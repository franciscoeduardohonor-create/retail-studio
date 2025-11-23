# 📝 Ejercicios Prácticos del Curso SPSS

Este documento contiene ejercicios prácticos adicionales para reforzar tu aprendizaje.

---

## 📚 Índice de Ejercicios

1. [Ejercicios Módulo 1: Introducción](#módulo-1-introducción)
2. [Ejercicios Módulo 2: Estadística Descriptiva](#módulo-2-estadística-descriptiva)
3. [Ejercicios Módulo 3: Gráficos](#módulo-3-gráficos)
4. [Ejercicios Módulo 4: Pruebas de Hipótesis](#módulo-4-pruebas-de-hipótesis)
5. [Ejercicios Módulo 5: Correlación y Regresión](#módulo-5-correlación-y-regresión)
6. [Ejercicios Módulo 6: ANOVA](#módulo-6-anova)
7. [Ejercicios Módulo 7: Técnicas Avanzadas](#módulo-7-técnicas-avanzadas)
8. [Proyecto Final Integrador](#proyecto-final-integrador)

---

## Módulo 1: Introducción

### Ejercicio 1.1: Crear tu Primera Base de Datos

**Objetivo**: Familiarizarse con la creación de datos en SPSS.

**Instrucciones:**
Crea un dataset con información de 15 productos de una tienda:

1. **Variables a incluir:**
   - ID del producto (numérico)
   - Nombre del producto (texto)
   - Categoría (1=Electrónica, 2=Ropa, 3=Alimentos, 4=Hogar)
   - Precio (numérico con 2 decimales)
   - Stock disponible (numérico)
   - Descuento actual (0=No, 1=Sí)
   - Valoración promedio (1-5 estrellas, decimal)

2. **Tareas:**
   - Asigna etiquetas apropiadas a todas las variables
   - Define correctamente el nivel de medición de cada variable
   - Crea una variable calculada: `precio_descuento` = precio * 0.8 si descuento=1
   - Crea una variable categórica `rango_precio`: Bajo (<20), Medio (20-50), Alto (>50)
   - Guarda el archivo como `productos.sav`

**Solución esperada:**
```spss
* Tu código aquí
```

---

### Ejercicio 1.2: Manipulación de Datos

**Objetivo**: Practicar transformaciones de variables.

Usando el dataset `empleados.csv`:

1. Crea una variable `salario_anual` = salario_mensual * 12
2. Crea una variable `grupo_edad`:
   - 1 = "Jóvenes" (< 30 años)
   - 2 = "Adultos" (30-40 años)
   - 3 = "Senior" (> 40 años)
3. Crea una variable `alto_rendimiento`:
   - 1 si productividad >= 90
   - 0 si productividad < 90
4. Calcula el salario promedio por departamento y guárdalo en una nueva variable
5. Ordena los datos por salario (descendente)

---

## Módulo 2: Estadística Descriptiva

### Ejercicio 2.1: Análisis Descriptivo Completo

**Dataset**: `estudiantes.csv`

**Tareas:**

1. **Estadísticos descriptivos:**
   - Calcula media, mediana, moda, desviación estándar, mínimo y máximo de:
     - Promedio
     - Horas de estudio
     - Asistencia
     - Satisfacción

2. **Tablas de frecuencias:**
   - Crea tablas de frecuencias para:
     - Género
     - Facultad
     - Beca

3. **Percentiles:**
   - Calcula los percentiles 25, 50, 75 y 90 del promedio
   - ¿Qué promedio se necesita para estar en el top 10%?

4. **Análisis por grupos:**
   - Calcula estadísticos de promedio separados por facultad
   - Calcula estadísticos de horas de estudio separados por género

5. **Interpretación:**
   - ¿Qué facultad tiene el promedio más alto?
   - ¿Hay diferencia en horas de estudio entre géneros?
   - ¿Los estudiantes con beca estudian más horas?

**Código esperado:**
```spss
* Importar datos.
GET DATA...

* 1. Descriptivos.
DESCRIPTIVES...

* 2. Frecuencias.
FREQUENCIES...

* 3. Percentiles.
FREQUENCIES.../PERCENTILES...

* 4. Por grupos.
MEANS...

* 5. Interpretación en comentarios.
```

---

### Ejercicio 2.2: Tabla de Contingencia

**Dataset**: `empleados.csv`

Crea tablas de contingencia para analizar:

1. Departamento × Género
   - ¿Hay distribución equitativa de género por departamento?

2. Nivel educativo × Departamento
   - ¿Qué departamento tiene mayor nivel educativo?

3. Crea una variable `alta_satisfaccion` (satisfaccion >= 8)
   - Analiza: Departamento × Alta satisfacción
   - ¿Qué departamento tiene mayor proporción de empleados satisfechos?

Incluye:
- Frecuencias absolutas
- Porcentajes por fila
- Porcentajes por columna
- Prueba Chi-cuadrado

---

## Módulo 3: Gráficos

### Ejercicio 3.1: Visualizaciones Básicas

**Dataset**: `estudiantes.csv`

Crea los siguientes gráficos:

1. **Histograma** del promedio con curva normal
2. **Boxplot** de promedio por facultad
3. **Gráfico de barras** de frecuencia de estudiantes por facultad
4. **Gráfico de sectores** de distribución de género
5. **Scatterplot** de horas_estudio vs promedio
   - Con puntos diferenciados por facultad
6. **Scatterplot** de asistencia vs promedio
   - ¿Hay relación visual?

**Personalización:**
- Añade títulos descriptivos
- Etiqueta los ejes correctamente
- Usa colores apropiados

---

### Ejercicio 3.2: Visualización de Tendencias

**Dataset**: `empleados.csv`

1. Crea un boxplot comparando salarios entre departamentos
   - Identifica valores atípicos

2. Crea un scatterplot de antigüedad vs salario
   - Diferencia por departamento
   - ¿Se observa relación positiva?

3. Crea un gráfico de barras agrupadas:
   - Eje X: Departamento
   - Barras: Productividad promedio por género

4. Exporta todos los gráficos a PDF

---

## Módulo 4: Pruebas de Hipótesis

### Ejercicio 4.1: Pruebas t

**Dataset**: `estudiantes.csv`

**Pregunta 1: ¿El promedio general es superior a 7.0?**
- H₀: μ = 7.0
- H₁: μ > 7.0
- Usa prueba t de una muestra
- α = 0.05
- Interpreta el resultado

**Pregunta 2: ¿Hay diferencias en el promedio entre estudiantes con y sin beca?**
- H₀: μ_beca = μ_sin_beca
- H₁: μ_beca ≠ μ_sin_beca
- Usa prueba t para muestras independientes
- Verifica homogeneidad de varianzas
- Calcula tamaño del efecto (d de Cohen)

**Pregunta 3: Si tuvieras datos antes-después de una intervención:**
- Crea datos ficticios de 20 estudiantes
- Calificación antes de tutoría
- Calificación después de tutoría
- Prueba t pareada para evaluar efectividad

---

### Ejercicio 4.2: Chi-Cuadrado

**Dataset**: `estudiantes.csv`

**Pregunta: ¿Hay asociación entre género y facultad?**

1. Crea tabla de contingencia género × facultad
2. Incluye frecuencias esperadas
3. Realiza prueba Chi-cuadrado
4. Calcula coeficiente Phi o V de Cramer
5. Interpreta:
   - ¿Es significativa la asociación?
   - ¿Cuál es la magnitud?
   - ¿Hay alguna facultad con desequilibrio de género?

---

### Ejercicio 4.3: Pruebas No Paramétricas

**Dataset**: `empleados.csv`

1. Verifica normalidad de la variable `productividad` por departamento
   - Usa prueba Kolmogorov-Smirnov
   - Crea Q-Q plots

2. Si no hay normalidad, usa Mann-Whitney U:
   - Compara productividad entre géneros

3. Compara satisfacción entre los 4 departamentos:
   - Usa Kruskal-Wallis (alternativa no paramétrica a ANOVA)
   - Si es significativo, realiza comparaciones post-hoc

---

## Módulo 5: Correlación y Regresión

### Ejercicio 5.1: Análisis de Correlación

**Dataset**: `estudiantes.csv`

1. **Matriz de correlaciones:**
   - Variables: promedio, horas_estudio, asistencia, satisfaccion
   - Usa correlación de Pearson
   - Identifica las correlaciones más fuertes

2. **Interpretación:**
   - ¿Qué variable está más correlacionada con el promedio?
   - ¿Hay multicolinealidad entre predictores?

3. **Correlación no paramétrica:**
   - Calcula Spearman para las mismas variables
   - Compara con Pearson

---

### Ejercicio 5.2: Regresión Lineal Simple

**Dataset**: `estudiantes.csv`

**Pregunta: ¿Las horas de estudio predicen el promedio?**

1. Crea scatterplot de horas_estudio vs promedio
2. Realiza regresión lineal simple
3. Interpreta:
   - R² (¿qué % de varianza se explica?)
   - Coeficiente β (¿cuánto aumenta el promedio por cada hora adicional?)
   - ¿Es significativo? (p < .05)
4. Escribe la ecuación de regresión
5. Predice el promedio de un estudiante que estudia 20 horas/semana
6. Verifica supuestos:
   - Linealidad (scatterplot)
   - Normalidad de residuos
   - Homocedasticidad

---

### Ejercicio 5.3: Regresión Múltiple

**Dataset**: `estudiantes.csv`

**Pregunta: ¿Qué factores predicen mejor el promedio académico?**

1. **Modelo 1**: Regresión múltiple con predictores:
   - horas_estudio
   - asistencia
   - beca (dummy)

2. **Interpretación:**
   - R² y R² ajustado
   - ¿Qué variable es el predictor más importante? (Beta estandarizado)
   - ¿Hay multicolinealidad? (VIF)

3. **Modelo 2**: Usa método Stepwise
   - ¿Qué variables entran al modelo?
   - Compara con Modelo 1

4. **Diagnóstico:**
   - Identifica casos influyentes (Cook's D)
   - Verifica normalidad de residuos
   - Crea ecuación predictiva final

**Desafío adicional:**
Crea un modelo separado para cada facultad y compara los coeficientes.

---

## Módulo 6: ANOVA

### Ejercicio 6.1: ANOVA de Un Factor

**Dataset**: `estudiantes.csv`

**Pregunta: ¿Hay diferencias en el promedio entre las 4 facultades?**

1. **Análisis previo:**
   - Calcula media y SD del promedio por facultad
   - Crea boxplot comparativo

2. **ANOVA:**
   - Verifica homogeneidad de varianzas (Levene)
   - Realiza ANOVA de un factor
   - Si p < .05, realiza prueba post-hoc Tukey

3. **Interpretación:**
   - ¿Qué facultades difieren significativamente?
   - Calcula Eta² (tamaño del efecto)
   - ¿Es grande la diferencia práctica?

4. **Si Levene es significativo:**
   - Usa Welch ANOVA
   - Usa Games-Howell para post-hoc

---

### Ejercicio 6.2: ANOVA Factorial

**Dataset**: `estudiantes.csv`

**Pregunta: ¿El promedio depende de la facultad y/o la beca? ¿Hay interacción?**

1. Realiza ANOVA factorial 4×2:
   - Factor A: Facultad (4 niveles)
   - Factor B: Beca (2 niveles)
   - VD: Promedio

2. Interpreta:
   - Efecto principal de Facultad
   - Efecto principal de Beca
   - Interacción Facultad × Beca

3. Si hay interacción significativa:
   - Crea gráfico de interacción
   - Analiza efectos simples

4. Calcula medias marginales estimadas

---

### Ejercicio 6.3: ANOVA de Medidas Repetidas

**Crea datos ficticios:**

20 estudiantes evaluados en 4 exámenes parciales:
- Parcial 1, 2, 3, 4

**Pregunta: ¿Hay cambio en el rendimiento a lo largo del semestre?**

1. Crea el dataset con datos de ejemplo
2. Realiza ANOVA de medidas repetidas
3. Verifica esfericidad (Mauchly)
4. Si hay diferencias, ¿dónde están? (comparaciones pareadas)
5. Crea gráfico de líneas mostrando la tendencia

---

## Módulo 7: Técnicas Avanzadas

### Ejercicio 7.1: Análisis Factorial

**Crea un cuestionario de clima laboral:**

15 items, escala 1-7, 30 empleados:
- Items 1-5: Satisfacción con el trabajo
- Items 6-10: Relación con compañeros
- Items 11-15: Relación con supervisores

**Tareas:**

1. Verifica adecuación de los datos (KMO y Bartlett)
2. Realiza análisis factorial exploratorio
   - Método de extracción: Ejes principales
   - Rotación: Varimax
3. ¿Cuántos factores emergen?
4. Interpreta la matriz de componentes rotados
5. Calcula Alfa de Cronbach para cada factor
6. Guarda puntuaciones factoriales

---

### Ejercicio 7.2: Regresión Logística

**Dataset**: Crea datos de 100 clientes

Variables:
- edad
- ingresos
- satisfaccion (1-10)
- quejas (número)
- abandono (0=No, 1=Sí)

**Pregunta: ¿Qué factores predicen el abandono de clientes?**

1. Realiza regresión logística binaria
2. Interpreta Odds Ratios
3. ¿Qué variable es el predictor más fuerte?
4. Evalúa la bondad de ajuste
5. Revisa la tabla de clasificación
   - ¿Qué % de precisión tiene el modelo?
6. Identifica clientes de alto riesgo (probabilidad > 0.7)

---

### Ejercicio 7.3: Análisis de Conglomerados

**Dataset**: `empleados.csv`

**Objetivo: Segmentar empleados en grupos homogéneos**

1. Selecciona variables:
   - edad
   - antiguedad
   - salario_mensual
   - satisfaccion
   - productividad

2. Estandariza las variables (Z-scores)

3. Realiza análisis de conglomerados K-medias:
   - Prueba con k=2, 3, 4, 5
   - Elige el k óptimo

4. Caracteriza cada conglomerado:
   - Calcula medias de cada variable
   - Interpreta perfiles
   - Asigna nombres descriptivos

5. Valida con ANOVA:
   - ¿Los conglomerados difieren significativamente?

6. Analiza distribución de departamentos por conglomerado
   - Tabla de contingencia

---

## Proyecto Final Integrador

### Proyecto: Análisis Integral de Recursos Humanos

**Contexto:**
Eres analista de RRHH de una empresa. Te han pedido un informe completo sobre la fuerza laboral.

**Dataset**: Combina y expande `empleados.csv` con datos adicionales ficticios.

**Variables adicionales a crear:**
- Cuestionario de clima (10 items, escala 1-7)
- Evaluación de desempeño del supervisor (0-100)
- Capacitaciones completadas (número)
- Intención de rotación (0=No, 1=Sí)
- Salario deseado

---

### Fase 1: Análisis Descriptivo (Módulos 1-2)

1. **Preparación de datos:**
   - Importa y limpia datos
   - Crea variables calculadas necesarias
   - Verifica valores perdidos

2. **Análisis univariado:**
   - Descriptivos de todas las variables continuas
   - Frecuencias de todas las categóricas
   - Identifica valores atípicos

3. **Análisis bivariado:**
   - Tablas cruzadas relevantes
   - Correlaciones entre variables continuas

---

### Fase 2: Visualización (Módulo 3)

Crea un conjunto de gráficos para el informe:

1. Pirámide poblacional (edad × género)
2. Distribución salarial por departamento (boxplots)
3. Relación antigüedad-salario (scatterplot)
4. Satisfacción por departamento (barras)
5. Distribución de niveles educativos (sectores)

Exporta todos a un solo PDF profesional.

---

### Fase 3: Inferencia (Módulos 4-6)

**Preguntas de investigación:**

1. **¿Hay brecha salarial de género?**
   - t-test o ANCOVA controlando por antigüedad y departamento

2. **¿Qué departamento tiene mejor clima laboral?**
   - ANOVA con post-hoc

3. **¿La satisfacción difiere por género y departamento?**
   - ANOVA factorial 2×4

4. **¿Hay asociación entre nivel educativo y departamento?**
   - Chi-cuadrado

---

### Fase 4: Modelado Predictivo (Módulo 5)

**Modelo 1: Predecir Desempeño**
- VD: Evaluación de desempeño
- VI: Satisfacción, capacitaciones, antigüedad, clima laboral
- Usa regresión múltiple

**Modelo 2: Predecir Intención de Rotación**
- VD: Intención de rotación (0/1)
- VI: Satisfacción, salario, desempeño, clima
- Usa regresión logística

---

### Fase 5: Análisis Avanzado (Módulo 7)

1. **Análisis factorial del cuestionario de clima**
   - Identifica dimensiones
   - Calcula confiabilidad

2. **Segmentación de empleados (cluster)**
   - Identifica perfiles de empleados
   - Caracteriza cada segmento

3. **Análisis de riesgo de rotación**
   - Identifica empleados en riesgo
   - Recomienda acciones

---

### Fase 6: Informe Final

Crea un documento que incluya:

1. **Resumen Ejecutivo** (1 página)
   - Hallazgos clave
   - Recomendaciones principales

2. **Metodología** (1 página)
   - Muestra
   - Técnicas utilizadas

3. **Resultados** (5-10 páginas)
   - Análisis descriptivos
   - Pruebas de hipótesis
   - Modelos predictivos
   - Gráficos

4. **Conclusiones y Recomendaciones** (2 páginas)
   - Implicaciones prácticas
   - Acciones sugeridas

5. **Anexos**
   - Sintaxis de SPSS
   - Tablas completas

---

### Criterios de Evaluación

**Análisis Técnico (40%):**
- Selección apropiada de técnicas estadísticas
- Verificación de supuestos
- Interpretación correcta de resultados

**Visualización (20%):**
- Gráficos apropiados y claros
- Etiquetado correcto
- Presentación profesional

**Interpretación (30%):**
- Conclusiones basadas en evidencia
- Comprensión del contexto empresarial
- Recomendaciones prácticas

**Documentación (10%):**
- Sintaxis clara y comentada
- Reporte bien estructurado
- Referencias a resultados específicos

---

## 🎓 Soluciones

Las soluciones detalladas de todos los ejercicios estarán disponibles en:
`ejercicios/soluciones/`

**Nota**: Se recomienda intentar resolver los ejercicios por tu cuenta antes de consultar las soluciones.

---

## 💡 Consejos para Resolver Ejercicios

1. **Lee el enunciado completo** antes de empezar
2. **Planifica tu enfoque** antes de escribir código
3. **Comenta tu sintaxis** para documentar tu razonamiento
4. **Verifica tus resultados** con sentido común
5. **Compara con ejemplos** del módulo correspondiente
6. **No te rindas** si algo no funciona; revisa errores comunes
7. **Interpreta, no solo calcules**: Los números sin contexto no sirven

---

## 📞 Ayuda

Si tienes dificultades:
1. Revisa el módulo teórico correspondiente
2. Consulta los ejemplos resueltos
3. Busca en la documentación de SPSS
4. Pregunta en foros especializados

---

**¡Mucho éxito con los ejercicios!** 🚀📊

La práctica constante es la clave para dominar SPSS.
