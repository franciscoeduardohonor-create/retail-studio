# 🚀 Curso Práctico de Programación CUDA

## De Principiante a Avanzado

Bienvenido al curso completo de programación en CUDA (Compute Unified Device Architecture). Este curso te llevará desde los conceptos básicos hasta técnicas avanzadas de programación GPU.

## 📋 Tabla de Contenidos

- [Requisitos](#requisitos)
- [Estructura del Curso](#estructura-del-curso)
- [Cómo Usar Este Curso](#cómo-usar-este-curso)
- [Compilación](#compilación)
- [Recursos Adicionales](#recursos-adicionales)

## 🎯 Objetivos del Curso

Al finalizar este curso serás capaz de:
- ✅ Escribir programas CUDA desde cero
- ✅ Optimizar código para máximo rendimiento
- ✅ Entender la arquitectura GPU y su modelo de ejecución
- ✅ Aplicar patrones paralelos comunes
- ✅ Debuggear y perfilar aplicaciones CUDA
- ✅ Usar bibliotecas CUDA estándar (Thrust, cuBLAS, etc.)

## 🛠️ Requisitos

### Hardware
- **GPU NVIDIA** con Compute Capability 3.0 o superior
- Para verificar tu GPU:
  ```bash
  nvidia-smi
  ```

### Software
- **CUDA Toolkit** (versión 11.0 o superior)
  - [Descargar CUDA Toolkit](https://developer.nvidia.com/cuda-downloads)
- **Compilador C/C++**
  - Linux: gcc/g++
  - Windows: Visual Studio
- **Make** (opcional, para usar Makefiles)

### Verificar Instalación
```bash
nvcc --version
```

## 📚 Estructura del Curso

El curso está organizado en 5 módulos progresivos:

### 📘 Módulo 1: Fundamentos de CUDA
**Nivel:** Principiante
**Duración estimada:** 2-3 días

Aprenderás:
- ¿Qué es CUDA y por qué usarlo?
- Arquitectura GPU vs CPU
- Tu primer programa CUDA
- Gestión básica de memoria
- Transferencia de datos CPU ↔ GPU
- Manejo de errores

**Ejemplos:**
- `ejemplo_01_hola_cuda.cu` - Primer programa
- `ejemplo_02_suma_vectores.cu` - Operaciones paralelas básicas
- `ejemplo_03_gestion_errores.cu` - Debugging
- `ejemplo_04_propiedades_device.cu` - Información de GPU

**Ejercicios:**
- Multiplicación de vectores
- Operaciones combinadas

---

### 📗 Módulo 2: Gestión de Memoria y Threads
**Nivel:** Principiante-Intermedio
**Duración estimada:** 3-4 días

Aprenderás:
- Jerarquía de memoria en CUDA
- Grids y bloques 2D/3D
- Shared memory
- Memoria unificada (Unified Memory)
- Constant memory
- Pinned memory

**Ejemplos:**
- `ejemplo_01_grids_2d_3d.cu` - Organización multidimensional
- `ejemplo_02_shared_memory.cu` - Memoria compartida
- `ejemplo_03_memoria_unificada.cu` - Unified Memory

**Puntos clave:**
```
┌─────────────────────────────────┐
│  Jerarquía de Velocidad         │
├─────────────────────────────────┤
│  Registers      (más rápido)    │
│  Shared Memory                  │
│  L1/L2 Cache                    │
│  Global Memory  (más lento)     │
└─────────────────────────────────┘
```

---

### 📙 Módulo 3: Optimización Básica
**Nivel:** Intermedio
**Duración estimada:** 4-5 días

Aprenderás:
- Memory coalescing
- Evitar bank conflicts
- Tiling para multiplicación de matrices
- Optimización de occupancy
- Herramientas de profiling

**Ejemplos:**
- `ejemplo_01_matrix_multiply.cu` - MatMul optimizado con tiling

**Conceptos clave:**
- **Coalescing:** Threads consecutivos → Direcciones consecutivas
- **Tiling:** Reutilizar datos en shared memory
- **Occupancy:** Maximizar uso de recursos

---

### 📕 Módulo 4: Técnicas Intermedias
**Nivel:** Intermedio-Avanzado
**Duración estimada:** 5-6 días

Aprenderás:
- Reducción paralela
- Scan (prefix sum)
- Streams para concurrencia
- Histogramas paralelos
- Patrones Map-Reduce

**Ejemplos:**
- `ejemplo_01_reduccion.cu` - Reducción optimizada
- `ejemplo_02_streams.cu` - Ejecución concurrente
- `ejemplo_03_scan.cu` - Prefix sum

**Patrón de Reducción:**
```
[1, 2, 3, 4, 5, 6, 7, 8]
[  3,   7,   11,  15  ]  ← Paso 1
[      10,      26    ]  ← Paso 2
[          36         ]  ← Resultado
```

---

### 📔 Módulo 5: Técnicas Avanzadas
**Nivel:** Avanzado
**Duración estimada:** 7+ días

Aprenderás:
- Operaciones a nivel de warp
- Dynamic parallelism
- Multi-GPU programming
- Bibliotecas CUDA (Thrust, CUB, cuBLAS)
- Debugging avanzado
- CUDA Graphs
- Tensor Cores

**Ejemplos:**
- `ejemplo_01_warp_primitives.cu` - Warp shuffle
- `ejemplo_02_dynamic_parallelism.cu` - Kernels recursivos
- `ejemplo_03_thrust.cu` - Biblioteca Thrust
- `ejemplo_04_multi_gpu.cu` - Múltiples GPUs

---

## 🚀 Cómo Usar Este Curso

### Enfoque Recomendado

1. **Lee el README** de cada módulo primero
2. **Estudia los ejemplos** con comentarios detallados
3. **Compila y ejecuta** cada ejemplo
4. **Modifica el código** para experimentar
5. **Completa los ejercicios** antes de avanzar
6. **Repite conceptos** que no queden claros

### Progresión Sugerida

```
Día 1-3:   Módulo 1 (Fundamentos)
Día 4-7:   Módulo 2 (Memoria y Threads)
Día 8-12:  Módulo 3 (Optimización)
Día 13-18: Módulo 4 (Técnicas Intermedias)
Día 19+:   Módulo 5 (Técnicas Avanzadas)
```

### Tips de Aprendizaje

- 📝 **Toma notas** de conceptos clave
- 💻 **Escribe código** desde cero, no solo copies
- 🔍 **Experimenta** con diferentes configuraciones
- 📊 **Mide rendimiento** de tus implementaciones
- 🐛 **Debuggea errores** tú mismo antes de buscar ayuda
- 🤝 **Comparte** lo que aprendes

## 🔧 Compilación

### Compilar un Ejemplo Individual

```bash
nvcc ejemplo_01_hola_cuda.cu -o ejemplo_01
./ejemplo_01
```

### Opciones de Compilación Útiles

```bash
# Especificar compute capability (ej: para RTX 3080)
nvcc -arch=sm_86 ejemplo.cu -o ejemplo

# Optimización
nvcc -O3 ejemplo.cu -o ejemplo

# Con información de debugging
nvcc -g -G ejemplo.cu -o ejemplo

# Warnings detallados
nvcc -Xcompiler -Wall ejemplo.cu -o ejemplo
```

### Usar Makefile (Simplifica Compilación)

```bash
# Compilar todos los ejemplos de un módulo
cd modulo-1-fundamentos
make

# Compilar ejemplo específico
make ejemplo_01

# Limpiar binarios
make clean
```

## 📊 Verificar tu GPU

Ejecuta este comando para ver información de tu GPU:

```bash
# Ver GPUs disponibles
nvidia-smi

# Información detallada de CUDA
nvcc --version
deviceQuery  # (viene en CUDA samples)
```

## 🎓 Recursos Adicionales

### Documentación Oficial
- [CUDA Toolkit Documentation](https://docs.nvidia.com/cuda/)
- [CUDA C Programming Guide](https://docs.nvidia.com/cuda/cuda-c-programming-guide/)
- [CUDA Best Practices Guide](https://docs.nvidia.com/cuda/cuda-c-best-practices-guide/)

### Tutoriales
- [NVIDIA Developer Blog](https://developer.nvidia.com/blog/)
- [CUDA Training Series](https://www.olcf.ornl.gov/cuda-training-series/)

### Libros Recomendados
- "Programming Massively Parallel Processors" - Kirk & Hwu
- "CUDA by Example" - Sanders & Kandrot
- "Professional CUDA C Programming" - Cheng et al.

### Herramientas
- **NVIDIA Nsight Systems**: Profiler de sistema
- **NVIDIA Nsight Compute**: Profiler de kernels
- **cuda-memcheck**: Detector de errores de memoria
- **nvprof**: Profiler de línea de comandos

### Comunidad
- [NVIDIA Developer Forums](https://forums.developer.nvidia.com/)
- [Stack Overflow - CUDA tag](https://stackoverflow.com/questions/tagged/cuda)
- [r/CUDA subreddit](https://www.reddit.com/r/CUDA/)

## 📝 Notas Importantes

### Buenas Prácticas

1. **Siempre verifica errores** después de llamadas CUDA
2. **Libera memoria** que asignes (evita memory leaks)
3. **Sincroniza** antes de acceder a resultados
4. **Usa shared memory** para datos reutilizados
5. **Prefiere threads/bloque** en múltiplos de 32
6. **Perfila antes de optimizar** - no adivines cuellos de botella

### Errores Comunes a Evitar

- ❌ No verificar errores de CUDA
- ❌ Olvidar sincronizar después de lanzar kernel
- ❌ Acceder a memoria después de liberarla
- ❌ No verificar límites de arrays
- ❌ Usar demasiados registros (reduce occupancy)
- ❌ Bank conflicts en shared memory

## 🎯 Proyecto Final Sugerido

Después de completar los módulos, implementa un proyecto que combine múltiples técnicas:

### Ideas de Proyectos

1. **Procesamiento de Imágenes**
   - Filtros (blur, sharpen, edge detection)
   - Transformaciones (resize, rotate)
   - Histogramas y ecualización

2. **Simulación Física**
   - N-body simulation
   - Fluid dynamics
   - Cloth simulation

3. **Machine Learning**
   - Red neuronal simple
   - K-means clustering
   - Gradient descent

4. **Procesamiento de Datos**
   - Sort paralelo (radix sort)
   - Compresión de datos
   - Búsqueda y filtrado

## 🤝 Contribuciones

Si encuentras errores o tienes sugerencias de mejora:
1. Anota el módulo y archivo específico
2. Describe el problema o mejora
3. Si es posible, propón una solución

## 📄 Licencia

Este material educativo está disponible para uso personal y educativo.

---

## 🚀 ¡Comienza Ahora!

```bash
cd modulo-1-fundamentos
nvcc ejemplo_01_hola_cuda.cu -o ejemplo_01
./ejemplo_01
```

**¡Bienvenido al mundo de la programación GPU! 🎉**

---

### Preguntas Frecuentes

**P: ¿Necesito una GPU NVIDIA?**
R: Sí, CUDA solo funciona con GPUs NVIDIA.

**P: ¿Funciona en Windows/Linux/Mac?**
R: Windows y Linux completamente. Mac descontinuó soporte CUDA.

**P: ¿Cuánto tiempo toma aprender CUDA?**
R: Básico: 1-2 semanas. Competente: 1-2 meses. Experto: 6+ meses de práctica.

**P: ¿Es necesario saber C++?**
R: Sí, necesitas conocimientos sólidos de C/C++.

**P: ¿Qué GPU necesito para aprender?**
R: Cualquier GPU NVIDIA moderna (GTX 1050+, RTX serie, etc.)

---

**¡Feliz programación en CUDA! 🚀**
