# 📁 Datos de Ejemplo para Prácticas

## 📋 Descripción

Esta carpeta contiene datos de ejemplo que puedes usar para practicar todos los conceptos del curso.

Los datos simulan un negocio retail real con ventas, productos, clientes y más.

---

## 🗂️ Estructura de Datos

### Ventas (Tabla de Hechos)
```
Columnas:
- VentaID (entero)
- Fecha (fecha)
- ProductoID (entero)
- ClienteID (entero)
- VendedorID (entero)
- SucursalID (entero)
- Canal (texto): Tienda, Online, Telefónico
- Cantidad (entero)
- PrecioUnitario (decimal)
- Descuento (decimal): 0.00 a 0.30
```

### Productos (Dimensión)
```
Columnas:
- ProductoID (entero)
- SKU (texto)
- NombreProducto (texto)
- CategoriaID (entero)
- Categoria (texto): Laptops, Accesorios, Monitores, etc.
- Marca (texto)
- Precio (decimal)
- Costo (decimal)
- Stock (entero)
- StockMinimo (entero)
```

### Clientes (Dimensión)
```
Columnas:
- ClienteID (entero)
- Nombre (texto)
- Apellido (texto)
- Email (texto)
- Telefono (texto)
- Ciudad (texto)
- Estado (texto)
- FechaRegistro (fecha)
- TipoCliente (texto): Nuevo, Regular, Premium, VIP
```

### Vendedores (Dimensión)
```
Columnas:
- VendedorID (entero)
- Nombre (texto)
- Apellido (texto)
- SucursalID (entero)
- Puesto (texto): Vendedor, Supervisor, Gerente
- FechaContratacion (fecha)
- MetaMensual (decimal)
```

### Sucursales (Dimensión)
```
Columnas:
- SucursalID (entero)
- NombreSucursal (texto)
- Ciudad (texto)
- Estado (texto)
- Zona (texto): Norte, Sur, Centro, Este, Oeste
- TipoTienda (texto): Flagship, Estándar, Express
- FechaApertura (fecha)
```

---

## 📊 Datos Disponibles

### Para Principiantes

**ventas_simple.csv**
- 100 transacciones
- 3 meses de datos
- Perfecto para primeros ejercicios

**productos_simple.xlsx**
- 20 productos
- 3 categorías
- Incluye precios y stock

### Para Nivel Intermedio

**ventas_2024.csv**
- 5,000+ transacciones
- Todo el año 2024
- Múltiples canales

**ventas_2025.csv**
- 3,000+ transacciones
- Primer semestre 2025
- Para comparaciones YoY

**clientes.xlsx**
- 500 clientes
- Información demográfica completa

### Para Nivel Avanzado

**ventas_completo.csv**
- 50,000+ transacciones
- 2024-2025
- Incluye devoluciones y ajustes

**productos_completo.xlsx**
- 200+ productos
- 10 categorías
- Histórico de cambios de precio

---

## 🎯 Casos de Uso por Módulo

### Módulo 1 (Power Query Básico)
Usa: `ventas_simple.csv` + `productos_simple.xlsx`

**Practicar**:
- Importar CSV y Excel
- Cambiar tipos de datos
- Agregar columnas calculadas
- Filtros básicos

### Módulo 2 (Power Query Intermedio)
Usa: `ventas_2024.csv` + `productos_completo.xlsx` + `clientes.xlsx`

**Practicar**:
- Merge de tablas
- Append de archivos
- Funciones personalizadas
- Manejo de errores

### Módulo 4 (DAX Básico)
Usa todos los archivos simples

**Practicar**:
- Medidas de agregación
- Columnas calculadas
- Contexto básico

### Módulo 5 (DAX Intermedio)
Usa: `ventas_2024.csv` + `ventas_2025.csv` + todas las dimensiones

**Practicar**:
- CALCULATE
- Time Intelligence
- Funciones X
- Comparaciones temporales

---

## 📥 Cómo Usar los Datos

### Opción 1: CSV/Excel Directamente

1. Descarga los archivos a tu computadora
2. En Power BI: "Obtener datos" > "Archivo" > "CSV" o "Excel"
3. Selecciona el archivo
4. Sigue las transformaciones de los ejercicios

### Opción 2: Crear Datos en Power Query

Puedes copiar este código directamente en Power Query:

```m
// Tabla de ventas de ejemplo
let
    Fuente = #table(
        {"VentaID", "Fecha", "Producto", "Cantidad", "Precio"},
        {
            {1, #date(2025,11,1), "Laptop", 2, 15999},
            {2, #date(2025,11,2), "Mouse", 5, 299},
            {3, #date(2025,11,3), "Teclado", 3, 899}
        }
    )
in
    Fuente
```

### Opción 3: Generar Datos Aleatorios

Para practicar con más volumen, usa este código:

```m
// Generar 1000 ventas aleatorias
let
    NumeroFilas = 1000,
    FechaInicio = #date(2024, 1, 1),
    FechaFin = #date(2025, 11, 30),

    GenerarVentas = List.Generate(
        () => [
            VentaID = 1,
            Fecha = FechaInicio,
            ProductoID = Number.RoundUp(Number.Random() * 20, 0),
            Cantidad = Number.RoundUp(Number.Random() * 10, 0),
            Precio = Number.Round(Number.Random() * 20000, 2)
        ],
        each [VentaID] <= NumeroFilas,
        each [
            VentaID = [VentaID] + 1,
            Fecha = Date.AddDays(FechaInicio, Number.RoundUp(Number.Random() *
                     Duration.Days(FechaFin - FechaInicio), 0)),
            ProductoID = Number.RoundUp(Number.Random() * 20, 0),
            Cantidad = Number.RoundUp(Number.Random() * 10, 0),
            Precio = Number.Round(Number.Random() * 20000, 2)
        ]
    ),

    ConvertirATabla = Table.FromList(
        GenerarVentas,
        Splitter.SplitByNothing(),
        null,
        null,
        ExtraValues.Error
    ),

    ExpandirColumnas = Table.ExpandRecordColumn(
        ConvertirATabla,
        "Column1",
        {"VentaID", "Fecha", "ProductoID", "Cantidad", "Precio"}
    )
in
    ExpandirColumnas
```

---

## 🎨 Personalización

Siéntete libre de:
- ✅ Modificar los datos para simular tu industria
- ✅ Agregar más columnas según necesites
- ✅ Cambiar valores para diferentes escenarios
- ✅ Crear tus propios datasets combinando conceptos

---

## 💡 Tips para Practicar

1. **Empieza simple**: Usa los archivos "simple" primero
2. **Repite ejercicios**: Practica el mismo ejercicio con diferentes datos
3. **Experimenta**: Modifica los códigos de ejemplo
4. **Crea escenarios**: "¿Qué pasaría si...?"
5. **Documenta**: Escribe comentarios en tu código

---

## 🚀 Ejercicios Sugeridos

### Ejercicio 1: Pipeline Completo
1. Importa `ventas_simple.csv`
2. Limpia los datos
3. Combina con `productos_simple.xlsx`
4. Crea medidas DAX básicas
5. Genera un visual

### Ejercicio 2: Análisis Temporal
1. Carga `ventas_2024.csv` y `ventas_2025.csv`
2. Combínalos con Append
3. Crea tabla de calendario
4. Implementa Time Intelligence
5. Analiza crecimiento YoY

### Ejercicio 3: Segmentación
1. Carga datos de clientes
2. Combina con ventas
3. Crea segmentación RFM
4. Identifica mejores clientes
5. Visualiza los segmentos

---

## 📞 Soporte

Si necesitas:
- Más datos
- Diferentes formatos
- Datos para casos específicos

Revisa los módulos del curso o adapta los scripts de generación de datos.

---

**¡Feliz práctica!** 💪

Los datos de calidad son la base de análisis de calidad. Experimenta todo lo que quieras con estos datasets.
