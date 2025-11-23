# ============================================================================
# EJEMPLO PRÁCTICO: SISTEMA DE COMISIONES DE VENTAS
# ============================================================================

# Función para calcular comisión según nivel de ventas
calcular_comision <- function(venta) {
  if (venta < 1000) {
    comision <- venta * 0.05  # 5%
  } else if (venta < 5000) {
    comision <- venta * 0.08  # 8%
  } else if (venta < 10000) {
    comision <- venta * 0.10  # 10%
  } else {
    comision <- venta * 0.12  # 12%
  }
  return(comision)
}

# Función para generar reporte de vendedor
reporte_vendedor <- function(nombre, ventas_mensuales) {
  total_ventas <- sum(ventas_mensuales)
  promedio_ventas <- mean(ventas_mensuales)
  mejor_venta <- max(ventas_mensuales)
  peor_venta <- min(ventas_mensuales)

  # Calcular comisiones
  comisiones <- numeric(length(ventas_mensuales))
  for (i in 1:length(ventas_mensuales)) {
    comisiones[i] <- calcular_comision(ventas_mensuales[i])
  }
  total_comision <- sum(comisiones)

  # Determinar categoría
  if (total_ventas >= 50000) {
    categoria <- "Estrella"
  } else if (total_ventas >= 30000) {
    categoria <- "Destacado"
  } else if (total_ventas >= 15000) {
    categoria <- "Regular"
  } else {
    categoria <- "Necesita mejorar"
  }

  # Crear reporte
  cat("\n===", nombre, "===\n")
  cat("Total de ventas: $", total_ventas, "\n")
  cat("Promedio mensual: $", round(promedio_ventas, 2), "\n")
  cat("Mejor venta: $", mejor_venta, "\n")
  cat("Peor venta: $", peor_venta, "\n")
  cat("Total comisiones: $", round(total_comision, 2), "\n")
  cat("Categoría:", categoria, "\n")

  return(list(
    nombre = nombre,
    total_ventas = total_ventas,
    total_comision = total_comision,
    categoria = categoria
  ))
}

# Probar el sistema
ventas_ana <- c(3200, 4500, 5800, 3900, 4200, 6100)
ventas_juan <- c(8500, 9200, 11000, 7800, 9500, 10200)
ventas_maria <- c(1200, 1500, 1800, 1400, 1600, 1900)

reporte_ana <- reporte_vendedor("Ana García", ventas_ana)
reporte_juan <- reporte_vendedor("Juan Pérez", ventas_juan)
reporte_maria <- reporte_vendedor("María López", ventas_maria)

# Encontrar el mejor vendedor
if (reporte_ana$total_ventas > reporte_juan$total_ventas &
    reporte_ana$total_ventas > reporte_maria$total_ventas) {
  mejor <- reporte_ana$nombre
} else if (reporte_juan$total_ventas > reporte_maria$total_ventas) {
  mejor <- reporte_juan$nombre
} else {
  mejor <- reporte_maria$nombre
}

cat("\n¡El mejor vendedor del mes es:", mejor, "!\n")
