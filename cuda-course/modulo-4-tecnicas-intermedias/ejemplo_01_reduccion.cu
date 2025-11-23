/**
 * EJEMPLO 1: Reducción Paralela
 *
 * Este ejemplo demuestra:
 * - Implementación de reducción en árbol
 * - Uso eficiente de shared memory
 * - Evitar divergencia de warps
 * - Diferentes estrategias de reducción
 *
 * Objetivo: Sumar todos los elementos de un array
 *
 * Para compilar: nvcc ejemplo_01_reduccion.cu -o ejemplo_01
 * Para ejecutar: ./ejemplo_01
 */

#include <stdio.h>
#include <cuda_runtime.h>

#define N (1024 * 1024)  // 1M elementos
#define THREADS_PER_BLOCK 256

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
 * VERSIÓN 1: Reducción Naive (con divergencia)
 * ════════════════════════════════════════════════════════════
 */
__global__ void reduceNaive(float *input, float *output, int n) {
    __shared__ float sdata[THREADS_PER_BLOCK];

    int tid = threadIdx.x;
    int i = blockIdx.x * blockDim.x + threadIdx.x;

    // Cargar datos a shared memory
    sdata[tid] = (i < n) ? input[i] : 0.0f;
    __syncthreads();

    /**
     * REDUCCIÓN EN ÁRBOL
     *
     * Paso 1: Threads 0-127 suman con threads 128-255
     * Paso 2: Threads 0-63 suman con threads 64-127
     * Paso 3: Threads 0-31 suman con threads 32-63
     * ...
     * Paso final: Thread 0 tiene la suma total
     */

    // PROBLEMA: Mucha divergencia de warps
    for (int s = 1; s < blockDim.x; s *= 2) {
        if (tid % (2 * s) == 0) {  // Divergencia!
            sdata[tid] += sdata[tid + s];
        }
        __syncthreads();
    }

    // Thread 0 escribe resultado del bloque
    if (tid == 0) {
        output[blockIdx.x] = sdata[0];
    }
}

/**
 * ════════════════════════════════════════════════════════════
 * VERSIÓN 2: Reducción Optimizada (sin divergencia)
 * ════════════════════════════════════════════════════════════
 */
__global__ void reduceOptimized(float *input, float *output, int n) {
    __shared__ float sdata[THREADS_PER_BLOCK];

    int tid = threadIdx.x;
    int i = blockIdx.x * blockDim.x + threadIdx.x;

    // Cargar datos
    sdata[tid] = (i < n) ? input[i] : 0.0f;
    __syncthreads();

    /**
     * OPTIMIZACIÓN: Reducción sin divergencia
     *
     * En lugar de:
     *   if (tid % (2*s) == 0)  // Divergencia!
     *
     * Usamos:
     *   if (tid < s)           // Sin divergencia!
     *
     * Ahora threads consecutivos están activos
     */

    for (int s = blockDim.x / 2; s > 0; s >>= 1) {
        if (tid < s) {
            sdata[tid] += sdata[tid + s];
        }
        __syncthreads();
    }

    if (tid == 0) {
        output[blockIdx.x] = sdata[0];
    }
}

/**
 * ════════════════════════════════════════════════════════════
 * VERSIÓN 3: Reducción con Warp Shuffle (muy rápido)
 * ════════════════════════════════════════════════════════════
 *
 * Para los últimos 32 threads (un warp), podemos usar
 * warp shuffle en lugar de shared memory
 */
__device__ void warpReduce(volatile float *sdata, int tid) {
    /**
     * WARP SHUFFLE
     *
     * Los threads en un warp se ejecutan en sincronía
     * No necesitamos __syncthreads() dentro de un warp
     *
     * Usamos 'volatile' para evitar optimizaciones del compilador
     */
    sdata[tid] += sdata[tid + 32];
    sdata[tid] += sdata[tid + 16];
    sdata[tid] += sdata[tid + 8];
    sdata[tid] += sdata[tid + 4];
    sdata[tid] += sdata[tid + 2];
    sdata[tid] += sdata[tid + 1];
}

__global__ void reduceWarp(float *input, float *output, int n) {
    __shared__ float sdata[THREADS_PER_BLOCK];

    int tid = threadIdx.x;
    int i = blockIdx.x * blockDim.x + threadIdx.x;

    sdata[tid] = (i < n) ? input[i] : 0.0f;
    __syncthreads();

    // Reducción normal hasta llegar a 1 warp
    for (int s = blockDim.x / 2; s > 32; s >>= 1) {
        if (tid < s) {
            sdata[tid] += sdata[tid + s];
        }
        __syncthreads();
    }

    // Último warp: sin syncthreads
    if (tid < 32) {
        warpReduce(sdata, tid);
    }

    if (tid == 0) {
        output[blockIdx.x] = sdata[0];
    }
}

/**
 * ════════════════════════════════════════════════════════════
 * FUNCIÓN: Reducción completa en CPU
 * ════════════════════════════════════════════════════════════
 */
float reduceCPU(float *data, int n) {
    float sum = 0.0f;
    for (int i = 0; i < n; i++) {
        sum += data[i];
    }
    return sum;
}

/**
 * ════════════════════════════════════════════════════════════
 * FUNCIÓN: Wrapper para reducción GPU completa
 * ════════════════════════════════════════════════════════════
 */
float reduceGPU(void (*kernel)(float*, float*, int),
                float *d_input, int n, const char* nombre) {
    int threadsPerBlock = THREADS_PER_BLOCK;
    int blocksPerGrid = (n + threadsPerBlock - 1) / threadsPerBlock;

    float *d_partial;
    float *h_partial = (float*)malloc(blocksPerGrid * sizeof(float));
    CUDA_CHECK(cudaMalloc(&d_partial, blocksPerGrid * sizeof(float)));

    // Eventos para medir tiempo
    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    // Warm-up
    kernel<<<blocksPerGrid, threadsPerBlock>>>(d_input, d_partial, n);

    // Medir
    cudaEventRecord(start);
    for (int i = 0; i < 100; i++) {
        kernel<<<blocksPerGrid, threadsPerBlock>>>(d_input, d_partial, n);
    }
    cudaEventRecord(stop);
    cudaEventSynchronize(stop);

    float ms;
    cudaEventElapsedTime(&ms, start, stop);

    // Copiar resultados parciales
    CUDA_CHECK(cudaMemcpy(h_partial, d_partial, blocksPerGrid * sizeof(float),
                         cudaMemcpyDeviceToHost));

    // Reducir en CPU (resultados parciales son pocos)
    float result = 0.0f;
    for (int i = 0; i < blocksPerGrid; i++) {
        result += h_partial[i];
    }

    // Calcular ancho de banda
    float bandwidth = (n * sizeof(float) * 100) / (ms * 1e6);  // GB/s

    printf("  %-20s: %8.4f ms  |  %6.2f GB/s  |  Resultado: %.2f\n",
           nombre, ms/100.0f, bandwidth, result);

    free(h_partial);
    cudaFree(d_partial);
    cudaEventDestroy(start);
    cudaEventDestroy(stop);

    return result;
}

/**
 * ════════════════════════════════════════════════════════════
 * MAIN
 * ════════════════════════════════════════════════════════════
 */
int main() {
    printf("╔═══════════════════════════════════════════════════════╗\n");
    printf("║          Reducción Paralela: Suma de Array           ║\n");
    printf("╚═══════════════════════════════════════════════════════╝\n\n");

    size_t bytes = N * sizeof(float);

    // Asignar y inicializar en host
    float *h_input = (float*)malloc(bytes);
    for (int i = 0; i < N; i++) {
        h_input[i] = 1.0f;  // Suma esperada = N
    }

    // Calcular en CPU
    printf("Calculando en CPU...\n");
    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    cudaEventRecord(start);
    float cpuResult = reduceCPU(h_input, N);
    cudaEventRecord(stop);
    cudaEventSynchronize(stop);

    float cpuTime;
    cudaEventElapsedTime(&cpuTime, start, stop);

    printf("  CPU:                 %8.4f ms  |  Resultado: %.2f\n\n",
           cpuTime, cpuResult);

    // Asignar en device
    float *d_input;
    CUDA_CHECK(cudaMalloc(&d_input, bytes));
    CUDA_CHECK(cudaMemcpy(d_input, h_input, bytes, cudaMemcpyHostToDevice));

    printf("Calculando en GPU (%d elementos)...\n", N);
    printf("─────────────────────────────────────────────────────────\n");

    // Versión Naive
    float result1 = reduceGPU(reduceNaive, d_input, N, "Naive");

    // Versión Optimizada
    float result2 = reduceGPU(reduceOptimized, d_input, N, "Optimizada");

    // Versión Warp
    float result3 = reduceGPU(reduceWarp, d_input, N, "Warp Optimized");

    printf("─────────────────────────────────────────────────────────\n");

    // Verificar
    printf("\nVerificación:\n");
    printf("  Esperado: %.2f\n", (float)N);
    printf("  CPU:      %.2f %s\n", cpuResult,
           (fabs(cpuResult - N) < 0.1f) ? "✓" : "✗");
    printf("  Naive:    %.2f %s\n", result1,
           (fabs(result1 - N) < 0.1f) ? "✓" : "✗");
    printf("  Optimiz:  %.2f %s\n", result2,
           (fabs(result2 - N) < 0.1f) ? "✓" : "✗");
    printf("  Warp:     %.2f %s\n", result3,
           (fabs(result3 - N) < 0.1f) ? "✓" : "✗");

    // Limpiar
    free(h_input);
    cudaFree(d_input);
    cudaEventDestroy(start);
    cudaEventDestroy(stop);

    printf("\n═══════════════════════════════════════════════════════\n");
    printf("                   FIN DEL EJEMPLO\n");
    printf("═══════════════════════════════════════════════════════\n");

    return 0;
}

/**
 * ════════════════════════════════════════════════════════════
 * CONCEPTOS CLAVE DE REDUCCIÓN
 * ════════════════════════════════════════════════════════════
 *
 * 1. DIVERGENCIA DE WARPS:
 *    - Evitar: if (tid % 2*s == 0)
 *    - Usar:   if (tid < s)
 *
 * 2. PATRÓN EN ÁRBOL:
 *    - Reduce log₂(N) iteraciones
 *    - Cada iteración reduce datos a la mitad
 *
 * 3. OPTIMIZACIÓN DE WARP:
 *    - Último warp no necesita __syncthreads()
 *    - Threads en warp están sincronizados
 *
 * 4. REDUCCIÓN MULTI-NIVEL:
 *    - Nivel 1: Reducción dentro de bloques
 *    - Nivel 2: Reducción de resultados parciales (CPU o GPU)
 *
 * 5. OPERACIONES SOPORTADAS:
 *    - Suma, multiplicación
 *    - Mínimo, máximo
 *    - AND, OR, XOR
 *    - Cualquier operación asociativa
 *
 * VARIACIONES COMUNES:
 *
 * - Reducción por clave (group by)
 * - Reducción segmentada
 * - Reducción con transformación (map-reduce)
 *
 * BIBLIOTECAS:
 *
 * - Thrust: thrust::reduce()
 * - CUB: cub::BlockReduce
 *
 * EJERCICIO:
 *
 * Modifica este código para:
 * 1. Encontrar el valor máximo en lugar de la suma
 * 2. Calcular el promedio
 * 3. Contar elementos que cumplen una condición
 */
