# ============================================================================
# EJEMPLO PRÁCTICO 1: SISTEMA DE INVENTARIO DE TIENDA
# ============================================================================
# Aprenderás a manejar data frames con un caso real de inventario

# Crear base de datos de productos
inventario <- data.frame(
  codigo = c("P001", "P002", "P003", "P004", "P005", "P006"),
  producto = c("Laptop", "Mouse", "Teclado", "Monitor", "Webcam", "Audífonos"),
  categoria = c("Computadoras", "Accesorios", "Accesorios",
                "Computadoras", "Accesorios", "Accesorios"),
  precio = c(899.99, 29.99, 79.99, 299.99, 89.99, 59.99),
  stock = c(15, 50, 30, 20, 25, 40),
  stock_minimo = c(5, 20, 15, 10, 10, 20),
  proveedor = c("TechCorp", "TechCorp", "PeripheralCo",
                "ScreenPro", "TechCorp", "AudioMax"),
  stringsAsFactors = FALSE
)

print("=== INVENTARIO DE LA TIENDA ===")
print(inventario)

# ============================================================================
# ANÁLISIS 1: VALOR DEL INVENTARIO
# ============================================================================

# Calcular valor total por producto
inventario$valor_total <- inventario$precio * inventario$stock

print("\n=== VALOR DEL INVENTARIO ===")
print(inventario[, c("producto", "stock", "precio", "valor_total")])

# Valor total del inventario
valor_total_inventario <- sum(inventario$valor_total)
print(paste("\nValor total del inventario: $", round(valor_total_inventario, 2)))

# Producto con mayor valor en inventario
producto_mayor_valor <- inventario[which.max(inventario$valor_total), ]
print(paste("Producto con mayor valor:", producto_mayor_valor$producto,
            "($", round(producto_mayor_valor$valor_total, 2), ")"))

# ============================================================================
# ANÁLISIS 2: ALERTAS DE STOCK
# ============================================================================

# Identificar productos con stock bajo
inventario$alerta_stock <- inventario$stock < inventario$stock_minimo

print("\n=== ALERTAS DE STOCK ===")
productos_bajo_stock <- inventario[inventario$alerta_stock, ]

if (nrow(productos_bajo_stock) > 0) {
  print("¡ATENCIÓN! Productos con stock bajo:")
  print(productos_bajo_stock[, c("codigo", "producto", "stock", "stock_minimo")])
} else {
  print("Todos los productos tienen stock suficiente")
}

# ============================================================================
# ANÁLISIS 3: ANÁLISIS POR CATEGORÍA
# ============================================================================

print("\n=== ANÁLISIS POR CATEGORÍA ===")

# Número de productos por categoría
productos_por_categoria <- table(inventario$categoria)
print("Productos por categoría:")
print(productos_por_categoria)

# Valor del inventario por categoría
valor_por_categoria <- tapply(inventario$valor_total,
                               inventario$categoria, sum)
print("\nValor por categoría:")
print(valor_por_categoria)

# Precio promedio por categoría
precio_promedio_categoria <- tapply(inventario$precio,
                                    inventario$categoria, mean)
print("\nPrecio promedio por categoría:")
print(round(precio_promedio_categoria, 2))

# ============================================================================
# ANÁLISIS 4: ANÁLISIS POR PROVEEDOR
# ============================================================================

print("\n=== ANÁLISIS POR PROVEEDOR ===")

# Productos por proveedor
productos_por_proveedor <- table(inventario$proveedor)
print("Productos por proveedor:")
print(productos_por_proveedor)

# Valor total por proveedor
valor_por_proveedor <- tapply(inventario$valor_total,
                               inventario$proveedor, sum)
print("\nValor en inventario por proveedor:")
print(round(sort(valor_por_proveedor, decreasing = TRUE), 2))

# ============================================================================
# ANÁLISIS 5: CATEGORIZACIÓN DE PRODUCTOS
# ============================================================================

# Clasificar productos por precio
inventario$rango_precio <- cut(inventario$precio,
                                breaks = c(0, 50, 100, 500, Inf),
                                labels = c("Bajo", "Medio", "Alto", "Premium"))

print("\n=== CLASIFICACIÓN POR PRECIO ===")
print(inventario[, c("producto", "precio", "rango_precio")])

# Contar productos por rango
table(inventario$rango_precio)

# ============================================================================
# SIMULACIÓN: VENTA DE PRODUCTOS
# ============================================================================

print("\n=== SIMULACIÓN DE VENTAS ===")

# Simular venta de 5 Laptops
producto_vendido <- "Laptop"
cantidad_vendida <- 5

# Actualizar stock
indice_producto <- which(inventario$producto == producto_vendido)
stock_anterior <- inventario$stock[indice_producto]
inventario$stock[indice_producto] <- stock_anterior - cantidad_vendida

print(paste("Venta realizada:", cantidad_vendida, producto_vendido))
print(paste("Stock anterior:", stock_anterior))
print(paste("Stock actual:", inventario$stock[indice_producto]))

# Calcular ingreso por la venta
precio_producto <- inventario$precio[indice_producto]
ingreso_venta <- precio_producto * cantidad_vendida
print(paste("Ingreso generado: $", ingreso_venta))

# Verificar si necesita reabastecimiento
if (inventario$stock[indice_producto] < inventario$stock_minimo[indice_producto]) {
  print("¡ALERTA! El stock está por debajo del mínimo. Reabastecer.")
}

# ============================================================================
# REPORTE FINAL
# ============================================================================

print("\n=== REPORTE FINAL DE INVENTARIO ===")

# Recalcular valores después de la venta
inventario$valor_total <- inventario$precio * inventario$stock

# Top 3 productos por valor
top_productos <- head(inventario[order(-inventario$valor_total), ], 3)
print("\nTop 3 productos por valor en inventario:")
print(top_productos[, c("producto", "stock", "valor_total")])

# Estadísticas generales
print(paste("\nTotal de productos diferentes:", nrow(inventario)))
print(paste("Unidades totales en stock:", sum(inventario$stock)))
print(paste("Valor total actual: $", round(sum(inventario$valor_total), 2)))
print(paste("Precio promedio: $", round(mean(inventario$precio), 2)))

# ============================================================================
# EJERCICIO PARA TI
# ============================================================================
# 1. Agrega 3 productos más al inventario
# 2. Simula la venta de diferentes productos
# 3. Crea un sistema de descuentos por categoría
# 4. Calcula las ganancias si tienes un margen del 30%
# 5. Identifica qué proveedor tiene el mayor valor en inventario
