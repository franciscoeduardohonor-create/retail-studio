#!/usr/bin/env julia
# ============================================================================
# MÓDULO 3 - FUNCIONES BÁSICAS
# ============================================================================

println("🎯 FUNCIONES EN JULIA\n")

# ============================================================================
# 1. DEFINICIÓN BÁSICA
# ============================================================================

function saludar(nombre)
    return "¡Hola, $nombre!"
end

println(saludar("Julia"))

# Forma compacta (una línea)
cuadrado(x) = x^2
println("Cuadrado de 5: $(cuadrado(5))")

# ============================================================================
# 2. MÚLTIPLES RETORNOS
# ============================================================================

function dividir_con_residuo(a, b)
    cociente = a ÷ b
    residuo = a % b
    return cociente, residuo
end

q, r = dividir_con_residuo(17, 5)
println("17 ÷ 5 = $q con residuo $r")

# ============================================================================
# 3. ARGUMENTOS OPCIONALES
# ============================================================================

function saludar_personalizado(nombre, saludo="Hola")
    return "$saludo, $nombre!"
end

println(saludar_personalizado("Ana"))
println(saludar_personalizado("Ana", "Buenos días"))

# ============================================================================
# 4. KEYWORD ARGUMENTS
# ============================================================================

function crear_usuario(nombre; edad=18, ciudad="Madrid", activo=true)
    println("Usuario: $nombre")
    println("  Edad: $edad")
    println("  Ciudad: $ciudad")
    println("  Activo: $activo")
end

crear_usuario("María", edad=25, ciudad="Barcelona")

# ============================================================================
# 5. FUNCIONES CON TIPOS
# ============================================================================

function sumar(a::Int, b::Int)
    return a + b
end

println("Suma con tipos: $(sumar(3, 5))")

# ============================================================================
# 6. FUNCIONES ANÓNIMAS (LAMBDA)
# ============================================================================

# Asignadas a variable
doble = x -> x * 2
println("Doble de 7: $(doble(7))")

# Con map
numeros = [1, 2, 3, 4, 5]
cuadrados = map(x -> x^2, numeros)
println("Cuadrados: $cuadrados")

# Con filter
pares = filter(x -> x % 2 == 0, numeros)
println("Pares: $pares")

# ============================================================================
# 7. MÚLTIPLE DISPATCH
# ============================================================================

# Misma función, diferentes tipos
describir(x::Int) = "Esto es un entero: $x"
describir(x::Float64) = "Esto es un flotante: $x"
describir(x::String) = "Esto es un string: $x"

println(describir(42))
println(describir(3.14))
println(describir("Hola"))

# ============================================================================
# 8. FUNCIONES RECURSIVAS
# ============================================================================

function factorial(n)
    if n <= 1
        return 1
    else
        return n * factorial(n - 1)
    end
end

println("Factorial de 5: $(factorial(5))")

function fibonacci(n)
    if n <= 2
        return 1
    else
        return fibonacci(n-1) + fibonacci(n-2)
    end
end

println("Fibonacci(7): $(fibonacci(7))")

# ============================================================================
# 9. EJEMPLO PRÁCTICO: VALIDACIONES
# ============================================================================

function validar_email(email::String)
    if !contains(email, "@")
        return (false, "Falta el símbolo @")
    elseif !contains(email, ".")
        return (false, "Falta el dominio")
    else
        return (true, "Email válido")
    end
end

emails = ["user@example.com", "invalid", "test@domain."]
for email in emails
    valido, mensaje = validar_email(email)
    status = valido ? "✅" : "❌"
    println("$status $email: $mensaje")
end

# ============================================================================
# 10. EJERCICIOS
# ============================================================================

println("\n🎯 Ejercicios:")
println("1. Crea una función que calcule el área de un círculo")
println("2. Crea una función que determine si un número es primo")
println("3. Crea una función que revierta un string")

println("\n✅ Funciones básicas completadas!")
