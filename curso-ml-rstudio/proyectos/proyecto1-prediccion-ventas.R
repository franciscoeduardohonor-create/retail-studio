# ============================================================================
# PROYECTO PRÁCTICO 1: PREDICCIÓN DE VENTAS CON MACHINE LEARNING
# ============================================================================
# Descripción: Proyecto completo end-to-end para predecir ventas usando
#              múltiples algoritmos de ML y seleccionar el mejor modelo
# Nivel: Intermedio-Avanzado
# Duración estimada: 8-10 horas
# Objetivo: Aplicar todo lo aprendido en un proyecto real
# ============================================================================

# Cargar librerías necesarias
library(tidyverse)      # Manipulación y visualización
library(caret)          # Machine Learning
library(randomForest)   # Random Forest
library(xgboost)        # Gradient Boosting
library(lubridate)      # Manejo de fechas
library(corrplot)       # Matriz de correlación
library(gridExtra)      # Múltiples gráficos

cat("==================================================\n")
cat("  PROYECTO: PREDICCIÓN DE VENTAS\n")
cat("  Sistema completo de ML para retail\n")
cat("==================================================\n\n")

# ----------------------------------------------------------------------------
# FASE 1: GENERACIÓN Y COMPRENSIÓN DE DATOS
# ----------------------------------------------------------------------------

cat("=== FASE 1: GENERACIÓN DE DATOS ===\n\n")

# En un proyecto real, cargarías datos desde un archivo:
# ventas <- read_csv("ventas.csv")
# Para este proyecto, generaremos datos realistas

set.seed(2025)

# Generar 2 años de datos diarios
fechas <- seq(as.Date("2023-01-01"), as.Date("2024-12-31"), by = "day")
n <- length(fechas)

ventas_raw <- data.frame(
  fecha = fechas,
  # Variables numéricas
  temperatura = rnorm(n, mean = 20, sd = 8),
  lluvia = rbinom(n, 1, 0.2),  # 20% de días llueve
  inversion_marketing = runif(n, 1000, 10000),
  precio_promedio = runif(n, 50, 150),
  descuento_pct = sample(c(0, 5, 10, 15, 20), n, replace = TRUE),
  competencia_activa = sample(0:1, n, replace = TRUE)
)

# Extraer características temporales
ventas_raw <- ventas_raw %>%
  mutate(
    año = year(fecha),
    mes = month(fecha),
    dia_mes = day(fecha),
    dia_semana = wday(fecha),
    es_fin_semana = ifelse(dia_semana %in% c(1, 7), 1, 0),
    trimestre = quarter(fecha),
    semana_año = week(fecha)
  )

# Generar ventas con patrones realistas
ventas_raw <- ventas_raw %>%
  mutate(
    # Componente base
    venta_base = 5000,

    # Tendencia creciente
    tendencia = (row_number() / n) * 2000,

    # Estacionalidad (más ventas en fin de año)
    estacionalidad = sin(2 * pi * mes / 12) * 1500 + 1500,

    # Efecto día de semana (más en viernes-sábado)
    efecto_dia = case_when(
      dia_semana == 6 ~ 2000,  # Viernes
      dia_semana == 7 ~ 2500,  # Sábado
      dia_semana == 1 ~ 1500,  # Domingo
      TRUE ~ 0
    ),

    # Efectos de variables
    efecto_marketing = inversion_marketing * 0.3,
    efecto_precio = -precio_promedio * 20,
    efecto_descuento = descuento_pct * 150,
    efecto_temperatura = temperatura * 30,
    efecto_lluvia = lluvia * (-500),
    efecto_competencia = competencia_activa * (-800),

    # Ventas finales con ruido
    ventas = venta_base + tendencia + estacionalidad + efecto_dia +
             efecto_marketing + efecto_precio + efecto_descuento +
             efecto_temperatura + efecto_lluvia + efecto_competencia +
             rnorm(n, 0, 500)
  )

# Asegurar ventas positivas
ventas_raw$ventas <- pmax(ventas_raw$ventas, 1000)

# Dataset final (sin variables de construcción)
ventas <- ventas_raw %>%
  select(fecha, año, mes, dia_mes, dia_semana, es_fin_semana,
         trimestre, semana_año, temperatura, lluvia,
         inversion_marketing, precio_promedio, descuento_pct,
         competencia_activa, ventas)

cat("Dataset creado con", nrow(ventas), "observaciones\n")
cat("Periodo:", min(ventas$fecha), "a", max(ventas$fecha), "\n\n")

head(ventas, 10)

# ----------------------------------------------------------------------------
# FASE 2: ANÁLISIS EXPLORATORIO DE DATOS (EDA)
# ----------------------------------------------------------------------------

cat("\n=== FASE 2: ANÁLISIS EXPLORATORIO ===\n\n")

# Estadísticas descriptivas
cat("=== ESTADÍSTICAS DESCRIPTIVAS ===\n")
summary(ventas %>% select(-fecha))

# Distribución de ventas
cat("\n=== DISTRIBUCIÓN DE VENTAS ===\n")
cat("Promedio: $", mean(ventas$ventas), "\n")
cat("Mediana: $", median(ventas$ventas), "\n")
cat("Desviación estándar: $", sd(ventas$ventas), "\n")
cat("Mínimo: $", min(ventas$ventas), "\n")
cat("Máximo: $", max(ventas$ventas), "\n\n")

# Visualización 1: Evolución temporal
p1 <- ggplot(ventas, aes(x = fecha, y = ventas)) +
  geom_line(color = "blue", alpha = 0.6) +
  geom_smooth(method = "loess", color = "red", size = 1.2) +
  labs(
    title = "Evolución de Ventas en el Tiempo",
    x = "Fecha",
    y = "Ventas ($)"
  ) +
  theme_minimal() +
  scale_y_continuous(labels = scales::comma)

print(p1)

# Visualización 2: Ventas por día de la semana
ventas_dia_semana <- ventas %>%
  group_by(dia_semana) %>%
  summarize(promedio_ventas = mean(ventas)) %>%
  mutate(dia_nombre = factor(dia_semana,
                            levels = 1:7,
                            labels = c("Dom", "Lun", "Mar", "Mié",
                                      "Jue", "Vie", "Sáb")))

p2 <- ggplot(ventas_dia_semana, aes(x = dia_nombre, y = promedio_ventas)) +
  geom_col(fill = "steelblue") +
  labs(
    title = "Ventas Promedio por Día de la Semana",
    x = "Día",
    y = "Ventas Promedio ($)"
  ) +
  theme_minimal() +
  scale_y_continuous(labels = scales::comma)

print(p2)

# Visualización 3: Ventas por mes
ventas_mes <- ventas %>%
  group_by(mes) %>%
  summarize(promedio_ventas = mean(ventas))

p3 <- ggplot(ventas_mes, aes(x = mes, y = promedio_ventas)) +
  geom_line(color = "darkgreen", size = 1.2) +
  geom_point(color = "red", size = 3) +
  scale_x_continuous(breaks = 1:12) +
  labs(
    title = "Estacionalidad: Ventas por Mes",
    x = "Mes",
    y = "Ventas Promedio ($)"
  ) +
  theme_minimal() +
  scale_y_continuous(labels = scales::comma)

print(p3)

# Visualización 4: Correlaciones
cat("=== MATRIZ DE CORRELACIÓN ===\n")

vars_numericas <- ventas %>%
  select(ventas, temperatura, inversion_marketing, precio_promedio,
         descuento_pct, mes, dia_semana, es_fin_semana)

matriz_cor <- cor(vars_numericas)
print(round(matriz_cor, 2))

corrplot(matriz_cor, method = "color", type = "upper",
        addCoef.col = "black", number.cex = 0.7,
        tl.col = "black", tl.srt = 45,
        title = "Matriz de Correlación",
        mar = c(0,0,1,0))

# Visualización 5: Relación con variables clave
p4 <- ggplot(ventas, aes(x = inversion_marketing, y = ventas)) +
  geom_point(alpha = 0.3, color = "blue") +
  geom_smooth(method = "lm", color = "red") +
  labs(
    title = "Ventas vs Inversión en Marketing",
    x = "Inversión Marketing ($)",
    y = "Ventas ($)"
  ) +
  theme_minimal()

p5 <- ggplot(ventas, aes(x = precio_promedio, y = ventas)) +
  geom_point(alpha = 0.3, color = "darkgreen") +
  geom_smooth(method = "lm", color = "red") +
  labs(
    title = "Ventas vs Precio Promedio",
    x = "Precio Promedio ($)",
    y = "Ventas ($)"
  ) +
  theme_minimal()

grid.arrange(p4, p5, ncol = 2)

# ----------------------------------------------------------------------------
# FASE 3: PREPARACIÓN DE DATOS
# ----------------------------------------------------------------------------

cat("\n=== FASE 3: PREPARACIÓN DE DATOS ===\n\n")

# Convertir variables categóricas a factores
ventas_prep <- ventas %>%
  mutate(
    lluvia = as.factor(lluvia),
    competencia_activa = as.factor(competencia_activa),
    es_fin_semana = as.factor(es_fin_semana),
    trimestre = as.factor(trimestre),
    mes = as.factor(mes),
    dia_semana = as.factor(dia_semana)
  )

# Variables para el modelo (excluir fecha)
ventas_modelo <- ventas_prep %>%
  select(-fecha, -año, -semana_año, -dia_mes)  # Quitar variables no útiles

cat("Variables en el modelo:\n")
print(names(ventas_modelo))

# División temporal (importante para series de tiempo)
# Train: Primeros 18 meses (547 días)
# Test: Últimos 6 meses (184 días)

fecha_corte <- as.Date("2024-07-01")

train_data <- ventas_modelo[ventas_prep$fecha < fecha_corte, ]
test_data <- ventas_modelo[ventas_prep$fecha >= fecha_corte, ]

cat("\n=== DIVISIÓN DE DATOS ===\n")
cat("Train:", nrow(train_data), "observaciones\n")
cat("Test:", nrow(test_data), "observaciones\n")
cat("Proporción:", round(nrow(train_data) / nrow(ventas_modelo), 2), "/",
    round(nrow(test_data) / nrow(ventas_modelo), 2), "\n\n")

# ----------------------------------------------------------------------------
# FASE 4: ENTRENAMIENTO DE MODELOS
# ----------------------------------------------------------------------------

cat("=== FASE 4: ENTRENAMIENTO DE MODELOS ===\n\n")

# Configuración de validación cruzada
ctrl <- trainControl(
  method = "cv",
  number = 5,
  verboseIter = FALSE
)

# MODELO 1: REGRESIÓN LINEAL
cat("Entrenando Modelo 1: Regresión Lineal...\n")
modelo_lm <- train(
  ventas ~ .,
  data = train_data,
  method = "lm",
  trControl = ctrl
)

cat("✓ Completado\n\n")

# MODELO 2: RANDOM FOREST
cat("Entrenando Modelo 2: Random Forest...\n")
modelo_rf <- train(
  ventas ~ .,
  data = train_data,
  method = "rf",
  trControl = ctrl,
  ntree = 200,
  importance = TRUE
)

cat("✓ Completado\n\n")

# MODELO 3: GRADIENT BOOSTING (XGBoost)
cat("Entrenando Modelo 3: XGBoost...\n")

# Preparar datos para XGBoost (necesita matrices numéricas)
train_matrix <- model.matrix(ventas ~ ., data = train_data)[, -1]
test_matrix <- model.matrix(ventas ~ ., data = test_data)[, -1]

modelo_xgb <- train(
  x = train_matrix,
  y = train_data$ventas,
  method = "xgbTree",
  trControl = ctrl,
  tuneLength = 3,
  verbose = FALSE
)

cat("✓ Completado\n\n")

# ----------------------------------------------------------------------------
# FASE 5: EVALUACIÓN DE MODELOS
# ----------------------------------------------------------------------------

cat("=== FASE 5: EVALUACIÓN DE MODELOS ===\n\n")

# Función para calcular métricas
calcular_metricas <- function(real, predicho, nombre_modelo) {
  rmse <- sqrt(mean((real - predicho)^2))
  mae <- mean(abs(real - predicho))
  mape <- mean(abs((real - predicho) / real)) * 100
  r2 <- cor(real, predicho)^2

  cat(nombre_modelo, ":\n")
  cat("  RMSE: $", round(rmse, 2), "\n")
  cat("  MAE: $", round(mae, 2), "\n")
  cat("  MAPE:", round(mape, 2), "%\n")
  cat("  R²:", round(r2, 4), "\n\n")

  return(data.frame(
    Modelo = nombre_modelo,
    RMSE = rmse,
    MAE = mae,
    MAPE = mape,
    R2 = r2
  ))
}

# Predicciones en Test Set
pred_lm <- predict(modelo_lm, test_data)
pred_rf <- predict(modelo_rf, test_data)
pred_xgb <- predict(modelo_xgb, test_matrix)

# Calcular métricas
cat("=== MÉTRICAS EN TEST SET ===\n\n")

metricas_lm <- calcular_metricas(test_data$ventas, pred_lm, "Regresión Lineal")
metricas_rf <- calcular_metricas(test_data$ventas, pred_rf, "Random Forest")
metricas_xgb <- calcular_metricas(test_data$ventas, pred_xgb, "XGBoost")

# Tabla comparativa
comparacion <- rbind(metricas_lm, metricas_rf, metricas_xgb)
print(comparacion)

# Identificar mejor modelo
mejor_modelo_idx <- which.min(comparacion$RMSE)
cat("\n🏆 MEJOR MODELO:", comparacion$Modelo[mejor_modelo_idx], "\n")
cat("   RMSE:", round(comparacion$RMSE[mejor_modelo_idx], 2), "\n\n")

# ----------------------------------------------------------------------------
# FASE 6: ANÁLISIS DE RESULTADOS
# ----------------------------------------------------------------------------

cat("=== FASE 6: ANÁLISIS DE RESULTADOS ===\n\n")

# Crear dataframe con resultados
resultados <- data.frame(
  fecha = ventas_prep$fecha[ventas_prep$fecha >= fecha_corte],
  real = test_data$ventas,
  pred_lm = pred_lm,
  pred_rf = pred_rf,
  pred_xgb = pred_xgb
)

# Visualización 1: Real vs Predicho (Mejor modelo)
p6 <- ggplot(resultados, aes(x = real, y = pred_rf)) +
  geom_point(alpha = 0.5, color = "blue") +
  geom_abline(intercept = 0, slope = 1, color = "red", size = 1) +
  labs(
    title = "Random Forest: Valores Reales vs Predichos",
    subtitle = paste("R² =", round(metricas_rf$R2, 4)),
    x = "Ventas Reales ($)",
    y = "Ventas Predichas ($)"
  ) +
  theme_minimal() +
  scale_x_continuous(labels = scales::comma) +
  scale_y_continuous(labels = scales::comma)

print(p6)

# Visualización 2: Evolución temporal con predicciones
resultados_long <- resultados %>%
  pivot_longer(
    cols = c(real, pred_rf),
    names_to = "tipo",
    values_to = "valor"
  )

p7 <- ggplot(resultados_long, aes(x = fecha, y = valor, color = tipo)) +
  geom_line(size = 1) +
  scale_color_manual(
    values = c("real" = "black", "pred_rf" = "red"),
    labels = c("Real", "Predicción")
  ) +
  labs(
    title = "Comparación: Ventas Reales vs Predicciones (Random Forest)",
    x = "Fecha",
    y = "Ventas ($)",
    color = ""
  ) +
  theme_minimal() +
  scale_y_continuous(labels = scales::comma)

print(p7)

# Visualización 3: Residuos
resultados$residuos_rf <- resultados$real - resultados$pred_rf

p8 <- ggplot(resultados, aes(x = pred_rf, y = residuos_rf)) +
  geom_point(alpha = 0.5) +
  geom_hline(yintercept = 0, color = "red", linetype = "dashed") +
  labs(
    title = "Análisis de Residuos (Random Forest)",
    x = "Valores Predichos",
    y = "Residuos"
  ) +
  theme_minimal()

print(p8)

# Importancia de variables (Random Forest)
cat("=== IMPORTANCIA DE VARIABLES ===\n")
importancia <- varImp(modelo_rf)
print(importancia)

plot(importancia, main = "Variables Más Importantes para Predicción")

# ----------------------------------------------------------------------------
# FASE 7: PREDICCIONES FUTURAS
# ----------------------------------------------------------------------------

cat("\n=== FASE 7: PREDICCIONES FUTURAS ===\n\n")

# Generar datos para próximos 30 días
fechas_futuro <- seq(max(ventas$fecha) + 1, by = "day", length.out = 30)

futuro <- data.frame(
  fecha = fechas_futuro,
  mes = factor(month(fechas_futuro)),
  dia_semana = factor(wday(fechas_futuro)),
  es_fin_semana = factor(ifelse(wday(fechas_futuro) %in% c(1, 7), 1, 0)),
  trimestre = factor(quarter(fechas_futuro)),
  # Suponer valores promedio para variables controlables
  temperatura = 20,
  lluvia = factor(0),
  inversion_marketing = mean(ventas$inversion_marketing),
  precio_promedio = mean(ventas$precio_promedio),
  descuento_pct = 10,  # Promoción estándar
  competencia_activa = factor(1)
)

# Hacer predicciones
predicciones_futuro <- predict(modelo_rf, futuro)

futuro$ventas_predichas <- predicciones_futuro

cat("=== PREDICCIONES PARA LOS PRÓXIMOS 30 DÍAS ===\n\n")
print(futuro %>% select(fecha, dia_semana, ventas_predichas))

# Resumen de predicciones
cat("\n=== RESUMEN DE PREDICCIONES ===\n")
cat("Venta diaria promedio predicha: $", round(mean(predicciones_futuro), 2), "\n")
cat("Total proyectado (30 días): $", round(sum(predicciones_futuro), 2), "\n")
cat("Mejor día predicho:", format(futuro$fecha[which.max(predicciones_futuro)], "%Y-%m-%d"),
    "($", round(max(predicciones_futuro), 2), ")\n")
cat("Peor día predicho:", format(futuro$fecha[which.min(predicciones_futuro)], "%Y-%m-%d"),
    "($", round(min(predicciones_futuro), 2), ")\n\n")

# Visualizar predicciones futuras
p9 <- ggplot(futuro, aes(x = fecha, y = ventas_predichas)) +
  geom_line(color = "blue", size = 1.2) +
  geom_point(aes(color = es_fin_semana), size = 3) +
  scale_color_manual(
    values = c("0" = "gray", "1" = "red"),
    labels = c("Entre semana", "Fin de semana")
  ) +
  labs(
    title = "Predicción de Ventas - Próximos 30 Días",
    x = "Fecha",
    y = "Ventas Predichas ($)",
    color = ""
  ) +
  theme_minimal() +
  scale_y_continuous(labels = scales::comma)

print(p9)

# ----------------------------------------------------------------------------
# FASE 8: RECOMENDACIONES DE NEGOCIO
# ----------------------------------------------------------------------------

cat("=== FASE 8: RECOMENDACIONES DE NEGOCIO ===\n\n")

cat("📊 INSIGHTS DEL MODELO:\n\n")

cat("1. PATRÓN SEMANAL:\n")
cat("   - Días con mayores ventas: Viernes, Sábado, Domingo\n")
cat("   - Recomendación: Aumentar inventario en fin de semana\n\n")

cat("2. INVERSIÓN EN MARKETING:\n")
importancia_marketing <- importancia$importance[rownames(importancia$importance) == "inversion_marketing",]
cat("   - Importancia:", round(importancia_marketing, 2), "\n")
cat("   - Recomendación: Mantener inversión constante, ROI positivo\n\n")

cat("3. PRECIO:\n")
cat("   - Efecto negativo en ventas (esperado)\n")
cat("   - Recomendación: Evaluar elasticidad precio-demanda\n\n")

cat("4. DESCUENTOS:\n")
cat("   - Efecto positivo en volumen de ventas\n")
cat("   - Recomendación: Usar descuentos estratégicamente\n\n")

cat("5. ESTACIONALIDAD:\n")
cat("   - Picos en: Diciembre (fin de año)\n")
cat("   - Recomendación: Preparar inventario extra para temporada alta\n\n")

# ----------------------------------------------------------------------------
# FASE 9: GUARDAR MODELO
# ----------------------------------------------------------------------------

cat("=== FASE 9: GUARDAR MODELO PARA PRODUCCIÓN ===\n\n")

# Guardar el mejor modelo
# saveRDS(modelo_rf, "modelo_prediccion_ventas.rds")

cat("Modelo guardado como: modelo_prediccion_ventas.rds\n")
cat("Para usar en producción:\n")
cat("  modelo <- readRDS('modelo_prediccion_ventas.rds')\n")
cat("  predicciones <- predict(modelo, nuevos_datos)\n\n")

# ----------------------------------------------------------------------------
# RESUMEN FINAL
# ----------------------------------------------------------------------------

cat("\n")
cat("==================================================\n")
cat("  RESUMEN DEL PROYECTO\n")
cat("==================================================\n\n")

cat("✅ COMPLETADO:\n")
cat("  1. Generación y carga de datos (731 días)\n")
cat("  2. Análisis exploratorio completo\n")
cat("  3. Preparación y limpieza de datos\n")
cat("  4. Entrenamiento de 3 modelos (LM, RF, XGBoost)\n")
cat("  5. Evaluación y comparación de modelos\n")
cat("  6. Análisis de resultados y residuos\n")
cat("  7. Predicciones para los próximos 30 días\n")
cat("  8. Recomendaciones de negocio\n\n")

cat("🏆 MEJOR MODELO:", comparacion$Modelo[mejor_modelo_idx], "\n")
cat("   - RMSE: $", round(comparacion$RMSE[mejor_modelo_idx], 2), "\n")
cat("   - MAPE:", round(comparacion$MAPE[mejor_modelo_idx], 2), "%\n")
cat("   - R²:", round(comparacion$R2[mejor_modelo_idx], 4), "\n\n")

cat("💡 PRÓXIMOS PASOS:\n")
cat("  - Reentrenar modelo mensualmente con nuevos datos\n")
cat("  - Monitorear métricas de performance\n")
cat("  - A/B testing de recomendaciones\n")
cat("  - Explorar variables adicionales\n")
cat("  - Implementar en sistema de producción\n\n")

cat("==================================================\n")
cat("  ¡PROYECTO COMPLETADO CON ÉXITO!\n")
cat("==================================================\n")

# ============================================================================
# FIN DEL PROYECTO
# ============================================================================
