"""
MÓDULO 3 - EJEMPLO 1: Clasificación de Imágenes con CNN (CIFAR-10)
===================================================================

En este ejemplo aprenderás:
- Construir una CNN desde cero
- Entrenar en el dataset CIFAR-10
- Usar capas convolucionales y de pooling
- Data augmentation
- Técnicas de regularización
- Visualizar resultados

CIFAR-10: 60,000 imágenes de 32×32 píxeles en 10 clases
"""

import tensorflow as tf
import numpy as np
import matplotlib.pyplot as plt

print("=" * 70)
print("CLASIFICACIÓN DE IMÁGENES CON CNN - CIFAR-10")
print("=" * 70)
print()

# =============================================================================
# 1. CARGAR Y EXPLORAR EL DATASET
# =============================================================================

print("1. CARGANDO CIFAR-10")
print("-" * 70)

# Cargar CIFAR-10 (se descarga automáticamente la primera vez)
(X_train, y_train), (X_test, y_test) = tf.keras.datasets.cifar10.load_data()

# Nombres de las clases
class_names = ['Avión', 'Auto', 'Pájaro', 'Gato', 'Ciervo',
               'Perro', 'Rana', 'Caballo', 'Barco', 'Camión']

print(f"Datos de entrenamiento:")
print(f"  X_train shape: {X_train.shape}")  # (50000, 32, 32, 3)
print(f"  y_train shape: {y_train.shape}")  # (50000, 1)
print(f"\nDatos de prueba:")
print(f"  X_test shape: {X_test.shape}")    # (10000, 32, 32, 3)
print(f"  y_test shape: {y_test.shape}")    # (10000, 1)

print(f"\nRango de píxeles: {X_train.min()} - {X_train.max()}")
print(f"Clases: {class_names}")
print()

# Distribución de clases
print("Distribución de clases:")
for i in range(10):
    count = np.sum(y_train == i)
    print(f"  {class_names[i]:10s}: {count:5d} imágenes")
print()

# =============================================================================
# 2. VISUALIZAR EJEMPLOS
# =============================================================================

print("2. VISUALIZANDO EJEMPLOS")
print("-" * 70)

# Mostrar 25 imágenes aleatorias
fig, axes = plt.subplots(5, 5, figsize=(12, 12))
axes = axes.ravel()

np.random.seed(42)
indices = np.random.choice(len(X_train), 25, replace=False)

for i, idx in enumerate(indices):
    axes[i].imshow(X_train[idx])
    axes[i].set_title(class_names[y_train[idx][0]])
    axes[i].axis('off')

plt.tight_layout()
plt.savefig('/tmp/cifar10_ejemplos.png', dpi=100, bbox_inches='tight')
print("✓ Ejemplos guardados en: /tmp/cifar10_ejemplos.png")
print()

# =============================================================================
# 3. PREPROCESAMIENTO
# =============================================================================

print("3. PREPROCESAMIENTO")
print("-" * 70)

# Normalizar píxeles a rango [0, 1]
X_train_norm = X_train.astype('float32') / 255.0
X_test_norm = X_test.astype('float32') / 255.0

print(f"Valores normalizados: {X_train_norm.min():.1f} - {X_train_norm.max():.1f}")
print()

# Convertir etiquetas a formato correcto
y_train = y_train.flatten()
y_test = y_test.flatten()

# =============================================================================
# 4. DATA AUGMENTATION
# =============================================================================

print("4. DATA AUGMENTATION")
print("-" * 70)

# Crear pipeline de data augmentation
data_augmentation = tf.keras.Sequential([
    tf.keras.layers.RandomFlip("horizontal"),
    tf.keras.layers.RandomRotation(0.1),
    tf.keras.layers.RandomZoom(0.1),
])

print("Transformaciones de data augmentation:")
print("  - Random horizontal flip")
print("  - Random rotation (±10%)")
print("  - Random zoom (±10%)")
print()

# Visualizar el efecto del data augmentation
fig, axes = plt.subplots(2, 5, figsize=(15, 6))

# Imagen original
imagen_original = X_train_norm[0:1]  # Tomar la primera imagen
axes[0, 0].imshow(imagen_original[0])
axes[0, 0].set_title('Original')
axes[0, 0].axis('off')

# Aplicar augmentation 9 veces
for i in range(9):
    imagen_aug = data_augmentation(imagen_original, training=True)
    row = (i + 1) // 5
    col = (i + 1) % 5
    axes[row, col].imshow(imagen_aug[0])
    axes[row, col].set_title(f'Augmentada {i+1}')
    axes[row, col].axis('off')

plt.tight_layout()
plt.savefig('/tmp/cifar10_augmentation.png', dpi=100, bbox_inches='tight')
print("✓ Data augmentation visualizado en: /tmp/cifar10_augmentation.png")
print()

# =============================================================================
# 5. CONSTRUIR EL MODELO CNN
# =============================================================================

print("5. CONSTRUYENDO LA CNN")
print("-" * 70)

model = tf.keras.Sequential([
    # Data augmentation (solo en entrenamiento)
    data_augmentation,

    # Bloque 1: Conv + Conv + Pool
    tf.keras.layers.Conv2D(32, (3, 3), activation='relu', padding='same',
                           input_shape=(32, 32, 3)),
    tf.keras.layers.BatchNormalization(),
    tf.keras.layers.Conv2D(32, (3, 3), activation='relu', padding='same'),
    tf.keras.layers.BatchNormalization(),
    tf.keras.layers.MaxPooling2D((2, 2)),
    tf.keras.layers.Dropout(0.2),

    # Bloque 2: Conv + Conv + Pool
    tf.keras.layers.Conv2D(64, (3, 3), activation='relu', padding='same'),
    tf.keras.layers.BatchNormalization(),
    tf.keras.layers.Conv2D(64, (3, 3), activation='relu', padding='same'),
    tf.keras.layers.BatchNormalization(),
    tf.keras.layers.MaxPooling2D((2, 2)),
    tf.keras.layers.Dropout(0.3),

    # Bloque 3: Conv + Conv + Pool
    tf.keras.layers.Conv2D(128, (3, 3), activation='relu', padding='same'),
    tf.keras.layers.BatchNormalization(),
    tf.keras.layers.Conv2D(128, (3, 3), activation='relu', padding='same'),
    tf.keras.layers.BatchNormalization(),
    tf.keras.layers.MaxPooling2D((2, 2)),
    tf.keras.layers.Dropout(0.4),

    # Capas densas finales
    tf.keras.layers.Flatten(),
    tf.keras.layers.Dense(128, activation='relu'),
    tf.keras.layers.BatchNormalization(),
    tf.keras.layers.Dropout(0.5),
    tf.keras.layers.Dense(10, activation='softmax')
])

print("Arquitectura del modelo:")
model.summary()
print()

# Contar parámetros
total_params = model.count_params()
print(f"Total de parámetros: {total_params:,}")
print()

# =============================================================================
# 6. COMPILAR EL MODELO
# =============================================================================

print("6. COMPILACIÓN")
print("-" * 70)

model.compile(
    optimizer=tf.keras.optimizers.Adam(learning_rate=0.001),
    loss='sparse_categorical_crossentropy',
    metrics=['accuracy']
)

print("Modelo compilado con:")
print("  - Optimizer: Adam (lr=0.001)")
print("  - Loss: Sparse Categorical Crossentropy")
print("  - Metrics: Accuracy")
print()

# =============================================================================
# 7. CALLBACKS
# =============================================================================

print("7. CONFIGURANDO CALLBACKS")
print("-" * 70)

# Early stopping: detener si no mejora
early_stopping = tf.keras.callbacks.EarlyStopping(
    monitor='val_loss',
    patience=10,
    restore_best_weights=True,
    verbose=1
)

# Reducir learning rate si se estanca
reduce_lr = tf.keras.callbacks.ReduceLROnPlateau(
    monitor='val_loss',
    factor=0.5,
    patience=5,
    min_lr=1e-7,
    verbose=1
)

# Guardar el mejor modelo
checkpoint = tf.keras.callbacks.ModelCheckpoint(
    '/tmp/best_cifar10_model.keras',
    monitor='val_accuracy',
    save_best_only=True,
    verbose=1
)

callbacks = [early_stopping, reduce_lr, checkpoint]

print("Callbacks configurados:")
print("  - EarlyStopping (patience=10)")
print("  - ReduceLROnPlateau (factor=0.5, patience=5)")
print("  - ModelCheckpoint")
print()

# =============================================================================
# 8. ENTRENAR EL MODELO
# =============================================================================

print("8. ENTRENAMIENTO")
print("-" * 70)
print("Entrenando la CNN (esto puede tomar varios minutos)...\n")

history = model.fit(
    X_train_norm,
    y_train,
    epochs=50,
    batch_size=64,
    validation_split=0.2,
    callbacks=callbacks,
    verbose=1
)

print("\n✓ Entrenamiento completado!")
print()

# =============================================================================
# 9. EVALUAR EL MODELO
# =============================================================================

print("9. EVALUACIÓN")
print("-" * 70)

# Evaluar en test set
test_loss, test_accuracy = model.evaluate(X_test_norm, y_test, verbose=0)

print(f"Resultados en test set:")
print(f"  Loss:     {test_loss:.4f}")
print(f"  Accuracy: {test_accuracy:.4f} ({test_accuracy*100:.2f}%)")
print()

# Comparar con train
final_train_acc = history.history['accuracy'][-1]
final_val_acc = history.history['val_accuracy'][-1]

print(f"Comparación:")
print(f"  Train accuracy:      {final_train_acc:.4f} ({final_train_acc*100:.2f}%)")
print(f"  Validation accuracy: {final_val_acc:.4f} ({final_val_acc*100:.2f}%)")
print(f"  Test accuracy:       {test_accuracy:.4f} ({test_accuracy*100:.2f}%)")
print()

# =============================================================================
# 10. PREDICCIONES Y VISUALIZACIÓN
# =============================================================================

print("10. PREDICCIONES")
print("-" * 70)

# Predecir en test set
y_pred = model.predict(X_test_norm, verbose=0)
y_pred_classes = np.argmax(y_pred, axis=1)

# Matriz de confusión
from sklearn.metrics import confusion_matrix, classification_report

conf_matrix = confusion_matrix(y_test, y_pred_classes)

print("Matriz de confusión:")
print("(Filas: reales, Columnas: predichas)\n")
print("         ", end="")
for name in class_names:
    print(f"{name[:4]:>6}", end="")
print()
for i, name in enumerate(class_names):
    print(f"{name:10s}", end="")
    for j in range(10):
        print(f"{conf_matrix[i,j]:6d}", end="")
    print()
print()

# Accuracy por clase
print("Accuracy por clase:")
for i in range(10):
    class_correct = conf_matrix[i, i]
    class_total = np.sum(conf_matrix[i, :])
    class_acc = class_correct / class_total if class_total > 0 else 0
    print(f"  {class_names[i]:10s}: {class_acc:.4f} ({class_acc*100:.2f}%)")
print()

# =============================================================================
# 11. VISUALIZAR PREDICCIONES
# =============================================================================

print("11. VISUALIZACIÓN DE PREDICCIONES")
print("-" * 70)

# Encontrar ejemplos correctos e incorrectos
aciertos = np.where(y_pred_classes == y_test)[0]
errores = np.where(y_pred_classes != y_test)[0]

fig, axes = plt.subplots(4, 5, figsize=(15, 12))
axes = axes.ravel()

# 10 aciertos
for i in range(10):
    idx = aciertos[i]
    axes[i].imshow(X_test[idx])
    pred = y_pred_classes[idx]
    real = y_test[idx]
    conf = y_pred[idx][pred] * 100
    axes[i].set_title(f'✓ {class_names[pred]}\n{conf:.0f}%', color='green')
    axes[i].axis('off')

# 10 errores
for i in range(10):
    idx = errores[i]
    axes[i+10].imshow(X_test[idx])
    pred = y_pred_classes[idx]
    real = y_test[idx]
    conf = y_pred[idx][pred] * 100
    axes[i+10].set_title(
        f'✗ Pred:{class_names[pred]}\nReal:{class_names[real]} ({conf:.0f}%)',
        color='red'
    )
    axes[i+10].axis('off')

plt.tight_layout()
plt.savefig('/tmp/cifar10_predicciones.png', dpi=100, bbox_inches='tight')
print("✓ Predicciones guardadas en: /tmp/cifar10_predicciones.png")
print()

# =============================================================================
# 12. CURVAS DE APRENDIZAJE
# =============================================================================

print("12. CURVAS DE APRENDIZAJE")
print("-" * 70)

fig, axes = plt.subplots(1, 2, figsize=(14, 5))

# Loss
axes[0].plot(history.history['loss'], label='Train Loss', linewidth=2)
axes[0].plot(history.history['val_loss'], label='Val Loss', linewidth=2)
axes[0].set_xlabel('Época')
axes[0].set_ylabel('Loss')
axes[0].set_title('Curva de Pérdida')
axes[0].legend()
axes[0].grid(True, alpha=0.3)

# Accuracy
axes[1].plot(history.history['accuracy'], label='Train Accuracy', linewidth=2)
axes[1].plot(history.history['val_accuracy'], label='Val Accuracy', linewidth=2)
axes[1].set_xlabel('Época')
axes[1].set_ylabel('Accuracy')
axes[1].set_title('Curva de Precisión')
axes[1].legend()
axes[1].grid(True, alpha=0.3)

plt.tight_layout()
plt.savefig('/tmp/cifar10_curvas.png', dpi=100, bbox_inches='tight')
print("✓ Curvas guardadas en: /tmp/cifar10_curvas.png")
print()

# =============================================================================
# 13. EJERCICIO PRÁCTICO
# =============================================================================

print("13. EJERCICIO PRÁCTICO")
print("-" * 70)
print("""
EJERCICIO: Mejorar el modelo

El modelo actual alcanza ~75-80% accuracy. ¡Intenta mejorarlo!

Ideas:
1. Añadir más capas convolucionales
2. Usar arquitecturas preentrenadas (VGG16, ResNet)
3. Ajustar hiperparámetros (learning rate, batch size)
4. Más data augmentation
5. Diferentes optimizadores (SGD con momentum)
6. Mixup o CutMix
7. Entrenar por más épocas

Meta: Alcanzar 85%+ de accuracy

Agrega tu código aquí:
""")

# TU CÓDIGO AQUÍ:
# ...

print("\n" + "=" * 70)
print("¡Excelente! Has dominado las CNNs básicas")
print("Continúa con: 02_transfer_learning.py")
print("=" * 70)
