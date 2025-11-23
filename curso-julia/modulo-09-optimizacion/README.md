# Módulo 9: Optimización y Performance ⚡

## Objetivos

- ✅ Medir performance (benchmarking)
- ✅ Usar @time, @benchmark
- ✅ Optimizar código
- ✅ Type stability
- ✅ Evitar allocations innecesarias

## Conceptos Clave

```julia
# Benchmarking
using BenchmarkTools

@time suma = sum(rand(1000))      # Timing simple
@benchmark sum(rand(1000))         # Benchmark detallado

# Type stability
function suma_estable(arr::Vector{Float64})
    total = 0.0  # Tipo específico
    for x in arr
        total += x
    end
    return total
end

# Evitar global variables
const CONSTANTE = 100  # Mejor que variable global

# Pre-allocation
function suma_preallocada!(resultado, arr)
    resultado[1] = sum(arr)
    return resultado
end

# Profiling
using Profile
@profile sum(rand(10000))
Profile.print()

# Inline y devectorization
@inline function pequeña(x)
    return x * 2
end

# Type annotations
function calculo(x::Float64, y::Float64)::Float64
    return x * y + x
end
```

## Consejos de Optimización

1. Evita variables globales
2. Usa tipos concretos
3. Pre-aloca arrays cuando sea posible
4. Usa @inbounds para acceso seguro
5. Perfila antes de optimizar
6. Usa @simd para vectorización

---

➡️ **Siguiente:** [Módulo 10: Proyectos Avanzados](../modulo-10-proyectos/README.md)
