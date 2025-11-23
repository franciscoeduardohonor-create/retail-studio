# Makefile para Módulo 1: Fundamentos de CUDA

NVCC = nvcc
NVCC_FLAGS = -O3 -arch=sm_50 -Xcompiler -Wall

# Ejemplos
EJEMPLOS = ejemplo_01_hola_cuda \
           ejemplo_02_suma_vectores \
           ejemplo_03_gestion_errores \
           ejemplo_04_propiedades_device

# Ejercicios
EJERCICIOS = ejercicios/ejercicio_01_multiplicacion_vectores \
             ejercicios/ejercicio_02_operaciones_combinadas

# Todos los ejecutables
ALL = $(EJEMPLOS) $(EJERCICIOS)

.PHONY: all clean ejemplos ejercicios help

all: ejemplos

ejemplos: $(EJEMPLOS)
	@echo "✓ Ejemplos del Módulo 1 compilados"

ejercicios: $(EJERCICIOS)
	@echo "✓ Ejercicios del Módulo 1 compilados"

# Regla general para compilar .cu a ejecutable
%: %.cu
	@echo "Compilando $<..."
	@$(NVCC) $(NVCC_FLAGS) $< -o $@

# Targets individuales
ejemplo_01_hola_cuda: ejemplo_01_hola_cuda.cu
ejemplo_02_suma_vectores: ejemplo_02_suma_vectores.cu
ejemplo_03_gestion_errores: ejemplo_03_gestion_errores.cu
ejemplo_04_propiedades_device: ejemplo_04_propiedades_device.cu

ejercicios/ejercicio_01_multiplicacion_vectores: ejercicios/ejercicio_01_multiplicacion_vectores.cu
ejercicios/ejercicio_02_operaciones_combinadas: ejercicios/ejercicio_02_operaciones_combinadas.cu

clean:
	@echo "Limpiando Módulo 1..."
	@rm -f $(EJEMPLOS) ejercicios/ejercicio_01_multiplicacion_vectores ejercicios/ejercicio_02_operaciones_combinadas
	@echo "✓ Módulo 1 limpio"

help:
	@echo "Módulo 1: Fundamentos de CUDA"
	@echo ""
	@echo "Comandos:"
	@echo "  make              - Compilar ejemplos"
	@echo "  make ejemplos     - Compilar solo ejemplos"
	@echo "  make ejercicios   - Compilar solo ejercicios"
	@echo "  make ejemplo_01   - Compilar ejemplo específico"
	@echo "  make clean        - Limpiar binarios"
	@echo ""
	@echo "Ejemplos disponibles:"
	@echo "  ejemplo_01_hola_cuda"
	@echo "  ejemplo_02_suma_vectores"
	@echo "  ejemplo_03_gestion_errores"
	@echo "  ejemplo_04_propiedades_device"
