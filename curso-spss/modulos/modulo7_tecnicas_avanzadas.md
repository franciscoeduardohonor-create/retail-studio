# Módulo 7: Técnicas Avanzadas en SPSS

## 📋 Contenido
1. Análisis Factorial Exploratorio (AFE)
2. Análisis de Confiabilidad (Alfa de Cronbach)
3. Regresión Logística
4. Análisis Discriminante
5. Análisis de Conglomerados (Cluster)
6. Análisis de Componentes Principales (ACP)
7. Análisis de Supervivencia
8. Series Temporales

---

## 1. Análisis Factorial Exploratorio (AFE)

El **AFE** identifica **factores subyacentes** (no observables) a partir de múltiples variables observadas.

### ¿Cuándo usar AFE?
- Reducir dimensionalidad de datos
- Identificar constructos latentes
- Validar escalas psicométricas

### Ejemplo: Cuestionario de Satisfacción Laboral

```spss
* ================================================================.
* ANÁLISIS FACTORIAL EXPLORATORIO.
* ================================================================.

* Crear datos de cuestionario (20 items, escala 1-7).
NEW FILE.

DATA LIST FREE
  / id (F3.0) item1 item2 item3 item4 item5
    item6 item7 item8 item9 item10
    item11 item12 item13 item14 item15.

BEGIN DATA
1 6 7 6 5 6 4 5 4 3 3 6 7 6 5 6
2 5 6 5 4 5 3 4 3 2 2 5 6 5 4 5
3 7 7 6 6 7 5 6 5 4 4 7 7 6 6 7
4 4 5 4 3 4 2 3 2 1 1 4 5 4 3 4
5 6 6 5 5 6 4 5 4 3 3 6 6 5 5 6
6 5 5 4 4 5 3 4 3 2 2 5 5 4 4 5
7 7 6 6 5 6 5 5 4 4 4 7 6 6 5 6
8 3 4 3 2 3 1 2 1 1 1 3 4 3 2 3
9 6 7 6 5 6 4 5 4 3 3 6 7 6 5 6
10 5 6 5 4 5 3 4 3 2 2 5 6 5 4 5
END DATA.

* Items 1-5: Satisfacción con el trabajo
* Items 6-10: Relación con compañeros
* Items 11-15: Satisfacción con supervisión

* ----------------------------------------------------------------.
* PASO 1: Verificar adecuación de los datos.
* ----------------------------------------------------------------.

FACTOR
  /VARIABLES item1 TO item15
  /PRINT INITIAL KMO EXTRACTION
  /CRITERIA MINEIGEN(1)
  /EXTRACTION PC
  /ROTATION NOROTATE.

* KMO (Kaiser-Meyer-Olkin):
* > 0.90: Excelente
* > 0.80: Bueno
* > 0.70: Aceptable
* > 0.60: Mediocre
* < 0.50: Inaceptable

* Prueba de Bartlett:
* p < 0.05: Los datos son factorizables

* ----------------------------------------------------------------.
* PASO 2: Análisis factorial con rotación.
* ----------------------------------------------------------------.

FACTOR
  /VARIABLES item1 TO item15
  /MISSING LISTWISE
  /ANALYSIS item1 TO item15
  /PRINT INITIAL EXTRACTION ROTATION
  /FORMAT SORT BLANK(.4)
  /PLOT EIGEN
  /CRITERIA MINEIGEN(1) ITERATE(25)
  /EXTRACTION PAF
  /CRITERIA ITERATE(25)
  /ROTATION VARIMAX
  /METHOD=CORRELATION.

* Explicación:
* EXTRACTION PAF = Factorización de ejes principales
* ROTATION VARIMAX = Rotación ortogonal (factores independientes)
* BLANK(.4) = Ocultar cargas < 0.4
* SORT = Ordenar cargas por tamaño
```

### Métodos de Extracción:

| Método | Cuándo usar |
|--------|-------------|
| **PC (Componentes Principales)** | Reducción de datos |
| **PAF (Principal Axis Factoring)** | Identificar factores latentes |
| **ML (Maximum Likelihood)** | Permite pruebas de bondad de ajuste |

### Métodos de Rotación:

| Método | Tipo | Cuándo usar |
|--------|------|-------------|
| **Varimax** | Ortogonal | Factores independientes |
| **Oblimin** | Oblicua | Factores correlacionados |
| **Promax** | Oblicua | Grandes conjuntos de datos |

### Interpretación:

```
Matriz de componentes rotados
              Factor 1    Factor 2    Factor 3
Item1           .812
Item2           .795
Item3           .801
Item4           .767
Item5           .788
Item6                       .745
Item7                       .732
Item8                       .698
Item9                       .712
Item10                      .725
Item11                                  .823
Item12                                  .811
Item13                                  .798
Item14                                  .776
Item15                                  .805

Varianza explicada:
Factor 1: 28.5%
Factor 2: 24.3%
Factor 3: 22.1%
Total: 74.9%
```

**Interpretación:**
- **Factor 1**: Satisfacción con el trabajo
- **Factor 2**: Relación con compañeros
- **Factor 3**: Satisfacción con supervisión

### Crear Puntuaciones Factoriales:

```spss
* Guardar puntuaciones factoriales.
FACTOR
  /VARIABLES item1 TO item15
  /EXTRACTION PAF
  /CRITERIA ITERATE(25)
  /ROTATION VARIMAX
  /SAVE REG(ALL)
  /METHOD=CORRELATION.

* Esto crea variables FAC1_1, FAC2_1, FAC3_1
```

---

## 2. Análisis de Confiabilidad (Alfa de Cronbach)

Evalúa la **consistencia interna** de una escala.

### ¿Qué es Alfa de Cronbach?
- Varía de 0 a 1
- **α > 0.90**: Excelente
- **α > 0.80**: Bueno
- **α > 0.70**: Aceptable
- **α > 0.60**: Cuestionable
- **α < 0.50**: Inaceptable

```spss
* ================================================================.
* ANÁLISIS DE CONFIABILIDAD.
* ================================================================.

* Análisis de confiabilidad para Factor 1.
RELIABILITY
  /VARIABLES=item1 item2 item3 item4 item5
  /SCALE('Factor 1: Satisfacción Trabajo') ALL
  /MODEL=ALPHA
  /STATISTICS=DESCRIPTIVE SCALE CORR
  /SUMMARY=TOTAL MEANS VARIANCE COV.

* Explicación:
* MODEL=ALPHA = Alfa de Cronbach
* STATISTICS=CORR = Correlaciones inter-item
* SUMMARY=TOTAL = Estadísticos si se elimina item
```

### Interpretación:

```
Estadísticos de fiabilidad
Alfa de Cronbach    N de elementos
      .845                5

Estadísticos total-elemento
              Media si se   Alfa de Cronbach
              elimina       si se elimina
Item1           20.5             .812
Item2           20.3             .808
Item3           20.6             .825
Item4           21.2             .840
Item5           20.7             .818
```

**Interpretación:**
- **α = .845**: Buena consistencia interna
- Eliminar Item4 aumentaría levemente el alfa
- Generalmente NO se eliminan items a menos que α < .70

---

## 3. Regresión Logística

Para predecir una **variable dicotómica** (0/1, Sí/No).

### Ejemplo: Predecir Riesgo de Abandono (Churn)

```spss
* ================================================================.
* REGRESIÓN LOGÍSTICA BINARIA.
* ================================================================.

NEW FILE.

DATA LIST FREE
  / cliente_id (F4.0) edad (F2.0) ingresos (F6.0)
    satisfaccion (F3.1) meses_cliente (F3.0)
    quejas (F2.0) abandono (F1.0).

BEGIN DATA
1 28 35000 7.5 24 0 0
2 35 45000 6.2 12 2 1
3 42 58000 8.1 48 0 0
4 31 40000 5.8 8 3 1
5 27 32000 6.5 18 1 0
6 39 52000 8.5 36 0 0
7 33 43000 4.9 6 4 1
8 45 62000 8.8 60 0 0
9 29 37000 5.5 10 2 1
10 36 48000 7.9 30 1 0
11 26 30000 4.2 4 5 1
12 41 55000 8.4 42 0 0
13 30 39000 6.8 20 1 0
14 38 51000 5.1 9 3 1
15 32 42000 7.5 28 0 0
END DATA.

VALUE LABELS abandono 0 'Permanece' 1 'Abandona'.

* ----------------------------------------------------------------.
* REGRESIÓN LOGÍSTICA.
* ----------------------------------------------------------------.

LOGISTIC REGRESSION VARIABLES abandono
  /METHOD=ENTER edad ingresos satisfaccion meses_cliente quejas
  /CONTRAST(abandono)=Indicator
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5)
  /PRINT=GOODFIT CI(95)
  /CLASSPLOT
  /SAVE PRED PGROUP RESID ZRESID.

* Explicación:
* VARIABLES = Variable dependiente (0/1)
* METHOD=ENTER = Todas las variables entran simultáneamente
* GOODFIT = Bondad de ajuste
* CLASSPLOT = Tabla de clasificación
* SAVE PRED = Guardar probabilidad predicha
```

### Interpretación:

```
Variables en la ecuación
                    B        E.T.    Wald    gl    Sig.    Exp(B)    IC 95% Exp(B)
Edad              .024      .045     0.28     1    .596    1.024     [0.937, 1.120]
Ingresos         -.00003    .00002   2.25     1    .134    1.000     [1.000, 1.000]
Satisfacción     -.852      .312     7.46     1    .006    0.426     [0.231, 0.788]
Meses_cliente    -.095      .038     6.25     1    .012    0.909     [0.844, 0.979]
Quejas            1.234     .425    8.42     1    .004    3.435     [1.494, 7.901]
Constante         2.156     1.245    3.00     1    .083    8.634

Tabla de clasificación
                 Observado          Predicho
                               Permanece  Abandona  % correcto
Permanece            8             1          88.9%
Abandona             1             5          83.3%
Porcentaje global                             86.7%
```

**Interpretación:**
- **Satisfacción**: OR = 0.426 (p = .006) - Mayor satisfacción reduce riesgo de abandono en 57.4%
- **Meses_cliente**: OR = 0.909 (p = .012) - Más antigüedad reduce riesgo
- **Quejas**: OR = 3.435 (p = .004) - Cada queja adicional triplica el riesgo
- **Clasificación**: 86.7% de precisión global

### Odds Ratio (OR):
- **OR = 1**: Sin efecto
- **OR > 1**: Aumenta probabilidad
- **OR < 1**: Disminuye probabilidad

---

## 4. Análisis Discriminante

Clasifica casos en grupos basándose en **variables predictoras**.

```spss
* ================================================================.
* ANÁLISIS DISCRIMINANTE.
* ================================================================.

* Clasificar clientes en grupos de riesgo.
DISCRIMINANT
  /GROUPS=abandono(0 1)
  /VARIABLES=edad ingresos satisfaccion meses_cliente quejas
  /ANALYSIS ALL
  /PRIORS EQUAL
  /STATISTICS=MEAN STDDEV UNIVF BOXM COEF RAW CORR COV GCOV TABLE
  /PLOT=COMBINED SEPARATE CASES
  /CLASSIFY=NONMISSING POOLED.

* Explicación:
* GROUPS = Variable de grupo
* PRIORS EQUAL = Probabilidades a priori iguales
* BOXM = Prueba M de Box (homogeneidad de matrices de covarianza)
```

---

## 5. Análisis de Conglomerados (Cluster)

Agrupa casos **similares** sin grupos predefinidos.

### 5.1 K-Medias (K-Means)

```spss
* ================================================================.
* ANÁLISIS DE CONGLOMERADOS K-MEDIAS.
* ================================================================.

* Crear 3 grupos de clientes según comportamiento.
QUICK CLUSTER edad ingresos satisfaccion meses_cliente quejas
  /MISSING=LISTWISE
  /CRITERIA=CLUSTER(3) MXITER(10) CONVERGE(0)
  /METHOD=KMEANS(NOUPDATE)
  /SAVE CLUSTER DISTANCE
  /PRINT INITIAL ANOVA CLUSTER.

* Explicación:
* CLUSTER(3) = Número de conglomerados deseado
* MXITER(10) = Máximo 10 iteraciones
* SAVE CLUSTER = Guardar membresía de conglomerado
```

### 5.2 Jerárquico

```spss
* Conglomerados jerárquicos.
CLUSTER variables edad ingresos satisfaccion meses_cliente quejas
  /METHOD BAVERAGE
  /MEASURE=SEUCLID
  /PRINT SCHEDULE CLUSTER(2,4)
  /PLOT DENDROGRAM VICICLE.

* METHOD BAVERAGE = Enlace promedio entre grupos
* MEASURE=SEUCLID = Distancia euclidiana al cuadrado
* DENDROGRAM = Árbol de conglomerados
```

### Interpretación de Conglomerados:

```
Centros de conglomerados finales
                 Conglomerado
                 1        2        3
Edad            28.3     38.5     35.2
Ingresos        33500    54200    42100
Satisfacción    5.2      8.6      6.8
Meses_cliente   8.5      42.3     22.1
Quejas          3.2      0.3      1.5

ANOVA
                 Conglomerado        Error
                 Media cuadrática    F       Sig.
Satisfacción     12.45              28.92   .000
Meses_cliente    582.30             42.15   .000
```

**Interpretación:**
- **Cluster 1**: Clientes nuevos, insatisfechos, alto riesgo
- **Cluster 2**: Clientes leales, satisfechos, bajo riesgo
- **Cluster 3**: Clientes intermedios

---

## 6. Análisis de Componentes Principales (ACP)

Similar al AFE pero enfocado en **reducción de dimensionalidad**.

```spss
* ================================================================.
* ANÁLISIS DE COMPONENTES PRINCIPALES.
* ================================================================.

FACTOR
  /VARIABLES item1 TO item15
  /MISSING LISTWISE
  /ANALYSIS item1 TO item15
  /PRINT INITIAL EXTRACTION
  /PLOT EIGEN
  /CRITERIA MINEIGEN(1) ITERATE(25)
  /EXTRACTION PC
  /ROTATION NOROTATE
  /SAVE REG(ALL)
  /METHOD=CORRELATION.
```

---

## 7. Análisis de Supervivencia (Kaplan-Meier)

Analiza **tiempo hasta un evento** (retención, fallo, etc.).

```spss
* ================================================================.
* ANÁLISIS DE SUPERVIVENCIA.
* ================================================================.

DATA LIST FREE
  / cliente_id (F4.0) tiempo (F3.0) evento (F1.0) grupo (F1.0).

BEGIN DATA
1 12 1 1
2 24 0 1
3 6 1 1
4 18 1 2
5 30 0 2
6 8 1 1
7 22 0 2
8 14 1 1
9 28 0 2
10 10 1 1
END DATA.

VALUE LABELS
  evento 0 'Censurado' 1 'Abandono'
  /grupo 1 'Control' 2 'Tratamiento'.

* Curvas de supervivencia de Kaplan-Meier.
KM tiempo
  /STATUS=evento(1)
  /STRATA=grupo
  /PRINT TABLE MEAN
  /PLOT SURVIVAL
  /TEST LOGRANK
  /COMPARE OVERALL POOLED.

* Explicación:
* STATUS = Variable de evento (1 = evento ocurrió)
* STRATA = Grupos a comparar
* TEST LOGRANK = Prueba log-rank para comparar curvas
```

---

## 8. Series Temporales

Analiza datos secuenciales en el tiempo.

### 8.1 Suavizamiento Exponencial

```spss
* ================================================================.
* SERIES TEMPORALES.
* ================================================================.

DATA LIST FREE
  / mes (F2.0) ventas (F8.2).

BEGIN DATA
1 45000
2 47000
3 46000
4 50000
5 52000
6 54000
7 53000
8 57000
9 59000
10 61000
11 60000
12 65000
END DATA.

* Crear variable de fecha.
COMPUTE fecha = DATE.MDY(mes, 1, 2024).
FORMATS fecha (ADATE10).

* Suavizamiento exponencial simple.
TSMODEL
  /MODELSUMMARY PRINT=[MODELFIT]
  /MODELSTATISTICS  DISPLAY=YES MODELFIT=[ SRSQUARE]
  /MODELDETAILS PRINT=[ PARAMETERS]
  /SERIESPLOT PRINT=[ventas]
  /OUTPUTFILTER DISPLAY=ALLMODELS
  /SAVE PREDICTED(ventas_pred) NOISE(ventas_residuo)
  /AUXILIARY CILEVEL=95 MAXACFLAGS=24
  /MISSING USERMISSING=EXCLUDE
  /MODEL TYPE=EXSMOOTH
  /ARIMA AR={0} DIFF=0 MA={0} TRANSFORM=NONE CONSTANT=YES
  /FORECAST LEADS=3 PRINT=YES.

* Esto predice las próximas 3 observaciones.
```

### 8.2 ARIMA

```spss
* Modelo ARIMA(1,1,1).
TSMODEL
  /MODELSUMMARY PRINT=[MODELFIT]
  /MODEL TYPE=ARIMA
  /ARIMA AR={1} DIFF=1 MA={1}
  /FORECAST LEADS=6.
```

---

## 9. Ejemplo Integrado Final

### Segmentación y Predicción de Clientes

```spss
* ================================================================.
* PROYECTO FINAL: SEGMENTACIÓN Y PREDICCIÓN.
* ================================================================.

* Crear dataset completo de clientes.
NEW FILE.

DATA LIST FREE
  / cliente_id (F4.0) edad (F2.0) ingresos (F6.0)
    item_sat1 item_sat2 item_sat3 item_sat4 item_sat5 (5F3.1)
    meses_cliente (F3.0) num_compras (F3.0)
    monto_total (F8.2) abandono (F1.0).

* [Insertar datos aquí]

* ----------------------------------------------------------------.
* PASO 1: Crear escala de satisfacción.
* ----------------------------------------------------------------.

RELIABILITY
  /VARIABLES=item_sat1 TO item_sat5
  /SCALE('Satisfacción') ALL
  /MODEL=ALPHA.

COMPUTE satisfaccion = MEAN(item_sat1, item_sat2, item_sat3,
                            item_sat4, item_sat5).

* ----------------------------------------------------------------.
* PASO 2: Segmentar clientes (cluster).
* ----------------------------------------------------------------.

QUICK CLUSTER edad ingresos satisfaccion meses_cliente num_compras
  /CRITERIA=CLUSTER(4)
  /SAVE CLUSTER.

* ----------------------------------------------------------------.
* PASO 3: Caracterizar segmentos.
* ----------------------------------------------------------------.

MEANS TABLES=edad ingresos satisfaccion meses_cliente num_compras
             monto_total BY qcl_1
  /CELLS=MEAN STDDEV COUNT.

* ----------------------------------------------------------------.
* PASO 4: Predecir abandono.
* ----------------------------------------------------------------.

LOGISTIC REGRESSION VARIABLES abandono
  /METHOD=ENTER satisfaccion meses_cliente num_compras qcl_1
  /SAVE PRED PGROUP
  /CLASSPLOT.

* ----------------------------------------------------------------.
* PASO 5: Identificar clientes en riesgo.
* ----------------------------------------------------------------.

SELECT IF (PRE_1 > 0.5).
LIST cliente_id satisfaccion meses_cliente PRE_1.
```

---

## 🎯 Ejercicio Práctico Final

### Proyecto Integrador: Análisis de Recursos Humanos

**Dataset**: 200 empleados con:
- Datos demográficos (edad, género, educación)
- Cuestionario de clima laboral (15 items, 1-7)
- Desempeño (0-100)
- Salario
- Rotación (0/1)

**Tareas:**
1. **Análisis factorial** del cuestionario de clima
2. **Confiabilidad** de cada factor identificado
3. **Cluster** de empleados según perfil
4. **Regresión lineal** prediciendo desempeño
5. **Regresión logística** prediciendo rotación
6. **ANOVA** comparando salarios entre clusters
7. **Informe final** con recomendaciones

---

## 📝 Resumen del Módulo 7

### Has aprendido:
✅ Análisis factorial exploratorio (AFE) para identificar constructos
✅ Análisis de confiabilidad con Alfa de Cronbach
✅ Regresión logística para variables dicotómicas
✅ Análisis discriminante para clasificación
✅ Análisis de conglomerados (k-medias y jerárquico)
✅ Análisis de componentes principales (ACP)
✅ Análisis de supervivencia (Kaplan-Meier)
✅ Series temporales básicas

### Comandos clave:
```spss
FACTOR /EXTRACTION PAF /ROTATION VARIMAX.
RELIABILITY /VARIABLES=items /MODEL=ALPHA.
LOGISTIC REGRESSION VARIABLES=y /METHOD=ENTER x1 x2.
DISCRIMINANT /GROUPS=grupo /VARIABLES=predictores.
QUICK CLUSTER vars /CRITERIA=CLUSTER(k).
KM tiempo /STATUS=evento(1) /STRATA=grupo.
```

---

## 💡 Consejos Finales del Curso

1. **Practica constantemente**: La estadística se aprende haciendo

2. **Entiende tus datos**: Siempre empieza con análisis descriptivo

3. **Verifica supuestos**: No uses técnicas sin verificar que aplican

4. **Interpreta en contexto**: Los números sin contexto no significan nada

5. **Documenta tu trabajo**: Usa sintaxis y comenta todo

6. **Sigue aprendiendo**: Este curso es solo el comienzo

---

## 🎓 ¡Felicitaciones!

Has completado el **Curso Práctico de SPSS de Principiante a Avanzado**.

### Lo que has logrado:
✅ Dominar la interfaz y sintaxis de SPSS
✅ Realizar análisis descriptivos completos
✅ Crear visualizaciones profesionales
✅ Aplicar pruebas de hipótesis
✅ Construir modelos de regresión
✅ Ejecutar ANOVAs complejos
✅ Aplicar técnicas multivariantes avanzadas

### Tus próximos pasos:
1. **Aplica lo aprendido** en proyectos reales
2. **Profundiza** en áreas de tu interés
3. **Comparte** tu conocimiento con otros
4. **Mantente actualizado** con nuevas técnicas

---

## 📚 Recursos Adicionales

### Libros recomendados:
- Field, A. (2013). *Discovering Statistics Using IBM SPSS Statistics*
- Pallant, J. (2020). *SPSS Survival Manual*
- Tabachnick, B. G., & Fidell, L. S. (2019). *Using Multivariate Statistics*

### Recursos en línea:
- IBM SPSS Documentation
- Statistics Solutions
- ResearchGate Q&A
- Cross Validated (Stack Exchange)

---

**¡Éxito en tus análisis estadísticos!** 🚀📊
