# Módulo 7: Machine Learning para Business Intelligence 🤖

## Objetivo
Aplicar técnicas de Machine Learning para resolver problemas reales de negocio: segmentación, predicción y forecasting.

## Contenido

### 📝 Lecciones

1. **01_introduccion_ml.R** - Conceptos básicos de ML para BI
2. **02_clustering_clientes.R** - Segmentación de clientes (K-means)
3. **03_regresion_lineal.R** - Predicción de ventas
4. **04_arboles_decision.R** - Clasificación y reglas de negocio
5. **05_random_forest.R** - Predicciones robustas
6. **06_series_tiempo.R** - Forecasting de demanda
7. **07_analisis_cesta.R** - Market Basket Analysis
8. **08_caso_practico.R** - Proyecto integrador de ML

## ⏱️ Tiempo estimado
10-12 horas de estudio y práctica

## 🎯 Al finalizar este módulo podrás:
- Segmentar clientes automáticamente
- Predecir ventas futuras
- Clasificar transacciones y detectar patrones
- Hacer forecasting de demanda
- Encontrar asociaciones entre productos
- Evaluar modelos de ML
- Implementar soluciones de ML en producción

## 📦 Paquetes necesarios
```r
install.packages("caret")        # Framework de ML
install.packages("cluster")      # Clustering
install.packages("factoextra")   # Visualización de clusters
install.packages("randomForest") # Random Forest
install.packages("rpart")        # Árboles de decisión
install.packages("rpart.plot")   # Visualizar árboles
install.packages("forecast")     # Series de tiempo
install.packages("arules")       # Market basket analysis
```

## 💡 Conceptos clave

### Aprendizaje Supervisado
- **Regresión**: Predecir valores numéricos (ventas, precios)
- **Clasificación**: Predecir categorías (churn, segmento)

### Aprendizaje No Supervisado
- **Clustering**: Agrupar clientes similares
- **Reglas de asociación**: Productos que se compran juntos

### Series de Tiempo
- **Forecasting**: Predecir valores futuros
- **Estacionalidad**: Patrones que se repiten
- **Tendencias**: Dirección a largo plazo

## 🎯 Aplicaciones en BI

### Segmentación de Clientes
- Identificar grupos de clientes con comportamiento similar
- Personalizar estrategias de marketing
- Optimizar recursos

### Predicción de Ventas
- Forecasting de demanda
- Planificación de inventario
- Presupuestos y metas

### Detección de Patrones
- Productos que se compran juntos
- Comportamiento de compra
- Cross-selling y up-selling

### Clasificación de Riesgo
- Clientes con probabilidad de cancelar (churn)
- Detección de fraude
- Scoring de crédito

## 📊 Flujo de trabajo de ML

1. **Definir el problema** - ¿Qué queremos predecir/clasificar?
2. **Recolectar datos** - Obtener datos históricos
3. **Explorar datos** - EDA (Exploratory Data Analysis)
4. **Preparar datos** - Limpieza y transformación
5. **Dividir datos** - Train/Test split
6. **Entrenar modelo** - Ajustar el algoritmo
7. **Evaluar modelo** - Métricas de performance
8. **Optimizar** - Mejorar el modelo
9. **Implementar** - Usar en producción

## 🚀 Comienza por aquí
Abre el archivo `01_introduccion_ml.R` en RStudio.
