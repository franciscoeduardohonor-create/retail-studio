/**
 * EJEMPLO 2: Suma de Vectores
 *
 * Este ejemplo demuestra:
 * - Transferencia de datos entre CPU y GPU
 * - Procesamiento paralelo de arrays
 * - Gestión básica de memoria en CUDA
 * - Uso de threadIdx, blockIdx y blockDim
 *
 * Para compilar: nvcc ejemplo_02_suma_vectores.cu -o ejemplo_02
 * Para ejecutar: ./ejemplo_02
 */

#include <stdio.h>
#include <cuda_runtime.h>

// Tamaño del vector
#define N 1024

/**
 * KERNEL: Suma de vectores
 *
 * Cada thread calcula un elemento del resultado:
 * c[i] = a[i] + b[i]
 *
 * Variables built-in importantes:
 * - threadIdx.x: índice del thread dentro del bloque (0 a blockDim.x-1)
 * - blockIdx.x: índice del bloque (0 a gridDim.x-1)
 * - blockDim.x: número de threads por bloque
 */
__global__ void sumaVectores(float *a, float *b, float *c, int n) {
    /**
     * CÁLCULO DEL ÍNDICE GLOBAL
     *
     * Cada thread debe procesar un elemento único del array.
     * El índice global se calcula como:
     *
     * idx = blockIdx.x * blockDim.x + threadIdx.x
     *
     * Ejemplo con 2 bloques de 4 threads:
     * Bloque 0: threads 0,1,2,3 -> índices globales 0,1,2,3
     * Bloque 1: threads 0,1,2,3 -> índices globales 4,5,6,7
     */
    int idx = blockIdx.x * blockDim.x + threadIdx.x;

    /**
     * VERIFICACIÓN DE LÍMITES
     *
     * Es importante verificar que no accedamos fuera del array
     * porque podríamos lanzar más threads que elementos
     */
    if (idx < n) {
        c[idx] = a[idx] + b[idx];
    }
}

int main() {
    printf("=== EJEMPLO 2: Suma de Vectores ===\n\n");
    printf("Tamaño del vector: %d elementos\n\n", N);

    // ==========================================
    // PASO 1: Declarar variables en el host (CPU)
    // ==========================================
    float *h_a, *h_b, *h_c;  // h_ = host (CPU)
    float *d_a, *d_b, *d_c;  // d_ = device (GPU)

    // Tamaño en bytes
    size_t bytes = N * sizeof(float);

    // ==========================================
    // PASO 2: Asignar memoria en el host
    // ==========================================
    h_a = (float*)malloc(bytes);
    h_b = (float*)malloc(bytes);
    h_c = (float*)malloc(bytes);

    // ==========================================
    // PASO 3: Inicializar los vectores
    // ==========================================
    printf("1. Inicializando vectores en CPU...\n");
    for (int i = 0; i < N; i++) {
        h_a[i] = i * 1.0f;      // a = [0, 1, 2, 3, ...]
        h_b[i] = i * 2.0f;      // b = [0, 2, 4, 6, ...]
    }

    // ==========================================
    // PASO 4: Asignar memoria en el device (GPU)
    // ==========================================
    printf("2. Asignando memoria en GPU...\n");
    cudaMalloc(&d_a, bytes);
    cudaMalloc(&d_b, bytes);
    cudaMalloc(&d_c, bytes);

    // ==========================================
    // PASO 5: Copiar datos de CPU a GPU
    // ==========================================
    printf("3. Copiando datos de CPU a GPU...\n");
    cudaMemcpy(d_a, h_a, bytes, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, h_b, bytes, cudaMemcpyHostToDevice);

    // ==========================================
    // PASO 6: Configurar y lanzar el kernel
    // ==========================================
    printf("4. Ejecutando kernel en GPU...\n");

    /**
     * CONFIGURACIÓN DE LA EJECUCIÓN
     *
     * threadsPerBlock: 256 threads por bloque (valor común)
     * blocksPerGrid: Suficientes bloques para cubrir todos los elementos
     *
     * Cálculo: (N + threadsPerBlock - 1) / threadsPerBlock
     * Esto redondea hacia arriba para asegurar que cubrimos todos los elementos
     *
     * Ejemplo con N=1024 y threadsPerBlock=256:
     * blocksPerGrid = (1024 + 256 - 1) / 256 = 1279 / 256 = 4 bloques
     */
    int threadsPerBlock = 256;
    int blocksPerGrid = (N + threadsPerBlock - 1) / threadsPerBlock;

    printf("   - Bloques: %d\n", blocksPerGrid);
    printf("   - Threads por bloque: %d\n", threadsPerBlock);
    printf("   - Threads totales: %d\n", blocksPerGrid * threadsPerBlock);

    // Lanzar el kernel
    sumaVectores<<<blocksPerGrid, threadsPerBlock>>>(d_a, d_b, d_c, N);

    // ==========================================
    // PASO 7: Copiar resultados de GPU a CPU
    // ==========================================
    printf("5. Copiando resultados de GPU a CPU...\n");
    cudaMemcpy(h_c, d_c, bytes, cudaMemcpyDeviceToHost);

    // ==========================================
    // PASO 8: Verificar resultados
    // ==========================================
    printf("6. Verificando resultados...\n");
    bool correcto = true;
    for (int i = 0; i < N; i++) {
        float esperado = h_a[i] + h_b[i];
        if (h_c[i] != esperado) {
            printf("   ERROR en índice %d: esperado %.1f, obtenido %.1f\n",
                   i, esperado, h_c[i]);
            correcto = false;
            break;
        }
    }

    if (correcto) {
        printf("   ✓ Todos los resultados son correctos!\n");
        printf("\n   Primeros 10 elementos:\n");
        for (int i = 0; i < 10; i++) {
            printf("   %.1f + %.1f = %.1f\n", h_a[i], h_b[i], h_c[i]);
        }
    }

    // ==========================================
    // PASO 9: Liberar memoria
    // ==========================================
    printf("\n7. Liberando memoria...\n");

    // Liberar memoria del host
    free(h_a);
    free(h_b);
    free(h_c);

    // Liberar memoria del device
    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);

    printf("\n=== FIN DEL EJEMPLO ===\n");

    return 0;
}

/**
 * FLUJO COMPLETO DE UN PROGRAMA CUDA:
 *
 * 1. Asignar memoria en CPU (malloc)
 * 2. Inicializar datos en CPU
 * 3. Asignar memoria en GPU (cudaMalloc)
 * 4. Copiar datos CPU → GPU (cudaMemcpy con cudaMemcpyHostToDevice)
 * 5. Lanzar kernel en GPU (<<<bloques, threads>>>)
 * 6. Copiar resultados GPU → CPU (cudaMemcpy con cudaMemcpyDeviceToHost)
 * 7. Liberar memoria GPU (cudaFree)
 * 8. Liberar memoria CPU (free)
 *
 * EJERCICIO PARA PRACTICAR:
 *
 * Modifica este programa para:
 * 1. Realizar la operación: d[i] = a[i] * b[i] + c[i]
 * 2. Usar N = 2048 elementos
 * 3. Probar con diferentes valores de threadsPerBlock (128, 256, 512)
 */
