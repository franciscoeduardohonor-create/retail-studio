# 📘 Módulo 4: Time Intelligence (Inteligencia Temporal)

## 🎯 Objetivos del Módulo

- ✅ Crear y usar tabla de calendario
- ✅ Dominar funciones temporales: YTD, MTD, QTD
- ✅ Comparar períodos (vs año anterior, vs mes anterior)
- ✅ Calcular crecimientos y variaciones
- ✅ Crear análisis de tendencias

---

## 📅 La Tabla de Calendario (Esencial)

> **💡 Las funciones de Time Intelligence REQUIEREN una tabla de calendario**

### Crear Tabla de Calendario

```dax
-- Opción 1: CALENDAR (rango manual)
Calendario =
    CALENDAR(DATE(2023, 1, 1), DATE(2025, 12, 31))

-- Opción 2: CALENDARAUTO (detecta automáticamente)
Calendario =
    CALENDARAUTO()

/*
📝 CALENDARAUTO():
- Busca la fecha mín/máx en el modelo
- Crea calendario completo para esos años
- MÁS PRÁCTICO
*/
```

### Enriquecer la Tabla de Calendario

```dax
-- Columnas calculadas en la tabla Calendario

Año = YEAR('Calendario'[Fecha])

Trimestre = "Q" & QUARTER('Calendario'[Fecha])

Mes Número = MONTH('Calendario'[Fecha])

Mes Nombre = FORMAT('Calendario'[Fecha], "MMMM")

Mes Corto = FORMAT('Calendario'[Fecha], "MMM")

Semana = WEEKNUM('Calendario'[Fecha])

Día Semana = WEEKDAY('Calendario'[Fecha])

Nombre Día = FORMAT('Calendario'[Fecha], "DDDD")

Es Fin de Semana =
    IF(
        WEEKDAY('Calendario'[Fecha]) IN {1, 7},
        "Sí",
        "No"
    )

Año-Mes = FORMAT('Calendario'[Fecha], "YYYY-MM")

Trimestre Año = 'Calendario'[Año] & "-" & 'Calendario'[Trimestre]

/*
📝 IMPORTANTE:
- Crea RELACIÓN entre Ventas[Fecha] y Calendario[Fecha]
- Marca Calendario como tabla de fechas:
  → Table Tools > Mark as Date Table
*/
```

---

## 📊 Funciones YTD, MTD, QTD

### TOTALYTD - Total Year To Date

```dax
-- Ventas acumuladas del año hasta la fecha

Ventas YTD =
    TOTALYTD(
        SUM('Ventas'[MontoTotal]),
        'Calendario'[Fecha]
    )

/*
📝 EJEMPLO:

Hoy es: 15 de Marzo 2024

Ventas YTD = Suma de ventas desde 1 Enero 2024 hasta 15 Marzo 2024

┌──────────┬────────────┬─────────────┐
│ Mes      │ Ventas Mes │ Ventas YTD  │
├──────────┼────────────┼─────────────┤
│ Enero    │ $100,000   │ $100,000    │
│ Febrero  │ $120,000   │ $220,000    │
│ Marzo    │ $80,000    │ $300,000    │ ← Acumulado
└──────────┴────────────┴─────────────┘
*/
```

### TOTALMTD - Total Month To Date

```dax
-- Ventas acumuladas del mes

Ventas MTD =
    TOTALMTD(
        SUM('Ventas'[MontoTotal]),
        'Calendario'[Fecha]
    )

/*
📝 EJEMPLO:

Hoy es: 15 de Marzo

Ventas MTD = Suma desde 1 Marzo hasta 15 Marzo
*/
```

### TOTALQTD - Total Quarter To Date

```dax
-- Ventas acumuladas del trimestre

Ventas QTD =
    TOTALQTD(
        SUM('Ventas'[MontoTotal]),
        'Calendario'[Fecha]
    )

/*
📝 EJEMPLO:

Hoy es: 15 de Marzo (Q1)

Ventas QTD = Suma desde 1 Enero hasta 15 Marzo
*/
```

---

## 🔄 Comparaciones Temporales

### SAMEPERIODLASTYEAR - Mismo Período Año Anterior

```dax
-- Ventas del mismo período del año pasado

Ventas Año Anterior =
    CALCULATE(
        SUM('Ventas'[MontoTotal]),
        SAMEPERIODLASTYEAR('Calendario'[Fecha])
    )

/*
📝 EJEMPLO:

Contexto actual: Marzo 2024
SAMEPERIODLASTYEAR → Marzo 2023

Contexto actual: Q1 2024
SAMEPERIODLASTYEAR → Q1 2023
*/

-- Variación vs año anterior
Variación vs AA =
    [Total Ventas] - [Ventas Año Anterior]

-- % Crecimiento vs año anterior
% Crecimiento YoY =
    DIVIDE(
        [Variación vs AA],
        [Ventas Año Anterior],
        0
    ) * 100
```

### PARALLELPERIOD - Período Paralelo

```dax
-- Ventas del mes anterior
Ventas Mes Anterior =
    CALCULATE(
        SUM('Ventas'[MontoTotal]),
        PARALLELPERIOD('Calendario'[Fecha], -1, MONTH)
    )

-- Ventas del trimestre anterior
Ventas Trimestre Anterior =
    CALCULATE(
        SUM('Ventas'[MontoTotal]),
        PARALLELPERIOD('Calendario'[Fecha], -1, QUARTER)
    )

/*
📝 PARALLELPERIOD(Fecha, N, Intervalo)

N: Número de intervalos (-1 = anterior, 1 = siguiente)
Intervalo: MONTH, QUARTER, YEAR

Ejemplos:
PARALLELPERIOD(..., -1, MONTH) → Mes anterior
PARALLELPERIOD(..., -3, MONTH) → 3 meses atrás
PARALLELPERIOD(..., 1, YEAR) → Próximo año
*/
```

### DATEADD - Mover Fechas

```dax
-- Ventas hace 7 días
Ventas Hace 7 Días =
    CALCULATE(
        SUM('Ventas'[MontoTotal]),
        DATEADD('Calendario'[Fecha], -7, DAY)
    )

-- Ventas hace 6 meses
Ventas Hace 6 Meses =
    CALCULATE(
        SUM('Ventas'[MontoTotal]),
        DATEADD('Calendario'[Fecha], -6, MONTH)
    )

/*
📝 DATEADD vs PARALLELPERIOD:

DATEADD:
- Más flexible (DAY, MONTH, QUARTER, YEAR)
- Mantiene la granularidad del contexto

PARALLELPERIOD:
- Solo MONTH, QUARTER, YEAR
- Cambia a períodos completos
*/
```

---

## 📈 Análisis de Tendencias

### Promedio Móvil

```dax
-- Promedio móvil de 7 días

Promedio Móvil 7 Días =
VAR FechaMax = MAX('Calendario'[Fecha])
VAR FechaMin = FechaMax - 7

RETURN
    CALCULATE(
        AVERAGE('Ventas'[MontoTotal]),
        DATESBETWEEN(
            'Calendario'[Fecha],
            FechaMin,
            FechaMax
        )
    )

/*
📝 DATESBETWEEN(Columna, Inicio, Fin)

Filtra fechas entre un rango
*/

-- Promedio móvil de 3 meses
Promedio Móvil 3 Meses =
VAR FechaActual = MAX('Calendario'[Fecha])

RETURN
    CALCULATE(
        AVERAGE(
            CALCULATE(SUM('Ventas'[MontoTotal]))
        ),
        DATESINPERIOD(
            'Calendario'[Fecha],
            FechaActual,
            -3,
            MONTH
        )
    )

/*
📝 DATESINPERIOD(Columna, FechaInicio, N, Intervalo)

Retorna N intervalos desde FechaInicio
*/
```

### Crecimiento Acumulado

```dax
-- Crecimiento acumulado del año

Crecimiento Acumulado YTD % =
VAR VentasActualYTD = [Ventas YTD]
VAR VentasAñoAnteriorYTD =
    CALCULATE(
        [Ventas YTD],
        SAMEPERIODLASTYEAR('Calendario'[Fecha])
    )

RETURN
    DIVIDE(
        VentasActualYTD - VentasAñoAnteriorYTD,
        VentasAñoAnteriorYTD,
        0
    ) * 100
```

---

## 🎨 Casos Prácticos Completos

### Dashboard de Análisis Temporal

```dax
-- 1. VENTAS DEL MES ACTUAL
Ventas Mes Actual =
    TOTALMTD(
        SUM('Ventas'[MontoTotal]),
        'Calendario'[Fecha]
    )

-- 2. VENTAS DEL AÑO ACTUAL
Ventas Año Actual =
    TOTALYTD(
        SUM('Ventas'[MontoTotal]),
        'Calendario'[Fecha]
    )

-- 3. VENTAS MES PASADO
Ventas Mes Pasado =
    CALCULATE(
        [Total Ventas],
        PARALLELPERIOD('Calendario'[Fecha], -1, MONTH)
    )

-- 4. VARIACIÓN MES vs MES ANTERIOR
Var MoM =
    [Total Ventas] - [Ventas Mes Pasado]

% Var MoM =
    DIVIDE([Var MoM], [Ventas Mes Pasado], 0) * 100

-- 5. VENTAS MISMO MES AÑO ANTERIOR
Ventas Mismo Mes AA =
    CALCULATE(
        [Total Ventas],
        SAMEPERIODLASTYEAR('Calendario'[Fecha])
    )

-- 6. VARIACIÓN YoY (Year over Year)
Var YoY =
    [Total Ventas] - [Ventas Mismo Mes AA]

% Var YoY =
    DIVIDE([Var YoY], [Ventas Mismo Mes AA], 0) * 100

-- 7. PROYECCIÓN FIN DE AÑO
Proyección Año =
VAR DíasTranscurridos =
    COUNTROWS(
        FILTER(
            ALL('Calendario'),
            'Calendario'[Año] = YEAR(TODAY()) &&
            'Calendario'[Fecha] <= TODAY()
        )
    )

VAR DíasTotalesAño = 365

RETURN
    DIVIDE(
        [Ventas Año Actual] * DíasTotalesAño,
        DíasTranscurridos,
        0
    )
```

### Análisis de Estacionalidad

```dax
-- Índice de estacionalidad por mes

Índice Estacionalidad Mes =
VAR VentasDelMes =
    CALCULATE(
        [Total Ventas],
        ALLEXCEPT('Calendario', 'Calendario'[Mes Nombre])
    )

VAR PromedioMensual =
    DIVIDE(
        CALCULATE([Total Ventas], ALL('Calendario')),
        DISTINCTCOUNT(ALLSELECTED('Calendario'[Año-Mes])),
        0
    )

RETURN
    DIVIDE(
        VentasDelMes,
        PromedioMensual,
        0
    )

/*
📝 INTERPRETACIÓN:

1.0 = Mes promedio
1.2 = 20% arriba del promedio (mes fuerte)
0.8 = 20% abajo del promedio (mes débil)

USO: Identificar meses pico (Nov-Dic en retail)
*/
```

---

## 🔥 Funciones Avanzadas de Tiempo

### FIRSTDATE / LASTDATE

```dax
-- Primera venta del período
Primera Fecha Venta =
    FIRSTDATE('Calendario'[Fecha])

-- Última venta del período
Última Fecha Venta =
    LASTDATE('Calendario'[Fecha])

-- Días entre primera y última venta
Días Período =
    DATEDIFF(
        [Primera Fecha Venta],
        [Última Fecha Venta],
        DAY
    )
```

### PREVIOUSMONTH / NEXTMONTH

```dax
-- Ventas del mes anterior (completo)
Ventas Mes Anterior Completo =
    CALCULATE(
        [Total Ventas],
        PREVIOUSMONTH('Calendario'[Fecha])
    )

-- Ventas del próximo mes
Ventas Próximo Mes =
    CALCULATE(
        [Total Ventas],
        NEXTMONTH('Calendario'[Fecha])
    )

/*
📝 DIFERENCIA vs PARALLELPERIOD:

PREVIOUSMONTH:
- Retorna TODO el mes anterior completo

PARALLELPERIOD(-1, MONTH):
- Retorna el mismo rango del mes anterior
- Si hoy es 15 marzo, retorna 1-15 febrero
*/
```

### DATESYTD - Fechas YTD

```dax
-- Ventas YTD (forma manual)
Ventas YTD Manual =
    CALCULATE(
        [Total Ventas],
        DATESYTD('Calendario'[Fecha])
    )

-- Con año fiscal diferente (ej: inicia en Julio)
Ventas YTD Fiscal =
    CALCULATE(
        [Total Ventas],
        DATESYTD('Calendario'[Fecha], "06-30")  -- Año fiscal termina 30 junio
    )

/*
📝 AÑO FISCAL:

Si tu año fiscal NO es Enero-Diciembre:
DATESYTD(..., "MM-DD") donde MM-DD es el último día del año fiscal
*/
```

---

## 💡 Tips y Mejores Prácticas

### ✅ DO (Hacer)

1. **Siempre usa tabla de calendario dedicada**
   ```dax
   ✅ Tabla Calendario separada con todas las columnas
   ❌ Usar directamente 'Ventas'[Fecha]
   ```

2. **Marca tu tabla como Date Table**
   ```
   Table Tools → Mark as Date Table
   ```

3. **Usa funciones nativas cuando sea posible**
   ```dax
   ✅ TOTALYTD(...)            -- Más rápido
   ❌ CALCULATE con FILTER    -- Manual, más lento
   ```

4. **Maneja años fiscales correctamente**
   ```dax
   ✅ DATESYTD(..., "MM-DD")
   ```

### ❌ DON'T (No Hacer)

1. **No uses Time Intelligence sin tabla calendario**
   ```dax
   ❌ Las funciones NO funcionarán correctamente
   ```

2. **No calcules fechas manualmente si hay función nativa**
   ```dax
   ❌ FILTER con fechas manuales
   ✅ SAMEPERIODLASTYEAR
   ```

3. **No olvides la relación Ventas ↔ Calendario**
   ```dax
   ❌ Sin relación = resultados incorrectos
   ```

---

## 🎯 Ejercicios Prácticos

1. **Acumulados**: Crea Ventas YTD, MTD, QTD
2. **Comparaciones**: Ventas vs mes anterior, vs año anterior
3. **Crecimientos**: % crecimiento MoM y YoY
4. **Tendencias**: Promedio móvil 7 días y 30 días
5. **Estacionalidad**: Índice de estacionalidad por mes
6. **Proyecciones**: Proyección de ventas fin de año

**💡 Soluciones en:** `/soluciones/soluciones_modulo4.md`

---

## 🎓 Resumen

✅ Tabla de calendario con columnas enriquecidas
✅ TOTALYTD, MTD, QTD para acumulados
✅ SAMEPERIODLASTYEAR para comparaciones YoY
✅ PARALLELPERIOD y DATEADD para períodos anteriores
✅ DATESBETWEEN y DATESINPERIOD para rangos
✅ Análisis de tendencias y estacionalidad

### Próximo Módulo:
📚 **Módulo 5: KPIs Avanzados para Retail**

---

**[⬅️ Módulo 3](03_calculate_filtros.md) | [➡️ Módulo 5](05_kpis_avanzados.md)**

*Módulo 4 de 6*
