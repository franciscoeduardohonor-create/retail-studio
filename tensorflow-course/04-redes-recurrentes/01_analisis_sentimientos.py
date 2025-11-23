"""
MÓDULO 4 - EJEMPLO 1: Análisis de Sentimientos con LSTM
========================================================

En este ejemplo aprenderás:
- Procesamiento de texto para NLP
- Tokenización y word embeddings
- Construir un modelo LSTM
- Clasificación de sentimientos (positivo/negativo)
- Evaluar modelos de NLP

Dataset: IMDB Movie Reviews (50,000 reseñas de películas)
"""

import tensorflow as tf
import numpy as np
import matplotlib.pyplot as plt
from tensorflow.keras.preprocessing.sequence import pad_sequences

print("=" * 70)
print("ANÁLISIS DE SENTIMIENTOS CON LSTM - IMDB REVIEWS")
print("=" * 70)
print()

# =============================================================================
# 1. CARGAR EL DATASET
# =============================================================================

print("1. CARGANDO DATASET IMDB")
print("-" * 70)

# IMDB viene con vocabulario limitado a las 10,000 palabras más frecuentes
vocab_size = 10000
max_length = 200  # Longitud máxima de cada reseña

(X_train, y_train), (X_test, y_test) = tf.keras.datasets.imdb.load_data(
    num_words=vocab_size
)

print(f"Datos de entrenamiento:")
print(f"  X_train: {len(X_train)} reseñas")
print(f"  y_train: {len(y_train)} etiquetas")
print(f"\nDatos de prueba:")
print(f"  X_test: {len(X_test)} reseñas")
print(f"  y_test: {len(y_test)} etiquetas")
print()

# Distribución de clases
print(f"Distribución de sentimientos:")
print(f"  Positivo (1): {np.sum(y_train == 1)} ({np.sum(y_train == 1)/len(y_train)*100:.1f}%)")
print(f"  Negativo (0): {np.sum(y_train == 0)} ({np.sum(y_train == 0)/len(y_train)*100:.1f}%)")
print()

# =============================================================================
# 2. EXPLORAR LOS DATOS
# =============================================================================

print("2. EXPLORANDO LOS DATOS")
print("-" * 70)

# Ver longitud de las reseñas
longitudes = [len(x) for x in X_train]
print(f"Longitud de las reseñas:")
print(f"  Mínima:  {min(longitudes)} palabras")
print(f"  Máxima:  {max(longitudes)} palabras")
print(f"  Media:   {np.mean(longitudes):.1f} palabras")
print(f"  Mediana: {np.median(longitudes):.1f} palabras")
print()

# Ver ejemplos (están en formato numérico)
print("Ejemplo de reseña (primeras 20 palabras):")
print(f"Secuencia: {X_train[0][:20]}...")
print(f"Etiqueta: {y_train[0]} ({'Positivo' if y_train[0] == 1 else 'Negativo'})")
print()

# Decodificar una reseña (convertir números a palabras)
word_index = tf.keras.datasets.imdb.get_word_index()
reverse_word_index = {value: key for key, value in word_index.items()}

def decode_review(encoded_review):
    # Los índices están offset por 3 (0=padding, 1=start, 2=unknown)
    return ' '.join([reverse_word_index.get(i - 3, '?') for i in encoded_review])

print("Reseña decodificada (primera):")
decoded = decode_review(X_train[0])
print(f"{decoded[:500]}...")  # Primeros 500 caracteres
print(f"Sentimiento: {'Positivo' if y_train[0] == 1 else 'Negativo'}")
print()

# =============================================================================
# 3. PREPROCESAMIENTO
# =============================================================================

print("3. PREPROCESAMIENTO")
print("-" * 70)

# Padding: hacer que todas las reseñas tengan la misma longitud
# - Si es más corta: agregar ceros (padding)
# - Si es más larga: truncar

X_train_padded = pad_sequences(X_train, maxlen=max_length, padding='post', truncating='post')
X_test_padded = pad_sequences(X_test, maxlen=max_length, padding='post', truncating='post')

print(f"Después del padding:")
print(f"  X_train shape: {X_train_padded.shape}")  # (25000, 200)
print(f"  X_test shape:  {X_test_padded.shape}")   # (25000, 200)
print()

print("Ejemplo después del padding:")
print(f"Original length: {len(X_train[1])}")
print(f"Padded length:   {len(X_train_padded[1])}")
print(f"Primeras 30 palabras: {X_train_padded[1][:30]}")
print(f"Últimas 10 palabras:  {X_train_padded[1][-10:]} (padding)")
print()

# =============================================================================
# 4. CONSTRUIR EL MODELO LSTM
# =============================================================================

print("4. CONSTRUYENDO EL MODELO LSTM")
print("-" * 70)

# Modelo con Embedding + LSTM
model = tf.keras.Sequential([
    # Embedding: convierte índices de palabras a vectores densos
    # vocab_size: tamaño del vocabulario
    # 128: dimensión del embedding (cada palabra = vector de 128 números)
    tf.keras.layers.Embedding(vocab_size, 128, input_length=max_length),

    # LSTM: procesa la secuencia de embeddings
    # 64: número de unidades LSTM
    # dropout: desactiva neuronas aleatoriamente (regularización)
    # recurrent_dropout: dropout en las conexiones recurrentes
    tf.keras.layers.LSTM(64, dropout=0.2, recurrent_dropout=0.2),

    # Dense: capa de salida
    # 1 neurona con sigmoid para clasificación binaria
    tf.keras.layers.Dense(1, activation='sigmoid')
])

print("Arquitectura del modelo:")
model.summary()
print()

total_params = model.count_params()
print(f"Total de parámetros: {total_params:,}")
print()

# =============================================================================
# 5. COMPILAR EL MODELO
# =============================================================================

print("5. COMPILACIÓN")
print("-" * 70)

model.compile(
    optimizer='adam',
    loss='binary_crossentropy',
    metrics=['accuracy', tf.keras.metrics.AUC(name='auc')]
)

print("Modelo compilado con:")
print("  - Optimizer: Adam")
print("  - Loss: Binary Crossentropy")
print("  - Metrics: Accuracy, AUC")
print()

# =============================================================================
# 6. ENTRENAR EL MODELO
# =============================================================================

print("6. ENTRENAMIENTO")
print("-" * 70)

# Callbacks
early_stopping = tf.keras.callbacks.EarlyStopping(
    monitor='val_loss',
    patience=3,
    restore_best_weights=True
)

print("Entrenando el modelo...\n")

history = model.fit(
    X_train_padded,
    y_train,
    epochs=10,
    batch_size=128,
    validation_split=0.2,
    callbacks=[early_stopping],
    verbose=1
)

print("\n✓ Entrenamiento completado!")
print()

# =============================================================================
# 7. EVALUAR EL MODELO
# =============================================================================

print("7. EVALUACIÓN")
print("-" * 70)

# Evaluar en test set
test_loss, test_accuracy, test_auc = model.evaluate(X_test_padded, y_test, verbose=0)

print(f"Resultados en test set:")
print(f"  Loss:     {test_loss:.4f}")
print(f"  Accuracy: {test_accuracy:.4f} ({test_accuracy*100:.2f}%)")
print(f"  AUC:      {test_auc:.4f}")
print()

# =============================================================================
# 8. HACER PREDICCIONES
# =============================================================================

print("8. PREDICCIONES")
print("-" * 70)

# Predecir en los primeros 5 ejemplos del test
predicciones = model.predict(X_test_padded[:5], verbose=0)

print("Ejemplos de predicción:\n")
for i in range(5):
    prob = predicciones[i][0]
    pred_label = 1 if prob > 0.5 else 0
    real_label = y_test[i]

    print(f"Reseña {i+1}:")
    print(f"  Texto: {decode_review(X_test[i])[:200]}...")
    print(f"  Probabilidad positivo: {prob:.4f}")
    print(f"  Predicción: {'Positivo' if pred_label == 1 else 'Negativo'}")
    print(f"  Real:       {'Positivo' if real_label == 1 else 'Negativo'}")
    print(f"  ¿Correcta? {'✓' if pred_label == real_label else '✗'}")
    print()

# =============================================================================
# 9. MATRIZ DE CONFUSIÓN Y MÉTRICAS
# =============================================================================

print("9. MÉTRICAS DETALLADAS")
print("-" * 70)

# Predecir todo el test set
y_pred_prob = model.predict(X_test_padded, verbose=0)
y_pred = (y_pred_prob > 0.5).astype(int).flatten()

# Matriz de confusión
from sklearn.metrics import confusion_matrix, classification_report

conf_matrix = confusion_matrix(y_test, y_pred)

print("Matriz de confusión:")
print("              Predicho")
print("              Neg  Pos")
print(f"Real  Neg   {conf_matrix[0,0]:5d} {conf_matrix[0,1]:5d}")
print(f"      Pos   {conf_matrix[1,0]:5d} {conf_matrix[1,1]:5d}")
print()

# Calcular métricas
tn, fp, fn, tp = conf_matrix.ravel()
precision = tp / (tp + fp)
recall = tp / (tp + fn)
f1 = 2 * (precision * recall) / (precision + recall)

print("Métricas:")
print(f"  True Positives:  {tp}")
print(f"  True Negatives:  {tn}")
print(f"  False Positives: {fp}")
print(f"  False Negatives: {fn}")
print(f"\n  Precision: {precision:.4f}")
print(f"  Recall:    {recall:.4f}")
print(f"  F1-Score:  {f1:.4f}")
print()

# =============================================================================
# 10. VISUALIZACIÓN
# =============================================================================

print("10. VISUALIZACIÓN")
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
plt.savefig('/tmp/sentiment_curves.png', dpi=100, bbox_inches='tight')
print("✓ Curvas guardadas en: /tmp/sentiment_curves.png")
print()

# =============================================================================
# 11. PREDECIR CON TEXTO NUEVO
# =============================================================================

print("11. PREDICCIÓN CON TEXTO NUEVO")
print("-" * 70)

def predecir_sentimiento(texto):
    # Tokenizar el texto nuevo usando el vocabulario de IMDB
    # (Nota: esto es simplificado; en producción usarías el tokenizer entrenado)
    palabras = texto.lower().split()
    secuencia = []

    for palabra in palabras:
        if palabra in word_index:
            idx = word_index[palabra]
            if idx < vocab_size:  # Solo palabras en el vocabulario
                secuencia.append(idx + 3)  # +3 por el offset

    # Padding
    secuencia_padded = pad_sequences([secuencia], maxlen=max_length, padding='post')

    # Predecir
    prob = model.predict(secuencia_padded, verbose=0)[0][0]

    return prob

# Ejemplos de texto nuevo
textos_prueba = [
    "This movie was absolutely amazing! Great acting and wonderful story.",
    "Terrible film. Waste of time and money. Very disappointing.",
    "It was okay, nothing special but not bad either.",
    "Best movie I've ever seen! Absolutely loved it!",
    "Boring and predictable. Would not recommend."
]

print("Predicciones en textos nuevos:\n")
for texto in textos_prueba:
    prob = predecir_sentimiento(texto)
    sentimiento = "Positivo" if prob > 0.5 else "Negativo"
    print(f"Texto: {texto}")
    print(f"Sentimiento: {sentimiento} (confianza: {abs(prob-0.5)*200:.1f}%)")
    print()

# =============================================================================
# 12. EJERCICIO PRÁCTICO
# =============================================================================

print("12. EJERCICIO PRÁCTICO")
print("-" * 70)
print("""
EJERCICIO: Mejorar el modelo

Ideas para experimentar:
1. Usar Bidirectional LSTM
2. Apilar múltiples capas LSTM
3. Usar GRU en lugar de LSTM
4. Ajustar el tamaño del embedding (64, 256, etc.)
5. Cambiar max_length (100, 300, etc.)
6. Usar embeddings preentrenados (Word2Vec, GloVe)
7. Añadir capas Dense adicionales

BONUS: Prueba con otros datasets de texto

Agrega tu código aquí:
""")

# TU CÓDIGO AQUÍ:
# ...

print("\n" + "=" * 70)
print("¡Excelente! Has dominado el análisis de sentimientos con LSTM")
print("Continúa con: 02_serie_temporal.py")
print("=" * 70)
