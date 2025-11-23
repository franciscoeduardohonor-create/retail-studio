# 🎓 Proyecto Final: Dashboard de Análisis de Ventas Retail

## 📋 Descripción del Proyecto

Este es tu **proyecto final integrador** donde aplicarás todo lo aprendido en el curso. Crearás un dashboard completo de análisis de ventas desde cero, utilizando tanto Power Query como DAX.

---

## 🎯 Objetivos

Al completar este proyecto serás capaz de:
- ✅ Diseñar y construir un modelo de datos completo
- ✅ Limpiar y transformar datos con Power Query
- ✅ Crear medidas DAX avanzadas
- ✅ Desarrollar visualizaciones profesionales
- ✅ Implementar análisis de negocio real

---

## 🏢 Caso de Negocio: MegaRetail Analytics

### Contexto

**MegaRetail** es una cadena nacional de tiendas con:
- 15 sucursales en 5 estados
- 3 canales de venta: Tienda física, Online, Telefónico
- 200+ productos en 10 categorías
- 30,000+ clientes registrados
- Equipo de 50 vendedores

### Tu Misión

El Director Comercial necesita un **Dashboard Ejecutivo** para:
1. Monitorear ventas en tiempo real
2. Identificar tendencias y oportunidades
3. Evaluar rendimiento de vendedores y productos
4. Segmentar clientes eficientemente
5. Tomar decisiones basadas en datos

---

## 📊 Estructura del Proyecto

### Fase 1: Preparación de Datos (Power Query)
### Fase 2: Modelo de Datos (Relaciones)
### Fase 3: Medidas DAX (Cálculos)
### Fase 4: Visualizaciones (Dashboards)
### Fase 5: Optimización (Rendimiento)

---

## 🔧 Fase 1: Preparación de Datos

### 1.1 Cargar y Limpiar Ventas

```m
// ==========================================
// QUERY: Ventas
// ==========================================

let
    // 1. CARGAR DATOS
    Fuente = Folder.Files("C:\MegaRetail\Ventas"),

    // 2. FILTRAR SOLO CSVs
    FiltrarCSV = Table.SelectRows(
        Fuente,
        each Text.EndsWith([Name], ".csv")
    ),

    // 3. COMBINAR TODOS LOS ARCHIVOS
    CombinarArchivos = Table.AddColumn(
        FiltrarCSV,
        "Datos",
        each Csv.Document([Content], [Delimiter=",", Encoding=65001])
    ),

    ExpandirDatos = Table.ExpandTableColumn(
        CombinarArchivos,
        "Datos",
        {"Column1", "Column2", "Column3", "Column4", "Column5", "Column6", "Column7", "Column8"},
        {"Column1", "Column2", "Column3", "Column4", "Column5", "Column6", "Column7", "Column8"}
    ),

    // 4. PROMOVER ENCABEZADOS (del primer archivo)
    PrimeraFila = Table.Skip(ExpandirDatos, 0){0},
    Encabezados = Table.PromoteHeaders(ExpandirDatos),

    // 5. CAMBIAR TIPOS DE DATOS
    TiposCambiados = Table.TransformColumnTypes(
        Encabezados,
        {
            {"VentaID", Int64.Type},
            {"Fecha", type date},
            {"ProductoID", Int64.Type},
            {"ClienteID", Int64.Type},
            {"VendedorID", Int64.Type},
            {"SucursalID", Int64.Type},
            {"Canal", type text},
            {"Cantidad", Int64.Type},
            {"PrecioUnitario", type number},
            {"Descuento", type number}
        }
    ),

    // 6. LIMPIAR DATOS
    // Reemplazar nulos en Descuento
    ReemplazarNulosDescuento = Table.ReplaceValue(
        TiposCambiados,
        null,
        0,
        Replacer.ReplaceValue,
        {"Descuento"}
    ),

    // Filtrar fechas válidas
    FiltrarFechas = Table.SelectRows(
        ReemplazarNulosDescuento,
        each [Fecha] >= #date(2024, 1, 1) and [Fecha] <= #date(2025, 12, 31)
    ),

    // Filtrar cantidades positivas
    FiltrarCantidades = Table.SelectRows(
        FiltrarFechas,
        each [Cantidad] > 0
    ),

    // 7. AGREGAR COLUMNAS CALCULADAS
    AgregarSubtotal = Table.AddColumn(
        FiltrarCantidades,
        "Subtotal",
        each [Cantidad] * [PrecioUnitario],
        type number
    ),

    AgregarMontoDescuento = Table.AddColumn(
        AgregarSubtotal,
        "MontoDescuento",
        each [Subtotal] * [Descuento],
        type number
    ),

    AgregarTotal = Table.AddColumn(
        AgregarMontoDescuento,
        "Total",
        each [Subtotal] - [MontoDescuento],
        type number
    ),

    // 8. AGREGAR COLUMNAS DE TIEMPO
    AgregarAño = Table.AddColumn(
        AgregarTotal,
        "Año",
        each Date.Year([Fecha]),
        Int64.Type
    ),

    AgregarMes = Table.AddColumn(
        AgregarAño,
        "MesNumero",
        each Date.Month([Fecha]),
        Int64.Type
    ),

    AgregarNombreMes = Table.AddColumn(
        AgregarMes,
        "Mes",
        each Date.MonthName([Fecha]),
        type text
    ),

    AgregarTrimestre = Table.AddColumn(
        AgregarNombreMes,
        "Trimestre",
        each "Q" & Number.ToText(Date.QuarterOfYear([Fecha])),
        type text
    ),

    AgregarDiaSemana = Table.AddColumn(
        AgregarTrimestre,
        "DiaSemana",
        each Date.DayOfWeekName([Fecha]),
        type text
    ),

    // 9. REMOVER COLUMNAS TEMPORALES (si existen)
    ColumnasFinales = Table.SelectColumns(
        AgregarDiaSemana,
        {
            "VentaID", "Fecha", "ProductoID", "ClienteID", "VendedorID",
            "SucursalID", "Canal", "Cantidad", "PrecioUnitario",
            "Descuento", "Subtotal", "MontoDescuento", "Total",
            "Año", "MesNumero", "Mes", "Trimestre", "DiaSemana"
        }
    )
in
    ColumnasFinales
```

---

### 1.2 Cargar y Enriquecer Productos

```m
// ==========================================
// QUERY: Productos
// ==========================================

let
    // Cargar productos
    Fuente = Excel.Workbook(
        File.Contents("C:\MegaRetail\Productos.xlsx"),
        null,
        true
    ),

    HojaProductos = Fuente{[Item="Productos",Kind="Sheet"]}[Data],
    Encabezados = Table.PromoteHeaders(HojaProductos),

    // Tipos de datos
    TiposCambiados = Table.TransformColumnTypes(
        Encabezados,
        {
            {"ProductoID", Int64.Type},
            {"SKU", type text},
            {"NombreProducto", type text},
            {"CategoriaID", Int64.Type},
            {"Marca", type text},
            {"Precio", type number},
            {"Costo", type number},
            {"Stock", Int64.Type},
            {"StockMinimo", Int64.Type},
            {"Proveedor", type text}
        }
    ),

    // MERGE con Categorías
    Categorias = Excel.Workbook(
        File.Contents("C:\MegaRetail\Categorias.xlsx"),
        null,
        true
    ){[Item="Categorias",Kind="Sheet"]}[Data],

    EncabezadosCat = Table.PromoteHeaders(Categorias),

    MergeCategorias = Table.NestedJoin(
        TiposCambiados,
        {"CategoriaID"},
        EncabezadosCat,
        {"CategoriaID"},
        "Categoria",
        JoinKind.LeftOuter
    ),

    ExpandirCategoria = Table.ExpandTableColumn(
        MergeCategorias,
        "Categoria",
        {"NombreCategoria", "Departamento"},
        {"Categoria", "Departamento"}
    ),

    // COLUMNAS CALCULADAS
    AgregarMargen = Table.AddColumn(
        ExpandirCategoria,
        "Margen",
        each [Precio] - [Costo],
        type number
    ),

    AgregarMargenPct = Table.AddColumn(
        AgregarMargen,
        "MargenPct",
        each try ([Margen] / [Precio]) otherwise 0,
        type number
    ),

    AgregarValorInventario = Table.AddColumn(
        AgregarMargenPct,
        "ValorInventario",
        each [Precio] * [Stock],
        type number
    ),

    // Clasificación de precio
    AgregarRangoPrecio = Table.AddColumn(
        AgregarValorInventario,
        "RangoPrecio",
        each if [Precio] >= 10000 then "Premium"
             else if [Precio] >= 1000 then "Medio"
             else "Económico",
        type text
    ),

    // Estado de stock
    AgregarEstadoStock = Table.AddColumn(
        AgregarRangoPrecio,
        "EstadoStock",
        each if [Stock] = 0 then "Sin Stock"
             else if [Stock] < [StockMinimo] then "Stock Bajo"
             else if [Stock] < [StockMinimo] * 2 then "Stock Normal"
             else "Sobr股",
        type text
    )
in
    AgregarEstadoStock
```

---

### 1.3 Función Personalizada: Calcular Costo con IVA

```m
// ==========================================
// FUNCIÓN: CalcularPrecioFinal
// ==========================================

let
    CalcularPrecioFinal = (
        precio as number,
        descuento as number,
        incluirIVA as logical
    ) as number =>
    let
        PrecioConDescuento = precio * (1 - descuento),
        PrecioFinal = if incluirIVA then
                          PrecioConDescuento * 1.16
                      else
                          PrecioConDescuento
    in
        PrecioFinal
in
    CalcularPrecioFinal
```

---

### 1.4 Crear Tabla de Calendario

```m
// ==========================================
// QUERY: Calendario
// ==========================================

let
    FechaInicio = #date(2024, 1, 1),
    FechaFin = #date(2025, 12, 31),

    // Generar rango de fechas
    ListaFechas = List.Dates(
        FechaInicio,
        Duration.Days(FechaFin - FechaInicio) + 1,
        #duration(1, 0, 0, 0)
    ),

    // Convertir a tabla
    TablaFechas = Table.FromList(
        ListaFechas,
        Splitter.SplitByNothing(),
        {"Fecha"},
        null,
        ExtraValues.Error
    ),

    // Cambiar tipo
    CambiarTipo = Table.TransformColumnTypes(
        TablaFechas,
        {{"Fecha", type date}}
    ),

    // AGREGAR TODAS LAS COLUMNAS DE TIEMPO
    AgregarAño = Table.AddColumn(CambiarTipo, "Año", each Date.Year([Fecha]), Int64.Type),
    AgregarMes = Table.AddColumn(AgregarAño, "MesNumero", each Date.Month([Fecha]), Int64.Type),
    AgregarNombreMes = Table.AddColumn(AgregarMes, "Mes", each Date.MonthName([Fecha]), type text),
    AgregarMesCorto = Table.AddColumn(AgregarNombreMes, "MesCorto", each Text.Start([Mes], 3), type text),
    AgregarTrimestre = Table.AddColumn(AgregarMesCorto, "Trimestre", each Date.QuarterOfYear([Fecha]), Int64.Type),
    AgregarTrimestreTexto = Table.AddColumn(AgregarTrimestre, "TrimestreNombre", each "Q" & Number.ToText([Trimestre]), type text),
    AgregarSemanaAño = Table.AddColumn(AgregarTrimestreTexto, "SemanaAño", each Date.WeekOfYear([Fecha]), Int64.Type),
    AgregarDiaAño = Table.AddColumn(AgregarSemanaAño, "DiaAño", each Date.DayOfYear([Fecha]), Int64.Type),
    AgregarDiaMes = Table.AddColumn(AgregarDiaAño, "DiaMes", each Date.Day([Fecha]), Int64.Type),
    AgregarDiaSemana = Table.AddColumn(AgregarDiaMes, "DiaSemanaNum", each Date.DayOfWeek([Fecha], Day.Monday), Int64.Type),
    AgregarNombreDia = Table.AddColumn(AgregarDiaSemana, "DiaSemana", each Date.DayOfWeekName([Fecha]), type text),
    AgregarDiaCorto = Table.AddColumn(AgregarNombreDia, "DiaCorto", each Text.Start([DiaSemana], 3), type text),

    // Banderas útiles
    AgregarEsFinSemana = Table.AddColumn(
        AgregarDiaCorto,
        "EsFinSemana",
        each [DiaSemanaNum] >= 5,
        type logical
    ),

    AgregarEsLaborable = Table.AddColumn(
        AgregarEsFinSemana,
        "EsDiaLaborable",
        each not [EsFinSemana],
        type logical
    ),

    // Año-Mes para ordenar
    AgregarAñoMes = Table.AddColumn(
        AgregarEsLaborable,
        "AñoMes",
        each Text.From([Año]) & "-" & Text.PadStart(Text.From([MesNumero]), 2, "0"),
        type text
    ),

    // Inicio y fin de mes
    AgregarInicioMes = Table.AddColumn(
        AgregarAñoMes,
        "InicioMes",
        each Date.StartOfMonth([Fecha]),
        type date
    ),

    AgregarFinMes = Table.AddColumn(
        AgregarInicioMes,
        "FinMes",
        each Date.EndOfMonth([Fecha]),
        type date
    )
in
    AgregarFinMes
```

---

## 📐 Fase 2: Modelo de Datos

### 2.1 Esquema de Relaciones

Crea las siguientes relaciones en el modelo:

```
Calendario (1) -----> (*) Ventas  [Fecha]
Productos (1) -------> (*) Ventas  [ProductoID]
Clientes (1) --------> (*) Ventas  [ClienteID]
Vendedores (1) ------> (*) Ventas  [VendedorID]
Sucursales (1) ------> (*) Ventas  [SucursalID]
```

**Importante**:
- Todas las relaciones son **1:Many**
- La tabla de **Hechos** es **Ventas**
- Las tablas de **Dimensiones** son: Calendario, Productos, Clientes, Vendedores, Sucursales

---

## 📊 Fase 3: Medidas DAX

### 3.1 Medidas Básicas

```dax
// ==========================================
// TABLA DE MEDIDAS: _Medidas
// ==========================================
// Crea una tabla vacía para organizar tus medidas

// ==========================================
// VENTAS - BÁSICAS
// ==========================================

Total Ventas = SUM(Ventas[Total])

Total Unidades = SUM(Ventas[Cantidad])

Num Transacciones = COUNTROWS(Ventas)

Ticket Promedio =
DIVIDE(
    [Total Ventas],
    [Num Transacciones],
    0
)

Precio Promedio =
DIVIDE(
    [Total Ventas],
    [Total Unidades],
    0
)

// ==========================================
// COSTOS Y MÁRGENES
// ==========================================

Total Costos =
SUMX(
    Ventas,
    Ventas[Cantidad] * RELATED(Productos[Costo])
)

Utilidad Bruta = [Total Ventas] - [Total Costos]

Margen Bruto % =
DIVIDE(
    [Utilidad Bruta],
    [Total Ventas],
    0
) * 100

Total Descuentos = SUM(Ventas[MontoDescuento])

% Descuento Promedio =
DIVIDE(
    [Total Descuentos],
    SUM(Ventas[Subtotal]),
    0
) * 100
```

---

### 3.2 Time Intelligence

```dax
// ==========================================
// TIME INTELLIGENCE
// ==========================================

// YTD (Year-to-Date)
Ventas YTD =
TOTALYTD(
    [Total Ventas],
    Calendario[Fecha]
)

// MTD (Month-to-Date)
Ventas MTD =
TOTALMTD(
    [Total Ventas],
    Calendario[Fecha]
)

// QTD (Quarter-to-Date)
Ventas QTD =
TOTALQTD(
    [Total Ventas],
    Calendario[Fecha]
)

// Mes Anterior
Ventas Mes Anterior =
CALCULATE(
    [Total Ventas],
    DATEADD(Calendario[Fecha], -1, MONTH)
)

// Crecimiento MoM
Crecimiento MoM =
VAR Actual = [Total Ventas]
VAR Anterior = [Ventas Mes Anterior]
RETURN
    Actual - Anterior

% Crecimiento MoM =
DIVIDE(
    [Crecimiento MoM],
    [Ventas Mes Anterior],
    0
) * 100

// Año Anterior
Ventas Año Anterior =
CALCULATE(
    [Total Ventas],
    SAMEPERIODLASTYEAR(Calendario[Fecha])
)

// Crecimiento YoY
Crecimiento YoY = [Total Ventas] - [Ventas Año Anterior]

% Crecimiento YoY =
DIVIDE(
    [Crecimiento YoY],
    [Ventas Año Anterior],
    0
) * 100

// Promedio Móvil
Promedio Movil 3M =
CALCULATE(
    [Total Ventas],
    DATESINPERIOD(
        Calendario[Fecha],
        LASTDATE(Calendario[Fecha]),
        -3,
        MONTH
    )
) / 3

Promedio Movil 12M =
CALCULATE(
    [Total Ventas],
    DATESINPERIOD(
        Calendario[Fecha],
        LASTDATE(Calendario[Fecha]),
        -12,
        MONTH
    )
) / 12
```

---

### 3.3 Análisis por Dimensiones

```dax
// ==========================================
// ANÁLISIS POR CANAL
// ==========================================

Ventas Tienda =
CALCULATE(
    [Total Ventas],
    Ventas[Canal] = "Tienda"
)

Ventas Online =
CALCULATE(
    [Total Ventas],
    Ventas[Canal] = "Online"
)

Ventas Telefono =
CALCULATE(
    [Total Ventas],
    Ventas[Canal] = "Telefónico"
)

% Ventas Online =
DIVIDE(
    [Ventas Online],
    [Total Ventas],
    0
) * 100

// ==========================================
// ANÁLISIS DE PRODUCTOS
// ==========================================

Num Productos Vendidos =
DISTINCTCOUNT(Ventas[ProductoID])

Productos Sin Ventas =
CALCULATE(
    COUNTROWS(Productos),
    FILTER(
        Productos,
        ISBLANK([Total Ventas])
    )
)

Rotacion Inventario =
DIVIDE(
    [Total Costos],
    SUMX(
        Productos,
        Productos[Costo] * Productos[Stock]
    ),
    0
)

// ==========================================
// RANKINGS
// ==========================================

Ranking Producto =
VAR VentasActual = [Total Ventas]
RETURN
    COUNTROWS(
        FILTER(
            ALL(Productos[NombreProducto]),
            [Total Ventas] > VentasActual
        )
    ) + 1

Es Top 10 Productos =
IF([Ranking Producto] <= 10, "Top 10", "Otros")

Ventas Top 10 Productos =
CALCULATE(
    [Total Ventas],
    TOPN(
        10,
        ALL(Productos[NombreProducto]),
        [Total Ventas],
        DESC
    )
)

% Top 10 =
DIVIDE(
    [Ventas Top 10 Productos],
    CALCULATE([Total Ventas], ALL(Productos)),
    0
) * 100
```

---

### 3.4 Análisis de Clientes (RFM)

```dax
// ==========================================
// ANÁLISIS RFM
// ==========================================

// Recencia (días desde última compra)
Recencia =
VAR UltimaCompra = MAX(Ventas[Fecha])
VAR Hoy = TODAY()
RETURN
    DATEDIFF(UltimaCompra, Hoy, DAY)

// Frecuencia (número de compras)
Frecuencia = COUNTROWS(Ventas)

// Monto (total gastado)
Monto = [Total Ventas]

// Puntuación RFM
Score RFM =
VAR R = [Recencia]
VAR F = [Frecuencia]
VAR M = [Monto]
VAR ScoreR = IF(R <= 30, 5, IF(R <= 60, 4, IF(R <= 90, 3, IF(R <= 180, 2, 1))))
VAR ScoreF = IF(F >= 20, 5, IF(F >= 10, 4, IF(F >= 5, 3, IF(F >= 2, 2, 1))))
VAR ScoreM = IF(M >= 100000, 5, IF(M >= 50000, 4, IF(M >= 20000, 3, IF(M >= 5000, 2, 1))))
RETURN
    ScoreR + ScoreF + ScoreM

// Segmento RFM
Segmento RFM =
VAR Score = [Score RFM]
RETURN
    SWITCH(
        TRUE(),
        Score >= 13, "🏆 Champions",
        Score >= 10, "⭐ Loyal Customers",
        Score >= 7, "📈 Potential Loyalists",
        Score >= 5, "🔔 At Risk",
        "❌ Lost"
    )

// Clientes Activos (compraron en últimos 90 días)
Clientes Activos =
CALCULATE(
    DISTINCTCOUNT(Ventas[ClienteID]),
    Ventas[Fecha] >= TODAY() - 90
)

// Clientes Nuevos (primera compra en últimos 30 días)
Clientes Nuevos =
VAR FechaCorte = TODAY() - 30
RETURN
    CALCULATE(
        DISTINCTCOUNT(Ventas[ClienteID]),
        FILTER(
            ALL(Ventas[ClienteID]),
            CALCULATE(MIN(Ventas[Fecha])) >= FechaCorte
        )
    )

// CLV Simple (Customer Lifetime Value)
CLV =
VAR TicketPromedio = [Ticket Promedio]
VAR FrecuenciaPromedio = DIVIDE([Num Transacciones], DISTINCTCOUNT(Ventas[ClienteID]), 0)
VAR VidaPromedio = 36 // meses estimados
RETURN
    TicketPromedio * FrecuenciaPromedio * (VidaPromedio / 12)
```

---

### 3.5 KPIs y Metas

```dax
// ==========================================
// KPIS Y METAS
// ==========================================

// Meta de Ventas (ejemplo: 10% más que año anterior)
Meta Ventas =
[Ventas Año Anterior] * 1.10

// % Cumplimiento de Meta
% Cumplimiento Meta =
DIVIDE(
    [Total Ventas],
    [Meta Ventas],
    0
) * 100

// Estado de Meta
Estado Meta =
VAR Cumplimiento = [% Cumplimiento Meta]
RETURN
    SWITCH(
        TRUE(),
        Cumplimiento >= 100, "✅ Cumplido",
        Cumplimiento >= 90, "⚠️ Cerca",
        "❌ Por debajo"
    )

// Indicador de Tendencia
Indicador Tendencia =
VAR Crecimiento = [% Crecimiento MoM]
RETURN
    IF(
        Crecimiento > 5,
        "📈 Creciendo",
        IF(
            Crecimiento < -5,
            "📉 Decreciendo",
            "➡️ Estable"
        )
    )
```

---

## 🎨 Fase 4: Visualizaciones

### Dashboard 1: Resumen Ejecutivo

**Página**: Portada / Overview

**Visuales**:
1. **Tarjetas KPI** (4 tarjetas):
   - Total Ventas
   - vs Mes Anterior (con indicador ▲/▼)
   - vs Año Anterior (con indicador ▲/▼)
   - % Cumplimiento Meta

2. **Gráfico de Líneas**: Tendencia Mensual
   - Eje X: Mes
   - Eje Y: Total Ventas
   - Línea adicional: Promedio Móvil 3M
   - Línea adicional: Ventas Año Anterior

3. **Gráfico de Barras**: Top 10 Productos
   - Eje Y: Producto
   - Eje X: Total Ventas
   - Color: Por categoría

4. **Gráfico de Donas**: Ventas por Canal
   - Valores: % por canal
   - Leyenda: Canal (Tienda, Online, Telefónico)

5. **Tabla**: Resumen por Categoría
   - Categoría
   - Total Ventas
   - Margen %
   - % del Total

6. **Slicers**:
   - Año
   - Trimestre
   - Mes
   - Sucursal

---

### Dashboard 2: Análisis de Productos

**Visuales**:
1. **Matriz**: Ventas por Categoría y Mes
2. **Scatter Plot**: Precio vs Margen %
3. **Gráfico de Barras Apiladas**: Ventas por Categoría y Canal
4. **Tabla**: Productos con Stock Bajo
5. **Gráfico de Cascada**: Contribución al Total por Producto

---

### Dashboard 3: Análisis de Clientes

**Visuales**:
1. **Matriz RFM**: Segmentación de clientes
2. **Gráfico de Embudo**: Customer Journey
3. **Tarjetas**: Clientes Activos, Nuevos, En Riesgo
4. **Gráfico de Barras**: Top 20 Clientes por Ventas
5. **Tabla**: Clientes VIP con detalle

---

### Dashboard 4: Análisis de Vendedores

**Visuales**:
1. **Ranking de Vendedores**
2. **Cumplimiento de Cuota**
3. **Tendencia Individual**
4. **Comparación de Equipo**

---

## ⚡ Fase 5: Optimización

### 5.1 Buenas Prácticas

```dax
// ❌ EVITAR: Columnas calculadas cuando puedes usar medidas
PrecioTotal (Columna) = Ventas[Cantidad] * Ventas[Precio]  // Ocupa memoria

// ✅ MEJOR: Medida
Total Ventas = SUMX(Ventas, Ventas[Cantidad] * Ventas[Precio])  // No ocupa memoria

// ❌ EVITAR: FILTER innecesario
Ventas 2025 v1 = CALCULATE([Total Ventas], FILTER(ALL(Calendario), Calendario[Año] = 2025))

// ✅ MEJOR: Filtro directo
Ventas 2025 v2 = CALCULATE([Total Ventas], Calendario[Año] = 2025)

// ✅ SIEMPRE: Usar variables
Margen Optimizado =
VAR Ventas = [Total Ventas]
VAR Costos = [Total Costos]
VAR Utilidad = Ventas - Costos
VAR Margen = DIVIDE(Utilidad, Ventas, 0)
RETURN
    Margen * 100
```

### 5.2 Checklist de Optimización

- [ ] Eliminar columnas calculadas innecesarias
- [ ] Usar variables en medidas complejas
- [ ] Evitar FILTER cuando sea posible
- [ ] Reducir cardinalidad de columnas
- [ ] Establecer relaciones correctamente
- [ ] Usar tipos de datos apropiados
- [ ] Marcar tabla de calendario como tabla de fechas

---

## 🎯 Criterios de Evaluación

Tu proyecto será evaluado en:

### Funcionalidad (40%)
- ✅ Modelo de datos correcto
- ✅ Medidas DAX funcionando
- ✅ Time Intelligence implementado
- ✅ Filtros y slicers interactivos

### Diseño (30%)
- ✅ Dashboards organizados y lógicos
- ✅ Visuales apropiados para cada análisis
- ✅ Colores y formato profesional
- ✅ Navegación clara entre páginas

### Código (20%)
- ✅ Código limpio y comentado
- ✅ Nomenclatura consistente
- ✅ Optimización aplicada
- ✅ Uso de variables

### Valor de Negocio (10%)
- ✅ Insights accionables
- ✅ KPIs relevantes
- ✅ Análisis útil para toma de decisiones

---

## 📦 Entregables

1. **Archivo .pbix** con:
   - Modelo de datos completo
   - Todas las medidas DAX
   - 4 dashboards funcionales

2. **Documento de análisis** (PDF o Word):
   - Insights principales encontrados
   - Recomendaciones de negocio
   - Próximos pasos sugeridos

3. **Código documentado**:
   - Scripts de Power Query (texto)
   - Medidas DAX (texto)
   - Explicaciones de decisiones técnicas

---

## 🎉 ¡Felicidades!

Al completar este proyecto habrás demostrado dominio de:
- ✅ Power Query para ETL
- ✅ Modelado de datos dimensional
- ✅ DAX básico, intermedio y avanzado
- ✅ Diseño de dashboards profesionales
- ✅ Análisis de negocio aplicado

**¡Estás listo para trabajar profesionalmente con Power BI!** 🚀

---

## 📚 Recursos Adicionales

- [Documentación oficial de Power BI](https://docs.microsoft.com/power-bi/)
- [DAX Guide](https://dax.guide/)
- [SQLBI - Expertos en DAX](https://www.sqlbi.com/)
- [Comunidad de Power BI](https://community.powerbi.com/)

---

**¿Tienes preguntas?** Revisa los módulos del curso o practica con los ejercicios intermedios antes de abordar este proyecto final.

**¡Mucho éxito!** 💪
