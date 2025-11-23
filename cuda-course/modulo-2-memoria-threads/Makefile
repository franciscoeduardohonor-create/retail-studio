# Makefile para Módulo 2: Gestión de Memoria y Threads

NVCC = nvcc
NVCC_FLAGS = -O3 -arch=sm_50 -Xcompiler -Wall

EJEMPLOS = ejemplo_01_grids_2d_3d \
           ejemplo_02_shared_memory \
           ejemplo_03_memoria_unificada

.PHONY: all clean help

all: $(EJEMPLOS)
	@echo "✓ Ejemplos del Módulo 2 compilados"

%: %.cu
	@echo "Compilando $<..."
	@$(NVCC) $(NVCC_FLAGS) $< -o $@

clean:
	@rm -f $(EJEMPLOS)
	@echo "✓ Módulo 2 limpio"

help:
	@echo "Módulo 2: Gestión de Memoria y Threads"
	@echo ""
	@echo "Comandos:"
	@echo "  make        - Compilar todos los ejemplos"
	@echo "  make clean  - Limpiar binarios"
