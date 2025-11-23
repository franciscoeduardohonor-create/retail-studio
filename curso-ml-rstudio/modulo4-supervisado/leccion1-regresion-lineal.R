# ============================================================================
# MÓDULO 4 - LECCIÓN 1: REGRESIÓN LINEAL
# ============================================================================
# Descripción: Tu primer algoritmo de Machine Learning. Aprenderás regresión
#              lineal simple y múltiple para predecir valores continuos
# Nivel: Intermedio
# Duración estimada: 5-6 horas
# Prerequisito: Módulos 1-3 completados
# ============================================================================

# Cargar librerías
library(ggplot2)
library(dplyr)
library(caret)     # Para ML y validación
library(gridExtra) # Para múltiples gráficos

cat("==================================================\n")
cat("  MÓDULO 4: MACHINE LEARNING SUPERVISADO\n")
cat("  Lección 1: Regresión Lineal\n")
cat("==================================================\n\n")

# ----------------------------------------------------------------------------
# SECCIÓN 1: ¿QUÉ ES LA REGRESIÓN LINEAL?
# ----------------------------------------------------------------------------

cat("=== ¿QUÉ ES LA REGRESIÓN LINEAL? ===\n\n")

# La regresión lineal es un algoritmo de ML supervisado que:
# - Predice valores CONTINUOS (números)
# - Encuentra la relación lineal entre variables
# - Es el algoritmo más fundamental de ML

# Ecuación: y = β₀ + β₁x₁ + β₂x₂ + ... + βₙxₙ + ε
# Donde:
# - y: variable objetivo (lo que queremos predecir)
# - x: variables predictoras (features)
# - β₀: intercepto (valor cuando todas las x son 0)
# - β₁, β₂, ...: coeficientes (pendientes)
# - ε: error aleatorio

# Casos de uso:
# - Predecir ventas basándose en inversión en marketing
# - Predecir precio de casas basándose en características
# - Predecir salario basándose en años de experiencia

# ----------------------------------------------------------------------------
# SECCIÓN 2: REGRESIÓN LINEAL SIMPLE (Una variable)
# ----------------------------------------------------------------------------

cat("=== REGRESIÓN LINEAL SIMPLE ===\n\n")

# Ejemplo: Predecir ventas basándose en inversión en publicidad

# Crear datos de ejemplo
set.seed(42)
n <- 100

publicidad <- data.frame(
  inversion_publicidad = runif(n, min = 1000, max = 50000),
  ventas = numeric(n)
)

# Generar ventas con relación lineal + ruido
publicidad$ventas <- 20000 +
                     0.8 * publicidad$inversion_publicidad +
                     rnorm(n, mean = 0, sd = 5000)

head(publicidad, 10)

# Visualizar los datos
ggplot(publicidad, aes(x = inversion_publicidad, y = ventas)) +
  geom_point(alpha = 0.6, color = "blue") +
  labs(
    title = "Relación entre Inversión en Publicidad y Ventas",
    x = "Inversión en Publicidad ($)",
    y = "Ventas ($)"
  ) +
  theme_minimal()

# ENTRENAR EL MODELO
# Función lm() (linear model)
modelo_simple <- lm(ventas ~ inversion_publicidad, data = publicidad)

# Ver resumen del modelo
summary(modelo_simple)

cat("\n=== INTERPRETACIÓN DEL RESUMEN ===\n")
cat("Coefficients:\n")
cat("  - Intercept: Ventas cuando inversión = 0\n")
cat("  - inversion_publicidad: Por cada $1 más en publicidad,\n")
cat("    las ventas aumentan en este valor\n")
cat("  - Pr(>|t|): p-value, si < 0.05 la variable es significativa\n")
cat("\nR-squared: Qué tan bien el modelo explica los datos\n")
cat("  - 0 = No explica nada\n")
cat("  - 1 = Explica perfectamente\n")
cat("  - > 0.7 = Buen modelo\n\n")

# Extraer coeficientes
coeficientes <- coef(modelo_simple)
intercepto <- coeficientes[1]
pendiente <- coeficientes[2]

cat("Intercepto:", intercepto, "\n")
cat("Pendiente:", pendiente, "\n")
cat("\nEcuación del modelo:\n")
cat("Ventas = ", round(intercepto, 2), " + ",
    round(pendiente, 4), " * Inversión\n\n", sep = "")

# HACER PREDICCIONES

# Predicción sobre datos existentes
publicidad$ventas_predichas <- predict(modelo_simple, publicidad)

head(publicidad, 10)

# Predicción sobre nuevos datos
nuevos_datos <- data.frame(
  inversion_publicidad = c(10000, 25000, 40000)
)

predicciones_nuevas <- predict(modelo_simple, nuevos_datos)

cat("=== PREDICCIONES PARA NUEVOS VALORES ===\n")
for(i in 1:nrow(nuevos_datos)) {
  cat("Inversión: $", nuevos_datos$inversion_publicidad[i],
      " -> Ventas predichas: $", round(predicciones_nuevas[i], 2), "\n")
}

# Visualizar modelo
ggplot(publicidad, aes(x = inversion_publicidad, y = ventas)) +
  geom_point(alpha = 0.6, color = "blue") +
  geom_line(aes(y = ventas_predichas), color = "red", size = 1.2) +
  labs(
    title = "Modelo de Regresión Lineal",
    subtitle = paste("R² =", round(summary(modelo_simple)$r.squared, 4)),
    x = "Inversión en Publicidad ($)",
    y = "Ventas ($)"
  ) +
  theme_minimal()

# ----------------------------------------------------------------------------
# SECCIÓN 3: EVALUACIÓN DEL MODELO
# ----------------------------------------------------------------------------

cat("\n=== EVALUACIÓN DEL MODELO ===\n\n")

# Métricas de evaluación

# 1. R-squared (R²)
r_cuadrado <- summary(modelo_simple)$r.squared
cat("R²:", r_cuadrado, "\n")
cat("  Interpretación: El modelo explica el",
    round(r_cuadrado * 100, 2), "% de la variabilidad\n\n")

# 2. RMSE (Root Mean Squared Error)
# Promedio de los errores en las mismas unidades que y
residuos <- publicidad$ventas - publicidad$ventas_predichas
rmse <- sqrt(mean(residuos^2))
cat("RMSE:", round(rmse, 2), "\n")
cat("  Interpretación: En promedio, el modelo se equivoca por $",
    round(rmse, 2), "\n\n")

# 3. MAE (Mean Absolute Error)
mae <- mean(abs(residuos))
cat("MAE:", round(mae, 2), "\n")
cat("  Interpretación: Error absoluto promedio de $",
    round(mae, 2), "\n\n")

# 4. MAPE (Mean Absolute Percentage Error)
mape <- mean(abs(residuos / publicidad$ventas)) * 100
cat("MAPE:", round(mape, 2), "%\n")
cat("  Interpretación: Error promedio del",
    round(mape, 2), "%\n\n")

# Análisis de residuos (diferencia entre real y predicho)
publicidad$residuos <- residuos

# Gráfico de residuos
p1 <- ggplot(publicidad, aes(x = ventas_predichas, y = residuos)) +
  geom_point(alpha = 0.6) +
  geom_hline(yintercept = 0, color = "red", linetype = "dashed") +
  labs(
    title = "Residuos vs Valores Predichos",
    x = "Valores Predichos",
    y = "Residuos"
  ) +
  theme_minimal()

# QQ-plot (verifica normalidad de residuos)
p2 <- ggplot(publicidad, aes(sample = residuos)) +
  stat_qq() +
  stat_qq_line(color = "red") +
  labs(
    title = "Q-Q Plot",
    x = "Teórico",
    y = "Muestra"
  ) +
  theme_minimal()

# Histograma de residuos
p3 <- ggplot(publicidad, aes(x = residuos)) +
  geom_histogram(bins = 30, fill = "lightblue", color = "white") +
  labs(
    title = "Distribución de Residuos",
    x = "Residuos",
    y = "Frecuencia"
  ) +
  theme_minimal()

grid.arrange(p1, p2, p3, ncol = 2)

# Supuestos de la regresión lineal:
# 1. Linealidad: La relación es lineal
# 2. Homocedasticidad: Varianza constante de residuos
# 3. Normalidad: Los residuos siguen distribución normal
# 4. Independencia: Las observaciones son independientes

# ----------------------------------------------------------------------------
# SECCIÓN 4: REGRESIÓN LINEAL MÚLTIPLE (Múltiples variables)
# ----------------------------------------------------------------------------

cat("\n=== REGRESIÓN LINEAL MÚLTIPLE ===\n\n")

# Ejemplo: Predecir ventas basándose en múltiples factores

# Crear dataset más completo
set.seed(123)
n <- 200

ventas_data <- data.frame(
  inversion_tv = runif(n, 0, 50000),
  inversion_radio = runif(n, 0, 30000),
  inversion_internet = runif(n, 0, 40000),
  precio_promedio = runif(n, 50, 500),
  competencia = sample(1:10, n, replace = TRUE)
)

# Generar ventas con relación lineal compleja
ventas_data$ventas <- 10000 +
                      0.5 * ventas_data$inversion_tv +
                      0.3 * ventas_data$inversion_radio +
                      0.7 * ventas_data$inversion_internet -
                      20 * ventas_data$precio_promedio -
                      500 * ventas_data$competencia +
                      rnorm(n, 0, 5000)

head(ventas_data)

# ENTRENAR MODELO MÚLTIPLE
modelo_multiple <- lm(ventas ~ inversion_tv + inversion_radio +
                              inversion_internet + precio_promedio +
                              competencia,
                     data = ventas_data)

summary(modelo_multiple)

cat("\n=== INTERPRETACIÓN ===\n")
cat("Cada coeficiente representa el efecto de esa variable\n")
cat("MANTENIENDO LAS DEMÁS CONSTANTES\n\n")

# Predicciones
ventas_data$prediccion <- predict(modelo_multiple, ventas_data)

# Evaluación
cat("=== MÉTRICAS DEL MODELO MÚLTIPLE ===\n")
cat("R²:", summary(modelo_multiple)$r.squared, "\n")
cat("R² Ajustado:", summary(modelo_multiple)$adj.r.squared, "\n")

residuos_multiple <- ventas_data$ventas - ventas_data$prediccion
cat("RMSE:", sqrt(mean(residuos_multiple^2)), "\n\n")

# Visualizar predicciones vs reales
ggplot(ventas_data, aes(x = prediccion, y = ventas)) +
  geom_point(alpha = 0.5, color = "blue") +
  geom_abline(intercept = 0, slope = 1, color = "red", size = 1) +
  labs(
    title = "Valores Reales vs Predichos",
    subtitle = paste("R² =", round(summary(modelo_multiple)$r.squared, 4)),
    x = "Valores Predichos",
    y = "Valores Reales"
  ) +
  theme_minimal()

# ----------------------------------------------------------------------------
# SECCIÓN 5: DIVISIÓN TRAIN/TEST
# ----------------------------------------------------------------------------

cat("\n=== DIVISIÓN TRAIN/TEST ===\n\n")

# En ML, SIEMPRE dividimos los datos:
# - Training set (70-80%): Para entrenar el modelo
# - Test set (20-30%): Para evaluar el modelo

# Establecer semilla para reproducibilidad
set.seed(42)

# Crear índices para división
indices_train <- sample(1:nrow(ventas_data), 0.7 * nrow(ventas_data))

# Dividir datos
train_data <- ventas_data[indices_train, ]
test_data <- ventas_data[-indices_train, ]

cat("Datos de entrenamiento:", nrow(train_data), "filas\n")
cat("Datos de prueba:", nrow(test_data), "filas\n\n")

# Entrenar modelo SOLO con datos de entrenamiento
modelo_train <- lm(ventas ~ inversion_tv + inversion_radio +
                           inversion_internet + precio_promedio +
                           competencia,
                  data = train_data)

summary(modelo_train)

# Evaluar en datos de ENTRENAMIENTO
pred_train <- predict(modelo_train, train_data)
rmse_train <- sqrt(mean((train_data$ventas - pred_train)^2))

# Evaluar en datos de PRUEBA
pred_test <- predict(modelo_train, test_data)
rmse_test <- sqrt(mean((test_data$ventas - pred_test)^2))

cat("\n=== EVALUACIÓN ===\n")
cat("RMSE Entrenamiento:", round(rmse_train, 2), "\n")
cat("RMSE Prueba:", round(rmse_test, 2), "\n\n")

if (rmse_test < rmse_train * 1.1) {
  cat("✓ Buen modelo: RMSE de prueba similar al de entrenamiento\n")
} else {
  cat("⚠ Posible overfitting: RMSE de prueba mucho mayor\n")
}

# ----------------------------------------------------------------------------
# SECCIÓN 6: VALIDACIÓN CRUZADA
# ----------------------------------------------------------------------------

cat("\n\n=== VALIDACIÓN CRUZADA ===\n\n")

# La validación cruzada divide los datos en K partes (folds)
# Entrena K veces, cada vez usando una parte diferente para test

# Configurar validación cruzada de 10 folds
control <- trainControl(method = "cv", number = 10)

# Entrenar modelo con validación cruzada
modelo_cv <- train(
  ventas ~ inversion_tv + inversion_radio + inversion_internet +
          precio_promedio + competencia,
  data = ventas_data,
  method = "lm",
  trControl = control
)

print(modelo_cv)

cat("\n=== INTERPRETACIÓN ===\n")
cat("RMSE:", modelo_cv$results$RMSE, "\n")
cat("R²:", modelo_cv$results$Rsquared, "\n")
cat("\nEstas métricas son más confiables que train/test simple\n")
cat("porque prueban el modelo en múltiples divisiones\n\n")

# ----------------------------------------------------------------------------
# SECCIÓN 7: SELECCIÓN DE VARIABLES
# ----------------------------------------------------------------------------

cat("=== SELECCIÓN DE VARIABLES ===\n\n")

# No todas las variables son importantes
# Veamos cuáles son significativas

# Método 1: Ver p-values en summary
summary(modelo_multiple)

# Método 2: Importancia de variables
importancia <- varImp(modelo_cv)
print(importancia)

# Visualizar importancia
plot(importancia, main = "Importancia de Variables")

# Método 3: Stepwise selection (paso a paso)
# Backward elimination
modelo_completo <- lm(ventas ~ ., data = ventas_data)
modelo_step <- step(modelo_completo, direction = "backward", trace = 0)

cat("\n=== MODELO DESPUÉS DE SELECCIÓN ===\n")
summary(modelo_step)

# ----------------------------------------------------------------------------
# SECCIÓN 8: EJEMPLO PRÁCTICO COMPLETO
# ----------------------------------------------------------------------------

cat("\n\n=== EJEMPLO PRÁCTICO: PREDICCIÓN DE PRECIOS DE CASAS ===\n\n")

# Crear dataset de precios de casas
set.seed(2025)
n <- 500

casas <- data.frame(
  metros_cuadrados = runif(n, 50, 300),
  num_habitaciones = sample(1:5, n, replace = TRUE),
  num_banos = sample(1:4, n, replace = TRUE),
  antiguedad_años = runif(n, 0, 50),
  distancia_centro_km = runif(n, 1, 30)
)

# Generar precio basado en características
casas$precio <- 50000 +
                2000 * casas$metros_cuadrados +
                15000 * casas$num_habitaciones +
                20000 * casas$num_banos -
                1000 * casas$antiguedad_años -
                2000 * casas$distancia_centro_km +
                rnorm(n, 0, 50000)

# Asegurar precios positivos
casas$precio <- pmax(casas$precio, 100000)

head(casas, 10)

# Análisis exploratorio
cat("\n=== ESTADÍSTICAS DESCRIPTIVAS ===\n")
summary(casas)

# Correlaciones
cat("\n=== MATRIZ DE CORRELACIÓN ===\n")
cor_matrix <- cor(casas)
print(round(cor_matrix, 2))

# Visualizar correlaciones
library(corrplot)
corrplot(cor_matrix, method = "color", type = "upper",
        addCoef.col = "black", number.cex = 0.7)

# División train/test
set.seed(42)
indices <- sample(1:nrow(casas), 0.75 * nrow(casas))
train <- casas[indices, ]
test <- casas[-indices, ]

cat("\n=== DIVISIÓN DE DATOS ===\n")
cat("Train:", nrow(train), "casas\n")
cat("Test:", nrow(test), "casas\n\n")

# Entrenar modelo
modelo_casas <- lm(precio ~ ., data = train)
summary(modelo_casas)

# Predicciones
pred_train_casas <- predict(modelo_casas, train)
pred_test_casas <- predict(modelo_casas, test)

# Evaluación
cat("\n=== EVALUACIÓN DEL MODELO ===\n")

# RMSE
rmse_train_casas <- sqrt(mean((train$precio - pred_train_casas)^2))
rmse_test_casas <- sqrt(mean((test$precio - pred_test_casas)^2))

cat("RMSE Train: $", round(rmse_train_casas, 2), "\n")
cat("RMSE Test: $", round(rmse_test_casas, 2), "\n\n")

# R²
r2_train <- summary(lm(train$precio ~ pred_train_casas))$r.squared
r2_test <- summary(lm(test$precio ~ pred_test_casas))$r.squared

cat("R² Train:", round(r2_train, 4), "\n")
cat("R² Test:", round(r2_test, 4), "\n\n")

# MAPE
mape_test <- mean(abs((test$precio - pred_test_casas) / test$precio)) * 100
cat("MAPE Test:", round(mape_test, 2), "%\n\n")

# Visualizar resultados
test$prediccion <- pred_test_casas

ggplot(test, aes(x = precio, y = prediccion)) +
  geom_point(alpha = 0.6, color = "blue") +
  geom_abline(intercept = 0, slope = 1, color = "red", size = 1) +
  labs(
    title = "Predicción de Precios de Casas",
    subtitle = paste("R² =", round(r2_test, 4), "| MAPE =", round(mape_test, 2), "%"),
    x = "Precio Real ($)",
    y = "Precio Predicho ($)"
  ) +
  theme_minimal() +
  scale_x_continuous(labels = scales::comma) +
  scale_y_continuous(labels = scales::comma)

# Ejemplos de predicción
cat("=== EJEMPLOS DE PREDICCIÓN ===\n\n")

nuevas_casas <- data.frame(
  metros_cuadrados = c(100, 150, 200),
  num_habitaciones = c(2, 3, 4),
  num_banos = c(1, 2, 2),
  antiguedad_años = c(5, 10, 2),
  distancia_centro_km = c(10, 5, 15)
)

predicciones_casas <- predict(modelo_casas, nuevas_casas)

for(i in 1:nrow(nuevas_casas)) {
  cat("Casa", i, ":\n")
  cat("  - Metros cuadrados:", nuevas_casas$metros_cuadrados[i], "\n")
  cat("  - Habitaciones:", nuevas_casas$num_habitaciones[i], "\n")
  cat("  - Baños:", nuevas_casas$num_banos[i], "\n")
  cat("  - Antigüedad:", nuevas_casas$antiguedad_años[i], "años\n")
  cat("  - Distancia al centro:", nuevas_casas$distancia_centro_km[i], "km\n")
  cat("  PRECIO PREDICHO: $", format(round(predicciones_casas[i], 2), big.mark = ","), "\n\n")
}

# ----------------------------------------------------------------------------
# SECCIÓN 9: EJERCICIOS PRÁCTICOS
# ----------------------------------------------------------------------------

cat("=== EJERCICIOS PARA PRACTICAR ===\n\n")

cat("EJERCICIO 1: Predecir salarios\n")
cat("Crea un modelo para predecir salarios basándote en:\n")
cat("- Años de experiencia\n")
cat("- Nivel de educación\n")
cat("- Horas trabajadas por semana\n\n")

cat("EJERCICIO 2: Optimizar inversión en marketing\n")
cat("Usando el modelo de publicidad, encuentra:\n")
cat("- Cuánto invertir para lograr ventas de $50,000\n")
cat("- Qué canal de marketing es más efectivo\n\n")

cat("EJERCICIO 3: Comparar modelos\n")
cat("Crea tres modelos diferentes y compara:\n")
cat("- Modelo con todas las variables\n")
cat("- Modelo con selección stepwise\n")
cat("- Modelo solo con variables significativas\n")
cat("¿Cuál funciona mejor?\n\n")

# ----------------------------------------------------------------------------
# RESUMEN
# ----------------------------------------------------------------------------

cat("\n=== RESUMEN DE LA LECCIÓN ===\n")
cat("Aprendiste:\n\n")
cat("✓ Qué es la regresión lineal y cuándo usarla\n")
cat("✓ Regresión lineal simple (1 variable)\n")
cat("✓ Regresión lineal múltiple (múltiples variables)\n")
cat("✓ Métricas de evaluación: R², RMSE, MAE, MAPE\n")
cat("✓ División train/test\n")
cat("✓ Validación cruzada\n")
cat("✓ Selección de variables\n")
cat("✓ Análisis de residuos\n")
cat("✓ Proyecto completo de predicción de precios\n\n")

cat("CONCEPTOS CLAVE:\n")
cat("- SIEMPRE dividir datos en train/test\n")
cat("- NUNCA evaluar en los datos de entrenamiento\n")
cat("- Verificar supuestos del modelo\n")
cat("- Interpretar coeficientes correctamente\n\n")

cat("Siguiente: Lección 2 - Regresión Logística (Clasificación)\n")

# ============================================================================
# FIN DE LA LECCIÓN
# ============================================================================
