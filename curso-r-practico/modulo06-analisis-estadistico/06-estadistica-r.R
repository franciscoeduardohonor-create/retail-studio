# ============================================================================
# MÓDULO 6: ANÁLISIS ESTADÍSTICO EN R
# ============================================================================
# Aprenderás a realizar análisis estadísticos básicos e intermedios

# ============================================================================
# 1. ESTADÍSTICA DESCRIPTIVA
# ============================================================================

# Crear datos de ejemplo
set.seed(123)
calificaciones <- rnorm(100, mean = 75, sd = 10)

# Medidas de tendencia central
mean(calificaciones)      # Media
median(calificaciones)    # Mediana
# No hay función mode() nativa para moda

# Medidas de dispersión
var(calificaciones)       # Varianza
sd(calificaciones)        # Desviación estándar
range(calificaciones)     # Rango (min, max)
IQR(calificaciones)       # Rango intercuartílico

# Resumen completo
summary(calificaciones)

# Cuartiles
quantile(calificaciones, probs = c(0.25, 0.5, 0.75))

# ============================================================================
# 2. DISTRIBUCIONES DE PROBABILIDAD
# ============================================================================

# DISTRIBUCIÓN NORMAL
# dnorm - densidad
# pnorm - probabilidad acumulada
# qnorm - cuantil
# rnorm - números aleatorios

# Generar números aleatorios normales
datos_normales <- rnorm(1000, mean = 100, sd = 15)
hist(datos_normales, main = "Distribución Normal", col = "lightblue")

# Probabilidad de x <= 100 en N(100, 15)
pnorm(100, mean = 100, sd = 15)  # 0.5

# Encontrar el valor del percentil 95
qnorm(0.95, mean = 100, sd = 15)

# DISTRIBUCIÓN BINOMIAL
# Probabilidad de 5 éxitos en 10 intentos con p=0.5
dbinom(5, size = 10, prob = 0.5)

# Generar datos binomiales
datos_binomial <- rbinom(1000, size = 10, prob = 0.3)
hist(datos_binomial, main = "Distribución Binomial")

# DISTRIBUCIÓN POISSON (eventos raros)
# Probabilidad de exactamente 3 eventos si lambda = 5
dpois(3, lambda = 5)

# ============================================================================
# 3. PRUEBAS DE HIPÓTESIS
# ============================================================================

# PRUEBA T DE UNA MUESTRA
# H0: media = 75
# H1: media ≠ 75
t.test(calificaciones, mu = 75)

# PRUEBA T DE DOS MUESTRAS
grupo_a <- rnorm(50, mean = 75, sd = 10)
grupo_b <- rnorm(50, mean = 80, sd = 10)

# Prueba t independiente
t.test(grupo_a, grupo_b)

# PRUEBA T PAREADA (muestras relacionadas)
antes <- c(120, 130, 125, 140, 135, 128, 132, 138)
despues <- c(115, 125, 120, 132, 128, 122, 126, 130)

t.test(antes, despues, paired = TRUE)

# PRUEBA DE NORMALIDAD (Shapiro-Wilk)
shapiro.test(calificaciones)
# p > 0.05 indica que los datos son normales

# ============================================================================
# 4. CORRELACIÓN
# ============================================================================

# Datos de ejemplo
horas_estudio <- c(2, 3, 4, 5, 6, 7, 8, 9, 10, 11)
calificacion <- c(65, 70, 75, 78, 82, 85, 88, 90, 92, 95)

# Correlación de Pearson
cor(horas_estudio, calificacion)
cor.test(horas_estudio, calificacion)

# Visualizar correlación
plot(horas_estudio, calificacion,
     main = "Horas de Estudio vs Calificación",
     xlab = "Horas", ylab = "Calificación",
     pch = 19, col = "blue")
abline(lm(calificacion ~ horas_estudio), col = "red")

# Correlación de Spearman (no paramétrica)
cor(horas_estudio, calificacion, method = "spearman")

# ============================================================================
# 5. REGRESIÓN LINEAL
# ============================================================================

# Modelo de regresión simple
modelo <- lm(calificacion ~ horas_estudio)
summary(modelo)

# Coeficientes
coef(modelo)

# Predicciones
nuevas_horas <- data.frame(horas_estudio = c(5, 7, 12))
predict(modelo, nuevas_horas)

# Intervalos de confianza
confint(modelo)

# Diagnóstico del modelo
par(mfrow = c(2, 2))
plot(modelo)
par(mfrow = c(1, 1))

# REGRESIÓN MÚLTIPLE
# Crear datos
set.seed(123)
datos_multi <- data.frame(
  ventas = rnorm(100, 5000, 1000),
  publicidad = rnorm(100, 500, 100),
  precio = rnorm(100, 50, 10),
  competencia = rnorm(100, 3, 1)
)

# Modelo múltiple
modelo_multi <- lm(ventas ~ publicidad + precio + competencia, data = datos_multi)
summary(modelo_multi)

# ============================================================================
# 6. ANOVA (ANÁLISIS DE VARIANZA)
# ============================================================================

# Comparar medias de 3+ grupos
grupo1 <- rnorm(30, mean = 75, sd = 10)
grupo2 <- rnorm(30, mean = 80, sd = 10)
grupo3 <- rnorm(30, mean = 85, sd = 10)

# Crear data frame
datos_anova <- data.frame(
  calificacion = c(grupo1, grupo2, grupo3),
  grupo = rep(c("A", "B", "C"), each = 30)
)

# ANOVA de una vía
modelo_anova <- aov(calificacion ~ grupo, data = datos_anova)
summary(modelo_anova)

# Test post-hoc (Tukey)
TukeyHSD(modelo_anova)

# ============================================================================
# 7. PRUEBAS NO PARAMÉTRICAS
# ============================================================================

# PRUEBA DE WILCOXON (alternativa a t-test)
wilcox.test(grupo_a, grupo_b)

# PRUEBA DE KRUSKAL-WALLIS (alternativa a ANOVA)
kruskal.test(calificacion ~ grupo, data = datos_anova)

# PRUEBA DE CHI-CUADRADO (independencia)
# Tabla de contingencia
datos_chi <- matrix(c(30, 20, 15, 35), nrow = 2)
chisq.test(datos_chi)

# ============================================================================
# 8. INTERVALOS DE CONFIANZA
# ============================================================================

# IC para la media
t.test(calificaciones)$conf.int

# IC manualmente
error_std <- sd(calificaciones) / sqrt(length(calificaciones))
media <- mean(calificaciones)
margen_error <- qt(0.975, df = length(calificaciones) - 1) * error_std

ic_inferior <- media - margen_error
ic_superior <- media + margen_error

cat("IC 95%: [", ic_inferior, ",", ic_superior, "]\n")

# ============================================================================
# 9. EJEMPLO PRÁCTICO INTEGRADOR
# ============================================================================

# Dataset: Estudio de efectividad de 3 métodos de enseñanza
set.seed(456)
estudio <- data.frame(
  estudiante = 1:90,
  metodo = rep(c("Tradicional", "Online", "Híbrido"), each = 30),
  calificacion_inicial = rnorm(90, 60, 10),
  calificacion_final = c(
    rnorm(30, 70, 12),  # Tradicional
    rnorm(30, 75, 11),  # Online
    rnorm(30, 80, 10)   # Híbrido
  ),
  horas_estudio = rnorm(90, 10, 3)
)

# Calcular mejora
estudio$mejora <- estudio$calificacion_final - estudio$calificacion_inicial

# 1. Estadística descriptiva por grupo
library(dplyr)
resumen <- estudio %>%
  group_by(metodo) %>%
  summarise(
    n = n(),
    media_mejora = mean(mejora),
    sd_mejora = sd(mejora),
    media_final = mean(calificacion_final)
  )
print(resumen)

# 2. ANOVA para comparar métodos
anova_metodos <- aov(calificacion_final ~ metodo, data = estudio)
summary(anova_metodos)

# 3. Test post-hoc
TukeyHSD(anova_metodos)

# 4. Correlación entre horas de estudio y calificación final
cor.test(estudio$horas_estudio, estudio$calificacion_final)

# 5. Regresión: predecir calificación final
modelo_reg <- lm(calificacion_final ~ metodo + horas_estudio +
                 calificacion_inicial, data = estudio)
summary(modelo_reg)

# 6. Visualizaciones
boxplot(calificacion_final ~ metodo, data = estudio,
        main = "Calificaciones por Método",
        col = c("lightblue", "lightgreen", "lightyellow"))

# ============================================================================
# 10. CONSEJOS ESTADÍSTICOS
# ============================================================================

# 1. Siempre verifica normalidad antes de usar pruebas paramétricas
# 2. Usa pruebas no paramétricas si los datos no son normales
# 3. El p-valor < 0.05 es significativo (nivel de confianza 95%)
# 4. La correlación no implica causalidad
# 5. Verifica los supuestos de regresión (linealidad, normalidad, homocedasticidad)

print("\n¡Felicidades! Has completado el Módulo 6")
print("Ahora puedes realizar análisis estadísticos en R")
