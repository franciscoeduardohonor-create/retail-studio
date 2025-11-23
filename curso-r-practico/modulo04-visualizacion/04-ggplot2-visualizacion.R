# ============================================================================
# MÓDULO 4: VISUALIZACIÓN DE DATOS CON GGPLOT2
# ============================================================================
# Aprenderás a crear gráficos profesionales con ggplot2

# Instalar y cargar ggplot2 (solo necesitas instalar una vez)
# install.packages("ggplot2")
library(ggplot2)

# ============================================================================
# 1. GRAMÁTICA DE GRÁFICOS - CONCEPTOS BÁSICOS
# ============================================================================

# ggplot2 usa una "gramática de gráficos":
# - Datos (data)
# - Estética (aes): qué variables van en x, y, color, etc.
# - Geometría (geom): tipo de gráfico (puntos, líneas, barras, etc.)

# Crear datos de ejemplo
ventas_df <- data.frame(
  mes = c("Ene", "Feb", "Mar", "Abr", "May", "Jun"),
  ventas = c(1200, 1500, 1800, 1400, 2100, 2300),
  gastos = c(800, 950, 1100, 900, 1300, 1400)
)

# ============================================================================
# 2. GRÁFICO DE DISPERSIÓN (SCATTER PLOT)
# ============================================================================

# Datos de ejemplo
datos_scatter <- data.frame(
  experiencia = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10),
  salario = c(30, 32, 35, 38, 42, 45, 48, 52, 55, 60)
)

# Gráfico básico
ggplot(datos_scatter, aes(x = experiencia, y = salario)) +
  geom_point()

# Mejorado con estilo
ggplot(datos_scatter, aes(x = experiencia, y = salario)) +
  geom_point(color = "blue", size = 3) +
  labs(title = "Relación entre Experiencia y Salario",
       x = "Años de Experiencia",
       y = "Salario (miles)") +
  theme_minimal()

# Con línea de tendencia
ggplot(datos_scatter, aes(x = experiencia, y = salario)) +
  geom_point(color = "blue", size = 3) +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Experiencia vs Salario") +
  theme_minimal()

# ============================================================================
# 3. GRÁFICO DE BARRAS
# ============================================================================

# Gráfico de barras simple
ggplot(ventas_df, aes(x = mes, y = ventas)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Ventas Mensuales",
       x = "Mes",
       y = "Ventas ($)") +
  theme_minimal()

# Con colores diferentes por barra
ggplot(ventas_df, aes(x = mes, y = ventas, fill = mes)) +
  geom_bar(stat = "identity") +
  labs(title = "Ventas Mensuales") +
  theme_minimal() +
  theme(legend.position = "none")

# Barras agrupadas
library(tidyr)
ventas_long <- pivot_longer(ventas_df,
                            cols = c(ventas, gastos),
                            names_to = "tipo",
                            values_to = "monto")

ggplot(ventas_long, aes(x = mes, y = monto, fill = tipo)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Ventas y Gastos Mensuales") +
  scale_fill_manual(values = c("ventas" = "green", "gastos" = "red")) +
  theme_minimal()

# ============================================================================
# 4. GRÁFICO DE LÍNEAS
# ============================================================================

# Línea simple
ggplot(ventas_df, aes(x = mes, y = ventas, group = 1)) +
  geom_line(color = "blue", size = 1) +
  geom_point(color = "red", size = 3) +
  labs(title = "Tendencia de Ventas",
       x = "Mes",
       y = "Ventas") +
  theme_minimal()

# Múltiples líneas
ggplot(ventas_long, aes(x = mes, y = monto, color = tipo, group = tipo)) +
  geom_line(size = 1) +
  geom_point(size = 2) +
  labs(title = "Ventas vs Gastos") +
  theme_minimal()

# ============================================================================
# 5. HISTOGRAMA
# ============================================================================

# Datos de ejemplo
set.seed(123)
alturas <- data.frame(altura = rnorm(1000, mean = 170, sd = 10))

# Histograma básico
ggplot(alturas, aes(x = altura)) +
  geom_histogram(bins = 30, fill = "skyblue", color = "black") +
  labs(title = "Distribución de Alturas",
       x = "Altura (cm)",
       y = "Frecuencia") +
  theme_minimal()

# Con densidad
ggplot(alturas, aes(x = altura)) +
  geom_histogram(aes(y = ..density..), bins = 30,
                 fill = "lightblue", color = "black") +
  geom_density(color = "red", size = 1) +
  labs(title = "Distribución de Alturas") +
  theme_minimal()

# ============================================================================
# 6. BOX PLOT (DIAGRAMA DE CAJAS)
# ============================================================================

# Datos de calificaciones por grupo
calificaciones <- data.frame(
  grupo = rep(c("A", "B", "C"), each = 20),
  calificacion = c(rnorm(20, 85, 5), rnorm(20, 75, 8), rnorm(20, 80, 6))
)

# Box plot
ggplot(calificaciones, aes(x = grupo, y = calificacion, fill = grupo)) +
  geom_boxplot() +
  labs(title = "Calificaciones por Grupo",
       x = "Grupo",
       y = "Calificación") +
  theme_minimal()

# ============================================================================
# 7. GRÁFICO DE PASTEL (PIE CHART)
# ============================================================================

# Datos de participación de mercado
mercado <- data.frame(
  empresa = c("Empresa A", "Empresa B", "Empresa C", "Empresa D"),
  participacion = c(35, 25, 20, 20)
)

# Crear gráfico de pastel
ggplot(mercado, aes(x = "", y = participacion, fill = empresa)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  labs(title = "Participación de Mercado") +
  theme_void()

# ============================================================================
# 8. FACETAS (FACETS) - MÚLTIPLES GRÁFICOS
# ============================================================================

# Datos de ventas por región y producto
ventas_regiones <- data.frame(
  mes = rep(1:6, 4),
  ventas = c(rnorm(6, 100, 10), rnorm(6, 120, 15),
             rnorm(6, 90, 12), rnorm(6, 110, 10)),
  region = rep(c("Norte", "Sur"), each = 12),
  producto = rep(rep(c("A", "B"), each = 6), 2)
)

# Facetas por columna
ggplot(ventas_regiones, aes(x = mes, y = ventas, color = producto)) +
  geom_line() +
  facet_wrap(~ region) +
  labs(title = "Ventas por Región") +
  theme_minimal()

# ============================================================================
# 9. PERSONALIZACIÓN AVANZADA
# ============================================================================

# Ejemplo completo personalizado
ggplot(ventas_df, aes(x = mes, y = ventas)) +
  geom_bar(stat = "identity", fill = "#2E86AB", alpha = 0.8) +
  geom_text(aes(label = ventas), vjust = -0.5, size = 3.5) +
  labs(title = "Análisis de Ventas Mensuales",
       subtitle = "Primer semestre 2024",
       x = "",
       y = "Ventas ($)",
       caption = "Fuente: Departamento de Ventas") +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold"),
    plot.subtitle = element_text(size = 12, color = "gray40"),
    axis.text.x = element_text(angle = 0, hjust = 0.5),
    panel.grid.major.x = element_blank()
  )

# ============================================================================
# 10. EJEMPLO PRÁCTICO INTEGRADOR
# ============================================================================

# Crear dataset completo de ventas
set.seed(42)
datos_ventas <- data.frame(
  vendedor = rep(c("Ana", "Juan", "María"), each = 12),
  mes = rep(1:12, 3),
  ventas = c(
    rnorm(12, 5000, 500),   # Ana
    rnorm(12, 6000, 600),   # Juan
    rnorm(12, 5500, 550)    # María
  ),
  region = rep(c("Norte", "Sur", "Este"), each = 12)
)

# Gráfico 1: Líneas por vendedor
p1 <- ggplot(datos_ventas, aes(x = mes, y = ventas, color = vendedor)) +
  geom_line(size = 1) +
  geom_point(size = 2) +
  labs(title = "Ventas por Vendedor",
       x = "Mes",
       y = "Ventas ($)") +
  theme_minimal() +
  scale_x_continuous(breaks = 1:12)

print(p1)

# Gráfico 2: Box plot comparativo
p2 <- ggplot(datos_ventas, aes(x = vendedor, y = ventas, fill = vendedor)) +
  geom_boxplot() +
  geom_jitter(width = 0.2, alpha = 0.3) +
  labs(title = "Distribución de Ventas por Vendedor",
       y = "Ventas ($)") +
  theme_minimal() +
  theme(legend.position = "none")

print(p2)

# Gráfico 3: Facetas por región
p3 <- ggplot(datos_ventas, aes(x = mes, y = ventas, color = vendedor)) +
  geom_line() +
  facet_wrap(~ region) +
  labs(title = "Ventas por Región y Vendedor") +
  theme_minimal()

print(p3)

# ============================================================================
# CONSEJOS PARA BUENOS GRÁFICOS
# ============================================================================

# 1. Siempre incluye títulos descriptivos
# 2. Etiqueta claramente los ejes
# 3. Usa colores significativos y accesibles
# 4. Evita gráficos 3D innecesarios
# 5. Mantén el diseño simple y limpio
# 6. Usa theme_minimal() o theme_classic() para gráficos profesionales

print("\n¡Felicidades! Has completado el Módulo 4")
print("Ahora puedes crear visualizaciones profesionales con ggplot2")
