#!/usr/bin/env julia
# ============================================================================
# MÓDULO 1 - EJEMPLO 1: Hola Mundo y Primeros Pasos
# ============================================================================
# Este es tu primer programa en Julia. Aprenderás:
# - Cómo imprimir texto en la consola
# - Comentarios en Julia
# - Ejecución básica de código

println("=" ^ 60)
println("🎉 ¡BIENVENIDO A JULIA! 🎉")
println("=" ^ 60)

# ============================================================================
# 1. IMPRIMIENDO EN LA CONSOLA
# ============================================================================

# println() imprime texto y añade un salto de línea al final
println("¡Hola, Mundo!")
println("Este es mi primer programa en Julia")

# print() imprime texto SIN salto de línea
print("Hola ")
print("desde ")
println("Julia!")

println()  # Línea en blanco

# ============================================================================
# 2. COMENTARIOS
# ============================================================================

# Esto es un comentario de una línea
# Los comentarios ayudan a explicar el código

#=
Esto es un comentario
de múltiples líneas.
Útil para explicaciones más largas.
=#

# ============================================================================
# 3. OPERACIONES MATEMÁTICAS SIMPLES
# ============================================================================

println("--- Matemáticas Básicas ---")

# Julia puede usarse como una calculadora
println("2 + 2 = ", 2 + 2)
println("10 - 3 = ", 10 - 3)
println("4 × 5 = ", 4 * 5)
println("20 ÷ 4 = ", 20 / 4)
println("2³ = ", 2 ^ 3)

println()

# ============================================================================
# 4. EXPRESIONES MATEMÁTICAS COMPLEJAS
# ============================================================================

println("--- Cálculos más Complejos ---")

# Julia respeta el orden de operaciones (PEMDAS)
resultado = 2 + 3 * 4
println("2 + 3 × 4 = $resultado")  # 14 (no 20)

# Usando paréntesis para cambiar la prioridad
resultado = (2 + 3) * 4
println("(2 + 3) × 4 = $resultado")  # 20

# Expresión matemática compleja
area_circulo = 3.14159 * 5^2
println("Área de un círculo con radio 5: $area_circulo")

println()

# ============================================================================
# 5. UNICODE Y SÍMBOLOS MATEMÁTICOS
# ============================================================================

println("--- Unicode en Julia ---")

# Julia soporta caracteres Unicode nativamente
# Esto hace que el código sea más expresivo y cercano a la notación matemática

# Puedes usar π (pi) directamente
# Escribe \pi y presiona TAB en el REPL para obtener π
println("π ≈ ", π)
println("Área del círculo: π × 5² = ", π * 5^2)

# Otros símbolos útiles:
# α (alpha): \alpha + TAB
# β (beta): \beta + TAB
# Σ (sigma): \Sigma + TAB
# √ (raíz cuadrada): \sqrt + TAB

println("√16 = ", √16)  # 4.0
println("∛27 = ", ∛27)  # 3.0 (raíz cúbica)

println()

# ============================================================================
# 6. INTERPOLACIÓN DE STRINGS
# ============================================================================

println("--- Interpolación de Strings ---")

# Puedes insertar valores en strings usando $
nombre = "Julia"
version = 1.10

println("Estoy aprendiendo $nombre versión $version")

# Para expresiones más complejas, usa $()
x = 10
y = 20
println("La suma de $x y $y es $(x + y)")

println()

# ============================================================================
# 7. INFORMACIÓN DEL SISTEMA
# ============================================================================

println("--- Información del Sistema ---")

# Muestra información sobre tu instalación de Julia
println("Versión de Julia: ", VERSION)
println("Sistema operativo: ", Sys.KERNEL)
println("Arquitectura: ", Sys.ARCH)
println("Número de CPUs: ", Sys.CPU_THREADS)

println()

# ============================================================================
# 8. TIEMPO Y FECHA
# ============================================================================

println("--- Fecha y Hora ---")

using Dates  # Importamos el módulo de fechas

# Obtener la fecha y hora actual
ahora = now()
println("Fecha y hora actual: $ahora")

# Solo la fecha
hoy = today()
println("Fecha de hoy: $hoy")

# Componentes de la fecha
println("Año: ", year(hoy))
println("Mes: ", month(hoy))
println("Día: ", day(hoy))

println()

# ============================================================================
# 9. EMOJIS Y CARACTERES ESPECIALES
# ============================================================================

println("--- Julia y Emojis 😎 ---")

# Julia soporta emojis en strings (¡e incluso en nombres de variables!)
println("Julia es genial! 🚀")
println("Matemáticas: ∫ f(x)dx desde a hasta b")
println("Ciencia: E = mc²")
println("Aprobado: ✅ | Error: ❌ | Advertencia: ⚠️")

println()

# ============================================================================
# 10. EJERCICIO PRÁCTICO
# ============================================================================

println("=" ^ 60)
println("🎯 EJERCICIO PARA TI:")
println("=" ^ 60)
println()
println("1. Modifica este archivo para imprimir tu nombre")
println("2. Calcula tu edad en días (edad × 365)")
println("3. Calcula el área de un rectángulo de 7 × 12")
println("4. Experimenta con otros símbolos Unicode")
println("5. Agrega tus propios mensajes creativos")
println()

# ============================================================================
# TU CÓDIGO AQUÍ:
# ============================================================================

# Escribe tu código debajo de esta línea


# ============================================================================

println("=" ^ 60)
println("✅ ¡Programa completado exitosamente!")
println("=" ^ 60)

# ============================================================================
# NOTAS IMPORTANTES:
# ============================================================================
#
# 💡 Cómo ejecutar este archivo:
#
# Opción 1 - Desde la terminal:
#   julia 01_hola_mundo.jl
#
# Opción 2 - Desde el REPL de Julia:
#   include("01_hola_mundo.jl")
#
# 💡 Experimentos sugeridos:
#   - Cambia los mensajes y vuelve a ejecutar
#   - Prueba diferentes operaciones matemáticas
#   - Agrega tus propios comentarios
#   - Usa diferentes símbolos Unicode
#
# ============================================================================
