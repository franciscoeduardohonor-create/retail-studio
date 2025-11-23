#!/usr/bin/env julia
# ============================================================================
# MÓDULO 4 - ARRAYS Y MATRICES
# ============================================================================

println("📊 ARRAYS EN JULIA\n")

# Arrays básicos
numeros = [1, 2, 3, 4, 5]
println("Array: $numeros")

# Operaciones comunes
push!(numeros, 6)           # Agregar al final
println("Después de push!: $numeros")

pop!(numeros)               # Remover último
println("Después de pop!: $numeros")

# Acceso por índice
println("Primer elemento: $(numeros[1])")
println("Último elemento: $(numeros[end])")

# Slicing
println("Primeros 3: $(numeros[1:3])")

# Arrays de diferentes tipos
strings = ["hola", "mundo"]
mixto = [1, "dos", 3.0, true]
println("Array mixto: $mixto")

# Operaciones vectorizadas
cuadrados = numeros .^ 2
println("Cuadrados: $cuadrados")

# Matrices
matriz = [1 2 3; 4 5 6; 7 8 9]
println("\nMatriz:")
display(matriz)

# Acceso a elementos
println("\nElemento [2,3]: $(matriz[2,3])")
println("Fila 2: $(matriz[2,:])")
println("Columna 3: $(matriz[:,3])")

# Funciones útiles
println("\nFunciones:")
println("length: $(length(numeros))")
println("sum: $(sum(numeros))")
println("maximum: $(maximum(numeros))")
println("minimum: $(minimum(numeros))")
println("mean: $(sum(numeros)/length(numeros))")

# Comprensiones
pares = [x for x in 1:20 if x % 2 == 0]
println("\nPares: $pares")

matriz_comp = [i+j for i in 1:3, j in 1:3]
println("Matriz por comprensión:")
display(matriz_comp)

println("\n✅ Arrays completados!")
