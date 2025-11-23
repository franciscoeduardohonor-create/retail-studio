"""
MÓDULO 1 - EJEMPLO 3: Variables vs Constantes
==============================================

En este ejemplo aprenderás:
- Diferencia entre tf.constant y tf.Variable
- Cuándo usar cada una
- Cómo modificar variables
- El concepto de entrenamiento en Machine Learning
- Gradientes y derivadas automáticas (introducción)
"""

import tensorflow as tf
import numpy as np

print("=" * 70)
print("VARIABLES VS CONSTANTES EN TENSORFLOW")
print("=" * 70)
print()

# =============================================================================
# 1. CONSTANTES - VALORES INMUTABLES
# =============================================================================

print("1. CONSTANTES (tf.constant)")
print("-" * 70)

# Las constantes NO se pueden modificar después de crearlas
constante = tf.constant([1, 2, 3, 4, 5])
print(f"Constante: {constante}")
print(f"  - Tipo: {type(constante)}")
print(f"  - ¿Es mutable?: NO")
print()

# Intentar modificar una constante causará un error
print("¿Qué pasa si intentamos modificar una constante?")
print("  constante[0] = 10  ← ¡Esto daría ERROR!")
print("  Las constantes son inmutables (no se pueden cambiar)")
print()

# Uso de constantes: datos que no cambian durante el entrenamiento
# - Datos de entrada (features)
# - Datos de salida esperados (labels)
# - Hiperparámetros fijos
print("Usos comunes:")
print("  ✓ Datos de entrada (X)")
print("  ✓ Etiquetas (y)")
print("  ✓ Valores que no cambiarán")
print()

# =============================================================================
# 2. VARIABLES - VALORES MUTABLES
# =============================================================================

print("2. VARIABLES (tf.Variable)")
print("-" * 70)

# Las variables SÍ se pueden modificar - ¡esto es crucial para el aprendizaje!
variable = tf.Variable([1, 2, 3, 4, 5])
print(f"Variable inicial: {variable}")
print(f"  - Tipo: {type(variable)}")
print(f"  - ¿Es mutable?: SÍ")
print()

# Modificar una variable usando assign()
variable.assign([10, 20, 30, 40, 50])
print(f"Variable modificada: {variable}")
print()

# Modificar un elemento específico
variable_matriz = tf.Variable([[1, 2, 3],
                               [4, 5, 6]])
print(f"Variable matriz original:\n{variable_matriz}\n")

# Cambiar un solo elemento
variable_matriz[0, 1].assign(99)
print(f"Después de modificar elemento [0,1]:\n{variable_matriz}\n")

# Uso de variables: parámetros que el modelo aprende
# - Pesos (weights) de la red neuronal
# - Sesgos (bias)
# - Cualquier parámetro que se ajuste durante el entrenamiento
print("Usos comunes:")
print("  ✓ Pesos de la red neuronal (W)")
print("  ✓ Sesgos (b)")
print("  ✓ Parámetros que se actualizan durante el entrenamiento")
print()

# =============================================================================
# 3. OPERACIONES CON VARIABLES
# =============================================================================

print("3. OPERACIONES CON VARIABLES")
print("-" * 70)

# Crear una variable
peso = tf.Variable(5.0, name="peso")
print(f"Peso inicial: {peso.numpy()}")

# assign() - Asignar un nuevo valor
peso.assign(10.0)
print(f"Después de assign(10.0): {peso.numpy()}")

# assign_add() - Sumar al valor actual
peso.assign_add(3.0)
print(f"Después de assign_add(3.0): {peso.numpy()}")

# assign_sub() - Restar al valor actual
peso.assign_sub(2.0)
print(f"Después de assign_sub(2.0): {peso.numpy()}")
print()

# =============================================================================
# 4. EJEMPLO PRÁCTICO: ECUACIÓN LINEAL
# =============================================================================

print("4. EJEMPLO PRÁCTICO: y = mx + b")
print("-" * 70)

# Vamos a representar la ecuación de una línea: y = mx + b
# donde m (pendiente) y b (intersección) son VARIABLES que podemos ajustar

# Valores iniciales (aleatorios o de tu elección)
m = tf.Variable(2.0, name="pendiente")
b = tf.Variable(1.0, name="interseccion")

print(f"Ecuación inicial: y = {m.numpy()}x + {b.numpy()}")

# Datos de entrada (constantes)
x = tf.constant([1.0, 2.0, 3.0, 4.0, 5.0])

# Calcular y
y = m * x + b
print(f"Para x = {x.numpy()}")
print(f"Obtenemos y = {y.numpy()}")
print()

# Ahora cambiemos los parámetros
m.assign(3.0)
b.assign(-2.0)
y_nuevo = m * x + b
print(f"Nueva ecuación: y = {m.numpy()}x + {b.numpy()}")
print(f"Para x = {x.numpy()}")
print(f"Obtenemos y = {y_nuevo.numpy()}")
print()

# =============================================================================
# 5. GRADIENTES AUTOMÁTICOS (GradientTape)
# =============================================================================

print("5. GRADIENTES AUTOMÁTICOS - ¡La magia del aprendizaje!")
print("-" * 70)

# TensorFlow puede calcular derivadas automáticamente
# Esto es FUNDAMENTAL para el entrenamiento de redes neuronales

# Ejemplo: calcular la derivada de f(x) = x²
x = tf.Variable(3.0)

# GradientTape registra las operaciones para calcular gradientes
with tf.GradientTape() as tape:
    # Definimos la función
    y = x ** 2  # y = x²

# Calculamos dy/dx (la derivada)
# La derivada de x² es 2x, entonces en x=3, debería ser 2*3 = 6
gradiente = tape.gradient(y, x)

print(f"Función: f(x) = x²")
print(f"En x = {x.numpy()}")
print(f"f(x) = {y.numpy()}")
print(f"f'(x) = df/dx = {gradiente.numpy()}")
print(f"  (La derivada de x² es 2x = 2×{x.numpy()} = {gradiente.numpy()})")
print()

# Ejemplo más complejo: múltiples variables
print("Ejemplo con múltiples variables:")
w = tf.Variable(2.0)
b = tf.Variable(3.0)
x_val = tf.constant(4.0)

with tf.GradientTape() as tape:
    # Función: y = w*x + b
    y = w * x_val + b

# Calcular gradientes con respecto a w y b
gradientes = tape.gradient(y, [w, b])
grad_w, grad_b = gradientes

print(f"Función: y = w*x + b")
print(f"  w={w.numpy()}, b={b.numpy()}, x={x_val.numpy()}")
print(f"  y = {y.numpy()}")
print(f"Gradientes:")
print(f"  dy/dw = {grad_w.numpy()} (debería ser x = {x_val.numpy()})")
print(f"  dy/db = {grad_b.numpy()} (debería ser 1)")
print()

# =============================================================================
# 6. SIMULACIÓN DE ENTRENAMIENTO SIMPLE
# =============================================================================

print("6. SIMULACIÓN DE ENTRENAMIENTO")
print("-" * 70)

# Vamos a "entrenar" un modelo muy simple para que aprenda y = 2x + 3
# El modelo intentará descubrir que m=2 y b=3

# Inicializar parámetros con valores aleatorios
m = tf.Variable(0.0, name="pendiente")
b = tf.Variable(0.0, name="interseccion")

# Datos de entrenamiento (sabemos que la relación real es y = 2x + 3)
x_train = tf.constant([1.0, 2.0, 3.0, 4.0, 5.0])
y_train = tf.constant([5.0, 7.0, 9.0, 11.0, 13.0])  # 2x + 3

# Learning rate (tasa de aprendizaje)
learning_rate = 0.01

print(f"Parámetros iniciales: m={m.numpy():.4f}, b={b.numpy():.4f}")
print("Objetivo: m=2.0, b=3.0")
print("\nEntrenando...\n")

# Entrenar por 100 iteraciones
for epoch in range(100):
    with tf.GradientTape() as tape:
        # Predicción del modelo
        y_pred = m * x_train + b

        # Error cuadrático medio (Mean Squared Error)
        loss = tf.reduce_mean((y_train - y_pred) ** 2)

    # Calcular gradientes
    gradientes = tape.gradient(loss, [m, b])
    grad_m, grad_b = gradientes

    # Actualizar parámetros (descenso de gradiente)
    m.assign_sub(learning_rate * grad_m)  # m = m - lr * grad
    b.assign_sub(learning_rate * grad_b)  # b = b - lr * grad

    # Mostrar progreso cada 20 épocas
    if epoch % 20 == 0:
        print(f"Época {epoch:3d}: m={m.numpy():.4f}, b={b.numpy():.4f}, "
              f"loss={loss.numpy():.4f}")

print(f"\nParámetros finales: m={m.numpy():.4f}, b={b.numpy():.4f}")
print(f"¡El modelo aprendió que y ≈ {m.numpy():.1f}x + {b.numpy():.1f}!")
print()

# =============================================================================
# 7. COMPARACIÓN FINAL
# =============================================================================

print("7. RESUMEN: CONSTANTES VS VARIABLES")
print("-" * 70)
print("""
┌─────────────────┬──────────────────┬──────────────────┐
│ Característica  │   tf.constant    │   tf.Variable    │
├─────────────────┼──────────────────┼──────────────────┤
│ ¿Se puede       │       NO         │       SÍ         │
│  modificar?     │                  │                  │
├─────────────────┼──────────────────┼──────────────────┤
│ Uso típico      │ Datos de entrada │ Pesos del modelo │
│                 │ Etiquetas        │ Sesgos           │
├─────────────────┼──────────────────┼──────────────────┤
│ En              │ X (features)     │ W (weights)      │
│ ML/DL           │ y (labels)       │ b (bias)         │
└─────────────────┴──────────────────┴──────────────────┘
""")

# =============================================================================
# 8. EJERCICIO PRÁCTICO
# =============================================================================

print("8. EJERCICIO PRÁCTICO")
print("-" * 70)
print("""
EJERCICIO:

Crea un modelo simple que aprenda la función y = 3x² + 2x + 1

1. Define las variables a, b, c (inicializadas en 0)
2. Crea datos de entrenamiento para x = [0, 1, 2, 3, 4]
3. Implementa un loop de entrenamiento similar al ejemplo
4. Verifica que el modelo aprenda a ≈ 3, b ≈ 2, c ≈ 1

Pista: La función es y = a*x² + b*x + c

Agrega tu código aquí:
""")

# TU CÓDIGO AQUÍ:
# ...

print("\n" + "=" * 70)
print("¡Genial! Ahora entiendes la diferencia entre variables y constantes")
print("Continúa con: 04_indexing_slicing.py")
print("=" * 70)
