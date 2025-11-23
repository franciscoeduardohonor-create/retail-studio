# Módulo 4: Técnicas Intermedias

## Objetivos de Aprendizaje
- Implementar algoritmos de reducción paralela
- Usar streams para ejecución concurrente
- Implementar scan (prefix sum)
- Trabajar con eventos para timing
- Usar callbacks y paginación

## Contenido

### 4.1 Reducción Paralela

La **reducción** es un patrón común donde se combina un array en un solo valor:
- Suma de todos los elementos
- Valor máximo/mínimo
- Producto de elementos
- Operaciones lógicas (AND, OR)

**Estrategia:** Reducción en árbol usando shared memory

```
Iteración 0: [1, 2, 3, 4, 5, 6, 7, 8]
Iteración 1: [3, 7, 11, 15]  (pares sumados)
Iteración 2: [10, 26]         (pares sumados)
Iteración 3: [36]             (resultado final)
```

### 4.2 Streams

Los **streams** permiten ejecutar operaciones concurrentemente:

```
Stream 0: [Kernel A] → [Kernel B] → [Copy C]
Stream 1:     [Kernel D] → [Copy E]
Stream 2:         [Kernel F] → [Kernel G]
```

Ventajas:
- Ocultar latencia de transferencias
- Ejecutar múltiples kernels simultáneamente
- Mejor utilización de GPU

### 4.3 Scan (Prefix Sum)

**Scan** calcula sumas acumuladas: `output[i] = sum(input[0..i])`

```
Input:  [1, 2, 3, 4, 5]
Output: [1, 3, 6, 10, 15]  (inclusive scan)
Output: [0, 1, 3, 6, 10]   (exclusive scan)
```

Aplicaciones:
- Compactación de arrays
- Ordenamiento radix
- Asignación de memoria dinámica
- Procesamiento de imágenes

### 4.4 Patrones Comunes

1. **Map**: Transformar cada elemento
2. **Reduce**: Combinar elementos
3. **Scan**: Sumas acumuladas
4. **Scatter/Gather**: Reorganizar datos
5. **Stencil**: Operaciones con vecinos

## Ejemplos en este Módulo

1. **ejemplo_01_reduccion.cu** - Reducción paralela optimizada
2. **ejemplo_02_streams.cu** - Uso de streams para concurrencia
3. **ejemplo_03_scan.cu** - Implementación de prefix sum
4. **ejemplo_04_histogram.cu** - Histograma paralelo

## Próximo Módulo

En el Módulo 5 aprenderás técnicas avanzadas como operaciones a nivel de warp, dynamic parallelism, y programación multi-GPU.
