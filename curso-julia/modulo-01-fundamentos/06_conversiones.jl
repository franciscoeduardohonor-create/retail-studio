#!/usr/bin/env julia
# ============================================================================
# MÓDULO 1 - EJEMPLO 6: Conversión de Tipos
# ============================================================================
# En este archivo aprenderás:
# - Conversión entre tipos numéricos
# - Conversión entre strings y números
# - Funciones de conversión
# - Manejo de errores en conversiones

println("=" ^ 70)
println("🔄 CONVERSIÓN DE TIPOS EN JULIA")
println("=" ^ 70)
println()

# ============================================================================
# 1. CONVERSIÓN ENTRE TIPOS NUMÉRICOS
# ============================================================================

println("--- 1. Conversión entre Tipos Numéricos ---")
println()

# Int a Float
entero = 42
flotante = Float64(entero)
println("Int a Float64:")
println("  $entero (Int) → $flotante (Float64)")
println()

# Float a Int (debe ser exacto)
numero_exacto = 10.0
entero_convertido = Int(numero_exacto)
println("Float a Int (exacto):")
println("  $numero_exacto (Float) → $entero_convertido (Int)")
println()

# Float a Int con redondeo
numero_decimal = 3.7

println("Float a Int con redondeo:")
println("  Original: $numero_decimal")
println("  floor (piso):   $(floor(Int, numero_decimal))")   # 3
println("  ceil (techo):   $(ceil(Int, numero_decimal))")    # 4
println("  round (redondeo): $(round(Int, numero_decimal))") # 4
println("  trunc (truncar):  $(trunc(Int, numero_decimal))") # 3
println()

# ============================================================================
# 2. PARSE() - STRING A NÚMERO
# ============================================================================

println("--- 2. parse() - String a Número ---")
println()

# String a Int
texto_numero = "42"
numero = parse(Int, texto_numero)
println("String a Int:")
println("  \"$texto_numero\" → $numero ($(typeof(numero)))")
println()

# String a Float
texto_decimal = "3.14159"
decimal = parse(Float64, texto_decimal)
println("String a Float:")
println("  \"$texto_decimal\" → $decimal ($(typeof(decimal)))")
println()

# Diferentes bases numéricas
binario_str = "1010"
binario_num = parse(Int, binario_str, base=2)
println("String binario a Int:")
println("  \"$binario_str\" (base 2) → $binario_num")
println()

hexadecimal_str = "FF"
hex_num = parse(Int, hexadecimal_str, base=16)
println("String hexadecimal a Int:")
println("  \"$hexadecimal_str\" (base 16) → $hex_num")
println()

# ============================================================================
# 3. STRING() - NÚMERO A STRING
# ============================================================================

println("--- 3. string() - Número a String ---")
println()

# Int a String
numero = 42
texto = string(numero)
println("Int a String:")
println("  $numero → \"$texto\" ($(typeof(texto)))")
println()

# Float a String
pi_valor = 3.14159
pi_texto = string(pi_valor)
println("Float a String:")
println("  $pi_valor → \"$pi_texto\"")
println()

# Múltiples valores a String
resultado = string("El resultado es: ", 42, " y π ≈ ", π)
println("Concatenar múltiples valores:")
println("  \"$resultado\"")
println()

# ============================================================================
# 4. TRYPARSE() - CONVERSIÓN SEGURA
# ============================================================================

println("--- 4. tryparse() - Conversión Segura ---")
println()

# tryparse() retorna nothing si falla en lugar de error
valido = "123"
invalido = "abc"

resultado_valido = tryparse(Int, valido)
resultado_invalido = tryparse(Int, invalido)

println("tryparse() con entrada válida:")
println("  \"$valido\" → $resultado_valido")
println()

println("tryparse() con entrada inválida:")
println("  \"$invalido\" → $resultado_invalido")
println()

# Uso práctico con verificación
function convertir_a_numero(texto)
    resultado = tryparse(Int, texto)
    if resultado === nothing
        println("❌ \"$texto\" no es un número válido")
        return 0
    else
        println("✅ \"$texto\" convertido a $resultado")
        return resultado
    end
end

println("Ejemplos de uso:")
convertir_a_numero("42")
convertir_a_numero("xyz")
println()

# ============================================================================
# 5. CONVERT() - CONVERSIÓN GENÉRICA
# ============================================================================

println("--- 5. convert() - Conversión Genérica ---")
println()

# convert() es más flexible que las funciones de constructores
x = 10
y = convert(Float64, x)
println("convert(Float64, $x) = $y")

# Con arrays
array_int = [1, 2, 3, 4, 5]
array_float = convert(Array{Float64}, array_int)
println("Array Int a Float:")
println("  $array_int → $array_float")
println()

# ============================================================================
# 6. CONVERSIÓN DE BOOLEANOS
# ============================================================================

println("--- 6. Conversión de Booleanos ---")
println()

# Bool a Int
verdadero = true
falso = false
println("Bool a Int:")
println("  true → $(Int(verdadero))")
println("  false → $(Int(falso))")
println()

# Int a Bool (0 es false, cualquier otro es true)
println("Int a Bool:")
println("  0 → $(Bool(0))")
println("  1 → $(Bool(1))")
println("  -5 → $(Bool(-5))")
println()

# ============================================================================
# 7. CONVERSIÓN DE CARACTERES
# ============================================================================

println("--- 7. Conversión de Caracteres ---")
println()

# Char a Int (código Unicode)
letra = 'A'
codigo = Int(letra)
println("Char a Int (código Unicode):")
println("  '$letra' → $codigo")
println()

# Int a Char
numero = 65
caracter = Char(numero)
println("Int a Char:")
println("  $numero → '$caracter'")
println()

# Ejemplos adicionales
println("Códigos Unicode de caracteres comunes:")
for c in ['a', 'Z', '0', '9', '!', '😊']
    println("  '$c' → $(Int(c))")
end
println()

# ============================================================================
# 8. CONVERSIÓN DE STRINGS Y CARACTERES
# ============================================================================

println("--- 8. Conversión entre String y Char ---")
println()

# Char a String
caracter = 'A'
texto = string(caracter)
println("Char a String:")
println("  '$caracter' → \"$texto\"")
println()

# String a Char (solo si es de longitud 1)
texto_corto = "B"
if length(texto_corto) == 1
    char_convertido = texto_corto[1]
    println("String a Char:")
    println("  \"$texto_corto\" → '$char_convertido'")
end
println()

# String a Array de Chars
palabra = "Hola"
chars = collect(palabra)
println("String a Array de Chars:")
println("  \"$palabra\" → $chars")
println()

# Array de Chars a String
chars_array = ['J', 'u', 'l', 'i', 'a']
palabra_reconstruida = string(chars_array...)
println("Array de Chars a String:")
println("  $chars_array → \"$palabra_reconstruida\"")
println()

# ============================================================================
# 9. CONVERSIÓN CON NÚMEROS COMPLEJOS
# ============================================================================

println("--- 9. Números Complejos ---")
println()

# Real a Complejo
real = 5
complejo = Complex(real)
println("Real a Complejo:")
println("  $real → $complejo")
println()

# Crear complejo con parte real e imaginaria
z = Complex(3, 4)  # 3 + 4im
println("Crear complejo: $z")
println("  Parte real: $(real(z))")
println("  Parte imaginaria: $(imag(z))")
println("  Magnitud: $(abs(z))")
println()

# ============================================================================
# 10. CONVERSIÓN CON RACIONALES
# ============================================================================

println("--- 10. Números Racionales ---")
println()

# Crear racional
fraccion = 3//4
println("Número racional: $fraccion")
println("  Numerador: $(numerator(fraccion))")
println("  Denominador: $(denominator(fraccion))")
println()

# Racional a Float
decimal = float(fraccion)
println("Racional a Float:")
println("  $fraccion → $decimal")
println()

# Operaciones mantienen la precisión
suma_fracciones = 1//3 + 1//6
println("Suma de racionales:")
println("  1/3 + 1/6 = $suma_fracciones")
println("  Como decimal: $(float(suma_fracciones))")
println()

# ============================================================================
# 11. CONVERSIÓN CON BASES NUMÉRICAS
# ============================================================================

println("--- 11. Conversión entre Bases Numéricas ---")
println()

numero = 42

# Número a diferentes bases (como string)
println("Número $numero en diferentes bases:")
println("  Binario:       $(string(numero, base=2))")
println("  Octal:         $(string(numero, base=8))")
println("  Hexadecimal:   $(string(numero, base=16))")
println()

# String en base específica a número
binario = parse(Int, "101010", base=2)
octal = parse(Int, "52", base=8)
hex = parse(Int, "2A", base=16)

println("Diferentes bases a decimal:")
println("  101010 (base 2)  → $binario")
println("  52 (base 8)      → $octal")
println("  2A (base 16)     → $hex")
println()

# ============================================================================
# 12. MANEJO DE ERRORES EN CONVERSIONES
# ============================================================================

println("--- 12. Manejo de Errores ---")
println()

# Función segura para convertir string a número
function convertir_seguro(texto, tipo=Int)
    try
        return parse(tipo, texto)
    catch e
        println("❌ Error al convertir \"$texto\": $(typeof(e))")
        return nothing
    end
end

println("Conversiones con manejo de errores:")
println("Entrada: \"123\"")
resultado1 = convertir_seguro("123")
println("Resultado: $resultado1")
println()

println("Entrada: \"abc\"")
resultado2 = convertir_seguro("abc")
println("Resultado: $resultado2")
println()

println("Entrada: \"3.14\"")
resultado3 = convertir_seguro("3.14", Float64)
println("Resultado: $resultado3")
println()

# ============================================================================
# 13. TABLA DE CONVERSIONES COMUNES
# ============================================================================

println("--- 13. Tabla de Conversiones Comunes ---")
println()

println("╔════════════════╦═══════════════════╦═════════════════╗")
println("║     De         ║      A            ║    Función      ║")
println("╠════════════════╬═══════════════════╬═════════════════╣")
println("║ String         ║ Int               ║ parse(Int, s)   ║")
println("║ String         ║ Float64           ║ parse(Float64,s)║")
println("║ Int            ║ String            ║ string(n)       ║")
println("║ Float          ║ String            ║ string(f)       ║")
println("║ Int            ║ Float64           ║ Float64(n)      ║")
println("║ Float          ║ Int (redondear)   ║ round(Int, f)   ║")
println("║ Float          ║ Int (piso)        ║ floor(Int, f)   ║")
println("║ Float          ║ Int (techo)       ║ ceil(Int, f)    ║")
println("║ Char           ║ Int (Unicode)     ║ Int(c)          ║")
println("║ Int            ║ Char              ║ Char(n)         ║")
println("║ Bool           ║ Int               ║ Int(b)          ║")
println("║ Int            ║ Bool              ║ Bool(n)         ║")
println("║ Rational       ║ Float             ║ float(r)        ║")
println("╚════════════════╩═══════════════════╩═════════════════╝")
println()

# ============================================================================
# 14. EJEMPLOS PRÁCTICOS
# ============================================================================

println("--- 14. Ejemplos Prácticos ---")
println()

# Ejemplo 1: Validar y convertir entrada de edad
function validar_edad(texto)
    edad = tryparse(Int, texto)

    if edad === nothing
        return (false, 0, "No es un número válido")
    elseif edad < 0
        return (false, edad, "La edad no puede ser negativa")
    elseif edad > 150
        return (false, edad, "La edad parece irreal")
    else
        return (true, edad, "Edad válida")
    end
end

println("📊 Validación de edad:")
for entrada in ["25", "abc", "-5", "200", "18"]
    valido, edad, mensaje = validar_edad(entrada)
    estado = valido ? "✅" : "❌"
    println("  $estado \"$entrada\" → $mensaje")
end
println()

# Ejemplo 2: Convertir precio con formato
function parsear_precio(texto)
    # Eliminar símbolo de moneda y espacios
    limpio = replace(texto, r"[$€£,\s]" => "")

    precio = tryparse(Float64, limpio)

    return precio === nothing ? 0.0 : precio
end

println("💰 Parsear precios:")
for precio_texto in ["\$19.99", "€ 25,50", "£42.00", "100"]
    precio = parsear_precio(precio_texto)
    println("  \"$precio_texto\" → \$$precio")
end
println()

# ============================================================================
# 15. EJERCICIOS PRÁCTICOS
# ============================================================================

println("=" ^ 70)
println("🎯 EJERCICIOS PARA PRACTICAR:")
println("=" ^ 70)
println()
println("1. Convertir entre tipos:")
println("   - Convierte 42.7 a Int usando floor, ceil y round")
println("   - Compara los resultados")
println()
println("2. Parse seguro:")
println("   - Crea una función que convierta string a Float")
println("   - Debe retornar 0.0 si la conversión falla")
println("   - Prueba con \"3.14\", \"abc\", \"100\"")
println()
println("3. Validador de entrada:")
println("   - Crea una función que valide un código postal (5 dígitos)")
println("   - Debe verificar que sea numérico y de longitud correcta")
println()
println("4. Conversor de temperatura:")
println("   - Pide temperatura como string")
println("   - Convierte a número")
println("   - Realiza la conversión C° a F°")
println()
println("5. Calculadora de bases:")
println("   - Crea una función que convierta un número")
println("   - De decimal a binario, octal y hexadecimal")
println("   - Muestra los resultados formateados")
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
println("   ✓ parse() para string a número")
println("   ✓ string() para número a string")
println("   ✓ tryparse() para conversión segura")
println("   ✓ Redondeo: floor, ceil, round, trunc")
println("   ✓ Conversión entre tipos numéricos")
println("   ✓ Manejo de errores en conversiones")
println("   ✓ Conversión de bases numéricas")
println()
println("📚 Próximo paso: proyecto_calculadora.jl")
println("=" ^ 70)
