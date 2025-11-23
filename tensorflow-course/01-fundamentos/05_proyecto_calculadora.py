"""
MÓDULO 1 - PROYECTO PRÁCTICO: Calculadora con TensorFlow
=========================================================

PROYECTO FINAL DEL MÓDULO 1

En este proyecto aplicarás todo lo aprendido para crear:
- Una calculadora matricial interactiva
- Operaciones con vectores y matrices
- Funciones de álgebra lineal
- Sistema de ecuaciones lineales
"""

import tensorflow as tf
import numpy as np

print("=" * 70)
print(" PROYECTO: CALCULADORA AVANZADA CON TENSORFLOW")
print("=" * 70)
print()

# =============================================================================
# 1. CALCULADORA DE OPERACIONES BÁSICAS
# =============================================================================

def calculadora_basica(a, b, operacion):
    """
    Calculadora básica con tensores

    Args:
        a: Primer tensor
        b: Segundo tensor
        operacion: '+', '-', '*', '/' o '**'

    Returns:
        Resultado de la operación
    """
    if operacion == '+':
        return tf.add(a, b)
    elif operacion == '-':
        return tf.subtract(a, b)
    elif operacion == '*':
        return tf.multiply(a, b)
    elif operacion == '/':
        return tf.divide(a, b)
    elif operacion == '**':
        return tf.pow(a, b)
    else:
        return "Operación no válida"


print("1. CALCULADORA BÁSICA")
print("-" * 70)

x = tf.constant([10.0, 20.0, 30.0, 40.0])
y = tf.constant([2.0, 4.0, 6.0, 8.0])

print(f"x = {x.numpy()}")
print(f"y = {y.numpy()}\n")

print(f"x + y = {calculadora_basica(x, y, '+').numpy()}")
print(f"x - y = {calculadora_basica(x, y, '-').numpy()}")
print(f"x * y = {calculadora_basica(x, y, '*').numpy()}")
print(f"x / y = {calculadora_basica(x, y, '/').numpy()}")
print(f"x ** 2 = {calculadora_basica(x, tf.constant(2.0), '**').numpy()}")
print()

# =============================================================================
# 2. CALCULADORA DE ESTADÍSTICAS
# =============================================================================

def estadisticas(tensor):
    """
    Calcula estadísticas de un tensor

    Args:
        tensor: Tensor de entrada

    Returns:
        Diccionario con estadísticas
    """
    return {
        'media': tf.reduce_mean(tensor),
        'mediana': tfp_median(tensor),
        'suma': tf.reduce_sum(tensor),
        'maximo': tf.reduce_max(tensor),
        'minimo': tf.reduce_min(tensor),
        'varianza': tf.math.reduce_variance(tensor),
        'desviacion_std': tf.math.reduce_std(tensor)
    }

def tfp_median(tensor):
    """Calcula la mediana de un tensor"""
    sorted_tensor = tf.sort(tensor)
    n = tf.size(tensor)
    mid = n // 2

    # Si es par, promedio de los dos valores centrales
    if n % 2 == 0:
        return (sorted_tensor[mid-1] + sorted_tensor[mid]) / 2
    else:
        return sorted_tensor[mid]


print("2. CALCULADORA DE ESTADÍSTICAS")
print("-" * 70)

datos = tf.constant([23.5, 45.2, 67.8, 12.3, 89.1, 34.6, 56.7, 78.9, 90.1, 45.6])
print(f"Datos: {datos.numpy()}\n")

stats = estadisticas(datos)
print("Estadísticas:")
print(f"  Media:           {stats['media'].numpy():.2f}")
print(f"  Mediana:         {stats['mediana'].numpy():.2f}")
print(f"  Suma:            {stats['suma'].numpy():.2f}")
print(f"  Máximo:          {stats['maximo'].numpy():.2f}")
print(f"  Mínimo:          {stats['minimo'].numpy():.2f}")
print(f"  Varianza:        {stats['varianza'].numpy():.2f}")
print(f"  Desv. Estándar:  {stats['desviacion_std'].numpy():.2f}")
print()

# =============================================================================
# 3. OPERACIONES MATRICIALES
# =============================================================================

def determinante_2x2(matriz):
    """Calcula el determinante de una matriz 2×2"""
    # det = ad - bc para matriz [[a,b], [c,d]]
    a, b = matriz[0, 0], matriz[0, 1]
    c, d = matriz[1, 0], matriz[1, 1]
    return a * d - b * c


def inversa_2x2(matriz):
    """Calcula la inversa de una matriz 2×2"""
    det = determinante_2x2(matriz)

    if tf.abs(det) < 1e-10:
        print("La matriz no tiene inversa (determinante ≈ 0)")
        return None

    # Inversa = (1/det) * [[d, -b], [-c, a]]
    a, b = matriz[0, 0], matriz[0, 1]
    c, d = matriz[1, 0], matriz[1, 1]

    inversa = (1/det) * tf.constant([[d, -b], [-c, a]])
    return inversa


print("3. CALCULADORA MATRICIAL")
print("-" * 70)

# Matriz ejemplo
A = tf.constant([[4.0, 7.0],
                 [2.0, 6.0]])

print(f"Matriz A:\n{A.numpy()}\n")

# Determinante
det_A = determinante_2x2(A)
print(f"Determinante de A: {det_A.numpy()}")

# Inversa
A_inv = inversa_2x2(A)
print(f"\nInversa de A:\n{A_inv.numpy()}\n")

# Verificar: A × A⁻¹ = I (matriz identidad)
verificacion = tf.matmul(A, A_inv)
print(f"Verificación (A × A⁻¹):\n{verificacion.numpy()}")
print("(Debería ser aproximadamente la matriz identidad)")
print()

# =============================================================================
# 4. RESOLVER SISTEMA DE ECUACIONES LINEALES
# =============================================================================

def resolver_sistema_2x2(A, b):
    """
    Resuelve el sistema Ax = b para matrices 2×2

    Sistema:
        a₁₁x₁ + a₁₂x₂ = b₁
        a₂₁x₁ + a₂₂x₂ = b₂

    Solución: x = A⁻¹b
    """
    A_inv = inversa_2x2(A)
    if A_inv is None:
        return None

    # x = A⁻¹ × b
    x = tf.matmul(A_inv, tf.expand_dims(b, axis=1))
    return tf.squeeze(x)


print("4. RESOLVER SISTEMA DE ECUACIONES")
print("-" * 70)

# Sistema de ecuaciones:
#   2x + 3y = 13
#   4x - y = 5

A = tf.constant([[2.0, 3.0],
                 [4.0, -1.0]])
b = tf.constant([13.0, 5.0])

print("Sistema de ecuaciones:")
print(f"  {A[0,0]}x + {A[0,1]}y = {b[0]}")
print(f"  {A[1,0]}x + {A[1,1]}y = {b[1]}\n")

solucion = resolver_sistema_2x2(A, b)
print(f"Solución:")
print(f"  x = {solucion[0].numpy():.2f}")
print(f"  y = {solucion[1].numpy():.2f}")

# Verificar la solución
verificacion = tf.matmul(A, tf.expand_dims(solucion, axis=1))
print(f"\nVerificación (A × solución):\n{tf.squeeze(verificacion).numpy()}")
print(f"Debería ser igual a b: {b.numpy()}")
print()

# =============================================================================
# 5. NORMALIZACIÓN DE DATOS
# =============================================================================

def normalizar_z_score(tensor):
    """
    Normalización Z-score (estandarización)
    x_norm = (x - media) / desviación_estándar
    """
    media = tf.reduce_mean(tensor)
    std = tf.math.reduce_std(tensor)
    return (tensor - media) / std


def normalizar_min_max(tensor):
    """
    Normalización Min-Max (escala 0-1)
    x_norm = (x - min) / (max - min)
    """
    minimo = tf.reduce_min(tensor)
    maximo = tf.reduce_max(tensor)
    return (tensor - minimo) / (maximo - minimo)


print("5. NORMALIZACIÓN DE DATOS")
print("-" * 70)

datos = tf.constant([10.0, 25.0, 50.0, 75.0, 100.0, 150.0, 200.0])
print(f"Datos originales: {datos.numpy()}\n")

# Z-score
datos_z = normalizar_z_score(datos)
print(f"Normalización Z-score:")
print(f"  {datos_z.numpy()}")
print(f"  Media: {tf.reduce_mean(datos_z).numpy():.6f} (≈ 0)")
print(f"  Std:   {tf.math.reduce_std(datos_z).numpy():.6f} (≈ 1)")
print()

# Min-Max
datos_mm = normalizar_min_max(datos)
print(f"Normalización Min-Max (0-1):")
print(f"  {datos_mm.numpy()}")
print(f"  Mínimo: {tf.reduce_min(datos_mm).numpy():.6f} (= 0)")
print(f"  Máximo: {tf.reduce_max(datos_mm).numpy():.6f} (= 1)")
print()

# =============================================================================
# 6. DISTANCIAS Y SIMILITUDES
# =============================================================================

def distancia_euclidiana(a, b):
    """Calcula la distancia euclidiana entre dos vectores"""
    return tf.sqrt(tf.reduce_sum((a - b) ** 2))


def similitud_coseno(a, b):
    """Calcula la similitud de coseno entre dos vectores"""
    producto_punto = tf.reduce_sum(a * b)
    norma_a = tf.sqrt(tf.reduce_sum(a ** 2))
    norma_b = tf.sqrt(tf.reduce_sum(b ** 2))
    return producto_punto / (norma_a * norma_b)


print("6. DISTANCIAS Y SIMILITUDES")
print("-" * 70)

vector_a = tf.constant([1.0, 2.0, 3.0])
vector_b = tf.constant([4.0, 5.0, 6.0])
vector_c = tf.constant([1.0, 2.0, 3.5])

print(f"Vector A: {vector_a.numpy()}")
print(f"Vector B: {vector_b.numpy()}")
print(f"Vector C: {vector_c.numpy()}\n")

# Distancias euclidianas
dist_ab = distancia_euclidiana(vector_a, vector_b)
dist_ac = distancia_euclidiana(vector_a, vector_c)

print(f"Distancia euclidiana A-B: {dist_ab.numpy():.4f}")
print(f"Distancia euclidiana A-C: {dist_ac.numpy():.4f}")
print(f"→ A está más cerca de C que de B\n")

# Similitudes de coseno
sim_ab = similitud_coseno(vector_a, vector_b)
sim_ac = similitud_coseno(vector_a, vector_c)

print(f"Similitud coseno A-B: {sim_ab.numpy():.4f}")
print(f"Similitud coseno A-C: {sim_ac.numpy():.4f}")
print(f"→ Valores cercanos a 1 indican vectores similares")
print()

# =============================================================================
# 7. EJERCICIO FINAL
# =============================================================================

print("7. EJERCICIO FINAL - ¡TU TURNO!")
print("-" * 70)
print("""
EJERCICIO INTEGRADOR:

Tienes datos de ventas de 5 productos durante 3 meses:

Producto    | Ene  | Feb  | Mar
------------|------|------|------
A           | 100  | 120  | 150
B           | 80   | 85   | 90
C           | 200  | 220  | 250
D           | 50   | 60   | 55
E           | 150  | 140  | 160

Implementa:

1. Calcula las ventas totales por producto y por mes
2. Encuentra el producto con mayores ventas totales
3. Calcula el promedio de ventas de cada mes
4. Normaliza los datos (Min-Max)
5. Calcula la matriz de correlación entre productos

PISTAS:
- Crea una matriz de 5×3 (5 productos, 3 meses)
- Usa tf.reduce_sum con diferentes axis
- Usa tf.argmax para encontrar el máximo
- Implementa correlación: corr(A,B) = cov(A,B) / (std(A) * std(B))
""")

# TU CÓDIGO AQUÍ:
# ventas = tf.constant([...], dtype=tf.float32)
# ...

print("\n" + "=" * 70)
print("¡FELICIDADES! Has completado el Módulo 1")
print("Ahora estás listo para el Módulo 2: Redes Neuronales Básicas")
print("=" * 70)
