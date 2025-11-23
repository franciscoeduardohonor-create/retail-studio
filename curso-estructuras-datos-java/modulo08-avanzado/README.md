# Módulo 8: Algoritmos Avanzados

## 📚 Objetivos
- Dominar programación dinámica
- Aplicar algoritmos greedy
- Resolver problemas con backtracking
- Optimizar soluciones complejas

## 📖 Técnicas Fundamentales

### 1. Programación Dinámica (DP)

**Concepto:** Resolver problemas complejos dividiéndolos en subproblemas más simples y reutilizando soluciones.

**Características:**
- Sobreposición de subproblemas
- Subestructura óptima
- Memoización (top-down)
- Tabulación (bottom-up)

**Problemas Clásicos:**

1. **Fibonacci**
```
F(n) = F(n-1) + F(n-2)
```

2. **Problema de la Mochila (0/1 Knapsack)**
```
Capacidad limitada, maximizar valor
DP[i][w] = max(incluir, excluir)
```

3. **Subsecuencia Común más Larga (LCS)**
```
Encontrar mayor subsecuencia en común
```

4. **Caminos en Grid**
```
¿De cuántas formas llegar de (0,0) a (m,n)?
```

5. **Cambio de Monedas**
```
Mínimas monedas para dar cambio
```

### 2. Algoritmos Greedy (Voraces)

**Concepto:** Tomar decisión óptima local en cada paso.

**Cuándo funciona:**
- Propiedad greedy choice
- Subestructura óptima

**Problemas:**

1. **Cambio de Monedas (Greedy)**
```
Tomar siempre la moneda más grande posible
```

2. **Huffman Coding**
```
Compresión de datos
```

3. **Actividades (Activity Selection)**
```
Máximo número de actividades sin solapamiento
```

4. **Fractional Knapsack**
```
Puede tomar fracciones de items
```

### 3. Backtracking

**Concepto:** Exploración exhaustiva con poda.

**Estructura:**
```java
void backtrack(estado) {
    if (es_solucion(estado)) {
        procesar_solucion();
        return;
    }

    for (cada_opcion) {
        hacer_movimiento();
        backtrack(nuevo_estado);
        deshacer_movimiento();
    }
}
```

**Problemas:**

1. **N-Reinas**
```
Colocar N reinas sin atacarse
```

2. **Sudoku Solver**
```
Resolver sudoku con backtracking
```

3. **Generación de Subconjuntos**
```
Todos los subconjuntos de un conjunto
```

4. **Permutaciones**
```
Todas las permutaciones de un array
```

### 4. Divide y Vencerás

**Concepto:** Dividir → Resolver → Combinar

**Ejemplos:**
- Merge Sort
- Quick Sort
- Búsqueda Binaria
- Karatsuba (multiplicación)

## 📊 Comparación de Técnicas

| Técnica | Cuándo Usar | Complejidad Típica | Ejemplo |
|---------|-------------|-------------------|---------|
| DP | Subproblemas solapados | O(n²), O(n³) | Fibonacci, LCS |
| Greedy | Elección óptima local | O(n log n) | Huffman, Dijkstra |
| Backtracking | Exploración exhaustiva | O(2ⁿ), O(n!) | N-Reinas, Sudoku |
| Divide y Conquista | Problema divisible | O(n log n) | Merge Sort |

## 🎯 Problemas por Categoría

### Programación Dinámica
1. ✓ Fibonacci
2. ✓ Escaleras (Climbing Stairs)
3. ✓ Mochila 0/1
4. ✓ LCS (Longest Common Subsequence)
5. ✓ Edit Distance
6. ✓ Subset Sum
7. ✓ Longest Increasing Subsequence
8. ✓ Matrix Chain Multiplication

### Greedy
1. ✓ Activity Selection
2. ✓ Fractional Knapsack
3. ✓ Huffman Coding
4. ✓ Job Sequencing
5. ✓ Minimum Spanning Tree (Prim, Kruskal)

### Backtracking
1. ✓ N-Reinas
2. ✓ Sudoku
3. ✓ Subconjuntos
4. ✓ Permutaciones
5. ✓ Combinaciones
6. ✓ Laberinto (Rat in Maze)
7. ✓ Coloreo de Grafos

## 📂 Ejemplos
1. `ProgramacionDinamica.java` - Fibonacci, LCS, Mochila
2. `Greedy.java` - Activity Selection, Huffman
3. `Backtracking.java` - N-Reinas, Sudoku

## 💡 Patrones de Reconocimiento

**¿Es DP?**
- ¿Hay subproblemas solapados?
- ¿Puedo dividir en problemas más pequeños?
- ¿Las soluciones parciales se reutilizan?
→ SÍ: Usar DP

**¿Es Greedy?**
- ¿La elección óptima local lleva a la global?
- ¿No necesito reconsiderar decisiones?
→ SÍ: Usar Greedy (más eficiente que DP)

**¿Es Backtracking?**
- ¿Necesito explorar todas las posibilidades?
- ¿Puedo podar ramas inválidas?
→ SÍ: Usar Backtracking

## 🚀 Optimización

### DP: Top-Down vs Bottom-Up

**Top-Down (Memoización):**
```java
int fib(int n, int[] memo) {
    if (memo[n] != -1) return memo[n];
    memo[n] = fib(n-1, memo) + fib(n-2, memo);
    return memo[n];
}
```

**Bottom-Up (Tabulación):**
```java
int fib(int n) {
    int[] dp = new int[n+1];
    dp[0] = 0; dp[1] = 1;
    for (int i = 2; i <= n; i++) {
        dp[i] = dp[i-1] + dp[i-2];
    }
    return dp[n];
}
```

## 🎓 Recursos de Práctica
- LeetCode (categoría DP, Greedy, Backtracking)
- Dynamic Programming Patterns
- Backtracking Template
- Greedy Algorithm Problems

## 🏆 Metas del Módulo
Al completar este módulo deberías poder:
- ✅ Identificar cuándo usar cada técnica
- ✅ Implementar soluciones DP (memoización y tabulación)
- ✅ Aplicar estrategia greedy correctamente
- ✅ Escribir backtracking con poda eficiente
- ✅ Optimizar soluciones de fuerza bruta
- ✅ Resolver problemas de entrevistas avanzadas
