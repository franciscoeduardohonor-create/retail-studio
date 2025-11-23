"""
MÓDULO 2: PANDAS PARA ANÁLISIS DE DATOS Y MACHINE LEARNING
===========================================================

Pandas es LA librería para trabajar con datos tabulares en Python.
Es esencial para ML porque:
- Permite leer/escribir datos de múltiples formatos (CSV, Excel, SQL, etc.)
- Facilita la limpieza y transformación de datos
- Proporciona herramientas poderosas para análisis exploratorio
- Se integra perfectamente con scikit-learn
"""

import pandas as pd
import numpy as np

# =============================================================================
# 1. SERIES - ESTRUCTURAS 1D
# =============================================================================

print("=" * 70)
print("1. SERIES (Arrays 1D etiquetados)")
print("=" * 70)

# Crear una Serie desde una lista
temperaturas = pd.Series([22.5, 24.1, 23.8, 21.9, 25.3],
                        index=['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes'])

print("Temperaturas de la semana:")
print(temperaturas)
print(f"\nTipo: {type(temperaturas)}")
print(f"Forma: {temperaturas.shape}")
print(f"Índice: {temperaturas.index.tolist()}")
print(f"Valores: {temperaturas.values}\n")

# Acceso a elementos
print(f"Temperatura del Lunes: {temperaturas['Lunes']}°C")
print(f"Temperatura del Viernes: {temperaturas['Viernes']}°C\n")

# Operaciones
print(f"Temperatura promedio: {temperaturas.mean():.2f}°C")
print(f"Temperatura máxima: {temperaturas.max():.2f}°C")
print(f"Temperatura mínima: {temperaturas.min():.2f}°C\n")

# Filtrado
dias_calurosos = temperaturas[temperaturas > 23]
print(f"Días con temperatura > 23°C:\n{dias_calurosos}\n")

# =============================================================================
# 2. DATAFRAMES - ESTRUCTURAS 2D (Tablas)
# =============================================================================

print("=" * 70)
print("2. DATAFRAMES (Tablas 2D etiquetadas)")
print("=" * 70)

# Crear un DataFrame desde un diccionario
datos_ventas = {
    'Producto': ['Laptop', 'Mouse', 'Teclado', 'Monitor', 'USB'],
    'Precio': [15000, 250, 800, 3500, 150],
    'Cantidad': [10, 50, 30, 15, 100],
    'Categoría': ['Computadoras', 'Accesorios', 'Accesorios', 'Computadoras', 'Accesorios']
}

df = pd.DataFrame(datos_ventas)
print("DataFrame de ventas:")
print(df)
print(f"\nForma: {df.shape} (filas, columnas)")
print(f"Columnas: {df.columns.tolist()}")
print(f"Tipos de datos:\n{df.dtypes}\n")

# Información del DataFrame
print("Información general:")
df.info()
print()

# Estadísticas descriptivas
print("Estadísticas descriptivas:")
print(df.describe())
print()

# =============================================================================
# 3. SELECCIÓN Y FILTRADO
# =============================================================================

print("=" * 70)
print("3. SELECCIÓN Y FILTRADO")
print("=" * 70)

# Seleccionar una columna (devuelve Series)
print("Columna 'Producto':")
print(df['Producto'])
print(f"Tipo: {type(df['Producto'])}\n")

# Seleccionar múltiples columnas (devuelve DataFrame)
print("Columnas 'Producto' y 'Precio':")
print(df[['Producto', 'Precio']])
print()

# Seleccionar filas por índice con loc (por etiqueta)
print("Primera fila (índice 0):")
print(df.loc[0])
print()

# Seleccionar filas por posición con iloc (por posición)
print("Primeras 3 filas:")
print(df.iloc[:3])
print()

# Filtrado condicional
print("Productos con precio > 500:")
productos_caros = df[df['Precio'] > 500]
print(productos_caros)
print()

# Múltiples condiciones
print("Accesorios con precio < 500:")
filtro = (df['Categoría'] == 'Accesorios') & (df['Precio'] < 500)
print(df[filtro])
print()

# =============================================================================
# 4. AGREGAR, MODIFICAR Y ELIMINAR COLUMNAS
# =============================================================================

print("=" * 70)
print("4. AGREGAR, MODIFICAR Y ELIMINAR COLUMNAS")
print("=" * 70)

# Copiar el DataFrame para no modificar el original
df_modificado = df.copy()

# Agregar nueva columna (cálculo derivado)
df_modificado['Total'] = df_modificado['Precio'] * df_modificado['Cantidad']
print("DataFrame con columna 'Total':")
print(df_modificado)
print()

# Agregar columna con valor constante
df_modificado['Disponible'] = True
print("Con columna 'Disponible':")
print(df_modificado)
print()

# Modificar una columna
df_modificado['Precio'] = df_modificado['Precio'] * 1.1  # Incremento del 10%
print("Precios con incremento del 10%:")
print(df_modificado[['Producto', 'Precio']])
print()

# Eliminar columna
df_modificado = df_modificado.drop('Disponible', axis=1)
print("Después de eliminar 'Disponible':")
print(df_modificado.columns.tolist())
print()

# =============================================================================
# 5. MANEJO DE DATOS FALTANTES (CRUCIAL EN ML)
# =============================================================================

print("=" * 70)
print("5. MANEJO DE DATOS FALTANTES")
print("=" * 70)

# Crear DataFrame con valores faltantes
datos_con_na = {
    'A': [1, 2, np.nan, 4, 5],
    'B': [5, np.nan, np.nan, 8, 9],
    'C': [10, 11, 12, 13, 14]
}

df_na = pd.DataFrame(datos_con_na)
print("DataFrame con valores faltantes (NaN):")
print(df_na)
print()

# Detectar valores faltantes
print("¿Hay valores faltantes?")
print(df_na.isna())
print()

print("Cantidad de valores faltantes por columna:")
print(df_na.isna().sum())
print()

# Eliminar filas con valores faltantes
print("Eliminar filas con NaN:")
print(df_na.dropna())
print()

# Rellenar valores faltantes con un valor
print("Rellenar NaN con 0:")
print(df_na.fillna(0))
print()

# Rellenar con la media de la columna (común en ML)
print("Rellenar con la media de cada columna:")
print(df_na.fillna(df_na.mean()))
print()

# Rellenar con forward fill (valor anterior)
print("Forward fill (propagar valor anterior):")
print(df_na.fillna(method='ffill'))
print()

# =============================================================================
# 6. AGRUPACIÓN Y AGREGACIÓN
# =============================================================================

print("=" * 70)
print("6. AGRUPACIÓN Y AGREGACIÓN (GroupBy)")
print("=" * 70)

# Datos de ventas por región
ventas = pd.DataFrame({
    'Región': ['Norte', 'Sur', 'Norte', 'Este', 'Sur', 'Este', 'Norte', 'Sur'],
    'Producto': ['A', 'B', 'A', 'B', 'A', 'A', 'B', 'B'],
    'Ventas': [100, 150, 120, 200, 180, 160, 140, 170],
    'Unidades': [10, 15, 12, 20, 18, 16, 14, 17]
})

print("Datos de ventas:")
print(ventas)
print()

# Agrupar por región
print("Ventas totales por región:")
ventas_por_region = ventas.groupby('Región')['Ventas'].sum()
print(ventas_por_region)
print()

# Múltiples agregaciones
print("Estadísticas por región:")
stats_por_region = ventas.groupby('Región').agg({
    'Ventas': ['sum', 'mean', 'count'],
    'Unidades': 'sum'
})
print(stats_por_region)
print()

# Agrupar por múltiples columnas
print("Ventas por Región y Producto:")
ventas_detalladas = ventas.groupby(['Región', 'Producto'])['Ventas'].sum()
print(ventas_detalladas)
print()

# =============================================================================
# 7. ORDENAMIENTO
# =============================================================================

print("=" * 70)
print("7. ORDENAMIENTO")
print("=" * 70)

# Ordenar por columna
print("Productos ordenados por precio (ascendente):")
print(df.sort_values('Precio'))
print()

print("Productos ordenados por precio (descendente):")
print(df.sort_values('Precio', ascending=False))
print()

# Ordenar por múltiples columnas
print("Ordenar por Categoría y luego por Precio:")
print(df.sort_values(['Categoría', 'Precio']))
print()

# =============================================================================
# 8. COMBINACIÓN DE DATAFRAMES
# =============================================================================

print("=" * 70)
print("8. COMBINACIÓN DE DATAFRAMES")
print("=" * 70)

# Datos de productos
productos = pd.DataFrame({
    'ProductoID': [1, 2, 3],
    'Nombre': ['Laptop', 'Mouse', 'Teclado'],
    'Precio': [15000, 250, 800]
})

# Datos de inventario
inventario = pd.DataFrame({
    'ProductoID': [1, 2, 4],
    'Stock': [10, 50, 30],
    'Almacén': ['A', 'B', 'A']
})

print("Productos:")
print(productos)
print("\nInventario:")
print(inventario)
print()

# Inner join (solo coincidencias)
print("INNER JOIN (solo productos en ambas tablas):")
inner = pd.merge(productos, inventario, on='ProductoID', how='inner')
print(inner)
print()

# Left join (todos los productos)
print("LEFT JOIN (todos los productos):")
left = pd.merge(productos, inventario, on='ProductoID', how='left')
print(left)
print()

# Concatenar DataFrames verticalmente
df1 = pd.DataFrame({'A': [1, 2], 'B': [3, 4]})
df2 = pd.DataFrame({'A': [5, 6], 'B': [7, 8]})

print("DataFrame 1:")
print(df1)
print("\nDataFrame 2:")
print(df2)
print("\nConcatenados verticalmente:")
print(pd.concat([df1, df2], ignore_index=True))
print()

# =============================================================================
# 9. LECTURA Y ESCRITURA DE ARCHIVOS
# =============================================================================

print("=" * 70)
print("9. LECTURA Y ESCRITURA DE ARCHIVOS")
print("=" * 70)

# Guardar a CSV
df.to_csv('ventas.csv', index=False)
print("✓ DataFrame guardado en 'ventas.csv'")

# Leer desde CSV
df_leido = pd.read_csv('ventas.csv')
print("\nDataFrame leído desde CSV:")
print(df_leido)
print()

# =============================================================================
# 10. EJEMPLO PRÁCTICO: ANÁLISIS DE DATOS DE ESTUDIANTES
# =============================================================================

print("=" * 70)
print("10. EJEMPLO PRÁCTICO: Análisis de Datos de Estudiantes")
print("=" * 70)

# Crear dataset de estudiantes
np.random.seed(42)
n_estudiantes = 50

estudiantes = pd.DataFrame({
    'ID': range(1, n_estudiantes + 1),
    'Nombre': [f'Estudiante_{i}' for i in range(1, n_estudiantes + 1)],
    'Edad': np.random.randint(18, 25, n_estudiantes),
    'Género': np.random.choice(['M', 'F'], n_estudiantes),
    'Matemáticas': np.random.randint(60, 100, n_estudiantes),
    'Física': np.random.randint(55, 100, n_estudiantes),
    'Química': np.random.randint(50, 100, n_estudiantes),
    'Asistencia': np.random.uniform(0.7, 1.0, n_estudiantes).round(2)
})

print(f"Dataset de {n_estudiantes} estudiantes")
print("\nPrimeras 5 filas:")
print(estudiantes.head())
print()

print("Últimas 5 filas:")
print(estudiantes.tail())
print()

# Análisis exploratorio
print("Estadísticas descriptivas:")
print(estudiantes.describe())
print()

# Calcular promedio general
estudiantes['Promedio'] = estudiantes[['Matemáticas', 'Física', 'Química']].mean(axis=1)
print("Primeros 5 estudiantes con promedio:")
print(estudiantes.head())
print()

# Estudiantes con mejor desempeño
top_5 = estudiantes.nlargest(5, 'Promedio')[['Nombre', 'Promedio', 'Asistencia']]
print("Top 5 estudiantes:")
print(top_5)
print()

# Análisis por género
print("Promedio de calificaciones por género:")
print(estudiantes.groupby('Género')[['Matemáticas', 'Física', 'Química', 'Promedio']].mean())
print()

# Correlación entre asistencia y promedio
correlacion = estudiantes['Asistencia'].corr(estudiantes['Promedio'])
print(f"Correlación entre Asistencia y Promedio: {correlacion:.3f}")
print()

# Estudiantes en riesgo (promedio < 70 o asistencia < 0.8)
en_riesgo = estudiantes[(estudiantes['Promedio'] < 70) | (estudiantes['Asistencia'] < 0.8)]
print(f"Estudiantes en riesgo: {len(en_riesgo)}")
print(en_riesgo[['Nombre', 'Promedio', 'Asistencia']].head())
print()

# Crear categorías de rendimiento
def categorizar_rendimiento(promedio):
    if promedio >= 90:
        return 'Excelente'
    elif promedio >= 80:
        return 'Bueno'
    elif promedio >= 70:
        return 'Regular'
    else:
        return 'Bajo'

estudiantes['Rendimiento'] = estudiantes['Promedio'].apply(categorizar_rendimiento)

print("Distribución de estudiantes por rendimiento:")
print(estudiantes['Rendimiento'].value_counts())
print()

print("=" * 70)
print("¡Has completado el módulo de Pandas!")
print("=" * 70)
