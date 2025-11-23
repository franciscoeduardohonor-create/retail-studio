# =============================================================================
# MÓDULO 2: MANIPULACIÓN DE DATOS
# Lección 1: dplyr - Manipulación básica de datos
# =============================================================================

# dplyr es parte del "tidyverse", un conjunto de paquetes para ciencia de datos
# Facilita la manipulación de datos con funciones intuitivas

# CONTENIDO:
# 1. Instalación y carga de paquetes
# 2. Funciones principales: select, filter, arrange, mutate, summarise
# 3. Pipe operator %>%
# 4. group_by

# =============================================================================
# 1. INSTALACIÓN Y CARGA DE PAQUETES
# =============================================================================

# Instalar dplyr (solo se hace una vez)
# Descomenta la siguiente línea si aún no lo has instalado:
# install.packages("dplyr")

# Cargar la librería
library(dplyr)

# Crear datos de ejemplo
ventas <- data.frame(
  producto = c("Laptop", "Mouse", "Teclado", "Monitor", "Laptop",
               "Mouse", "Teclado", "Monitor", "Laptop", "Tablet"),
  vendedor = c("Juan", "Ana", "Luis", "Ana", "Juan",
               "Luis", "Ana", "Juan", "Luis", "Ana"),
  cantidad = c(2, 15, 8, 3, 1, 20, 10, 2, 3, 5),
  precio_unitario = c(15000, 250, 800, 5000, 15000,
                      250, 800, 5000, 15000, 8000),
  region = c("Norte", "Sur", "Norte", "Sur", "Centro",
             "Norte", "Sur", "Centro", "Norte", "Sur")
)

print(ventas)

# =============================================================================
# 2. SELECT - Seleccionar columnas
# =============================================================================

# select() permite elegir qué columnas mantener

# Seleccionar columnas específicas
productos_precios <- select(ventas, producto, precio_unitario)
print(productos_precios)

# Seleccionar rango de columnas
primeras_columnas <- select(ventas, producto:cantidad)
print(primeras_columnas)

# Excluir columnas (usar -)
sin_region <- select(ventas, -region)
print(sin_region)

# Seleccionar columnas que empiezan con cierto texto
# columnas_p <- select(ventas, starts_with("p"))

# Seleccionar columnas que contienen cierto texto
# columnas_con_o <- select(ventas, contains("o"))

# Reordenar columnas
ventas_reordenadas <- select(ventas, vendedor, producto, everything())
print(ventas_reordenadas)

# EJERCICIO 1: Del data frame 'ventas'
# 1. Selecciona solo producto y cantidad
# 2. Selecciona todas las columnas excepto region
# Tu código aquí:




# =============================================================================
# 3. FILTER - Filtrar filas
# =============================================================================

# filter() permite seleccionar filas basándose en condiciones

# Filtrar ventas de un vendedor específico
ventas_juan <- filter(ventas, vendedor == "Juan")
print(ventas_juan)

# Filtrar por cantidad
ventas_grandes <- filter(ventas, cantidad > 5)
print(ventas_grandes)

# Filtrar por precio
productos_caros <- filter(ventas, precio_unitario >= 5000)
print(productos_caros)

# Múltiples condiciones con AND (&)
ventas_juan_norte <- filter(ventas, vendedor == "Juan" & region == "Norte")
print(ventas_juan_norte)

# Múltiples condiciones con OR (|)
ventas_juan_o_ana <- filter(ventas, vendedor == "Juan" | vendedor == "Ana")
print(ventas_juan_o_ana)

# Filtrar con %in% (está en un conjunto de valores)
ventas_norte_sur <- filter(ventas, region %in% c("Norte", "Sur"))
print(ventas_norte_sur)

# Combinar select y filter (forma tradicional)
resultado <- select(filter(ventas, cantidad > 5), producto, cantidad)
print(resultado)

# EJERCICIO 2: Del data frame 'ventas'
# 1. Filtra ventas de la región Norte
# 2. Filtra ventas con precio_unitario menor a 1000
# 3. Filtra ventas de Ana en la región Sur
# Tu código aquí:




# =============================================================================
# 4. PIPE OPERATOR %>% - Encadenar operaciones
# =============================================================================

# El operador %>% (pipe) toma el resultado de la izquierda
# y lo pasa como primer argumento a la función de la derecha
# Atajo de teclado: Ctrl+Shift+M (Windows) o Cmd+Shift+M (Mac)

# Sin pipe (difícil de leer)
resultado1 <- select(filter(ventas, vendedor == "Juan"), producto, cantidad)

# Con pipe (más legible)
resultado2 <- ventas %>%
  filter(vendedor == "Juan") %>%
  select(producto, cantidad)

print(resultado2)

# Ejemplo más complejo
analisis <- ventas %>%
  filter(precio_unitario > 500) %>%
  select(producto, vendedor, cantidad, precio_unitario)

print(analisis)

# EJERCICIO 3: Usa el pipe para:
# 1. Filtrar ventas de la región Norte
# 2. Seleccionar solo producto, vendedor y cantidad
# Tu código aquí:




# =============================================================================
# 5. ARRANGE - Ordenar filas
# =============================================================================

# arrange() ordena las filas según una o más columnas

# Ordenar por cantidad (ascendente)
ventas_ordenadas <- ventas %>%
  arrange(cantidad)
print(ventas_ordenadas)

# Ordenar descendente con desc()
ventas_desc <- ventas %>%
  arrange(desc(cantidad))
print(ventas_desc)

# Ordenar por múltiples columnas
ventas_multi <- ventas %>%
  arrange(region, desc(cantidad))
print(ventas_multi)

# EJERCICIO 4: Ordena las ventas:
# 1. Por precio_unitario de mayor a menor
# 2. Por vendedor (ascendente) y luego cantidad (descendente)
# Tu código aquí:




# =============================================================================
# 6. MUTATE - Crear o modificar columnas
# =============================================================================

# mutate() crea nuevas columnas o modifica existentes

# Crear nueva columna
ventas_con_total <- ventas %>%
  mutate(venta_total = cantidad * precio_unitario)
print(ventas_con_total)

# Crear múltiples columnas
ventas_calculadas <- ventas %>%
  mutate(
    venta_total = cantidad * precio_unitario,
    iva = venta_total * 0.16,
    venta_con_iva = venta_total + iva
  )
print(ventas_calculadas)

# Modificar columna existente
ventas_modificadas <- ventas %>%
  mutate(precio_unitario = precio_unitario * 1.1)  # Aumentar 10%
print(ventas_modificadas)

# Usar condiciones con ifelse()
ventas_categorias <- ventas %>%
  mutate(
    categoria_precio = ifelse(precio_unitario >= 5000, "Caro", "Económico")
  )
print(ventas_categorias)

# case_when() para múltiples condiciones
ventas_categorias2 <- ventas %>%
  mutate(
    categoria = case_when(
      precio_unitario < 500 ~ "Económico",
      precio_unitario < 5000 ~ "Medio",
      precio_unitario >= 5000 ~ "Premium"
    )
  )
print(ventas_categorias2)

# EJERCICIO 5:
# 1. Crea una columna 'venta_total'
# 2. Crea una columna 'tipo_venta' que sea "Mayor" si cantidad > 5, sino "Menor"
# 3. Crea una columna 'comision' que sea el 5% de venta_total
# Tu código aquí:




# =============================================================================
# 7. SUMMARISE - Resúmenes estadísticos
# =============================================================================

# summarise() reduce el data frame a una sola fila de resúmenes

# Resumen simple
resumen <- ventas %>%
  summarise(
    total_ventas = n(),                    # Número de filas
    cantidad_total = sum(cantidad),
    cantidad_promedio = mean(cantidad),
    cantidad_max = max(cantidad),
    cantidad_min = min(cantidad)
  )
print(resumen)

# EJERCICIO 6: Crea un resumen que incluya:
# 1. El precio unitario promedio
# 2. El precio unitario máximo y mínimo
# Tu código aquí:




# =============================================================================
# 8. GROUP_BY - Agrupar datos
# =============================================================================

# group_by() agrupa datos para hacer operaciones por grupo
# Se usa típicamente con summarise()

# Resumen por vendedor
resumen_vendedor <- ventas %>%
  group_by(vendedor) %>%
  summarise(
    num_ventas = n(),
    cantidad_total = sum(cantidad),
    cantidad_promedio = mean(cantidad)
  )
print(resumen_vendedor)

# Resumen por región
resumen_region <- ventas %>%
  group_by(region) %>%
  summarise(
    total_productos = sum(cantidad),
    num_transacciones = n()
  )
print(resumen_region)

# Agrupar por múltiples variables
resumen_doble <- ventas %>%
  group_by(vendedor, region) %>%
  summarise(
    ventas_totales = n(),
    cantidad_total = sum(cantidad),
    .groups = "drop"  # Eliminar agrupamiento después
  )
print(resumen_doble)

# Combinar todo: análisis completo
analisis_completo <- ventas %>%
  mutate(venta_total = cantidad * precio_unitario) %>%
  group_by(vendedor) %>%
  summarise(
    num_ventas = n(),
    ingresos_totales = sum(venta_total),
    ingreso_promedio = mean(venta_total),
    ingreso_maximo = max(venta_total)
  ) %>%
  arrange(desc(ingresos_totales))

print(analisis_completo)

# EJERCICIO 7: Crea un análisis que:
# 1. Agrupe por producto
# 2. Calcule la cantidad total vendida de cada producto
# 3. Ordene de mayor a menor cantidad vendida
# Tu código aquí:




# =============================================================================
# EJEMPLO PRÁCTICO COMPLETO: ANÁLISIS DE VENTAS
# =============================================================================

# Análisis detallado paso a paso
print("=== ANÁLISIS COMPLETO DE VENTAS ===")

# 1. Preparar datos
ventas_completas <- ventas %>%
  mutate(venta_total = cantidad * precio_unitario)

# 2. Top 3 productos más vendidos
top_productos <- ventas_completas %>%
  group_by(producto) %>%
  summarise(
    cantidad_vendida = sum(cantidad),
    ingresos = sum(venta_total)
  ) %>%
  arrange(desc(ingresos)) %>%
  head(3)

print("Top 3 productos por ingresos:")
print(top_productos)

# 3. Desempeño por vendedor
desempeno_vendedores <- ventas_completas %>%
  group_by(vendedor) %>%
  summarise(
    transacciones = n(),
    unidades_vendidas = sum(cantidad),
    ingresos_totales = sum(venta_total),
    ticket_promedio = mean(venta_total)
  ) %>%
  arrange(desc(ingresos_totales))

print("Desempeño por vendedor:")
print(desempeno_vendedores)

# 4. Análisis por región
analisis_regional <- ventas_completas %>%
  group_by(region) %>%
  summarise(
    ventas = n(),
    ingresos = sum(venta_total)
  ) %>%
  mutate(porcentaje = round(ingresos / sum(ingresos) * 100, 2))

print("Análisis regional:")
print(analisis_regional)

# =============================================================================
# RESUMEN DE LA LECCIÓN
# =============================================================================
# ✓ select(): seleccionar columnas
# ✓ filter(): filtrar filas por condiciones
# ✓ arrange(): ordenar filas
# ✓ mutate(): crear/modificar columnas
# ✓ summarise(): crear resúmenes estadísticos
# ✓ group_by(): agrupar datos
# ✓ %>%: encadenar operaciones (pipe)

# =============================================================================
# ¡Felicidades! Has completado la Lección 1 del Módulo 2
# Continúa con leccion2_dplyr_avanzado.R
# =============================================================================
