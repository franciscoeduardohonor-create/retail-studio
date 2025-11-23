# Módulo 4: Tablas y Arreglos en COBOL

## 📖 Introducción

Las tablas (arreglos) permiten almacenar múltiples valores del mismo tipo en una sola estructura. Son fundamentales para procesamiento de datos en lotes y manejo de colecciones.

## 🎯 Objetivos

- Definir tablas con OCCURS
- Acceder a elementos por índice
- Usar SEARCH y SEARCH ALL
- Trabajar con tablas multidimensionales
- Implementar ordenamiento

## 📊 Definición de Tablas

### OCCURS - Tabla Simple

```cobol
01  WS-DIAS-SEMANA.
    05  WS-DIA  PIC X(10) OCCURS 7 TIMES.

*> Acceso:
MOVE "Lunes" TO WS-DIA(1).
MOVE "Martes" TO WS-DIA(2).
DISPLAY WS-DIA(3).  *> Muestra día 3
```

### Tabla con Múltiples Campos

```cobol
01  WS-EMPLEADOS.
    05  WS-EMP OCCURS 100 TIMES.
        10  WS-EMP-ID      PIC 9(6).
        10  WS-EMP-NOMBRE  PIC X(40).
        10  WS-EMP-SALARIO PIC 9(6)V99.

*> Acceso:
MOVE 100234 TO WS-EMP-ID(1).
MOVE "Juan Pérez" TO WS-EMP-NOMBRE(1).
```

### Tabla con INDEXED BY

```cobol
01  WS-PRODUCTOS.
    05  WS-PROD OCCURS 50 TIMES
        INDEXED BY WS-IDX.
        10  WS-PROD-CODIGO  PIC X(10).
        10  WS-PROD-PRECIO  PIC 9(6)V99.

*> Uso del índice:
SET WS-IDX TO 1.
PERFORM VARYING WS-IDX FROM 1 BY 1 UNTIL WS-IDX > 50
    DISPLAY WS-PROD-CODIGO(WS-IDX)
END-PERFORM.
```

## 🔍 Búsqueda en Tablas

### SEARCH - Búsqueda Secuencial

```cobol
01  WS-CODIGOS-TABLA.
    05  WS-COD OCCURS 100 TIMES
        INDEXED BY WS-INDICE.
        10  WS-CODIGO       PIC X(10).
        10  WS-DESCRIPCION  PIC X(30).

*> Búsqueda:
SET WS-INDICE TO 1.
SEARCH WS-COD
    AT END
        DISPLAY "No encontrado"
    WHEN WS-CODIGO(WS-INDICE) = "PROD001"
        DISPLAY "Encontrado: " WS-DESCRIPCION(WS-INDICE)
END-SEARCH.
```

### SEARCH ALL - Búsqueda Binaria

```cobol
*> La tabla debe estar ordenada y usar KEY
01  WS-PRODUCTOS-TABLA.
    05  WS-PRODUCTO OCCURS 100 TIMES
        ASCENDING KEY IS WS-PROD-CODIGO
        INDEXED BY WS-IDX-PROD.
        10  WS-PROD-CODIGO  PIC X(10).
        10  WS-PROD-NOMBRE  PIC X(30).

SEARCH ALL WS-PRODUCTO
    AT END
        DISPLAY "Producto no encontrado"
    WHEN WS-PROD-CODIGO(WS-IDX-PROD) = "PROD001"
        DISPLAY WS-PROD-NOMBRE(WS-IDX-PROD)
END-SEARCH.
```

## 📐 Tablas Multidimensionales

### Tabla 2D (Matriz)

```cobol
01  WS-MATRIZ.
    05  WS-FILA OCCURS 10 TIMES.
        10  WS-CELDA OCCURS 10 TIMES PIC 9(3).

*> Acceso:
MOVE 100 TO WS-CELDA(1, 1).     *> Fila 1, Columna 1
MOVE 200 TO WS-CELDA(5, 3).     *> Fila 5, Columna 3
```

### Tabla 3D

```cobol
01  WS-VENTAS-ANUALES.
    05  WS-TRIMESTRE OCCURS 4 TIMES.
        10  WS-MES OCCURS 3 TIMES.
            15  WS-DIA OCCURS 30 TIMES PIC 9(6)V99.

*> Acceso: Trimestre 2, Mes 1, Día 15
MOVE 15000.50 TO WS-DIA(2, 1, 15).
```

## 🔄 Ordenamiento

### SORT - Ordenar Tabla

```cobol
*> Ordenar archivo completo
SORT ARCHIVO-SORT
    ON ASCENDING KEY SORT-CODIGO
    USING ARCHIVO-ENTRADA
    GIVING ARCHIVO-SALIDA.
```

## 💻 Ejemplos Prácticos

### Ejemplo 13: Gestión de Calificaciones con Tablas
Ver: `ejemplo-13-tablas-calificaciones.cob`
- Tabla de estudiantes
- Promedio y estadísticas
- Búsqueda por nombre

### Ejemplo 14: Matriz de Ventas
Ver: `ejemplo-14-matriz-ventas.cob`
- Tabla bidimensional
- Totales por fila y columna
- Reportes

## 🔨 Ejercicios

### Ejercicio 1: Registro de Asistencia
Tabla de 30 estudiantes × 20 días
- Marcar presente/ausente
- Calcular porcentaje de asistencia
- Identificar estudiantes en riesgo

### Ejercicio 2: Tabla de Multiplicar
Genera tabla 12x12
- Carga la matriz
- Imprime formateada
- Busca un resultado

### Ejercicio 3: Top 10 Productos
- Carga productos desde archivo
- Ordena por ventas
- Muestra top 10

## 💡 Mejores Prácticas

1. Usar INDEXED BY para búsquedas
2. SEARCH ALL más rápido que SEARCH (tabla ordenada)
3. Inicializar tablas antes de usar
4. Validar índices (no exceder OCCURS)
5. Documentar dimensiones de tablas

## ⚠️ Errores Comunes

1. Índice fuera de rango
2. No inicializar tabla
3. Usar SEARCH ALL en tabla no ordenada
4. Olvidar SET antes de SEARCH
5. Confundir índice con subscript

## 🎓 Conceptos Dominados

- ✅ OCCURS
- ✅ INDEXED BY
- ✅ SEARCH y SEARCH ALL
- ✅ Tablas multidimensionales
- ✅ SORT
- ✅ Inicialización de tablas
- ✅ Recorrido con PERFORM VARYING

## 🎯 Siguiente Paso

**Módulo 5: Subprogramas y Modularización**
