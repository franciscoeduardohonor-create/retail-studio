# Módulo 2: Listas Enlazadas (Linked Lists)

## 🎯 Objetivos
- Comprender la estructura de listas enlazadas
- Implementar listas simples, dobles y circulares
- Dominar operaciones básicas y avanzadas
- Comparar con arrays

## 📖 ¿Qué es una Lista Enlazada?

Una **lista enlazada** es una estructura de datos lineal donde los elementos no están almacenados en posiciones contiguas de memoria. Cada elemento (nodo) contiene:
- **Dato**: El valor almacenado
- **Puntero(s)**: Referencia al siguiente nodo (y anterior en listas dobles)

### Representación Visual

```
Lista Simple:
[Dato|Next] -> [Dato|Next] -> [Dato|Next] -> NULL

Lista Doble:
NULL <- [Prev|Dato|Next] <-> [Prev|Dato|Next] <-> [Prev|Dato|Next] -> NULL

Lista Circular:
[Dato|Next] -> [Dato|Next] -> [Dato|Next] -|
     ^                                      |
     |______________________________________|
```

## 📊 Tipos de Listas Enlazadas

### 1. Lista Simplemente Enlazada
- Cada nodo apunta solo al siguiente
- Recorrido en una sola dirección
- Más eficiente en memoria

### 2. Lista Doblemente Enlazada
- Cada nodo apunta al siguiente Y al anterior
- Recorrido bidireccional
- Mayor flexibilidad, más memoria

### 3. Lista Circular
- El último nodo apunta al primero
- No hay NULL al final
- Útil para buffers circulares

## ⏱️ Complejidad de Operaciones

| Operación | Lista Enlazada | Array |
|-----------|----------------|-------|
| Acceso por índice | O(n) | O(1) |
| Búsqueda | O(n) | O(n) |
| Inserción al inicio | O(1) | O(n) |
| Inserción al final | O(n) o O(1)* | O(1) |
| Inserción en medio | O(n) | O(n) |
| Eliminación | O(n) | O(n) |

*O(1) si mantenemos puntero al final

## 💡 Ventajas vs Arrays

### Ventajas ✅
- **Inserción/eliminación eficiente** al inicio: O(1)
- **Tamaño dinámico**: Crece según necesidad
- **No desperdicia memoria**: Solo usa lo necesario
- **Fácil reorganización**: Solo cambiar punteros

### Desventajas ❌
- **Acceso lento** por índice: O(n)
- **Memoria extra** para punteros
- **No cache-friendly**: Memoria no contigua
- **Recorrido solo secuencial**

## 🔍 Estructura Básica del Nodo

```cpp
// Nodo de lista simple
struct Nodo {
    int dato;
    Nodo* siguiente;
};

// Nodo de lista doble
struct NodoDoble {
    int dato;
    NodoDoble* siguiente;
    NodoDoble* anterior;
};
```

## 🎯 Operaciones Fundamentales

### 1. Inserción
- Al inicio: O(1)
- Al final: O(n) sin tail pointer
- En posición específica: O(n)

### 2. Eliminación
- Al inicio: O(1)
- Al final: O(n) en lista simple
- Nodo específico: O(n)

### 3. Búsqueda
- Siempre O(n)
- Recorrido secuencial

### 4. Recorrido
- O(n) para visitar todos los nodos

## 🚀 Casos de Uso

### Cuándo usar Listas Enlazadas:
- Inserciones/eliminaciones frecuentes al inicio
- Tamaño impredecible de datos
- Implementar pilas, colas, grafos
- No necesitas acceso aleatorio

### Cuándo usar Arrays:
- Acceso frecuente por índice
- Tamaño conocido y fijo
- Operaciones matemáticas sobre datos
- Mejor rendimiento de cache

## 📝 Conceptos Importantes

### 1. Head (Cabeza)
- Primer nodo de la lista
- Punto de entrada principal

### 2. Tail (Cola)
- Último nodo de la lista
- Opcional pero útil

### 3. NULL/nullptr
- Indica fin de la lista
- Importante para evitar loops infinitos

### 4. Memoria Dinámica
- Usar `new` para crear nodos
- Usar `delete` para liberar memoria
- Evitar memory leaks

## ⚠️ Problemas Comunes

1. **Memory Leaks**: No liberar memoria
2. **Null Pointer**: Acceder a puntero NULL
3. **Loops Infinitos**: No actualizar punteros correctamente
4. **Lost References**: Perder referencia a nodos

## 🎓 Lo que Aprenderás

En este módulo verás:
- Implementación completa de listas simples
- Implementación de listas dobles
- Operaciones avanzadas (reversión, detección de ciclos)
- Ejercicios prácticos
- Comparación de rendimiento

¡Comencemos con los ejemplos de código!
