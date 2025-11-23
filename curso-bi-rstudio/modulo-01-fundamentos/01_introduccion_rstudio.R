# ============================================================================
# MÓDULO 1 - LECCIÓN 1: INTRODUCCIÓN A RSTUDIO
# ============================================================================
# Objetivo: Familiarizarse con el entorno de RStudio y ejecutar código básico
# ============================================================================

# BIENVENIDO A R Y RSTUDIO
# =========================

# Este es un comentario en R. Los comentarios comienzan con el símbolo #
# Los comentarios no se ejecutan, sirven para documentar el código

# Para ejecutar una línea de código:
# - Windows/Linux: Ctrl + Enter
# - Mac: Cmd + Enter

# ============================================================================
# 1. R COMO CALCULADORA
# ============================================================================

# R puede realizar operaciones matemáticas básicas

# Suma
5 + 3

# Resta
10 - 4

# Multiplicación
6 * 7

# División
20 / 4

# Potencia
2^10

# Raíz cuadrada
sqrt(144)

# Módulo (residuo de una división)
17 %% 5

# División entera
17 %/% 5

# ============================================================================
# 2. VARIABLES: GUARDANDO VALORES
# ============================================================================

# En R usamos <- o = para asignar valores a variables
# La convención preferida es usar <-

# Asignar un número a una variable
ventas_enero <- 15000
ventas_febrero <- 18500
ventas_marzo <- 22000

# Ver el contenido de una variable
ventas_enero

# Imprimir explícitamente
print(ventas_febrero)

# Realizar operaciones con variables
total_trimestre <- ventas_enero + ventas_febrero + ventas_marzo
total_trimestre

# Calcular promedio
promedio_ventas <- total_trimestre / 3
promedio_ventas

# ============================================================================
# 3. TIPOS DE DATOS BÁSICOS
# ============================================================================

# NUMÉRICO (numeric)
precio <- 99.99
cantidad <- 150

# Ver el tipo de dato
class(precio)
class(cantidad)

# ENTERO (integer) - se especifica con L
productos_vendidos <- 42L
class(productos_vendidos)

# CARACTER/TEXTO (character)
nombre_producto <- "Laptop HP"
categoria <- "Electrónica"
class(nombre_producto)

# LÓGICO/BOOLEANO (logical)
en_stock <- TRUE
descontinuado <- FALSE
class(en_stock)

# ============================================================================
# 4. OPERADORES LÓGICOS
# ============================================================================

# Mayor que
10 > 5

# Menor que
3 < 8

# Mayor o igual que
15 >= 15

# Menor o igual que
7 <= 10

# Igual a (comparación)
5 == 5

# Diferente de
"A" != "B"

# Y lógico (AND)
TRUE & TRUE
TRUE & FALSE

# O lógico (OR)
TRUE | FALSE
FALSE | FALSE

# Negación (NOT)
!TRUE
!FALSE

# ============================================================================
# 5. FUNCIONES ÚTILES
# ============================================================================

# Función para crear una secuencia
secuencia <- 1:10
secuencia

# Secuencia con incremento específico
seq(from = 0, to = 100, by = 10)

# Repetir valores
rep(5, times = 7)
rep(c("A", "B"), times = 3)

# Valores perdidos (NA)
ventas_dia <- c(100, 200, NA, 150, 180)
ventas_dia

# Verificar si hay valores NA
is.na(ventas_dia)

# Contar valores NA
sum(is.na(ventas_dia))

# ============================================================================
# 6. AYUDA Y DOCUMENTACIÓN
# ============================================================================

# Obtener ayuda sobre una función
?mean
help(sum)

# Buscar en la documentación
??regression

# Ver ejemplos de una función
example(mean)

# ============================================================================
# 7. ENTORNO DE TRABAJO (WORKSPACE)
# ============================================================================

# Ver todas las variables en el entorno
ls()

# Ver estructura del entorno
ls.str()

# Eliminar una variable
mi_variable_temporal <- 123
rm(mi_variable_temporal)

# Eliminar todas las variables (¡CUIDADO!)
# rm(list = ls())  # Descomenta solo si quieres limpiar todo

# Ver directorio de trabajo actual
getwd()

# Cambiar directorio de trabajo
# setwd("C:/mis_proyectos/bi_curso")  # Windows
# setwd("/Users/usuario/mis_proyectos/bi_curso")  # Mac/Linux

# ============================================================================
# 8. BUENAS PRÁCTICAS
# ============================================================================

# 1. Usa nombres descriptivos para variables
total_ventas_2024 <- 50000  # BIEN
x <- 50000                  # NO tan claro

# 2. Usa snake_case para nombres (palabras_separadas_por_guion_bajo)
ingreso_neto_mensual <- 3500  # BIEN
IngresoNetoMensual <- 3500    # También funciona pero menos común en R

# 3. Comenta tu código para explicar QUÉ y POR QUÉ
descuento <- 0.15  # Descuento del 15% por promoción de temporada

# 4. Organiza tu código en secciones
# Usa comentarios con líneas para separar secciones claramente

# ============================================================================
# EJERCICIO PRÁCTICO 1
# ============================================================================

# Ejercicio: Calcular el margen de ganancia de un producto
# Datos:
# - Precio de venta: $450
# - Costo de producción: $280
# - Cantidad vendida: 125 unidades

# SOLUCIÓN:
precio_venta <- 450
costo_produccion <- 280
cantidad_vendida <- 125

# Calcular ganancia por unidad
ganancia_unitaria <- precio_venta - costo_produccion
ganancia_unitaria

# Calcular ganancia total
ganancia_total <- ganancia_unitaria * cantidad_vendida
ganancia_total

# Calcular margen de ganancia (%)
margen_porcentual <- (ganancia_unitaria / precio_venta) * 100
margen_porcentual

# ============================================================================
# EJERCICIO PRÁCTICO 2
# ============================================================================

# Ejercicio: Análisis de meta de ventas
# Meta mensual: $50,000
# Ventas actuales: $38,500

# SOLUCIÓN:
meta_mensual <- 50000
ventas_actuales <- 38500

# ¿Se cumplió la meta?
meta_cumplida <- ventas_actuales >= meta_mensual
meta_cumplida

# Calcular cuánto falta o cuánto se excedió
diferencia <- ventas_actuales - meta_mensual
diferencia

# Porcentaje de cumplimiento
porcentaje_cumplimiento <- (ventas_actuales / meta_mensual) * 100
porcentaje_cumplimiento

# Mensaje interpretativo
if (meta_cumplida) {
  print("¡Meta cumplida! Felicitaciones")
} else {
  print(paste("Falta alcanzar:", abs(diferencia), "para cumplir la meta"))
}

# ============================================================================
# EJERCICIOS PARA PRACTICAR TÚ
# ============================================================================

# 1. Crea variables con los siguientes datos de tu empresa:
#    - Número de empleados
#    - Ingresos mensuales
#    - Gastos operativos
#    - Calcula la utilidad neta

# TU CÓDIGO AQUÍ:




# 2. Una tienda ofrece 20% de descuento en productos mayores a $100
#    Precio original: $150
#    Calcula el precio final después del descuento

# TU CÓDIGO AQUÍ:




# 3. Calcula el ROI (Return on Investment)
#    Inversión inicial: $10,000
#    Ganancia obtenida: $13,500
#    Formula: ROI = ((Ganancia - Inversión) / Inversión) * 100

# TU CÓDIGO AQUÍ:




# ============================================================================
# ¡EXCELENTE TRABAJO!
# ============================================================================
# Has completado la primera lección. Ahora sabes:
# ✓ Ejecutar código en RStudio
# ✓ Crear variables y realizar operaciones
# ✓ Usar diferentes tipos de datos
# ✓ Obtener ayuda
# ✓ Aplicar conceptos básicos a problemas de negocio
#
# Continúa con: 02_tipos_datos.R
# ============================================================================
