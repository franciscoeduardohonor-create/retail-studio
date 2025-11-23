# 📚 Curso Práctico de Machine Learning con RStudio
### De Principiante a Avanzado

¡Bienvenido al curso más completo de Machine Learning usando RStudio! Este curso te llevará desde los fundamentos de R hasta algoritmos avanzados de ML con ejemplos prácticos y código comentado.

## 🎯 Objetivos del Curso

- Dominar R y RStudio desde cero
- Entender los fundamentos de Machine Learning
- Implementar algoritmos de ML supervisado y no supervisado
- Trabajar con datasets reales
- Crear proyectos completos de ML
- Optimizar y evaluar modelos

## 📋 Estructura del Curso

### 📘 Módulo 1: Fundamentos de R (Principiante)
**Duración estimada: 2-3 semanas**

1. **Lección 1:** Introducción a R y RStudio
2. **Lección 2:** Tipos de datos y estructuras
3. **Lección 3:** Operadores y control de flujo
4. **Lección 4:** Funciones en R
5. **Lección 5:** Paquetes esenciales

📁 Carpeta: `modulo1-fundamentos/`

### 📗 Módulo 2: Manipulación y Visualización de Datos (Principiante-Intermedio)
**Duración estimada: 3-4 semanas**

1. **Lección 1:** Importación de datos (CSV, Excel, SQL)
2. **Lección 2:** Manipulación con dplyr
3. **Lección 3:** Transformación con tidyr
4. **Lección 4:** Visualización con ggplot2
5. **Lección 5:** Análisis exploratorio de datos (EDA)

📁 Carpeta: `modulo2-datos/`

### 📙 Módulo 3: Estadística y Preparación para ML (Intermedio)
**Duración estimada: 2-3 semanas**

1. **Lección 1:** Estadística descriptiva
2. **Lección 2:** Distribuciones y probabilidad
3. **Lección 3:** Pruebas de hipótesis
4. **Lección 4:** Correlación y regresión lineal
5. **Lección 5:** Preparación de datos para ML

📁 Carpeta: `modulo3-estadistica/`

### 📕 Módulo 4: Algoritmos Supervisados (Intermedio-Avanzado)
**Duración estimada: 4-5 semanas**

1. **Lección 1:** Regresión Lineal y Múltiple
2. **Lección 2:** Regresión Logística
3. **Lección 3:** Árboles de Decisión y Random Forest
4. **Lección 4:** Support Vector Machines (SVM)
5. **Lección 5:** K-Nearest Neighbors (KNN)
6. **Lección 6:** Gradient Boosting (XGBoost, LightGBM)
7. **Lección 7:** Validación cruzada y métricas

📁 Carpeta: `modulo4-supervisado/`

### 📓 Módulo 5: Algoritmos No Supervisados (Intermedio-Avanzado)
**Duración estimada: 3-4 semanas**

1. **Lección 1:** K-Means Clustering
2. **Lección 2:** Clustering Jerárquico
3. **Lección 3:** DBSCAN
4. **Lección 4:** PCA (Análisis de Componentes Principales)
5. **Lección 5:** Reglas de Asociación

📁 Carpeta: `modulo5-no-supervisado/`

### 📔 Módulo 6: Algoritmos Avanzados (Avanzado)
**Duración estimada: 4-5 semanas**

1. **Lección 1:** Redes Neuronales con keras
2. **Lección 2:** Deep Learning para clasificación
3. **Lección 3:** Series de tiempo y pronósticos
4. **Lección 4:** Procesamiento de texto (NLP)
5. **Lección 5:** Ensemble Methods avanzados
6. **Lección 6:** AutoML con H2O

📁 Carpeta: `modulo6-avanzado/`

### 🚀 Proyectos Prácticos Completos
**Duración estimada: 4-6 semanas**

1. **Proyecto 1:** Predicción de precios de viviendas
2. **Proyecto 2:** Sistema de recomendación
3. **Proyecto 3:** Clasificación de clientes (Churn)
4. **Proyecto 4:** Detección de fraude
5. **Proyecto 5:** Análisis de sentimientos
6. **Proyecto 6:** Pronóstico de ventas

📁 Carpeta: `proyectos/`

## 🛠️ Requisitos Previos

### Software necesario:
```r
# 1. Descargar e instalar R (versión 4.0 o superior)
# https://cran.r-project.org/

# 2. Descargar e instalar RStudio
# https://www.rstudio.com/products/rstudio/download/
```

### Paquetes que instalaremos:
```r
# Ejecutar este código en RStudio al comenzar el curso
install.packages(c(
  # Manipulación de datos
  "tidyverse", "dplyr", "tidyr", "readr", "readxl",

  # Visualización
  "ggplot2", "plotly", "corrplot", "GGally",

  # Machine Learning
  "caret", "mlr3", "randomForest", "e1071", "class",
  "rpart", "xgboost", "lightgbm", "glmnet",

  # Deep Learning
  "keras", "tensorflow",

  # Clustering
  "cluster", "factoextra", "dbscan",

  # Series de tiempo
  "forecast", "prophet", "tseries",

  # Text Mining
  "tm", "tidytext", "wordcloud",

  # AutoML
  "h2o",

  # Evaluación
  "yardstick", "MLmetrics", "pROC"
))
```

## 📖 Cómo usar este curso

### Para principiantes absolutos:
1. Comienza con el **Módulo 1** y completa todas las lecciones en orden
2. Practica cada ejercicio proporcionado
3. No avances al siguiente módulo hasta dominar el actual
4. Dedica tiempo a los ejercicios prácticos

### Para usuarios con experiencia en R:
1. Puedes saltar al **Módulo 3** si ya conoces R básico
2. Revisa el Módulo 2 si necesitas refrescar manipulación de datos
3. Enfócate en los módulos 4-6 para ML

### Para usuarios avanzados:
1. Ve directo a los **Módulos 4-6**
2. Usa los proyectos prácticos para consolidar conocimientos
3. Experimenta modificando los ejemplos

## 💡 Metodología de Aprendizaje

Cada lección incluye:

1. **📝 Teoría:** Explicación conceptual del tema
2. **💻 Código comentado:** Ejemplos paso a paso
3. **🔍 Explicación detallada:** Qué hace cada línea
4. **🎯 Ejercicios prácticos:** Para que practiques
5. **🏆 Desafíos:** Problemas más complejos
6. **✅ Soluciones:** Con explicaciones completas

## 📊 Datasets Incluidos

Encontrarás datasets reales en la carpeta `datasets/`:
- Iris (clasificación)
- Titanic (clasificación binaria)
- Boston Housing (regresión)
- Mall Customers (clustering)
- Stock prices (series de tiempo)
- Y muchos más...

## 🎓 Certificación

Al completar cada módulo, encontrarás un archivo de evaluación. Completa todos los módulos y proyectos para dominar ML con R.

## 📞 Soporte

- Cada archivo de código incluye comentarios detallados
- Los README de cada módulo tienen información adicional
- Experimenta y modifica el código libremente

## 🚀 ¡Comienza Ahora!

### Paso 1: Configura tu entorno
```r
# Abre RStudio y ejecuta:
source("setup.R")  # Este archivo verificará tu instalación
```

### Paso 2: Comienza con el Módulo 1
```r
# Navega a: modulo1-fundamentos/leccion1-introduccion.R
```

### Paso 3: Practica, practica, practica
¡La clave del éxito es la práctica constante!

---

## 📚 Recursos Adicionales

- [Documentación oficial de R](https://www.r-project.org/)
- [RStudio Cheatsheets](https://www.rstudio.com/resources/cheatsheets/)
- [R for Data Science](https://r4ds.had.co.nz/)
- [Advanced R](https://adv-r.hadley.nz/)

---

**¡Disfruta tu viaje en el mundo del Machine Learning con R! 🎉**

*Última actualización: Noviembre 2025*
