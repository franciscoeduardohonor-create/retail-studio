"""
MÓDULO 3 - PANDAS
Lección 1: Introducción a Pandas

Pandas es la librería más importante para análisis de datos en Python.
Proporciona estructuras de datos potentes y fáciles de usar.

En esta lección aprenderás:
- Qué es Pandas y por qué es esencial
- Series (arrays 1D etiquetados)
- DataFrames (tablas de datos)
- Crear DataFrames de diferentes formas
- Exploración básica de datos
"""

import pandas as pd
import numpy as np

# ============================================
# 1. ¿QUÉ ES PANDAS?
# ============================================

print("="*60)
print("¿QUÉ ES PANDAS?")
print("="*60)

print("""
Pandas es la librería fundamental para análisis de datos en Python.

Características principales:
✓ Trabaja con datos tabulares (como Excel o SQL)
✓ Manejo fácil de datos faltantes (NaN)
✓ Operaciones de merge, join, group by
✓ Indexación potente y flexible
✓ Lee/escribe múltiples formatos (CSV, Excel, SQL, JSON, etc.)
✓ Funciones de análisis de series temporales
✓ Integración perfecta con NumPy y matplotlib

Estructuras principales:
- Series: array 1D etiquetado (como una columna de Excel)
- DataFrame: tabla 2D (como una hoja de Excel completa)
""")

# ============================================
# 2. SERIES - Arrays 1D Etiquetados
# ============================================

print("\n" + "="*60)
print("SERIES")
print("="*60)

# Crear una Serie desde una lista
calificaciones = pd.Series([85, 90, 78, 92, 88])
print("\nSerie de calificaciones:")
print(calificaciones)

# Serie con índice personalizado
calificaciones_con_nombre = pd.Series(
    [85, 90, 78, 92, 88],
    index=['Ana', 'Luis', 'María', 'Pedro', 'Laura']
)
print("\nSerie con índice personalizado:")
print(calificaciones_con_nombre)

# Acceder a elementos
print(f"\nCalificación de María: {calificaciones_con_nombre['María']}")
print(f"Calificación de Ana: {calificaciones_con_nombre['Ana']}")

# También se puede acceder por posición
print(f"Primera calificación: {calificaciones_con_nombre.iloc[0]}")

# Crear Serie desde un diccionario
ventas = pd.Series({
    'enero': 1000,
    'febrero': 1200,
    'marzo': 1500,
    'abril': 1300,
    'mayo': 1800
})
print("\nSerie desde diccionario:")
print(ventas)

# Operaciones con Series
print("\n--- OPERACIONES CON SERIES ---")
print(f"Media: {calificaciones_con_nombre.mean():.2f}")
print(f"Mediana: {calificaciones_con_nombre.median()}")
print(f"Máximo: {calificaciones_con_nombre.max()}")
print(f"Mínimo: {calificaciones_con_nombre.min()}")
print(f"Suma: {calificaciones_con_nombre.sum()}")

# Filtrado
print("\nEstudiantes con calificación >= 85:")
print(calificaciones_con_nombre[calificaciones_con_nombre >= 85])

# Operaciones aritméticas
print("\nAplicar 5 puntos extra a todos:")
print(calificaciones_con_nombre + 5)

# ============================================
# 3. DATAFRAMES - Tablas 2D
# ============================================

print("\n" + "="*60)
print("DATAFRAMES")
print("="*60)

# Un DataFrame es como una hoja de Excel: filas y columnas con etiquetas

# Método 1: Desde un diccionario
estudiantes = pd.DataFrame({
    'nombre': ['Ana', 'Luis', 'María', 'Pedro', 'Laura'],
    'edad': [20, 22, 21, 23, 20],
    'calificacion': [85, 90, 78, 92, 88],
    'ciudad': ['Madrid', 'Barcelona', 'Valencia', 'Sevilla', 'Bilbao']
})

print("\nDataFrame de estudiantes:")
print(estudiantes)

# Método 2: Desde una lista de diccionarios
productos = pd.DataFrame([
    {'producto': 'Laptop', 'precio': 1200, 'stock': 15},
    {'producto': 'Mouse', 'precio': 25, 'stock': 50},
    {'producto': 'Teclado', 'precio': 75, 'stock': 30},
    {'producto': 'Monitor', 'precio': 300, 'stock': 20}
])

print("\nDataFrame de productos:")
print(productos)

# Método 3: Desde un array de NumPy
np.random.seed(42)
datos_aleatorios = pd.DataFrame(
    np.random.randint(0, 100, size=(5, 3)),
    columns=['A', 'B', 'C'],
    index=['Fila1', 'Fila2', 'Fila3', 'Fila4', 'Fila5']
)

print("\nDataFrame desde NumPy:")
print(datos_aleatorios)

# ============================================
# 4. EXPLORACIÓN BÁSICA DE DATAFRAMES
# ============================================

print("\n" + "="*60)
print("EXPLORACIÓN BÁSICA")
print("="*60)

# Crear un DataFrame más grande para explorar
np.random.seed(42)
ventas_df = pd.DataFrame({
    'fecha': pd.date_range('2024-01-01', periods=100),
    'producto': np.random.choice(['A', 'B', 'C'], 100),
    'cantidad': np.random.randint(1, 50, 100),
    'precio': np.random.uniform(10, 100, 100).round(2),
    'region': np.random.choice(['Norte', 'Sur', 'Este', 'Oeste'], 100)
})

# Agregar columna calculada
ventas_df['total'] = ventas_df['cantidad'] * ventas_df['precio']

print("\n--- MÉTODOS BÁSICOS DE EXPLORACIÓN ---")

# Ver primeras filas
print("\nPrimeras 5 filas (head):")
print(ventas_df.head())

# Ver últimas filas
print("\nÚltimas 3 filas (tail):")
print(ventas_df.tail(3))

# Información del DataFrame
print("\nInformación del DataFrame (info):")
print(ventas_df.info())

# Estadísticas descriptivas
print("\nEstadísticas descriptivas (describe):")
print(ventas_df.describe())

# Forma del DataFrame
print(f"\nForma (shape): {ventas_df.shape}")
print(f"Filas: {ventas_df.shape[0]}, Columnas: {ventas_df.shape[1]}")

# Nombres de columnas
print(f"\nColumnas: {list(ventas_df.columns)}")

# Tipos de datos
print("\nTipos de datos (dtypes):")
print(ventas_df.dtypes)

# Valores únicos en una columna
print(f"\nProductos únicos: {ventas_df['producto'].unique()}")
print(f"Cantidad de productos únicos: {ventas_df['producto'].nunique()}")

# Conteo de valores
print("\nConteo de valores por producto:")
print(ventas_df['producto'].value_counts())

# ============================================
# 5. SELECCIÓN DE DATOS
# ============================================

print("\n" + "="*60)
print("SELECCIÓN DE DATOS")
print("="*60)

# Volver al DataFrame de estudiantes
print("DataFrame de estudiantes:")
print(estudiantes)

# Seleccionar una columna (retorna una Serie)
print("\n--- SELECCIÓN DE COLUMNAS ---")
nombres = estudiantes['nombre']
print(f"\nColumna 'nombre':\n{nombres}")

# Seleccionar múltiples columnas (retorna un DataFrame)
nombre_edad = estudiantes[['nombre', 'edad']]
print(f"\nColumnas 'nombre' y 'edad':\n{nombre_edad}")

# Seleccionar filas por posición (iloc)
print("\n--- SELECCIÓN POR POSICIÓN (iloc) ---")
primera_fila = estudiantes.iloc[0]
print(f"\nPrimera fila:\n{primera_fila}")

primeras_tres = estudiantes.iloc[0:3]
print(f"\nPrimeras 3 filas:\n{primeras_tres}")

# Seleccionar por índice (loc) - si el índice tiene nombres
estudiantes_indexed = estudiantes.set_index('nombre')
print("\n--- SELECCIÓN POR ÍNDICE (loc) ---")
print(f"\nDataFrame con índice 'nombre':\n{estudiantes_indexed}")
print(f"\nDatos de María:\n{estudiantes_indexed.loc['María']}")

# Selección condicional
print("\n--- SELECCIÓN CONDICIONAL ---")
mayores_85 = estudiantes[estudiantes['calificacion'] >= 85]
print(f"\nEstudiantes con calificación >= 85:\n{mayores_85}")

# Múltiples condiciones
jovenes_buenos = estudiantes[
    (estudiantes['edad'] <= 21) & (estudiantes['calificacion'] >= 85)
]
print(f"\nEstudiantes <= 21 años y calificación >= 85:\n{jovenes_buenos}")

# ============================================
# 6. MODIFICAR DATAFRAMES
# ============================================

print("\n" + "="*60)
print("MODIFICAR DATAFRAMES")
print("="*60)

# Crear una copia para modificar
estudiantes_mod = estudiantes.copy()

# Agregar nueva columna
estudiantes_mod['aprobado'] = estudiantes_mod['calificacion'] >= 60
print("\nCon columna 'aprobado':")
print(estudiantes_mod)

# Modificar valores
estudiantes_mod.loc[0, 'calificacion'] = 95
print("\nDespués de modificar calificación de Ana:")
print(estudiantes_mod)

# Eliminar columna
estudiantes_sin_ciudad = estudiantes_mod.drop('ciudad', axis=1)
print("\nSin columna 'ciudad':")
print(estudiantes_sin_ciudad)

# Eliminar fila
estudiantes_sin_primera = estudiantes_mod.drop(0, axis=0)
print("\nSin primera fila:")
print(estudiantes_sin_primera)

# Renombrar columnas
estudiantes_renamed = estudiantes.rename(columns={
    'calificacion': 'nota',
    'edad': 'años'
})
print("\nCon columnas renombradas:")
print(estudiantes_renamed)

# ============================================
# 7. ORDENAR DATOS
# ============================================

print("\n" + "="*60)
print("ORDENAR DATOS")
print("="*60)

# Ordenar por una columna
print("\nOrdenado por calificación (ascendente):")
print(estudiantes.sort_values('calificacion'))

print("\nOrdenado por calificación (descendente):")
print(estudiantes.sort_values('calificacion', ascending=False))

# Ordenar por múltiples columnas
print("\nOrdenado por edad (ascendente) y luego calificación (descendente):")
print(estudiantes.sort_values(['edad', 'calificacion'], ascending=[True, False]))

# ============================================
# 8. EJERCICIO PRÁCTICO
# ============================================

print("\n" + "="*60)
print("EJERCICIO PRÁCTICO: ANÁLISIS DE VENTAS")
print("="*60)

# Crear dataset de ventas
np.random.seed(42)
n_registros = 50

ventas_ejercicio = pd.DataFrame({
    'fecha': pd.date_range('2024-01-01', periods=n_registros),
    'vendedor': np.random.choice(['Juan', 'María', 'Carlos', 'Ana'], n_registros),
    'producto': np.random.choice(['Laptop', 'Mouse', 'Teclado', 'Monitor'], n_registros),
    'cantidad': np.random.randint(1, 10, n_registros),
    'precio_unitario': np.random.choice([25, 75, 300, 1200], n_registros)
})

# Calcular total de venta
ventas_ejercicio['total'] = ventas_ejercicio['cantidad'] * ventas_ejercicio['precio_unitario']

print("Dataset de ventas:")
print(ventas_ejercicio.head(10))

# Análisis
print("\n--- ANÁLISIS ---")
print(f"\nTotal de registros: {len(ventas_ejercicio)}")
print(f"\nVentas totales: ${ventas_ejercicio['total'].sum():,.2f}")
print(f"Promedio por venta: ${ventas_ejercicio['total'].mean():,.2f}")
print(f"Venta mínima: ${ventas_ejercicio['total'].min():,.2f}")
print(f"Venta máxima: ${ventas_ejercicio['total'].max():,.2f}")

print("\n--- TOP 5 VENTAS ---")
top_5 = ventas_ejercicio.nlargest(5, 'total')[['fecha', 'vendedor', 'producto', 'total']]
print(top_5)

print("\n--- CONTEO POR PRODUCTO ---")
print(ventas_ejercicio['producto'].value_counts())

print("\n--- CONTEO POR VENDEDOR ---")
print(ventas_ejercicio['vendedor'].value_counts())

# ============================================
# RESUMEN
# ============================================

print("\n" + "="*60)
print("RESUMEN")
print("="*60)
print("""
Pandas proporciona dos estructuras principales:

1. SERIES (1D):
   - Array etiquetado
   - Como una columna de Excel
   - pd.Series([valores], index=[índices])

2. DATAFRAME (2D):
   - Tabla de datos
   - Como una hoja de Excel
   - pd.DataFrame({col1: [...], col2: [...]})

Métodos de exploración:
- .head() / .tail()     # Primeras/últimas filas
- .info()               # Información general
- .describe()           # Estadísticas
- .shape                # Dimensiones
- .columns              # Nombres de columnas
- .dtypes               # Tipos de datos

Selección:
- df['columna']         # Una columna
- df[['col1', 'col2']]  # Múltiples columnas
- df.iloc[0]            # Por posición
- df.loc['índice']      # Por índice
- df[condición]         # Filtrado

Modificación:
- df['nueva'] = ...     # Agregar columna
- df.drop()             # Eliminar
- df.rename()           # Renombrar
- df.sort_values()      # Ordenar
""")

# ============================================
# EJERCICIOS PARA PRACTICAR
# ============================================

print("\n" + "="*60)
print("EJERCICIOS PARA TI:")
print("="*60)
print("""
1. CREAR DATAFRAMES:
   - Crea un DataFrame con datos de 5 libros:
     (título, autor, año, páginas, precio)
   - Muestra las primeras 3 filas
   - Muestra información básica (.info())

2. EXPLORACIÓN:
   - Calcula el promedio de páginas
   - Encuentra el libro más caro
   - Cuenta cuántos libros hay por autor

3. FILTRADO:
   - Filtra libros publicados después de 2000
   - Filtra libros con más de 300 páginas
   - Filtra libros de un autor específico

4. MODIFICACIÓN:
   - Agrega una columna 'precio_descuento' (10% menos)
   - Ordena por año (más reciente primero)
   - Renombra la columna 'páginas' a 'num_paginas'

5. ANÁLISIS:
   - Crea un DataFrame con datos de temperatura:
     * 30 días
     * Columnas: fecha, temperatura, humedad, ciudad
   - Encuentra el día más caluroso
   - Calcula temperatura promedio por ciudad
   - Filtra días con temperatura > 25°C

¡Practica creando tus propios DataFrames!
""")
