# Módulo 6: Manejo de Archivos y E/S 📁

## Objetivos

- ✅ Leer y escribir archivos de texto
- ✅ Trabajar con CSV y JSON
- ✅ Serialización de datos
- ✅ Manejo de rutas y directorios

## Conceptos Clave

```julia
# Escribir archivo
open("archivo.txt", "w") do file
    write(file, "Hola Julia!\n")
end

# Leer archivo
contenido = read("archivo.txt", String)

# Leer línea por línea
lines = readlines("archivo.txt")

# CSV
using CSV, DataFrames
df = CSV.read("datos.csv", DataFrame)

# JSON
using JSON
data = Dict("nombre" => "Julia", "version" => 1.10)
json_str = JSON.json(data)
parsed = JSON.parse(json_str)
```

---

➡️ **Siguiente:** [Módulo 7: Módulos y Paquetes](../modulo-07-modulos/README.md)
