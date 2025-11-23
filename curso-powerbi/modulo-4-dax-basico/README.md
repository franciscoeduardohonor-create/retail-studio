# 📘 Módulo 4: DAX - Fundamentos

## 🎯 Objetivos del Módulo

Al finalizar este módulo serás capaz de:
- Entender qué es DAX y cuándo usarlo
- Diferenciar entre Medidas y Columnas Calculadas
- Crear cálculos básicos con DAX
- Comprender el contexto de fila y filtro
- Usar funciones de agregación esenciales

---

## 📚 Contenido

1. [¿Qué es DAX?](#1-qué-es-dax)
2. [Medidas vs Columnas Calculadas](#2-medidas-vs-columnas-calculadas)
3. [Sintaxis Básica de DAX](#3-sintaxis-básica-de-dax)
4. [Funciones de Agregación](#4-funciones-de-agregación)
5. [Contexto en DAX](#5-contexto-en-dax)
6. [Ejercicios Prácticos](#6-ejercicios-prácticos)

---

## 1. ¿Qué es DAX?

### Data Analysis Expressions (DAX)

DAX es el lenguaje de fórmulas utilizado en Power BI para:
- **Crear medidas**: Cálculos dinámicos que responden a filtros
- **Columnas calculadas**: Nuevas columnas en tablas existentes
- **Tablas calculadas**: Tablas completas basadas en expresiones

### Diferencias entre Power Query M y DAX

| Aspecto | Power Query M | DAX |
|---------|---------------|-----|
| **Propósito** | Transformar y limpiar datos (ETL) | Analizar y calcular sobre datos limpios |
| **Cuándo se ejecuta** | Al cargar/refrescar datos | Al interactuar con visuales |
| **Modifica datos fuente** | Sí | No (solo crea cálculos) |
| **Uso típico** | Preparar datos | Análisis de negocio |

### ¿Dónde se escribe DAX?

En Power BI Desktop:
1. **Medidas**: Pestaña "Modelado" > "Nueva medida"
2. **Columnas calculadas**: Pestaña "Modelado" > "Nueva columna"
3. **Tablas calculadas**: Pestaña "Modelado" > "Nueva tabla"

---

## 2. Medidas vs Columnas Calculadas

### 2.1 Columnas Calculadas

Las columnas calculadas:
- Se calculan **fila por fila**
- Se almacenan en el modelo (ocupan memoria)
- Se calculan al refrescar los datos
- Útiles para: categorización, concatenación, extracción de datos

```dax
// EJEMPLO 1: Columna Calculada - Total de Venta
// Se crea en la tabla "Ventas"

TotalVenta = Ventas[Cantidad] * Ventas[PrecioUnitario]

// Explicación:
// - Se calcula para CADA fila de la tabla Ventas
// - El resultado se almacena en la tabla
// - [Cantidad] y [PrecioUnitario] son columnas de la misma tabla
```

```dax
// EJEMPLO 2: Columna Calculada - Categoría de Producto

CategoriaProducto =
IF(
    Ventas[PrecioUnitario] >= 10000,  // Si el precio es >= 10000
    "Premium",                         // Devuelve "Premium"
    IF(
        Ventas[PrecioUnitario] >= 1000, // Si no, si el precio es >= 1000
        "Medio",                        // Devuelve "Medio"
        "Básico"                        // Si no, devuelve "Básico"
    )
)

// Explicación:
// - IF anidados para crear categorías
// - Se evalúa fila por fila
// - El resultado es una nueva columna de texto en la tabla
```

```dax
// EJEMPLO 3: Columna Calculada - Nombre Completo del Cliente

NombreCompleto = Clientes[Nombre] & " " & Clientes[Apellido]

// Explicación:
// - & es el operador de concatenación en DAX
// - " " agrega un espacio entre nombre y apellido
// - Se calcula para cada fila de la tabla Clientes
```

---

### 2.2 Medidas

Las medidas:
- Se calculan **dinámicamente** según el contexto
- NO se almacenan (no ocupan memoria adicional)
- Se recalculan con cada interacción
- Útiles para: agregaciones, KPIs, análisis

```dax
// EJEMPLO 4: Medida - Total de Ventas
// Se crea como medida independiente o en una tabla

Total Ventas = SUM(Ventas[TotalVenta])

// Explicación:
// - SUM suma todos los valores de la columna TotalVenta
// - El resultado cambia según los filtros aplicados
// - No se almacena, se calcula en tiempo real
```

```dax
// EJEMPLO 5: Medida - Cantidad de Productos Vendidos

Cantidad Vendida = SUM(Ventas[Cantidad])

// Explicación:
// - Suma todas las cantidades vendidas
// - Si filtras por producto, solo suma ese producto
// - Si filtras por fecha, solo suma esas fechas
```

```dax
// EJEMPLO 6: Medida - Ticket Promedio

Ticket Promedio =
DIVIDE(
    [Total Ventas],        // Numerador: total de ventas
    [Cantidad Vendida],    // Denominador: cantidad de productos
    0                      // Valor si hay división por cero
)

// Explicación:
// - DIVIDE es más seguro que usar / (maneja división por cero)
// - Las medidas pueden referenciar otras medidas con [NombreMedida]
// - El tercer parámetro (0) es lo que devuelve si el denominador es 0
```

---

### 2.3 ¿Cuándo usar cada una?

**Usa Columnas Calculadas cuando**:
- ✅ Necesitas categorizar o etiquetar datos
- ✅ Quieres usar el resultado en un slicer (filtro)
- ✅ El cálculo es fila por fila con datos de la misma tabla

**Usa Medidas cuando**:
- ✅ Necesitas agregaciones (sumas, promedios, conteos)
- ✅ El resultado debe cambiar según filtros
- ✅ Quieres optimizar el uso de memoria
- ✅ Necesitas cálculos que comparan periodos o contextos

---

## 3. Sintaxis Básica de DAX

### 3.1 Estructura de una Fórmula DAX

```dax
// EJEMPLO 7: Estructura completa de una medida

Ventas Totales con IVA =
SUM(Ventas[TotalVenta]) * 1.16

// Componentes:
// 1. "Ventas Totales con IVA" = Nombre de la medida
// 2. SUM() = Función de agregación
// 3. Ventas[TotalVenta] = Referencia a columna (Tabla[Columna])
// 4. * 1.16 = Operador matemático para agregar 16% de IVA
```

### 3.2 Referenciar Columnas y Tablas

```dax
// EJEMPLO 8: Diferentes formas de referenciar

// Referencia a columna (SIEMPRE especifica la tabla)
Total = Ventas[TotalVenta]

// Referencia a medida (entre corchetes, sin tabla)
TotalConIVA = [Total Ventas] * 1.16

// INCORRECTO - Esto causará error:
// Total = [TotalVenta]  // ❌ Falta el nombre de la tabla

// CORRECTO:
Total = Ventas[TotalVenta]  // ✅ Tabla[Columna]
```

### 3.3 Comentarios en DAX

```dax
// EJEMPLO 9: Uso de comentarios

Margen de Utilidad =
// Esta medida calcula el margen de utilidad en porcentaje
DIVIDE(
    [Total Ventas] - [Total Costos],  // Utilidad (ventas menos costos)
    [Total Ventas],                    // Ventas totales
    0                                  // Si no hay ventas, devuelve 0
) * 100  // Multiplicamos por 100 para obtener porcentaje

/*
Comentario multi-línea:
Esta fórmula es útil para análisis de rentabilidad
Muestra qué porcentaje de las ventas es utilidad
*/
```

### 3.4 Operadores en DAX

```dax
// EJEMPLO 10: Operadores matemáticos y lógicos

// OPERADORES MATEMÁTICOS
Suma = [Ventas] + [Devoluciones]
Resta = [Ventas] - [Costos]
Multiplicacion = [Precio] * [Cantidad]
Division = [Total] / [Cantidad]

// OPERADORES DE COMPARACIÓN
Es Mayor = [Ventas] > [Meta]         // Devuelve TRUE o FALSE
Es Igual = [Categoria] = "Premium"   // Comparación de texto
Es Diferente = [Stock] <> 0          // <> significa "diferente de"

// OPERADORES LÓGICOS
Condicion Y = [Ventas] > 1000 && [Stock] > 0    // && significa AND
Condicion O = [Categoria] = "A" || [Categoria] = "B"  // || significa OR

// CONCATENACIÓN
Nombre Completo = [Nombre] & " " & [Apellido]  // & une texto
```

---

## 4. Funciones de Agregación

### 4.1 SUM - Sumar valores

```dax
// EJEMPLO 11: Función SUM

// Medida básica: Suma de todas las ventas
Total Ventas = SUM(Ventas[TotalVenta])

// Medida: Suma de cantidades
Total Unidades = SUM(Ventas[Cantidad])

// Explicación:
// - SUM ignora valores en blanco
// - Solo suma valores numéricos
// - Respeta el contexto de filtro (lo veremos más adelante)
```

### 4.2 AVERAGE - Promedio

```dax
// EJEMPLO 12: Función AVERAGE

// Promedio de ventas
Venta Promedio = AVERAGE(Ventas[TotalVenta])

// Precio promedio de productos
Precio Promedio = AVERAGE(Productos[Precio])

// Explicación:
// - AVERAGE calcula el promedio aritmético
// - Ignora celdas en blanco
// - No ignora ceros (si quieres excluir ceros, usa AVERAGEX con filtro)
```

### 4.3 COUNT y COUNTA

```dax
// EJEMPLO 13: Contar valores

// COUNT: Cuenta valores numéricos (ignora blancos y texto)
Cantidad de Ventas = COUNT(Ventas[ID])

// COUNTA: Cuenta cualquier valor no vacío (números, texto, fechas)
Cantidad de Productos = COUNTA(Productos[Nombre])

// COUNTROWS: Cuenta filas en una tabla
Total de Transacciones = COUNTROWS(Ventas)

// Explicación:
// - COUNT: Solo números
// - COUNTA: Cualquier valor no vacío
// - COUNTROWS: Todas las filas (incluso si tienen valores vacíos)
```

### 4.4 MIN y MAX

```dax
// EJEMPLO 14: Valores mínimos y máximos

// Venta más baja
Venta Minima = MIN(Ventas[TotalVenta])

// Venta más alta
Venta Maxima = MAX(Ventas[TotalVenta])

// Fecha de primera venta
Primera Venta = MIN(Ventas[Fecha])

// Fecha de última venta
Ultima Venta = MAX(Ventas[Fecha])

// Explicación:
// - MIN devuelve el valor más pequeño
// - MAX devuelve el valor más grande
// - Funcionan con números, fechas y texto
```

### 4.5 DIVIDE - División segura

```dax
// EJEMPLO 15: División con manejo de errores

// Ticket promedio (forma INCORRECTA)
Ticket Promedio Incorrecto = [Total Ventas] / [Cantidad Vendida]
// ❌ Problema: Si Cantidad Vendida es 0, da error

// Ticket promedio (forma CORRECTA)
Ticket Promedio =
DIVIDE(
    [Total Ventas],       // Numerador
    [Cantidad Vendida],   // Denominador
    0                     // Valor alternativo si denominador = 0
)
// ✅ Si Cantidad Vendida es 0, devuelve 0 en lugar de error

// Margen de utilidad en porcentaje
Margen % =
DIVIDE(
    [Total Ventas] - [Total Costos],  // Utilidad
    [Total Ventas],                    // Ventas totales
    BLANK()                            // Devuelve espacio en blanco si no hay ventas
) * 100

// Explicación:
// - DIVIDE evita errores de división por cero
// - El tercer parámetro es opcional (default: BLANK())
// - Puedes usar 0, BLANK(), o cualquier valor como alternativa
```

---

## 5. Contexto en DAX

### 5.1 ¿Qué es el Contexto?

El contexto determina **qué filas** se incluyen en el cálculo. Hay dos tipos:

1. **Contexto de Fila**: Una fila a la vez (columnas calculadas)
2. **Contexto de Filtro**: Conjunto de filas (medidas)

### 5.2 Contexto de Fila (Row Context)

```dax
// EJEMPLO 16: Contexto de fila en columnas calculadas

// Columna Calculada en tabla Ventas
Total por Linea = Ventas[Cantidad] * Ventas[PrecioUnitario]

// Explicación:
// - Se evalúa FILA POR FILA
// - En cada fila, [Cantidad] y [PrecioUnitario] son los valores de ESA fila
// - No puedes usar SUM, AVERAGE, etc. directamente en columnas calculadas
//   porque ya estás en una sola fila

// Ejemplo fila por fila:
// Fila 1: Cantidad=2, Precio=100 → Total=200
// Fila 2: Cantidad=3, Precio=150 → Total=450
// Fila 3: Cantidad=1, Precio=200 → Total=200
```

```dax
// EJEMPLO 17: Categorización con contexto de fila

// Columna Calculada: Clasificar vendedores por rendimiento
Clasificacion Vendedor =
SWITCH(
    TRUE(),
    Ventas[TotalVenta] >= 50000, "Top",      // Si venta >= 50000
    Ventas[TotalVenta] >= 20000, "Medio",    // Si venta >= 20000
    "Básico"                                  // Cualquier otro caso
)

// Explicación de SWITCH:
// - SWITCH con TRUE() permite evaluar múltiples condiciones
// - Se evalúa cada condición en orden
// - Devuelve el valor de la primera condición verdadera
```

### 5.3 Contexto de Filtro (Filter Context)

```dax
// EJEMPLO 18: Contexto de filtro en medidas

// Medida: Total de ventas
Total Ventas = SUM(Ventas[TotalVenta])

// Explicación del contexto de filtro:
// Esta medida cambia según los filtros aplicados:

// Sin filtros: suma TODAS las ventas
// Con filtro de Producto="Laptop": suma solo ventas de Laptop
// Con filtro de Mes="Enero": suma solo ventas de enero
// Con filtros múltiples (Laptop + Enero): suma ventas de Laptop en enero
```

```dax
// EJEMPLO 19: Contexto de filtro visual

// Imagina esta tabla visual:
// | Producto  | Total Ventas |
// |-----------|--------------|
// | Laptop    | 45,000       | ← Contexto: solo filas donde Producto="Laptop"
// | Mouse     | 5,000        | ← Contexto: solo filas donde Producto="Mouse"
// | Teclado   | 8,000        | ← Contexto: solo filas donde Producto="Teclado"
// | TOTAL     | 58,000       | ← Contexto: todas las filas

// La misma medida [Total Ventas] da diferentes resultados
// según la fila del visual donde se muestra
```

### 5.4 Ejemplo Práctico: Contexto en Acción

```dax
// EJEMPLO 20: Comparando columna calculada vs medida

// COLUMNA CALCULADA (contexto de fila):
Precio con IVA = Productos[Precio] * 1.16
// Se calcula UNA VEZ para cada producto al refrescar datos
// Producto A: Precio=100 → Precio con IVA=116
// Producto B: Precio=200 → Precio con IVA=232

// MEDIDA (contexto de filtro):
Total Ventas con IVA = SUM(Ventas[TotalVenta]) * 1.16
// Se calcula DINÁMICAMENTE según filtros
// Sin filtros: suma todas las ventas * 1.16
// Con filtro Producto="A": suma solo ventas del producto A * 1.16
// Con filtro Fecha=Enero: suma solo ventas de enero * 1.16
```

---

## 6. Ejercicios Prácticos

### Ejercicio 1: Tus Primeras Medidas

**Escenario**: Tienes una tabla de ventas con columnas: Fecha, Producto, Cantidad, PrecioUnitario, Costo

**Crea las siguientes medidas**:
1. Total de Ingresos (Cantidad * PrecioUnitario)
2. Total de Costos (Cantidad * Costo)
3. Utilidad (Ingresos - Costos)
4. Margen de Utilidad % (Utilidad / Ingresos * 100)
5. Cantidad Total de Productos Vendidos

**Intenta hacerlo tú mismo antes de ver la solución**

<details>
<summary>👉 Ver Solución</summary>

```dax
// 1. Total de Ingresos
Total Ingresos =
SUMX(
    Ventas,
    Ventas[Cantidad] * Ventas[PrecioUnitario]
)
// SUMX itera fila por fila, multiplica y luego suma
// Es necesario cuando necesitas calcular algo antes de sumar

// 2. Total de Costos
Total Costos =
SUMX(
    Ventas,
    Ventas[Cantidad] * Ventas[Costo]
)

// 3. Utilidad
Utilidad = [Total Ingresos] - [Total Costos]
// Las medidas pueden referenciar otras medidas

// 4. Margen de Utilidad %
Margen % =
DIVIDE(
    [Utilidad],
    [Total Ingresos],
    0
) * 100
// DIVIDE protege contra división por cero

// 5. Cantidad Total Vendida
Cantidad Total Vendida = SUM(Ventas[Cantidad])
```

**Nota**: También podrías crear una columna calculada "TotalVenta" primero:
```dax
// Columna Calculada en tabla Ventas:
TotalVenta = Ventas[Cantidad] * Ventas[PrecioUnitario]

// Luego la medida sería más simple:
Total Ingresos = SUM(Ventas[TotalVenta])
```
</details>

---

### Ejercicio 2: Columnas Calculadas de Categorización

**Escenario**: Tabla de Productos con: Nombre, Precio, Stock

**Crea las siguientes columnas calculadas**:
1. Rango de Precio (Económico < 1000, Medio 1000-5000, Premium > 5000)
2. Estado de Stock (Sin Stock = 0, Stock Bajo < 10, Stock Normal >= 10)
3. Valor de Inventario (Precio * Stock)
4. Nombre Corto (primeras 10 caracteres del nombre)

**Intenta hacerlo tú mismo**

<details>
<summary>👉 Ver Solución</summary>

```dax
// 1. Rango de Precio
Rango Precio =
SWITCH(
    TRUE(),
    Productos[Precio] < 1000, "Económico",
    Productos[Precio] <= 5000, "Medio",
    "Premium"
)

// Alternativa con IF anidados:
Rango Precio (IF) =
IF(
    Productos[Precio] < 1000,
    "Económico",
    IF(
        Productos[Precio] <= 5000,
        "Medio",
        "Premium"
    )
)

// 2. Estado de Stock
Estado Stock =
SWITCH(
    TRUE(),
    Productos[Stock] = 0, "Sin Stock",
    Productos[Stock] < 10, "Stock Bajo",
    "Stock Normal"
)

// 3. Valor de Inventario
Valor Inventario = Productos[Precio] * Productos[Stock]

// 4. Nombre Corto
Nombre Corto = LEFT(Productos[Nombre], 10)
// LEFT extrae los primeros N caracteres de un texto
```
</details>

---

### Ejercicio 3: Análisis de Ventas

**Escenario**: Tabla Ventas con: Fecha, Producto, Vendedor, Cantidad, Precio, Costo

**Crea estas medidas analíticas**:
1. Número de Transacciones
2. Ticket Promedio (Venta promedio por transacción)
3. Cantidad Promedio por Transacción
4. Venta Máxima
5. Venta Mínima
6. ROI % (Retorno sobre inversión: (Ingresos-Costos)/Costos * 100)

**Intenta hacerlo tú mismo**

<details>
<summary>👉 Ver Solución</summary>

```dax
// 1. Número de Transacciones
Num Transacciones = COUNTROWS(Ventas)
// Cuenta todas las filas de la tabla Ventas

// 2. Ticket Promedio
Ticket Promedio =
DIVIDE(
    [Total Ingresos],
    [Num Transacciones],
    0
)
// Ingreso total dividido entre número de transacciones

// 3. Cantidad Promedio por Transacción
Cantidad Promedio =
DIVIDE(
    [Cantidad Total Vendida],
    [Num Transacciones],
    0
)

// 4. Venta Máxima
Venta Maxima =
MAXX(
    Ventas,
    Ventas[Cantidad] * Ventas[Precio]
)
// MAXX evalúa la expresión para cada fila y devuelve el máximo

// 5. Venta Mínima
Venta Minima =
MINX(
    Ventas,
    Ventas[Cantidad] * Ventas[Precio]
)

// 6. ROI %
ROI % =
DIVIDE(
    [Total Ingresos] - [Total Costos],
    [Total Costos],
    0
) * 100
// (Ganancia / Inversión) * 100
```
</details>

---

### Ejercicio 4: Texto y Lógica

**Escenario**: Tabla Clientes con: Nombre, Apellido, Email, TotalCompras, UltimaCompra (fecha)

**Crea estas columnas calculadas**:
1. Nombre Completo (Nombre + Apellido)
2. Iniciales (Primera letra de Nombre + Primera letra de Apellido)
3. Tipo de Cliente (VIP si TotalCompras > 50000, Regular si >= 10000, Nuevo si < 10000)
4. Días Desde Última Compra

**Intenta hacerlo tú mismo**

<details>
<summary>👉 Ver Solución</summary>

```dax
// 1. Nombre Completo
Nombre Completo = Clientes[Nombre] & " " & Clientes[Apellido]
// & concatena texto

// 2. Iniciales
Iniciales =
LEFT(Clientes[Nombre], 1) & LEFT(Clientes[Apellido], 1)
// LEFT(texto, 1) extrae el primer carácter

// Para mayúsculas:
Iniciales Mayusculas =
UPPER(LEFT(Clientes[Nombre], 1) & LEFT(Clientes[Apellido], 1))

// 3. Tipo de Cliente
Tipo Cliente =
SWITCH(
    TRUE(),
    Clientes[TotalCompras] > 50000, "VIP",
    Clientes[TotalCompras] >= 10000, "Regular",
    "Nuevo"
)

// 4. Días Desde Última Compra
Dias Sin Comprar =
DATEDIFF(
    Clientes[UltimaCompra],  // Fecha inicio
    TODAY(),                  // Fecha fin (hoy)
    DAY                       // Unidad (DAY, MONTH, YEAR)
)
// DATEDIFF calcula la diferencia entre dos fechas
```
</details>

---

## 🎯 Resumen del Módulo

**Has aprendido**:
- ✅ Qué es DAX y cuándo usarlo
- ✅ Diferencia entre Medidas y Columnas Calculadas
- ✅ Sintaxis básica de DAX
- ✅ Funciones de agregación (SUM, AVERAGE, COUNT, MIN, MAX, DIVIDE)
- ✅ Concepto de contexto de fila y filtro
- ✅ Operadores matemáticos y lógicos
- ✅ Funciones de texto y fechas básicas

**Próximo Módulo**: [Módulo 5 - DAX Intermedio](../modulo-5-dax-intermedio/README.md)

Donde aprenderás:
- Time Intelligence (análisis temporal)
- CALCULATE y modificación de contexto
- Funciones iteradoras (SUMX, AVERAGEX)
- Variables en DAX
- Tablas calculadas

---

## 📌 Consejos Importantes

1. **Medidas para análisis**: Siempre que necesites sumar, promediar, contar → usa MEDIDAS
2. **Columnas para categorizar**: Cuando necesites agrupar o filtrar → usa COLUMNAS CALCULADAS
3. **DIVIDE es tu amigo**: Siempre usa DIVIDE en lugar de / para evitar errores
4. **Nombres descriptivos**: Usa nombres claros para tus medidas (ej: "Total Ventas" en lugar de "TV")
5. **Comenta tu código**: Los comentarios te ayudarán a entender tus fórmulas después

---

**¡Felicidades por completar el Módulo 4!** 🎉

Practica creando medidas y columnas calculadas con tus propios datos antes de avanzar.
