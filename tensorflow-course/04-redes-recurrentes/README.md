# 📚 Módulo 4: Redes Neuronales Recurrentes (RNN/LSTM)

## 🎯 Objetivos del Módulo

En este módulo aprenderás:
- ✅ Qué son las RNNs y cuándo usarlas
- ✅ LSTM y GRU para secuencias largas
- ✅ Procesamiento de series temporales
- ✅ Procesamiento de lenguaje natural (NLP)
- ✅ Generación de texto
- ✅ Análisis de sentimientos

## 📖 ¿Qué son las RNNs?

Las **Redes Neuronales Recurrentes** (RNN) están diseñadas para datos secuenciales donde el orden importa:

- 📈 Series temporales (precios de acciones, clima)
- 📝 Texto y lenguaje natural
- 🎵 Música y audio
- 🎥 Video
- 🧬 Secuencias de ADN

### Diferencia con redes tradicionales

**Redes Dense/CNN**: Cada entrada es independiente
**RNN**: Mantiene "memoria" de entradas anteriores

```
Entrada:  [x₁] → [x₂] → [x₃] → [x₄]
          ↓      ↓      ↓      ↓
Estado:  [h₁] → [h₂] → [h₃] → [h₄]
          ↓      ↓      ↓      ↓
Salida:  [y₁]   [y₂]   [y₃]   [y₄]
```

## 🔧 Tipos de RNNs

### 1. RNN Simple (SimpleRNN)

```python
tf.keras.layers.SimpleRNN(
    units=64,           # Número de unidades
    return_sequences=True  # Retornar toda la secuencia
)
```

**Problema**: Vanishing/Exploding gradients
**Solución**: LSTM y GRU

### 2. LSTM (Long Short-Term Memory)

```python
tf.keras.layers.LSTM(
    units=64,
    return_sequences=True,
    dropout=0.2
)
```

**Componentes:**
- Forget gate: Qué olvidar
- Input gate: Qué recordar
- Output gate: Qué generar
- Cell state: Memoria a largo plazo

**Ventajas:**
- Captura dependencias a largo plazo
- Evita vanishing gradient
- Más usado en la práctica

### 3. GRU (Gated Recurrent Unit)

```python
tf.keras.layers.GRU(
    units=64,
    return_sequences=True
)
```

**Características:**
- Más simple que LSTM (2 gates vs 3)
- Menos parámetros
- Entrena más rápido
- Performance similar a LSTM

### 4. Bidirectional RNN

```python
tf.keras.layers.Bidirectional(
    tf.keras.layers.LSTM(64)
)
```

Procesa la secuencia en ambas direcciones (→ y ←)

## 📊 Tipos de Tareas Secuenciales

### 1. Many-to-One
Secuencia → Un valor (Análisis de sentimientos)
```
[x₁, x₂, x₃, x₄] → [y]
```

### 2. One-to-Many
Un valor → Secuencia (Generación de imágenes)
```
[x] → [y₁, y₂, y₃, y₄]
```

### 3. Many-to-Many (mismo tamaño)
Secuencia → Secuencia (Etiquetado de secuencias)
```
[x₁, x₂, x₃, x₄] → [y₁, y₂, y₃, y₄]
```

### 4. Many-to-Many (diferente tamaño)
Secuencia → Secuencia (Traducción)
```
[x₁, x₂, x₃] → [y₁, y₂, y₃, y₄, y₅]
```

## 📂 Contenido del Módulo

### Archivos de Ejemplo

1. **01_introduccion_rnn.py** - RNN básica
2. **02_serie_temporal.py** - Predicción de series temporales
3. **03_analisis_sentimientos.py** - NLP con LSTM
4. **04_generador_texto.py** - Generación de texto
5. **05_proyecto_prediccion_acciones.py** - Proyecto: Predicción de precios

## 🔤 Procesamiento de Texto

### Tokenización

Convertir texto a números:

```python
from tensorflow.keras.preprocessing.text import Tokenizer
from tensorflow.keras.preprocessing.sequence import pad_sequences

# Crear tokenizer
tokenizer = Tokenizer(num_words=10000, oov_token="<OOV>")
tokenizer.fit_on_texts(textos)

# Convertir texto a secuencias
sequences = tokenizer.texts_to_sequences(textos)

# Padding (todas las secuencias del mismo largo)
padded = pad_sequences(sequences, maxlen=100, padding='post')
```

### Word Embeddings

Representar palabras como vectores densos:

```python
# Embedding layer
tf.keras.layers.Embedding(
    input_dim=10000,    # Tamaño del vocabulario
    output_dim=64,      # Dimensión del embedding
    input_length=100    # Longitud de las secuencias
)
```

**Embeddings preentrenados:**
- Word2Vec (Google)
- GloVe (Stanford)
- FastText (Facebook)

## 📈 Series Temporales

### Preparación de datos

```python
def create_sequences(data, seq_length):
    X, y = [], []
    for i in range(len(data) - seq_length):
        X.append(data[i:i+seq_length])
        y.append(data[i+seq_length])
    return np.array(X), np.array(y)

# Ejemplo
seq_length = 30  # Usar 30 pasos anteriores
X, y = create_sequences(data, seq_length)
```

### Normalización

```python
from sklearn.preprocessing import MinMaxScaler

scaler = MinMaxScaler()
data_scaled = scaler.fit_transform(data.reshape(-1, 1))
```

## 🏗️ Arquitecturas Típicas

### 1. Análisis de Sentimientos

```python
model = tf.keras.Sequential([
    Embedding(vocab_size, 64),
    LSTM(64, dropout=0.2),
    Dense(1, activation='sigmoid')
])
```

### 2. Predicción de Series Temporales

```python
model = tf.keras.Sequential([
    LSTM(64, return_sequences=True, input_shape=(seq_len, n_features)),
    Dropout(0.2),
    LSTM(32),
    Dense(1)
])
```

### 3. Generación de Texto

```python
model = tf.keras.Sequential([
    Embedding(vocab_size, 256),
    LSTM(512, return_sequences=True),
    Dropout(0.2),
    LSTM(512),
    Dense(vocab_size, activation='softmax')
])
```

### 4. Clasificación de Secuencias (Bidireccional)

```python
model = tf.keras.Sequential([
    Embedding(vocab_size, 128),
    Bidirectional(LSTM(64, return_sequences=True)),
    Bidirectional(LSTM(32)),
    Dense(num_classes, activation='softmax')
])
```

## 💡 Consejos Prácticos

### Datos
1. **Normalizar** series temporales
2. **Secuencias de igual longitud** (usar padding)
3. **Train/Val/Test** secuencial (no aleatorio)
4. **Stateful RNNs** para secuencias muy largas

### Arquitectura
1. Comenzar con **LSTM** (más robusto que SimpleRNN)
2. **GRU** si necesitas velocidad
3. **Bidirectional** para tareas donde el contexto futuro ayuda
4. **return_sequences=True** si apilas RNNs
5. **Dropout** para regularización

### Entrenamiento
1. **Batch size**: Potencias de 2 (32, 64, 128)
2. **Learning rate**: 0.001 (Adam) o 0.01 (SGD)
3. **Gradient clipping** si hay exploding gradients
4. **Early stopping** basado en val_loss

## 🎯 Datasets del Módulo

### IMDB Reviews
- 50,000 reseñas de películas
- Clasificación binaria (positivo/negativo)
- Incluido en Keras

### Reuters News
- 11,228 noticias
- 46 categorías
- Clasificación multiclase

### Series temporales sintéticas
- Funciones sinusoidales
- Tendencias y estacionalidad
- Datos de ejemplo

## 📊 Métricas

### Para Clasificación
- Accuracy
- Precision, Recall, F1
- AUC-ROC

### Para Regresión (Series Temporales)
- MSE (Mean Squared Error)
- MAE (Mean Absolute Error)
- RMSE (Root Mean Squared Error)
- MAPE (Mean Absolute Percentage Error)

## 🔬 Técnicas Avanzadas

### 1. Attention Mechanism
Permite al modelo "enfocarse" en partes relevantes

### 2. Encoder-Decoder
Para traducción y seq2seq

### 3. Transformers
Arquitectura moderna que reemplaza RNNs (BERT, GPT)

### 4. Teacher Forcing
Técnica de entrenamiento para generación de secuencias

## ➡️ Siguiente Paso

Después de este módulo:
**Módulo 5: Transfer Learning y Modelos Preentrenados**

---

**¡Comienza con `01_introduccion_rnn.py`!** 🚀
