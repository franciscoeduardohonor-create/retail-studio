# 📘 Módulo 2: Agregación y Contexto en DAX

## 🎯 Objetivos del Módulo

Al terminar este módulo podrás:
- ✅ Entender el concepto de **CONTEXTO** (la clave de DAX)
- ✅ Diferenciar entre contexto de fila y contexto de filtro
- ✅ Usar funciones iteradoras (SUMX, AVERAGEX, etc.)
- ✅ Trabajar con relaciones usando RELATED y RELATEDTABLE
- ✅ Crear cálculos complejos que combinan múltiples columnas

---

## 🧠 El Concepto Más Importante: CONTEXTO

> **💡 CONTEXTO es el entorno en el cual se evalúa una fórmula DAX**

DAX siempre evalúa las fórmulas en un **contexto**. Entender esto es la diferencia entre un principiante y un experto en DAX.

### Tipos de Contexto

```
📊 CONTEXTO DE FILTRO           📏 CONTEXTO DE FILA
(Filter Context)                 (Row Context)

- Aplica a MEDIDAS               - Aplica a COLUMNAS CALCULADAS
- Creado por filtros/slicers     - Creado automáticamente al iterar
- Afecta a toda la tabla         - Afecta solo a la fila actual
- Más común y poderoso           - Más limitado
```

---

## 📊 Contexto de Filtro (Filter Context)

### ¿Qué es?

El **contexto de filtro** define qué filas de las tablas se consideran en un cálculo.

### Ejemplo Visual

```
TABLA: Ventas
┌─────────┬──────────┬────────┐
│ Fecha   │ Región   │ Monto  │
├─────────┼──────────┼────────┤
│ 2024-01 │ Norte    │ 1000   │ ←
│ 2024-01 │ Norte    │ 1500   │ ← Contexto: Región = Norte
│ 2024-01 │ Sur      │ 2000   │   (Solo estas filas)
│ 2024-02 │ Norte    │ 1200   │ ←
│ 2024-02 │ Sur      │ 1800   │
└─────────┴──────────┴────────┘

Medida: Total Ventas = SUM('Ventas'[Monto])

SIN FILTROS → 7,500
CON FILTRO (Región = Norte) → 3,700
```

### Ejemplo Práctico 1: Ventas por Región

```dax
-- Esta medida responde al contexto de filtro

Total Ventas =
    SUM('Ventas'[MontoTotal])

/*
📝 CÓMO CAMBIA SEGÚN EL CONTEXTO:

1. Sin filtros:
   → Suma TODAS las ventas = $1,311,445,308

2. Con filtro [Región = "Norte"]:
   → Suma solo ventas del Norte

3. Con filtro [Región = "Norte"] Y [Año = 2024]:
   → Suma solo ventas del Norte en 2024

4. En una tabla con columna [Producto]:
   → Cada fila muestra ventas de ESE producto

EL CONTEXTO LO DEFINE TODO
*/
```

### Ejemplo Práctico 2: Ventas con Múltiples Filtros

```dax
-- Esta medida se comporta diferente según dónde la uses

Ticket Promedio =
    DIVIDE(
        SUM('Ventas'[MontoTotal]),
        COUNTROWS('Ventas'),
        0
    )

/*
📝 EN DIFERENTES VISUALES:

Visual 1: Card (sin filtros)
→ Ticket promedio de TODAS las ventas

Visual 2: Tabla con [Región]
┌──────────┬─────────────────┐
│ Región   │ Ticket Promedio │
├──────────┼─────────────────┤
│ Norte    │ $12,450         │ ← Contexto: Región = Norte
│ Centro   │ $11,890         │ ← Contexto: Región = Centro
│ Sur      │ $10,320         │ ← Contexto: Región = Sur
└──────────┴─────────────────┘

Visual 3: Tabla con [Región] y [Categoría]
→ Cada fila tiene contexto de Región Y Categoría
*/
```

---

## 📏 Contexto de Fila (Row Context)

### ¿Qué es?

El **contexto de fila** significa que DAX está evaluando UNA fila específica a la vez.

### ¿Cuándo se crea?

1. **Columnas Calculadas** (automático)
2. **Funciones iteradoras** como SUMX, FILTER, etc.

### Ejemplo con Columna Calculada

```dax
-- COLUMNA CALCULADA en la tabla Ventas
-- Se evalúa FILA POR FILA

Monto con IVA =
    'Ventas'[MontoTotal] * 1.16

/*
📝 EVALUACIÓN FILA POR FILA:

Fila 1: 1000 * 1.16 = 1160
Fila 2: 1500 * 1.16 = 1740
Fila 3: 2000 * 1.16 = 2320
...

Cada fila se calcula INDEPENDIENTEMENTE
*/
```

### ⚠️ Advertencia Importante

```dax
-- ❌ ESTO NO FUNCIONA EN UNA MEDIDA (sin contexto de fila)
Monto con IVA =
    'Ventas'[MontoTotal] * 1.16

-- ✅ ESTO SÍ FUNCIONA EN UNA MEDIDA (con agregación)
Total con IVA =
    SUM('Ventas'[MontoTotal]) * 1.16
```

**¿Por qué?**
- Las MEDIDAS se evalúan en contexto de FILTRO, no de FILA
- No tienen acceso directo a valores de columnas individuales
- Necesitan funciones de agregación o iteradores

---

## 🔄 Funciones Iteradoras (Iterator Functions)

Las funciones iteradoras **crean un contexto de fila** y evalúan una expresión para cada fila.

### SUMX - Suma con Iteración

```dax
-- Calcula el margen total (precio venta - precio lista)

Margen Total =
    SUMX(
        'Ventas',                                    -- Tabla a iterar
        'Ventas'[PrecioUnitario] -                  -- Expresión a evaluar
        RELATED('Productos'[PrecioLista])            -- por cada fila
    )

/*
📝 PASO A PASO:

1. SUMX itera la tabla 'Ventas' FILA POR FILA
2. Para cada fila:
   - Toma el PrecioUnitario de esa venta
   - Busca el PrecioLista del producto relacionado
   - Calcula la diferencia
3. Suma todos los resultados

Fila 1: 10,500 - 12,000 = -1,500  (con descuento)
Fila 2: 15,000 - 15,000 =      0  (sin descuento)
Fila 3: 8,500  - 10,000 = -1,500  (con descuento)
                          -------
SUMA TOTAL:               -3,000
*/
```

### AVERAGEX - Promedio con Iteración

```dax
-- Calcula el descuento promedio REAL (no el promedio de %)

Descuento Real Promedio =
    AVERAGEX(
        'Ventas',
        DIVIDE(
            RELATED('Productos'[PrecioLista]) - 'Ventas'[PrecioUnitario],
            RELATED('Productos'[PrecioLista]),
            0
        ) * 100
    )

/*
📝 EXPLICACIÓN:

Para cada venta, calcula:
(PrecioLista - PrecioVenta) / PrecioLista * 100

Luego promedia ESOS resultados

Fila 1: (12,000 - 10,500) / 12,000 * 100 = 12.5%
Fila 2: (15,000 - 15,000) / 15,000 * 100 = 0.0%
Fila 3: (10,000 - 8,500)  / 10,000 * 100 = 15.0%
                                           ------
PROMEDIO:                                  9.17%

💡 NOTA: Esto es DIFERENTE a AVERAGE('Ventas'[Descuento])
         que simplemente promedia la columna Descuento
*/
```

### COUNTX - Contar con Condición

```dax
-- Cuenta ventas con descuento mayor al 20%

Ventas Alto Descuento =
    COUNTX(
        FILTER(
            'Ventas',
            'Ventas'[Descuento] > 20
        ),
        'Ventas'[VentaID]
    )

/*
📝 EXPLICACIÓN:

1. FILTER crea una tabla con solo ventas con descuento > 20%
2. COUNTX itera esa tabla filtrada
3. Cuenta las filas

Alternativa más simple (mismo resultado):
*/

Ventas Alto Descuento Alt =
    COUNTROWS(
        FILTER(
            'Ventas',
            'Ventas'[Descuento] > 20
        )
    )
```

### Comparación: Funciones Simples vs Iteradoras

```dax
-- ✅ FUNCIÓN SIMPLE (Más rápida cuando aplica)
Total Ventas Simple =
    SUM('Ventas'[MontoTotal])

-- ✅ FUNCIÓN ITERADORA (Necesaria para cálculos complejos)
Total Ventas Calculado =
    SUMX(
        'Ventas',
        'Ventas'[Cantidad] * 'Ventas'[PrecioUnitario]
    )

/*
📝 CUÁNDO USAR CADA UNA:

FUNCIONES SIMPLES (SUM, AVERAGE, COUNT):
✅ Más rápidas
✅ Usa cuando agregues UNA columna existente
✅ Ejemplo: SUM('Ventas'[MontoTotal])

FUNCIONES ITERADORAS (SUMX, AVERAGEX, COUNTX):
✅ Necesarias para cálculos por fila
✅ Cuando necesitas RELATED, DIVIDE, operaciones complejas
✅ Ejemplo: SUMX('Ventas', [Cantidad] * [Precio])

⚡ REGLA: Usa simple si puedes, iterador si debes
*/
```

---

## 🔗 Trabajando con Relaciones

### RELATED - Traer Valores de Tabla Relacionada

```dax
-- RELATED trae un valor de la tabla del lado "UNO"

Precio Lista Producto =
    RELATED('Productos'[PrecioLista])

/*
📝 CÓMO FUNCIONA:

Modelo de Datos:
Ventas (MUCHOS) → Productos (UNO)
   └─ ProductoID

RELATED sigue la relación desde Ventas hacia Productos
para traer el PrecioLista del producto de esa venta

⚠️ IMPORTANTE:
- Solo funciona en contexto de FILA
- Sigue la dirección MUCHOS → UNO
- Se usa en columnas calculadas o dentro de iteradores
*/
```

### Ejemplo Práctico con RELATED

```dax
-- Calcula el margen por venta

Margen por Venta =
    SUMX(
        'Ventas',
        (
            'Ventas'[PrecioUnitario] -
            RELATED('Productos'[PrecioLista]) * 0.60    -- Asumimos costo = 60% del precio lista
        ) * 'Ventas'[Cantidad]
    )

/*
📝 EXPLICACIÓN DETALLADA:

Para cada venta:
1. Toma el PrecioUnitario de la venta actual
2. Usa RELATED para buscar el PrecioLista del producto
3. Calcula el costo estimado (60% del precio lista)
4. Calcula el margen: (PrecioVenta - Costo) * Cantidad
5. Suma todos los márgenes

Ejemplo con datos:
- PrecioUnitario: $10,500
- PrecioLista (RELATED): $12,000
- Costo estimado: $7,200
- Cantidad: 2
- Margen: (10,500 - 7,200) * 2 = $6,600
*/
```

### RELATEDTABLE - Traer Tabla Relacionada

```dax
-- Cuenta cuántos productos diferentes vendió cada tienda

Productos por Tienda =
    COUNTROWS(
        DISTINCT(
            RELATEDTABLE('Ventas')
        )
    )

/*
📝 CÓMO FUNCIONA:

Si estás en contexto de Tiendas:
RELATEDTABLE('Ventas') retorna TODAS las ventas de esa tienda

⚠️ NOTA:
- RELATEDTABLE va en dirección UNO → MUCHOS
- Retorna una TABLA, no un valor
- Menos común que RELATED
*/
```

---

## 💰 Ejemplos Prácticos Completos para Retail

### Ejemplo 1: Análisis de Margen

```dax
-- 💵 PRECIO PROMEDIO DE LISTA
Precio Lista Promedio =
    AVERAGE('Productos'[PrecioLista])

-- 💰 PRECIO PROMEDIO DE VENTA
Precio Venta Promedio =
    DIVIDE(
        SUM('Ventas'[MontoTotal]),
        SUM('Ventas'[Cantidad]),
        0
    )

-- 💸 DESCUENTO REAL EN PESOS
Descuento en Pesos =
    SUMX(
        'Ventas',
        (
            RELATED('Productos'[PrecioLista]) -
            'Ventas'[PrecioUnitario]
        ) * 'Ventas'[Cantidad]
    )

-- 📊 PORCENTAJE DE DESCUENTO REAL
% Descuento Real =
    DIVIDE(
        [Descuento en Pesos],
        SUMX(
            'Ventas',
            RELATED('Productos'[PrecioLista]) * 'Ventas'[Cantidad]
        ),
        0
    ) * 100

/*
📝 USO:
Estos 4 KPIs juntos te dan una visión completa
del comportamiento de precios y descuentos
*/
```

### Ejemplo 2: Análisis de Categorías

```dax
-- 📱 VENTAS POR CATEGORÍA
Ventas por Categoria =
    CALCULATE(
        SUM('Ventas'[MontoTotal]),
        USERELATIONSHIP('Ventas'[ProductoID], 'Productos'[ProductoID])
    )

-- 🏆 CATEGORÍA MÁS VENDIDA
Top Categoria =
    CALCULATE(
        FIRSTNONBLANK('Productos'[Categoria], 1),
        TOPN(
            1,
            ALL('Productos'[Categoria]),
            [Total Ventas],
            DESC
        )
    )

/*
📝 NOTA:
Estas medidas usan funciones avanzadas que veremos
en el Módulo 3 (CALCULATE) y Módulo 5 (TOPN)
*/
```

### Ejemplo 3: Métricas de Eficiencia de Tiendas

```dax
-- 🏪 VENTA PROMEDIO POR TIENDA
Venta Promedio por Tienda =
    AVERAGEX(
        VALUES('Tiendas'[TiendaID]),
        [Total Ventas]
    )

/*
📝 EXPLICACIÓN:

1. VALUES('Tiendas'[TiendaID]) crea una lista única de tiendas
2. Para cada tienda, calcula [Total Ventas]
3. Promedia esos resultados

💡 DIFERENCIA con AVERAGE:
AVERAGE promedia valores de una columna
AVERAGEX promedia el resultado de una expresión iterada
*/

-- 📊 VENTAS POR METRO CUADRADO (asumiendo columna de m²)
Ventas por m² =
    SUMX(
        VALUES('Tiendas'[TiendaID]),
        DIVIDE(
            [Total Ventas],
            MAX('Tiendas'[MetrosCuadrados]),
            0
        )
    )

-- 🎯 PRODUCTIVIDAD POR EMPLEADO
Ventas por Empleado =
    DIVIDE(
        [Total Ventas],
        SUM('Tiendas'[NumeroEmpleados]),
        0
    )
```

---

## 🎨 Patrón Común: Cálculos Ponderados

### Problema: Promedios Simples vs Ponderados

```dax
-- ❌ PROMEDIO SIMPLE (Incorrecto para algunos casos)
Descuento Promedio Simple =
    AVERAGE('Ventas'[Descuento])

/*
Problema:
Una venta de $100 con 50% descuento tiene
el mismo peso que una venta de $10,000 con 5% descuento
*/

-- ✅ PROMEDIO PONDERADO (Correcto)
Descuento Promedio Ponderado =
    DIVIDE(
        SUMX(
            'Ventas',
            'Ventas'[MontoTotal] * 'Ventas'[Descuento] / 100
        ),
        SUM('Ventas'[MontoTotal]),
        0
    ) * 100

/*
📝 EXPLICACIÓN:

Numerador:
- Para cada venta: MontoTotal * (Descuento/100)
- Suma todo = Monto total descontado

Denominador:
- Suma de todos los montos

Resultado:
- % de descuento ponderado por monto de venta

Ejemplo:
Venta 1: $10,000 con 10% desc = $1,000 desc
Venta 2: $100 con 50% desc = $50 desc
         ------              ------
Total:   $10,100             $1,050

Descuento ponderado: 1,050 / 10,100 = 10.4%
Descuento simple: (10% + 50%) / 2 = 30% ← INCORRECTO
*/
```

---

## 🧩 Combinando Contextos

### Ejemplo Avanzado: Ventas vs Potencial

```dax
-- Calcula el % de penetración de producto en tienda

% Penetración =
VAR VentasActuales =
    COUNTROWS('Ventas')

VAR ProductosDisponibles =
    COUNTROWS('Productos')

VAR TiendasActivas =
    DISTINCTCOUNT('Ventas'[TiendaID])

VAR VentasPotenciales =
    ProductosDisponibles * TiendasActivas

RETURN
    DIVIDE(
        VentasActuales,
        VentasPotenciales,
        0
    ) * 100

/*
📝 VARIABLES (VAR):

✅ Hacen el código más legible
✅ Mejoran el rendimiento (se calculan una sola vez)
✅ Facilitan el debugging
✅ Se introducen formalmente en Módulo 6

Estructura:
VAR NombreVariable = Expresión
RETURN Resultado
*/
```

---

## 💡 Tips y Mejores Prácticas

### ✅ DO (Hacer)

1. **Usa SUMX solo cuando sea necesario**
   ```dax
   ✅ SUM('Ventas'[Monto])                    -- Más rápido
   ❌ SUMX('Ventas', 'Ventas'[Monto])        -- Innecesario
   ✅ SUMX('Ventas', [Cant] * [Precio])      -- Necesario
   ```

2. **Usa RELATED en lugar de LOOKUPVALUE cuando puedas**
   ```dax
   ✅ RELATED('Productos'[Precio])            -- Más rápido
   ❌ LOOKUPVALUE(...)                        -- Más lento
   ```

3. **Entiende el contexto antes de escribir la fórmula**
   - ¿Es una medida o columna calculada?
   - ¿Qué filtros estarán activos?
   - ¿Necesito iterar?

### ❌ DON'T (No Hacer)

1. **No uses iteradores innecesariamente**
   ```dax
   ❌ SUMX('Ventas', 'Ventas'[Monto])
   ✅ SUM('Ventas'[Monto])
   ```

2. **No olvides manejar divisiones por cero**
   ```dax
   ❌ [Total] / [Cantidad]
   ✅ DIVIDE([Total], [Cantidad], 0)
   ```

3. **No uses RELATED fuera de contexto de fila**
   ```dax
   ❌ Total = SUM(RELATED('Productos'[Precio]))
   ✅ Total = SUMX('Ventas', RELATED('Productos'[Precio]))
   ```

---

## 🎯 Ejercicios Prácticos

### Ejercicio 1: Funciones Iteradoras
Crea las siguientes medidas usando SUMX o AVERAGEX:
1. Monto total calculado (Cantidad × PrecioUnitario)
2. Descuento total en pesos
3. Precio promedio ponderado por cantidad

### Ejercicio 2: Uso de RELATED
Crea medidas que:
1. Calculen la diferencia entre precio de venta y precio de lista
2. Muestren el % de ventas de productos de marca "SAMSUNG"
3. Calculen el margen asumiendo costo = 65% del precio lista

### Ejercicio 3: Promedios Ponderados
Crea:
1. Descuento promedio ponderado por monto de venta
2. Precio promedio ponderado por cantidad vendida
3. Ticket promedio por tienda (usando AVERAGEX)

**💡 TIP:** Las soluciones están en `/soluciones/soluciones_modulo2.md`

---

## 📊 Caso Práctico: Dashboard de Márgenes

### Objetivo
Crear un análisis completo de márgenes y rentabilidad

### KPIs a Implementar

```dax
-- 1. 💰 INGRESOS BRUTOS (sin descuentos)
Ingresos Brutos =
    SUMX(
        'Ventas',
        'Ventas'[Cantidad] * RELATED('Productos'[PrecioLista])
    )

-- 2. 💸 DESCUENTOS OTORGADOS
Total Descuentos =
    [Ingresos Brutos] - [Total Ventas]

-- 3. 📊 % DESCUENTO EFECTIVO
% Descuento Efectivo =
    DIVIDE(
        [Total Descuentos],
        [Ingresos Brutos],
        0
    ) * 100

-- 4. 💼 COSTO DE VENTAS (asumiendo 65% del precio lista)
Costo de Ventas =
    SUMX(
        'Ventas',
        'Ventas'[Cantidad] * RELATED('Productos'[PrecioLista]) * 0.65
    )

-- 5. 💚 MARGEN BRUTO
Margen Bruto =
    [Total Ventas] - [Costo de Ventas]

-- 6. 📈 % MARGEN
% Margen =
    DIVIDE(
        [Margen Bruto],
        [Total Ventas],
        0
    ) * 100
```

---

## 🎓 Resumen del Módulo

### Has Aprendido:
✅ El concepto de CONTEXTO (filtro y fila)
✅ Diferencias entre contexto de filtro y fila
✅ Funciones iteradoras: SUMX, AVERAGEX, COUNTX
✅ Uso de RELATED para traer datos relacionados
✅ Cálculos ponderados vs promedios simples
✅ Variables (VAR) para código más limpio
✅ Cuándo usar funciones simples vs iteradoras

### Conceptos Clave:
🔑 **Contexto de Filtro**: Define QUÉ filas se consideran
🔑 **Contexto de Fila**: Evalúa una fila a la vez
🔑 **SUMX**: Itera y suma resultados de una expresión
🔑 **RELATED**: Trae valores de tabla relacionada (MUCHOS → UNO)

### Próximo Módulo:
📚 **Módulo 3: CALCULATE y Filtros**
- La función más poderosa de DAX: CALCULATE
- Modificar el contexto de filtro
- Funciones ALL, ALLEXCEPT, FILTER
- Cálculos complejos con múltiples filtros

---

## 🔗 Referencias Útiles

- [DAX Context](https://www.sqlbi.com/articles/understanding-context-in-dax/)
- [Iterator Functions](https://www.sqlbi.com/articles/iterator-functions-in-dax/)
- [Row Context and Filter Context](https://docs.microsoft.com/en-us/dax/context-in-dax-formulas)

---

**🎉 ¡Excelente trabajo completando el Módulo 2!**

Ahora entiendes cómo DAX evalúa las fórmulas en diferentes contextos, lo que te da superpoderes para crear medidas avanzadas.

**[⬅️ Volver al Módulo 1](01_fundamentos_dax.md) | [➡️ Ir al Módulo 3: CALCULATE y Filtros](03_calculate_filtros.md)**

---

*Curso de DAX | Módulo 2 de 6 | Última actualización: 2025*
