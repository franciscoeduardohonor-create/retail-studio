/**
 * EJEMPLO 1: Multiplicación de Matrices - Versiones Optimizadas
 *
 * Este ejemplo demuestra:
 * - Versión naive (lenta)
 * - Versión con tiling usando shared memory (rápida)
 * - Comparación de rendimiento
 * - Conceptos de memory coalescing
 *
 * Para compilar: nvcc ejemplo_01_matrix_multiply.cu -o ejemplo_01
 * Para ejecutar: ./ejemplo_01
 */

#include <stdio.h>
#include <cuda_runtime.h>

#define TILE_SIZE 16

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
 * VERSIÓN 1: Naive (Sin optimización)
 * ════════════════════════════════════════════════════════════
 *
 * C = A × B
 * C[i][j] = Σ A[i][k] × B[k][j]
 *
 * PROBLEMAS:
 * - Múltiples accesos a global memory
 * - No reutiliza datos
 * - Muy lento para matrices grandes
 */
__global__ void matMulNaive(float *A, float *B, float *C, int N) {
    // Calcular fila y columna del elemento C a calcular
    int row = blockIdx.y * blockDim.y + threadIdx.y;
    int col = blockIdx.x * blockDim.x + threadIdx.x;

    if (row < N && col < N) {
        float sum = 0.0f;

        // Calcular producto punto de fila × columna
        for (int k = 0; k < N; k++) {
            // PROBLEMA: Cada thread lee N elementos de A y B desde global memory
            sum += A[row * N + k] * B[k * N + col];
        }

        C[row * N + col] = sum;
    }
}

/**
 * ════════════════════════════════════════════════════════════
 * VERSIÓN 2: Con Tiling (Optimizado)
 * ════════════════════════════════════════════════════════════
 *
 * OPTIMIZACIÓN: Usar shared memory para reutilizar datos
 *
 * Estrategia de Tiling:
 * 1. Dividir matrices en tiles (bloques pequeños)
 * 2. Cargar tiles a shared memory
 * 3. Hacer cálculos usando shared memory (rápida)
 * 4. Repetir para todos los tiles
 *
 * VENTAJAS:
 * - Reduce accesos a global memory en ~N/TILE_SIZE
 * - Reutiliza datos en shared memory
 * - Memory coalescing al cargar tiles
 */
__global__ void matMulTiled(float *A, float *B, float *C, int N) {
    /**
     * SHARED MEMORY: Tiles para A y B
     *
     * Cada bloque tiene sus propios tiles
     * Todos los threads del bloque pueden acceder
     */
    __shared__ float tileA[TILE_SIZE][TILE_SIZE];
    __shared__ float tileB[TILE_SIZE][TILE_SIZE];

    // Índices globales
    int row = blockIdx.y * TILE_SIZE + threadIdx.y;
    int col = blockIdx.x * TILE_SIZE + threadIdx.x;

    float sum = 0.0f;

    /**
     * ITERAR SOBRE TILES
     *
     * Número de tiles necesarios: N / TILE_SIZE
     *
     * Para cada tile:
     * 1. Cargar tile de A y B a shared memory
     * 2. Sincronizar
     * 3. Calcular productos parciales
     * 4. Sincronizar
     */
    int numTiles = (N + TILE_SIZE - 1) / TILE_SIZE;

    for (int t = 0; t < numTiles; t++) {
        /**
         * PASO 1: CARGAR TILE A SHARED MEMORY
         *
         * Cada thread carga un elemento
         * Accesos coalescentes = rápido
         */

        // Cargar elemento de A
        int aRow = row;
        int aCol = t * TILE_SIZE + threadIdx.x;
        if (aRow < N && aCol < N) {
            tileA[threadIdx.y][threadIdx.x] = A[aRow * N + aCol];
        } else {
            tileA[threadIdx.y][threadIdx.x] = 0.0f;
        }

        // Cargar elemento de B
        int bRow = t * TILE_SIZE + threadIdx.y;
        int bCol = col;
        if (bRow < N && bCol < N) {
            tileB[threadIdx.y][threadIdx.x] = B[bRow * N + bCol];
        } else {
            tileB[threadIdx.y][threadIdx.x] = 0.0f;
        }

        /**
         * PASO 2: SINCRONIZAR
         *
         * Asegurar que todos los threads cargaron sus datos
         * antes de empezar a calcular
         */
        __syncthreads();

        /**
         * PASO 3: CALCULAR PRODUCTOS PARCIALES
         *
         * Usar datos de shared memory (muy rápido!)
         */
        for (int k = 0; k < TILE_SIZE; k++) {
            sum += tileA[threadIdx.y][k] * tileB[k][threadIdx.x];
        }

        /**
         * PASO 4: SINCRONIZAR
         *
         * Asegurar que todos terminaron de usar el tile
         * antes de cargar el siguiente
         */
        __syncthreads();
    }

    // Escribir resultado
    if (row < N && col < N) {
        C[row * N + col] = sum;
    }
}

/**
 * ════════════════════════════════════════════════════════════
 * FUNCIÓN: Inicializar matriz
 * ════════════════════════════════════════════════════════════
 */
void initMatrix(float *matrix, int N, float value) {
    for (int i = 0; i < N * N; i++) {
        matrix[i] = value;
    }
}

/**
 * ════════════════════════════════════════════════════════════
 * FUNCIÓN: Verificar resultado
 * ════════════════════════════════════════════════════════════
 */
bool verifyResult(float *C, int N, float expected) {
    for (int i = 0; i < N * N; i++) {
        if (fabs(C[i] - expected) > 0.01f) {
            printf("Error: C[%d] = %f, esperado %f\n", i, C[i], expected);
            return false;
        }
    }
    return true;
}

/**
 * ════════════════════════════════════════════════════════════
 * FUNCIÓN: Medir rendimiento
 * ════════════════════════════════════════════════════════════
 */
float medirTiempo(void (*kernel)(float*, float*, float*, int),
                  float *d_A, float *d_B, float *d_C, int N,
                  dim3 grid, dim3 block, const char* nombre) {
    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    // Warm-up
    kernel<<<grid, block>>>(d_A, d_B, d_C, N);

    // Medir
    cudaEventRecord(start);
    for (int i = 0; i < 10; i++) {
        kernel<<<grid, block>>>(d_A, d_B, d_C, N);
    }
    cudaEventRecord(stop);
    cudaEventSynchronize(stop);

    float ms;
    cudaEventElapsedTime(&ms, start, stop);

    // Calcular GFLOPS
    // Operaciones: N^3 multiplicaciones + N^3 sumas = 2*N^3
    float gflops = (2.0f * N * N * N * 10) / (ms * 1e6);

    printf("  %-20s: %8.4f ms  |  %6.2f GFLOPS\n", nombre, ms/10.0f, gflops);

    cudaEventDestroy(start);
    cudaEventDestroy(stop);

    return ms/10.0f;
}

/**
 * ════════════════════════════════════════════════════════════
 * MAIN
 * ════════════════════════════════════════════════════════════
 */
int main() {
    printf("╔═══════════════════════════════════════════════════════╗\n");
    printf("║     Multiplicación de Matrices: Naive vs Tiled       ║\n");
    printf("╚═══════════════════════════════════════════════════════╝\n\n");

    // Diferentes tamaños para probar
    int sizes[] = {256, 512, 1024};
    int numSizes = 3;

    for (int s = 0; s < numSizes; s++) {
        int N = sizes[s];
        size_t bytes = N * N * sizeof(float);

        printf("\n┌─────────────────────────────────────────────────────┐\n");
        printf("│  Tamaño de Matriz: %d × %d                      \n", N, N);
        printf("└─────────────────────────────────────────────────────┘\n");

        // Asignar memoria
        float *h_A, *h_B, *h_C;
        h_A = (float*)malloc(bytes);
        h_B = (float*)malloc(bytes);
        h_C = (float*)malloc(bytes);

        // Inicializar: A = 2, B = 3, esperado C = 2*3*N = 6N
        initMatrix(h_A, N, 2.0f);
        initMatrix(h_B, N, 3.0f);

        float *d_A, *d_B, *d_C;
        CUDA_CHECK(cudaMalloc(&d_A, bytes));
        CUDA_CHECK(cudaMalloc(&d_B, bytes));
        CUDA_CHECK(cudaMalloc(&d_C, bytes));

        CUDA_CHECK(cudaMemcpy(d_A, h_A, bytes, cudaMemcpyHostToDevice));
        CUDA_CHECK(cudaMemcpy(d_B, h_B, bytes, cudaMemcpyHostToDevice));

        // Configuración
        dim3 block(TILE_SIZE, TILE_SIZE);
        dim3 grid((N + TILE_SIZE - 1) / TILE_SIZE,
                  (N + TILE_SIZE - 1) / TILE_SIZE);

        printf("\nConfiguración:\n");
        printf("  Block: %dx%d threads\n", block.x, block.y);
        printf("  Grid: %dx%d bloques\n\n", grid.x, grid.y);

        printf("Rendimiento:\n");

        // Versión Naive
        float timeNaive = medirTiempo(matMulNaive, d_A, d_B, d_C, N,
                                       grid, block, "Naive");

        // Verificar
        CUDA_CHECK(cudaMemcpy(h_C, d_C, bytes, cudaMemcpyDeviceToHost));
        bool correctNaive = verifyResult(h_C, N, 6.0f * N);

        // Versión Tiled
        float timeTiled = medirTiempo(matMulTiled, d_A, d_B, d_C, N,
                                       grid, block, "Tiled (Optimizado)");

        // Verificar
        CUDA_CHECK(cudaMemcpy(h_C, d_C, bytes, cudaMemcpyDeviceToHost));
        bool correctTiled = verifyResult(h_C, N, 6.0f * N);

        printf("\nResultados:\n");
        printf("  Naive:  %s\n", correctNaive ? "✓ Correcto" : "✗ Error");
        printf("  Tiled:  %s\n", correctTiled ? "✓ Correcto" : "✗ Error");
        printf("  Speedup: %.2fx\n", timeNaive / timeTiled);

        // Limpiar
        free(h_A); free(h_B); free(h_C);
        cudaFree(d_A); cudaFree(d_B); cudaFree(d_C);
    }

    printf("\n═══════════════════════════════════════════════════════\n");
    printf("                   FIN DEL EJEMPLO\n");
    printf("═══════════════════════════════════════════════════════\n");

    return 0;
}

/**
 * ════════════════════════════════════════════════════════════
 * ANÁLISIS DE RENDIMIENTO
 * ════════════════════════════════════════════════════════════
 *
 * VERSIÓN NAIVE:
 * - Cada thread lee 2N elementos de global memory
 * - Total: N² threads × 2N lecturas = 2N³ lecturas
 * - Muy lento para matrices grandes
 *
 * VERSIÓN TILED:
 * - Carga cada elemento a shared memory una vez
 * - Reutiliza datos TILE_SIZE veces
 * - Reduce lecturas por factor de ~TILE_SIZE
 * - Típicamente 10-20x más rápido
 *
 * MEJORAS ADICIONALES POSIBLES:
 * 1. Usar registros para acumulación
 * 2. Desenrollar loops
 * 3. Usar cuBLAS (biblioteca optimizada de NVIDIA)
 * 4. Tensor Cores (GPUs modernas)
 *
 * EJERCICIO:
 *
 * 1. Experimenta con diferentes TILE_SIZE (8, 16, 32)
 * 2. Compara el rendimiento
 * 3. ¿Cuál es el mejor TILE_SIZE para tu GPU?
 * 4. Implementa una versión CPU y compara velocidad
 */
