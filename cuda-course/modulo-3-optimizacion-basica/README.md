# Módulo 3: Optimización Básica

## Objetivos de Aprendizaje
- Entender memory coalescing y cómo optimizar accesos a memoria
- Evitar bank conflicts en shared memory
- Optimizar occupancy
- Usar herramientas de profiling
- Aplicar técnicas de tiling

## Contenido

### 3.1 Memory Coalescing

**Concepto clave:** Los accesos a global memory son más eficientes cuando threads consecutivos acceden a direcciones consecutivas.

```
ACCESO COALESCENTE (RÁPIDO):
Thread 0 → Address 0
Thread 1 → Address 4
Thread 2 → Address 8
Thread 3 → Address 12
...
[Se completa en 1 transacción]

ACCESO NO-COALESCENTE (LENTO):
Thread 0 → Address 0
Thread 1 → Address 128
Thread 2 → Address 256
Thread 3 → Address 384
...
[Requiere múltiples transacciones]
```

### 3.2 Bank Conflicts en Shared Memory

La shared memory está organizada en **32 banks**. Accesos simultáneos al mismo bank causan serialización.

```
SIN CONFLICTO:
Thread 0 → Bank 0
Thread 1 → Bank 1
Thread 2 → Bank 2
...

CON CONFLICTO:
Thread 0 → Bank 0
Thread 1 → Bank 0  ← Conflicto!
Thread 2 → Bank 0  ← Conflicto!
```

### 3.3 Occupancy

**Occupancy** = (Warps activos) / (Warps máximos posibles)

Factores que lo limitan:
- Threads por bloque
- Registros por thread
- Shared memory por bloque

### 3.4 Principios de Optimización

1. **Maximizar uso de ancho de banda**: Memory coalescing
2. **Minimizar latencia**: Usar shared memory, constant memory
3. **Maximizar paralelismo**: Buen occupancy, suficientes bloques
4. **Minimizar divergencia**: Evitar branching desigual en warps
5. **Optimizar instrucciones**: Usar operaciones rápidas

## Ejemplos en este Módulo

1. **ejemplo_01_memory_coalescing.cu** - Accesos coalescentes vs no-coalescentes
2. **ejemplo_02_bank_conflicts.cu** - Evitar bank conflicts
3. **ejemplo_03_matrix_multiply_optimizado.cu** - Multiplicación de matrices con tiling
4. **ejemplo_04_occupancy.cu** - Optimizar occupancy

## Herramientas de Profiling

- **nvprof**: Profiler de línea de comandos
- **NVIDIA Nsight**: IDE con profiler integrado
- **CUDA-MEMCHECK**: Detector de errores de memoria

## Próximo Módulo

En el Módulo 4 aprenderás técnicas intermedias como reducción paralela, scan (prefix sum), y uso de streams para concurrencia.
