# Makefile para Módulo 3: Optimización Básica

NVCC = nvcc
NVCC_FLAGS = -O3 -arch=sm_50 -Xcompiler -Wall

EJEMPLOS = ejemplo_01_matrix_multiply

.PHONY: all clean help

all: $(EJEMPLOS)
	@echo "✓ Ejemplos del Módulo 3 compilados"

%: %.cu
	@echo "Compilando $<..."
	@$(NVCC) $(NVCC_FLAGS) $< -o $@

clean:
	@rm -f $(EJEMPLOS)
	@echo "✓ Módulo 3 limpio"

help:
	@echo "Módulo 3: Optimización Básica"
	@echo ""
	@echo "Comandos:"
	@echo "  make        - Compilar todos los ejemplos"
	@echo "  make clean  - Limpiar binarios"
