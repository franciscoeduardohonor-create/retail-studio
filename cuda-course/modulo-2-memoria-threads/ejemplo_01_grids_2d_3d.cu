/**
 * EJEMPLO 1: Grids y Bloques 2D y 3D
 *
 * Este ejemplo demuestra:
 * - Cómo trabajar con grids 2D y 3D
 * - Procesamiento de matrices (2D)
 * - Procesamiento de volúmenes (3D)
 * - Cálculo de índices en múltiples dimensiones
 *
 * Para compilar: nvcc ejemplo_01_grids_2d_3d.cu -o ejemplo_01
 * Para ejecutar: ./ejemplo_01
 */

#include <stdio.h>
#include <cuda_runtime.h>

#define WIDTH 1024
#define HEIGHT 1024
#define DEPTH 64

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
 * EJEMPLO 1D: Repaso
 * ════════════════════════════════════════════════════════════
 */
__global__ void suma1D(float *a, float *b, float *c, int n) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx < n) {
        c[idx] = a[idx] + b[idx];
    }
}

/**
 * ════════════════════════════════════════════════════════════
 * EJEMPLO 2D: Suma de Matrices
 * ════════════════════════════════════════════════════════════
 *
 * Para matrices, usamos configuración 2D:
 * - dim3 grid(numBlocksX, numBlocksY)
 * - dim3 block(threadsX, threadsY)
 */
__global__ void suma2D(float *a, float *b, float *c, int width, int height) {
    /**
     * CÁLCULO DE ÍNDICES 2D
     *
     * Para una matriz almacenada en row-major (fila principal):
     *
     * 1. Calcular posición X (columna)
     * 2. Calcular posición Y (fila)
     * 3. Convertir a índice 1D: idx = y * width + x
     */

    // Posición X (columna)
    int x = blockIdx.x * blockDim.x + threadIdx.x;

    // Posición Y (fila)
    int y = blockIdx.y * blockDim.y + threadIdx.y;

    // Convertir a índice lineal (row-major)
    int idx = y * width + x;

    // Verificar límites en ambas dimensiones
    if (x < width && y < height) {
        c[idx] = a[idx] + b[idx];
    }
}

/**
 * ════════════════════════════════════════════════════════════
 * EJEMPLO 2D: Transposición de Matriz
 * ════════════════════════════════════════════════════════════
 *
 * Este kernel transpone una matriz: out[j][i] = in[i][j]
 */
__global__ void transponer(float *input, float *output, int width, int height) {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int y = blockIdx.y * blockDim.y + threadIdx.y;

    if (x < width && y < height) {
        // Índice en matriz original: [y][x]
        int idxIn = y * width + x;

        // Índice en matriz transpuesta: [x][y] en matriz height×width
        int idxOut = x * height + y;

        output[idxOut] = input[idxIn];
    }
}

/**
 * ════════════════════════════════════════════════════════════
 * EJEMPLO 3D: Procesamiento de Volumen
 * ════════════════════════════════════════════════════════════
 *
 * Para datos 3D (ej: volúmenes médicos, simulaciones fluidos)
 */
__global__ void procesar3D(float *input, float *output,
                           int width, int height, int depth) {
    /**
     * CÁLCULO DE ÍNDICES 3D
     *
     * Para un volumen almacenado como [depth][height][width]:
     *
     * x: coordenada en width
     * y: coordenada en height
     * z: coordenada en depth
     *
     * índice = z * (height * width) + y * width + x
     */

    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int y = blockIdx.y * blockDim.y + threadIdx.y;
    int z = blockIdx.z * blockDim.z + threadIdx.z;

    if (x < width && y < height && z < depth) {
        int idx = z * (height * width) + y * width + x;

        // Operación simple: multiplicar por 2
        output[idx] = input[idx] * 2.0f;
    }
}

/**
 * ════════════════════════════════════════════════════════════
 * FUNCIÓN AUXILIAR: Imprimir matriz
 * ════════════════════════════════════════════════════════════
 */
void imprimirMatriz(const char* nombre, float *matriz, int filas, int cols, int maxFilas = 5, int maxCols = 5) {
    printf("\n%s (%dx%d, mostrando %dx%d):\n", nombre, filas, cols, maxFilas, maxCols);
    for (int i = 0; i < maxFilas && i < filas; i++) {
        printf("  ");
        for (int j = 0; j < maxCols && j < cols; j++) {
            printf("%.1f ", matriz[i * cols + j]);
        }
        if (cols > maxCols) printf("...");
        printf("\n");
    }
    if (filas > maxFilas) printf("  ...\n");
}

/**
 * ════════════════════════════════════════════════════════════
 * DEMO 1: Suma de Matrices 2D
 * ════════════════════════════════════════════════════════════
 */
void demo2D() {
    printf("\n╔════════════════════════════════════════════════╗\n");
    printf("║         DEMO 2D: Suma de Matrices              ║\n");
    printf("╚════════════════════════════════════════════════╝\n");

    const int width = 8;
    const int height = 6;
    size_t bytes = width * height * sizeof(float);

    // Asignar memoria
    float *h_a, *h_b, *h_c;
    h_a = (float*)malloc(bytes);
    h_b = (float*)malloc(bytes);
    h_c = (float*)malloc(bytes);

    // Inicializar
    for (int i = 0; i < height * width; i++) {
        h_a[i] = i * 1.0f;
        h_b[i] = i * 2.0f;
    }

    // Asignar en device
    float *d_a, *d_b, *d_c;
    CUDA_CHECK(cudaMalloc(&d_a, bytes));
    CUDA_CHECK(cudaMalloc(&d_b, bytes));
    CUDA_CHECK(cudaMalloc(&d_c, bytes));

    CUDA_CHECK(cudaMemcpy(d_a, h_a, bytes, cudaMemcpyHostToDevice));
    CUDA_CHECK(cudaMemcpy(d_b, h_b, bytes, cudaMemcpyHostToDevice));

    /**
     * CONFIGURACIÓN 2D
     *
     * dim3 es una estructura con 3 campos: x, y, z
     * Útil para especificar configuración multidimensional
     */

    // Bloque de 16x16 threads (total: 256 threads)
    dim3 blockDim(16, 16);

    // Grid: suficientes bloques para cubrir toda la matriz
    dim3 gridDim((width + blockDim.x - 1) / blockDim.x,
                 (height + blockDim.y - 1) / blockDim.y);

    printf("\nConfiguración:\n");
    printf("  Matriz: %dx%d\n", height, width);
    printf("  Block: %dx%d threads\n", blockDim.x, blockDim.y);
    printf("  Grid: %dx%d bloques\n", gridDim.x, gridDim.y);
    printf("  Threads totales: %d\n",
           blockDim.x * blockDim.y * gridDim.x * gridDim.y);

    // Lanzar kernel
    suma2D<<<gridDim, blockDim>>>(d_a, d_b, d_c, width, height);
    CUDA_CHECK(cudaGetLastError());
    CUDA_CHECK(cudaDeviceSynchronize());

    // Copiar resultado
    CUDA_CHECK(cudaMemcpy(h_c, d_c, bytes, cudaMemcpyDeviceToHost));

    // Mostrar resultados
    imprimirMatriz("Matriz A", h_a, height, width);
    imprimirMatriz("Matriz B", h_b, height, width);
    imprimirMatriz("Matriz C (A+B)", h_c, height, width);

    // Verificar
    bool correcto = true;
    for (int i = 0; i < height * width; i++) {
        if (h_c[i] != h_a[i] + h_b[i]) {
            correcto = false;
            break;
        }
    }
    printf("\n%s\n", correcto ? "✓ Resultado correcto" : "✗ Error en el cálculo");

    // Limpiar
    free(h_a); free(h_b); free(h_c);
    cudaFree(d_a); cudaFree(d_b); cudaFree(d_c);
}

/**
 * ════════════════════════════════════════════════════════════
 * DEMO 2: Transposición de Matriz
 * ════════════════════════════════════════════════════════════
 */
void demoTransponer() {
    printf("\n╔════════════════════════════════════════════════╗\n");
    printf("║         DEMO 2D: Transposición                 ║\n");
    printf("╚════════════════════════════════════════════════╝\n");

    const int width = 6;
    const int height = 4;
    size_t bytes = width * height * sizeof(float);

    float *h_input, *h_output;
    h_input = (float*)malloc(bytes);
    h_output = (float*)malloc(bytes);

    // Inicializar con patrón reconocible
    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
            h_input[y * width + x] = y * 10 + x;
        }
    }

    float *d_input, *d_output;
    CUDA_CHECK(cudaMalloc(&d_input, bytes));
    CUDA_CHECK(cudaMalloc(&d_output, bytes));

    CUDA_CHECK(cudaMemcpy(d_input, h_input, bytes, cudaMemcpyHostToDevice));

    dim3 blockDim(16, 16);
    dim3 gridDim((width + 15) / 16, (height + 15) / 16);

    transponer<<<gridDim, blockDim>>>(d_input, d_output, width, height);
    CUDA_CHECK(cudaGetLastError());
    CUDA_CHECK(cudaDeviceSynchronize());

    CUDA_CHECK(cudaMemcpy(h_output, d_output, bytes, cudaMemcpyDeviceToHost));

    imprimirMatriz("Matriz Original", h_input, height, width);
    imprimirMatriz("Matriz Transpuesta", h_output, width, height);

    free(h_input); free(h_output);
    cudaFree(d_input); cudaFree(d_output);
}

/**
 * ════════════════════════════════════════════════════════════
 * MAIN
 * ════════════════════════════════════════════════════════════
 */
int main() {
    printf("╔═════════════════════════════════════════════════════╗\n");
    printf("║       EJEMPLO 1: Grids y Bloques 2D y 3D           ║\n");
    printf("╚═════════════════════════════════════════════════════╝\n");

    demo2D();
    demoTransponer();

    printf("\n═══════════════════════════════════════════════════════\n");
    printf("                     FIN DEL EJEMPLO\n");
    printf("═══════════════════════════════════════════════════════\n");

    return 0;
}

/**
 * PUNTOS CLAVE:
 *
 * 1. GRIDS 2D son ideales para matrices y imágenes
 * 2. GRIDS 3D son útiles para volúmenes y simulaciones
 * 3. dim3 permite especificar hasta 3 dimensiones
 * 4. Siempre verifica límites en TODAS las dimensiones
 * 5. El cálculo de índice lineal es: idx = z*(H*W) + y*W + x
 *
 * PATRÓN COMÚN PARA 2D:
 *
 * int x = blockIdx.x * blockDim.x + threadIdx.x;
 * int y = blockIdx.y * blockDim.y + threadIdx.y;
 * int idx = y * width + x;
 * if (x < width && y < height) { ... }
 *
 * EJERCICIO:
 *
 * Implementa un kernel que rote una matriz 90° a la derecha
 * Pista: output[x][height-1-y] = input[y][x]
 */
