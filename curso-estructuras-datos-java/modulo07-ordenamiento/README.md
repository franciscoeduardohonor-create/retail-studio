# Módulo 7: Algoritmos de Ordenamiento

## 📚 Objetivos
- Implementar algoritmos de ordenamiento
- Comparar eficiencias
- Entender estabilidad
- Elegir el algoritmo apropiado

## 📖 Algoritmos

### Comparación Rápida

| Algoritmo | Tiempo Promedio | Peor Caso | Espacio | Estable |
|-----------|----------------|-----------|---------|---------|
| Bubble Sort | O(n²) | O(n²) | O(1) | Sí |
| Selection Sort | O(n²) | O(n²) | O(1) | No |
| Insertion Sort | O(n²) | O(n²) | O(1) | Sí |
| Merge Sort | O(n log n) | O(n log n) | O(n) | Sí |
| Quick Sort | O(n log n) | O(n²) | O(log n) | No |
| Heap Sort | O(n log n) | O(n log n) | O(1) | No |

### Algoritmos Simples O(n²)

**1. Bubble Sort**
- Compara pares adyacentes
- Burbujea el mayor al final
- Simple pero lento

**2. Selection Sort**
- Selecciona el mínimo
- Lo coloca al inicio
- Menos intercambios que bubble

**3. Insertion Sort**
- Inserta en posición correcta
- Eficiente para datos casi ordenados
- Mejor que bubble y selection

### Algoritmos Eficientes O(n log n)

**1. Merge Sort**
- Divide y conquista
- Siempre O(n log n)
- Estable
- Requiere O(n) espacio

**2. Quick Sort**
- Divide usando pivote
- Promedio O(n log n)
- In-place
- No estable
- Usado en la práctica

**3. Heap Sort**
- Usa heap (montículo)
- Garantiza O(n log n)
- In-place
- No estable

### Algoritmos Especializados

**Counting Sort: O(n + k)**
- Solo para enteros en rango
- No es comparación
- Muy rápido para rango pequeño

**Radix Sort: O(d × n)**
- Ordena por dígitos
- Bueno para números grandes
- d = número de dígitos

## 🎯 ¿Cuál Usar?

```
Datos pequeños (n < 50):
→ Insertion Sort

Datos casi ordenados:
→ Insertion Sort

Necesitas estabilidad:
→ Merge Sort

Quieres el más rápido promedio:
→ Quick Sort

Memoria limitada:
→ Heap Sort o Quick Sort

Rango pequeño de enteros:
→ Counting Sort
```

## 📂 Ejemplos
1. `AlgoritmosSimples.java` - Bubble, Selection, Insertion
2. `AlgoritmosAvanzados.java` - Merge, Quick, Heap
3. `Comparacion.java` - Benchmark de algoritmos

## 🔥 Conceptos Clave
- **Estabilidad**: Preserva orden de elementos iguales
- **In-place**: No requiere espacio extra
- **Adaptativo**: Mejor con datos casi ordenados
- **Divide y conquista**: Divide problema en subproblemas
