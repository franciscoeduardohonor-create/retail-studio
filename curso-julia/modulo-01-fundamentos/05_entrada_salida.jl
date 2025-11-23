#!/usr/bin/env julia
# ============================================================================
# MÓDULO 1 - EJEMPLO 5: Entrada y Salida de Datos
# ============================================================================
# En este archivo aprenderás:
# - Recibir entrada del usuario
# - Mostrar salida formateada
# - Validar entrada
# - Crear programas interactivos

println("=" ^ 70)
println("💬 ENTRADA Y SALIDA EN JULIA")
println("=" ^ 70)
println()

# ============================================================================
# 1. SALIDA BÁSICA - print() y println()
# ============================================================================

println("--- 1. Salida Básica ---")
println()

# println() imprime y agrega salto de línea
println("Esta es la línea 1")
println("Esta es la línea 2")
println()

# print() imprime SIN salto de línea
print("Palabra1 ")
print("Palabra2 ")
print("Palabra3")
println()  # Salto de línea manual
println()

# Múltiples argumentos
println("Nombre:", " Juan", " -", " Edad:", " 25")
println()

# ============================================================================
# 2. INTERPOLACIÓN EN SALIDA
# ============================================================================

println("--- 2. Interpolación de Variables ---")
println()

nombre = "María"
edad = 30
ciudad = "Madrid"

# Forma básica
println("Nombre: ", nombre)
println("Edad: ", edad)
println()

# Con interpolación (más elegante)
println("Hola, me llamo $nombre, tengo $edad años y vivo en $ciudad")
println()

# Interpolación con expresiones
x = 10
y = 20
println("$x + $y = $(x + y)")
println("$x × $y = $(x * y)")
println()

# ============================================================================
# 3. FORMATEO DE SALIDA
# ============================================================================

println("--- 3. Formateo de Salida ---")
println()

# Números con decimales específicos
pi_valor = π
println("π completo: $pi_valor")
println("π (2 decimales): $(round(pi_valor, digits=2))")
println("π (4 decimales): $(round(pi_valor, digits=4))")
println()

# Padding y alineación
println("Tabla de productos:")
println("-" ^ 40)
println("$(rpad("Producto", 15)) $(lpad("Precio", 10))")
println("-" ^ 40)
println("$(rpad("Manzana", 15)) $(lpad("\$2.50", 10))")
println("$(rpad("Naranja", 15)) $(lpad("\$3.00", 10))")
println("$(rpad("Plátano", 15)) $(lpad("\$1.75", 10))")
println("-" ^ 40)
println()

# ============================================================================
# 4. MACROS DE SALIDA
# ============================================================================

println("--- 4. Macros de Salida ---")
println()

# @show - muestra la variable y su valor
edad = 25
@show edad
@show 2 + 2
@show π
println()

# @info, @warn, @error - mensajes con niveles
@info "Este es un mensaje informativo"
@warn "Este es un mensaje de advertencia"
# @error "Este es un mensaje de error"  # Descomenta para ver
println()

# ============================================================================
# 5. ENTRADA BÁSICA - readline()
# ============================================================================

println("--- 5. Entrada Básica ---")
println()

# Ejemplo comentado (para que no bloquee la ejecución automática)
# Descomenta estas líneas para probar la entrada interactiva:

# println("¿Cuál es tu nombre?")
# nombre_usuario = readline()
# println("¡Hola, $nombre_usuario!")
# println()

println("💡 Ejemplo de código para entrada:")
println("""
# println("¿Cuál es tu nombre?")
# nombre_usuario = readline()
# println("¡Hola, \$nombre_usuario!")
""")
println()

# ============================================================================
# 6. ENTRADA CON PROMPT
# ============================================================================

println("--- 6. Entrada con Prompt ---")
println()

# Función helper para entrada con mensaje
function pedir_entrada(mensaje)
    print(mensaje * ": ")
    return readline()
end

# Ejemplo comentado:
# nombre = pedir_entrada("¿Cuál es tu nombre?")
# edad = pedir_entrada("¿Cuántos años tienes?")
# println("\nHola $nombre, tienes $edad años.")

println("💡 Función útil para pedir entrada:")
println("""
function pedir_entrada(mensaje)
    print(mensaje * ": ")
    return readline()
end

nombre = pedir_entrada("¿Cuál es tu nombre?")
""")
println()

# ============================================================================
# 7. CONVERSIÓN DE ENTRADA
# ============================================================================

println("--- 7. Conversión de Entrada ---")
println()

# readline() siempre retorna String
# Necesitamos convertir a otros tipos

println("💡 Convertir entrada a números:")
println("""
# Leer y convertir a entero
print("Ingresa tu edad: ")
edad_str = readline()
edad = parse(Int, edad_str)

# Leer y convertir a flotante
print("Ingresa tu altura: ")
altura_str = readline()
altura = parse(Float64, altura_str)

println("Edad: \$edad años")
println("Altura: \$altura metros")
""")
println()

# ============================================================================
# 8. VALIDACIÓN DE ENTRADA
# ============================================================================

println("--- 8. Validación de Entrada ---")
println()

# Función para leer un entero con validación
function leer_entero(mensaje)
    while true
        print(mensaje * ": ")
        entrada = readline()

        # Intentar convertir a entero
        try
            numero = parse(Int, entrada)
            return numero
        catch
            println("❌ Error: Debes ingresar un número entero. Intenta de nuevo.")
        end
    end
end

println("💡 Función con validación:")
println("""
function leer_entero(mensaje)
    while true
        print(mensaje * ": ")
        entrada = readline()

        try
            numero = parse(Int, entrada)
            return numero
        catch
            println("❌ Error: Ingresa un número válido.")
        end
    end
end

edad = leer_entero("Ingresa tu edad")
""")
println()

# ============================================================================
# 9. VALIDACIÓN CON RANGO
# ============================================================================

println("--- 9. Validación con Rango ---")
println()

# Función para leer un número dentro de un rango
function leer_numero_rango(mensaje, minimo, maximo)
    while true
        print("$mensaje ($minimo-$maximo): ")
        entrada = readline()

        try
            numero = parse(Int, entrada)
            if minimo <= numero <= maximo
                return numero
            else
                println("❌ El número debe estar entre $minimo y $maximo")
            end
        catch
            println("❌ Debes ingresar un número válido")
        end
    end
end

println("💡 Ejemplo de uso:")
println("""
# edad = leer_numero_rango("Ingresa tu edad", 1, 120)
# println("Edad válida: \$edad años")
""")
println()

# ============================================================================
# 10. MENÚS INTERACTIVOS
# ============================================================================

println("--- 10. Menú Interactivo ---")
println()

function mostrar_menu()
    println("\n" * "=" ^ 40)
    println("MENÚ PRINCIPAL")
    println("=" ^ 40)
    println("1. Opción 1")
    println("2. Opción 2")
    println("3. Opción 3")
    println("0. Salir")
    println("=" ^ 40)
end

function ejemplo_menu()
    while true
        mostrar_menu()
        print("Selecciona una opción: ")

        # En un programa real, usarías readline() aquí
        # opcion = readline()
        # Simulamos seleccionar la opción 0 para salir
        opcion = "0"

        if opcion == "1"
            println("✅ Seleccionaste opción 1")
        elseif opcion == "2"
            println("✅ Seleccionaste opción 2")
        elseif opcion == "3"
            println("✅ Seleccionaste opción 3")
        elseif opcion == "0"
            println("👋 ¡Hasta luego!")
            break
        else
            println("❌ Opción no válida")
        end

        # Salir automáticamente en el ejemplo
        break
    end
end

println("💡 Ejemplo de menú:")
ejemplo_menu()
println()

# ============================================================================
# 11. CONFIRMACIONES SI/NO
# ============================================================================

println("--- 11. Confirmaciones Sí/No ---")
println()

function preguntar_si_no(mensaje)
    while true
        print("$mensaje (s/n): ")
        respuesta = lowercase(strip(readline()))

        if respuesta == "s" || respuesta == "si" || respuesta == "sí"
            return true
        elseif respuesta == "n" || respuesta == "no"
            return false
        else
            println("❌ Por favor responde 's' o 'n'")
        end
    end
end

println("💡 Función para confirmaciones:")
println("""
function preguntar_si_no(mensaje)
    while true
        print("\$mensaje (s/n): ")
        respuesta = lowercase(strip(readline()))

        if respuesta in ["s", "si", "sí"]
            return true
        elseif respuesta in ["n", "no"]
            return false
        else
            println("❌ Responde 's' o 'n'")
        end
    end
end

# Uso:
# continuar = preguntar_si_no("¿Deseas continuar?")
# if continuar
#     println("Continuando...")
# end
""")
println()

# ============================================================================
# 12. PROGRAMA INTERACTIVO COMPLETO
# ============================================================================

println("--- 12. Programa Interactivo de Ejemplo ---")
println()

function calculadora_simple_demo()
    println("\n📊 CALCULADORA SIMPLE - DEMO")
    println("=" ^ 40)

    # En un programa real, pedirías entrada aquí
    # Simulamos con valores predefinidos
    num1 = 10
    num2 = 5
    operacion = "+"

    println("Número 1: $num1")
    println("Número 2: $num2")
    println("Operación: $operacion")
    println()

    resultado = if operacion == "+"
        num1 + num2
    elseif operacion == "-"
        num1 - num2
    elseif operacion == "*"
        num1 * num2
    elseif operacion == "/"
        num2 != 0 ? num1 / num2 : "Error: División por cero"
    else
        "Operación no válida"
    end

    println("Resultado: $num1 $operacion $num2 = $resultado")
    println("=" ^ 40)
end

calculadora_simple_demo()
println()

# ============================================================================
# 13. SALIDA CON COLORES (ANSI)
# ============================================================================

println("--- 13. Salida con Colores (ANSI) ---")
println()

# Julia soporta códigos ANSI para colores en la terminal
function imprimir_color()
    # Códigos de color ANSI
    rojo = "\033[31m"
    verde = "\033[32m"
    amarillo = "\033[33m"
    azul = "\033[34m"
    magenta = "\033[35m"
    cyan = "\033[36m"
    reset = "\033[0m"

    println("$(rojo)Texto en rojo$(reset)")
    println("$(verde)Texto en verde$(reset)")
    println("$(amarillo)Texto en amarillo$(reset)")
    println("$(azul)Texto en azul$(reset)")
    println("$(magenta)Texto en magenta$(reset)")
    println("$(cyan)Texto en cyan$(reset)")
end

imprimir_color()
println()

# ============================================================================
# 14. BARRAS DE PROGRESO SIMPLES
# ============================================================================

println("--- 14. Barra de Progreso Simple ---")
println()

function mostrar_progreso(porcentaje)
    ancho = 30
    completo = round(Int, ancho * porcentaje / 100)
    vacio = ancho - completo

    barra = "█" ^ completo * "░" ^ vacio
    print("\r[$barra] $porcentaje%")
    flush(stdout)
end

println("Ejemplo de barra de progreso:")
for i in 0:20:100
    mostrar_progreso(i)
    sleep(0.3)
end
println("\n✅ Completado!")
println()

# ============================================================================
# 15. EJERCICIOS PRÁCTICOS
# ============================================================================

println("=" ^ 70)
println("🎯 EJERCICIOS PARA PRACTICAR:")
println("=" ^ 70)
println()
println("1. Programa de saludo:")
println("   - Pide el nombre del usuario")
println("   - Pide su edad")
println("   - Muestra un mensaje personalizado")
println()
println("2. Calculadora básica:")
println("   - Pide dos números al usuario")
println("   - Pide la operación (+, -, *, /)")
println("   - Muestra el resultado")
println("   - Valida que no haya división por cero")
println()
println("3. Conversor de temperatura:")
println("   - Pide una temperatura en Celsius")
println("   - Convierte a Fahrenheit")
println("   - Muestra el resultado formateado")
println("   - Fórmula: F = C × 9/5 + 32")
println()
println("4. Validador de edad:")
println("   - Pide la edad del usuario")
println("   - Valida que sea un número entre 0 y 120")
println("   - Indica si es menor, adulto o adulto mayor")
println()
println("5. Menú de opciones:")
println("   - Crea un menú con 3 opciones diferentes")
println("   - Valida la entrada del usuario")
println("   - Ejecuta acciones según la opción")
println("   - Permite salir del programa")
println()

# ============================================================================
# TU CÓDIGO AQUÍ:
# ============================================================================

println("--- TUS SOLUCIONES (Descomenta para probar) ---")
println()

# Ejercicio 1: Programa de saludo
# function ejercicio_saludo()
#     println("Ingresa tu nombre: ")
#     nombre = readline()
#     println("Ingresa tu edad: ")
#     edad = parse(Int, readline())
#     println("¡Hola $nombre! Tienes $edad años.")
# end
# ejercicio_saludo()


# Ejercicio 2: Calculadora básica


# Ejercicio 3: Conversor de temperatura


# Ejercicio 4: Validador de edad


# Ejercicio 5: Menú de opciones


# ============================================================================

println()
println("=" ^ 70)
println("✅ ¡Programa completado!")
println("=" ^ 70)
println()
println("💡 Conceptos clave aprendidos:")
println("   ✓ print() y println() para salida")
println("   ✓ readline() para entrada")
println("   ✓ parse() para conversión de tipos")
println("   ✓ Validación de entrada con try-catch")
println("   ✓ Creación de menús interactivos")
println("   ✓ Formateo de salida")
println("   ✓ Uso de colores ANSI")
println()
println("📚 Próximo paso: 06_conversiones.jl")
println("=" ^ 70)
