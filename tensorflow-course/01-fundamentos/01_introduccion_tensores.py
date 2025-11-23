"""
MÓDULO 1 - EJEMPLO 1: Introducción a los Tensores
==================================================

En este ejemplo aprenderás:
- Cómo crear tensores de diferentes tipos
- Entender el concepto de shape, rank y dtype
- Convertir entre diferentes tipos de datos
- Crear tensores especiales (ceros, unos, aleatorios)

¡Ejecuta este archivo y observa los resultados!
"""

import tensorflow as tf
import numpy as np

print("=" * 70)
print("BIENVENIDO AL CURSO DE TENSORFLOW - MÓDULO 1")
print("=" * 70)
print()

# =============================================================================
# 1. CREACIÓN DE TENSORES BÁSICOS
# =============================================================================

print("1. CREACIÓN DE TENSORES BÁSICOS")
print("-" * 70)

# Tensor escalar (0D) - Un solo número
escalar = tf.constant(42)
print(f"Escalar: {escalar}")
print(f"  - Valor: {escalar.numpy()}")
print(f"  - Shape: {escalar.shape}")
print(f"  - Rank: {tf.rank(escalar).numpy()}")
print(f"  - Dtype: {escalar.dtype}")
print()

# Tensor vector (1D) - Una lista de números
vector = tf.constant([1, 2, 3, 4, 5])
print(f"Vector: {vector}")
print(f"  - Shape: {vector.shape}")
print(f"  - Rank: {tf.rank(vector).numpy()}")
print(f"  - Número de elementos: {tf.size(vector).numpy()}")
print()

# Tensor matriz (2D) - Una tabla de números
matriz = tf.constant([[1, 2, 3],
                      [4, 5, 6]])
print(f"Matriz:\n{matriz}")
print(f"  - Shape: {matriz.shape}")  # (2 filas, 3 columnas)
print(f"  - Rank: {tf.rank(matriz).numpy()}")
print()

# Tensor 3D - Por ejemplo, una imagen en color (alto × ancho × canales RGB)
tensor_3d = tf.constant([
    [[1, 2], [3, 4]],
    [[5, 6], [7, 8]]
])
print(f"Tensor 3D:\n{tensor_3d}")
print(f"  - Shape: {tensor_3d.shape}")  # (2, 2, 2)
print(f"  - Rank: {tf.rank(tensor_3d).numpy()}")
print()

# =============================================================================
# 2. DIFERENTES TIPOS DE DATOS (DTYPE)
# =============================================================================

print("2. DIFERENTES TIPOS DE DATOS")
print("-" * 70)

# Enteros
tensor_int = tf.constant([1, 2, 3], dtype=tf.int32)
print(f"Tensor de enteros (int32): {tensor_int}")
print(f"  - Dtype: {tensor_int.dtype}")
print()

# Flotantes (más común en Machine Learning)
tensor_float = tf.constant([1.5, 2.7, 3.9], dtype=tf.float32)
print(f"Tensor de flotantes (float32): {tensor_float}")
print(f"  - Dtype: {tensor_float.dtype}")
print()

# Booleanos
tensor_bool = tf.constant([True, False, True], dtype=tf.bool)
print(f"Tensor booleano: {tensor_bool}")
print(f"  - Dtype: {tensor_bool.dtype}")
print()

# Strings (cadenas de texto)
tensor_string = tf.constant(["Hola", "TensorFlow", "!"])
print(f"Tensor de strings: {tensor_string}")
print(f"  - Dtype: {tensor_string.dtype}")
print()

# =============================================================================
# 3. CONVERSIÓN DE TIPOS
# =============================================================================

print("3. CONVERSIÓN DE TIPOS")
print("-" * 70)

# De int a float
int_tensor = tf.constant([1, 2, 3])
float_tensor = tf.cast(int_tensor, dtype=tf.float32)
print(f"Original (int): {int_tensor}")
print(f"Convertido a float: {float_tensor}")
print()

# De float a int (se trunca, no redondea)
float_original = tf.constant([1.9, 2.5, 3.1])
int_convertido = tf.cast(float_original, dtype=tf.int32)
print(f"Original (float): {float_original}")
print(f"Convertido a int (truncado): {int_convertido}")
print()

# =============================================================================
# 4. CREACIÓN DE TENSORES ESPECIALES
# =============================================================================

print("4. TENSORES ESPECIALES")
print("-" * 70)

# Tensor de ceros
ceros = tf.zeros(shape=(3, 4))  # 3 filas, 4 columnas
print(f"Tensor de ceros (3×4):\n{ceros}")
print()

# Tensor de unos
unos = tf.ones(shape=(2, 3))
print(f"Tensor de unos (2×3):\n{unos}")
print()

# Tensor con un valor constante
lleno = tf.fill(dims=(2, 3), value=7)
print(f"Tensor lleno de 7s (2×3):\n{lleno}")
print()

# Tensor de números aleatorios (distribución normal)
aleatorio_normal = tf.random.normal(shape=(3, 3), mean=0.0, stddev=1.0)
print(f"Tensor aleatorio (distribución normal):\n{aleatorio_normal}")
print()

# Tensor de números aleatorios (distribución uniforme entre 0 y 1)
aleatorio_uniforme = tf.random.uniform(shape=(3, 3), minval=0, maxval=10)
print(f"Tensor aleatorio (uniforme 0-10):\n{aleatorio_uniforme}")
print()

# Matriz identidad
identidad = tf.eye(num_rows=4)
print(f"Matriz identidad (4×4):\n{identidad}")
print()

# Secuencia de números (similar a range en Python)
secuencia = tf.range(start=0, limit=10, delta=2)
print(f"Secuencia (0 a 10, paso 2): {secuencia}")
print()

# =============================================================================
# 5. CONVERSIÓN ENTRE NUMPY Y TENSORFLOW
# =============================================================================

print("5. CONVERSIÓN NUMPY ↔ TENSORFLOW")
print("-" * 70)

# De NumPy a TensorFlow
array_numpy = np.array([[1, 2, 3], [4, 5, 6]])
tensor_from_numpy = tf.constant(array_numpy)
print(f"Array NumPy:\n{array_numpy}")
print(f"Tensor de TensorFlow:\n{tensor_from_numpy}")
print()

# De TensorFlow a NumPy
tensor = tf.constant([[10, 20], [30, 40]])
array_from_tensor = tensor.numpy()
print(f"Tensor de TensorFlow:\n{tensor}")
print(f"Array NumPy:\n{array_from_tensor}")
print()

# =============================================================================
# 6. INFORMACIÓN SOBRE TENSORES
# =============================================================================

print("6. OBTENER INFORMACIÓN DE UN TENSOR")
print("-" * 70)

tensor_ejemplo = tf.constant([[[1, 2, 3, 4],
                               [5, 6, 7, 8]],
                              [[9, 10, 11, 12],
                               [13, 14, 15, 16]]])

print(f"Tensor:\n{tensor_ejemplo}")
print(f"\nInformación:")
print(f"  - Shape (forma): {tensor_ejemplo.shape}")
print(f"  - Rank (rango): {tf.rank(tensor_ejemplo).numpy()}")
print(f"  - Size (tamaño total): {tf.size(tensor_ejemplo).numpy()} elementos")
print(f"  - Dtype (tipo): {tensor_ejemplo.dtype}")
print(f"  - Dimensión 0: {tensor_ejemplo.shape[0]} (profundidad)")
print(f"  - Dimensión 1: {tensor_ejemplo.shape[1]} (filas)")
print(f"  - Dimensión 2: {tensor_ejemplo.shape[2]} (columnas)")
print()

# =============================================================================
# 7. EJERCICIO PRÁCTICO
# =============================================================================

print("7. EJERCICIO PRÁCTICO PARA TI")
print("-" * 70)
print("""
EJERCICIO: Crea los siguientes tensores por tu cuenta

1. Un tensor escalar con el valor de PI (3.14159)
2. Un vector de 10 elementos con valores del 1 al 10
3. Una matriz de 5×5 llena de ceros
4. Un tensor 3D de dimensiones (2, 3, 4) con valores aleatorios
5. Una matriz identidad de 6×6

Modifica este archivo y agrega tu código aquí abajo:
""")

# TU CÓDIGO AQUÍ:
# ejercicio_1 = ...
# ejercicio_2 = ...
# ejercicio_3 = ...
# ejercicio_4 = ...
# ejercicio_5 = ...

print("\n" + "=" * 70)
print("¡FELICIDADES! Has completado el primer ejemplo de TensorFlow")
print("Ahora continúa con: 02_operaciones_basicas.py")
print("=" * 70)
