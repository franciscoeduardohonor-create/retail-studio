# ============================================================================
# MÓDULO 1 - LECCIÓN 1: INTRODUCCIÓN A R Y RSTUDIO
# ============================================================================
# Descripción: Primera lección del curso de ML. Aprenderás los conceptos
#              básicos de R, operaciones matemáticas, y cómo usar RStudio.
# Nivel: Principiante
# Duración estimada: 2-3 horas
# ============================================================================

# ----------------------------------------------------------------------------
# SECCIÓN 1: ¿QUÉ ES R Y PARA QUÉ SIRVE?
# ----------------------------------------------------------------------------

# R es un lenguaje de programación especializado en:
# - Análisis estadístico
# - Visualización de datos
# - Machine Learning
# - Data Science

# Esta es tu primera línea de código en R
# El símbolo '#' se usa para comentarios (el código no se ejecuta)

print("¡Hola Mundo! Bienvenido a R")

# ----------------------------------------------------------------------------
# SECCIÓN 2: R COMO CALCULADORA
# ----------------------------------------------------------------------------

# R puede hacer operaciones matemáticas básicas

# Suma
2 + 3                    # Resultado: 5

# Resta
10 - 4                   # Resultado: 6

# Multiplicación
5 * 6                    # Resultado: 30

# División
20 / 4                   # Resultado: 5

# Potencia
2^3                      # Resultado: 8 (2 elevado a la 3)
2**3                     # Resultado: 8 (también funciona con **)

# Módulo (residuo de división)
17 %% 5                  # Resultado: 2 (residuo de 17/5)

# División entera
17 %/% 5                 # Resultado: 3 (parte entera de 17/5)

# Raíz cuadrada
sqrt(16)                 # Resultado: 4

# Valor absoluto
abs(-10)                 # Resultado: 10

# Redondeo
round(3.14159, 2)        # Resultado: 3.14 (redondea a 2 decimales)
ceiling(3.2)             # Resultado: 4 (redondea hacia arriba)
floor(3.9)               # Resultado: 3 (redondea hacia abajo)

# ----------------------------------------------------------------------------
# SECCIÓN 3: VARIABLES
# ----------------------------------------------------------------------------

# Las variables almacenan valores para usarlos después
# En R usamos <- o = para asignar valores (preferimos <-)

# Crear variables numéricas
x <- 5                   # Asigna 5 a la variable x
y <- 10                  # Asigna 10 a la variable y
z <- x + y              # z ahora vale 15

# Imprimir el valor de una variable
print(x)                 # Muestra: 5
print(z)                 # Muestra: 15

# También puedes solo escribir el nombre de la variable
x                        # Muestra: 5
z                        # Muestra: 15

# Variables con texto (strings/cadenas)
nombre <- "Juan"
apellido <- "Pérez"

# Concatenar texto
nombre_completo <- paste(nombre, apellido)
print(nombre_completo)   # Muestra: Juan Pérez

# Variables lógicas (booleanas)
es_estudiante <- TRUE
tiene_trabajo <- FALSE

# ----------------------------------------------------------------------------
# SECCIÓN 4: TIPOS DE DATOS
# ----------------------------------------------------------------------------

# R tiene varios tipos de datos básicos:

# 1. Numeric (números con decimales)
precio <- 99.99
class(precio)            # Muestra: "numeric"

# 2. Integer (números enteros)
edad <- 25L              # La 'L' indica que es entero
class(edad)              # Muestra: "integer"

# 3. Character (texto)
ciudad <- "México"
class(ciudad)            # Muestra: "character"

# 4. Logical (verdadero/falso)
activo <- TRUE
class(activo)            # Muestra: "logical"

# Verificar el tipo de dato
typeof(precio)           # Muestra el tipo interno
mode(precio)             # Muestra el modo del dato

# ----------------------------------------------------------------------------
# SECCIÓN 5: VECTORES (ESTRUCTURAS FUNDAMENTALES)
# ----------------------------------------------------------------------------

# Un vector es una colección de elementos del mismo tipo
# Es la estructura de datos más importante en R

# Crear vectores con la función c() (combinar)
numeros <- c(1, 2, 3, 4, 5)
print(numeros)

# Vector de nombres
nombres <- c("Ana", "Luis", "María", "Carlos")
print(nombres)

# Vector de valores lógicos
aprobados <- c(TRUE, FALSE, TRUE, TRUE)
print(aprobados)

# Operaciones con vectores (se aplican a cada elemento)
ventas <- c(100, 200, 150, 300, 250)

# Multiplicar cada venta por 1.16 (agregar IVA)
ventas_con_iva <- ventas * 1.16
print(ventas_con_iva)

# Sumar 50 a cada venta
ventas_plus <- ventas + 50
print(ventas_plus)

# Crear secuencias
# Secuencia del 1 al 10
seq1 <- 1:10
print(seq1)

# Secuencia con incrementos específicos
seq2 <- seq(from = 0, to = 100, by = 10)  # De 0 a 100, de 10 en 10
print(seq2)

# Secuencia de longitud específica
seq3 <- seq(from = 0, to = 1, length.out = 11)  # 11 números entre 0 y 1
print(seq3)

# Repetir valores
rep1 <- rep(5, times = 10)    # Repite 5, diez veces
print(rep1)

rep2 <- rep(c(1, 2, 3), times = 3)  # Repite el vector 3 veces
print(rep2)

rep3 <- rep(c(1, 2, 3), each = 3)   # Repite cada elemento 3 veces
print(rep3)

# ----------------------------------------------------------------------------
# SECCIÓN 6: ACCEDER A ELEMENTOS DE VECTORES
# ----------------------------------------------------------------------------

# En R, los índices comienzan en 1 (no en 0 como en Python)

frutas <- c("manzana", "pera", "naranja", "plátano", "uva")

# Acceder al primer elemento
frutas[1]                # Resultado: "manzana"

# Acceder al tercer elemento
frutas[3]                # Resultado: "naranja"

# Acceder a múltiples elementos
frutas[c(1, 3, 5)]       # Resultado: "manzana" "naranja" "uva"

# Acceder a un rango
frutas[2:4]              # Resultado: "pera" "naranja" "plátano"

# Excluir elementos (usando índice negativo)
frutas[-1]               # Todos excepto el primero
frutas[-c(1, 3)]         # Todos excepto el primero y tercero

# Modificar elementos
frutas[2] <- "sandía"
print(frutas)

# ----------------------------------------------------------------------------
# SECCIÓN 7: FUNCIONES ÚTILES PARA VECTORES
# ----------------------------------------------------------------------------

numeros <- c(10, 25, 15, 30, 20, 18, 22)

# Longitud del vector
length(numeros)          # Resultado: 7

# Suma de todos los elementos
sum(numeros)             # Resultado: 140

# Promedio
mean(numeros)            # Resultado: 20

# Mediana
median(numeros)          # Resultado: 20

# Valor mínimo y máximo
min(numeros)             # Resultado: 10
max(numeros)             # Resultado: 30

# Rango (mínimo y máximo)
range(numeros)           # Resultado: 10 30

# Desviación estándar
sd(numeros)              # Resultado: 6.78...

# Varianza
var(numeros)             # Resultado: 46

# Ordenar
sort(numeros)            # Orden ascendente
sort(numeros, decreasing = TRUE)  # Orden descendente

# Obtener índices ordenados
order(numeros)           # Posiciones de los elementos ordenados

# Valores únicos
numeros_repetidos <- c(1, 2, 2, 3, 3, 3, 4, 5, 5)
unique(numeros_repetidos)  # Resultado: 1 2 3 4 5

# Contar frecuencias
table(numeros_repetidos)

# ----------------------------------------------------------------------------
# SECCIÓN 8: OPERACIONES LÓGICAS
# ----------------------------------------------------------------------------

# Los operadores lógicos devuelven TRUE o FALSE

# Igualdad
5 == 5                   # TRUE
5 == 3                   # FALSE

# Diferente
5 != 3                   # TRUE
5 != 5                   # FALSE

# Mayor que, menor que
5 > 3                    # TRUE
5 < 3                    # FALSE
5 >= 5                   # TRUE
5 <= 4                   # FALSE

# Operadores lógicos con vectores
ventas <- c(100, 200, 150, 300, 250)

# ¿Qué ventas son mayores a 200?
ventas > 200             # FALSE FALSE FALSE TRUE TRUE

# Filtrar ventas mayores a 200
ventas_altas <- ventas[ventas > 200]
print(ventas_altas)      # 300 250

# Operadores AND (&) y OR (|)
# AND: ambas condiciones deben ser TRUE
TRUE & TRUE              # TRUE
TRUE & FALSE             # FALSE

# OR: al menos una condición debe ser TRUE
TRUE | FALSE             # TRUE
FALSE | FALSE            # FALSE

# Filtros múltiples
# Ventas entre 150 y 250
ventas_medias <- ventas[ventas >= 150 & ventas <= 250]
print(ventas_medias)     # 200 150 250

# ----------------------------------------------------------------------------
# SECCIÓN 9: VALORES FALTANTES (NA)
# ----------------------------------------------------------------------------

# NA representa valores faltantes (Not Available)
datos <- c(10, 20, NA, 40, 50, NA)

# Detectar valores NA
is.na(datos)             # FALSE FALSE TRUE FALSE FALSE TRUE

# Contar cuántos NA hay
sum(is.na(datos))        # Resultado: 2

# Eliminar NA
datos_limpios <- na.omit(datos)
print(datos_limpios)     # 10 20 40 50

# Funciones que ignoran NA
mean(datos)              # Resultado: NA
mean(datos, na.rm = TRUE)  # Resultado: 30 (promedio sin NA)

sum(datos)               # Resultado: NA
sum(datos, na.rm = TRUE)   # Resultado: 120

# ----------------------------------------------------------------------------
# SECCIÓN 10: EJERCICIOS PRÁCTICOS
# ----------------------------------------------------------------------------

cat("\n=== EJERCICIOS PRÁCTICOS ===\n\n")

# EJERCICIO 1: Crear un vector con las edades de 5 personas
# Tu turno: Descomenta las siguientes líneas y completa el código
# edades <- c(__, __, __, __, __)
# print(edades)

# Solución:
edades <- c(25, 30, 18, 45, 32)
print(edades)

# EJERCICIO 2: Calcular el promedio de las edades
promedio_edades <- mean(edades)
cat("Promedio de edades:", promedio_edades, "\n")

# EJERCICIO 3: Crear un vector de ventas de una semana
ventas_semana <- c(1500, 2000, 1800, 2200, 1900, 2500, 1700)

# ¿Cuál fue la venta total de la semana?
venta_total <- sum(ventas_semana)
cat("Venta total de la semana:", venta_total, "\n")

# ¿Cuál fue el promedio de ventas diarias?
promedio_diario <- mean(ventas_semana)
cat("Promedio diario:", promedio_diario, "\n")

# ¿Qué días tuvieron ventas superiores al promedio?
dias <- c("Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo")
dias_superiores <- dias[ventas_semana > promedio_diario]
cat("Días con ventas superiores al promedio:", dias_superiores, "\n")

# EJERCICIO 4: Temperatura en grados Celsius, convertir a Fahrenheit
# Fórmula: F = C * 9/5 + 32
temperaturas_c <- c(0, 10, 20, 25, 30, 35)
temperaturas_f <- temperaturas_c * 9/5 + 32
cat("\nTemperaturas en Celsius:", temperaturas_c, "\n")
cat("Temperaturas en Fahrenheit:", temperaturas_f, "\n")

# EJERCICIO 5: Calcular el precio final con descuento e IVA
precios <- c(100, 200, 150, 300)
descuento <- 0.10  # 10% de descuento
iva <- 0.16        # 16% de IVA

# Aplicar descuento
precios_con_descuento <- precios * (1 - descuento)

# Aplicar IVA
precios_finales <- precios_con_descuento * (1 + iva)

cat("\nPrecios originales:", precios, "\n")
cat("Precios con descuento:", precios_con_descuento, "\n")
cat("Precios finales (con IVA):", precios_finales, "\n")

# ----------------------------------------------------------------------------
# SECCIÓN 11: DESAFÍOS PARA PRACTICAR
# ----------------------------------------------------------------------------

cat("\n=== DESAFÍOS PARA TI ===\n\n")

# DESAFÍO 1: Crear un vector con los números del 1 al 100
# Encuentra cuántos son divisibles por 7
# Pista: usa el operador %% (módulo)

numeros_1_100 <- 1:100
divisibles_7 <- numeros_1_100[numeros_1_100 %% 7 == 0]
cat("Números divisibles por 7:", divisibles_7, "\n")
cat("Total de números divisibles por 7:", length(divisibles_7), "\n")

# DESAFÍO 2: Tienes las ventas de 3 productos en 4 meses
# Calcula el total por producto

# Ventas del Producto A
producto_a <- c(1000, 1200, 1100, 1300)

# Ventas del Producto B
producto_b <- c(800, 900, 850, 950)

# Ventas del Producto C
producto_c <- c(1500, 1600, 1550, 1700)

# Calcula el total de cada producto
total_a <- sum(producto_a)
total_b <- sum(producto_b)
total_c <- sum(producto_c)

cat("\nTotal Producto A:", total_a, "\n")
cat("Total Producto B:", total_b, "\n")
cat("Total Producto C:", total_c, "\n")

# ¿Cuál producto vendió más?
productos <- c("Producto A", "Producto B", "Producto C")
totales <- c(total_a, total_b, total_c)
producto_ganador <- productos[which.max(totales)]
cat("Producto con más ventas:", producto_ganador, "\n")

# DESAFÍO 3: Crear un sistema de calificaciones
# Calificaciones de un estudiante
calificaciones <- c(85, 90, 78, 92, 88)

# Calcular:
# - Promedio
# - Calificación más alta
# - Calificación más baja
# - ¿Aprobó? (promedio >= 70)

promedio <- mean(calificaciones)
mas_alta <- max(calificaciones)
mas_baja <- min(calificaciones)
aprobo <- promedio >= 70

cat("\n=== REPORTE DE CALIFICACIONES ===\n")
cat("Calificaciones:", calificaciones, "\n")
cat("Promedio:", promedio, "\n")
cat("Calificación más alta:", mas_alta, "\n")
cat("Calificación más baja:", mas_baja, "\n")
cat("¿Aprobó?:", aprobo, "\n")

# ----------------------------------------------------------------------------
# RESUMEN DE LA LECCIÓN
# ----------------------------------------------------------------------------

cat("\n=== RESUMEN ===\n")
cat("En esta lección aprendiste:\n")
cat("1. Operaciones matemáticas básicas en R\n")
cat("2. Crear y usar variables\n")
cat("3. Tipos de datos: numeric, integer, character, logical\n")
cat("4. Vectores: crear, acceder, modificar\n")
cat("5. Funciones útiles: mean, sum, max, min, etc.\n")
cat("6. Operaciones lógicas y filtros\n")
cat("7. Manejo de valores NA\n")
cat("\n¡Excelente trabajo! Ahora practica estos conceptos antes de continuar.\n")
cat("Siguiente lección: Estructuras de datos (listas, matrices, data frames)\n")

# ============================================================================
# FIN DE LA LECCIÓN 1
# ============================================================================
