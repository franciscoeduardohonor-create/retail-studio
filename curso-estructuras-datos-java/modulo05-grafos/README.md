# Módulo 5: Grafos

## 📚 Objetivos
- Entender representaciones de grafos
- Implementar BFS y DFS
- Aplicar algoritmos de caminos más cortos
- Resolver problemas de conectividad

## 📖 Conceptos

### Tipos de Grafos

**1. Dirigido vs No Dirigido**
```
Dirigido:        No Dirigido:
A → B            A — B
↓   ↓            |   |
C → D            C — D
```

**2. Ponderado vs No Ponderado**
```
Ponderado:       No Ponderado:
A -5→ B          A → B
↓3    ↓2         ↓   ↓
C -4→ D          C → D
```

### Representaciones

**1. Matriz de Adyacencia: O(V²) espacio**
```
  A B C D
A[0 1 1 0]
B[0 0 0 1]
C[0 0 0 1]
D[0 0 0 0]
```

**2. Lista de Adyacencia: O(V+E) espacio**
```
A → [B, C]
B → [D]
C → [D]
D → []
```

### Algoritmos Fundamentales

**BFS (Breadth-First Search):**
- Explora por niveles
- Usa cola (FIFO)
- Encuentra camino más corto (grafos no ponderados)
- O(V + E)

**DFS (Depth-First Search):**
- Explora en profundidad
- Usa pila (recursión o stack)
- Detecta ciclos
- Ordenamiento topológico
- O(V + E)

**Dijkstra:**
- Camino más corto en grafos ponderados
- No funciona con pesos negativos
- O((V + E) log V) con heap

## 🎯 Aplicaciones
- Redes sociales (conexiones)
- Mapas y GPS (rutas)
- Internet (routing)
- Dependencias (compiladores)
- Juegos (IA, pathfinding)

## 📂 Ejemplos
1. `GrafoBasico.java` - Implementación y representación
2. `BFS_DFS.java` - Recorridos
3. `CaminoMasCorto.java` - Dijkstra

## 🔥 Problemas
- Detectar ciclo
- Componentes conectados
- Camino más corto
- Ordenamiento topológico
- Puentes y puntos de articulación
