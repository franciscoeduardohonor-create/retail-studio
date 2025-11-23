# Módulo 4: Pruebas de Hipótesis en SPSS

## 📋 Contenido
1. Conceptos fundamentales de inferencia estadística
2. Prueba t para una muestra
3. Prueba t para muestras independientes
4. Prueba t para muestras relacionadas (pareadas)
5. Prueba Chi-cuadrado
6. Pruebas no paramétricas
7. Interpretación de valores p y significancia

---

## 1. Conceptos Fundamentales

### 1.1 Hipótesis Nula (H₀) e Hipótesis Alternativa (H₁)

- **H₀**: No hay efecto o diferencia
- **H₁**: Hay efecto o diferencia

### 1.2 Nivel de Significancia (α)

- Usualmente **α = 0.05** (5%)
- Probabilidad de rechazar H₀ cuando es verdadera (Error Tipo I)

### 1.3 Valor p (p-value)

- **p < 0.05**: Rechazamos H₀ (resultado significativo)
- **p ≥ 0.05**: No rechazamos H₀ (resultado no significativo)

### 1.4 Tamaño del Efecto

Indica la **magnitud práctica** de la diferencia:
- **d de Cohen**: Pequeño (0.2), Mediano (0.5), Grande (0.8)
- **r de Pearson**: Pequeño (0.1), Mediano (0.3), Grande (0.5)

---

## 2. Prueba t para Una Muestra

Compara la **media de una muestra** con un **valor conocido**.

### Ejemplo: ¿El salario promedio es diferente de 50,000 EUR?

```spss
* ================================================.
* PRUEBA T PARA UNA MUESTRA.
* ================================================.

* H₀: μ = 50000
* H₁: μ ≠ 50000
* α = 0.05

T-TEST
  /TESTVAL=50000
  /VARIABLES=salario
  /CRITERIA=CI(0.95).

* Explicación:
* TESTVAL = Valor de prueba (50000)
* VARIABLES = Variable a analizar
* CI(0.95) = Intervalo de confianza del 95%
```

### Interpretación de Resultados

```
Prueba de una muestra

Estadísticos de una muestra
             N    Media    Desv. típ.    Error típ. de la media
Salario     100  52,350.00  8,450.00     845.00

Prueba de una muestra
                    Valor de prueba = 50000
             t      gl    Sig. (bilateral)    Diferencia de medias
Salario     2.78    99         0.006             2,350.00
```

**Interpretación:**
- **t = 2.78**: Estadístico t
- **gl = 99**: Grados de libertad
- **p = 0.006 < 0.05**: Rechazamos H₀
- **Conclusión**: El salario promedio ES significativamente diferente de 50,000 EUR

---

## 3. Prueba t para Muestras Independientes

Compara las **medias de dos grupos independientes**.

### Ejemplo: ¿Los salarios difieren entre hombres y mujeres?

```spss
* ================================================.
* PRUEBA T PARA MUESTRAS INDEPENDIENTES.
* ================================================.

* H₀: μ_hombres = μ_mujeres
* H₁: μ_hombres ≠ μ_mujeres

T-TEST GROUPS=genero(1 2)
  /VARIABLES=salario
  /CRITERIA=CI(0.95).

* GROUPS = Variable agrupadora (valores 1 y 2)
* VARIABLES = Variable dependiente
```

### Ejemplo Completo con Datos

```spss
* Crear dataset de ejemplo.
NEW FILE.

DATA LIST FREE
  / empleado_id (F3.0) genero (F1.0) salario (F7.2).

BEGIN DATA
1 1 52000
2 1 48000
3 1 55000
4 1 51000
5 1 49000
6 1 53000
7 1 50000
8 1 54000
9 1 47000
10 1 52000
11 2 49000
12 2 47000
13 2 51000
14 2 48000
15 2 50000
16 2 46000
17 2 49000
18 2 52000
19 2 48000
20 2 47000
END DATA.

VALUE LABELS genero 1 'Hombre' 2 'Mujer'.

* Realizar prueba t.
T-TEST GROUPS=genero(1 2)
  /VARIABLES=salario
  /CRITERIA=CI(0.95).

* Prueba de Levene incluida automáticamente (homogeneidad de varianzas).
```

### Interpretación de la Prueba de Levene

```
Prueba de Levene:
- Si p > 0.05: Varianzas iguales → usar primera fila
- Si p < 0.05: Varianzas diferentes → usar segunda fila
```

---

## 4. Prueba t para Muestras Relacionadas (Pareadas)

Compara las **medias de dos mediciones** en los **mismos sujetos**.

### Ejemplo: ¿Hay diferencia entre ventas antes y después de capacitación?

```spss
* ================================================.
* PRUEBA T PARA MUESTRAS RELACIONADAS.
* ================================================.

* Crear datos de ejemplo.
DATA LIST FREE
  / vendedor_id (F3.0) ventas_antes (F8.2) ventas_despues (F8.2).

BEGIN DATA
1 45000 52000
2 38000 41000
3 42000 48000
4 39000 45000
5 44000 50000
6 41000 47000
7 43000 49000
8 40000 44000
9 37000 43000
10 46000 53000
END DATA.

* H₀: μ_antes = μ_despues
* H₁: μ_antes < μ_despues (mejora esperada)

T-TEST PAIRS=ventas_antes WITH ventas_despues (PAIRED)
  /CRITERIA=CI(0.95).

* Calcular diferencia y tamaño del efecto manualmente.
COMPUTE diferencia = ventas_despues - ventas_antes.
EXECUTE.

DESCRIPTIVES VARIABLES=diferencia
  /STATISTICS=MEAN STDDEV.
```

### Cálculo del Tamaño del Efecto (d de Cohen)

```spss
* d = diferencia_media / desviacion_diferencia.
COMPUTE d_cohen = MEAN(diferencia) / SD.1(diferencia).
```

---

## 5. Prueba Chi-Cuadrado (χ²)

Evalúa la **asociación entre dos variables categóricas**.

### Ejemplo: ¿Hay relación entre género y preferencia de producto?

```spss
* ================================================.
* PRUEBA CHI-CUADRADO.
* ================================================.

* Crear datos de ejemplo.
DATA LIST FREE
  / cliente_id (F3.0) genero (F1.0) preferencia (F1.0).

BEGIN DATA
1 1 1
2 1 1
3 1 2
4 1 1
5 1 3
6 1 1
7 1 2
8 1 1
9 1 1
10 1 2
11 2 2
12 2 3
13 2 2
14 2 3
15 2 2
16 2 3
17 2 2
18 2 3
19 2 3
20 2 2
END DATA.

VALUE LABELS
  genero 1 'Hombre' 2 'Mujer'
  /preferencia 1 'Producto A' 2 'Producto B' 3 'Producto C'.

* H₀: No hay asociación entre género y preferencia
* H₁: Hay asociación entre género y preferencia

CROSSTABS
  /TABLES=genero BY preferencia
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ PHI
  /CELLS=COUNT EXPECTED ROW COLUMN
  /COUNT ROUND CELL.

* CHISQ = Prueba chi-cuadrado
* PHI = Coeficiente Phi (tamaño del efecto)
```

### Interpretación

```
Pruebas de chi-cuadrado
                    Valor    gl    Sig. asintótica (bilateral)
Chi-cuadrado        8.52     2          0.014

Medidas simétricas
                    Valor    Sig. aproximada
Phi                 0.653         0.014
```

**Interpretación:**
- **χ² = 8.52, p = 0.014 < 0.05**: Rechazamos H₀
- **Phi = 0.653**: Asociación moderada-fuerte
- **Conclusión**: Hay asociación significativa entre género y preferencia

---

## 6. Pruebas No Paramétricas

Cuando los datos **NO cumplen supuestos** de normalidad o tienen **escalas ordinales**.

### 6.1 Prueba U de Mann-Whitney (alternativa a t independiente)

```spss
* ================================================.
* PRUEBA U DE MANN-WHITNEY.
* ================================================.

* Alternativa no paramétrica a t para muestras independientes.

NPAR TESTS
  /M-W= salario BY genero(1 2)
  /STATISTICS=DESCRIPTIVES
  /MISSING ANALYSIS.

* M-W = Mann-Whitney U test
```

### 6.2 Prueba de Wilcoxon (alternativa a t pareada)

```spss
* ================================================.
* PRUEBA DE WILCOXON.
* ================================================.

* Alternativa no paramétrica a t para muestras pareadas.

NPAR TESTS
  /WILCOXON=ventas_antes WITH ventas_despues (PAIRED)
  /STATISTICS=DESCRIPTIVES
  /MISSING ANALYSIS.
```

### 6.3 Prueba de Kruskal-Wallis (alternativa a ANOVA)

```spss
* ================================================.
* PRUEBA DE KRUSKAL-WALLIS.
* ================================================.

* Compara medianas de 3+ grupos independientes.

NPAR TESTS
  /K-W= satisfaccion BY region(1 4)
  /STATISTICS=DESCRIPTIVES
  /MISSING ANALYSIS.

* K-W = Kruskal-Wallis
* region(1 4) = Grupos del 1 al 4
```

### 6.4 Prueba de Friedman (alternativa a ANOVA repetidas)

```spss
* ================================================.
* PRUEBA DE FRIEDMAN.
* ================================================.

* Compara medianas de mediciones repetidas.

NPAR TESTS
  /FRIEDMAN=ventas_q1 ventas_q2 ventas_q3 ventas_q4
  /STATISTICS=DESCRIPTIVES
  /MISSING LISTWISE.
```

---

## 7. Verificación de Supuestos

### 7.1 Prueba de Normalidad (Kolmogorov-Smirnov y Shapiro-Wilk)

```spss
* ================================================.
* PRUEBAS DE NORMALIDAD.
* ================================================.

EXAMINE VARIABLES=salario
  /PLOT=NPPLOT
  /STATISTICS=DESCRIPTIVES
  /CINTERVAL 95
  /MISSING=LISTWISE
  /NOTOTAL.

* Si p > 0.05: Distribución normal
* Si p < 0.05: Distribución NO normal
```

### 7.2 Prueba de Homogeneidad de Varianzas (Levene)

```spss
* Ya incluida automáticamente en T-TEST para muestras independientes.
* También disponible independientemente:

ONEWAY salario BY region
  /STATISTICS=HOMOGENEITY.
```

---

## 8. Ejemplo Práctico Completo

### Análisis de Efectividad de un Programa de Entrenamiento

```spss
* ================================================================.
* EJEMPLO PRÁCTICO: EFECTIVIDAD DE PROGRAMA DE ENTRENAMIENTO.
* ================================================================.

NEW FILE.

DATA LIST FREE
  / empleado_id (F3.0) departamento (F1.0)
    productividad_antes (F5.2) productividad_despues (F5.2)
    grupo (F1.0).

BEGIN DATA
1 1 75.5 82.3 1
2 1 78.2 85.1 1
3 1 72.8 79.6 1
4 1 76.9 83.4 1
5 1 74.1 80.8 1
6 2 77.3 78.1 0
7 2 75.8 76.5 0
8 2 79.1 80.3 0
9 2 73.5 74.2 0
10 2 76.4 77.8 0
11 1 80.2 87.5 1
12 1 73.9 81.2 1
13 2 78.8 79.6 0
14 2 74.6 75.3 0
15 1 77.5 84.9 1
END DATA.

VALUE LABELS
  departamento 1 'Ventas' 2 'Operaciones'
  /grupo 1 'Con Entrenamiento' 0 'Sin Entrenamiento'.

* ----------------------------------------------------------------.
* PASO 1: Verificar normalidad.
* ----------------------------------------------------------------.

EXAMINE VARIABLES=productividad_antes productividad_despues
  /PLOT=NPPLOT HISTOGRAM
  /STATISTICS=DESCRIPTIVES
  /CINTERVAL 95.

* ----------------------------------------------------------------.
* PASO 2: Crear variable de cambio.
* ----------------------------------------------------------------.

COMPUTE cambio = productividad_despues - productividad_antes.
VARIABLE LABELS cambio 'Cambio en Productividad'.
EXECUTE.

* ----------------------------------------------------------------.
* PASO 3: Prueba t pareada (todos los empleados).
* ----------------------------------------------------------------.

T-TEST PAIRS=productividad_antes WITH productividad_despues (PAIRED)
  /CRITERIA=CI(0.95).

* ----------------------------------------------------------------.
* PASO 4: Comparar cambio entre grupos.
* ----------------------------------------------------------------.

T-TEST GROUPS=grupo(0 1)
  /VARIABLES=cambio
  /CRITERIA=CI(0.95).

* ----------------------------------------------------------------.
* PASO 5: Análisis por departamento.
* ----------------------------------------------------------------.

SORT CASES BY departamento.
SPLIT FILE LAYERED BY departamento.

T-TEST PAIRS=productividad_antes WITH productividad_despues (PAIRED)
  /CRITERIA=CI(0.95).

SPLIT FILE OFF.

* ----------------------------------------------------------------.
* PASO 6: Calcular tamaño del efecto.
* ----------------------------------------------------------------.

DESCRIPTIVES VARIABLES=cambio BY grupo
  /STATISTICS=MEAN STDDEV.

* d de Cohen = (Media1 - Media2) / SD_pooled
* Calcular manualmente con las medias y SD obtenidas.

* ----------------------------------------------------------------.
* PASO 7: Gráficos para visualizar.
* ----------------------------------------------------------------.

GRAPH
  /BOXPLOT(SIMPLE)=cambio BY grupo
  /TITLE='Cambio en Productividad por Grupo'.

GRAPH
  /BAR(SIMPLE)=MEAN(cambio) BY grupo
  /TITLE='Cambio Promedio en Productividad'.
```

---

## 9. Tabla de Decisión de Pruebas

| Situación | Paramétrica | No Paramétrica |
|-----------|-------------|----------------|
| 1 grupo vs valor | t una muestra | Wilcoxon signed-rank |
| 2 grupos independientes | t independiente | Mann-Whitney U |
| 2 grupos pareados | t pareada | Wilcoxon signed-rank |
| 3+ grupos independientes | ANOVA | Kruskal-Wallis |
| 3+ grupos pareados | ANOVA repetidas | Friedman |
| Relación entre categóricas | - | Chi-cuadrado |

---

## 10. Potencia Estadística y Tamaño de Muestra

```spss
* ================================================.
* CÁLCULO DE TAMAÑO DE MUESTRA (APROXIMADO).
* ================================================.

* Para detectar un efecto mediano (d=0.5) con α=0.05 y potencia=0.80:
* n ≈ 64 por grupo (prueba t independiente)
* n ≈ 34 pares (prueba t pareada)

* SPSS no tiene función directa, usar calculadoras externas o:
* GPower software (gratuito)
* Fórmulas manuales
```

---

## 🎯 Ejercicio Práctico 1

### Efectividad de Dos Métodos de Enseñanza

Crea datos de 40 estudiantes (20 por grupo):
- Grupo A: Método tradicional
- Grupo B: Método interactivo
- Variable: Calificación final (0-100)

**Tareas:**
1. Verificar normalidad de calificaciones
2. Realizar prueba t para muestras independientes
3. Calcular tamaño del efecto
4. Interpretar resultados con nivel de significancia α=0.05
5. Crear boxplot comparativo
6. Si no hay normalidad, usar Mann-Whitney U

---

## 🎯 Ejercicio Práctico 2

### Satisfacción Antes y Después de Mejora

Crea datos de 25 clientes evaluados antes y después de mejoras:
- Satisfacción antes (escala 1-10)
- Satisfacción después (escala 1-10)

**Tareas:**
1. Realizar prueba t pareada
2. Calcular el cambio promedio
3. Interpretar si la mejora es significativa
4. Crear gráfico de líneas pareadas
5. Realizar prueba de Wilcoxon como alternativa

---

## 📝 Resumen del Módulo 4

### Has aprendido:
✅ Conceptos de hipótesis nula y alternativa
✅ Interpretación del valor p y significancia estadística
✅ Prueba t para una muestra
✅ Prueba t para muestras independientes
✅ Prueba t para muestras pareadas
✅ Prueba Chi-cuadrado para variables categóricas
✅ Pruebas no paramétricas (Mann-Whitney, Wilcoxon, Kruskal-Wallis, Friedman)
✅ Verificación de supuestos (normalidad, homogeneidad)
✅ Cálculo e interpretación del tamaño del efecto

### Comandos clave:
```spss
T-TEST /TESTVAL=valor /VARIABLES=var.
T-TEST GROUPS=grupo(1 2) /VARIABLES=var.
T-TEST PAIRS=var1 WITH var2 (PAIRED).
CROSSTABS /TABLES=var1 BY var2 /STATISTICS=CHISQ.
NPAR TESTS /M-W=var BY grupo(1 2).
NPAR TESTS /WILCOXON=var1 WITH var2 (PAIRED).
EXAMINE VARIABLES=var /PLOT=NPPLOT.
```

### Próximo paso:
Continúa con el **Módulo 5: Correlación y Regresión** para analizar relaciones entre variables continuas.

---

## 💡 Consejos de Interpretación

1. **p-valor no mide tamaño del efecto**: Un p<0.05 no significa efecto grande

2. **Significancia estadística ≠ significancia práctica**: Siempre evalúa el tamaño del efecto

3. **Reporta IC además de p-valor**: Los intervalos de confianza dan más información

4. **Verifica supuestos antes de elegir prueba**: Normalidad, homogeneidad de varianzas

5. **Con muestras grandes**: Casi todo resulta "significativo", enfócate en tamaño del efecto

6. **Con muestras pequeñas**: Puede no haber suficiente potencia, considera análisis de potencia

---

**¡Excelente progreso!** Ahora puedes realizar pruebas de hipótesis fundamentales en SPSS y tomar decisiones basadas en evidencia estadística.
