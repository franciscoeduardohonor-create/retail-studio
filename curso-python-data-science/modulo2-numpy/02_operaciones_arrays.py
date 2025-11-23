"""
MÓDULO 2 - NUMPY
Lección 2: Operaciones con Arrays

En esta lección aprenderás:
- Indexación y slicing
- Operaciones aritméticas vectorizadas
- Funciones matemáticas
- Operaciones estadísticas
- Broadcasting
- Álgebra lineal básica
"""

import numpy as np

# ============================================
# 1. INDEXACIÓN Y SLICING
# ============================================

print("="*50)
print("INDEXACIÓN Y SLICING")
print("="*50)

# Array 1D
arr = np.array([10, 20, 30, 40, 50, 60, 70, 80, 90, 100])
print(f"Array: {arr}\n")

# Indexación básica (como listas)
print(f"Primer elemento: {arr[0]}")
print(f"Último elemento: {arr[-1]}")
print(f"Tercer elemento: {arr[2]}")

# Slicing
print(f"\nPrimeros 3: {arr[:3]}")
print(f"Del índice 2 al 5: {arr[2:6]}")
print(f"Últimos 3: {arr[-3:]}")
print(f"Cada 2 elementos: {arr[::2]}")
print(f"Invertido: {arr[::-1]}")

# Modificar con slicing
arr[0:3] = 0  # Cambiar múltiples elementos
print(f"\nDespués de arr[0:3] = 0: {arr}")

# Arrays 2D (matrices)
print("\n--- ARRAYS 2D ---")
matriz = np.array([[1, 2, 3, 4],
                   [5, 6, 7, 8],
                   [9, 10, 11, 12]])

print(f"Matriz:\n{matriz}\n")

# Indexación 2D: [fila, columna]
print(f"Elemento [0,0]: {matriz[0, 0]}")  # Primer elemento
print(f"Elemento [1,2]: {matriz[1, 2]}")  # Fila 1, columna 2
print(f"Elemento [2,3]: {matriz[2, 3]}")  # Último elemento

# Obtener filas completas
print(f"\nPrimera fila: {matriz[0, :]}")  # o matriz[0]
print(f"Segunda fila: {matriz[1, :]}")

# Obtener columnas completas
print(f"\nPrimera columna: {matriz[:, 0]}")
print(f"Tercera columna: {matriz[:, 2]}")

# Slicing 2D
print(f"\nPrimeras 2 filas, primeras 2 columnas:\n{matriz[:2, :2]}")
print(f"\nTodas las filas, columnas 1 y 2:\n{matriz[:, 1:3]}")

# ============================================
# 2. INDEXACIÓN BOOLEANA
# ============================================

print("\n" + "="*50)
print("INDEXACIÓN BOOLEANA")
print("="*50)

# Muy útil para filtrar datos
numeros = np.array([1, 5, 10, 15, 20, 25, 30, 35, 40])
print(f"Números: {numeros}\n")

# Crear máscara booleana
mayor_que_20 = numeros > 20
print(f"Máscara (> 20): {mayor_que_20}")
print(f"Valores > 20: {numeros[mayor_que_20]}")

# En una sola línea
print(f"\nValores < 15: {numeros[numeros < 15]}")
print(f"Valores pares: {numeros[numeros % 2 == 0]}")

# Múltiples condiciones (usar & para AND, | para OR)
condicion = (numeros > 10) & (numeros < 30)
print(f"\nValores entre 10 y 30: {numeros[condicion]}")

# Modificar usando indexación booleana
numeros_copia = numeros.copy()
numeros_copia[numeros_copia > 25] = 25  # Limitar valores máximos
print(f"Limitado a 25: {numeros_copia}")

# ============================================
# 3. OPERACIONES ARITMÉTICAS
# ============================================

print("\n" + "="*50)
print("OPERACIONES ARITMÉTICAS VECTORIZADAS")
print("="*50)

# Las operaciones se aplican elemento por elemento
a = np.array([1, 2, 3, 4, 5])
b = np.array([10, 20, 30, 40, 50])

print(f"a = {a}")
print(f"b = {b}\n")

# Operaciones básicas
print(f"a + b = {a + b}")
print(f"a - b = {a - b}")
print(f"a * b = {a * b}")  # Multiplicación elemento por elemento
print(f"b / a = {b / a}")
print(f"a ** 2 = {a ** 2}")

# Operaciones con escalares
print(f"\na + 10 = {a + 10}")
print(f"a * 2 = {a * 2}")
print(f"a / 2 = {a / 2}")

# Matrices
print("\n--- OPERACIONES CON MATRICES ---")
matriz1 = np.array([[1, 2], [3, 4]])
matriz2 = np.array([[5, 6], [7, 8]])

print(f"Matriz 1:\n{matriz1}\n")
print(f"Matriz 2:\n{matriz2}\n")

print(f"Suma:\n{matriz1 + matriz2}\n")
print(f"Multiplicación elemento por elemento:\n{matriz1 * matriz2}\n")

# Multiplicación de matrices (álgebra lineal)
print(f"Multiplicación matricial (dot):\n{np.dot(matriz1, matriz2)}\n")
# O usando el operador @
print(f"Multiplicación matricial (@):\n{matriz1 @ matriz2}")

# ============================================
# 4. FUNCIONES MATEMÁTICAS
# ============================================

print("\n" + "="*50)
print("FUNCIONES MATEMÁTICAS")
print("="*50)

# NumPy tiene muchas funciones matemáticas optimizadas
valores = np.array([1, 4, 9, 16, 25])
print(f"Valores: {valores}\n")

# Raíz cuadrada
print(f"Raíz cuadrada: {np.sqrt(valores)}")

# Exponencial y logaritmo
print(f"Exponencial: {np.exp([0, 1, 2])}")
print(f"Logaritmo natural: {np.log([1, np.e, np.e**2])}")
print(f"Logaritmo base 10: {np.log10([1, 10, 100])}")

# Trigonometría
angulos = np.array([0, np.pi/2, np.pi])
print(f"\nÁngulos: {angulos}")
print(f"Seno: {np.sin(angulos)}")
print(f"Coseno: {np.cos(angulos)}")

# Redondeo
numeros = np.array([1.2, 2.5, 3.7, 4.8])
print(f"\nNúmeros: {numeros}")
print(f"Redondeo: {np.round(numeros)}")
print(f"Piso (floor): {np.floor(numeros)}")
print(f"Techo (ceil): {np.ceil(numeros)}")

# Valor absoluto
print(f"\nValor absoluto: {np.abs([-1, -2, 3, -4])}")

# ============================================
# 5. OPERACIONES ESTADÍSTICAS
# ============================================

print("\n" + "="*50)
print("OPERACIONES ESTADÍSTICAS")
print("="*50)

# Datos de ejemplo: calificaciones de estudiantes
calificaciones = np.array([85, 90, 78, 92, 88, 76, 95, 89, 82, 91])
print(f"Calificaciones: {calificaciones}\n")

# Estadísticas básicas
print(f"Media (promedio): {np.mean(calificaciones):.2f}")
print(f"Mediana: {np.median(calificaciones):.2f}")
print(f"Desviación estándar: {np.std(calificaciones):.2f}")
print(f"Varianza: {np.var(calificaciones):.2f}")
print(f"Mínimo: {np.min(calificaciones)}")
print(f"Máximo: {np.max(calificaciones)}")
print(f"Suma: {np.sum(calificaciones)}")

# Percentiles
print(f"\nPercentil 25: {np.percentile(calificaciones, 25)}")
print(f"Percentil 50 (mediana): {np.percentile(calificaciones, 50)}")
print(f"Percentil 75: {np.percentile(calificaciones, 75)}")

# Operaciones con matrices
print("\n--- ESTADÍSTICAS EN MATRICES ---")
ventas = np.array([[100, 200, 150],  # Semana 1
                   [180, 220, 190],  # Semana 2
                   [160, 210, 170],  # Semana 3
                   [190, 230, 200]]) # Semana 4

print(f"Ventas por semana (filas) y productos (columnas):\n{ventas}\n")

# Estadísticas globales
print(f"Total de ventas: {ventas.sum()}")
print(f"Promedio general: {ventas.mean():.2f}")

# Por columna (axis=0) - ventas por producto
print(f"\nVentas totales por producto: {ventas.sum(axis=0)}")
print(f"Promedio por producto: {ventas.mean(axis=0)}")

# Por fila (axis=1) - ventas por semana
print(f"\nVentas totales por semana: {ventas.sum(axis=1)}")
print(f"Promedio por semana: {ventas.mean(axis=1)}")

# ============================================
# 6. BROADCASTING
# ============================================

print("\n" + "="*50)
print("BROADCASTING")
print("="*50)

# Broadcasting permite operar arrays de diferentes formas
# NumPy automáticamente "expande" las dimensiones

# Ejemplo 1: Escalar con array
arr = np.array([1, 2, 3, 4])
print(f"Array: {arr}")
print(f"Array + 10: {arr + 10}")  # 10 se expande a [10, 10, 10, 10]

# Ejemplo 2: Vector con matriz
matriz = np.array([[1, 2, 3],
                   [4, 5, 6],
                   [7, 8, 9]])
vector = np.array([10, 20, 30])

print(f"\nMatriz:\n{matriz}")
print(f"Vector: {vector}")
print(f"\nMatriz + Vector:\n{matriz + vector}")
# El vector se suma a cada fila

# Ejemplo 3: Vector columna
vector_col = np.array([[1], [2], [3]])
print(f"\nVector columna:\n{vector_col}")
print(f"\nMatriz + Vector columna:\n{matriz + vector_col}")
# El vector columna se suma a cada columna

# Aplicación práctica: Normalizar datos
print("\n--- NORMALIZACIÓN DE DATOS ---")
datos = np.array([[100, 200, 300],
                  [150, 250, 350],
                  [120, 220, 320]])

print(f"Datos originales:\n{datos}\n")

# Restar la media de cada columna
media = datos.mean(axis=0)
print(f"Media por columna: {media}")

datos_centrados = datos - media  # Broadcasting!
print(f"\nDatos centrados (media=0):\n{datos_centrados}")

# Z-score normalization
desv_std = datos.std(axis=0)
print(f"\nDesviación estándar: {desv_std}")
datos_normalizados = (datos - media) / desv_std
print(f"\nDatos normalizados (Z-score):\n{datos_normalizados}")

# ============================================
# 7. OTRAS OPERACIONES ÚTILES
# ============================================

print("\n" + "="*50)
print("OTRAS OPERACIONES ÚTILES")
print("="*50)

# Concatenación
arr1 = np.array([1, 2, 3])
arr2 = np.array([4, 5, 6])
concatenado = np.concatenate([arr1, arr2])
print(f"Concatenar: {concatenado}")

# Stack vertical (apilar)
matriz1 = np.array([[1, 2], [3, 4]])
matriz2 = np.array([[5, 6], [7, 8]])
vstack = np.vstack([matriz1, matriz2])
print(f"\nVertical stack:\n{vstack}")

# Stack horizontal
hstack = np.hstack([matriz1, matriz2])
print(f"\nHorizontal stack:\n{hstack}")

# Split (dividir)
arr = np.arange(10)
partes = np.split(arr, 5)  # Dividir en 5 partes
print(f"\nArray: {arr}")
print(f"Dividido en 5: {partes}")

# Ordenar
desordenado = np.array([3, 1, 4, 1, 5, 9, 2, 6])
print(f"\nDesordenado: {desordenado}")
print(f"Ordenado: {np.sort(desordenado)}")

# Valores únicos
con_duplicados = np.array([1, 2, 2, 3, 3, 3, 4, 5, 5])
unicos = np.unique(con_duplicados)
print(f"\nCon duplicados: {con_duplicados}")
print(f"Únicos: {unicos}")

# Contar valores únicos
unicos, conteos = np.unique(con_duplicados, return_counts=True)
print(f"\nValores y conteos:")
for valor, conteo in zip(unicos, conteos):
    print(f"  {valor}: {conteo} veces")

# ============================================
# 8. EJERCICIO INTEGRADOR
# ============================================

print("\n" + "="*50)
print("EJERCICIO INTEGRADOR: ANÁLISIS DE VENTAS")
print("="*50)

# Simular ventas de 3 productos en 12 meses
np.random.seed(42)
ventas_mensuales = np.random.randint(1000, 5000, size=(12, 3))

meses = ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun',
         'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic']
productos = ['Producto A', 'Producto B', 'Producto C']

print("Ventas mensuales (12 meses x 3 productos):")
print(f"\n{'Mes':<8} {productos[0]:<12} {productos[1]:<12} {productos[2]:<12}")
print("-" * 50)
for i, mes in enumerate(meses):
    print(f"{mes:<8} ${ventas_mensuales[i, 0]:<11,} ${ventas_mensuales[i, 1]:<11,} ${ventas_mensuales[i, 2]:<11,}")

# Análisis
print("\n--- ANÁLISIS ---")

# 1. Ventas totales por producto
ventas_por_producto = ventas_mensuales.sum(axis=0)
print("\nVentas totales por producto:")
for i, producto in enumerate(productos):
    print(f"  {producto}: ${ventas_por_producto[i]:,}")

# 2. Ventas promedio mensuales por producto
promedio_por_producto = ventas_mensuales.mean(axis=0)
print("\nPromedio mensual por producto:")
for i, producto in enumerate(productos):
    print(f"  {producto}: ${promedio_por_producto[i]:,.2f}")

# 3. Mejor y peor mes para cada producto
print("\nMejor mes por producto:")
for i, producto in enumerate(productos):
    mejor_mes_idx = ventas_mensuales[:, i].argmax()
    print(f"  {producto}: {meses[mejor_mes_idx]} (${ventas_mensuales[mejor_mes_idx, i]:,})")

# 4. Producto más vendido cada mes
print("\nProducto más vendido cada mes:")
for i, mes in enumerate(meses):
    mejor_producto_idx = ventas_mensuales[i, :].argmax()
    print(f"  {mes}: {productos[mejor_producto_idx]} (${ventas_mensuales[i, mejor_producto_idx]:,})")

# 5. Estadísticas generales
print(f"\n--- ESTADÍSTICAS GENERALES ---")
print(f"Ventas totales del año: ${ventas_mensuales.sum():,}")
print(f"Promedio mensual general: ${ventas_mensuales.mean():,.2f}")
print(f"Desviación estándar: ${ventas_mensuales.std():,.2f}")
print(f"Ventas mínimas: ${ventas_mensuales.min():,}")
print(f"Ventas máximas: ${ventas_mensuales.max():,}")

# 6. Crecimiento trimestral
trimestres = ventas_mensuales.reshape(4, 3, 3).sum(axis=1)  # 4 trimestres, 3 productos
print(f"\nVentas por trimestre:")
for i in range(4):
    print(f"  Q{i+1}: ${trimestres[i].sum():,}")

# ============================================
# EJERCICIOS PARA PRACTICAR
# ============================================

print("\n" + "="*50)
print("EJERCICIOS PARA TI:")
print("="*50)
print("""
1. INDEXACIÓN:
   - Crea una matriz 5x5 con números del 1 al 25
   - Extrae la diagonal principal
   - Extrae las esquinas (4 elementos)
   - Extrae el cuadrado central 3x3

2. INDEXACIÓN BOOLEANA:
   - Genera 50 números aleatorios entre 0 y 100
   - Filtra los que sean mayores a 50
   - Filtra los que estén entre 30 y 70
   - Reemplaza todos los valores < 25 por 25

3. ESTADÍSTICAS:
   - Crea datos de temperaturas para 30 días
   - Calcula: media, mediana, desviación estándar
   - Encuentra días con temperatura extrema (> 2 desv. std.)
   - Organiza en semanas y calcula promedio semanal

4. NORMALIZACIÓN:
   - Crea una matriz de datos 10x3 (10 personas, 3 características)
   - Normaliza cada característica (Z-score)
   - Verifica que la media sea 0 y desv. std. sea 1

5. PROYECTO:
   - Simula notas de 20 estudiantes en 5 exámenes
   - Calcula promedio por estudiante
   - Calcula promedio por examen
   - Encuentra el mejor estudiante
   - Encuentra el examen más difícil (menor promedio)
   - Aplica curva de calificación (normalización)

¡Practica estos ejercicios!
""")
