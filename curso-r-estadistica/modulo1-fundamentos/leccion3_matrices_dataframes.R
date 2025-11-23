# =============================================================================
# MÓDULO 1: FUNDAMENTOS DE R
# Lección 3: Matrices y Data Frames
# =============================================================================

# CONTENIDO:
# 1. Matrices
# 2. Data Frames
# 3. Listas
# 4. Factores

# =============================================================================
# 1. MATRICES
# =============================================================================

# Una matriz es un arreglo bidimensional de elementos del mismo tipo

# Crear matriz con matrix()
# Por defecto, R llena por columnas
matriz1 <- matrix(1:12, nrow = 3, ncol = 4)
print(matriz1)

# Llenar por filas
matriz2 <- matrix(1:12, nrow = 3, ncol = 4, byrow = TRUE)
print(matriz2)

# Crear matriz desde vectores
ventas_lun <- c(100, 150, 120)
ventas_mar <- c(110, 140, 130)
ventas_mie <- c(120, 160, 125)

# Combinar por columnas
ventas_matriz_col <- cbind(ventas_lun, ventas_mar, ventas_mie)
print(ventas_matriz_col)

# Combinar por filas
ventas_matriz_fil <- rbind(ventas_lun, ventas_mar, ventas_mie)
print(ventas_matriz_fil)

# Nombres de filas y columnas
rownames(ventas_matriz_col) <- c("Sucursal A", "Sucursal B", "Sucursal C")
colnames(ventas_matriz_col) <- c("Lunes", "Martes", "Miércoles")
print(ventas_matriz_col)

# Acceso a elementos de la matriz
# matriz[fila, columna]

# Un elemento específico
elemento <- ventas_matriz_col[1, 2]  # Fila 1, Columna 2
print(elemento)

# Toda una fila
fila1 <- ventas_matriz_col[1, ]      # Sucursal A
print(fila1)

# Toda una columna
columna2 <- ventas_matriz_col[, 2]   # Martes
print(columna2)

# Múltiples filas/columnas
submatriz <- ventas_matriz_col[1:2, 1:2]
print(submatriz)

# Dimensiones de la matriz
dim(ventas_matriz_col)      # Filas y columnas
nrow(ventas_matriz_col)     # Número de filas
ncol(ventas_matriz_col)     # Número de columnas

# Operaciones con matrices
matriz_a <- matrix(1:9, nrow = 3)
matriz_b <- matrix(10:18, nrow = 3)

# Suma y resta (elemento por elemento)
suma_matrices <- matriz_a + matriz_b
print(suma_matrices)

# Multiplicación elemento por elemento
mult_elemento <- matriz_a * matriz_b
print(mult_elemento)

# Multiplicación matricial
mult_matricial <- matriz_a %*% t(matriz_b)  # t() = transpuesta
print(mult_matricial)

# Transpuesta
transpuesta <- t(matriz_a)
print(transpuesta)

# Estadísticas por fila o columna
ventas_totales_sucursal <- rowSums(ventas_matriz_col)    # Suma por fila
ventas_totales_dia <- colSums(ventas_matriz_col)         # Suma por columna
promedio_sucursal <- rowMeans(ventas_matriz_col)         # Promedio por fila
promedio_dia <- colMeans(ventas_matriz_col)              # Promedio por columna

print(ventas_totales_sucursal)
print(ventas_totales_dia)

# EJERCICIO 1: Crea una matriz de calificaciones
# - 5 estudiantes (filas)
# - 4 materias (columnas)
# - Calcula el promedio de cada estudiante
# - Calcula el promedio de cada materia
# Tu código aquí:




# =============================================================================
# 2. DATA FRAMES
# =============================================================================

# Un data frame es como una tabla de Excel
# Cada columna puede tener un tipo de dato diferente
# Es la estructura más usada en análisis de datos

# Crear data frame desde vectores
estudiantes <- data.frame(
  nombre = c("Ana", "Luis", "María", "Carlos", "Elena"),
  edad = c(20, 22, 21, 23, 20),
  calificacion = c(85, 92, 88, 78, 95),
  aprobado = c(TRUE, TRUE, TRUE, TRUE, TRUE)
)

print(estudiantes)

# Ver estructura del data frame
str(estudiantes)

# Ver primeras filas
head(estudiantes)

# Ver últimas filas
tail(estudiantes)

# Dimensiones
dim(estudiantes)
nrow(estudiantes)
ncol(estudiantes)

# Nombres de columnas
names(estudiantes)
colnames(estudiantes)

# Resumen estadístico
summary(estudiantes)

# Acceso a columnas (4 formas)
# 1. Con $
edades1 <- estudiantes$edad
print(edades1)

# 2. Con [["nombre"]]
edades2 <- estudiantes[["edad"]]
print(edades2)

# 3. Con ["nombre"] (devuelve un data frame de 1 columna)
edades3 <- estudiantes["edad"]
print(edades3)

# 4. Con [, índice]
edades4 <- estudiantes[, 2]
print(edades4)

# Acceso a filas
primera_fila <- estudiantes[1, ]
print(primera_fila)

# Acceso a elemento específico
elemento <- estudiantes[2, "calificacion"]  # Luis, calificación
print(elemento)

# Múltiples columnas
subset_datos <- estudiantes[, c("nombre", "calificacion")]
print(subset_datos)

# Filtrado de filas
# Estudiantes con calificación >= 90
excelentes <- estudiantes[estudiantes$calificacion >= 90, ]
print(excelentes)

# Estudiantes mayores de 20 años
mayores_20 <- estudiantes[estudiantes$edad > 20, ]
print(mayores_20)

# Múltiples condiciones (& = AND, | = OR)
jovenes_excelentes <- estudiantes[estudiantes$edad <= 21 & estudiantes$calificacion >= 85, ]
print(jovenes_excelentes)

# Agregar nuevas columnas
estudiantes$semestre <- c(4, 6, 5, 7, 4)
print(estudiantes)

# Calcular nueva columna basada en otras
estudiantes$mayor_edad <- estudiantes$edad >= 18
print(estudiantes)

# Agregar nuevas filas
nuevo_estudiante <- data.frame(
  nombre = "Pedro",
  edad = 24,
  calificacion = 87,
  aprobado = TRUE,
  semestre = 8,
  mayor_edad = TRUE
)

estudiantes <- rbind(estudiantes, nuevo_estudiante)
print(estudiantes)

# Eliminar columnas
estudiantes$aprobado <- NULL
print(estudiantes)

# Ordenar data frame
# Por edad (ascendente)
estudiantes_ordenados <- estudiantes[order(estudiantes$edad), ]
print(estudiantes_ordenados)

# Por calificación (descendente)
estudiantes_por_calif <- estudiantes[order(-estudiantes$calificacion), ]
print(estudiantes_por_calif)

# EJERCICIO 2: Crea un data frame de productos
# Columnas: producto, precio, stock, categoria
# 6 productos de diferentes categorías
# Luego:
# 1. Filtra productos con precio > 100
# 2. Calcula el valor del inventario (precio * stock) como nueva columna
# 3. Ordena por valor de inventario descendente
# Tu código aquí:




# =============================================================================
# EJEMPLO PRÁCTICO: BASE DE DATOS DE VENTAS
# =============================================================================

# Crear base de datos de ventas
ventas_df <- data.frame(
  fecha = as.Date(c("2024-01-01", "2024-01-02", "2024-01-03",
                    "2024-01-04", "2024-01-05", "2024-01-06", "2024-01-07")),
  producto = c("Laptop", "Mouse", "Teclado", "Monitor", "Laptop", "Mouse", "Teclado"),
  cantidad = c(2, 15, 8, 3, 1, 20, 10),
  precio_unitario = c(15000, 250, 800, 5000, 15000, 250, 800),
  vendedor = c("Juan", "Ana", "Luis", "Ana", "Juan", "Luis", "Ana")
)

print(ventas_df)

# Calcular venta total
ventas_df$venta_total <- ventas_df$cantidad * ventas_df$precio_unitario
print(ventas_df)

# Análisis
print("=== ANÁLISIS DE VENTAS ===")
print(paste("Venta total del período:", sum(ventas_df$venta_total)))
print(paste("Venta promedio:", round(mean(ventas_df$venta_total), 2)))
print(paste("Venta máxima:", max(ventas_df$venta_total)))

# Ventas por vendedor
ventas_ana <- sum(ventas_df$venta_total[ventas_df$vendedor == "Ana"])
ventas_juan <- sum(ventas_df$venta_total[ventas_df$vendedor == "Juan"])
ventas_luis <- sum(ventas_df$venta_total[ventas_df$vendedor == "Luis"])

print(paste("Ventas Ana:", ventas_ana))
print(paste("Ventas Juan:", ventas_juan))
print(paste("Ventas Luis:", ventas_luis))

# Productos más vendidos (por cantidad)
ventas_por_producto <- aggregate(cantidad ~ producto, data = ventas_df, FUN = sum)
print("Ventas por producto:")
print(ventas_por_producto)

# =============================================================================
# 3. LISTAS
# =============================================================================

# Las listas pueden contener elementos de diferentes tipos y longitudes
mi_lista <- list(
  numeros = c(1, 2, 3, 4, 5),
  nombres = c("Ana", "Luis", "María"),
  matriz = matrix(1:6, nrow = 2),
  dato_simple = 42,
  logico = TRUE
)

print(mi_lista)

# Acceso a elementos de la lista
# Con [[]]
mi_lista[[1]]         # Primer elemento
mi_lista[["numeros"]] # Por nombre

# Con $
mi_lista$nombres

# Agregar elementos a la lista
mi_lista$nuevo_elemento <- c(10, 20, 30)
print(mi_lista)

# EJERCICIO 3: Crea una lista que contenga:
# - Un vector con tus 3 películas favoritas
# - Un vector con sus años de estreno
# - Una calificación (1-10) para cada una
# Tu código aquí:




# =============================================================================
# 4. FACTORES
# =============================================================================

# Los factores representan variables categóricas
# R los almacena internamente como números enteros con etiquetas

# Crear factor
genero <- factor(c("M", "F", "F", "M", "F", "M", "M", "F"))
print(genero)

# Ver niveles (categorías)
levels(genero)

# Ver estructura
str(genero)

# Factor ordenado
nivel_educativo <- factor(
  c("Primaria", "Universidad", "Secundaria", "Universidad", "Primaria"),
  levels = c("Primaria", "Secundaria", "Universidad"),
  ordered = TRUE
)
print(nivel_educativo)

# Los factores ordenados permiten comparaciones
nivel_educativo[1] < nivel_educativo[2]  # TRUE

# Tabla de frecuencias
table(genero)
table(nivel_educativo)

# Los factores son muy útiles en análisis estadísticos
edades <- c(25, 30, 28, 35, 27, 32, 29, 31)
generos <- factor(c("M", "F", "M", "F", "M", "F", "M", "F"))

# Promedios por grupo
tapply(edades, generos, mean)

# EJERCICIO 4: Crea un factor de categorías de productos
# Categorías: "Electrónica", "Ropa", "Alimentos"
# Crea 10 productos y cuenta cuántos hay de cada categoría
# Tu código aquí:




# =============================================================================
# RESUMEN DE LA LECCIÓN 3
# =============================================================================
# ✓ Matrices: arreglos 2D del mismo tipo
# ✓ Data Frames: tablas con columnas de diferentes tipos
# ✓ Listas: colecciones de elementos diversos
# ✓ Factores: variables categóricas
# ✓ Operaciones: filtrado, ordenamiento, agregación

# =============================================================================
# ¡Felicidades! Has completado el Módulo 1 - Fundamentos
# Continúa con el Módulo 2 - Manipulación de Datos
# =============================================================================
