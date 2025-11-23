# =============================================================================
# MÓDULO 4: ESTADÍSTICA CON R
# Lección 2: Estadística Inferencial
# =============================================================================

# La estadística inferencial permite hacer conclusiones sobre poblaciones
# basándose en muestras, y probar hipótesis

# CONTENIDO:
# 1. Pruebas de hipótesis - conceptos básicos
# 2. Prueba t (t-test)
# 3. ANOVA
# 4. Chi-cuadrado
# 5. Intervalos de confianza
# 6. Correlación y covarianza

# =============================================================================
# PREPARACIÓN
# =============================================================================

library(ggplot2)
library(dplyr)

set.seed(123)

# =============================================================================
# 1. CONCEPTOS BÁSICOS DE PRUEBAS DE HIPÓTESIS
# =============================================================================

# Hipótesis nula (H0): No hay efecto o diferencia
# Hipótesis alternativa (H1): Sí hay efecto o diferencia
# p-valor: Probabilidad de obtener resultados al menos tan extremos
#          asumiendo que H0 es verdadera
# Nivel de significancia (α): Típicamente 0.05 (5%)
# Si p-valor < α: Rechazamos H0
# Si p-valor >= α: No rechazamos H0

# =============================================================================
# 2. PRUEBA T (T-TEST)
# =============================================================================

# A) PRUEBA T DE UNA MUESTRA
# Compara la media de una muestra con un valor específico

# Ejemplo: ¿La calificación promedio es diferente de 75?
calificaciones <- c(78, 82, 75, 88, 79, 85, 77, 81, 83, 86, 80, 84)

# Hipótesis:
# H0: media = 75
# H1: media ≠ 75

resultado_t1 <- t.test(calificaciones, mu = 75)
print(resultado_t1)

# Interpretación:
print(paste("Media de la muestra:", round(mean(calificaciones), 2)))
print(paste("p-valor:", round(resultado_t1$p.value, 4)))

if (resultado_t1$p.value < 0.05) {
  print("Conclusión: Rechazamos H0. La media es significativamente diferente de 75")
} else {
  print("Conclusión: No rechazamos H0. No hay evidencia de que la media sea diferente de 75")
}

# Intervalo de confianza
print(paste("Intervalo de confianza 95%:",
            round(resultado_t1$conf.int[1], 2), "a",
            round(resultado_t1$conf.int[2], 2)))

# B) PRUEBA T DE DOS MUESTRAS INDEPENDIENTES
# Compara las medias de dos grupos independientes

# Ejemplo: Calificaciones de dos grupos
grupo_a <- c(85, 88, 82, 90, 87, 89, 84, 86, 91, 83)
grupo_b <- c(75, 78, 72, 80, 77, 79, 74, 76, 81, 73)

# Hipótesis:
# H0: media_a = media_b
# H1: media_a ≠ media_b

resultado_t2 <- t.test(grupo_a, grupo_b)
print(resultado_t2)

print(paste("Media grupo A:", round(mean(grupo_a), 2)))
print(paste("Media grupo B:", round(mean(grupo_b), 2)))
print(paste("p-valor:", round(resultado_t2$p.value, 6)))

# Visualización
datos_grupos <- data.frame(
  calificacion = c(grupo_a, grupo_b),
  grupo = rep(c("Grupo A", "Grupo B"), each = 10)
)

ggplot(datos_grupos, aes(x = grupo, y = calificacion, fill = grupo)) +
  geom_boxplot(alpha = 0.7) +
  geom_jitter(width = 0.1, alpha = 0.3) +
  stat_summary(fun = mean, geom = "point", shape = 23, size = 3, fill = "red") +
  labs(
    title = "Comparación de Calificaciones entre Grupos",
    subtitle = paste("p-valor =", round(resultado_t2$p.value, 4)),
    y = "Calificación"
  ) +
  theme_minimal()

# C) PRUEBA T PAREADA
# Compara medidas antes y después en los mismos sujetos

# Ejemplo: Calificaciones antes y después de un curso
antes <- c(70, 68, 72, 65, 75, 71, 69, 73, 67, 74)
despues <- c(75, 73, 78, 72, 80, 76, 74, 79, 73, 78)

# Hipótesis:
# H0: media_antes = media_despues
# H1: media_antes ≠ media_despues

resultado_t3 <- t.test(despues, antes, paired = TRUE)
print(resultado_t3)

print(paste("Media antes:", round(mean(antes), 2)))
print(paste("Media después:", round(mean(despues), 2)))
print(paste("Mejora promedio:", round(mean(despues - antes), 2)))
print(paste("p-valor:", round(resultado_t3$p.value, 6)))

# Visualización de cambios
datos_pareados <- data.frame(
  id = rep(1:10, 2),
  calificacion = c(antes, despues),
  momento = rep(c("Antes", "Después"), each = 10)
)

ggplot(datos_pareados, aes(x = momento, y = calificacion, group = id)) +
  geom_line(alpha = 0.3) +
  geom_point(aes(color = momento), size = 3) +
  labs(
    title = "Cambio en Calificaciones Antes y Después del Curso",
    subtitle = paste("p-valor =", round(resultado_t3$p.value, 4)),
    x = "Momento",
    y = "Calificación"
  ) +
  theme_minimal()

# EJERCICIO 1: Prueba si estas ventas son significativamente mayores a 10000
ventas_dia <- c(10500, 11200, 10800, 11500, 10300, 11000, 10900, 11300)
# Tu código aquí:




# =============================================================================
# 3. ANOVA (Análisis de Varianza)
# =============================================================================

# ANOVA compara las medias de 3 o más grupos
# Hipótesis:
# H0: Todas las medias son iguales
# H1: Al menos una media es diferente

# Ejemplo: Calificaciones de 4 métodos de enseñanza
set.seed(42)
metodo_1 <- rnorm(20, mean = 75, sd = 8)
metodo_2 <- rnorm(20, mean = 80, sd = 8)
metodo_3 <- rnorm(20, mean = 78, sd = 8)
metodo_4 <- rnorm(20, mean = 82, sd = 8)

# Crear data frame
datos_metodos <- data.frame(
  calificacion = c(metodo_1, metodo_2, metodo_3, metodo_4),
  metodo = factor(rep(c("Método 1", "Método 2", "Método 3", "Método 4"), each = 20))
)

# Realizar ANOVA
resultado_anova <- aov(calificacion ~ metodo, data = datos_metodos)
print(summary(resultado_anova))

# Extraer p-valor
p_valor_anova <- summary(resultado_anova)[[1]][["Pr(>F)"]][1]
print(paste("p-valor ANOVA:", round(p_valor_anova, 6)))

# Visualización
ggplot(datos_metodos, aes(x = metodo, y = calificacion, fill = metodo)) +
  geom_boxplot(alpha = 0.7) +
  stat_summary(fun = mean, geom = "point", shape = 23, size = 3, fill = "red") +
  labs(
    title = "Comparación de Calificaciones por Método de Enseñanza",
    subtitle = paste("p-valor ANOVA =", round(p_valor_anova, 4)),
    x = "Método",
    y = "Calificación"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

# Pruebas post-hoc (si ANOVA es significativa)
# Tukey HSD: Compara todos los pares de grupos
if (p_valor_anova < 0.05) {
  print("ANOVA significativa. Realizando pruebas post-hoc Tukey HSD:")
  resultado_tukey <- TukeyHSD(resultado_anova)
  print(resultado_tukey)
}

# EJERCICIO 2: Realiza un ANOVA con estos datos
grupo_1 <- c(23, 25, 22, 26, 24)
grupo_2 <- c(30, 32, 29, 33, 31)
grupo_3 <- c(28, 27, 29, 26, 28)
# Crea un data frame y realiza el ANOVA
# Tu código aquí:




# =============================================================================
# 4. PRUEBA CHI-CUADRADO
# =============================================================================

# Prueba de independencia entre variables categóricas

# Ejemplo: ¿Hay relación entre género y preferencia de producto?
# Tabla de contingencia
datos_contingencia <- matrix(c(30, 20, 15, 35), nrow = 2,
                             dimnames = list(
                               Genero = c("Masculino", "Femenino"),
                               Producto = c("A", "B")
                             ))

print("Tabla de contingencia:")
print(datos_contingencia)

# Prueba Chi-cuadrado
# H0: Las variables son independientes
# H1: Las variables están relacionadas

resultado_chi <- chisq.test(datos_contingencia)
print(resultado_chi)

print(paste("p-valor:", round(resultado_chi$p.value, 4)))

if (resultado_chi$p.value < 0.05) {
  print("Conclusión: Rechazamos H0. Hay relación entre género y preferencia")
} else {
  print("Conclusión: No rechazamos H0. No hay evidencia de relación")
}

# Visualización
library(tidyr)
datos_chi_df <- as.data.frame(datos_contingencia) %>%
  pivot_wider(names_from = Producto, values_from = Freq)

# Prueba de bondad de ajuste Chi-cuadrado
# ¿Los datos observados se ajustan a una distribución esperada?

# Ejemplo: ¿Los clientes visitan la tienda uniformemente cada día?
visitas_observadas <- c(Lun = 45, Mar = 38, Mie = 52, Jue = 48, Vie = 65, Sab = 72)
# Si fueran uniformes, esperaríamos el mismo número cada día
visitas_esperadas <- rep(sum(visitas_observadas) / 6, 6)

resultado_bondad <- chisq.test(visitas_observadas, p = visitas_esperadas / sum(visitas_esperadas))
print(resultado_bondad)

# EJERCICIO 3: Realiza una prueba chi-cuadrado
# ¿Hay relación entre tipo de cliente (nuevo/recurrente) y compra (sí/no)?
tabla <- matrix(c(40, 60, 70, 30), nrow = 2)
# Tu código aquí:




# =============================================================================
# 5. INTERVALOS DE CONFIANZA
# =============================================================================

# Un intervalo de confianza da un rango donde probablemente está el parámetro

# Intervalo de confianza para la media
datos_muestra <- c(23, 25, 22, 28, 24, 26, 23, 27, 25, 24)

# Método 1: Con t.test
ic_media <- t.test(datos_muestra)$conf.int
print(paste("IC 95% para la media:", round(ic_media[1], 2), "a", round(ic_media[2], 2)))

# Método 2: Calcular manualmente
media_m <- mean(datos_muestra)
error_est <- sd(datos_muestra) / sqrt(length(datos_muestra))
margen_error <- qt(0.975, df = length(datos_muestra) - 1) * error_est

ic_inferior <- media_m - margen_error
ic_superior <- media_m + margen_error

print(paste("Media:", round(media_m, 2)))
print(paste("IC 95%: [", round(ic_inferior, 2), ",", round(ic_superior, 2), "]"))

# Intervalos de confianza para proporciones
# Ejemplo: De 100 encuestados, 62 están satisfechos
# ¿Cuál es el IC para la proporción de satisfechos?

resultado_prop <- prop.test(x = 62, n = 100)
print(resultado_prop)
print(paste("Proporción estimada:", resultado_prop$estimate))
print(paste("IC 95%:", round(resultado_prop$conf.int[1], 3), "a",
            round(resultado_prop$conf.int[2], 3)))

# Visualización de intervalos de confianza
grupos_ic <- data.frame(
  grupo = c("A", "B", "C", "D"),
  media = c(75, 82, 78, 85),
  ic_inf = c(72, 79, 75, 82),
  ic_sup = c(78, 85, 81, 88)
)

ggplot(grupos_ic, aes(x = grupo, y = media)) +
  geom_point(size = 4, color = "steelblue") +
  geom_errorbar(aes(ymin = ic_inf, ymax = ic_sup), width = 0.2) +
  labs(
    title = "Medias con Intervalos de Confianza 95%",
    x = "Grupo",
    y = "Media"
  ) +
  theme_minimal()

# EJERCICIO 4: Calcula el IC 95% para estas ventas
ventas <- c(15000, 16500, 14800, 17200, 15900, 16100, 15500, 16800)
# Tu código aquí:




# =============================================================================
# 6. CORRELACIÓN Y COVARIANZA
# =============================================================================

# CORRELACIÓN: Mide la relación lineal entre dos variables (-1 a +1)
# -1: correlación negativa perfecta
#  0: sin correlación
# +1: correlación positiva perfecta

# Generar datos correlacionados
set.seed(123)
horas_estudio <- rnorm(50, mean = 15, sd = 5)
calificaciones_corr <- 50 + 2 * horas_estudio + rnorm(50, mean = 0, sd = 5)

# Correlación de Pearson (para variables continuas, relación lineal)
cor_pearson <- cor(horas_estudio, calificaciones_corr, method = "pearson")
print(paste("Correlación de Pearson:", round(cor_pearson, 3)))

# Prueba de significancia de la correlación
resultado_cor <- cor.test(horas_estudio, calificaciones_corr)
print(resultado_cor)

# Correlación de Spearman (para variables ordinales o no lineales)
cor_spearman <- cor(horas_estudio, calificaciones_corr, method = "spearman")
print(paste("Correlación de Spearman:", round(cor_spearman, 3)))

# Visualización con correlación
df_corr <- data.frame(horas_estudio, calificaciones_corr)

ggplot(df_corr, aes(x = horas_estudio, y = calificaciones_corr)) +
  geom_point(alpha = 0.6, color = "steelblue") +
  geom_smooth(method = "lm", color = "red", se = TRUE) +
  labs(
    title = "Relación entre Horas de Estudio y Calificación",
    subtitle = paste("r =", round(cor_pearson, 3), ", p-valor =",
                    round(resultado_cor$p.value, 4)),
    x = "Horas de Estudio",
    y = "Calificación"
  ) +
  theme_minimal()

# MATRIZ DE CORRELACIÓN
# Para múltiples variables
datos_multi <- data.frame(
  horas_estudio = horas_estudio,
  calificacion = calificaciones_corr,
  asistencia = rnorm(50, mean = 80, sd = 10),
  tareas = rnorm(50, mean = 90, sd = 8)
)

matriz_cor <- cor(datos_multi)
print("Matriz de correlación:")
print(round(matriz_cor, 3))

# Visualización de matriz de correlación
library(reshape2)
matriz_cor_long <- melt(matriz_cor)

ggplot(matriz_cor_long, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile() +
  geom_text(aes(label = round(value, 2)), color = "white") +
  scale_fill_gradient2(low = "blue", mid = "white", high = "red",
                       midpoint = 0, limit = c(-1, 1)) +
  labs(
    title = "Matriz de Correlación",
    x = "",
    y = "",
    fill = "Correlación"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# COVARIANZA
# Mide cómo varían juntas dos variables (sin estandarizar)
covarianza <- cov(horas_estudio, calificaciones_corr)
print(paste("Covarianza:", round(covarianza, 2)))

# EJERCICIO 5: Calcula la correlación
# Usa el dataset mtcars
# Correlación entre mpg y wt (peso)
# ¿Es significativa?
# Tu código aquí:




# =============================================================================
# EJEMPLO PRÁCTICO: ANÁLISIS COMPLETO DE A/B TESTING
# =============================================================================

print("=== ANÁLISIS A/B TESTING: COMPARACIÓN DE DOS VERSIONES DE SITIO WEB ===")

# Datos: Tiempo en sitio (segundos) para versión A y B
set.seed(42)
version_a <- rnorm(100, mean = 180, sd = 40)  # Media ~3 minutos
version_b <- rnorm(100, mean = 210, sd = 40)  # Media ~3.5 minutos

datos_ab <- data.frame(
  tiempo = c(version_a, version_b),
  version = rep(c("Versión A", "Versión B"), each = 100)
)

# 1. Estadísticas descriptivas
estadisticas_ab <- datos_ab %>%
  group_by(version) %>%
  summarise(
    n = n(),
    media = round(mean(tiempo), 2),
    mediana = round(median(tiempo), 2),
    desv_est = round(sd(tiempo), 2),
    ic_inf = round(t.test(tiempo)$conf.int[1], 2),
    ic_sup = round(t.test(tiempo)$conf.int[2], 2)
  )

print(estadisticas_ab)

# 2. Prueba t
resultado_ab <- t.test(version_b, version_a)
print(resultado_ab)

# 3. Visualización
ggplot(datos_ab, aes(x = version, y = tiempo, fill = version)) +
  geom_boxplot(alpha = 0.7) +
  geom_jitter(width = 0.2, alpha = 0.1) +
  stat_summary(fun = mean, geom = "point", shape = 23, size = 3, fill = "red") +
  labs(
    title = "Comparación A/B Testing: Tiempo en Sitio",
    subtitle = paste("Diferencia de medias:", round(mean(version_b) - mean(version_a), 2),
                    "seg, p-valor =", round(resultado_ab$p.value, 4)),
    x = "Versión",
    y = "Tiempo en sitio (segundos)"
  ) +
  theme_minimal()

# 4. Conclusión
if (resultado_ab$p.value < 0.05) {
  print("CONCLUSIÓN: La Versión B es significativamente mejor que la Versión A")
  print(paste("Los usuarios pasan", round(mean(version_b) - mean(version_a), 1),
              "segundos más en la Versión B"))
} else {
  print("CONCLUSIÓN: No hay diferencia significativa entre versiones")
}

# =============================================================================
# RESUMEN DE LA LECCIÓN
# =============================================================================
# ✓ Pruebas de hipótesis: H0, H1, p-valor
# ✓ t-test: t.test() - una muestra, dos muestras, pareada
# ✓ ANOVA: aov() - comparar 3+ grupos
# ✓ Chi-cuadrado: chisq.test() - variables categóricas
# ✓ Intervalos de confianza: t.test()$conf.int
# ✓ Correlación: cor(), cor.test()

# =============================================================================
# ¡Felicidades! Has completado la Lección 2 del Módulo 4
# Continúa con el Módulo 5 - Modelos Estadísticos Avanzados
# =============================================================================
