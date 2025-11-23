#!/usr/bin/env julia
# ============================================================================
# MÓDULO 1 - PROYECTO 2: Conversor Universal de Unidades
# ============================================================================
# Este proyecto te enseña a:
# - Organizar código en funciones
# - Trabajar con diferentes tipos de conversiones
# - Validar entrada del usuario
# - Crear interfaces de menú interactivas

println("=" ^ 70)
println("🔄 CONVERSOR UNIVERSAL DE UNIDADES")
println("=" ^ 70)
println()

# ============================================================================
# FUNCIONES DE CONVERSIÓN - TEMPERATURA
# ============================================================================

"""
Celsius a Fahrenheit
Fórmula: F = C × 9/5 + 32
"""
celsius_a_fahrenheit(c) = c * 9/5 + 32

"""
Fahrenheit a Celsius
Fórmula: C = (F - 32) × 5/9
"""
fahrenheit_a_celsius(f) = (f - 32) * 5/9

"""
Celsius a Kelvin
Fórmula: K = C + 273.15
"""
celsius_a_kelvin(c) = c + 273.15

"""
Kelvin a Celsius
Fórmula: C = K - 273.15
"""
kelvin_a_celsius(k) = k - 273.15

"""
Fahrenheit a Kelvin
"""
fahrenheit_a_kelvin(f) = celsius_a_kelvin(fahrenheit_a_celsius(f))

"""
Kelvin a Fahrenheit
"""
kelvin_a_fahrenheit(k) = celsius_a_fahrenheit(kelvin_a_celsius(k))

# ============================================================================
# FUNCIONES DE CONVERSIÓN - LONGITUD
# ============================================================================

"""Metros a Kilómetros"""
metros_a_kilometros(m) = m / 1000

"""Kilómetros a Metros"""
kilometros_a_metros(km) = km * 1000

"""Metros a Millas"""
metros_a_millas(m) = m / 1609.34

"""Millas a Metros"""
millas_a_metros(mi) = mi * 1609.34

"""Metros a Pies"""
metros_a_pies(m) = m * 3.28084

"""Pies a Metros"""
pies_a_metros(ft) = ft / 3.28084

"""Metros a Pulgadas"""
metros_a_pulgadas(m) = m * 39.3701

"""Pulgadas a Metros"""
pulgadas_a_metros(inch) = inch / 39.3701

"""Centímetros a Pulgadas"""
cm_a_pulgadas(cm) = cm / 2.54

"""Pulgadas a Centímetros"""
pulgadas_a_cm(inch) = inch * 2.54

# ============================================================================
# FUNCIONES DE CONVERSIÓN - PESO/MASA
# ============================================================================

"""Kilogramos a Libras"""
kg_a_libras(kg) = kg * 2.20462

"""Libras a Kilogramos"""
libras_a_kg(lb) = lb / 2.20462

"""Kilogramos a Gramos"""
kg_a_gramos(kg) = kg * 1000

"""Gramos a Kilogramos"""
gramos_a_kg(g) = g / 1000

"""Kilogramos a Onzas"""
kg_a_onzas(kg) = kg * 35.274

"""Onzas a Kilogramos"""
onzas_a_kg(oz) = oz / 35.274

# ============================================================================
# FUNCIONES DE CONVERSIÓN - VELOCIDAD
# ============================================================================

"""Kilómetros/hora a Millas/hora"""
kmh_a_mph(kmh) = kmh / 1.60934

"""Millas/hora a Kilómetros/hora"""
mph_a_kmh(mph) = mph * 1.60934

"""Metros/segundo a Kilómetros/hora"""
ms_a_kmh(ms) = ms * 3.6

"""Kilómetros/hora a Metros/segundo"""
kmh_a_ms(kmh) = kmh / 3.6

# ============================================================================
# FUNCIONES DE CONVERSIÓN - TIEMPO
# ============================================================================

"""Horas a Minutos"""
horas_a_minutos(h) = h * 60

"""Minutos a Horas"""
minutos_a_horas(m) = m / 60

"""Horas a Segundos"""
horas_a_segundos(h) = h * 3600

"""Segundos a Horas"""
segundos_a_horas(s) = s / 3600

"""Días a Horas"""
dias_a_horas(d) = d * 24

"""Horas a Días"""
horas_a_dias(h) = h / 24

# ============================================================================
# FUNCIONES DE CONVERSIÓN - DATOS DIGITALES
# ============================================================================

"""Bytes a Kilobytes"""
bytes_a_kb(b) = b / 1024

"""Kilobytes a Bytes"""
kb_a_bytes(kb) = kb * 1024

"""Kilobytes a Megabytes"""
kb_a_mb(kb) = kb / 1024

"""Megabytes a Kilobytes"""
mb_a_kb(mb) = mb * 1024

"""Megabytes a Gigabytes"""
mb_a_gb(mb) = mb / 1024

"""Gigabytes a Megabytes"""
gb_a_mb(gb) = gb * 1024

# ============================================================================
# FUNCIONES AUXILIARES
# ============================================================================

"""Lee un número del usuario con validación"""
function leer_numero(mensaje::String)
    while true
        print(mensaje)
        entrada = readline()

        numero = tryparse(Float64, entrada)

        if numero === nothing
            println("❌ Error: Ingresa un número válido")
        else
            return numero
        end
    end
end

"""Muestra el resultado de la conversión"""
function mostrar_resultado(valor, unidad_origen, resultado, unidad_destino)
    println()
    println("=" ^ 70)
    println("RESULTADO DE LA CONVERSIÓN")
    println("=" ^ 70)
    println()
    println("  $valor $unidad_origen = $(round(resultado, digits=4)) $unidad_destino")
    println()
    println("=" ^ 70)
end

"""Pausa hasta que el usuario presione Enter"""
function pausar()
    print("\nPresiona Enter para continuar...")
    readline()
end

# ============================================================================
# MENÚS DE CONVERSIÓN
# ============================================================================

"""Conversión de Temperatura"""
function menu_temperatura()
    println("\n" * "-" ^ 70)
    println("CONVERSIÓN DE TEMPERATURA")
    println("-" ^ 70)
    println("  [1] Celsius → Fahrenheit")
    println("  [2] Fahrenheit → Celsius")
    println("  [3] Celsius → Kelvin")
    println("  [4] Kelvin → Celsius")
    println("  [5] Fahrenheit → Kelvin")
    println("  [6] Kelvin → Fahrenheit")
    println("  [0] Volver")
    println("-" ^ 70)
    print("Opción: ")

    opcion = readline()

    if opcion == "1"
        valor = leer_numero("Temperatura en Celsius: ")
        resultado = celsius_a_fahrenheit(valor)
        mostrar_resultado(valor, "°C", resultado, "°F")
    elseif opcion == "2"
        valor = leer_numero("Temperatura en Fahrenheit: ")
        resultado = fahrenheit_a_celsius(valor)
        mostrar_resultado(valor, "°F", resultado, "°C")
    elseif opcion == "3"
        valor = leer_numero("Temperatura en Celsius: ")
        resultado = celsius_a_kelvin(valor)
        mostrar_resultado(valor, "°C", resultado, "K")
    elseif opcion == "4"
        valor = leer_numero("Temperatura en Kelvin: ")
        resultado = kelvin_a_celsius(valor)
        mostrar_resultado(valor, "K", resultado, "°C")
    elseif opcion == "5"
        valor = leer_numero("Temperatura en Fahrenheit: ")
        resultado = fahrenheit_a_kelvin(valor)
        mostrar_resultado(valor, "°F", resultado, "K")
    elseif opcion == "6"
        valor = leer_numero("Temperatura en Kelvin: ")
        resultado = kelvin_a_fahrenheit(valor)
        mostrar_resultado(valor, "K", resultado, "°F")
    elseif opcion != "0"
        println("❌ Opción no válida")
    end

    if opcion != "0"
        pausar()
    end
end

"""Conversión de Longitud"""
function menu_longitud()
    println("\n" * "-" ^ 70)
    println("CONVERSIÓN DE LONGITUD")
    println("-" ^ 70)
    println("  [1] Metros ↔ Kilómetros")
    println("  [2] Metros ↔ Millas")
    println("  [3] Metros ↔ Pies")
    println("  [4] Centímetros ↔ Pulgadas")
    println("  [0] Volver")
    println("-" ^ 70)
    print("Opción: ")

    opcion = readline()

    if opcion == "1"
        print("¿De metros a km (1) o de km a metros (2)?: ")
        sub = readline()
        if sub == "1"
            valor = leer_numero("Metros: ")
            resultado = metros_a_kilometros(valor)
            mostrar_resultado(valor, "m", resultado, "km")
        elseif sub == "2"
            valor = leer_numero("Kilómetros: ")
            resultado = kilometros_a_metros(valor)
            mostrar_resultado(valor, "km", resultado, "m")
        end
    elseif opcion == "2"
        print("¿De metros a millas (1) o de millas a metros (2)?: ")
        sub = readline()
        if sub == "1"
            valor = leer_numero("Metros: ")
            resultado = metros_a_millas(valor)
            mostrar_resultado(valor, "m", resultado, "mi")
        elseif sub == "2"
            valor = leer_numero("Millas: ")
            resultado = millas_a_metros(valor)
            mostrar_resultado(valor, "mi", resultado, "m")
        end
    elseif opcion == "3"
        print("¿De metros a pies (1) o de pies a metros (2)?: ")
        sub = readline()
        if sub == "1"
            valor = leer_numero("Metros: ")
            resultado = metros_a_pies(valor)
            mostrar_resultado(valor, "m", resultado, "ft")
        elseif sub == "2"
            valor = leer_numero("Pies: ")
            resultado = pies_a_metros(valor)
            mostrar_resultado(valor, "ft", resultado, "m")
        end
    elseif opcion == "4"
        print("¿De cm a pulgadas (1) o de pulgadas a cm (2)?: ")
        sub = readline()
        if sub == "1"
            valor = leer_numero("Centímetros: ")
            resultado = cm_a_pulgadas(valor)
            mostrar_resultado(valor, "cm", resultado, "in")
        elseif sub == "2"
            valor = leer_numero("Pulgadas: ")
            resultado = pulgadas_a_cm(valor)
            mostrar_resultado(valor, "in", resultado, "cm")
        end
    elseif opcion != "0"
        println("❌ Opción no válida")
    end

    if opcion != "0"
        pausar()
    end
end

"""Conversión de Peso/Masa"""
function menu_peso()
    println("\n" * "-" ^ 70)
    println("CONVERSIÓN DE PESO/MASA")
    println("-" ^ 70)
    println("  [1] Kilogramos ↔ Libras")
    println("  [2] Kilogramos ↔ Gramos")
    println("  [3] Kilogramos ↔ Onzas")
    println("  [0] Volver")
    println("-" ^ 70)
    print("Opción: ")

    opcion = readline()

    if opcion == "1"
        print("¿De kg a libras (1) o de libras a kg (2)?: ")
        sub = readline()
        if sub == "1"
            valor = leer_numero("Kilogramos: ")
            resultado = kg_a_libras(valor)
            mostrar_resultado(valor, "kg", resultado, "lb")
        elseif sub == "2"
            valor = leer_numero("Libras: ")
            resultado = libras_a_kg(valor)
            mostrar_resultado(valor, "lb", resultado, "kg")
        end
    elseif opcion == "2"
        print("¿De kg a gramos (1) o de gramos a kg (2)?: ")
        sub = readline()
        if sub == "1"
            valor = leer_numero("Kilogramos: ")
            resultado = kg_a_gramos(valor)
            mostrar_resultado(valor, "kg", resultado, "g")
        elseif sub == "2"
            valor = leer_numero("Gramos: ")
            resultado = gramos_a_kg(valor)
            mostrar_resultado(valor, "g", resultado, "kg")
        end
    elseif opcion != "0"
        println("❌ Opción no válida")
    end

    if opcion != "0"
        pausar()
    end
end

"""Conversión de Velocidad"""
function menu_velocidad()
    println("\n" * "-" ^ 70)
    println("CONVERSIÓN DE VELOCIDAD")
    println("-" ^ 70)
    println("  [1] km/h ↔ mph")
    println("  [2] m/s ↔ km/h")
    println("  [0] Volver")
    println("-" ^ 70)
    print("Opción: ")

    opcion = readline()

    if opcion == "1"
        print("¿De km/h a mph (1) o de mph a km/h (2)?: ")
        sub = readline()
        if sub == "1"
            valor = leer_numero("Kilómetros por hora: ")
            resultado = kmh_a_mph(valor)
            mostrar_resultado(valor, "km/h", resultado, "mph")
        elseif sub == "2"
            valor = leer_numero("Millas por hora: ")
            resultado = mph_a_kmh(valor)
            mostrar_resultado(valor, "mph", resultado, "km/h")
        end
    elseif opcion != "0"
        println("❌ Opción no válida")
    end

    if opcion != "0"
        pausar()
    end
end

# ============================================================================
# MENÚ PRINCIPAL
# ============================================================================

"""Muestra el menú principal"""
function menu_principal()
    while true
        println("\n" * "=" ^ 70)
        println(" " ^ 18 * "CONVERSOR UNIVERSAL DE UNIDADES")
        println("=" ^ 70)
        println()
        println("  [1] 🌡️  Temperatura")
        println("  [2] 📏 Longitud")
        println("  [3] ⚖️  Peso/Masa")
        println("  [4] 🚗 Velocidad")
        println("  [5] 💾 Datos digitales")
        println("  [0] 🚪 Salir")
        println()
        println("=" ^ 70)
        print("Selecciona una categoría: ")

        opcion = readline()

        if opcion == "1"
            menu_temperatura()
        elseif opcion == "2"
            menu_longitud()
        elseif opcion == "3"
            menu_peso()
        elseif opcion == "4"
            menu_velocidad()
        elseif opcion == "0"
            println()
            println("=" ^ 70)
            println("¡Gracias por usar el Conversor Universal! 👋")
            println("=" ^ 70)
            break
        else
            println("❌ Opción no válida")
            pausar()
        end
    end
end

# ============================================================================
# EJECUCIÓN DEL PROGRAMA
# ============================================================================

# Ejecutar el programa
menu_principal()

# ============================================================================
# RETOS DE EXTENSIÓN
# ============================================================================
#
# Una vez que domines este conversor, intenta agregar:
#
# 1. Conversiones de área (m², km², hectáreas, acres)
# 2. Conversiones de volumen (litros, galones, m³)
# 3. Conversiones de presión (bar, psi, atm, Pa)
# 4. Conversiones de energía (joules, calorías, kWh)
# 5. Guardar conversiones frecuentes
# 6. Modo inverso (ingresar resultado deseado)
# 7. Conversión múltiple (mostrar todas las unidades a la vez)
# 8. Exportar resultados a archivo
# 9. Tablas de conversión
# 10. Modo de conversión de monedas (con API)
#
# ============================================================================
