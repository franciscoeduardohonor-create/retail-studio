# Módulo 1: Introducción y Fundamentos de Julia 🎯

## Objetivos del Módulo

Al finalizar este módulo serás capaz de:
- ✅ Entender la sintaxis básica de Julia
- ✅ Trabajar con variables y tipos de datos
- ✅ Realizar operaciones aritméticas y lógicas
- ✅ Manejar entrada y salida de datos
- ✅ Crear programas básicos interactivos

## 📚 Contenido

1. [Primeros Pasos](#1-primeros-pasos)
2. [Variables y Tipos de Datos](#2-variables-y-tipos-de-datos)
3. [Operadores](#3-operadores)
4. [Strings y Caracteres](#4-strings-y-caracteres)
5. [Entrada y Salida](#5-entrada-y-salida)
6. [Conversión de Tipos](#6-conversión-de-tipos)

## Archivos de Práctica

- `01_hola_mundo.jl` - Tu primer programa en Julia
- `02_variables.jl` - Variables y tipos de datos
- `03_operadores.jl` - Operadores aritméticos y lógicos
- `04_strings.jl` - Manipulación de cadenas
- `05_entrada_salida.jl` - Interacción con el usuario
- `06_conversiones.jl` - Conversión entre tipos
- `proyecto_calculadora.jl` - Proyecto: Calculadora básica
- `proyecto_conversor.jl` - Proyecto: Conversor de unidades
- `ejercicios.jl` - Ejercicios para practicar

---

## 1. Primeros Pasos

### ¿Qué hace especial a Julia?

```julia
# Julia combina velocidad y facilidad de uso
# Este código es tan rápido como C pero tan fácil como Python

function fibonacci(n)
    if n <= 2
        return 1
    else
        return fibonacci(n-1) + fibonacci(n-2)
    end
end

# La función se compila la primera vez que se ejecuta
# Las siguientes ejecuciones son extremadamente rápidas
```

### El REPL de Julia

Julia tiene un REPL (Read-Eval-Print Loop) interactivo:

```bash
$ julia
julia> 2 + 2
4

julia> println("¡Hola Julia!")
¡Hola Julia!
```

---

## 2. Variables y Tipos de Datos

### Tipos Numéricos

```julia
# Enteros
edad = 25              # Int64 (en sistemas de 64 bits)
poblacion = 1_000_000  # Puedes usar _ para legibilidad

# Flotantes
precio = 19.99         # Float64
pi_aprox = 3.14159265358979

# Números complejos
z = 3 + 4im

# Racionales
fraccion = 3//4
```

### Boolean

```julia
es_mayor = true
esta_activo = false
```

### Verificar tipos

```julia
typeof(42)        # Int64
typeof(3.14)      # Float64
typeof(true)      # Bool
typeof("hola")    # String
```

---

## 3. Operadores

### Aritméticos

```julia
10 + 5    # Suma: 15
10 - 5    # Resta: 5
10 * 5    # Multiplicación: 50
10 / 5    # División: 2.0
10 ÷ 3    # División entera: 3 (o usar div(10, 3))
10 % 3    # Módulo: 1
2 ^ 3     # Potencia: 8
```

### Comparación

```julia
5 == 5    # Igualdad: true
5 != 3    # Desigualdad: true
5 > 3     # Mayor que: true
5 < 3     # Menor que: false
5 >= 5    # Mayor o igual: true
5 <= 5    # Menor o igual: true
```

### Lógicos

```julia
true && false   # AND: false
true || false   # OR: true
!true          # NOT: false
```

---

## 4. Strings y Caracteres

### Caracteres

```julia
letra = 'a'        # Char (usa comillas simples)
unicode = '♥'      # Julia soporta Unicode nativamente
```

### Strings

```julia
nombre = "Julia"   # String (usa comillas dobles)
saludo = "¡Hola, $nombre!"  # Interpolación
mensaje = """
    Este es un string
    multi-línea
    """
```

### Operaciones con Strings

```julia
"Hola" * " " * "Mundo"     # Concatenación
"Ja" ^ 3                    # Repetición: "JaJaJa"
length("Hola")              # Longitud: 4
uppercase("hola")           # "HOLA"
lowercase("HOLA")           # "hola"
```

---

## 5. Entrada y Salida

### Salida

```julia
println("Texto con salto de línea")
print("Texto sin salto de línea")
@show variable    # Muestra variable = valor
```

### Entrada

```julia
nombre = readline()
println("Hola, $nombre")
```

---

## 6. Conversión de Tipos

```julia
# String a número
parse(Int, "42")        # 42
parse(Float64, "3.14")  # 3.14

# Número a string
string(42)              # "42"

# Conversión directa
Int(3.7)               # Error: InexactError
floor(Int, 3.7)        # 3
ceil(Int, 3.2)         # 4
round(Int, 3.5)        # 4

# Float a Int (con conversión)
convert(Int, 3.0)      # 3
```

---

## 🚀 Proyectos Prácticos

### Proyecto 1: Calculadora Básica
Crea una calculadora que realice operaciones básicas.

### Proyecto 2: Conversor de Unidades
Desarrolla un conversor de temperatura, distancia y peso.

---

## ✅ Ejercicios

Completa los ejercicios en `ejercicios.jl` para practicar:

1. Crear variables de diferentes tipos
2. Realizar cálculos matemáticos
3. Manipular strings
4. Crear programas interactivos
5. Convertir entre tipos de datos

---

## 📖 Recursos Adicionales

- [Julia Manual - Variables](https://docs.julialang.org/en/v1/manual/variables/)
- [Julia Manual - Integers and Floating-Point Numbers](https://docs.julialang.org/en/v1/manual/integers-and-floating-point-numbers/)
- [Julia Manual - Strings](https://docs.julialang.org/en/v1/manual/strings/)

---

## ➡️ Siguiente Módulo

Una vez que domines estos conceptos, continúa con el [Módulo 2: Estructuras de Control](../modulo-02-control/README.md)
