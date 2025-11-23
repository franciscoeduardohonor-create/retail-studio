# =============================================================================
# MÓDULO 5: MODELOS ESTADÍSTICOS AVANZADOS
# Lección 1: Regresión Lineal
# =============================================================================

# La regresión lineal modela la relación entre una variable dependiente (Y)
# y una o más variables independientes (X)

# CONTENIDO:
# 1. Regresión lineal simple
# 2. Evaluación del modelo
# 3. Diagnóstico del modelo
# 4. Predicciones
# 5. Regresión lineal múltiple

# =============================================================================
# PREPARACIÓN
# =============================================================================

library(ggplot2)
library(dplyr)

# =============================================================================
# 1. REGRESIÓN LINEAL SIMPLE
# =============================================================================

# Regresión lineal simple: Y = β₀ + β₁X + ε
# β₀ = intercepto (ordenada al origen)
# β₁ = pendiente (efecto de X sobre Y)
# ε = error

# Ejemplo: Predecir ventas basándose en gasto en publicidad
set.seed(123)
publicidad <- seq(10, 100, length.out = 50)  # Gasto en publicidad (miles)
ventas <- 50 + 3 * publicidad + rnorm(50, mean = 0, sd = 20)  # Ventas (miles)

datos <- data.frame(publicidad, ventas)
head(datos)

# Visualización de los datos
ggplot(datos, aes(x = publicidad, y = ventas)) +
  geom_point(size = 3, alpha = 0.6, color = "steelblue") +
  labs(
    title = "Relación entre Publicidad y Ventas",
    x = "Gasto en Publicidad (miles MXN)",
    y = "Ventas (miles MXN)"
  ) +
  theme_minimal()

# Crear modelo de regresión lineal
# Sintaxis: lm(Y ~ X, data = datos)
modelo <- lm(ventas ~ publicidad, data = datos)

# Ver resultados del modelo
print(summary(modelo))

# Extraer coeficientes
coeficientes <- coef(modelo)
print(paste("Intercepto (β₀):", round(coeficientes[1], 2)))
print(paste("Pendiente (β₁):", round(coeficientes[2], 2)))

# Interpretación:
# Por cada mil pesos adicionales en publicidad, las ventas aumentan
# aproximadamente 3 mil pesos

# Ecuación del modelo
print(paste("Ecuación: Ventas =", round(coeficientes[1], 2), "+",
            round(coeficientes[2], 2), "* Publicidad"))

# Visualización con línea de regresión
ggplot(datos, aes(x = publicidad, y = ventas)) +
  geom_point(size = 3, alpha = 0.6, color = "steelblue") +
  geom_smooth(method = "lm", color = "red", se = TRUE) +
  labs(
    title = "Regresión Lineal: Publicidad vs Ventas",
    subtitle = paste("Ventas =", round(coeficientes[1], 1), "+",
                    round(coeficientes[2], 2), "× Publicidad"),
    x = "Gasto en Publicidad (miles MXN)",
    y = "Ventas (miles MXN)"
  ) +
  theme_minimal()

# =============================================================================
# 2. EVALUACIÓN DEL MODELO
# =============================================================================

# Métricas clave para evaluar el modelo

# R² (R-cuadrado o coeficiente de determinación)
# Proporción de la varianza en Y explicada por X
# Rango: 0 a 1 (mientras más alto, mejor)
r_cuadrado <- summary(modelo)$r.squared
print(paste("R²:", round(r_cuadrado, 4)))
print(paste("El modelo explica el", round(r_cuadrado * 100, 2), "% de la varianza"))

# R² ajustado
# Ajusta R² por el número de predictores (mejor para regresión múltiple)
r_cuadrado_adj <- summary(modelo)$adj.r.squared
print(paste("R² ajustado:", round(r_cuadrado_adj, 4)))

# Error estándar residual (RSE)
# Promedio de qué tan lejos están las observaciones de la línea de regresión
rse <- summary(modelo)$sigma
print(paste("Error estándar residual:", round(rse, 2)))

# Prueba F
# H0: El modelo no es mejor que simplemente usar la media de Y
# p-valor < 0.05 indica que el modelo es significativo
f_statistic <- summary(modelo)$fstatistic
p_valor_modelo <- pf(f_statistic[1], f_statistic[2], f_statistic[3], lower.tail = FALSE)
print(paste("p-valor del modelo:", round(p_valor_modelo, 6)))

# Prueba t para los coeficientes
# Verifica si cada coeficiente es significativamente diferente de 0
coef_summary <- summary(modelo)$coefficients
print("Pruebas de significancia de coeficientes:")
print(coef_summary)

# =============================================================================
# 3. DIAGNÓSTICO DEL MODELO
# =============================================================================

# Los supuestos de regresión lineal:
# 1. Linealidad: La relación entre X e Y es lineal
# 2. Independencia: Las observaciones son independientes
# 3. Homocedasticidad: Varianza constante de los residuos
# 4. Normalidad: Los residuos siguen una distribución normal

# Gráficos de diagnóstico
par(mfrow = c(2, 2))  # Configurar para 4 gráficos
plot(modelo)
par(mfrow = c(1, 1))  # Restaurar configuración

# Análisis individual de residuos
residuos <- residuals(modelo)
valores_ajustados <- fitted(modelo)

# 1. Gráfico de residuos vs valores ajustados (Homocedasticidad)
ggplot(data.frame(ajustados = valores_ajustados, residuos = residuos),
       aes(x = ajustados, y = residuos)) +
  geom_point(alpha = 0.6) +
  geom_hline(yintercept = 0, color = "red", linetype = "dashed") +
  geom_smooth(se = FALSE, color = "blue") +
  labs(
    title = "Residuos vs Valores Ajustados",
    subtitle = "Debe mostrar patrón aleatorio sin tendencias",
    x = "Valores Ajustados",
    y = "Residuos"
  ) +
  theme_minimal()

# 2. Q-Q Plot (Normalidad de residuos)
ggplot(data.frame(residuos = residuos), aes(sample = residuos)) +
  stat_qq() +
  stat_qq_line(color = "red") +
  labs(
    title = "Q-Q Plot de Residuos",
    subtitle = "Los puntos deben seguir la línea roja",
    x = "Cuantiles Teóricos",
    y = "Cuantiles de la Muestra"
  ) +
  theme_minimal()

# 3. Histograma de residuos
ggplot(data.frame(residuos = residuos), aes(x = residuos)) +
  geom_histogram(bins = 20, fill = "steelblue", color = "white", alpha = 0.7) +
  geom_density(aes(y = after_stat(density) * 10), color = "red", size = 1) +
  labs(
    title = "Distribución de Residuos",
    subtitle = "Debe aproximarse a una distribución normal",
    x = "Residuos",
    y = "Frecuencia"
  ) +
  theme_minimal()

# Prueba de normalidad de residuos (Shapiro-Wilk)
prueba_normalidad <- shapiro.test(residuos)
print(paste("Prueba Shapiro-Wilk p-valor:", round(prueba_normalidad$p.value, 4)))
if (prueba_normalidad$p.value > 0.05) {
  print("Los residuos parecen seguir una distribución normal")
} else {
  print("Los residuos NO parecen seguir una distribución normal")
}

# =============================================================================
# 4. PREDICCIONES
# =============================================================================

# Hacer predicciones con el modelo

# Predicción para valores específicos
nuevos_datos <- data.frame(publicidad = c(50, 75, 100))
predicciones <- predict(modelo, newdata = nuevos_datos)

print("Predicciones:")
print(data.frame(
  publicidad = nuevos_datos$publicidad,
  ventas_predichas = round(predicciones, 2)
))

# Predicciones con intervalos de confianza
predicciones_ic <- predict(modelo, newdata = nuevos_datos, interval = "confidence", level = 0.95)
print("Predicciones con IC 95%:")
print(round(predicciones_ic, 2))

# Predicciones con intervalos de predicción (más amplios)
predicciones_ip <- predict(modelo, newdata = nuevos_datos, interval = "prediction", level = 0.95)
print("Predicciones con Intervalo de Predicción 95%:")
print(round(predicciones_ip, 2))

# Visualización de predicciones
rango_publicidad <- data.frame(publicidad = seq(min(datos$publicidad),
                                                max(datos$publicidad),
                                                length.out = 100))
pred_ic <- predict(modelo, newdata = rango_publicidad, interval = "confidence")
pred_ip <- predict(modelo, newdata = rango_publicidad, interval = "prediction")

datos_pred <- data.frame(
  publicidad = rango_publicidad$publicidad,
  fit = pred_ic[, "fit"],
  ic_lwr = pred_ic[, "lwr"],
  ic_upr = pred_ic[, "upr"],
  ip_lwr = pred_ip[, "lwr"],
  ip_upr = pred_ip[, "upr"]
)

ggplot() +
  geom_ribbon(data = datos_pred, aes(x = publicidad, ymin = ip_lwr, ymax = ip_upr),
              fill = "lightblue", alpha = 0.3) +
  geom_ribbon(data = datos_pred, aes(x = publicidad, ymin = ic_lwr, ymax = ic_upr),
              fill = "steelblue", alpha = 0.4) +
  geom_line(data = datos_pred, aes(x = publicidad, y = fit), color = "red", size = 1) +
  geom_point(data = datos, aes(x = publicidad, y = ventas), alpha = 0.6) +
  labs(
    title = "Modelo con Intervalos de Confianza y Predicción",
    subtitle = "Azul oscuro: IC 95%, Azul claro: IP 95%",
    x = "Gasto en Publicidad (miles MXN)",
    y = "Ventas (miles MXN)"
  ) +
  theme_minimal()

# EJERCICIO 1: Crea un modelo de regresión
# Usa el dataset mtcars
# Predice mpg (millas por galón) usando wt (peso)
# Evalúa el modelo y haz predicciones
# Tu código aquí:
# head(mtcars)




# =============================================================================
# 5. REGRESIÓN LINEAL MÚLTIPLE
# =============================================================================

# Regresión lineal múltiple: Y = β₀ + β₁X₁ + β₂X₂ + ... + βₙXₙ + ε
# Múltiples variables predictoras

# Ejemplo: Predecir ventas usando publicidad, precio y ubicación
set.seed(456)
n <- 100
datos_multiple <- data.frame(
  publicidad = rnorm(n, mean = 50, sd = 15),
  precio = rnorm(n, mean = 100, sd = 20),
  ubicacion_score = rnorm(n, mean = 70, sd = 10)
)

# Generar ventas basadas en múltiples factores
datos_multiple$ventas <- 20 +
  2.5 * datos_multiple$publicidad -
  0.8 * datos_multiple$precio +
  1.2 * datos_multiple$ubicacion_score +
  rnorm(n, mean = 0, sd = 15)

head(datos_multiple)

# Modelo de regresión múltiple
modelo_multiple <- lm(ventas ~ publicidad + precio + ubicacion_score, data = datos_multiple)
print(summary(modelo_multiple))

# Extraer coeficientes
coef_mult <- coef(modelo_multiple)
print("Coeficientes del modelo:")
print(round(coef_mult, 2))

# Interpretación:
print("Interpretaciones:")
print(paste("- Por cada unidad adicional en publicidad, ventas aumentan",
            round(coef_mult["publicidad"], 2), "manteniendo otras variables constantes"))
print(paste("- Por cada unidad adicional en precio, ventas disminuyen",
            abs(round(coef_mult["precio"], 2)), "manteniendo otras variables constantes"))
print(paste("- Por cada unidad adicional en ubicacion_score, ventas aumentan",
            round(coef_mult["ubicacion_score"], 2), "manteniendo otras variables constantes"))

# Métricas del modelo
print(paste("R²:", round(summary(modelo_multiple)$r.squared, 4)))
print(paste("R² ajustado:", round(summary(modelo_multiple)$adj.r.squared, 4)))

# Comparar modelos simples vs múltiple
modelo_solo_pub <- lm(ventas ~ publicidad, data = datos_multiple)
modelo_pub_precio <- lm(ventas ~ publicidad + precio, data = datos_multiple)

# Comparación de R²
print("Comparación de modelos:")
print(paste("Solo publicidad - R²:", round(summary(modelo_solo_pub)$r.squared, 4)))
print(paste("Publicidad + Precio - R²:", round(summary(modelo_pub_precio)$r.squared, 4)))
print(paste("Modelo completo - R²:", round(summary(modelo_multiple)$r.squared, 4)))

# ANOVA para comparar modelos
anova_modelos <- anova(modelo_solo_pub, modelo_pub_precio, modelo_multiple)
print("ANOVA de comparación de modelos:")
print(anova_modelos)

# Verificar multicolinealidad (VIF - Variance Inflation Factor)
# VIF > 10 indica multicolinealidad problemática
# Necesita el paquete car
# install.packages("car")
library(car)
vif_valores <- vif(modelo_multiple)
print("VIF (Variance Inflation Factor):")
print(vif_valores)

# Predicciones con modelo múltiple
nuevos_datos_mult <- data.frame(
  publicidad = c(40, 60, 80),
  precio = c(90, 100, 110),
  ubicacion_score = c(65, 75, 85)
)

predicciones_mult <- predict(modelo_multiple, newdata = nuevos_datos_mult,
                             interval = "confidence")
print("Predicciones del modelo múltiple:")
print(round(predicciones_mult, 2))

# Importancia relativa de predictores
# Coeficientes estandarizados
datos_estandarizados <- as.data.frame(scale(datos_multiple))
modelo_estandarizado <- lm(ventas ~ publicidad + precio + ubicacion_score,
                          data = datos_estandarizados)
coef_std <- coef(modelo_estandarizado)[-1]  # Excluir intercepto

importancia_df <- data.frame(
  variable = names(coef_std),
  coeficiente_std = abs(coef_std)
) %>% arrange(desc(coeficiente_std))

print("Importancia relativa de variables (coeficientes estandarizados):")
print(importancia_df)

ggplot(importancia_df, aes(x = reorder(variable, coeficiente_std),
                           y = coeficiente_std, fill = variable)) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Importancia de Variables Predictoras",
    subtitle = "Basado en coeficientes estandarizados",
    x = "Variable",
    y = "Importancia (Coef. Estandarizado)"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

# EJERCICIO 2: Regresión múltiple con mtcars
# Predice mpg usando hp, wt, y cyl
# Evalúa el modelo y calcula VIF
# Tu código aquí:




# =============================================================================
# EJEMPLO PRÁCTICO: PREDICCIÓN DE PRECIO DE CASAS
# =============================================================================

# Datos de casas
set.seed(789)
n_casas <- 200
casas <- data.frame(
  metros_cuadrados = rnorm(n_casas, mean = 120, sd = 30),
  habitaciones = sample(1:5, n_casas, replace = TRUE),
  antiguedad = sample(0:30, n_casas, replace = TRUE),
  distancia_centro = rnorm(n_casas, mean = 10, sd = 5)
)

# Generar precio basado en características
casas$precio <- 500000 +
  3000 * casas$metros_cuadrados +
  50000 * casas$habitaciones -
  5000 * casas$antiguedad -
  8000 * casas$distancia_centro +
  rnorm(n_casas, mean = 0, sd = 50000)

# Asegurar precios positivos
casas$precio <- pmax(casas$precio, 100000)

print("=== MODELO DE PREDICCIÓN DE PRECIOS DE CASAS ===")

# 1. Exploración inicial
print("Correlaciones con precio:")
correlaciones <- cor(casas)[, "precio"]
print(round(sort(correlaciones, decreasing = TRUE), 3))

# 2. Crear modelo
modelo_casas <- lm(precio ~ metros_cuadrados + habitaciones +
                   antiguedad + distancia_centro, data = casas)
print(summary(modelo_casas))

# 3. Evaluación
print(paste("R² del modelo:", round(summary(modelo_casas)$r.squared, 4)))
print(paste("Error estándar:", round(summary(modelo_casas)$sigma, 2)))

# 4. Diagnóstico visual
residuos_casas <- residuals(modelo_casas)
ggplot(data.frame(residuos = residuos_casas), aes(x = residuos)) +
  geom_histogram(bins = 30, fill = "coral", color = "white", alpha = 0.7) +
  labs(
    title = "Distribución de Residuos - Modelo de Precios",
    x = "Residuos",
    y = "Frecuencia"
  ) +
  theme_minimal()

# 5. Predicción para una casa nueva
casa_nueva <- data.frame(
  metros_cuadrados = 150,
  habitaciones = 3,
  antiguedad = 5,
  distancia_centro = 8
)

precio_predicho <- predict(modelo_casas, newdata = casa_nueva, interval = "prediction")
print("Predicción de precio para casa nueva:")
print(paste("Precio estimado:", format(round(precio_predicho[1], 0), big.mark = ",")))
print(paste("IC 95%: [", format(round(precio_predicho[2], 0), big.mark = ","),
            "-", format(round(precio_predicho[3], 0), big.mark = ","), "]"))

# =============================================================================
# RESUMEN DE LA LECCIÓN
# =============================================================================
# ✓ Regresión lineal simple: lm(Y ~ X)
# ✓ Evaluación: R², R² ajustado, RSE, prueba F
# ✓ Diagnóstico: residuos, Q-Q plot, homocedasticidad
# ✓ Predicciones: predict() con IC y IP
# ✓ Regresión múltiple: lm(Y ~ X1 + X2 + X3)
# ✓ Multicolinealidad: VIF
# ✓ Comparación de modelos: anova()

# =============================================================================
# ¡Felicidades! Has completado la Lección 1 del Módulo 5
# Continúa con leccion2_modelos_clasificacion.R
# =============================================================================
