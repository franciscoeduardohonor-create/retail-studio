# 📘 Módulo 5: DAX - Nivel Intermedio

## 🎯 Objetivos del Módulo

Al finalizar este módulo serás capaz de:
- Dominar CALCULATE y modificación de contexto
- Usar funciones de Time Intelligence
- Crear medidas con funciones iteradoras (X)
- Optimizar fórmulas con variables
- Trabajar con tablas calculadas
- Aplicar filtros complejos con FILTER

---

## 📚 Contenido

1. [CALCULATE - Modificando el Contexto](#1-calculate---modificando-el-contexto)
2. [Funciones Iteradoras (X)](#2-funciones-iteradoras-x)
3. [Variables en DAX](#3-variables-en-dax)
4. [Time Intelligence](#4-time-intelligence)
5. [FILTER y Filtros Avanzados](#5-filter-y-filtros-avanzados)
6. [Tablas Calculadas](#6-tablas-calculadas)
7. [Ejercicios Prácticos](#7-ejercicios-prácticos)

---

## 1. CALCULATE - Modificando el Contexto

### 1.1 Concepto de CALCULATE

`CALCULATE` es la función más importante de DAX. Permite:
- Cambiar el contexto de filtro
- Aplicar filtros adicionales
- Remover filtros existentes

**Sintaxis básica**:
```dax
CALCULATE(<expresión>, <filtro1>, <filtro2>, ...)
```

### 1.2 CALCULATE Básico

```dax
// EJEMPLO 1: Calcular ventas solo de una categoría específica

// Medida base
Total Ventas = SUM(Ventas[Total])

// Medida con filtro: Solo laptops
Ventas Laptops =
CALCULATE(
    [Total Ventas],              // Expresión a evaluar
    Productos[Categoria] = "Laptops"  // Filtro aplicado
)

// Explicación:
// - Calcula [Total Ventas] pero SOLO para productos donde Categoria = "Laptops"
// - Ignora cualquier filtro de categoría en el visual
// - Siempre muestra ventas de Laptops sin importar los filtros del usuario
```

```dax
// EJEMPLO 2: Comparar ventas de diferentes categorías

Ventas Laptops = CALCULATE([Total Ventas], Productos[Categoria] = "Laptops")
Ventas Accesorios = CALCULATE([Total Ventas], Productos[Categoria] = "Accesorios")
Ventas Monitores = CALCULATE([Total Ventas], Productos[Categoria] = "Monitores")

// Porcentaje de laptops del total
% Laptops =
DIVIDE(
    [Ventas Laptops],
    [Total Ventas],
    0
) * 100

// Uso en visual:
// | Categoría   | Total Ventas | Ventas Laptops | % Laptops |
// |-------------|--------------|----------------|-----------|
// | Laptops     | 100,000      | 100,000        | 40%       |
// | Accesorios  | 50,000       | 100,000        | 40%       |
// | Monitores   | 100,000      | 100,000        | 40%       |
//
// Nota: Ventas Laptops es siempre 100,000 (ignora el filtro de fila)
```

### 1.3 Múltiples Filtros en CALCULATE

```dax
// EJEMPLO 3: Aplicar múltiples condiciones

// Ventas de Laptops Premium (precio > 10000)
Ventas Laptops Premium =
CALCULATE(
    [Total Ventas],
    Productos[Categoria] = "Laptops",     // Condición 1
    Productos[Precio] > 10000             // Condición 2
)
// Los filtros se combinan con AND (ambos deben cumplirse)

// Ventas de productos de alta rotación
Ventas Alta Rotacion =
CALCULATE(
    [Total Ventas],
    Productos[Stock] > 0,                 // Con stock
    Ventas[Cantidad] > 10                 // Ventas mayores a 10 unidades
)
```

### 1.4 ALL - Removiendo Filtros

```dax
// EJEMPLO 4: Calcular porcentaje del total (sin filtros)

// Total general (ignora TODOS los filtros)
Total General =
CALCULATE(
    [Total Ventas],
    ALL(Productos)    // Remueve todos los filtros de la tabla Productos
)

// Porcentaje del total
% del Total =
DIVIDE(
    [Total Ventas],      // Ventas con filtros actuales
    [Total General],     // Ventas sin filtros
    0
) * 100

// Uso en visual:
// | Producto  | Total Ventas | Total General | % del Total |
// |-----------|--------------|---------------|-------------|
// | Laptop    | 100,000      | 250,000       | 40%         |
// | Mouse     | 50,000       | 250,000       | 20%         |
// | Monitor   | 100,000      | 250,000       | 40%         |
```

```dax
// EJEMPLO 5: ALL vs ALLSELECTED

// ALL: Ignora TODOS los filtros (incluso slicers)
Total con ALL = CALCULATE([Total Ventas], ALL(Productos[Categoria]))

// ALLSELECTED: Respeta filtros de slicers/páginas, pero ignora filtros de visual
Total con ALLSELECTED = CALCULATE([Total Ventas], ALLSELECTED(Productos[Categoria]))

// Escenario:
// - Slicer selecciona: Año 2025
// - Visual muestra categorías
//
// | Categoria | Total Ventas | ALL      | ALLSELECTED |
// |-----------|--------------|----------|-------------|
// | Laptops   | 40,000       | 250,000* | 100,000**   |
// | Monitores | 60,000       | 250,000* | 100,000**   |
//
// * Todas las ventas de todos los años
// ** Todas las ventas del 2025 (respeta el slicer)
```

### 1.5 REMOVEFILTERS y KEEPFILTERS

```dax
// EJEMPLO 6: Control fino de filtros

// REMOVEFILTERS: Alternativa moderna a ALL
Total Sin Filtros Categoria =
CALCULATE(
    [Total Ventas],
    REMOVEFILTERS(Productos[Categoria])  // Remueve filtro de esta columna específica
)

// KEEPFILTERS: Mantiene filtros externos además de los nuevos
Ventas Laptops Estricto =
CALCULATE(
    [Total Ventas],
    KEEPFILTERS(Productos[Categoria] = "Laptops")
)
// Si el usuario filtra "Monitores", esta medida devuelve BLANK
// porque intenta aplicar Laptops Y Monitores (imposible)
```

---

## 2. Funciones Iteradoras (X)

### 2.1 Concepto de Funciones X

Las funciones que terminan en "X" iteran fila por fila:
- `SUMX`: Suma una expresión evaluada fila por fila
- `AVERAGEX`: Promedio de una expresión fila por fila
- `COUNTX`: Cuenta filas donde la expresión no es BLANK
- `MINX` / `MAXX`: Mínimo/Máximo de una expresión

### 2.2 SUMX - Suma Iterativa

```dax
// EJEMPLO 7: SUMX básico

// Calcular total de ventas (Cantidad * Precio)
Total Ingresos =
SUMX(
    Ventas,                              // Tabla a iterar
    Ventas[Cantidad] * Ventas[Precio]    // Expresión a evaluar en cada fila
)

// Explicación del proceso:
// Fila 1: 2 * 15999 = 31,998
// Fila 2: 5 * 299 = 1,495
// Fila 3: 3 * 899 = 2,697
// Suma total: 36,190

// Alternativa sin SUMX (si tienes columna calculada):
// 1. Crear columna: TotalLinea = Ventas[Cantidad] * Ventas[Precio]
// 2. Medida: Total Ingresos = SUM(Ventas[TotalLinea])
//
// SUMX es mejor porque:
// - No ocupa memoria (no crea columna)
// - Más flexible (puedes cambiar la fórmula sin modificar el modelo)
```

```dax
// EJEMPLO 8: SUMX con tabla relacionada

// Calcular valor de inventario: Precio * Stock
Valor Inventario =
SUMX(
    Productos,
    Productos[Precio] * Productos[Stock]
)

// Para cada producto:
// Laptop: 15999 * 5 = 79,995
// Mouse: 299 * 25 = 7,475
// Monitor: 4599 * 8 = 36,792
// Total: 124,262
```

### 2.3 AVERAGEX - Promedio Iterativo

```dax
// EJEMPLO 9: Ticket promedio por transacción

// Ticket Promedio = Promedio del Total de cada venta
Ticket Promedio =
AVERAGEX(
    Ventas,
    Ventas[Cantidad] * Ventas[Precio]
)

// Diferencia con AVERAGE simple:
Precio Promedio Simple = AVERAGE(Ventas[Precio])  // Promedio de precios
Ticket Promedio Calculado = AVERAGEX(Ventas, Ventas[Cantidad] * Ventas[Precio])  // Promedio de totales

// Ejemplo:
// Venta 1: 2 * 100 = 200
// Venta 2: 1 * 50 = 50
// Venta 3: 3 * 100 = 300
//
// Precio Promedio Simple: (100 + 50 + 100) / 3 = 83.33
// Ticket Promedio: (200 + 50 + 300) / 3 = 183.33
```

```dax
// EJEMPLO 10: Margen promedio ponderado

Margen Promedio % =
AVERAGEX(
    Productos,
    DIVIDE(
        Productos[Precio] - Productos[Costo],
        Productos[Precio],
        0
    )
) * 100

// Calcula el margen de cada producto y luego promedia
```

### 2.4 COUNTX - Conteo Condicional

```dax
// EJEMPLO 11: Contar ventas rentables

Ventas Rentables =
COUNTX(
    Ventas,
    IF(
        Ventas[Precio] > Ventas[Costo],  // Si hay ganancia
        1,                                 // Cuenta
        BLANK()                            // No cuenta
    )
)

// Otra forma:
Ventas con Descuento =
COUNTX(
    FILTER(
        Ventas,
        Ventas[Descuento] > 0
    ),
    Ventas[VentaID]
)
```

### 2.5 MINX y MAXX

```dax
// EJEMPLO 12: Venta más grande y más pequeña

Venta Mayor =
MAXX(
    Ventas,
    Ventas[Cantidad] * Ventas[Precio]
)

Venta Menor =
MINX(
    Ventas,
    Ventas[Cantidad] * Ventas[Precio]
)

// Fecha de última compra por cliente
Ultima Compra =
MAXX(
    FILTER(
        Ventas,
        Ventas[ClienteID] = EARLIER(Clientes[ClienteID])
    ),
    Ventas[Fecha]
)
```

---

## 3. Variables en DAX

### 3.1 ¿Por qué usar Variables?

Las variables mejoran:
- **Rendimiento**: La expresión se calcula UNA sola vez
- **Legibilidad**: El código es más fácil de entender
- **Mantenimiento**: Cambios en un solo lugar

### 3.2 Sintaxis de Variables

```dax
// EJEMPLO 13: Variable básica

Utilidad =
VAR Ingresos = [Total Ventas]
VAR Costos = [Total Costos]
VAR Ganancia = Ingresos - Costos
RETURN
    Ganancia

// Sin variables (menos eficiente):
Utilidad Sin VAR = [Total Ventas] - [Total Costos]
// Si [Total Ventas] y [Total Costos] son complejos, se calculan varias veces
```

```dax
// EJEMPLO 14: Variables con cálculos intermedios

Margen % =
VAR Ingresos = [Total Ventas]
VAR Costos = [Total Costos]
VAR Utilidad = Ingresos - Costos
VAR Margen = DIVIDE(Utilidad, Ingresos, 0)
RETURN
    Margen * 100

// Ventajas:
// 1. Cada cálculo se hace UNA vez
// 2. Fácil de debuggear (puedes cambiar RETURN temporalmente)
// 3. Código más legible
```

### 3.3 Variables con CALCULATE

```dax
// EJEMPLO 15: Comparar con mes anterior

Crecimiento vs Mes Anterior =
VAR VentasActuales = [Total Ventas]
VAR VentasMesAnterior =
    CALCULATE(
        [Total Ventas],
        DATEADD(Calendario[Fecha], -1, MONTH)
    )
VAR Crecimiento = VentasActuales - VentasMesAnterior
VAR PorcentajeCrecimiento = DIVIDE(Crecimiento, VentasMesAnterior, 0)
RETURN
    PorcentajeCrecimiento * 100
```

### 3.4 Variables para Mejorar Rendimiento

```dax
// EJEMPLO 16: Sin variables (INEFICIENTE)

Ratio Ineficiente =
DIVIDE(
    CALCULATE([Total Ventas], Productos[Categoria] = "Laptops"),
    CALCULATE([Total Ventas], Productos[Categoria] = "Laptops") +
    CALCULATE([Total Ventas], Productos[Categoria] = "Monitores"),
    0
)
// Problema: Calcula "Ventas Laptops" DOS veces

// Con variables (EFICIENTE)
Ratio Eficiente =
VAR VentasLaptops = CALCULATE([Total Ventas], Productos[Categoria] = "Laptops")
VAR VentasMonitores = CALCULATE([Total Ventas], Productos[Categoria] = "Monitores")
VAR TotalAmbos = VentasLaptops + VentasMonitores
VAR Ratio = DIVIDE(VentasLaptops, TotalAmbos, 0)
RETURN
    Ratio
// Cada cálculo se hace UNA sola vez
```

---

## 4. Time Intelligence

### 4.1 Requisitos para Time Intelligence

Para usar funciones de tiempo necesitas:
1. **Tabla de Calendario** con todas las fechas
2. **Columna de fecha** marcada como "Fecha" en el modelo
3. **Relación** entre tabla de hechos y calendario

```dax
// EJEMPLO 17: Crear tabla de calendario

Calendario =
ADDCOLUMNS(
    CALENDAR(DATE(2024, 1, 1), DATE(2025, 12, 31)),
    "Año", YEAR([Date]),
    "Mes", MONTH([Date]),
    "NombreMes", FORMAT([Date], "MMMM"),
    "Trimestre", "Q" & QUARTER([Date]),
    "DiaSemana", WEEKDAY([Date], 2),
    "NombreDia", FORMAT([Date], "DDDD")
)
```

### 4.2 Funciones Básicas de Time Intelligence

```dax
// EJEMPLO 18: Ventas del año hasta la fecha (YTD)

Ventas YTD =
TOTALYTD(
    [Total Ventas],          // Medida a calcular
    Calendario[Fecha]        // Columna de fecha
)

// Explicación:
// Si hoy es 15 de Marzo de 2025:
// - Suma TODAS las ventas desde 1-Enero-2025 hasta 15-Marzo-2025
// - Se actualiza automáticamente cada día
```

```dax
// EJEMPLO 19: Ventas del mes hasta la fecha (MTD)

Ventas MTD =
TOTALMTD(
    [Total Ventas],
    Calendario[Fecha]
)

// Si hoy es 15 de Marzo:
// - Suma ventas desde 1-Marzo hasta 15-Marzo
```

```dax
// EJEMPLO 20: Ventas del trimestre hasta la fecha (QTD)

Ventas QTD =
TOTALQTD(
    [Total Ventas],
    Calendario[Fecha]
)

// Si estamos en Q2 (Abril-Junio) y hoy es 15-Mayo:
// - Suma desde 1-Abril hasta 15-Mayo
```

### 4.3 Comparaciones de Tiempo

```dax
// EJEMPLO 21: Ventas del mismo periodo año anterior

Ventas Año Anterior =
CALCULATE(
    [Total Ventas],
    SAMEPERIODLASTYEAR(Calendario[Fecha])
)

// Si el contexto es Marzo-2025:
// - Devuelve ventas de Marzo-2024

// Crecimiento interanual
Crecimiento YoY =
VAR VentasActual = [Total Ventas]
VAR VentasAñoAnterior = [Ventas Año Anterior]
VAR Diferencia = VentasActual - VentasAñoAnterior
VAR PorcentajeCrecimiento = DIVIDE(Diferencia, VentasAñoAnterior, 0)
RETURN
    PorcentajeCrecimiento * 100
```

```dax
// EJEMPLO 22: Ventas mes anterior

Ventas Mes Anterior =
CALCULATE(
    [Total Ventas],
    DATEADD(Calendario[Fecha], -1, MONTH)
)

// Cambio vs mes anterior
Cambio vs Mes Anterior =
VAR Actual = [Total Ventas]
VAR MesAnterior = [Ventas Mes Anterior]
RETURN
    Actual - MesAnterior

// % Cambio vs mes anterior
% Cambio MoM =
DIVIDE(
    [Cambio vs Mes Anterior],
    [Ventas Mes Anterior],
    0
) * 100
```

### 4.4 Promedios Móviles

```dax
// EJEMPLO 23: Promedio móvil de 3 meses

Promedio Movil 3M =
CALCULATE(
    AVERAGE(Ventas[Total]),
    DATESINPERIOD(
        Calendario[Fecha],
        MAX(Calendario[Fecha]),  // Fecha más reciente en contexto
        -3,                      // 3 periodos hacia atrás
        MONTH                    // Unidad: meses
    )
)

// Si estamos en Marzo-2025:
// - Promedia: Enero-2025, Febrero-2025, Marzo-2025
```

```dax
// EJEMPLO 24: Últimos 7 días

Ventas Ultimos 7 Dias =
CALCULATE(
    [Total Ventas],
    DATESINPERIOD(
        Calendario[Fecha],
        MAX(Calendario[Fecha]),
        -7,
        DAY
    )
)
```

---

## 5. FILTER y Filtros Avanzados

### 5.1 Función FILTER

```dax
// EJEMPLO 25: FILTER básico

// Ventas de productos caros (precio > 5000)
Ventas Productos Premium =
CALCULATE(
    [Total Ventas],
    FILTER(
        Productos,
        Productos[Precio] > 5000
    )
)

// Explicación:
// FILTER devuelve una tabla con solo los productos que cumplen la condición
// CALCULATE aplica esa tabla filtrada como contexto
```

```dax
// EJEMPLO 26: FILTER con múltiples condiciones

// Ventas de laptops con stock bajo
Ventas Laptops Stock Bajo =
CALCULATE(
    [Total Ventas],
    FILTER(
        Productos,
        Productos[Categoria] = "Laptops" &&
        Productos[Stock] < 10
    )
)

// && significa AND (ambas condiciones deben cumplirse)
// || significa OR (al menos una debe cumplirse)
```

### 5.2 FILTER vs Filtros Directos

```dax
// EJEMPLO 27: Cuándo usar FILTER

// Método 1: Filtro directo (MÁS EFICIENTE)
Ventas Laptops v1 =
CALCULATE(
    [Total Ventas],
    Productos[Categoria] = "Laptops"
)

// Método 2: Con FILTER (menos eficiente, pero más flexible)
Ventas Laptops v2 =
CALCULATE(
    [Total Ventas],
    FILTER(
        Productos,
        Productos[Categoria] = "Laptops"
    )
)

// Usa FILTER cuando:
// - Necesitas condiciones complejas
// - Referencias a medidas o múltiples tablas
// - Cálculos dinámicos en el filtro

// Usa filtro directo cuando:
// - Filtros simples de una columna
// - Mejor rendimiento
```

### 5.3 FILTER con Medidas

```dax
// EJEMPLO 28: Filtrar por resultado de medida

// Productos con ventas mayores al promedio
Productos Top =
CALCULATE(
    COUNTROWS(Productos),
    FILTER(
        Productos,
        [Total Ventas] > [Promedio Ventas por Producto]
    )
)

// FILTER puede evaluar medidas en cada fila
```

### 5.4 ALL + FILTER (Patrón Común)

```dax
// EJEMPLO 29: Ranking de productos

Ranking Producto =
VAR VentasProductoActual = [Total Ventas]
VAR Ranking =
    COUNTROWS(
        FILTER(
            ALL(Productos[Nombre]),
            [Total Ventas] > VentasProductoActual
        )
    ) + 1
RETURN
    Ranking

// Explicación:
// 1. ALL elimina filtros del producto actual
// 2. FILTER encuentra productos con más ventas
// 3. COUNTROWS cuenta cuántos hay
// 4. +1 para obtener la posición (el de más ventas tiene 0 por encima, +1 = posición 1)

// Uso en tabla:
// | Producto  | Total Ventas | Ranking |
// |-----------|--------------|---------|
// | Laptop    | 100,000      | 1       |
// | Monitor   | 80,000       | 2       |
// | Mouse     | 50,000       | 3       |
```

---

## 6. Tablas Calculadas

### 6.1 Crear Tabla Calculada

```dax
// EJEMPLO 30: Tabla de resumen de categorías

Resumen Categorias =
SUMMARIZE(
    Productos,
    Productos[Categoria],
    "Cantidad Productos", COUNTROWS(Productos),
    "Precio Promedio", AVERAGE(Productos[Precio]),
    "Precio Maximo", MAX(Productos[Precio]),
    "Precio Minimo", MIN(Productos[Precio])
)

// Crea una tabla nueva con agregaciones
```

```dax
// EJEMPLO 31: Tabla de valores únicos

Lista Categorias =
DISTINCT(Productos[Categoria])

// Crea tabla con una columna de valores únicos
// Útil para slicers personalizados
```

```dax
// EJEMPLO 32: Tabla generada

Rangos Precio =
DATATABLE(
    "Rango", STRING,
    "Min", INTEGER,
    "Max", INTEGER,
    {
        {"Económico", 0, 999},
        {"Medio", 1000, 4999},
        {"Premium", 5000, 99999}
    }
)

// Crea tabla desde cero con datos fijos
// Útil para tablas de parámetros o rangos
```

---

## 7. Ejercicios Prácticos

### Ejercicio 1: Análisis de Ventas con CALCULATE

**Tarea**: Crea las siguientes medidas:
1. Ventas Totales
2. Ventas de Categoría "Electrónica"
3. % que representa Electrónica del total
4. Ventas de productos con precio > 1000

<details>
<summary>👉 Ver Solución</summary>

```dax
// 1. Ventas Totales
Total Ventas = SUM(Ventas[Total])

// 2. Ventas de Electrónica
Ventas Electronica =
CALCULATE(
    [Total Ventas],
    Productos[Categoria] = "Electrónica"
)

// 3. % de Electrónica
% Electronica =
DIVIDE(
    [Ventas Electronica],
    [Total Ventas],
    0
) * 100

// 4. Ventas productos > 1000
Ventas Productos Premium =
CALCULATE(
    [Total Ventas],
    FILTER(
        Productos,
        Productos[Precio] > 1000
    )
)
```
</details>

---

### Ejercicio 2: Funciones X

**Tarea**:
1. Calcula el total de ingresos (Cantidad * Precio)
2. Calcula el ticket promedio
3. Encuentra la venta máxima
4. Cuenta cuántas ventas fueron mayores a $10,000

<details>
<summary>👉 Ver Solución</summary>

```dax
// 1. Total Ingresos
Total Ingresos =
SUMX(
    Ventas,
    Ventas[Cantidad] * Ventas[Precio]
)

// 2. Ticket Promedio
Ticket Promedio =
AVERAGEX(
    Ventas,
    Ventas[Cantidad] * Ventas[Precio]
)

// 3. Venta Máxima
Venta Maxima =
MAXX(
    Ventas,
    Ventas[Cantidad] * Ventas[Precio]
)

// 4. Ventas Grandes
Ventas Mayores 10K =
COUNTX(
    FILTER(
        Ventas,
        Ventas[Cantidad] * Ventas[Precio] > 10000
    ),
    Ventas[VentaID]
)

// Alternativa con COUNTX:
Ventas Mayores 10K v2 =
COUNTX(
    Ventas,
    IF(
        Ventas[Cantidad] * Ventas[Precio] > 10000,
        1,
        BLANK()
    )
)
```
</details>

---

### Ejercicio 3: Time Intelligence

**Tarea** (requiere tabla Calendario):
1. Ventas YTD
2. Ventas del año anterior
3. Crecimiento % vs año anterior
4. Ventas mes anterior
5. Promedio móvil 3 meses

<details>
<summary>👉 Ver Solución</summary>

```dax
// 1. Ventas YTD
Ventas YTD =
TOTALYTD(
    [Total Ventas],
    Calendario[Fecha]
)

// 2. Ventas Año Anterior
Ventas Año Anterior =
CALCULATE(
    [Total Ventas],
    SAMEPERIODLASTYEAR(Calendario[Fecha])
)

// 3. Crecimiento vs Año Anterior
Crecimiento YoY % =
VAR VentasActual = [Total Ventas]
VAR VentasAñoPasado = [Ventas Año Anterior]
VAR Diferencia = VentasActual - VentasAñoPasado
VAR Porcentaje = DIVIDE(Diferencia, VentasAñoPasado, 0)
RETURN
    Porcentaje * 100

// 4. Ventas Mes Anterior
Ventas Mes Anterior =
CALCULATE(
    [Total Ventas],
    DATEADD(Calendario[Fecha], -1, MONTH)
)

// 5. Promedio Móvil 3 Meses
Promedio Movil 3M =
CALCULATE(
    AVERAGE(Ventas[Total]),
    DATESINPERIOD(
        Calendario[Fecha],
        MAX(Calendario[Fecha]),
        -3,
        MONTH
    )
)
```
</details>

---

### Ejercicio 4: Ranking y Filtros Avanzados

**Tarea**:
1. Crea un ranking de productos por ventas
2. Marca los productos del Top 5
3. Calcula ventas solo del Top 5
4. Calcula el % que representa el Top 5 del total

<details>
<summary>👉 Ver Solución</summary>

```dax
// 1. Ranking de Productos
Ranking Producto =
VAR VentasActual = [Total Ventas]
VAR Ranking =
    COUNTROWS(
        FILTER(
            ALL(Productos[Nombre]),
            [Total Ventas] > VentasActual
        )
    ) + 1
RETURN
    Ranking

// 2. Es Top 5 (Columna Calculada o Medida)
Es Top 5 =
IF([Ranking Producto] <= 5, "Sí", "No")

// 3. Ventas Top 5
Ventas Top 5 =
CALCULATE(
    [Total Ventas],
    FILTER(
        ALL(Productos),
        [Ranking Producto] <= 5
    )
)

// 4. % Top 5
% Top 5 del Total =
DIVIDE(
    [Ventas Top 5],
    CALCULATE([Total Ventas], ALL(Productos)),
    0
) * 100
```
</details>

---

## 🎯 Resumen del Módulo

**Has aprendido**:
- ✅ CALCULATE para modificar contexto de filtro
- ✅ Funciones iteradoras (SUMX, AVERAGEX, etc.)
- ✅ Variables para optimizar y mejorar legibilidad
- ✅ Time Intelligence (YTD, MoM, YoY)
- ✅ FILTER para filtros avanzados
- ✅ Tablas calculadas
- ✅ Comparaciones temporales

**Próximo Módulo**: [Módulo 6 - DAX Avanzado](../modulo-6-dax-avanzado/README.md)

Donde aprenderás:
- Patrones DAX avanzados
- Optimización de rendimiento
- Virtual relationships
- Análisis de cohorts
- DAX Studio

---

**¡Excelente trabajo!** 🎉

Estos conceptos intermedios son la base del análisis profesional en Power BI.
