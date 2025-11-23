/**
 * EJEMPLO 1: Hola CUDA - Tu primer programa CUDA
 *
 * Este ejemplo demuestra:
 * - Estructura básica de un programa CUDA
 * - Cómo definir un kernel (función que corre en GPU)
 * - Cómo lanzar un kernel
 * - Sincronización entre CPU y GPU
 *
 * Para compilar: nvcc ejemplo_01_hola_cuda.cu -o ejemplo_01
 * Para ejecutar: ./ejemplo_01
 */

#include <stdio.h>
#include <cuda_runtime.h>

/**
 * KERNEL: Función que se ejecuta en la GPU
 *
 * Notas importantes:
 * - __global__ indica que esta función es un kernel
 * - Se ejecuta en el device (GPU)
 * - Se puede llamar desde el host (CPU)
 * - Debe devolver void
 */
__global__ void holaMundoKernel() {
    // Esta función se ejecutará en la GPU
    printf("¡Hola desde el thread GPU!\n");
}

int main() {
    printf("=== EJEMPLO 1: Hola CUDA ===\n\n");

    printf("1. Mensaje desde CPU (host):\n");
    printf("   ¡Hola desde la CPU!\n\n");

    printf("2. Lanzando kernel en GPU...\n");

    /**
     * LANZAMIENTO DEL KERNEL
     *
     * Sintaxis: nombreKernel<<<numBlocks, numThreadsPerBlock>>>(argumentos);
     *
     * - numBlocks: número de bloques de threads
     * - numThreadsPerBlock: número de threads por bloque
     *
     * En este caso:
     * - 1 bloque
     * - 1 thread por bloque
     * - Total: 1 thread
     */
    holaMundoKernel<<<1, 1>>>();

    /**
     * SINCRONIZACIÓN
     *
     * cudaDeviceSynchronize() espera a que todos los kernels terminen
     * Es importante porque:
     * - Los kernels se lanzan de forma asíncrona
     * - El CPU continúa ejecutando sin esperar
     * - Necesitamos sincronizar para ver los resultados
     */
    cudaDeviceSynchronize();

    printf("\n3. Kernel completado!\n");

    printf("\n=== FIN DEL EJEMPLO ===\n");

    return 0;
}

/**
 * PUNTOS CLAVE PARA RECORDAR:
 *
 * 1. __global__ = función que corre en GPU, llamada desde CPU
 * 2. <<<...>>> = sintaxis para lanzar kernel (configuración de ejecución)
 * 3. cudaDeviceSynchronize() = esperar a que GPU termine
 * 4. Los kernels se ejecutan de forma asíncrona
 *
 * PRÓXIMO PASO:
 * Modifica este ejemplo para lanzar:
 * - holaMundoKernel<<<2, 3>>>(); // 2 bloques, 3 threads cada uno
 *
 * ¿Cuántos mensajes verás? ¿Por qué?
 */
