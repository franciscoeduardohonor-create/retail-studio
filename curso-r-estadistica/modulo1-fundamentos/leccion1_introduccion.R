# =============================================================================
# MÓDULO 1: FUNDAMENTOS DE R
# Lección 1: Introducción a R y RStudio
# =============================================================================

# CONTENIDO:
# 1. Operaciones básicas
# 2. Tipos de datos
# 3. Variables y asignación
# 4. Operadores

# =============================================================================
# 1. OPERACIONES BÁSICAS
# =============================================================================

# R puede usarse como una calculadora
2 + 2          # Suma
10 - 3         # Resta
4 * 5          # Multiplicación
20 / 4         # División
2^3            # Potencia
sqrt(16)       # Raíz cuadrada
abs(-5)        # Valor absoluto

# EJERCICIO 1: Calcula el resultado de (15 + 25) * 2 / 4
# Tu código aquí:



# =============================================================================
# 2. TIPOS DE DATOS BÁSICOS
# =============================================================================

# Numérico (numeric)
edad <- 25
altura <- 1.75
print(class(edad))      # Imprime el tipo de dato
print(class(altura))

# Entero (integer) - se especifica con L
cantidad <- 100L
print(class(cantidad))

# Carácter (character) - texto entre comillas
nombre <- "Juan"
apellido <- 'Pérez'
print(class(nombre))

# Lógico (logical) - TRUE o FALSE
es_estudiante <- TRUE
tiene_licencia <- FALSE
print(class(es_estudiante))

# EJERCICIO 2: Crea las siguientes variables:
# - tu_nombre (tu nombre como texto)
# - tu_edad (tu edad como número)
# - estudias_r (TRUE si estás estudiando R)
# Tu código aquí:




# =============================================================================
# 3. VARIABLES Y ASIGNACIÓN
# =============================================================================

# Hay tres formas de asignar valores (se recomienda <-)
x <- 10        # Forma recomendada
y = 20         # También válido
30 -> z        # Válido pero poco común

print(x)
print(y)
print(z)

# Operaciones con variables
suma <- x + y
diferencia <- y - x
producto <- x * y
cociente <- y / x

print(suma)
print(diferencia)
print(producto)
print(cociente)

# Ver todas las variables en el entorno
ls()

# Eliminar una variable
rm(z)
ls()  # Verifica que z ya no existe

# EJERCICIO 3: Crea dos variables con tus números favoritos y:
# 1. Súmalos
# 2. Multiplícalos
# 3. Eleva uno a la potencia del otro
# Tu código aquí:




# =============================================================================
# 4. OPERADORES
# =============================================================================

# Operadores aritméticos (ya vistos arriba)
# +, -, *, /, ^, %% (módulo), %/% (división entera)

10 %% 3        # Módulo (resto de la división): 1
10 %/% 3       # División entera: 3

# Operadores de comparación
5 == 5         # Igual a: TRUE
5 != 3         # Diferente de: TRUE
5 > 3          # Mayor que: TRUE
5 < 3          # Menor que: FALSE
5 >= 5         # Mayor o igual que: TRUE
5 <= 4         # Menor o igual que: FALSE

# Operadores lógicos
TRUE & TRUE    # AND (Y): TRUE
TRUE & FALSE   # AND: FALSE
TRUE | FALSE   # OR (O): TRUE
FALSE | FALSE  # OR: FALSE
!TRUE          # NOT (NO): FALSE
!FALSE         # NOT: TRUE

# Ejemplo práctico
edad <- 20
es_mayor_edad <- edad >= 18
print(paste("¿Es mayor de edad?", es_mayor_edad))

tiene_dinero <- TRUE
tiene_tiempo <- FALSE
puede_viajar <- tiene_dinero & tiene_tiempo
print(paste("¿Puede viajar?", puede_viajar))

# EJERCICIO 4: Verifica si un número es par
# Pista: Un número es par si el resto de dividirlo entre 2 es 0
numero <- 17
# Tu código aquí (usa el operador %%)




# =============================================================================
# FUNCIONES ÚTILES PARA PRINCIPIANTES
# =============================================================================

# print() - Imprime en consola
print("Hola, R!")

# paste() - Concatena texto
saludo <- paste("Hola", nombre, apellido)
print(saludo)

# paste0() - Concatena sin espacios
codigo <- paste0("USR", 123)
print(codigo)

# c() - Crea vectores (lo veremos en detalle en la próxima lección)
numeros <- c(1, 2, 3, 4, 5)
print(numeros)

# help() o ? - Ayuda sobre funciones
help(sqrt)
?mean

# EJERCICIO 5: Crea un mensaje personalizado
# Usa paste() para crear una frase como: "Me llamo [tu_nombre] y tengo [tu_edad] años"
# Tu código aquí:




# =============================================================================
# RESUMEN DE LA LECCIÓN 1
# =============================================================================
# ✓ R puede usarse como calculadora
# ✓ Tipos de datos: numeric, character, logical
# ✓ Asignación de variables con <-
# ✓ Operadores: aritméticos, de comparación, lógicos
# ✓ Funciones básicas: print(), paste(), c(), help()

# =============================================================================
# ¡Felicidades! Has completado la Lección 1
# Continúa con leccion2_vectores.R
# =============================================================================
