# Módulo 3: Gráficos y Visualizaciones en SPSS

## 📋 Contenido
1. Introducción a los gráficos en SPSS
2. Gráficos de barras
3. Histogramas
4. Diagramas de caja (Boxplots)
5. Gráficos de dispersión (Scatterplots)
6. Gráficos de líneas
7. Gráficos de sectores (Pie charts)
8. Personalización avanzada de gráficos
9. Chart Builder vs. Legacy Dialogs

---

## 1. Introducción a los Gráficos en SPSS

Los gráficos son fundamentales para:
- **Explorar datos** visualmente
- **Identificar patrones** y tendencias
- **Detectar valores atípicos**
- **Comunicar resultados** de forma efectiva

### Dos formas de crear gráficos en SPSS:
1. **Chart Builder**: Interfaz moderna y visual
2. **Legacy Dialogs**: Sintaxis directa y clásica (usaremos esta)

---

## 2. Gráficos de Barras

### 2.1 Gráfico de Barras Simple

```spss
* ================================================.
* GRÁFICO DE BARRAS SIMPLE.
* ================================================.

* Frecuencia por categoría.
GRAPH
  /BAR(SIMPLE)=COUNT BY region.

* Con porcentajes en lugar de frecuencias.
GRAPH
  /BAR(SIMPLE)=PCT BY region.
```

### 2.2 Gráfico de Barras Agrupadas

```spss
* Barras agrupadas por dos variables.
GRAPH
  /BAR(GROUPED)=COUNT BY region BY categoria.

* Con estadístico diferente (media de ventas).
GRAPH
  /BAR(GROUPED)=MEAN(ventas_anuales) BY region BY categoria.
```

### 2.3 Gráfico de Barras Apiladas

```spss
* Barras apiladas.
GRAPH
  /BAR(STACKED)=COUNT BY region BY categoria.
```

### 2.4 Ejemplo Práctico Completo

```spss
* ================================================.
* EJEMPLO: VENTAS PROMEDIO POR REGIÓN Y CATEGORÍA.
* ================================================.

GRAPH
  /BAR(GROUPED)=MEAN(ventas_anuales) BY region BY categoria
  /TITLE='Ventas Anuales Promedio por Región y Categoría'
  /FOOTNOTE='Datos de 2024'
  /MISSING=LISTWISE.
```

---

## 3. Histogramas

Los histogramas muestran la **distribución de frecuencias** de una variable continua.

### 3.1 Histograma Básico

```spss
* ================================================.
* HISTOGRAMA BÁSICO.
* ================================================.

GRAPH
  /HISTOGRAM=edad.

* Con curva normal superpuesta.
GRAPH
  /HISTOGRAM(NORMAL)=salario.
```

### 3.2 Histograma con Opciones

```spss
* Histograma personalizado.
GRAPH
  /HISTOGRAM(NORMAL)=ventas_anuales
  /TITLE='Distribución de Ventas Anuales'
  /FOOTNOTE='N=20 vendedores'.
```

### 3.3 Múltiples Histogramas

```spss
* Histogramas separados por grupo.
SORT CASES BY region.
SPLIT FILE LAYERED BY region.

GRAPH
  /HISTOGRAM(NORMAL)=ventas_anuales.

* Desactivar división.
SPLIT FILE OFF.
```

---

## 4. Diagramas de Caja (Boxplots)

Los boxplots son excelentes para:
- Visualizar la **mediana, cuartiles y valores atípicos**
- **Comparar distribuciones** entre grupos

### 4.1 Boxplot Simple

```spss
* ================================================.
* DIAGRAMA DE CAJA SIMPLE.
* ================================================.

GRAPH
  /BOXPLOT(SIMPLE)=ventas_anuales.
```

### 4.2 Boxplot por Grupos

```spss
* Boxplot separado por categoría.
GRAPH
  /BOXPLOT(SIMPLE)=ventas_anuales BY categoria.

* Boxplot separado por región.
GRAPH
  /BOXPLOT(SIMPLE)=ventas_anuales BY region.
```

### 4.3 Boxplot Agrupado

```spss
* Boxplots agrupados (dos factores).
GRAPH
  /BOXPLOT(GROUPED)=ventas_anuales BY region BY categoria.
```

### 4.4 Interpretación del Boxplot

```
    Máximo (sin atípicos)
         |
    ┌────┴────┐  ← Q3 (Percentil 75)
    │         │
    │    ─    │  ← Mediana (Q2, Percentil 50)
    │         │
    └────┬────┘  ← Q1 (Percentil 25)
         |
    Mínimo (sin atípicos)

    * = Valores atípicos leves (1.5-3 IQR)
    ○ = Valores atípicos extremos (> 3 IQR)
```

---

## 5. Gráficos de Dispersión (Scatterplots)

Los scatterplots muestran la **relación entre dos variables continuas**.

### 5.1 Scatterplot Simple

```spss
* ================================================.
* GRÁFICO DE DISPERSIÓN SIMPLE.
* ================================================.

GRAPH
  /SCATTERPLOT(BIVAR)=edad WITH ventas_anuales.

* Con línea de regresión.
GRAPH
  /SCATTERPLOT(BIVAR)=antiguedad WITH salario
  /MISSING=LISTWISE.
```

### 5.2 Scatterplot con Grupos

```spss
* Puntos diferenciados por color según grupo.
GRAPH
  /SCATTERPLOT(BIVAR)=edad WITH ventas_anuales BY region.

* Con categorías.
GRAPH
  /SCATTERPLOT(BIVAR)=antiguedad WITH ventas_anuales BY categoria.
```

### 5.3 Matriz de Scatterplots

```spss
* Matriz de dispersión (múltiples variables).
GRAPH
  /SCATTERPLOT(MATRIX)=edad antiguedad ventas_q1 ventas_q2
                       ventas_q3 ventas_q4.
```

### 5.4 Scatterplot con Etiquetas

```spss
* Scatterplot con etiquetas de casos.
GRAPH
  /SCATTERPLOT(BIVAR)=antiguedad WITH ventas_anuales
  /TITLE='Relación entre Antigüedad y Ventas'
  /FOOTNOTE='Cada punto representa un vendedor'.
```

---

## 6. Gráficos de Líneas

Ideales para **series temporales** y **tendencias**.

### 6.1 Gráfico de Líneas Simple

```spss
* ================================================.
* GRÁFICO DE LÍNEAS.
* ================================================.

* Primero necesitamos reorganizar datos para series temporales.
* Crear variable de trimestre.
VARSTOCASES
  /MAKE ventas FROM ventas_q1 ventas_q2 ventas_q3 ventas_q4
  /INDEX=trimestre(ventas).

* Gráfico de líneas.
GRAPH
  /LINE(SIMPLE)=MEAN(ventas) BY trimestre.
```

### 6.2 Gráfico de Líneas Múltiples

```spss
* Líneas separadas por grupo.
GRAPH
  /LINE(MULTIPLE)=MEAN(ventas) BY trimestre BY region.
```

### 6.3 Ejemplo: Tendencia Mensual de Ventas

```spss
* Crear datos mensuales (ejemplo).
COMPUTE mes = 1.
LOOP #i = 1 TO 12.
  COMPUTE mes = #i.
  XSAVE OUTFILE='temp.sav'.
END LOOP.
EXECUTE.

* Gráfico de tendencia.
GRAPH
  /LINE(SIMPLE)=MEAN(ventas) BY mes
  /TITLE='Tendencia de Ventas Mensuales'.
```

---

## 7. Gráficos de Sectores (Pie Charts)

Útiles para mostrar **proporciones** de un total.

### 7.1 Gráfico de Sectores Simple

```spss
* ================================================.
* GRÁFICO DE SECTORES.
* ================================================.

GRAPH
  /PIE=COUNT BY region.

* Con porcentajes.
GRAPH
  /PIE=PCT BY categoria.
```

### 7.2 Gráfico de Sectores con Valores

```spss
* Suma de ventas por región.
GRAPH
  /PIE=SUM(ventas_anuales) BY region
  /TITLE='Distribución de Ventas por Región'.
```

---

## 8. Gráficos con GPL (Graphics Production Language)

GPL es el lenguaje avanzado de gráficos de SPSS que permite **máxima personalización**.

### 8.1 Histograma con GPL

```spss
* ================================================.
* GRÁFICOS CON GPL (AVANZADO).
* ================================================.

GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=ventas_anuales
  /GRAPHSPEC SOURCE=INLINE.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: ventas_anuales=col(source(s), name("ventas_anuales"))
  GUIDE: axis(dim(1), label("Ventas Anuales"))
  GUIDE: axis(dim(2), label("Frecuencia"))
  GUIDE: text.title(label("Distribución de Ventas Anuales"))
  ELEMENT: interval(position(summary.count(bin.rect(ventas_anuales))))
END GPL.
```

### 8.2 Boxplot con GPL

```spss
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=ventas_anuales region
  /GRAPHSPEC SOURCE=INLINE.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: ventas_anuales=col(source(s), name("ventas_anuales"), unit.category())
  DATA: region=col(source(s), name("region"), unit.category())
  GUIDE: axis(dim(1), label("Región"))
  GUIDE: axis(dim(2), label("Ventas Anuales"))
  GUIDE: text.title(label("Ventas por Región"))
  SCALE: cat(dim(1), include("1", "2", "3"))
  ELEMENT: schema(position(region*ventas_anuales), label(region))
END GPL.
```

### 8.3 Scatterplot con Línea de Regresión (GPL)

```spss
GGRAPH
  /GRAPHDATASET NAME="graphdataset"
    VARIABLES=antiguedad ventas_anuales
  /GRAPHSPEC SOURCE=INLINE.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: antiguedad=col(source(s), name("antiguedad"))
  DATA: ventas_anuales=col(source(s), name("ventas_anuales"))
  GUIDE: axis(dim(1), label("Antigüedad (años)"))
  GUIDE: axis(dim(2), label("Ventas Anuales (EUR)"))
  GUIDE: text.title(label("Relación entre Antigüedad y Ventas"))
  ELEMENT: point(position(antiguedad*ventas_anuales))
  ELEMENT: line(position(smooth.linear(antiguedad*ventas_anuales)))
END GPL.
```

---

## 9. Ejemplo Práctico Completo

### Análisis Visual de Ventas

```spss
* ================================================================.
* ANÁLISIS VISUAL COMPLETO DE VENTAS.
* ================================================================.

* Supongamos que ya tenemos el dataset de vendedores cargado.

* ----------------------------------------------------------------.
* 1. DISTRIBUCIÓN DE VENTAS ANUALES.
* ----------------------------------------------------------------.

GRAPH
  /HISTOGRAM(NORMAL)=ventas_anuales
  /TITLE='Distribución de Ventas Anuales'
  /FOOTNOTE='Incluye curva normal de referencia'.

* ----------------------------------------------------------------.
* 2. COMPARACIÓN DE VENTAS POR REGIÓN.
* ----------------------------------------------------------------.

GRAPH
  /BAR(SIMPLE)=MEAN(ventas_anuales) BY region
  /TITLE='Ventas Promedio por Región'.

GRAPH
  /BOXPLOT(SIMPLE)=ventas_anuales BY region
  /TITLE='Distribución de Ventas por Región'.

* ----------------------------------------------------------------.
* 3. COMPARACIÓN DE VENTAS POR CATEGORÍA.
* ----------------------------------------------------------------.

GRAPH
  /BAR(SIMPLE)=MEAN(ventas_anuales) BY categoria
  /TITLE='Ventas Promedio por Categoría de Vendedor'.

GRAPH
  /BOXPLOT(SIMPLE)=ventas_anuales BY categoria
  /TITLE='Distribución de Ventas por Categoría'.

* ----------------------------------------------------------------.
* 4. RELACIÓN ENTRE ANTIGÜEDAD Y VENTAS.
* ----------------------------------------------------------------.

GRAPH
  /SCATTERPLOT(BIVAR)=antiguedad WITH ventas_anuales
  /TITLE='Relación entre Antigüedad y Ventas'
  /FOOTNOTE='Cada punto representa un vendedor'.

* Con grupos de categoría.
GRAPH
  /SCATTERPLOT(BIVAR)=antiguedad WITH ventas_anuales BY categoria
  /TITLE='Antigüedad vs Ventas por Categoría'.

* ----------------------------------------------------------------.
* 5. RELACIÓN ENTRE EDAD Y VENTAS.
* ----------------------------------------------------------------.

GRAPH
  /SCATTERPLOT(BIVAR)=edad WITH ventas_anuales BY region
  /TITLE='Edad vs Ventas por Región'.

* ----------------------------------------------------------------.
* 6. DISTRIBUCIÓN POR REGIÓN Y CATEGORÍA.
* ----------------------------------------------------------------.

GRAPH
  /BAR(GROUPED)=MEAN(ventas_anuales) BY region BY categoria
  /TITLE='Ventas Promedio: Región × Categoría'.

* ----------------------------------------------------------------.
* 7. PROPORCIÓN DE VENDEDORES POR REGIÓN.
* ----------------------------------------------------------------.

GRAPH
  /PIE=COUNT BY region
  /TITLE='Distribución de Vendedores por Región'.

* ----------------------------------------------------------------.
* 8. EVOLUCIÓN TRIMESTRAL (requiere reestructuración).
* ----------------------------------------------------------------.

* Calcular medias trimestrales.
AGGREGATE OUTFILE=* MODE=ADDVARIABLES
  /BREAK=
  /mean_q1=MEAN(ventas_q1)
  /mean_q2=MEAN(ventas_q2)
  /mean_q3=MEAN(ventas_q3)
  /mean_q4=MEAN(ventas_q4).

* Para crear gráfico de líneas, necesitamos datos en formato largo.
* (Esto es más complejo, ver ejemplo específico más adelante).
```

---

## 10. Personalización de Gráficos

Después de crear un gráfico, puedes personalizarlo haciendo doble clic en el gráfico en el Viewer.

### Elementos que puedes personalizar:
- **Títulos y etiquetas**: Texto, tamaño, fuente
- **Ejes**: Escala, rango, marcas
- **Colores**: Barras, puntos, líneas
- **Leyendas**: Posición, formato
- **Fondo**: Color, bordes
- **Etiquetas de datos**: Mostrar valores

### Plantillas de Gráficos

```spss
* Aplicar plantilla predefinida.
SET TTEMPLATE='C:/MisCursos/SPSS/mi_plantilla.sgt'.

* Todos los gráficos posteriores usarán esta plantilla.
GRAPH
  /BAR(SIMPLE)=MEAN(ventas_anuales) BY region.

* Desactivar plantilla.
SET TTEMPLATE=''.
```

---

## 11. Exportar Gráficos

### Exportar desde la Ventana de Resultados

```spss
* Exportar todos los gráficos a PNG.
OUTPUT EXPORT
  /CONTENTS EXPORT=VISIBLE LAYERS=PRINTSETTING MODELVIEWS=PRINTSETTING
  /PNG IMAGEROOT='C:/MisCursos/SPSS/graficos/grafico.png'
       PERCENTSIZE=100.

* Exportar a PDF.
OUTPUT EXPORT
  /CONTENTS EXPORT=ALL LAYERS=PRINTSETTING
  /PDF DOCUMENTFILE='C:/MisCursos/SPSS/reporte_graficos.pdf'.

* Exportar a Word.
OUTPUT EXPORT
  /CONTENTS EXPORT=ALL LAYERS=PRINTSETTING
  /DOC DOCUMENTFILE='C:/MisCursos/SPSS/reporte_graficos.docx'.
```

---

## 🎯 Ejercicio Práctico 1

### Dataset: Rendimiento de Productos

Crea 50 registros de productos con:
- ID producto
- Categoría (Electrónica, Hogar, Ropa, Deportes)
- Precio
- Unidades vendidas
- Valoración (1-5 estrellas)
- Descuento (0-50%)

**Tareas gráficas:**
1. Histograma de precios con curva normal
2. Boxplot de unidades vendidas por categoría
3. Scatterplot de precio vs unidades vendidas
4. Gráfico de barras de valoración promedio por categoría
5. Gráfico de sectores de distribución de productos por categoría
6. Scatterplot de precio vs valoración por categoría

---

## 🎯 Ejercicio Práctico 2

### Dataset: Datos Climáticos

Crea datos mensuales (12 meses) con:
- Mes
- Temperatura promedio
- Precipitación
- Humedad
- Horas de sol

**Tareas gráficas:**
1. Gráfico de líneas de temperatura por mes
2. Gráfico de barras de precipitación mensual
3. Scatterplot de temperatura vs precipitación
4. Histograma de distribución de humedad
5. Gráfico de líneas múltiples: temperatura, humedad y horas de sol
6. Boxplot de temperatura por estación del año

---

## 📝 Resumen del Módulo 3

### Has aprendido:
✅ Crear histogramas para visualizar distribuciones
✅ Crear boxplots para comparar grupos y detectar atípicos
✅ Crear gráficos de barras (simples, agrupados, apilados)
✅ Crear scatterplots para analizar relaciones
✅ Crear gráficos de líneas para tendencias temporales
✅ Crear gráficos de sectores para proporciones
✅ Usar GPL para personalización avanzada
✅ Exportar gráficos en diferentes formatos
✅ Interpretar gráficos estadísticos

### Comandos clave:
```spss
GRAPH /HISTOGRAM(NORMAL)=variable.
GRAPH /BOXPLOT(SIMPLE)=variable BY grupo.
GRAPH /BAR(SIMPLE)=MEAN(variable) BY categoria.
GRAPH /SCATTERPLOT(BIVAR)=var1 WITH var2.
GRAPH /LINE(SIMPLE)=MEAN(variable) BY tiempo.
GRAPH /PIE=COUNT BY categoria.
GGRAPH ... BEGIN GPL ... END GPL.
```

### Próximo paso:
Continúa con el **Módulo 4: Pruebas de Hipótesis** para aprender a realizar tests estadísticos inferenciales.

---

## 💡 Consejos para Gráficos Efectivos

1. **Elige el gráfico apropiado**:
   - Distribución → Histograma o boxplot
   - Comparación de grupos → Barras o boxplot
   - Relación → Scatterplot
   - Tendencia temporal → Líneas
   - Proporciones → Sectores

2. **Simplifica**: Menos es más. Evita gráficos sobrecargados

3. **Etiqueta claramente**: Títulos, ejes y leyendas deben ser descriptivos

4. **Usa colores con propósito**: No más de 5-7 colores diferentes

5. **Considera a tu audiencia**: Ajusta la complejidad según quien vaya a verlo

6. **Muestra contexto**: Incluye tamaño de muestra, unidades, fechas

---

**¡Excelente!** Ahora puedes crear visualizaciones profesionales en SPSS. Los gráficos son herramientas poderosas para comunicar tus hallazgos estadísticos.
