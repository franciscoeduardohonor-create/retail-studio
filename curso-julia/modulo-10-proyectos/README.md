# Módulo 10: Proyectos Prácticos Avanzados 🎓

## Objetivos

- ✅ Aplicar todos los conceptos aprendidos
- ✅ Crear proyectos completos
- ✅ Trabajar con librerías del ecosistema
- ✅ Análisis de datos real
- ✅ Visualización

## Proyectos

### Proyecto 1: Análisis de Datos con DataFrames

```julia
using DataFrames, CSV, Statistics

# Cargar datos
df = CSV.read("ventas.csv", DataFrame)

# Análisis exploratorio
describe(df)
mean(df.precio)
groupby(df, :categoria)

# Transformaciones
df.total = df.precio .* df.cantidad
filter(row -> row.total > 100, df)
```

### Proyecto 2: Visualización con Plots

```julia
using Plots

# Gráfico de línea
x = 1:10
y = x.^2
plot(x, y, label="y = x²")

# Scatter plot
scatter(rand(50), rand(50))

# Histograma
histogram(randn(1000), bins=30)
```

### Proyecto 3: Machine Learning Básico

```julia
using MLJ, DataFrames

# Cargar datos
X = rand(100, 5)
y = rand(100)

# Modelo simple
model = @load LinearRegressor
mach = machine(model, X, y)
fit!(mach)
```

### Proyecto 4: Web Scraping

```julia
using HTTP, Gumbo, Cascadia

# Descargar página
response = HTTP.get("https://example.com")
html = parsehtml(String(response.body))

# Extraer información
titles = eachmatch(Selector("h1"), html.root)
```

### Proyecto 5: API REST

```julia
using HTTP, JSON3

# GET request
response = HTTP.get("https://api.example.com/data")
data = JSON3.read(response.body)

# POST request
payload = Dict("nombre" => "Julia")
HTTP.post("https://api.example.com/users",
    headers=["Content-Type" => "application/json"],
    body=JSON3.write(payload))
```

## Proyecto Final Integrador

Crea un sistema completo que incluya:
- Lectura de datos (CSV/JSON/API)
- Procesamiento y limpieza
- Análisis estadístico
- Visualización
- Exportación de resultados
- Tests unitarios
- Documentación completa

---

🎉 **¡Felicitaciones! Has completado el curso de Julia**

## Próximos Pasos

1. Practica con proyectos propios
2. Contribuye a paquetes de Julia
3. Explora el ecosistema: JuliaData, JuliaML, JuliaStats
4. Únete a la comunidad Julia
5. Comparte tu conocimiento

## Recursos Adicionales

- [Julia Docs](https://docs.julialang.org/)
- [JuliaHub](https://juliahub.com/)
- [Julia Discourse](https://discourse.julialang.org/)
- [Julia YouTube](https://www.youtube.com/user/JuliaLanguage)
- [Julia Slack](https://julialang.org/slack/)
