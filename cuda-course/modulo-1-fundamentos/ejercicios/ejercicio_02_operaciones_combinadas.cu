/**
 * EJERCICIO 2: Operaciones Combinadas
 *
 * OBJETIVO:
 * Implementar un kernel que realice múltiples operaciones:
 * resultado[i] = (a[i] + b[i]) * c[i] - d[i]
 *
 * NIVEL: Principiante
 *
 * INSTRUCCIONES:
 * 1. Completa el kernel operacionesCombinadas
 * 2. El kernel debe realizar la operación: (a + b) * c - d
 * 3. Practica pasando múltiples arrays al kernel
 *
 * Para compilar: nvcc ejercicio_02_operaciones_combinadas.cu -o ejercicio_02
 * Para ejecutar: ./ejercicio_02
 */

#include <stdio.h>
#include <cuda_runtime.h>

#define N 1024
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
 * - Necesitas 5 parámetros: a, b, c, d, resultado
 * - Calcula: resultado[idx] = (a[idx] + b[idx]) * c[idx] - d[idx]
 * - No olvides verificar límites
 */
__global__ void operacionesCombinadas(float *a, float *b, float *c,
                                       float *d, float *resultado, int n) {
    // ┌─────────────────────────────────────────────┐
    // │  ESCRIBE TU CÓDIGO AQUÍ                     │
    // └─────────────────────────────────────────────┘


}

int main() {
    printf("=== EJERCICIO 2: Operaciones Combinadas ===\n\n");
    printf("Operación: resultado = (a + b) * c - d\n\n");

    // Declarar punteros
    float *h_a, *h_b, *h_c, *h_d, *h_resultado;
    float *d_a, *d_b, *d_c, *d_d, *d_resultado;
    size_t bytes = N * sizeof(float);

    // Asignar memoria en host
    h_a = (float*)malloc(bytes);
    h_b = (float*)malloc(bytes);
    h_c = (float*)malloc(bytes);
    h_d = (float*)malloc(bytes);
    h_resultado = (float*)malloc(bytes);

    // Inicializar con valores simples para fácil verificación
    printf("Inicializando datos de prueba...\n");
    for (int i = 0; i < N; i++) {
        h_a[i] = 1.0f;
        h_b[i] = 2.0f;
        h_c[i] = 3.0f;
        h_d[i] = 4.0f;
        // Esperado: (1 + 2) * 3 - 4 = 9 - 4 = 5
    }

    // Asignar memoria en device
    CUDA_CHECK(cudaMalloc(&d_a, bytes));
    CUDA_CHECK(cudaMalloc(&d_b, bytes));
    CUDA_CHECK(cudaMalloc(&d_c, bytes));
    CUDA_CHECK(cudaMalloc(&d_d, bytes));
    CUDA_CHECK(cudaMalloc(&d_resultado, bytes));

    // Copiar datos a device
    CUDA_CHECK(cudaMemcpy(d_a, h_a, bytes, cudaMemcpyHostToDevice));
    CUDA_CHECK(cudaMemcpy(d_b, h_b, bytes, cudaMemcpyHostToDevice));
    CUDA_CHECK(cudaMemcpy(d_c, h_c, bytes, cudaMemcpyHostToDevice));
    CUDA_CHECK(cudaMemcpy(d_d, h_d, bytes, cudaMemcpyHostToDevice));

    // Lanzar kernel
    int threadsPerBlock = 256;
    int blocksPerGrid = (N + threadsPerBlock - 1) / threadsPerBlock;

    printf("Ejecutando kernel...\n");
    operacionesCombinadas<<<blocksPerGrid, threadsPerBlock>>>(
        d_a, d_b, d_c, d_d, d_resultado, N);

    CUDA_CHECK(cudaGetLastError());
    CUDA_CHECK(cudaDeviceSynchronize());

    // Copiar resultados
    CUDA_CHECK(cudaMemcpy(h_resultado, d_resultado, bytes, cudaMemcpyDeviceToHost));

    // Verificar (esperamos 5.0 para todos)
    printf("Verificando resultados...\n");
    float esperado = (h_a[0] + h_b[0]) * h_c[0] - h_d[0];
    bool correcto = true;

    for (int i = 0; i < N; i++) {
        if (h_resultado[i] != esperado) {
            printf("ERROR en índice %d: esperado %.1f, obtenido %.1f\n",
                   i, esperado, h_resultado[i]);
            correcto = false;
            break;
        }
    }

    if (correcto) {
        printf("✓ ¡CORRECTO! Todos los resultados son %.1f\n", esperado);
        printf("\nVerificación manual:\n");
        printf("  (%.1f + %.1f) * %.1f - %.1f = %.1f\n",
               h_a[0], h_b[0], h_c[0], h_d[0], h_resultado[0]);
    } else {
        printf("✗ Hay errores. Revisa la fórmula en tu kernel.\n");
    }

    // Liberar memoria
    free(h_a); free(h_b); free(h_c); free(h_d); free(h_resultado);
    cudaFree(d_a); cudaFree(d_b); cudaFree(d_c); cudaFree(d_d); cudaFree(d_resultado);

    return 0;
}

/**
 * SOLUCIÓN (no mires hasta intentar):
 *
 * __global__ void operacionesCombinadas(float *a, float *b, float *c,
 *                                        float *d, float *resultado, int n) {
 *     int idx = blockIdx.x * blockDim.x + threadIdx.x;
 *     if (idx < n) {
 *         resultado[idx] = (a[idx] + b[idx]) * c[idx] - d[idx];
 *     }
 * }
 *
 * DESAFÍO EXTRA:
 * 1. Cambia la operación a: (a * b + c) / d
 * 2. Agrega verificación para división por cero
 */
