# Módulo 8: Programación Paralela 🚀

## Objetivos

- ✅ Usar multithreading (Threads)
- ✅ Procesamiento distribuido
- ✅ Operaciones asíncronas (@async, @sync)
- ✅ Paralelizar bucles (@threads)

## Conceptos Clave

```julia
# Multithreading
using Base.Threads

@threads for i in 1:10
    println("Thread $(threadid()): $i")
end

# Async/Await
@async begin
    sleep(2)
    println("Tarea completada")
end

# Distributed computing
using Distributed
addprocs(4)  # Agregar 4 procesos

@everywhere function trabajo_pesado(n)
    sum(rand(n))
end

# Parallel map
pmap(trabajo_pesado, [1000, 2000, 3000])
```

---

➡️ **Siguiente:** [Módulo 9: Optimización](../modulo-09-optimizacion/README.md)
