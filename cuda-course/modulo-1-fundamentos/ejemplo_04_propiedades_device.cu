/**
 * EJEMPLO 4: Propiedades del Device (GPU)
 *
 * Este ejemplo demuestra:
 * - Cómo obtener información detallada de tu GPU
 * - Qué propiedades son importantes para optimización
 * - Cómo seleccionar el mejor dispositivo
 * - Uso de threadIdx, blockIdx y blockDim en detalle
 *
 * Para compilar: nvcc ejemplo_04_propiedades_device.cu -o ejemplo_04
 * Para ejecutar: ./ejemplo_04
 */

#include <stdio.h>
#include <cuda_runtime.h>

#define CUDA_CHECK(call) \
    do { \
        cudaError_t error = call; \
        if (error != cudaSuccess) { \
            fprintf(stderr, "Error CUDA: %s\n", cudaGetErrorString(error)); \
            exit(EXIT_FAILURE); \
        } \
    } while(0)

/**
 * KERNEL: Mostrar información de threads
 *
 * Este kernel imprime las variables built-in de CUDA
 * para ayudarte a entender cómo se organizan los threads
 */
__global__ void mostrarInfoThreads() {
    /**
     * VARIABLES BUILT-IN DE CUDA:
     *
     * threadIdx.x/y/z : Índice del thread dentro del bloque (0 a blockDim-1)
     * blockIdx.x/y/z  : Índice del bloque dentro del grid (0 a gridDim-1)
     * blockDim.x/y/z  : Número de threads por bloque en cada dimensión
     * gridDim.x/y/z   : Número de bloques en el grid en cada dimensión
     */

    int globalIdx = blockIdx.x * blockDim.x + threadIdx.x;

    printf("Thread Global=%d | Bloque=%d Thread=%d | blockDim=%d gridDim=%d\n",
           globalIdx,
           blockIdx.x,
           threadIdx.x,
           blockDim.x,
           gridDim.x);
}

/**
 * KERNEL: Demostrar organización 2D
 */
__global__ void mostrarInfo2D() {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int y = blockIdx.y * blockDim.y + threadIdx.y;

    printf("Posición 2D: (%d,%d) | Bloque=(%d,%d) Thread=(%d,%d)\n",
           x, y,
           blockIdx.x, blockIdx.y,
           threadIdx.x, threadIdx.y);
}

/**
 * Función para mostrar todas las propiedades del dispositivo
 */
void mostrarPropiedadesCompletas(int deviceId) {
    cudaDeviceProp prop;
    CUDA_CHECK(cudaGetDeviceProperties(&prop, deviceId));

    printf("\n╔══════════════════════════════════════════════════════════╗\n");
    printf("║         PROPIEDADES DEL DISPOSITIVO %d                    ║\n", deviceId);
    printf("╚══════════════════════════════════════════════════════════╝\n");

    // INFORMACIÓN GENERAL
    printf("\n📋 INFORMACIÓN GENERAL:\n");
    printf("   Nombre: %s\n", prop.name);
    printf("   Compute Capability: %d.%d\n", prop.major, prop.minor);
    printf("   Clock Rate: %.2f GHz\n", prop.clockRate / 1e6);
    printf("   Número de multiprocesadores (SM): %d\n", prop.multiProcessorCount);

    // MEMORIA
    printf("\n💾 MEMORIA:\n");
    printf("   Memoria Global Total: %.2f GB\n",
           prop.totalGlobalMem / 1024.0 / 1024.0 / 1024.0);
    printf("   Memoria Compartida por Bloque: %.2f KB\n",
           prop.sharedMemPerBlock / 1024.0);
    printf("   Memoria Constante: %.2f KB\n",
           prop.totalConstMem / 1024.0);
    printf("   Tamaño de L2 Cache: %.2f MB\n",
           prop.l2CacheSize / 1024.0 / 1024.0);
    printf("   Registros por Bloque: %d\n", prop.regsPerBlock);

    // LÍMITES DE THREADS
    printf("\n🧵 LÍMITES DE THREADS:\n");
    printf("   Threads máximos por bloque: %d\n", prop.maxThreadsPerBlock);
    printf("   Dimensiones máximas del bloque: (%d, %d, %d)\n",
           prop.maxThreadsDim[0], prop.maxThreadsDim[1], prop.maxThreadsDim[2]);
    printf("   Dimensiones máximas del grid: (%d, %d, %d)\n",
           prop.maxGridSize[0], prop.maxGridSize[1], prop.maxGridSize[2]);
    printf("   Warp size: %d threads\n", prop.warpSize);

    // CARACTERÍSTICAS DE MEMORIA
    printf("\n⚡ CARACTERÍSTICAS DE MEMORIA:\n");
    printf("   Ancho de bus de memoria: %d bits\n", prop.memoryBusWidth);
    printf("   Clock de memoria: %.2f GHz\n", prop.memoryClockRate / 1e6);
    printf("   ECC habilitado: %s\n", prop.ECCEnabled ? "Sí" : "No");

    // CAPACIDADES ESPECIALES
    printf("\n🎯 CAPACIDADES:\n");
    printf("   Concurrent Kernels: %s\n",
           prop.concurrentKernels ? "Sí" : "No");
    printf("   Unified Addressing: %s\n",
           prop.unifiedAddressing ? "Sí" : "No");
    printf("   Managed Memory: %s\n",
           prop.managedMemory ? "Sí" : "No");

    // CÁLCULOS DERIVADOS ÚTILES
    printf("\n📊 CÁLCULOS ÚTILES:\n");
    int coresPerSM = 0;
    // Aproximación de cores por SM según Compute Capability
    if (prop.major == 2) coresPerSM = 32;
    else if (prop.major == 3) coresPerSM = 192;
    else if (prop.major == 5) coresPerSM = 128;
    else if (prop.major == 6) {
        coresPerSM = (prop.minor == 0) ? 64 : 128;
    } else if (prop.major == 7) coresPerSM = 64;
    else if (prop.major == 8) coresPerSM = (prop.minor == 0) ? 64 : 128;

    if (coresPerSM > 0) {
        printf("   Cores CUDA totales (aprox): %d\n",
               coresPerSM * prop.multiProcessorCount);
    }

    printf("   Occupancy máximo: %d bloques concurrentes por SM\n",
           prop.maxThreadsPerMultiProcessor / prop.maxThreadsPerBlock);

    printf("   Ancho de banda teórico: %.2f GB/s\n",
           2.0 * prop.memoryClockRate * (prop.memoryBusWidth / 8) / 1.0e6);
}

/**
 * Función para seleccionar el mejor dispositivo
 */
int seleccionarMejorDispositivo() {
    int deviceCount;
    CUDA_CHECK(cudaGetDeviceCount(&deviceCount));

    if (deviceCount == 0) {
        fprintf(stderr, "No se encontraron dispositivos CUDA\n");
        return -1;
    }

    printf("\n🔍 SELECCIONANDO EL MEJOR DISPOSITIVO:\n");
    printf("   Dispositivos encontrados: %d\n\n", deviceCount);

    int mejorDispositivo = 0;
    int mejorScore = 0;

    for (int i = 0; i < deviceCount; i++) {
        cudaDeviceProp prop;
        CUDA_CHECK(cudaGetDeviceProperties(&prop, i));

        // Calcular un "score" simple basado en varias características
        int score = prop.multiProcessorCount * 100 +
                    prop.major * 10 +
                    (prop.totalGlobalMem / (1024 * 1024 * 1024));

        printf("   Dispositivo %d: %s\n", i, prop.name);
        printf("      Score: %d (SM=%d, CC=%d.%d, Mem=%.1fGB)\n",
               score, prop.multiProcessorCount, prop.major, prop.minor,
               prop.totalGlobalMem / 1024.0 / 1024.0 / 1024.0);

        if (score > mejorScore) {
            mejorScore = score;
            mejorDispositivo = i;
        }
    }

    printf("\n   ✓ Mejor dispositivo: %d (score=%d)\n", mejorDispositivo, mejorScore);

    return mejorDispositivo;
}

/**
 * Función para demostrar la organización de threads
 */
void demostrarOrganizacionThreads() {
    printf("\n\n╔══════════════════════════════════════════════════════════╗\n");
    printf("║         DEMOSTRACIÓN DE ORGANIZACIÓN DE THREADS         ║\n");
    printf("╚══════════════════════════════════════════════════════════╝\n");

    printf("\n📐 EJEMPLO 1D: 2 bloques de 4 threads\n");
    printf("─────────────────────────────────────\n");
    mostrarInfoThreads<<<2, 4>>>();
    cudaDeviceSynchronize();

    printf("\n📐 EJEMPLO 2D: Grid(2,2) de Bloques(2,2)\n");
    printf("─────────────────────────────────────\n");
    dim3 grid2D(2, 2);    // 2x2 bloques
    dim3 block2D(2, 2);   // 2x2 threads por bloque
    mostrarInfo2D<<<grid2D, block2D>>>();
    cudaDeviceSynchronize();
}

/**
 * Función para mostrar recomendaciones basadas en el hardware
 */
void mostrarRecomendaciones(cudaDeviceProp prop) {
    printf("\n\n╔══════════════════════════════════════════════════════════╗\n");
    printf("║              RECOMENDACIONES PARA TU GPU                ║\n");
    printf("╚══════════════════════════════════════════════════════════╝\n");

    printf("\n💡 THREADS POR BLOQUE:\n");
    printf("   Múltiplo del warp size (%d): Sí, siempre usa múltiplos de %d\n",
           prop.warpSize, prop.warpSize);
    printf("   Valores comunes buenos: 128, 256, 512\n");
    printf("   Máximo permitido: %d\n", prop.maxThreadsPerBlock);

    printf("\n💡 MEMORIA COMPARTIDA:\n");
    printf("   Disponible por bloque: %.2f KB\n", prop.sharedMemPerBlock / 1024.0);
    printf("   Recomendación: Usa memoria compartida para datos que se reutilizan\n");

    printf("\n💡 OCCUPANCY:\n");
    int threadsRecomendados = 256;
    int bloquesSimultaneos = prop.maxThreadsPerMultiProcessor / threadsRecomendados;
    printf("   Con %d threads/bloque: ~%d bloques por SM\n",
           threadsRecomendados, bloquesSimultaneos);
    printf("   Recomendación: Experimenta con 128-512 threads/bloque\n");

    printf("\n💡 GRID SIZE:\n");
    printf("   Recomendación: Usa al menos %d bloques para saturar la GPU\n",
           prop.multiProcessorCount * 2);
}

int main() {
    printf("╔════════════════════════════════════════════════════════════╗\n");
    printf("║     EJEMPLO 4: PROPIEDADES Y ORGANIZACIÓN DE THREADS      ║\n");
    printf("╚════════════════════════════════════════════════════════════╝\n");

    // Seleccionar el mejor dispositivo
    int deviceId = seleccionarMejorDispositivo();

    if (deviceId >= 0) {
        CUDA_CHECK(cudaSetDevice(deviceId));

        // Mostrar todas las propiedades
        mostrarPropiedadesCompletas(deviceId);

        // Demostrar organización de threads
        demostrarOrganizacionThreads();

        // Mostrar recomendaciones
        cudaDeviceProp prop;
        CUDA_CHECK(cudaGetDeviceProperties(&prop, deviceId));
        mostrarRecomendaciones(prop);
    }

    printf("\n\n═══════════════════════════════════════════════════════════\n");
    printf("                     FIN DEL EJEMPLO\n");
    printf("═══════════════════════════════════════════════════════════\n");

    return 0;
}

/**
 * CONCEPTOS CLAVE PARA RECORDAR:
 *
 * 1. WARP: Grupo de 32 threads que se ejecutan en lockstep
 *    - Siempre usa múltiplos de 32 threads
 *
 * 2. STREAMING MULTIPROCESSOR (SM):
 *    - Unidad de ejecución en la GPU
 *    - Más SM = más paralelismo
 *
 * 3. COMPUTE CAPABILITY:
 *    - Versión de la arquitectura (ej: 7.5, 8.0, 8.6)
 *    - Mayor número = más características
 *
 * 4. OCCUPANCY:
 *    - Porcentaje de recursos de SM utilizados
 *    - Mayor occupancy generalmente = mejor rendimiento
 *
 * 5. THREADS POR BLOQUE:
 *    - Típicamente: 128, 256, o 512
 *    - Debe ser múltiplo de 32
 *    - Afecta uso de registros y memoria compartida
 *
 * EJERCICIO:
 *
 * 1. Ejecuta este programa en tu GPU
 * 2. Anota las propiedades clave de tu hardware
 * 3. Modifica los ejemplos anteriores para usar configuraciones
 *    óptimas basadas en tu GPU
 */
