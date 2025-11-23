# ============================================================================
# MÓDULO 4 - LECCIÓN 3: ÁRBOLES DE DECISIÓN Y RANDOM FOREST
# ============================================================================
# Descripción: Aprenderás algoritmos de árbol, uno de los más potentes
#              y utilizados en competencias de ML y aplicaciones reales
# Nivel: Intermedio-Avanzado
# Duración estimada: 6-7 horas
# Prerequisito: Lecciones anteriores del Módulo 4
# ============================================================================

# Instalar paquetes si no los tienes
# install.packages(c("rpart", "rpart.plot", "randomForest", "caret", "e1071"))

library(rpart)           # Árboles de decisión
library(rpart.plot)      # Visualizar árboles
library(randomForest)    # Random Forest
library(caret)           # ML framework
library(ggplot2)
library(dplyr)

cat("==================================================\n")
cat("  ÁRBOLES DE DECISIÓN Y RANDOM FOREST\n")
cat("==================================================\n\n")

# ----------------------------------------------------------------------------
# SECCIÓN 1: ¿QUÉ SON LOS ÁRBOLES DE DECISIÓN?
# ----------------------------------------------------------------------------

cat("=== ¿QUÉ SON LOS ÁRBOLES DE DECISIÓN? ===\n\n")

# Los árboles de decisión son modelos que:
# - Dividen los datos en subgrupos basándose en reglas
# - Se ven como un diagrama de flujo
# - Son fáciles de interpretar y visualizar
# - Funcionan para clasificación Y regresión

# Ventajas:
# ✓ Fáciles de entender y visualizar
# ✓ Requieren poca preparación de datos
# ✓ Pueden capturar relaciones no lineales
# ✓ Funcionan con datos categóricos y numéricos

# Desventajas:
# ✗ Propensos a overfitting
# ✗ Inestables (pequeños cambios en datos = árbol diferente)
# ✗ Pueden crear modelos sesgados con clases desbalanceadas

# ----------------------------------------------------------------------------
# SECCIÓN 2: ÁRBOL DE DECISIÓN PARA CLASIFICACIÓN
# ----------------------------------------------------------------------------

cat("=== ÁRBOL DE DECISIÓN - CLASIFICACIÓN ===\n\n")

# Ejemplo: Clasificar si un cliente comprará un producto

# Crear dataset
set.seed(42)
n <- 300

clientes <- data.frame(
  edad = sample(18:70, n, replace = TRUE),
  ingreso_anual = sample(20000:150000, n, replace = TRUE),
  tiempo_en_sitio_min = sample(1:60, n, replace = TRUE),
  num_visitas = sample(1:50, n, replace = TRUE)
)

# Generar variable objetivo (comprará o no)
# Regla compleja: más probable comprar si...
clientes$comprara <- ifelse(
  (clientes$edad >= 25 & clientes$ingreso_anual >= 50000) |
  (clientes$tiempo_en_sitio_min >= 20 & clientes$num_visitas >= 10),
  "Sí", "No"
)

# Agregar algo de aleatoriedad
indices_aleatorios <- sample(1:n, 50)
clientes$comprara[indices_aleatorios] <- sample(c("Sí", "No"), 50, replace = TRUE)

# Convertir a factor
clientes$comprara <- as.factor(clientes$comprara)

head(clientes, 10)

# Distribución de clases
table(clientes$comprara)

# División train/test
set.seed(123)
indices_train <- sample(1:nrow(clientes), 0.7 * nrow(clientes))
train <- clientes[indices_train, ]
test <- clientes[-indices_train, ]

cat("Datos de entrenamiento:", nrow(train), "\n")
cat("Datos de prueba:", nrow(test), "\n\n")

# ENTRENAR ÁRBOL DE DECISIÓN
arbol_clf <- rpart(
  comprara ~ edad + ingreso_anual + tiempo_en_sitio_min + num_visitas,
  data = train,
  method = "class",  # "class" para clasificación, "anova" para regresión
  control = rpart.control(
    minsplit = 20,    # Mínimo de observaciones para dividir
    minbucket = 7,    # Mínimo de observaciones en hoja
    cp = 0.01,        # Complejidad mínima (menor = árbol más complejo)
    maxdepth = 10     # Profundidad máxima
  )
)

# Visualizar el árbol
cat("=== VISUALIZACIÓN DEL ÁRBOL ===\n\n")
rpart.plot(arbol_clf,
          type = 4,          # Estilo del árbol
          extra = 104,       # Información extra a mostrar
          fallen.leaves = TRUE,
          main = "Árbol de Decisión: Predicción de Compra")

# Cómo leer el árbol:
# - Nodo raíz (arriba): Primera pregunta
# - Cada rama: Una decisión (sí/no)
# - Hojas (abajo): Predicción final
# - Números: Proporción de cada clase

# Ver reglas del árbol en texto
cat("\n=== REGLAS DEL ÁRBOL ===\n")
print(arbol_clf)

# Información detallada
summary(arbol_clf)

# HACER PREDICCIONES

# Predicción de clases
pred_train_class <- predict(arbol_clf, train, type = "class")
pred_test_class <- predict(arbol_clf, test, type = "class")

# Predicción de probabilidades
pred_test_prob <- predict(arbol_clf, test, type = "prob")
head(pred_test_prob)

# EVALUACIÓN

# Matriz de confusión (Test set)
cat("\n=== MATRIZ DE CONFUSIÓN (TEST) ===\n")
conf_matrix <- confusionMatrix(pred_test_class, test$comprara)
print(conf_matrix)

cat("\n=== INTERPRETACIÓN ===\n")
cat("Accuracy:", conf_matrix$overall['Accuracy'], "\n")
cat("  -> Porcentaje de predicciones correctas\n\n")

cat("Sensitivity (Recall):", conf_matrix$byClass['Sensitivity'], "\n")
cat("  -> De los 'Sí' reales, cuántos detectamos\n\n")

cat("Specificity:", conf_matrix$byClass['Specificity'], "\n")
cat("  -> De los 'No' reales, cuántos detectamos\n\n")

cat("Precision:", conf_matrix$byClass['Pos Pred Value'], "\n")
cat("  -> De los que predijimos 'Sí', cuántos eran correctos\n\n")

# Importancia de variables
cat("=== IMPORTANCIA DE VARIABLES ===\n")
importancia <- arbol_clf$variable.importance
print(sort(importancia, decreasing = TRUE))

# Visualizar importancia
barplot(sort(importancia, decreasing = TRUE),
       main = "Importancia de Variables",
       col = "steelblue",
       las = 2)  # Rotar etiquetas

# ----------------------------------------------------------------------------
# SECCIÓN 3: ÁRBOL DE DECISIÓN PARA REGRESIÓN
# ----------------------------------------------------------------------------

cat("\n\n=== ÁRBOL DE DECISIÓN - REGRESIÓN ===\n\n")

# Ejemplo: Predecir precio de casas

set.seed(2025)
n <- 400

casas <- data.frame(
  metros_cuadrados = runif(n, 50, 300),
  num_habitaciones = sample(1:6, n, replace = TRUE),
  num_banos = sample(1:4, n, replace = TRUE),
  antiguedad = sample(0:50, n, replace = TRUE),
  calidad = sample(c("Baja", "Media", "Alta"), n, replace = TRUE)
)

# Generar precio
casas$precio <- 50000 +
                2500 * casas$metros_cuadrados +
                25000 * casas$num_habitaciones +
                15000 * casas$num_banos -
                800 * casas$antiguedad +
                ifelse(casas$calidad == "Alta", 100000,
                      ifelse(casas$calidad == "Media", 50000, 0)) +
                rnorm(n, 0, 50000)

# División train/test
indices <- sample(1:nrow(casas), 0.75 * nrow(casas))
train_casas <- casas[indices, ]
test_casas <- casas[-indices, ]

# Entrenar árbol de regresión
arbol_reg <- rpart(
  precio ~ .,
  data = train_casas,
  method = "anova",  # Para regresión
  control = rpart.control(cp = 0.01)
)

# Visualizar árbol
rpart.plot(arbol_reg,
          type = 4,
          main = "Árbol de Regresión: Predicción de Precio")

# Predicciones
pred_test_precio <- predict(arbol_reg, test_casas)

# Evaluación
rmse <- sqrt(mean((test_casas$precio - pred_test_precio)^2))
mae <- mean(abs(test_casas$precio - pred_test_precio))
r2 <- cor(test_casas$precio, pred_test_precio)^2

cat("=== MÉTRICAS DE REGRESIÓN ===\n")
cat("RMSE: $", round(rmse, 2), "\n")
cat("MAE: $", round(mae, 2), "\n")
cat("R²:", round(r2, 4), "\n\n")

# Visualizar predicciones
test_casas$prediccion <- pred_test_precio

ggplot(test_casas, aes(x = precio, y = prediccion)) +
  geom_point(alpha = 0.6, color = "blue") +
  geom_abline(intercept = 0, slope = 1, color = "red", size = 1) +
  labs(
    title = "Árbol de Regresión: Real vs Predicho",
    x = "Precio Real",
    y = "Precio Predicho"
  ) +
  theme_minimal()

# ----------------------------------------------------------------------------
# SECCIÓN 4: PODA DEL ÁRBOL (PRUNING)
# ----------------------------------------------------------------------------

cat("\n=== PODA DEL ÁRBOL ===\n\n")

# Los árboles muy profundos tienden a hacer overfitting
# La poda reduce la complejidad

# Ver parámetro CP (complexity parameter)
printcp(arbol_reg)

# Visualizar CP
plotcp(arbol_reg)

# El mejor CP es el que minimiza el error
cp_optimo <- arbol_reg$cptable[which.min(arbol_reg$cptable[,"xerror"]), "CP"]
cat("CP óptimo:", cp_optimo, "\n\n")

# Podar el árbol
arbol_podado <- prune(arbol_reg, cp = cp_optimo)

# Comparar árboles
par(mfrow = c(1, 2))
rpart.plot(arbol_reg, main = "Árbol Original")
rpart.plot(arbol_podado, main = "Árbol Podado")
par(mfrow = c(1, 1))

# Comparar performance
pred_original <- predict(arbol_reg, test_casas)
pred_podado <- predict(arbol_podado, test_casas)

rmse_original <- sqrt(mean((test_casas$precio - pred_original)^2))
rmse_podado <- sqrt(mean((test_casas$precio - pred_podado)^2))

cat("RMSE Árbol Original:", round(rmse_original, 2), "\n")
cat("RMSE Árbol Podado:", round(rmse_podado, 2), "\n\n")

# ----------------------------------------------------------------------------
# SECCIÓN 5: RANDOM FOREST
# ----------------------------------------------------------------------------

cat("=== RANDOM FOREST ===\n\n")

# Random Forest:
# - Entrena MUCHOS árboles de decisión
# - Cada árbol usa una muestra aleatoria de datos
# - Cada división usa un subconjunto aleatorio de variables
# - Predicción final = promedio/voto de todos los árboles

# Ventajas sobre árboles simples:
# ✓ Mucho más precisos
# ✓ Menos propensos a overfitting
# ✓ Robustos al ruido
# ✓ Calculan importancia de variables automáticamente

# Desventajas:
# ✗ Más lentos de entrenar
# ✗ Menos interpretables (caja negra)
# ✗ Requieren más memoria

cat("=== RANDOM FOREST - CLASIFICACIÓN ===\n\n")

# Usar dataset de clientes
rf_clf <- randomForest(
  comprara ~ edad + ingreso_anual + tiempo_en_sitio_min + num_visitas,
  data = train,
  ntree = 500,           # Número de árboles
  mtry = 2,              # Número de variables en cada división
  importance = TRUE,     # Calcular importancia
  proximity = TRUE       # Calcular similitudes
)

print(rf_clf)

# Predicciones
pred_rf_train <- predict(rf_clf, train)
pred_rf_test <- predict(rf_clf, test)

# Matriz de confusión
conf_matrix_rf <- confusionMatrix(pred_rf_test, test$comprara)
print(conf_matrix_rf)

cat("\n=== COMPARACIÓN: ÁRBOL vs RANDOM FOREST ===\n")
cat("Accuracy Árbol Simple:", conf_matrix$overall['Accuracy'], "\n")
cat("Accuracy Random Forest:", conf_matrix_rf$overall['Accuracy'], "\n\n")

# Importancia de variables
cat("=== IMPORTANCIA DE VARIABLES (RF) ===\n")
importancia_rf <- importance(rf_clf)
print(importancia_rf)

# Visualizar importancia
varImpPlot(rf_clf,
          main = "Importancia de Variables (Random Forest)")

# Curva de error
plot(rf_clf, main = "Error vs Número de Árboles")
legend("topright", colnames(rf_clf$err.rate), col = 1:3, lty = 1:3)

# El error se estabiliza después de ciertos árboles
# No necesitamos 500 si el error ya no mejora con 200

# ----------------------------------------------------------------------------
# SECCIÓN 6: RANDOM FOREST - REGRESIÓN
# ----------------------------------------------------------------------------

cat("\n=== RANDOM FOREST - REGRESIÓN ===\n\n")

# Predecir precios de casas
rf_reg <- randomForest(
  precio ~ .,
  data = train_casas,
  ntree = 300,
  mtry = 3,
  importance = TRUE
)

print(rf_reg)

# Predicciones
pred_rf_precio <- predict(rf_reg, test_casas)

# Evaluación
rmse_rf <- sqrt(mean((test_casas$precio - pred_rf_precio)^2))
mae_rf <- mean(abs(test_casas$precio - pred_rf_precio))
r2_rf <- cor(test_casas$precio, pred_rf_precio)^2

cat("\n=== COMPARACIÓN: ÁRBOL vs RANDOM FOREST ===\n")
cat("RMSE Árbol:", round(rmse, 2), "\n")
cat("RMSE Random Forest:", round(rmse_rf, 2), "\n\n")

cat("R² Árbol:", round(r2, 4), "\n")
cat("R² Random Forest:", round(r2_rf, 4), "\n\n")

# Visualizar
test_casas$prediccion_rf <- pred_rf_precio

ggplot(test_casas, aes(x = precio, y = prediccion_rf)) +
  geom_point(alpha = 0.6, color = "darkgreen") +
  geom_abline(intercept = 0, slope = 1, color = "red", size = 1) +
  labs(
    title = "Random Forest: Predicción de Precios",
    subtitle = paste("R² =", round(r2_rf, 4)),
    x = "Precio Real",
    y = "Precio Predicho"
  ) +
  theme_minimal() +
  scale_x_continuous(labels = scales::comma) +
  scale_y_continuous(labels = scales::comma)

# Importancia de variables
varImpPlot(rf_reg,
          main = "Importancia de Variables (Regresión)")

# ----------------------------------------------------------------------------
# SECCIÓN 7: OPTIMIZACIÓN DE HIPERPARÁMETROS
# ----------------------------------------------------------------------------

cat("\n=== OPTIMIZACIÓN DE HIPERPARÁMETROS ===\n\n")

# Hiperparámetros importantes:
# - ntree: Número de árboles (más árboles = más lento pero más preciso)
# - mtry: Variables en cada división (default = sqrt(p) para clasificación)
# - nodesize: Tamaño mínimo de nodos terminales

# Probar diferentes valores de mtry
cat("Buscando mejor valor de mtry...\n")

resultados_mtry <- data.frame(
  mtry = integer(),
  rmse = numeric()
)

for (m in 2:5) {
  rf_temp <- randomForest(
    precio ~ .,
    data = train_casas,
    ntree = 100,
    mtry = m
  )

  pred_temp <- predict(rf_temp, test_casas)
  rmse_temp <- sqrt(mean((test_casas$precio - pred_temp)^2))

  resultados_mtry <- rbind(resultados_mtry, data.frame(mtry = m, rmse = rmse_temp))
  cat("mtry =", m, "| RMSE =", round(rmse_temp, 2), "\n")
}

mejor_mtry <- resultados_mtry$mtry[which.min(resultados_mtry$rmse)]
cat("\nMejor mtry:", mejor_mtry, "\n\n")

# Visualizar
ggplot(resultados_mtry, aes(x = mtry, y = rmse)) +
  geom_line(color = "blue", size = 1) +
  geom_point(color = "red", size = 3) +
  labs(
    title = "Optimización de mtry",
    x = "mtry (número de variables)",
    y = "RMSE"
  ) +
  theme_minimal()

# Entrenar modelo final con mejor mtry
rf_final <- randomForest(
  precio ~ .,
  data = train_casas,
  ntree = 300,
  mtry = mejor_mtry,
  importance = TRUE
)

# ----------------------------------------------------------------------------
# SECCIÓN 8: EJEMPLO PRÁCTICO COMPLETO
# ----------------------------------------------------------------------------

cat("\n=== PROYECTO: PREDICCIÓN DE ABANDONO DE CLIENTES (CHURN) ===\n\n")

# Crear dataset de clientes
set.seed(2025)
n <- 1000

churn_data <- data.frame(
  edad = sample(18:80, n, replace = TRUE),
  antiguedad_meses = sample(1:120, n, replace = TRUE),
  gasto_mensual = runif(n, 20, 200),
  minutos_servicio = sample(0:500, n, replace = TRUE),
  num_productos = sample(1:5, n, replace = TRUE),
  tiene_tarjeta = sample(c("Sí", "No"), n, replace = TRUE),
  reclamos = sample(0:10, n, replace = TRUE)
)

# Generar abandono (churn)
prob_churn <- with(churn_data,
  0.1 +
  0.005 * pmax(0, 40 - edad) +  # Más jóvenes = más churn
  0.003 * pmax(0, 12 - antiguedad_meses) +  # Menos antigüedad = más churn
  0.002 * pmax(0, 100 - gasto_mensual) +    # Menos gasto = más churn
  0.05 * reclamos                            # Más reclamos = más churn
)

churn_data$abandono <- ifelse(runif(n) < prob_churn, "Sí", "No")
churn_data$abandono <- as.factor(churn_data$abandono)
churn_data$tiene_tarjeta <- as.factor(churn_data$tiene_tarjeta)

# Distribución
cat("Distribución de abandono:\n")
table(churn_data$abandono)
cat("\n")

# División estratificada (mantiene proporción de clases)
set.seed(42)
indices <- createDataPartition(churn_data$abandono, p = 0.75, list = FALSE)
train_churn <- churn_data[indices, ]
test_churn <- churn_data[-indices, ]

cat("Train - Sí:", sum(train_churn$abandono == "Sí"),
    "| No:", sum(train_churn$abandono == "No"), "\n")
cat("Test - Sí:", sum(test_churn$abandono == "Sí"),
    "| No:", sum(test_churn$abandono == "No"), "\n\n")

# MODELO 1: Árbol de Decisión
cat("=== MODELO 1: ÁRBOL DE DECISIÓN ===\n")
arbol_churn <- rpart(abandono ~ ., data = train_churn, method = "class")

pred_arbol <- predict(arbol_churn, test_churn, type = "class")
conf_arbol <- confusionMatrix(pred_arbol, test_churn$abandono)

cat("Accuracy:", conf_arbol$overall['Accuracy'], "\n")
cat("Sensitivity:", conf_arbol$byClass['Sensitivity'], "\n")
cat("Specificity:", conf_arbol$byClass['Specificity'], "\n\n")

# MODELO 2: Random Forest
cat("=== MODELO 2: RANDOM FOREST ===\n")
rf_churn <- randomForest(
  abandono ~ .,
  data = train_churn,
  ntree = 300,
  importance = TRUE
)

pred_rf <- predict(rf_churn, test_churn)
conf_rf <- confusionMatrix(pred_rf, test_churn$abandono)

cat("Accuracy:", conf_rf$overall['Accuracy'], "\n")
cat("Sensitivity:", conf_rf$byClass['Sensitivity'], "\n")
cat("Specificity:", conf_rf$byClass['Specificity'], "\n\n")

# Comparación
cat("=== COMPARACIÓN FINAL ===\n")
cat("Árbol - Accuracy:", round(conf_arbol$overall['Accuracy'], 4), "\n")
cat("Random Forest - Accuracy:", round(conf_rf$overall['Accuracy'], 4), "\n\n")

# Variables más importantes
cat("=== VARIABLES MÁS IMPORTANTES ===\n")
importancia_churn <- importance(rf_churn)
print(importancia_churn[order(importancia_churn[, 3], decreasing = TRUE), ])

# Visualizar
varImpPlot(rf_churn, main = "Factores de Abandono de Clientes")

# Probabilidades de abandono
probabilidades <- predict(rf_churn, test_churn, type = "prob")
test_churn$prob_abandono <- probabilidades[, "Sí"]

# Clientes con alta probabilidad de abandono
clientes_riesgo <- test_churn %>%
  filter(prob_abandono > 0.7) %>%
  arrange(desc(prob_abandono))

cat("\n=== CLIENTES EN RIESGO DE ABANDONO ===\n")
cat("Total de clientes en riesgo:", nrow(clientes_riesgo), "\n")
head(clientes_riesgo, 10)

# ----------------------------------------------------------------------------
# RESUMEN
# ----------------------------------------------------------------------------

cat("\n\n=== RESUMEN DE LA LECCIÓN ===\n")
cat("Aprendiste:\n\n")
cat("✓ Árboles de Decisión (clasificación y regresión)\n")
cat("✓ Visualización e interpretación de árboles\n")
cat("✓ Importancia de variables\n")
cat("✓ Poda de árboles (pruning)\n")
cat("✓ Random Forest (ensemble de árboles)\n")
cat("✓ Optimización de hiperparámetros\n")
cat("✓ Proyecto completo de predicción de churn\n\n")

cat("CONCEPTOS CLAVE:\n")
cat("- Random Forest > Árbol simple (casi siempre)\n")
cat("- Árboles: interpretables, RF: precisos\n")
cat("- Importancia de variables es muy útil\n")
cat("- Optimizar hiperparámetros mejora resultados\n\n")

cat("Random Forest es uno de los algoritmos MÁS USADOS en:\n")
cat("- Competencias de Kaggle\n")
cat("- Aplicaciones reales\n")
cat("- Cuando necesitas precisión sin mucho tuning\n\n")

cat("Siguiente: Lección 4 - Support Vector Machines (SVM)\n")

# ============================================================================
# FIN DE LA LECCIÓN
# ============================================================================
