# Módulo 5: Programación Funcional 🔧

## Objetivos

- ✅ Usar map, filter, reduce
- ✅ Dominar comprehensions
- ✅ Aplicar broadcasting
- ✅ Trabajar con pipelines
- ✅ Usar funciones de orden superior

## Conceptos Clave

```julia
# Map - transformar elementos
map(x -> x^2, [1,2,3,4,5])

# Filter - filtrar elementos
filter(x -> x % 2 == 0, [1,2,3,4,5,6])

# Reduce - reducir a un valor
reduce(+, [1,2,3,4,5])  # Suma total

# Broadcasting (.)
[1,2,3] .+ [4,5,6]  # [5,7,9]

# Pipelines (|>)
[1,2,3,4,5] |>
    x -> filter(>(2), x) |>
    x -> map(^(2), x) |>
    sum

# Comprehensions
[x^2 for x in 1:10 if x % 2 == 0]

# Zip
collect(zip([1,2,3], ["a","b","c"]))
```

---

➡️ **Siguiente:** [Módulo 6: Archivos y E/S](../modulo-06-archivos/README.md)
