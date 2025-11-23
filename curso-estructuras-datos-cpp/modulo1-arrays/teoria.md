# Módulo 1: Fundamentos y Arrays

## 🎯 Objetivos
- Entender qué son las estructuras de datos
- Dominar el uso de arrays en C++
- Conocer arrays estáticos y dinámicos
- Aprender operaciones básicas

## 📖 ¿Qué son las Estructuras de Datos?

Las estructuras de datos son formas de organizar y almacenar datos para que puedan ser accedidos y modificados eficientemente.

### Importancia
- Optimización de algoritmos
- Uso eficiente de memoria
- Mejor rendimiento de aplicaciones

## 📊 Arrays (Arreglos)

Un **array** es una colección de elementos del mismo tipo almacenados en posiciones contiguas de memoria.

### Características
- **Acceso directo**: O(1) - acceso por índice
- **Tamaño fijo** (arrays estáticos)
- **Memoria contigua**: elementos uno tras otro

### Arrays Estáticos vs Dinámicos

#### Arrays Estáticos
```cpp
int arr[5];  // Tamaño fijo de 5 elementos
```

#### Arrays Dinámicos
```cpp
int* arr = new int[n];  // Tamaño variable
// Importante: liberar memoria
delete[] arr;
```

## ⏱️ Complejidad de Operaciones

| Operación | Complejidad |
|-----------|-------------|
| Acceso    | O(1)        |
| Búsqueda  | O(n)        |
| Inserción al final | O(1) |
| Inserción al inicio | O(n) |
| Eliminación | O(n) |

## 🔍 Operaciones Básicas

1. **Acceso**: Obtener elemento en posición i
2. **Búsqueda**: Encontrar un elemento
3. **Inserción**: Agregar un nuevo elemento
4. **Eliminación**: Remover un elemento
5. **Recorrido**: Visitar todos los elementos

## 💡 Ventajas y Desventajas

### Ventajas ✅
- Acceso rápido por índice
- Fácil de implementar
- Eficiente en memoria (sin overhead)

### Desventajas ❌
- Tamaño fijo (arrays estáticos)
- Inserción/eliminación costosa
- Desperdicio de memoria si no se usa completamente

## 📝 Próximos Pasos

Revisa los ejemplos de código y realiza los ejercicios para practicar.
