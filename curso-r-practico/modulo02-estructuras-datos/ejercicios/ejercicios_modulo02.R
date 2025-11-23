# ============================================================================
# EJERCICIOS - MÓDULO 2: ESTRUCTURAS DE DATOS
# ============================================================================

# ============================================================================
# EJERCICIO 1: MATRICES
# ============================================================================
# Crea una matriz de ventas de 4 productos en 3 meses:
# Producto 1: Enero=1000, Febrero=1200, Marzo=1100
# Producto 2: Enero=1500, Febrero=1600, Marzo=1700
# Producto 3: Enero=800, Febrero=900, Marzo=950
# Producto 4: Enero=1300, Febrero=1350, Marzo=1400
#
# a) Crea la matriz
# b) Nombra las filas como "Prod1", "Prod2", etc.
# c) Nombra las columnas como "Enero", "Febrero", "Marzo"
# d) Calcula las ventas totales por producto
# e) Calcula las ventas totales por mes
# f) ¿Qué producto vendió más en total?

# TU CÓDIGO AQUÍ:




# ============================================================================
# EJERCICIO 2: LISTAS
# ============================================================================
# Crea una lista que represente un estudiante con:
# - nombre: tu nombre
# - edad: tu edad
# - materias: vector con 3 materias
# - calificaciones: vector con 3 calificaciones (una por materia)
# - becado: TRUE o FALSE
#
# a) Crea la lista
# b) Calcula el promedio de calificaciones
# c) Agrega un nuevo campo "universidad"
# d) Accede a la segunda materia usando diferentes métodos

# TU CÓDIGO AQUÍ:




# ============================================================================
# EJERCICIO 3: DATA FRAMES BÁSICOS
# ============================================================================
# Crea un data frame de 5 libros con:
# - titulo
# - autor
# - año de publicación
# - precio
# - paginas
#
# a) Crea el data frame
# b) Muestra los primeros 3 libros
# c) ¿Cuál es el libro más caro?
# d) ¿Cuál es el promedio de páginas?
# e) Filtra los libros publicados después del 2000

# TU CÓDIGO AQUÍ:




# ============================================================================
# EJERCICIO 4: FILTRADO DE DATA FRAMES
# ============================================================================
# Usa este data frame de empleados:
empleados <- data.frame(
  nombre = c("Ana", "Juan", "María", "Pedro", "Lucía", "Carlos"),
  edad = c(25, 35, 28, 42, 30, 38),
  salario = c(35000, 45000, 38000, 55000, 42000, 48000),
  departamento = c("Ventas", "IT", "Ventas", "IT", "RRHH", "IT")
)

# a) Filtra empleados mayores de 30 años
# b) Filtra empleados del departamento IT
# c) Filtra empleados con salario > 40000 y edad < 40
# d) Ordena por salario de mayor a menor
# e) ¿Cuál es el salario promedio por departamento?

# TU CÓDIGO AQUÍ:




# ============================================================================
# EJERCICIO 5: AGREGANDO COLUMNAS
# ============================================================================
# Usando el data frame de empleados del ejercicio 4:
# a) Agrega una columna "salario_anual" con el salario * 12
# b) Agrega una columna "categoria_edad": "Joven" (<30), "Adulto" (30-40), "Senior" (>40)
# c) Agrega una columna "salario_alto" (TRUE si salario > 40000)
# d) Calcula cuántos empleados son "Joven" con salario_alto

# TU CÓDIGO AQUÍ:




# ============================================================================
# EJERCICIO 6: FACTORES
# ============================================================================
# a) Crea un factor con niveles de satisfacción: "Bajo", "Medio", "Alto"
#    con los siguientes datos: Alto, Medio, Alto, Bajo, Medio, Alto
# b) Cuenta cuántos hay de cada nivel
# c) Crea un factor ordenado con los niveles en orden: Bajo < Medio < Alto
# d) ¿Cuál es el nivel más frecuente?

# TU CÓDIGO AQUÍ:




# ============================================================================
# EJERCICIO 7: OPERACIONES CON MATRICES
# ============================================================================
# Crea dos matrices 3x3:
# matriz_a con números del 1 al 9
# matriz_b con números del 10 al 18
#
# a) Suma las dos matrices
# b) Multiplica elemento por elemento
# c) Calcula la transpuesta de matriz_a
# d) Calcula la suma de cada fila en ambas matrices

# TU CÓDIGO AQUÍ:




# ============================================================================
# EJERCICIO 8: PROYECTO - REGISTRO DE VENTAS
# ============================================================================
# Crea un data frame de ventas con:
# - fecha (7 días): "2024-01-01" a "2024-01-07"
# - producto: "A", "B", "A", "C", "B", "A", "C"
# - cantidad: 10, 15, 12, 8, 20, 14, 11
# - precio_unitario: 50, 75, 50, 100, 75, 50, 100
#
# a) Crea el data frame
# b) Calcula el total de ventas por transacción (cantidad * precio_unitario)
# c) ¿Cuál fue el total de ventas en la semana?
# d) ¿Qué producto generó más ingresos?
# e) ¿Cuál fue el promedio de venta por día?
# f) Filtra las ventas del producto "A"

# TU CÓDIGO AQUÍ:




# ============================================================================
# EJERCICIO 9: LISTAS ANIDADAS
# ============================================================================
# Crea una lista de 3 productos, donde cada producto es una lista con:
# - nombre
# - precio
# - stock
# - categoría
#
# a) Crea la estructura
# b) Accede al precio del segundo producto
# c) Calcula el valor total del inventario (precio * stock de todos)

# TU CÓDIGO AQUÍ:




# ============================================================================
# EJERCICIO 10: ANÁLISIS COMPLETO
# ============================================================================
# Crea un data frame de estudiantes con:
# - 10 estudiantes con nombres
# - Calificaciones en 3 materias (Matemáticas, Física, Programación)
# - Edad de cada estudiante
# - Ciudad de origen
#
# a) Crea el data frame
# b) Calcula el promedio general de cada estudiante
# c) Identifica al mejor estudiante
# d) Calcula el promedio por materia
# e) ¿Cuántos estudiantes tienen promedio >= 80?
# f) Agrupa los estudiantes por ciudad y calcula el promedio por ciudad

# TU CÓDIGO AQUÍ:




print("¡Excelente trabajo! Al completar estos ejercicios dominarás las estructuras de datos en R")
