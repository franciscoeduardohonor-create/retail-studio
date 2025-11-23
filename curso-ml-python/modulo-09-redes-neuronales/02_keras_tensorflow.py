"""
MÓDULO 9: REDES NEURONALES CON TENSORFLOW/KERAS
================================================

TensorFlow + Keras es el framework líder para Deep Learning.
Keras proporciona una API de alto nivel, fácil de usar.

En este módulo aprenderás:
- Arquitectura de redes neuronales con Keras
- Clasificación de dígitos MNIST
- Técnicas de regularización
- Callbacks y early stopping
"""

import numpy as np
import matplotlib.pyplot as plt

# Importar TensorFlow y Keras
try:
    import tensorflow as tf
    from tensorflow import keras
    from tensorflow.keras import layers, models
    from tensorflow.keras.datasets import mnist
    from tensorflow.keras.utils import to_categorical
    print(f"TensorFlow version: {tf.__version__}")
    print(f"Keras version: {keras.__version__}\n")
except ImportError:
    print("⚠️  TensorFlow no está instalado.")
    print("Instala con: pip install tensorflow")
    print("\nEste script requiere TensorFlow para funcionar.")
    exit()

# =============================================================================
# 1. RED NEURONAL SIMPLE CON KERAS
# =============================================================================

print("=" * 70)
print("1. RED NEURONAL SIMPLE CON KERAS")
print("=" * 70)

# Generar datos sintéticos para clasificación binaria
np.random.seed(42)
from sklearn.datasets import make_moons
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler

X, y = make_moons(n_samples=1000, noise=0.2, random_state=42)

# Dividir datos
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Normalizar
scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train)
X_test_scaled = scaler.transform(X_test)

print(f"Datos de entrenamiento: {X_train_scaled.shape}")
print(f"Datos de prueba: {X_test_scaled.shape}")
print()

# Crear modelo secuencial
model = models.Sequential([
    layers.Dense(16, activation='relu', input_shape=(2,)),  # Capa oculta 1
    layers.Dense(8, activation='relu'),                     # Capa oculta 2
    layers.Dense(1, activation='sigmoid')                   # Capa de salida
])

print("Arquitectura del modelo:")
model.summary()
print()

# Compilar el modelo
model.compile(
    optimizer='adam',                    # Optimizador Adam
    loss='binary_crossentropy',          # Función de pérdida para clasificación binaria
    metrics=['accuracy']                 # Métrica a monitorear
)

# Entrenar el modelo
print("Entrenando modelo...")
history = model.fit(
    X_train_scaled, y_train,
    epochs=50,
    batch_size=32,
    validation_split=0.2,  # 20% de los datos de entrenamiento para validación
    verbose=0              # Sin output detallado
)

# Evaluar
test_loss, test_accuracy = model.evaluate(X_test_scaled, y_test, verbose=0)
print(f"\nResultados en datos de prueba:")
print(f"  Loss: {test_loss:.4f}")
print(f"  Accuracy: {test_accuracy:.4f} ({test_accuracy*100:.2f}%)")
print()

# =============================================================================
# 2. MNIST - CLASIFICACIÓN DE DÍGITOS ESCRITOS A MANO
# =============================================================================

print("=" * 70)
print("2. MNIST - CLASIFICACIÓN DE DÍGITOS")
print("=" * 70)

"""
MNIST es el "Hello World" del deep learning.
- 70,000 imágenes de dígitos escritos a mano (0-9)
- Imágenes de 28x28 píxeles en escala de grises
- 60,000 para entrenamiento, 10,000 para prueba
"""

# Cargar datos MNIST
print("Cargando dataset MNIST...")
(X_train_mnist, y_train_mnist), (X_test_mnist, y_test_mnist) = mnist.load_data()

print(f"\nDatos cargados:")
print(f"  X_train shape: {X_train_mnist.shape}")  # (60000, 28, 28)
print(f"  y_train shape: {y_train_mnist.shape}")  # (60000,)
print(f"  X_test shape: {X_test_mnist.shape}")    # (10000, 28, 28)
print(f"  y_test shape: {y_test_mnist.shape}")    # (10000,)
print()

# Visualizar algunos ejemplos
print("Visualizando ejemplos de MNIST...")
fig, axes = plt.subplots(2, 5, figsize=(12, 5))
for i, ax in enumerate(axes.flat):
    ax.imshow(X_train_mnist[i], cmap='gray')
    ax.set_title(f'Dígito: {y_train_mnist[i]}', fontsize=12)
    ax.axis('off')
plt.tight_layout()
plt.savefig('mnist_examples.png', dpi=150, bbox_inches='tight')
plt.close()
print("✓ Ejemplos guardados en 'mnist_examples.png'\n")

# Preprocesar datos
# 1. Aplanar imágenes de 28x28 a vector de 784
X_train_flat = X_train_mnist.reshape(60000, 784)
X_test_flat = X_test_mnist.reshape(10000, 784)

# 2. Normalizar píxeles a [0, 1]
X_train_flat = X_train_flat.astype('float32') / 255
X_test_flat = X_test_flat.astype('float32') / 255

# 3. Convertir etiquetas a one-hot encoding
y_train_cat = to_categorical(y_train_mnist, 10)  # 10 clases (0-9)
y_test_cat = to_categorical(y_test_mnist, 10)

print("Datos preprocesados:")
print(f"  X_train_flat shape: {X_train_flat.shape}")  # (60000, 784)
print(f"  y_train_cat shape: {y_train_cat.shape}")    # (60000, 10)
print()

print("Ejemplo de one-hot encoding:")
print(f"  Dígito: {y_train_mnist[0]}")
print(f"  One-hot: {y_train_cat[0]}")
print()

# Crear modelo para MNIST
print("Creando modelo para MNIST...")
mnist_model = models.Sequential([
    layers.Dense(512, activation='relu', input_shape=(784,)),  # Capa oculta 1
    layers.Dropout(0.2),                                       # Dropout para regularización
    layers.Dense(256, activation='relu'),                      # Capa oculta 2
    layers.Dropout(0.2),
    layers.Dense(128, activation='relu'),                      # Capa oculta 3
    layers.Dense(10, activation='softmax')                     # Capa de salida (10 clases)
])

print("\nArquitectura del modelo MNIST:")
mnist_model.summary()
print()

# Compilar
mnist_model.compile(
    optimizer='adam',
    loss='categorical_crossentropy',  # Para clasificación multiclase
    metrics=['accuracy']
)

# Callbacks
early_stopping = keras.callbacks.EarlyStopping(
    monitor='val_loss',     # Monitorear pérdida de validación
    patience=5,             # Esperar 5 épocas sin mejora
    restore_best_weights=True  # Restaurar mejores pesos
)

# Entrenar
print("Entrenando modelo MNIST...")
print("Esto puede tomar algunos minutos...\n")

mnist_history = mnist_model.fit(
    X_train_flat, y_train_cat,
    epochs=20,
    batch_size=128,
    validation_split=0.1,
    callbacks=[early_stopping],
    verbose=1
)

# Evaluar
print("\nEvaluando modelo...")
test_loss, test_accuracy = mnist_model.evaluate(X_test_flat, y_test_cat, verbose=0)
print(f"\nResultados en datos de prueba:")
print(f"  Loss: {test_loss:.4f}")
print(f"  Accuracy: {test_accuracy:.4f} ({test_accuracy*100:.2f}%)")
print()

# =============================================================================
# 3. HACER PREDICCIONES
# =============================================================================

print("=" * 70)
print("3. PREDICCIONES")
print("=" * 70)

# Predecir primeras 10 imágenes del conjunto de prueba
predictions = mnist_model.predict(X_test_flat[:10], verbose=0)

print("Predicciones para las primeras 10 imágenes de prueba:")
print("  Real | Predicción | Confianza")
for i in range(10):
    pred_class = np.argmax(predictions[i])
    confidence = predictions[i][pred_class]
    real_class = y_test_mnist[i]
    status = "✓" if pred_class == real_class else "✗"
    print(f"   {real_class}   |     {pred_class}      |  {confidence:.4f}  {status}")
print()

# Visualizar predicciones
fig, axes = plt.subplots(2, 5, figsize=(14, 6))
for i, ax in enumerate(axes.flat):
    ax.imshow(X_test_mnist[i], cmap='gray')
    pred_class = np.argmax(predictions[i])
    confidence = predictions[i][pred_class]
    real_class = y_test_mnist[i]

    color = 'green' if pred_class == real_class else 'red'
    ax.set_title(f'Real: {real_class}\nPred: {pred_class} ({confidence:.2%})',
                fontsize=10, color=color, fontweight='bold')
    ax.axis('off')

plt.tight_layout()
plt.savefig('mnist_predictions.png', dpi=150, bbox_inches='tight')
plt.close()
print("✓ Predicciones guardadas en 'mnist_predictions.png'\n")

# =============================================================================
# 4. VISUALIZAR ENTRENAMIENTO
# =============================================================================

print("=" * 70)
print("4. VISUALIZACIÓN DEL ENTRENAMIENTO")
print("=" * 70)

# Crear gráficas
fig, axes = plt.subplots(1, 2, figsize=(14, 5))

# Accuracy
ax1 = axes[0]
ax1.plot(mnist_history.history['accuracy'], label='Train Accuracy', linewidth=2)
ax1.plot(mnist_history.history['val_accuracy'], label='Validation Accuracy', linewidth=2)
ax1.set_xlabel('Época', fontsize=12)
ax1.set_ylabel('Accuracy', fontsize=12)
ax1.set_title('Accuracy durante el entrenamiento', fontsize=14, fontweight='bold')
ax1.legend()
ax1.grid(True, alpha=0.3)

# Loss
ax2 = axes[1]
ax2.plot(mnist_history.history['loss'], label='Train Loss', linewidth=2)
ax2.plot(mnist_history.history['val_loss'], label='Validation Loss', linewidth=2)
ax2.set_xlabel('Época', fontsize=12)
ax2.set_ylabel('Loss', fontsize=12)
ax2.set_title('Loss durante el entrenamiento', fontsize=14, fontweight='bold')
ax2.legend()
ax2.grid(True, alpha=0.3)

plt.tight_layout()
plt.savefig('mnist_training_history.png', dpi=150, bbox_inches='tight')
plt.close()
print("✓ Historial de entrenamiento guardado en 'mnist_training_history.png'\n")

# =============================================================================
# 5. ANÁLISIS DE ERRORES
# =============================================================================

print("=" * 70)
print("5. ANÁLISIS DE ERRORES")
print("=" * 70)

# Predecir todo el conjunto de prueba
all_predictions = mnist_model.predict(X_test_flat, verbose=0)
predicted_classes = np.argmax(all_predictions, axis=1)
actual_classes = y_test_mnist

# Encontrar errores
errors = predicted_classes != actual_classes
error_indices = np.where(errors)[0]

print(f"Total de errores: {len(error_indices)} de {len(y_test_mnist)}")
print(f"Tasa de error: {len(error_indices)/len(y_test_mnist)*100:.2f}%")
print()

# Visualizar algunos errores
if len(error_indices) > 0:
    print("Visualizando errores...")
    n_errors_to_show = min(10, len(error_indices))

    fig, axes = plt.subplots(2, 5, figsize=(14, 6))
    for i, ax in enumerate(axes.flat[:n_errors_to_show]):
        idx = error_indices[i]
        ax.imshow(X_test_mnist[idx], cmap='gray')

        pred_class = predicted_classes[idx]
        real_class = actual_classes[idx]
        confidence = all_predictions[idx][pred_class]

        ax.set_title(f'Real: {real_class}\nPredijo: {pred_class} ({confidence:.2%})',
                    fontsize=10, color='red', fontweight='bold')
        ax.axis('off')

    plt.tight_layout()
    plt.savefig('mnist_errors.png', dpi=150, bbox_inches='tight')
    plt.close()
    print("✓ Errores guardados en 'mnist_errors.png'\n")

# =============================================================================
# 6. MATRIZ DE CONFUSIÓN
# =============================================================================

print("=" * 70)
print("6. MATRIZ DE CONFUSIÓN")
print("=" * 70)

from sklearn.metrics import confusion_matrix
import seaborn as sns

# Calcular matriz de confusión
cm = confusion_matrix(actual_classes, predicted_classes)

# Visualizar
plt.figure(figsize=(10, 8))
sns.heatmap(cm, annot=True, fmt='d', cmap='Blues', cbar=True)
plt.xlabel('Predicción', fontsize=12)
plt.ylabel('Real', fontsize=12)
plt.title('Matriz de Confusión - MNIST', fontsize=14, fontweight='bold')
plt.savefig('mnist_confusion_matrix.png', dpi=150, bbox_inches='tight')
plt.close()
print("✓ Matriz de confusión guardada en 'mnist_confusion_matrix.png'\n")

# =============================================================================
# 7. GUARDAR Y CARGAR MODELO
# =============================================================================

print("=" * 70)
print("7. GUARDAR Y CARGAR MODELO")
print("=" * 70)

# Guardar modelo completo
mnist_model.save('mnist_model.h5')
print("✓ Modelo guardado como 'mnist_model.h5'")

# Guardar solo los pesos
mnist_model.save_weights('mnist_weights.h5')
print("✓ Pesos guardados como 'mnist_weights.h5'")
print()

# Cargar modelo
print("Cargando modelo guardado...")
loaded_model = keras.models.load_model('mnist_model.h5')
print("✓ Modelo cargado exitosamente")

# Verificar que funciona
test_loss_loaded, test_accuracy_loaded = loaded_model.evaluate(X_test_flat, y_test_cat, verbose=0)
print(f"\nAccuracy del modelo cargado: {test_accuracy_loaded:.4f}")
print()

# =============================================================================
# 8. RESUMEN FINAL
# =============================================================================

print("=" * 70)
print("RESUMEN FINAL")
print("=" * 70)

print("""
¡Has completado el módulo de TensorFlow/Keras!

Lo que aprendiste:
✓ Crear modelos secuenciales con Keras
✓ Capas Dense, Dropout
✓ Funciones de activación (ReLU, Sigmoid, Softmax)
✓ Optimizadores (Adam)
✓ Funciones de pérdida (Binary/Categorical Crossentropy)
✓ Callbacks (EarlyStopping)
✓ Clasificación de MNIST con >98% accuracy
✓ Visualización de resultados
✓ Análisis de errores
✓ Guardar y cargar modelos

Archivos generados:
- mnist_examples.png
- mnist_predictions.png
- mnist_training_history.png
- mnist_errors.png
- mnist_confusion_matrix.png
- mnist_model.h5
- mnist_weights.h5

Próximos pasos:
1. Redes Convolucionales (CNN) para imágenes
2. Redes Recurrentes (RNN/LSTM) para secuencias
3. Transfer Learning
4. GANs (Generative Adversarial Networks)
""")

print("=" * 70)
print("¡Felicidades! Ahora dominas las bases de Deep Learning con Keras")
print("=" * 70)
