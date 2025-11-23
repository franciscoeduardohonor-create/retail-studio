# 📘 Módulo 2: Power Query M - Nivel Intermedio

## 🎯 Objetivos del Módulo

Al finalizar este módulo serás capaz de:
- Crear funciones personalizadas reutilizables
- Combinar tablas con Merge y Append
- Manejar errores de forma profesional
- Trabajar con tablas dinámicas (Pivot/Unpivot)
- Usar parámetros para consultas dinámicas

---

## 📚 Contenido

1. [Combinar Consultas (Merge)](#1-combinar-consultas-merge)
2. [Anexar Consultas (Append)](#2-anexar-consultas-append)
3. [Funciones Personalizadas](#3-funciones-personalizadas)
4. [Manejo de Errores](#4-manejo-de-errores)
5. [Pivot y Unpivot](#5-pivot-y-unpivot)
6. [Parámetros](#6-parámetros)
7. [Ejercicios Prácticos](#7-ejercicios-prácticos)

---

## 1. Combinar Consultas (Merge)

### 1.1 Concepto de Merge

Merge es similar a un JOIN en SQL: combina dos tablas basándose en una o más columnas comunes.

**Tipos de Merge**:
- **Left Outer**: Todas las filas de la tabla izquierda
- **Right Outer**: Todas las filas de la tabla derecha
- **Inner**: Solo filas que coinciden en ambas tablas
- **Full Outer**: Todas las filas de ambas tablas
- **Left Anti**: Filas de la izquierda que NO están en la derecha
- **Right Anti**: Filas de la derecha que NO están en la izquierda

### 1.2 Merge Básico - Inner Join

```m
// EJEMPLO 1: Combinar Ventas con Productos

let
    // Tabla de Ventas
    Ventas = #table(
        {"VentaID", "ProductoID", "Cantidad", "Fecha"},
        {
            {1, 101, 2, #date(2025,11,1)},
            {2, 102, 5, #date(2025,11,2)},
            {3, 101, 1, #date(2025,11,3)},
            {4, 103, 3, #date(2025,11,4)}
        }
    ),

    // Tabla de Productos
    Productos = #table(
        {"ProductoID", "NombreProducto", "Precio"},
        {
            {101, "Laptop", 15999},
            {102, "Mouse", 299},
            {103, "Teclado", 899}
        }
    ),

    // MERGE: Combinar tablas por ProductoID
    Merge = Table.NestedJoin(
        Ventas,                    // Tabla izquierda
        {"ProductoID"},            // Columnas de la tabla izquierda
        Productos,                 // Tabla derecha
        {"ProductoID"},            // Columnas de la tabla derecha
        "Productos",               // Nombre de la nueva columna
        JoinKind.Inner             // Tipo de join
    ),

    // EXPANDIR: Extraer las columnas de la tabla anidada
    Expandir = Table.ExpandTableColumn(
        Merge,
        "Productos",                          // Nombre de la columna anidada
        {"NombreProducto", "Precio"},         // Columnas a expandir
        {"NombreProducto", "Precio"}          // Nombres para las nuevas columnas
    ),

    // Agregar columna de Total
    AgregarTotal = Table.AddColumn(
        Expandir,
        "Total",
        each [Cantidad] * [Precio],
        type number
    )
in
    AgregarTotal

/* RESULTADO:
VentaID | ProductoID | Cantidad | Fecha      | NombreProducto | Precio | Total
--------|------------|----------|------------|----------------|--------|-------
1       | 101        | 2        | 2025-11-01 | Laptop         | 15999  | 31998
2       | 102        | 5        | 2025-11-02 | Mouse          | 299    | 1495
3       | 101        | 1        | 2025-11-03 | Laptop         | 15999  | 15999
4       | 103        | 3        | 2025-11-04 | Teclado        | 899    | 2697
*/
```

### 1.3 Left Outer Join

```m
// EJEMPLO 2: Left Join - Mantener todas las ventas aunque no haya producto

let
    // Ventas (incluye un ProductoID que no existe en Productos)
    Ventas = #table(
        {"VentaID", "ProductoID", "Cantidad"},
        {
            {1, 101, 2},
            {2, 102, 5},
            {3, 999, 1},  // Este producto NO existe
            {4, 103, 3}
        }
    ),

    Productos = #table(
        {"ProductoID", "NombreProducto", "Precio"},
        {
            {101, "Laptop", 15999},
            {102, "Mouse", 299},
            {103, "Teclado", 899}
        }
    ),

    // LEFT JOIN: Mantiene todas las ventas
    Merge = Table.NestedJoin(
        Ventas,
        {"ProductoID"},
        Productos,
        {"ProductoID"},
        "Productos",
        JoinKind.LeftOuter    // LEFT OUTER JOIN
    ),

    Expandir = Table.ExpandTableColumn(
        Merge,
        "Productos",
        {"NombreProducto", "Precio"},
        {"NombreProducto", "Precio"}
    )
in
    Expandir

/* RESULTADO:
VentaID | ProductoID | Cantidad | NombreProducto | Precio
--------|------------|----------|----------------|--------
1       | 101        | 2        | Laptop         | 15999
2       | 102        | 5        | Mouse          | 299
3       | 999        | 1        | null           | null   ← No hay coincidencia
4       | 103        | 3        | Teclado        | 899
*/
```

### 1.4 Merge con Múltiples Columnas

```m
// EJEMPLO 3: Merge usando múltiples columnas

let
    // Ventas por Tienda y Producto
    Ventas = #table(
        {"Tienda", "ProductoID", "Cantidad"},
        {
            {"Norte", 101, 5},
            {"Sur", 101, 3},
            {"Norte", 102, 2},
            {"Sur", 102, 4}
        }
    ),

    // Precios que varían por Tienda
    Precios = #table(
        {"Tienda", "ProductoID", "Precio"},
        {
            {"Norte", 101, 15999},
            {"Norte", 102, 299},
            {"Sur", 101, 14999},  // Precio diferente en tienda Sur
            {"Sur", 102, 279}      // Precio diferente en tienda Sur
        }
    ),

    // MERGE con DOS columnas: Tienda Y ProductoID
    Merge = Table.NestedJoin(
        Ventas,
        {"Tienda", "ProductoID"},     // Dos columnas de la izquierda
        Precios,
        {"Tienda", "ProductoID"},     // Dos columnas de la derecha
        "Precios",
        JoinKind.Inner
    ),

    Expandir = Table.ExpandTableColumn(
        Merge,
        "Precios",
        {"Precio"},
        {"Precio"}
    ),

    AgregarTotal = Table.AddColumn(
        Expandir,
        "Total",
        each [Cantidad] * [Precio],
        type number
    )
in
    AgregarTotal
```

---

## 2. Anexar Consultas (Append)

### 2.1 Concepto de Append

Append combina tablas **verticalmente** (una debajo de otra). Similar a UNION en SQL.

### 2.2 Append Básico

```m
// EJEMPLO 4: Combinar ventas de diferentes meses

let
    // Ventas de Enero
    VentasEnero = #table(
        {"Fecha", "Producto", "Monto"},
        {
            {#date(2025,1,15), "Laptop", 15999},
            {#date(2025,1,20), "Mouse", 299}
        }
    ),

    // Ventas de Febrero
    VentasFebrero = #table(
        {"Fecha", "Producto", "Monto"},
        {
            {#date(2025,2,10), "Teclado", 899},
            {#date(2025,2,25), "Monitor", 4599}
        }
    ),

    // APPEND: Combinar verticalmente
    Combinado = Table.Combine({VentasEnero, VentasFebrero})
in
    Combinado

/* RESULTADO:
Fecha      | Producto | Monto
-----------|----------|-------
2025-01-15 | Laptop   | 15999
2025-01-20 | Mouse    | 299
2025-02-10 | Teclado  | 899
2025-02-25 | Monitor  | 4599
*/
```

### 2.3 Append con Columnas Diferentes

```m
// EJEMPLO 5: Append cuando las tablas tienen columnas diferentes

let
    // Ventas Tienda Física (tiene columna "Vendedor")
    VentasFisica = #table(
        {"Fecha", "Producto", "Monto", "Vendedor"},
        {
            {#date(2025,11,1), "Laptop", 15999, "Ana García"},
            {#date(2025,11,2), "Mouse", 299, "Carlos López"}
        }
    ),

    // Ventas Online (tiene columna "MetodoPago" en lugar de "Vendedor")
    VentasOnline = #table(
        {"Fecha", "Producto", "Monto", "MetodoPago"},
        {
            {#date(2025,11,3), "Teclado", 899, "Tarjeta"},
            {#date(2025,11,4), "Monitor", 4599, "PayPal"}
        }
    ),

    // APPEND: Las columnas que no coinciden se llenan con null
    Combinado = Table.Combine({VentasFisica, VentasOnline}),

    // Agregar columna para identificar el origen
    VentasFisicaConOrigen = Table.AddColumn(
        VentasFisica,
        "Canal",
        each "Tienda Física",
        type text
    ),

    VentasOnlineConOrigen = Table.AddColumn(
        VentasOnline,
        "Canal",
        each "Online",
        type text
    ),

    // Combinar con identificación de origen
    CombinandoConOrigen = Table.Combine({VentasFisicaConOrigen, VentasOnlineConOrigen})
in
    CombinandoConOrigen
```

### 2.4 Append Múltiple

```m
// EJEMPLO 6: Combinar múltiples tablas a la vez

let
    Enero = #table({"Mes", "Ventas"}, {{"Enero", 50000}}),
    Febrero = #table({"Mes", "Ventas"}, {{"Febrero", 60000}}),
    Marzo = #table({"Mes", "Ventas"}, {{"Marzo", 55000}}),
    Abril = #table({"Mes", "Ventas"}, {{"Abril", 70000}}),

    // Combinar todas las tablas en una sola operación
    TodasLasVentas = Table.Combine({Enero, Febrero, Marzo, Abril})
in
    TodasLasVentas
```

---

## 3. Funciones Personalizadas

### 3.1 Crear una Función Básica

```m
// EJEMPLO 7: Función para calcular IVA

let
    // Definimos la función
    CalcularIVA = (monto as number) as number =>
        monto * 0.16,

    // Probamos la función
    Resultado = CalcularIVA(1000)  // Resultado: 160
in
    Resultado

// Explicación:
// (monto as number) = Parámetro de entrada de tipo número
// as number => = La función devuelve un número
// monto * 0.16 = La lógica de la función
```

### 3.2 Función con Múltiples Parámetros

```m
// EJEMPLO 8: Función para calcular precio final con descuento e IVA

let
    // Función con tres parámetros
    PrecioFinal = (precio as number, descuento as number, incluirIVA as logical) as number =>
        let
            // Paso 1: Aplicar descuento
            PrecioConDescuento = precio * (1 - descuento),

            // Paso 2: Aplicar IVA si se solicita
            Resultado = if incluirIVA then
                            PrecioConDescuento * 1.16
                        else
                            PrecioConDescuento
        in
            Resultado,

    // Probar la función
    Prueba1 = PrecioFinal(1000, 0.10, true),   // 1000 con 10% desc + IVA = 1044
    Prueba2 = PrecioFinal(1000, 0.10, false)   // 1000 con 10% desc sin IVA = 900
in
    Prueba1
```

### 3.3 Aplicar Función a una Tabla

```m
// EJEMPLO 9: Usar función personalizada en una tabla

let
    // Definir la función
    ClasificarPrecio = (precio as number) as text =>
        if precio >= 10000 then "Premium"
        else if precio >= 1000 then "Medio"
        else "Básico",

    // Tabla de productos
    Productos = #table(
        {"Producto", "Precio"},
        {
            {"Laptop", 15999},
            {"Mouse", 299},
            {"Teclado", 899},
            {"Monitor", 4599},
            {"Cable", 50}
        }
    ),

    // Aplicar la función a cada fila
    AgregarCategoria = Table.AddColumn(
        Productos,
        "Categoria",
        each ClasificarPrecio([Precio]),  // Llamamos a la función
        type text
    )
in
    AgregarCategoria
```

### 3.4 Función para Limpiar Texto

```m
// EJEMPLO 10: Función reutilizable para limpiar nombres

let
    // Función que limpia y estandariza texto
    LimpiarTexto = (texto as text) as text =>
        let
            // Paso 1: Eliminar espacios al inicio y final
            SinEspacios = Text.Trim(texto),

            // Paso 2: Convertir a formato propio (Primera letra mayúscula)
            Capitalizado = Text.Proper(SinEspacios),

            // Paso 3: Reemplazar múltiples espacios por uno solo
            EspaciosSimples = Text.Combine(
                List.RemoveMatchingItems(
                    Text.Split(Capitalizado, " "),
                    {""}
                ),
                " "
            )
        in
            EspaciosSimples,

    // Tabla con nombres mal formateados
    Clientes = #table(
        {"Nombre"},
        {
            {"  JUAN  PÉREZ  "},
            {"maria   garcía"},
            {"  Carlos   LÓPEZ"}
        }
    ),

    // Aplicar función de limpieza
    LimpiarNombres = Table.TransformColumns(
        Clientes,
        {{"Nombre", LimpiarTexto}}
    )
in
    LimpiarNombres

/* RESULTADO:
Nombre Original     → Nombre Limpio
"  JUAN  PÉREZ  "  → "Juan Pérez"
"maria   garcía"   → "Maria García"
"  Carlos   LÓPEZ" → "Carlos López"
*/
```

---

## 4. Manejo de Errores

### 4.1 Try...Otherwise

```m
// EJEMPLO 11: Manejo básico de errores con try

let
    // Tabla con algunos datos problemáticos
    Datos = #table(
        {"Producto", "PrecioTexto"},
        {
            {"Laptop", "15999"},
            {"Mouse", "299.50"},
            {"Teclado", "N/A"},      // Esto causará error al convertir a número
            {"Monitor", "4599"},
            {"Cable", "ERROR"}        // Esto también causará error
        }
    ),

    // Convertir a número con manejo de errores
    ConvertirConSeguridad = Table.AddColumn(
        Datos,
        "Precio",
        each try Number.From([PrecioTexto]) otherwise 0,  // Si hay error, devuelve 0
        type number
    )
in
    ConvertirConSeguridad

/* RESULTADO:
Producto | PrecioTexto | Precio
---------|-------------|--------
Laptop   | 15999       | 15999
Mouse    | 299.50      | 299.5
Teclado  | N/A         | 0      ← Error capturado
Monitor  | 4599        | 4599
Cable    | ERROR       | 0      ← Error capturado
*/
```

### 4.2 Detectar y Marcar Errores

```m
// EJEMPLO 12: Identificar qué filas tienen errores

let
    Datos = #table(
        {"Producto", "PrecioTexto"},
        {
            {"Laptop", "15999"},
            {"Mouse", "N/A"},
            {"Teclado", "899"}
        }
    ),

    // Convertir y detectar errores
    ConvertirPrecio = Table.AddColumn(
        Datos,
        "Precio",
        each try Number.From([PrecioTexto]),  // Sin otherwise, devuelve [Error]
        type any
    ),

    // Agregar columna que indica si hay error
    MarcarErrores = Table.AddColumn(
        ConvertirPrecio,
        "TieneError",
        each [Precio][HasError]?,  // Verifica si hay error
        type logical
    ),

    // Extraer el valor o el mensaje de error
    ExtraerValor = Table.AddColumn(
        MarcarErrores,
        "PrecioFinal",
        each if [TieneError] = true then
                null  // o 0, o lo que prefieras
             else
                [Precio][Value],
        type number
    ),

    // Limpiar columnas temporales
    LimpiarColumnas = Table.RemoveColumns(ExtraerValor, {"Precio", "TieneError"})
in
    LimpiarColumnas
```

### 4.3 Función con Manejo de Errores

```m
// EJEMPLO 13: Función robusta para conversión de números

let
    // Función que convierte texto a número de forma segura
    ConvertirANumero = (valor as any, valorPorDefecto as number) as number =>
        try
            Number.From(valor)
        otherwise
            valorPorDefecto,

    // Tabla de prueba
    Datos = #table(
        {"Producto", "Precio", "Cantidad"},
        {
            {"Laptop", "15999", "2"},
            {"Mouse", "N/A", "5"},
            {"Teclado", "899", "ERROR"}
        }
    ),

    // Aplicar conversión segura
    ConvertirDatos = Table.TransformColumns(
        Datos,
        {
            {"Precio", each ConvertirANumero(_, 0), type number},
            {"Cantidad", each ConvertirANumero(_, 1), type number}
        }
    )
in
    ConvertirDatos
```

### 4.4 Remover Filas con Errores

```m
// EJEMPLO 14: Filtrar filas que tienen errores

let
    Datos = #table(
        {"Producto", "PrecioTexto"},
        {
            {"Laptop", "15999"},
            {"Mouse", "N/A"},
            {"Teclado", "899"},
            {"Monitor", "ERROR"}
        }
    ),

    // Intentar conversión
    ConvertirPrecio = Table.AddColumn(
        Datos,
        "Precio",
        each try Number.From([PrecioTexto]),
        type any
    ),

    // MÉTODO 1: Remover filas con error
    RemoverErrores = Table.RemoveRowsWithErrors(ConvertirPrecio, {"Precio"}),

    // Extraer el valor
    ExtraerValor = Table.TransformColumns(
        RemoverErrores,
        {{"Precio", each [Value], type number}}
    )
in
    ExtraerValor

/* RESULTADO (solo filas sin errores):
Producto | PrecioTexto | Precio
---------|-------------|--------
Laptop   | 15999       | 15999
Teclado  | 899         | 899
*/
```

---

## 5. Pivot y Unpivot

### 5.1 Unpivot - Convertir Columnas a Filas

```m
// EJEMPLO 15: Transformar tabla ancha a formato largo (Unpivot)

let
    // Tabla con ventas por mes (formato ancho)
    VentasAncho = #table(
        {"Producto", "Enero", "Febrero", "Marzo"},
        {
            {"Laptop", 50000, 60000, 55000},
            {"Mouse", 5000, 6000, 5500},
            {"Teclado", 8000, 9000, 8500}
        }
    ),

    // UNPIVOT: Convertir columnas de meses a filas
    Unpivot = Table.UnpivotOtherColumns(
        VentasAncho,
        {"Producto"},              // Columnas que NO se despivotean
        "Mes",                     // Nombre para la columna de atributos
        "Ventas"                   // Nombre para la columna de valores
    )
in
    Unpivot

/* RESULTADO:
Producto | Mes     | Ventas
---------|---------|--------
Laptop   | Enero   | 50000
Laptop   | Febrero | 60000
Laptop   | Marzo   | 55000
Mouse    | Enero   | 5000
Mouse    | Febrero | 6000
Mouse    | Marzo   | 5500
Teclado  | Enero   | 8000
Teclado  | Febrero | 9000
Teclado  | Marzo   | 8500
*/
```

### 5.2 Unpivot Selectivo

```m
// EJEMPLO 16: Unpivot solo columnas específicas

let
    VentasCompleto = #table(
        {"Producto", "Categoria", "Enero", "Febrero", "Marzo"},
        {
            {"Laptop", "Computadoras", 50000, 60000, 55000},
            {"Mouse", "Accesorios", 5000, 6000, 5500}
        }
    ),

    // Unpivot SOLO las columnas de meses
    Unpivot = Table.Unpivot(
        VentasCompleto,
        {"Enero", "Febrero", "Marzo"},  // Solo estas columnas se despivotan
        "Mes",
        "Ventas"
    )
in
    Unpivot

/* RESULTADO:
Producto | Categoria    | Mes     | Ventas
---------|--------------|---------|--------
Laptop   | Computadoras | Enero   | 50000
Laptop   | Computadoras | Febrero | 60000
Laptop   | Computadoras | Marzo   | 55000
Mouse    | Accesorios   | Enero   | 5000
Mouse    | Accesorios   | Febrero | 6000
Mouse    | Accesorios   | Marzo   | 5500
*/
```

### 5.3 Pivot - Convertir Filas a Columnas

```m
// EJEMPLO 17: Transformar formato largo a ancho (Pivot)

let
    // Tabla en formato largo
    VentasLargo = #table(
        {"Producto", "Mes", "Ventas"},
        {
            {"Laptop", "Enero", 50000},
            {"Laptop", "Febrero", 60000},
            {"Laptop", "Marzo", 55000},
            {"Mouse", "Enero", 5000},
            {"Mouse", "Febrero", 6000},
            {"Mouse", "Marzo", 5500}
        }
    ),

    // PIVOT: Convertir Mes en columnas
    Pivot = Table.Pivot(
        VentasLargo,
        List.Distinct(VentasLargo[Mes]),  // Lista de valores únicos para crear columnas
        "Mes",                             // Columna que contiene los nombres de las nuevas columnas
        "Ventas",                          // Columna que contiene los valores
        List.Sum                           // Función de agregación (Sum, Average, Count, etc.)
    )
in
    Pivot

/* RESULTADO:
Producto | Enero | Febrero | Marzo
---------|-------|---------|-------
Laptop   | 50000 | 60000   | 55000
Mouse    | 5000  | 6000    | 5500
*/
```

---

## 6. Parámetros

### 6.1 Crear un Parámetro Simple

Los parámetros se crean desde la interfaz de Power Query:
**Administrar parámetros > Nuevo parámetro**

Pero también se pueden crear con código:

```m
// EJEMPLO 18: Parámetro para año de análisis

let
    // Valor del parámetro (normalmente lo establece el usuario en la UI)
    AñoSeleccionado = 2025,

    // Usar el parámetro en una consulta
    VentasCompletas = #table(
        {"Producto", "Año", "Ventas"},
        {
            {"Laptop", 2024, 50000},
            {"Laptop", 2025, 60000},
            {"Mouse", 2024, 5000},
            {"Mouse", 2025, 6000}
        }
    ),

    // Filtrar por el año del parámetro
    VentasFiltradas = Table.SelectRows(
        VentasCompletas,
        each [Año] = AñoSeleccionado  // Usa el parámetro
    )
in
    VentasFiltradas
```

### 6.2 Parámetro para Ruta de Archivo

```m
// EJEMPLO 19: Parámetro para ruta dinámica de archivos

let
    // Parámetro: Ruta base de los archivos
    RutaBase = "C:\Datos\",

    // Parámetro: Nombre del archivo
    NombreArchivo = "Ventas2025.xlsx",

    // Construir ruta completa
    RutaCompleta = RutaBase & NombreArchivo,

    // Cargar el archivo usando la ruta dinámica
    Fuente = Excel.Workbook(
        File.Contents(RutaCompleta),
        null,
        true
    ),

    HojaVentas = Fuente{[Item="Ventas",Kind="Sheet"]}[Data]
in
    HojaVentas

// BENEFICIO: Cambiando solo el parámetro, puedes cargar diferentes archivos
// sin modificar el código
```

### 6.3 Parámetro para Filtro Dinámico

```m
// EJEMPLO 20: Parámetro para filtrar por categoría

let
    // Parámetro: Categoría a filtrar
    CategoriaFiltro = "Computadoras",  // Cambiar esto filtra diferentes categorías

    // Datos
    Productos = #table(
        {"Producto", "Categoria", "Precio"},
        {
            {"Laptop", "Computadoras", 15999},
            {"Mouse", "Accesorios", 299},
            {"Monitor", "Monitores", 4599},
            {"Teclado", "Accesorios", 899}
        }
    ),

    // Filtrar usando el parámetro
    ProductosFiltrados = Table.SelectRows(
        Productos,
        each [Categoria] = CategoriaFiltro
    )
in
    ProductosFiltrados
```

---

## 7. Ejercicios Prácticos

### Ejercicio 1: Merge Completo

**Escenario**: Tienes tres tablas:
1. Ventas: VentaID, ProductoID, ClienteID, Cantidad
2. Productos: ProductoID, NombreProducto, Precio
3. Clientes: ClienteID, NombreCliente, Ciudad

**Tarea**:
- Combina las tres tablas
- Calcula el Total de cada venta
- Filtra solo ventas de clientes de "CDMX"

<details>
<summary>👉 Ver Solución</summary>

```m
let
    Ventas = #table(
        {"VentaID", "ProductoID", "ClienteID", "Cantidad"},
        {
            {1, 101, 201, 2},
            {2, 102, 202, 5},
            {3, 101, 203, 1}
        }
    ),

    Productos = #table(
        {"ProductoID", "NombreProducto", "Precio"},
        {
            {101, "Laptop", 15999},
            {102, "Mouse", 299}
        }
    ),

    Clientes = #table(
        {"ClienteID", "NombreCliente", "Ciudad"},
        {
            {201, "Ana García", "CDMX"},
            {202, "Carlos López", "Guadalajara"},
            {203, "María Rodríguez", "CDMX"}
        }
    ),

    // Merge 1: Ventas + Productos
    MergeProductos = Table.NestedJoin(
        Ventas, {"ProductoID"},
        Productos, {"ProductoID"},
        "Productos",
        JoinKind.Inner
    ),

    ExpandirProductos = Table.ExpandTableColumn(
        MergeProductos,
        "Productos",
        {"NombreProducto", "Precio"},
        {"NombreProducto", "Precio"}
    ),

    // Merge 2: Resultado anterior + Clientes
    MergeClientes = Table.NestedJoin(
        ExpandirProductos, {"ClienteID"},
        Clientes, {"ClienteID"},
        "Clientes",
        JoinKind.Inner
    ),

    ExpandirClientes = Table.ExpandTableColumn(
        MergeClientes,
        "Clientes",
        {"NombreCliente", "Ciudad"},
        {"NombreCliente", "Ciudad"}
    ),

    // Calcular Total
    AgregarTotal = Table.AddColumn(
        ExpandirClientes,
        "Total",
        each [Cantidad] * [Precio],
        type number
    ),

    // Filtrar solo CDMX
    FiltrarCDMX = Table.SelectRows(
        AgregarTotal,
        each [Ciudad] = "CDMX"
    )
in
    FiltrarCDMX
```
</details>

---

### Ejercicio 2: Función de Limpieza

**Tarea**: Crea una función que:
- Reciba un texto
- Elimine espacios al inicio/final
- Convierta a formato propio
- Reemplace "SA" por "S.A." y "CV" por "C.V."

<details>
<summary>👉 Ver Solución</summary>

```m
let
    LimpiarNombreEmpresa = (nombre as text) as text =>
        let
            Paso1 = Text.Trim(nombre),
            Paso2 = Text.Proper(Paso1),
            Paso3 = Text.Replace(Paso2, " Sa ", " S.A. "),
            Paso4 = Text.Replace(Paso3, " Cv ", " C.V. ")
        in
            Paso4,

    // Probar la función
    Empresas = #table(
        {"NombreOriginal"},
        {
            {"  empresa SA de CV  "},
            {"TECNOLOGÍA SA"},
            {"comercio CV"}
        }
    ),

    Limpiar = Table.AddColumn(
        Empresas,
        "NombreLimpio",
        each LimpiarNombreEmpresa([NombreOriginal]),
        type text
    )
in
    Limpiar
```
</details>

---

### Ejercicio 3: Unpivot de Ventas Mensuales

**Escenario**: Tienes ventas en formato ancho con columnas para cada mes.

**Tarea**: Convierte a formato largo para poder analizar por mes.

<details>
<summary>👉 Ver Solución</summary>

```m
let
    VentasMeses = #table(
        {"Vendedor", "Ene", "Feb", "Mar", "Abr", "May", "Jun"},
        {
            {"Ana", 50000, 55000, 60000, 58000, 62000, 65000},
            {"Carlos", 45000, 48000, 52000, 50000, 54000, 56000},
            {"María", 52000, 54000, 58000, 60000, 63000, 66000}
        }
    ),

    // Unpivot todas las columnas excepto Vendedor
    FormatoLargo = Table.UnpivotOtherColumns(
        VentasMeses,
        {"Vendedor"},
        "Mes",
        "Ventas"
    ),

    // Opcional: Ordenar por Vendedor y Mes
    Ordenado = Table.Sort(
        FormatoLargo,
        {{"Vendedor", Order.Ascending}, {"Mes", Order.Ascending}}
    )
in
    Ordenado
```
</details>

---

## 🎯 Resumen del Módulo

**Has aprendido**:
- ✅ Combinar tablas con Merge (diferentes tipos de join)
- ✅ Anexar tablas verticalmente con Append
- ✅ Crear funciones personalizadas reutilizables
- ✅ Manejar errores con try...otherwise
- ✅ Transformar datos con Pivot y Unpivot
- ✅ Usar parámetros para consultas dinámicas

**Próximo Módulo**: [Módulo 3 - Power Query M Avanzado](../modulo-3-power-query-avanzado/README.md)

Donde aprenderás:
- Funciones recursivas
- Optimización de consultas
- Web scraping y APIs
- Transformaciones complejas

---

**¡Excelente progreso!** 🎉

Estos conceptos intermedios son fundamentales para trabajar con datos reales en Power BI.
