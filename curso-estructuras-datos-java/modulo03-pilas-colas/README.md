# Módulo 3: Pilas y Colas

## 📚 Objetivos de Aprendizaje
- Entender las estructuras LIFO (Last In, First Out) y FIFO (First In, First Out)
- Implementar Pilas (Stack) y Colas (Queue) desde cero
- Aplicar pilas y colas en problemas reales
- Dominar las operaciones fundamentales: push, pop, peek

## 📖 Contenido Teórico

### Pilas (Stack) - LIFO

Una **pila** es como una pila de platos: el último en entrar es el primero en salir.

```
       │ 30 │ <- Top (último agregado, primero en salir)
       │ 20 │
       │ 10 │
       └────┘
```

**Operaciones principales:**
- `push(elemento)` - Agregar al tope: O(1)
- `pop()` - Quitar del tope: O(1)
- `peek()` - Ver el tope sin quitar: O(1)
- `isEmpty()` - Verificar si está vacía: O(1)

### Colas (Queue) - FIFO

Una **cola** es como una fila de personas: el primero en entrar es el primero en salir.

```
FRONT                           REAR
[10] <- [20] <- [30] <- [40]
 ↑                        ↑
sale                   entra
```

**Operaciones principales:**
- `enqueue(elemento)` - Agregar al final: O(1)
- `dequeue()` - Quitar del frente: O(1)
- `peek()` - Ver el frente sin quitar: O(1)
- `isEmpty()` - Verificar si está vacía: O(1)

### Implementaciones

| Implementación | Ventajas | Desventajas |
|---------------|----------|-------------|
| Con Array | Simple, rápida | Tamaño fijo |
| Con ArrayList | Dinámica | Puede desperdiciar memoria |
| Con Lista Enlazada | Eficiente en memoria | Overhead de punteros |

## 🎯 Aplicaciones Reales

### Pilas (Stack):
- **Deshacer/Rehacer** en editores de texto
- **Navegación del navegador** (historial atrás/adelante)
- **Evaluación de expresiones** matemáticas
- **Llamadas a funciones** (call stack)
- **Validación de paréntesis/llaves**
- **Backtracking** en algoritmos

### Colas (Queue):
- **Cola de impresión** de documentos
- **Gestión de procesos** en sistemas operativos
- **Manejo de peticiones** en servidores
- **BFS (Breadth-First Search)** en grafos
- **Buffer de datos** en streaming
- **Simulación de eventos**

## 📂 Ejemplos Prácticos

1. `PilaConArray.java` - Implementación con array
2. `ColaConLista.java` - Implementación con lista enlazada
3. `Aplicaciones.java` - Validar paréntesis, evaluar expresiones

## ✏️ Ejercicios

1. Implementar pila con mínimo en O(1)
2. Implementar cola usando dos pilas
3. Validar paréntesis balanceados
4. Evaluar notación postfija (RPN)

## 🔥 Problemas Clásicos

- Validar paréntesis balanceados
- Siguiente elemento mayor (Next Greater Element)
- Cola circular
- Implementar pila con dos colas
- Ordenar una pila
