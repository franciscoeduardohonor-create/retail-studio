# ============================================================================
# EJERCICIOS - MÓDULO 3: PROGRAMACIÓN Y CONTROL DE FLUJO
# ============================================================================

# ============================================================================
# EJERCICIO 1: CONDICIONALES BÁSICOS
# ============================================================================
# Escribe un if-else que determine si un número es positivo, negativo o cero

numero <- 15
# TU CÓDIGO AQUÍ:




# ============================================================================
# EJERCICIO 2: IFELSE VECTORIZADO
# ============================================================================
# Tienes ventas de una semana. Clasifica cada día como:
# "Excelente" (>= 2000), "Bueno" (>= 1500), "Regular" (>= 1000), "Bajo" (<1000)

ventas_semana <- c(1800, 2200, 900, 1500, 2500, 1200, 1600)
# TU CÓDIGO AQUÍ:




# ============================================================================
# EJERCICIO 3: BUCLE FOR
# ============================================================================
# Usa un for para imprimir los números del 1 al 10, pero solo los pares

# TU CÓDIGO AQUÍ:




# ============================================================================
# EJERCICIO 4: WHILE
# ============================================================================
# Usa while para encontrar el primer número mayor a 100 que sea divisible por 7

# TU CÓDIGO AQUÍ:




# ============================================================================
# EJERCICIO 5: FUNCIÓN SIMPLE
# ============================================================================
# Crea una función que calcule el área de un círculo (área = π * r²)
# Usa pi (constante en R) o 3.14159

# TU CÓDIGO AQUÍ:




# ============================================================================
# EJERCICIO 6: FUNCIÓN CON CONDICIONAL
# ============================================================================
# Crea una función que determine si un año es bisiesto
# Un año es bisiesto si es divisible por 4, excepto los siglos
# que deben ser divisibles por 400

es_bisiesto <- function(año) {
  # TU CÓDIGO AQUÍ:

}

# Prueba: 2024 (TRUE), 2023 (FALSE), 2000 (TRUE), 1900 (FALSE)




# ============================================================================
# EJERCICIO 7: FUNCIÓN CON BUCLE
# ============================================================================
# Crea una función que cuente cuántos números negativos hay en un vector

contar_negativos <- function(numeros) {
  # TU CÓDIGO AQUÍ:

}

# Prueba con: c(5, -3, 8, -2, 0, -7, 10)




# ============================================================================
# EJERCICIO 8: FUNCIÓN DE CONVERSIÓN
# ============================================================================
# Crea una función que convierta temperaturas de Celsius a Fahrenheit
# Fórmula: F = (C * 9/5) + 32

celsius_a_fahrenheit <- function(celsius) {
  # TU CÓDIGO AQUÍ:

}




# ============================================================================
# EJERCICIO 9: VALIDACIÓN DE DATOS
# ============================================================================
# Crea una función que valide un email (simplificado):
# - Debe contener "@"
# - Debe contener "."
# - Debe tener al menos 5 caracteres

validar_email <- function(email) {
  # TU CÓDIGO AQUÍ:

}

# Prueba con: "user@example.com", "invalido", "no@dominio"




# ============================================================================
# EJERCICIO 10: CALCULADORA DE PRÉSTAMOS
# ============================================================================
# Crea una función que calcule el pago mensual de un préstamo
# Parámetros: monto, tasa_anual (%), plazo_meses
# Fórmula simplificada: (monto + interés total) / plazo_meses
# donde interés total = monto * (tasa_anual/100) * (plazo_meses/12)

calcular_pago_mensual <- function(monto, tasa_anual, plazo_meses) {
  # TU CÓDIGO AQUÍ:

}

# Prueba con: monto=10000, tasa_anual=12, plazo_meses=24




print("¡Excelente! Completa estos ejercicios para dominar la programación en R")
