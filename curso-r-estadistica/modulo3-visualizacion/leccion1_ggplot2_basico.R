# =============================================================================
# MÓDULO 3: VISUALIZACIÓN DE DATOS
# Lección 1: ggplot2 - Fundamentos de visualización
# =============================================================================

# ggplot2 es el sistema de visualización más poderoso de R
# Basado en la "Grammar of Graphics"
# Componentes: datos + geometrías + estéticas + temas

# CONTENIDO:
# 1. Estructura básica de ggplot2
# 2. Gráficos de dispersión (scatter plots)
# 3. Gráficos de líneas
# 4. Gráficos de barras
# 5. Histogramas y densidad
# 6. Boxplots

# =============================================================================
# INSTALACIÓN Y CARGA
# =============================================================================

# install.packages("ggplot2")  # Descomenta si no lo tienes
library(ggplot2)
library(dplyr)

# =============================================================================
# 1. ESTRUCTURA BÁSICA DE GGPLOT2
# =============================================================================

# Estructura básica:
# ggplot(data = datos, aes(x = variable_x, y = variable_y)) +
#   geom_tipo_grafico()

# Crear datos de ejemplo
datos_ejemplo <- data.frame(
  x = 1:10,
  y = c(2, 4, 3, 5, 7, 6, 8, 9, 10, 11)
)

# Gráfico básico
ggplot(data = datos_ejemplo, aes(x = x, y = y)) +
  geom_point()  # Gráfico de puntos

# Guardar la gráfica
grafica <- ggplot(data = datos_ejemplo, aes(x = x, y = y)) +
  geom_point()
print(grafica)

# Guardar la gráfica en un archivo
# ggsave("mi_grafica.png", width = 8, height = 6)

# =============================================================================
# 2. GRÁFICOS DE DISPERSIÓN (SCATTER PLOTS)
# =============================================================================

# Datos de ejemplo: relación entre precio y ventas
productos <- data.frame(
  producto = paste("Prod", 1:20),
  precio = c(100, 150, 200, 250, 300, 120, 180, 220, 280, 320,
             110, 160, 210, 260, 310, 130, 190, 230, 290, 330),
  ventas = c(95, 85, 75, 65, 55, 92, 82, 72, 62, 52,
             94, 84, 74, 64, 54, 91, 81, 71, 61, 51),
  categoria = rep(c("A", "B", "C", "D"), each = 5)
)

# Gráfico de dispersión básico
ggplot(productos, aes(x = precio, y = ventas)) +
  geom_point()

# Agregar color por categoría
ggplot(productos, aes(x = precio, y = ventas, color = categoria)) +
  geom_point()

# Cambiar tamaño de puntos
ggplot(productos, aes(x = precio, y = ventas, color = categoria)) +
  geom_point(size = 3)

# Cambiar forma de puntos
ggplot(productos, aes(x = precio, y = ventas, color = categoria)) +
  geom_point(size = 3, shape = 17)  # 17 = triángulos

# Agregar línea de tendencia
ggplot(productos, aes(x = precio, y = ventas)) +
  geom_point(size = 3, color = "steelblue") +
  geom_smooth(method = "lm", se = TRUE, color = "red")  # lm = linear model

# Agregar títulos y etiquetas
ggplot(productos, aes(x = precio, y = ventas)) +
  geom_point(size = 3, color = "steelblue") +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(
    title = "Relación entre Precio y Ventas",
    subtitle = "Datos ficticios de productos",
    x = "Precio (MXN)",
    y = "Unidades Vendidas",
    caption = "Fuente: Datos de ejemplo"
  )

# EJERCICIO 1: Crea un gráfico de dispersión
# Usa el dataset mtcars (viene incluido en R)
# Grafica mpg (millas por galón) vs hp (caballos de fuerza)
# Colorea por número de cilindros (cyl)
# Tu código aquí:
# head(mtcars)  # Ver los datos




# =============================================================================
# 3. GRÁFICOS DE LÍNEAS
# =============================================================================

# Datos de series de tiempo
ventas_tiempo <- data.frame(
  mes = 1:12,
  ventas_2023 = c(100, 110, 105, 120, 130, 125, 140, 145, 150, 155, 160, 170),
  ventas_2024 = c(105, 115, 110, 125, 135, 132, 148, 152, 158, 163, 168, 180)
)

# Gráfico de líneas simple
ggplot(ventas_tiempo, aes(x = mes, y = ventas_2023)) +
  geom_line()

# Línea con puntos
ggplot(ventas_tiempo, aes(x = mes, y = ventas_2023)) +
  geom_line(color = "blue", size = 1) +
  geom_point(color = "blue", size = 3)

# Múltiples líneas - necesitamos formato largo
library(tidyr)
ventas_largo <- ventas_tiempo %>%
  pivot_longer(
    cols = c(ventas_2023, ventas_2024),
    names_to = "año",
    values_to = "ventas"
  )

# Gráfico con múltiples líneas
ggplot(ventas_largo, aes(x = mes, y = ventas, color = año)) +
  geom_line(size = 1) +
  geom_point(size = 2) +
  labs(
    title = "Comparación de Ventas 2023 vs 2024",
    x = "Mes",
    y = "Ventas",
    color = "Año"
  ) +
  scale_x_continuous(breaks = 1:12) +
  theme_minimal()

# EJERCICIO 2: Crea un gráfico de líneas
# Usa el dataset EuStockMarkets (viene en R)
# Convierte a data frame y grafica al menos 2 mercados
# Tu código aquí:
# head(EuStockMarkets)




# =============================================================================
# 4. GRÁFICOS DE BARRAS
# =============================================================================

# Datos de ventas por categoría
ventas_cat <- data.frame(
  categoria = c("Electrónica", "Ropa", "Alimentos", "Hogar", "Deportes"),
  ventas = c(45000, 32000, 28000, 19000, 15000)
)

# Gráfico de barras vertical
ggplot(ventas_cat, aes(x = categoria, y = ventas)) +
  geom_col(fill = "steelblue")

# Gráfico de barras horizontal
ggplot(ventas_cat, aes(x = ventas, y = categoria)) +
  geom_col(fill = "coral")

# Ordenar barras por valor
ggplot(ventas_cat, aes(x = reorder(categoria, ventas), y = ventas)) +
  geom_col(fill = "steelblue") +
  coord_flip() +  # Voltear coordenadas
  labs(
    title = "Ventas por Categoría",
    x = "Categoría",
    y = "Ventas (MXN)"
  )

# Barras con diferentes colores
ggplot(ventas_cat, aes(x = reorder(categoria, -ventas), y = ventas, fill = categoria)) +
  geom_col() +
  labs(
    title = "Ventas por Categoría",
    x = "Categoría",
    y = "Ventas (MXN)"
  ) +
  theme_minimal() +
  theme(legend.position = "none")  # Ocultar leyenda

# Barras agrupadas
ventas_mes_cat <- data.frame(
  mes = rep(c("Enero", "Febrero", "Marzo"), each = 3),
  categoria = rep(c("A", "B", "C"), 3),
  ventas = c(100, 120, 110, 105, 125, 115, 110, 130, 120)
)

ggplot(ventas_mes_cat, aes(x = mes, y = ventas, fill = categoria)) +
  geom_col(position = "dodge") +  # dodge = lado a lado
  labs(
    title = "Ventas Mensuales por Categoría",
    x = "Mes",
    y = "Ventas"
  )

# Barras apiladas
ggplot(ventas_mes_cat, aes(x = mes, y = ventas, fill = categoria)) +
  geom_col(position = "stack") +
  labs(
    title = "Ventas Mensuales por Categoría (Apiladas)",
    x = "Mes",
    y = "Ventas Totales"
  )

# EJERCICIO 3: Crea un gráfico de barras
# Cuenta cuántos autos hay por número de cilindros en mtcars
# Crea un gráfico de barras ordenado de mayor a menor
# Tu código aquí:




# =============================================================================
# 5. HISTOGRAMAS Y DENSIDAD
# =============================================================================

# Generar datos aleatorios
set.seed(123)
datos_dist <- data.frame(
  valores = rnorm(1000, mean = 50, sd = 10)  # 1000 valores normales
)

# Histograma básico
ggplot(datos_dist, aes(x = valores)) +
  geom_histogram()

# Histograma con más control
ggplot(datos_dist, aes(x = valores)) +
  geom_histogram(
    bins = 30,              # Número de bins
    fill = "steelblue",
    color = "white"
  ) +
  labs(
    title = "Distribución de Valores",
    x = "Valor",
    y = "Frecuencia"
  )

# Gráfico de densidad
ggplot(datos_dist, aes(x = valores)) +
  geom_density(fill = "coral", alpha = 0.5) +
  labs(
    title = "Densidad de Valores",
    x = "Valor",
    y = "Densidad"
  )

# Combinar histograma y densidad
ggplot(datos_dist, aes(x = valores)) +
  geom_histogram(aes(y = after_stat(density)), bins = 30, fill = "steelblue", alpha = 0.5) +
  geom_density(color = "red", size = 1) +
  labs(
    title = "Histograma con Curva de Densidad",
    x = "Valor",
    y = "Densidad"
  )

# EJERCICIO 4: Crea un histograma
# Usa la columna mpg del dataset mtcars
# Crea un histograma con 15 bins
# Tu código aquí:




# =============================================================================
# 6. BOXPLOTS (DIAGRAMAS DE CAJA)
# =============================================================================

# Datos de calificaciones por grupo
calificaciones <- data.frame(
  grupo = rep(c("A", "B", "C", "D"), each = 25),
  calificacion = c(
    rnorm(25, mean = 75, sd = 8),
    rnorm(25, mean = 82, sd = 7),
    rnorm(25, mean = 68, sd = 10),
    rnorm(25, mean = 85, sd = 6)
  )
)

# Boxplot básico
ggplot(calificaciones, aes(x = grupo, y = calificacion)) +
  geom_boxplot()

# Boxplot con colores
ggplot(calificaciones, aes(x = grupo, y = calificacion, fill = grupo)) +
  geom_boxplot() +
  labs(
    title = "Calificaciones por Grupo",
    x = "Grupo",
    y = "Calificación"
  ) +
  theme_minimal()

# Boxplot con puntos individuales
ggplot(calificaciones, aes(x = grupo, y = calificacion, fill = grupo)) +
  geom_boxplot(alpha = 0.7) +
  geom_jitter(width = 0.2, alpha = 0.3) +  # Agregar puntos
  labs(
    title = "Calificaciones por Grupo con Datos Individuales",
    x = "Grupo",
    y = "Calificación"
  )

# Boxplot horizontal
ggplot(calificaciones, aes(x = calificacion, y = grupo, fill = grupo)) +
  geom_boxplot() +
  labs(
    title = "Calificaciones por Grupo (Horizontal)",
    x = "Calificación",
    y = "Grupo"
  )

# EJERCICIO 5: Crea un boxplot
# Usa el dataset iris (viene en R)
# Crea un boxplot de Sepal.Length por Species
# Tu código aquí:
# head(iris)




# =============================================================================
# EJEMPLO PRÁCTICO COMPLETO: DASHBOARD DE VENTAS
# =============================================================================

# Datos de ventas
set.seed(42)
ventas_completas <- data.frame(
  fecha = seq.Date(from = as.Date("2024-01-01"), to = as.Date("2024-12-31"), by = "day"),
  ventas = abs(rnorm(365, mean = 10000, sd = 2000)),
  categoria = sample(c("Electrónica", "Ropa", "Alimentos"), 365, replace = TRUE),
  region = sample(c("Norte", "Sur", "Este", "Oeste"), 365, replace = TRUE)
)

ventas_completas <- ventas_completas %>%
  mutate(mes = format(fecha, "%m"))

# 1. Evolución temporal de ventas
p1 <- ventas_completas %>%
  group_by(fecha) %>%
  summarise(ventas_totales = sum(ventas)) %>%
  ggplot(aes(x = fecha, y = ventas_totales)) +
  geom_line(color = "steelblue", size = 0.8) +
  geom_smooth(method = "loess", color = "red", se = FALSE) +
  labs(
    title = "Evolución de Ventas Diarias 2024",
    x = "Fecha",
    y = "Ventas (MXN)"
  ) +
  theme_minimal()

print(p1)

# 2. Ventas por categoría
p2 <- ventas_completas %>%
  group_by(categoria) %>%
  summarise(total = sum(ventas)) %>%
  ggplot(aes(x = reorder(categoria, -total), y = total, fill = categoria)) +
  geom_col() +
  labs(
    title = "Ventas Totales por Categoría",
    x = "Categoría",
    y = "Ventas Totales (MXN)"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

print(p2)

# 3. Distribución de ventas diarias
p3 <- ggplot(ventas_completas, aes(x = ventas)) +
  geom_histogram(bins = 40, fill = "coral", color = "white", alpha = 0.7) +
  geom_density(aes(y = after_stat(density) * 2000), color = "darkred", size = 1) +
  labs(
    title = "Distribución de Ventas Diarias",
    x = "Ventas (MXN)",
    y = "Frecuencia"
  ) +
  theme_minimal()

print(p3)

# 4. Comparación por región
p4 <- ventas_completas %>%
  ggplot(aes(x = region, y = ventas, fill = region)) +
  geom_boxplot() +
  labs(
    title = "Comparación de Ventas por Región",
    x = "Región",
    y = "Ventas (MXN)"
  ) +
  theme_minimal()

print(p4)

# =============================================================================
# RESUMEN DE LA LECCIÓN
# =============================================================================
# ✓ ggplot2: sistema de gráficos basado en capas
# ✓ geom_point(): gráficos de dispersión
# ✓ geom_line(): gráficos de líneas
# ✓ geom_col(): gráficos de barras
# ✓ geom_histogram(): histogramas
# ✓ geom_boxplot(): diagramas de caja
# ✓ labs(): títulos y etiquetas
# ✓ theme_*(): temas visuales

# =============================================================================
# ¡Felicidades! Has completado la Lección 1 del Módulo 3
# Continúa con el Módulo 4 - Estadística
# =============================================================================
