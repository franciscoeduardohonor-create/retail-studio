"""
MÓDULO 1 - EJEMPLO 2: Operaciones Básicas con Tensores
=======================================================

En este ejemplo aprenderás:
- Operaciones aritméticas básicas (+, -, *, /)
- Operaciones matriciales (multiplicación de matrices)
- Operaciones de reducción (suma, promedio, máximo, mínimo)
- Funciones matemáticas (exponencial, logaritmo, etc.)
- Operaciones elemento por elemento vs. matriciales
"""

import tensorflow as tf
import numpy as np

print("=" * 70)
print("OPERACIONES BÁSICAS CON TENSORES")
print("=" * 70)
print()

# =============================================================================
# 1. OPERACIONES ARITMÉTICAS BÁSICAS
# =============================================================================

print("1. OPERACIONES ARITMÉTICAS BÁSICAS")
print("-" * 70)

# Creamos dos tensores para trabajar
a = tf.constant([1, 2, 3, 4, 5], dtype=tf.float32)
b = tf.constant([10, 20, 30, 40, 50], dtype=tf.float32)

print(f"Tensor a: {a}")
print(f"Tensor b: {b}")
print()

# Suma (elemento por elemento)
suma = a + b  # También puedes usar: tf.add(a, b)
print(f"Suma (a + b): {suma}")

# Resta
resta = b - a  # También: tf.subtract(b, a)
print(f"Resta (b - a): {resta}")

# Multiplicación (elemento por elemento, NO es multiplicación de matrices)
multiplicacion = a * b  # También: tf.multiply(a, b)
print(f"Multiplicación (a * b): {multiplicacion}")

# División
division = b / a  # También: tf.divide(b, a)
print(f"División (b / a): {division}")

# Potencia
potencia = tf.pow(a, 2)  # Eleva cada elemento al cuadrado
print(f"Potencia (a²): {potencia}")

# Módulo (resto de la división)
modulo = b % a
print(f"Módulo (b % a): {modulo}")
print()

# =============================================================================
# 2. OPERACIONES CON ESCALARES
# =============================================================================

print("2. OPERACIONES CON ESCALARES")
print("-" * 70)

tensor = tf.constant([1.0, 2.0, 3.0, 4.0, 5.0])
escalar = 10.0

print(f"Tensor: {tensor}")
print(f"Escalar: {escalar}")
print()

# Todas las operaciones se aplican a cada elemento
print(f"Tensor + escalar: {tensor + escalar}")
print(f"Tensor - escalar: {tensor - escalar}")
print(f"Tensor × escalar: {tensor * escalar}")
print(f"Tensor ÷ escalar: {tensor / escalar}")
print()

# =============================================================================
# 3. MULTIPLICACIÓN DE MATRICES
# =============================================================================

print("3. MULTIPLICACIÓN DE MATRICES")
print("-" * 70)

# Multiplicación elemento por elemento vs. multiplicación matricial
matriz_a = tf.constant([[1, 2],
                        [3, 4]], dtype=tf.float32)

matriz_b = tf.constant([[5, 6],
                        [7, 8]], dtype=tf.float32)

print(f"Matriz A:\n{matriz_a}\n")
print(f"Matriz B:\n{matriz_b}\n")

# Multiplicación elemento por elemento (Hadamard product)
mult_elemento = matriz_a * matriz_b
print(f"Multiplicación elemento por elemento (A * B):\n{mult_elemento}\n")

# Multiplicación matricial (dot product)
mult_matricial = tf.matmul(matriz_a, matriz_b)
print(f"Multiplicación matricial (A @ B):\n{mult_matricial}\n")
# También puedes usar: matriz_a @ matriz_b

# Ejemplo práctico: multiplicación de matriz por vector
matriz = tf.constant([[1, 2, 3],
                      [4, 5, 6]], dtype=tf.float32)  # 2×3
vector = tf.constant([[10],
                      [20],
                      [30]], dtype=tf.float32)  # 3×1

resultado = tf.matmul(matriz, vector)  # Resultado: 2×1
print(f"Matriz (2×3):\n{matriz}\n")
print(f"Vector (3×1):\n{vector}\n")
print(f"Matriz × Vector (2×1):\n{resultado}\n")

# =============================================================================
# 4. OPERACIONES DE REDUCCIÓN
# =============================================================================

print("4. OPERACIONES DE REDUCCIÓN")
print("-" * 70)

numeros = tf.constant([[1, 2, 3],
                       [4, 5, 6],
                       [7, 8, 9]], dtype=tf.float32)

print(f"Matriz:\n{numeros}\n")

# Suma de todos los elementos
suma_total = tf.reduce_sum(numeros)
print(f"Suma total: {suma_total}")

# Suma por filas (axis=1)
suma_filas = tf.reduce_sum(numeros, axis=1)
print(f"Suma por filas: {suma_filas}")
print(f"  Fila 0: 1+2+3 = {suma_filas[0]}")
print(f"  Fila 1: 4+5+6 = {suma_filas[1]}")
print(f"  Fila 2: 7+8+9 = {suma_filas[2]}")

# Suma por columnas (axis=0)
suma_columnas = tf.reduce_sum(numeros, axis=0)
print(f"Suma por columnas: {suma_columnas}")
print(f"  Columna 0: 1+4+7 = {suma_columnas[0]}")
print(f"  Columna 1: 2+5+8 = {suma_columnas[1]}")
print(f"  Columna 2: 3+6+9 = {suma_columnas[2]}")
print()

# Promedio
promedio = tf.reduce_mean(numeros)
print(f"Promedio total: {promedio}")

promedio_filas = tf.reduce_mean(numeros, axis=1)
print(f"Promedio por filas: {promedio_filas}")
print()

# Máximo y mínimo
maximo = tf.reduce_max(numeros)
minimo = tf.reduce_min(numeros)
print(f"Valor máximo: {maximo}")
print(f"Valor mínimo: {minimo}")
print()

# Índice del máximo (argmax)
matriz_ejemplo = tf.constant([[10, 25, 15],
                              [30, 20, 35]])
indice_max = tf.argmax(matriz_ejemplo, axis=1)  # Máximo de cada fila
print(f"Matriz:\n{matriz_ejemplo}")
print(f"Índice del máximo por fila: {indice_max}")
print(f"  Fila 0: máximo en columna {indice_max[0]} (valor: 25)")
print(f"  Fila 1: máximo en columna {indice_max[1]} (valor: 35)")
print()

# =============================================================================
# 5. FUNCIONES MATEMÁTICAS
# =============================================================================

print("5. FUNCIONES MATEMÁTICAS")
print("-" * 70)

x = tf.constant([1.0, 2.0, 3.0, 4.0])
print(f"x: {x}\n")

# Raíz cuadrada
raiz = tf.sqrt(x)
print(f"Raíz cuadrada: {raiz}")

# Exponencial (e^x)
exponencial = tf.exp(x)
print(f"Exponencial (e^x): {exponencial}")

# Logaritmo natural
logaritmo = tf.math.log(x)
print(f"Logaritmo natural (ln): {logaritmo}")

# Valor absoluto
negativos = tf.constant([-5, -3, -1, 2, 4])
absoluto = tf.abs(negativos)
print(f"\nValores negativos: {negativos}")
print(f"Valor absoluto: {absoluto}")

# Redondeo
decimales = tf.constant([1.2, 2.5, 3.7, 4.9])
redondeado = tf.round(decimales)
print(f"\nDecimales: {decimales}")
print(f"Redondeado: {redondeado}")

# Funciones trigonométricas
angulos = tf.constant([0.0, np.pi/4, np.pi/2, np.pi])
seno = tf.sin(angulos)
coseno = tf.cos(angulos)
print(f"\nÁngulos (radianes): {angulos}")
print(f"Seno: {seno}")
print(f"Coseno: {coseno}")
print()

# =============================================================================
# 6. OPERACIONES LÓGICAS Y COMPARACIÓN
# =============================================================================

print("6. OPERACIONES LÓGICAS Y COMPARACIÓN")
print("-" * 70)

x = tf.constant([1, 5, 10, 15, 20])
y = tf.constant([5, 5, 8, 20, 15])

print(f"x: {x}")
print(f"y: {y}\n")

# Comparaciones
print(f"x == y: {tf.equal(x, y)}")
print(f"x != y: {tf.not_equal(x, y)}")
print(f"x < y:  {tf.less(x, y)}")
print(f"x <= y: {tf.less_equal(x, y)}")
print(f"x > y:  {tf.greater(x, y)}")
print(f"x >= y: {tf.greater_equal(x, y)}")
print()

# Operaciones lógicas
a_bool = tf.constant([True, False, True, False])
b_bool = tf.constant([True, True, False, False])

print(f"a: {a_bool}")
print(f"b: {b_bool}\n")
print(f"a AND b: {tf.logical_and(a_bool, b_bool)}")
print(f"a OR b:  {tf.logical_or(a_bool, b_bool)}")
print(f"NOT a:   {tf.logical_not(a_bool)}")
print()

# =============================================================================
# 7. BROADCASTING
# =============================================================================

print("7. BROADCASTING (PROPAGACIÓN AUTOMÁTICA)")
print("-" * 70)

# Broadcasting permite operar tensores de diferentes formas
matriz = tf.constant([[1, 2, 3],
                      [4, 5, 6],
                      [7, 8, 9]])

vector_fila = tf.constant([10, 20, 30])  # Shape: (3,)

# El vector se "propaga" automáticamente para cada fila
resultado = matriz + vector_fila
print(f"Matriz (3×3):\n{matriz}\n")
print(f"Vector (3,): {vector_fila}\n")
print(f"Matriz + Vector:\n{resultado}\n")
print("Explicación: El vector [10, 20, 30] se suma a cada fila de la matriz")
print()

# =============================================================================
# 8. EJERCICIO PRÁCTICO
# =============================================================================

print("8. EJERCICIO PRÁCTICO")
print("-" * 70)
print("""
EJERCICIO: Implementa las siguientes operaciones

Dados los tensores:
A = [[1, 2], [3, 4]]
B = [[5, 6], [7, 8]]

Calcula:
1. La suma de A y B
2. El producto matricial de A y B
3. La media de todos los elementos de A
4. El máximo valor de B
5. Normaliza la matriz A (resta la media y divide por la desviación estándar)

Agrega tu código aquí abajo:
""")

# TU CÓDIGO AQUÍ:
# A = tf.constant([[1, 2], [3, 4]], dtype=tf.float32)
# B = tf.constant([[5, 6], [7, 8]], dtype=tf.float32)
#
# ejercicio_1 = ...
# ejercicio_2 = ...
# ...

print("\n" + "=" * 70)
print("¡Excelente! Ahora dominas las operaciones básicas con tensores")
print("Continúa con: 03_variables_constantes.py")
print("=" * 70)
