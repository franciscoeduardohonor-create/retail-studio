/**
 * EJEMPLO 3: Unified Memory (Memoria Unificada)
 *
 * Este ejemplo demuestra:
 * - Qué es Unified Memory y sus ventajas
 * - Cómo usar cudaMallocManaged
 * - Diferencias con gestión manual de memoria
 * - Prefetching y hints de rendimiento
 *
 * Para compilar: nvcc ejemplo_03_memoria_unificada.cu -o ejemplo_03
 * Para ejecutar: ./ejemplo_03
 */

#include <stdio.h>
#include <cuda_runtime.h>

#define N 1024 * 1024  // 1 millón de elementos

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
 * KERNEL SIMPLE: Suma de vectores
 * ════════════════════════════════════════════════════════════
 */
__global__ void sumaVectores(float *a, float *b, float *c, int n) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx < n) {
        c[idx] = a[idx] + b[idx];
    }
}

/**
 * ════════════════════════════════════════════════════════════
 * KERNEL: Modificar datos in-place
 * ════════════════════════════════════════════════════════════
 */
__global__ void duplicarValores(float *data, int n) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx < n) {
        data[idx] *= 2.0f;
    }
}

/**
 * ════════════════════════════════════════════════════════════
 * MÉTODO TRADICIONAL: Gestión Manual de Memoria
 * ════════════════════════════════════════════════════════════
 */
void metodoTradicional() {
    printf("\n╔════════════════════════════════════════════════╗\n");
    printf("║     MÉTODO 1: Gestión Manual (Tradicional)    ║\n");
    printf("╚════════════════════════════════════════════════╝\n\n");

    const int n = 10;
    size_t bytes = n * sizeof(float);

    // Variables para CPU y GPU
    float *h_a, *h_b, *h_c;  // host
    float *d_a, *d_b, *d_c;  // device

    printf("Pasos necesarios:\n");

    // 1. Asignar en host
    printf("  1. malloc para CPU...\n");
    h_a = (float*)malloc(bytes);
    h_b = (float*)malloc(bytes);
    h_c = (float*)malloc(bytes);

    // 2. Inicializar
    printf("  2. Inicializar datos en CPU...\n");
    for (int i = 0; i < n; i++) {
        h_a[i] = i;
        h_b[i] = i * 2.0f;
    }

    // 3. Asignar en device
    printf("  3. cudaMalloc para GPU...\n");
    CUDA_CHECK(cudaMalloc(&d_a, bytes));
    CUDA_CHECK(cudaMalloc(&d_b, bytes));
    CUDA_CHECK(cudaMalloc(&d_c, bytes));

    // 4. Copiar a device
    printf("  4. cudaMemcpy CPU → GPU...\n");
    CUDA_CHECK(cudaMemcpy(d_a, h_a, bytes, cudaMemcpyHostToDevice));
    CUDA_CHECK(cudaMemcpy(d_b, h_b, bytes, cudaMemcpyHostToDevice));

    // 5. Ejecutar kernel
    printf("  5. Ejecutar kernel...\n");
    sumaVectores<<<(n+255)/256, 256>>>(d_a, d_b, d_c, n);

    // 6. Copiar resultado
    printf("  6. cudaMemcpy GPU → CPU...\n");
    CUDA_CHECK(cudaMemcpy(h_c, d_c, bytes, cudaMemcpyDeviceToHost));

    // 7. Verificar
    printf("  7. Verificar resultados...\n");
    printf("\n  Resultados:\n");
    for (int i = 0; i < 5; i++) {
        printf("    %.0f + %.0f = %.0f\n", h_a[i], h_b[i], h_c[i]);
    }

    // 8. Liberar memoria
    printf("\n  8. Liberar memoria (6 llamadas)...\n");
    free(h_a); free(h_b); free(h_c);
    cudaFree(d_a); cudaFree(d_b); cudaFree(d_c);

    printf("\n  Total de pasos: 8\n");
    printf("  Líneas de código: ~25+\n");
}

/**
 * ════════════════════════════════════════════════════════════
 * MÉTODO CON UNIFIED MEMORY: Mucho más simple
 * ════════════════════════════════════════════════════════════
 */
void metodoUnifiedMemory() {
    printf("\n╔════════════════════════════════════════════════╗\n");
    printf("║     MÉTODO 2: Unified Memory (Moderno)        ║\n");
    printf("╚════════════════════════════════════════════════╝\n\n");

    const int n = 10;
    size_t bytes = n * sizeof(float);

    /**
     * UNIFIED MEMORY: Un solo puntero para CPU y GPU
     *
     * cudaMallocManaged crea memoria accesible desde:
     * - CPU (host)
     * - GPU (device)
     *
     * El sistema automáticamente migra los datos donde se necesiten
     */

    float *a, *b, *c;  // ¡Un solo conjunto de punteros!

    printf("Pasos necesarios:\n");

    // 1. Asignar memoria unificada
    printf("  1. cudaMallocManaged (accesible en CPU y GPU)...\n");
    CUDA_CHECK(cudaMallocManaged(&a, bytes));
    CUDA_CHECK(cudaMallocManaged(&b, bytes));
    CUDA_CHECK(cudaMallocManaged(&c, bytes));

    // 2. Inicializar directamente (¡sin copias!)
    printf("  2. Inicializar datos directamente...\n");
    for (int i = 0; i < n; i++) {
        a[i] = i;
        b[i] = i * 2.0f;
    }

    // 3. Ejecutar kernel (¡sin copias manuales!)
    printf("  3. Ejecutar kernel...\n");
    sumaVectores<<<(n+255)/256, 256>>>(a, b, c, n);

    // 4. Sincronizar
    printf("  4. Sincronizar...\n");
    CUDA_CHECK(cudaDeviceSynchronize());

    // 5. Usar resultados directamente (¡sin copias!)
    printf("  5. Acceder a resultados directamente...\n");
    printf("\n  Resultados:\n");
    for (int i = 0; i < 5; i++) {
        printf("    %.0f + %.0f = %.0f\n", a[i], b[i], c[i]);
    }

    // 6. Liberar
    printf("\n  6. Liberar memoria (3 llamadas)...\n");
    cudaFree(a);
    cudaFree(b);
    cudaFree(c);

    printf("\n  Total de pasos: 6\n");
    printf("  Líneas de código: ~15\n");

    printf("\n  ✓ Ventajas:\n");
    printf("    - Código más simple\n");
    printf("    - Menos propensión a errores\n");
    printf("    - No necesitas cudaMemcpy\n");
    printf("    - Menos variables para trackear\n");
}

/**
 * ════════════════════════════════════════════════════════════
 * EJEMPLO AVANZADO: Prefetching
 * ════════════════════════════════════════════════════════════
 */
void ejemploPrefetching() {
    printf("\n╔════════════════════════════════════════════════╗\n");
    printf("║     OPTIMIZACIÓN: Prefetching                  ║\n");
    printf("╚════════════════════════════════════════════════╝\n\n");

    const int n = N;
    size_t bytes = n * sizeof(float);

    float *data;
    CUDA_CHECK(cudaMallocManaged(&data, bytes));

    // Inicializar en CPU
    for (int i = 0; i < n; i++) {
        data[i] = i;
    }

    int device;
    CUDA_CHECK(cudaGetDevice(&device));

    /**
     * PREFETCHING: Mover datos explícitamente
     *
     * cudaMemPrefetchAsync sugiere al sistema que mueva
     * los datos a un dispositivo específico ANTES de usarlos
     *
     * Ventajas:
     * - Reduce page faults
     * - Mejora rendimiento
     * - Mantiene la simplicidad de Unified Memory
     */

    printf("Sin prefetch:\n");
    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    cudaEventRecord(start);
    duplicarValores<<<(n+255)/256, 256>>>(data, n);
    CUDA_CHECK(cudaDeviceSynchronize());
    cudaEventRecord(stop);
    cudaEventSynchronize(stop);

    float ms1;
    cudaEventElapsedTime(&ms1, start, stop);
    printf("  Tiempo: %.4f ms\n", ms1);

    // Resetear datos
    for (int i = 0; i < n; i++) {
        data[i] = i;
    }

    printf("\nCon prefetch:\n");

    cudaEventRecord(start);
    // Prefetch a GPU ANTES de ejecutar kernel
    CUDA_CHECK(cudaMemPrefetchAsync(data, bytes, device));
    duplicarValores<<<(n+255)/256, 256>>>(data, n);
    CUDA_CHECK(cudaDeviceSynchronize());
    cudaEventRecord(stop);
    cudaEventSynchronize(stop);

    float ms2;
    cudaEventElapsedTime(&ms2, start, stop);
    printf("  Tiempo: %.4f ms\n", ms2);

    printf("\n  Mejora: %.2fx más rápido\n", ms1/ms2);

    cudaEventDestroy(start);
    cudaEventDestroy(stop);
    cudaFree(data);
}

/**
 * ════════════════════════════════════════════════════════════
 * EJEMPLO: Acceso desde CPU y GPU intercalado
 * ════════════════════════════════════════════════════════════
 */
void ejemploAccesoIntercalado() {
    printf("\n╔════════════════════════════════════════════════╗\n");
    printf("║     Acceso Intercalado CPU-GPU                 ║\n");
    printf("╚════════════════════════════════════════════════╝\n\n");

    const int n = 10;
    size_t bytes = n * sizeof(float);

    float *data;
    CUDA_CHECK(cudaMallocManaged(&data, bytes));

    // 1. CPU escribe
    printf("1. CPU inicializa datos:\n");
    for (int i = 0; i < n; i++) {
        data[i] = i;
    }
    printf("   data = [%.0f, %.0f, %.0f, ...]\n", data[0], data[1], data[2]);

    // 2. GPU procesa
    printf("\n2. GPU duplica valores:\n");
    duplicarValores<<<1, n>>>(data, n);
    CUDA_CHECK(cudaDeviceSynchronize());
    printf("   data = [%.0f, %.0f, %.0f, ...]\n", data[0], data[1], data[2]);

    // 3. CPU lee y modifica
    printf("\n3. CPU suma 100 a cada elemento:\n");
    for (int i = 0; i < n; i++) {
        data[i] += 100.0f;
    }
    printf("   data = [%.0f, %.0f, %.0f, ...]\n", data[0], data[1], data[2]);

    // 4. GPU procesa de nuevo
    printf("\n4. GPU duplica valores nuevamente:\n");
    duplicarValores<<<1, n>>>(data, n);
    CUDA_CHECK(cudaDeviceSynchronize());
    printf("   data = [%.0f, %.0f, %.0f, ...]\n", data[0], data[1], data[2]);

    printf("\n✓ Los datos se migraron automáticamente entre CPU y GPU\n");

    cudaFree(data);
}

/**
 * ════════════════════════════════════════════════════════════
 * MAIN
 * ════════════════════════════════════════════════════════════
 */
int main() {
    printf("╔═════════════════════════════════════════════════════╗\n");
    printf("║       EJEMPLO 3: Unified Memory                     ║\n");
    printf("╚═════════════════════════════════════════════════════╝\n");

    // Verificar soporte de Unified Memory
    int device;
    CUDA_CHECK(cudaGetDevice(&device));

    cudaDeviceProp prop;
    CUDA_CHECK(cudaGetDeviceProperties(&prop, device));

    if (!prop.managedMemory) {
        printf("\n⚠ Tu GPU no soporta Unified Memory\n");
        return 1;
    }

    printf("\n✓ GPU: %s soporta Unified Memory\n", prop.name);

    metodoTradicional();
    metodoUnifiedMemory();
    ejemploAccesoIntercalado();
    ejemploPrefetching();

    printf("\n═══════════════════════════════════════════════════════\n");
    printf("                     FIN DEL EJEMPLO\n");
    printf("═══════════════════════════════════════════════════════\n");

    return 0;
}

/**
 * ════════════════════════════════════════════════════════════
 * RESUMEN: UNIFIED MEMORY
 * ════════════════════════════════════════════════════════════
 *
 * VENTAJAS:
 * ✓ Código mucho más simple
 * ✓ Menos propensión a errores
 * ✓ No necesitas cudaMemcpy manual
 * ✓ Un solo puntero para CPU y GPU
 * ✓ Ideal para prototipado rápido
 *
 * DESVENTAJAS:
 * ✗ Puede ser más lento que gestión manual optimizada
 * ✗ Requiere GPU con Compute Capability 3.0+
 * ✗ Menos control sobre transferencias
 *
 * CUÁNDO USAR:
 * - Prototipado y desarrollo rápido
 * - Aplicaciones donde la simplicidad es importante
 * - Cuando los datos se acceden desde CPU y GPU
 * - Cuando el rendimiento es "suficientemente bueno"
 *
 * OPTIMIZACIONES:
 * 1. cudaMemPrefetchAsync - prefetch a dispositivo específico
 * 2. cudaMemAdvise - hints sobre uso de memoria
 * 3. Verificar con CUDA profiler
 *
 * FUNCIONES CLAVE:
 *
 * cudaMallocManaged(&ptr, bytes)  - Asignar memoria unificada
 * cudaMemPrefetchAsync(...)       - Prefetch a dispositivo
 * cudaMemAdvise(...)              - Hints de uso
 * cudaFree(ptr)                   - Liberar (igual que memoria normal)
 *
 * EJERCICIO:
 *
 * Convierte el programa de multiplicación de matrices del
 * Módulo 1 para usar Unified Memory en lugar de gestión manual.
 */
