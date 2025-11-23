# 📘 Módulo 5: KPIs Avanzados para Retail

## 🎯 Objetivos del Módulo

- ✅ Crear KPIs específicos de retail
- ✅ Análisis Sell-Out, Sell-In, Sell-Through
- ✅ Market Share y participación
- ✅ Análisis ABC/Pareto
- ✅ Cohort Analysis y retención
- ✅ Métricas de inventario y rotación

---

## 💰 Métricas de Ventas (Sell-Out, Sell-In, Sell-Through)

### Sell-Out (Venta al Cliente Final)

```dax
-- SELL-OUT: Ventas al consumidor final

Sell-Out =
    SUM('Ventas'[MontoTotal])

Unidades Sell-Out =
    SUM('Ventas'[Cantidad])

/*
📝 SELL-OUT:
- Ventas finales al consumidor
- Lo que salió de la tienda
- Indicador de DEMANDA real
*/
```

### Sell-In (Venta a la Tienda/Distribuidor)

```dax
-- SELL-IN: Ventas del fabricante a la tienda

Sell-In =
    SUM('ComprasTiendas'[MontoTotal])

Unidades Sell-In =
    SUM('ComprasTiendas'[Cantidad])

/*
📝 SELL-IN:
- Ventas del proveedor a la tienda
- Stock que entra a la tienda
- Indicador de ABASTECIMIENTO
*/
```

### Sell-Through Rate

```dax
-- SELL-THROUGH: % de inventario vendido

Sell-Through % =
    DIVIDE(
        [Unidades Sell-Out],
        [Unidades Sell-In],
        0
    ) * 100

/*
📝 SELL-THROUGH RATE:

> 100%: Vendiste más de lo que compraste (stock previo)
= 100%: Balance perfecto
< 100%: Hay inventario sin vender

Objetivo típico: 80-100%

Ejemplo:
Sell-In: 100 unidades
Sell-Out: 85 unidades
Sell-Through: 85%
→ 15 unidades en inventario
*/

-- Por categoría
Sell-Through por Categoría =
    AVERAGEX(
        VALUES('Productos'[Categoria]),
        [Sell-Through %]
    )
```

---

## 📊 Market Share (Participación de Mercado)

### Market Share Básico

```dax
-- VENTAS TOTALES DEL MERCADO
Ventas Mercado Total =
    CALCULATE(
        [Total Ventas],
        ALL('Productos')
    )

-- MARKET SHARE
Market Share % =
    DIVIDE(
        [Total Ventas],
        [Ventas Mercado Total],
        0
    ) * 100

/*
📝 USO:

En tabla por Marca:
┌──────────┬────────────┬──────────────┐
│ Marca    │ Ventas     │ Market Share │
├──────────┼────────────┼──────────────┤
│ SAMSUNG  │ $500M      │ 35%          │
│ APPLE    │ $400M      │ 28%          │
│ XIAOMI   │ $300M      │ 21%          │
│ Otros    │ $230M      │ 16%          │
└──────────┴────────────┴──────────────┘
*/
```

### Market Share por Segmento

```dax
-- Market Share dentro de una categoría

Market Share en Categoria % =
VAR VentasCategoria =
    CALCULATE(
        [Total Ventas],
        ALLEXCEPT('Productos', 'Productos'[Categoria])
    )

RETURN
    DIVIDE(
        [Total Ventas],
        VentasCategoria,
        0
    ) * 100

/*
📝 EJEMPLO:

Categoría: Smartphones
┌──────────┬────────────┬────────────────┐
│ Marca    │ Ventas     │ Market Share   │
├──────────┼────────────┼────────────────┤
│ SAMSUNG  │ $200M      │ 40% ← de SMARTPHONEs
│ APPLE    │ $180M      │ 36%
│ XIAOMI   │ $120M      │ 24%
└──────────┴────────────┴────────────────┘
*/
```

### Ranking de Participación

```dax
-- RANKING por participación de mercado

Ranking Market Share =
    RANKX(
        ALL('Productos'[Marca]),
        [Total Ventas],
        ,
        DESC,
        DENSE
    )

-- TOP 3 Brands
Es Top 3 =
    IF(
        [Ranking Market Share] <= 3,
        "Top 3",
        "Otros"
    )

-- Ventas de Top 3 vs Resto
Ventas Top 3 =
    CALCULATE(
        [Total Ventas],
        FILTER(
            ALL('Productos'[Marca]),
            [Ranking Market Share] <= 3
        )
    )

Ventas Resto =
    [Total Ventas] - [Ventas Top 3]
```

---

## 🎯 Análisis ABC / Pareto

### Clasificación ABC de Productos

```dax
-- CLASIFICACIÓN ABC (80-15-5)

ABC Producto =
VAR VentasProducto = [Total Ventas]
VAR TotalVentas =
    CALCULATE([Total Ventas], ALL('Productos'))

VAR RankingProducto =
    RANKX(
        ALL('Productos'[ProductoID]),
        [Total Ventas],
        ,
        DESC,
        DENSE
    )

VAR TotalProductos =
    COUNTROWS(ALL('Productos'))

VAR AcumuladoHastaProducto =
    CALCULATE(
        [Total Ventas],
        FILTER(
            ALL('Productos'[ProductoID]),
            [Ranking de Producto] <= RankingProducto
        )
    )

VAR PorcentajeAcumulado =
    DIVIDE(AcumuladoHastaProducto, TotalVentas, 0)

RETURN
    SWITCH(
        TRUE(),
        PorcentajeAcumulado <= 0.80, "A",  -- Top 80% de ventas
        PorcentajeAcumulado <= 0.95, "B",  -- Siguiente 15%
        "C"                                 -- Último 5%
    )

/*
📝 ANÁLISIS ABC:

A: ~20% de productos → 80% de ventas (CRÍTICOS)
B: ~30% de productos → 15% de ventas (IMPORTANTES)
C: ~50% de productos → 5% de ventas (RESIDUALES)

ESTRATEGIA:
A: Nunca quiebres stock, promociona
B: Mantén disponibilidad
C: Evalúa descontinuar
*/

-- Contar productos por segmento
Productos A =
    CALCULATE(
        DISTINCTCOUNT('Productos'[ProductoID]),
        'Productos'[ABC Producto] = "A"
    )

-- Ventas por segmento
Ventas Productos A =
    CALCULATE(
        [Total Ventas],
        'Productos'[ABC Producto] = "A"
    )
```

### Pareto Acumulado

```dax
-- % ACUMULADO de ventas (Curva de Pareto)

% Acumulado =
VAR ProductoActual = MAX('Productos'[ProductoID])

VAR RankingProducto =
    RANKX(
        ALL('Productos'[ProductoID]),
        [Total Ventas],
        ,
        DESC,
        DENSE
    )

VAR VentasAcumuladas =
    CALCULATE(
        [Total Ventas],
        FILTER(
            ALL('Productos'[ProductoID]),
            RANKX(
                ALL('Productos'[ProductoID]),
                [Total Ventas],
                ,
                DESC,
                DENSE
            ) <= RankingProducto
        )
    )

VAR TotalVentas =
    CALCULATE([Total Ventas], ALL('Productos'))

RETURN
    DIVIDE(VentasAcumuladas, TotalVentas, 0) * 100

/*
📝 CURVA DE PARETO:

Gráfico de línea mostrando:
X: Productos ordenados por ranking
Y: % Acumulado

Busca el punto donde llegas al 80%
→ Ese es tu punto de corte para productos "A"
*/
```

---

## 👥 Cohort Analysis (Análisis de Cohortes)

### Cohorte por Mes de Primera Compra

```dax
-- MES DE PRIMERA COMPRA (por cliente)

Mes Primera Compra =
VAR PrimeraFecha =
    CALCULATE(
        MIN('Ventas'[Fecha]),
        ALL('Ventas'[Fecha])
    )

RETURN
    FORMAT(PrimeraFecha, "YYYY-MM")

/*
📝 COHORT ANALYSIS:

Agrupa clientes por cuándo hicieron su primera compra
Analiza comportamiento a lo largo del tiempo

Ejemplo:
Cohorte Enero 2024: Clientes que compraron por primera vez en Enero 2024
*/

-- Ventas de la cohorte por mes
Ventas Cohorte =
    CALCULATE(
        [Total Ventas],
        ALLEXCEPT('Ventas', 'Clientes'[Mes Primera Compra])
    )

-- % Retención de la cohorte
% Retención Cohorte =
VAR ClientesIniciales =
    CALCULATE(
        DISTINCTCOUNT('Ventas'[ClienteID]),
        'Ventas'[Fecha] = MIN('Clientes'[Fecha Primera Compra])
    )

VAR ClientesActivos =
    DISTINCTCOUNT('Ventas'[ClienteID])

RETURN
    DIVIDE(ClientesActivos, ClientesIniciales, 0) * 100
```

---

## 📦 Métricas de Inventario y Rotación

### Cobertura de Inventario

```dax
-- DÍAS DE INVENTARIO (DOI - Days of Inventory)

Días Cobertura Inventario =
VAR InventarioActual = SUM('Inventario'[UnidadesStock])
VAR VentaDiariaPromedio =
    DIVIDE(
        [Unidades Sell-Out],
        DISTINCTCOUNT('Calendario'[Fecha]),
        0
    )

RETURN
    DIVIDE(InventarioActual, VentaDiariaPromedio, 0)

/*
📝 INTERPRETACIÓN:

30 días = Tienes inventario para 30 días de venta
15 días = Inventario bajo, reabastecer pronto
60 días = Sobrestock, reducir compras

OBJETIVO típico: 30-45 días
*/
```

### Rotación de Inventario

```dax
-- INVENTORY TURNOVER (Rotación de Inventario)

Rotación Inventario =
VAR VentasAnuales = [Unidades Sell-Out]
VAR InventarioPromedio =
    AVERAGE('Inventario'[UnidadesStock])

RETURN
    DIVIDE(VentasAnuales, InventarioPromedio, 0)

/*
📝 ROTACIÓN:

12 = El inventario se vende y renueva 12 veces/año
6 = Se renueva cada 2 meses
2 = Se renueva cada 6 meses

Mayor rotación = Mejor (menos capital inmovilizado)
*/

-- Días para vender el inventario
Días Rotación =
    DIVIDE(365, [Rotación Inventario], 0)
```

### Stock Out (Quiebres de Stock)

```dax
-- TASA DE QUIEBRE DE STOCK

Tasa Stock Out % =
VAR DíasConStock =
    CALCULATE(
        COUNTROWS('Inventario'),
        'Inventario'[UnidadesStock] > 0
    )

VAR DíasTotales =
    COUNTROWS('Calendario')

RETURN
    (1 - DIVIDE(DíasConStock, DíasTotales, 0)) * 100

/*
📝 STOCK OUT:

5% = 95% de disponibilidad (EXCELENTE)
10% = 90% de disponibilidad (BUENO)
20% = 80% de disponibilidad (POBRE)

Objetivo: < 5%
*/

-- Ventas perdidas por stock out
Ventas Perdidas Stock Out =
VAR DíasSinStock =
    CALCULATE(
        COUNTROWS('Calendario'),
        FILTER(
            'Inventario',
            'Inventario'[UnidadesStock] = 0
        )
    )

VAR VentaDiaria = [Unidades Sell-Out] / 365

RETURN
    DíasSinStock * VentaDiaria * AVERAGE('Productos'[PrecioLista])
```

---

## 💎 KPIs de Rentabilidad

### Margen Bruto

```dax
-- COSTO DE VENTAS
Costo de Ventas =
    SUMX(
        'Ventas',
        'Ventas'[Cantidad] *
        RELATED('Productos'[CostoUnitario])
    )

-- MARGEN BRUTO EN PESOS
Margen Bruto =
    [Total Ventas] - [Costo de Ventas]

-- MARGEN BRUTO %
Margen Bruto % =
    DIVIDE(
        [Margen Bruto],
        [Total Ventas],
        0
    ) * 100

/*
📝 MARGEN TÍPICO EN RETAIL:

Electrónicos: 15-25%
Ropa: 40-60%
Alimentos: 20-30%
Lujo: 60-80%
*/

-- MARKUP
Markup % =
    DIVIDE(
        [Margen Bruto],
        [Costo de Ventas],
        0
    ) * 100
```

### GMROI (Gross Margin Return on Investment)

```dax
-- GMROI: Retorno de margen sobre inversión en inventario

GMROI =
VAR MargenBruto = [Margen Bruto]
VAR CostoInventarioPromedio =
    AVERAGE('Inventario'[CostoInventario])

RETURN
    DIVIDE(MargenBruto, CostoInventarioPromedio, 0)

/*
📝 GMROI:

3.0 = Por cada $1 invertido en inventario, generas $3 de margen
1.5 = $1.50 de margen por $1 invertido
< 1.0 = PÉRDIDA (mal negocio)

Objetivo: > 2.0
*/
```

---

## 🎨 Dashboard Completo de Retail

```dax
-- ═══════════════════════════════════════
-- 📊 KPIs PRINCIPALES
-- ═══════════════════════════════════════

-- 1. VENTAS Y CRECIMIENTO
Total Ventas = SUM('Ventas'[MontoTotal])

Ventas YoY % =
    DIVIDE(
        [Total Ventas] - [Ventas Año Anterior],
        [Ventas Año Anterior],
        0
    ) * 100

-- 2. UNIDADES Y TICKETS
Unidades Vendidas = SUM('Ventas'[Cantidad])

Ticket Promedio =
    DIVIDE([Total Ventas], COUNTROWS('Ventas'), 0)

UPT (Unidades por Transacción) =
    DIVIDE([Unidades Vendidas], COUNTROWS('Ventas'), 0)

-- 3. RENTABILIDAD
Margen Bruto % =
    DIVIDE([Total Ventas] - [Costo de Ventas], [Total Ventas], 0) * 100

-- 4. MARKET SHARE
Market Share % =
    DIVIDE([Total Ventas], [Ventas Mercado Total], 0) * 100

-- 5. INVENTARIO
Días Inventario =
    DIVIDE(SUM('Inventario'[Unidades]), [Venta Diaria], 0)

Sell-Through % =
    DIVIDE([Sell-Out], [Sell-In], 0) * 100

-- 6. EFICIENCIA
Ventas por m² =
    DIVIDE([Total Ventas], SUM('Tiendas'[MetrosCuadrados]), 0)

Productividad por Empleado =
    DIVIDE([Total Ventas], SUM('Tiendas'[NumEmpleados]), 0)

-- 7. MIX DE PRODUCTO
% Ventas Categoría A =
    DIVIDE(
        CALCULATE([Total Ventas], 'Productos'[ABC] = "A"),
        [Total Ventas],
        0
    ) * 100
```

---

## 🎯 Casos de Uso Específicos

### Detección de Tendencias

```dax
-- Productos con crecimiento acelerado

Aceleración Ventas % =
VAR Ventas3MesesAtras =
    CALCULATE(
        [Total Ventas],
        DATEADD('Calendario'[Fecha], -3, MONTH)
    )

VAR VentasActuales = [Total Ventas]

RETURN
    DIVIDE(
        (VentasActuales - Ventas3MesesAtras) / Ventas3MesesAtras,
        3,  -- 3 meses
        0
    ) * 100

-- Productos en tendencia
Es Tendencia =
    IF([Aceleración Ventas %] > 10, "📈 En tendencia", "")
```

### Price Elasticity (Elasticidad de Precio)

```dax
-- Cambio en ventas por cambio en precio

Elasticidad Precio =
VAR PrecioAnterior =
    CALCULATE(
        AVERAGE('Ventas'[PrecioUnitario]),
        DATEADD('Calendario'[Fecha], -1, MONTH)
    )

VAR PrecioActual = AVERAGE('Ventas'[PrecioUnitario])

VAR CambioPrecio% =
    DIVIDE(PrecioActual - PrecioAnterior, PrecioAnterior, 0)

VAR VentasAnteriores =
    CALCULATE(
        [Unidades Vendidas],
        DATEADD('Calendario'[Fecha], -1, MONTH)
    )

VAR CambioVentas% =
    DIVIDE(
        [Unidades Vendidas] - VentasAnteriores,
        VentasAnteriores,
        0
    )

RETURN
    DIVIDE(CambioVentas%, CambioPrecio%, 0)

/*
📝 ELASTICIDAD:

-1.5 = 1% aumento de precio → 1.5% caída en unidades (elástico)
-0.5 = 1% aumento de precio → 0.5% caída en unidades (inelástico)

Productos elásticos (|E| > 1): Sensibles al precio
Productos inelásticos (|E| < 1): Poco sensibles al precio
*/
```

---

## 💡 Tips para KPIs de Retail

### ✅ DO (Hacer)

1. **Combina métricas de volumen y valor**
   - Unidades + Monto
   - Transacciones + Ticket promedio

2. **Usa benchmarks de la industria**
   - Compara con estándares del sector

3. **Segmenta siempre**
   - Por categoría, tienda, región, tiempo

4. **Monitorea tendencias, no solo absolutos**
   - YoY%, MoM%, WoW%

### ❌ DON'T (No Hacer)

1. **No ignores estacionalidad**
2. **No compares períodos incomparables**
3. **No te enfoques solo en ventas**

---

## 🎓 Resumen

✅ Sell-Out, Sell-In, Sell-Through
✅ Market Share y rankings
✅ Análisis ABC/Pareto
✅ Cohort analysis
✅ Métricas de inventario
✅ Rentabilidad y GMROI
✅ KPIs operacionales

### Próximo Módulo:
📚 **Módulo 6: Optimización y Mejores Prácticas**

---

**[⬅️ Módulo 4](04_time_intelligence.md) | [➡️ Módulo 6](06_optimizacion.md)**

*Módulo 5 de 6*
