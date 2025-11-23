# Módulo 2: Estadística Descriptiva en SPSS

## 📋 Contenido
1. Introducción a la estadística descriptiva
2. Medidas de tendencia central
3. Medidas de dispersión
4. Tablas de frecuencias
5. Análisis por grupos
6. Tablas de contingencia (cruzadas)
7. Percentiles y cuartiles

---

## 1. Introducción a la Estadística Descriptiva

La **estadística descriptiva** resume y describe las características principales de un conjunto de datos mediante:

- **Medidas numéricas**: media, mediana, desviación estándar, etc.
- **Tablas**: frecuencias, contingencia
- **Gráficos**: histogramas, diagramas de caja (próximo módulo)

### ¿Cuándo usar estadística descriptiva?
- Para conocer tus datos antes de análisis complejos
- Para detectar valores atípicos o errores
- Para presentar resúmenes de información
- Para comparar grupos

---

## 2. Medidas de Tendencia Central

Las medidas de tendencia central indican el **valor típico o central** de un conjunto de datos.

### 2.1 Media Aritmética
- **Definición**: Suma de todos los valores dividida por el número de casos
- **Fórmula**: x̄ = Σx / n
- **Uso**: Datos numéricos sin valores extremos
- **Comando SPSS**: MEAN

### 2.2 Mediana
- **Definición**: Valor que divide los datos en dos mitades iguales
- **Uso**: Cuando hay valores extremos (outliers)
- **Comando SPSS**: MEDIAN

### 2.3 Moda
- **Definición**: Valor más frecuente
- **Uso**: Variables nominales u ordinales
- **Comando SPSS**: MODE

---

## 3. Medidas de Dispersión

Las medidas de dispersión indican qué tan **esparcidos** están los datos.

### 3.1 Rango
- **Definición**: Diferencia entre el máximo y el mínimo
- **Fórmula**: Rango = Máximo - Mínimo
- **Comando SPSS**: RANGE

### 3.2 Varianza
- **Definición**: Promedio de las desviaciones cuadradas respecto a la media
- **Fórmula**: s² = Σ(x - x̄)² / (n-1)
- **Comando SPSS**: VARIANCE

### 3.3 Desviación Estándar
- **Definición**: Raíz cuadrada de la varianza
- **Interpretación**: Cuánto se desvían los datos de la media (en las mismas unidades)
- **Comando SPSS**: STDDEV

### 3.4 Coeficiente de Variación
- **Definición**: (Desviación estándar / Media) × 100
- **Uso**: Comparar variabilidad entre variables con diferentes unidades

---

## 4. Comando DESCRIPTIVES

El comando más básico para estadística descriptiva.

### Sintaxis Básica:

```spss
DESCRIPTIVES VARIABLES=variable1 variable2 variable3
  /STATISTICS=MEAN STDDEV MIN MAX.
```

### Ejemplo Completo:

```spss
* ================================================.
* EJEMPLO 1: ESTADÍSTICAS DESCRIPTIVAS BÁSICAS.
* ================================================.

* Cargar datos de ejemplo (suponemos que ya están cargados).

* Obtener estadísticas descriptivas de variables numéricas.
DESCRIPTIVES VARIABLES=edad salario antiguedad
  /STATISTICS=MEAN STDDEV MIN MAX VARIANCE RANGE
              SEMEAN KURTOSIS SKEWNESS.

* Explicación de opciones:
* MEAN      = Media aritmética
* STDDEV    = Desviación estándar
* MIN       = Valor mínimo
* MAX       = Valor máximo
* VARIANCE  = Varianza
* RANGE     = Rango (Max - Min)
* SEMEAN    = Error estándar de la media
* KURTOSIS  = Curtosis (forma de la distribución)
* SKEWNESS  = Asimetría (sesgo de la distribución)
```

### Opciones Adicionales:

```spss
* Ordenar resultados por la media.
DESCRIPTIVES VARIABLES=salario_enero salario_febrero salario_marzo
  /STATISTICS=MEAN STDDEV
  /SORT=MEAN (D).
* (D) = Descendente, (A) = Ascendente

* Guardar valores estandarizados (Z-scores).
DESCRIPTIVES VARIABLES=edad salario
  /SAVE
  /STATISTICS=MEAN STDDEV.

* Esto crea nuevas variables: Zedad, Zsalario
```

---

## 5. Comando FREQUENCIES

Para tablas de frecuencias y estadísticos de variables categóricas o discretas.

### Ejemplo Básico:

```spss
* ================================================.
* EJEMPLO 2: TABLAS DE FRECUENCIAS.
* ================================================.

* Tabla de frecuencias simple.
FREQUENCIES VARIABLES=departamento genero nivel_educativo.

* Con estadísticos adicionales.
FREQUENCIES VARIABLES=edad
  /STATISTICS=MEAN MEDIAN MODE STDDEV VARIANCE
              MINIMUM MAXIMUM RANGE
              SKEWNESS SESKEW KURTOSIS SEKURT
  /ORDER=ANALYSIS.

* Explicación:
* SKEWNESS = Coeficiente de asimetría
* SESKEW   = Error estándar de asimetría
* KURTOSIS = Coeficiente de curtosis
* SEKURT   = Error estándar de curtosis
* ORDER=ANALYSIS = Ordenar por valores de la variable
```

### Tabla de Frecuencias con Percentiles:

```spss
* Tabla con percentiles y cuartiles.
FREQUENCIES VARIABLES=salario
  /STATISTICS=MEAN MEDIAN STDDEV
  /PERCENTILES=10 25 50 75 90 95 99
  /FORMAT=NOTABLE
  /HISTOGRAM NORMAL.

* PERCENTILES = Especificar percentiles deseados
* FORMAT=NOTABLE = No mostrar tabla de frecuencias
* HISTOGRAM NORMAL = Incluir histograma con curva normal
```

### Tabla de Frecuencias Agrupadas:

```spss
* Crear grupos de edad para tabla de frecuencias.
RECODE edad
  (18 THRU 25 = 1)
  (26 THRU 35 = 2)
  (36 THRU 45 = 3)
  (46 THRU 55 = 4)
  (56 THRU 65 = 5)
  INTO grupo_edad.

VALUE LABELS grupo_edad
  1 '18-25 años'
  2 '26-35 años'
  3 '36-45 años'
  4 '46-55 años'
  5 '56-65 años'.

FREQUENCIES VARIABLES=grupo_edad
  /BARCHART PERCENT.
```

---

## 6. Comando EXAMINE

El comando más completo para análisis exploratorio de datos.

### Sintaxis Completa:

```spss
* ================================================.
* EJEMPLO 3: ANÁLISIS EXPLORATORIO COMPLETO.
* ================================================.

EXAMINE VARIABLES=salario antiguedad
  /PLOT=BOXPLOT STEMLEAF HISTOGRAM NPPLOT
  /STATISTICS=DESCRIPTIVES EXTREME OUTLIERS
  /PERCENTILES(5,10,25,50,75,90,95) HAVERAGE
  /MISSING=LISTWISE
  /NOTOTAL.

* Explicación:
* PLOT=BOXPLOT      = Diagrama de caja
* PLOT=STEMLEAF     = Diagrama de tallo y hojas
* PLOT=HISTOGRAM    = Histograma
* PLOT=NPPLOT       = Gráfico Q-Q normal
* STATISTICS=DESCRIPTIVES = Estadísticos descriptivos
* STATISTICS=EXTREME = Valores extremos (5 más altos y 5 más bajos)
* STATISTICS=OUTLIERS = Identificar valores atípicos
* PERCENTILES       = Calcular percentiles
* HAVERAGE          = Media armónica para percentiles
```

### Análisis por Grupos:

```spss
* Análisis exploratorio por departamento.
EXAMINE VARIABLES=salario BY departamento
  /PLOT=BOXPLOT
  /STATISTICS=DESCRIPTIVES
  /COMPARE=GROUPS
  /PERCENTILES(25,50,75)
  /ID=nombre.

* BY departamento = Separar análisis por grupo
* COMPARE=GROUPS  = Comparar grupos en los gráficos
* ID=nombre       = Identificar casos por nombre
```

---

## 7. Tablas de Contingencia (Cruzadas)

Las **tablas de contingencia** muestran la relación entre dos variables categóricas.

### Sintaxis Básica:

```spss
* ================================================.
* EJEMPLO 4: TABLAS DE CONTINGENCIA.
* ================================================.

CROSSTABS
  /TABLES=departamento BY genero
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT ROW COLUMN TOTAL
  /COUNT ROUND CELL.

* Explicación:
* TABLES=var1 BY var2 = Variable de fila BY variable de columna
* AVALUE = Mostrar valores ascendentes
* CELLS=COUNT  = Frecuencias absolutas
* CELLS=ROW    = Porcentajes por fila
* CELLS=COLUMN = Porcentajes por columna
* CELLS=TOTAL  = Porcentaje del total
```

### Tabla Cruzada con Estadísticos:

```spss
* Tabla cruzada con prueba de chi-cuadrado.
CROSSTABS
  /TABLES=nivel_educativo BY rango_salarial
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ PHI CC
  /CELLS=COUNT EXPECTED ROW COLUMN
  /COUNT ROUND CELL.

* STATISTICS=CHISQ = Chi-cuadrado de Pearson
* STATISTICS=PHI   = Coeficiente Phi
* STATISTICS=CC    = Coeficiente de contingencia
* CELLS=EXPECTED   = Frecuencias esperadas
```

### Tabla Cruzada de Tres Dimensiones:

```spss
* Tabla cruzada controlando por tercera variable.
CROSSTABS
  /TABLES=departamento BY genero BY sucursal
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT ROW.

* Esto crea tablas separadas de departamento*genero para cada sucursal
```

---

## 8. Estadísticos por Grupos (MEANS)

El comando MEANS calcula estadísticos de una variable numérica **separados por grupos**.

### Sintaxis:

```spss
* ================================================.
* EJEMPLO 5: ESTADÍSTICOS POR GRUPOS.
* ================================================.

MEANS TABLES=salario antiguedad BY departamento
  /CELLS=MEAN STDDEV MIN MAX COUNT.

* Salario y antigüedad agrupados por departamento
```

### Análisis de Múltiples Niveles:

```spss
* Análisis por departamento y luego por género.
MEANS TABLES=salario BY departamento BY genero
  /CELLS=MEAN STDDEV COUNT SUM
  /STATISTICS=ANOVA.

* STATISTICS=ANOVA = Incluir análisis de varianza
```

---

## 9. Ejemplo Práctico Completo

Vamos a analizar un dataset de ventas de una empresa.

```spss
* ================================================================.
* EJEMPLO PRÁCTICO: ANÁLISIS DE VENTAS DE UNA EMPRESA.
* ================================================================.

* Crear dataset de ejemplo.
NEW FILE.

DATA LIST FREE
  / vendedor_id (F3.0) nombre (A25) region (F1.0)
    edad (F2.0) antiguedad (F2.0)
    ventas_q1 (F8.2) ventas_q2 (F8.2)
    ventas_q3 (F8.2) ventas_q4 (F8.2)
    categoria (F1.0).

BEGIN DATA
101 "Ana López" 1 28 3 45000 52000 48000 61000 2
102 "Carlos Ruiz" 2 35 7 38000 41000 39000 44000 2
103 "María García" 1 42 12 67000 71000 69000 78000 3
104 "Juan Pérez" 3 31 5 51000 48000 53000 59000 2
105 "Laura Martín" 2 27 2 34000 37000 35000 39000 1
106 "Pedro Sánchez" 1 39 9 59000 63000 61000 68000 3
107 "Isabel Torres" 3 33 6 49000 52000 50000 56000 2
108 "Miguel Díaz" 2 45 15 72000 76000 74000 82000 3
109 "Rosa Fernández" 1 29 4 44000 47000 45000 51000 2
110 "Jorge Morales" 3 36 8 55000 58000 56000 63000 3
111 "Carmen Jiménez" 2 26 1 29000 31000 30000 34000 1
112 "Francisco Álvarez" 1 41 11 64000 68000 66000 73000 3
113 "Patricia Romero" 3 30 5 48000 51000 49000 55000 2
114 "Antonio Navarro" 2 38 10 61000 65000 63000 70000 3
115 "Lucía Herrera" 1 32 6 52000 55000 53000 59000 2
116 "Roberto Castro" 3 44 13 69000 73000 71000 79000 3
117 "Elena Ortiz" 2 28 3 42000 45000 43000 49000 2
118 "David Vega" 1 34 7 56000 59000 57000 64000 3
119 "Beatriz Ramírez" 3 37 9 58000 62000 60000 67000 3
120 "Manuel Guerrero" 2 40 11 65000 69000 67000 74000 3
END DATA.

* Etiquetas.
VARIABLE LABELS
  vendedor_id 'ID del Vendedor'
  nombre 'Nombre del Vendedor'
  region 'Región de Ventas'
  edad 'Edad (años)'
  antiguedad 'Antigüedad (años)'
  ventas_q1 'Ventas Trimestre 1 (EUR)'
  ventas_q2 'Ventas Trimestre 2 (EUR)'
  ventas_q3 'Ventas Trimestre 3 (EUR)'
  ventas_q4 'Ventas Trimestre 4 (EUR)'
  categoria 'Categoría del Vendedor'.

VALUE LABELS
  region 1 'Norte' 2 'Centro' 3 'Sur'
  /categoria 1 'Junior' 2 'Senior' 3 'Experto'.

* ----------------------------------------------------------------.
* PASO 1: Crear variables calculadas.
* ----------------------------------------------------------------.

* Ventas totales anuales.
COMPUTE ventas_anuales = ventas_q1 + ventas_q2 + ventas_q3 + ventas_q4.
VARIABLE LABELS ventas_anuales 'Ventas Anuales Totales (EUR)'.

* Promedio trimestral.
COMPUTE ventas_promedio = MEAN(ventas_q1, ventas_q2, ventas_q3, ventas_q4).
VARIABLE LABELS ventas_promedio 'Promedio Trimestral de Ventas (EUR)'.

* Crecimiento del año (Q4 vs Q1).
COMPUTE crecimiento_anual = ((ventas_q4 - ventas_q1) / ventas_q1) * 100.
VARIABLE LABELS crecimiento_anual 'Crecimiento Anual (%)'.

* Volatilidad de ventas (desviación estándar trimestral).
COMPUTE volatilidad = SD(ventas_q1, ventas_q2, ventas_q3, ventas_q4).
VARIABLE LABELS volatilidad 'Volatilidad de Ventas'.

* Clasificación de rendimiento.
RECODE ventas_anuales
  (LOWEST THRU 150000 = 1)
  (150000 THRU 200000 = 2)
  (200000 THRU 250000 = 3)
  (250000 THRU HIGHEST = 4)
  INTO rendimiento.

VALUE LABELS rendimiento
  1 'Bajo'
  2 'Medio'
  3 'Alto'
  4 'Excepcional'.

EXECUTE.

* ----------------------------------------------------------------.
* PASO 2: Estadísticas descriptivas generales.
* ----------------------------------------------------------------.

DESCRIPTIVES VARIABLES=edad antiguedad ventas_anuales
                       ventas_promedio crecimiento_anual volatilidad
  /STATISTICS=MEAN STDDEV MIN MAX VARIANCE RANGE.

* ----------------------------------------------------------------.
* PASO 3: Análisis de frecuencias.
* ----------------------------------------------------------------.

FREQUENCIES VARIABLES=region categoria rendimiento
  /BARCHART PERCENT
  /ORDER=ANALYSIS.

* ----------------------------------------------------------------.
* PASO 4: Análisis exploratorio completo de ventas anuales.
* ----------------------------------------------------------------.

EXAMINE VARIABLES=ventas_anuales
  /PLOT=BOXPLOT HISTOGRAM NPPLOT
  /STATISTICS=DESCRIPTIVES EXTREME
  /PERCENTILES(10,25,50,75,90)
  /ID=nombre.

* ----------------------------------------------------------------.
* PASO 5: Estadísticos por grupos.
* ----------------------------------------------------------------.

* Ventas por región.
MEANS TABLES=ventas_anuales ventas_promedio crecimiento_anual BY region
  /CELLS=MEAN STDDEV MIN MAX COUNT.

* Ventas por categoría.
MEANS TABLES=ventas_anuales BY categoria
  /CELLS=MEAN STDDEV COUNT
  /STATISTICS=ANOVA.

* Ventas por región y categoría (dos niveles).
MEANS TABLES=ventas_anuales BY region BY categoria
  /CELLS=MEAN COUNT.

* ----------------------------------------------------------------.
* PASO 6: Análisis exploratorio por grupos.
* ----------------------------------------------------------------.

* Ventas anuales por región (con gráficos).
EXAMINE VARIABLES=ventas_anuales BY region
  /PLOT=BOXPLOT
  /STATISTICS=DESCRIPTIVES
  /COMPARE=GROUPS.

* ----------------------------------------------------------------.
* PASO 7: Tablas de contingencia.
* ----------------------------------------------------------------.

* Relación entre región y categoría.
CROSSTABS
  /TABLES=region BY categoria
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ
  /CELLS=COUNT ROW COLUMN TOTAL.

* Relación entre categoría y rendimiento.
CROSSTABS
  /TABLES=categoria BY rendimiento
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT ROW EXPECTED
  /STATISTICS=CHISQ.

* ----------------------------------------------------------------.
* PASO 8: Análisis de percentiles.
* ----------------------------------------------------------------.

FREQUENCIES VARIABLES=ventas_anuales
  /STATISTICS=MEAN MEDIAN
  /PERCENTILES=5 10 25 50 75 90 95
  /FORMAT=NOTABLE.

* ----------------------------------------------------------------.
* PASO 9: Identificar top performers.
* ----------------------------------------------------------------.

* Vendedores en el top 25% de ventas.
RANK VARIABLES=ventas_anuales (D)
  /PERCENT
  /PRINT=YES
  /TIES=MEAN.

RENAME VARIABLES (Pventas_anuales = percentil_ventas).

* Crear indicador de top performer.
IF (percentil_ventas <= 25) top_performer = 1.
IF (percentil_ventas > 25) top_performer = 0.

VALUE LABELS top_performer
  0 'No'
  1 'Sí (Top 25%)'.

EXECUTE.

* Mostrar top performers.
SELECT IF (top_performer = 1).
LIST nombre region categoria ventas_anuales percentil_ventas.

* Restaurar todos los casos.
USE ALL.

* ----------------------------------------------------------------.
* PASO 10: Resumen ejecutivo.
* ----------------------------------------------------------------.

SUMMARIZE
  /TABLES=ventas_anuales crecimiento_anual volatilidad
  /FORMAT=VALIDLIST NOCASENUM TOTAL LIMIT=100
  /TITLE='Resumen de Ventas por Vendedor'
  /MISSING=VARIABLE
  /CELLS=MEAN SUM STDDEV MIN MAX.
```

---

## 10. Interpretación de Resultados

### 10.1 Interpretar DESCRIPTIVES

```
Estadísticos descriptivos

               N    Mínimo   Máximo    Media    Desv. típ.
Ventas Anuales 20   124000   310000   206500.00  52847.32
Edad           20   26       45       34.85      5.82
Antigüedad     20   1        15       7.40       3.91
```

**Interpretación:**
- **Media de ventas**: 206,500 EUR
- **Desviación estándar**: 52,847 EUR (alta variabilidad)
- **Rango**: De 124,000 a 310,000 EUR
- **Edad promedio**: 35 años, relativamente homogénea (SD=5.82)

### 10.2 Interpretar Asimetría y Curtosis

```
Asimetría (Skewness):
  -1 a +1:  Distribución simétrica
  > +1:     Sesgo positivo (cola hacia la derecha)
  < -1:     Sesgo negativo (cola hacia la izquierda)

Curtosis:
  -1 a +1:  Distribución normal
  > +1:     Leptocúrtica (más puntiaguda)
  < -1:     Platicúrtica (más aplanada)
```

### 10.3 Interpretar Percentiles

```
Percentiles de Ventas Anuales:
  P25 = 164,000 EUR  (25% gana menos de esto)
  P50 = 201,000 EUR  (mediana)
  P75 = 248,000 EUR  (25% gana más de esto)
```

---

## 11. Comando SUMMARIZE

Para crear tablas resumen personalizadas.

```spss
* ================================================.
* COMANDO SUMMARIZE.
* ================================================.

SUMMARIZE
  /TABLES=ventas_q1 ventas_q2 ventas_q3 ventas_q4
  /FORMAT=VALIDLIST NOCASENUM TOTAL
  /TITLE='Ventas Trimestrales por Vendedor'
  /MISSING=VARIABLE
  /CELLS=COUNT MEAN SUM MIN MAX STDDEV.
```

---

## 🎯 Ejercicio Práctico 1

### Dataset: Satisfacción del Cliente

Crea un dataset con 30 clientes que incluya:
- ID cliente
- Edad
- Género (1=M, 2=F)
- Región (1=Norte, 2=Sur, 3=Este, 4=Oeste)
- Satisfacción (escala 1-10)
- Monto de compra
- Frecuencia de compra (1=Ocasional, 2=Regular, 3=Frecuente)

**Tareas:**
1. Calcula estadísticos descriptivos de edad, satisfacción y monto de compra
2. Crea tabla de frecuencias de género y región
3. Calcula estadísticos de satisfacción por región
4. Crea tabla cruzada de género × región
5. Identifica los valores extremos de monto de compra
6. Calcula percentiles 25, 50, 75 de satisfacción
7. Clasifica satisfacción en: Baja (1-3), Media (4-7), Alta (8-10)

---

## 🎯 Ejercicio Práctico 2

### Dataset: Rendimiento Académico

Analiza datos de 50 estudiantes con:
- ID estudiante
- Facultad (Ciencias, Humanidades, Ingeniería, Medicina)
- Promedio general (0-10)
- Horas de estudio semanales
- Asistencia (%)
- Beca (Sí/No)

**Tareas:**
1. Descriptivos de promedio, horas de estudio y asistencia
2. Promedio por facultad
3. Comparar promedio entre estudiantes con y sin beca
4. Tabla cruzada facultad × nivel de promedio
5. Identificar top 10% de estudiantes
6. Analizar si hay correlación entre horas de estudio y promedio

---

## 📝 Resumen del Módulo 2

### Has aprendido:
✅ Medidas de tendencia central (media, mediana, moda)
✅ Medidas de dispersión (rango, varianza, desviación estándar)
✅ Comando DESCRIPTIVES para estadísticos rápidos
✅ Comando FREQUENCIES para tablas de frecuencias
✅ Comando EXAMINE para análisis exploratorio completo
✅ Comando MEANS para estadísticos por grupos
✅ Tablas de contingencia con CROSSTABS
✅ Cálculo e interpretación de percentiles
✅ Identificación de valores extremos y atípicos
✅ Interpretación de resultados estadísticos

### Comandos clave:
```spss
DESCRIPTIVES VARIABLES=var1 var2 /STATISTICS=opciones.
FREQUENCIES VARIABLES=var1 /STATISTICS=opciones.
EXAMINE VARIABLES=var1 BY grupo /PLOT=opciones.
MEANS TABLES=var1 BY grupo /CELLS=opciones.
CROSSTABS /TABLES=var1 BY var2 /CELLS=opciones.
SUMMARIZE /TABLES=var1 var2 /CELLS=opciones.
```

### Próximo paso:
Continúa con el **Módulo 3: Gráficos y Visualizaciones** para aprender a crear visualizaciones profesionales de tus datos.

---

## 💡 Consejos de Interpretación

1. **Siempre mira la media Y la mediana**: Si difieren mucho, hay valores atípicos

2. **La desviación estándar en contexto**: Un SD grande significa alta variabilidad

3. **Usa percentiles para comparaciones**: Son más robustos que la media

4. **Verifica normalidad**: Skewness y kurtosis cercanos a 0 indican normalidad

5. **Analiza por grupos**: Las diferencias entre grupos pueden ser muy reveladoras

6. **Valores perdidos**: Siempre revisa cuántos casos tienen datos completos

---

**¡Excelente trabajo!** Ahora dominas el análisis descriptivo en SPSS. Estos fundamentos son esenciales para cualquier análisis estadístico más avanzado.
