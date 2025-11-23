# Makefile para Módulo 4: Técnicas Intermedias

NVCC = nvcc
NVCC_FLAGS = -O3 -arch=sm_50 -Xcompiler -Wall

EJEMPLOS = ejemplo_01_reduccion

.PHONY: all clean help

all: $(EJEMPLOS)
	@echo "✓ Ejemplos del Módulo 4 compilados"

%: %.cu
	@echo "Compilando $<..."
	@$(NVCC) $(NVCC_FLAGS) $< -o $@

clean:
	@rm -f $(EJEMPLOS)
	@echo "✓ Módulo 4 limpio"

help:
	@echo "Módulo 4: Técnicas Intermedias"
	@echo ""
	@echo "Comandos:"
	@echo "  make        - Compilar todos los ejemplos"
	@echo "  make clean  - Limpiar binarios"
