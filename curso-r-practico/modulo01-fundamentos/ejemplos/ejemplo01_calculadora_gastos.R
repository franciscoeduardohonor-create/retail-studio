# ============================================================================
# EJEMPLO PRÁCTICO 1: CALCULADORA DE GASTOS MENSUALES
# ============================================================================
# Este ejemplo te ayudará a calcular y analizar tus gastos mensuales

# Paso 1: Define tus gastos mensuales
alquiler <- 800
comida <- 400
transporte <- 150
servicios <- 120
entretenimiento <- 100
otros <- 80

# Paso 2: Calcula el total de gastos
total_gastos <- alquiler + comida + transporte + servicios +
                entretenimiento + otros

print("=== ANÁLISIS DE GASTOS MENSUALES ===")
print(paste("Total de gastos:", total_gastos))

# Paso 3: Calcula el porcentaje de cada categoría
porcentaje_alquiler <- (alquiler / total_gastos) * 100
porcentaje_comida <- (comida / total_gastos) * 100
porcentaje_transporte <- (transporte / total_gastos) * 100
porcentaje_servicios <- (servicios / total_gastos) * 100
porcentaje_entretenimiento <- (entretenimiento / total_gastos) * 100
porcentaje_otros <- (otros / total_gastos) * 100

print(paste("Alquiler:", round(porcentaje_alquiler, 1), "%"))
print(paste("Comida:", round(porcentaje_comida, 1), "%"))
print(paste("Transporte:", round(porcentaje_transporte, 1), "%"))
print(paste("Servicios:", round(porcentaje_servicios, 1), "%"))
print(paste("Entretenimiento:", round(porcentaje_entretenimiento, 1), "%"))
print(paste("Otros:", round(porcentaje_otros, 1), "%"))

# Paso 4: Calcula cuánto necesitas ganar para ahorrar el 20%
# Si quieres ahorrar el 20%, tus gastos deben ser el 80% de tu ingreso
ingreso_recomendado <- total_gastos / 0.8
ahorro_objetivo <- ingreso_recomendado * 0.2

print(paste("\nPara ahorrar el 20%, necesitas ganar:", round(ingreso_recomendado, 2)))
print(paste("Esto te permitiría ahorrar:", round(ahorro_objetivo, 2), "al mes"))

# Paso 5: Proyección anual
total_anual <- total_gastos * 12
ahorro_anual <- ahorro_objetivo * 12

print(paste("\nGastos anuales:", total_anual))
print(paste("Ahorro anual potencial:", round(ahorro_anual, 2)))

# ============================================================================
# AHORA PRUÉBALO TÚ
# ============================================================================
# 1. Modifica los valores de los gastos con tus propios datos
# 2. Agrega nuevas categorías de gastos (ej: gimnasio, mascotas, etc.)
# 3. Calcula cuánto necesitas ganar para ahorrar el 30%
# 4. ¿Cuál es tu categoría de gasto más grande?
