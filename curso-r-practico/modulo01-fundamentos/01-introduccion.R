# ============================================================================
# MÓDULO 1: INTRODUCCIÓN Y FUNDAMENTOS DE R
# ============================================================================
# En este módulo aprenderás los conceptos básicos de R y RStudio

# ============================================================================
# 1. R COMO CALCULADORA
# ============================================================================

# R puede realizar operaciones matemáticas básicas
2 + 3          # Suma: 5
10 - 4         # Resta: 6
5 * 6          # Multiplicación: 30
20 / 4         # División: 5
2^3            # Potencia: 8
sqrt(16)       # Raíz cuadrada: 4
abs(-10)       # Valor absoluto: 10

# Operaciones más complejas
(5 + 3) * 2    # Los paréntesis controlan el orden: 16
10 %% 3        # Módulo (residuo de la división): 1
10 %/% 3       # División entera: 3

# ============================================================================
# 2. VARIABLES Y ASIGNACIÓN
# ============================================================================

# Crear variables usando <- (preferido) o =
x <- 10                    # Asigna el valor 10 a x
y <- 5                     # Asigna el valor 5 a y
nombre <- "Juan"           # Asigna un texto a nombre
edad <- 25                 # Asigna un número a edad

# Ver el contenido de una variable
print(x)                   # Imprime: 10
x                          # También imprime: 10

# Operaciones con variables
suma <- x + y              # suma vale 15
producto <- x * y          # producto vale 50
mensaje <- paste("Hola", nombre)  # Concatena texto

# Ver el valor
print(suma)
print(mensaje)

# ============================================================================
# 3. TIPOS DE DATOS BÁSICOS
# ============================================================================

# Numéricos (numeric)
numero_entero <- 42
numero_decimal <- 3.14159
print(class(numero_entero))     # "numeric"
print(class(numero_decimal))    # "numeric"

# Caracteres (character) - texto entre comillas
texto <- "Hola Mundo"
letra <- 'A'
print(class(texto))             # "character"

# Lógicos (logical) - TRUE o FALSE
verdadero <- TRUE
falso <- FALSE
print(class(verdadero))         # "logical"

# Enteros explícitos (integer)
entero <- 42L                   # La L indica que es entero
print(class(entero))            # "integer"

# ============================================================================
# 4. OPERADORES LÓGICOS Y COMPARACIÓN
# ============================================================================

# Operadores de comparación
5 > 3          # Mayor que: TRUE
5 < 3          # Menor que: FALSE
5 >= 5         # Mayor o igual: TRUE
5 <= 3         # Menor o igual: FALSE
5 == 5         # Igual a: TRUE
5 != 3         # Diferente de: TRUE

# Operadores lógicos
TRUE & TRUE    # AND (y): TRUE
TRUE & FALSE   # AND: FALSE
TRUE | FALSE   # OR (o): TRUE
FALSE | FALSE  # OR: FALSE
!TRUE          # NOT (no): FALSE
!FALSE         # NOT: TRUE

# Ejemplos prácticos
edad <- 25
es_mayor_edad <- edad >= 18           # TRUE
tiene_licencia <- TRUE
puede_conducir <- es_mayor_edad & tiene_licencia  # TRUE

print(puede_conducir)

# ============================================================================
# 5. FUNCIONES BÁSICAS ÚTILES
# ============================================================================

# Ver el tipo de un objeto
class(42)                  # "numeric"
class("Hola")              # "character"
class(TRUE)                # "logical"

# Ver la estructura de un objeto
str(x)                     # num 10

# Información sobre un objeto
typeof(x)                  # "double"
length(x)                  # 1 (número de elementos)

# Funciones matemáticas comunes
log(10)                    # Logaritmo natural
log10(100)                 # Logaritmo base 10: 2
exp(1)                     # e^1: 2.718282
round(3.14159, 2)          # Redondear a 2 decimales: 3.14
ceiling(3.2)               # Redondear hacia arriba: 4
floor(3.8)                 # Redondear hacia abajo: 3

# ============================================================================
# 6. VECTORES - LA ESTRUCTURA MÁS IMPORTANTE
# ============================================================================

# Crear vectores con c() (combine)
numeros <- c(1, 2, 3, 4, 5)
nombres <- c("Ana", "Juan", "María", "Pedro")
logicos <- c(TRUE, FALSE, TRUE, TRUE)

print(numeros)

# Secuencias de números
secuencia1 <- 1:10                    # Números del 1 al 10
secuencia2 <- seq(0, 100, by = 10)    # De 0 a 100 de 10 en 10
repetidos <- rep(5, times = 10)       # El número 5 repetido 10 veces

print(secuencia1)
print(secuencia2)
print(repetidos)

# Operaciones con vectores
v1 <- c(1, 2, 3, 4)
v2 <- c(10, 20, 30, 40)

suma_vectores <- v1 + v2              # c(11, 22, 33, 44)
producto_vectores <- v1 * v2          # c(10, 40, 90, 160)
v1_mas_10 <- v1 + 10                  # c(11, 12, 13, 14)

print(suma_vectores)
print(producto_vectores)

# Acceder a elementos de un vector (indexación empieza en 1)
numeros <- c(10, 20, 30, 40, 50)
numeros[1]                            # Primer elemento: 10
numeros[3]                            # Tercer elemento: 30
numeros[c(1, 3, 5)]                   # Elementos 1, 3 y 5: 10, 30, 50
numeros[2:4]                          # Elementos del 2 al 4: 20, 30, 40

# Modificar elementos
numeros[1] <- 100                     # Cambia el primer elemento
print(numeros)                        # 100, 20, 30, 40, 50

# ============================================================================
# 7. FUNCIONES ESTADÍSTICAS BÁSICAS
# ============================================================================

datos <- c(12, 15, 18, 20, 22, 25, 30)

# Medidas de tendencia central
mean(datos)                           # Media (promedio): 20.28571
median(datos)                         # Mediana: 20

# Medidas de dispersión
sd(datos)                             # Desviación estándar: 6.24
var(datos)                            # Varianza: 38.9
min(datos)                            # Valor mínimo: 12
max(datos)                            # Valor máximo: 30
range(datos)                          # Rango (min y max)

# Resumen estadístico completo
summary(datos)                        # Muestra min, Q1, mediana, media, Q3, max

# Suma y producto
sum(datos)                            # Suma de todos: 142
prod(c(2, 3, 4))                      # Producto: 24

# Contar elementos
length(datos)                         # Número de elementos: 7

# ============================================================================
# 8. VALORES ESPECIALES
# ============================================================================

# NA (Not Available) - dato faltante
edad_con_faltante <- c(25, 30, NA, 35, 40)
mean(edad_con_faltante)               # Devuelve NA
mean(edad_con_faltante, na.rm = TRUE) # Calcula sin NAs: 32.5

# Identificar NAs
is.na(edad_con_faltante)              # Vector lógico
sum(is.na(edad_con_faltante))         # Cuenta cuántos NAs hay

# NULL - objeto vacío
x <- NULL
is.null(x)                            # TRUE

# Inf y -Inf (infinito)
1/0                                   # Inf
-1/0                                  # -Inf

# NaN (Not a Number)
0/0                                   # NaN

# ============================================================================
# 9. CARACTERES Y TEXTO
# ============================================================================

# Crear texto
saludo <- "Hola"
nombre <- "María"

# Concatenar texto
mensaje <- paste(saludo, nombre)              # "Hola María"
mensaje2 <- paste(saludo, nombre, sep = ", ") # "Hola, María"
mensaje3 <- paste0(saludo, nombre)            # "HolaMaría" (sin espacio)

# Longitud de un texto
nchar("Hola")                         # 4 caracteres

# Convertir a mayúsculas/minúsculas
toupper("hola")                       # "HOLA"
tolower("HOLA")                       # "hola"

# Extraer parte de un texto
substr("Hola Mundo", 1, 4)            # "Hola"

# ============================================================================
# 10. AYUDA Y DOCUMENTACIÓN
# ============================================================================

# Obtener ayuda sobre una función
?mean                                 # Abre la documentación de mean
help(mean)                            # Alternativa
??mean                                # Búsqueda más amplia

# Ver ejemplos de uso
example(mean)

# ============================================================================
# EJEMPLO PRÁCTICO INTEGRADOR
# ============================================================================

# Imaginemos que tienes las ventas semanales de una tienda
ventas <- c(1200, 1500, 980, 1800, 2100, 1650, 1400)
dias <- c("Lun", "Mar", "Mié", "Jue", "Vie", "Sáb", "Dom")

# Análisis básico
print("=== ANÁLISIS DE VENTAS SEMANALES ===")
print(paste("Total de ventas:", sum(ventas)))
print(paste("Promedio diario:", round(mean(ventas), 2)))
print(paste("Día con más ventas:", dias[which.max(ventas)]))
print(paste("Día con menos ventas:", dias[which.min(ventas)]))
print(paste("Ventas máximas:", max(ventas)))
print(paste("Ventas mínimas:", min(ventas)))

# Calcular comisión del 5%
comision <- ventas * 0.05
print(paste("Comisión total de la semana:", sum(comision)))

# Identificar días con ventas superiores al promedio
promedio <- mean(ventas)
dias_buenos <- ventas > promedio
print("Días con ventas sobre el promedio:")
print(dias[dias_buenos])

print("¡Felicidades! Has completado el Módulo 1")
