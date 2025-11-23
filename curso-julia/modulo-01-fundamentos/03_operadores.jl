#!/usr/bin/env julia
# ============================================================================
# MÓDULO 1 - EJEMPLO 3: Operadores en Julia
# ============================================================================
# En este archivo aprenderás:
# - Operadores aritméticos
# - Operadores de comparación
# - Operadores lógicos
# - Operadores de asignación
# - Precedencia de operadores

println("=" ^ 70)
println("🔢 OPERADORES EN JULIA")
println("=" ^ 70)
println()

# ============================================================================
# 1. OPERADORES ARITMÉTICOS BÁSICOS
# ============================================================================

println("--- 1. Operadores Aritméticos Básicos ---")
println()

a = 10
b = 3

# Operaciones básicas
suma = a + b
resta = a - b
multiplicacion = a * b
division = a / b

println("a = $a, b = $b")
println()
println("Suma:            $a + $b = $suma")
println("Resta:           $a - $b = $resta")
println("Multiplicación:  $a × $b = $multiplicacion")
println("División:        $a ÷ $b = $division")
println()

# ============================================================================
# 2. OPERADORES DE DIVISIÓN Y MÓDULO
# ============================================================================

println("--- 2. División y Módulo ---")
println()

# División normal (siempre retorna Float)
division_normal = 10 / 3
println("División normal:      10 / 3 = $division_normal")

# División entera (descarta decimales)
division_entera = 10 ÷ 3  # También: div(10, 3)
println("División entera:      10 ÷ 3 = $division_entera")

# Módulo (residuo de la división)
modulo = 10 % 3
println("Módulo (residuo):     10 % 3 = $modulo")

# Función divrem (división y residuo al mismo tiempo)
cociente, residuo = divrem(10, 3)
println("divrem(10, 3) → cociente: $cociente, residuo: $residuo")
println()

# Ejemplos prácticos del módulo
println("Ejemplos prácticos del módulo (%):")
println("  ¿Es 10 par? $(10 % 2 == 0)")
println("  ¿Es 15 par? $(15 % 2 == 0)")
println("  ¿Es 21 divisible por 3? $(21 % 3 == 0)")
println()

# ============================================================================
# 3. POTENCIA Y RAÍCES
# ============================================================================

println("--- 3. Potencia y Raíces ---")
println()

# Potencia
potencia = 2^8
println("Potencia:       2⁸ = $potencia")
println("               3⁴ = $(3^4)")
println("               5³ = $(5^3)")
println()

# Raíces
raiz_cuadrada = √16        # También: sqrt(16)
raiz_cubica = ∛27          # También: cbrt(27)

println("Raíz cuadrada:  √16 = $raiz_cuadrada")
println("Raíz cúbica:    ∛27 = $raiz_cubica")
println("Raíz n-ésima:   16^(1/4) = $(16^(1/4))")  # Raíz cuarta
println()

# ============================================================================
# 4. OPERADORES DE ACTUALIZACIÓN (+=, -=, etc.)
# ============================================================================

println("--- 4. Operadores de Actualización ---")
println()

contador = 10
println("Valor inicial: contador = $contador")

# Incrementar
contador += 5  # Equivalente a: contador = contador + 5
println("Después de +=5: contador = $contador")

# Decrementar
contador -= 3  # Equivalente a: contador = contador - 3
println("Después de -=3: contador = $contador")

# Multiplicar
contador *= 2  # Equivalente a: contador = contador * 2
println("Después de *=2: contador = $contador")

# Dividir
contador /= 4  # Equivalente a: contador = contador / 4
println("Después de /=4: contador = $contador")
println()

# Otros operadores de actualización
x = 10
x ^= 2    # x = x^2
println("10^2 usando ^=: $x")
println()

# ============================================================================
# 5. OPERADORES DE COMPARACIÓN
# ============================================================================

println("--- 5. Operadores de Comparación ---")
println()

x = 10
y = 20
z = 10

println("x = $x, y = $y, z = $z")
println()

# Igualdad y desigualdad
println("x == z  (igual):           $(x == z)")
println("x == y  (igual):           $(x == y)")
println("x != y  (diferente):       $(x != y)")
println()

# Comparaciones numéricas
println("x < y   (menor que):       $(x < y)")
println("x > y   (mayor que):       $(x > y)")
println("x <= z  (menor o igual):   $(x <= z)")
println("x >= z  (mayor o igual):   $(x >= z)")
println()

# Comparaciones encadenadas (¡muy útil!)
println("Comparaciones encadenadas:")
println("1 < 2 < 3:                 $(1 < 2 < 3)")
println("1 < 2 < 1:                 $(1 < 2 < 1)")
println("10 <= x <= 100:            $(10 <= x <= 100)")
println()

# ============================================================================
# 6. OPERADORES LÓGICOS
# ============================================================================

println("--- 6. Operadores Lógicos ---")
println()

verdadero = true
falso = false

# AND lógico (&&)
println("AND lógico (&&):")
println("  true && true   = $(true && true)")
println("  true && false  = $(true && false)")
println("  false && false = $(false && false)")
println()

# OR lógico (||)
println("OR lógico (||):")
println("  true || false  = $(true || false)")
println("  false || false = $(false || false)")
println("  false || true  = $(false || true)")
println()

# NOT lógico (!)
println("NOT lógico (!):")
println("  !true  = $(!true)")
println("  !false = $(!false)")
println()

# ============================================================================
# 7. EVALUACIÓN DE CORTOCIRCUITO
# ============================================================================

println("--- 7. Evaluación de Cortocircuito ---")
println()

# && (AND): Si el primero es falso, no evalúa el segundo
println("Cortocircuito con &&:")
x = 5
resultado = (x > 10) && (println("Esto no se imprime"); true)
println("Resultado: $resultado")
println()

resultado = (x > 0) && (println("Esto SÍ se imprime"); true)
println("Resultado: $resultado")
println()

# || (OR): Si el primero es verdadero, no evalúa el segundo
println("Cortocircuito con ||:")
resultado = (x > 0) || (println("Esto no se imprime"); true)
println("Resultado: $resultado")
println()

# ============================================================================
# 8. OPERADORES CON STRINGS
# ============================================================================

println("--- 8. Operadores con Strings ---")
println()

# Concatenación con *
nombre = "Julia"
apellido = "Lang"
nombre_completo = nombre * " " * apellido
println("Concatenación (*):    \"$nombre\" * \" \" * \"$apellido\" = \"$nombre_completo\"")

# Repetición con ^
risa = "Ja" ^ 5
println("Repetición (^):       \"Ja\" ^ 5 = \"$risa\"")

# Interpolación con $
edad = 10
mensaje = "El lenguaje $nombre tiene $edad años"
println("Interpolación (\$):    \"$mensaje\"")
println()

# ============================================================================
# 9. OPERADOR TERNARIO (CONDICIONAL)
# ============================================================================

println("--- 9. Operador Ternario ---")
println()

# Sintaxis: condicion ? valor_si_true : valor_si_false
edad = 18
mensaje = edad >= 18 ? "Mayor de edad" : "Menor de edad"
println("Edad: $edad → $mensaje")

numero = 7
paridad = numero % 2 == 0 ? "par" : "impar"
println("El número $numero es $paridad")

temperatura = 25
clima = temperatura > 30 ? "Calor" : temperatura > 20 ? "Agradable" : "Frío"
println("$temperatura°C → $clima")
println()

# ============================================================================
# 10. OPERADORES BIT A BIT (BITWISE)
# ============================================================================

println("--- 10. Operadores Bit a Bit ---")
println()

a = 12  # 1100 en binario
b = 10  # 1010 en binario

println("a = $a ($(string(a, base=2, pad=4)) en binario)")
println("b = $b ($(string(b, base=2, pad=4)) en binario)")
println()

# AND bit a bit
and_result = a & b
println("a & b  (AND):    $and_result ($(string(and_result, base=2, pad=4)))")

# OR bit a bit
or_result = a | b
println("a | b  (OR):     $or_result ($(string(or_result, base=2, pad=4)))")

# XOR bit a bit
xor_result = a ⊻ b  # También: xor(a, b)
println("a ⊻ b  (XOR):    $xor_result ($(string(xor_result, base=2, pad=4)))")

# NOT bit a bit
not_result = ~a
println("~a     (NOT):    $not_result")
println()

# Desplazamientos de bits
left_shift = a << 2   # Desplazar a la izquierda
right_shift = a >> 2  # Desplazar a la derecha
println("a << 2 (shift izq):  $left_shift")
println("a >> 2 (shift der):  $right_shift")
println()

# ============================================================================
# 11. PRECEDENCIA DE OPERADORES
# ============================================================================

println("--- 11. Precedencia de Operadores ---")
println()

# Julia sigue el orden estándar de operaciones (PEMDAS)
# Paréntesis > Exponentes > Multiplicación/División > Suma/Resta

resultado1 = 2 + 3 * 4
println("2 + 3 × 4 = $resultado1  (multiplicación primero)")

resultado2 = (2 + 3) * 4
println("(2 + 3) × 4 = $resultado2  (paréntesis primero)")

resultado3 = 2^3 * 4
println("2³ × 4 = $resultado3  (potencia primero)")

resultado4 = 2 * 3^2
println("2 × 3² = $resultado4  (potencia antes que multiplicación)")
println()

# ============================================================================
# 12. COMPARACIÓN DE TIPOS
# ============================================================================

println("--- 12. Operadores de Tipo ---")
println()

# isa() verifica si un valor es de un tipo específico
numero = 42
println("42 isa Int:        $(numero isa Int)")
println("42 isa Float64:    $(numero isa Float64)")
println("42 isa Number:     $(numero isa Number)")
println()

texto = "Hola"
println("\"Hola\" isa String: $(texto isa String)")
println("\"Hola\" isa Int:    $(texto isa Int)")
println()

# typeof() vs isa()
println("typeof(42) == Int64:  $(typeof(42) == Int64)")
println("42 isa Int64:         $(42 isa Int64)")
println()

# ============================================================================
# 13. OPERADOR DE COMPOSICIÓN (∘)
# ============================================================================

println("--- 13. Composición de Funciones ---")
println()

# El operador ∘ compone funciones: (f ∘ g)(x) = f(g(x))
# Escribe \circ + TAB para obtener ∘

# Ejemplo: aplicar sqrt y luego redondear
f = round ∘ sqrt
resultado = f(17)
println("(round ∘ sqrt)(17) = $resultado")
println("Equivalente a: round(sqrt(17)) = $(round(sqrt(17)))")
println()

# ============================================================================
# 14. OPERADOR PIPE (|>)
# ============================================================================

println("--- 14. Operador Pipe ---")
println()

# El operador |> pasa el resultado de una función a otra
# Similar a Unix pipes

resultado = 16 |> sqrt |> x -> x * 2
println("16 |> sqrt |> (x -> x * 2) = $resultado")

# Equivalente a:
# x = 16
# x = sqrt(x)     # x = 4
# x = x * 2       # x = 8
println()

# Ejemplo más práctico
texto = "  HOLA MUNDO  " |> strip |> lowercase
println("\"  HOLA MUNDO  \" |> strip |> lowercase = \"$texto\"")
println()

# ============================================================================
# 15. EJEMPLOS PRÁCTICOS COMBINADOS
# ============================================================================

println("--- 15. Ejemplos Prácticos ---")
println()

# Ejemplo 1: Calcular el área de un círculo
radio = 5
area = π * radio^2
println("📊 Área de un círculo con radio $radio:")
println("   A = π × r² = π × $radio² = $area")
println()

# Ejemplo 2: Convertir temperatura
celsius = 25
fahrenheit = celsius * 9/5 + 32
println("🌡️  Conversión de temperatura:")
println("   $celsius°C = $fahrenheit°F")
println()

# Ejemplo 3: Calcular el IMC
peso = 70  # kg
altura = 1.75  # metros
imc = peso / altura^2
categoria = imc < 18.5 ? "Bajo peso" : imc < 25 ? "Normal" : imc < 30 ? "Sobrepeso" : "Obesidad"
println("⚕️  Índice de Masa Corporal:")
println("   Peso: $peso kg, Altura: $altura m")
println("   IMC = $peso / $altura² = $(round(imc, digits=2))")
println("   Categoría: $categoria")
println()

# Ejemplo 4: Determinar si un año es bisiesto
año = 2024
es_bisiesto = (año % 4 == 0 && año % 100 != 0) || (año % 400 == 0)
println("📅 ¿Es $año un año bisiesto?")
println("   $(es_bisiesto ? "Sí" : "No")")
println()

# ============================================================================
# 16. EJERCICIOS PRÁCTICOS
# ============================================================================

println("=" ^ 70)
println("🎯 EJERCICIOS PARA PRACTICAR:")
println("=" ^ 70)
println()
println("1. Operaciones básicas:")
println("   Dados a=15 y b=4, calcula:")
println("   - La suma, resta, multiplicación y división")
println("   - El residuo de a/b")
println("   - a elevado a la b")
println()
println("2. Comparaciones:")
println("   Dado x=25, determina si:")
println("   - x es mayor que 20")
println("   - x está entre 10 y 30 (usa comparación encadenada)")
println("   - x es par o impar")
println()
println("3. Lógica:")
println("   Tienes edad=17, licencia=true")
println("   - ¿Puede conducir? (edad >= 18 && licencia)")
println("   - ¿Necesita permiso parental? (edad < 18)")
println()
println("4. Aplicación práctica:")
println("   Calcula el precio final de un producto:")
println("   - Precio base: 100")
println("   - Descuento: 15%")
println("   - Impuesto: 16%")
println("   (Aplica descuento primero, luego impuesto)")
println()
println("5. Conversiones:")
println("   Convierte 100 millas a kilómetros (1 milla = 1.60934 km)")
println("   Convierte 5 pies y 10 pulgadas a centímetros")
println()

# ============================================================================
# TU CÓDIGO AQUÍ:
# ============================================================================

println("--- TUS SOLUCIONES ---")
println()

# Ejercicio 1:


# Ejercicio 2:


# Ejercicio 3:


# Ejercicio 4:


# Ejercicio 5:


# ============================================================================

println()
println("=" ^ 70)
println("✅ ¡Programa completado!")
println("=" ^ 70)
println()
println("💡 Conceptos clave aprendidos:")
println("   ✓ Operadores aritméticos (+, -, *, /, ^, %, ÷)")
println("   ✓ Operadores de comparación (==, !=, <, >, <=, >=)")
println("   ✓ Operadores lógicos (&&, ||, !)")
println("   ✓ Operador ternario (? :)")
println("   ✓ Operadores de actualización (+=, -=, *=, /=)")
println("   ✓ Precedencia de operadores")
println()
println("📚 Próximo paso: 04_strings.jl")
println("=" ^ 70)
