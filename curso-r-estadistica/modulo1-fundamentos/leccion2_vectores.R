# =============================================================================
# MÓDULO 1: FUNDAMENTOS DE R
# Lección 2: Vectores
# =============================================================================

# CONTENIDO:
# 1. Creación de vectores
# 2. Acceso a elementos
# 3. Operaciones con vectores
# 4. Funciones útiles para vectores

# =============================================================================
# 1. CREACIÓN DE VECTORES
# =============================================================================

# Un vector es una colección de elementos del mismo tipo
# Se crea con la función c() (combine/concatenar)

# Vector numérico
edades <- c(25, 30, 22, 28, 35, 40)
print(edades)

# Vector de caracteres
nombres <- c("Ana", "Luis", "María", "Carlos", "Elena", "Pedro")
print(nombres)

# Vector lógico
aprobados <- c(TRUE, TRUE, FALSE, TRUE, TRUE, FALSE)
print(aprobados)

# Secuencias numéricas
# Usando el operador :
secuencia1 <- 1:10
print(secuencia1)

# Usando seq()
secuencia2 <- seq(from = 0, to = 100, by = 10)  # De 0 a 100, de 10 en 10
print(secuencia2)

secuencia3 <- seq(0, 1, length.out = 11)  # 11 números entre 0 y 1
print(secuencia3)

# Repeticiones con rep()
repeticion1 <- rep(5, times = 10)  # Repite 5 diez veces
print(repeticion1)

repeticion2 <- rep(c(1, 2, 3), times = 3)  # Repite el vector 3 veces
print(repeticion2)

repeticion3 <- rep(c(1, 2, 3), each = 3)  # Repite cada elemento 3 veces
print(repeticion3)

# EJERCICIO 1: Crea los siguientes vectores:
# 1. Un vector con los días de la semana
# 2. Una secuencia del 50 al 100
# 3. Un vector que repita tu edad 5 veces
# Tu código aquí:




# =============================================================================
# 2. ACCESO A ELEMENTOS DEL VECTOR
# =============================================================================

# Los índices en R comienzan en 1 (no en 0 como en otros lenguajes)
calificaciones <- c(85, 92, 78, 95, 88, 76, 90)

# Acceder a un elemento
primera_calif <- calificaciones[1]
print(primera_calif)

tercera_calif <- calificaciones[3]
print(tercera_calif)

# Acceder a múltiples elementos
primeras_tres <- calificaciones[1:3]
print(primeras_tres)

# Acceder a elementos específicos
califs_seleccionadas <- calificaciones[c(1, 3, 5)]
print(califs_seleccionadas)

# Excluir elementos (usando índices negativos)
sin_primera <- calificaciones[-1]
print(sin_primera)

sin_primera_y_ultima <- calificaciones[-c(1, 7)]
print(sin_primera_y_ultima)

# Último elemento
ultimo <- calificaciones[length(calificaciones)]
print(ultimo)

# Modificar elementos
calificaciones[3] <- 80  # Cambiar la tercera calificación
print(calificaciones)

# EJERCICIO 2: Dado el siguiente vector:
numeros <- c(10, 20, 30, 40, 50, 60, 70, 80, 90, 100)
# 1. Obtén el 5to elemento
# 2. Obtén los elementos del 3 al 7
# 3. Cambia el valor del elemento 6 a 65
# Tu código aquí:




# =============================================================================
# 3. OPERACIONES CON VECTORES
# =============================================================================

# Operaciones vectorizadas (se aplican a cada elemento)
precios <- c(100, 200, 150, 300, 250)
print(precios)

# Aplicar descuento del 10%
precios_descuento <- precios * 0.9
print(precios_descuento)

# Sumar IVA del 16%
precios_con_iva <- precios * 1.16
print(precios_con_iva)

# Operaciones entre vectores
ventas_enero <- c(1000, 1500, 2000, 1800, 2200)
ventas_febrero <- c(1200, 1400, 2100, 1900, 2300)

# Suma de vectores (elemento por elemento)
ventas_totales <- ventas_enero + ventas_febrero
print(ventas_totales)

# Diferencia
crecimiento <- ventas_febrero - ventas_enero
print(crecimiento)

# Comparaciones (devuelven vectores lógicos)
ventas_altas <- ventas_enero > 1500
print(ventas_altas)

# Filtrado con vectores lógicos
calificaciones <- c(85, 92, 78, 95, 88, 76, 90)
aprobados <- calificaciones >= 80
print(aprobados)

# Obtener solo las calificaciones aprobadas
solo_aprobados <- calificaciones[aprobados]
print(solo_aprobados)

# O en una sola línea
solo_aprobados2 <- calificaciones[calificaciones >= 80]
print(solo_aprobados2)

# EJERCICIO 3: Dado el siguiente vector de temperaturas en Celsius:
temp_celsius <- c(0, 10, 20, 30, 40)
# 1. Convierte a Fahrenheit usando la fórmula: F = C * 9/5 + 32
# 2. Filtra las temperaturas mayores a 25°C
# Tu código aquí:




# =============================================================================
# 4. FUNCIONES ÚTILES PARA VECTORES
# =============================================================================

datos <- c(15, 22, 18, 25, 30, 19, 21, 28, 17, 23)

# Longitud del vector
longitud <- length(datos)
print(paste("Longitud:", longitud))

# Estadísticas básicas
promedio <- mean(datos)         # Media
mediana <- median(datos)        # Mediana
minimo <- min(datos)            # Valor mínimo
maximo <- max(datos)            # Valor máximo
rango <- range(datos)           # Mínimo y máximo
desv_est <- sd(datos)           # Desviación estándar
varianza <- var(datos)          # Varianza
suma_total <- sum(datos)        # Suma de todos los elementos

print(paste("Promedio:", promedio))
print(paste("Mediana:", mediana))
print(paste("Mínimo:", minimo))
print(paste("Máximo:", maximo))
print(paste("Desviación estándar:", desv_est))
print(paste("Suma total:", suma_total))

# Resumen completo
resumen <- summary(datos)
print(resumen)

# Ordenar
datos_ordenados <- sort(datos)                    # Ascendente
print(datos_ordenados)

datos_desc <- sort(datos, decreasing = TRUE)      # Descendente
print(datos_desc)

# Orden de índices
indices_orden <- order(datos)
print(indices_orden)

# Valores únicos
numeros_repetidos <- c(1, 2, 2, 3, 3, 3, 4, 5, 5)
unicos <- unique(numeros_repetidos)
print(unicos)

# Contar ocurrencias
tabla_frecuencias <- table(numeros_repetidos)
print(tabla_frecuencias)

# ¿Está el elemento en el vector?
20 %in% datos        # TRUE
100 %in% datos       # FALSE

# Encontrar posición de un elemento
which(datos == 25)   # Devuelve el índice donde datos es igual a 25
which(datos > 20)    # Devuelve todos los índices donde datos > 20

# EJERCICIO 4: Analiza el siguiente vector de ventas:
ventas <- c(450, 380, 520, 490, 410, 550, 470, 500, 430, 510)
# Calcula:
# 1. La venta promedio
# 2. La venta máxima y mínima
# 3. ¿Cuántas ventas fueron mayores a 480?
# 4. Ordena las ventas de mayor a menor
# Tu código aquí:




# =============================================================================
# EJEMPLO PRÁCTICO: ANÁLISIS DE CALIFICACIONES
# =============================================================================

# Datos de estudiantes
estudiantes <- c("Ana", "Luis", "María", "Carlos", "Elena", "Pedro", "Sofía", "Juan")
calificaciones <- c(85, 92, 78, 95, 88, 76, 90, 82)

# Análisis básico
print("=== ANÁLISIS DE CALIFICACIONES ===")
print(paste("Total de estudiantes:", length(estudiantes)))
print(paste("Calificación promedio:", round(mean(calificaciones), 2)))
print(paste("Calificación más alta:", max(calificaciones)))
print(paste("Calificación más baja:", min(calificaciones)))

# Estudiante con mejor calificación
indice_mejor <- which.max(calificaciones)
mejor_estudiante <- estudiantes[indice_mejor]
mejor_calificacion <- calificaciones[indice_mejor]
print(paste("Mejor estudiante:", mejor_estudiante, "con", mejor_calificacion))

# Estudiantes aprobados (>= 80)
aprobados <- calificaciones >= 80
num_aprobados <- sum(aprobados)  # sum() cuenta los TRUE
print(paste("Estudiantes aprobados:", num_aprobados))

# Lista de estudiantes aprobados
estudiantes_aprobados <- estudiantes[aprobados]
print("Estudiantes aprobados:")
print(estudiantes_aprobados)

# Calificaciones por encima del promedio
sobre_promedio <- calificaciones > mean(calificaciones)
print(paste("Estudiantes sobre el promedio:", sum(sobre_promedio)))

# EJERCICIO 5: Crea tu propio análisis
# Crea vectores con nombres y edades de 5 personas
# Luego calcula:
# 1. La edad promedio
# 2. Quién es la persona mayor
# 3. Cuántas personas son mayores de edad (>= 18)
# Tu código aquí:




# =============================================================================
# RESUMEN DE LA LECCIÓN 2
# =============================================================================
# ✓ Vectores: colecciones de elementos del mismo tipo
# ✓ Creación: c(), seq(), rep(), operador :
# ✓ Acceso: [índice], índices negativos para excluir
# ✓ Operaciones vectorizadas y filtrado con lógicos
# ✓ Funciones: mean(), median(), min(), max(), sum(), sort(), etc.

# =============================================================================
# ¡Felicidades! Has completado la Lección 2
# Continúa con leccion3_matrices_dataframes.R
# =============================================================================
