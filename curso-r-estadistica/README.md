# 📊 CURSO PRÁCTICO DE ESTADÍSTICA CON R Y RStudio

**De Principiante a Avanzado** - Aprende análisis de datos y estadística con R mediante ejemplos prácticos y ejercicios

---

## 🎯 Sobre Este Curso

Este curso te enseñará a manejar datos estadísticos con R y RStudio desde cero hasta nivel avanzado. Cada lección incluye:

- ✅ **Código completamente comentado** y explicado
- ✅ **Ejemplos prácticos** que puedes ejecutar
- ✅ **Ejercicios** para que practiques
- ✅ **Datasets reales** para análisis
- ✅ **Progresión gradual** desde básico hasta avanzado

---

## 📚 Contenido del Curso

### 🟢 MÓDULO 1: Fundamentos de R (Principiante)

**Objetivo**: Aprender los conceptos básicos de R para comenzar a programar

1. **Lección 1: Introducción a R y RStudio** (`modulo1-fundamentos/leccion1_introduccion.R`)
   - Operaciones básicas (calculadora)
   - Tipos de datos (numérico, carácter, lógico)
   - Variables y asignación
   - Operadores (aritméticos, comparación, lógicos)
   - Funciones básicas

2. **Lección 2: Vectores** (`modulo1-fundamentos/leccion2_vectores.R`)
   - Creación de vectores (c(), seq(), rep())
   - Acceso a elementos
   - Operaciones con vectores
   - Funciones estadísticas básicas (mean, median, sum, etc.)
   - Filtrado y selección

3. **Lección 3: Matrices y Data Frames** (`modulo1-fundamentos/leccion3_matrices_dataframes.R`)
   - Matrices bidimensionales
   - Data frames (tablas de datos)
   - Listas
   - Factores (variables categóricas)
   - Operaciones y filtrado

---

### 🔵 MÓDULO 2: Manipulación de Datos (Intermedio)

**Objetivo**: Dominar la limpieza y transformación de datos con tidyverse

1. **Lección 1: dplyr - Manipulación Básica** (`modulo2-manipulacion/leccion1_dplyr_basico.R`)
   - select(): seleccionar columnas
   - filter(): filtrar filas
   - arrange(): ordenar datos
   - mutate(): crear/modificar columnas
   - summarise(): resúmenes estadísticos
   - group_by(): agrupar datos
   - Pipe operator (%>%)

2. **Lección 2: tidyr - Reestructuración** (`modulo2-manipulacion/leccion2_tidyr_reshape.R`)
   - pivot_longer(): ancho → largo
   - pivot_wider(): largo → ancho
   - separate(): dividir columnas
   - unite(): combinar columnas
   - Manejo de valores faltantes (NA)

---

### 🟣 MÓDULO 3: Visualización de Datos (Intermedio)

**Objetivo**: Crear gráficos profesionales con ggplot2

1. **Lección 1: ggplot2 - Fundamentos** (`modulo3-visualizacion/leccion1_ggplot2_basico.R`)
   - Estructura de ggplot2 (capas)
   - Gráficos de dispersión (scatter plots)
   - Gráficos de líneas
   - Gráficos de barras
   - Histogramas y densidad
   - Boxplots (diagramas de caja)
   - Personalización (títulos, etiquetas, temas)

---

### 🟡 MÓDULO 4: Estadística (Intermedio-Avanzado)

**Objetivo**: Aplicar estadística descriptiva e inferencial

1. **Lección 1: Estadística Descriptiva** (`modulo4-estadistica/leccion1_estadistica_descriptiva.R`)
   - Medidas de tendencia central (media, mediana, moda)
   - Medidas de dispersión (varianza, desviación estándar, IQR)
   - Medidas de posición (cuantiles, percentiles)
   - Distribuciones de frecuencia
   - Análisis exploratorio de datos (EDA)

2. **Lección 2: Estadística Inferencial** (`modulo4-estadistica/leccion2_estadistica_inferencial.R`)
   - Pruebas de hipótesis (conceptos)
   - Prueba t (t-test): una muestra, dos muestras, pareada
   - ANOVA (comparar 3+ grupos)
   - Prueba Chi-cuadrado
   - Intervalos de confianza
   - Correlación y covarianza

---

### 🔴 MÓDULO 5: Modelos Estadísticos Avanzados (Avanzado)

**Objetivo**: Construir modelos predictivos y de clasificación

1. **Lección 1: Regresión Lineal** (`modulo5-avanzado/leccion1_regresion_lineal.R`)
   - Regresión lineal simple
   - Evaluación del modelo (R², RSE, prueba F)
   - Diagnóstico (residuos, normalidad, homocedasticidad)
   - Predicciones con intervalos de confianza
   - Regresión lineal múltiple
   - Comparación de modelos

2. **Lección 2: Regresión Logística** (`modulo5-avanzado/leccion2_regresion_logistica.R`)
   - Introducción a clasificación
   - Crear modelo logístico
   - Odds Ratios (interpretación)
   - Matriz de confusión (exactitud, sensibilidad, precisión)
   - Curva ROC y AUC
   - Predicción de probabilidades
   - Ejemplo: predicción de churn

---

## 📁 Estructura del Proyecto

```
curso-r-estadistica/
│
├── modulo1-fundamentos/
│   ├── leccion1_introduccion.R
│   ├── leccion2_vectores.R
│   └── leccion3_matrices_dataframes.R
│
├── modulo2-manipulacion/
│   ├── leccion1_dplyr_basico.R
│   └── leccion2_tidyr_reshape.R
│
├── modulo3-visualizacion/
│   └── leccion1_ggplot2_basico.R
│
├── modulo4-estadistica/
│   ├── leccion1_estadistica_descriptiva.R
│   └── leccion2_estadistica_inferencial.R
│
├── modulo5-avanzado/
│   ├── leccion1_regresion_lineal.R
│   └── leccion2_regresion_logistica.R
│
├── datasets/
│   ├── generar_datasets.R
│   ├── README_DATASETS.md
│   └── datos_csv/
│       ├── ventas_tienda.csv
│       ├── estudiantes.csv
│       ├── empleados.csv
│       ├── clientes_churn.csv
│       ├── casas.csv
│       ├── productos_inventario.csv
│       └── encuesta_satisfaccion.csv
│
└── README.md (este archivo)
```

---

## 🚀 Cómo Usar Este Curso

### Paso 1: Instalar R y RStudio

1. **Descarga R**: https://cran.r-project.org/
2. **Descarga RStudio**: https://posit.co/download/rstudio-desktop/
3. Instala ambos programas en tu computadora

### Paso 2: Instalar Paquetes Necesarios

Abre RStudio y ejecuta:

```r
# Instalar paquetes principales
install.packages("tidyverse")  # Incluye dplyr, tidyr, ggplot2
install.packages("car")        # Para diagnóstico de regresión
install.packages("pROC")       # Para curvas ROC
```

### Paso 3: Generar Datasets de Práctica

```r
# Navega al directorio del curso
setwd("ruta/a/curso-r-estadistica")

# Genera los datasets
source("datasets/generar_datasets.R")
```

### Paso 4: Comenzar con las Lecciones

1. Abre el archivo R de la lección en RStudio
2. Lee los comentarios y explicaciones
3. Ejecuta el código línea por línea (Ctrl+Enter o Cmd+Enter)
4. Completa los ejercicios propuestos
5. Experimenta con variaciones del código

**Ejemplo**:
```r
# Abrir primera lección
file.edit("modulo1-fundamentos/leccion1_introduccion.R")
```

---

## 💡 Consejos para Aprender

1. **No te saltes lecciones**: El curso está diseñado de forma progresiva
2. **Ejecuta TODO el código**: Aprende haciendo, no solo leyendo
3. **Completa TODOS los ejercicios**: Son la mejor forma de practicar
4. **Experimenta**: Modifica el código para ver qué pasa
5. **Toma notas**: Anota lo que aprendes y tus dudas
6. **Practica regularmente**: Dedica al menos 30 minutos diarios

---

## 📖 Ruta de Aprendizaje Sugerida

### Para Principiantes Absolutos (0-2 semanas)
- Módulo 1 completo
- Practica con vectores y data frames

### Para Usuarios Básicos (2-4 semanas)
- Módulo 2: Manipulación de datos
- Módulo 3: Visualización
- Comienza a analizar los datasets incluidos

### Para Usuarios Intermedios (4-8 semanas)
- Módulo 4: Estadística descriptiva e inferencial
- Practica con pruebas de hipótesis en los datasets

### Para Usuarios Avanzados (8-12 semanas)
- Módulo 5: Modelos de regresión
- Crea tus propios proyectos de análisis

---

## 📊 Datasets Incluidos

El curso incluye 7 datasets de práctica realistas:

1. **ventas_tienda.csv**: Transacciones de ventas (1000 registros)
2. **estudiantes.csv**: Rendimiento académico (200 estudiantes)
3. **empleados.csv**: RRHH y salarios (300 empleados)
4. **clientes_churn.csv**: Cancelación de clientes (500 clientes)
5. **casas.csv**: Precios de propiedades (400 casas)
6. **productos_inventario.csv**: Inventario (100 productos)
7. **encuesta_satisfaccion.csv**: Satisfacción de clientes (300 respuestas)

Ver detalles en: `datasets/README_DATASETS.md`

---

## 🎓 Qué Aprenderás

Al completar este curso, serás capaz de:

- ✅ Programar en R con confianza
- ✅ Limpiar y manipular datos de cualquier fuente
- ✅ Crear visualizaciones profesionales
- ✅ Realizar análisis estadísticos descriptivos e inferenciales
- ✅ Aplicar pruebas de hipótesis correctamente
- ✅ Construir modelos de regresión lineal y logística
- ✅ Evaluar y validar modelos estadísticos
- ✅ Interpretar resultados y comunicar hallazgos
- ✅ Trabajar con datos reales de negocio

---

## 🛠️ Recursos Adicionales

### Documentación Oficial
- [R Documentation](https://www.r-project.org/other-docs.html)
- [RStudio Cheatsheets](https://www.rstudio.com/resources/cheatsheets/)
- [tidyverse](https://www.tidyverse.org/)
- [ggplot2](https://ggplot2.tidyverse.org/)

### Comunidades
- [Stack Overflow - R](https://stackoverflow.com/questions/tagged/r)
- [RStudio Community](https://community.rstudio.com/)
- [r/rstats (Reddit)](https://www.reddit.com/r/rstats/)

### Libros Recomendados (Gratis Online)
- [R for Data Science](https://r4ds.had.co.nz/) - Hadley Wickham
- [Advanced R](https://adv-r.hadley.nz/) - Hadley Wickham
- [Introduction to Statistical Learning](https://www.statlearning.com/) - James et al.

---

## 🤝 Contribuciones y Sugerencias

Si encuentras errores o tienes sugerencias para mejorar el curso:

1. Revisa el código cuidadosamente
2. Propón mejoras específicas
3. Comparte tus proyectos de práctica

---

## 📜 Licencia

Este material educativo es de código abierto y puede ser usado libremente para aprendizaje personal.

---

## ✨ Créditos

Curso desarrollado para enseñar estadística práctica con R de forma accesible y progresiva.

---

## 🎯 ¡Comienza Ahora!

```r
# 1. Configura tu espacio de trabajo
setwd("ruta/a/curso-r-estadistica")

# 2. Genera los datasets
source("datasets/generar_datasets.R")

# 3. Abre la primera lección
file.edit("modulo1-fundamentos/leccion1_introduccion.R")

# ¡Éxito en tu aprendizaje! 🚀
```

---

**¡Bienvenido al mundo del análisis de datos con R!** 📊✨
