/**
 * EJEMPLO 3: Gestión de Errores en CUDA
 *
 * Este ejemplo demuestra:
 * - Cómo detectar y manejar errores en CUDA
 * - Diferentes tipos de errores (memoria, kernel, etc.)
 * - Macros útiles para debugging
 * - Mejores prácticas para programación robusta
 *
 * Para compilar: nvcc ejemplo_03_gestion_errores.cu -o ejemplo_03
 * Para ejecutar: ./ejemplo_03
 */

#include <stdio.h>
#include <cuda_runtime.h>

/**
 * MACRO PARA VERIFICAR ERRORES DE CUDA
 *
 * Esta macro verifica si una llamada CUDA tuvo éxito.
 * Si hay un error:
 * - Imprime el mensaje de error
 * - Muestra el archivo y línea donde ocurrió
 * - Termina el programa
 *
 * Uso: CUDA_CHECK(cudaMalloc(...));
 */
#define CUDA_CHECK(call) \
    do { \
        cudaError_t error = call; \
        if (error != cudaSuccess) { \
            fprintf(stderr, "Error CUDA en %s:%d: %s\n", \
                    __FILE__, __LINE__, cudaGetErrorString(error)); \
            exit(EXIT_FAILURE); \
        } \
    } while(0)

/**
 * MACRO PARA VERIFICAR ERRORES DE KERNEL
 *
 * Los kernels no devuelven valores, así que necesitamos
 * verificar errores de manera diferente:
 * 1. cudaGetLastError() - obtiene el error del último kernel lanzado
 * 2. cudaDeviceSynchronize() - espera a que termine y verifica errores de ejecución
 */
#define CUDA_CHECK_KERNEL() \
    do { \
        cudaError_t error = cudaGetLastError(); \
        if (error != cudaSuccess) { \
            fprintf(stderr, "Error al lanzar kernel en %s:%d: %s\n", \
                    __FILE__, __LINE__, cudaGetErrorString(error)); \
            exit(EXIT_FAILURE); \
        } \
        error = cudaDeviceSynchronize(); \
        if (error != cudaSuccess) { \
            fprintf(stderr, "Error durante ejecución del kernel en %s:%d: %s\n", \
                    __FILE__, __LINE__, cudaGetErrorString(error)); \
            exit(EXIT_FAILURE); \
        } \
    } while(0)

/**
 * KERNEL SIMPLE PARA DEMOSTRACIÓN
 */
__global__ void kernelEjemplo(float *data, int n) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx < n) {
        data[idx] = data[idx] * 2.0f;
    }
}

/**
 * KERNEL CON ERROR INTENCIONAL
 * Este kernel intenta acceder a memoria fuera de límites
 */
__global__ void kernelConError(float *data, int n) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    // ERROR: No verificamos límites, puede acceder fuera del array
    data[idx * 2] = idx;  // Potencialmente fuera de límites
}

/**
 * Función para demostrar verificación de errores básica
 */
void ejemplo1_VerificacionBasica() {
    printf("\n=== EJEMPLO 1: Verificación Básica de Errores ===\n\n");

    float *d_data;
    int n = 1024;
    size_t bytes = n * sizeof(float);

    // Forma INCORRECTA (sin verificar errores):
    // cudaMalloc(&d_data, bytes);

    // Forma CORRECTA (verificando errores):
    cudaError_t error = cudaMalloc(&d_data, bytes);
    if (error != cudaSuccess) {
        printf("Error al asignar memoria: %s\n", cudaGetErrorString(error));
        return;
    }
    printf("✓ Memoria asignada correctamente\n");

    // Forma más conveniente usando la macro:
    CUDA_CHECK(cudaFree(d_data));
    printf("✓ Memoria liberada correctamente\n");
}

/**
 * Función para demostrar manejo de errores con la macro
 */
void ejemplo2_UsoDesMacros() {
    printf("\n=== EJEMPLO 2: Uso de Macros para Verificación ===\n\n");

    float *h_data, *d_data;
    int n = 1024;
    size_t bytes = n * sizeof(float);

    // Asignar y verificar memoria en host
    h_data = (float*)malloc(bytes);
    for (int i = 0; i < n; i++) {
        h_data[i] = i * 1.0f;
    }
    printf("✓ Memoria del host inicializada\n");

    // Asignar memoria en device (con verificación)
    CUDA_CHECK(cudaMalloc(&d_data, bytes));
    printf("✓ Memoria del device asignada\n");

    // Copiar datos (con verificación)
    CUDA_CHECK(cudaMemcpy(d_data, h_data, bytes, cudaMemcpyHostToDevice));
    printf("✓ Datos copiados a GPU\n");

    // Lanzar kernel (con verificación)
    int threadsPerBlock = 256;
    int blocksPerGrid = (n + threadsPerBlock - 1) / threadsPerBlock;

    kernelEjemplo<<<blocksPerGrid, threadsPerBlock>>>(d_data, n);
    CUDA_CHECK_KERNEL();
    printf("✓ Kernel ejecutado correctamente\n");

    // Copiar resultados (con verificación)
    CUDA_CHECK(cudaMemcpy(h_data, d_data, bytes, cudaMemcpyDeviceToHost));
    printf("✓ Resultados copiados a CPU\n");

    // Verificar algunos resultados
    printf("\nPrimeros 5 resultados (deben ser el doble):\n");
    for (int i = 0; i < 5; i++) {
        printf("  %d: %.1f (original) -> %.1f (resultado)\n",
               i, i * 1.0f, h_data[i]);
    }

    // Limpiar
    CUDA_CHECK(cudaFree(d_data));
    free(h_data);
}

/**
 * Función para demostrar detección de errores comunes
 */
void ejemplo3_ErroresComunes() {
    printf("\n=== EJEMPLO 3: Detección de Errores Comunes ===\n\n");

    float *d_data;
    int n = 1024;
    size_t bytes = n * sizeof(float);

    CUDA_CHECK(cudaMalloc(&d_data, bytes));

    printf("Intentando lanzar kernel con configuración inválida...\n");

    // ERROR COMÚN 1: Demasiados threads por bloque
    // El máximo típicamente es 1024 threads por bloque
    int threadsInvalidos = 2048;  // Demasiados!

    printf("  Lanzando con %d threads por bloque...\n", threadsInvalidos);

    // Esto causará un error
    kernelEjemplo<<<1, threadsInvalidos>>>(d_data, n);

    cudaError_t error = cudaGetLastError();
    if (error != cudaSuccess) {
        printf("  ✓ Error detectado correctamente: %s\n", cudaGetErrorString(error));
        printf("    (El máximo de threads por bloque suele ser 1024)\n");
    }

    // Resetear el error
    cudaGetLastError();

    printf("\nIntentando acceso a memoria no asignada...\n");

    // ERROR COMÚN 2: Usar puntero después de liberarlo
    CUDA_CHECK(cudaFree(d_data));
    printf("  Memoria liberada\n");

    // Intentar usar el puntero liberado (MAL!)
    error = cudaMemset(d_data, 0, bytes);
    if (error != cudaSuccess) {
        printf("  ✓ Error detectado correctamente: %s\n", cudaGetErrorString(error));
    }

    // Resetear el error para no afectar otros ejemplos
    cudaGetLastError();
}

/**
 * Función para mostrar información de dispositivo
 */
void mostrarInfoDispositivo() {
    printf("\n=== INFORMACIÓN DEL DISPOSITIVO ===\n\n");

    int deviceCount;
    CUDA_CHECK(cudaGetDeviceCount(&deviceCount));

    printf("Número de dispositivos CUDA disponibles: %d\n", deviceCount);

    for (int i = 0; i < deviceCount; i++) {
        cudaDeviceProp prop;
        CUDA_CHECK(cudaGetDeviceProperties(&prop, i));

        printf("\nDispositivo %d: %s\n", i, prop.name);
        printf("  Compute Capability: %d.%d\n", prop.major, prop.minor);
        printf("  Memoria global: %.2f GB\n",
               prop.totalGlobalMem / 1024.0 / 1024.0 / 1024.0);
        printf("  Threads máximos por bloque: %d\n", prop.maxThreadsPerBlock);
        printf("  Dimensiones máximas del bloque: (%d, %d, %d)\n",
               prop.maxThreadsDim[0], prop.maxThreadsDim[1], prop.maxThreadsDim[2]);
        printf("  Dimensiones máximas del grid: (%d, %d, %d)\n",
               prop.maxGridSize[0], prop.maxGridSize[1], prop.maxGridSize[2]);
    }
}

int main() {
    printf("=== EJEMPLO 3: Gestión de Errores en CUDA ===\n");

    // Mostrar información del dispositivo
    mostrarInfoDispositivo();

    // Ejecutar ejemplos
    ejemplo1_VerificacionBasica();
    ejemplo2_UsoDesMacros();
    ejemplo3_ErroresComunes();

    printf("\n=== FIN DEL EJEMPLO ===\n");

    return 0;
}

/**
 * RESUMEN DE MEJORES PRÁCTICAS:
 *
 * 1. SIEMPRE verifica errores después de llamadas CUDA
 * 2. Usa macros como CUDA_CHECK para código más limpio
 * 3. Verifica errores de kernel con cudaGetLastError() y cudaDeviceSynchronize()
 * 4. Conoce los límites de tu GPU (usa cudaGetDeviceProperties)
 * 5. En producción, maneja errores de forma robusta
 *
 * ERRORES COMUNES A EVITAR:
 *
 * 1. No verificar errores de cudaMalloc (puede fallar si no hay memoria)
 * 2. Lanzar kernels con demasiados threads por bloque
 * 3. Acceder a memoria después de cudaFree
 * 4. No sincronizar antes de acceder a resultados
 * 5. Olvidar verificar errores de kernel
 *
 * EJERCICIO:
 *
 * Agrega verificación de errores a tus programas anteriores
 * usando las macros CUDA_CHECK y CUDA_CHECK_KERNEL.
 */
