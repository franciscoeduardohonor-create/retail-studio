* ================================================================.
* SINTAXIS DEL MÓDULO 2: ESTADÍSTICA DESCRIPTIVA
* Autor: Curso Práctico de SPSS
* Descripción: Ejemplos prácticos del Módulo 2
* ================================================================.

* ================================================================.
* CREAR DATASET DE VENTAS
* ================================================================.

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

* Crear variables calculadas.
COMPUTE ventas_anuales = ventas_q1 + ventas_q2 + ventas_q3 + ventas_q4.
COMPUTE ventas_promedio = MEAN(ventas_q1, ventas_q2, ventas_q3, ventas_q4).
COMPUTE crecimiento_anual = ((ventas_q4 - ventas_q1) / ventas_q1) * 100.
COMPUTE volatilidad = SD(ventas_q1, ventas_q2, ventas_q3, ventas_q4).

VARIABLE LABELS
  ventas_anuales 'Ventas Anuales Totales (EUR)'
  ventas_promedio 'Promedio Trimestral de Ventas (EUR)'
  crecimiento_anual 'Crecimiento Anual (%)'
  volatilidad 'Volatilidad de Ventas'.

EXECUTE.

* ================================================================.
* ESTADÍSTICAS DESCRIPTIVAS BÁSICAS
* ================================================================.

DESCRIPTIVES VARIABLES=edad antiguedad ventas_anuales
                       ventas_promedio crecimiento_anual volatilidad
  /STATISTICS=MEAN STDDEV MIN MAX VARIANCE RANGE SEMEAN SKEWNESS KURTOSIS.

* ================================================================.
* TABLAS DE FRECUENCIAS
* ================================================================.

FREQUENCIES VARIABLES=region categoria
  /BARCHART PERCENT
  /ORDER=ANALYSIS.

* ================================================================.
* ANÁLISIS EXPLORATORIO COMPLETO
* ================================================================.

EXAMINE VARIABLES=ventas_anuales
  /PLOT=BOXPLOT HISTOGRAM NPPLOT
  /STATISTICS=DESCRIPTIVES EXTREME
  /PERCENTILES(10,25,50,75,90)
  /ID=nombre.

* ================================================================.
* ESTADÍSTICOS POR GRUPOS
* ================================================================.

* Ventas por región.
MEANS TABLES=ventas_anuales ventas_promedio crecimiento_anual BY region
  /CELLS=MEAN STDDEV MIN MAX COUNT.

* Ventas por categoría con ANOVA.
MEANS TABLES=ventas_anuales BY categoria
  /CELLS=MEAN STDDEV COUNT
  /STATISTICS=ANOVA.

* ================================================================.
* TABLAS DE CONTINGENCIA
* ================================================================.

CROSSTABS
  /TABLES=region BY categoria
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ
  /CELLS=COUNT ROW COLUMN TOTAL.

* ================================================================.
* FIN DE LA SINTAXIS
* ================================================================.
