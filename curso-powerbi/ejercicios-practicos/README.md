# 💼 Ejercicios Prácticos - Curso Power BI

## 🎯 Objetivo

Esta sección contiene ejercicios prácticos integrados que combinan Power Query M y DAX para resolver problemas reales de negocio.

---

## 📁 Datos de Ejemplo

Para estos ejercicios, usaremos datos de una tienda de electrónica retail. Los datos simulan un negocio real con:

- **Ventas**: Transacciones diarias
- **Productos**: Catálogo de productos
- **Clientes**: Base de clientes
- **Vendedores**: Equipo de ventas
- **Fechas**: 2024-2025

---

## 🏪 Caso de Estudio: ElectroTech Store

### Contexto del Negocio

**ElectroTech Store** es una cadena de tiendas de electrónica con:
- 3 sucursales (Norte, Sur, Centro)
- Catálogo de 50+ productos
- Equipo de 12 vendedores
- Ventas online y presenciales

**Tu rol**: Analista de Datos que debe crear un dashboard ejecutivo.

---

## 📊 Ejercicio 1: Preparación de Datos (Power Query)

### Objetivo
Limpiar y transformar los datos crudos para análisis.

### Tareas

#### 1.1 Limpiar Tabla de Ventas

**Archivo**: `ventas_raw.csv`

**Problemas a resolver**:
- Fechas en formato texto
- Nombres de productos inconsistentes
- Valores nulos en descuento
- Columna "Total" falta (calcularla)

**Código Power Query**:

```m
let
    // Cargar datos crudos
    Fuente = Csv.Document(
        File.Contents("C:\CursoPowerBI\Datos\ventas_raw.csv"),
        [Delimiter=",", Encoding=65001]
    ),

    // Promover encabezados
    Encabezados = Table.PromoteHeaders(Fuente),

    // Cambiar tipos de datos
    TiposCambiados = Table.TransformColumnTypes(
        Encabezados,
        {
            {"VentaID", Int64.Type},
            {"Fecha", type date},
            {"ProductoID", Int64.Type},
            {"ClienteID", Int64.Type},
            {"VendedorID", Int64.Type},
            {"Cantidad", Int64.Type},
            {"PrecioUnitario", type number},
            {"Descuento", type number}
        }
    ),

    // Reemplazar valores nulos en Descuento por 0
    ReemplazarNulos = Table.ReplaceValue(
        TiposCambiados,
        null,
        0,
        Replacer.ReplaceValue,
        {"Descuento"}
    ),

    // Agregar columna de Subtotal
    AgregarSubtotal = Table.AddColumn(
        ReemplazarNulos,
        "Subtotal",
        each [Cantidad] * [PrecioUnitario],
        type number
    ),

    // Agregar columna de Total (con descuento)
    AgregarTotal = Table.AddColumn(
        AgregarSubtotal,
        "Total",
        each [Subtotal] * (1 - [Descuento]),
        type number
    ),

    // Agregar columnas de tiempo
    AgregarAño = Table.AddColumn(AgregarTotal, "Año", each Date.Year([Fecha]), Int64.Type),
    AgregarMes = Table.AddColumn(AgregarAño, "Mes", each Date.Month([Fecha]), Int64.Type),
    AgregarNombreMes = Table.AddColumn(AgregarMes, "NombreMes", each Date.MonthName([Fecha]), type text),
    AgregarTrimestre = Table.AddColumn(AgregarNombreMes, "Trimestre", each "Q" & Number.ToText(Date.QuarterOfYear([Fecha])), type text)
in
    AgregarTrimestre
```

---

#### 1.2 Combinar Productos con Categorías

**Objetivo**: Hacer merge de Productos con Categorías.

```m
let
    // Tabla de Productos
    Productos = Excel.Workbook(
        File.Contents("C:\CursoPowerBI\Datos\productos.xlsx"),
        null,
        true
    ){[Item="Productos",Kind="Sheet"]}[Data],

    EncabezadosProductos = Table.PromoteHeaders(Productos),

    // Tabla de Categorías
    Categorias = Excel.Workbook(
        File.Contents("C:\CursoPowerBI\Datos\categorias.xlsx"),
        null,
        true
    ){[Item="Categorias",Kind="Sheet"]}[Data],

    EncabezadosCategorias = Table.PromoteHeaders(Categorias),

    // Merge: Productos + Categorías
    Merge = Table.NestedJoin(
        EncabezadosProductos,
        {"CategoriaID"},
        EncabezadosCategorias,
        {"CategoriaID"},
        "Categoria",
        JoinKind.LeftOuter
    ),

    // Expandir información de categoría
    Expandir = Table.ExpandTableColumn(
        Merge,
        "Categoria",
        {"NombreCategoria", "Departamento"},
        {"Categoria", "Departamento"}
    )
in
    Expandir
```

---

#### 1.3 Función Personalizada: Clasificar Clientes

```m
// Función para clasificar clientes por total de compras
let
    ClasificarCliente = (totalCompras as number) as text =>
        if totalCompras >= 100000 then "VIP"
        else if totalCompras >= 50000 then "Premium"
        else if totalCompras >= 10000 then "Regular"
        else "Nuevo",

    // Aplicar a tabla de clientes
    Clientes = Excel.Workbook(
        File.Contents("C:\CursoPowerBI\Datos\clientes.xlsx"),
        null,
        true
    ){[Item="Clientes",Kind="Sheet"]}[Data],

    Encabezados = Table.PromoteHeaders(Clientes),

    // Agregar clasificación
    ConClasificacion = Table.AddColumn(
        Encabezados,
        "TipoCliente",
        each ClasificarCliente([TotalHistoricoCompras]),
        type text
    )
in
    ConClasificacion
```

---

## 📈 Ejercicio 2: Medidas DAX Básicas

### Objetivo
Crear las medidas fundamentales para el análisis.

### Medidas a Crear

```dax
// ==========================================
// MEDIDAS BÁSICAS
// ==========================================

// 1. Total de Ventas
Total Ventas = SUM(Ventas[Total])

// 2. Total de Unidades Vendidas
Unidades Vendidas = SUM(Ventas[Cantidad])

// 3. Número de Transacciones
Num Transacciones = COUNTROWS(Ventas)

// 4. Ticket Promedio
Ticket Promedio =
DIVIDE(
    [Total Ventas],
    [Num Transacciones],
    0
)

// 5. Precio Promedio por Unidad
Precio Promedio Unidad =
DIVIDE(
    [Total Ventas],
    [Unidades Vendidas],
    0
)

// ==========================================
// MEDIDAS POR CATEGORÍA
// ==========================================

// 6. Ventas de Laptops
Ventas Laptops =
CALCULATE(
    [Total Ventas],
    Productos[Categoria] = "Laptops"
)

// 7. Ventas de Accesorios
Ventas Accesorios =
CALCULATE(
    [Total Ventas],
    Productos[Categoria] = "Accesorios"
)

// 8. % Laptops del Total
% Laptops =
DIVIDE(
    [Ventas Laptops],
    [Total Ventas],
    0
) * 100

// ==========================================
// MEDIDAS DE MARGEN
// ==========================================

// 9. Total Costos
Total Costos =
SUMX(
    Ventas,
    Ventas[Cantidad] * RELATED(Productos[Costo])
)

// 10. Utilidad Bruta
Utilidad Bruta = [Total Ventas] - [Total Costos]

// 11. Margen de Utilidad %
Margen % =
DIVIDE(
    [Utilidad Bruta],
    [Total Ventas],
    0
) * 100
```

---

## ⏰ Ejercicio 3: Time Intelligence

### Objetivo
Crear medidas de análisis temporal.

```dax
// ==========================================
// MEDIDAS DE TIEMPO
// ==========================================

// 1. Ventas YTD (Año hasta la fecha)
Ventas YTD =
TOTALYTD(
    [Total Ventas],
    Calendario[Fecha]
)

// 2. Ventas Mes Anterior
Ventas Mes Anterior =
CALCULATE(
    [Total Ventas],
    DATEADD(Calendario[Fecha], -1, MONTH)
)

// 3. Crecimiento vs Mes Anterior
Crecimiento MoM =
VAR VentasActual = [Total Ventas]
VAR VentasMesAnterior = [Ventas Mes Anterior]
VAR Diferencia = VentasActual - VentasMesAnterior
RETURN
    Diferencia

// 4. % Crecimiento MoM
% Crecimiento MoM =
DIVIDE(
    [Crecimiento MoM],
    [Ventas Mes Anterior],
    0
) * 100

// 5. Ventas Año Anterior
Ventas Año Anterior =
CALCULATE(
    [Total Ventas],
    SAMEPERIODLASTYEAR(Calendario[Fecha])
)

// 6. Crecimiento YoY
Crecimiento YoY = [Total Ventas] - [Ventas Año Anterior]

// 7. % Crecimiento YoY
% Crecimiento YoY =
DIVIDE(
    [Crecimiento YoY],
    [Ventas Año Anterior],
    0
) * 100

// 8. Promedio Móvil 3 Meses
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

// 9. Últimos 7 Días
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

## 🏆 Ejercicio 4: Rankings y Top N

### Objetivo
Identificar los mejores performers.

```dax
// ==========================================
// RANKINGS
// ==========================================

// 1. Ranking de Productos por Ventas
Ranking Producto =
VAR VentasActual = [Total Ventas]
VAR Ranking =
    COUNTROWS(
        FILTER(
            ALL(Productos[NombreProducto]),
            [Total Ventas] > VentasActual
        )
    ) + 1
RETURN
    Ranking

// 2. Es Top 10
Es Top 10 =
IF([Ranking Producto] <= 10, "Top 10", "Otros")

// 3. Ventas Top 10 Productos
Ventas Top 10 =
CALCULATE(
    [Total Ventas],
    FILTER(
        ALL(Productos),
        [Ranking Producto] <= 10
    )
)

// 4. % que representa el Top 10
% Top 10 =
DIVIDE(
    [Ventas Top 10],
    CALCULATE([Total Ventas], ALL(Productos)),
    0
) * 100

// 5. Ranking de Vendedores
Ranking Vendedor =
VAR VentasVendedorActual = [Total Ventas]
VAR Ranking =
    COUNTROWS(
        FILTER(
            ALL(Vendedores[NombreCompleto]),
            [Total Ventas] > VentasVendedorActual
        )
    ) + 1
RETURN
    Ranking

// 6. Mejor Vendedor del Mes
Mejor Vendedor =
VAR VentasMax = MAXX(ALL(Vendedores), [Total Ventas])
RETURN
    CALCULATE(
        VALUES(Vendedores[NombreCompleto]),
        FILTER(
            ALL(Vendedores),
            [Total Ventas] = VentasMax
        )
    )
```

---

## 🎨 Ejercicio 5: Medidas Avanzadas con Variables

### Objetivo
Crear medidas complejas optimizadas.

```dax
// ==========================================
// ANÁLISIS DE CLIENTES
// ==========================================

// 1. Análisis RFM Simplificado
Recencia Cliente =
VAR UltimaCompra = MAX(Ventas[Fecha])
VAR FechaHoy = TODAY()
VAR DiasDesdeCompra = DATEDIFF(UltimaCompra, FechaHoy, DAY)
RETURN
    DiasDesdeCompra

Frecuencia Cliente = COUNTROWS(Ventas)

Monto Cliente = [Total Ventas]

// 2. Clasificación RFM
Clasificacion RFM =
VAR R = [Recencia Cliente]
VAR F = [Frecuencia Cliente]
VAR M = [Monto Cliente]
VAR Puntuacion =
    IF(R <= 30, 3, IF(R <= 90, 2, 1)) +
    IF(F >= 10, 3, IF(F >= 5, 2, 1)) +
    IF(M >= 50000, 3, IF(M >= 10000, 2, 1))
RETURN
    SWITCH(
        TRUE(),
        Puntuacion >= 8, "Champions",
        Puntuacion >= 6, "Loyal",
        Puntuacion >= 4, "Potential",
        "At Risk"
    )

// ==========================================
// ANÁLISIS ABC DE PRODUCTOS
// ==========================================

// 3. % Acumulado de Ventas
% Ventas Acumulado =
VAR VentasActual = [Total Ventas]
VAR TodasLasVentas =
    CALCULATETABLE(
        ADDCOLUMNS(
            VALUES(Productos[NombreProducto]),
            "Ventas", [Total Ventas]
        ),
        ALL(Productos)
    )
VAR ProductosMayores =
    FILTER(
        TodasLasVentas,
        [Ventas] >= VentasActual
    )
VAR VentasAcumuladas = SUMX(ProductosMayores, [Ventas])
VAR VentasTotales = SUMX(TodasLasVentas, [Ventas])
VAR Porcentaje = DIVIDE(VentasAcumuladas, VentasTotales, 0)
RETURN
    Porcentaje * 100

// 4. Clasificación ABC
Clasificacion ABC =
VAR PctAcum = [% Ventas Acumulado]
RETURN
    SWITCH(
        TRUE(),
        PctAcum <= 80, "A",
        PctAcum <= 95, "B",
        "C"
    )

// ==========================================
// ANÁLISIS DE TENDENCIA
// ==========================================

// 5. Tendencia vs Promedio Histórico
vs Promedio Historico =
VAR PromedioHistorico =
    CALCULATE(
        [Total Ventas],
        ALL(Calendario[Fecha])
    ) / DISTINCTCOUNT(Calendario[Mes])
VAR VentasActual = [Total Ventas]
VAR Diferencia = VentasActual - PromedioHistorico
VAR PorcentajeDif = DIVIDE(Diferencia, PromedioHistorico, 0)
RETURN
    PorcentajeDif * 100

// 6. Estado de Tendencia
Estado Tendencia =
VAR Pct = [vs Promedio Historico]
RETURN
    IF(
        Pct > 10,
        "▲ Por encima (+10%)",
        IF(
            Pct < -10,
            "▼ Por debajo (-10%)",
            "● Normal"
        )
    )
```

---

## 🎯 Ejercicio Integrador Final

### Desafío Completo

Crea un análisis completo que incluya:

1. **Dashboard Ejecutivo** con:
   - Ventas totales, YTD, MoM, YoY
   - Top 10 productos
   - Ranking de vendedores
   - Análisis por categoría

2. **Dashboard de Productos**:
   - Clasificación ABC
   - Margen por producto
   - Rotación de inventario
   - Productos en riesgo (bajo stock + alta demanda)

3. **Dashboard de Clientes**:
   - Segmentación RFM
   - Análisis de retención
   - CLV (Customer Lifetime Value)
   - Clientes en riesgo

4. **Dashboard de Tiempo**:
   - Tendencias mensuales
   - Estacionalidad
   - Proyecciones simples
   - Análisis de crecimiento

---

## 📝 Soluciones Paso a Paso

Cada ejercicio incluye:
- ✅ Código completo comentado
- ✅ Explicación línea por línea
- ✅ Consejos de optimización
- ✅ Casos de uso reales

---

## 🎓 Recursos Adicionales

### Datasets de Práctica

En la carpeta `datos-ejemplo/` encontrarás:
- `ventas_raw.csv`: 10,000+ transacciones
- `productos.xlsx`: 50 productos
- `clientes.xlsx`: 500 clientes
- `vendedores.xlsx`: 12 vendedores
- `categorias.xlsx`: Categorías y departamentos

### Scripts SQL para Generar Datos

Si quieres practicar con más datos, incluimos scripts para generar datasets personalizados.

---

**¡Manos a la obra!** 💪

Practica estos ejercicios hasta dominarlos. Son situaciones reales que encontrarás en tu trabajo diario con Power BI.
