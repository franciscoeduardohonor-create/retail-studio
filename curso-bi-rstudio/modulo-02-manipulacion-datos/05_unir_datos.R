# ============================================================================
# MÓDULO 2 - LECCIÓN 5: UNIR DATOS (JOINS)
# ============================================================================
# Objetivo: Dominar la unión de tablas, fundamental para Business Intelligence
# ============================================================================

# En BI casi siempre trabajamos con múltiples tablas que necesitamos combinar
# Los JOINS son como en SQL pero más intuitivos en dplyr

library(dplyr)

# ============================================================================
# 1. CONCEPTOS BÁSICOS DE JOINS
# ============================================================================

# Hay 4 tipos principales de joins:
#
# 1. left_join()  - Mantiene todas las filas de la tabla izquierda
# 2. right_join() - Mantiene todas las filas de la tabla derecha
# 3. inner_join() - Solo filas que coinciden en ambas tablas
# 4. full_join()  - Todas las filas de ambas tablas

# ============================================================================
# 2. DATOS DE EJEMPLO
# ============================================================================

# Tabla de ventas
ventas <- data.frame(
  venta_id = 1:8,
  producto_id = c(101, 102, 103, 101, 104, 102, 105, 103),
  cantidad = c(2, 5, 1, 3, 4, 2, 1, 6),
  vendedor_id = c(1, 2, 1, 3, 2, 1, 3, 2)
)

# Tabla de productos
productos <- data.frame(
  producto_id = c(101, 102, 103, 104, 106),
  nombre_producto = c("Laptop", "Mouse", "Teclado", "Monitor", "Impresora"),
  precio = c(899.99, 25.50, 45.99, 199.99, 299.99),
  categoria = c("Computadoras", "Accesorios", "Accesorios",
               "Computadoras", "Periféricos")
)

# Tabla de vendedores
vendedores <- data.frame(
  vendedor_id = c(1, 2, 3),
  nombre_vendedor = c("Ana García", "Carlos López", "Diana Martínez"),
  region = c("Norte", "Sur", "Centro"),
  comision_pct = c(5, 7, 6)
)

print("VENTAS:")
print(ventas)
print("\nPRODUCTOS:")
print(productos)
print("\nVENDEDORES:")
print(vendedores)

# ============================================================================
# 3. LEFT JOIN - Join más común en BI
# ============================================================================

# left_join mantiene TODAS las filas de la tabla izquierda
# Sintaxis: left_join(tabla_izquierda, tabla_derecha, by = "columna_común")

# Unir ventas con información de productos
ventas_con_productos <- left_join(ventas, productos, by = "producto_id")
print(ventas_con_productos)

# NOTA: El producto_id 105 en ventas no existe en productos
#       Por eso tiene NA en las columnas de productos

# Ahora podemos calcular el total de cada venta
ventas_completas <- ventas_con_productos %>%
  mutate(total_venta = cantidad * precio)

print(ventas_completas)

# ============================================================================
# 4. INNER JOIN - Solo coincidencias
# ============================================================================

# inner_join mantiene SOLO las filas que coinciden en AMBAS tablas

ventas_inner <- inner_join(ventas, productos, by = "producto_id")
print(ventas_inner)

# NOTA: La venta del producto_id 105 desapareció porque no existe en productos
# También el producto_id 106 (Impresora) no aparece porque no tiene ventas

# ============================================================================
# 5. RIGHT JOIN - Menos común pero útil
# ============================================================================

# right_join es lo opuesto a left_join
# Mantiene todas las filas de la tabla DERECHA

ventas_right <- right_join(ventas, productos, by = "producto_id")
print(ventas_right)

# NOTA: Ahora aparece la Impresora (106) con NA en las columnas de ventas

# ============================================================================
# 6. FULL JOIN - Todas las filas
# ============================================================================

# full_join mantiene todas las filas de AMBAS tablas

ventas_full <- full_join(ventas, productos, by = "producto_id")
print(ventas_full)

# Aparecen tanto el producto 105 como el 106

# ============================================================================
# 7. MÚLTIPLES JOINS ENCADENADOS
# ============================================================================

# En BI es común unir 3+ tablas
# Usamos %>% para encadenar joins

ventas_completo <- ventas %>%
  left_join(productos, by = "producto_id") %>%
  left_join(vendedores, by = "vendedor_id") %>%
  mutate(
    total_venta = cantidad * precio,
    comision = total_venta * (comision_pct / 100)
  )

print(ventas_completo)

# Ahora tenemos un dataset completo con toda la información

# ============================================================================
# 8. JOINS CON NOMBRES DE COLUMNAS DIFERENTES
# ============================================================================

# Si las columnas tienen nombres diferentes, usamos "by" con named vector

# Ejemplo: tabla clientes
clientes <- data.frame(
  id_cliente = c(1, 2, 3),
  nombre = c("Empresa A", "Empresa B", "Empresa C"),
  tipo = c("Premium", "Estándar", "Premium")
)

# Tabla pedidos con diferente nombre de columna
pedidos <- data.frame(
  pedido_id = c(1, 2, 3),
  cliente = c(1, 2, 1),  # Nota: se llama "cliente" no "id_cliente"
  monto = c(5000, 3000, 7500)
)

# Join especificando la correspondencia
pedidos_con_info <- left_join(
  pedidos,
  clientes,
  by = c("cliente" = "id_cliente")  # cliente (pedidos) = id_cliente (clientes)
)

print(pedidos_con_info)

# ============================================================================
# 9. JOINS CON MÚLTIPLES COLUMNAS
# ============================================================================

# A veces necesitamos hacer join por más de una columna

ventas_detalle <- data.frame(
  tienda_id = c(1, 1, 2, 2),
  producto_id = c(101, 102, 101, 103),
  cantidad = c(10, 5, 8, 12)
)

precios_tienda <- data.frame(
  tienda_id = c(1, 1, 2, 2, 2),
  producto_id = c(101, 102, 101, 102, 103),
  precio_local = c(900, 26, 850, 24, 46)
)

# Join por ambas columnas
ventas_con_precio <- left_join(
  ventas_detalle,
  precios_tienda,
  by = c("tienda_id", "producto_id")
)

print(ventas_con_precio)

# ============================================================================
# 10. ANTI_JOIN Y SEMI_JOIN
# ============================================================================

# anti_join: Filas de X que NO tienen coincidencia en Y
# semi_join: Filas de X que SÍ tienen coincidencia en Y (pero no agrega columnas)

# Productos que NO se han vendido
productos_sin_venta <- anti_join(productos, ventas, by = "producto_id")
print("Productos sin ventas:")
print(productos_sin_venta)

# Productos que SÍ se han vendido (sin duplicar info)
productos_con_venta <- semi_join(productos, ventas, by = "producto_id")
print("Productos con ventas:")
print(productos_con_venta)

# ============================================================================
# 11. SUFIJOS PARA COLUMNAS DUPLICADAS
# ============================================================================

# Cuando ambas tablas tienen columnas con el mismo nombre
# (aparte de la columna del join)

tabla_a <- data.frame(
  id = c(1, 2, 3),
  nombre = c("A1", "A2", "A3"),
  valor = c(100, 200, 300)
)

tabla_b <- data.frame(
  id = c(1, 2, 4),
  nombre = c("B1", "B2", "B4"),
  valor = c(150, 250, 350)
)

# Por defecto agrega .x y .y
resultado <- left_join(tabla_a, tabla_b, by = "id")
print(resultado)

# Personalizar los sufijos
resultado_custom <- left_join(
  tabla_a,
  tabla_b,
  by = "id",
  suffix = c("_original", "_nuevo")
)
print(resultado_custom)

# ============================================================================
# CASO PRÁCTICO 1: ANÁLISIS COMPLETO DE VENTAS
# ============================================================================

# Dataset realista de BI

# Tabla transacciones
transacciones <- data.frame(
  trans_id = 1:10,
  fecha = as.Date(c("2024-01-15", "2024-01-15", "2024-01-16", "2024-01-16",
                   "2024-01-17", "2024-01-17", "2024-01-18", "2024-01-18",
                   "2024-01-19", "2024-01-19")),
  producto_id = c(101, 102, 103, 101, 102, 104, 101, 103, 102, 104),
  cantidad = c(2, 5, 1, 3, 4, 2, 1, 2, 6, 3),
  cliente_id = c(1, 2, 1, 3, 2, 1, 3, 2, 1, 3),
  vendedor_id = c(1, 2, 1, 2, 1, 2, 1, 2, 1, 2)
)

# Tabla clientes
clientes_tbl <- data.frame(
  cliente_id = 1:3,
  nombre_cliente = c("TechCorp", "RetailMax", "SoftSolutions"),
  segmento = c("Corporativo", "Retail", "Corporativo"),
  ciudad = c("CDMX", "Guadalajara", "Monterrey")
)

# Crear reporte completo
reporte_ventas <- transacciones %>%
  # Unir con productos
  left_join(productos, by = "producto_id") %>%
  # Unir con clientes
  left_join(clientes_tbl, by = "cliente_id") %>%
  # Unir con vendedores
  left_join(vendedores, by = "vendedor_id") %>%
  # Calcular métricas
  mutate(
    total_venta = cantidad * precio,
    comision = total_venta * (comision_pct / 100)
  ) %>%
  # Seleccionar columnas relevantes
  select(trans_id, fecha, nombre_cliente, segmento, ciudad,
         nombre_producto, categoria, cantidad, precio, total_venta,
         nombre_vendedor, region, comision)

print(reporte_ventas)

# Análisis: Ventas por segmento de cliente
analisis_segmento <- reporte_ventas %>%
  group_by(segmento) %>%
  summarise(
    total_ingresos = sum(total_venta, na.rm = TRUE),
    num_transacciones = n(),
    ticket_promedio = mean(total_venta, na.rm = TRUE),
    unidades_vendidas = sum(cantidad)
  ) %>%
  arrange(desc(total_ingresos))

print("Análisis por segmento:")
print(analisis_segmento)

# ============================================================================
# CASO PRÁCTICO 2: IDENTIFICAR PROBLEMAS DE DATOS
# ============================================================================

# Uso de anti_join para encontrar problemas

# Ventas de productos que no existen en el catálogo (error de datos)
ventas_problematicas <- anti_join(ventas, productos, by = "producto_id")
print("Ventas de productos no catalogados:")
print(ventas_problematicas)

# Productos sin movimiento
productos_inactivos <- anti_join(productos, ventas, by = "producto_id")
print("Productos sin ventas:")
print(productos_inactivos)

# ============================================================================
# EJERCICIOS PRÁCTICOS
# ============================================================================

# Crea estos datasets:
empleados_tbl <- data.frame(
  empleado_id = 1:5,
  nombre = c("Juan", "María", "Pedro", "Ana", "Luis"),
  depto_id = c(1, 2, 1, 2, 3)
)

departamentos <- data.frame(
  depto_id = c(1, 2, 3, 4),
  nombre_depto = c("Ventas", "IT", "RRHH", "Marketing"),
  gerente = c("Carlos", "Diana", "Roberto", "Laura")
)

salarios <- data.frame(
  empleado_id = c(1, 2, 3, 4),
  salario = c(25000, 35000, 28000, 40000),
  bono = c(5000, 7000, 5500, 8000)
)

# EJERCICIO 1: Une empleados con departamentos para ver qué departamento
#              pertenece cada empleado
# TU CÓDIGO AQUÍ:




# EJERCICIO 2: Une empleados con departamentos Y salarios
#              Calcula el total (salario + bono) para cada empleado
# TU CÓDIGO AQUÍ:




# EJERCICIO 3: Encuentra qué empleados NO tienen información de salario
# TU CÓDIGO AQUÍ:




# EJERCICIO 4: Encuentra qué departamentos NO tienen empleados asignados
# TU CÓDIGO AQUÍ:




# ============================================================================
# ¡EXCELENTE TRABAJO!
# ============================================================================
# Ahora dominas:
# ✓ Los 4 tipos principales de joins
# ✓ Unir múltiples tablas
# ✓ Joins con diferentes nombres de columnas
# ✓ anti_join y semi_join
# ✓ Manejar columnas duplicadas
# ✓ Análisis completos uniendo datos
#
# Continúa con: 06_pivotar_datos.R
# ============================================================================
