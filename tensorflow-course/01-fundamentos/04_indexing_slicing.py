"""
MÓDULO 1 - EJEMPLO 4: Indexación y Slicing de Tensores
========================================================

En este ejemplo aprenderás:
- Acceder a elementos individuales de un tensor
- Slicing (rebanado) de tensores
- Indexación avanzada
- Modificar partes de un tensor
- Reshape y transponer tensores
"""

import tensorflow as tf
import numpy as np

print("=" * 70)
print("INDEXACIÓN Y SLICING DE TENSORES")
print("=" * 70)
print()

# =============================================================================
# 1. INDEXACIÓN BÁSICA - VECTORES (1D)
# =============================================================================

print("1. INDEXACIÓN EN VECTORES (1D)")
print("-" * 70)

vector = tf.constant([10, 20, 30, 40, 50, 60, 70, 80, 90, 100])
print(f"Vector: {vector}\n")

# Acceder a un elemento (similar a Python)
print(f"Primer elemento [0]: {vector[0]}")
print(f"Tercer elemento [2]: {vector[2]}")
print(f"Último elemento [-1]: {vector[-1]}")
print(f"Penúltimo elemento [-2]: {vector[-2]}")
print()

# Slicing básico [inicio:fin:paso]
print("Slicing:")
print(f"  vector[0:3] = {vector[0:3]}")      # Primeros 3 elementos
print(f"  vector[2:7] = {vector[2:7]}")      # Del índice 2 al 6
print(f"  vector[::2] = {vector[::2]}")      # Cada 2 elementos
print(f"  vector[:5]  = {vector[:5]}")       # Primeros 5
print(f"  vector[5:]  = {vector[5:]}")       # Desde el índice 5 hasta el final
print(f"  vector[::-1] = {vector[::-1]}")    # Invertir el vector
print()

# =============================================================================
# 2. INDEXACIÓN EN MATRICES (2D)
# =============================================================================

print("2. INDEXACIÓN EN MATRICES (2D)")
print("-" * 70)

matriz = tf.constant([[1,  2,  3,  4],
                      [5,  6,  7,  8],
                      [9, 10, 11, 12]])

print(f"Matriz (3×4):\n{matriz}\n")

# Acceder a elementos individuales [fila, columna]
print(f"Elemento en fila 0, columna 0: {matriz[0, 0]}")
print(f"Elemento en fila 1, columna 2: {matriz[1, 2]}")
print(f"Elemento en fila 2, columna 3: {matriz[2, 3]}")
print()

# Acceder a filas completas
print(f"Primera fila [0]: {matriz[0]}")
print(f"Segunda fila [1]: {matriz[1]}")
print(f"Última fila [-1]: {matriz[-1]}")
print()

# Acceder a columnas completas
print(f"Primera columna [:, 0]: {matriz[:, 0]}")
print(f"Tercera columna [:, 2]: {matriz[:, 2]}")
print(f"Última columna [:, -1]: {matriz[:, -1]}")
print()

# Slicing de submatrices
print("Submatrices:")
print(f"Primeras 2 filas, primeras 3 columnas [0:2, 0:3]:\n{matriz[0:2, 0:3]}\n")
print(f"Todas las filas, columnas 1 y 2 [:, 1:3]:\n{matriz[:, 1:3]}\n")
print(f"Filas 1 y 2, todas las columnas [1:3, :]:\n{matriz[1:3, :]}\n")

# =============================================================================
# 3. INDEXACIÓN EN TENSORES 3D
# =============================================================================

print("3. INDEXACIÓN EN TENSORES 3D")
print("-" * 70)

# Imaginemos un tensor que representa 2 imágenes de 3×3 con 2 canales de color
tensor_3d = tf.constant([
    # Imagen 1
    [[1, 2], [3, 4], [5, 6]],       # Fila 0
    [[7, 8], [9, 10], [11, 12]],    # Fila 1
    [[13, 14], [15, 16], [17, 18]]  # Fila 2
])

print(f"Tensor 3D shape {tensor_3d.shape}:\n{tensor_3d}\n")

# [fila, columna, canal]
print(f"Elemento [0, 0, 0]: {tensor_3d[0, 0, 0]}")
print(f"Elemento [1, 2, 1]: {tensor_3d[1, 2, 1]}")
print()

# Acceder a una fila completa (todos los canales)
print(f"Primera fila completa [0, :, :]:\n{tensor_3d[0, :, :]}\n")

# Acceder a un canal específico
print(f"Canal 0 de todas las filas [:, :, 0]:\n{tensor_3d[:, :, 0]}\n")
print(f"Canal 1 de todas las filas [:, :, 1]:\n{tensor_3d[:, :, 1]}\n")

# =============================================================================
# 4. MODIFICACIÓN DE TENSORES (Variables)
# =============================================================================

print("4. MODIFICACIÓN DE ELEMENTOS")
print("-" * 70)

# Crear una variable (las constantes no se pueden modificar)
matriz_var = tf.Variable([[1, 2, 3],
                          [4, 5, 6],
                          [7, 8, 9]])

print(f"Matriz original:\n{matriz_var.numpy()}\n")

# Modificar un elemento
matriz_var[0, 0].assign(99)
print(f"Después de modificar [0, 0] = 99:\n{matriz_var.numpy()}\n")

# Modificar una fila completa
matriz_var[1].assign([40, 50, 60])
print(f"Después de modificar fila 1:\n{matriz_var.numpy()}\n")

# =============================================================================
# 5. RESHAPE - CAMBIAR LA FORMA
# =============================================================================

print("5. RESHAPE - CAMBIAR LA FORMA DEL TENSOR")
print("-" * 70)

# Vector original
vector_original = tf.constant([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12])
print(f"Vector original shape {vector_original.shape}:")
print(f"{vector_original}\n")

# Reshape a matriz 3×4
matriz_3x4 = tf.reshape(vector_original, shape=(3, 4))
print(f"Reshape a (3, 4):\n{matriz_3x4}\n")

# Reshape a matriz 2×6
matriz_2x6 = tf.reshape(vector_original, shape=(2, 6))
print(f"Reshape a (2, 6):\n{matriz_2x6}\n")

# Reshape a tensor 3D: 2×2×3
tensor_2x2x3 = tf.reshape(vector_original, shape=(2, 2, 3))
print(f"Reshape a (2, 2, 3):\n{tensor_2x2x3}\n")

# Reshape con dimensión automática (-1)
# TensorFlow calcula automáticamente la dimensión
matriz_auto = tf.reshape(vector_original, shape=(4, -1))  # 4 filas, columnas automáticas
print(f"Reshape a (4, -1) - dimensión automática:\n{matriz_auto}\n")

# Aplanar (flatten) - convertir a vector
matriz_ejemplo = tf.constant([[1, 2, 3], [4, 5, 6]])
vector_plano = tf.reshape(matriz_ejemplo, shape=(-1,))
print(f"Matriz original:\n{matriz_ejemplo}\n")
print(f"Aplanada (flatten): {vector_plano}\n")

# =============================================================================
# 6. TRANSPOSE - TRANSPONER
# =============================================================================

print("6. TRANSPOSE - TRANSPONER MATRICES")
print("-" * 70)

matriz = tf.constant([[1, 2, 3],
                      [4, 5, 6]])

print(f"Matriz original (2×3):\n{matriz}\n")

# Transponer (intercambiar filas por columnas)
transpuesta = tf.transpose(matriz)
print(f"Transpuesta (3×2):\n{transpuesta}\n")

# Para tensores 3D, podemos especificar el orden de las dimensiones
tensor = tf.constant([[[1, 2],
                       [3, 4],
                       [5, 6]]])
print(f"Tensor 3D shape {tensor.shape}:\n{tensor}\n")

# Permutar dimensiones: (1, 3, 2) → (3, 1, 2)
permutado = tf.transpose(tensor, perm=[1, 0, 2])
print(f"Permutado shape {permutado.shape}:\n{permutado}\n")

# =============================================================================
# 7. EXPAND_DIMS y SQUEEZE
# =============================================================================

print("7. EXPAND_DIMS y SQUEEZE - MANIPULAR DIMENSIONES")
print("-" * 70)

vector = tf.constant([1, 2, 3, 4, 5])
print(f"Vector original shape {vector.shape}: {vector}\n")

# Expandir dimensiones (agregar una dimensión)
# Útil para batch processing en ML
expanded_0 = tf.expand_dims(vector, axis=0)  # Agregar dimensión al inicio
print(f"expand_dims(axis=0) shape {expanded_0.shape}:\n{expanded_0}\n")

expanded_1 = tf.expand_dims(vector, axis=1)  # Agregar dimensión al final
print(f"expand_dims(axis=1) shape {expanded_1.shape}:\n{expanded_1}\n")

# Squeeze - eliminar dimensiones de tamaño 1
tensor_con_dims_extra = tf.constant([[[1, 2, 3]]])
print(f"Tensor con dimensiones extra shape {tensor_con_dims_extra.shape}:")
print(f"{tensor_con_dims_extra}\n")

squeezed = tf.squeeze(tensor_con_dims_extra)
print(f"Después de squeeze shape {squeezed.shape}: {squeezed}\n")

# =============================================================================
# 8. CONCATENACIÓN Y STACKING
# =============================================================================

print("8. CONCATENAR Y APILAR TENSORES")
print("-" * 70)

# Tensores para concatenar
t1 = tf.constant([[1, 2], [3, 4]])
t2 = tf.constant([[5, 6], [7, 8]])

print(f"Tensor 1:\n{t1}\n")
print(f"Tensor 2:\n{t2}\n")

# Concatenar por filas (axis=0)
concat_filas = tf.concat([t1, t2], axis=0)
print(f"Concatenar por filas (axis=0) - shape {concat_filas.shape}:\n{concat_filas}\n")

# Concatenar por columnas (axis=1)
concat_columnas = tf.concat([t1, t2], axis=1)
print(f"Concatenar por columnas (axis=1) - shape {concat_columnas.shape}:\n{concat_columnas}\n")

# Stack - apilar (crea una nueva dimensión)
stacked = tf.stack([t1, t2], axis=0)
print(f"Stack (axis=0) - shape {stacked.shape}:\n{stacked}\n")

# =============================================================================
# 9. INDEXACIÓN AVANZADA
# =============================================================================

print("9. INDEXACIÓN AVANZADA")
print("-" * 70)

matriz = tf.constant([[10, 20, 30],
                      [40, 50, 60],
                      [70, 80, 90]])

print(f"Matriz:\n{matriz}\n")

# Gather - seleccionar elementos específicos por índices
# Seleccionar filas 0 y 2
filas_seleccionadas = tf.gather(matriz, indices=[0, 2], axis=0)
print(f"Filas 0 y 2:\n{filas_seleccionadas}\n")

# Seleccionar columnas 0 y 2
columnas_seleccionadas = tf.gather(matriz, indices=[0, 2], axis=1)
print(f"Columnas 0 y 2:\n{columnas_seleccionadas}\n")

# Boolean masking
vector = tf.constant([1, 5, 3, 8, 2, 9, 4])
mascara = vector > 4
print(f"Vector: {vector}")
print(f"Máscara (valores > 4): {mascara}")
valores_filtrados = tf.boolean_mask(vector, mascara)
print(f"Valores filtrados: {valores_filtrados}\n")

# =============================================================================
# 10. EJERCICIO PRÁCTICO
# =============================================================================

print("10. EJERCICIO PRÁCTICO")
print("-" * 70)
print("""
EJERCICIO: Manipulación de tensores

Dada la siguiente matriz:
matriz = [[1,  2,  3,  4,  5],
          [6,  7,  8,  9, 10],
          [11, 12, 13, 14, 15],
          [16, 17, 18, 19, 20]]

Realiza las siguientes operaciones:

1. Extrae la submatriz central (elementos del 7 al 9 y del 12 al 14)
2. Extrae la diagonal principal
3. Invierte el orden de las filas
4. Transpón la matriz
5. Aplana la matriz a un vector
6. Filtra todos los elementos mayores que 10

Agrega tu código aquí:
""")

# TU CÓDIGO AQUÍ:
# matriz = tf.constant([[1,  2,  3,  4,  5],
#                       [6,  7,  8,  9, 10],
#                       [11, 12, 13, 14, 15],
#                       [16, 17, 18, 19, 20]])
#
# ejercicio_1 = ...
# ejercicio_2 = ...
# ...

print("\n" + "=" * 70)
print("¡Perfecto! Ahora dominas la indexación y slicing de tensores")
print("Continúa con: 05_proyecto_calculadora.py")
print("=" * 70)
