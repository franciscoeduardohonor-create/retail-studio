# Módulo 1: Fundamentos de CUDA

## Objetivos de Aprendizaje
- Entender qué es CUDA y la arquitectura GPU
- Escribir tu primer kernel de CUDA
- Comprender la transferencia de datos entre CPU y GPU
- Gestionar memoria en CUDA

## Contenido

### 1.1 Introducción a CUDA

CUDA (Compute Unified Device Architecture) es una plataforma de computación paralela desarrollada por NVIDIA que permite usar GPUs para procesamiento de propósito general.

**Conceptos clave:**
- **Host:** CPU y su memoria
- **Device:** GPU y su memoria
- **Kernel:** Función que se ejecuta en la GPU
- **Thread:** Unidad básica de ejecución en la GPU

### 1.2 Arquitectura GPU vs CPU

**CPU:**
- Pocos cores (4-32)
- Optimizada para ejecución secuencial
- Gran cache
- Lógica compleja

**GPU:**
- Miles de cores (1000+)
- Optimizada para ejecución paralela masiva
- Cache pequeña
- Lógica simple por core

### 1.3 Modelo de programación CUDA

```
CPU (Host)                GPU (Device)
    |                         |
    |------ Copiar datos ---->|
    |                         |
    |------ Lanzar kernel --->|
    |                         |
    |                    [Ejecución paralela]
    |                         |
    |<----- Copiar resultados-|
    |                         |
```

## Ejemplos en este Módulo

1. **ejemplo_01_hola_cuda.cu** - Tu primer programa CUDA
2. **ejemplo_02_suma_vectores.cu** - Suma de vectores en paralelo
3. **ejemplo_03_gestion_errores.cu** - Manejo de errores en CUDA
4. **ejemplo_04_propiedades_device.cu** - Consultar propiedades de la GPU

## Ejercicios Prácticos

Los ejercicios están en la carpeta `ejercicios/`. Intenta resolverlos después de estudiar los ejemplos.

## Compilación

Para compilar los ejemplos:
```bash
nvcc ejemplo_01_hola_cuda.cu -o ejemplo_01
./ejemplo_01
```

## Próximo Módulo

En el Módulo 2 aprenderás sobre la gestión avanzada de memoria y la organización de threads en grids y blocks.
