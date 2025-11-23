# Módulo 4: Tipos y Estructuras de Datos 📊

## Objetivos

- ✅ Trabajar con Arrays y Matrices
- ✅ Usar Tuplas y Named Tuples
- ✅ Manejar Diccionarios
- ✅ Trabajar con Sets (Conjuntos)
- ✅ Crear tipos personalizados (structs)

## Conceptos Clave

```julia
# Arrays
arr = [1, 2, 3, 4, 5]
push!(arr, 6)  # Agregar elemento
pop!(arr)      # Remover último

# Matrices
matriz = [1 2 3; 4 5 6; 7 8 9]

# Tuplas (inmutables)
punto = (10, 20)
persona = (nombre="Ana", edad=25)

# Diccionarios
dict = Dict("nombre" => "Julia", "version" => 1.10)

# Sets
conjunto = Set([1, 2, 3, 2, 1])  # {1, 2, 3}

# Structs personalizados
struct Persona
    nombre::String
    edad::Int
end

# Mutable struct
mutable struct Contador
    valor::Int
end
```

## Archivos

- `01_arrays.jl` - Arrays y operaciones
- `02_diccionarios.jl` - Diccionarios y hashes
- `03_structs.jl` - Tipos personalizados

---

➡️ **Siguiente:** [Módulo 5: Programación Funcional](../modulo-05-funcional/README.md)
