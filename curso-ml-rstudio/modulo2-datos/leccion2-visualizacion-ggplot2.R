# ============================================================================
# MÓDULO 2 - LECCIÓN 2: VISUALIZACIÓN DE DATOS CON GGPLOT2
# ============================================================================
# Descripción: Aprenderás a crear visualizaciones profesionales con ggplot2,
#              esencial para análisis exploratorio antes de aplicar ML
# Nivel: Intermedio
# Duración estimada: 5-6 horas
# Prerequisito: Módulo 1 y Lección 1 del Módulo 2
# ============================================================================

# Cargar librerías necesarias
# install.packages(c("ggplot2", "dplyr", "scales", "RColorBrewer"))

library(ggplot2)
library(dplyr)
library(scales)  # Para formatear ejes

cat("=== VISUALIZACIÓN DE DATOS CON GGPLOT2 ===\n\n")

# ----------------------------------------------------------------------------
# SECCIÓN 1: INTRODUCCIÓN A GGPLOT2
# ----------------------------------------------------------------------------

# ggplot2 se basa en "Grammar of Graphics"
# Estructura básica:
# ggplot(data, aes(x, y, ...)) + geom_*() + opciones

# Componentes principales:
# 1. Data: El dataset
# 2. Aesthetics (aes): Mapeo de variables a propiedades visuales
# 3. Geometries (geom): Tipo de gráfica
# 4. Themes: Apariencia visual
# 5. Scales: Control de ejes y leyendas
# 6. Facets: Paneles múltiples

# ----------------------------------------------------------------------------
# SECCIÓN 2: DATOS DE EJEMPLO
# ----------------------------------------------------------------------------

# Crear dataset de ventas completo
set.seed(42)
ventas <- data.frame(
  id = 1:100,
  fecha = seq(as.Date("2025-01-01"), by = "day", length.out = 100),
  producto = sample(c("Laptop", "Monitor", "Mouse", "Teclado", "Webcam"),
                   100, replace = TRUE),
  categoria = sample(c("Computadoras", "Accesorios", "Periféricos"),
                    100, replace = TRUE),
  vendedor = sample(c("Ana", "Luis", "Carlos", "María", "Pedro"),
                   100, replace = TRUE),
  region = sample(c("Norte", "Sur", "Centro", "Este", "Oeste"),
                 100, replace = TRUE),
  cantidad = sample(1:10, 100, replace = TRUE),
  precio_unitario = sample(c(250, 800, 1200, 5000, 15000),
                          100, replace = TRUE),
  stringsAsFactors = FALSE
)

ventas <- ventas %>%
  mutate(
    total = cantidad * precio_unitario,
    mes = format(fecha, "%Y-%m"),
    dia_semana = weekdays(fecha)
  )

# ----------------------------------------------------------------------------
# SECCIÓN 3: GRÁFICOS DE DISPERSIÓN (SCATTER PLOTS)
# ----------------------------------------------------------------------------

cat("=== GRÁFICOS DE DISPERSIÓN ===\n\n")

# Gráfico básico
# Relación entre cantidad y total
ggplot(ventas, aes(x = cantidad, y = total)) +
  geom_point()

# Con color por categoría
ggplot(ventas, aes(x = cantidad, y = total, color = region)) +
  geom_point() +
  labs(
    title = "Relación entre Cantidad y Total de Venta",
    subtitle = "Por Región",
    x = "Cantidad de Productos",
    y = "Total de Venta ($)",
    color = "Región"
  ) +
  theme_minimal()

# Con tamaño por otra variable
ggplot(ventas, aes(x = cantidad, y = total, color = region, size = precio_unitario)) +
  geom_point(alpha = 0.6) +  # alpha para transparencia
  labs(
    title = "Análisis Multivariado de Ventas",
    x = "Cantidad",
    y = "Total ($)",
    color = "Región",
    size = "Precio Unitario"
  ) +
  theme_minimal()

# Con forma diferente por categoría
ggplot(ventas, aes(x = cantidad, y = total, color = region, shape = categoria)) +
  geom_point(size = 3, alpha = 0.7) +
  theme_minimal()

# Agregar línea de tendencia
ggplot(ventas, aes(x = cantidad, y = total)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", se = TRUE, color = "blue") +  # se = intervalo de confianza
  labs(
    title = "Relación Cantidad vs Total con Línea de Tendencia",
    x = "Cantidad",
    y = "Total ($)"
  ) +
  theme_minimal()

# Línea de tendencia no lineal (loess)
ggplot(ventas, aes(x = cantidad, y = total)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "loess", color = "red") +
  theme_minimal()

# ----------------------------------------------------------------------------
# SECCIÓN 4: GRÁFICOS DE BARRAS
# ----------------------------------------------------------------------------

cat("\n=== GRÁFICOS DE BARRAS ===\n\n")

# Contar ventas por producto
ventas_por_producto <- ventas %>%
  count(producto, name = "num_ventas")

# Gráfico de barras básico
ggplot(ventas_por_producto, aes(x = producto, y = num_ventas)) +
  geom_col(fill = "steelblue") +
  labs(
    title = "Número de Ventas por Producto",
    x = "Producto",
    y = "Número de Ventas"
  ) +
  theme_minimal()

# Con colores diferentes
ggplot(ventas_por_producto, aes(x = producto, y = num_ventas, fill = producto)) +
  geom_col() +
  labs(title = "Ventas por Producto") +
  theme_minimal() +
  theme(legend.position = "none")  # Ocultar leyenda redundante

# Ordenar barras
ggplot(ventas_por_producto, aes(x = reorder(producto, num_ventas), y = num_ventas)) +
  geom_col(fill = "darkgreen") +
  coord_flip() +  # Barras horizontales
  labs(
    title = "Productos Más Vendidos",
    x = "Producto",
    y = "Número de Ventas"
  ) +
  theme_minimal()

# Barras agrupadas
ventas_region_producto <- ventas %>%
  group_by(region, producto) %>%
  summarize(total_ventas = sum(total), .groups = "drop")

ggplot(ventas_region_producto, aes(x = region, y = total_ventas, fill = producto)) +
  geom_col(position = "dodge") +  # position = "dodge" para agrupar
  labs(
    title = "Ventas por Región y Producto",
    x = "Región",
    y = "Total Ventas ($)",
    fill = "Producto"
  ) +
  theme_minimal() +
  scale_y_continuous(labels = comma)  # Formato con comas

# Barras apiladas
ggplot(ventas_region_producto, aes(x = region, y = total_ventas, fill = producto)) +
  geom_col(position = "stack") +  # position = "stack" para apilar
  labs(
    title = "Composición de Ventas por Región",
    x = "Región",
    y = "Total Ventas ($)",
    fill = "Producto"
  ) +
  theme_minimal()

# Barras apiladas al 100%
ggplot(ventas_region_producto, aes(x = region, y = total_ventas, fill = producto)) +
  geom_col(position = "fill") +
  labs(
    title = "Proporción de Ventas por Región",
    x = "Región",
    y = "Proporción",
    fill = "Producto"
  ) +
  theme_minimal() +
  scale_y_continuous(labels = percent)

# ----------------------------------------------------------------------------
# SECCIÓN 5: HISTOGRAMAS Y DISTRIBUCIONES
# ----------------------------------------------------------------------------

cat("\n=== HISTOGRAMAS ===\n\n")

# Histograma básico
ggplot(ventas, aes(x = total)) +
  geom_histogram(bins = 30, fill = "steelblue", color = "white") +
  labs(
    title = "Distribución de Totales de Venta",
    x = "Total ($)",
    y = "Frecuencia"
  ) +
  theme_minimal()

# Histograma con densidad
ggplot(ventas, aes(x = total)) +
  geom_histogram(aes(y = after_stat(density)), bins = 30,
                fill = "lightblue", color = "white") +
  geom_density(alpha = 0.5, fill = "red") +
  labs(
    title = "Distribución de Ventas con Curva de Densidad",
    x = "Total ($)",
    y = "Densidad"
  ) +
  theme_minimal()

# Múltiples histogramas
ggplot(ventas, aes(x = total, fill = region)) +
  geom_histogram(bins = 20, alpha = 0.6, position = "identity") +
  labs(
    title = "Distribución de Ventas por Región",
    x = "Total ($)",
    y = "Frecuencia"
  ) +
  theme_minimal()

# Curva de densidad
ggplot(ventas, aes(x = total, fill = region)) +
  geom_density(alpha = 0.5) +
  labs(
    title = "Densidad de Ventas por Región",
    x = "Total ($)",
    y = "Densidad"
  ) +
  theme_minimal()

# ----------------------------------------------------------------------------
# SECCIÓN 6: BOX PLOTS (DIAGRAMAS DE CAJA)
# ----------------------------------------------------------------------------

cat("\n=== BOX PLOTS ===\n\n")

# Box plot básico
ggplot(ventas, aes(x = producto, y = total)) +
  geom_boxplot(fill = "lightblue") +
  labs(
    title = "Distribución de Ventas por Producto",
    x = "Producto",
    y = "Total ($)"
  ) +
  theme_minimal()

# Box plot con colores
ggplot(ventas, aes(x = producto, y = total, fill = producto)) +
  geom_boxplot() +
  labs(
    title = "Distribución de Ventas por Producto",
    x = "Producto",
    y = "Total ($)"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

# Box plot con puntos
ggplot(ventas, aes(x = producto, y = total, fill = producto)) +
  geom_boxplot(alpha = 0.7) +
  geom_jitter(width = 0.2, alpha = 0.3) +  # Agregar puntos con jitter
  labs(
    title = "Distribución de Ventas (con datos individuales)",
    x = "Producto",
    y = "Total ($)"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

# Box plot horizontal
ggplot(ventas, aes(x = total, y = reorder(producto, total, median))) +
  geom_boxplot(fill = "steelblue") +
  labs(
    title = "Distribución de Ventas por Producto",
    x = "Total ($)",
    y = "Producto"
  ) +
  theme_minimal()

# Violin plot (variante del box plot)
ggplot(ventas, aes(x = producto, y = total, fill = producto)) +
  geom_violin() +
  geom_boxplot(width = 0.1, fill = "white", alpha = 0.8) +
  labs(
    title = "Violin Plot de Ventas por Producto",
    x = "Producto",
    y = "Total ($)"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

# ----------------------------------------------------------------------------
# SECCIÓN 7: GRÁFICOS DE LÍNEA (SERIES DE TIEMPO)
# ----------------------------------------------------------------------------

cat("\n=== GRÁFICOS DE LÍNEA ===\n\n")

# Ventas diarias totales
ventas_diarias <- ventas %>%
  group_by(fecha) %>%
  summarize(total_dia = sum(total))

ggplot(ventas_diarias, aes(x = fecha, y = total_dia)) +
  geom_line(color = "blue", size = 1) +
  geom_point(color = "red", size = 2) +
  labs(
    title = "Evolución de Ventas Diarias",
    x = "Fecha",
    y = "Total Ventas ($)"
  ) +
  theme_minimal() +
  scale_y_continuous(labels = comma)

# Múltiples líneas (por región)
ventas_diarias_region <- ventas %>%
  group_by(fecha, region) %>%
  summarize(total_dia = sum(total), .groups = "drop")

ggplot(ventas_diarias_region, aes(x = fecha, y = total_dia, color = region)) +
  geom_line(size = 1) +
  labs(
    title = "Evolución de Ventas por Región",
    x = "Fecha",
    y = "Total Ventas ($)",
    color = "Región"
  ) +
  theme_minimal()

# Con áreas sombreadas
ggplot(ventas_diarias, aes(x = fecha, y = total_dia)) +
  geom_area(fill = "lightblue", alpha = 0.5) +
  geom_line(color = "blue", size = 1) +
  labs(
    title = "Área de Ventas Diarias",
    x = "Fecha",
    y = "Total Ventas ($)"
  ) +
  theme_minimal()

# ----------------------------------------------------------------------------
# SECCIÓN 8: FACETAS (PANELES MÚLTIPLES)
# ----------------------------------------------------------------------------

cat("\n=== FACETAS ===\n\n")

# facet_wrap() - Una variable
ggplot(ventas, aes(x = cantidad, y = total)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = FALSE) +
  facet_wrap(~region) +
  labs(
    title = "Relación Cantidad-Total por Región",
    x = "Cantidad",
    y = "Total ($)"
  ) +
  theme_minimal()

# facet_grid() - Dos variables
ggplot(ventas, aes(x = cantidad, y = total)) +
  geom_point(alpha = 0.5) +
  facet_grid(region ~ categoria) +
  labs(
    title = "Análisis por Región y Categoría",
    x = "Cantidad",
    y = "Total ($)"
  ) +
  theme_minimal()

# Histogramas facetados
ggplot(ventas, aes(x = total, fill = producto)) +
  geom_histogram(bins = 20) +
  facet_wrap(~producto, scales = "free_y") +  # scales libres en y
  theme_minimal() +
  theme(legend.position = "none")

# ----------------------------------------------------------------------------
# SECCIÓN 9: TEMAS Y PERSONALIZACIÓN
# ----------------------------------------------------------------------------

cat("\n=== PERSONALIZACIÓN ===\n\n")

# Temas predefinidos
p <- ggplot(ventas_por_producto, aes(x = reorder(producto, num_ventas),
                                     y = num_ventas, fill = producto)) +
  geom_col() +
  labs(title = "Ventas por Producto") +
  theme(legend.position = "none")

# theme_minimal()
p + theme_minimal() + ggtitle("Theme Minimal")

# theme_classic()
p + theme_classic() + ggtitle("Theme Classic")

# theme_bw()
p + theme_bw() + ggtitle("Theme BW")

# theme_dark()
p + theme_dark() + ggtitle("Theme Dark")

# Personalización completa
ggplot(ventas_por_producto, aes(x = reorder(producto, num_ventas),
                                y = num_ventas, fill = producto)) +
  geom_col() +
  labs(
    title = "Análisis de Ventas por Producto",
    subtitle = "Periodo: Enero 2025",
    x = "Producto",
    y = "Número de Ventas",
    caption = "Fuente: Sistema de Ventas"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 12, hjust = 0.5),
    axis.title = element_text(size = 12, face = "bold"),
    axis.text = element_text(size = 10),
    legend.position = "none",
    panel.grid.major.x = element_blank()
  )

# ----------------------------------------------------------------------------
# SECCIÓN 10: ESCALAS Y COLORES
# ----------------------------------------------------------------------------

cat("\n=== ESCALAS Y COLORES ===\n\n")

# Colores manuales
ggplot(ventas_por_producto, aes(x = producto, y = num_ventas, fill = producto)) +
  geom_col() +
  scale_fill_manual(values = c(
    "Laptop" = "#FF6B6B",
    "Monitor" = "#4ECDC4",
    "Mouse" = "#45B7D1",
    "Teclado" = "#FFA07A",
    "Webcam" = "#98D8C8"
  )) +
  theme_minimal() +
  theme(legend.position = "none")

# Paletas de colores predefinidas (RColorBrewer)
ggplot(ventas_region_producto, aes(x = region, y = total_ventas, fill = producto)) +
  geom_col(position = "dodge") +
  scale_fill_brewer(palette = "Set2") +
  theme_minimal()

# Escala de colores continua
ventas_promedio <- ventas %>%
  group_by(producto, region) %>%
  summarize(promedio = mean(total), .groups = "drop")

ggplot(ventas_promedio, aes(x = region, y = producto, fill = promedio)) +
  geom_tile(color = "white") +  # Heatmap
  scale_fill_gradient(low = "lightblue", high = "darkblue") +
  labs(
    title = "Heatmap de Ventas Promedio",
    x = "Región",
    y = "Producto",
    fill = "Promedio ($)"
  ) +
  theme_minimal()

# Escala divergente
ggplot(ventas_promedio, aes(x = region, y = producto, fill = promedio)) +
  geom_tile(color = "white") +
  scale_fill_gradient2(
    low = "blue",
    mid = "white",
    high = "red",
    midpoint = median(ventas_promedio$promedio)
  ) +
  theme_minimal()

# ----------------------------------------------------------------------------
# SECCIÓN 11: GRÁFICOS AVANZADOS
# ----------------------------------------------------------------------------

cat("\n=== GRÁFICOS AVANZADOS ===\n\n")

# Correlación con ggplot
# Crear matriz de correlación
datos_numericos <- ventas %>%
  select(cantidad, precio_unitario, total) %>%
  cor()

# Convertir a formato long para ggplot
library(reshape2)  # Para melt
datos_cor <- melt(datos_numericos)

ggplot(datos_cor, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile(color = "white") +
  geom_text(aes(label = round(value, 2)), color = "black", size = 5) +
  scale_fill_gradient2(
    low = "blue",
    mid = "white",
    high = "red",
    midpoint = 0,
    limits = c(-1, 1)
  ) +
  labs(
    title = "Matriz de Correlación",
    x = "",
    y = "",
    fill = "Correlación"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Gráfico de pirámide (ventas por vendedor)
ventas_vendedor <- ventas %>%
  group_by(vendedor) %>%
  summarize(
    ventas_positivas = sum(total[total > 5000]),
    ventas_bajas = sum(total[total <= 5000])
  )

# ----------------------------------------------------------------------------
# SECCIÓN 12: GUARDAR GRÁFICOS
# ----------------------------------------------------------------------------

# Crear un gráfico
plot_final <- ggplot(ventas_diarias, aes(x = fecha, y = total_dia)) +
  geom_line(color = "blue", size = 1.2) +
  geom_point(color = "red", size = 2) +
  labs(
    title = "Evolución de Ventas Diarias",
    subtitle = "Periodo: Enero-Abril 2025",
    x = "Fecha",
    y = "Total Ventas ($)",
    caption = "Fuente: Sistema de Ventas"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold"),
    plot.subtitle = element_text(size = 12)
  )

# Guardar gráfico
# ggsave("ventas_diarias.png", plot_final, width = 10, height = 6, dpi = 300)
# ggsave("ventas_diarias.pdf", plot_final, width = 10, height = 6)

# ----------------------------------------------------------------------------
# SECCIÓN 13: EJERCICIOS PRÁCTICOS
# ----------------------------------------------------------------------------

cat("\n=== EJERCICIOS PRÁCTICOS ===\n\n")

# EJERCICIO 1: Crear gráfico de barras de top 5 vendedores
cat("EJERCICIO 1: Top 5 vendedores\n")

top_vendedores <- ventas %>%
  group_by(vendedor) %>%
  summarize(total_ventas = sum(total)) %>%
  top_n(5, total_ventas) %>%
  arrange(desc(total_ventas))

ggplot(top_vendedores, aes(x = reorder(vendedor, total_ventas),
                           y = total_ventas, fill = vendedor)) +
  geom_col() +
  coord_flip() +
  scale_y_continuous(labels = comma) +
  labs(
    title = "Top 5 Vendedores por Total de Ventas",
    x = "Vendedor",
    y = "Total Ventas ($)"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

# EJERCICIO 2: Comparar distribución de ventas entre regiones
cat("\n\nEJERCICIO 2: Distribución por regiones\n")

ggplot(ventas, aes(x = total, fill = region)) +
  geom_density(alpha = 0.6) +
  facet_wrap(~region, ncol = 2) +
  labs(
    title = "Distribución de Ventas por Región",
    x = "Total ($)",
    y = "Densidad"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

# EJERCICIO 3: Evolución temporal por producto
cat("\n\nEJERCICIO 3: Evolución temporal\n")

ventas_producto_tiempo <- ventas %>%
  group_by(fecha, producto) %>%
  summarize(total_dia = sum(total), .groups = "drop")

ggplot(ventas_producto_tiempo, aes(x = fecha, y = total_dia, color = producto)) +
  geom_smooth(se = FALSE, size = 1.2) +
  labs(
    title = "Tendencia de Ventas por Producto",
    x = "Fecha",
    y = "Total Ventas ($)",
    color = "Producto"
  ) +
  theme_minimal()

# ----------------------------------------------------------------------------
# RESUMEN
# ----------------------------------------------------------------------------

cat("\n=== RESUMEN DE LA LECCIÓN ===\n")
cat("Aprendiste a crear:\n")
cat("✓ Gráficos de dispersión\n")
cat("✓ Gráficos de barras (simples, agrupadas, apiladas)\n")
cat("✓ Histogramas y curvas de densidad\n")
cat("✓ Box plots y violin plots\n")
cat("✓ Gráficos de línea (series de tiempo)\n")
cat("✓ Facetas para paneles múltiples\n")
cat("✓ Personalización de temas y colores\n")
cat("✓ Heatmaps y gráficos avanzados\n")
cat("\nLa visualización es CRUCIAL para:\n")
cat("- Análisis exploratorio de datos (EDA)\n")
cat("- Detectar patrones y outliers\n")
cat("- Validar supuestos antes de ML\n")
cat("- Comunicar resultados\n")
cat("\nSiguiente: Módulo 3 - Estadística para ML\n")

# ============================================================================
# FIN DE LA LECCIÓN
# ============================================================================
