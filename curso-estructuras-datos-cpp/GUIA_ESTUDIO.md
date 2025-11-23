# 📘 Guía de Estudio - Estructuras de Datos en C++

## 🎯 Cómo Usar Este Curso

Este curso está diseñado para llevarte desde principiante hasta avanzado en estructuras de datos. Sigue esta guía para aprovechar al máximo el material.

## 📅 Plan de Estudio Sugerido

### Semana 1-2: Fundamentos
- **Módulo 1: Arrays**
  - Lee `teoria.md`
  - Ejecuta y estudia `01_arrays_basicos.cpp`
  - Ejecuta y estudia `02_arrays_dinamicos.cpp`
  - Resuelve TODOS los ejercicios de `ejercicios.md`
  - Compara con `soluciones.cpp`
  - ✅ Checkpoint: Debes poder implementar arrays y resolver problemas básicos

### Semana 3-4: Listas Enlazadas
- **Módulo 2: Listas Enlazadas**
  - Lee `teoria.md`
  - Implementa `01_lista_simple.cpp` tú mismo siguiendo comentarios
  - Ejecuta `02_lista_doble.cpp`
  - Practica: Implementa una función para detectar ciclos
  - Practica: Implementa una función para invertir lista
  - ✅ Checkpoint: Debes poder crear listas y manipularlas

### Semana 5: Pilas y Colas
- **Módulo 3: Pilas y Colas**
  - Ejecuta `01_pila_stack.cpp`
  - Ejecuta `02_cola_queue.cpp`
  - Practica: Implementa calculadora con notación postfija
  - Practica: Simula sistema de atención con colas
  - ✅ Checkpoint: Entender diferencia entre LIFO y FIFO

### Semana 6-7: Árboles
- **Módulo 4: Árboles**
  - Lee sobre árboles binarios
  - Ejecuta `01_arbol_binario.cpp`
  - Practica todos los recorridos (inorder, preorder, postorder)
  - Implementa función para validar si es BST
  - ✅ Checkpoint: Poder construir y recorrer árboles

### Semana 8: Hash Tables
- **Módulo 5: Hash Tables**
  - Ejecuta `01_hash_table.cpp`
  - Comprende diferencia entre encadenamiento y linear probing
  - Practica: Implementa contador de frecuencia de palabras
  - ✅ Checkpoint: Entender funciones hash y colisiones

### Semana 9: Heaps
- **Módulo 6: Heaps**
  - Ejecuta `01_heap.cpp`
  - Implementa heap sort manualmente
  - Practica: Encuentra K elementos más grandes
  - ✅ Checkpoint: Entender propiedad de heap y heapify

### Semana 10-11: Grafos
- **Módulo 7: Grafos**
  - Ejecuta `01_grafo.cpp`
  - Implementa BFS y DFS tú mismo
  - Practica: Encuentra componentes conexas
  - Practica: Implementa algoritmo de Dijkstra
  - ✅ Checkpoint: Poder representar y recorrer grafos

### Semana 12: Estructuras Avanzadas
- **Módulo 8: AVL y Tries**
  - Ejecuta `01_avl_tree.cpp`
  - Ejecuta `02_trie.cpp`
  - Comprende rotaciones en AVL
  - Practica: Implementa autocompletar con Trie
  - ✅ Checkpoint: Entender balanceo y prefijos

## 📝 Metodología de Estudio

### Para Cada Módulo:

1. **LEE la Teoría (20%)**
   - Entiende conceptos antes de codificar
   - Toma notas de puntos clave
   - Dibuja diagramas si ayuda

2. **EJECUTA los Ejemplos (30%)**
   ```bash
   cd modulo-X
   g++ -std=c++17 archivo.cpp -o programa
   ./programa
   ```
   - Ejecuta cada programa
   - Observa la salida
   - Compara con salida esperada

3. **MODIFICA el Código (20%)**
   - Cambia valores
   - Agrega más operaciones
   - Experimenta para entender

4. **IMPLEMENTA desde Cero (30%)**
   - Cierra el ejemplo
   - Intenta implementar tú mismo
   - Consulta solo si te atoras

## 🎓 Ejercicios Prácticos Integrados

### Nivel Principiante

#### Ejercicio: Lista de Tareas
Crea un sistema de gestión de tareas usando:
- Lista enlazada para almacenar tareas
- Pila para función "deshacer"
- Cola para tareas pendientes

#### Ejercicio: Validador de Expresiones
Implementa validador que use pilas para verificar:
- Paréntesis balanceados
- Corchetes y llaves
- Expresiones matemáticas válidas

### Nivel Intermedio

#### Ejercicio: Sistema de Archivos
Simula estructura de archivos usando:
- Árbol para jerarquía de carpetas
- Hash table para búsqueda rápida por nombre
- DFS para listar recursivamente

#### Ejercicio: Cache LRU
Implementa cache Least Recently Used con:
- Hash table para acceso O(1)
- Lista doble enlazada para orden

### Nivel Avanzado

#### Ejercicio: Motor de Búsqueda Simple
Crea buscador básico usando:
- Trie para autocompletar
- Hash table para índice invertido
- Heap para ranking de resultados

#### Ejercicio: Sistema de Recomendación
Implementa sistema simple con:
- Grafo para relaciones entre usuarios/items
- BFS para encontrar similares
- Priority queue para top K recomendaciones

## 📊 Tabla de Complejidades

Memoriza estas complejidades:

| Estructura | Acceso | Búsqueda | Inserción | Eliminación |
|------------|--------|----------|-----------|-------------|
| Array | O(1) | O(n) | O(n) | O(n) |
| Lista Enlazada | O(n) | O(n) | O(1)* | O(1)* |
| Pila | O(1) | O(n) | O(1) | O(1) |
| Cola | O(1) | O(n) | O(1) | O(1) |
| BST | O(log n)** | O(log n)** | O(log n)** | O(log n)** |
| AVL | O(log n) | O(log n) | O(log n) | O(log n) |
| Hash Table | - | O(1)*** | O(1)*** | O(1)*** |
| Heap | O(1)**** | O(n) | O(log n) | O(log n) |
| Trie | O(m) | O(m) | O(m) | O(m) |

\* Al inicio/final con puntero
\*\* Promedio, peor caso O(n)
\*\*\* Promedio, peor caso O(n)
\*\*\*\* Solo min/max
m = longitud de la cadena

## 🔍 Preguntas de Autoevaluación

### Módulo 1: Arrays
- [ ] ¿Cuál es la diferencia entre array estático y dinámico?
- [ ] ¿Por qué el acceso es O(1) pero inserción es O(n)?
- [ ] ¿Cuándo usar array vs lista enlazada?

### Módulo 2: Listas Enlazadas
- [ ] ¿Qué ventajas tiene lista doble sobre simple?
- [ ] ¿Cómo detectar un ciclo en una lista?
- [ ] ¿Por qué insertar al inicio es O(1)?

### Módulo 3: Pilas y Colas
- [ ] ¿Cuál es la diferencia entre LIFO y FIFO?
- [ ] ¿Qué es una cola de prioridad?
- [ ] ¿Cómo se implementa con array circular?

### Módulo 4: Árboles
- [ ] ¿Qué es un BST y su propiedad principal?
- [ ] ¿Cuándo usar cada tipo de recorrido?
- [ ] ¿Cómo eliminar nodo con dos hijos?

### Módulo 5: Hash Tables
- [ ] ¿Qué hace una función hash?
- [ ] ¿Diferencia entre encadenamiento y linear probing?
- [ ] ¿Qué es el factor de carga?

### Módulo 6: Heaps
- [ ] ¿Diferencia entre min-heap y max-heap?
- [ ] ¿Cómo se implementa con array?
- [ ] ¿Qué es heapify up/down?

### Módulo 7: Grafos
- [ ] ¿Diferencia entre BFS y DFS?
- [ ] ¿Cuándo usar matriz vs lista de adyacencia?
- [ ] ¿Cómo funciona Dijkstra?

### Módulo 8: Avanzadas
- [ ] ¿Por qué AVL garantiza O(log n)?
- [ ] ¿Qué son las rotaciones en AVL?
- [ ] ¿Para qué sirve un Trie?

## 💡 Consejos para el Éxito

1. **Practica Diariamente**
   - Mínimo 1 hora al día
   - Consistencia > Intensidad

2. **Dibuja Todo**
   - Visualiza estructuras en papel
   - Traza ejecución paso a paso

3. **Implementa desde Cero**
   - No copies y pegues
   - Escribe cada línea entendiendo

4. **Resuelve Problemas**
   - LeetCode, HackerRank
   - Comienza con "Easy"
   - Progresa gradualmente

5. **Enseña a Otros**
   - Explica conceptos en voz alta
   - Ayuda en foros
   - Escribe tu propio blog

6. **Analiza Complejidad**
   - Siempre pregúntate: ¿Cuál es el Big O?
   - Optimiza después de que funcione

7. **Debuggea con Paciencia**
   - Usa print statements
   - Usa debugger (gdb)
   - Verifica casos extremos

## 🎯 Proyecto Final Sugerido

Al terminar el curso, implementa uno de estos proyectos:

1. **Sistema de Gestión de Biblioteca**
   - Hash table para búsqueda por ISBN
   - AVL tree para búsqueda por título
   - Heap para libros más populares

2. **Juego de Palabras (Scrabble-like)**
   - Trie para diccionario
   - Búsqueda de palabras válidas
   - Sugerencias de jugadas

3. **Simulador de Red Social**
   - Grafo para conexiones
   - BFS para grados de separación
   - Sugerencias de amigos

4. **Sistema de Navegación GPS**
   - Grafo ponderado para mapa
   - Dijkstra para ruta más corta
   - Priority queue para alternativas

## 📚 Recursos Adicionales

### Libros Recomendados
- "Introduction to Algorithms" (CLRS)
- "Data Structures and Algorithm Analysis in C++" (Mark Allen Weiss)
- "Cracking the Coding Interview" (Gayle Laakmann McDowell)

### Sitios Web
- [VisuAlgo](https://visualgo.net) - Visualización de algoritmos
- [GeeksforGeeks](https://www.geeksforgeeks.org) - Tutoriales
- [LeetCode](https://leetcode.com) - Práctica
- [HackerRank](https://www.hackerrank.com) - Ejercicios

### Videos
- MIT OpenCourseWare - Introduction to Algorithms
- Abdul Bari - Algorithm Playlist
- Back To Back SWE - Data Structures

## ✅ Lista de Verificación Final

Antes de considerar el curso completado:

- [ ] Implementé todas las estructuras básicas desde cero
- [ ] Resolví al menos 50% de ejercicios de cada módulo
- [ ] Puedo explicar cada estructura sin ver código
- [ ] Entiendo análisis de complejidad
- [ ] Completé un proyecto final integrador
- [ ] Puedo resolver problemas "Medium" en LeetCode

## 🚀 Siguientes Pasos

Después de este curso:
1. Estudia algoritmos avanzados (Divide & Conquer, DP, Greedy)
2. Practica entrevistas técnicas
3. Contribuye a proyectos open source
4. Implementa estructuras en otros lenguajes
5. Estudia estructuras concurrentes

---

**¡Mucho éxito en tu aprendizaje! 🎉**

Recuerda: La clave es la práctica constante. No te desanimes si algo no tiene sentido al principio. Sigue practicando y todo se aclarará.

**"La única manera de aprender una nueva estructura de datos es implementándola." - Donald Knuth (parafraseado)**
