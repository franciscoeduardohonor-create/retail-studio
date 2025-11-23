# 📘 Módulo 3: CALCULATE y Filtros

## 🎯 Objetivos del Módulo

Al terminar este módulo podrás:
- ✅ Dominar CALCULATE, la función más poderosa de DAX
- ✅ Modificar el contexto de filtro dinámicamente
- ✅ Usar ALL, ALLEXCEPT, FILTER para manipular filtros
- ✅ Crear medidas con filtros personalizados
- ✅ Entender la propagación de filtros en relaciones

---

## ⭐ CALCULATE: La Función Más Importante

> **💡 CALCULATE es la función más poderosa y usada en DAX**

### Sintaxis Básica

```dax
CALCULATE(
    <expresión>,          -- La medida o expresión a calcular
    <filtro1>,            -- Filtro opcional 1
    <filtro2>,            -- Filtro opcional 2
    ...                   -- Más filtros
)
```

### ¿Qué Hace CALCULATE?

**CALCULATE modifica el contexto de filtro** antes de evaluar una expresión.

```dax
-- Sin CALCULATE
Total Ventas = SUM('Ventas'[MontoTotal])
→ Respeta los filtros activos

-- Con CALCULATE
Ventas Norte = CALCULATE(
    SUM('Ventas'[MontoTotal]),
    'Tiendas'[Region] = "Norte"
)
→ FUERZA el filtro Región = "Norte"
```

---

## 📊 Ejemplos Básicos de CALCULATE

### Ejemplo 1: Filtro Simple

```dax
-- Ventas solo de la región Norte

Ventas Norte =
    CALCULATE(
        SUM('Ventas'[MontoTotal]),
        'Tiendas'[Region] = "Norte"
    )

/*
📝 EXPLICACIÓN:

1. CALCULATE evalúa SUM('Ventas'[MontoTotal])
2. Pero PRIMERO modifica el contexto de filtro
3. Agrega el filtro: Region = "Norte"
4. El resultado SIEMPRE será ventas del Norte
   sin importar qué filtros estén activos en el reporte

💡 USO: KPI fijo que siempre muestra Norte
*/
```

### Ejemplo 2: Múltiples Filtros

```dax
-- Ventas de Smartphones en el Norte

Ventas Smartphones Norte =
    CALCULATE(
        SUM('Ventas'[MontoTotal]),
        'Tiendas'[Region] = "Norte",
        'Productos'[Categoria] = "Smartphones"
    )

/*
📝 EXPLICACIÓN:

Los filtros se combinan con AND (Y)
→ Region = "Norte" Y Categoria = "Smartphones"

Equivalente a WHERE en SQL:
SELECT SUM(MontoTotal)
FROM Ventas
WHERE Region = 'Norte' AND Categoria = 'Smartphones'
*/
```

### Ejemplo 3: Filtros con OR (O)

```dax
-- Ventas de Norte O Sur

Ventas Norte o Sur =
    CALCULATE(
        SUM('Ventas'[MontoTotal]),
        'Tiendas'[Region] IN {"Norte", "Sur"}
    )

/*
📝 OPERADOR IN:

- Permite valores múltiples
- Equivalente a OR
- Sintaxis: Columna IN {valor1, valor2, ...}
*/

-- Alternativa con OR explícito
Ventas Norte o Sur Alt =
    CALCULATE(
        SUM('Ventas'[MontoTotal]),
        'Tiendas'[Region] = "Norte" ||
        'Tiendas'[Region] = "Sur"
    )

/*
📝 OPERADOR ||:

- Operador OR lógico
- Menos eficiente que IN
- Usa IN cuando sea posible
*/
```

---

## 🧹 ALL: Remover Filtros

**ALL** quita los filtros de una tabla o columna.

### ALL de Toda la Tabla

```dax
-- Total de TODAS las ventas (ignora filtros)

Total Ventas Global =
    CALCULATE(
        SUM('Ventas'[MontoTotal]),
        ALL('Ventas')
    )

/*
📝 CÓMO FUNCIONA:

Sin importar qué filtros estén activos:
- Filtro de Región → Ignorado
- Filtro de Fecha → Ignorado
- Filtro de Producto → Ignorado

SIEMPRE retorna el total absoluto

💡 USO: Denomin ador para calcular porcentajes
*/
```

### ALL de Columnas Específicas

```dax
-- Total ventas ignorando solo el filtro de Región

Total Sin Filtro Region =
    CALCULATE(
        SUM('Ventas'[MontoTotal]),
        ALL('Tiendas'[Region])
    )

/*
📝 DIFERENCIA:

ALL('Ventas') → Quita TODOS los filtros de Ventas
ALL('Tiendas'[Region]) → Quita solo filtro de Región

Otros filtros (fecha, producto, etc.) siguen activos
*/
```

### Caso Práctico: Porcentaje del Total

```dax
-- % de ventas respecto al total global

% del Total =
    DIVIDE(
        SUM('Ventas'[MontoTotal]),          -- Ventas con filtros actuales
        CALCULATE(
            SUM('Ventas'[MontoTotal]),
            ALL('Ventas')                    -- Ventas totales sin filtros
        ),
        0
    ) * 100

/*
📝 EJEMPLO EN UNA TABLA:

┌──────────┬────────────┬───────────┐
│ Región   │ Ventas     │ % Total   │
├──────────┼────────────┼───────────┤
│ Norte    │ $500,000   │ 38.5%     │ ← 500k / 1,300k
│ Centro   │ $450,000   │ 34.6%     │ ← 450k / 1,300k
│ Sur      │ $350,000   │ 26.9%     │ ← 350k / 1,300k
├──────────┼────────────┼───────────┤
│ Total    │ $1,300,000 │ 100.0%    │
└──────────┴────────────┴───────────┘

El denominador SIEMPRE es 1,300,000 (total global)
*/
```

---

## 🎯 ALLEXCEPT: Remover Todos EXCEPTO

**ALLEXCEPT** quita todos los filtros EXCEPTO los especificados.

```dax
-- Total de ventas manteniendo solo el filtro de Año

Ventas por Año (Sin Otros Filtros) =
    CALCULATE(
        SUM('Ventas'[MontoTotal]),
        ALLEXCEPT('Ventas', 'Calendario'[Año])
    )

/*
📝 EXPLICACIÓN:

Quita filtros de:
- Región ✓
- Categoría ✓
- Marca ✓
- Tienda ✓

Mantiene filtro de:
- Año ✗

💡 EQUIVALENTE A:
CALCULATE(
    SUM('Ventas'[MontoTotal]),
    ALL('Ventas'),
    VALUES('Calendario'[Año])
)

Pero ALLEXCEPT es más conciso
*/
```

### Caso Práctico: Ranking por Grupo

```dax
-- % de ventas dentro del año (ignorando región, producto, etc.)

% Ventas en el Año =
    DIVIDE(
        SUM('Ventas'[MontoTotal]),
        CALCULATE(
            SUM('Ventas'[MontoTotal]),
            ALLEXCEPT('Ventas', 'Calendario'[Año])
        ),
        0
    ) * 100

/*
📝 USO:

En un reporte con Año, Región, Producto:
- El denominador es el total del AÑO
- No del total global
- Útil para comparaciones dentro de período
*/
```

---

## 🔍 FILTER: Filtros Complejos

**FILTER** crea filtros con condiciones complejas.

### FILTER Básico

```dax
-- Ventas de productos con precio > $10,000

Ventas Productos Premium =
    CALCULATE(
        SUM('Ventas'[MontoTotal]),
        FILTER(
            'Productos',
            'Productos'[PrecioLista] > 10000
        )
    )

/*
📝 CÓMO FUNCIONA:

1. FILTER itera la tabla 'Productos'
2. Evalúa la condición para cada producto
3. Retorna solo productos con PrecioLista > 10,000
4. CALCULATE usa esa tabla filtrada
*/
```

### FILTER con Medidas

```dax
-- Productos que vendieron más de $100,000

Ventas Top Productos =
    CALCULATE(
        SUM('Ventas'[MontoTotal]),
        FILTER(
            ALL('Productos'[ProductoID]),
            [Total Ventas] > 100000
        )
    )

/*
📝 FILTRO CON MEDIDA:

- FILTER puede evaluar MEDIDAS (no solo columnas)
- Muy poderoso para filtros dinámicos
- ALL() necesario para evaluar cada producto

⚠️ ADVERTENCIA: Puede ser lento con muchos datos
*/
```

### FILTER con Múltiples Condiciones

```dax
-- Ventas de smartphones Samsung o Apple con descuento

Ventas Smartphones Premium Desc =
    CALCULATE(
        SUM('Ventas'[MontoTotal]),
        FILTER(
            'Ventas',
            'Ventas'[Descuento] > 0 &&
            RELATED('Productos'[Categoria]) = "Smartphones" &&
            (
                RELATED('Productos'[Marca]) = "SAMSUNG" ||
                RELATED('Productos'[Marca]) = "APPLE"
            )
        )
    )

/*
📝 OPERADORES LÓGICOS:

&& = AND (Y)
|| = OR (O)

💡 TIP: Usa paréntesis para claridad
*/
```

---

## 🔄 KEEPFILTERS: Preservar Filtros Externos

```dax
-- SIN KEEPFILTERS (reemplaza filtros)
Ventas Norte =
    CALCULATE(
        SUM('Ventas'[MontoTotal]),
        'Tiendas'[Region] = "Norte"
    )

-- Si el usuario filtra por "Sur", esta medida FUERZA "Norte"
-- Resultado: Ventas del Norte (ignora filtro de usuario)

-- CON KEEPFILTERS (combina filtros)
Ventas Norte Respetuoso =
    CALCULATE(
        SUM('Ventas'[MontoTotal]),
        KEEPFILTERS('Tiendas'[Region] = "Norte")
    )

-- Si el usuario filtra por "Sur":
-- → Norte AND Sur = Sin resultados (vacío)

/*
📝 CUÁNDO USAR:

SIN KEEPFILTERS:
- Quieres FORZAR un filtro
- KPIs fijos (ej: "Ventas Norte" siempre muestra Norte)

CON KEEPFILTERS:
- Quieres COMBINAR con filtros del usuario
- Filtros restrictivos adicionales
*/
```

---

## 📐 Patrones Comunes con CALCULATE

### Patrón 1: Comparación vs Total

```dax
-- Ventas actuales (con filtros)
Total Ventas =
    SUM('Ventas'[MontoTotal])

-- Ventas totales (sin filtros)
Total Ventas Global =
    CALCULATE(
        SUM('Ventas'[MontoTotal]),
        ALL('Ventas')
    )

-- Diferencia vs total
Diferencia vs Global =
    [Total Ventas] - [Total Ventas Global]

-- % del total
% del Total =
    DIVIDE(
        [Total Ventas],
        [Total Ventas Global],
        0
    ) * 100
```

### Patrón 2: Totales por Categoría

```dax
-- Total de la categoría del producto actual

Ventas de la Categoria =
    CALCULATE(
        SUM('Ventas'[MontoTotal]),
        ALLEXCEPT('Productos', 'Productos'[Categoria])
    )

-- % dentro de la categoría
% en Categoria =
    DIVIDE(
        [Total Ventas],
        [Ventas de la Categoria],
        0
    ) * 100

/*
📝 USO:

En un reporte de productos:
- Muestra % de cada producto dentro de su categoría
- iPhone 15: 45% de ventas de Smartphones
- Galaxy S24: 30% de ventas de Smartphones
*/
```

### Patrón 3: Valores Acumulados

```dax
-- Ventas acumuladas del año

Ventas YTD (Acumulado) =
    CALCULATE(
        SUM('Ventas'[MontoTotal]),
        FILTER(
            ALL('Calendario'[Fecha]),
            'Calendario'[Año] = MAX('Calendario'[Año]) &&
            'Calendario'[Fecha] <= MAX('Calendario'[Fecha])
        )
    )

/*
📝 EXPLICACIÓN:

1. ALL('Calendario'[Fecha]) quita filtro de fecha
2. Filtra por año actual
3. Filtra fechas <= fecha máxima actual
4. Suma ventas de esas fechas

Resultado: Acumulado del año hasta la fecha
*/
```

### Patrón 4: Top N

```dax
-- Ventas de los Top 10 productos

Ventas Top 10 Productos =
    CALCULATE(
        SUM('Ventas'[MontoTotal]),
        TOPN(
            10,
            ALL('Productos'[ProductoID]),
            [Total Ventas],
            DESC
        )
    )

/*
📝 TOPN():

TOPN(N, Tabla, Criterio, Orden)

- N: Número de elementos
- Tabla: Tabla a filtrar
- Criterio: Medida para ordenar
- Orden: DESC (descendente) o ASC (ascendente)
*/
```

---

## 🎨 Casos Prácticos Avanzados

### Caso 1: Dashboard de Participación de Mercado

```dax
-- 1. VENTAS TOTALES DEL MERCADO
Ventas Total Mercado =
    CALCULATE(
        SUM('Ventas'[MontoTotal]),
        ALL('Productos')
    )

-- 2. VENTAS POR MARCA
Ventas por Marca =
    CALCULATE(
        SUM('Ventas'[MontoTotal]),
        ALLEXCEPT('Productos', 'Productos'[Marca])
    )

-- 3. MARKET SHARE
Market Share % =
    DIVIDE(
        [Total Ventas],
        [Ventas Total Mercado],
        0
    ) * 100

-- 4. RANKING DE MARCAS
Ranking Marca =
    RANKX(
        ALL('Productos'[Marca]),
        [Total Ventas],
        ,
        DESC,
        DENSE
    )

/*
📝 RANKX():

Asigna un ranking basado en una medida

Parámetros:
- Tabla sobre la cual rankear
- Expresión para comparar
- (Opcional) Valor para empates
- Orden: DESC o ASC
- Tipo: DENSE (1,2,3) o SKIP (1,2,2,4)
*/
```

### Caso 2: Análisis de Ventas con/sin Descuento

```dax
-- VENTAS CON DESCUENTO
Ventas con Descuento =
    CALCULATE(
        SUM('Ventas'[MontoTotal]),
        'Ventas'[Descuento] > 0
    )

-- VENTAS SIN DESCUENTO
Ventas sin Descuento =
    CALCULATE(
        SUM('Ventas'[MontoTotal]),
        'Ventas'[Descuento] = 0
    )

-- % VENTAS CON DESCUENTO
% Ventas con Desc =
    DIVIDE(
        [Ventas con Descuento],
        [Total Ventas],
        0
    ) * 100

-- TICKET PROMEDIO CON/SIN DESCUENTO
Ticket Prom con Desc =
    CALCULATE(
        [Ticket Promedio],
        'Ventas'[Descuento] > 0
    )

Ticket Prom sin Desc =
    CALCULATE(
        [Ticket Promedio],
        'Ventas'[Descuento] = 0
    )

-- DIFERENCIA
Impacto Descuento en Ticket =
    [Ticket Prom con Desc] - [Ticket Prom sin Desc]
```

### Caso 3: Segmentación ABC

```dax
-- Clasificación ABC de productos

Segmento ABC =
VAR VentasProducto = [Total Ventas]
VAR TotalVentas = CALCULATE([Total Ventas], ALL('Productos'))
VAR AcumuladoRanking =
    CALCULATE(
        [Total Ventas],
        FILTER(
            ALL('Productos'[ProductoID]),
            [Total Ventas] >= VentasProducto
        )
    )
VAR PorcentajeAcumulado =
    DIVIDE(AcumuladoRanking, TotalVentas, 0)

RETURN
    SWITCH(
        TRUE(),
        PorcentajeAcumulado <= 0.80, "A",  -- Top 80%
        PorcentajeAcumulado <= 0.95, "B",  -- Siguiente 15%
        "C"                                 -- Resto 5%
    )

/*
📝 ANÁLISIS ABC (PARETO):

A: Productos que generan el 80% de ventas
B: Productos que generan el siguiente 15%
C: Productos que generan el último 5%

💡 Principio 80/20: ~20% de productos genera 80% de ventas
*/
```

---

## 💡 Tips y Mejores Prácticas

### ✅ DO (Hacer)

1. **Usa CALCULATE para cambiar contexto**
   ```dax
   ✅ CALCULATE(SUM(...), 'Tabla'[Col] = "Valor")
   ```

2. **Usa ALL para porcentajes del total**
   ```dax
   ✅ DIVIDE([Ventas], CALCULATE([Ventas], ALL(...)), 0)
   ```

3. **Usa FILTER solo cuando sea necesario**
   ```dax
   ✅ 'Tabla'[Col] = "Valor"           -- Más rápido
   ⚠️ FILTER('Tabla', ...)              -- Solo si es complejo
   ```

4. **Combina filtros eficientemente**
   ```dax
   ✅ IN {"A", "B", "C"}                -- Más rápido que OR
   ❌ = "A" || = "B" || = "C"
   ```

### ❌ DON'T (No Hacer)

1. **No uses FILTER innecesariamente**
   ```dax
   ❌ FILTER('Tabla', 'Tabla'[Col] = "X")
   ✅ 'Tabla'[Col] = "X"
   ```

2. **No olvides manejar valores en blanco**
   ```dax
   ❌ 'Tabla'[Col] = "Valor"
   ✅ 'Tabla'[Col] = "Valor" && NOT(ISBLANK('Tabla'[Col]))
   ```

3. **No abuses de ALL() en tablas grandes**
   ```dax
   ⚠️ CALCULATE(..., ALL('VentasGrandes'))  -- Lento
   ✅ CALCULATE(..., ALL('Ventas'[Columna])) -- Más rápido
   ```

---

## 🎯 Ejercicios Prácticos

### Ejercicio 1: Filtros Básicos
1. Ventas solo de región "Centro"
2. Ventas de productos de marca "SAMSUNG"
3. Ventas con descuento mayor al 15%

### Ejercicio 2: Porcentajes
1. % de ventas de cada región vs total
2. % de ventas de cada categoría dentro de su región
3. % de ventas de cada producto dentro de su categoría

### Ejercicio 3: Comparaciones
1. Ventas de productos premium (precio > $15,000) vs estándar
2. Ranking de tiendas por ventas
3. Top 5 productos por ventas

**💡 Soluciones en:** `/soluciones/soluciones_modulo3.md`

---

## 🎓 Resumen del Módulo

### Has Aprendido:
✅ CALCULATE para modificar contexto de filtro
✅ ALL y ALLEXCEPT para remover filtros
✅ FILTER para filtros complejos
✅ KEEPFILTERS para preservar filtros externos
✅ Patrones comunes: % del total, rankings, Top N
✅ Análisis ABC/Pareto
✅ Funciones TOPN, RANKX, IN

### Próximo Módulo:
📚 **Módulo 4: Time Intelligence**
- Análisis temporal con DAX
- YTD, MTD, QTD
- Comparaciones con períodos anteriores
- Crecimiento y variaciones

---

**[⬅️ Volver al Módulo 2](02_agregacion_contexto.md) | [➡️ Ir al Módulo 4](04_time_intelligence.md)**

---

*Curso de DAX | Módulo 3 de 6*
