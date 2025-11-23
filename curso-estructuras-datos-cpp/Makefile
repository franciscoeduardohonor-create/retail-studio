# Makefile para Curso de Estructuras de Datos en C++
# Uso:
#   make             - Compila todos los programas
#   make modulo1     - Compila solo módulo 1
#   make clean       - Limpia ejecutables
#   make run-X       - Ejecuta programa específico

CXX = g++
CXXFLAGS = -std=c++17 -Wall -Wextra -O2

# Directorios
M1 = modulo1-arrays
M2 = modulo2-listas-enlazadas
M3 = modulo3-pilas-colas
M4 = modulo4-arboles
M5 = modulo5-hash-tables
M6 = modulo6-heaps
M7 = modulo7-grafos
M8 = modulo8-avanzadas

# Programas del Módulo 1
M1_PROGS = $(M1)/arrays_basicos $(M1)/arrays_dinamicos $(M1)/soluciones

# Programas del Módulo 2
M2_PROGS = $(M2)/lista_simple $(M2)/lista_doble

# Programas del Módulo 3
M3_PROGS = $(M3)/pila_stack $(M3)/cola_queue

# Programas del Módulo 4
M4_PROGS = $(M4)/arbol_binario

# Programas del Módulo 5
M5_PROGS = $(M5)/hash_table

# Programas del Módulo 6
M6_PROGS = $(M6)/heap

# Programas del Módulo 7
M7_PROGS = $(M7)/grafo

# Programas del Módulo 8
M8_PROGS = $(M8)/avl_tree $(M8)/trie

# Todos los programas
ALL_PROGS = $(M1_PROGS) $(M2_PROGS) $(M3_PROGS) $(M4_PROGS) \
            $(M5_PROGS) $(M6_PROGS) $(M7_PROGS) $(M8_PROGS)

# Regla principal
all: modulo1 modulo2 modulo3 modulo4 modulo5 modulo6 modulo7 modulo8
	@echo "✓ Todos los módulos compilados exitosamente!"

# Compilar Módulo 1
modulo1: $(M1_PROGS)
	@echo "✓ Módulo 1 compilado"

$(M1)/arrays_basicos: $(M1)/01_arrays_basicos.cpp
	$(CXX) $(CXXFLAGS) $< -o $@

$(M1)/arrays_dinamicos: $(M1)/02_arrays_dinamicos.cpp
	$(CXX) $(CXXFLAGS) $< -o $@

$(M1)/soluciones: $(M1)/soluciones.cpp
	$(CXX) $(CXXFLAGS) $< -o $@

# Compilar Módulo 2
modulo2: $(M2_PROGS)
	@echo "✓ Módulo 2 compilado"

$(M2)/lista_simple: $(M2)/01_lista_simple.cpp
	$(CXX) $(CXXFLAGS) $< -o $@

$(M2)/lista_doble: $(M2)/02_lista_doble.cpp
	$(CXX) $(CXXFLAGS) $< -o $@

# Compilar Módulo 3
modulo3: $(M3_PROGS)
	@echo "✓ Módulo 3 compilado"

$(M3)/pila_stack: $(M3)/01_pila_stack.cpp
	$(CXX) $(CXXFLAGS) $< -o $@

$(M3)/cola_queue: $(M3)/02_cola_queue.cpp
	$(CXX) $(CXXFLAGS) $< -o $@

# Compilar Módulo 4
modulo4: $(M4_PROGS)
	@echo "✓ Módulo 4 compilado"

$(M4)/arbol_binario: $(M4)/01_arbol_binario.cpp
	$(CXX) $(CXXFLAGS) $< -o $@

# Compilar Módulo 5
modulo5: $(M5_PROGS)
	@echo "✓ Módulo 5 compilado"

$(M5)/hash_table: $(M5)/01_hash_table.cpp
	$(CXX) $(CXXFLAGS) $< -o $@

# Compilar Módulo 6
modulo6: $(M6_PROGS)
	@echo "✓ Módulo 6 compilado"

$(M6)/heap: $(M6)/01_heap.cpp
	$(CXX) $(CXXFLAGS) $< -o $@

# Compilar Módulo 7
modulo7: $(M7_PROGS)
	@echo "✓ Módulo 7 compilado"

$(M7)/grafo: $(M7)/01_grafo.cpp
	$(CXX) $(CXXFLAGS) $< -o $@

# Compilar Módulo 8
modulo8: $(M8_PROGS)
	@echo "✓ Módulo 8 compilado"

$(M8)/avl_tree: $(M8)/01_avl_tree.cpp
	$(CXX) $(CXXFLAGS) $< -o $@

$(M8)/trie: $(M8)/02_trie.cpp
	$(CXX) $(CXXFLAGS) $< -o $@

# Limpiar ejecutables
clean:
	@rm -f $(ALL_PROGS)
	@echo "✓ Ejecutables eliminados"

# Ejecutar programas
run-arrays-basicos:
	@./$(M1)/arrays_basicos

run-lista-simple:
	@./$(M2)/lista_simple

run-pila:
	@./$(M3)/pila_stack

run-cola:
	@./$(M3)/cola_queue

run-arbol:
	@./$(M4)/arbol_binario

run-hash:
	@./$(M5)/hash_table

run-heap:
	@./$(M6)/heap

run-grafo:
	@./$(M7)/grafo

run-avl:
	@./$(M8)/avl_tree

run-trie:
	@./$(M8)/trie

# Ayuda
help:
	@echo "Comandos disponibles:"
	@echo "  make           - Compila todos los módulos"
	@echo "  make moduloX   - Compila módulo específico (1-8)"
	@echo "  make clean     - Elimina ejecutables"
	@echo "  make run-X     - Ejecuta programa específico"
	@echo ""
	@echo "Ejemplos:"
	@echo "  make modulo1"
	@echo "  make run-arrays-basicos"
	@echo "  make run-lista-simple"

.PHONY: all modulo1 modulo2 modulo3 modulo4 modulo5 modulo6 modulo7 modulo8 clean help
