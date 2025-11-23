# =============================================================================
# MÓDULO 5: MODELOS ESTADÍSTICOS AVANZADOS
# Lección 2: Regresión Logística (Clasificación)
# =============================================================================

# La regresión logística se usa para predecir variables categóricas binarias
# (Sí/No, 1/0, Éxito/Fracaso, etc.)

# CONTENIDO:
# 1. Introducción a la regresión logística
# 2. Crear y evaluar modelo logístico
# 3. Interpretación de coeficientes (Odds Ratios)
# 4. Matriz de confusión
# 5. Curva ROC y AUC
# 6. Predicciones y probabilidades

# =============================================================================
# PREPARACIÓN
# =============================================================================

library(ggplot2)
library(dplyr)

# =============================================================================
# 1. INTRODUCCIÓN A LA REGRESIÓN LOGÍSTICA
# =============================================================================

# Regresión logística modela la probabilidad de que Y = 1
# P(Y=1) = 1 / (1 + e^-(β₀ + β₁X₁ + ... + βₙXₙ))
# Función logística (sigmoide) transforma valores reales a probabilidades [0,1]

# Ejemplo: Predecir si un cliente comprará un producto
set.seed(123)
n <- 200
datos_compra <- data.frame(
  edad = round(rnorm(n, mean = 40, sd = 15)),
  ingresos = round(rnorm(n, mean = 50000, sd = 20000)),
  visitas_web = round(abs(rnorm(n, mean = 10, sd = 5)))
)

# Asegurar valores razonables
datos_compra$edad <- pmax(pmin(datos_compra$edad, 80), 18)
datos_compra$ingresos <- pmax(datos_compra$ingresos, 10000)

# Generar variable de compra basada en características
# Mayor probabilidad si: mayor ingreso, más visitas
logit <- -5 +
  0.00005 * datos_compra$ingresos +
  0.2 * datos_compra$visitas_web
probabilidad <- 1 / (1 + exp(-logit))
datos_compra$compra <- rbinom(n, 1, prob = probabilidad)

# Convertir a factor
datos_compra$compra_factor <- factor(datos_compra$compra,
                                    levels = c(0, 1),
                                    labels = c("No", "Sí"))

head(datos_compra, 10)

# Exploración inicial
print("Distribución de compras:")
table(datos_compra$compra_factor)
print(prop.table(table(datos_compra$compra_factor)))

# Visualización
ggplot(datos_compra, aes(x = ingresos, y = compra, color = compra_factor)) +
  geom_point(alpha = 0.5, position = position_jitter(height = 0.05)) +
  labs(
    title = "Relación entre Ingresos y Probabilidad de Compra",
    x = "Ingresos",
    y = "Compra (0 = No, 1 = Sí)",
    color = "Compró"
  ) +
  theme_minimal()

# =============================================================================
# 2. CREAR MODELO DE REGRESIÓN LOGÍSTICA
# =============================================================================

# Sintaxis: glm(Y ~ X, family = binomial, data = datos)
# family = binomial indica regresión logística

# Modelo simple con una variable
modelo_simple <- glm(compra ~ ingresos, family = binomial, data = datos_compra)
print(summary(modelo_simple))

# Modelo múltiple
modelo_logistico <- glm(compra ~ ingresos + visitas_web + edad,
                       family = binomial,
                       data = datos_compra)

print(summary(modelo_logistico))

# Prueba de significancia global (prueba de devianza)
prueba_devianza <- anova(modelo_logistico, test = "Chisq")
print(prueba_devianza)

# =============================================================================
# 3. INTERPRETACIÓN DE COEFICIENTES (ODDS RATIOS)
# =============================================================================

# Los coeficientes en escala logit son difíciles de interpretar
# Convertimos a Odds Ratios (razón de probabilidades)

coeficientes <- coef(modelo_logistico)
print("Coeficientes (escala logit):")
print(coeficientes)

# Convertir a Odds Ratios
odds_ratios <- exp(coeficientes)
print("Odds Ratios:")
print(round(odds_ratios, 4))

# Interpretación:
print("\nInterpretaciones:")
print(paste("- Por cada 1000 pesos adicionales de ingreso,",
            "las probabilidades de compra se multiplican por",
            round(exp(coeficientes["ingresos"] * 1000), 3)))
print(paste("- Por cada visita adicional al sitio web,",
            "las probabilidades de compra se multiplican por",
            round(odds_ratios["visitas_web"], 3)))

# Intervalos de confianza para Odds Ratios
ic_or <- exp(confint(modelo_logistico))
print("Intervalos de confianza 95% para Odds Ratios:")
print(round(ic_or, 4))

# Visualización de Odds Ratios
or_df <- data.frame(
  variable = names(odds_ratios)[-1],  # Excluir intercepto
  odds_ratio = odds_ratios[-1],
  ic_lower = ic_or[-1, 1],
  ic_upper = ic_or[-1, 2]
)

ggplot(or_df, aes(x = variable, y = odds_ratio)) +
  geom_point(size = 4, color = "steelblue") +
  geom_errorbar(aes(ymin = ic_lower, ymax = ic_upper), width = 0.2) +
  geom_hline(yintercept = 1, linetype = "dashed", color = "red") +
  labs(
    title = "Odds Ratios con Intervalos de Confianza 95%",
    subtitle = "Línea roja en 1 = sin efecto",
    x = "Variable",
    y = "Odds Ratio"
  ) +
  theme_minimal() +
  coord_flip()

# =============================================================================
# 4. PREDICCIONES Y PROBABILIDADES
# =============================================================================

# Predecir probabilidades
probabilidades_pred <- predict(modelo_logistico, type = "response")
head(data.frame(
  ingresos = datos_compra$ingresos[1:10],
  visitas = datos_compra$visitas_web[1:10],
  prob_predicha = round(probabilidades_pred[1:10], 3),
  compra_real = datos_compra$compra[1:10]
))

# Predecir clase (0 o 1) usando umbral de 0.5
predicciones_clase <- ifelse(probabilidades_pred > 0.5, 1, 0)

# Agregar predicciones al dataset
datos_compra$prob_predicha <- probabilidades_pred
datos_compra$pred_clase <- predicciones_clase

# Visualización de probabilidades predichas
ggplot(datos_compra, aes(x = ingresos, y = prob_predicha, color = compra_factor)) +
  geom_point(alpha = 0.6) +
  geom_hline(yintercept = 0.5, linetype = "dashed", color = "red") +
  labs(
    title = "Probabilidades Predichas de Compra",
    x = "Ingresos",
    y = "Probabilidad Predicha",
    color = "Compra Real"
  ) +
  theme_minimal()

# Predicción para nuevos clientes
nuevos_clientes <- data.frame(
  edad = c(30, 45, 60),
  ingresos = c(40000, 70000, 90000),
  visitas_web = c(5, 12, 20)
)

prob_nuevos <- predict(modelo_logistico, newdata = nuevos_clientes, type = "response")
pred_nuevos <- ifelse(prob_nuevos > 0.5, "Sí", "No")

print("Predicciones para nuevos clientes:")
print(data.frame(
  nuevos_clientes,
  probabilidad = round(prob_nuevos, 3),
  prediccion = pred_nuevos
))

# =============================================================================
# 5. MATRIZ DE CONFUSIÓN
# =============================================================================

# Matriz de confusión: compara predicciones vs valores reales
tabla_confusion <- table(Real = datos_compra$compra, Predicho = predicciones_clase)
print("Matriz de Confusión:")
print(tabla_confusion)

# Calcular métricas
VP <- tabla_confusion[2, 2]  # Verdaderos Positivos
VN <- tabla_confusion[1, 1]  # Verdaderos Negativos
FP <- tabla_confusion[1, 2]  # Falsos Positivos
FN <- tabla_confusion[2, 1]  # Falsos Negativos

# Exactitud (Accuracy)
exactitud <- (VP + VN) / sum(tabla_confusion)
print(paste("Exactitud:", round(exactitud, 4)))

# Sensibilidad (Sensitivity/Recall/True Positive Rate)
sensibilidad <- VP / (VP + FN)
print(paste("Sensibilidad:", round(sensibilidad, 4)))

# Especificidad (Specificity/True Negative Rate)
especificidad <- VN / (VN + FP)
print(paste("Especificidad:", round(especificidad, 4)))

# Precisión (Precision/Positive Predictive Value)
precision <- VP / (VP + FP)
print(paste("Precisión:", round(precision, 4)))

# F1 Score (media armónica de precisión y sensibilidad)
f1_score <- 2 * (precision * sensibilidad) / (precision + sensibilidad)
print(paste("F1 Score:", round(f1_score, 4)))

# Visualización de matriz de confusión
library(tidyr)
conf_matrix_df <- as.data.frame(tabla_confusion)

ggplot(conf_matrix_df, aes(x = Predicho, y = Real, fill = Freq)) +
  geom_tile() +
  geom_text(aes(label = Freq), color = "white", size = 10) +
  scale_fill_gradient(low = "lightblue", high = "steelblue") +
  labs(
    title = "Matriz de Confusión",
    x = "Predicción",
    y = "Valor Real"
  ) +
  theme_minimal()

# =============================================================================
# 6. CURVA ROC Y AUC
# =============================================================================

# ROC (Receiver Operating Characteristic) curve
# Muestra el trade-off entre sensibilidad y especificidad
# AUC (Area Under the Curve): medida global de desempeño (0.5 a 1)

# Instalar y cargar pROC si no está instalado
# install.packages("pROC")
library(pROC)

# Crear curva ROC
roc_obj <- roc(datos_compra$compra, probabilidades_pred)
print(roc_obj)

# AUC
auc_valor <- auc(roc_obj)
print(paste("AUC:", round(auc_valor, 4)))

# Interpretación del AUC:
# 0.5: Modelo aleatorio (no tiene capacidad predictiva)
# 0.7-0.8: Aceptable
# 0.8-0.9: Excelente
# >0.9: Sobresaliente

# Visualización de curva ROC
plot(roc_obj,
     main = paste("Curva ROC (AUC =", round(auc_valor, 3), ")"),
     col = "steelblue",
     lwd = 2)
abline(a = 0, b = 1, lty = 2, col = "red")  # Línea diagonal (modelo aleatorio)

# Encontrar umbral óptimo (maximiza Youden's Index)
coords_optimas <- coords(roc_obj, "best", ret = "threshold")
print(paste("Umbral óptimo:", round(coords_optimas, 3)))

# Reclasificar con umbral óptimo
predicciones_optimas <- ifelse(probabilidades_pred > coords_optimas, 1, 0)
tabla_conf_optima <- table(Real = datos_compra$compra, Predicho = predicciones_optimas)
print("Matriz de Confusión con Umbral Óptimo:")
print(tabla_conf_optima)

# =============================================================================
# 7. COMPARACIÓN DE MODELOS
# =============================================================================

# Comparar modelos con diferentes variables
modelo1 <- glm(compra ~ ingresos, family = binomial, data = datos_compra)
modelo2 <- glm(compra ~ ingresos + visitas_web, family = binomial, data = datos_compra)
modelo3 <- glm(compra ~ ingresos + visitas_web + edad, family = binomial, data = datos_compra)

# AIC (Akaike Information Criterion) - menor es mejor
print("Comparación de modelos (AIC):")
print(paste("Modelo 1 (solo ingresos):", round(AIC(modelo1), 2)))
print(paste("Modelo 2 (ingresos + visitas):", round(AIC(modelo2), 2)))
print(paste("Modelo 3 (completo):", round(AIC(modelo3), 2)))

# Prueba de razón de verosimilitud
anova(modelo1, modelo2, modelo3, test = "Chisq")

# EJERCICIO 1: Crea un modelo de regresión logística
# Predice si un estudiante aprobará (>= 80) basado en horas de estudio
set.seed(456)
estudiantes <- data.frame(
  horas_estudio = round(abs(rnorm(100, mean = 15, sd = 8))),
  asistencia = round(runif(100, 50, 100))
)
estudiantes$aprobo <- ifelse(
  50 + 2*estudiantes$horas_estudio + 0.5*estudiantes$asistencia + rnorm(100, 0, 20) >= 80,
  1, 0
)
# Crea el modelo, evalúalo con matriz de confusión y calcula AUC
# Tu código aquí:




# =============================================================================
# EJEMPLO PRÁCTICO: PREDICCIÓN DE CHURN (CANCELACIÓN DE CLIENTES)
# =============================================================================

print("=== MODELO DE PREDICCIÓN DE CHURN ===")

# Generar datos de clientes
set.seed(789)
n_clientes <- 500
clientes <- data.frame(
  antiguedad_meses = round(abs(rnorm(n_clientes, mean = 24, sd = 15))),
  llamadas_soporte = round(abs(rnorm(n_clientes, mean = 3, sd = 2))),
  gasto_mensual = round(rnorm(n_clientes, mean = 500, sd = 200)),
  num_productos = sample(1:4, n_clientes, replace = TRUE),
  satisfaccion = round(runif(n_clientes, 1, 10))
)

clientes$gasto_mensual <- pmax(clientes$gasto_mensual, 100)

# Generar churn (más probable si: poca antigüedad, muchas llamadas, baja satisfacción)
logit_churn <- -3 -
  0.05 * clientes$antiguedad_meses +
  0.4 * clientes$llamadas_soporte -
  0.003 * clientes$gasto_mensual -
  0.5 * clientes$satisfaccion

prob_churn <- 1 / (1 + exp(-logit_churn))
clientes$churn <- rbinom(n_clientes, 1, prob = prob_churn)

print("Tasa de churn:")
print(prop.table(table(clientes$churn)))

# 1. Modelo de predicción
modelo_churn <- glm(churn ~ antiguedad_meses + llamadas_soporte +
                    gasto_mensual + num_productos + satisfaccion,
                   family = binomial,
                   data = clientes)

print(summary(modelo_churn))

# 2. Odds Ratios
or_churn <- exp(coef(modelo_churn))
print("Odds Ratios - Factores de Churn:")
print(round(or_churn, 3))

# 3. Predicciones
prob_churn_pred <- predict(modelo_churn, type = "response")
pred_churn <- ifelse(prob_churn_pred > 0.5, 1, 0)

# 4. Evaluación
tabla_conf_churn <- table(Real = clientes$churn, Predicho = pred_churn)
print("Matriz de Confusión:")
print(tabla_conf_churn)

exactitud_churn <- sum(diag(tabla_conf_churn)) / sum(tabla_conf_churn)
print(paste("Exactitud:", round(exactitud_churn, 4)))

# 5. Curva ROC
roc_churn <- roc(clientes$churn, prob_churn_pred)
auc_churn <- auc(roc_churn)
print(paste("AUC:", round(auc_churn, 4)))

plot(roc_churn,
     main = paste("Curva ROC - Predicción de Churn (AUC =", round(auc_churn, 3), ")"),
     col = "darkgreen",
     lwd = 2)

# 6. Identificar clientes en riesgo
clientes$riesgo_churn <- prob_churn_pred
clientes_alto_riesgo <- clientes %>%
  filter(riesgo_churn > 0.7 & churn == 0) %>%  # Alto riesgo pero aún no se fueron
  arrange(desc(riesgo_churn)) %>%
  head(10)

print("Top 10 clientes en riesgo de churn (para intervención):")
print(clientes_alto_riesgo[, c("antiguedad_meses", "llamadas_soporte",
                              "satisfaccion", "riesgo_churn")])

# 7. Visualización de factores de riesgo
ggplot(clientes, aes(x = satisfaccion, y = riesgo_churn, color = factor(churn))) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "loess", se = FALSE) +
  labs(
    title = "Relación entre Satisfacción y Riesgo de Churn",
    x = "Nivel de Satisfacción (1-10)",
    y = "Probabilidad de Churn",
    color = "Churn Real"
  ) +
  theme_minimal()

# =============================================================================
# RESUMEN DE LA LECCIÓN
# =============================================================================
# ✓ Regresión logística: glm(Y ~ X, family = binomial)
# ✓ Interpretación: Odds Ratios = exp(coeficientes)
# ✓ Predicciones: predict(modelo, type = "response")
# ✓ Evaluación: Matriz de confusión, exactitud, sensibilidad, precisión
# ✓ Curva ROC y AUC: medir desempeño del modelo
# ✓ Umbral óptimo: maximizar Youden's Index
# ✓ Comparación de modelos: AIC, ANOVA

# =============================================================================
# ¡Felicidades! Has completado el Módulo 5 - Modelos Avanzados
# Ahora tienes las herramientas para análisis estadístico completo con R
# =============================================================================
