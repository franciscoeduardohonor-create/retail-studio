# ============================================================================
# MÓDULO 1 - LECCIÓN 2: TIPOS DE DATOS Y ESTRUCTURAS
# ============================================================================
# Objetivo: Dominar los diferentes tipos de datos en R
# ============================================================================

# ============================================================================
# 1. VECTORES: LA ESTRUCTURA MÁS FUNDAMENTAL
# ============================================================================

# Un vector es una colección de elementos del MISMO tipo
# Se crea con la función c() (combine/concatenar)

# Vector numérico
ventas_semana <- c(1200, 1450, 980, 1670, 2100, 1800, 1350)
ventas_semana

# Vector de caracteres
dias_semana <- c("Lunes", "Martes", "Miércoles", "Jueves",
                 "Viernes", "Sábado", "Domingo")
dias_semana

# Vector lógico
dias_laborables <- c(TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, FALSE)
dias_laborables

# ============================================================================
# 2. OPERACIONES CON VECTORES
# ============================================================================

# Longitud del vector
length(ventas_semana)

# Sumar todos los elementos
sum(ventas_semana)
total_semanal <- sum(ventas_semana)
total_semanal

# Promedio
mean(ventas_semana)
promedio_diario <- mean(ventas_semana)
promedio_diario

# Valor máximo y mínimo
max(ventas_semana)  # Día con más ventas
min(ventas_semana)  # Día con menos ventas

# Mediana
median(ventas_semana)

# Desviación estándar
sd(ventas_semana)

# Resumen estadístico completo
summary(ventas_semana)

# ============================================================================
# 3. INDEXACIÓN: ACCEDER A ELEMENTOS ESPECÍFICOS
# ============================================================================

# En R, los índices empiezan en 1 (no en 0 como Python)

# Primer elemento
ventas_semana[1]  # Ventas del lunes

# Último elemento
ventas_semana[7]  # Ventas del domingo

# Múltiples elementos
ventas_semana[c(1, 3, 5)]  # Lunes, Miércoles, Viernes

# Rango de elementos
ventas_semana[1:5]  # Días laborables (lunes a viernes)

# Excluir elementos (con el signo -)
ventas_semana[-7]  # Todos excepto el domingo

# Acceso por condición lógica
ventas_semana[ventas_semana > 1500]  # Días con ventas mayores a 1500

# Días con ventas menores al promedio
ventas_semana[ventas_semana < mean(ventas_semana)]

# ============================================================================
# 4. MODIFICAR VECTORES
# ============================================================================

# Crear una copia para no alterar el original
ventas_ajustadas <- ventas_semana

# Cambiar un elemento específico
ventas_ajustadas[3] <- 1050  # Actualizar ventas del miércoles
ventas_ajustadas

# Aplicar descuento del 10% a todos los elementos
ventas_con_descuento <- ventas_semana * 0.90
ventas_con_descuento

# Agregar un nuevo elemento al final
ventas_extendidas <- c(ventas_semana, 1400)  # Agregar lunes siguiente
ventas_extendidas

# Operaciones elemento por elemento
ventas_semana_1 <- c(1200, 1450, 980, 1670, 2100)
ventas_semana_2 <- c(1350, 1520, 1100, 1580, 2250)

# Comparar ambas semanas
diferencia <- ventas_semana_2 - ventas_semana_1
diferencia

# Crecimiento porcentual
crecimiento <- ((ventas_semana_2 - ventas_semana_1) / ventas_semana_1) * 100
crecimiento

# ============================================================================
# 5. VECTORES CON NOMBRES (NAMED VECTORS)
# ============================================================================

# Asignar nombres a los elementos del vector
names(ventas_semana) <- dias_semana
ventas_semana

# Ahora podemos acceder por nombre
ventas_semana["Viernes"]
ventas_semana["Sábado"]

# O crear el vector ya con nombres
ventas_mes <- c(
  "Semana_1" = 8500,
  "Semana_2" = 9200,
  "Semana_3" = 7800,
  "Semana_4" = 10100
)
ventas_mes

# ============================================================================
# 6. FACTORES: VARIABLES CATEGÓRICAS
# ============================================================================

# Los factores se usan para representar datos categóricos
# Son fundamentales en análisis estadístico y BI

# Crear un vector de categorías
categorias <- c("Electrónica", "Ropa", "Alimentos", "Electrónica",
                "Ropa", "Alimentos", "Electrónica", "Hogar")

# Convertir a factor
categorias_factor <- factor(categorias)
categorias_factor

# Ver los niveles (categorías únicas)
levels(categorias_factor)

# Contar elementos por categoría
table(categorias_factor)

# Ejemplo con niveles ordenados
satisfaccion <- c("Medio", "Alto", "Bajo", "Alto", "Medio", "Bajo", "Alto")

# Factor ordenado
satisfaccion_factor <- factor(
  satisfaccion,
  levels = c("Bajo", "Medio", "Alto"),
  ordered = TRUE
)
satisfaccion_factor

# Ahora podemos hacer comparaciones ordinales
satisfaccion_factor[1] < satisfaccion_factor[2]

# ============================================================================
# 7. MATRICES: DATOS EN 2 DIMENSIONES
# ============================================================================

# Una matriz es una tabla rectangular de datos del mismo tipo

# Crear una matriz de ventas por producto y mes
ventas_matriz <- matrix(
  c(150, 200, 180, 220,    # Producto 1
    130, 170, 160, 190,    # Producto 2
    200, 230, 210, 250),   # Producto 3
  nrow = 3,
  byrow = TRUE
)
ventas_matriz

# Asignar nombres a filas y columnas
rownames(ventas_matriz) <- c("Laptop", "Mouse", "Teclado")
colnames(ventas_matriz) <- c("Enero", "Febrero", "Marzo", "Abril")
ventas_matriz

# Acceder a elementos
ventas_matriz[1, 2]  # Laptop en Febrero (fila 1, columna 2)
ventas_matriz["Mouse", "Marzo"]  # Por nombres

# Acceder a filas completas
ventas_matriz[1, ]  # Todas las ventas de Laptop

# Acceder a columnas completas
ventas_matriz[, "Enero"]  # Ventas de todos los productos en Enero

# Operaciones con matrices
rowSums(ventas_matriz)  # Total por producto
colSums(ventas_matriz)  # Total por mes

# Promedio por producto
rowMeans(ventas_matriz)

# Promedio por mes
colMeans(ventas_matriz)

# Transponer (intercambiar filas por columnas)
t(ventas_matriz)

# ============================================================================
# 8. LISTAS: ESTRUCTURAS HETEROGÉNEAS
# ============================================================================

# Las listas pueden contener elementos de diferentes tipos
# Son muy flexibles y potentes

# Crear una lista con información de un cliente
cliente <- list(
  id = 1001,
  nombre = "María González",
  edad = 34,
  ciudad = "Ciudad de México",
  compras = c(450, 230, 890, 120),
  cliente_premium = TRUE
)

cliente

# Acceder a elementos de la lista

# Por índice con [[]]
cliente[[1]]

# Por nombre con $
cliente$nombre
cliente$compras

# Información más compleja
str(cliente)  # Estructura de la lista

# Agregar un nuevo elemento a la lista
cliente$email <- "maria.gonzalez@email.com"
cliente

# Lista anidada (lista dentro de lista)
empresa <- list(
  nombre = "TechCorp",
  empleados = 150,
  departamentos = list(
    ventas = 45,
    marketing = 30,
    IT = 25,
    RRHH = 15,
    operaciones = 35
  ),
  ingresos_trimestrales = c(250000, 280000, 310000, 295000)
)

# Acceder a datos anidados
empresa$departamentos$ventas
empresa$departamentos$IT

# ============================================================================
# 9. DATA FRAMES: LA ESTRUCTURA MÁS IMPORTANTE PARA BI
# ============================================================================

# Un data frame es como una hoja de Excel: filas y columnas
# Es la estructura que más usarás en Business Intelligence

# Crear un data frame de ventas
df_ventas <- data.frame(
  producto = c("Laptop", "Mouse", "Teclado", "Monitor", "Webcam"),
  precio = c(899.99, 25.50, 45.99, 199.99, 89.99),
  unidades_vendidas = c(45, 320, 180, 78, 95),
  categoria = c("Computadoras", "Accesorios", "Accesorios",
                "Computadoras", "Accesorios"),
  en_oferta = c(TRUE, FALSE, FALSE, TRUE, FALSE)
)

# Ver el data frame
df_ventas

# Ver las primeras filas
head(df_ventas)

# Ver estructura
str(df_ventas)

# Resumen estadístico
summary(df_ventas)

# Dimensiones (filas, columnas)
dim(df_ventas)
nrow(df_ventas)
ncol(df_ventas)

# Nombres de columnas
names(df_ventas)
colnames(df_ventas)

# ============================================================================
# 10. ACCEDER A DATOS EN DATA FRAMES
# ============================================================================

# Acceder a una columna completa
df_ventas$precio
df_ventas$producto

# También con corchetes
df_ventas[, "precio"]
df_ventas[, 2]  # Segunda columna

# Acceder a una fila
df_ventas[1, ]  # Primera fila

# Acceder a un elemento específico
df_ventas[2, 3]  # Fila 2, columna 3
df_ventas[2, "unidades_vendidas"]  # Más claro

# Múltiples columnas
df_ventas[, c("producto", "precio")]

# ============================================================================
# 11. OPERACIONES CON DATA FRAMES
# ============================================================================

# Crear nueva columna calculada
df_ventas$ingresos_totales <- df_ventas$precio * df_ventas$unidades_vendidas
df_ventas

# Filtrar filas
df_ventas[df_ventas$precio > 50, ]  # Productos con precio mayor a 50

# Productos en oferta
df_ventas[df_ventas$en_oferta == TRUE, ]

# Ordenar por precio
df_ventas[order(df_ventas$precio), ]  # Ascendente
df_ventas[order(-df_ventas$precio), ]  # Descendente

# Agregar una nueva fila
nuevo_producto <- data.frame(
  producto = "Impresora",
  precio = 159.99,
  unidades_vendidas = 62,
  categoria = "Computadoras",
  en_oferta = FALSE,
  ingresos_totales = 159.99 * 62
)

df_ventas_actualizado <- rbind(df_ventas, nuevo_producto)
df_ventas_actualizado

# ============================================================================
# EJERCICIO PRÁCTICO 1: ANÁLISIS DE EMPLEADOS
# ============================================================================

# Crea un data frame con información de empleados

empleados <- data.frame(
  id = 1:6,
  nombre = c("Ana", "Carlos", "Diana", "Eduardo", "Fernanda", "Gabriel"),
  departamento = c("Ventas", "IT", "Ventas", "RRHH", "IT", "Ventas"),
  salario = c(3500, 4200, 3800, 3600, 4500, 3300),
  años_experiencia = c(3, 5, 4, 6, 7, 2),
  bonificacion_anual = c(5000, 7000, 6000, 5500, 8000, 4500)
)

empleados

# TAREAS:

# 1. Calcular el salario anual total (salario * 12 + bonificación)
empleados$salario_anual_total <- (empleados$salario * 12) + empleados$bonificacion_anual
empleados

# 2. Encontrar el empleado con mayor salario anual
empleados[which.max(empleados$salario_anual_total), ]

# 3. Calcular el promedio salarial por departamento
aggregate(salario ~ departamento, data = empleados, FUN = mean)

# 4. ¿Cuántos empleados hay por departamento?
table(empleados$departamento)

# 5. Filtrar empleados con más de 4 años de experiencia
empleados[empleados$años_experiencia > 4, ]

# ============================================================================
# EJERCICIO PRÁCTICO 2: ANÁLISIS DE PRODUCTOS
# ============================================================================

# Tienes datos de productos en diferentes tiendas

productos_tiendas <- data.frame(
  tienda = rep(c("Norte", "Sur", "Este"), each = 3),
  producto = rep(c("A", "B", "C"), times = 3),
  ventas = c(120, 95, 150,    # Tienda Norte
             135, 110, 140,    # Tienda Sur
             145, 105, 160),   # Tienda Este
  inventario = c(50, 30, 70, 60, 25, 65, 55, 35, 80),
  precio_unitario = rep(c(25, 18, 30), times = 3)
)

productos_tiendas

# TAREAS:

# 1. Calcular ingresos por producto y tienda
productos_tiendas$ingresos <- productos_tiendas$ventas * productos_tiendas$precio_unitario
productos_tiendas

# 2. ¿Qué tienda generó más ingresos?
aggregate(ingresos ~ tienda, data = productos_tiendas, FUN = sum)

# 3. ¿Qué producto se vendió más en total?
aggregate(ventas ~ producto, data = productos_tiendas, FUN = sum)

# 4. Calcular la rotación de inventario (ventas / inventario)
productos_tiendas$rotacion <- productos_tiendas$ventas / productos_tiendas$inventario
productos_tiendas

# ============================================================================
# EJERCICIOS PARA PRACTICAR TÚ
# ============================================================================

# 1. Crea un vector con las temperaturas de una semana
#    Calcula: promedio, máxima, mínima
#    Encuentra cuántos días tuvieron temperatura > 20°C

# TU CÓDIGO AQUÍ:




# 2. Crea un data frame con 5 clientes
#    Columnas: nombre, edad, ciudad, compra_total, es_premium
#    Calcula: promedio de edad, total de compras, clientes premium

# TU CÓDIGO AQUÍ:




# 3. Crea una matriz 4x4 con ventas trimestrales de 4 productos
#    Calcula totales por producto y por trimestre

# TU CÓDIGO AQUÍ:




# ============================================================================
# ¡EXCELENTE TRABAJO!
# ============================================================================
# Ahora dominas:
# ✓ Vectores y operaciones
# ✓ Factores para variables categóricas
# ✓ Matrices para datos rectangulares
# ✓ Listas para estructuras complejas
# ✓ Data frames para análisis de negocio
# ✓ Indexación y filtrado de datos
#
# Continúa con: 03_vectores_listas.R
# ============================================================================
