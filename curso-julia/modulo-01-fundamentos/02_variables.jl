#!/usr/bin/env julia
# ============================================================================
# MÓDULO 1 - EJEMPLO 2: Variables y Tipos de Datos
# ============================================================================
# En este archivo aprenderás:
# - Cómo crear y usar variables
# - Tipos de datos en Julia
# - Nomenclatura y convenciones
# - Verificación de tipos

println("=" ^ 70)
println("📦 VARIABLES Y TIPOS DE DATOS EN JULIA")
println("=" ^ 70)
println()

# ============================================================================
# 1. VARIABLES BÁSICAS
# ============================================================================

println("--- 1. Creando Variables ---")
println()

# En Julia, las variables se crean con asignación directa
# No necesitas declarar el tipo (tipado dinámico)
nombre = "María"
edad = 28
altura = 1.65
es_estudiante = true

println("Nombre: $nombre")
println("Edad: $edad años")
println("Altura: $altura metros")
println("¿Es estudiante?: $es_estudiante")
println()

# ============================================================================
# 2. TIPOS NUMÉRICOS - ENTEROS
# ============================================================================

println("--- 2. Números Enteros (Integers) ---")
println()

# Diferentes tamaños de enteros
numero_pequeño = 42                    # Int64 (por defecto en sistemas 64-bit)
numero_grande = 1_000_000_000          # Puedes usar _ para separar miles
numero_muy_grande = 123456789012345    # Julia maneja números grandes automáticamente

println("Número pequeño: $numero_pequeño (tipo: $(typeof(numero_pequeño)))")
println("Número grande: $numero_grande (tipo: $(typeof(numero_grande)))")
println("Número muy grande: $numero_muy_grande")
println()

# Diferentes bases numéricas
binario = 0b1010        # Binario (10 en decimal)
octal = 0o12            # Octal (10 en decimal)
hexadecimal = 0x0A      # Hexadecimal (10 en decimal)

println("Binario 0b1010 = $binario")
println("Octal 0o12 = $octal")
println("Hexadecimal 0x0A = $hexadecimal")
println()

# ============================================================================
# 3. TIPOS NUMÉRICOS - FLOTANTES
# ============================================================================

println("--- 3. Números de Punto Flotante (Floats) ---")
println()

precio = 19.99                 # Float64
temperatura = -5.5
cientifico = 6.022e23          # Notación científica (Número de Avogadro)
muy_pequeño = 1.6e-19          # 0.00000000000000000016

println("Precio: \$$precio (tipo: $(typeof(precio)))")
println("Temperatura: $temperatura°C")
println("Número de Avogadro: $cientifico")
println("Carga del electrón: $muy_pequeño coulombs")
println()

# Precisión de flotantes
pi_aproximado = 3.14159265358979323846
println("π ≈ $pi_aproximado")
println("π (constante de Julia) = $π")
println("Diferencia: $(abs(pi_aproximado - π))")
println()

# ============================================================================
# 4. TIPOS NUMÉRICOS ESPECIALES
# ============================================================================

println("--- 4. Tipos Numéricos Especiales ---")
println()

# Números complejos (importantes en ingeniería y física)
z1 = 3 + 4im                   # Número complejo
z2 = complex(5, 2)             # Otra forma de crear complejos

println("Número complejo z1: $z1")
println("  Parte real: $(real(z1))")
println("  Parte imaginaria: $(imag(z1))")
println("  Magnitud: $(abs(z1))")
println("  Ángulo: $(angle(z1)) radianes")
println()

# Números racionales (fracciones exactas)
fraccion1 = 3//4               # Tres cuartos
fraccion2 = 5//6               # Cinco sextos
suma_fracciones = fraccion1 + fraccion2

println("Fracción 1: $fraccion1")
println("Fracción 2: $fraccion2")
println("Suma: $fraccion1 + $fraccion2 = $suma_fracciones")
println("Como decimal: $(float(suma_fracciones))")
println()

# ============================================================================
# 5. BOOLEANOS (LÓGICOS)
# ============================================================================

println("--- 5. Valores Booleanos ---")
println()

# Solo dos valores posibles: true y false
es_verdad = true
es_falso = false
resultado_comparacion = 10 > 5

println("Es verdad: $es_verdad (tipo: $(typeof(es_verdad)))")
println("Es falso: $es_falso")
println("10 > 5 = $resultado_comparacion")
println()

# ============================================================================
# 6. CARACTERES (CHAR)
# ============================================================================

println("--- 6. Caracteres ---")
println()

# Los caracteres usan comillas simples ''
letra = 'A'
numero_char = '5'
emoji = '😊'
simbolo = '∑'

println("Letra: $letra (tipo: $(typeof(letra)))")
println("Número como carácter: $numero_char")
println("Emoji: $emoji")
println("Símbolo matemático: $simbolo")
println()

# Código Unicode del carácter
println("Código Unicode de 'A': $(Int('A'))")
println("Código Unicode de '😊': $(Int(emoji))")
println()

# ============================================================================
# 7. STRINGS (CADENAS)
# ============================================================================

println("--- 7. Strings (Cadenas de Texto) ---")
println()

# Los strings usan comillas dobles ""
saludo = "¡Hola, Mundo!"
lenguaje = "Julia"
descripcion = "es un lenguaje de programación moderno"

println("Saludo: $saludo")
println("$lenguaje $descripcion")
println()

# String multilínea
poema = """
    Las rosas son rojas,
    las violetas son azules,
    Julia es rápida,
    ¡y fácil de usar también!
    """
println("Poema:")
println(poema)

# ============================================================================
# 8. TYPEOF() - VERIFICANDO TIPOS
# ============================================================================

println("--- 8. Verificando Tipos con typeof() ---")
println()

# typeof() te dice qué tipo es una variable
variables = [
    42,
    3.14,
    true,
    'c',
    "texto",
    3//4,
    2 + 3im
]

for var in variables
    println("$var → $(typeof(var))")
end
println()

# ============================================================================
# 9. CONSTANTES
# ============================================================================

println("--- 9. Constantes ---")
println()

# Las constantes no pueden cambiar su valor
# Se declaran con 'const' y por convención en MAYÚSCULAS
const PI_PERSONALIZADO = 3.14159
const VELOCIDAD_LUZ = 299_792_458  # metros por segundo
const GRAVEDAD = 9.81              # m/s²

println("π personalizado: $PI_PERSONALIZADO")
println("Velocidad de la luz: $VELOCIDAD_LUZ m/s")
println("Gravedad terrestre: $GRAVEDAD m/s²")
println()

# Si intentas cambiar una constante, Julia te advertirá
# Descomenta la siguiente línea para ver el warning:
# PI_PERSONALIZADO = 3.14  # ⚠️ Esto generará una advertencia

# ============================================================================
# 10. NOMENCLATURA DE VARIABLES
# ============================================================================

println("--- 10. Buenas Prácticas en Nombres de Variables ---")
println()

# ✅ Buenos nombres (descriptivos, claros)
edad_usuario = 25
precio_total = 99.99
es_valido = true
nombre_completo = "Juan Pérez"

# ❌ Malos nombres (poco descriptivos)
# x = 25           # ¿Qué es x?
# p = 99.99        # ¿Precio? ¿Peso? ¿Porcentaje?
# flag = true      # ¿Qué indica este flag?

println("✅ Usa nombres descriptivos:")
println("  - edad_usuario = $edad_usuario")
println("  - precio_total = \$$precio_total")
println("  - es_valido = $es_valido")
println()

# Convenciones en Julia:
# - snake_case para variables y funciones: mi_variable
# - CamelCase para tipos y módulos: MiTipo
# - MAYÚSCULAS para constantes: MI_CONSTANTE

# ============================================================================
# 11. UNICODE EN NOMBRES DE VARIABLES
# ============================================================================

println("--- 11. Unicode en Variables (¡Sí, puedes usar emojis!) ---")
println()

# Julia permite Unicode en nombres de variables
# Esto es especialmente útil en matemáticas y ciencias
α = 45  # ángulo en grados (\alpha + TAB)
β = 30  # otro ángulo (\beta + TAB)
θ = 90  # theta (\theta + TAB)

println("Ángulo α = $α°")
println("Ángulo β = $β°")
println("Ángulo θ = $θ°")
println()

# Incluso puedes usar emojis (aunque no es recomendado en código serio)
🚀 = "Julia"
💰 = 1000
🌡️ = 25.5

println("Lenguaje: $🚀")
println("Dinero: \$$💰")
println("Temperatura: $🌡️°C")
println()

# ============================================================================
# 12. VALORES ESPECIALES
# ============================================================================

println("--- 12. Valores Especiales ---")
println()

# Nothing (ausencia de valor)
sin_valor = nothing
println("Sin valor: $sin_valor (tipo: $(typeof(sin_valor)))")

# NaN (Not a Number)
resultado_invalido = 0 / 0
println("0/0 = $resultado_invalido (tipo: $(typeof(resultado_invalido)))")

# Infinito
infinito_positivo = Inf
infinito_negativo = -Inf
println("+∞: $infinito_positivo")
println("-∞: $infinito_negativo")
println("1/0 = $(1/0)")
println()

# ============================================================================
# 13. ÁMBITO DE VARIABLES (SCOPE)
# ============================================================================

println("--- 13. Ámbito de Variables ---")
println()

# Variables globales (accesibles en todo el programa)
variable_global = "Soy global"

# Variables locales (solo dentro de bloques)
# Las veremos más en detalle en módulos posteriores
println("Variable global: $variable_global")
println()

# ============================================================================
# 14. MÚLTIPLE ASIGNACIÓN
# ============================================================================

println("--- 14. Asignación Múltiple ---")
println()

# Puedes asignar múltiples variables en una sola línea
x, y, z = 10, 20, 30
println("x = $x, y = $y, z = $z")

# Intercambiar valores
a, b = 5, 7
println("Antes: a = $a, b = $b")
a, b = b, a  # Intercambio elegante
println("Después: a = $a, b = $b")
println()

# ============================================================================
# 15. EJERCICIOS PRÁCTICOS
# ============================================================================

println("=" ^ 70)
println("🎯 EJERCICIOS PARA PRACTICAR:")
println("=" ^ 70)
println()
println("1. Crea variables con tu información personal:")
println("   - tu_nombre, tu_edad, tu_ciudad, tu_altura")
println()
println("2. Crea variables numéricas:")
println("   - Un número entero grande con separadores _")
println("   - Un número en notación científica")
println("   - Una fracción usando //")
println()
println("3. Experimenta con tipos:")
println("   - Crea un número complejo")
println("   - Verifica su tipo con typeof()")
println("   - Calcula su magnitud con abs()")
println()
println("4. Crea tres constantes:")
println("   - DIAS_SEMANA = 7")
println("   - MESES_AÑO = 12")
println("   - HORAS_DIA = 24")
println()
println("5. Usa Unicode:")
println("   - Crea una variable Δ (delta) con un valor numérico")
println("   - Crea una variable con un emoji de tu elección")
println()

# ============================================================================
# TU CÓDIGO AQUÍ:
# ============================================================================

# Ejercicio 1: Tu información personal


# Ejercicio 2: Números especiales


# Ejercicio 3: Números complejos


# Ejercicio 4: Constantes


# Ejercicio 5: Unicode


# ============================================================================

println()
println("=" ^ 70)
println("✅ ¡Programa completado!")
println("=" ^ 70)
println()
println("💡 Conceptos clave aprendidos:")
println("   ✓ Variables y asignación")
println("   ✓ Tipos de datos: Int, Float, Bool, Char, String")
println("   ✓ Números especiales: complejos, racionales")
println("   ✓ typeof() para verificar tipos")
println("   ✓ Constantes con const")
println("   ✓ Unicode en variables")
println()
println("📚 Próximo paso: 03_operadores.jl")
println("=" ^ 70)
