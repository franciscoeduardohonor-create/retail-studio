# 📚 Módulo 3: Redes Neuronales Convolucionales (CNN)

## 🎯 Objetivos del Módulo

En este módulo aprenderás:
- ✅ Qué son las CNNs y por qué son poderosas para imágenes
- ✅ Capas convolucionales y de pooling
- ✅ Arquitecturas CNN clásicas
- ✅ Data augmentation
- ✅ Técnicas de regularización
- ✅ Proyectos de visión por computadora

## 📖 ¿Qué son las CNNs?

Las **Redes Neuronales Convolucionales** (CNN) son especializadas para procesar datos con estructura de cuadrícula (como imágenes). Son extremadamente efectivas para:

- 🖼️ Clasificación de imágenes
- 🎯 Detección de objetos
- 👤 Reconocimiento facial
- 🏥 Imágenes médicas
- 🚗 Visión en vehículos autónomos

### ¿Por qué CNNs?

Las redes densas tradicionales tienen limitaciones para imágenes:
- Demasiados parámetros (una imagen 224×224×3 = 150,528 parámetros en la primera capa)
- No capturan la estructura espacial
- No son invariantes a traslación

Las CNNs resuelven esto usando:
- **Campos receptivos locales**: cada neurona mira solo una región pequeña
- **Compartición de pesos**: mismo filtro en toda la imagen
- **Jerarquía de features**: bordes → formas → objetos

## 🔧 Componentes de una CNN

### 1. Capa Convolucional (Conv2D)

Aplica filtros (kernels) que detectan patrones:

```python
tf.keras.layers.Conv2D(
    filters=32,           # Número de filtros
    kernel_size=(3, 3),   # Tamaño del filtro
    activation='relu',
    padding='same'        # 'same' o 'valid'
)
```

**Parámetros:**
- `filters`: Cantidad de filtros (detectores de patrones)
- `kernel_size`: Tamaño del filtro (típicamente 3×3 o 5×5)
- `strides`: Paso del filtro (default=1)
- `padding`:
  - `'valid'`: Sin padding (output más pequeño)
  - `'same'`: Con padding (mismo tamaño)

**Lo que detectan:**
- Primera capa: Bordes, colores, texturas
- Capas medias: Formas, patrones
- Capas finales: Objetos completos

### 2. Capa de Pooling

Reduce las dimensiones espaciales:

```python
tf.keras.layers.MaxPooling2D(
    pool_size=(2, 2),     # Tamaño de la ventana
    strides=2             # Paso (default = pool_size)
)
```

**Tipos:**
- **MaxPooling**: Toma el valor máximo
- **AveragePooling**: Toma el promedio

**Beneficios:**
- Reduce dimensionalidad
- Invarianza a pequeñas traslaciones
- Reduce overfitting

### 3. Batch Normalization

Normaliza las activaciones entre capas:

```python
tf.keras.layers.BatchNormalization()
```

**Beneficios:**
- Acelera el entrenamiento
- Permite learning rates más altos
- Reduce sensibilidad a la inicialización

### 4. Dropout

Regularización que desactiva neuronas aleatoriamente:

```python
tf.keras.layers.Dropout(0.5)  # Desactiva 50%
```

### 5. Flatten

Convierte tensor 3D a vector 1D:

```python
tf.keras.layers.Flatten()
```

## 🏗️ Arquitectura Típica de una CNN

```
Input Image (224×224×3)
    ↓
Conv2D(32, 3×3) + ReLU
    ↓
MaxPooling2D(2×2)
    ↓
Conv2D(64, 3×3) + ReLU
    ↓
MaxPooling2D(2×2)
    ↓
Conv2D(128, 3×3) + ReLU
    ↓
MaxPooling2D(2×2)
    ↓
Flatten
    ↓
Dense(128) + ReLU
    ↓
Dropout(0.5)
    ↓
Dense(num_classes) + Softmax
```

## 📂 Contenido del Módulo

### Archivos de Ejemplo

1. **01_introduccion_cnn.py** - Primera CNN simple
2. **02_cifar10_clasificacion.py** - Clasificación CIFAR-10
3. **03_data_augmentation.py** - Aumento de datos
4. **04_transfer_learning_intro.py** - Introducción a Transfer Learning
5. **05_proyecto_cats_vs_dogs.py** - Proyecto: Gatos vs Perros
6. **06_visualizacion_filtros.py** - Visualizar qué aprende la CNN

## 🎨 Data Augmentation

Técnica para aumentar artificialmente el dataset:

```python
data_augmentation = tf.keras.Sequential([
    tf.keras.layers.RandomFlip("horizontal"),
    tf.keras.layers.RandomRotation(0.2),
    tf.keras.layers.RandomZoom(0.2),
    tf.keras.layers.RandomContrast(0.2)
])
```

**Transformaciones comunes:**
- Flip horizontal/vertical
- Rotación
- Zoom
- Traslación
- Cambio de brillo/contraste
- Recorte aleatorio

## 🏆 Arquitecturas CNN Famosas

### 1. LeNet-5 (1998)
- Primera CNN exitosa
- Para reconocimiento de dígitos
- 7 capas

### 2. AlexNet (2012)
- Ganó ImageNet 2012
- 8 capas
- ReLU, Dropout, Data Augmentation

### 3. VGG16/VGG19 (2014)
- Arquitectura muy profunda (16-19 capas)
- Solo filtros 3×3
- Muy popular para transfer learning

### 4. ResNet (2015)
- Conexiones residuales (skip connections)
- Permite entrenar redes muy profundas (50, 101, 152 capas)
- Resuelve el problema del vanishing gradient

### 5. MobileNet (2017)
- Optimizada para dispositivos móviles
- Depthwise separable convolutions
- Muy eficiente

### 6. EfficientNet (2019)
- Balance óptimo entre precisión y eficiencia
- Scaling balanceado (ancho, profundidad, resolución)

## 💡 Consejos Prácticos

### Preparación de Datos
1. **Normalizar** píxeles (0-255 → 0-1 o -1-1)
2. **Redimensionar** todas las imágenes al mismo tamaño
3. **Data augmentation** para aumentar variabilidad
4. **Balance** de clases (si es necesario)

### Arquitectura
1. Comenzar simple, luego aumentar complejidad
2. Usar **padding='same'** para mantener dimensiones
3. Duplicar filtros después de cada pooling (32→64→128→256)
4. Usar **BatchNormalization** después de Conv2D
5. **Dropout** antes de las capas Dense finales

### Entrenamiento
1. Usar **callbacks**:
   - EarlyStopping
   - ModelCheckpoint
   - ReduceLROnPlateau
2. **Learning rate**: empezar con 0.001 (Adam)
3. **Batch size**: 32 o 64 típicamente
4. Monitorear overfitting (gap entre train y val)

### Regularización
1. **Data augmentation** (muy efectivo)
2. **Dropout** (0.3-0.5)
3. **L2 regularization**
4. **BatchNormalization**
5. Reducir tamaño del modelo

## 📊 Datasets del Módulo

### CIFAR-10
- 60,000 imágenes de 32×32 píxeles
- 10 clases: avión, auto, pájaro, gato, ciervo, perro, rana, caballo, barco, camión
- Incluido en Keras

### CIFAR-100
- 60,000 imágenes de 32×32 píxeles
- 100 clases
- Más desafiante que CIFAR-10

### Fashion MNIST
- 70,000 imágenes de 28×28 píxeles (escala de grises)
- 10 clases de ropa
- Reemplazo de MNIST

### Cats vs Dogs
- ~25,000 imágenes de gatos y perros
- Clasificación binaria
- Imágenes de tamaño variable

## 🎯 Métricas de Evaluación

```python
# Accuracy
accuracy = correct_predictions / total_predictions

# Precision
precision = true_positives / (true_positives + false_positives)

# Recall
recall = true_positives / (true_positives + false_negatives)

# F1-Score
f1 = 2 * (precision * recall) / (precision + recall)
```

## 🔬 Técnicas Avanzadas

### 1. Global Average Pooling
```python
tf.keras.layers.GlobalAveragePooling2D()
```
Reemplaza Flatten + Dense, reduce overfitting

### 2. Separable Convolutions
```python
tf.keras.layers.SeparableConv2D()
```
Más eficiente que Conv2D normal

### 3. 1×1 Convolutions
Cambiar número de canales sin cambiar dimensiones espaciales

## ➡️ Siguiente Paso

Después de este módulo:
**Módulo 4: Redes Neuronales Recurrentes (RNN/LSTM)**

---

**¡Comienza con `01_introduccion_cnn.py`!** 🚀
