"""
MÓDULO 2 - EJEMPLO 1: Regresión Lineal con TensorFlow
======================================================

En este ejemplo aprenderás:
- Cómo funciona la regresión lineal
- Implementar regresión lineal desde cero
- Usar Keras para regresión lineal
- Visualizar el proceso de entrenamiento
- Evaluar el modelo
"""

import tensorflow as tf
import numpy as np
import matplotlib.pyplot as plt

print("=" * 70)
print("REGRESIÓN LINEAL CON TENSORFLOW")
print("=" * 70)
print()

# =============================================================================
# 1. GENERAR DATOS SINTÉTICOS
# =============================================================================

print("1. GENERACIÓN DE DATOS")
print("-" * 70)

# Generar datos con relación lineal: y = 3x + 7 + ruido
np.random.seed(42)
n_samples = 100

# X: valores entre 0 y 10
X = np.random.rand(n_samples, 1) * 10

# y = 3x + 7 + ruido aleatorio
y_true = 3 * X + 7
ruido = np.random.randn(n_samples, 1) * 2
y = y_true + ruido

print(f"Datos generados: {n_samples} muestras")
print(f"Relación real: y = 3x + 7 + ruido")
print(f"X shape: {X.shape}")
print(f"y shape: {y.shape}")
print(f"\nPrimeras 5 muestras:")
for i in range(5):
    print(f"  X={X[i,0]:.2f}, y={y[i,0]:.2f}")
print()

# =============================================================================
# 2. REGRESIÓN LINEAL DESDE CERO (Manual)
# =============================================================================

print("2. IMPLEMENTACIÓN MANUAL (desde cero)")
print("-" * 70)

# Inicializar parámetros aleatoriamente
W = tf.Variable(tf.random.normal([1, 1]), name='peso')
b = tf.Variable(tf.zeros([1]), name='bias')

# Hiperparámetros
learning_rate = 0.01
epochs = 100

print(f"Parámetros iniciales: W={W.numpy()[0,0]:.4f}, b={b.numpy()[0]:.4f}")
print(f"Learning rate: {learning_rate}")
print(f"Epochs: {epochs}\n")

# Convertir a tensores
X_tensor = tf.constant(X, dtype=tf.float32)
y_tensor = tf.constant(y, dtype=tf.float32)

# Listas para guardar el historial
loss_history = []

# Entrenamiento
print("Entrenando...")
for epoch in range(epochs):
    with tf.GradientTape() as tape:
        # Forward pass: y_pred = W*X + b
        y_pred = tf.matmul(X_tensor, W) + b

        # Calcular loss (Mean Squared Error)
        loss = tf.reduce_mean(tf.square(y_tensor - y_pred))

    # Backward pass: calcular gradientes
    gradients = tape.gradient(loss, [W, b])
    grad_W, grad_b = gradients

    # Actualizar parámetros
    W.assign_sub(learning_rate * grad_W)
    b.assign_sub(learning_rate * grad_b)

    # Guardar loss
    loss_history.append(loss.numpy())

    # Mostrar progreso cada 20 épocas
    if epoch % 20 == 0 or epoch == epochs - 1:
        print(f"Época {epoch:3d}: Loss={loss.numpy():.4f}, "
              f"W={W.numpy()[0,0]:.4f}, b={b.numpy()[0]:.4f}")

print(f"\nParámetros finales: W={W.numpy()[0,0]:.4f}, b={b.numpy()[0]:.4f}")
print(f"Valores reales:     W=3.0000, b=7.0000")
print(f"¡El modelo aprendió aproximadamente la relación correcta!")
print()

# =============================================================================
# 3. REGRESIÓN LINEAL CON KERAS (Forma moderna)
# =============================================================================

print("3. IMPLEMENTACIÓN CON KERAS")
print("-" * 70)

# Construir el modelo
# Sequential: modelo lineal (una capa tras otra)
# Dense: capa totalmente conectada
model = tf.keras.Sequential([
    tf.keras.layers.Dense(units=1, input_shape=[1])
])

# Compilar el modelo
# optimizer: algoritmo de optimización
# loss: función de pérdida a minimizar
model.compile(
    optimizer=tf.keras.optimizers.SGD(learning_rate=0.01),
    loss='mean_squared_error',
    metrics=['mae']  # Mean Absolute Error para monitoreo
)

print("Arquitectura del modelo:")
model.summary()
print()

# Entrenar el modelo
print("Entrenando con Keras...")
history = model.fit(
    X, y,
    epochs=100,
    verbose=0  # No mostrar cada época
)

# Obtener parámetros aprendidos
W_keras = model.layers[0].get_weights()[0][0, 0]
b_keras = model.layers[0].get_weights()[1][0]

print(f"Parámetros aprendidos: W={W_keras:.4f}, b={b_keras:.4f}")
print(f"Valores reales:        W=3.0000, b=7.0000")
print()

# =============================================================================
# 4. HACER PREDICCIONES
# =============================================================================

print("4. PREDICCIONES")
print("-" * 70)

# Nuevos valores para predecir
X_nuevo = np.array([[1.5], [4.0], [7.5], [10.0]])

# Predecir con el modelo
predicciones = model.predict(X_nuevo, verbose=0)

print("Predicciones:")
for i in range(len(X_nuevo)):
    x_val = X_nuevo[i, 0]
    y_pred = predicciones[i, 0]
    y_real = 3 * x_val + 7  # Valor real sin ruido
    print(f"  X={x_val:5.1f} → Predicción: {y_pred:6.2f}, "
          f"Real: {y_real:6.2f}")
print()

# =============================================================================
# 5. EVALUACIÓN DEL MODELO
# =============================================================================

print("5. EVALUACIÓN")
print("-" * 70)

# Evaluar en los datos de entrenamiento
loss, mae = model.evaluate(X, y, verbose=0)
print(f"Mean Squared Error (MSE): {loss:.4f}")
print(f"Mean Absolute Error (MAE): {mae:.4f}")
print()

# Calcular R² (coeficiente de determinación)
y_pred_all = model.predict(X, verbose=0)
ss_res = np.sum((y - y_pred_all) ** 2)  # Suma de residuos al cuadrado
ss_tot = np.sum((y - np.mean(y)) ** 2)  # Suma total de cuadrados
r_squared = 1 - (ss_res / ss_tot)
print(f"R² (coeficiente de determinación): {r_squared:.4f}")
print("  (Valores cercanos a 1 indican buen ajuste)")
print()

# =============================================================================
# 6. VISUALIZACIÓN
# =============================================================================

print("6. VISUALIZACIÓN")
print("-" * 70)

# Crear figura con subplots
fig, axes = plt.subplots(1, 2, figsize=(14, 5))

# Subplot 1: Datos y línea de regresión
axes[0].scatter(X, y, alpha=0.5, label='Datos de entrenamiento')
axes[0].plot(X, y_true, 'g--', label='Línea real (y=3x+7)', linewidth=2)

# Línea predicha
X_line = np.linspace(0, 10, 100).reshape(-1, 1)
y_line = model.predict(X_line, verbose=0)
axes[0].plot(X_line, y_line, 'r-',
             label=f'Predicción (y={W_keras:.2f}x+{b_keras:.2f})',
             linewidth=2)

axes[0].set_xlabel('X')
axes[0].set_ylabel('y')
axes[0].set_title('Regresión Lineal: Datos y Predicción')
axes[0].legend()
axes[0].grid(True, alpha=0.3)

# Subplot 2: Curva de aprendizaje (loss)
axes[1].plot(history.history['loss'], linewidth=2)
axes[1].set_xlabel('Época')
axes[1].set_ylabel('Loss (MSE)')
axes[1].set_title('Curva de Aprendizaje')
axes[1].grid(True, alpha=0.3)

plt.tight_layout()
plt.savefig('/tmp/regresion_lineal.png', dpi=100, bbox_inches='tight')
print("✓ Gráfica guardada en: /tmp/regresion_lineal.png")
print()

# =============================================================================
# 7. EJEMPLO CON DATOS REALES: Boston Housing
# =============================================================================

print("7. EJEMPLO CON DATOS REALES")
print("-" * 70)

# Nota: El dataset Boston Housing fue removido de sklearn
# Usaremos datos sintéticos similares
print("Generando datos sintéticos de precios de casas...")

np.random.seed(42)
n_casas = 500

# Features: tamaño (m²), habitaciones, antigüedad
tamano = np.random.rand(n_casas) * 200 + 50      # 50-250 m²
habitaciones = np.random.randint(1, 6, n_casas)   # 1-5 habitaciones
antiguedad = np.random.rand(n_casas) * 50         # 0-50 años

# Precio = 2000*tamaño + 50000*habitaciones - 500*antigüedad + ruido
precio = (2000 * tamano +
          50000 * habitaciones -
          500 * antiguedad +
          np.random.randn(n_casas) * 20000)

# Preparar datos
X_casas = np.column_stack([tamano, habitaciones, antiguedad])
y_casas = precio.reshape(-1, 1)

# Normalizar features (importante para regresión)
X_mean = X_casas.mean(axis=0)
X_std = X_casas.std(axis=0)
X_casas_norm = (X_casas - X_mean) / X_std

# Dividir en train/test (80/20)
split = int(0.8 * n_casas)
X_train, X_test = X_casas_norm[:split], X_casas_norm[split:]
y_train, y_test = y_casas[:split], y_casas[split:]

print(f"Datos de entrenamiento: {X_train.shape[0]} casas")
print(f"Datos de prueba: {X_test.shape[0]} casas")
print()

# Crear y entrenar modelo
modelo_casas = tf.keras.Sequential([
    tf.keras.layers.Dense(64, activation='relu', input_shape=[3]),
    tf.keras.layers.Dense(32, activation='relu'),
    tf.keras.layers.Dense(1)
])

modelo_casas.compile(
    optimizer='adam',
    loss='mse',
    metrics=['mae']
)

print("Entrenando modelo de predicción de precios...")
history_casas = modelo_casas.fit(
    X_train, y_train,
    epochs=100,
    validation_split=0.2,
    verbose=0
)

# Evaluar
test_loss, test_mae = modelo_casas.evaluate(X_test, y_test, verbose=0)
print(f"\nEvaluación en test:")
print(f"  MSE: ${test_loss:,.2f}")
print(f"  MAE: ${test_mae:,.2f}")
print()

# Predicción de ejemplo
casa_ejemplo = np.array([[150, 3, 10]])  # 150m², 3 hab, 10 años
casa_ejemplo_norm = (casa_ejemplo - X_mean) / X_std
precio_predicho = modelo_casas.predict(casa_ejemplo_norm, verbose=0)[0, 0]

print("Ejemplo de predicción:")
print(f"  Casa: {casa_ejemplo[0,0]:.0f}m², "
      f"{casa_ejemplo[0,1]:.0f} habitaciones, "
      f"{casa_ejemplo[0,2]:.0f} años")
print(f"  Precio estimado: ${precio_predicho:,.2f}")
print()

# =============================================================================
# 8. EJERCICIO PRÁCTICO
# =============================================================================

print("8. EJERCICIO PRÁCTICO")
print("-" * 70)
print("""
EJERCICIO:

Implementa un modelo de regresión lineal para predecir el salario
basado en los años de experiencia.

Datos:
Años de experiencia: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
Salario (miles):     [30, 35, 40, 45, 50, 55, 60, 65, 70, 75]

Tareas:
1. Crea y entrena un modelo de regresión lineal
2. Predice el salario para alguien con 12 años de experiencia
3. Visualiza los datos y la línea de regresión
4. Calcula el R²

Agrega tu código aquí:
""")

# TU CÓDIGO AQUÍ:
# experiencia = np.array([[1], [2], ...])
# salario = np.array([[30], [35], ...])
# ...

print("\n" + "=" * 70)
print("¡Excelente! Has dominado la regresión lineal con TensorFlow")
print("Continúa con: 02_regresion_logistica.py")
print("=" * 70)
