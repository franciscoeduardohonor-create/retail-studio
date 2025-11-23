# 📘 Módulo 1: Power Query M - Fundamentos

## 🎯 Objetivos del Módulo

Al finalizar este módulo serás capaz de:
- Entender qué es Power Query y el lenguaje M
- Escribir código M básico
- Importar datos de diferentes fuentes
- Aplicar transformaciones básicas
- Manejar tipos de datos correctamente

---

## 📚 Contenido

1. [Introducción a Power Query](#1-introducción-a-power-query)
2. [Sintaxis Básica del Lenguaje M](#2-sintaxis-básica-del-lenguaje-m)
3. [Importación de Datos](#3-importación-de-datos)
4. [Transformaciones Básicas](#4-transformaciones-básicas)
5. [Tipos de Datos](#5-tipos-de-datos)
6. [Ejercicios Prácticos](#6-ejercicios-prácticos)

---

## 1. Introducción a Power Query

### ¿Qué es Power Query?

Power Query es el motor de transformación de datos (ETL) de Power BI. Te permite:
- **Extraer** datos de múltiples fuentes
- **Transformar** y limpiar datos
- **Cargar** datos al modelo de Power BI

### ¿Qué es el Lenguaje M?

M (también llamado "Power Query Formula Language") es un lenguaje:
- **Funcional**: Trabaja con funciones que transforman datos
- **Sensible a mayúsculas**: `tabla` es diferente de `Tabla`
- **Evaluado paso a paso**: Cada paso se ejecuta en orden

### ¿Dónde se escribe el código M?

En Power BI Desktop:
1. Ve a **Transformar datos** (Power Query Editor)
2. Selecciona una consulta
3. Ve a **Vista > Editor avanzado**

---

## 2. Sintaxis Básica del Lenguaje M

### 2.1 Estructura de una Consulta

```m
// EJEMPLO 1: Estructura básica de una consulta
let
    // Paso 1: Definimos una variable con un valor
    Nombre = "Juan",

    // Paso 2: Definimos otra variable
    Apellido = "Pérez",

    // Paso 3: Combinamos las variables
    NombreCompleto = Nombre & " " & Apellido
in
    // El resultado final que se muestra
    NombreCompleto
```

**Explicación línea por línea:**
- `let`: Palabra clave que inicia el bloque de definiciones
- `Nombre = "Juan"`: Crea una variable llamada `Nombre` con el valor "Juan"
- `,`: Las comas separan cada paso (excepto el último antes de `in`)
- `&`: Operador de concatenación de texto
- `in`: Indica cuál es el resultado final de la consulta
- `NombreCompleto`: El resultado que se devolverá

---

### 2.2 Comentarios

```m
// EJEMPLO 2: Tipos de comentarios

let
    // Este es un comentario de una línea

    /* Este es un comentario
       de múltiples líneas
       muy útil para explicaciones largas */

    Precio = 100,          // Comentario al final de la línea
    Descuento = 0.15,      // 15% de descuento
    PrecioFinal = Precio * (1 - Descuento)  // Calculamos el precio con descuento
in
    PrecioFinal  // Resultado: 85
```

---

### 2.3 Tipos de Datos Básicos

```m
// EJEMPLO 3: Diferentes tipos de datos

let
    // TEXTO (Text)
    Producto = "Laptop",

    // NÚMERO ENTERO (Int64.Type)
    Cantidad = 5,

    // NÚMERO DECIMAL (Number)
    Precio = 15999.99,

    // BOOLEANO (Logical)
    EnStock = true,

    // FECHA (Date)
    FechaVenta = #date(2025, 11, 23),

    // FECHA Y HORA (DateTime)
    FechaHoraVenta = #datetime(2025, 11, 23, 14, 30, 0),

    // LISTA (List)
    Productos = {"Laptop", "Mouse", "Teclado"},

    // TABLA (Table)
    TablaVentas = #table(
        {"Producto", "Cantidad", "Precio"},  // Nombres de columnas
        {
            {"Laptop", 2, 15999.99},          // Fila 1
            {"Mouse", 5, 299.99},             // Fila 2
            {"Teclado", 3, 899.99}            // Fila 3
        }
    )
in
    TablaVentas
```

---

### 2.4 Operadores Básicos

```m
// EJEMPLO 4: Operadores matemáticos y lógicos

let
    // OPERADORES MATEMÁTICOS
    Suma = 10 + 5,              // Resultado: 15
    Resta = 10 - 5,             // Resultado: 5
    Multiplicacion = 10 * 5,    // Resultado: 50
    Division = 10 / 5,          // Resultado: 2
    Potencia = 2 ^ 3,           // Resultado: 8 (2 elevado a 3)

    // OPERADORES DE COMPARACIÓN
    EsMayor = 10 > 5,           // Resultado: true
    EsMenor = 10 < 5,           // Resultado: false
    EsIgual = 10 = 10,          // Resultado: true (nota: un solo =)
    EsDiferente = 10 <> 5,      // Resultado: true

    // OPERADORES LÓGICOS
    Y = true and false,         // Resultado: false
    O = true or false,          // Resultado: true
    No = not true,              // Resultado: false

    // OPERADOR DE CONCATENACIÓN
    TextoCompleto = "Power" & " " & "BI"  // Resultado: "Power BI"
in
    TextoCompleto
```

---

## 3. Importación de Datos

### 3.1 Crear Tabla Manualmente

```m
// EJEMPLO 5: Crear una tabla de ventas manualmente

let
    // Creamos una tabla desde cero
    Fuente = #table(
        // Definimos los nombres de las columnas
        {"Fecha", "Producto", "Cantidad", "PrecioUnitario", "Vendedor"},

        // Definimos las filas de datos
        {
            {#date(2025,11,1), "Laptop Dell", 2, 15999, "Ana García"},
            {#date(2025,11,1), "Mouse Logitech", 5, 299, "Ana García"},
            {#date(2025,11,2), "Teclado Mecánico", 3, 899, "Carlos López"},
            {#date(2025,11,2), "Monitor Samsung", 1, 4599, "Ana García"},
            {#date(2025,11,3), "Laptop HP", 1, 12999, "Carlos López"},
            {#date(2025,11,3), "Mouse Logitech", 8, 299, "María Rodríguez"},
            {#date(2025,11,4), "Teclado Mecánico", 2, 899, "María Rodríguez"},
            {#date(2025,11,4), "Laptop Dell", 1, 15999, "Carlos López"}
        }
    ),

    // Establecemos los tipos de datos correctos
    TiposCambiados = Table.TransformColumnTypes(
        Fuente,
        {
            {"Fecha", type date},
            {"Producto", type text},
            {"Cantidad", Int64.Type},
            {"PrecioUnitario", type number},
            {"Vendedor", type text}
        }
    )
in
    TiposCambiados
```

---

### 3.2 Importar desde Excel

```m
// EJEMPLO 6: Importar datos desde un archivo Excel

let
    // Conectamos al archivo Excel
    Fuente = Excel.Workbook(
        File.Contents("C:\Datos\Ventas2025.xlsx"),  // Ruta del archivo
        null,   // No hay opciones adicionales
        true    // Usar la primera fila como encabezados
    ),

    // Seleccionamos la hoja específica que queremos
    HojaVentas = Fuente{[Item="Ventas",Kind="Sheet"]}[Data],

    // Promovemos la primera fila como encabezados (si no se hizo automáticamente)
    EncabezadosPromovidos = Table.PromoteHeaders(
        HojaVentas,
        [PromoteAllScalars=true]  // Promueve todos los valores escalares
    ),

    // Establecemos los tipos de datos
    TiposCambiados = Table.TransformColumnTypes(
        EncabezadosPromovidos,
        {
            {"Fecha", type date},
            {"Producto", type text},
            {"Cantidad", Int64.Type},
            {"Precio", type number}
        }
    )
in
    TiposCambiados
```

---

### 3.3 Importar desde CSV

```m
// EJEMPLO 7: Importar datos desde archivo CSV

let
    // Leemos el archivo CSV
    Fuente = Csv.Document(
        File.Contents("C:\Datos\Ventas.csv"),
        [
            Delimiter = ",",        // Delimitador de columnas
            Columns = 5,            // Número de columnas esperadas
            Encoding = 65001,       // UTF-8 para caracteres especiales (ñ, á, etc.)
            QuoteStyle = QuoteStyle.None
        ]
    ),

    // Promovemos la primera fila como encabezados
    EncabezadosPromovidos = Table.PromoteHeaders(Fuente),

    // Cambiamos los tipos de datos
    TiposCambiados = Table.TransformColumnTypes(
        EncabezadosPromovidos,
        {
            {"Fecha", type date},
            {"Producto", type text},
            {"Cantidad", Int64.Type},
            {"Precio", type number},
            {"Vendedor", type text}
        }
    )
in
    TiposCambiados
```

---

## 4. Transformaciones Básicas

### 4.1 Filtrar Filas

```m
// EJEMPLO 8: Filtrar filas de una tabla

let
    // Primero creamos una tabla de ejemplo
    Fuente = #table(
        {"Producto", "Categoria", "Precio", "Stock"},
        {
            {"Laptop Dell", "Computadoras", 15999, 5},
            {"Mouse Logitech", "Accesorios", 299, 25},
            {"Teclado Mecánico", "Accesorios", 899, 15},
            {"Monitor Samsung", "Monitores", 4599, 8},
            {"Laptop HP", "Computadoras", 12999, 3},
            {"Mouse Gamer", "Accesorios", 599, 12},
            {"Monitor LG", "Monitores", 3999, 0}
        }
    ),

    // FILTRO 1: Productos con precio mayor a 1000
    PrecioMayor1000 = Table.SelectRows(
        Fuente,
        each [Precio] > 1000  // "each" se refiere a cada fila
    ),

    // FILTRO 2: Solo productos de categoría "Accesorios"
    SoloAccesorios = Table.SelectRows(
        Fuente,
        each [Categoria] = "Accesorios"
    ),

    // FILTRO 3: Productos con stock disponible (mayor que 0)
    ConStock = Table.SelectRows(
        Fuente,
        each [Stock] > 0
    ),

    // FILTRO 4: Filtro combinado (AND)
    // Computadoras con precio menor a 15000
    ComputadorasEconomicas = Table.SelectRows(
        Fuente,
        each [Categoria] = "Computadoras" and [Precio] < 15000
    ),

    // FILTRO 5: Filtro con OR
    // Productos caros (>5000) O sin stock
    CarosOSinStock = Table.SelectRows(
        Fuente,
        each [Precio] > 5000 or [Stock] = 0
    )
in
    CarosOSinStock  // Cambia esto para ver diferentes resultados
```

---

### 4.2 Agregar Columnas

```m
// EJEMPLO 9: Agregar columnas calculadas

let
    // Tabla de ventas
    Fuente = #table(
        {"Producto", "Cantidad", "PrecioUnitario"},
        {
            {"Laptop", 2, 15999},
            {"Mouse", 5, 299},
            {"Teclado", 3, 899},
            {"Monitor", 1, 4599}
        }
    ),

    // COLUMNA 1: Total de venta (Cantidad * PrecioUnitario)
    AgregarTotal = Table.AddColumn(
        Fuente,
        "Total",                    // Nombre de la nueva columna
        each [Cantidad] * [PrecioUnitario],  // Fórmula
        type number                 // Tipo de dato
    ),

    // COLUMNA 2: IVA (16% del Total)
    AgregarIVA = Table.AddColumn(
        AgregarTotal,
        "IVA",
        each [Total] * 0.16,
        type number
    ),

    // COLUMNA 3: Total con IVA
    AgregarTotalConIVA = Table.AddColumn(
        AgregarIVA,
        "TotalConIVA",
        each [Total] + [IVA],
        type number
    ),

    // COLUMNA 4: Categoría basada en el precio
    AgregarCategoria = Table.AddColumn(
        AgregarTotalConIVA,
        "Categoria",
        each if [PrecioUnitario] >= 10000 then "Premium"
             else if [PrecioUnitario] >= 1000 then "Medio"
             else "Básico",
        type text
    ),

    // COLUMNA 5: Columna de texto combinado
    AgregarDescripcion = Table.AddColumn(
        AgregarCategoria,
        "DescripcionVenta",
        each "Se vendieron " & Number.ToText([Cantidad]) & " " & [Producto],
        type text
    )
in
    AgregarDescripcion
```

---

### 4.3 Renombrar Columnas

```m
// EJEMPLO 10: Renombrar columnas

let
    // Tabla original con nombres en inglés
    Fuente = #table(
        {"Product", "Qty", "Price", "Seller"},
        {
            {"Laptop", 2, 15999, "Ana"},
            {"Mouse", 5, 299, "Carlos"}
        }
    ),

    // MÉTODO 1: Renombrar una columna a la vez
    Renombrar1 = Table.RenameColumns(
        Fuente,
        {"Product", "Producto"}  // {nombre_viejo, nombre_nuevo}
    ),

    // MÉTODO 2: Renombrar múltiples columnas
    RenombrarVarias = Table.RenameColumns(
        Fuente,
        {
            {"Product", "Producto"},
            {"Qty", "Cantidad"},
            {"Price", "Precio"},
            {"Seller", "Vendedor"}
        }
    )
in
    RenombrarVarias
```

---

### 4.4 Eliminar Columnas

```m
// EJEMPLO 11: Eliminar columnas innecesarias

let
    // Tabla con columnas adicionales que no necesitamos
    Fuente = #table(
        {"ID", "Producto", "Precio", "Stock", "CodigoInterno", "Temporal"},
        {
            {1, "Laptop", 15999, 5, "XYZ123", "dato_temp"},
            {2, "Mouse", 299, 25, "ABC456", "dato_temp"},
            {3, "Teclado", 899, 15, "DEF789", "dato_temp"}
        }
    ),

    // MÉTODO 1: Eliminar columnas específicas
    EliminarColumnas = Table.RemoveColumns(
        Fuente,
        {"CodigoInterno", "Temporal"}  // Lista de columnas a eliminar
    ),

    // MÉTODO 2: Mantener solo las columnas que necesitamos
    SeleccionarColumnas = Table.SelectColumns(
        Fuente,
        {"Producto", "Precio", "Stock"}  // Solo estas columnas se mantienen
    )
in
    SeleccionarColumnas
```

---

### 4.5 Reemplazar Valores

```m
// EJEMPLO 12: Reemplazar valores en columnas

let
    // Tabla con datos que necesitan limpieza
    Fuente = #table(
        {"Producto", "Categoria", "Estado", "Precio"},
        {
            {"Laptop", "PC", "Disponible", 15999},
            {"Mouse", "Accesorios", "Agotado", 299},
            {"Teclado", "Accesorios", "Disponible", 899},
            {"Monitor", "PC", "En Stock", 4599},
            {"Impresora", "Otros", "Disponible", 2999}
        }
    ),

    // REEMPLAZO 1: Reemplazar "PC" por "Computadoras" en la columna Categoria
    ReemplazarCategoria = Table.ReplaceValue(
        Fuente,
        "PC",                    // Valor a buscar
        "Computadoras",          // Valor de reemplazo
        Replacer.ReplaceText,    // Tipo de reemplazo (texto completo)
        {"Categoria"}            // Columnas donde aplicar
    ),

    // REEMPLAZO 2: Estandarizar el estado
    ReemplazarEstado1 = Table.ReplaceValue(
        ReemplazarCategoria,
        "En Stock",
        "Disponible",
        Replacer.ReplaceText,
        {"Estado"}
    ),

    ReemplazarEstado2 = Table.ReplaceValue(
        ReemplazarEstado1,
        "Agotado",
        "No Disponible",
        Replacer.ReplaceText,
        {"Estado"}
    ),

    // REEMPLAZO 3: Aplicar descuento del 10% a todos los precios
    AplicarDescuento = Table.ReplaceValue(
        ReemplazarEstado2,
        each [Precio],                    // Valor actual
        each [Precio] * 0.90,             // Nuevo valor (90% del original)
        Replacer.ReplaceValue,            // Reemplazar valor completo
        {"Precio"}
    )
in
    AplicarDescuento
```

---

### 4.6 Ordenar Filas

```m
// EJEMPLO 13: Ordenar filas

let
    // Tabla de productos
    Fuente = #table(
        {"Producto", "Precio", "Stock", "Categoria"},
        {
            {"Mouse", 299, 25, "Accesorios"},
            {"Laptop Dell", 15999, 5, "Computadoras"},
            {"Teclado", 899, 15, "Accesorios"},
            {"Monitor", 4599, 8, "Monitores"},
            {"Laptop HP", 12999, 3, "Computadoras"}
        }
    ),

    // ORDEN 1: Ordenar por precio ascendente (menor a mayor)
    OrdenPrecioAsc = Table.Sort(
        Fuente,
        {{"Precio", Order.Ascending}}
    ),

    // ORDEN 2: Ordenar por precio descendente (mayor a menor)
    OrdenPrecioDesc = Table.Sort(
        Fuente,
        {{"Precio", Order.Descending}}
    ),

    // ORDEN 3: Ordenar por múltiples columnas
    // Primero por Categoria (ascendente), luego por Precio (descendente)
    OrdenMultiple = Table.Sort(
        Fuente,
        {
            {"Categoria", Order.Ascending},
            {"Precio", Order.Descending}
        }
    )
in
    OrdenMultiple
```

---

## 5. Tipos de Datos

### 5.1 Conversión de Tipos

```m
// EJEMPLO 14: Convertir tipos de datos

let
    // Tabla con tipos incorrectos (todo como texto)
    Fuente = #table(
        {"Producto", "Precio", "Cantidad", "Fecha", "EnStock"},
        {
            {"Laptop", "15999.99", "2", "2025-11-23", "true"},
            {"Mouse", "299.50", "5", "2025-11-22", "true"},
            {"Teclado", "899.00", "0", "2025-11-21", "false"}
        }
    ),

    // Convertimos cada columna al tipo correcto
    TiposCorregidos = Table.TransformColumnTypes(
        Fuente,
        {
            {"Producto", type text},        // Ya es texto, pero lo especificamos
            {"Precio", type number},        // De texto a número decimal
            {"Cantidad", Int64.Type},       // De texto a número entero
            {"Fecha", type date},           // De texto a fecha
            {"EnStock", type logical}       // De texto a booleano
        }
    ),

    // CONVERSIÓN MANUAL: Agregar columna con conversión personalizada
    AgregarPrecioTexto = Table.AddColumn(
        TiposCorregidos,
        "PrecioFormateado",
        each "$" & Number.ToText([Precio], "N2"),  // N2 = 2 decimales
        type text
    )
in
    AgregarPrecioTexto
```

---

### 5.2 Funciones de Texto

```m
// EJEMPLO 15: Trabajar con texto

let
    // Tabla con datos de texto que necesitan limpieza
    Fuente = #table(
        {"Nombre", "Email", "Telefono"},
        {
            {"  ANA GARCÍA  ", "ANA.garcia@email.com", "555-1234"},
            {"carlos lópez", "Carlos.Lopez@EMAIL.COM", "555-5678"},
            {"  MARÍA rodríguez", "maria.r@email.com  ", "555-9012"}
        }
    ),

    // LIMPIEZA 1: Eliminar espacios al inicio y final
    LimpiarEspacios = Table.TransformColumns(
        Fuente,
        {
            {"Nombre", Text.Trim},      // Elimina espacios antes y después
            {"Email", Text.Trim}
        }
    ),

    // LIMPIEZA 2: Convertir a mayúsculas/minúsculas
    AgregarNombrePropio = Table.AddColumn(
        LimpiarEspacios,
        "NombrePropio",
        each Text.Proper([Nombre]),     // Primera letra de cada palabra en mayúscula
        type text
    ),

    AgregarEmailMinusculas = Table.AddColumn(
        AgregarNombrePropio,
        "EmailLimpio",
        each Text.Lower([Email]),       // Todo en minúsculas
        type text
    ),

    // EXTRACCIÓN: Obtener solo el primer nombre
    AgregarPrimerNombre = Table.AddColumn(
        AgregarEmailMinusculas,
        "PrimerNombre",
        each Text.BeforeDelimiter([NombrePropio], " "),  // Texto antes del espacio
        type text
    ),

    // CONCATENACIÓN: Crear código de cliente
    AgregarCodigo = Table.AddColumn(
        AgregarPrimerNombre,
        "CodigoCliente",
        each Text.Upper(Text.Start([PrimerNombre], 3)) & "-" &
             Text.End([Telefono], 4),   // Primeras 3 letras + últimos 4 dígitos
        type text
    ),

    // LONGITUD: Validar longitud del nombre
    AgregarLongitudNombre = Table.AddColumn(
        AgregarCodigo,
        "LongitudNombre",
        each Text.Length([NombrePropio]),
        Int64.Type
    )
in
    AgregarLongitudNombre
```

---

### 5.3 Funciones de Números

```m
// EJEMPLO 16: Trabajar con números

let
    // Tabla de ventas con cálculos
    Fuente = #table(
        {"Producto", "Precio", "Descuento", "Cantidad"},
        {
            {"Laptop", 15999.99, 0.15, 2},
            {"Mouse", 299.50, 0.10, 5},
            {"Teclado", 899.75, 0.05, 3}
        }
    ),

    // REDONDEO 1: Redondear precio a 2 decimales
    AgregarPrecioRedondeado = Table.AddColumn(
        Fuente,
        "PrecioRedondeado",
        each Number.Round([Precio], 2),  // Redondear a 2 decimales
        type number
    ),

    // REDONDEO 2: Redondear hacia arriba
    AgregarPrecioRedondeadoArriba = Table.AddColumn(
        AgregarPrecioRedondeado,
        "PrecioRedondeadoArriba",
        each Number.RoundUp([Precio], 0),  // Redondear hacia arriba (sin decimales)
        type number
    ),

    // REDONDEO 3: Redondear hacia abajo
    AgregarPrecioRedondeadoAbajo = Table.AddColumn(
        AgregarPrecioRedondeadoArriba,
        "PrecioRedondeadoAbajo",
        each Number.RoundDown([Precio], 0),  // Redondear hacia abajo
        type number
    ),

    // CÁLCULOS: Precio con descuento
    AgregarPrecioConDescuento = Table.AddColumn(
        AgregarPrecioRedondeadoAbajo,
        "PrecioConDescuento",
        each [Precio] * (1 - [Descuento]),
        type number
    ),

    // MÓDULO: Verificar si la cantidad es par o impar
    AgregarEsPar = Table.AddColumn(
        AgregarPrecioConDescuento,
        "CantidadEsPar",
        each Number.Mod([Cantidad], 2) = 0,  // Si el módulo es 0, es par
        type logical
    ),

    // ABSOLUTO: Calcular diferencia entre precio original y con descuento
    AgregarDiferencia = Table.AddColumn(
        AgregarEsPar,
        "DiferenciaAbsoluta",
        each Number.Abs([Precio] - [PrecioConDescuento]),
        type number
    )
in
    AgregarDiferencia
```

---

### 5.4 Funciones de Fechas

```m
// EJEMPLO 17: Trabajar con fechas

let
    // Tabla de ventas con fechas
    Fuente = #table(
        {"Producto", "FechaVenta", "Monto"},
        {
            {"Laptop", #date(2025, 1, 15), 15999},
            {"Mouse", #date(2025, 3, 22), 299},
            {"Teclado", #date(2025, 6, 10), 899},
            {"Monitor", #date(2025, 11, 23), 4599}
        }
    ),

    // EXTRACCIÓN 1: Obtener el año
    AgregarAnio = Table.AddColumn(
        Fuente,
        "Año",
        each Date.Year([FechaVenta]),
        Int64.Type
    ),

    // EXTRACCIÓN 2: Obtener el mes (número)
    AgregarMesNumero = Table.AddColumn(
        AgregarAnio,
        "MesNumero",
        each Date.Month([FechaVenta]),
        Int64.Type
    ),

    // EXTRACCIÓN 3: Obtener el nombre del mes
    AgregarNombreMes = Table.AddColumn(
        AgregarMesNumero,
        "NombreMes",
        each Date.MonthName([FechaVenta]),
        type text
    ),

    // EXTRACCIÓN 4: Obtener el trimestre
    AgregarTrimestre = Table.AddColumn(
        AgregarNombreMes,
        "Trimestre",
        each "Q" & Number.ToText(Date.QuarterOfYear([FechaVenta])),
        type text
    ),

    // EXTRACCIÓN 5: Obtener el día de la semana
    AgregarDiaSemana = Table.AddColumn(
        AgregarTrimestre,
        "DiaSemana",
        each Date.DayOfWeekName([FechaVenta]),
        type text
    ),

    // CÁLCULO 1: Días desde la venta hasta hoy
    AgregarDiasDesdeVenta = Table.AddColumn(
        AgregarDiaSemana,
        "DiasDesdeVenta",
        each Duration.Days(DateTime.LocalNow() - DateTime.From([FechaVenta])),
        Int64.Type
    ),

    // CÁLCULO 2: Inicio del mes
    AgregarInicioMes = Table.AddColumn(
        AgregarDiasDesdeVenta,
        "InicioMes",
        each Date.StartOfMonth([FechaVenta]),
        type date
    ),

    // CÁLCULO 3: Fin del mes
    AgregarFinMes = Table.AddColumn(
        AgregarInicioMes,
        "FinMes",
        each Date.EndOfMonth([FechaVenta]),
        type date
    )
in
    AgregarFinMes
```

---

## 6. Ejercicios Prácticos

### Ejercicio 1: Crear tu Primera Tabla

**Objetivo**: Crear una tabla de productos de una tienda de electrónica.

**Instrucciones**:
1. Crea una tabla con las siguientes columnas: Producto, Categoria, Precio, Stock
2. Agrega al menos 5 productos
3. Establece los tipos de datos correctos
4. Agrega una columna calculada "ValorInventario" (Precio * Stock)
5. Filtra los productos con ValorInventario mayor a 10000

**Intenta hacerlo tú mismo antes de ver la solución**

<details>
<summary>👉 Ver Solución</summary>

```m
let
    // Crear la tabla de productos
    Fuente = #table(
        {"Producto", "Categoria", "Precio", "Stock"},
        {
            {"iPhone 15", "Celulares", 18999, 15},
            {"Samsung Galaxy S24", "Celulares", 16999, 20},
            {"iPad Air", "Tablets", 12999, 10},
            {"AirPods Pro", "Accesorios", 4999, 35},
            {"Apple Watch", "Wearables", 8999, 12},
            {"Cargador USB-C", "Accesorios", 299, 100}
        }
    ),

    // Establecer tipos de datos
    TiposCambiados = Table.TransformColumnTypes(
        Fuente,
        {
            {"Producto", type text},
            {"Categoria", type text},
            {"Precio", type number},
            {"Stock", Int64.Type}
        }
    ),

    // Agregar columna ValorInventario
    AgregarValor = Table.AddColumn(
        TiposCambiados,
        "ValorInventario",
        each [Precio] * [Stock],
        type number
    ),

    // Filtrar productos con valor mayor a 10000
    Filtrado = Table.SelectRows(
        AgregarValor,
        each [ValorInventario] > 10000
    )
in
    Filtrado
```
</details>

---

### Ejercicio 2: Limpieza de Datos de Clientes

**Objetivo**: Limpiar una base de datos de clientes con problemas de formato.

**Instrucciones**:
1. Crea una tabla con: Nombre (con espacios), Email (mayúsculas/minúsculas mezcladas), Telefono
2. Limpia los espacios del nombre
3. Convierte el nombre a formato propio (Primera letra mayúscula)
4. Convierte el email a minúsculas
5. Crea un código de cliente usando las primeras 3 letras del nombre + últimos 4 dígitos del teléfono

**Intenta hacerlo tú mismo**

<details>
<summary>👉 Ver Solución</summary>

```m
let
    // Datos con problemas de formato
    Fuente = #table(
        {"Nombre", "Email", "Telefono"},
        {
            {"  juan PÉREZ  ", "Juan.Perez@GMAIL.com", "555-1234-5678"},
            {"MARIA  garcía", "MARIA.G@email.COM", "555-2345-6789"},
            {"  Pedro López", "pedro@HOTMAIL.com  ", "555-3456-7890"}
        }
    ),

    // Limpiar espacios
    LimpiarEspacios = Table.TransformColumns(
        Fuente,
        {
            {"Nombre", Text.Trim},
            {"Email", Text.Trim}
        }
    ),

    // Nombre en formato propio
    NombrePropio = Table.TransformColumns(
        LimpiarEspacios,
        {{"Nombre", Text.Proper}}
    ),

    // Email en minúsculas
    EmailMinusculas = Table.TransformColumns(
        NombrePropio,
        {{"Email", Text.Lower}}
    ),

    // Crear código de cliente
    AgregarCodigo = Table.AddColumn(
        EmailMinusculas,
        "CodigoCliente",
        each Text.Upper(Text.Start([Nombre], 3)) & "-" & Text.End([Telefono], 4),
        type text
    )
in
    AgregarCodigo
```
</details>

---

### Ejercicio 3: Análisis de Ventas por Periodo

**Objetivo**: Trabajar con fechas para analizar ventas.

**Instrucciones**:
1. Crea una tabla con ventas de diferentes fechas
2. Extrae: Año, Mes, Nombre del Mes, Trimestre
3. Calcula cuántos días han pasado desde cada venta
4. Filtra solo las ventas del trimestre actual (Q4 - Oct, Nov, Dic)

**Intenta hacerlo tú mismo**

<details>
<summary>👉 Ver Solución</summary>

```m
let
    // Tabla de ventas
    Fuente = #table(
        {"Producto", "FechaVenta", "Monto"},
        {
            {"Laptop", #date(2025, 2, 15), 15999},
            {"Mouse", #date(2025, 5, 20), 299},
            {"Teclado", #date(2025, 10, 5), 899},
            {"Monitor", #date(2025, 11, 12), 4599},
            {"Impresora", #date(2025, 11, 23), 2999},
            {"Scanner", #date(2025, 8, 30), 1599}
        }
    ),

    // Tipos de datos
    TiposCambiados = Table.TransformColumnTypes(
        Fuente,
        {
            {"Producto", type text},
            {"FechaVenta", type date},
            {"Monto", type number}
        }
    ),

    // Extraer año
    AgregarAnio = Table.AddColumn(
        TiposCambiados,
        "Año",
        each Date.Year([FechaVenta]),
        Int64.Type
    ),

    // Extraer mes
    AgregarMes = Table.AddColumn(
        AgregarAnio,
        "Mes",
        each Date.Month([FechaVenta]),
        Int64.Type
    ),

    // Nombre del mes
    AgregarNombreMes = Table.AddColumn(
        AgregarMes,
        "NombreMes",
        each Date.MonthName([FechaVenta]),
        type text
    ),

    // Trimestre
    AgregarTrimestre = Table.AddColumn(
        AgregarNombreMes,
        "Trimestre",
        each "Q" & Number.ToText(Date.QuarterOfYear([FechaVenta])),
        type text
    ),

    // Días desde la venta
    AgregarDias = Table.AddColumn(
        AgregarTrimestre,
        "DiasDesdeVenta",
        each Duration.Days(DateTime.LocalNow() - DateTime.From([FechaVenta])),
        Int64.Type
    ),

    // Filtrar solo Q4 (Trimestre 4)
    FiltrarQ4 = Table.SelectRows(
        AgregarDias,
        each [Trimestre] = "Q4"
    )
in
    FiltrarQ4
```
</details>

---

## 🎯 Resumen del Módulo

**Has aprendido**:
- ✅ La estructura básica de una consulta M (let...in)
- ✅ Tipos de datos fundamentales
- ✅ Operadores matemáticos, lógicos y de comparación
- ✅ Crear tablas manualmente e importar de Excel/CSV
- ✅ Filtrar, ordenar y transformar datos
- ✅ Agregar y eliminar columnas
- ✅ Trabajar con texto, números y fechas
- ✅ Cambiar tipos de datos

**Próximo Módulo**: [Módulo 2 - Power Query M Intermedio](../modulo-2-power-query-intermedio/README.md)

Donde aprenderás:
- Funciones personalizadas
- Merge y Append de tablas
- Manejo de errores
- Parámetros dinámicos

---

**¡Felicidades por completar el Módulo 1!** 🎉

Practica estos ejercicios hasta sentirte cómodo antes de avanzar al siguiente módulo.
