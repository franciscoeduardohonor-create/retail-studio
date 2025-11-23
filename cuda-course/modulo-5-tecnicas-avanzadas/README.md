# Módulo 5: Técnicas Avanzadas

## Objetivos de Aprendizaje
- Usar operaciones a nivel de warp (warp-level primitives)
- Implementar dynamic parallelism
- Programación multi-GPU
- Usar bibliotecas CUDA (Thrust, CUB, cuBLAS)
- Técnicas avanzadas de debugging y profiling

## Contenido

### 5.1 Operaciones a Nivel de Warp

Los **warps** son grupos de 32 threads que se ejecutan en sincronía. CUDA provee operaciones especiales:

```cpp
// Shuffle: Intercambiar datos entre threads de un warp
__shfl_sync(mask, var, srcLane)
__shfl_down_sync(mask, var, delta)
__shfl_up_sync(mask, var, delta)
__shfl_xor_sync(mask, var, laneMask)

// Vote: Operaciones de consenso
__all_sync(mask, predicate)
__any_sync(mask, predicate)
__ballot_sync(mask, predicate)

// Match: Comparación
__match_any_sync(mask, value)
__match_all_sync(mask, value, &pred)
```

**Ventajas:**
- No usa shared memory
- Muy rápido (1 ciclo)
- Reduce presión en memoria

### 5.2 Dynamic Parallelism

Permite que kernels lancen otros kernels:

```cpp
__global__ void parentKernel() {
    // Lanzar kernel hijo desde GPU
    childKernel<<<grid, block>>>(...);
    cudaDeviceSynchronize();
}
```

**Aplicaciones:**
- Algoritmos recursivos (quicksort, tree traversal)
- Generación de trabajo adaptativa
- Simplificar código complejo

### 5.3 Multi-GPU

Estrategias para usar múltiples GPUs:

```cpp
// Seleccionar GPU
cudaSetDevice(gpuId);

// Peer-to-peer entre GPUs
cudaDeviceEnablePeerAccess(peerDevice, 0);
cudaMemcpyPeer(dst, dstDevice, src, srcDevice, size);
```

**Patrones comunes:**
- Data parallelism: Dividir datos entre GPUs
- Model parallelism: Dividir modelo entre GPUs
- Pipeline parallelism: Diferentes etapas en diferentes GPUs

### 5.4 Bibliotecas CUDA

#### Thrust (STL para CUDA)
```cpp
#include <thrust/device_vector.h>
#include <thrust/sort.h>
#include <thrust/reduce.h>

thrust::device_vector<float> d_vec(1000);
thrust::sort(d_vec.begin(), d_vec.end());
float sum = thrust::reduce(d_vec.begin(), d_vec.end());
```

#### CUB (CUDA Unbound)
```cpp
#include <cub/cub.cuh>

// Reducción optimizada
cub::DeviceReduce::Sum(d_temp, temp_bytes, d_in, d_out, num_items);
```

#### cuBLAS (Álgebra Lineal)
```cpp
// Multiplicación de matrices optimizada
cublasSgemm(handle, CUBLAS_OP_N, CUBLAS_OP_N,
            m, n, k, &alpha, A, lda, B, ldb, &beta, C, ldc);
```

#### cuDNN (Deep Learning)
- Operaciones de redes neuronales optimizadas
- Convoluciones, pooling, activaciones
- Usado por TensorFlow, PyTorch

### 5.5 Debugging y Profiling Avanzado

#### cuda-memcheck
```bash
cuda-memcheck ./programa
```
Detecta:
- Accesos fuera de límites
- Races conditions
- Memory leaks

#### NVIDIA Nsight Systems
```bash
nsys profile -o output ./programa
```
Análisis de:
- Timeline de ejecución
- Uso de CPU y GPU
- Transferencias de memoria

#### NVIDIA Nsight Compute
```bash
ncu -o output ./programa
```
Análisis detallado de:
- Métricas de kernels
- Occupancy
- Memory throughput
- Roofline analysis

### 5.6 Técnicas Avanzadas

1. **Cooperative Groups**: Sincronización flexible
2. **Graph API**: Capturar y reusar flujos de trabajo
3. **Tensor Cores**: Aceleración para ML (FP16/INT8)
4. **CUDA Graphs**: Reducir overhead de lanzamiento
5. **Multi-Process Service (MPS)**: Compartir GPU entre procesos

## Ejemplos en este Módulo

1. **ejemplo_01_warp_primitives.cu** - Operaciones warp shuffle
2. **ejemplo_02_dynamic_parallelism.cu** - Kernels que lanzan kernels
3. **ejemplo_03_thrust.cu** - Uso de biblioteca Thrust
4. **ejemplo_04_multi_gpu.cu** - Programación multi-GPU

## Recursos Adicionales

- **Documentación CUDA**: https://docs.nvidia.com/cuda/
- **CUDA Samples**: Ejemplos oficiales de NVIDIA
- **GPU Gems**: Técnicas avanzadas de GPU
- **Parallel Forall Blog**: Blog técnico de NVIDIA

## Proyecto Final Sugerido

Implementa una aplicación completa que combine varias técnicas:
- Procesamiento de imágenes (filtros, convoluciones)
- Simulación física (N-body, fluidos)
- Machine Learning (red neuronal simple)
- Análisis de datos (estadísticas, clustering)

Aplica:
- Múltiples kernels optimizados
- Streams para concurrencia
- Shared memory
- Profiling y optimización
- Manejo de errores robusto
