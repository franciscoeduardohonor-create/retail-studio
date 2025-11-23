# ============================================================================
# MÓDULO 2: ESTRUCTURAS DE DATOS EN R
# ============================================================================
# Aprenderás sobre las principales estructuras de datos: vectores, matrices,
# listas, data frames y factores

# ============================================================================
# 1. VECTORES (REPASO Y PROFUNDIZACIÓN)
# ============================================================================

# Los vectores son la estructura básica en R
# Todos los elementos deben ser del mismo tipo

# Vectores numéricos
numeros <- c(1, 2, 3, 4, 5)
decimales <- c(1.5, 2.7, 3.9)

# Vectores de caracteres
nombres <- c("Ana", "Juan", "María", "Pedro")
ciudades <- c("Madrid", "Barcelona", "Valencia")

# Vectores lógicos
aprobados <- c(TRUE, TRUE, FALSE, TRUE)

# Operaciones vectorizadas (elemento por elemento)
v1 <- c(1, 2, 3, 4)
v2 <- c(10, 20, 30, 40)

v1 + v2        # c(11, 22, 33, 44)
v1 * 2         # c(2, 4, 6, 8)
v1 > 2         # c(FALSE, FALSE, TRUE, TRUE)

# Indexación avanzada
numeros <- c(10, 20, 30, 40, 50, 60)
numeros[c(1, 3, 5)]           # Elementos en posiciones 1, 3, 5
numeros[-c(2, 4)]             # Todos excepto posiciones 2 y 4
numeros[numeros > 30]         # Elementos mayores que 30: 40, 50, 60

# Nombres en vectores
edades <- c(25, 30, 35, 28)
names(edades) <- c("Ana", "Juan", "María", "Pedro")
print(edades)
edades["Ana"]                 # Acceder por nombre: 25

# ============================================================================
# 2. MATRICES
# ============================================================================

# Las matrices son arreglos bidimensionales (filas y columnas)
# Todos los elementos deben ser del mismo tipo

# Crear matrices
matriz1 <- matrix(1:9, nrow = 3, ncol = 3)
print(matriz1)

# Por defecto llena por columnas, usar byrow = TRUE para llenar por filas
matriz2 <- matrix(1:9, nrow = 3, ncol = 3, byrow = TRUE)
print(matriz2)

# Crear matriz con vectores
ventas_lunes <- c(100, 200, 150)
ventas_martes <- c(120, 180, 160)
ventas_miercoles <- c(110, 190, 170)

# Combinar por columnas
ventas_matriz <- cbind(ventas_lunes, ventas_martes, ventas_miercoles)
print(ventas_matriz)

# Combinar por filas
ventas_matriz2 <- rbind(ventas_lunes, ventas_martes, ventas_miercoles)
print(ventas_matriz2)

# Nombrar filas y columnas
rownames(ventas_matriz) <- c("Producto A", "Producto B", "Producto C")
colnames(ventas_matriz) <- c("Lunes", "Martes", "Miércoles")
print(ventas_matriz)

# Acceder a elementos de la matriz
ventas_matriz[1, 2]              # Fila 1, columna 2
ventas_matriz[1, ]               # Toda la fila 1
ventas_matriz[, 2]               # Toda la columna 2
ventas_matriz["Producto A", "Lunes"]  # Por nombres

# Operaciones con matrices
matriz_a <- matrix(1:4, nrow = 2)
matriz_b <- matrix(5:8, nrow = 2)

matriz_a + matriz_b              # Suma elemento por elemento
matriz_a * matriz_b              # Multiplicación elemento por elemento
matriz_a %*% matriz_b            # Multiplicación matricial

# Funciones útiles para matrices
dim(matriz1)                     # Dimensiones: filas y columnas
nrow(matriz1)                    # Número de filas
ncol(matriz1)                    # Número de columnas
t(matriz1)                       # Transpuesta
rowSums(ventas_matriz)           # Suma por filas
colSums(ventas_matriz)           # Suma por columnas
rowMeans(ventas_matriz)          # Media por filas
colMeans(ventas_matriz)          # Media por columnas

# ============================================================================
# 3. LISTAS
# ============================================================================

# Las listas pueden contener diferentes tipos de datos
# Son muy flexibles y potentes

# Crear una lista simple
mi_lista <- list(
  numeros = c(1, 2, 3, 4, 5),
  nombres = c("Ana", "Juan", "María"),
  logico = TRUE,
  matriz = matrix(1:6, nrow = 2)
)

print(mi_lista)

# Acceder a elementos de la lista
mi_lista[[1]]                    # Primer elemento (vector de números)
mi_lista$numeros                 # Por nombre
mi_lista[["numeros"]]            # Por nombre (alternativa)

# Lista con información de una persona
persona <- list(
  nombre = "Juan Pérez",
  edad = 30,
  ciudad = "Madrid",
  casado = TRUE,
  hijos = c("Ana", "Pedro"),
  salario = 35000
)

print(paste(persona$nombre, "tiene", persona$edad, "años"))
print(paste("Número de hijos:", length(persona$hijos)))

# Lista de listas (anidadas)
empleados <- list(
  empleado1 = list(nombre = "Ana", edad = 25, salario = 30000),
  empleado2 = list(nombre = "Juan", edad = 30, salario = 35000),
  empleado3 = list(nombre = "María", edad = 28, salario = 32000)
)

empleados$empleado1$nombre       # "Ana"
empleados[[2]]$salario           # 35000

# Agregar elementos a una lista
mi_lista$nuevo <- "Elemento nuevo"
mi_lista[[length(mi_lista) + 1]] <- 42

# Longitud de una lista
length(mi_lista)

# ============================================================================
# 4. DATA FRAMES (¡LA ESTRUCTURA MÁS IMPORTANTE!)
# ============================================================================

# Los data frames son como tablas de Excel
# Cada columna puede tener un tipo de dato diferente
# Cada columna debe tener la misma longitud

# Crear un data frame
estudiantes <- data.frame(
  nombre = c("Ana", "Juan", "María", "Pedro", "Lucía"),
  edad = c(20, 22, 21, 23, 20),
  calificacion = c(85, 92, 78, 88, 95),
  aprobado = c(TRUE, TRUE, TRUE, TRUE, TRUE),
  stringsAsFactors = FALSE  # Evita convertir texto a factores
)

print(estudiantes)

# Ver estructura del data frame
str(estudiantes)

# Resumen estadístico
summary(estudiantes)

# Dimensiones
dim(estudiantes)                 # Filas y columnas
nrow(estudiantes)                # Número de filas
ncol(estudiantes)                # Número de columnas

# Ver primeras y últimas filas
head(estudiantes, 3)             # Primeras 3 filas
tail(estudiantes, 2)             # Últimas 2 filas

# Nombres de columnas
names(estudiantes)
colnames(estudiantes)

# Acceder a columnas
estudiantes$nombre               # Como lista
estudiantes[, "nombre"]          # Como matriz
estudiantes[["nombre"]]          # Como lista (alternativa)
estudiantes[, 1]                 # Por índice

# Acceder a filas
estudiantes[1, ]                 # Primera fila
estudiantes[c(1, 3, 5), ]        # Filas 1, 3 y 5

# Acceder a elementos específicos
estudiantes[1, "nombre"]         # Fila 1, columna "nombre"
estudiantes$calificacion[3]      # Tercera calificación

# Filtrar filas (IMPORTANTE)
estudiantes[estudiantes$edad > 21, ]              # Mayores de 21
estudiantes[estudiantes$calificacion >= 90, ]     # Calificación >= 90
estudiantes[estudiantes$nombre == "Ana", ]        # Solo Ana

# Filtros múltiples
estudiantes[estudiantes$edad > 20 & estudiantes$calificacion > 85, ]

# Ordenar data frames
estudiantes_ordenados <- estudiantes[order(estudiantes$calificacion), ]  # Ascendente
estudiantes_desc <- estudiantes[order(-estudiantes$calificacion), ]      # Descendente

print(estudiantes_ordenados)

# Agregar nuevas columnas
estudiantes$nota_letra <- ifelse(estudiantes$calificacion >= 90, "A",
                          ifelse(estudiantes$calificacion >= 80, "B",
                          ifelse(estudiantes$calificacion >= 70, "C", "F")))

# Agregar nuevas filas
nuevo_estudiante <- data.frame(
  nombre = "Carlos",
  edad = 22,
  calificacion = 87,
  aprobado = TRUE,
  nota_letra = "B"
)

estudiantes <- rbind(estudiantes, nuevo_estudiante)

# Eliminar columnas
estudiantes$nota_letra <- NULL   # Eliminar columna

# Crear data frame de ventas
ventas_df <- data.frame(
  producto = c("A", "B", "C", "A", "B", "C"),
  mes = c("Enero", "Enero", "Enero", "Febrero", "Febrero", "Febrero"),
  ventas = c(1200, 1500, 1800, 1300, 1600, 1900),
  costos = c(800, 1000, 1200, 900, 1100, 1300)
)

# Calcular ganancias
ventas_df$ganancia <- ventas_df$ventas - ventas_df$costos
ventas_df$margen <- (ventas_df$ganancia / ventas_df$ventas) * 100

print(ventas_df)

# ============================================================================
# 5. FACTORES
# ============================================================================

# Los factores representan datos categóricos
# Útiles para variables cualitativas (niveles fijos)

# Crear un factor
genero <- factor(c("Masculino", "Femenino", "Femenino", "Masculino", "Masculino"))
print(genero)
levels(genero)                   # Niveles únicos

# Factor con niveles específicos
satisfaccion <- factor(
  c("Bajo", "Alto", "Medio", "Alto", "Bajo", "Medio"),
  levels = c("Bajo", "Medio", "Alto"),
  ordered = TRUE  # Factor ordenado
)

print(satisfaccion)
levels(satisfaccion)

# Contar frecuencias
table(genero)
table(satisfaccion)

# Factor de meses
meses <- factor(
  c("Ene", "Feb", "Mar", "Ene", "Feb"),
  levels = c("Ene", "Feb", "Mar", "Abr", "May", "Jun",
             "Jul", "Ago", "Sep", "Oct", "Nov", "Dic")
)

# Convertir factor a numérico
numeros_factor <- factor(c("1", "2", "3", "2", "1"))
as.numeric(as.character(numeros_factor))  # Convierte correctamente

# ============================================================================
# 6. EJEMPLO PRÁCTICO INTEGRADOR
# ============================================================================

# Base de datos de empleados
empleados_df <- data.frame(
  id = 1:10,
  nombre = c("Ana", "Juan", "María", "Pedro", "Lucía",
             "Carlos", "Laura", "Miguel", "Sofia", "Diego"),
  departamento = c("Ventas", "IT", "Ventas", "IT", "RRHH",
                   "Ventas", "IT", "RRHH", "Ventas", "IT"),
  salario = c(30000, 45000, 32000, 48000, 35000,
              31000, 46000, 36000, 33000, 47000),
  años_experiencia = c(2, 5, 3, 6, 4, 2, 5, 4, 3, 6),
  stringsAsFactors = FALSE
)

print("=== BASE DE DATOS DE EMPLEADOS ===")
print(empleados_df)

# Análisis por departamento
print("\n=== ANÁLISIS POR DEPARTAMENTO ===")

# Salario promedio por departamento
tapply(empleados_df$salario, empleados_df$departamento, mean)

# Contar empleados por departamento
table(empleados_df$departamento)

# Filtrar departamento IT
empleados_it <- empleados_df[empleados_df$departamento == "IT", ]
print("\nEmpleados de IT:")
print(empleados_it)

# Calcular salario máximo y mínimo
print(paste("Salario máximo:", max(empleados_df$salario)))
print(paste("Salario mínimo:", min(empleados_df$salario)))

# Empleados con salario > 40000
empleados_alto_salario <- empleados_df[empleados_df$salario > 40000, ]
print("\nEmpleados con salario > 40000:")
print(empleados_alto_salario[, c("nombre", "salario", "departamento")])

# Crear categoría de experiencia
empleados_df$nivel_exp <- ifelse(empleados_df$años_experiencia >= 5, "Senior",
                          ifelse(empleados_df$años_experiencia >= 3, "Mid", "Junior"))

# Tabla cruzada
table(empleados_df$departamento, empleados_df$nivel_exp)

print("\n¡Felicidades! Has completado el Módulo 2")
