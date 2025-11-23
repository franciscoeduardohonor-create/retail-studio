# ⚡ Guía Rápida - Power BI

## 🚀 Referencia Rápida de Código

Esta guía es tu cheatsheet para consultar rápidamente las funciones más comunes.

---

## 📊 Power Query M - Funciones Esenciales

### Transformaciones de Tabla

```m
// Promover encabezados
Table.PromoteHeaders(tabla)

// Cambiar tipos de datos
Table.TransformColumnTypes(tabla, {{"Columna", type text}})

// Filtrar filas
Table.SelectRows(tabla, each [Columna] > 100)

// Agregar columna
Table.AddColumn(tabla, "NuevaCol", each [Col1] + [Col2])

// Eliminar columnas
Table.RemoveColumns(tabla, {"Col1", "Col2"})

// Renombrar columnas
Table.RenameColumns(tabla, {{"Viejo", "Nuevo"}})

// Ordenar
Table.Sort(tabla, {{"Columna", Order.Descending}})

// Combinar tablas (merge)
Table.NestedJoin(tabla1, {"ID"}, tabla2, {"ID"}, "NombreCol", JoinKind.Inner)

// Anexar tablas
Table.Combine({tabla1, tabla2, tabla3})

// Unpivot
Table.UnpivotOtherColumns(tabla, {"ColFija"}, "Atributo", "Valor")
```

### Funciones de Texto

```m
Text.Trim(texto)                    // Eliminar espacios
Text.Upper(texto)                   // Mayúsculas
Text.Lower(texto)                   // Minúsculas
Text.Proper(texto)                  // Primera letra mayúscula
Text.Length(texto)                  // Longitud
Text.Start(texto, 5)                // Primeros 5 caracteres
Text.End(texto, 3)                  // Últimos 3 caracteres
Text.Replace(texto, "viejo", "nuevo") // Reemplazar
texto1 & texto2                     // Concatenar
```

### Funciones de Números

```m
Number.Round(numero, 2)             // Redondear a 2 decimales
Number.RoundUp(numero)              // Redondear arriba
Number.RoundDown(numero)            // Redondear abajo
Number.Abs(numero)                  // Valor absoluto
Number.Mod(numero, 2)               // Módulo
Number.ToText(numero, "N2")         // Convertir a texto con formato
```

### Funciones de Fechas

```m
Date.Year(fecha)                    // Año
Date.Month(fecha)                   // Mes (número)
Date.MonthName(fecha)               // Nombre del mes
Date.Day(fecha)                     // Día
Date.QuarterOfYear(fecha)           // Trimestre
Date.DayOfWeek(fecha, Day.Monday)   // Día de la semana
Date.DayOfWeekName(fecha)           // Nombre del día
Date.StartOfMonth(fecha)            // Inicio del mes
Date.EndOfMonth(fecha)              // Fin del mes
Date.AddDays(fecha, 7)              // Agregar días
DATEDIFF(fecha1, fecha2, DAY)       // Diferencia en días
```

### Manejo de Errores

```m
try ... otherwise ...

// Ejemplo
try Number.From(valor) otherwise 0
```

---

## 📈 DAX - Funciones Esenciales

### Agregaciones Básicas

```dax
SUM(Tabla[Columna])                 // Suma
AVERAGE(Tabla[Columna])             // Promedio
MIN(Tabla[Columna])                 // Mínimo
MAX(Tabla[Columna])                 // Máximo
COUNT(Tabla[Columna])               // Contar números
COUNTA(Tabla[Columna])              // Contar no vacíos
COUNTROWS(Tabla)                    // Contar filas
DISTINCTCOUNT(Tabla[Columna])       // Contar únicos
```

### Funciones X (Iteradoras)

```dax
SUMX(Tabla, expresión)              // Suma iterativa
AVERAGEX(Tabla, expresión)          // Promedio iterativo
COUNTX(Tabla, expresión)            // Conteo iterativo
MINX(Tabla, expresión)              // Mínimo iterativo
MAXX(Tabla, expresión)              // Máximo iterativo

// Ejemplo
SUMX(Ventas, [Cantidad] * [Precio])
```

### CALCULATE

```dax
// Sintaxis básica
CALCULATE(
    expresión,
    filtro1,
    filtro2
)

// Ejemplos
CALCULATE([Total Ventas], Productos[Categoria] = "Laptops")
CALCULATE([Total Ventas], ALL(Productos))
CALCULATE([Total Ventas], REMOVEFILTERS(Productos[Categoria]))
```

### Time Intelligence

```dax
// Year-to-Date
TOTALYTD([Medida], Calendario[Fecha])

// Month-to-Date
TOTALMTD([Medida], Calendario[Fecha])

// Quarter-to-Date
TOTALQTD([Medida], Calendario[Fecha])

// Periodo anterior
DATEADD(Calendario[Fecha], -1, MONTH)     // Mes anterior
DATEADD(Calendario[Fecha], -1, YEAR)      // Año anterior

// Mismo periodo año anterior
SAMEPERIODLASTYEAR(Calendario[Fecha])

// Rango de fechas
DATESINPERIOD(
    Calendario[Fecha],
    MAX(Calendario[Fecha]),
    -3,
    MONTH
)
```

### Filtros

```dax
// FILTER
FILTER(Tabla, condición)

// Ejemplo
FILTER(Productos, Productos[Precio] > 1000)

// ALL (remover filtros)
ALL(Tabla)
ALL(Tabla[Columna])

// ALLSELECTED (respeta slicers)
ALLSELECTED(Tabla)

// VALUES (valores en contexto actual)
VALUES(Tabla[Columna])

// DISTINCT (valores únicos)
DISTINCT(Tabla[Columna])
```

### Lógica

```dax
IF(condición, verdadero, falso)

SWITCH(
    expresión,
    valor1, resultado1,
    valor2, resultado2,
    resultado_default
)

// SWITCH con TRUE()
SWITCH(
    TRUE(),
    condición1, resultado1,
    condición2, resultado2,
    resultado_default
)
```

### Texto

```dax
CONCATENATE(texto1, texto2)         // Unir textos
texto1 & texto2                     // Operador de concatenación
LEFT(texto, num)                    // Primeros caracteres
RIGHT(texto, num)                   // Últimos caracteres
LEN(texto)                          // Longitud
UPPER(texto)                        // Mayúsculas
LOWER(texto)                        // Minúsculas
TRIM(texto)                         // Eliminar espacios
FORMAT(valor, "formato")            // Formatear
```

### Relaciones

```dax
RELATED(Tabla[Columna])             // Lado "uno" de la relación
RELATEDTABLE(Tabla)                 // Lado "muchos" de la relación
USERELATIONSHIP(col1, col2)         // Activar relación inactiva
```

### Variables

```dax
VAR nombre = expresión
VAR nombre2 = expresión2
RETURN
    resultado

// Ejemplo completo
Margen % =
VAR Ventas = [Total Ventas]
VAR Costos = [Total Costos]
VAR Utilidad = Ventas - Costos
VAR Margen = DIVIDE(Utilidad, Ventas, 0)
RETURN
    Margen * 100
```

### Otras Funciones Útiles

```dax
DIVIDE(numerador, denominador, alternativo)    // División segura
ISBLANK(valor)                                 // Verifica si está vacío
BLANK()                                        // Valor en blanco
SELECTEDVALUE(Tabla[Columna])                  // Valor seleccionado único
HASONEVALUE(Tabla[Columna])                    // ¿Solo un valor?
```

---

## 🎯 Patrones Comunes

### Ranking

```dax
Ranking =
VAR ValorActual = [Medida]
RETURN
    COUNTROWS(
        FILTER(
            ALL(Tabla[Columna]),
            [Medida] > ValorActual
        )
    ) + 1
```

### Top N

```dax
Ventas Top 10 =
CALCULATE(
    [Total Ventas],
    TOPN(
        10,
        ALL(Productos),
        [Total Ventas],
        DESC
    )
)
```

### % del Total

```dax
% del Total =
DIVIDE(
    [Medida],
    CALCULATE([Medida], ALL(Dimension)),
    0
) * 100
```

### Crecimiento %

```dax
% Crecimiento =
VAR Actual = [Medida Actual]
VAR Anterior = [Medida Anterior]
VAR Diferencia = Actual - Anterior
RETURN
    DIVIDE(Diferencia, Anterior, 0) * 100
```

### Acumulado

```dax
Acumulado =
CALCULATE(
    [Medida],
    FILTER(
        ALL(Calendario[Fecha]),
        Calendario[Fecha] <= MAX(Calendario[Fecha])
    )
)
```

### Primer/Último Valor

```dax
Primera Fecha = MIN(Tabla[Fecha])
Última Fecha = MAX(Tabla[Fecha])

Primera Venta =
CALCULATE(
    [Total Ventas],
    Tabla[Fecha] = [Primera Fecha]
)
```

---

## 🔧 Tipos de Datos

### Power Query M

| Tipo | Sintaxis |
|------|----------|
| Texto | `type text` |
| Número entero | `Int64.Type` |
| Número decimal | `type number` |
| Fecha | `type date` |
| Fecha/Hora | `type datetime` |
| Booleano | `type logical` |

### DAX

Los tipos se infieren automáticamente, pero puedes especificar en columnas calculadas.

---

## 💡 Tips y Buenas Prácticas

### Power Query

1. **Nombra tus pasos descriptivamente**
2. **Documenta con comentarios**
3. **Usa funciones personalizadas para código reutilizable**
4. **Maneja errores con try...otherwise**
5. **Filtra datos temprano para mejor rendimiento**

### DAX

1. **Usa variables para claridad y rendimiento**
2. **Prefiere medidas sobre columnas calculadas**
3. **Usa DIVIDE en lugar de /**
4. **Evita FILTER cuando puedas usar filtros directos**
5. **Organiza medidas en tablas separadas**
6. **Comenta fórmulas complejas**

---

## ⌨️ Atajos de Teclado en Power BI Desktop

| Atajo | Acción |
|-------|--------|
| `Ctrl + S` | Guardar |
| `Ctrl + O` | Abrir |
| `Ctrl + N` | Nuevo |
| `F5` | Refrescar datos |
| `Ctrl + M` | Abrir Power Query |
| `Alt + F12` | Editor DAX (medidas) |
| `Ctrl + Shift + C` | Copiar formato |
| `Ctrl + Shift + V` | Pegar formato |
| `Ctrl + [` | Enviar al fondo |
| `Ctrl + ]` | Traer al frente |

---

## 📚 Recursos de Referencia

- **DAX Guide**: https://dax.guide/
- **M Language Reference**: https://docs.microsoft.com/powerquery-m/
- **Power BI Docs**: https://docs.microsoft.com/power-bi/
- **SQLBI**: https://www.sqlbi.com/

---

**¡Guarda esta guía para consulta rápida!** 📌

Imprime o mantén abierta mientras trabajas en Power BI.
