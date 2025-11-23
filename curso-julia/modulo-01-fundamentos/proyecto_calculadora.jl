#!/usr/bin/env julia
# ============================================================================
# MÓDULO 1 - PROYECTO 1: Calculadora Interactiva
# ============================================================================
# Este proyecto integra todos los conceptos del Módulo 1:
# - Variables y tipos de datos
# - Operadores aritméticos
# - Entrada y salida
# - Conversión de tipos
# - Estructuras de control básicas
# - Funciones

println("=" ^ 70)
println("🧮 CALCULADORA INTERACTIVA EN JULIA")
println("=" ^ 70)
println()

# ============================================================================
# FUNCIONES AUXILIARES
# ============================================================================

"""
Limpia la pantalla (funciona en la mayoría de terminales)
"""
function limpiar_pantalla()
    print("\033[2J\033[H")
end

"""
Pausa la ejecución hasta que el usuario presione Enter
"""
function pausar()
    print("\nPresiona Enter para continuar...")
    readline()
end

"""
Lee un número flotante del usuario con validación
"""
function leer_numero(mensaje::String)
    while true
        print(mensaje)
        entrada = readline()

        # Intentar convertir a Float64
        numero = tryparse(Float64, entrada)

        if numero === nothing
            println("❌ Error: Ingresa un número válido")
        else
            return numero
        end
    end
end

"""
Lee una operación del usuario
"""
function leer_operacion()
    operaciones_validas = ["+", "-", "*", "/", "^", "%", "√"]

    while true
        print("Operación (+, -, *, /, ^, %, √): ")
        operacion = strip(readline())

        if operacion in operaciones_validas
            return operacion
        else
            println("❌ Operación no válida. Usa: +, -, *, /, ^, %, √")
        end
    end
end

"""
Muestra el menú principal y retorna la opción seleccionada
"""
function mostrar_menu()
    println("\n" * "=" ^ 70)
    println(" " ^ 20 * "CALCULADORA JULIA")
    println("=" ^ 70)
    println()
    println("  [1] Operación básica (+, -, *, /)")
    println("  [2] Potencia (^)")
    println("  [3] Raíz cuadrada (√)")
    println("  [4] Porcentaje (%)")
    println("  [5] Operaciones múltiples")
    println("  [6] Historial de cálculos")
    println("  [7] Acerca de")
    println("  [0] Salir")
    println()
    println("=" ^ 70)
    print("Selecciona una opción: ")
end

# ============================================================================
# FUNCIONES DE CÁLCULO
# ============================================================================

"""
Realiza una operación básica entre dos números
"""
function calcular(num1::Float64, num2::Float64, operacion::String)
    if operacion == "+"
        return num1 + num2
    elseif operacion == "-"
        return num1 - num2
    elseif operacion == "*"
        return num1 * num2
    elseif operacion == "/"
        if num2 == 0
            println("❌ Error: No se puede dividir por cero")
            return nothing
        end
        return num1 / num2
    elseif operacion == "^"
        return num1 ^ num2
    elseif operacion == "%"
        if num2 == 0
            println("❌ Error: No se puede calcular módulo con cero")
            return nothing
        end
        return num1 % num2
    else
        println("❌ Operación no reconocida")
        return nothing
    end
end

"""
Calcula la raíz cuadrada de un número
"""
function calcular_raiz(numero::Float64)
    if numero < 0
        println("❌ Error: No se puede calcular raíz cuadrada de número negativo")
        return nothing
    end
    return √numero
end

"""
Calcula el porcentaje de un número
"""
function calcular_porcentaje(numero::Float64, porcentaje::Float64)
    return (numero * porcentaje) / 100
end

# ============================================================================
# OPERACIONES DEL MENÚ
# ============================================================================

"""
Operación 1: Cálculo básico
"""
function operacion_basica(historial)
    println("\n" * "-" ^ 70)
    println("OPERACIÓN BÁSICA")
    println("-" ^ 70)

    num1 = leer_numero("Primer número: ")
    num2 = leer_numero("Segundo número: ")
    operacion = leer_operacion()

    resultado = calcular(num1, num2, operacion)

    if resultado !== nothing
        println()
        println("=" ^ 70)
        println("RESULTADO: $num1 $operacion $num2 = $resultado")
        println("=" ^ 70)

        # Guardar en historial
        push!(historial, "$num1 $operacion $num2 = $resultado")
    end

    pausar()
end

"""
Operación 2: Potencia
"""
function operacion_potencia(historial)
    println("\n" * "-" ^ 70)
    println("POTENCIA")
    println("-" ^ 70)

    base = leer_numero("Base: ")
    exponente = leer_numero("Exponente: ")

    resultado = base ^ exponente

    println()
    println("=" ^ 70)
    println("RESULTADO: $base ^ $exponente = $resultado")
    println("=" ^ 70)

    # Guardar en historial
    push!(historial, "$base ^ $exponente = $resultado")

    pausar()
end

"""
Operación 3: Raíz cuadrada
"""
function operacion_raiz(historial)
    println("\n" * "-" ^ 70)
    println("RAÍZ CUADRADA")
    println("-" ^ 70)

    numero = leer_numero("Número: ")

    resultado = calcular_raiz(numero)

    if resultado !== nothing
        println()
        println("=" ^ 70)
        println("RESULTADO: √$numero = $resultado")
        println("=" ^ 70)

        # Guardar en historial
        push!(historial, "√$numero = $resultado")
    end

    pausar()
end

"""
Operación 4: Porcentaje
"""
function operacion_porcentaje(historial)
    println("\n" * "-" ^ 70)
    println("CÁLCULO DE PORCENTAJE")
    println("-" ^ 70)

    numero = leer_numero("Número: ")
    porcentaje = leer_numero("Porcentaje: ")

    resultado = calcular_porcentaje(numero, porcentaje)

    println()
    println("=" ^ 70)
    println("RESULTADO: $porcentaje% de $numero = $resultado")
    println("=" ^ 70)

    # También mostrar operaciones útiles
    println()
    println("Operaciones relacionadas:")
    println("  $numero + $porcentaje% = $(numero + resultado)")
    println("  $numero - $porcentaje% = $(numero - resultado)")

    # Guardar en historial
    push!(historial, "$porcentaje% de $numero = $resultado")

    pausar()
end

"""
Operación 5: Operaciones múltiples (calculadora continua)
"""
function operaciones_multiples(historial)
    println("\n" * "-" ^ 70)
    println("OPERACIONES MÚLTIPLES")
    println("-" ^ 70)
    println("Realiza operaciones continuas. El resultado se usa para el siguiente cálculo.")
    println()

    resultado = leer_numero("Valor inicial: ")
    println("Resultado actual: $resultado")

    while true
        println()
        print("Operación (+, -, *, /, ^, = para finalizar): ")
        operacion = strip(readline())

        if operacion == "="
            println()
            println("=" ^ 70)
            println("RESULTADO FINAL: $resultado")
            println("=" ^ 70)

            # Guardar en historial
            push!(historial, "Operaciones múltiples → $resultado")
            break
        end

        if operacion in ["+", "-", "*", "/", "^"]
            num = leer_numero("Número: ")
            anterior = resultado
            resultado_calc = calcular(resultado, num, operacion)

            if resultado_calc !== nothing
                resultado = resultado_calc
                println("$anterior $operacion $num = $resultado")
            else
                println("Operación cancelada, resultado actual: $resultado")
            end
        else
            println("❌ Operación no válida")
        end
    end

    pausar()
end

"""
Operación 6: Mostrar historial
"""
function mostrar_historial(historial)
    println("\n" * "-" ^ 70)
    println("HISTORIAL DE CÁLCULOS")
    println("-" ^ 70)

    if isempty(historial)
        println("No hay cálculos en el historial.")
    else
        for (i, calculo) in enumerate(historial)
            println("  $i. $calculo")
        end
    end

    println("-" ^ 70)
    pausar()
end

"""
Operación 7: Acerca de
"""
function mostrar_acerca()
    println("\n" * "=" ^ 70)
    println("ACERCA DE LA CALCULADORA")
    println("=" ^ 70)
    println()
    println("📚 Calculadora Interactiva en Julia")
    println()
    println("Versión: 1.0")
    println("Lenguaje: Julia $(VERSION)")
    println("Autor: Curso de Julia - Módulo 1")
    println()
    println("Características:")
    println("  ✓ Operaciones básicas (+, -, *, /)")
    println("  ✓ Potencias y raíces")
    println("  ✓ Cálculo de porcentajes")
    println("  ✓ Operaciones continuas")
    println("  ✓ Historial de cálculos")
    println("  ✓ Validación de entrada")
    println()
    println("Este proyecto integra los conceptos del Módulo 1:")
    println("  • Variables y tipos de datos")
    println("  • Operadores aritméticos")
    println("  • Entrada/salida de datos")
    println("  • Conversión de tipos")
    println("  • Funciones")
    println()
    println("=" ^ 70)
    pausar()
end

# ============================================================================
# PROGRAMA PRINCIPAL
# ============================================================================

"""
Función principal de la calculadora
"""
function main()
    # Array para guardar historial
    historial = String[]

    while true
        # limpiar_pantalla()  # Descomenta si deseas limpiar la pantalla
        mostrar_menu()

        opcion = readline()

        if opcion == "1"
            operacion_basica(historial)
        elseif opcion == "2"
            operacion_potencia(historial)
        elseif opcion == "3"
            operacion_raiz(historial)
        elseif opcion == "4"
            operacion_porcentaje(historial)
        elseif opcion == "5"
            operaciones_multiples(historial)
        elseif opcion == "6"
            mostrar_historial(historial)
        elseif opcion == "7"
            mostrar_acerca()
        elseif opcion == "0"
            println()
            println("=" ^ 70)
            println("¡Gracias por usar la Calculadora Julia! 👋")
            println("=" ^ 70)
            break
        else
            println("❌ Opción no válida. Intenta de nuevo.")
            pausar()
        end
    end
end

# ============================================================================
# EJECUCIÓN
# ============================================================================

# Ejecutar la calculadora
main()

# ============================================================================
# EJERCICIOS DE EXTENSIÓN
# ============================================================================
#
# Una vez que domines esta calculadora, intenta agregar:
#
# 1. Funciones trigonométricas (sin, cos, tan)
# 2. Logaritmos (log, log10, log2)
# 3. Factorial de un número
# 4. Guardar historial en un archivo
# 5. Modo científico con notación científica
# 6. Conversión entre diferentes bases (binario, octal, hexadecimal)
# 7. Operaciones con números complejos
# 8. Estadísticas básicas (media, mediana, desviación estándar)
# 9. Resolver ecuaciones de segundo grado
# 10. Modo de conversión de unidades
#
# ============================================================================
