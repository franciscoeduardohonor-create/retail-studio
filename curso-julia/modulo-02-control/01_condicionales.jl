#!/usr/bin/env julia
# ============================================================================
# MÓDULO 2 - ESTRUCTURAS DE CONTROL: CONDICIONALES
# ============================================================================

println("=" ^ 70)
println("🔀 CONDICIONALES EN JULIA")
println("=" ^ 70)
println()

# ============================================================================
# 1. IF SIMPLE
# ============================================================================

println("--- 1. If Simple ---")
println()

edad = 20

if edad >= 18
    println("✅ Eres mayor de edad")
end

# Ejemplo con múltiples condiciones
temperatura = 35

if temperatura > 30
    println("🌡️  Hace mucho calor")
end

if temperatura < 10
    println("🥶 Hace frío")
end

println()

# ============================================================================
# 2. IF-ELSE
# ============================================================================

println("--- 2. If-Else ---")
println()

hora = 14

if hora < 12
    println("🌅 Buenos días")
else
    println("🌆 Buenas tardes/noches")
end

# Verificar número par o impar
numero = 7

if numero % 2 == 0
    println("$numero es par")
else
    println("$numero es impar")
end

println()

# ============================================================================
# 3. IF-ELSEIF-ELSE (Múltiples condiciones)
# ============================================================================

println("--- 3. If-Elseif-Else ---")
println()

# Clasificación de notas
nota = 85

if nota >= 90
    calificacion = "A - Excelente"
elseif nota >= 80
    calificacion = "B - Muy bien"
elseif nota >= 70
    calificacion = "C - Bien"
elseif nota >= 60
    calificacion = "D - Suficiente"
else
    calificacion = "F - Reprobado"
end

println("Nota: $nota → $calificacion")

# Clasificación de edad
edad = 25

if edad < 13
    categoria = "Niño"
elseif edad < 18
    categoria = "Adolescente"
elseif edad < 65
    categoria = "Adulto"
else
    categoria = "Adulto mayor"
end

println("Edad: $edad → $categoria")

println()

# ============================================================================
# 4. OPERADOR TERNARIO (forma abreviada)
# ============================================================================

println("--- 4. Operador Ternario ---")
println()

# Sintaxis: condición ? valor_si_true : valor_si_false

edad = 16
puede_votar = edad >= 18 ? "Sí" : "No"
println("¿Puede votar con $edad años? $puede_votar")

numero = 10
paridad = numero % 2 == 0 ? "par" : "impar"
println("$numero es $paridad")

# Ternarios anidados (usar con moderación)
temperatura = 15
clima = temperatura > 30 ? "Calor" : temperatura > 20 ? "Templado" : temperatura > 10 ? "Fresco" : "Frío"
println("$temperatura°C → $clima")

println()

# ============================================================================
# 5. OPERADORES LÓGICOS EN CONDICIONALES
# ============================================================================

println("--- 5. Operadores Lógicos ---")
println()

# AND (&&)
edad = 25
tiene_licencia = true

if edad >= 18 && tiene_licencia
    println("✅ Puede conducir")
else
    println("❌ No puede conducir")
end

# OR (||)
es_fin_semana = true
es_feriado = false

if es_fin_semana || es_feriado
    println("🎉 Día de descanso")
else
    println("💼 Día laboral")
end

# NOT (!)
llueve = false

if !llueve
    println("☀️  Puedes salir sin paraguas")
else
    println("☔ Lleva paraguas")
end

# Combinación de operadores
hora = 14
es_laborable = true

if (hora >= 9 && hora <= 18) && es_laborable
    println("⏰ Horario de oficina")
else
    println("🏠 Fuera de horario")
end

println()

# ============================================================================
# 6. COMPARACIONES EN CONDICIONALES
# ============================================================================

println("--- 6. Comparaciones Avanzadas ---")
println()

# Comparaciones encadenadas
edad = 25

if 18 <= edad <= 65
    println("En edad laboral activa")
end

# Múltiples condiciones
puntuacion = 75
intentos = 3

if puntuacion >= 70 && intentos <= 5
    println("✅ Aprobado con buena puntuación")
end

println()

# ============================================================================
# 7. SHORT-CIRCUIT EVALUATION
# ============================================================================

println("--- 7. Evaluación de Cortocircuito ---")
println()

# && ejecuta el segundo solo si el primero es true
x = 10
x > 5 && println("x es mayor que 5")  # Se ejecuta
x > 15 && println("x es mayor que 15")  # No se ejecuta

# || ejecuta el segundo solo si el primero es false
y = 3
y > 5 || println("y no es mayor que 5")  # Se ejecuta

println()

# ============================================================================
# 8. EJEMPLOS PRÁCTICOS
# ============================================================================

println("--- 8. Ejemplos Prácticos ---")
println()

# Ejemplo 1: Validar contraseña
contraseña = "abc123"

if length(contraseña) < 6
    println("❌ Contraseña muy corta (mínimo 6 caracteres)")
elseif !any(isdigit, contraseña)
    println("⚠️  La contraseña debería incluir números")
else
    println("✅ Contraseña válida")
end

# Ejemplo 2: Calcular descuento
precio = 100
cantidad = 5
total = precio * cantidad

if cantidad >= 10
    descuento = 0.20  # 20% de descuento
elseif cantidad >= 5
    descuento = 0.10  # 10% de descuento
else
    descuento = 0.0   # Sin descuento
end

precio_final = total * (1 - descuento)
println("\n💰 Factura:")
println("  Precio unitario: \$$precio")
println("  Cantidad: $cantidad")
println("  Subtotal: \$$total")
println("  Descuento: $(descuento * 100)%")
println("  Total: \$$precio_final")

# Ejemplo 3: Clasificar IMC
peso = 70  # kg
altura = 1.75  # metros
imc = peso / altura^2

println("\n⚕️  Índice de Masa Corporal:")
println("  Peso: $peso kg")
println("  Altura: $altura m")
println("  IMC: $(round(imc, digits=2))")

if imc < 18.5
    categoria_imc = "Bajo peso"
    emoji = "⚠️"
elseif imc < 25
    categoria_imc = "Peso normal"
    emoji = "✅"
elseif imc < 30
    categoria_imc = "Sobrepeso"
    emoji = "⚠️"
else
    categoria_imc = "Obesidad"
    emoji = "❌"
end

println("  Categoría: $emoji $categoria_imc")

println()
println("=" ^ 70)
println("✅ ¡Condicionales completados!")
println("📚 Próximo: 02_bucles_for.jl")
println("=" ^ 70)
