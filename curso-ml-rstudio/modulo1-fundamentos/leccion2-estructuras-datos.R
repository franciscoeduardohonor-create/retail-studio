# ============================================================================
# MÓDULO 1 - LECCIÓN 2: ESTRUCTURAS DE DATOS EN R
# ============================================================================
# Descripción: Aprenderás a trabajar con matrices, listas y data frames,
#              estructuras fundamentales para Machine Learning
# Nivel: Principiante
# Duración estimada: 3-4 horas
# Prerequisito: Haber completado Lección 1
# ============================================================================

# ----------------------------------------------------------------------------
# SECCIÓN 1: MATRICES
# ----------------------------------------------------------------------------

# Una matriz es una estructura bidimensional (filas y columnas)
# Todos los elementos deben ser del mismo tipo

# Crear una matriz con la función matrix()
# Sintaxis: matrix(data, nrow, ncol, byrow)

# Ejemplo 1: Matriz 3x3 con números del 1 al 9
matriz1 <- matrix(1:9, nrow = 3, ncol = 3)
print(matriz1)

# Por defecto, R llena las matrices por columnas
# Si queremos llenar por filas, usamos byrow = TRUE
matriz2 <- matrix(1:9, nrow = 3, ncol = 3, byrow = TRUE)
print(matriz2)

# Ejemplo práctico: Ventas de 3 productos en 4 meses
ventas_matrix <- matrix(
  c(1000, 1200, 1100, 1300,    # Producto A
    800, 900, 850, 950,         # Producto B
    1500, 1600, 1550, 1700),    # Producto C
  nrow = 3,
  ncol = 4,
  byrow = TRUE
)

# Dar nombres a filas y columnas
rownames(ventas_matrix) <- c("Producto A", "Producto B", "Producto C")
colnames(ventas_matrix) <- c("Enero", "Febrero", "Marzo", "Abril")

print(ventas_matrix)

# Acceder a elementos de una matriz
# Sintaxis: matriz[fila, columna]

# Acceder a un elemento específico (Producto B en Marzo)
ventas_matrix[2, 3]              # Resultado: 850

# Acceder a una fila completa (todas las ventas del Producto A)
ventas_matrix[1, ]               # Todas las columnas de la fila 1

# Acceder a una columna completa (ventas de Enero)
ventas_matrix[, 1]               # Todas las filas de la columna 1

# Acceder usando nombres
ventas_matrix["Producto A", "Marzo"]     # 1100
ventas_matrix["Producto B", ]            # Todas las ventas del Producto B

# Operaciones con matrices

# Suma de todas las ventas
total_ventas <- sum(ventas_matrix)
cat("Total de ventas:", total_ventas, "\n")

# Total por fila (total por producto)
totales_productos <- rowSums(ventas_matrix)
print(totales_productos)

# Total por columna (total por mes)
totales_meses <- colSums(ventas_matrix)
print(totales_meses)

# Promedio por fila
promedios_productos <- rowMeans(ventas_matrix)
print(promedios_productos)

# Promedio por columna
promedios_meses <- colMeans(ventas_matrix)
print(promedios_meses)

# Agregar una fila
producto_d <- c(1100, 1150, 1200, 1250)
ventas_matrix_nueva <- rbind(ventas_matrix, "Producto D" = producto_d)
print(ventas_matrix_nueva)

# Agregar una columna
mayo <- c(1400, 1000, 1750, 1300)
ventas_matrix_completa <- cbind(ventas_matrix_nueva, "Mayo" = mayo)
print(ventas_matrix_completa)

# Operaciones aritméticas con matrices
# Aumentar todas las ventas en un 10%
ventas_incrementadas <- ventas_matrix * 1.10
print(ventas_incrementadas)

# Transponer una matriz (intercambiar filas por columnas)
ventas_transpuesta <- t(ventas_matrix)
print(ventas_transpuesta)

# Dimensiones de una matriz
dim(ventas_matrix)               # Resultado: 3 4 (3 filas, 4 columnas)
nrow(ventas_matrix)              # Número de filas: 3
ncol(ventas_matrix)              # Número de columnas: 4

# ----------------------------------------------------------------------------
# SECCIÓN 2: LISTAS
# ----------------------------------------------------------------------------

# Las listas pueden contener diferentes tipos de datos
# Son muy flexibles y útiles para estructuras complejas

# Crear una lista simple
mi_lista <- list(
  nombre = "Juan",
  edad = 30,
  calificaciones = c(85, 90, 88),
  aprobado = TRUE
)

print(mi_lista)

# Acceder a elementos de una lista

# Método 1: Usando el nombre con $
mi_lista$nombre                  # "Juan"
mi_lista$calificaciones          # 85 90 88

# Método 2: Usando [[]]
mi_lista[[1]]                    # "Juan" (primer elemento)
mi_lista[["edad"]]               # 30

# Método 3: Usando [] (devuelve una sublista)
mi_lista[1]                      # Lista con solo el nombre

# Ejemplo práctico: Información de un cliente
cliente <- list(
  id = 101,
  nombre = "María García",
  edad = 28,
  ciudad = "Ciudad de México",
  compras = c(500, 750, 1200, 300),
  premium = TRUE,
  contacto = list(
    email = "maria@email.com",
    telefono = "555-1234"
  )
)

print(cliente)

# Acceder a elementos anidados
cliente$contacto$email           # "maria@email.com"
cliente$compras[3]               # 1200 (tercera compra)

# Calcular total de compras del cliente
total_compras <- sum(cliente$compras)
cat("Total de compras:", total_compras, "\n")

# Agregar elementos a una lista
cliente$ultima_visita <- "2025-11-20"
cliente$puntos <- 1500

# Modificar elementos
cliente$edad <- 29

# Lista de listas (ejemplo: base de datos de clientes)
base_clientes <- list(
  cliente1 = list(nombre = "Ana", edad = 25, ciudad = "CDMX"),
  cliente2 = list(nombre = "Luis", edad = 32, ciudad = "Guadalajara"),
  cliente3 = list(nombre = "Carlos", edad = 28, ciudad = "Monterrey")
)

# Acceder a un cliente específico
base_clientes$cliente2$nombre    # "Luis"

# Iterar sobre una lista (lo veremos más a detalle en la siguiente lección)
nombres_clientes <- sapply(base_clientes, function(x) x$nombre)
print(nombres_clientes)

# ----------------------------------------------------------------------------
# SECCIÓN 3: DATA FRAMES (¡MUY IMPORTANTE PARA ML!)
# ----------------------------------------------------------------------------

# Un data frame es como una tabla de Excel
# Es la estructura MÁS IMPORTANTE para análisis de datos y Machine Learning
# Cada columna puede tener un tipo diferente, pero todos los valores
# en una columna deben ser del mismo tipo

# Crear un data frame
empleados <- data.frame(
  nombre = c("Ana", "Luis", "María", "Carlos", "Pedro"),
  edad = c(25, 32, 28, 35, 29),
  departamento = c("Ventas", "IT", "Ventas", "IT", "RH"),
  salario = c(15000, 25000, 18000, 28000, 20000),
  antiguedad = c(2, 5, 3, 7, 4)
)

print(empleados)

# Ver estructura del data frame
str(empleados)

# Resumen estadístico
summary(empleados)

# Primeras filas
head(empleados)                  # Por defecto muestra 6 filas
head(empleados, 3)               # Muestra 3 filas

# Últimas filas
tail(empleados)

# Dimensiones
dim(empleados)                   # filas x columnas
nrow(empleados)                  # número de filas
ncol(empleados)                  # número de columnas

# Nombres de columnas
names(empleados)
colnames(empleados)

# Acceder a columnas

# Método 1: Usando $
empleados$nombre
empleados$salario

# Método 2: Usando [, "nombre_columna"]
empleados[, "edad"]

# Método 3: Usando [, número]
empleados[, 2]                   # Segunda columna (edad)

# Acceder a filas
empleados[1, ]                   # Primera fila (Ana)
empleados[3, ]                   # Tercera fila (María)

# Acceder a un elemento específico
empleados[2, "salario"]          # Salario de Luis
empleados[2, 4]                  # Mismo resultado (fila 2, columna 4)

# Filtrar data frames (MUY IMPORTANTE)

# Empleados mayores de 30 años
empleados_30plus <- empleados[empleados$edad > 30, ]
print(empleados_30plus)

# Empleados del departamento de IT
empleados_it <- empleados[empleados$departamento == "IT", ]
print(empleados_it)

# Empleados de Ventas con salario > 16000
empleados_ventas_alto <- empleados[
  empleados$departamento == "Ventas" & empleados$salario > 16000,
]
print(empleados_ventas_alto)

# Seleccionar columnas específicas
# Solo nombre y salario
empleados_simple <- empleados[, c("nombre", "salario")]
print(empleados_simple)

# Agregar una nueva columna

# Calcular bono (10% del salario)
empleados$bono <- empleados$salario * 0.10
print(empleados)

# Salario total (salario + bono)
empleados$salario_total <- empleados$salario + empleados$bono
print(empleados)

# Clasificar por nivel de salario
empleados$nivel <- ifelse(empleados$salario < 20000, "Junior", "Senior")
print(empleados)

# Ordenar data frame

# Por salario ascendente
empleados_ordenados <- empleados[order(empleados$salario), ]
print(empleados_ordenados)

# Por salario descendente
empleados_ordenados_desc <- empleados[order(empleados$salario, decreasing = TRUE), ]
print(empleados_ordenados_desc)

# Por departamento y luego por salario
empleados_ordenados_multi <- empleados[order(empleados$departamento, empleados$salario), ]
print(empleados_ordenados_multi)

# Agregar filas
nuevo_empleado <- data.frame(
  nombre = "Laura",
  edad = 27,
  departamento = "Ventas",
  salario = 19000,
  antiguedad = 3,
  bono = 1900,
  salario_total = 20900,
  nivel = "Junior"
)

empleados <- rbind(empleados, nuevo_empleado)
print(empleados)

# Eliminar filas
# Eliminar la fila 3
empleados <- empleados[-3, ]
print(empleados)

# Eliminar columnas
# Eliminar la columna de bono
empleados$bono <- NULL
print(empleados)

# ----------------------------------------------------------------------------
# SECCIÓN 4: EJEMPLO PRÁCTICO COMPLETO - ANÁLISIS DE VENTAS
# ----------------------------------------------------------------------------

cat("\n=== EJEMPLO PRÁCTICO: ANÁLISIS DE VENTAS ===\n\n")

# Crear un dataset de ventas
ventas_df <- data.frame(
  fecha = as.Date(c("2025-01-15", "2025-01-16", "2025-01-17",
                    "2025-01-18", "2025-01-19", "2025-01-20",
                    "2025-01-21", "2025-01-22", "2025-01-23",
                    "2025-01-24")),
  producto = c("Laptop", "Mouse", "Teclado", "Laptop", "Monitor",
               "Mouse", "Teclado", "Laptop", "Monitor", "Mouse"),
  cantidad = c(2, 5, 3, 1, 2, 10, 4, 3, 1, 8),
  precio_unitario = c(15000, 250, 800, 15000, 5000,
                      250, 800, 15000, 5000, 250),
  vendedor = c("Ana", "Luis", "Ana", "Carlos", "Luis",
               "Ana", "Carlos", "Ana", "Luis", "Carlos")
)

print(ventas_df)

# 1. Calcular el total de cada venta
ventas_df$total <- ventas_df$cantidad * ventas_df$precio_unitario
print(ventas_df)

# 2. Resumen estadístico
cat("\n=== RESUMEN DE VENTAS ===\n")
cat("Total vendido:", sum(ventas_df$total), "\n")
cat("Promedio por venta:", mean(ventas_df$total), "\n")
cat("Venta máxima:", max(ventas_df$total), "\n")
cat("Venta mínima:", min(ventas_df$total), "\n")

# 3. Análisis por producto
cat("\n=== VENTAS POR PRODUCTO ===\n")

# Productos únicos
productos_unicos <- unique(ventas_df$producto)
print(productos_unicos)

# Total vendido por producto
for(prod in productos_unicos) {
  total_prod <- sum(ventas_df$total[ventas_df$producto == prod])
  cat(prod, ":", total_prod, "\n")
}

# 4. Análisis por vendedor
cat("\n=== VENTAS POR VENDEDOR ===\n")

vendedores <- unique(ventas_df$vendedor)

for(vend in vendedores) {
  ventas_vend <- ventas_df[ventas_df$vendedor == vend, ]
  total_vend <- sum(ventas_vend$total)
  num_ventas <- nrow(ventas_vend)
  promedio_vend <- mean(ventas_vend$total)

  cat("\n", vend, ":\n", sep = "")
  cat("  Total vendido:", total_vend, "\n")
  cat("  Número de ventas:", num_ventas, "\n")
  cat("  Promedio por venta:", promedio_vend, "\n")
}

# 5. Ventas superiores a $10,000
ventas_altas <- ventas_df[ventas_df$total > 10000, ]
cat("\n=== VENTAS MAYORES A $10,000 ===\n")
print(ventas_altas)

# 6. Producto más vendido (por cantidad)
cat("\n=== PRODUCTO MÁS VENDIDO (CANTIDAD) ===\n")

# Usar aggregate para sumar cantidades por producto
cantidad_por_producto <- aggregate(
  cantidad ~ producto,
  data = ventas_df,
  FUN = sum
)
print(cantidad_por_producto)

producto_top <- cantidad_por_producto[
  which.max(cantidad_por_producto$cantidad),
]
cat("Producto más vendido:", producto_top$producto,
    "con", producto_top$cantidad, "unidades\n")

# 7. Producto que generó más ingresos
cat("\n=== PRODUCTO CON MAYORES INGRESOS ===\n")

ingresos_por_producto <- aggregate(
  total ~ producto,
  data = ventas_df,
  FUN = sum
)
print(ingresos_por_producto)

producto_top_ingresos <- ingresos_por_producto[
  which.max(ingresos_por_producto$total),
]
cat("Producto con mayores ingresos:", producto_top_ingresos$producto,
    "con $", producto_top_ingresos$total, "\n")

# ----------------------------------------------------------------------------
# SECCIÓN 5: FUNCIONES ÚTILES PARA DATA FRAMES
# ----------------------------------------------------------------------------

cat("\n=== FUNCIONES ÚTILES ===\n\n")

# Crear un data frame de ejemplo
estudiantes <- data.frame(
  nombre = c("Ana", "Luis", "María", "Carlos", "Pedro", "Laura"),
  matematicas = c(85, 90, 78, 92, 88, 95),
  fisica = c(80, 85, 75, 88, 90, 92),
  quimica = c(88, 87, 82, 90, 85, 94),
  stringsAsFactors = FALSE  # No convertir strings a factores
)

print(estudiantes)

# subset() - Filtrar de forma más legible
# Estudiantes con matemáticas > 85
buenos_en_mate <- subset(estudiantes, matematicas > 85)
print(buenos_en_mate)

# Estudiantes con matemáticas > 85 Y física > 85
excelentes <- subset(estudiantes, matematicas > 85 & fisica > 85)
print(excelentes)

# Seleccionar columnas con subset
solo_nombre_mate <- subset(estudiantes, select = c(nombre, matematicas))
print(solo_nombre_mate)

# transform() - Agregar o modificar columnas
estudiantes <- transform(estudiantes,
                        promedio = (matematicas + fisica + quimica) / 3)
print(estudiantes)

# within() - Modificar múltiples columnas
estudiantes <- within(estudiantes, {
  promedio_redondeado = round(promedio, 1)
  aprobado = promedio >= 70
  nivel = ifelse(promedio >= 90, "Excelente",
                ifelse(promedio >= 80, "Bueno", "Regular"))
})
print(estudiantes)

# merge() - Combinar data frames (como JOIN en SQL)

# Crear otro data frame con información adicional
info_adicional <- data.frame(
  nombre = c("Ana", "Luis", "María", "Carlos"),
  edad = c(20, 21, 19, 22),
  ciudad = c("CDMX", "Guadalajara", "Monterrey", "CDMX")
)

# Combinar los data frames por la columna "nombre"
estudiantes_completo <- merge(estudiantes, info_adicional, by = "nombre", all.x = TRUE)
print(estudiantes_completo)

# ----------------------------------------------------------------------------
# SECCIÓN 6: FACTORES (VARIABLES CATEGÓRICAS)
# ----------------------------------------------------------------------------

# Los factores se usan para variables categóricas (muy importante para ML)

# Crear un factor
niveles_educacion <- c("Secundaria", "Preparatoria", "Universidad",
                       "Preparatoria", "Secundaria", "Universidad",
                       "Posgrado", "Universidad")

# Convertir a factor
niveles_factor <- factor(niveles_educacion)
print(niveles_factor)

# Ver los niveles únicos
levels(niveles_factor)

# Contar frecuencias
table(niveles_factor)

# Factor ordenado (con orden jerárquico)
niveles_ordenado <- factor(
  niveles_educacion,
  levels = c("Secundaria", "Preparatoria", "Universidad", "Posgrado"),
  ordered = TRUE
)

print(niveles_ordenado)

# Ahora podemos hacer comparaciones
niveles_ordenado[1] < niveles_ordenado[3]  # TRUE (Secundaria < Universidad)

# Ejemplo con data frame
clientes_df <- data.frame(
  nombre = c("Juan", "María", "Pedro", "Ana", "Luis"),
  categoria = factor(c("Gold", "Silver", "Gold", "Platinum", "Silver"),
                    levels = c("Silver", "Gold", "Platinum"),
                    ordered = TRUE),
  gasto_anual = c(50000, 30000, 55000, 80000, 28000)
)

print(clientes_df)

# Filtrar clientes Gold o superior
clientes_premium <- clientes_df[clientes_df$categoria >= "Gold", ]
print(clientes_premium)

# ----------------------------------------------------------------------------
# SECCIÓN 7: EJERCICIOS PRÁCTICOS
# ----------------------------------------------------------------------------

cat("\n=== EJERCICIOS PRÁCTICOS ===\n\n")

# EJERCICIO 1: Crear una matriz de calificaciones
cat("EJERCICIO 1: Matriz de calificaciones\n")

# 5 estudiantes, 4 materias
calificaciones_matriz <- matrix(
  c(85, 90, 78, 92,    # Estudiante 1
    88, 85, 90, 87,    # Estudiante 2
    75, 80, 72, 78,    # Estudiante 3
    92, 95, 88, 94,    # Estudiante 4
    80, 82, 85, 83),   # Estudiante 5
  nrow = 5,
  ncol = 4,
  byrow = TRUE
)

rownames(calificaciones_matriz) <- paste("Estudiante", 1:5)
colnames(calificaciones_matriz) <- c("Mate", "Física", "Química", "Historia")

print(calificaciones_matriz)

# Promedio por estudiante
promedios_est <- rowMeans(calificaciones_matriz)
cat("\nPromedios por estudiante:\n")
print(promedios_est)

# Promedio por materia
promedios_mat <- colMeans(calificaciones_matriz)
cat("\nPromedios por materia:\n")
print(promedios_mat)

# Mejor estudiante
mejor_estudiante <- names(which.max(promedios_est))
cat("\nMejor estudiante:", mejor_estudiante, "\n")

# EJERCICIO 2: Data frame de productos
cat("\n\nEJERCICIO 2: Inventario de productos\n")

inventario <- data.frame(
  codigo = c("P001", "P002", "P003", "P004", "P005"),
  producto = c("Laptop", "Mouse", "Teclado", "Monitor", "Webcam"),
  precio = c(15000, 250, 800, 5000, 1200),
  stock = c(15, 50, 30, 20, 25),
  categoria = c("Computadoras", "Accesorios", "Accesorios",
                "Computadoras", "Accesorios")
)

print(inventario)

# Calcular valor total del inventario
inventario$valor_total <- inventario$precio * inventario$stock
print(inventario)

# Valor total de todo el inventario
valor_inventario <- sum(inventario$valor_total)
cat("\nValor total del inventario: $", valor_inventario, "\n")

# Productos con stock bajo (menos de 25 unidades)
stock_bajo <- inventario[inventario$stock < 25, ]
cat("\nProductos con stock bajo:\n")
print(stock_bajo)

# Producto más valioso en inventario
producto_valioso <- inventario[which.max(inventario$valor_total), ]
cat("\nProducto más valioso:\n")
print(producto_valioso)

# ----------------------------------------------------------------------------
# SECCIÓN 8: DESAFÍOS
# ----------------------------------------------------------------------------

cat("\n=== DESAFÍO FINAL ===\n\n")

# Crear un sistema completo de gestión de ventas

# Data frame de productos
productos_db <- data.frame(
  id_producto = 1:5,
  nombre = c("Laptop", "Mouse", "Teclado", "Monitor", "Webcam"),
  precio = c(15000, 250, 800, 5000, 1200),
  costo = c(10000, 150, 500, 3500, 800)
)

# Data frame de ventas
ventas_db <- data.frame(
  id_venta = 1:10,
  id_producto = c(1, 2, 3, 1, 4, 2, 3, 1, 5, 2),
  cantidad = c(2, 5, 3, 1, 2, 10, 4, 3, 2, 8),
  vendedor = c("Ana", "Luis", "Ana", "Carlos", "Luis",
               "Ana", "Carlos", "Ana", "Luis", "Carlos")
)

# Combinar para obtener información completa
ventas_completas <- merge(ventas_db, productos_db, by = "id_producto")

# Calcular totales
ventas_completas$total_venta <- ventas_completas$cantidad * ventas_completas$precio
ventas_completas$total_costo <- ventas_completas$cantidad * ventas_completas$costo
ventas_completas$ganancia <- ventas_completas$total_venta - ventas_completas$total_costo

cat("=== BASE DE DATOS DE VENTAS COMPLETA ===\n")
print(ventas_completas)

# Análisis de resultados
cat("\n=== ANÁLISIS DE RESULTADOS ===\n")
cat("Total de ventas: $", sum(ventas_completas$total_venta), "\n")
cat("Total de costos: $", sum(ventas_completas$total_costo), "\n")
cat("Ganancia total: $", sum(ventas_completas$ganancia), "\n")
cat("Margen de ganancia: ",
    round(sum(ventas_completas$ganancia) / sum(ventas_completas$total_venta) * 100, 2),
    "%\n")

# Mejor vendedor
ventas_por_vendedor <- aggregate(
  ganancia ~ vendedor,
  data = ventas_completas,
  FUN = sum
)
cat("\n=== GANANCIA POR VENDEDOR ===\n")
print(ventas_por_vendedor)

# Producto más rentable
ganancia_por_producto <- aggregate(
  ganancia ~ nombre,
  data = ventas_completas,
  FUN = sum
)
cat("\n=== GANANCIA POR PRODUCTO ===\n")
print(ganancia_por_producto)

# ----------------------------------------------------------------------------
# RESUMEN
# ----------------------------------------------------------------------------

cat("\n=== RESUMEN DE LA LECCIÓN 2 ===\n")
cat("Aprendiste sobre:\n")
cat("1. Matrices: crear, acceder, operaciones\n")
cat("2. Listas: estructuras flexibles\n")
cat("3. Data Frames: la estructura más importante para ML\n")
cat("4. Filtrado y selección de datos\n")
cat("5. Agregar y modificar datos\n")
cat("6. Funciones aggregate, merge, subset\n")
cat("7. Factores para variables categóricas\n")
cat("\n¡Excelente! Ahora estás listo para la Lección 3: Control de flujo\n")

# ============================================================================
# FIN DE LA LECCIÓN 2
# ============================================================================
