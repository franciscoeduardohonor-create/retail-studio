# 📝 Ejercicios Prácticos - Curso DAX

## 🎯 Módulo 1: Fundamentos

### Ejercicio 1.1: Métricas Básicas
Crea las siguientes medidas:
```dax
1. Total de ventas
2. Número de transacciones
3. Ticket promedio
4. Unidades vendidas totales
5. Productos únicos vendidos
```

### Ejercicio 1.2: Análisis de Tiendas
```dax
1. Número de tiendas activas
2. Venta promedio por tienda
3. Venta máxima
4. Venta mínima
5. Rango de ventas (máx - mín)
```

---

## 🎯 Módulo 2: Agregación y Contexto

### Ejercicio 2.1: Funciones Iteradoras
```dax
1. Monto total calculado (Cantidad × PrecioUnitario) usando SUMX
2. Descuento total en pesos usando SUMX
3. Precio promedio ponderado por cantidad usando AVERAGEX
```

### Ejercicio 2.2: RELATED
```dax
1. Diferencia entre precio de venta y precio de lista
2. Margen asumiendo costo = 60% del precio lista
3. % de ventas de productos "SAMSUNG"
```

---

## 🎯 Módulo 3: CALCULATE y Filtros

### Ejercicio 3.1: Filtros Básicos
```dax
1. Ventas solo de región "Norte"
2. Ventas de productos "Smartphones"
3. Ventas con descuento > 15%
```

### Ejercicio 3.2: Porcentajes
```dax
1. % de ventas de cada región vs total
2. % de ventas de cada categoría dentro de su región
3. % de ventas de cada producto dentro de su categoría
```

### Ejercicio 3.3: Rankings
```dax
1. Top 5 productos por ventas
2. Top 3 regiones por ventas
3. Ranking de tiendas
```

---

## 🎯 Módulo 4: Time Intelligence

### Ejercicio 4.1: Acumulados
```dax
1. Ventas YTD (año hasta la fecha)
2. Ventas MTD (mes hasta la fecha)
3. Ventas QTD (trimestre hasta la fecha)
```

### Ejercicio 4.2: Comparaciones Temporales
```dax
1. Ventas del mes anterior
2. Ventas del mismo mes año anterior
3. % Crecimiento MoM (mes vs mes anterior)
4. % Crecimiento YoY (año vs año anterior)
```

### Ejercicio 4.3: Tendencias
```dax
1. Promedio móvil 7 días
2. Promedio móvil 30 días
3. Proyección fin de año
```

---

## 🎯 Módulo 5: KPIs Retail

### Ejercicio 5.1: Sell-Out / Sell-Through
```dax
1. Sell-Out (unidades vendidas)
2. Sell-In (unidades compradas)
3. Sell-Through % (sell-out / sell-in)
```

### Ejercicio 5.2: Market Share
```dax
1. Market Share % por marca
2. Market Share % dentro de categoría
3. Ranking de participación
```

### Ejercicio 5.3: Clasificación ABC
```dax
1. Segmento ABC de productos
2. Número de productos A, B, C
3. Ventas de productos A, B, C
```

---

## 🎯 Módulo 6: Optimización

### Ejercicio 6.1: Usar Variables
Optimiza esta medida usando variables:
```dax
-- Antes
Margen % =
    DIVIDE(
        SUM('Ventas'[Monto]) - SUMX('Ventas', 'Ventas'[Cant] * RELATED('Productos'[Costo])),
        SUM('Ventas'[Monto]),
        0
    ) * 100

-- Tu solución aquí:
```

### Ejercicio 6.2: Optimizar Filtros
Optimiza para mejor rendimiento:
```dax
-- Antes (lento)
Productos Alto Valor =
    CALCULATE(
        [Total Ventas],
        FILTER(
            'Productos',
            [Total Ventas] > 100000
        )
    )

-- Tu solución aquí:
```

---

## 🔑 SOLUCIONES

<details>
<summary>Click para ver soluciones</summary>

### Soluciones Módulo 1

```dax
-- 1.1.1
Total Ventas = SUM('Ventas'[MontoTotal])

-- 1.1.2
Número Transacciones = COUNTROWS('Ventas')

-- 1.1.3
Ticket Promedio = DIVIDE([Total Ventas], [Número Transacciones], 0)

-- 1.1.4
Unidades Vendidas = SUM('Ventas'[Cantidad])

-- 1.1.5
Productos Únicos = DISTINCTCOUNT('Ventas'[ProductoID])

-- 1.2.1
Tiendas Activas = DISTINCTCOUNT('Ventas'[TiendaID])

-- 1.2.2
Venta Promedio por Tienda =
    DIVIDE([Total Ventas], [Tiendas Activas], 0)

-- 1.2.3
Venta Máxima = MAX('Ventas'[MontoTotal])

-- 1.2.4
Venta Mínima = MIN('Ventas'[MontoTotal])

-- 1.2.5
Rango Ventas = [Venta Máxima] - [Venta Mínima]
```

### Soluciones Módulo 2

```dax
-- 2.1.1
Monto Calculado =
    SUMX(
        'Ventas',
        'Ventas'[Cantidad] * 'Ventas'[PrecioUnitario]
    )

-- 2.1.2
Descuento en Pesos =
    SUMX(
        'Ventas',
        'Ventas'[Cantidad] *
        RELATED('Productos'[PrecioLista]) *
        ('Ventas'[Descuento] / 100)
    )

-- 2.1.3
Precio Promedio Ponderado =
    DIVIDE(
        SUMX('Ventas', 'Ventas'[Cantidad] * 'Ventas'[PrecioUnitario]),
        SUM('Ventas'[Cantidad]),
        0
    )

-- 2.2.1
Diferencia Precio =
    SUMX(
        'Ventas',
        (RELATED('Productos'[PrecioLista]) - 'Ventas'[PrecioUnitario]) *
        'Ventas'[Cantidad]
    )

-- 2.2.2
Margen Estimado =
    SUMX(
        'Ventas',
        ('Ventas'[PrecioUnitario] -
        RELATED('Productos'[PrecioLista]) * 0.60) *
        'Ventas'[Cantidad]
    )

-- 2.2.3
% Ventas Samsung =
    DIVIDE(
        CALCULATE([Total Ventas], 'Productos'[Marca] = "SAMSUNG"),
        [Total Ventas],
        0
    ) * 100
```

### Soluciones Módulo 3

```dax
-- 3.1.1
Ventas Norte =
    CALCULATE([Total Ventas], 'Tiendas'[Region] = "Norte")

-- 3.1.2
Ventas Smartphones =
    CALCULATE([Total Ventas], 'Productos'[Categoria] = "Smartphones")

-- 3.1.3
Ventas Alto Descuento =
    CALCULATE([Total Ventas], 'Ventas'[Descuento] > 15)

-- 3.2.1
% del Total =
    DIVIDE(
        [Total Ventas],
        CALCULATE([Total Ventas], ALL('Tiendas'[Region])),
        0
    ) * 100

-- 3.2.2
% en Región =
    DIVIDE(
        [Total Ventas],
        CALCULATE([Total Ventas], ALLEXCEPT('Ventas', 'Tiendas'[Region])),
        0
    ) * 100

-- 3.2.3
% en Categoría =
    DIVIDE(
        [Total Ventas],
        CALCULATE([Total Ventas], ALLEXCEPT('Productos', 'Productos'[Categoria])),
        0
    ) * 100

-- 3.3.1
Top 5 Productos =
    CALCULATE(
        [Total Ventas],
        TOPN(5, ALL('Productos'), [Total Ventas], DESC)
    )

-- 3.3.2
Ranking Tienda =
    RANKX(ALL('Tiendas'[TiendaID]), [Total Ventas], , DESC, DENSE)
```

### Soluciones Módulo 4

```dax
-- 4.1.1
Ventas YTD =
    TOTALYTD([Total Ventas], 'Calendario'[Fecha])

-- 4.1.2
Ventas MTD =
    TOTALMTD([Total Ventas], 'Calendario'[Fecha])

-- 4.1.3
Ventas QTD =
    TOTALQTD([Total Ventas], 'Calendario'[Fecha])

-- 4.2.1
Ventas Mes Anterior =
    CALCULATE([Total Ventas], PARALLELPERIOD('Calendario'[Fecha], -1, MONTH))

-- 4.2.2
Ventas Año Anterior =
    CALCULATE([Total Ventas], SAMEPERIODLASTYEAR('Calendario'[Fecha]))

-- 4.2.3
% Crecimiento MoM =
    DIVIDE(
        [Total Ventas] - [Ventas Mes Anterior],
        [Ventas Mes Anterior],
        0
    ) * 100

-- 4.2.4
% Crecimiento YoY =
    DIVIDE(
        [Total Ventas] - [Ventas Año Anterior],
        [Ventas Año Anterior],
        0
    ) * 100

-- 4.3.1
Promedio Móvil 7d =
VAR FechaMax = MAX('Calendario'[Fecha])
RETURN
    CALCULATE(
        AVERAGE('Ventas'[MontoTotal]),
        DATESBETWEEN('Calendario'[Fecha], FechaMax - 7, FechaMax)
    )
```

### Soluciones Módulo 6

```dax
-- 6.1 Con Variables
Margen % Optimizado =
VAR Ingresos = SUM('Ventas'[Monto])
VAR Costos =
    SUMX(
        'Ventas',
        'Ventas'[Cant] * RELATED('Productos'[Costo])
    )
VAR Margen = Ingresos - Costos

RETURN
    DIVIDE(Margen, Ingresos, 0) * 100

-- 6.2 Optimizado
Productos Alto Valor Opt =
    CALCULATE(
        [Total Ventas],
        TOPN(100, ALL('Productos'), [Total Ventas], DESC)
    )
```

</details>

---

📖 **Practica con los datos de ejemplo en `/datos/`**

¡Buena suerte! 💪
