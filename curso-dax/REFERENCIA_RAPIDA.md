# 📖 Guía Rápida de Referencia DAX

## 🎯 Cheat Sheet Completo

---

## 📊 Funciones de Agregación

| Función | Descripción | Ejemplo |
|---------|-------------|---------|
| `SUM` | Suma valores | `SUM('Ventas'[Monto])` |
| `AVERAGE` | Promedio | `AVERAGE('Ventas'[Monto])` |
| `MIN` | Valor mínimo | `MIN('Ventas'[Fecha])` |
| `MAX` | Valor máximo | `MAX('Ventas'[Fecha])` |
| `COUNT` | Cuenta no vacíos | `COUNT('Ventas'[Monto])` |
| `COUNTROWS` | Cuenta filas | `COUNTROWS('Ventas')` |
| `DISTINCTCOUNT` | Cuenta únicos | `DISTINCTCOUNT('Ventas'[ProductoID])` |
| `DIVIDE` | División segura | `DIVIDE([A], [B], 0)` |

---

## 🔄 Funciones Iteradoras (X)

| Función | Descripción | Ejemplo |
|---------|-------------|---------|
| `SUMX` | Suma iterando | `SUMX('Ventas', [Cant] * [Precio])` |
| `AVERAGEX` | Promedio iterando | `AVERAGEX('Ventas', [Calc])` |
| `COUNTX` | Cuenta iterando | `COUNTX('Tabla', [Expr])` |
| `MINX` | Mínimo iterando | `MINX('Tabla', [Expr])` |
| `MAXX` | Máximo iterando | `MAXX('Tabla', [Expr])` |

### ⚠️ Cuándo Usar X

```dax
✅ SUMX cuando necesitas calcular por fila:
   SUMX('Ventas', [Cantidad] * [Precio])

❌ SUMX innecesario:
   SUMX('Ventas', 'Ventas'[Monto]) → Usa SUM
```

---

## 🎯 CALCULATE (La Más Importante)

```dax
CALCULATE(
    <expresión>,
    <filtro1>,
    <filtro2>,
    ...
)
```

### Ejemplos

```dax
-- Filtro simple
CALCULATE([Total Ventas], 'Productos'[Categoria] = "Smartphones")

-- Múltiples filtros (AND)
CALCULATE([Ventas], [Region] = "Norte", [Año] = 2024)

-- Filtro OR
CALCULATE([Ventas], [Region] IN {"Norte", "Sur"})

-- Remover filtros
CALCULATE([Ventas], ALL('Ventas'))

-- Remover filtro específico
CALCULATE([Ventas], ALL('Tiendas'[Region]))
```

---

## 🔍 Funciones de Filtro

| Función | Descripción | Ejemplo |
|---------|-------------|---------|
| `ALL` | Quita todos los filtros | `ALL('Ventas')` |
| `ALLEXCEPT` | Quita todos EXCEPTO | `ALLEXCEPT('Ventas', 'Ventas'[Año])` |
| `FILTER` | Filtra tabla | `FILTER('Ventas', [Monto] > 1000)` |
| `KEEPFILTERS` | Preserva filtros externos | `KEEPFILTERS([Región] = "Norte")` |
| `VALUES` | Valores únicos (respeta filtros) | `VALUES('Productos'[Marca])` |
| `DISTINCT` | Valores únicos (sin blancos) | `DISTINCT('Productos'[Marca])` |

---

## 📅 Time Intelligence

### Crear Calendario

```dax
Calendario = CALENDAR(DATE(2023,1,1), DATE(2025,12,31))
-- O
Calendario = CALENDARAUTO()
```

### Funciones Temporales

| Función | Descripción | Ejemplo |
|---------|-------------|---------|
| `TOTALYTD` | Total año hasta la fecha | `TOTALYTD([Ventas], 'Cal'[Fecha])` |
| `TOTALMTD` | Total mes hasta la fecha | `TOTALMTD([Ventas], 'Cal'[Fecha])` |
| `TOTALQTD` | Total trimestre hasta la fecha | `TOTALQTD([Ventas], 'Cal'[Fecha])` |
| `SAMEPERIODLASTYEAR` | Mismo período año anterior | `SAMEPERIODLASTYEAR('Cal'[Fecha])` |
| `PARALLELPERIOD` | Período paralelo | `PARALLELPERIOD('Cal'[Fecha], -1, MONTH)` |
| `DATEADD` | Sumar/restar períodos | `DATEADD('Cal'[Fecha], -7, DAY)` |
| `DATESYTD` | Fechas YTD | `DATESYTD('Cal'[Fecha])` |
| `DATESBETWEEN` | Rango de fechas | `DATESBETWEEN('Cal'[Fecha], [Inicio], [Fin])` |

### Patrón YoY (Year over Year)

```dax
Ventas AA = CALCULATE([Ventas], SAMEPERIODLASTYEAR('Cal'[Fecha]))
Var YoY = [Ventas] - [Ventas AA]
% YoY = DIVIDE([Var YoY], [Ventas AA], 0) * 100
```

---

## 🔗 Relaciones

| Función | Descripción | Dirección |
|---------|-------------|-----------|
| `RELATED` | Trae valor de tabla relacionada | MUCHOS → UNO |
| `RELATEDTABLE` | Trae tabla relacionada | UNO → MUCHOS |
| `USERELATIONSHIP` | Activa relación inactiva | En CALCULATE |

```dax
-- RELATED (en tabla Ventas)
Precio = RELATED('Productos'[PrecioLista])

-- RELATEDTABLE (en tabla Productos)
Unidades = SUMX(RELATEDTABLE('Ventas'), 'Ventas'[Cantidad])

-- USERELATIONSHIP
Ventas Fecha Envío =
    CALCULATE(
        [Ventas],
        USERELATIONSHIP('Ventas'[FechaEnvio], 'Cal'[Fecha])
    )
```

---

## 📊 Funciones de Tabla

| Función | Descripción | Ejemplo |
|---------|-------------|---------|
| `CALCULATETABLE` | CALCULATE para tablas | `CALCULATETABLE('Ventas', [Filtro])` |
| `SUMMARIZE` | Agrupa y resume | `SUMMARIZE('Ventas', [Col], "Total", [Expr])` |
| `ADDCOLUMNS` | Agrega columnas | `ADDCOLUMNS('Tabla', "Nueva", [Expr])` |
| `SELECTCOLUMNS` | Selecciona columnas | `SELECTCOLUMNS('Tabla', "Nom", [Col])` |
| `TOPN` | Top N filas | `TOPN(10, 'Tabla', [Medida], DESC)` |

---

## 🏆 Ranking y Ordenamiento

```dax
-- RANKX
Ranking =
    RANKX(
        ALL('Productos'),    -- Tabla completa
        [Total Ventas],      -- Criterio
        ,                    -- Valor (opcional)
        DESC,                -- Orden
        DENSE                -- Tipo: DENSE o SKIP
    )

-- TOPN
Top 10 =
    CALCULATE(
        [Ventas],
        TOPN(10, ALL('Productos'), [Ventas], DESC)
    )
```

---

## 🧮 Funciones Lógicas

| Función | Descripción | Ejemplo |
|---------|-------------|---------|
| `IF` | Condición | `IF([Ventas] > 1000, "Alto", "Bajo")` |
| `SWITCH` | Múltiples condiciones | `SWITCH([Valor], 1, "A", 2, "B", "Otro")` |
| `AND` / `&&` | Y lógico | `[A] > 0 && [B] > 0` |
| `OR` / `||` | O lógico | `[A] = 1 || [B] = 1` |
| `NOT` | Negación | `NOT([A] = 0)` |
| `IN` | En lista | `[Región] IN {"Norte", "Sur"}` |

---

## 📝 Variables

```dax
Medida =
VAR Variable1 = <expresión>
VAR Variable2 = <expresión>

RETURN
    <expresión usando variables>
```

### Ejemplo

```dax
Margen % =
VAR Ingresos = SUM('Ventas'[Monto])
VAR Costos = SUM('Ventas'[Costo])
VAR Margen = Ingresos - Costos

RETURN
    DIVIDE(Margen, Ingresos, 0) * 100
```

---

## 🔍 Funciones de Información

| Función | Descripción | Ejemplo |
|---------|-------------|---------|
| `ISBLANK` | ¿Es vacío? | `IF(ISBLANK([Valor]), 0, [Valor])` |
| `ISFILTERED` | ¿Hay filtro activo? | `ISFILTERED('Productos'[Marca])` |
| `HASONEVALUE` | ¿Hay un solo valor? | `HASONEVALUE('Productos'[ID])` |
| `SELECTEDVALUE` | Valor seleccionado | `SELECTEDVALUE('Marca', "Todas")` |
| `COUNTROWS` | Cuenta filas | `COUNTROWS('Ventas')` |

---

## 💰 KPIs Comunes de Retail

```dax
-- VENTAS
Total Ventas = SUM('Ventas'[MontoTotal])

-- TICKET PROMEDIO
Ticket Promedio = DIVIDE([Total Ventas], COUNTROWS('Ventas'), 0)

-- MARKET SHARE
Market Share % =
    DIVIDE([Ventas], CALCULATE([Ventas], ALL('Productos')), 0) * 100

-- SELL-THROUGH
Sell-Through % =
    DIVIDE([Sell-Out], [Sell-In], 0) * 100

-- MARGEN
Margen % =
    DIVIDE([Ventas] - [Costo], [Ventas], 0) * 100

-- CRECIMIENTO YoY
% YoY =
    DIVIDE(
        [Ventas] - [Ventas AA],
        [Ventas AA],
        0
    ) * 100

-- DÍAS INVENTARIO
Días Inventario =
    DIVIDE(
        [Stock],
        [Venta Diaria Promedio],
        0
    )
```

---

## 🎯 Patrones Comunes

### % del Total

```dax
% del Total =
    DIVIDE(
        [Medida],
        CALCULATE([Medida], ALL(Tabla)),
        0
    ) * 100
```

### % dentro de Grupo

```dax
% en Categoría =
    DIVIDE(
        [Ventas],
        CALCULATE([Ventas], ALLEXCEPT('Productos', 'Productos'[Categoria])),
        0
    ) * 100
```

### Promedio Móvil

```dax
MA 7d =
VAR FechaMax = MAX('Cal'[Fecha])
RETURN
    CALCULATE(
        [Ventas],
        DATESBETWEEN('Cal'[Fecha], FechaMax - 7, FechaMax)
    )
```

### Total Acumulado

```dax
Acumulado =
VAR FechaActual = MAX('Cal'[Fecha])
RETURN
    CALCULATE(
        [Ventas],
        FILTER(
            ALL('Cal'[Fecha]),
            'Cal'[Fecha] <= FechaActual
        )
    )
```

---

## ⚡ Tips de Optimización

### ✅ Hacer

```dax
✅ Usa variables para cálculos repetidos
✅ Prefiere SUM sobre SUMX cuando no calculas por fila
✅ Usa DIVIDE en lugar de /
✅ Filtra por columnas en lugar de medidas cuando sea posible
✅ Usa IN en lugar de múltiples OR
```

### ❌ No Hacer

```dax
❌ SUMX cuando SUM es suficiente
❌ FILTER con medidas innecesariamente
❌ División sin DIVIDE
❌ Calcular lo mismo múltiples veces
❌ Nombres de medidas confusos
```

---

## 📐 Formato de Código

```dax
-- Nombre descriptivo en español
Nombre de Medida =
VAR Variable1 = Expresión1    -- Comentario
VAR Variable2 = Expresión2

RETURN
    FUNCIÓN(
        Argumento1,           -- Descripción
        Argumento2,
        0                     -- Default
    )
```

---

## 🔧 Funciones de Texto

| Función | Descripción | Ejemplo |
|---------|-------------|---------|
| `CONCATENATE` / `&` | Concatenar | `"Hola" & " Mundo"` |
| `LEFT` | Primeros N caracteres | `LEFT("Texto", 3)` = "Tex" |
| `RIGHT` | Últimos N caracteres | `RIGHT("Texto", 3)` = "xto" |
| `LEN` | Longitud | `LEN("Hola")` = 4 |
| `UPPER` | Mayúsculas | `UPPER("hola")` = "HOLA" |
| `LOWER` | Minúsculas | `LOWER("HOLA")` = "hola" |
| `FORMAT` | Formatear | `FORMAT([Fecha], "YYYY-MM")` |

---

## 📊 Funciones de Fecha

| Función | Descripción | Ejemplo |
|---------|-------------|---------|
| `DATE` | Crear fecha | `DATE(2024, 12, 31)` |
| `YEAR` | Extraer año | `YEAR([Fecha])` |
| `MONTH` | Extraer mes | `MONTH([Fecha])` |
| `DAY` | Extraer día | `DAY([Fecha])` |
| `WEEKDAY` | Día de semana | `WEEKDAY([Fecha])` |
| `TODAY` | Fecha actual | `TODAY()` |
| `NOW` | Fecha y hora actual | `NOW()` |
| `DATEDIFF` | Diferencia | `DATEDIFF([F1], [F2], DAY)` |

---

## 🎓 Errores Comunes

| Error | Causa | Solución |
|-------|-------|----------|
| División por cero | `[A] / [B]` cuando B=0 | `DIVIDE([A], [B], 0)` |
| Contexto incorrecto | Usar columna en medida | Usar agregación o SUMX |
| RELATED mal usado | Dirección UNO → MUCHOS | RELATED es MUCHOS → UNO |
| Sin tabla calendario | Time Intelligence | Crear y relacionar calendario |
| Referencia circular | Medida A usa B, B usa A | Reestructurar lógica |

---

## 📚 Recursos

- [DAX Guide](https://dax.guide/)
- [SQLBI](https://www.sqlbi.com/)
- [DAX Formatter](https://www.daxformatter.com/)
- [DAX Studio](https://daxstudio.org/)

---

**💡 Tip:** Imprime esta guía y tenla cerca mientras desarrollas en DAX

---

*Guía Rápida de DAX | Curso Completo de DAX | 2025*
