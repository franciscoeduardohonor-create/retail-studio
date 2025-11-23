"""
MÓDULO 2 - EJEMPLO 2: Clasificación de Dígitos MNIST
=====================================================

En este ejemplo aprenderás:
- Clasificación multiclase con redes neuronales
- Cargar y preprocesar el dataset MNIST
- Construir una red neuronal densa (fully connected)
- Entrenamiento y validación
- Evaluar precisión del modelo
- Visualizar predicciones

MNIST: 70,000 imágenes de dígitos escritos a mano (28×28 píxeles)
"""

import tensorflow as tf
import numpy as np
import matplotlib.pyplot as plt

print("=" * 70)
print("CLASIFICACIÓN DE DÍGITOS MNIST")
print("=" * 70)
print()

# =============================================================================
# 1. CARGAR Y EXPLORAR EL DATASET
# =============================================================================

print("1. CARGANDO EL DATASET MNIST")
print("-" * 70)

# MNIST viene incluido en Keras
# Se divide automáticamente en train (60,000) y test (10,000)
(X_train, y_train), (X_test, y_test) = tf.keras.datasets.mnist.load_data()

print(f"Datos de entrenamiento:")
print(f"  X_train shape: {X_train.shape}")  # (60000, 28, 28)
print(f"  y_train shape: {y_train.shape}")  # (60000,)
print(f"\nDatos de prueba:")
print(f"  X_test shape: {X_test.shape}")    # (10000, 28, 28)
print(f"  y_test shape: {y_test.shape}")    # (10000,)

print(f"\nRango de valores de píxeles: {X_train.min()} - {X_train.max()}")
print(f"Clases (dígitos): {np.unique(y_train)}")
print()

# Mostrar ejemplos
print("Primeros 5 ejemplos:")
for i in range(5):
    print(f"  Imagen {i}: etiqueta = {y_train[i]}")
print()

# =============================================================================
# 2. VISUALIZAR EJEMPLOS DEL DATASET
# =============================================================================

print("2. VISUALIZANDO EJEMPLOS")
print("-" * 70)

# Crear una cuadrícula de 10 imágenes
fig, axes = plt.subplots(2, 5, figsize=(12, 5))
axes = axes.ravel()

for i in range(10):
    axes[i].imshow(X_train[i], cmap='gray')
    axes[i].set_title(f'Etiqueta: {y_train[i]}')
    axes[i].axis('off')

plt.tight_layout()
plt.savefig('/tmp/mnist_ejemplos.png', dpi=100, bbox_inches='tight')
print("✓ Ejemplos guardados en: /tmp/mnist_ejemplos.png")
print()

# =============================================================================
# 3. PREPROCESAMIENTO DE DATOS
# =============================================================================

print("3. PREPROCESAMIENTO")
print("-" * 70)

# Paso 1: Normalizar los valores de píxeles (0-255 → 0-1)
# Esto ayuda al entrenamiento
X_train_norm = X_train.astype('float32') / 255.0
X_test_norm = X_test.astype('float32') / 255.0

print(f"Valores normalizados: {X_train_norm.min():.1f} - {X_train_norm.max():.1f}")

# Paso 2: Aplanar las imágenes (28×28 → 784)
# Cada imagen será un vector de 784 valores
X_train_flat = X_train_norm.reshape(-1, 28 * 28)
X_test_flat = X_test_norm.reshape(-1, 28 * 28)

print(f"Shape después de aplanar:")
print(f"  X_train: {X_train_flat.shape}")  # (60000, 784)
print(f"  X_test:  {X_test_flat.shape}")   # (10000, 784)
print()

# Paso 3: Las etiquetas ya están en formato correcto (0-9)
# No necesitamos one-hot encoding si usamos sparse_categorical_crossentropy
print(f"Distribución de clases en entrenamiento:")
for digit in range(10):
    count = np.sum(y_train == digit)
    print(f"  Dígito {digit}: {count:5d} imágenes ({count/len(y_train)*100:.1f}%)")
print()

# =============================================================================
# 4. CONSTRUIR EL MODELO
# =============================================================================

print("4. CONSTRUCCIÓN DEL MODELO")
print("-" * 70)

# Modelo Sequential: capas apiladas secuencialmente
model = tf.keras.Sequential([
    # Capa de entrada: 784 neuronas (una por píxel)
    # Primera capa oculta: 128 neuronas con activación ReLU
    tf.keras.layers.Dense(128, activation='relu', input_shape=(784,)),

    # Dropout: desactiva aleatoriamente 20% de neuronas (previene overfitting)
    tf.keras.layers.Dropout(0.2),

    # Segunda capa oculta: 64 neuronas con ReLU
    tf.keras.layers.Dense(64, activation='relu'),

    # Capa de salida: 10 neuronas (una por dígito) con softmax
    # Softmax convierte los valores en probabilidades que suman 1
    tf.keras.layers.Dense(10, activation='softmax')
])

print("Arquitectura del modelo:")
model.summary()
print()

# Explicación de la arquitectura:
print("Explicación:")
print("  - Input layer:  784 neuronas (28×28 píxeles)")
print("  - Hidden layer: 128 neuronas + ReLU")
print("  - Dropout:      Regularización (20%)")
print("  - Hidden layer: 64 neuronas + ReLU")
print("  - Output layer: 10 neuronas + Softmax")
print()

# Total de parámetros (pesos y bias)
total_params = model.count_params()
print(f"Total de parámetros entrenables: {total_params:,}")
print()

# =============================================================================
# 5. COMPILAR EL MODELO
# =============================================================================

print("5. COMPILACIÓN")
print("-" * 70)

model.compile(
    # Optimizer: Adam es muy eficiente
    optimizer='adam',

    # Loss: sparse_categorical_crossentropy para clasificación multiclase
    # "sparse" porque las etiquetas son enteros (0-9), no one-hot
    loss='sparse_categorical_crossentropy',

    # Metrics: accuracy (precisión)
    metrics=['accuracy']
)

print("Modelo compilado con:")
print("  - Optimizer: Adam")
print("  - Loss: Sparse Categorical Crossentropy")
print("  - Metrics: Accuracy")
print()

# =============================================================================
# 6. ENTRENAR EL MODELO
# =============================================================================

print("6. ENTRENAMIENTO")
print("-" * 70)
print("Entrenando el modelo...\n")

# Entrenar durante 10 épocas
# validation_split=0.1 usa 10% de datos para validación
history = model.fit(
    X_train_flat,
    y_train,
    epochs=10,
    batch_size=128,
    validation_split=0.1,  # 10% para validación
    verbose=1
)

print("\n✓ Entrenamiento completado!")
print()

# =============================================================================
# 7. EVALUAR EL MODELO
# =============================================================================

print("7. EVALUACIÓN EN DATOS DE PRUEBA")
print("-" * 70)

# Evaluar en el conjunto de test (datos nunca vistos)
test_loss, test_accuracy = model.evaluate(X_test_flat, y_test, verbose=0)

print(f"Resultados en test set:")
print(f"  Loss:     {test_loss:.4f}")
print(f"  Accuracy: {test_accuracy:.4f} ({test_accuracy*100:.2f}%)")
print()

# Comparar con train
train_loss = history.history['loss'][-1]
train_acc = history.history['accuracy'][-1]

print(f"Comparación train vs test:")
print(f"  Train accuracy: {train_acc:.4f} ({train_acc*100:.2f}%)")
print(f"  Test accuracy:  {test_accuracy:.4f} ({test_accuracy*100:.2f}%)")
print()

# =============================================================================
# 8. HACER PREDICCIONES
# =============================================================================

print("8. PREDICCIONES")
print("-" * 70)

# Predecir las primeras 10 imágenes del test set
predicciones = model.predict(X_test_flat[:10], verbose=0)

print("Predicciones (probabilidades para cada dígito):")
print(f"Shape: {predicciones.shape}\n")  # (10, 10)

for i in range(5):
    # Clase predicha (argmax de las probabilidades)
    clase_predicha = np.argmax(predicciones[i])
    confianza = predicciones[i][clase_predicha] * 100

    print(f"Imagen {i}:")
    print(f"  Predicción: {clase_predicha} (confianza: {confianza:.1f}%)")
    print(f"  Etiqueta real: {y_test[i]}")
    print(f"  ¿Correcta? {'✓' if clase_predicha == y_test[i] else '✗'}")
    print()

# =============================================================================
# 9. MATRIZ DE CONFUSIÓN
# =============================================================================

print("9. MATRIZ DE CONFUSIÓN")
print("-" * 70)

# Predecir todas las imágenes del test
y_pred = model.predict(X_test_flat, verbose=0)
y_pred_classes = np.argmax(y_pred, axis=1)

# Crear matriz de confusión
from sklearn.metrics import confusion_matrix, classification_report

conf_matrix = confusion_matrix(y_test, y_pred_classes)

print("Matriz de confusión:")
print("(Filas: etiquetas reales, Columnas: predicciones)\n")
print("    ", end="")
for i in range(10):
    print(f"{i:5d}", end="")
print()
for i in range(10):
    print(f"{i:2d}: ", end="")
    for j in range(10):
        print(f"{conf_matrix[i,j]:5d}", end="")
    print()
print()

# Reporte de clasificación
print("Reporte de clasificación:")
print(classification_report(y_test, y_pred_classes, target_names=[str(i) for i in range(10)]))
print()

# =============================================================================
# 10. VISUALIZAR PREDICCIONES
# =============================================================================

print("10. VISUALIZACIÓN DE PREDICCIONES")
print("-" * 70)

# Visualizar predicciones correctas e incorrectas
fig, axes = plt.subplots(4, 5, figsize=(15, 12))
axes = axes.ravel()

# Encontrar algunos aciertos y errores
aciertos = np.where(y_pred_classes == y_test)[0]
errores = np.where(y_pred_classes != y_test)[0]

# Mostrar 10 aciertos y 10 errores
for i in range(10):
    # Aciertos
    idx = aciertos[i]
    axes[i].imshow(X_test[idx], cmap='gray')
    pred = y_pred_classes[idx]
    conf = y_pred[idx][pred] * 100
    axes[i].set_title(f'✓ Pred:{pred} Real:{y_test[idx]}\n{conf:.0f}%',
                      color='green')
    axes[i].axis('off')

    # Errores
    idx = errores[i]
    axes[i+10].imshow(X_test[idx], cmap='gray')
    pred = y_pred_classes[idx]
    conf = y_pred[idx][pred] * 100
    axes[i+10].set_title(f'✗ Pred:{pred} Real:{y_test[idx]}\n{conf:.0f}%',
                         color='red')
    axes[i+10].axis('off')

plt.tight_layout()
plt.savefig('/tmp/mnist_predicciones.png', dpi=100, bbox_inches='tight')
print("✓ Predicciones guardadas en: /tmp/mnist_predicciones.png")
print()

# =============================================================================
# 11. CURVAS DE APRENDIZAJE
# =============================================================================

print("11. CURVAS DE APRENDIZAJE")
print("-" * 70)

fig, axes = plt.subplots(1, 2, figsize=(14, 5))

# Loss
axes[0].plot(history.history['loss'], label='Train Loss', linewidth=2)
axes[0].plot(history.history['val_loss'], label='Val Loss', linewidth=2)
axes[0].set_xlabel('Época')
axes[0].set_ylabel('Loss')
axes[0].set_title('Curva de Pérdida (Loss)')
axes[0].legend()
axes[0].grid(True, alpha=0.3)

# Accuracy
axes[1].plot(history.history['accuracy'], label='Train Accuracy', linewidth=2)
axes[1].plot(history.history['val_accuracy'], label='Val Accuracy', linewidth=2)
axes[1].set_xlabel('Época')
axes[1].set_ylabel('Accuracy')
axes[1].set_title('Curva de Precisión (Accuracy)')
axes[1].legend()
axes[1].grid(True, alpha=0.3)

plt.tight_layout()
plt.savefig('/tmp/mnist_curvas.png', dpi=100, bbox_inches='tight')
print("✓ Curvas guardadas en: /tmp/mnist_curvas.png")
print()

# =============================================================================
# 12. GUARDAR Y CARGAR EL MODELO
# =============================================================================

print("12. GUARDAR Y CARGAR MODELO")
print("-" * 70)

# Guardar el modelo
model.save('/tmp/mnist_model.keras')
print("✓ Modelo guardado en: /tmp/mnist_model.keras")

# Cargar el modelo
modelo_cargado = tf.keras.models.load_model('/tmp/mnist_model.keras')
print("✓ Modelo cargado correctamente")

# Verificar que funciona igual
test_acc_cargado = modelo_cargado.evaluate(X_test_flat, y_test, verbose=0)[1]
print(f"Accuracy del modelo cargado: {test_acc_cargado:.4f}")
print()

# =============================================================================
# 13. EJERCICIO PRÁCTICO
# =============================================================================

print("13. EJERCICIO PRÁCTICO")
print("-" * 70)
print("""
EJERCICIO: Mejorar el modelo

El modelo actual alcanza ~98% de accuracy. ¡Intenta mejorarlo!

Ideas para experimentar:
1. Añadir más capas ocultas
2. Aumentar/disminuir el número de neuronas
3. Cambiar la tasa de dropout
4. Probar diferentes optimizadores (SGD, RMSprop)
5. Ajustar el learning rate
6. Aumentar el número de épocas
7. Usar batch normalization

BONUS: Prueba con Fashion MNIST:
(X_train, y_train), (X_test, y_test) = tf.keras.datasets.fashion_mnist.load_data()

Agrega tu código aquí:
""")

# TU CÓDIGO AQUÍ:
# model_mejorado = tf.keras.Sequential([...])
# ...

print("\n" + "=" * 70)
print("¡Excelente! Has dominado la clasificación con redes neuronales")
print("Continúa con: 03_funciones_activacion.py")
print("=" * 70)
