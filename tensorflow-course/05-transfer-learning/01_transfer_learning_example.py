"""
MÓDULO 5 - EJEMPLO 1: Transfer Learning con MobileNetV2
========================================================

En este ejemplo aprenderás:
- Usar un modelo preentrenado (MobileNetV2)
- Feature extraction vs Fine-tuning
- Construir un clasificador personalizado
- Comparar resultados

Usaremos un subset de ImageNet para clasificación de flores
"""

import tensorflow as tf
import numpy as np
import matplotlib.pyplot as plt

print("=" * 70)
print("TRANSFER LEARNING CON MOBILENETV2")
print("=" * 70)
print()

# =============================================================================
# 1. PREPARAR LOS DATOS
# =============================================================================

print("1. PREPARANDO LOS DATOS")
print("-" * 70)

# Usaremos el dataset de flores de TensorFlow
import tensorflow_datasets as tfds

# Cargar dataset (descarga automática la primera vez)
dataset, info = tfds.load('tf_flowers', with_info=True, as_supervised=True)

train_dataset = dataset['train']

# Información del dataset
num_classes = info.features['label'].num_classes
class_names = info.features['label'].names

print(f"Dataset: TF Flowers")
print(f"Número de clases: {num_classes}")
print(f"Clases: {class_names}")
print()

# Configuración
IMG_SIZE = 224  # MobileNetV2 espera imágenes de 224×224
BATCH_SIZE = 32

# =============================================================================
# 2. PREPROCESAMIENTO Y AUGMENTATION
# =============================================================================

print("2. PREPROCESAMIENTO")
print("-" * 70)

def preprocess_image(image, label):
    """Redimensionar y normalizar imagen"""
    image = tf.image.resize(image, (IMG_SIZE, IMG_SIZE))
    image = image / 255.0  # Normalizar a [0, 1]
    return image, label

def augment_image(image, label):
    """Data augmentation"""
    image = tf.image.random_flip_left_right(image)
    image = tf.image.random_brightness(image, 0.2)
    image = tf.image.random_contrast(image, 0.8, 1.2)
    return image, label

# Dividir en train y validation (80/20)
train_size = int(0.8 * info.splits['train'].num_examples)
val_size = info.splits['train'].num_examples - train_size

train_data = (train_dataset
              .map(preprocess_image)
              .map(augment_image)
              .shuffle(1000)
              .batch(BATCH_SIZE)
              .prefetch(tf.data.AUTOTUNE))

val_data = (train_dataset
            .skip(train_size)
            .map(preprocess_image)
            .batch(BATCH_SIZE)
            .prefetch(tf.data.AUTOTUNE))

print(f"Train samples: ~{train_size}")
print(f"Val samples: ~{val_size}")
print()

# =============================================================================
# 3. CARGAR MODELO PREENTRENADO
# =============================================================================

print("3. CARGANDO MOBILENETV2 PREENTRENADO")
print("-" * 70)

# Cargar MobileNetV2 preentrenado en ImageNet
# include_top=False: no incluir la capa de clasificación final
# weights='imagenet': usar pesos entrenados en ImageNet
base_model = tf.keras.applications.MobileNetV2(
    include_top=False,
    weights='imagenet',
    input_shape=(IMG_SIZE, IMG_SIZE, 3)
)

# Congelar el modelo base (no entrenar sus pesos)
base_model.trainable = False

print(f"Modelo base: MobileNetV2")
print(f"Total de capas: {len(base_model.layers)}")
print(f"Parámetros del modelo base: {base_model.count_params():,}")
print(f"Modelo congelado: {not base_model.trainable}")
print()

# =============================================================================
# 4. CONSTRUIR EL MODELO CON TRANSFER LEARNING
# =============================================================================

print("4. CONSTRUYENDO EL MODELO")
print("-" * 70)

model = tf.keras.Sequential([
    # Modelo base (feature extractor)
    base_model,

    # Global Average Pooling: convierte (7, 7, 1280) → (1280,)
    tf.keras.layers.GlobalAveragePooling2D(),

    # Capa densa con regularización
    tf.keras.layers.Dense(128, activation='relu'),
    tf.keras.layers.Dropout(0.5),

    # Capa de salida
    tf.keras.layers.Dense(num_classes, activation='softmax')
])

print("Arquitectura completa:")
model.summary()
print()

# Contar parámetros
total_params = model.count_params()
trainable_params = sum([tf.keras.backend.count_params(w) for w in model.trainable_weights])
non_trainable_params = total_params - trainable_params

print(f"Total de parámetros: {total_params:,}")
print(f"  Entrenables: {trainable_params:,}")
print(f"  No entrenables: {non_trainable_params:,}")
print()

# =============================================================================
# 5. COMPILAR Y ENTRENAR (Feature Extraction)
# =============================================================================

print("5. FASE 1: FEATURE EXTRACTION")
print("-" * 70)

model.compile(
    optimizer=tf.keras.optimizers.Adam(learning_rate=0.001),
    loss='sparse_categorical_crossentropy',
    metrics=['accuracy']
)

print("Entrenando solo las capas nuevas...\n")

history = model.fit(
    train_data,
    epochs=10,
    validation_data=val_data
)

print("\n✓ Feature extraction completado!")
print()

# Resultados de feature extraction
train_acc = history.history['accuracy'][-1]
val_acc = history.history['val_accuracy'][-1]

print(f"Resultados después de feature extraction:")
print(f"  Train accuracy: {train_acc:.4f} ({train_acc*100:.2f}%)")
print(f"  Val accuracy:   {val_acc:.4f} ({val_acc*100:.2f}%)")
print()

# =============================================================================
# 6. FINE-TUNING
# =============================================================================

print("6. FASE 2: FINE-TUNING")
print("-" * 70)

# Descongelar el modelo base
base_model.trainable = True

# Congelar las primeras capas (mantener features básicos)
# MobileNetV2 tiene ~155 capas, congelamos las primeras 100
fine_tune_at = 100

for layer in base_model.layers[:fine_tune_at]:
    layer.trainable = False

print(f"Descongelando modelo base...")
print(f"Capas congeladas: {fine_tune_at}/{len(base_model.layers)}")
print(f"Capas entrenables: {len(base_model.layers) - fine_tune_at}")
print()

# Recompilar con learning rate MUY bajo
model.compile(
    optimizer=tf.keras.optimizers.Adam(learning_rate=1e-5),  # 10x más bajo
    loss='sparse_categorical_crossentropy',
    metrics=['accuracy']
)

# Contar parámetros ahora
total_params = model.count_params()
trainable_params = sum([tf.keras.backend.count_params(w) for w in model.trainable_weights])

print(f"Parámetros después de descongelar:")
print(f"  Total: {total_params:,}")
print(f"  Entrenables: {trainable_params:,}")
print()

# Entrenar con fine-tuning
print("Fine-tuning del modelo...\n")

history_fine = model.fit(
    train_data,
    epochs=10,
    validation_data=val_data
)

print("\n✓ Fine-tuning completado!")
print()

# Resultados finales
final_train_acc = history_fine.history['accuracy'][-1]
final_val_acc = history_fine.history['val_accuracy'][-1]

print(f"Resultados después de fine-tuning:")
print(f"  Train accuracy: {final_train_acc:.4f} ({final_train_acc*100:.2f}%)")
print(f"  Val accuracy:   {final_val_acc:.4f} ({final_val_acc*100:.2f}%)")
print()

print(f"Mejora con fine-tuning:")
print(f"  Train: +{(final_train_acc - train_acc)*100:.2f}%")
print(f"  Val:   +{(final_val_acc - val_acc)*100:.2f}%")
print()

# =============================================================================
# 7. VISUALIZACIÓN
# =============================================================================

print("7. VISUALIZACIÓN DE RESULTADOS")
print("-" * 70)

# Combinar historiales
epochs_feat = range(1, len(history.history['accuracy']) + 1)
epochs_fine = range(len(epochs_feat) + 1, len(epochs_feat) + len(history_fine.history['accuracy']) + 1)

fig, axes = plt.subplots(1, 2, figsize=(14, 5))

# Accuracy
axes[0].plot(epochs_feat, history.history['accuracy'], 'b-', label='Train (Feature Ext)', linewidth=2)
axes[0].plot(epochs_feat, history.history['val_accuracy'], 'b--', label='Val (Feature Ext)', linewidth=2)
axes[0].plot(epochs_fine, history_fine.history['accuracy'], 'r-', label='Train (Fine-tune)', linewidth=2)
axes[0].plot(epochs_fine, history_fine.history['val_accuracy'], 'r--', label='Val (Fine-tune)', linewidth=2)
axes[0].axvline(x=len(epochs_feat), color='gray', linestyle=':', linewidth=2)
axes[0].set_xlabel('Época')
axes[0].set_ylabel('Accuracy')
axes[0].set_title('Accuracy: Feature Extraction vs Fine-tuning')
axes[0].legend()
axes[0].grid(True, alpha=0.3)

# Loss
axes[1].plot(epochs_feat, history.history['loss'], 'b-', label='Train (Feature Ext)', linewidth=2)
axes[1].plot(epochs_feat, history.history['val_loss'], 'b--', label='Val (Feature Ext)', linewidth=2)
axes[1].plot(epochs_fine, history_fine.history['loss'], 'r-', label='Train (Fine-tune)', linewidth=2)
axes[1].plot(epochs_fine, history_fine.history['val_loss'], 'r--', label='Val (Fine-tune)', linewidth=2)
axes[1].axvline(x=len(epochs_feat), color='gray', linestyle=':', linewidth=2)
axes[1].set_xlabel('Época')
axes[1].set_ylabel('Loss')
axes[1].set_title('Loss: Feature Extraction vs Fine-tuning')
axes[1].legend()
axes[1].grid(True, alpha=0.3)

plt.tight_layout()
plt.savefig('/tmp/transfer_learning_results.png', dpi=100, bbox_inches='tight')
print("✓ Resultados guardados en: /tmp/transfer_learning_results.png")
print()

# =============================================================================
# 8. GUARDAR EL MODELO
# =============================================================================

print("8. GUARDANDO EL MODELO")
print("-" * 70)

model.save('/tmp/flower_classifier.keras')
print("✓ Modelo guardado en: /tmp/flower_classifier.keras")
print()

# =============================================================================
# 9. EJERCICIO PRÁCTICO
# =============================================================================

print("9. EJERCICIO PRÁCTICO")
print("-" * 70)
print("""
EJERCICIO: Experimenta con diferentes modelos

Prueba otros modelos preentrenados:

1. ResNet50
2. InceptionV3
3. EfficientNetB0
4. VGG16

Compara:
- Accuracy alcanzado
- Tiempo de entrenamiento
- Número de parámetros
- Memoria utilizada

¿Cuál funciona mejor para tu tarea?

Agrega tu código aquí:
""")

# TU CÓDIGO AQUÍ:
# ...

print("\n" + "=" * 70)
print("¡Excelente! Has dominado Transfer Learning")
print("Continúa con el Módulo 6: Proyectos Avanzados")
print("=" * 70)
