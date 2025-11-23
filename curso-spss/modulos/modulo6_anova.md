# Módulo 6: ANOVA y Comparaciones Múltiples en SPSS

## 📋 Contenido
1. Introducción a ANOVA
2. ANOVA de un factor (One-Way ANOVA)
3. Pruebas post-hoc
4. ANOVA factorial (Two-Way ANOVA)
5. ANOVA de medidas repetidas
6. ANCOVA (Análisis de covarianza)
7. Supuestos y diagnósticos

---

## 1. Introducción a ANOVA

**ANOVA (Analysis of Variance)** compara las **medias de 3 o más grupos**.

### ¿Cuándo usar ANOVA?
- **Una variable independiente categórica** (3+ grupos)
- **Una variable dependiente continua**
- Ejemplo: Comparar salarios entre 4 departamentos

### Hipótesis:
- **H₀**: μ₁ = μ₂ = μ₃ = ... = μₖ (todas las medias son iguales)
- **H₁**: Al menos una media es diferente

### Lógica de ANOVA:
Compara:
- **Varianza entre grupos** (explicada por el factor)
- **Varianza dentro de grupos** (error)

**F = Varianza entre grupos / Varianza dentro de grupos**

---

## 2. ANOVA de Un Factor (One-Way ANOVA)

### Sintaxis Básica:

```spss
* ================================================.
* ANOVA DE UN FACTOR.
* ================================================.

ONEWAY salario BY departamento
  /STATISTICS DESCRIPTIVES HOMOGENEITY
  /MISSING ANALYSIS.

* Explicación:
* ONEWAY = ANOVA de un factor
* BY = Variable agrupadora (factor)
* DESCRIPTIVES = Estadísticos por grupo
* HOMOGENEITY = Prueba de Levene (homogeneidad de varianzas)
```

### Ejemplo Completo:

```spss
* Crear dataset de ejemplo.
NEW FILE.

DATA LIST FREE
  / empleado_id (F3.0) departamento (F1.0) salario (F7.2).

BEGIN DATA
1 1 35000
2 1 38000
3 1 36000
4 1 37000
5 1 39000
6 2 45000
7 2 47000
8 2 46000
9 2 48000
10 2 44000
11 3 52000
12 3 54000
13 3 53000
14 3 55000
15 3 51000
16 4 42000
17 4 43000
18 4 41000
19 4 44000
20 4 42000
END DATA.

VALUE LABELS departamento
  1 'Ventas'
  2 'Marketing'
  3 'IT'
  4 'RRHH'.

* Análisis descriptivo por grupo.
MEANS TABLES=salario BY departamento
  /CELLS=MEAN STDDEV COUNT.

* ANOVA de un factor.
ONEWAY salario BY departamento
  /STATISTICS DESCRIPTIVES HOMOGENEITY
  /PLOT MEANS
  /MISSING ANALYSIS.
```

### Interpretación de Resultados:

```
ANOVA
                 Suma de cuadrados    gl    Media cuadrática    F       Sig.
Entre grupos          1240.50         3        413.50         25.84   .000
Dentro de grupos       256.00        16         16.00
Total                 1496.50        19

Prueba de homogeneidad de varianzas
Estadístico de Levene    gl1    gl2    Sig.
      1.24                3     16    .327
```

**Interpretación:**
- **F(3,16) = 25.84, p < .001**: Rechazamos H₀
- **Conclusión**: Hay diferencias significativas entre departamentos
- **Levene p = .327 > .05**: Varianzas homogéneas (supuesto cumplido)

---

## 3. Pruebas Post-Hoc

ANOVA solo indica que **hay diferencias**, pero no **entre qué grupos**.

### Pruebas Post-Hoc Comunes:

| Prueba | Cuándo usar |
|--------|-------------|
| **Tukey HSD** | Varianzas iguales, todos vs todos |
| **Bonferroni** | Varianzas iguales, más conservadora |
| **Scheffé** | Comparaciones complejas |
| **Games-Howell** | Varianzas desiguales |
| **Dunnett** | Todos los grupos vs control |

### Sintaxis con Post-Hoc:

```spss
* ================================================.
* ANOVA CON PRUEBAS POST-HOC.
* ================================================.

ONEWAY salario BY departamento
  /STATISTICS DESCRIPTIVES HOMOGENEITY
  /PLOT MEANS
  /POSTHOC=TUKEY BONFERRONI SCHEFFE ALPHA(0.05)
  /MISSING ANALYSIS.

* Si las varianzas NO son iguales:
ONEWAY salario BY departamento
  /STATISTICS DESCRIPTIVES HOMOGENEITY
  /POSTHOC=GH ALPHA(0.05)
  /MISSING ANALYSIS.

* GH = Games-Howell (para varianzas desiguales)
```

### Interpretación de Tukey:

```
Comparaciones múltiples (Tukey HSD)
Dep. I         Dep. J         Diferencia    Error típ.    Sig.    IC 95%
Ventas         Marketing         -9,000        1.79       .001   [-14.2, -3.8]
Ventas         IT               -16,000        1.79       .000   [-21.2, -10.8]
Ventas         RRHH              -5,000        1.79       .074   [-10.2, 0.2]
Marketing      IT                -7,000        1.79       .008   [-12.2, -1.8]
Marketing      RRHH               4,000        1.79       .190   [-1.2, 9.2]
IT             RRHH              11,000        1.79       .000   [5.8, 16.2]
```

**Interpretación:**
- IT tiene salarios significativamente mayores que Ventas, Marketing y RRHH
- Marketing tiene salarios mayores que Ventas
- No hay diferencia entre Marketing y RRHH

---

## 4. Contrastes Planificados

Cuando tienes **hipótesis específicas a priori**.

```spss
* ================================================.
* CONTRASTES PLANIFICADOS.
* ================================================.

* Ejemplo: Comparar IT vs promedio de los demás.
ONEWAY salario BY departamento
  /CONTRAST= -1 -1 3 -1
  /STATISTICS DESCRIPTIVES.

* Los coeficientes deben sumar 0:
* Ventas(-1) + Marketing(-1) + IT(3) + RRHH(-1) = 0
```

---

## 5. ANOVA Factorial (Two-Way ANOVA)

Analiza el efecto de **dos factores** simultáneamente y su **interacción**.

### Ejemplo: Efecto de Departamento y Género en Salario

```spss
* ================================================.
* ANOVA FACTORIAL (DOS FACTORES).
* ================================================.

* Crear dataset con dos factores.
DATA LIST FREE
  / empleado_id (F3.0) departamento (F1.0) genero (F1.0) salario (F7.2).

BEGIN DATA
1 1 1 37000
2 1 1 38000
3 1 2 35000
4 1 2 36000
5 2 1 47000
6 2 1 48000
7 2 2 44000
8 2 2 45000
9 3 1 54000
10 3 1 55000
11 3 2 51000
12 3 2 52000
13 4 1 43000
14 4 1 44000
15 4 2 41000
16 4 2 42000
END DATA.

VALUE LABELS
  departamento 1 'Ventas' 2 'Marketing' 3 'IT' 4 'RRHH'
  /genero 1 'Hombre' 2 'Mujer'.

* ANOVA factorial con UNIANOVA.
UNIANOVA salario BY departamento genero
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PLOT=PROFILE(departamento*genero)
  /EMMEANS=TABLES(departamento)
  /EMMEANS=TABLES(genero)
  /EMMEANS=TABLES(departamento*genero)
  /PRINT=DESCRIPTIVE HOMOGENEITY
  /CRITERIA=ALPHA(.05)
  /DESIGN=departamento genero departamento*genero.

* Explicación:
* UNIANOVA = ANOVA univariado (más flexible que ONEWAY)
* BY = Factores (variables independientes)
* EMMEANS = Medias marginales estimadas
* departamento*genero = Interacción entre factores
```

### Interpretación de Resultados:

```
Pruebas de efectos inter-sujetos
Origen                 Suma de cuadrados   gl   Media cuadrática   F      Sig.
Departamento              1820.50          3       606.83        50.57  .000
Género                     240.00          1       240.00        20.00  .001
Departamento * Género       48.00          3        16.00         1.33  .328
Error                       96.00          8        12.00
```

**Interpretación:**
- **Departamento**: Efecto principal significativo (p < .001)
- **Género**: Efecto principal significativo (p = .001)
- **Interacción**: No significativa (p = .328)
- **Conclusión**: Departamento y género afectan el salario independientemente, sin interacción

### Interpretación de Interacción:

**Interacción significativa** significa que el efecto de un factor depende del nivel del otro.

```spss
* Visualizar interacción.
GRAPH
  /LINE(MULTIPLE)=MEAN(salario) BY departamento BY genero.
```

---

## 6. ANOVA de Medidas Repetidas

Cuando los **mismos sujetos** son medidos **múltiples veces**.

### Ejemplo: Ventas en 4 trimestres

```spss
* ================================================.
* ANOVA DE MEDIDAS REPETIDAS.
* ================================================.

* Crear datos.
DATA LIST FREE
  / vendedor_id (F3.0) region (F1.0)
    ventas_q1 (F8.2) ventas_q2 (F8.2)
    ventas_q3 (F8.2) ventas_q4 (F8.2).

BEGIN DATA
1 1 45000 52000 48000 61000
2 1 38000 41000 39000 44000
3 1 42000 45000 43000 49000
4 2 51000 55000 53000 59000
5 2 47000 50000 48000 54000
6 2 49000 53000 51000 57000
7 3 44000 47000 45000 51000
8 3 40000 43000 41000 46000
9 3 46000 49000 47000 53000
10 3 48000 52000 50000 56000
END DATA.

VALUE LABELS region 1 'Norte' 2 'Centro' 3 'Sur'.

* ANOVA de medidas repetidas.
GLM ventas_q1 ventas_q2 ventas_q3 ventas_q4 BY region
  /WSFACTOR=trimestre 4 Polynomial
  /METHOD=SSTYPE(3)
  /PLOT=PROFILE(trimestre*region)
  /EMMEANS=TABLES(trimestre)
  /EMMEANS=TABLES(region)
  /EMMEANS=TABLES(trimestre*region)
  /PRINT=DESCRIPTIVE ETASQ
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=trimestre
  /DESIGN=region.

* Explicación:
* GLM = Modelo lineal general
* WSFACTOR = Factor intra-sujetos (trimestre)
* BY region = Factor entre-sujetos
```

### Interpretación:

```
Pruebas de efectos intra-sujetos
Origen           Tipo III suma   gl    Media        F       Sig.    Eta²
                 de cuadrados          cuadrática
Trimestre           580.50       3     193.50      45.18   .000    .866
Trimestre*región     42.30       6       7.05       1.65   .210    .322
Error(trimestre)     89.70      21       4.27
```

**Interpretación:**
- **Efecto de trimestre**: Significativo (p < .001)
- **Interacción trimestre×región**: No significativa (p = .210)
- **Eta² = .866**: Tamaño del efecto muy grande

---

## 7. ANCOVA (Análisis de Covarianza)

ANOVA que **controla por una variable continua** (covariable).

### Ejemplo: Comparar salarios controlando por antigüedad

```spss
* ================================================.
* ANCOVA.
* ================================================.

* Crear datos.
DATA LIST FREE
  / empleado_id (F3.0) departamento (F1.0)
    antiguedad (F2.0) salario (F7.2).

BEGIN DATA
1 1 3 37000
2 1 5 39000
3 1 2 35000
4 2 7 47000
5 2 4 44000
6 2 6 46000
7 3 10 55000
8 3 8 52000
9 3 12 57000
10 4 5 43000
11 4 3 41000
12 4 6 44000
END DATA.

VALUE LABELS departamento 1 'Ventas' 2 'Marketing' 3 'IT' 4 'RRHH'.

* ANCOVA controlando por antigüedad.
UNIANOVA salario BY departamento WITH antiguedad
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /EMMEANS=TABLES(departamento) WITH(antiguedad=MEAN)
  /PRINT=DESCRIPTIVE PARAMETER ETASQ HOMOGENEITY
  /CRITERIA=ALPHA(.05)
  /DESIGN=antiguedad departamento.

* Explicación:
* WITH antiguedad = Covariable
* EMMEANS ... WITH(antiguedad=MEAN) = Medias ajustadas
```

### Interpretación:

```
Pruebas de efectos inter-sujetos
Origen              Tipo III suma   gl   Media        F       Sig.    Eta²
                    de cuadrados         cuadrática
Antigüedad             420.50        1    420.50      28.03   .001    .778
Departamento           680.20        3    226.73      15.12   .002    .850
Error                  105.00        7     15.00
```

**Interpretación:**
- **Antigüedad**: Covariable significativa (p = .001)
- **Departamento**: Efecto significativo después de controlar por antigüedad
- Las medias ajustadas consideran que todos tienen la misma antigüedad promedio

---

## 8. Supuestos de ANOVA

### 8.1 Independencia
- Las observaciones son independientes entre sí

### 8.2 Normalidad
```spss
* Verificar normalidad por grupo.
EXAMINE VARIABLES=salario BY departamento
  /PLOT=NPPLOT
  /STATISTICS=DESCRIPTIVES
  /CINTERVAL 95.
```

### 8.3 Homogeneidad de Varianzas
```spss
* Prueba de Levene (ya incluida en ONEWAY).
ONEWAY salario BY departamento
  /STATISTICS HOMOGENEITY.

* Si p > .05: Varianzas homogéneas (cumple supuesto)
* Si p < .05: Usar Welch o Brown-Forsythe
```

### 8.4 ANOVA Robusto (Welch y Brown-Forsythe)

Cuando las **varianzas NO son iguales**:

```spss
* ANOVA robusto de Welch.
ONEWAY salario BY departamento
  /STATISTICS DESCRIPTIVES HOMOGENEITY WELCH BROWNFORSYTHE.
```

---

## 9. Tamaño del Efecto

### Eta Cuadrado (η²)

```
η² = SS_entre / SS_total

Interpretación:
- η² = 0.01: Efecto pequeño
- η² = 0.06: Efecto mediano
- η² = 0.14: Efecto grande
```

```spss
* Calcular Eta cuadrado manualmente.
UNIANOVA salario BY departamento
  /PRINT=ETASQ.
```

---

## 10. Ejemplo Práctico Completo

```spss
* ================================================================.
* EJEMPLO COMPLETO: EFECTIVIDAD DE MÉTODOS DE ENSEÑANZA.
* ================================================================.

NEW FILE.

DATA LIST FREE
  / estudiante_id (F3.0) metodo (F1.0) nivel_previo (F1.0)
    horas_estudio (F4.1) calificacion (F5.2).

BEGIN DATA
1 1 1 10.5 75.2
2 1 1 12.0 78.5
3 1 2 15.5 82.3
4 1 2 14.0 80.1
5 1 3 18.5 85.7
6 2 1 11.0 80.5
7 2 1 13.5 83.2
8 2 2 16.0 87.1
9 2 2 15.0 85.8
10 2 3 19.5 90.3
11 3 1 10.0 78.8
12 3 1 12.5 81.5
13 3 2 14.5 84.2
14 3 2 16.5 86.9
15 3 3 17.5 88.5
16 1 1 11.5 76.8
17 1 2 13.0 79.5
18 1 3 17.0 84.2
19 2 1 12.0 81.8
20 2 2 15.5 86.5
21 2 3 18.0 89.7
22 3 1 11.0 79.2
23 3 2 15.0 85.1
24 3 3 18.5 89.2
END DATA.

VALUE LABELS
  metodo 1 'Tradicional' 2 'Interactivo' 3 'Mixto'
  /nivel_previo 1 'Bajo' 2 'Medio' 3 'Alto'.

* ----------------------------------------------------------------.
* PASO 1: Descriptivos.
* ----------------------------------------------------------------.

MEANS TABLES=calificacion BY metodo BY nivel_previo
  /CELLS=MEAN STDDEV COUNT.

* ----------------------------------------------------------------.
* PASO 2: ANOVA de un factor (solo método).
* ----------------------------------------------------------------.

ONEWAY calificacion BY metodo
  /STATISTICS DESCRIPTIVES HOMOGENEITY
  /PLOT MEANS
  /POSTHOC=TUKEY ALPHA(0.05).

* ----------------------------------------------------------------.
* PASO 3: ANOVA factorial (método × nivel previo).
* ----------------------------------------------------------------.

UNIANOVA calificacion BY metodo nivel_previo
  /METHOD=SSTYPE(3)
  /PLOT=PROFILE(metodo*nivel_previo)
  /EMMEANS=TABLES(metodo)
  /EMMEANS=TABLES(nivel_previo)
  /EMMEANS=TABLES(metodo*nivel_previo)
  /PRINT=DESCRIPTIVE ETASQ HOMOGENEITY
  /CRITERIA=ALPHA(.05)
  /DESIGN=metodo nivel_previo metodo*nivel_previo.

* ----------------------------------------------------------------.
* PASO 4: ANCOVA controlando por horas de estudio.
* ----------------------------------------------------------------.

UNIANOVA calificacion BY metodo WITH horas_estudio
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(metodo) WITH(horas_estudio=MEAN)
  /PRINT=DESCRIPTIVE PARAMETER ETASQ
  /CRITERIA=ALPHA(.05)
  /DESIGN=horas_estudio metodo.

* ----------------------------------------------------------------.
* PASO 5: Verificar supuestos.
* ----------------------------------------------------------------.

EXAMINE VARIABLES=calificacion BY metodo
  /PLOT=BOXPLOT NPPLOT
  /STATISTICS=DESCRIPTIVES.
```

---

## 🎯 Ejercicio Práctico 1

### Efecto de la Dieta en la Pérdida de Peso

Crea datos de 45 participantes (15 por grupo):
- Grupo 1: Dieta baja en carbohidratos
- Grupo 2: Dieta baja en grasas
- Grupo 3: Dieta mediterránea
- Variable: Pérdida de peso (kg) después de 12 semanas

**Tareas:**
1. Descriptivos por grupo
2. ANOVA de un factor
3. Verificar homogeneidad de varianzas
4. Prueba post-hoc de Tukey
5. Calcular tamaño del efecto
6. Crear boxplot comparativo
7. Interpretar resultados

---

## 🎯 Ejercicio Práctico 2

### Rendimiento según Turno y Experiencia

Crea datos de 36 trabajadores:
- Factor 1: Turno (Mañana, Tarde, Noche)
- Factor 2: Experiencia (Novato, Intermedio, Experto)
- Variable: Productividad (0-100)

**Tareas:**
1. ANOVA factorial 3×3
2. Interpretar efectos principales e interacción
3. Gráfico de interacción
4. Pruebas post-hoc si corresponde
5. Medias marginales estimadas

---

## 📝 Resumen del Módulo 6

### Has aprendido:
✅ ANOVA de un factor para comparar 3+ grupos
✅ Pruebas post-hoc (Tukey, Bonferroni, Games-Howell)
✅ Contrastes planificados
✅ ANOVA factorial para múltiples factores e interacciones
✅ ANOVA de medidas repetidas
✅ ANCOVA para controlar covariables
✅ Verificar supuestos de ANOVA
✅ Calcular e interpretar tamaño del efecto (Eta²)
✅ Interpretación de interacciones

### Comandos clave:
```spss
ONEWAY variable BY factor /POSTHOC=TUKEY.
UNIANOVA variable BY factor1 factor2.
GLM var1 var2 var3 BY factor /WSFACTOR=tiempo 3.
UNIANOVA variable BY factor WITH covariable.
```

### Próximo paso:
Continúa con el **Módulo 7: Técnicas Avanzadas** para análisis factorial, regresión logística y más.

---

## 💡 Consejos Importantes

1. **ANOVA ≠ diferencias específicas**: Necesitas post-hoc para saber qué grupos difieren

2. **Verifica Levene**: Si p < .05, usa Welch o Games-Howell

3. **Interpreta interacciones primero**: Si hay interacción, los efectos principales pueden ser engañosos

4. **Reporta tamaño del efecto**: p-valor + Eta² o d de Cohen

5. **Medidas repetidas**: Verifica esfericidad (Mauchly) antes de interpretar

6. **ANCOVA**: La covariable debe estar relacionada con la VD pero no con la VI

---

**¡Impresionante!** Ahora dominas ANOVA y comparaciones múltiples, técnicas esenciales para investigación experimental.
