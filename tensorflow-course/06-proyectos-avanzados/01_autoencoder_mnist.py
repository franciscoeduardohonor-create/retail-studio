"""
MÓDULO 6 - EJEMPLO 1: Autoencoder para Compresión y Denoising
==============================================================

En este ejemplo aprenderás:
- Construir un autoencoder desde cero
- Comprimir imágenes a dimensiones bajas
- Reconstruir imágenes
- Denoising (eliminar ruido)
- Visualizar el latent space

Dataset: MNIST
"""

import tensorflow as tf
import numpy as np
import matplotlib.pyplot as plt

print("=" * 70)
print("AUTOENCODER PARA MNIST - COMPRESIÓN Y DENOISING")
print("=" * 70)
print()

# =============================================================================
# 1. CARGAR Y PREPARAR DATOS
# =============================================================================

print("1. CARGANDO DATOS")
print("-" * 70)

(X_train, y_train), (X_test, y_test) = tf.keras.datasets.mnist.load_data()

# Normalizar a [0, 1]
X_train = X_train.astype('float32') / 255.0
X_test = X_test.astype('float32') / 255.0

# Aplanar imágenes: 28×28 → 784
X_train_flat = X_train.reshape(-1, 784)
X_test_flat = X_test.reshape(-1, 784)

print(f"Train: {X_train_flat.shape}")
print(f"Test:  {X_test_flat.shape}")
print()

# =============================================================================
# 2. CONSTRUIR AUTOENCODER
# =============================================================================

print("2. CONSTRUYENDO AUTOENCODER")
print("-" * 70)

# Dimensión del latent space (código comprimido)
latent_dim = 32  # Comprimir de 784 a 32 (24.5x compresión!)

# ENCODER: 784 → 128 → 64 → 32
encoder = tf.keras.Sequential([
    tf.keras.layers.Dense(128, activation='relu', input_shape=(784,)),
    tf.keras.layers.Dense(64, activation='relu'),
    tf.keras.layers.Dense(latent_dim, activation='relu', name='latent')
])

# DECODER: 32 → 64 → 128 → 784
decoder = tf.keras.Sequential([
    tf.keras.layers.Dense(64, activation='relu', input_shape=(latent_dim,)),
    tf.keras.layers.Dense(128, activation='relu'),
    tf.keras.layers.Dense(784, activation='sigmoid')
])

# AUTOENCODER COMPLETO
autoencoder = tf.keras.Sequential([encoder, decoder])

print("Arquitectura del Autoencoder:")
autoencoder.summary()
print()

print(f"Compresión: 784 → {latent_dim} ({784/latent_dim:.1f}x)")
print()

# =============================================================================
# 3. COMPILAR Y ENTRENAR
# =============================================================================

print("3. ENTRENAMIENTO")
print("-" * 70)

autoencoder.compile(
    optimizer='adam',
    loss='binary_crossentropy',
    metrics=['mae']
)

print("Entrenando autoencoder...\n")

history = autoencoder.fit(
    X_train_flat,
    X_train_flat,  # ¡Input = Output! (reconstrucción)
    epochs=20,
    batch_size=256,
    validation_data=(X_test_flat, X_test_flat),
    verbose=1
)

print("\n✓ Entrenamiento completado!")
print()

# =============================================================================
# 4. EVALUAR RECONSTRUCCIÓN
# =============================================================================

print("4. EVALUACIÓN")
print("-" * 70)

# Reconstruir imágenes del test set
reconstructed = autoencoder.predict(X_test_flat[:10], verbose=0)

# Calcular error de reconstrucción
reconstruction_error = np.mean(np.abs(X_test_flat[:10] - reconstructed))
print(f"Error de reconstrucción promedio: {reconstruction_error:.4f}")
print()

# Visualizar originales vs reconstrucciones
fig, axes = plt.subplots(2, 10, figsize=(15, 3))

for i in range(10):
    # Original
    axes[0, i].imshow(X_test[i], cmap='gray')
    axes[0, i].axis('off')
    if i == 0:
        axes[0, i].set_title('Original', fontsize=10)

    # Reconstrucción
    axes[1, i].imshow(reconstructed[i].reshape(28, 28), cmap='gray')
    axes[1, i].axis('off')
    if i == 0:
        axes[1, i].set_title('Reconstrucción', fontsize=10)

plt.tight_layout()
plt.savefig('/tmp/autoencoder_reconstruction.png', dpi=100, bbox_inches='tight')
print("✓ Reconstrucciones guardadas en: /tmp/autoencoder_reconstruction.png")
print()

# =============================================================================
# 5. VISUALIZAR LATENT SPACE
# =============================================================================

print("5. LATENT SPACE")
print("-" * 70)

# Codificar todas las imágenes del test set
latent_representations = encoder.predict(X_test_flat, verbose=0)

print(f"Latent space shape: {latent_representations.shape}")
print(f"Cada imagen está representada por {latent_dim} números")
print()

# Reducir a 2D para visualización (usando las primeras 2 dimensiones)
if latent_dim >= 2:
    plt.figure(figsize=(10, 8))
    scatter = plt.scatter(
        latent_representations[:, 0],
        latent_representations[:, 1],
        c=y_test,
        cmap='tab10',
        alpha=0.5
    )
    plt.colorbar(scatter, label='Dígito')
    plt.xlabel('Latent Dimension 1')
    plt.ylabel('Latent Dimension 2')
    plt.title('Latent Space Visualization (2D projection)')
    plt.grid(True, alpha=0.3)
    plt.savefig('/tmp/autoencoder_latent.png', dpi=100, bbox_inches='tight')
    print("✓ Latent space guardado en: /tmp/autoencoder_latent.png")
    print()

# =============================================================================
# 6. DENOISING AUTOENCODER
# =============================================================================

print("6. DENOISING AUTOENCODER")
print("-" * 70)

# Añadir ruido a las imágenes
noise_factor = 0.5
X_train_noisy = X_train_flat + noise_factor * np.random.normal(size=X_train_flat.shape)
X_test_noisy = X_test_flat + noise_factor * np.random.normal(size=X_test_flat.shape)

# Clip valores a [0, 1]
X_train_noisy = np.clip(X_train_noisy, 0.0, 1.0)
X_test_noisy = np.clip(X_test_noisy, 0.0, 1.0)

print("Entrenando denoising autoencoder...\n")

# Nuevo autoencoder para denoising
denoising_autoencoder = tf.keras.Sequential([
    tf.keras.layers.Dense(128, activation='relu', input_shape=(784,)),
    tf.keras.layers.Dense(64, activation='relu'),
    tf.keras.layers.Dense(32, activation='relu'),
    tf.keras.layers.Dense(64, activation='relu'),
    tf.keras.layers.Dense(128, activation='relu'),
    tf.keras.layers.Dense(784, activation='sigmoid')
])

denoising_autoencoder.compile(
    optimizer='adam',
    loss='binary_crossentropy'
)

history_denoise = denoising_autoencoder.fit(
    X_train_noisy,    # Input: imágenes con ruido
    X_train_flat,     # Output: imágenes limpias
    epochs=20,
    batch_size=256,
    validation_data=(X_test_noisy, X_test_flat),
    verbose=0
)

print("✓ Denoising autoencoder entrenado!")
print()

# Limpiar imágenes ruidosas
denoised = denoising_autoencoder.predict(X_test_noisy[:10], verbose=0)

# Visualizar: ruidoso → limpio
fig, axes = plt.subplots(3, 10, figsize=(15, 5))

for i in range(10):
    # Original
    axes[0, i].imshow(X_test[i], cmap='gray')
    axes[0, i].axis('off')
    if i == 0:
        axes[0, i].set_title('Original', fontsize=10)

    # Con ruido
    axes[1, i].imshow(X_test_noisy[i].reshape(28, 28), cmap='gray')
    axes[1, i].axis('off')
    if i == 0:
        axes[1, i].set_title('Ruidoso', fontsize=10)

    # Limpio
    axes[2, i].imshow(denoised[i].reshape(28, 28), cmap='gray')
    axes[2, i].axis('off')
    if i == 0:
        axes[2, i].set_title('Denoised', fontsize=10)

plt.tight_layout()
plt.savefig('/tmp/autoencoder_denoising.png', dpi=100, bbox_inches='tight')
print("✓ Denoising guardado en: /tmp/autoencoder_denoising.png")
print()

# =============================================================================
# 7. GENERAR IMÁGENES (INTERPOLACIÓN)
# =============================================================================

print("7. GENERACIÓN E INTERPOLACIÓN")
print("-" * 70)

# Tomar dos dígitos y hacer interpolación en el latent space
idx1, idx2 = 0, 5  # Primer y sexto dígito del test set

# Codificar ambas imágenes
z1 = encoder.predict(X_test_flat[idx1:idx1+1], verbose=0)
z2 = encoder.predict(X_test_flat[idx2:idx2+1], verbose=0)

# Interpolar entre z1 y z2
n_steps = 10
interpolations = []

for alpha in np.linspace(0, 1, n_steps):
    z_interpolated = (1 - alpha) * z1 + alpha * z2
    img_interpolated = decoder.predict(z_interpolated, verbose=0)
    interpolations.append(img_interpolated)

# Visualizar interpolación
fig, axes = plt.subplots(1, n_steps, figsize=(15, 2))

for i in range(n_steps):
    axes[i].imshow(interpolations[i].reshape(28, 28), cmap='gray')
    axes[i].axis('off')
    if i == 0:
        axes[i].set_title(f'Dígito {y_test[idx1]}', fontsize=10)
    elif i == n_steps - 1:
        axes[i].set_title(f'Dígito {y_test[idx2]}', fontsize=10)

plt.suptitle('Interpolación en Latent Space')
plt.tight_layout()
plt.savefig('/tmp/autoencoder_interpolation.png', dpi=100, bbox_inches='tight')
print("✓ Interpolación guardada en: /tmp/autoencoder_interpolation.png")
print()

# =============================================================================
# 8. CURVAS DE APRENDIZAJE
# =============================================================================

print("8. CURVAS DE APRENDIZAJE")
print("-" * 70)

fig, axes = plt.subplots(1, 2, figsize=(14, 5))

# Autoencoder normal
axes[0].plot(history.history['loss'], label='Train Loss', linewidth=2)
axes[0].plot(history.history['val_loss'], label='Val Loss', linewidth=2)
axes[0].set_xlabel('Época')
axes[0].set_ylabel('Loss')
axes[0].set_title('Autoencoder - Loss')
axes[0].legend()
axes[0].grid(True, alpha=0.3)

# Denoising autoencoder
axes[1].plot(history_denoise.history['loss'], label='Train Loss', linewidth=2)
axes[1].plot(history_denoise.history['val_loss'], label='Val Loss', linewidth=2)
axes[1].set_xlabel('Época')
axes[1].set_ylabel('Loss')
axes[1].set_title('Denoising Autoencoder - Loss')
axes[1].legend()
axes[1].grid(True, alpha=0.3)

plt.tight_layout()
plt.savefig('/tmp/autoencoder_curves.png', dpi=100, bbox_inches='tight')
print("✓ Curvas guardadas en: /tmp/autoencoder_curves.png")
print()

# =============================================================================
# 9. APLICACIONES PRÁCTICAS
# =============================================================================

print("9. APLICACIONES DE AUTOENCODERS")
print("-" * 70)
print("""
Los Autoencoders tienen muchas aplicaciones:

1. **Compresión de datos**
   - Reducir tamaño de archivos
   - Almacenamiento eficiente

2. **Denoising (eliminación de ruido)**
   - Limpiar imágenes
   - Mejorar calidad de audio

3. **Detección de anomalías**
   - Detectar fraudes
   - Identificar defectos de manufactura

4. **Reducción de dimensionalidad**
   - Alternativa a PCA
   - Visualización de datos

5. **Generación de datos**
   - Variational Autoencoders (VAE)
   - Generar nuevas muestras

6. **Pre-entrenamiento**
   - Aprender representaciones
   - Transfer learning
""")

# =============================================================================
# 10. EJERCICIO PRÁCTICO
# =============================================================================

print("10. EJERCICIO PRÁCTICO")
print("-" * 70)
print("""
EJERCICIO: Mejora el Autoencoder

Ideas para experimentar:

1. **Convolutional Autoencoder**
   - Usa Conv2D en lugar de Dense
   - Mantiene estructura espacial

2. **Variational Autoencoder (VAE)**
   - Genera distribuciones en lugar de puntos
   - Mejor para generación

3. **Diferentes latent dimensions**
   - Prueba 16, 64, 128
   - ¿Cómo afecta la reconstrucción?

4. **Regularización**
   - Añade Dropout
   - L2 regularization

5. **Otros datasets**
   - Fashion MNIST
   - CIFAR-10 (requiere Conv2D)

Agrega tu código aquí:
""")

# TU CÓDIGO AQUÍ:
# ...

print("\n" + "=" * 70)
print("¡Felicidades! Has completado el curso de TensorFlow")
print("Ahora tienes las habilidades para crear proyectos increíbles de ML/DL")
print("=" * 70)
