#!/usr/bin/env julia
# ============================================================================
# MÓDULO 2 - BUCLES FOR
# ============================================================================

println("🔁 BUCLES FOR EN JULIA\n")

# For básico con rango
println("--- Bucle for básico ---")
for i in 1:5
    println("Iteración $i")
end

# For con step
println("\n--- Con step ---")
for i in 0:2:10  # De 0 a 10, de 2 en 2
    println(i)
end

# For con arrays
println("\n--- Iterando arrays ---")
frutas = ["🍎 Manzana", "🍊 Naranja", "🍌 Plátano"]
for fruta in frutas
    println(fruta)
end

# For con enumerate (índice y valor)
println("\n--- Con enumerate ---")
for (indice, fruta) in enumerate(frutas)
    println("$indice: $fruta")
end

# For con zip (múltiples arrays)
println("\n--- Con zip ---")
nombres = ["Ana", "Juan", "María"]
edades = [25, 30, 28]
for (nombre, edad) in zip(nombres, edades)
    println("$nombre tiene $edad años")
end

# For anidado
println("\n--- For anidado (tabla de multiplicar) ---")
for i in 1:3
    for j in 1:3
        println("$i × $j = $(i*j)")
    end
end

# Comprehension (forma concisa)
println("\n--- List comprehension ---")
cuadrados = [x^2 for x in 1:10]
println("Cuadrados: $cuadrados")

pares = [x for x in 1:20 if x % 2 == 0]
println("Pares: $pares")

println("\n✅ Bucles for completados!")
