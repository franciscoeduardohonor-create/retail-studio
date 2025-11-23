# Módulo 3: Funciones y Multiple Dispatch 🎯

## Objetivos

- ✅ Definir y llamar funciones
- ✅ Usar argumentos y valores de retorno
- ✅ Entender multiple dispatch
- ✅ Crear funciones anónimas
- ✅ Trabajar con argumentos opcionales y keyword arguments

## Archivos

- `01_funciones_basicas.jl` - Definición y uso
- `02_multiple_dispatch.jl` - Sistema de tipos
- `03_funciones_anonimas.jl` - Lambda functions
- `04_argumentos_avanzados.jl` - Args opcionales y keywords

## Conceptos Clave

```julia
# Función básica
function saludar(nombre)
    return "¡Hola, $nombre!"
end

# Forma compacta
cuadrado(x) = x^2

# Multiple dispatch
f(x::Int) = "Entero: $x"
f(x::Float64) = "Flotante: $x"

# Función anónima
map(x -> x^2, [1,2,3,4,5])

# Argumentos opcionales
function potencia(base, exponente=2)
    return base^exponente
end

# Keyword arguments
function crear_perfil(nombre; edad=0, ciudad="Desconocida")
    println("$nombre, $edad años, de $ciudad")
end
```

---

➡️ **Siguiente:** [Módulo 4: Tipos y Estructuras](../modulo-04-tipos/README.md)
