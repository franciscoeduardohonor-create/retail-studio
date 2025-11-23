# ============================================================================
# MÓDULO 2 - LECCIÓN 1: INTRODUCCIÓN A DPLYR
# ============================================================================
# Objetivo: Conocer dplyr, la herramienta más importante para manipular datos
# ============================================================================

# dplyr es parte de tidyverse, una colección de paquetes para ciencia de datos
# Es como tener SQL dentro de R, pero más poderoso y flexible

# ============================================================================
# 1. INSTALACIÓN Y CARGA
# ============================================================================

# Instalar tidyverse (incluye dplyr, ggplot2, tidyr, readr, y más)
# install.packages("tidyverse")

# Cargar la librería
library(dplyr)

# O cargar todo tidyverse
library(tidyverse)

# ============================================================================
# 2. LOS 6 VERBOS FUNDAMENTALES DE DPLYR
# ============================================================================

# dplyr se basa en 6 funciones principales (verbos):
#
# 1. filter()    - Filtrar FILAS basado en condiciones
# 2. select()    - Seleccionar COLUMNAS
# 3. mutate()    - Crear o modificar COLUMNAS
# 4. arrange()   - Ordenar filas
# 5. summarise() - Resumir datos (crear agregados)
# 6. group_by()  - Agrupar datos para operaciones

# ============================================================================
# 3. DATOS DE EJEMPLO
# ============================================================================

# Crear un dataset de ventas
ventas <- data.frame(
  fecha = as.Date(c("2024-01-15", "2024-01-16", "2024-01-17", "2024-01-18",
                   "2024-01-19", "2024-01-20", "2024-01-21", "2024-01-22")),
  producto = c("Laptop", "Mouse", "Teclado", "Monitor", "Laptop",
              "Mouse", "Webcam", "Teclado"),
  categoria = c("Computadoras", "Accesorios", "Accesorios", "Computadoras",
               "Computadoras", "Accesorios", "Accesorios", "Accesorios"),
  cantidad = c(2, 10, 5, 3, 1, 15, 4, 8),
  precio_unitario = c(899.99, 25.50, 45.99, 199.99, 899.99, 25.50, 89.99, 45.99),
  vendedor = c("Ana", "Carlos", "Ana", "Carlos", "Diana", "Ana", "Carlos", "Diana"),
  region = c("Norte", "Sur", "Norte", "Sur", "Centro", "Norte", "Sur", "Centro")
)

# Ver datos
print(ventas)

# Dimensiones
dim(ventas)
glimpse(ventas)  # Función de dplyr, mejor que str()

# ============================================================================
# 4. FILTER() - FILTRAR FILAS
# ============================================================================

# Sintaxis básica:
# filter(data, condicion)

# Ventas de computadoras solamente
filter(ventas, categoria == "Computadoras")

# Ventas con cantidad mayor a 5
filter(ventas, cantidad > 5)

# Ventas del vendedor Ana
filter(ventas, vendedor == "Ana")

# Múltiples condiciones con AND (&)
filter(ventas, categoria == "Accesorios" & cantidad > 5)

# Múltiples condiciones con OR (|)
filter(ventas, vendedor == "Ana" | vendedor == "Diana")

# Usando %in% para múltiples valores
filter(ventas, vendedor %in% c("Ana", "Diana"))

# Fechas posteriores a una específica
filter(ventas, fecha > as.Date("2024-01-18"))

# Productos específicos
filter(ventas, producto %in% c("Laptop", "Monitor"))

# ============================================================================
# 5. SELECT() - SELECCIONAR COLUMNAS
# ============================================================================

# Sintaxis básica:
# select(data, columnas)

# Seleccionar columnas específicas
select(ventas, producto, cantidad, precio_unitario)

# Seleccionar rango de columnas
select(ventas, fecha:cantidad)

# Seleccionar todas EXCEPTO algunas
select(ventas, -vendedor, -region)

# Reordenar columnas
select(ventas, vendedor, producto, cantidad, everything())
# everything() incluye todas las demás columnas

# Seleccionar columnas que empiezan con...
select(ventas, starts_with("p"))

# Seleccionar columnas que terminan con...
select(ventas, ends_with("io"))

# Seleccionar columnas que contienen...
select(ventas, contains("cat"))

# Renombrar al seleccionar
select(ventas, fecha, producto, qty = cantidad)

# ============================================================================
# 6. MUTATE() - CREAR/MODIFICAR COLUMNAS
# ============================================================================

# Sintaxis básica:
# mutate(data, nueva_columna = expresión)

# Calcular total de venta
mutate(ventas, total = cantidad * precio_unitario)

# Múltiples columnas nuevas
mutate(ventas,
       total = cantidad * precio_unitario,
       descuento = total * 0.10,
       total_final = total - descuento)

# Usar columnas recién creadas en la misma mutate
mutate(ventas,
       total = cantidad * precio_unitario,
       iva = total * 0.16,
       total_con_iva = total + iva)

# Modificar columna existente
mutate(ventas, precio_unitario = round(precio_unitario, 0))

# Crear columna condicional
mutate(ventas,
       venta_grande = ifelse(cantidad > 5, "Sí", "No"))

# Categorizar
mutate(ventas,
       nivel_venta = case_when(
         cantidad < 3 ~ "Baja",
         cantidad < 8 ~ "Media",
         TRUE ~ "Alta"  # else/default
       ))

# ============================================================================
# 7. ARRANGE() - ORDENAR FILAS
# ============================================================================

# Sintaxis básica:
# arrange(data, columna)

# Ordenar por cantidad (ascendente)
arrange(ventas, cantidad)

# Ordenar descendente
arrange(ventas, desc(cantidad))

# Ordenar por múltiples columnas
arrange(ventas, vendedor, desc(cantidad))

# Ordenar por fecha
arrange(ventas, fecha)

# ============================================================================
# 8. SUMMARISE() - RESUMIR DATOS
# ============================================================================

# Sintaxis básica:
# summarise(data, nombre = función)

# Total de ventas (suma de cantidad)
summarise(ventas, total_unidades = sum(cantidad))

# Múltiples resúmenes
summarise(ventas,
         total_unidades = sum(cantidad),
         promedio_precio = mean(precio_unitario),
         max_precio = max(precio_unitario),
         n_transacciones = n())  # n() cuenta filas

# Resumen con cálculos complejos
summarise(ventas,
         ingresos_totales = sum(cantidad * precio_unitario),
         ticket_promedio = mean(cantidad * precio_unitario),
         productos_diferentes = n_distinct(producto))

# ============================================================================
# 9. GROUP_BY() - AGRUPAR DATOS
# ============================================================================

# group_by() se usa ANTES de summarise() para hacer resúmenes por grupos

# Ventas por vendedor
ventas_por_vendedor <- group_by(ventas, vendedor)
summarise(ventas_por_vendedor,
         total_unidades = sum(cantidad),
         n_ventas = n())

# Ventas por categoría
ventas_por_categoria <- group_by(ventas, categoria)
summarise(ventas_por_categoria,
         ingresos = sum(cantidad * precio_unitario),
         unidades = sum(cantidad))

# Agrupar por múltiples variables
ventas_por_vendedor_categoria <- group_by(ventas, vendedor, categoria)
summarise(ventas_por_vendedor_categoria,
         total = sum(cantidad * precio_unitario))

# ============================================================================
# 10. EL OPERADOR PIPE %>% (TUBERÍA)
# ============================================================================

# El pipe %>% permite encadenar operaciones
# Se lee como "luego" o "entonces"
# Atajo de teclado: Ctrl+Shift+M (Windows) o Cmd+Shift+M (Mac)

# SIN PIPE (difícil de leer):
resultado <- summarise(
  group_by(
    filter(ventas, categoria == "Accesorios"),
    vendedor
  ),
  total = sum(cantidad * precio_unitario)
)

# CON PIPE (más claro y legible):
resultado <- ventas %>%
  filter(categoria == "Accesorios") %>%
  group_by(vendedor) %>%
  summarise(total = sum(cantidad * precio_unitario))

print(resultado)

# ============================================================================
# 11. EJEMPLO COMPLETO: ANÁLISIS DE VENTAS
# ============================================================================

# Pregunta: ¿Cuál vendedor vendió más en computadoras?

analisis <- ventas %>%
  # 1. Filtrar solo computadoras
  filter(categoria == "Computadoras") %>%
  # 2. Crear columna de ingresos
  mutate(ingresos = cantidad * precio_unitario) %>%
  # 3. Agrupar por vendedor
  group_by(vendedor) %>%
  # 4. Resumir
  summarise(
    total_ingresos = sum(ingresos),
    unidades_vendidas = sum(cantidad),
    n_transacciones = n()
  ) %>%
  # 5. Ordenar de mayor a menor
  arrange(desc(total_ingresos))

print(analisis)

# ============================================================================
# 12. COUNT() - CONTAR OCURRENCIAS
# ============================================================================

# count() es un atajo para group_by() + summarise(n = n())

# Contar ventas por producto
ventas %>%
  count(producto)

# Contar y ordenar
ventas %>%
  count(producto, sort = TRUE)

# Contar por múltiples variables
ventas %>%
  count(vendedor, categoria)

# Equivalente con group_by:
ventas %>%
  group_by(producto) %>%
  summarise(n = n())

# ============================================================================
# 13. OTRAS FUNCIONES ÚTILES
# ============================================================================

# distinct() - valores únicos
ventas %>%
  distinct(producto)

# Unique rows completas
ventas %>%
  distinct(vendedor, region)

# slice() - seleccionar filas por posición
ventas %>%
  slice(1:3)  # Primeras 3 filas

# slice_max/slice_min - top/bottom N
ventas %>%
  slice_max(cantidad, n = 3)  # Top 3 ventas

# sample_n() - muestra aleatoria
ventas %>%
  sample_n(3)  # 3 filas aleatorias

# ============================================================================
# EJERCICIO PRÁCTICO 1: ANÁLISIS DE VENDEDORES
# ============================================================================

# Usando el dataset ventas, responde:

# 1. ¿Cuántos productos diferentes vendió cada vendedor?
ventas %>%
  group_by(vendedor) %>%
  summarise(productos_unicos = n_distinct(producto))

# 2. ¿Cuál es el ingreso promedio por transacción de cada vendedor?
ventas %>%
  mutate(ingreso = cantidad * precio_unitario) %>%
  group_by(vendedor) %>%
  summarise(ingreso_promedio = mean(ingreso))

# 3. ¿Qué vendedor vendió más unidades en total?
ventas %>%
  group_by(vendedor) %>%
  summarise(total_unidades = sum(cantidad)) %>%
  arrange(desc(total_unidades)) %>%
  slice(1)

# ============================================================================
# EJERCICIO PRÁCTICO 2: ANÁLISIS DE PRODUCTOS
# ============================================================================

# 1. ¿Cuáles son los 3 productos más vendidos (por cantidad)?
ventas %>%
  group_by(producto) %>%
  summarise(total_vendido = sum(cantidad)) %>%
  arrange(desc(total_vendido)) %>%
  slice(1:3)

# 2. ¿Cuál es el ingreso total por categoría?
ventas %>%
  mutate(ingreso = cantidad * precio_unitario) %>%
  group_by(categoria) %>%
  summarise(ingreso_total = sum(ingreso)) %>%
  arrange(desc(ingreso_total))

# ============================================================================
# EJERCICIOS PARA PRACTICAR TÚ
# ============================================================================

# Usa el dataset ventas para resolver:

# 1. Filtra las ventas de la región "Norte"
# TU CÓDIGO AQUÍ:




# 2. Calcula el ingreso total (cantidad * precio) para cada transacción
#    y muestra solo: producto, cantidad, precio_unitario, ingreso
# TU CÓDIGO AQUÍ:




# 3. ¿Cuál región generó más ingresos?
# TU CÓDIGO AQUÍ:




# 4. Crea un resumen por categoría mostrando:
#    - Número de transacciones
#    - Total de unidades vendidas
#    - Ingreso promedio por transacción
# TU CÓDIGO AQUÍ:




# ============================================================================
# ¡EXCELENTE TRABAJO!
# ============================================================================
# Ahora dominas:
# ✓ Los 6 verbos fundamentales de dplyr
# ✓ Filtrar y seleccionar datos
# ✓ Crear nuevas columnas
# ✓ Ordenar resultados
# ✓ Resumir y agrupar datos
# ✓ Usar el operador pipe %>%
#
# Continúa con: 02_filtrar_seleccionar.R
# ============================================================================
