"""
MÓDULO 3 - PANDAS
Lección 2: Limpieza y Manipulación de Datos

La limpieza de datos es una de las tareas más importantes (y consumidoras de tiempo)
en ciencia de datos. Se estima que los científicos de datos pasan el 80% de su tiempo
limpiando y preparando datos.

En esta lección aprenderás:
- Manejo de datos faltantes (NaN)
- Eliminación de duplicados
- Transformación de datos
- Aplicar funciones
- Agrupación y agregación (groupby)
- Combinar DataFrames (merge, join, concat)
"""

import pandas as pd
import numpy as np

# ============================================
# 1. DATOS FALTANTES (NaN)
# ============================================

print("="*60)
print("MANEJO DE DATOS FALTANTES")
print("="*60)

# Crear DataFrame con datos faltantes
datos_incompletos = pd.DataFrame({
    'nombre': ['Ana', 'Luis', 'María', 'Pedro', 'Laura', 'Carlos'],
    'edad': [25, np.nan, 30, 28, np.nan, 35],
    'ciudad': ['Madrid', 'Barcelona', np.nan, 'Sevilla', 'Valencia', 'Bilbao'],
    'salario': [3000, 3500, np.nan, 2800, 3200, np.nan]
})

print("\nDataFrame con datos faltantes:")
print(datos_incompletos)

# Detectar valores faltantes
print("\n--- DETECTAR VALORES FALTANTES ---")
print("\n¿Hay valores faltantes? (isna)")
print(datos_incompletos.isna())

print("\n¿Cuántos valores faltantes por columna?")
print(datos_incompletos.isna().sum())

print(f"\n¿Hay algún valor faltante en todo el DataFrame? {datos_incompletos.isna().any().any()}")

# Eliminar filas con NaN
print("\n--- ELIMINAR FILAS CON NaN ---")
sin_nan = datos_incompletos.dropna()
print(f"\nSin filas con NaN (quedan {len(sin_nan)} de {len(datos_incompletos)}):")
print(sin_nan)

# Eliminar solo si TODAS las columnas son NaN
solo_todas_nan = datos_incompletos.dropna(how='all')
print(f"\nEliminar solo si todas son NaN (quedan {len(solo_todas_nan)}):")
print(solo_todas_nan)

# Eliminar columnas con NaN
sin_columnas_nan = datos_incompletos.dropna(axis=1)
print(f"\nSin columnas que tengan NaN:")
print(sin_columnas_nan)

# Rellenar valores faltantes
print("\n--- RELLENAR VALORES FALTANTES ---")

# Rellenar con un valor específico
relleno_cero = datos_incompletos.fillna(0)
print("\nRellenado con 0:")
print(relleno_cero)

# Rellenar con la media (solo columnas numéricas)
datos_relleno = datos_incompletos.copy()
datos_relleno['edad'] = datos_relleno['edad'].fillna(datos_relleno['edad'].mean())
datos_relleno['salario'] = datos_relleno['salario'].fillna(datos_relleno['salario'].mean())
print("\nEdad y salario rellenados con la media:")
print(datos_relleno)

# Forward fill (propagar valor anterior)
datos_ffill = datos_incompletos.fillna(method='ffill')
print("\nForward fill:")
print(datos_ffill)

# Backward fill (propagar valor siguiente)
datos_bfill = datos_incompletos.fillna(method='bfill')
print("\nBackward fill:")
print(datos_bfill)

# Rellenar por columna con diccionario
relleno_dict = datos_incompletos.fillna({
    'edad': datos_incompletos['edad'].median(),
    'ciudad': 'Desconocida',
    'salario': datos_incompletos['salario'].mean()
})
print("\nRellenado con diccionario:")
print(relleno_dict)

# ============================================
# 2. DUPLICADOS
# ============================================

print("\n" + "="*60)
print("MANEJO DE DUPLICADOS")
print("="*60)

# Crear DataFrame con duplicados
datos_duplicados = pd.DataFrame({
    'nombre': ['Ana', 'Luis', 'Ana', 'María', 'Luis', 'Pedro'],
    'edad': [25, 30, 25, 28, 30, 35],
    'ciudad': ['Madrid', 'Barcelona', 'Madrid', 'Valencia', 'Barcelona', 'Sevilla']
})

print("\nDataFrame con duplicados:")
print(datos_duplicados)

# Detectar duplicados
print("\n¿Hay duplicados?")
print(datos_duplicados.duplicated())

print(f"\nNúmero de filas duplicadas: {datos_duplicados.duplicated().sum()}")

# Ver los duplicados
print("\nFilas duplicadas:")
print(datos_duplicados[datos_duplicados.duplicated()])

# Eliminar duplicados
sin_duplicados = datos_duplicados.drop_duplicates()
print(f"\nSin duplicados (quedan {len(sin_duplicados)} de {len(datos_duplicados)}):")
print(sin_duplicados)

# Eliminar duplicados basándose en columnas específicas
sin_dup_nombre = datos_duplicados.drop_duplicates(subset=['nombre'])
print("\nSin duplicados en 'nombre' (mantiene primera aparición):")
print(sin_dup_nombre)

# Mantener última aparición
sin_dup_ultimo = datos_duplicados.drop_duplicates(subset=['nombre'], keep='last')
print("\nSin duplicados en 'nombre' (mantiene última aparición):")
print(sin_dup_ultimo)

# ============================================
# 3. TRANSFORMACIÓN DE DATOS
# ============================================

print("\n" + "="*60)
print("TRANSFORMACIÓN DE DATOS")
print("="*60)

# Crear DataFrame de ejemplo
ventas = pd.DataFrame({
    'producto': ['laptop', 'MOUSE', 'Teclado', 'monitor', 'LAPTOP'],
    'precio': ['1200', '25', '75', '300', '1100'],
    'cantidad': [5, 50, 30, 20, 8]
})

print("\nDataFrame original:")
print(ventas)
print("\nTipos de datos:")
print(ventas.dtypes)

# Convertir tipos de datos
ventas['precio'] = ventas['precio'].astype(float)
print("\nDespués de convertir 'precio' a float:")
print(ventas.dtypes)

# Normalizar texto
ventas['producto'] = ventas['producto'].str.lower()
print("\nProductos en minúsculas:")
print(ventas)

# Capitalizar
ventas['producto'] = ventas['producto'].str.capitalize()
print("\nProductos capitalizados:")
print(ventas)

# Operaciones con strings
texto_df = pd.DataFrame({
    'email': ['ana@example.com', 'luis@test.org', 'maria@company.es']
})

# Extraer dominio
texto_df['dominio'] = texto_df['email'].str.split('@').str[1]
print("\nExtraer dominio de email:")
print(texto_df)

# Contiene substring
texto_df['es_empresa'] = texto_df['email'].str.contains('company')
print("\n¿Es email empresarial?")
print(texto_df)

# ============================================
# 4. APLICAR FUNCIONES (apply, map, applymap)
# ============================================

print("\n" + "="*60)
print("APLICAR FUNCIONES")
print("="*60)

# DataFrame de ejemplo
datos = pd.DataFrame({
    'nombre': ['Ana', 'Luis', 'María', 'Pedro'],
    'edad': [25, 30, 28, 35],
    'salario': [3000, 3500, 2800, 4000]
})

print("DataFrame original:")
print(datos)

# apply() - Aplicar función a columna
print("\n--- APPLY A COLUMNA ---")
datos['edad_en_10_años'] = datos['edad'].apply(lambda x: x + 10)
print(datos)

# Función más compleja
def categorizar_edad(edad):
    if edad < 25:
        return 'Joven'
    elif edad < 35:
        return 'Adulto'
    else:
        return 'Senior'

datos['categoria_edad'] = datos['edad'].apply(categorizar_edad)
print("\nCon categoría de edad:")
print(datos)

# apply() en DataFrame (por fila o columna)
print("\n--- APPLY A DATAFRAME ---")
# Aplicar a todas las columnas numéricas
datos_numericos = datos[['edad', 'salario']]
print("\nPromedio por columna:")
print(datos_numericos.apply(np.mean))

print("\nPromedio por fila:")
print(datos_numericos.apply(np.mean, axis=1))

# map() - Mapear valores
print("\n--- MAP ---")
genero_map = {'Ana': 'F', 'Luis': 'M', 'María': 'F', 'Pedro': 'M'}
datos['genero'] = datos['nombre'].map(genero_map)
print(datos)

# replace() - Reemplazar valores
datos_reemplazo = datos.copy()
datos_reemplazo['genero'] = datos_reemplazo['genero'].replace({'M': 'Masculino', 'F': 'Femenino'})
print("\nCon reemplazo:")
print(datos_reemplazo)

# ============================================
# 5. GROUPBY - AGRUPACIÓN Y AGREGACIÓN
# ============================================

print("\n" + "="*60)
print("GROUPBY - AGRUPACIÓN")
print("="*60)

# Crear DataFrame de ventas
np.random.seed(42)
ventas_completas = pd.DataFrame({
    'fecha': pd.date_range('2024-01-01', periods=100),
    'producto': np.random.choice(['Laptop', 'Mouse', 'Teclado', 'Monitor'], 100),
    'vendedor': np.random.choice(['Ana', 'Luis', 'María'], 100),
    'region': np.random.choice(['Norte', 'Sur', 'Este', 'Oeste'], 100),
    'cantidad': np.random.randint(1, 10, 100),
    'precio_unitario': np.random.choice([25, 75, 300, 1200], 100)
})

ventas_completas['total'] = ventas_completas['cantidad'] * ventas_completas['precio_unitario']

print("Dataset de ventas:")
print(ventas_completas.head(10))

# Agrupar por una columna
print("\n--- AGRUPACIÓN SIMPLE ---")
por_producto = ventas_completas.groupby('producto')['total'].sum()
print("\nVentas totales por producto:")
print(por_producto)

# Múltiples agregaciones
print("\n--- MÚLTIPLES AGREGACIONES ---")
estadisticas_producto = ventas_completas.groupby('producto')['total'].agg([
    'sum', 'mean', 'count', 'min', 'max'
])
print("\nEstadísticas por producto:")
print(estadisticas_producto)

# Agrupar por múltiples columnas
print("\n--- AGRUPACIÓN MÚLTIPLE ---")
por_producto_region = ventas_completas.groupby(['producto', 'region'])['total'].sum()
print("\nVentas por producto y región:")
print(por_producto_region)

# Agg con diccionario (diferentes funciones por columna)
print("\n--- AGREGACIONES PERSONALIZADAS ---")
resumen = ventas_completas.groupby('vendedor').agg({
    'total': ['sum', 'mean'],
    'cantidad': 'sum',
    'fecha': 'count'
})
print("\nResumen por vendedor:")
print(resumen)

# Transform (mantiene el tamaño original)
print("\n--- TRANSFORM ---")
ventas_completas['promedio_vendedor'] = ventas_completas.groupby('vendedor')['total'].transform('mean')
print("\nPrimeras filas con promedio del vendedor:")
print(ventas_completas[['vendedor', 'total', 'promedio_vendedor']].head(10))

# Filter (filtrar grupos)
print("\n--- FILTER ---")
# Solo vendedores con ventas totales > 100000
vendedores_top = ventas_completas.groupby('vendedor').filter(
    lambda x: x['total'].sum() > 100000
)
print(f"\nVendedores top (ventas > 100k): {vendedores_top['vendedor'].unique()}")

# ============================================
# 6. COMBINAR DATAFRAMES
# ============================================

print("\n" + "="*60)
print("COMBINAR DATAFRAMES")
print("="*60)

# Crear DataFrames de ejemplo
empleados = pd.DataFrame({
    'id': [1, 2, 3, 4],
    'nombre': ['Ana', 'Luis', 'María', 'Pedro'],
    'departamento_id': [10, 20, 10, 30]
})

departamentos = pd.DataFrame({
    'id': [10, 20, 30],
    'nombre_dept': ['Ventas', 'IT', 'Marketing'],
    'ubicacion': ['Madrid', 'Barcelona', 'Valencia']
})

print("Empleados:")
print(empleados)
print("\nDepartamentos:")
print(departamentos)

# MERGE (como SQL JOIN)
print("\n--- MERGE ---")
# Inner join (default)
combinado = pd.merge(
    empleados,
    departamentos,
    left_on='departamento_id',
    right_on='id',
    suffixes=('_emp', '_dept')
)
print("\nMerge (inner join):")
print(combinado)

# Left join
empleados2 = pd.DataFrame({
    'id': [1, 2, 3, 4, 5],
    'nombre': ['Ana', 'Luis', 'María', 'Pedro', 'Laura'],
    'departamento_id': [10, 20, 10, 30, 99]  # 99 no existe
})

left_join = pd.merge(
    empleados2,
    departamentos,
    left_on='departamento_id',
    right_on='id',
    how='left',
    suffixes=('_emp', '_dept')
)
print("\nLeft join (mantiene todos los empleados):")
print(left_join)

# CONCAT (concatenar)
print("\n--- CONCAT ---")
df1 = pd.DataFrame({'A': [1, 2], 'B': [3, 4]})
df2 = pd.DataFrame({'A': [5, 6], 'B': [7, 8]})

# Concatenar verticalmente
vertical = pd.concat([df1, df2], ignore_index=True)
print("\nConcatenar verticalmente:")
print(vertical)

# Concatenar horizontalmente
horizontal = pd.concat([df1, df2], axis=1)
print("\nConcatenar horizontalmente:")
print(horizontal)

# ============================================
# 7. PIVOT TABLES
# ============================================

print("\n" + "="*60)
print("PIVOT TABLES")
print("="*60)

# Crear tabla pivote
pivot = ventas_completas.pivot_table(
    values='total',
    index='producto',
    columns='region',
    aggfunc='sum',
    fill_value=0
)

print("Pivot table: Ventas por producto y región")
print(pivot)

# Pivot con múltiples funciones
pivot_multi = ventas_completas.pivot_table(
    values='total',
    index='producto',
    columns='region',
    aggfunc=['sum', 'mean', 'count'],
    fill_value=0
)

print("\nPivot table con múltiples agregaciones:")
print(pivot_multi)

# ============================================
# 8. EJERCICIO INTEGRADOR
# ============================================

print("\n" + "="*60)
print("EJERCICIO INTEGRADOR: LIMPIEZA DE DATOS DE CLIENTES")
print("="*60)

# Datos sucios de clientes
clientes_sucios = pd.DataFrame({
    'id': [1, 2, 3, 4, 5, 5, 6, 7],
    'nombre': ['  ANA  ', 'luis', 'MARÍA', 'pedro', 'Laura', 'Laura', 'carlos', np.nan],
    'email': ['ana@test.com', 'LUIS@TEST.COM', 'maria@company', np.nan, 'laura@test.com', 'laura@test.com', 'invalid', 'pedro@test.com'],
    'edad': [25, np.nan, 30, 28, np.nan, np.nan, 35, 40],
    'compras': [5, 3, np.nan, 7, 4, 4, 2, 8]
})

print("Datos originales (sucios):")
print(clientes_sucios)
print(f"\nProblemas detectados:")
print(f"- Duplicados: {clientes_sucios.duplicated().sum()}")
print(f"- Valores faltantes: {clientes_sucios.isna().sum().sum()}")
print(f"- Formato inconsistente en 'nombre'")
print(f"- Emails inválidos")

# Proceso de limpieza
print("\n--- PROCESO DE LIMPIEZA ---")

# 1. Eliminar duplicados completos
clientes_limpios = clientes_sucios.drop_duplicates()
print(f"\n1. Duplicados eliminados: {len(clientes_sucios)} → {len(clientes_limpios)}")

# 2. Limpiar nombres
clientes_limpios['nombre'] = clientes_limpios['nombre'].str.strip().str.capitalize()
print("2. Nombres normalizados")

# 3. Limpiar emails
clientes_limpios['email'] = clientes_limpios['email'].str.lower().str.strip()
clientes_limpios.loc[~clientes_limpios['email'].str.contains('@', na=False), 'email'] = np.nan
print("3. Emails validados")

# 4. Rellenar valores faltantes
clientes_limpios['edad'] = clientes_limpios['edad'].fillna(clientes_limpios['edad'].median())
clientes_limpios['compras'] = clientes_limpios['compras'].fillna(0)
print("4. Valores faltantes rellenados")

# 5. Eliminar filas con datos críticos faltantes
clientes_limpios = clientes_limpios.dropna(subset=['nombre'])
print("5. Filas sin nombre eliminadas")

print("\nDatos limpios:")
print(clientes_limpios)
print(f"\n¿Hay valores faltantes? {clientes_limpios.isna().sum().sum()}")
print(f"¿Hay duplicados? {clientes_limpios.duplicated().sum()}")

# ============================================
# EJERCICIOS PARA PRACTICAR
# ============================================

print("\n" + "="*60)
print("EJERCICIOS PARA TI:")
print("="*60)
print("""
1. DATOS FALTANTES:
   - Crea un DataFrame con al menos 20% de valores NaN
   - Calcula el porcentaje de NaN por columna
   - Rellena usando diferentes estrategias
   - Compara los resultados

2. DUPLICADOS:
   - Crea datos con duplicados parciales
   - Identifica duplicados basándose en 2 columnas
   - Decide qué estrategia usar (eliminar vs combinar)

3. TRANSFORMACIÓN:
   - Limpia un dataset de emails y teléfonos
   - Normaliza nombres (mayúsculas, espacios)
   - Convierte tipos de datos apropiadamente

4. GROUPBY:
   - Agrupa ventas por mes y producto
   - Calcula múltiples estadísticas
   - Encuentra top 3 productos por región

5. PROYECTO INTEGRADOR:
   Dataset de ventas con problemas:
   - Valores faltantes
   - Duplicados
   - Formatos inconsistentes
   - Outliers

   Tareas:
   a) Limpia el dataset completamente
   b) Agrupa por categorías relevantes
   c) Genera reportes de ventas
   d) Identifica patrones y anomalías

¡La limpieza de datos es fundamental!
""")
