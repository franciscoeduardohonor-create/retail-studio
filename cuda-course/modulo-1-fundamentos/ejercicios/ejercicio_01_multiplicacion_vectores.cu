/**
 * EJERCICIO 1: Multiplicación de Vectores
 *
 * OBJETIVO:
 * Implementar un kernel que multiplique dos vectores elemento por elemento
 * y almacene el resultado en un tercer vector: c[i] = a[i] * b[i]
 *
 * NIVEL: Principiante
 *
 * INSTRUCCIONES:
 * 1. Completa la función multiplicarVectores (kernel)
 * 2. El kernel debe multiplicar a[i] * b[i] y guardar en c[i]
 * 3. Asegúrate de verificar los límites del array
 * 4. El código de verificación ya está implementado
 *
 * Para compilar: nvcc ejercicio_01_multiplicacion_vectores.cu -o ejercicio_01
 * Para ejecutar: ./ejercicio_01
 */

#include <stdio.h>
#include <cuda_runtime.h>

#define N 2048
#define CUDA_CHECK(call) \
    do { \
        cudaError_t error = call; \
        if (error != cudaSuccess) { \
            fprintf(stderr, "Error CUDA: %s\n", cudaGetErrorString(error)); \
            exit(EXIT_FAILURE); \
        } \
    } while(0)

/**
 * TODO: Implementa este kernel
 *
 * PISTAS:
 * - Calcula el índice global: idx = blockIdx.x * blockDim.x + threadIdx.x
 * - Verifica que idx < n
 * - Realiza la multiplicación: c[idx] = a[idx] * b[idx]
 */
__global__ void multiplicarVectores(float *a, float *b, float *c, int n) {
    // ┌─────────────────────────────────────────────┐
    // │  ESCRIBE TU CÓDIGO AQUÍ                     │
    // └─────────────────────────────────────────────┘

    // Paso 1: Calcula el índice global


    // Paso 2: Verifica límites y realiza la multiplicación


}

int main() {
    printf("=== EJERCICIO 1: Multiplicación de Vectores ===\n\n");

    float *h_a, *h_b, *h_c;
    float *d_a, *d_b, *d_c;
    size_t bytes = N * sizeof(float);

    // Asignar memoria en host
    h_a = (float*)malloc(bytes);
    h_b = (float*)malloc(bytes);
    h_c = (float*)malloc(bytes);

    // Inicializar vectores
    printf("Inicializando vectores de %d elementos...\n", N);
    for (int i = 0; i < N; i++) {
        h_a[i] = i * 1.0f;
        h_b[i] = 2.0f;  // Multiplicar cada elemento por 2
    }

    // Asignar memoria en device
    CUDA_CHECK(cudaMalloc(&d_a, bytes));
    CUDA_CHECK(cudaMalloc(&d_b, bytes));
    CUDA_CHECK(cudaMalloc(&d_c, bytes));

    // Copiar datos a device
    CUDA_CHECK(cudaMemcpy(d_a, h_a, bytes, cudaMemcpyHostToDevice));
    CUDA_CHECK(cudaMemcpy(d_b, h_b, bytes, cudaMemcpyHostToDevice));

    // Configurar y lanzar kernel
    int threadsPerBlock = 256;
    int blocksPerGrid = (N + threadsPerBlock - 1) / threadsPerBlock;

    printf("Lanzando kernel con %d bloques de %d threads...\n",
           blocksPerGrid, threadsPerBlock);

    multiplicarVectores<<<blocksPerGrid, threadsPerBlock>>>(d_a, d_b, d_c, N);

    CUDA_CHECK(cudaGetLastError());
    CUDA_CHECK(cudaDeviceSynchronize());

    // Copiar resultados
    CUDA_CHECK(cudaMemcpy(h_c, d_c, bytes, cudaMemcpyDeviceToHost));

    // Verificar resultados
    printf("Verificando resultados...\n");
    bool correcto = true;
    for (int i = 0; i < N; i++) {
        float esperado = h_a[i] * h_b[i];
        if (h_c[i] != esperado) {
            printf("ERROR en índice %d: esperado %.1f, obtenido %.1f\n",
                   i, esperado, h_c[i]);
            correcto = false;
            break;
        }
    }

    if (correcto) {
        printf("✓ ¡CORRECTO! Todos los resultados son válidos\n\n");
        printf("Primeros 10 resultados:\n");
        for (int i = 0; i < 10; i++) {
            printf("  %.1f * %.1f = %.1f\n", h_a[i], h_b[i], h_c[i]);
        }
    } else {
        printf("✗ Hay errores en el cálculo. Revisa tu kernel.\n");
    }

    // Liberar memoria
    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);
    free(h_a);
    free(h_b);
    free(h_c);

    return 0;
}

/**
 * SOLUCIÓN (no mires hasta haber intentado):
 *
 * __global__ void multiplicarVectores(float *a, float *b, float *c, int n) {
 *     int idx = blockIdx.x * blockDim.x + threadIdx.x;
 *     if (idx < n) {
 *         c[idx] = a[idx] * b[idx];
 *     }
 * }
 *
 * DESAFÍO EXTRA:
 * Modifica el programa para realizar: c[i] = a[i] * b[i] + a[i]
 */
