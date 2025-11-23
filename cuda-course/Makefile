# Makefile Principal del Curso de CUDA
# Este Makefile compila todos los módulos

.PHONY: all clean help modulo1 modulo2 modulo3 modulo4 modulo5

# Compilador
NVCC = nvcc

# Flags de compilación
NVCC_FLAGS = -O3 -arch=sm_50 -Xcompiler -Wall

# Colores para output
RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[1;33m
BLUE = \033[0;34m
NC = \033[0m # No Color

all: help

help:
	@echo "$(BLUE)╔════════════════════════════════════════════════════╗$(NC)"
	@echo "$(BLUE)║         Curso Práctico de CUDA                     ║$(NC)"
	@echo "$(BLUE)╚════════════════════════════════════════════════════╝$(NC)"
	@echo ""
	@echo "$(GREEN)Comandos disponibles:$(NC)"
	@echo "  $(YELLOW)make modulo1$(NC)  - Compilar Módulo 1: Fundamentos"
	@echo "  $(YELLOW)make modulo2$(NC)  - Compilar Módulo 2: Memoria y Threads"
	@echo "  $(YELLOW)make modulo3$(NC)  - Compilar Módulo 3: Optimización"
	@echo "  $(YELLOW)make modulo4$(NC)  - Compilar Módulo 4: Técnicas Intermedias"
	@echo "  $(YELLOW)make modulo5$(NC)  - Compilar Módulo 5: Técnicas Avanzadas"
	@echo "  $(YELLOW)make all-modules$(NC) - Compilar todos los módulos"
	@echo "  $(YELLOW)make clean$(NC)    - Limpiar todos los binarios"
	@echo "  $(YELLOW)make test$(NC)     - Verificar instalación de CUDA"
	@echo ""
	@echo "$(GREEN)Uso por módulo:$(NC)"
	@echo "  cd modulo-X-nombre && make"
	@echo ""

# Verificar instalación
test:
	@echo "$(BLUE)Verificando instalación de CUDA...$(NC)"
	@which nvcc > /dev/null && echo "$(GREEN)✓ nvcc encontrado$(NC)" || echo "$(RED)✗ nvcc no encontrado$(NC)"
	@which nvidia-smi > /dev/null && echo "$(GREEN)✓ nvidia-smi encontrado$(NC)" || echo "$(RED)✗ nvidia-smi no encontrado$(NC)"
	@echo ""
	@echo "$(BLUE)Versión de CUDA:$(NC)"
	@nvcc --version || echo "$(RED)Error: CUDA no instalado$(NC)"
	@echo ""
	@echo "$(BLUE)GPUs disponibles:$(NC)"
	@nvidia-smi -L || echo "$(RED)Error: No se detectaron GPUs NVIDIA$(NC)"

# Compilar cada módulo
modulo1:
	@echo "$(BLUE)Compilando Módulo 1: Fundamentos...$(NC)"
	@cd modulo-1-fundamentos && $(MAKE)

modulo2:
	@echo "$(BLUE)Compilando Módulo 2: Memoria y Threads...$(NC)"
	@cd modulo-2-memoria-threads && $(MAKE)

modulo3:
	@echo "$(BLUE)Compilando Módulo 3: Optimización...$(NC)"
	@cd modulo-3-optimizacion-basica && $(MAKE)

modulo4:
	@echo "$(BLUE)Compilando Módulo 4: Técnicas Intermedias...$(NC)"
	@cd modulo-4-tecnicas-intermedias && $(MAKE)

modulo5:
	@echo "$(BLUE)Compilando Módulo 5: Técnicas Avanzadas...$(NC)"
	@cd modulo-5-tecnicas-avanzadas && $(MAKE)

# Compilar todos los módulos
all-modules: modulo1 modulo2 modulo3 modulo4 modulo5
	@echo "$(GREEN)✓ Todos los módulos compilados$(NC)"

# Limpiar todos los binarios
clean:
	@echo "$(YELLOW)Limpiando binarios...$(NC)"
	@cd modulo-1-fundamentos && $(MAKE) clean
	@cd modulo-2-memoria-threads && $(MAKE) clean
	@cd modulo-3-optimizacion-basica && $(MAKE) clean
	@cd modulo-4-tecnicas-intermedias && $(MAKE) clean
	@cd modulo-5-tecnicas-avanzadas && $(MAKE) clean
	@echo "$(GREEN)✓ Limpieza completada$(NC)"
