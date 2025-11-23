/**
 * EJEMPLO 2: Shared Memory (Memoria Compartida)
 *
 * Este ejemplo demuestra:
 * - Qué es la shared memory y por qué es importante
 * - Cómo declarar y usar shared memory
 * - Sincronización con __syncthreads()
 * - Comparación de rendimiento: global vs shared memory
 *
 * Para compilar: nvcc ejemplo_02_shared_memory.cu -o ejemplo_02
 * Para ejecutar: ./ejemplo_02
 */

#include <stdio.h>
#include <cuda_runtime.h>

#define N 1024
#define BLOCK_SIZE 256

#define CUDA_CHECK(call) \
    do { \
        cudaError_t error = call; \
        if (error != cudaSuccess) { \
            fprintf(stderr, "Error CUDA: %s\n", cudaGetErrorString(error)); \
            exit(EXIT_FAILURE); \
        } \
    } while(0)

/**
 * ════════════════════════════════════════════════════════════
 * EJEMPLO 1: Reversa de Array con Global Memory (LENTO)
 * ════════════════════════════════════════════════════════════
 */
__global__ void reversaGlobal(float *input, float *output, int n) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x;

    if (idx < n) {
        // Acceso directo a global memory (lento)
        output[idx] = input[n - 1 - idx];
    }
}

/**
 * ════════════════════════════════════════════════════════════
 * EJEMPLO 2: Reversa de Array con Shared Memory (RÁPIDO)
 * ════════════════════════════════════════════════════════════
 */
__global__ void reversaShared(float *input, float *output, int n) {
    /**
     * DECLARACIÓN DE SHARED MEMORY
     *
     * __shared__ declara memoria compartida
     * - Es por bloque (todos los threads del bloque la comparten)
     * - Es mucho más rápida que global memory (~100x)
     * - Tamaño limitado (típ. 48-96 KB por bloque)
     */
    __shared__ float temp[BLOCK_SIZE];

    int globalIdx = blockIdx.x * blockDim.x + threadIdx.x;
    int localIdx = threadIdx.x;

    /**
     * PASO 1: Cargar datos de global memory a shared memory
     */
    if (globalIdx < n) {
        temp[localIdx] = input[globalIdx];
    }

    /**
     * SINCRONIZACIÓN: __syncthreads()
     *
     * CRÍTICO: Asegura que todos los threads del bloque
     * hayan terminado de cargar antes de continuar
     *
     * Sin esto, algunos threads podrían leer datos
     * que aún no se han cargado
     */
    __syncthreads();

    /**
     * PASO 2: Escribir en orden inverso desde shared memory
     */
    if (globalIdx < n) {
        // Leer de shared memory (rápido) en orden inverso
        int reverseIdx = blockDim.x - 1 - localIdx;
        int outputIdx = (blockIdx.x + 1) * blockDim.x - 1 - localIdx;

        if (outputIdx < n) {
            output[outputIdx] = temp[reverseIdx];
        }
    }
}

/**
 * ════════════════════════════════════════════════════════════
 * EJEMPLO 3: Suma de Vecinos (Stencil Pattern)
 * ════════════════════════════════════════════════════════════
 *
 * Cada elemento es la suma de él mismo y sus vecinos
 * output[i] = input[i-1] + input[i] + input[i+1]
 */
__global__ void sumaVecinosShared(float *input, float *output, int n) {
    /**
     * COMPARTIR DATOS ENTRE THREADS
     *
     * Cada thread necesita datos de sus vecinos
     * Usando shared memory evitamos múltiples accesos a global memory
     */
    __shared__ float shared[BLOCK_SIZE + 2]; // +2 para elementos halo

    int globalIdx = blockIdx.x * blockDim.x + threadIdx.x;
    int localIdx = threadIdx.x + 1; // +1 por el elemento halo izquierdo

    // Cargar datos principales
    if (globalIdx < n) {
        shared[localIdx] = input[globalIdx];
    }

    // Cargar elementos halo (bordes)
    if (threadIdx.x == 0) {
        // Primer thread carga el elemento izquierdo
        shared[0] = (globalIdx > 0) ? input[globalIdx - 1] : 0.0f;
    }
    if (threadIdx.x == blockDim.x - 1) {
        // Último thread carga el elemento derecho
        shared[localIdx + 1] = (globalIdx < n - 1) ? input[globalIdx + 1] : 0.0f;
    }

    // Sincronizar: todos los datos deben estar cargados
    __syncthreads();

    // Calcular suma de vecinos usando shared memory
    if (globalIdx < n) {
        output[globalIdx] = shared[localIdx - 1] +
                           shared[localIdx] +
                           shared[localIdx + 1];
    }
}

/**
 * ════════════════════════════════════════════════════════════
 * EJEMPLO 4: Shared Memory Dinámica
 * ════════════════════════════════════════════════════════════
 */
__global__ void ejemploSharedDinamica(float *input, float *output, int n) {
    /**
     * SHARED MEMORY DINÁMICA
     *
     * Se declara sin tamaño y se especifica al lanzar el kernel
     * Útil cuando el tamaño no se conoce en tiempo de compilación
     */
    extern __shared__ float dynamicShared[];

    int idx = blockIdx.x * blockDim.x + threadIdx.x;

    if (idx < n) {
        dynamicShared[threadIdx.x] = input[idx];
        __syncthreads();

        // Operación simple: duplicar
        output[idx] = dynamicShared[threadIdx.x] * 2.0f;
    }
}

/**
 * ════════════════════════════════════════════════════════════
 * FUNCIÓN AUXILIAR: Medir tiempo
 * ════════════════════════════════════════════════════════════
 */
float medirTiempo(void (*kernel)(float*, float*, int),
                  float *d_input, float *d_output, int n,
                  int bloques, int threads, const char* nombre) {
    // Eventos CUDA para medir tiempo
    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    // Calentamiento (warm-up)
    kernel<<<bloques, threads>>>(d_input, d_output, n);

    // Medir tiempo
    cudaEventRecord(start);
    for (int i = 0; i < 100; i++) {
        kernel<<<bloques, threads>>>(d_input, d_output, n);
    }
    cudaEventRecord(stop);
    cudaEventSynchronize(stop);

    float ms;
    cudaEventElapsedTime(&ms, start, stop);

    printf("  %s: %.4f ms (promedio de 100 ejecuciones)\n", nombre, ms/100.0f);

    cudaEventDestroy(start);
    cudaEventDestroy(stop);

    return ms/100.0f;
}

/**
 * ════════════════════════════════════════════════════════════
 * DEMO: Comparación de Rendimiento
 * ════════════════════════════════════════════════════════════
 */
void demoComparacion() {
    printf("\n╔════════════════════════════════════════════════╗\n");
    printf("║    Comparación: Global vs Shared Memory       ║\n");
    printf("╚════════════════════════════════════════════════╝\n");

    size_t bytes = N * sizeof(float);

    float *h_input = (float*)malloc(bytes);
    float *h_output = (float*)malloc(bytes);

    // Inicializar
    for (int i = 0; i < N; i++) {
        h_input[i] = i * 1.0f;
    }

    float *d_input, *d_output;
    CUDA_CHECK(cudaMalloc(&d_input, bytes));
    CUDA_CHECK(cudaMalloc(&d_output, bytes));

    CUDA_CHECK(cudaMemcpy(d_input, h_input, bytes, cudaMemcpyHostToDevice));

    int bloques = (N + BLOCK_SIZE - 1) / BLOCK_SIZE;

    printf("\nConfiguración:\n");
    printf("  Elementos: %d\n", N);
    printf("  Block size: %d\n", BLOCK_SIZE);
    printf("  Bloques: %d\n\n", bloques);

    printf("Midiendo rendimiento...\n");

    float timeGlobal = medirTiempo(reversaGlobal, d_input, d_output,
                                    N, bloques, BLOCK_SIZE,
                                    "Global Memory");

    float timeShared = medirTiempo(reversaShared, d_input, d_output,
                                    N, bloques, BLOCK_SIZE,
                                    "Shared Memory");

    printf("\nSpeedup: %.2fx más rápido con shared memory\n",
           timeGlobal / timeShared);

    // Verificar corrección
    CUDA_CHECK(cudaMemcpy(h_output, d_output, bytes, cudaMemcpyDeviceToHost));

    bool correcto = true;
    for (int i = 0; i < N; i++) {
        if (h_output[i] != h_input[N - 1 - i]) {
            correcto = false;
            break;
        }
    }

    printf("Resultado: %s\n", correcto ? "✓ Correcto" : "✗ Incorrecto");

    free(h_input);
    free(h_output);
    cudaFree(d_input);
    cudaFree(d_output);
}

/**
 * ════════════════════════════════════════════════════════════
 * DEMO: Suma de Vecinos
 * ════════════════════════════════════════════════════════════
 */
void demoSumaVecinos() {
    printf("\n╔════════════════════════════════════════════════╗\n");
    printf("║         Suma de Vecinos (Stencil)             ║\n");
    printf("╚════════════════════════════════════════════════╝\n");

    const int n = 16;
    size_t bytes = n * sizeof(float);

    float *h_input = (float*)malloc(bytes);
    float *h_output = (float*)malloc(bytes);

    // Inicializar con valores simples
    for (int i = 0; i < n; i++) {
        h_input[i] = i;
    }

    float *d_input, *d_output;
    CUDA_CHECK(cudaMalloc(&d_input, bytes));
    CUDA_CHECK(cudaMalloc(&d_output, bytes));

    CUDA_CHECK(cudaMemcpy(d_input, h_input, bytes, cudaMemcpyHostToDevice));

    sumaVecinosShared<<<1, n>>>(d_input, d_output, n);
    CUDA_CHECK(cudaGetLastError());
    CUDA_CHECK(cudaDeviceSynchronize());

    CUDA_CHECK(cudaMemcpy(h_output, d_output, bytes, cudaMemcpyDeviceToHost));

    printf("\nResultados:\n");
    printf("  Input:  ");
    for (int i = 0; i < n; i++) printf("%.0f ", h_input[i]);
    printf("\n  Output: ");
    for (int i = 0; i < n; i++) printf("%.0f ", h_output[i]);
    printf("\n");

    free(h_input);
    free(h_output);
    cudaFree(d_input);
    cudaFree(d_output);
}

/**
 * ════════════════════════════════════════════════════════════
 * MAIN
 * ════════════════════════════════════════════════════════════
 */
int main() {
    printf("╔═════════════════════════════════════════════════════╗\n");
    printf("║       EJEMPLO 2: Shared Memory                      ║\n");
    printf("╚═════════════════════════════════════════════════════╝\n");

    demoComparacion();
    demoSumaVecinos();

    printf("\n═══════════════════════════════════════════════════════\n");
    printf("                     FIN DEL EJEMPLO\n");
    printf("═══════════════════════════════════════════════════════\n");

    return 0;
}

/**
 * RESUMEN DE SHARED MEMORY:
 *
 * ┌──────────────────────────────────────────────────────────┐
 * │ CUÁNDO USAR SHARED MEMORY:                               │
 * ├──────────────────────────────────────────────────────────┤
 * │ ✓ Los threads necesitan compartir datos                 │
 * │ ✓ Múltiples accesos a los mismos datos                  │
 * │ ✓ Patrones stencil (vecinos)                            │
 * │ ✓ Reducción dentro de un bloque                         │
 * │ ✓ Tiling de matrices                                    │
 * └──────────────────────────────────────────────────────────┘
 *
 * REGLAS IMPORTANTES:
 *
 * 1. __shared__ declara memoria compartida
 * 2. Siempre usar __syncthreads() después de escribir y antes de leer
 * 3. El tamaño es limitado (48-96 KB típicamente)
 * 4. Es por bloque, no global
 * 5. ~100x más rápida que global memory
 *
 * PATRONES COMUNES:
 *
 * 1. Cargar de global a shared
 * 2. __syncthreads()
 * 3. Procesar datos en shared
 * 4. __syncthreads() (si es necesario)
 * 5. Escribir resultados a global
 *
 * EJERCICIO:
 *
 * Implementa un filtro blur 1D que promedia cada elemento
 * con sus 2 vecinos de cada lado usando shared memory.
 */
