# Módulo 5: Correlación y Regresión en SPSS

## 📋 Contenido
1. Correlación de Pearson
2. Correlación de Spearman
3. Matrices de correlación
4. Regresión lineal simple
5. Regresión lineal múltiple
6. Diagnóstico de regresión
7. Supuestos de regresión

---

## 1. Correlación de Pearson

Mide la **relación lineal** entre dos variables continuas.

### Coeficiente r de Pearson:
- **Rango**: -1 a +1
- **r = +1**: Correlación positiva perfecta
- **r = 0**: No hay correlación lineal
- **r = -1**: Correlación negativa perfecta

### Interpretación de la magnitud:
- **0.1 - 0.3**: Correlación débil
- **0.3 - 0.5**: Correlación moderada
- **0.5 - 1.0**: Correlación fuerte

```spss
* ================================================.
* CORRELACIÓN DE PEARSON.
* ================================================.

* Correlación entre dos variables.
CORRELATIONS
  /VARIABLES=edad salario
  /PRINT=TWOTAIL NOSIG
  /STATISTICS=DESCRIPTIVES
  /MISSING=PAIRWISE.

* Explicación:
* TWOTAIL = Prueba bilateral
* NOSIG = No marcar significancias
* DESCRIPTIVES = Incluir media y SD
* PAIRWISE = Usar todos los casos disponibles para cada par
```

### Ejemplo con Datos

```spss
* Crear dataset de ejemplo.
NEW FILE.

DATA LIST FREE
  / empleado_id (F3.0) edad (F2.0) antiguedad (F2.0)
    salario (F7.2) satisfaccion (F3.1) productividad (F5.2).

BEGIN DATA
1 28 3 35000 7.5 85.2
2 35 7 45000 8.1 88.5
3 42 12 58000 7.8 90.3
4 31 5 40000 6.9 82.1
5 27 2 32000 6.5 78.5
6 39 9 52000 8.5 91.2
7 33 6 43000 7.2 84.8
8 45 15 62000 8.8 93.5
9 29 4 37000 7.0 80.9
10 36 8 48000 8.2 89.1
11 26 1 30000 6.2 75.3
12 41 11 55000 8.4 92.1
13 30 5 39000 7.3 83.5
14 38 10 51000 8.3 90.8
15 32 6 42000 7.5 85.7
END DATA.

* Correlación entre salario y productividad.
CORRELATIONS
  /VARIABLES=salario productividad
  /PRINT=TWOTAIL SIG
  /STATISTICS=DESCRIPTIVES.
```

---

## 2. Correlación de Spearman

Para datos **ordinales** o cuando no hay **normalidad**.

```spss
* ================================================.
* CORRELACIÓN DE SPEARMAN (NO PARAMÉTRICA).
* ================================================.

NONPAR CORR
  /VARIABLES=satisfaccion productividad
  /PRINT=SPEARMAN TWOTAIL NOSIG
  /MISSING=PAIRWISE.

* SPEARMAN = Coeficiente de Spearman (rho)
```

---

## 3. Matriz de Correlaciones

Analiza correlaciones entre **múltiples variables simultáneamente**.

```spss
* ================================================.
* MATRIZ DE CORRELACIONES.
* ================================================.

CORRELATIONS
  /VARIABLES=edad antiguedad salario satisfaccion productividad
  /PRINT=TWOTAIL SIG
  /STATISTICS=DESCRIPTIVES
  /MATRIX=OUT('correlaciones.sav')
  /MISSING=PAIRWISE.

* MATRIX=OUT = Guardar matriz de correlaciones
```

### Interpretación de Matriz

```
                Edad    Antigüedad  Salario   Satisfacción  Productividad
Edad            1.000
Antigüedad      0.892**   1.000
Salario         0.854**   0.921**    1.000
Satisfacción    0.623*    0.701**    0.715**    1.000
Productividad   0.735**   0.788**    0.823**    0.856**      1.000

** p < 0.01
*  p < 0.05
```

---

## 4. Regresión Lineal Simple

Predice una variable dependiente (Y) a partir de una variable independiente (X).

### Ecuación: Y = b₀ + b₁X + ε

- **b₀**: Intercepto (valor de Y cuando X=0)
- **b₁**: Pendiente (cambio en Y por unidad de X)
- **ε**: Error

```spss
* ================================================.
* REGRESIÓN LINEAL SIMPLE.
* ================================================.

* Predecir productividad a partir de salario.
REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA CHANGE ZPP
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT productividad
  /METHOD=ENTER salario
  /SCATTERPLOT=(*ZRESID ,*ZPRED)
  /RESIDUALS HISTOGRAM(ZRESID) NORMPROB(ZRESID).

* Explicación:
* DESCRIPTIVES = Estadísticos descriptivos
* COEFF = Coeficientes de regresión
* R = R, R², R² ajustado
* ANOVA = Tabla ANOVA
* SCATTERPLOT = Gráfico de residuos vs predichos
* RESIDUALS = Diagnósticos de residuos
```

### Interpretación de Resultados

```
Resumen del modelo
Modelo   R      R²     R² ajustado   Error típ. de la estimación
1       .823   .677      .652              3.52

ANOVA
Modelo              Suma de cuadrados   gl    Media cuadrática    F        Sig.
1  Regresión            324.56          1         324.56        26.18    .000
   Residual             161.22         13          12.40
   Total                485.78         14

Coeficientes
                    B no estd.    Error típ.    Beta      t       Sig.
(Constante)          65.324        2.145                 30.44   .000
Salario               0.0004        0.000       .823     5.12   .000
```

**Interpretación:**
- **R² = 0.677**: El 67.7% de la varianza en productividad se explica por el salario
- **F(1,13) = 26.18, p < .001**: El modelo es significativo
- **b₁ = 0.0004**: Por cada EUR de aumento en salario, la productividad aumenta 0.04 puntos
- **Ecuación**: Productividad = 65.324 + 0.0004×Salario

---

## 5. Regresión Lineal Múltiple

Predice Y a partir de **múltiples variables independientes**.

### Ecuación: Y = b₀ + b₁X₁ + b₂X₂ + ... + bₖXₖ + ε

```spss
* ================================================.
* REGRESIÓN LINEAL MÚLTIPLE.
* ================================================.

* Predecir productividad a partir de múltiples predictores.
REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA CHANGE COLLIN TOL
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT productividad
  /METHOD=ENTER edad antiguedad salario satisfaccion
  /SCATTERPLOT=(*ZRESID ,*ZPRED)
  /RESIDUALS HISTOGRAM(ZRESID) NORMPROB(ZRESID)
  /SAVE PRED RESID ZPRED ZRESID.

* Explicación adicional:
* COLLIN TOL = Diagnósticos de colinealidad
* SAVE PRED = Guardar valores predichos
* SAVE RESID = Guardar residuos
```

### Interpretación de Coeficientes

```
Coeficientes
                    B        Error típ.    Beta      t       Sig.     VIF
(Constante)       50.21        5.32                  9.44   .000
Edad               0.15        0.18        .145      0.83   .425     3.21
Antigüedad         0.32        0.21        .298      1.52   .159     4.15
Salario            0.0002      0.0001      .412      2.18   .055     3.87
Satisfacción       2.45        0.68        .385      3.60   .005     1.52
```

**Interpretación:**
- **Satisfacción** es el predictor más significativo (p = .005)
- **VIF < 10**: No hay multicolinealidad severa
- **R² ajustado**: Usar este en lugar de R² en regresión múltiple

---

## 6. Métodos de Selección de Variables

### 6.1 Método Enter (Introducir)

Todas las variables entran simultáneamente (ya visto arriba).

### 6.2 Método Stepwise (Paso a paso)

```spss
* Selección automática de variables.
REGRESSION
  /STATISTICS COEFF OUTS R ANOVA CHANGE
  /DEPENDENT productividad
  /METHOD=STEPWISE edad antiguedad salario satisfaccion.

* Criterio: Incluye variables con p < .05, excluye con p > .10
```

### 6.3 Método Forward (Hacia adelante)

```spss
REGRESSION
  /STATISTICS COEFF OUTS R ANOVA
  /DEPENDENT productividad
  /METHOD=FORWARD edad antiguedad salario satisfaccion.
```

### 6.4 Método Backward (Hacia atrás)

```spss
REGRESSION
  /STATISTICS COEFF OUTS R ANOVA
  /DEPENDENT productividad
  /METHOD=BACKWARD edad antiguedad salario satisfaccion.
```

---

## 7. Diagnóstico de Regresión

### 7.1 Supuestos de Regresión Lineal

1. **Linealidad**: Relación lineal entre X e Y
2. **Independencia**: Observaciones independientes
3. **Homocedasticidad**: Varianza constante de residuos
4. **Normalidad**: Residuos distribuidos normalmente
5. **No multicolinealidad**: Predictores no altamente correlacionados

### 7.2 Verificar Linealidad

```spss
* Gráfico de dispersión.
GRAPH
  /SCATTERPLOT(BIVAR)=salario WITH productividad
  /MISSING=LISTWISE.
```

### 7.3 Verificar Homocedasticidad

```spss
* Después de ejecutar regresión con /SAVE PRED RESID:

* Gráfico de residuos vs predichos.
GRAPH
  /SCATTERPLOT(BIVAR)=PRE_1 WITH RES_1
  /MISSING=LISTWISE.

* Si hay patrón de embudo → heterocedasticidad
```

### 7.4 Verificar Normalidad de Residuos

```spss
* Histograma de residuos.
GRAPH
  /HISTOGRAM=RES_1.

* Q-Q plot.
PPLOT
  /VARIABLES=RES_1
  /NOLOG
  /NOSTANDARDIZE
  /TYPE=Q-Q
  /FRACTION=BLOM
  /TIES=MEAN
  /DIST=NORMAL.

* Prueba formal.
EXAMINE VARIABLES=RES_1
  /PLOT=NPPLOT
  /STATISTICS=NONE
  /CINTERVAL 95
  /MISSING=LISTWISE
  /NOTOTAL.
```

### 7.5 Detectar Multicolinealidad

```spss
* Ya incluido en REGRESSION con /STATISTICS COLLIN TOL:

VIF (Factor de Inflación de Varianza):
- VIF < 5: No hay problema
- VIF 5-10: Multicolinealidad moderada
- VIF > 10: Multicolinealidad severa

Tolerancia:
- TOL > 0.2: Aceptable
- TOL < 0.1: Problema
```

### 7.6 Detectar Valores Influyentes

```spss
* Guardar estadísticos de influencia.
REGRESSION
  /DEPENDENT productividad
  /METHOD=ENTER salario satisfaccion
  /SAVE COOK LEVER DFBETA.

* COOK = Distancia de Cook (> 1 indica influencia excesiva)
* LEVER = Leverage (> 2p/n indica punto de palanca)
* DFBETA = Cambio en coeficiente al eliminar caso
```

---

## 8. Transformaciones de Variables

### 8.1 Transformación Logarítmica

```spss
* Para relaciones no lineales o heterocedasticidad.
COMPUTE log_salario = LG10(salario).
COMPUTE ln_salario = LN(salario).

REGRESSION
  /DEPENDENT productividad
  /METHOD=ENTER log_salario.
```

### 8.2 Transformación Cuadrática

```spss
* Para relaciones curvilíneas.
COMPUTE salario_cuadrado = salario * salario.

REGRESSION
  /DEPENDENT productividad
  /METHOD=ENTER salario salario_cuadrado.
```

---

## 9. Ejemplo Práctico Completo

### Predecir Ventas de Productos

```spss
* ================================================================.
* EJEMPLO: PREDECIR VENTAS DE PRODUCTOS.
* ================================================================.

NEW FILE.

DATA LIST FREE
  / producto_id (F3.0) precio (F6.2) publicidad (F7.2)
    competidores (F2.0) calidad (F3.1) ventas (F8.2).

BEGIN DATA
1 25.00 5000 3 8.5 125000
2 30.00 7500 2 9.0 158000
3 20.00 3000 5 7.5 98000
4 35.00 10000 1 9.5 198000
5 22.00 4000 4 7.8 102000
6 28.00 6000 3 8.8 142000
7 32.00 8500 2 9.2 175000
8 18.00 2500 6 7.0 85000
9 38.00 12000 1 9.8 215000
10 26.00 5500 3 8.3 130000
11 21.00 3500 5 7.6 95000
12 33.00 9000 2 9.3 182000
13 27.00 6500 3 8.6 145000
14 23.00 4500 4 8.0 108000
15 36.00 11000 1 9.6 205000
16 24.00 5200 4 8.2 118000
17 31.00 7800 2 9.1 165000
18 19.00 2800 6 7.2 88000
19 34.00 9500 2 9.4 188000
20 29.00 7000 3 8.9 152000
END DATA.

VARIABLE LABELS
  precio 'Precio del Producto (EUR)'
  publicidad 'Inversión en Publicidad (EUR)'
  competidores 'Número de Competidores'
  calidad 'Calificación de Calidad (1-10)'
  ventas 'Ventas Mensuales (EUR)'.

* ----------------------------------------------------------------.
* PASO 1: Análisis descriptivo y correlaciones.
* ----------------------------------------------------------------.

DESCRIPTIVES VARIABLES=precio publicidad competidores calidad ventas
  /STATISTICS=MEAN STDDEV MIN MAX.

CORRELATIONS
  /VARIABLES=precio publicidad competidores calidad ventas
  /PRINT=TWOTAIL SIG
  /MISSING=PAIRWISE.

* ----------------------------------------------------------------.
* PASO 2: Visualizar relaciones.
* ----------------------------------------------------------------.

GRAPH
  /SCATTERPLOT(BIVAR)=publicidad WITH ventas.

GRAPH
  /SCATTERPLOT(BIVAR)=precio WITH ventas.

GRAPH
  /SCATTERPLOT(BIVAR)=calidad WITH ventas.

* ----------------------------------------------------------------.
* PASO 3: Regresión simple (publicidad predice ventas).
* ----------------------------------------------------------------.

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR
  /DEPENDENT ventas
  /METHOD=ENTER publicidad
  /STATISTICS COEFF OUTS R ANOVA
  /SCATTERPLOT=(*ZRESID ,*ZPRED).

* ----------------------------------------------------------------.
* PASO 4: Regresión múltiple (todos los predictores).
* ----------------------------------------------------------------.

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR
  /DEPENDENT ventas
  /METHOD=ENTER precio publicidad competidores calidad
  /STATISTICS COEFF OUTS R ANOVA COLLIN TOL
  /CRITERIA=PIN(.05) POUT(.10)
  /RESIDUALS HISTOGRAM(ZRESID) NORMPROB(ZRESID)
  /SAVE PRED RESID ZPRED ZRESID COOK.

* ----------------------------------------------------------------.
* PASO 5: Verificar supuestos.
* ----------------------------------------------------------------.

* Normalidad de residuos.
EXAMINE VARIABLES=RES_1
  /PLOT=NPPLOT HISTOGRAM.

* Homocedasticidad.
GRAPH
  /SCATTERPLOT(BIVAR)=PRE_1 WITH RES_1.

* Valores influyentes.
FREQUENCIES VARIABLES=COO_1
  /STATISTICS=MEAN MAX
  /ORDER=ANALYSIS.

* ----------------------------------------------------------------.
* PASO 6: Regresión con selección stepwise.
* ----------------------------------------------------------------.

REGRESSION
  /DEPENDENT ventas
  /METHOD=STEPWISE precio publicidad competidores calidad
  /STATISTICS COEFF OUTS R ANOVA CHANGE.

* ----------------------------------------------------------------.
* PASO 7: Interpretación y predicción.
* ----------------------------------------------------------------.

* Con el modelo final, podemos predecir:
* Ventas = b0 + b1(Publicidad) + b2(Calidad) + ...

* Ejemplo: Si publicidad = 8000 y calidad = 9.0
* Ventas predichas = [usar ecuación del modelo final]
```

---

## 🎯 Ejercicio Práctico 1

### Predicción de Precios de Viviendas

Crea un dataset de 30 viviendas con:
- Metros cuadrados
- Número de habitaciones
- Antigüedad (años)
- Distancia al centro (km)
- Precio (miles de EUR)

**Tareas:**
1. Correlaciones entre todas las variables
2. Regresión simple: m² predice precio
3. Regresión múltiple con todos los predictores
4. Verificar supuestos de regresión
5. Interpretar R², coeficientes y significancia
6. Identificar variables más importantes
7. Predecir precio de una vivienda nueva

---

## 🎯 Ejercicio Práctico 2

### Factores de Satisfacción Laboral

Crea datos de 40 empleados con:
- Salario
- Horas de trabajo semanales
- Años en la empresa
- Relación con jefe (1-10)
- Balance vida-trabajo (1-10)
- Satisfacción laboral (1-10)

**Tareas:**
1. Matriz de correlaciones
2. Regresión múltiple prediciendo satisfacción
3. Usar método stepwise
4. Verificar multicolinealidad
5. Interpretar modelo final
6. Crear ecuación predictiva

---

## 📝 Resumen del Módulo 5

### Has aprendido:
✅ Calcular e interpretar correlaciones de Pearson y Spearman
✅ Crear matrices de correlación
✅ Realizar regresión lineal simple
✅ Realizar regresión lineal múltiple
✅ Métodos de selección de variables (stepwise, forward, backward)
✅ Verificar supuestos de regresión (linealidad, normalidad, homocedasticidad)
✅ Diagnosticar multicolinealidad (VIF, tolerancia)
✅ Detectar casos influyentes (Cook, leverage)
✅ Transformar variables para mejorar modelos
✅ Interpretar R², coeficientes y significancia

### Comandos clave:
```spss
CORRELATIONS /VARIABLES=var1 var2.
NONPAR CORR /VARIABLES=var1 var2 /PRINT=SPEARMAN.
REGRESSION /DEPENDENT y /METHOD=ENTER x1 x2.
REGRESSION /DEPENDENT y /METHOD=STEPWISE x1 x2 x3.
```

### Próximo paso:
Continúa con el **Módulo 6: ANOVA y Comparaciones Múltiples** para comparar medias de múltiples grupos.

---

## 💡 Consejos Importantes

1. **Correlación ≠ Causalidad**: Una correlación alta no implica que X causa Y

2. **R² ajustado en regresión múltiple**: Siempre reportar R² ajustado, no R²

3. **Multicolinealidad**: Elimina o combina variables altamente correlacionadas

4. **Verifica supuestos**: Resultados no válidos si se violan supuestos

5. **Tamaño de muestra**: Regla general: n > 10k + 50 (k = número de predictores)

6. **Estandarizar para comparar**: Usa coeficientes Beta para comparar importancia relativa

---

**¡Fantástico!** Ahora dominas el análisis de correlación y regresión en SPSS, herramientas fundamentales para modelado predictivo.
