# ============================================================================
# MÓDULO 2 - LECCIÓN 1: MANIPULACIÓN DE DATOS CON DPLYR
# ============================================================================
# Descripción: Aprenderás a manipular datos eficientemente con dplyr,
#              una herramienta esencial para preparar datos para ML
# Nivel: Intermedio
# Duración estimada: 4-5 horas
# Prerequisito: Módulo 1 completo
# ============================================================================

# Instalar y cargar paquetes necesarios
# Descomenta la siguiente línea si no tienes instalado tidyverse
# install.packages("tidyverse")

library(dplyr)
library(tidyr)

cat("=== BIENVENIDO AL MÓDULO 2 ===\n")
cat("Manipulación de datos con dplyr\n\n")

# ----------------------------------------------------------------------------
# SECCIÓN 1: INTRODUCCIÓN A DPLYR
# ----------------------------------------------------------------------------

# dplyr es parte del tidyverse y proporciona funciones intuitivas para:
# - Filtrar filas
# - Seleccionar columnas
# - Ordenar datos
# - Crear nuevas variables
# - Resumir datos
# - Agrupar y agregar

# Los verbos principales de dplyr:
# - filter()    : Filtrar filas
# - select()    : Seleccionar columnas
# - arrange()   : Ordenar filas
# - mutate()    : Crear/modificar columnas
# - summarize() : Resumir datos
# - group_by()  : Agrupar datos

# Operador pipe: %>%
# Permite encadenar operaciones de forma legible
# x %>% f(y) es equivalente a f(x, y)

# ----------------------------------------------------------------------------
# SECCIÓN 2: DATASET DE EJEMPLO
# ----------------------------------------------------------------------------

# Crear un dataset de ventas para practicar
ventas <- data.frame(
  id_venta = 1:20,
  fecha = as.Date(c(
    "2025-01-01", "2025-01-02", "2025-01-03", "2025-01-04", "2025-01-05",
    "2025-01-06", "2025-01-07", "2025-01-08", "2025-01-09", "2025-01-10",
    "2025-01-11", "2025-01-12", "2025-01-13", "2025-01-14", "2025-01-15",
    "2025-01-16", "2025-01-17", "2025-01-18", "2025-01-19", "2025-01-20"
  )),
  producto = c(
    "Laptop", "Mouse", "Teclado", "Monitor", "Laptop",
    "Mouse", "Webcam", "Laptop", "Monitor", "Teclado",
    "Mouse", "Laptop", "Monitor", "Teclado", "Webcam",
    "Mouse", "Laptop", "Teclado", "Monitor", "Webcam"
  ),
  cantidad = c(2, 5, 3, 1, 1, 10, 2, 3, 2, 4, 8, 1, 1, 5, 3, 12, 2, 6, 1, 4),
  precio_unitario = c(
    15000, 250, 800, 5000, 15000,
    250, 1200, 15000, 5000, 800,
    250, 15000, 5000, 800, 1200,
    250, 15000, 800, 5000, 1200
  ),
  vendedor = c(
    "Ana", "Luis", "Ana", "Carlos", "Luis",
    "Ana", "Carlos", "Ana", "Luis", "Carlos",
    "Ana", "Luis", "Carlos", "Ana", "Luis",
    "Carlos", "Ana", "Luis", "Carlos", "Ana"
  ),
  region = c(
    "Norte", "Sur", "Norte", "Centro", "Sur",
    "Norte", "Centro", "Norte", "Sur", "Centro",
    "Norte", "Sur", "Centro", "Norte", "Sur",
    "Centro", "Norte", "Sur", "Centro", "Norte"
  ),
  stringsAsFactors = FALSE
)

# Calcular total
ventas$total <- ventas$cantidad * ventas$precio_unitario

print(ventas)

# ----------------------------------------------------------------------------
# SECCIÓN 3: FILTER() - FILTRAR FILAS
# ----------------------------------------------------------------------------

cat("\n=== FILTER: FILTRAR FILAS ===\n\n")

# Sintaxis tradicional de R
ventas_altas_tradicional <- ventas[ventas$total > 10000, ]

# Con dplyr - más legible
ventas_altas <- filter(ventas, total > 10000)
print(ventas_altas)

# Múltiples condiciones con AND
ventas_ana_altas <- filter(ventas, vendedor == "Ana", total > 5000)
print(ventas_ana_altas)

# Condiciones con OR
ventas_ana_luis <- filter(ventas, vendedor == "Ana" | vendedor == "Luis")
print(ventas_ana_luis)

# Usar %in% para múltiples valores
productos_filtrados <- filter(ventas, producto %in% c("Laptop", "Monitor"))
print(productos_filtrados)

# Filtrar por rango de fechas
ventas_primera_semana <- filter(
  ventas,
  fecha >= as.Date("2025-01-01"),
  fecha <= as.Date("2025-01-07")
)
print(ventas_primera_semana)

# Operador ! para negación
sin_mouse <- filter(ventas, producto != "Mouse")
# O equivalentemente:
sin_mouse2 <- filter(ventas, !(producto == "Mouse"))

# Filtrar valores NA
# Ejemplo con datos faltantes
ventas_con_na <- ventas
ventas_con_na$total[c(3, 7)] <- NA

# Filtrar filas con NA
solo_na <- filter(ventas_con_na, is.na(total))
print(solo_na)

# Filtrar filas sin NA
sin_na <- filter(ventas_con_na, !is.na(total))
print(sin_na)

# ----------------------------------------------------------------------------
# SECCIÓN 4: SELECT() - SELECCIONAR COLUMNAS
# ----------------------------------------------------------------------------

cat("\n=== SELECT: SELECCIONAR COLUMNAS ===\n\n")

# Seleccionar columnas específicas
ventas_simple <- select(ventas, producto, vendedor, total)
print(head(ventas_simple))

# Seleccionar rango de columnas
ventas_rango <- select(ventas, fecha:cantidad)
print(head(ventas_rango))

# Excluir columnas
sin_id <- select(ventas, -id_venta)
print(head(sin_id))

# Excluir múltiples columnas
sin_ids_fecha <- select(ventas, -id_venta, -fecha)
print(head(sin_ids_fecha))

# Funciones auxiliares de select

# starts_with() - columnas que empiezan con...
# (nuestro dataset no tiene columnas con prefijo común, ejemplo teórico)

# ends_with() - columnas que terminan con...
# (nuestro dataset no tiene columnas con sufijo común)

# contains() - columnas que contienen...
cols_con_precio <- select(ventas, contains("precio"))
print(head(cols_con_precio))

# matches() - columnas que coinciden con regex
# everything() - todas las columnas

# Reordenar columnas
ventas_reordenado <- select(ventas, vendedor, producto, total, everything())
print(head(ventas_reordenado))

# Renombrar mientras seleccionas
ventas_renombrado <- select(
  ventas,
  venta_id = id_venta,
  producto,
  monto_total = total
)
print(head(ventas_renombrado))

# rename() - solo para renombrar (sin seleccionar)
ventas_rename <- rename(ventas, monto = total)
print(head(ventas_rename))

# ----------------------------------------------------------------------------
# SECCIÓN 5: ARRANGE() - ORDENAR FILAS
# ----------------------------------------------------------------------------

cat("\n=== ARRANGE: ORDENAR FILAS ===\n\n")

# Ordenar por total (ascendente)
ventas_ordenadas <- arrange(ventas, total)
print(head(ventas_ordenadas))
print(tail(ventas_ordenadas))

# Ordenar descendente con desc()
ventas_desc <- arrange(ventas, desc(total))
print(head(ventas_desc))

# Ordenar por múltiples columnas
# Primero por vendedor, luego por total
ventas_multi_orden <- arrange(ventas, vendedor, desc(total))
print(ventas_multi_orden)

# ----------------------------------------------------------------------------
# SECCIÓN 6: MUTATE() - CREAR/MODIFICAR COLUMNAS
# ----------------------------------------------------------------------------

cat("\n=== MUTATE: CREAR/MODIFICAR COLUMNAS ===\n\n")

# Crear nueva columna
ventas_con_iva <- mutate(ventas, total_con_iva = total * 1.16)
print(head(ventas_con_iva))

# Crear múltiples columnas
ventas_completo <- mutate(
  ventas,
  total_con_iva = total * 1.16,
  comision = total * 0.05,
  ganancia_neta = total_con_iva - comision
)
print(head(ventas_completo))

# Usar columnas recién creadas
ventas_calc <- mutate(
  ventas,
  total_con_iva = total * 1.16,
  descuento = total_con_iva * 0.10,
  total_final = total_con_iva - descuento  # Usa columnas creadas arriba
)
print(head(ventas_calc))

# transmute() - Como mutate pero solo mantiene las nuevas columnas
ventas_solo_nuevas <- transmute(
  ventas,
  producto,
  total,
  total_con_iva = total * 1.16
)
print(head(ventas_solo_nuevas))

# Funciones útiles con mutate

# ifelse para categorizar
ventas_categoria <- mutate(
  ventas,
  categoria = ifelse(total >= 10000, "Alta", "Baja")
)
print(head(ventas_categoria))

# case_when para múltiples condiciones
ventas_nivel <- mutate(
  ventas,
  nivel = case_when(
    total >= 20000 ~ "Premium",
    total >= 10000 ~ "Alto",
    total >= 5000 ~ "Medio",
    TRUE ~ "Bajo"  # Valor por defecto
  )
)
print(head(ventas_nivel, 10))

# ----------------------------------------------------------------------------
# SECCIÓN 7: OPERADOR PIPE %>%
# ----------------------------------------------------------------------------

cat("\n=== OPERADOR PIPE %>% ===\n\n")

# Sin pipe (anidado y difícil de leer)
resultado_sin_pipe <- arrange(
  filter(
    select(ventas, -id_venta),
    total > 5000
  ),
  desc(total)
)

# Con pipe (legible y claro)
resultado_con_pipe <- ventas %>%
  select(-id_venta) %>%
  filter(total > 5000) %>%
  arrange(desc(total))

print(head(resultado_con_pipe))

# Ejemplo complejo con pipe
analisis_completo <- ventas %>%
  filter(producto %in% c("Laptop", "Monitor")) %>%
  mutate(
    total_con_iva = total * 1.16,
    categoria = ifelse(total >= 10000, "Premium", "Estándar")
  ) %>%
  arrange(desc(total_con_iva)) %>%
  select(fecha, producto, vendedor, total_con_iva, categoria)

print(analisis_completo)

# ----------------------------------------------------------------------------
# SECCIÓN 8: SUMMARIZE() - RESUMIR DATOS
# ----------------------------------------------------------------------------

cat("\n=== SUMMARIZE: RESUMIR DATOS ===\n\n")

# Resumen básico
resumen_ventas <- summarize(
  ventas,
  total_ventas = sum(total),
  promedio = mean(total),
  mediana = median(total),
  maximo = max(total),
  minimo = min(total),
  num_transacciones = n()  # n() cuenta filas
)

print(resumen_ventas)

# Con pipe
resumen_pipe <- ventas %>%
  summarize(
    total = sum(total),
    promedio = mean(total),
    desv_std = sd(total),
    cantidad_ventas = n()
  )

print(resumen_pipe)

# ----------------------------------------------------------------------------
# SECCIÓN 9: GROUP_BY() - AGRUPAR DATOS
# ----------------------------------------------------------------------------

cat("\n=== GROUP_BY: AGRUPAR Y RESUMIR ===\n\n")

# Agrupar por vendedor
ventas_por_vendedor <- ventas %>%
  group_by(vendedor) %>%
  summarize(
    total_vendido = sum(total),
    num_ventas = n(),
    promedio_venta = mean(total),
    max_venta = max(total)
  ) %>%
  arrange(desc(total_vendido))

print(ventas_por_vendedor)

# Agrupar por producto
ventas_por_producto <- ventas %>%
  group_by(producto) %>%
  summarize(
    cantidad_total = sum(cantidad),
    ingresos_totales = sum(total),
    num_transacciones = n(),
    precio_promedio = mean(precio_unitario)
  ) %>%
  arrange(desc(ingresos_totales))

print(ventas_por_producto)

# Agrupar por múltiples variables
ventas_por_vendedor_producto <- ventas %>%
  group_by(vendedor, producto) %>%
  summarize(
    total = sum(total),
    cantidad = n(),
    .groups = "drop"  # Desagrupar después
  ) %>%
  arrange(vendedor, desc(total))

print(ventas_por_vendedor_producto)

# Filtrar grupos
# ¿Qué vendedores vendieron más de $50,000 en total?
vendedores_top <- ventas %>%
  group_by(vendedor) %>%
  summarize(total = sum(total)) %>%
  filter(total > 50000)

print(vendedores_top)

# mutate con group_by (muy poderoso)
# Agregar porcentaje de cada venta respecto al total del vendedor
ventas_con_porcentaje <- ventas %>%
  group_by(vendedor) %>%
  mutate(
    total_vendedor = sum(total),
    porcentaje = (total / total_vendedor) * 100
  ) %>%
  ungroup()  # Importante: desagrupar cuando termines

print(head(ventas_con_porcentaje, 10))

# ----------------------------------------------------------------------------
# SECCIÓN 10: EJEMPLO PRÁCTICO COMPLETO
# ----------------------------------------------------------------------------

cat("\n=== EJEMPLO PRÁCTICO: ANÁLISIS DE RENDIMIENTO ===\n\n")

# Análisis completo de ventas por región y producto
analisis_regional <- ventas %>%
  # 1. Agregar información calculada
  mutate(
    mes = format(fecha, "%Y-%m"),
    total_con_iva = total * 1.16
  ) %>%
  # 2. Filtrar solo ventas significativas
  filter(total > 1000) %>%
  # 3. Agrupar por región y producto
  group_by(region, producto) %>%
  # 4. Calcular estadísticas
  summarize(
    ventas_totales = sum(total),
    ventas_con_iva = sum(total_con_iva),
    cantidad_vendida = sum(cantidad),
    num_transacciones = n(),
    ticket_promedio = mean(total),
    .groups = "drop"
  ) %>%
  # 5. Agregar ranking
  arrange(desc(ventas_totales)) %>%
  mutate(ranking = row_number()) %>%
  # 6. Filtrar top 10
  filter(ranking <= 10)

print(analisis_regional)

# Reporte por vendedor con métricas clave
reporte_vendedores <- ventas %>%
  mutate(
    total_con_iva = total * 1.16,
    comision = total * 0.05
  ) %>%
  group_by(vendedor, region) %>%
  summarize(
    ventas_brutas = sum(total),
    ventas_con_iva = sum(total_con_iva),
    comisiones_ganadas = sum(comision),
    num_ventas = n(),
    ticket_promedio = mean(total),
    mejor_venta = max(total),
    .groups = "drop"
  ) %>%
  arrange(desc(ventas_brutas))

print(reporte_vendedores)

# ----------------------------------------------------------------------------
# SECCIÓN 11: OTRAS FUNCIONES ÚTILES
# ----------------------------------------------------------------------------

cat("\n=== OTRAS FUNCIONES ÚTILES ===\n\n")

# distinct() - Valores únicos
productos_unicos <- ventas %>%
  distinct(producto)
print(productos_unicos)

# distinct con múltiples columnas
combos_unicos <- ventas %>%
  distinct(vendedor, producto)
print(combos_unicos)

# distinct manteniendo todas las columnas
primera_venta_producto <- ventas %>%
  distinct(producto, .keep_all = TRUE)
print(primera_venta_producto)

# count() - Contar de forma rápida
conteo_productos <- ventas %>%
  count(producto, sort = TRUE)
print(conteo_productos)

# count con peso
conteo_ponderado <- ventas %>%
  count(producto, wt = cantidad, sort = TRUE, name = "cantidad_total")
print(conteo_ponderado)

# top_n() - Top n registros
top_5_ventas <- ventas %>%
  top_n(5, total)
print(top_5_ventas)

# slice() - Seleccionar filas por posición
primeras_5 <- ventas %>%
  slice(1:5)
print(primeras_5)

# slice_head y slice_tail
primeras_3 <- ventas %>%
  slice_head(n = 3)

ultimas_3 <- ventas %>%
  slice_tail(n = 3)

# slice_max y slice_min
top_3_ventas <- ventas %>%
  slice_max(total, n = 3)
print(top_3_ventas)

# sample_n() y sample_frac() - Muestreo aleatorio
muestra_5 <- ventas %>%
  sample_n(5)  # 5 filas aleatorias

muestra_10pct <- ventas %>%
  sample_frac(0.1)  # 10% de filas aleatorias

# ----------------------------------------------------------------------------
# SECCIÓN 12: EJERCICIOS PRÁCTICOS
# ----------------------------------------------------------------------------

cat("\n=== EJERCICIOS PRÁCTICOS ===\n\n")

# EJERCICIO 1: Top 3 vendedores por total de ventas
cat("EJERCICIO 1: Top 3 vendedores\n")
top_vendedores <- ventas %>%
  group_by(vendedor) %>%
  summarize(total_ventas = sum(total)) %>%
  arrange(desc(total_ventas)) %>%
  slice_head(n = 3)

print(top_vendedores)

# EJERCICIO 2: Productos que se vendieron en todas las regiones
cat("\n\nEJERCICIO 2: Productos en todas las regiones\n")
productos_todas_regiones <- ventas %>%
  distinct(producto, region) %>%
  count(producto) %>%
  filter(n == length(unique(ventas$region))) %>%
  select(producto)

print(productos_todas_regiones)

# EJERCICIO 3: Día con mayor volumen de ventas
cat("\n\nEJERCICIO 3: Mejor día de ventas\n")
mejor_dia <- ventas %>%
  group_by(fecha) %>%
  summarize(total_dia = sum(total)) %>%
  arrange(desc(total_dia)) %>%
  slice_head(n = 1)

print(mejor_dia)

# EJERCICIO 4: Análisis de tickets promedio por región
cat("\n\nEJERCICIO 4: Ticket promedio por región\n")
ticket_region <- ventas %>%
  group_by(region) %>%
  summarize(
    ticket_promedio = mean(total),
    num_transacciones = n(),
    total_region = sum(total)
  ) %>%
  mutate(porcentaje_ventas = (total_region / sum(total_region)) * 100) %>%
  arrange(desc(ticket_promedio))

print(ticket_region)

# ----------------------------------------------------------------------------
# SECCIÓN 13: DESAFÍOS
# ----------------------------------------------------------------------------

cat("\n=== DESAFÍOS ===\n\n")

# DESAFÍO 1: Crear un ranking de productos por región
cat("DESAFÍO 1: Ranking productos por región\n")
ranking_productos_region <- ventas %>%
  group_by(region, producto) %>%
  summarize(total_ventas = sum(total), .groups = "drop_last") %>%
  mutate(ranking_en_region = rank(desc(total_ventas))) %>%
  arrange(region, ranking_en_region) %>%
  ungroup()

print(ranking_productos_region)

# DESAFÍO 2: Identificar el mejor mes para cada vendedor
cat("\n\nDESAFÍO 2: Mejor mes por vendedor\n")
mejor_mes_vendedor <- ventas %>%
  mutate(mes = format(fecha, "%Y-%m")) %>%
  group_by(vendedor, mes) %>%
  summarize(total_mes = sum(total), .groups = "drop_last") %>%
  slice_max(total_mes, n = 1) %>%
  ungroup()

print(mejor_mes_vendedor)

# DESAFÍO 3: Análisis de consistencia de vendedores
# (desviación estándar de sus ventas)
cat("\n\nDESAFÍO 3: Consistencia de vendedores\n")
consistencia_vendedores <- ventas %>%
  group_by(vendedor) %>%
  summarize(
    promedio_venta = mean(total),
    desv_std = sd(total),
    coef_variacion = (sd(total) / mean(total)) * 100,
    num_ventas = n()
  ) %>%
  arrange(coef_variacion)

print(consistencia_vendedores)
cat("\nNota: Menor coeficiente de variación = Más consistente\n")

# ----------------------------------------------------------------------------
# RESUMEN
# ----------------------------------------------------------------------------

cat("\n=== RESUMEN DE LA LECCIÓN ===\n")
cat("Dominaste los verbos de dplyr:\n")
cat("✓ filter()    - Filtrar filas\n")
cat("✓ select()    - Seleccionar columnas\n")
cat("✓ arrange()   - Ordenar datos\n")
cat("✓ mutate()    - Crear/modificar variables\n")
cat("✓ summarize() - Resumir datos\n")
cat("✓ group_by()  - Agrupar y agregar\n")
cat("✓ %>%         - Pipe para encadenar operaciones\n")
cat("\nEstas herramientas son ESENCIALES para preparar datos para ML\n")
cat("Siguiente: Lección 2 - Visualización con ggplot2\n")

# ============================================================================
# FIN DE LA LECCIÓN
# ============================================================================
