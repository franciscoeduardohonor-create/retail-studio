# 📚 Módulo 5: Transfer Learning y Modelos Preentrenados

## 🎯 Objetivos del Módulo

En este módulo aprenderás:
- ✅ Qué es Transfer Learning y por qué es poderoso
- ✅ Usar modelos preentrenados de TensorFlow Hub
- ✅ Fine-tuning de modelos
- ✅ Feature extraction
- ✅ Construir clasificadores personalizados con transfer learning
- ✅ Modelos state-of-the-art

## 📖 ¿Qué es Transfer Learning?

**Transfer Learning** es usar un modelo entrenado en una tarea para resolver otra tarea relacionada.

### Analogía
Es como aprender a tocar piano después de saber tocar guitarra - muchos conceptos musicales se transfieren.

### ¿Por qué usar Transfer Learning?

**Ventajas:**
- ⚡ Entrenamiento mucho más rápido
- 📊 Requiere menos datos
- 🎯 Mejor precisión (generalmente)
- 💰 Menos recursos computacionales

**Sin Transfer Learning:**
- Entrenar desde cero: días/semanas, millones de imágenes
- Requiere GPUs potentes

**Con Transfer Learning:**
- Fine-tuning: horas, cientos/miles de imágenes
- Posible con GPUs modestas o incluso CPU

## 🔧 Dos Enfoques Principales

### 1. Feature Extraction (Extracción de Características)

Usar el modelo preentrenado como **extractor de características fijo**:

```python
# Cargar modelo preentrenado (sin la capa final)
base_model = tf.keras.applications.VGG16(
    include_top=False,
    weights='imagenet',
    input_shape=(224, 224, 3)
)

# Congelar las capas del modelo base
base_model.trainable = False

# Añadir capas personalizadas
model = tf.keras.Sequential([
    base_model,
    tf.keras.layers.GlobalAveragePooling2D(),
    tf.keras.layers.Dense(256, activation='relu'),
    tf.keras.layers.Dropout(0.5),
    tf.keras.layers.Dense(num_classes, activation='softmax')
])
```

**Cuándo usar:**
- Dataset pequeño (< 10,000 imágenes)
- Tarea similar al dataset de preentrenamiento
- Recursos limitados

### 2. Fine-Tuning (Ajuste Fino)

Descongelar y entrenar algunas capas del modelo base:

```python
# Primero: entrenar solo las capas nuevas (feature extraction)
# ...

# Luego: descongelar capas superiores del modelo base
base_model.trainable = True

# Congelar solo las primeras capas (mantener features básicos)
for layer in base_model.layers[:100]:
    layer.trainable = False

# Recompilar con learning rate bajo
model.compile(
    optimizer=tf.keras.optimizers.Adam(learning_rate=1e-5),
    loss='categorical_crossentropy',
    metrics=['accuracy']
)

# Continuar entrenamiento
model.fit(...)
```

**Cuándo usar:**
- Dataset mediano/grande (> 10,000 imágenes)
- Tarea diferente al preentrenamiento
- Recursos computacionales disponibles

## 🏆 Modelos Preentrenados Populares

### En TensorFlow/Keras

```python
from tensorflow.keras.applications import (
    VGG16, VGG19,
    ResNet50, ResNet101, ResNet152,
    InceptionV3, InceptionResNetV2,
    MobileNet, MobileNetV2, MobileNetV3,
    DenseNet121, DenseNet169, DenseNet201,
    EfficientNetB0, EfficientNetB1, EfficientNetB7,
    Xception, NASNetLarge
)
```

### Comparación de Modelos

| Modelo | Parámetros | Top-1 Accuracy | Velocidad | Tamaño |
|--------|-----------|----------------|-----------|--------|
| MobileNetV2 | 3.5M | 71.3% | Muy rápido | Pequeño |
| VGG16 | 138M | 71.3% | Lento | Grande |
| ResNet50 | 25.6M | 76.1% | Medio | Medio |
| InceptionV3 | 23.8M | 77.9% | Medio | Medio |
| EfficientNetB0 | 5.3M | 77.1% | Rápido | Pequeño |
| EfficientNetB7 | 66M | 84.3% | Lento | Grande |

### Recomendaciones

**Para dispositivos móviles:**
- MobileNetV2/V3
- EfficientNetB0/B1

**Para máxima precisión:**
- EfficientNetB7
- ResNet152
- InceptionResNetV2

**Balance precisión/velocidad:**
- ResNet50
- EfficientNetB3
- InceptionV3

## 📂 Contenido del Módulo

### Archivos de Ejemplo

1. **01_feature_extraction.py** - Extracción de características con VGG16
2. **02_fine_tuning.py** - Fine-tuning de ResNet50
3. **03_tensorflow_hub.py** - Usar modelos de TensorFlow Hub
4. **04_clasificador_personalizado.py** - Clasificador de imágenes personalizado
5. **05_proyecto_clasificacion_medica.py** - Proyecto: Clasificación de imágenes médicas

## 🎨 Preprocesamiento según el Modelo

**Importante:** Cada modelo requiere preprocesamiento específico:

```python
# VGG16/VGG19
from tensorflow.keras.applications.vgg16 import preprocess_input
preprocessed = preprocess_input(images)

# ResNet
from tensorflow.keras.applications.resnet50 import preprocess_input
preprocessed = preprocess_input(images)

# MobileNet
from tensorflow.keras.applications.mobilenet import preprocess_input
preprocessed = preprocess_input(images)

# Genérico (funciona para la mayoría)
preprocessed = images / 255.0  # Normalizar a [0, 1]
```

## 🔄 Proceso Típico de Transfer Learning

### Paso 1: Preparar los datos
```python
# Redimensionar imágenes al tamaño esperado
IMG_SIZE = (224, 224)

# Data augmentation
data_augmentation = tf.keras.Sequential([
    tf.keras.layers.RandomFlip("horizontal"),
    tf.keras.layers.RandomRotation(0.2),
    tf.keras.layers.RandomZoom(0.2),
])
```

### Paso 2: Cargar modelo preentrenado
```python
base_model = tf.keras.applications.ResNet50(
    include_top=False,
    weights='imagenet',
    input_shape=(224, 224, 3)
)
base_model.trainable = False
```

### Paso 3: Añadir capas personalizadas
```python
model = tf.keras.Sequential([
    data_augmentation,
    base_model,
    tf.keras.layers.GlobalAveragePooling2D(),
    tf.keras.layers.Dense(512, activation='relu'),
    tf.keras.layers.Dropout(0.5),
    tf.keras.layers.Dense(num_classes, activation='softmax')
])
```

### Paso 4: Entrenar (feature extraction)
```python
model.compile(
    optimizer='adam',
    loss='categorical_crossentropy',
    metrics=['accuracy']
)

history = model.fit(train_data, epochs=10, validation_data=val_data)
```

### Paso 5: Fine-tuning (opcional)
```python
base_model.trainable = True

# Congelar primeras capas
for layer in base_model.layers[:100]:
    layer.trainable = False

# Learning rate bajo
model.compile(
    optimizer=tf.keras.optimizers.Adam(1e-5),
    loss='categorical_crossentropy',
    metrics=['accuracy']
)

history_fine = model.fit(train_data, epochs=10, validation_data=val_data)
```

## 📊 TensorFlow Hub

**TensorFlow Hub** es un repositorio de modelos preentrenados:

```python
import tensorflow_hub as hub

# Cargar modelo desde TF Hub
feature_extractor = hub.KerasLayer(
    "https://tfhub.dev/google/imagenet/mobilenet_v2_100_224/feature_vector/5",
    input_shape=(224, 224, 3),
    trainable=False
)

# Construir modelo
model = tf.keras.Sequential([
    feature_extractor,
    tf.keras.layers.Dense(num_classes, activation='softmax')
])
```

**Ventajas de TF Hub:**
- Modelos optimizados
- Múltiples versiones
- Incluye preprocesamiento
- Fácil de usar

## 💡 Mejores Prácticas

### 1. Learning Rate

**Feature Extraction:**
- Learning rate normal: 0.001 (Adam)

**Fine-Tuning:**
- Learning rate muy bajo: 1e-5 o 1e-6
- Evita destruir los pesos preentrenados

### 2. Congelar Capas

**Regla general:**
- Congelar capas iniciales (features generales)
- Entrenar capas finales (features específicos)

```python
# Ver qué capas congelar
for i, layer in enumerate(base_model.layers):
    print(f"Layer {i}: {layer.name}")

# Congelar primeras 100 capas
for layer in base_model.layers[:100]:
    layer.trainable = False
```

### 3. Data Augmentation

```python
data_augmentation = tf.keras.Sequential([
    tf.keras.layers.RandomFlip("horizontal"),
    tf.keras.layers.RandomRotation(0.1),
    tf.keras.layers.RandomZoom(0.1),
    tf.keras.layers.RandomContrast(0.1),
])
```

### 4. Regularización

- Usar **Dropout** (0.3-0.5)
- Usar **L2 regularization**
- **BatchNormalization** si es necesario

### 5. Callbacks

```python
callbacks = [
    tf.keras.callbacks.EarlyStopping(patience=5),
    tf.keras.callbacks.ReduceLROnPlateau(factor=0.5, patience=3),
    tf.keras.callbacks.ModelCheckpoint('best_model.keras', save_best_only=True)
]
```

## 🎯 Casos de Uso Reales

### 1. Clasificación de Imágenes Médicas
- Rayos X
- Resonancias magnéticas
- Detección de tumores

### 2. Clasificación de Productos
- E-commerce
- Control de calidad
- Inventario automático

### 3. Reconocimiento Facial
- Seguridad
- Autenticación
- Organización de fotos

### 4. Agricultura
- Detección de enfermedades en plantas
- Clasificación de cultivos
- Estimación de rendimiento

### 5. Fauna Silvestre
- Identificación de especies
- Conservación
- Monitoreo de población

## 🔬 Técnicas Avanzadas

### 1. Multi-task Learning
Entrenar un modelo para múltiples tareas simultáneamente

### 2. Domain Adaptation
Adaptar un modelo de un dominio a otro

### 3. Few-shot Learning
Aprender con muy pocos ejemplos

### 4. Knowledge Distillation
Transferir conocimiento de un modelo grande a uno pequeño

## ➡️ Siguiente Paso

Después de este módulo:
**Módulo 6: Proyectos Avanzados**

---

**¡Comienza con `01_feature_extraction.py`!** 🚀
