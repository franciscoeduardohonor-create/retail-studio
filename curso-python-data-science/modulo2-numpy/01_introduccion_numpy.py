"""
MÓDULO 2 - NUMPY
Lección 1: Introducción a NumPy

NumPy (Numerical Python) es la librería fundamental para computación científica en Python.
Es la base de pandas, scikit-learn, y muchas otras librerías de Data Science.

En esta lección aprenderás:
- Qué es NumPy y por qué es importante
- Arrays de NumPy vs Listas de Python
- Creación de arrays
- Propiedades de arrays
- Tipos de datos
"""

import numpy as np
import time

# ============================================
# 1. ¿POR QUÉ NUMPY?
# ============================================

print("="*50)
print("¿POR QUÉ NUMPY ES IMPORTANTE?")
print("="*50)

# Comparación de rendimiento: NumPy vs Python lists
n = 1000000

# Con listas de Python
lista_python = list(range(n))
start = time.time()
lista_resultado = [x * 2 for x in lista_python]
tiempo_python = time.time() - start

# Con NumPy
array_numpy = np.arange(n)
start = time.time()
array_resultado = array_numpy * 2
tiempo_numpy = time.time() - start

print(f"\nMultiplicar {n:,} números por 2:")
print(f"Python lists: {tiempo_python:.4f} segundos")
print(f"NumPy arrays: {tiempo_numpy:.4f} segundos")
print(f"NumPy es {tiempo_python/tiempo_numpy:.1f}x más rápido!")

# Ventajas de NumPy:
print("\n--- VENTAJAS DE NUMPY ---")
print("✓ Mucho más rápido que listas de Python")
print("✓ Usa menos memoria")
print("✓ Operaciones vectorizadas (sin bucles explícitos)")
print("✓ Funciones matemáticas optimizadas")
print("✓ Base de todo el ecosistema científico de Python")

# ============================================
# 2. CREAR ARRAYS
# ============================================

print("\n" + "="*50)
print("CREACIÓN DE ARRAYS")
print("="*50)

# Desde una lista
lista = [1, 2, 3, 4, 5]
array1 = np.array(lista)
print(f"\nDesde lista: {array1}")
print(f"Tipo: {type(array1)}")

# Array multidimensional (matriz)
matriz = np.array([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
print(f"\nMatriz 3x3:\n{matriz}")

# Arrays especiales
print("\n--- ARRAYS ESPECIALES ---")

# Array de ceros
ceros = np.zeros(5)
print(f"Ceros: {ceros}")

# Array de unos
unos = np.ones(5)
print(f"Unos: {unos}")

# Matriz de ceros
matriz_ceros = np.zeros((3, 4))  # 3 filas, 4 columnas
print(f"Matriz de ceros:\n{matriz_ceros}")

# Array con un valor específico
cincos = np.full(5, 5)
print(f"\nArray de cincos: {cincos}")

# Matriz identidad
identidad = np.eye(3)
print(f"\nMatriz identidad 3x3:\n{identidad}")

# Rango de números
rango = np.arange(0, 10, 2)  # inicio, fin, paso
print(f"\nRango (0 a 10, paso 2): {rango}")

# Espacio lineal (útil para gráficas)
lineal = np.linspace(0, 1, 5)  # 5 números entre 0 y 1
print(f"Espacio lineal (5 números de 0 a 1): {lineal}")

# Arrays aleatorios
print("\n--- ARRAYS ALEATORIOS ---")

# Números aleatorios entre 0 y 1
aleatorios = np.random.random(5)
print(f"Aleatorios [0,1): {aleatorios}")

# Enteros aleatorios
enteros_aleatorios = np.random.randint(1, 100, size=5)  # entre 1 y 100
print(f"Enteros aleatorios [1,100): {enteros_aleatorios}")

# Distribución normal (media=0, desviación=1)
normales = np.random.randn(5)
print(f"Distribución normal: {normales}")

# Establecer semilla para reproducibilidad
np.random.seed(42)
reproducible = np.random.random(3)
print(f"\nAleatorios con semilla 42: {reproducible}")

# ============================================
# 3. PROPIEDADES DE ARRAYS
# ============================================

print("\n" + "="*50)
print("PROPIEDADES DE ARRAYS")
print("="*50)

# Crear un array de ejemplo
array = np.array([[1, 2, 3, 4],
                  [5, 6, 7, 8],
                  [9, 10, 11, 12]])

print(f"Array:\n{array}\n")

# Propiedades importantes
print(f"Forma (shape): {array.shape}")  # (filas, columnas)
print(f"Dimensiones (ndim): {array.ndim}")  # 2D
print(f"Tamaño total (size): {array.size}")  # total de elementos
print(f"Tipo de datos (dtype): {array.dtype}")  # int64
print(f"Bytes por elemento: {array.itemsize}")
print(f"Memoria total (bytes): {array.nbytes}")

# ============================================
# 4. TIPOS DE DATOS
# ============================================

print("\n" + "="*50)
print("TIPOS DE DATOS (dtype)")
print("="*50)

# NumPy tiene muchos tipos de datos específicos
# Esto permite optimizar memoria y rendimiento

# Enteros
int8 = np.array([1, 2, 3], dtype=np.int8)  # -128 a 127
int32 = np.array([1, 2, 3], dtype=np.int32)  # rango mayor
uint8 = np.array([1, 2, 3], dtype=np.uint8)  # 0 a 255 (sin signo)

print(f"int8 usa {int8.itemsize} bytes por elemento")
print(f"int32 usa {int32.itemsize} bytes por elemento")
print(f"uint8 usa {uint8.itemsize} bytes por elemento")

# Flotantes
float32 = np.array([1.5, 2.5, 3.5], dtype=np.float32)
float64 = np.array([1.5, 2.5, 3.5], dtype=np.float64)  # más precisión

print(f"\nfloat32 usa {float32.itemsize} bytes por elemento")
print(f"float64 usa {float64.itemsize} bytes por elemento")

# Conversión de tipos
enteros = np.array([1, 2, 3, 4, 5])
flotantes = enteros.astype(np.float64)
print(f"\nEnteros: {enteros} (dtype: {enteros.dtype})")
print(f"Flotantes: {flotantes} (dtype: {flotantes.dtype})")

# Booleanos
booleanos = np.array([True, False, True, False])
print(f"\nBooleanos: {booleanos} (dtype: {booleanos.dtype})")

# ============================================
# 5. RESHAPE - CAMBIAR FORMA
# ============================================

print("\n" + "="*50)
print("RESHAPE - CAMBIAR FORMA DE ARRAYS")
print("="*50)

# Crear un array lineal
lineal = np.arange(12)
print(f"Array original: {lineal}")
print(f"Shape: {lineal.shape}")

# Convertir a matriz 3x4
matriz_3x4 = lineal.reshape(3, 4)
print(f"\nReshape a 3x4:\n{matriz_3x4}")
print(f"Shape: {matriz_3x4.shape}")

# Convertir a matriz 2x6
matriz_2x6 = lineal.reshape(2, 6)
print(f"\nReshape a 2x6:\n{matriz_2x6}")

# Reshape automático (-1)
# -1 significa "calcula esta dimensión automáticamente"
matriz_auto = lineal.reshape(4, -1)  # 4 filas, columnas automáticas
print(f"\nReshape a (4, -1):\n{matriz_auto}")
print(f"Shape: {matriz_auto.shape}")

# Aplanar array (flatten)
matriz = np.array([[1, 2, 3], [4, 5, 6]])
plano = matriz.flatten()
print(f"\nMatriz:\n{matriz}")
print(f"Aplanada: {plano}")

# Otra forma de aplanar: ravel()
plano2 = matriz.ravel()
print(f"Con ravel(): {plano2}")

# ============================================
# 6. EJERCICIO PRÁCTICO: SIMULACIÓN DE VENTAS
# ============================================

print("\n" + "="*50)
print("EJERCICIO PRÁCTICO: SIMULACIÓN DE VENTAS")
print("="*50)

# Simular ventas de una tienda durante 4 semanas (7 días cada una)
np.random.seed(42)

# Generar ventas aleatorias entre $500 y $2000 por día
ventas_diarias = np.random.randint(500, 2000, size=28)

# Reshape a 4 semanas x 7 días
ventas_semanales = ventas_diarias.reshape(4, 7)

print("Ventas diarias por semana:")
print(ventas_semanales)

print("\nPropiedades:")
print(f"- Total de días: {ventas_semanales.size}")
print(f"- Semanas registradas: {ventas_semanales.shape[0]}")
print(f"- Días por semana: {ventas_semanales.shape[1]}")
print(f"- Tipo de datos: {ventas_semanales.dtype}")

# Análisis básico (veremos más en la siguiente lección)
print(f"\n--- ANÁLISIS BÁSICO ---")
print(f"Ventas totales: ${ventas_diarias.sum():,}")
print(f"Promedio diario: ${ventas_diarias.mean():.2f}")
print(f"Día con más ventas: ${ventas_diarias.max():,}")
print(f"Día con menos ventas: ${ventas_diarias.min():,}")

# ============================================
# RESUMEN
# ============================================

print("\n" + "="*50)
print("RESUMEN")
print("="*50)
print("""
NumPy es fundamental porque:
✓ Es mucho más rápido que listas de Python
✓ Operaciones vectorizadas (sin bucles)
✓ Base de todo el ecosistema científico

Formas de crear arrays:
- np.array(lista)          # Desde lista
- np.zeros(n)              # Ceros
- np.ones(n)               # Unos
- np.arange(inicio, fin)   # Rango
- np.linspace(a, b, n)     # n números entre a y b
- np.random.random(n)      # Aleatorios

Propiedades importantes:
- .shape    # Dimensiones
- .ndim     # Número de dimensiones
- .size     # Total de elementos
- .dtype    # Tipo de datos

Operaciones:
- .reshape() # Cambiar forma
- .flatten() # Aplanar
- .astype()  # Convertir tipo
""")

# ============================================
# EJERCICIOS PARA PRACTICAR
# ============================================

print("\n" + "="*50)
print("EJERCICIOS PARA TI:")
print("="*50)
print("""
1. CREACIÓN DE ARRAYS:
   - Crea un array con números del 1 al 100
   - Crea una matriz 5x5 llena de números 7
   - Crea un array de 10 números aleatorios entre 50 y 100

2. RESHAPE:
   - Crea un array con números del 1 al 24
   - Conviértelo a una matriz 4x6
   - Luego conviértelo a 3x8
   - Finalmente aplánalo de nuevo

3. TIPOS DE DATOS:
   - Crea un array de flotantes
   - Conviértelo a enteros
   - Observa qué pasa con los decimales

4. SIMULACIÓN:
   - Simula las temperaturas de un mes (30 días)
     Rango: 15°C a 30°C
   - Organízalas en 4 semanas
   - Muestra las propiedades del array

5. COMPARACIÓN:
   - Crea una lista de Python con 1000 números
   - Crea un array de NumPy con los mismos números
   - Compara el tiempo de multiplicar todos por 2
   - Compara el uso de memoria (usa .nbytes para NumPy)

¡Practica con estos ejercicios!
""")
