#!/usr/bin/env julia
# ============================================================================
# MÓDULO 1 - EJERCICIOS DE PRÁCTICA
# ============================================================================
# Completa estos ejercicios para consolidar tu aprendizaje del Módulo 1

println("=" ^ 70)
println("✏️  EJERCICIOS DEL MÓDULO 1")
println("=" ^ 70)
println()

# ============================================================================
# SECCIÓN 1: VARIABLES Y TIPOS
# ============================================================================

println("SECCIÓN 1: Variables y Tipos de Datos")
println("-" ^ 70)

# Ejercicio 1.1: Crear variables de diferentes tipos
println("\n📝 Ejercicio 1.1: Crea las siguientes variables:")
println("  - tu_nombre (String): tu nombre completo")
println("  - tu_edad (Int): tu edad")
println("  - tu_altura (Float64): tu altura en metros")
println("  - estudiante (Bool): ¿eres estudiante?")
println()

# TU CÓDIGO AQUÍ:




# Ejercicio 1.2: Verificar tipos
println("\n📝 Ejercicio 1.2: Verifica el tipo de cada variable con typeof()")

# TU CÓDIGO AQUÍ:




# Ejercicio 1.3: Números especiales
println("\n📝 Ejercicio 1.3:")
println("  - Crea un número complejo z = 5 + 3im")
println("  - Crea una fracción racional 7//12")
println("  - Calcula y muestra sus valores")

# TU CÓDIGO AQUÍ:




# ============================================================================
# SECCIÓN 2: OPERADORES
# ============================================================================

println("\n" * "=" ^ 70)
println("SECCIÓN 2: Operadores")
println("-" ^ 70)

# Ejercicio 2.1: Operaciones aritméticas
println("\n📝 Ejercicio 2.1: Dados a=45 y b=7, calcula:")
println("  - Suma, resta, multiplicación, división")
println("  - División entera (÷)")
println("  - Módulo (%)")
println("  - Potencia (^)")

a = 45
b = 7

# TU CÓDIGO AQUÍ:




# Ejercicio 2.2: Comparaciones
println("\n📝 Ejercicio 2.2: Dado x=25, verifica:")
println("  - ¿x es mayor que 20?")
println("  - ¿x está entre 10 y 30? (usa 10 <= x <= 30)")
println("  - ¿x es par? (usa x % 2 == 0)")

x = 25

# TU CÓDIGO AQUÍ:




# Ejercicio 2.3: Operador ternario
println("\n📝 Ejercicio 2.3:")
println("  Usa el operador ternario para clasificar una nota:")
println("  - nota >= 70: \"Aprobado\"")
println("  - nota < 70: \"Reprobado\"")

nota = 85

# TU CÓDIGO AQUÍ:




# ============================================================================
# SECCIÓN 3: STRINGS
# ============================================================================

println("\n" * "=" ^ 70)
println("SECCIÓN 3: Strings")
println("-" ^ 70)

# Ejercicio 3.1: Manipulación básica
println("\n📝 Ejercicio 3.1:")
frase = "Julia es un lenguaje moderno"
println("  Frase: \"$frase\"")
println("  - Convierte a mayúsculas")
println("  - Convierte a minúsculas")
println("  - Cuenta la longitud")
println("  - Divide en palabras")

# TU CÓDIGO AQUÍ:




# Ejercicio 3.2: Búsqueda y reemplazo
println("\n📝 Ejercicio 3.2:")
texto = "Me gusta programar. Programar es divertido."
println("  Texto: \"$texto\"")
println("  - ¿Contiene 'programar'?")
println("  - Reemplaza 'programar' por 'codificar'")

# TU CÓDIGO AQUÍ:




# Ejercicio 3.3: Interpolación
println("\n📝 Ejercicio 3.3:")
println("  Crea un mensaje usando interpolación:")
println("  Nombre: Ana, Edad: 28, Ciudad: Barcelona")
println("  Mensaje: \"Hola, me llamo [nombre], tengo [edad] años y vivo en [ciudad]\"")

# TU CÓDIGO AQUÍ:




# ============================================================================
# SECCIÓN 4: ENTRADA Y SALIDA
# ============================================================================

println("\n" * "=" ^ 70)
println("SECCIÓN 4: Entrada y Salida")
println("-" ^ 70)

# Ejercicio 4.1: Formateo de salida
println("\n📝 Ejercicio 4.1: Crea una tabla formateada:")
println("  Usa rpad() y lpad() para alinear:")
println()
println("  Producto        Precio")
println("  Laptop        \$999.99")
println("  Mouse          \$25.50")

# TU CÓDIGO AQUÍ:




# Ejercicio 4.2: Entrada del usuario (comentado)
println("\n📝 Ejercicio 4.2: Pedir entrada del usuario")
println("  Descomenta y completa el código:")
println()
println("# print(\"¿Cuál es tu color favorito?: \")")
println("# color = readline()")
println("# println(\"¡El $color es un color genial!\")")

# TU CÓDIGO AQUÍ (descomenta para probar):
# print("¿Cuál es tu color favorito?: ")
# color = readline()
# println("¡El $color es un color genial!")


# ============================================================================
# SECCIÓN 5: CONVERSIÓN DE TIPOS
# ============================================================================

println("\n" * "=" ^ 70)
println("SECCIÓN 5: Conversión de Tipos")
println("-" ^ 70)

# Ejercicio 5.1: String a número
println("\n📝 Ejercicio 5.1:")
texto_num = "42"
texto_float = "3.14159"
println("  Convierte \"$texto_num\" a Int")
println("  Convierte \"$texto_float\" a Float64")

# TU CÓDIGO AQUÍ:




# Ejercicio 5.2: Número a string
println("\n📝 Ejercicio 5.2:")
numero = 256
println("  Convierte $numero a String")
println("  Convierte $numero a binario (string)")
println("  Convierte $numero a hexadecimal (string)")

# TU CÓDIGO AQUÍ:




# Ejercicio 5.3: Redondeo
println("\n📝 Ejercicio 5.3:")
decimal = 7.8
println("  Dado el número $decimal:")
println("  - Redondea hacia abajo (floor)")
println("  - Redondea hacia arriba (ceil)")
println("  - Redondea al más cercano (round)")

# TU CÓDIGO AQUÍ:




# ============================================================================
# SECCIÓN 6: PROBLEMAS INTEGRADOS
# ============================================================================

println("\n" * "=" ^ 70)
println("SECCIÓN 6: Problemas Integrados")
println("-" ^ 70)

# Problema 1: Calcular el área de un círculo
println("\n📝 Problema 1: Área de un círculo")
println("  Dado radio = 5")
println("  Fórmula: A = π × r²")
println("  Calcula y muestra el área")

radio = 5

# TU CÓDIGO AQUÍ:




# Problema 2: Conversión de temperatura
println("\n📝 Problema 2: Convertir temperatura")
println("  Convierte 25°C a Fahrenheit")
println("  Fórmula: F = C × 9/5 + 32")

celsius = 25

# TU CÓDIGO AQUÍ:




# Problema 3: Calcular el IMC
println("\n📝 Problema 3: Índice de Masa Corporal")
println("  Peso: 70 kg, Altura: 1.75 m")
println("  Fórmula: IMC = peso / altura²")
println("  Clasifica el resultado:")
println("    < 18.5: Bajo peso")
println("    18.5-24.9: Normal")
println("    25-29.9: Sobrepeso")
println("    >= 30: Obesidad")

peso = 70
altura = 1.75

# TU CÓDIGO AQUÍ:




# Problema 4: Validar edad
println("\n📝 Problema 4: Clasificar por edad")
println("  Dada edad = 17, clasifica:")
println("    < 13: Niño")
println("    13-17: Adolescente")
println("    18-64: Adulto")
println("    >= 65: Adulto mayor")

edad = 17

# TU CÓDIGO AQUÍ:




# Problema 5: Calcular descuento
println("\n📝 Problema 5: Precio con descuento")
println("  Precio original: \$100")
println("  Descuento: 15%")
println("  Impuesto después del descuento: 16%")
println("  Calcula el precio final")

precio_original = 100.0
descuento_porcentaje = 15
impuesto_porcentaje = 16

# TU CÓDIGO AQUÍ:




# ============================================================================
# SECCIÓN 7: FUNCIONES (AVANCE)
# ============================================================================

println("\n" * "=" ^ 70)
println("SECCIÓN 7: Funciones Básicas (Avance)")
println("-" ^ 70)

# Ejercicio 7.1: Crear una función simple
println("\n📝 Ejercicio 7.1: Función para calcular el cuadrado")
println("  Crea una función cuadrado(x) que retorne x²")

# TU CÓDIGO AQUÍ:
# function cuadrado(x)
#     return x^2
# end

# Prueba tu función:
# println("El cuadrado de 5 es: $(cuadrado(5))")


# Ejercicio 7.2: Función con condicional
println("\n📝 Ejercicio 7.2: Función es_par")
println("  Crea una función que retorne true si un número es par")

# TU CÓDIGO AQUÍ:
# function es_par(numero)
#     return numero % 2 == 0
# end

# Prueba:
# println("¿7 es par? $(es_par(7))")
# println("¿8 es par? $(es_par(8))")


# Ejercicio 7.3: Función de saludo
println("\n📝 Ejercicio 7.3: Función saludar")
println("  Crea una función que reciba un nombre y retorne un saludo")

# TU CÓDIGO AQUÍ:
# function saludar(nombre)
#     return "¡Hola, $nombre! Bienvenido/a."
# end

# Prueba:
# println(saludar("María"))


# ============================================================================
# DESAFÍOS FINALES
# ============================================================================

println("\n" * "=" ^ 70)
println("🏆 DESAFÍOS FINALES")
println("=" ^ 70)

println("\n🎯 Desafío 1: Palíndromo")
println("  Crea una función que verifique si una palabra es palíndromo")
println("  Ejemplo: 'anilina' → true, 'casa' → false")
println("  Pista: Compara el string con su reverso")

# TU CÓDIGO AQUÍ:




println("\n🎯 Desafío 2: Contador de vocales")
println("  Crea una función que cuente cuántas vocales tiene un string")
println("  Ejemplo: 'Julia' → 3 vocales")

# TU CÓDIGO AQUÍ:




println("\n🎯 Desafío 3: Número primo")
println("  Crea una función que determine si un número es primo")
println("  Ejemplo: es_primo(7) → true, es_primo(8) → false")

# TU CÓDIGO AQUÍ:




println("\n🎯 Desafío 4: FizzBuzz")
println("  Implementa el clásico FizzBuzz:")
println("  - Números divisibles por 3: imprime 'Fizz'")
println("  - Números divisibles por 5: imprime 'Buzz'")
println("  - Números divisibles por ambos: imprime 'FizzBuzz'")
println("  - Otros números: imprime el número")
println("  Hazlo para números del 1 al 20")

# TU CÓDIGO AQUÍ:




println("\n🎯 Desafío 5: Generador de contraseñas")
println("  Crea una función que genere una contraseña aleatoria")
println("  - Longitud especificada por el usuario")
println("  - Incluye letras mayúsculas, minúsculas y números")
println("  Pista: usa rand() y caracteres")

# TU CÓDIGO AQUÍ:




# ============================================================================
# VERIFICACIÓN DE PROGRESO
# ============================================================================

println("\n" * "=" ^ 70)
println("✅ VERIFICACIÓN DE PROGRESO")
println("=" ^ 70)
println()
println("¿Completaste todos los ejercicios?")
println()
println("  ☐ Sección 1: Variables y Tipos")
println("  ☐ Sección 2: Operadores")
println("  ☐ Sección 3: Strings")
println("  ☐ Sección 4: Entrada y Salida")
println("  ☐ Sección 5: Conversión de Tipos")
println("  ☐ Sección 6: Problemas Integrados")
println("  ☐ Sección 7: Funciones Básicas")
println("  ☐ Desafíos Finales")
println()
println("Si completaste todo, ¡estás listo para el Módulo 2! 🎉")
println()
println("=" ^ 70)

# ============================================================================
# SOLUCIONES (Descomenta para ver)
# ============================================================================

# Las soluciones están disponibles en un archivo separado
# Intenta resolver los ejercicios por tu cuenta primero
# Si te atoras, consulta 'soluciones_modulo1.jl'

println("\n💡 Consejo: Intenta resolver todos los ejercicios sin mirar las soluciones")
println("La práctica es la clave para dominar Julia!")
println()
