"""
MÓDULO 1: FUNDAMENTOS DE NUMPY PARA MACHINE LEARNING
=====================================================

NumPy es la biblioteca fundamental para computación científica en Python.
Es esencial para Machine Learning porque:
- Maneja arrays multidimensionales eficientemente
- Operaciones vectorizadas (mucho más rápidas que loops)
- Base de todas las librerías de ML (scikit-learn, TensorFlow, etc.)
"""

import numpy as np

# =============================================================================
# 1. CREACIÓN DE ARRAYS
# =============================================================================

print("=" * 70)
print("1. CREACIÓN DE ARRAYS")
print("=" * 70)

# Array 1D (vector)
vector = np.array([1, 2, 3, 4, 5])
print(f"Vector: {vector}")
print(f"Forma (shape): {vector.shape}")
print(f"Dimensiones: {vector.ndim}")
print(f"Tipo de dato: {vector.dtype}\n")

# Array 2D (matriz)
matriz = np.array([[1, 2, 3],
                   [4, 5, 6],
                   [7, 8, 9]])
print(f"Matriz:\n{matriz}")
print(f"Forma: {matriz.shape}")  # (filas, columnas)
print(f"Dimensiones: {matriz.ndim}")
print(f"Total de elementos: {matriz.size}\n")

# Arrays especiales útiles en ML
zeros = np.zeros((3, 4))  # Matriz de ceros (3 filas, 4 columnas)
print(f"Matriz de ceros:\n{zeros}\n")

ones = np.ones((2, 3))  # Matriz de unos
print(f"Matriz de unos:\n{ones}\n")

# Matriz identidad (muy usada en álgebra lineal)
identidad = np.eye(3)
print(f"Matriz identidad:\n{identidad}\n")

# Valores aleatorios (crucial para inicializar pesos en redes neuronales)
np.random.seed(42)  # Para reproducibilidad
aleatorios = np.random.rand(3, 3)  # Valores entre 0 y 1
print(f"Matriz aleatoria [0,1]:\n{aleatorios}\n")

# Distribución normal (muy usada en ML)
normal = np.random.randn(3, 3)  # Media 0, desviación estándar 1
print(f"Distribución normal:\n{normal}\n")

# Rango de valores
rango = np.arange(0, 10, 2)  # Inicio, fin, paso
print(f"Rango: {rango}\n")

# Espaciado lineal
linspace = np.linspace(0, 1, 5)  # 5 valores entre 0 y 1
print(f"Espaciado lineal: {linspace}\n")

# =============================================================================
# 2. OPERACIONES BÁSICAS CON ARRAYS
# =============================================================================

print("=" * 70)
print("2. OPERACIONES BÁSICAS")
print("=" * 70)

a = np.array([1, 2, 3, 4])
b = np.array([5, 6, 7, 8])

# Operaciones elemento por elemento
print(f"a = {a}")
print(f"b = {b}")
print(f"a + b = {a + b}")  # Suma
print(f"a - b = {a - b}")  # Resta
print(f"a * b = {a * b}")  # Multiplicación elemento por elemento
print(f"a / b = {a / b}")  # División
print(f"a ** 2 = {a ** 2}")  # Potencia
print(f"sqrt(a) = {np.sqrt(a)}\n")  # Raíz cuadrada

# Operaciones con escalares
print(f"a * 2 = {a * 2}")
print(f"a + 10 = {a + 10}\n")

# =============================================================================
# 3. INDEXACIÓN Y SLICING
# =============================================================================

print("=" * 70)
print("3. INDEXACIÓN Y SLICING")
print("=" * 70)

arr = np.array([10, 20, 30, 40, 50, 60, 70, 80, 90])
print(f"Array original: {arr}")
print(f"Primer elemento: {arr[0]}")
print(f"Último elemento: {arr[-1]}")
print(f"Primeros 3 elementos: {arr[:3]}")
print(f"Del índice 2 al 5: {arr[2:6]}")
print(f"Elementos pares (cada 2): {arr[::2]}\n")

# Indexación en 2D
matriz = np.array([[1, 2, 3, 4],
                   [5, 6, 7, 8],
                   [9, 10, 11, 12]])

print(f"Matriz:\n{matriz}")
print(f"Elemento [0,0]: {matriz[0, 0]}")
print(f"Elemento [1,2]: {matriz[1, 2]}")
print(f"Primera fila: {matriz[0, :]}")
print(f"Segunda columna: {matriz[:, 1]}")
print(f"Submatriz 2x2:\n{matriz[:2, :2]}\n")

# Indexación booleana (MUY IMPORTANTE en ML)
datos = np.array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
print(f"Datos: {datos}")
print(f"Datos > 5: {datos[datos > 5]}")
print(f"Datos pares: {datos[datos % 2 == 0]}\n")

# =============================================================================
# 4. RESHAPE Y TRANSPOSE
# =============================================================================

print("=" * 70)
print("4. RESHAPE Y TRANSPOSE")
print("=" * 70)

# Reshape: cambiar la forma sin cambiar los datos
original = np.arange(12)
print(f"Original: {original}")
print(f"Shape original: {original.shape}\n")

reshaped = original.reshape(3, 4)  # 3 filas, 4 columnas
print(f"Reshaped (3x4):\n{reshaped}\n")

reshaped2 = original.reshape(4, 3)  # 4 filas, 3 columnas
print(f"Reshaped (4x3):\n{reshaped2}\n")

# Reshape automático con -1
reshaped3 = original.reshape(2, -1)  # 2 filas, columnas automáticas
print(f"Reshaped (2, -1):\n{reshaped3}\n")

# Transpose (intercambiar filas por columnas)
matriz = np.array([[1, 2, 3],
                   [4, 5, 6]])
print(f"Matriz original:\n{matriz}")
print(f"Transpuesta:\n{matriz.T}\n")

# =============================================================================
# 5. AGREGACIONES Y ESTADÍSTICAS
# =============================================================================

print("=" * 70)
print("5. AGREGACIONES Y ESTADÍSTICAS")
print("=" * 70)

datos = np.array([[1, 2, 3, 4],
                  [5, 6, 7, 8],
                  [9, 10, 11, 12]])

print(f"Datos:\n{datos}\n")

# Operaciones sobre todo el array
print(f"Suma total: {datos.sum()}")
print(f"Mínimo: {datos.min()}")
print(f"Máximo: {datos.max()}")
print(f"Media: {datos.mean()}")
print(f"Mediana: {np.median(datos)}")
print(f"Desviación estándar: {datos.std()}")
print(f"Varianza: {datos.var()}\n")

# Operaciones por eje (axis)
# axis=0 -> operación por columnas
# axis=1 -> operación por filas
print(f"Suma por columnas (axis=0): {datos.sum(axis=0)}")
print(f"Suma por filas (axis=1): {datos.sum(axis=1)}")
print(f"Media por columnas: {datos.mean(axis=0)}")
print(f"Media por filas: {datos.mean(axis=1)}\n")

# =============================================================================
# 6. BROADCASTING
# =============================================================================

print("=" * 70)
print("6. BROADCASTING (Concepto Clave en ML)")
print("=" * 70)

# Broadcasting permite operar arrays de diferentes formas
matriz = np.array([[1, 2, 3],
                   [4, 5, 6],
                   [7, 8, 9]])

vector = np.array([10, 20, 30])

print(f"Matriz:\n{matriz}")
print(f"Vector: {vector}\n")

# El vector se "transmite" a cada fila de la matriz
resultado = matriz + vector
print(f"Matriz + Vector:\n{resultado}\n")

# Broadcasting con escalares
print(f"Matriz * 2:\n{matriz * 2}\n")

# Ejemplo práctico: Normalización (común en ML)
datos = np.array([[1, 2, 3],
                  [4, 5, 6],
                  [7, 8, 9]])

media = datos.mean(axis=0)  # Media de cada columna
std = datos.std(axis=0)     # Desviación estándar de cada columna

print(f"Datos originales:\n{datos}")
print(f"Media por columna: {media}")
print(f"Std por columna: {std}\n")

# Normalización z-score
datos_normalizados = (datos - media) / std
print(f"Datos normalizados:\n{datos_normalizados}\n")

# =============================================================================
# 7. ÁLGEBRA LINEAL BÁSICA
# =============================================================================

print("=" * 70)
print("7. ÁLGEBRA LINEAL (Fundamental para ML)")
print("=" * 70)

# Producto punto (dot product)
a = np.array([1, 2, 3])
b = np.array([4, 5, 6])

producto_punto = np.dot(a, b)  # 1*4 + 2*5 + 3*6 = 32
print(f"a = {a}")
print(f"b = {b}")
print(f"Producto punto a·b = {producto_punto}\n")

# Multiplicación de matrices
A = np.array([[1, 2],
              [3, 4]])

B = np.array([[5, 6],
              [7, 8]])

C = np.dot(A, B)  # o A @ B en Python 3.5+
print(f"Matriz A:\n{A}")
print(f"Matriz B:\n{B}")
print(f"A × B:\n{C}\n")

# Determinante
det = np.linalg.det(A)
print(f"Determinante de A: {det}\n")

# Inversa
inv_A = np.linalg.inv(A)
print(f"Inversa de A:\n{inv_A}\n")

# Verificación: A × A^(-1) = I
identidad = np.dot(A, inv_A)
print(f"A × A^(-1) = I:\n{np.round(identidad, decimals=10)}\n")

# =============================================================================
# 8. EJERCICIO PRÁCTICO
# =============================================================================

print("=" * 70)
print("8. EJERCICIO PRÁCTICO: Análisis de Datos")
print("=" * 70)

# Simular datos de temperatura (°C) de una semana
np.random.seed(42)
temperaturas = np.random.uniform(15, 30, size=(7, 24))  # 7 días, 24 horas

print(f"Forma de datos: {temperaturas.shape}")
print(f"Primeras 3 horas del día 1: {temperaturas[0, :3]}\n")

# Análisis
temp_maxima = temperaturas.max()
temp_minima = temperaturas.min()
temp_media = temperaturas.mean()

print(f"Temperatura máxima de la semana: {temp_maxima:.2f}°C")
print(f"Temperatura mínima de la semana: {temp_minima:.2f}°C")
print(f"Temperatura media de la semana: {temp_media:.2f}°C\n")

# Temperatura promedio por día
temp_promedio_dia = temperaturas.mean(axis=1)
print("Temperatura promedio por día:")
for i, temp in enumerate(temp_promedio_dia):
    print(f"  Día {i+1}: {temp:.2f}°C")

print()

# Hora más calurosa en promedio
temp_promedio_hora = temperaturas.mean(axis=0)
hora_mas_calurosa = temp_promedio_hora.argmax()
print(f"Hora más calurosa en promedio: {hora_mas_calurosa}:00 hrs")
print(f"Temperatura: {temp_promedio_hora[hora_mas_calurosa]:.2f}°C\n")

print("=" * 70)
print("¡Has completado el módulo de NumPy!")
print("=" * 70)
