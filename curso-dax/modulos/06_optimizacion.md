# 📘 Módulo 6: Optimización y Mejores Prácticas

## 🎯 Objetivos del Módulo

- ✅ Optimizar medidas DAX para máximo rendimiento
- ✅ Usar variables (VAR) efectivamente
- ✅ Entender Storage Engine vs Formula Engine
- ✅ Aplicar patrones DAX probados
- ✅ Debugging y troubleshooting

---

## 🚀 Variables en DAX

### ¿Por Qué Usar Variables?

```dax
-- ❌ SIN VARIABLES (cálculo repetido)
Margen % =
    DIVIDE(
        SUM('Ventas'[Monto]) - SUMX('Ventas', RELATED('Productos'[Costo]) * 'Ventas'[Cantidad]),
        SUM('Ventas'[Monto]),
        0
    ) * 100

-- ✅ CON VARIABLES (más rápido y legible)
Margen % =
VAR TotalVentas = SUM('Ventas'[Monto])
VAR TotalCostos =
    SUMX(
        'Ventas',
        RELATED('Productos'[Costo]) * 'Ventas'[Cantidad]
    )

RETURN
    DIVIDE(
        TotalVentas - TotalCostos,
        TotalVentas,
        0
    ) * 100

/*
📝 VENTAJAS DE VARIABLES:

✅ Performance: Cálculo UNA sola vez
✅ Legibilidad: Código más claro
✅ Debugging: Fácil identificar problemas
✅ Mantenibilidad: Cambios más simples

⚡ REGLA: Si repites una expresión, usa variable
*/
```

### Scope de Variables

```dax
-- Variables tienen scope (ámbito)

Mi Medida =
VAR VentasTotales = SUM('Ventas'[Monto])    -- Scope: toda la medida

VAR Top3 =
    CALCULATETABLE(
        TOPN(3, ALL('Productos'), [Total Ventas]),
        VAR VentasProducto = [Total Ventas]     -- ❌ ERROR: No se puede aquí
    )

RETURN VentasTotales

/*
📝 REGLAS:

1. Variables se declaran al inicio o en bloques específicos
2. No se pueden declarar dentro de CALCULATE, FILTER, etc.
3. Se evalúan en el contexto donde se declaran
4. Son inmutables (no cambian de valor)
*/
```

---

## ⚙️ Storage Engine vs Formula Engine

### Entendiendo los Dos Motores

```
📊 STORAGE ENGINE (VertiPaq)          🧮 FORMULA ENGINE
├─ Motor de base de datos             ├─ Evalúa expresiones DAX
├─ Muy rápido (columnar, comprimido)  ├─ Más lento
├─ Trabaja con columnas completas     ├─ Trabaja fila por fila
├─ Operaciones:                       ├─ Operaciones:
│  • SUM, COUNT, MIN, MAX             │  • SUMX, FILTER complejo
│  • Filtros simples                  │  • RELATED
│  • Group By                         │  • Cálculos complejos
└─ Objetivo: Maximizar su uso         └─ Objetivo: Minimizar su uso
```

### Optimización: Delegar al Storage Engine

```dax
-- ✅ RÁPIDO: Storage Engine
Ventas por Region =
    CALCULATE(
        SUM('Ventas'[Monto]),
        'Tiendas'[Region] = "Norte"
    )
-- → Filtro simple, Storage Engine lo procesa

-- ⚠️ MÁS LENTO: Formula Engine
Ventas Alto Monto =
    CALCULATE(
        SUM('Ventas'[Monto]),
        FILTER(
            'Ventas',
            [Total Ventas] > 10000      -- Evalúa medida por fila
        )
    )
-- → FILTER con medida fuerza Formula Engine

-- ✅ ALTERNATIVA RÁPIDA: Columna calculada
-- Crear columna: EsAltoMonto = IF('Ventas'[Monto] > 10000, "Sí", "No")

Ventas Alto Monto Opt =
    CALCULATE(
        SUM('Ventas'[Monto]),
        'Ventas'[EsAltoMonto] = "Sí"
    )
-- → Filtro en columna, Storage Engine lo procesa
```

---

## 🎯 Patrones de Optimización

### 1. Filtros: Columnas vs Medidas

```dax
-- ❌ LENTO: FILTER con medida
Productos Top =
    CALCULATE(
        [Total Ventas],
        FILTER(
            ALL('Productos'),
            [Total Ventas] > 100000
        )
    )

-- ✅ RÁPIDO: CALCULATETABLE + TOPN
Productos Top Opt =
    CALCULATE(
        [Total Ventas],
        TOPN(
            100,                         -- Limita a top 100
            ALL('Productos'),
            [Total Ventas],
            DESC
        )
    )

/*
📝 TOPN es más eficiente que FILTER con medidas
*/
```

### 2. Evitar Iteraciones Innecesarias

```dax
-- ❌ INNECESARIO: SUMX en columna existente
Total Ventas =
    SUMX('Ventas', 'Ventas'[Monto])

-- ✅ CORRECTO: SUM directo
Total Ventas Opt =
    SUM('Ventas'[Monto])

-- ✅ NECESARIO: SUMX para cálculo por fila
Total Calculado =
    SUMX(
        'Ventas',
        'Ventas'[Cantidad] * 'Ventas'[Precio]
    )
```

### 3. Materializar Cálculos Comunes

```dax
-- Si calculas lo mismo repetidamente, crea columna calculada

-- ❌ LENTO: Calcular en cada medida
Margen Producto =
    SUMX(
        'Ventas',
        ('Ventas'[Precio] - RELATED('Productos'[Costo])) * 'Ventas'[Cantidad]
    )

-- ✅ RÁPIDO: Columna calculada + SUM
-- Columna: MargenPorVenta = ('Ventas'[Precio] - RELATED('Productos'[Costo])) * 'Ventas'[Cantidad]

Margen Producto Opt =
    SUM('Ventas'[MargenPorVenta])

/*
📝 TRADE-OFF:

Columna Calculada:
✅ Cálculo rápido (pre-calculado)
❌ Ocupa memoria
❌ Se actualiza en refresh

Medida:
✅ No ocupa memoria
✅ Dinámica
❌ Se calcula cada vez

DECISIÓN: Si el cálculo se usa frecuentemente → Columna
*/
```

### 4. Optimizar Context Transitions

```dax
-- Context transition ocurre al usar medida en contexto de fila

-- ⚠️ LENTO: Múltiples context transitions
Ranking Lento =
    RANKX(
        ALL('Productos'),
        [Total Ventas]              -- Context transition en cada iteración
    )

-- ✅ RÁPIDO: Calcular una vez con variable
Ranking Rápido =
VAR VentasTable =
    ADDCOLUMNS(
        ALL('Productos'),
        "Ventas", [Total Ventas]
    )

RETURN
    RANKX(VentasTable, [Ventas])

/*
📝 Context Transition es costoso
Minimiza su uso con variables y ADDCOLUMNS
*/
```

### 5. ALL vs VALUES

```dax
-- ALL: Ignora todos los filtros (más rápido)
Total Global =
    CALCULATE(
        [Total Ventas],
        ALL('Ventas')
    )

-- VALUES: Respeta filtros externos (más lento)
Total Visible =
    CALCULATE(
        [Total Ventas],
        VALUES('Ventas'[ProductoID])
    )

/*
📝 CUÁNDO USAR:

ALL:
- Cuando quieres IGNORAR filtros
- Total absoluto
- Más rápido

VALUES:
- Cuando quieres RESPETAR filtros externos
- Total del contexto actual
- Más lento pero más flexible
*/
```

---

## 🧹 Mejores Prácticas de Código

### Nomenclatura

```dax
-- ✅ BUENAS PRÁCTICAS

-- Medidas: Descriptivas, sin prefijo
Total Ventas
Margen Bruto %
Ventas Año Anterior

-- Columnas Calculadas: Prefijo opcional o descripción clara
[CC] Categoría Precio  -- Prefijo [CC] = Columna Calculada
Es Alto Valor          -- O descripción clara
Año-Mes               -- Útil para agrupación

-- Tablas: PascalCase o con prefijo
dim_Productos          -- Prefijo para dimensiones
fact_Ventas            -- Prefijo para hechos
Calendario             -- Simple y claro

-- Variables: camelCase o Descriptivo
VAR ventasTotales = ...
VAR PrecioPromedio = ...
```

### Formato y Comentarios

```dax
-- ✅ CÓDIGO BIEN FORMATEADO

Margen Bruto % =
VAR Ingresos =              -- Variable con comentario
    SUM('Ventas'[Monto])

VAR Costos =
    SUMX(
        'Ventas',
        'Ventas'[Cantidad] * RELATED('Productos'[Costo])
    )

VAR Margen =
    Ingresos - Costos

RETURN
    DIVIDE(
        Margen,             -- Numerador
        Ingresos,           -- Denominador
        0                   -- Valor si cero
    ) * 100

/*
📝 EXPLICACIÓN COMPLETA:

Esta medida calcula el margen bruto como porcentaje de ingresos.

Fórmula:
Margen % = (Ingresos - Costos) / Ingresos * 100

Dependencias:
- Tabla: Ventas
- Relación: Ventas → Productos
- Columna: Productos[Costo]

Ejemplo:
Ingresos: $100,000
Costos: $65,000
Margen: 35%
*/
```

### Modularidad

```dax
-- ✅ CREAR MEDIDAS BASE REUTILIZABLES

-- Base
Total Ventas = SUM('Ventas'[Monto])

-- Derivadas
Ventas Año Anterior =
    CALCULATE(
        [Total Ventas],
        SAMEPERIODLASTYEAR('Calendario'[Fecha])
    )

Crecimiento YoY =
    [Total Ventas] - [Ventas Año Anterior]

% Crecimiento YoY =
    DIVIDE([Crecimiento YoY], [Ventas Año Anterior], 0) * 100

/*
📝 VENTAJAS:

✅ Si cambias [Total Ventas], todo se actualiza
✅ Código más limpio
✅ Fácil de mantener
✅ Reutilización
*/
```

---

## 🐛 Debugging y Troubleshooting

### Técnicas de Debugging

```dax
-- 1. USA VARIABLES PARA INSPECCIONAR

Debug Medida =
VAR Paso1 = SUM('Ventas'[Monto])
VAR Paso2 = SUM('Ventas'[Descuento])
VAR Paso3 = Paso1 - Paso2

RETURN
    Paso1        -- Cambia esto para ver cada paso
    -- Paso2
    -- Paso3

-- 2. USA COUNTROWS PARA VERIFICAR FILTROS

Verificar Filtro =
    COUNTROWS('Ventas')    -- ¿Cuántas filas se están considerando?

-- 3. USA ISFILTERED para detectar contexto

Hay Filtro Region =
    IF(
        ISFILTERED('Tiendas'[Region]),
        "Filtrado",
        "Sin filtro"
    )

-- 4. USA HASONEVALUE para valores únicos

Valor Único =
    IF(
        HASONEVALUE('Productos'[Categoria]),
        VALUES('Productos'[Categoria]),
        "Múltiples"
    )
```

### Errores Comunes y Soluciones

```dax
-- ERROR: División por cero
❌ Margen = [Ventas] / [Costos]
✅ Margen = DIVIDE([Ventas], [Costos], 0)

-- ERROR: Contexto de fila en medida
❌ Total = 'Ventas'[Monto] * 'Ventas'[Cantidad]
✅ Total = SUMX('Ventas', 'Ventas'[Monto] * 'Ventas'[Cantidad])

-- ERROR: Referencia circular
❌ Medida A = [Medida B]
   Medida B = [Medida A]
✅ Revisa dependencias, elimina circular

-- ERROR: RELATED en dirección incorrecta
❌ -- En tabla Productos, traer de Ventas
   Monto = RELATED('Ventas'[Monto])
✅ -- En tabla Ventas, traer de Productos
   Precio = RELATED('Productos'[Precio])

-- ERROR: Time Intelligence sin tabla calendario
❌ Ventas YTD = TOTALYTD([Ventas], 'Ventas'[Fecha])
✅ Ventas YTD = TOTALYTD([Ventas], 'Calendario'[Fecha])
                                   └── Tabla marcada como Date Table
```

---

## 📊 Checklist de Optimización

### Antes de Publicar

```
□ ¿Usé variables para cálculos repetidos?
□ ¿Evité FILTER con medidas cuando pude usar columnas?
□ ¿Preferí funciones simples (SUM) sobre iteradores (SUMX)?
□ ¿Consideré columnas calculadas para cálculos frecuentes?
□ ¿Minimicé context transitions?
□ ¿El código está comentado y formateado?
□ ¿Las medidas tienen nombres descriptivos?
□ ¿Reutilicé medidas base en lugar de duplicar lógica?
□ ¿Probé con datos reales y volumen esperado?
□ ¿El modelo está bien relacionado?
```

---

## 🎯 Patrones DAX Comunes

### Patrón 1: Dynamic Top N

```dax
-- Top N dinámico con parámetro

Top N Productos =
VAR TopN =
    SELECTEDVALUE('Parametros'[Valor Top N], 10)  -- Default 10

RETURN
    CALCULATE(
        [Total Ventas],
        TOPN(
            TopN,
            ALL('Productos'),
            [Total Ventas],
            DESC
        )
    )
```

### Patrón 2: Dynamic Measure Switcher

```dax
-- Selector de medida dinámica

Medida Dinámica =
VAR Selección =
    SELECTEDVALUE('SelectorMedida'[Medida], "Ventas")

RETURN
    SWITCH(
        Selección,
        "Ventas", [Total Ventas],
        "Margen", [Margen Bruto],
        "Unidades", [Unidades Vendidas],
        "Ticket", [Ticket Promedio],
        BLANK()
    )
```

### Patrón 3: Running Total

```dax
-- Total acumulado

Ventas Acumuladas =
VAR FechaActual = MAX('Calendario'[Fecha])

RETURN
    CALCULATE(
        [Total Ventas],
        FILTER(
            ALL('Calendario'[Fecha]),
            'Calendario'[Fecha] <= FechaActual
        )
    )
```

### Patrón 4: ABC Classification

```dax
-- Clasificación ABC dinámica

ABC Dinámico =
VAR LimiteA = 0.80
VAR LimiteB = 0.95
VAR VentasProducto = [Total Ventas]
VAR TotalVentas = CALCULATE([Total Ventas], ALL('Productos'))
VAR Acumulado =
    CALCULATE(
        [Total Ventas],
        FILTER(
            ALL('Productos'),
            [Total Ventas] >= VentasProducto
        )
    )
VAR Porcentaje = DIVIDE(Acumulado, TotalVentas, 0)

RETURN
    SWITCH(
        TRUE(),
        Porcentaje <= LimiteA, "A",
        Porcentaje <= LimiteB, "B",
        "C"
    )
```

---

## 💡 Tips de Expertos

### Performance

1. **Cardinalidad**: Filtra por columnas con baja cardinalidad primero
2. **Materializa**: Columnas calculadas para lógica compleja repetitiva
3. **SUMMARIZE con cuidado**: Puede ser lento con muchas columnas
4. **Evita funciones escalares**: En DAX Studio, revisa query plan

### Modelo de Datos

1. **Relaciones correctas**: Uno a Muchos, dirección adecuada
2. **Tabla calendario**: Siempre dedicada, completa
3. **Normalización**: Dimensiones separadas de hechos
4. **Tipos de datos**: Usa el más específico (entero vs decimal)

### Mantenibilidad

1. **Carpetas de medidas**: Organiza por categoría
2. **Prefijos**: dm_Ventas, dim_Productos, etc.
3. **Documentación**: Comenta medidas complejas
4. **Control de versiones**: Guarda cambios importantes

---

## 🎓 Resumen del Curso Completo

### Módulo 1: Fundamentos
✅ Medidas vs Columnas
✅ Funciones básicas
✅ Sintaxis DAX

### Módulo 2: Contexto
✅ Contexto de fila y filtro
✅ Iteradores
✅ RELATED

### Módulo 3: CALCULATE
✅ Modificar contexto
✅ ALL, FILTER
✅ Patrones comunes

### Módulo 4: Time Intelligence
✅ Tabla calendario
✅ YTD, MTD, QTD
✅ Comparaciones temporales

### Módulo 5: KPIs Retail
✅ Sell-Out, Market Share
✅ ABC/Pareto
✅ Inventario

### Módulo 6: Optimización
✅ Variables
✅ Storage vs Formula Engine
✅ Mejores prácticas

---

## 🎯 Próximos Pasos

1. **Practica**: Usa los datasets del curso
2. **Experimenta**: Modifica los ejemplos
3. **Certifícate**: Microsoft PL-300 (Power BI Data Analyst)
4. **Comunidad**: Participa en foros (SQLBI, Power BI Community)
5. **Proyectos reales**: Aplica en tu trabajo

---

## 📚 Recursos Adicionales

### Herramientas
- **DAX Studio**: Debugging y análisis de queries
- **Tabular Editor**: Edición avanzada del modelo
- **DAX Formatter**: Formateo automático de código

### Aprendizaje Continuo
- SQLBI (Marco Russo, Alberto Ferrari)
- Guy in a Cube (YouTube)
- Power BI Documentation

---

**¡Felicidades por completar el Curso de DAX!** 🎉

Ya dominas desde fundamentos hasta optimización avanzada. Ahora es momento de aplicar todo lo aprendido en proyectos reales.

**[⬅️ Volver al Módulo 5](05_kpis_avanzados.md) | [📖 Ver Guía Rápida](../REFERENCIA_RAPIDA.md)**

---

*Curso de DAX | Módulo 6 de 6 | ¡Curso Completado!*
