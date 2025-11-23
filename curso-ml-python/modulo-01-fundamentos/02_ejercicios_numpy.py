"""
EJERCICIOS PRÁCTICOS - NUMPY
=============================

Estos ejercicios te ayudarán a dominar NumPy.
Intenta resolverlos por tu cuenta antes de ver las soluciones.
"""

import numpy as np

print("=" * 70)
print("EJERCICIOS DE NUMPY - ¡Inténtalos tú mismo!")
print("=" * 70)

# =============================================================================
# EJERCICIO 1: Creación de Arrays
# =============================================================================

print("\n--- EJERCICIO 1: Creación de Arrays ---")
print("Crea los siguientes arrays:")
print("a) Un array de 10 ceros")
print("b) Un array de 5 cincos")
print("c) Un array del 10 al 50 con paso de 5")
print("d) Una matriz identidad de 4x4")
print("e) Una matriz 3x3 con valores aleatorios entre 0 y 1")

# SOLUCIONES:
print("\n--- SOLUCIONES ---\n")

# a) Array de 10 ceros
a = np.zeros(10)
print(f"a) 10 ceros: {a}")

# b) Array de 5 cincos
b = np.ones(5) * 5
# O también: b = np.full(5, 5)
print(f"b) 5 cincos: {b}")

# c) Array del 10 al 50 con paso de 5
c = np.arange(10, 51, 5)
print(f"c) 10 a 50, paso 5: {c}")

# d) Matriz identidad 4x4
d = np.eye(4)
print(f"d) Identidad 4x4:\n{d}")

# e) Matriz 3x3 aleatoria
np.random.seed(42)  # Para reproducibilidad
e = np.random.rand(3, 3)
print(f"e) Matriz aleatoria 3x3:\n{e}")

# =============================================================================
# EJERCICIO 2: Indexación y Slicing
# =============================================================================

print("\n" + "=" * 70)
print("--- EJERCICIO 2: Indexación y Slicing ---")

matriz = np.array([[1,  2,  3,  4,  5],
                   [6,  7,  8,  9,  10],
                   [11, 12, 13, 14, 15],
                   [16, 17, 18, 19, 20],
                   [21, 22, 23, 24, 25]])

print(f"Matriz:\n{matriz}\n")
print("Extrae:")
print("a) La tercera fila")
print("b) La última columna")
print("c) La submatriz del centro 3x3 (elementos del 7 al 9, 12 al 14, 17 al 19)")
print("d) Todos los elementos mayores a 15")

# SOLUCIONES:
print("\n--- SOLUCIONES ---\n")

# a) Tercera fila (índice 2)
a = matriz[2, :]
print(f"a) Tercera fila: {a}")

# b) Última columna
b = matriz[:, -1]
print(f"b) Última columna: {b}")

# c) Submatriz del centro 3x3
c = matriz[1:4, 1:4]
print(f"c) Submatriz 3x3 del centro:\n{c}")

# d) Elementos mayores a 15
d = matriz[matriz > 15]
print(f"d) Elementos > 15: {d}")

# =============================================================================
# EJERCICIO 3: Operaciones y Estadísticas
# =============================================================================

print("\n" + "=" * 70)
print("--- EJERCICIO 3: Operaciones y Estadísticas ---")

# Datos de ventas de 4 productos en 5 tiendas (filas=tiendas, columnas=productos)
ventas = np.array([[120, 150, 180, 90],
                   [95,  130, 200, 110],
                   [180, 170, 160, 150],
                   [110, 140, 175, 95],
                   [150, 160, 190, 120]])

print(f"Ventas por tienda y producto:\n{ventas}\n")
print("Calcula:")
print("a) Total de ventas de todas las tiendas")
print("b) Ventas totales por tienda")
print("c) Ventas totales por producto")
print("d) Producto más vendido (índice)")
print("e) Tienda con mayores ventas totales")
print("f) Promedio de ventas por producto")

# SOLUCIONES:
print("\n--- SOLUCIONES ---\n")

# a) Total de ventas
a = ventas.sum()
print(f"a) Total de ventas: {a}")

# b) Ventas por tienda (suma por filas)
b = ventas.sum(axis=1)
print(f"b) Ventas por tienda: {b}")
for i, venta in enumerate(b):
    print(f"   Tienda {i+1}: {venta}")

# c) Ventas por producto (suma por columnas)
c = ventas.sum(axis=0)
print(f"\nc) Ventas por producto: {c}")
for i, venta in enumerate(c):
    print(f"   Producto {i+1}: {venta}")

# d) Producto más vendido
d = c.argmax()
print(f"\nd) Producto más vendido: Producto {d+1} con {c[d]} unidades")

# e) Tienda con mayores ventas
e = b.argmax()
print(f"e) Tienda con mayores ventas: Tienda {e+1} con {b[e]} unidades")

# f) Promedio por producto
f = ventas.mean(axis=0)
print(f"\nf) Promedio por producto:")
for i, promedio in enumerate(f):
    print(f"   Producto {i+1}: {promedio:.2f}")

# =============================================================================
# EJERCICIO 4: Broadcasting y Normalización
# =============================================================================

print("\n" + "=" * 70)
print("--- EJERCICIO 4: Broadcasting y Normalización ---")

# Datos de exámenes de 5 estudiantes en 3 materias
notas = np.array([[85, 92, 78],
                  [90, 88, 95],
                  [75, 80, 82],
                  [92, 95, 88],
                  [88, 85, 90]])

print(f"Notas originales:\n{notas}\n")
print("Realiza:")
print("a) Añade 5 puntos bonus a todas las notas")
print("b) Calcula el promedio de cada estudiante")
print("c) Normaliza las notas (z-score) por materia")
print("d) Encuentra al estudiante con mejor promedio")

# SOLUCIONES:
print("\n--- SOLUCIONES ---\n")

# a) Añadir 5 puntos bonus
a = notas + 5
print(f"a) Notas con bonus:\n{a}")

# b) Promedio por estudiante
b = notas.mean(axis=1)
print(f"\nb) Promedio por estudiante:")
for i, promedio in enumerate(b):
    print(f"   Estudiante {i+1}: {promedio:.2f}")

# c) Normalización z-score por materia
media_materia = notas.mean(axis=0)
std_materia = notas.std(axis=0)
c = (notas - media_materia) / std_materia
print(f"\nc) Notas normalizadas (z-score):\n{c}")

# d) Mejor estudiante
d = b.argmax()
print(f"\nd) Mejor estudiante: Estudiante {d+1} con promedio {b[d]:.2f}")

# =============================================================================
# EJERCICIO 5: Álgebra Lineal
# =============================================================================

print("\n" + "=" * 70)
print("--- EJERCICIO 5: Álgebra Lineal ---")

# Sistema de ecuaciones lineales:
# 2x + 3y = 13
# x - y = -1

print("Resuelve el sistema de ecuaciones:")
print("2x + 3y = 13")
print("x - y = -1")
print("\nUsando: Ax = b, donde x = A^(-1)b")

# SOLUCIÓN:
print("\n--- SOLUCIÓN ---\n")

# Matriz de coeficientes A
A = np.array([[2, 3],
              [1, -1]])

# Vector de términos independientes b
b = np.array([13, -1])

print(f"Matriz A:\n{A}")
print(f"Vector b: {b}\n")

# Solución usando inversa: x = A^(-1) × b
A_inv = np.linalg.inv(A)
x = np.dot(A_inv, b)

print(f"Solución x: {x}")
print(f"x = {x[0]}, y = {x[1]}\n")

# Verificación
verificacion = np.dot(A, x)
print(f"Verificación Ax = b:")
print(f"Ax = {verificacion}")
print(f"b = {b}")
print(f"¿Son iguales? {np.allclose(verificacion, b)}")

# =============================================================================
# EJERCICIO 6: Proyecto Mini - Análisis de Temperaturas
# =============================================================================

print("\n" + "=" * 70)
print("--- EJERCICIO 6: PROYECTO MINI - Análisis de Temperaturas ---")
print("=" * 70)

# Simular temperaturas de 30 días (°C)
np.random.seed(100)
dias = 30
temperaturas = np.random.uniform(18, 32, size=dias)

print(f"\nTemperaturas de {dias} días:")
print(f"{temperaturas.round(1)}\n")

print("Calcula:")
print("1. Temperatura promedio del mes")
print("2. Temperatura máxima y mínima")
print("3. Cantidad de días con temperatura > 25°C")
print("4. Desviación estándar")
print("5. Días con temperatura anormal (fuera de ±1.5 std)")

# SOLUCIONES:
print("\n--- SOLUCIONES ---\n")

# 1. Temperatura promedio
temp_promedio = temperaturas.mean()
print(f"1. Temperatura promedio: {temp_promedio:.2f}°C")

# 2. Máxima y mínima
temp_max = temperaturas.max()
temp_min = temperaturas.min()
dia_max = temperaturas.argmax() + 1
dia_min = temperaturas.argmin() + 1

print(f"\n2. Temperatura máxima: {temp_max:.2f}°C (Día {dia_max})")
print(f"   Temperatura mínima: {temp_min:.2f}°C (Día {dia_min})")

# 3. Días con temperatura > 25°C
dias_calurosos = temperaturas > 25
cantidad_calurosos = dias_calurosos.sum()
print(f"\n3. Días con temperatura > 25°C: {cantidad_calurosos}")

# 4. Desviación estándar
temp_std = temperaturas.std()
print(f"\n4. Desviación estándar: {temp_std:.2f}°C")

# 5. Días anormales (outliers)
limite_superior = temp_promedio + 1.5 * temp_std
limite_inferior = temp_promedio - 1.5 * temp_std
dias_anormales = (temperaturas > limite_superior) | (temperaturas < limite_inferior)
cantidad_anormales = dias_anormales.sum()

print(f"\n5. Rango normal: [{limite_inferior:.2f}, {limite_superior:.2f}]°C")
print(f"   Días con temperatura anormal: {cantidad_anormales}")

if cantidad_anormales > 0:
    print(f"   Temperaturas anormales:")
    for i, es_anormal in enumerate(dias_anormales):
        if es_anormal:
            print(f"      Día {i+1}: {temperaturas[i]:.2f}°C")

# Resumen estadístico
print("\n" + "=" * 70)
print("RESUMEN ESTADÍSTICO:")
print("=" * 70)
print(f"Media:    {temperaturas.mean():.2f}°C")
print(f"Mediana:  {np.median(temperaturas):.2f}°C")
print(f"Std:      {temperaturas.std():.2f}°C")
print(f"Varianza: {temperaturas.var():.2f}")
print(f"Min:      {temperaturas.min():.2f}°C")
print(f"Max:      {temperaturas.max():.2f}°C")
print(f"Rango:    {temperaturas.max() - temperaturas.min():.2f}°C")

print("\n" + "=" * 70)
print("¡Excelente! Has completado todos los ejercicios de NumPy")
print("=" * 70)
