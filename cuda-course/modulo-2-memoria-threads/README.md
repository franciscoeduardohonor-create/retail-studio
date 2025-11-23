# Módulo 2: Gestión de Memoria y Threads

## Objetivos de Aprendizaje
- Entender la jerarquía de memoria en CUDA
- Dominar la organización de threads en grids y blocks
- Trabajar con memoria unificada (Unified Memory)
- Optimizar transferencias de memoria
- Usar grids y bloques 2D y 3D

## Contenido

### 2.1 Jerarquía de Memoria en CUDA

```
┌─────────────────────────────────────────────┐
│          MEMORIA EN CUDA                    │
├─────────────────────────────────────────────┤
│                                             │
│  REGISTERS (más rápida, más pequeña)        │
│    - Por thread                             │
│    - ~1 ciclo de acceso                     │
│    - Limitados (típ. 255 por thread)        │
│                                             │
│  SHARED MEMORY (L1 Cache)                   │
│    - Por bloque                             │
│    - ~5 ciclos de acceso                    │
│    - Típ. 48-96 KB por bloque               │
│                                             │
│  CONSTANT MEMORY                            │
│    - Read-only desde GPU                    │
│    - Cacheable                              │
│    - Típ. 64 KB                             │
│                                             │
│  TEXTURE MEMORY                             │
│    - Read-only                              │
│    - Optimizada para patrones 2D/3D         │
│                                             │
│  GLOBAL MEMORY (más lenta, más grande)      │
│    - Accesible por todos los threads        │
│    - ~500 ciclos de acceso                  │
│    - Típ. varios GB                         │
│                                             │
└─────────────────────────────────────────────┘
```

### 2.2 Organización de Threads

**Jerarquía:**
- **Grid**: Conjunto de bloques
- **Block**: Conjunto de threads
- **Thread**: Unidad básica de ejecución

**Dimensiones:**
- Pueden ser 1D, 2D o 3D
- Útil para organizar datos espaciales

**Límites típicos:**
- Max threads por bloque: 1024
- Max bloques: 2³¹-1 en cada dimensión
- Warp size: 32 threads

### 2.3 Tipos de Memoria

| Tipo | Scope | Velocidad | Tamaño | Uso |
|------|-------|-----------|--------|-----|
| Registers | Thread | Muy rápida | ~255 | Variables locales |
| Shared | Block | Rápida | 48-96 KB | Compartir datos en bloque |
| Global | Grid | Lenta | GB | Datos principales |
| Constant | Grid | Media | 64 KB | Constantes read-only |

## Ejemplos en este Módulo

1. **ejemplo_01_grids_2d_3d.cu** - Uso de grids 2D y 3D
2. **ejemplo_02_shared_memory.cu** - Memoria compartida
3. **ejemplo_03_memoria_unificada.cu** - Unified Memory
4. **ejemplo_04_constant_memory.cu** - Memoria constante
5. **ejemplo_05_pinned_memory.cu** - Memoria pinned para transferencias rápidas

## Compilación

```bash
nvcc ejemplo_01_grids_2d_3d.cu -o ejemplo_01
./ejemplo_01
```

## Próximo Módulo

En el Módulo 3 aprenderás técnicas de optimización como memory coalescing y reducción de bank conflicts.
