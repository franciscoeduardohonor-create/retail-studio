# 🎓 Curso Práctico de Estructuras de Datos en C++
## De Principiante a Avanzado

¡Bienvenido! Este es un curso **completo y práctico** de estructuras de datos con ejemplos detallados en C++.

## 🌟 Características del Curso

- ✅ **100+ ejemplos de código** completamente comentados
- ✅ **8 módulos** desde principiante hasta avanzado
- ✅ **Ejercicios prácticos** con soluciones
- ✅ **Explicaciones detalladas** de complejidad
- ✅ **Código funcional** listo para compilar y ejecutar
- ✅ **Guía de estudio** estructurada
- ✅ **Makefile** incluido para fácil compilación

## 📚 Estructura del Curso

### **Nivel Principiante**
1. **Módulo 1: Fundamentos y Arrays**
   - Introducción a estructuras de datos
   - Arrays estáticos y dinámicos
   - Operaciones básicas

2. **Módulo 2: Listas Enlazadas (Linked Lists)**
   - Listas simplemente enlazadas
   - Listas doblemente enlazadas
   - Listas circulares

3. **Módulo 3: Pilas y Colas (Stacks & Queues)**
   - Implementación de Pilas
   - Implementación de Colas
   - Aplicaciones prácticas

### **Nivel Intermedio**
4. **Módulo 4: Árboles (Trees)**
   - Árboles binarios
   - Árboles de búsqueda binaria (BST)
   - Recorridos de árboles

5. **Módulo 5: Tablas Hash (Hash Tables)**
   - Funciones hash
   - Manejo de colisiones
   - Implementación práctica

6. **Módulo 6: Heaps**
   - Min Heap y Max Heap
   - Priority Queue
   - Heap Sort

### **Nivel Avanzado**
7. **Módulo 7: Grafos (Graphs)**
   - Representación de grafos
   - Algoritmos de recorrido (BFS, DFS)
   - Algoritmos de camino más corto

8. **Módulo 8: Estructuras Avanzadas**
   - Árboles AVL (balanceados)
   - Tries (árboles de prefijos)
   - Segment Trees

## 🚀 Cómo usar este curso

1. **Lee la teoría** de cada módulo
2. **Estudia los ejemplos** comentados
3. **Ejecuta el código** en tu computadora
4. **Realiza los ejercicios** propuestos
5. **Compara** tus soluciones con las proporcionadas

## 💻 Requisitos

- Compilador de C++ (g++, clang, o Visual Studio)
- Conocimientos básicos de C++
- Un editor de texto o IDE

## 🚀 Inicio Rápido

### Opción 1: Usar Makefile (Recomendado)
```bash
# Compilar todos los módulos
make

# Compilar un módulo específico
make modulo1

# Ejecutar un programa
make run-arrays-basicos

# Ver ayuda
make help

# Limpiar ejecutables
make clean
```

### Opción 2: Compilación Manual
```bash
# Navegar a un módulo
cd modulo1-arrays

# Compilar un archivo
g++ -std=c++17 01_arrays_basicos.cpp -o arrays_basicos

# Ejecutar
./arrays_basicos
```

## 📖 Cómo Estudiar Este Curso

1. **Lee la [Guía de Estudio](GUIA_ESTUDIO.md)** completa primero
2. **Sigue el orden** de los módulos (1 → 8)
3. **Para cada módulo:**
   - Lee `teoria.md`
   - Ejecuta los ejemplos
   - Modifica el código
   - Resuelve ejercicios
4. **Practica constantemente** - La clave es implementar tú mismo

## 📁 Estructura de Archivos

```
curso-estructuras-datos-cpp/
├── README.md                    # Este archivo
├── GUIA_ESTUDIO.md             # Plan de estudio detallado
├── Makefile                     # Para compilar fácilmente
│
├── modulo1-arrays/
│   ├── teoria.md
│   ├── 01_arrays_basicos.cpp
│   ├── 02_arrays_dinamicos.cpp
│   ├── ejercicios.md
│   └── soluciones.cpp
│
├── modulo2-listas-enlazadas/
│   ├── teoria.md
│   ├── 01_lista_simple.cpp
│   └── 02_lista_doble.cpp
│
├── modulo3-pilas-colas/
│   ├── 01_pila_stack.cpp
│   └── 02_cola_queue.cpp
│
├── modulo4-arboles/
│   └── 01_arbol_binario.cpp
│
├── modulo5-hash-tables/
│   └── 01_hash_table.cpp
│
├── modulo6-heaps/
│   └── 01_heap.cpp
│
├── modulo7-grafos/
│   └── 01_grafo.cpp
│
└── modulo8-avanzadas/
    ├── 01_avl_tree.cpp
    └── 02_trie.cpp
```

## 📊 Tabla de Contenidos Detallada

| Módulo | Temas | Archivos | Dificultad |
|--------|-------|----------|------------|
| 1 | Arrays estáticos/dinámicos, operaciones | 4 archivos | ⭐ |
| 2 | Listas simples/dobles, operaciones | 2 archivos | ⭐⭐ |
| 3 | Pilas (LIFO), Colas (FIFO) | 2 archivos | ⭐⭐ |
| 4 | Árboles binarios, BST, recorridos | 1 archivo | ⭐⭐⭐ |
| 5 | Hash tables, colisiones | 1 archivo | ⭐⭐⭐ |
| 6 | Min/Max heaps, heap sort | 1 archivo | ⭐⭐⭐ |
| 7 | Grafos, BFS, DFS, Dijkstra | 1 archivo | ⭐⭐⭐⭐ |
| 8 | AVL trees, Tries | 2 archivos | ⭐⭐⭐⭐ |

## 💻 Requisitos

- **Compilador C++**: g++ 7.0+ o clang 5.0+
- **Estándar**: C++17 o superior
- **Sistema Operativo**: Linux, macOS, o Windows (con MinGW/WSL)
- **Conocimientos previos**:
  - Sintaxis básica de C++
  - Punteros y referencias
  - Recursión (recomendado)

## 🎯 Objetivos de Aprendizaje

Al completar este curso, serás capaz de:

1. ✅ Implementar todas las estructuras de datos fundamentales
2. ✅ Analizar complejidad temporal y espacial (Big O)
3. ✅ Elegir la estructura apropiada para cada problema
4. ✅ Resolver problemas de entrevistas técnicas
5. ✅ Optimizar código usando estructuras eficientes
6. ✅ Implementar algoritmos clásicos (BFS, DFS, Dijkstra)

## 📚 Recursos Adicionales

- **Visualización**: [VisuAlgo.net](https://visualgo.net)
- **Práctica**: [LeetCode](https://leetcode.com), [HackerRank](https://hackerrank.com)
- **Documentación**: [cppreference.com](https://cppreference.com)
- **Libros**: Ver GUIA_ESTUDIO.md

## ❓ Preguntas Frecuentes

**P: ¿Necesito conocimientos avanzados de C++?**
R: No. Con conocimientos básicos (variables, loops, funciones) es suficiente.

**P: ¿Cuánto tiempo toma completar el curso?**
R: Aproximadamente 8-12 semanas estudiando 1-2 horas diarias.

**P: ¿Puedo saltar módulos?**
R: Se recomienda seguir el orden, ya que los conceptos se construyen progresivamente.

**P: ¿Los ejemplos funcionan en Windows?**
R: Sí, con MinGW o usando WSL (Windows Subsystem for Linux).

## 🤝 Contribuciones

Este es material educativo. Si encuentras errores o mejoras:
1. Reporta issues
2. Propón cambios
3. Comparte tu experiencia

## 📝 Notas Importantes

- ⚠️ **Compila con optimizaciones**: Usa `-O2` o `-O3` para mejor rendimiento
- 💡 **Practica debugging**: Usa gdb o lldb para entender el flujo
- 🔍 **Analiza complejidad**: Siempre piensa en Big O
- ✏️ **Toma notas**: Escribe tus propios comentarios
- 🎨 **Dibuja estructuras**: Visualizar ayuda a entender

## 📜 Licencia

Este material es de código abierto para uso educativo.

## 🎓 Créditos

Curso creado con el objetivo de enseñar estructuras de datos de forma práctica y accesible.

---

## 🚀 ¡Comienza Ahora!

```bash
# Clona o descarga el repositorio
cd curso-estructuras-datos-cpp

# Compila todos los ejemplos
make

# Empieza con el módulo 1
cd modulo1-arrays
cat teoria.md

# Compila y ejecuta el primer ejemplo
make run-arrays-basicos
```

**¡Mucho éxito en tu aprendizaje! 🎉**

> "La práctica hace al maestro. No solo leas el código, ¡escríbelo!"
