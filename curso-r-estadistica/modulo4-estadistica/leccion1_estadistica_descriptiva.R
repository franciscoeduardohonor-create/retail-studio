# =============================================================================
# MÓDULO 4: ESTADÍSTICA CON R
# Lección 1: Estadística Descriptiva
# =============================================================================

# La estadística descriptiva resume y describe características de los datos
# Sin hacer inferencias sobre poblaciones más grandes

# CONTENIDO:
# 1. Medidas de tendencia central
# 2. Medidas de dispersión
# 3. Medidas de posición (cuantiles)
# 4. Distribuciones de frecuencia
# 5. Análisis exploratorio de datos (EDA)

# =============================================================================
# PREPARACIÓN
# =============================================================================

library(ggplot2)
library(dplyr)

# Crear datos de ejemplo: calificaciones de estudiantes
set.seed(123)
estudiantes <- data.frame(
  id = 1:100,
  calificacion = round(rnorm(100, mean = 75, sd = 12)),
  horas_estudio = round(abs(rnorm(100, mean = 15, sd = 5))),
  asistencia = round(runif(100, min = 60, max = 100)),
  grupo = sample(c("A", "B", "C"), 100, replace = TRUE)
)

# Asegurar que las calificaciones estén entre 0 y 100
estudiantes$calificacion <- pmin(pmax(estudiantes$calificacion, 0), 100)

head(estudiantes)

# =============================================================================
# 1. MEDIDAS DE TENDENCIA CENTRAL
# =============================================================================

# La tendencia central indica el "centro" de los datos

# MEDIA (PROMEDIO)
# Suma de todos los valores dividida por el número de observaciones
media_calif <- mean(estudiantes$calificacion)
print(paste("Media de calificaciones:", round(media_calif, 2)))

# Media con datos faltantes
datos_na <- c(10, 20, NA, 30, 40)
mean(datos_na)                    # Devuelve NA
mean(datos_na, na.rm = TRUE)      # Ignora NA: 25

# MEDIANA
# Valor central cuando los datos están ordenados
# Menos sensible a valores extremos que la media
mediana_calif <- median(estudiantes$calificacion)
print(paste("Mediana de calificaciones:", mediana_calif))

# Ejemplo donde media y mediana difieren
ingresos <- c(30000, 32000, 31000, 33000, 35000, 34000, 200000)  # Un valor extremo
print(paste("Media de ingresos:", mean(ingresos)))      # Muy afectada por 200000
print(paste("Mediana de ingresos:", median(ingresos)))  # Más representativa

# MODA
# Valor que más se repite
# R no tiene función built-in para moda, creamos una
calcular_moda <- function(x) {
  tabla <- table(x)
  moda <- as.numeric(names(tabla[tabla == max(tabla)]))
  return(moda)
}

moda_calif <- calcular_moda(estudiantes$calificacion)
print(paste("Moda de calificaciones:", moda_calif))

# EJERCICIO 1: Calcula media, mediana y moda de horas_estudio
# Tu código aquí:




# =============================================================================
# 2. MEDIDAS DE DISPERSIÓN
# =============================================================================

# La dispersión indica qué tan separados están los datos

# RANGO
# Diferencia entre el valor máximo y mínimo
rango_calif <- max(estudiantes$calificacion) - min(estudiantes$calificacion)
print(paste("Rango de calificaciones:", rango_calif))

# Función range() devuelve min y max
range(estudiantes$calificacion)

# VARIANZA
# Promedio de las desviaciones cuadradas respecto a la media
varianza_calif <- var(estudiantes$calificacion)
print(paste("Varianza de calificaciones:", round(varianza_calif, 2)))

# DESVIACIÓN ESTÁNDAR
# Raíz cuadrada de la varianza (en las mismas unidades que los datos)
desv_est_calif <- sd(estudiantes$calificacion)
print(paste("Desviación estándar:", round(desv_est_calif, 2)))

# Interpretación: En promedio, las calificaciones se desvían
# ±12 puntos de la media

# COEFICIENTE DE VARIACIÓN
# Desviación estándar relativa a la media (en porcentaje)
# Útil para comparar dispersión de variables con diferentes escalas
cv_calif <- (desv_est_calif / media_calif) * 100
print(paste("Coeficiente de variación:", round(cv_calif, 2), "%"))

# RANGO INTERCUARTÍLICO (IQR)
# Diferencia entre el percentil 75 y el percentil 25
# Menos sensible a valores extremos
iqr_calif <- IQR(estudiantes$calificacion)
print(paste("Rango intercuartílico:", round(iqr_calif, 2)))

# EJERCICIO 2: Calcula todas las medidas de dispersión para asistencia
# Tu código aquí:




# =============================================================================
# 3. MEDIDAS DE POSICIÓN (CUANTILES)
# =============================================================================

# Los cuantiles dividen los datos ordenados en partes iguales

# CUARTILES (dividen en 4 partes)
cuartiles <- quantile(estudiantes$calificacion, probs = c(0.25, 0.5, 0.75))
print("Cuartiles:")
print(cuartiles)

# PERCENTILES
# Percentil 90: el 90% de los datos están por debajo de este valor
percentiles <- quantile(estudiantes$calificacion, probs = seq(0, 1, 0.1))
print("Percentiles (cada 10%):")
print(percentiles)

# Percentiles específicos
p25 <- quantile(estudiantes$calificacion, 0.25)
p50 <- quantile(estudiantes$calificacion, 0.50)  # = mediana
p75 <- quantile(estudiantes$calificacion, 0.75)
p90 <- quantile(estudiantes$calificacion, 0.90)

print(paste("25% de estudiantes tiene calificación <=", p25))
print(paste("50% de estudiantes tiene calificación <=", p50))
print(paste("75% de estudiantes tiene calificación <=", p75))
print(paste("90% de estudiantes tiene calificación <=", p90))

# DECILES (dividen en 10 partes)
deciles <- quantile(estudiantes$calificacion, probs = seq(0.1, 0.9, 0.1))
print("Deciles:")
print(deciles)

# EJERCICIO 3: Encuentra:
# 1. El percentil 95 de horas_estudio
# 2. Los cuartiles de asistencia
# Tu código aquí:




# =============================================================================
# 4. RESUMEN ESTADÍSTICO COMPLETO
# =============================================================================

# summary() proporciona un resumen rápido
summary(estudiantes$calificacion)

# Resumen de todo el data frame
summary(estudiantes)

# Resumen personalizado con dplyr
resumen_completo <- estudiantes %>%
  summarise(
    n = n(),
    media = mean(calificacion),
    mediana = median(calificacion),
    desv_est = sd(calificacion),
    minimo = min(calificacion),
    maximo = max(calificacion),
    q25 = quantile(calificacion, 0.25),
    q75 = quantile(calificacion, 0.75),
    iqr = IQR(calificacion)
  )

print(resumen_completo)

# Resumen por grupo
resumen_por_grupo <- estudiantes %>%
  group_by(grupo) %>%
  summarise(
    n = n(),
    media = round(mean(calificacion), 2),
    mediana = median(calificacion),
    desv_est = round(sd(calificacion), 2),
    min = min(calificacion),
    max = max(calificacion)
  )

print(resumen_por_grupo)

# EJERCICIO 4: Crea un resumen por grupo de horas_estudio
# Incluye: n, media, mediana, desv_est
# Tu código aquí:




# =============================================================================
# 5. DISTRIBUCIONES DE FRECUENCIA
# =============================================================================

# TABLA DE FRECUENCIAS ABSOLUTAS
tabla_grupos <- table(estudiantes$grupo)
print("Frecuencia absoluta por grupo:")
print(tabla_grupos)

# TABLA DE FRECUENCIAS RELATIVAS
tabla_grupos_rel <- prop.table(tabla_grupos)
print("Frecuencia relativa por grupo:")
print(tabla_grupos_rel)

# En porcentaje
tabla_grupos_pct <- prop.table(tabla_grupos) * 100
print("Frecuencia en porcentaje:")
print(round(tabla_grupos_pct, 2))

# CATEGORIZAR VARIABLES CONTINUAS
# Crear categorías de calificaciones
estudiantes <- estudiantes %>%
  mutate(
    categoria_calif = cut(
      calificacion,
      breaks = c(0, 60, 70, 80, 90, 100),
      labels = c("Reprobado", "Regular", "Bueno", "Muy Bueno", "Excelente"),
      include.lowest = TRUE
    )
  )

# Tabla de frecuencias de categorías
tabla_categorias <- table(estudiantes$categoria_calif)
print("Distribución de calificaciones por categoría:")
print(tabla_categorias)

# Con porcentajes
tabla_cat_pct <- prop.table(tabla_categorias) * 100
print("Distribución en porcentaje:")
print(round(tabla_cat_pct, 2))

# TABLA DE CONTINGENCIA (dos variables)
tabla_contingencia <- table(estudiantes$grupo, estudiantes$categoria_calif)
print("Tabla de contingencia Grupo x Categoría:")
print(tabla_contingencia)

# Proporciones por fila
prop.table(tabla_contingencia, margin = 1) * 100  # margin = 1: por fila

# Proporciones por columna
prop.table(tabla_contingencia, margin = 2) * 100  # margin = 2: por columna

# EJERCICIO 5: Crea categorías para horas_estudio:
# "Poco" (0-10), "Medio" (10-20), "Mucho" (>20)
# Crea una tabla de frecuencias
# Tu código aquí:




# =============================================================================
# 6. ANÁLISIS EXPLORATORIO DE DATOS (EDA) CON VISUALIZACIÓN
# =============================================================================

# Combinar estadísticas con gráficos para entender los datos

# 1. HISTOGRAMA con estadísticas
media <- mean(estudiantes$calificacion)
mediana <- median(estudiantes$calificacion)

ggplot(estudiantes, aes(x = calificacion)) +
  geom_histogram(bins = 20, fill = "steelblue", color = "white", alpha = 0.7) +
  geom_vline(aes(xintercept = media), color = "red", linetype = "dashed", size = 1) +
  geom_vline(aes(xintercept = mediana), color = "green", linetype = "dashed", size = 1) +
  annotate("text", x = media + 5, y = 10, label = paste("Media =", round(media, 1)), color = "red") +
  annotate("text", x = mediana - 5, y = 10, label = paste("Mediana =", round(mediana, 1)), color = "green") +
  labs(
    title = "Distribución de Calificaciones",
    x = "Calificación",
    y = "Frecuencia"
  ) +
  theme_minimal()

# 2. BOXPLOT con resumen estadístico
ggplot(estudiantes, aes(y = calificacion)) +
  geom_boxplot(fill = "lightblue", alpha = 0.7) +
  stat_summary(fun = mean, geom = "point", shape = 23, size = 3, fill = "red") +
  labs(
    title = "Diagrama de Caja de Calificaciones",
    subtitle = "El rombo rojo indica la media",
    y = "Calificación"
  ) +
  theme_minimal()

# 3. BOXPLOT por grupo
ggplot(estudiantes, aes(x = grupo, y = calificacion, fill = grupo)) +
  geom_boxplot(alpha = 0.7) +
  stat_summary(fun = mean, geom = "point", shape = 23, size = 3, fill = "red") +
  labs(
    title = "Comparación de Calificaciones por Grupo",
    x = "Grupo",
    y = "Calificación"
  ) +
  theme_minimal()

# 4. GRÁFICO DE DENSIDAD comparando grupos
ggplot(estudiantes, aes(x = calificacion, fill = grupo)) +
  geom_density(alpha = 0.5) +
  labs(
    title = "Distribución de Calificaciones por Grupo",
    x = "Calificación",
    y = "Densidad"
  ) +
  theme_minimal()

# 5. GRÁFICO DE DISPERSIÓN con tendencia
ggplot(estudiantes, aes(x = horas_estudio, y = calificacion)) +
  geom_point(alpha = 0.5, color = "steelblue") +
  geom_smooth(method = "lm", color = "red", se = TRUE) +
  labs(
    title = "Relación entre Horas de Estudio y Calificación",
    x = "Horas de Estudio",
    y = "Calificación"
  ) +
  theme_minimal()

# =============================================================================
# EJEMPLO PRÁCTICO: REPORTE ESTADÍSTICO COMPLETO
# =============================================================================

print("======================================================")
print("REPORTE ESTADÍSTICO: CALIFICACIONES DE ESTUDIANTES")
print("======================================================")
print("")

# Información general
print(paste("Total de estudiantes:", nrow(estudiantes)))
print(paste("Grupos analizados:", paste(unique(estudiantes$grupo), collapse = ", ")))
print("")

# Estadísticas descriptivas generales
print("--- ESTADÍSTICAS GENERALES DE CALIFICACIONES ---")
print(paste("Media:", round(mean(estudiantes$calificacion), 2)))
print(paste("Mediana:", median(estudiantes$calificacion)))
print(paste("Desviación estándar:", round(sd(estudiantes$calificacion), 2)))
print(paste("Coeficiente de variación:", round(cv_calif, 2), "%"))
print(paste("Rango:", rango_calif))
print(paste("Mínimo:", min(estudiantes$calificacion)))
print(paste("Máximo:", max(estudiantes$calificacion)))
print("")

# Cuartiles
print("--- CUARTILES ---")
print(quantile(estudiantes$calificacion))
print("")

# Distribución por categorías
print("--- DISTRIBUCIÓN POR CATEGORÍAS ---")
dist_categorias <- prop.table(table(estudiantes$categoria_calif)) * 100
print(round(dist_categorias, 2))
print("")

# Comparación por grupos
print("--- COMPARACIÓN POR GRUPOS ---")
print(resumen_por_grupo)
print("")

# Correlación con horas de estudio
correlacion <- cor(estudiantes$horas_estudio, estudiantes$calificacion)
print(paste("Correlación calificación-horas estudio:", round(correlacion, 3)))

# =============================================================================
# RESUMEN DE LA LECCIÓN
# =============================================================================
# ✓ Tendencia central: mean(), median(), moda
# ✓ Dispersión: var(), sd(), IQR(), range()
# ✓ Posición: quantile(), percentiles, cuartiles
# ✓ Frecuencias: table(), prop.table()
# ✓ Resumen: summary()
# ✓ Visualización: histogramas, boxplots, densidad

# =============================================================================
# ¡Felicidades! Has completado la Lección 1 del Módulo 4
# Continúa con leccion2_estadistica_inferencial.R
# =============================================================================
