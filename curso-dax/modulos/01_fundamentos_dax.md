# 📘 Módulo 1: Fundamentos de DAX

## 🎯 Objetivos del Módulo

Al terminar este módulo podrás:
- ✅ Entender qué es DAX y por qué es importante
- ✅ Diferenciar entre **Medidas** y **Columnas Calculadas**
- ✅ Crear tus primeras medidas DAX
- ✅ Usar funciones básicas de agregación
- ✅ Comprender la sintaxis fundamental de DAX

---

## 📚 ¿Qué es DAX?

**DAX** (Data Analysis Expressions) es un **lenguaje de fórmulas** usado en:
- 📊 Power BI
- 📈 Excel Power Pivot
- 🔄 SQL Server Analysis Services

### ¿Por qué aprender DAX?

```
SIN DAX                           CON DAX
🔻                                🔺
- Análisis básicos                - KPIs complejos
- Tablas estáticas                - Cálculos dinámicos
- Sin context awareness           - Context-aware calculations
- Limitado                        - Ilimitadas posibilidades
```

---

## 🆚 Medidas vs Columnas Calculadas

Esta es **LA DIFERENCIA MÁS IMPORTANTE** en DAX:

### 📏 Columnas Calculadas (Calculated Columns)

```dax
-- Se crean en la tabla de datos
-- Se calculan FILA POR FILA
-- Se almacenan en el modelo (ocupan memoria)
-- Se calculan durante la actualización de datos

-- ❌ MAL USO: Calcular totales
Precio Total = 'Ventas'[Cantidad] * 'Ventas'[PrecioUnitario]
```

**Características:**
- ✅ Útiles para clasificaciones o categorías
- ✅ Se pueden usar en slicers/filtros
- ✅ Evaluadas en contexto de fila
- ❌ Ocupan memoria
- ❌ No son dinámicas

### 📊 Medidas (Measures)

```dax
-- Se crean como cálculos independientes
-- Se calculan DINÁMICAMENTE según el contexto
-- NO ocupan memoria (se calculan al vuelo)
-- Responden a filtros y selecciones

-- ✅ BUEN USO: Calcular totales dinámicos
Total Ventas =
    SUMX(
        'Ventas',
        'Ventas'[Cantidad] * 'Ventas'[PrecioUnitario]
    )
```

**Características:**
- ✅ Dinámicas y responden a filtros
- ✅ No ocupan memoria
- ✅ Se recalculan automáticamente
- ✅ Ideales para KPIs y agregaciones

### 🎯 Regla de Oro

> **💡 Usa MEDIDAS para agregaciones y cálculos que cambien según el contexto**
> **💡 Usa COLUMNAS CALCULADAS solo para clasificaciones o datos estáticos por fila**

---

## 🔢 Tu Primera Medida DAX

### Ejemplo 1: Suma Simple

```dax
-- Esta es una medida básica que suma todos los montos de venta

Total Ventas =
    SUM('Ventas'[MontoTotal])

/*
📝 EXPLICACIÓN:
   - SUM() = Función que suma valores
   - 'Ventas' = Nombre de la tabla (entre comillas simples)
   - [MontoTotal] = Nombre de la columna (entre corchetes)
   - El resultado cambia según los filtros aplicados
*/
```

**¿Cómo funciona?**
- Si no hay filtros: suma TODAS las ventas
- Si filtras por "Norte": suma solo ventas del Norte
- Si filtras por "2024": suma solo ventas de 2024
- Si filtras por "Norte" Y "2024": suma ventas del Norte en 2024

### Ejemplo 2: Promedio

```dax
-- Calcula el ticket promedio (venta promedio)

Ticket Promedio =
    AVERAGE('Ventas'[MontoTotal])

/*
📝 EXPLICACIÓN:
   - AVERAGE() = Calcula el promedio aritmético
   - Se adapta a los filtros activos
   - Útil para análisis de valor por transacción
*/
```

### Ejemplo 3: Conteo

```dax
-- Cuenta cuántas transacciones de venta hay

Número de Ventas =
    COUNTROWS('Ventas')

/*
📝 EXPLICACIÓN:
   - COUNTROWS() = Cuenta el número de filas de una tabla
   - Más eficiente que COUNT() para contar filas
   - Se usa para métricas de volumen
*/
```

---

## 📐 Sintaxis de DAX

### Estructura Básica

```dax
Nombre de la Medida = FUNCIÓN(argumentos)
```

### Convenciones de Nomenclatura

```dax
-- ✅ BUENAS PRÁCTICAS

Total Ventas                 -- Nombre descriptivo, sin abreviaturas confusas
Ventas Año Anterior          -- Espacio en blanco para legibilidad
Margen %                     -- Símbolo % indica porcentaje
[Total Ventas]               -- Referencia a otra medida

-- ❌ MALAS PRÁCTICAS

TotVnt                       -- Abreviación confusa
totalventas                  -- Sin espacios ni capitalización
m1                           -- Nombre no descriptivo
```

### Referencias en DAX

```dax
-- Referencia a COLUMNA
'NombreTabla'[NombreColumna]

-- Referencia a MEDIDA
[NombreMedida]

-- Referencia a TABLA
'NombreTabla'
```

---

## 🧮 Funciones Básicas de Agregación

### SUM - Sumar Valores

```dax
-- Suma simple
Total Monto =
    SUM('Ventas'[MontoTotal])

-- Suma con múltiples columnas (necesitas SUMX)
Total Calculado =
    SUMX(
        'Ventas',
        'Ventas'[Cantidad] * 'Ventas'[PrecioUnitario]
    )

/*
📝 DIFERENCIA:
   - SUM() = Suma UNA columna existente
   - SUMX() = Itera fila por fila y suma el resultado de una expresión
*/
```

### AVERAGE - Calcular Promedios

```dax
-- Promedio de monto de venta
Ticket Promedio =
    AVERAGE('Ventas'[MontoTotal])

-- Promedio de descuento aplicado
Descuento Promedio =
    AVERAGE('Ventas'[Descuento])

/*
📝 TIP:
   AVERAGE ignora valores en blanco automáticamente
   Solo considera filas con valores numéricos
*/
```

### COUNT y COUNTROWS - Contar

```dax
-- Contar filas de una tabla (MÁS RÁPIDO)
Total Transacciones =
    COUNTROWS('Ventas')

-- Contar valores en una columna (ignora blancos)
Productos con Descuento =
    COUNT('Ventas'[Descuento])

-- Contar valores únicos
Productos Vendidos =
    DISTINCTCOUNT('Ventas'[ProductoID])

/*
📝 CUÁNDO USAR CADA UNA:
   - COUNTROWS() → Contar todas las filas
   - COUNT() → Contar valores no vacíos en una columna
   - DISTINCTCOUNT() → Contar valores únicos
*/
```

### MIN y MAX - Valores Mínimos y Máximos

```dax
-- Venta más pequeña
Venta Mínima =
    MIN('Ventas'[MontoTotal])

-- Venta más grande
Venta Máxima =
    MAX('Ventas'[MontoTotal])

-- Diferencia entre máximo y mínimo (rango)
Rango de Ventas =
    [Venta Máxima] - [Venta Mínima]

/*
📝 NOTA:
   Las medidas se pueden referenciar con []
   Esto hace el código más modular y mantenible
*/
```

---

## 🎨 Ejemplos Prácticos Completos

### Ejemplo 1: Dashboard Básico de Ventas

```dax
-- 💰 VENTAS TOTALES
Total Ventas =
    SUM('Ventas'[MontoTotal])

-- 📦 UNIDADES VENDIDAS
Unidades Vendidas =
    SUM('Ventas'[Cantidad])

-- 🎫 TICKET PROMEDIO
Ticket Promedio =
    DIVIDE(
        [Total Ventas],
        [Total Transacciones],
        0
    )

/*
📝 DIVIDE():
   - Primer argumento: numerador
   - Segundo argumento: denominador
   - Tercer argumento: valor si hay división por cero
   - MÁS SEGURO que usar /
*/

-- 🔢 NÚMERO DE TRANSACCIONES
Total Transacciones =
    COUNTROWS('Ventas')

-- 🛍️ PRODUCTOS ÚNICOS VENDIDOS
Productos Vendidos =
    DISTINCTCOUNT('Ventas'[ProductoID])

-- 🏪 TIENDAS ACTIVAS
Tiendas Activas =
    DISTINCTCOUNT('Ventas'[TiendaID])
```

### Ejemplo 2: Métricas de Descuentos

```dax
-- 💸 DESCUENTO PROMEDIO (%)
Descuento Promedio % =
    AVERAGE('Ventas'[Descuento])

-- 💰 MONTO TOTAL DE DESCUENTOS
Monto Descontado =
    SUMX(
        'Ventas',
        'Ventas'[Cantidad] *
        RELATED('Productos'[PrecioLista]) *
        ('Ventas'[Descuento] / 100)
    )

/*
📝 RELATED():
   - Trae valores de una tabla relacionada
   - Sigue las relaciones del modelo
   - Solo funciona del lado "muchos" al lado "uno"
   - Veremos más en módulos avanzados
*/

-- 📊 PORCENTAJE DE VENTAS CON DESCUENTO
% Ventas con Descuento =
    DIVIDE(
        COUNTROWS(FILTER('Ventas', 'Ventas'[Descuento] > 0)),
        COUNTROWS('Ventas'),
        0
    )

/*
📝 FILTER():
   - Primera función de filtrado que aprendemos
   - Retorna una tabla filtrada
   - Se profundizará en Módulo 3
*/
```

### Ejemplo 3: Análisis de Productos

```dax
-- 🏆 PRECIO PROMEDIO DE VENTA
Precio Promedio Venta =
    AVERAGE('Ventas'[PrecioUnitario])

-- 📊 CANTIDAD PROMEDIO POR TRANSACCIÓN
Cantidad Promedio =
    AVERAGE('Ventas'[Cantidad])

-- 💵 PRECIO LISTA PROMEDIO (de productos en catálogo)
Precio Lista Promedio =
    AVERAGE('Productos'[PrecioLista])

-- 🎯 DIFERENCIA DE PRECIO (Lista vs Venta Real)
Diferencia Precio =
    [Precio Lista Promedio] - [Precio Promedio Venta]
```

---

## 💡 Tips y Mejores Prácticas

### ✅ DO (Hacer)

1. **Usa nombres descriptivos**
   ```dax
   ✅ Total Ventas Norte
   ❌ TVN
   ```

2. **Formatea tu código para legibilidad**
   ```dax
   ✅ Ticket Promedio =
       DIVIDE(
           [Total Ventas],
           [Total Transacciones],
           0
       )

   ❌ Ticket Promedio = DIVIDE([Total Ventas],[Total Transacciones],0)
   ```

3. **Comenta código complejo**
   ```dax
   ✅ -- Calcula el margen considerando costos variables
      Margen Bruto =
          [Total Ventas] - [Costo Total]
   ```

4. **Usa DIVIDE en lugar de /**
   ```dax
   ✅ DIVIDE([A], [B], 0)    -- Maneja división por cero
   ❌ [A] / [B]              -- Puede dar error
   ```

### ❌ DON'T (No Hacer)

1. **No uses columnas calculadas para agregaciones**
   ```dax
   ❌ Total (columna calculada) = SUM('Ventas'[Monto])
   ✅ Total (medida) = SUM('Ventas'[Monto])
   ```

2. **No repitas lógica, reutiliza medidas**
   ```dax
   ❌ Medida 1 = SUM('Ventas'[Monto]) * 0.16
      Medida 2 = SUM('Ventas'[Monto]) * 0.84

   ✅ Total Ventas = SUM('Ventas'[Monto])
      IVA = [Total Ventas] * 0.16
      Sin IVA = [Total Ventas] * 0.84
   ```

3. **No uses abreviaturas confusas**
   ```dax
   ❌ TotVntAnt, PrcProm, NVnt
   ✅ Total Ventas Año Anterior, Precio Promedio, Número de Ventas
   ```

---

## 🎯 Ejercicios Prácticos

### Ejercicio 1: Métricas Básicas de Ventas
Crea las siguientes medidas:
1. Total de ventas del año
2. Número total de transacciones
3. Ticket promedio
4. Unidades vendidas totales
5. Número de productos diferentes vendidos

### Ejercicio 2: Análisis de Tiendas
Crea medidas para:
1. Número de tiendas que han vendido
2. Venta promedio por tienda
3. Venta máxima registrada
4. Venta mínima registrada

### Ejercicio 3: Análisis de Descuentos
Crea medidas para:
1. Descuento promedio aplicado
2. Porcentaje de ventas con descuento
3. Ventas sin descuento vs con descuento

**💡 TIP:** Las soluciones están en `/soluciones/soluciones_modulo1.md`

---

## 📊 Caso Práctico: Mi Primer Dashboard

### Objetivo
Crear un dashboard básico con 6 KPIs principales

### KPIs a Crear

```dax
-- 1. 💰 VENTAS TOTALES
Total Ventas =
    SUM('Ventas'[MontoTotal])

-- 2. 🎫 TICKET PROMEDIO
Ticket Promedio =
    DIVIDE(
        [Total Ventas],
        COUNTROWS('Ventas'),
        0
    )

-- 3. 📦 UNIDADES VENDIDAS
Unidades Totales =
    SUM('Ventas'[Cantidad])

-- 4. 🛍️ PRODUCTOS VENDIDOS (ÚNICOS)
Productos Únicos =
    DISTINCTCOUNT('Ventas'[ProductoID])

-- 5. 🏪 TIENDAS ACTIVAS
Tiendas Activas =
    DISTINCTCOUNT('Ventas'[TiendaID])

-- 6. 💸 DESCUENTO PROMEDIO
Descuento Promedio =
    AVERAGE('Ventas'[Descuento]) & "%"

/*
📝 NOTA:
   & concatena texto en DAX
   Convierte el número en texto con el símbolo %
*/
```

### Cómo Usar Estas Medidas

1. Crea las 6 medidas en Power BI
2. Arrastra cada medida a una tarjeta (Card visual)
3. Agrega un slicer de fechas
4. Agrega un slicer de regiones
5. **Observa cómo las medidas cambian automáticamente** al filtrar

---

## 🎓 Resumen del Módulo

### Has Aprendido:
✅ Qué es DAX y para qué sirve
✅ Diferencia crítica entre Medidas y Columnas Calculadas
✅ Sintaxis básica de DAX
✅ Funciones de agregación: SUM, AVERAGE, COUNT, COUNTROWS, DISTINCTCOUNT, MIN, MAX
✅ Función DIVIDE para divisiones seguras
✅ Mejores prácticas de nomenclatura y formato
✅ Crear tu primer dashboard con 6 KPIs

### Próximo Módulo:
📚 **Módulo 2: Agregación y Contexto**
- Contexto de fila vs contexto de filtro
- Funciones X (SUMX, AVERAGEX, etc.)
- RELATED y RELATEDTABLE
- Cálculos más complejos

---

## 🔗 Referencias Útiles

- [Documentación oficial de DAX](https://docs.microsoft.com/en-us/dax/)
- [DAX Formatter](https://www.daxformatter.com/) - Formatea tu código DAX
- [SQLBI - DAX Guide](https://dax.guide/) - Referencia completa de funciones

---

**🎉 ¡Felicidades por completar el Módulo 1!**

Ahora tienes las bases para crear medidas DAX. En el siguiente módulo profundizaremos en conceptos más avanzados.

**[➡️ Ir al Módulo 2: Agregación y Contexto](02_agregacion_contexto.md)**

---

*Curso de DAX | Módulo 1 de 6 | Última actualización: 2025*
