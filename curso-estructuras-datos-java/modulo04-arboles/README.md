# Módulo 4: Árboles

## 📚 Objetivos
- Comprender estructuras jerárquicas
- Implementar árboles binarios y BST
- Dominar recorridos (DFS, BFS)
- Entender balanceo (AVL, Heap)

## 📖 Conceptos Clave

### Árbol Binario
```
       10
      /  \
     5    15
    / \   / \
   3   7 12  20
```

**Propiedades:**
- Cada nodo tiene máximo 2 hijos
- Raíz: nodo superior
- Hojas: nodos sin hijos
- Altura: distancia máxima raíz-hoja

### Árbol Binario de Búsqueda (BST)
```
Propiedad BST:
- Izquierda < Raíz < Derecha
```

**Operaciones:**
- Búsqueda: O(h) donde h = altura
- Inserción: O(h)
- Eliminación: O(h)
- En árbol balanceado: h = log n

### Recorridos

**1. DFS (Depth-First Search):**
- **Pre-orden**: Raíz → Izq → Der (uso: copiar árbol)
- **In-orden**: Izq → Raíz → Der (uso: ordenar BST)
- **Post-orden**: Izq → Der → Raíz (uso: eliminar árbol)

**2. BFS (Breadth-First Search):**
- Por niveles (uso: encontrar nivel, árbol mínimo)

### Árbol AVL
BST auto-balanceado:
- Factor de balance: altura_izq - altura_der ∈ {-1, 0, 1}
- Rotaciones: Simple y Doble
- Búsqueda garantizada: O(log n)

### Heap (Montículo)
Árbol binario completo:
- **Max Heap**: padre ≥ hijos
- **Min Heap**: padre ≤ hijos
- Uso: colas de prioridad, HeapSort

## 🎯 Aplicaciones
- Sistemas de archivos
- Bases de datos (índices B-Tree)
- Compresión (Huffman Coding)
- Autocompletado (Trie)
- Expresiones aritméticas

## 📂 Ejemplos
1. `ArbolBinario.java` - Implementación básica
2. `BST.java` - Árbol binario de búsqueda
3. `Recorridos.java` - DFS y BFS

## 🔥 Problemas Clásicos
- Validar BST
- Altura del árbol
- Mínimo ancestro común
- Diámetro del árbol
- Convertir array a BST balanceado
