# 📚 Módulo 6: Proyectos Avanzados

## 🎯 Objetivos del Módulo

En este módulo aprenderás:
- ✅ Generative Adversarial Networks (GANs)
- ✅ Autoencoders y Variational Autoencoders (VAE)
- ✅ Modelos de atención y Transformers
- ✅ Object Detection (Detección de objetos)
- ✅ Despliegue de modelos en producción
- ✅ Optimización y compresión de modelos

## 📖 Temas Avanzados

### 1. GANs (Generative Adversarial Networks)

**¿Qué son las GANs?**

Dos redes neuronales compitiendo entre sí:
- **Generator (Generador)**: Crea imágenes falsas
- **Discriminator (Discriminador)**: Distingue imágenes reales de falsas

```
    Ruido → [Generator] → Imagen Falsa
                              ↓
    Imagen Real ──────────→ [Discriminator] → ¿Real o Falsa?
```

**Aplicaciones:**
- Generación de imágenes realistas
- Style transfer (transferencia de estilo)
- Super-resolución de imágenes
- Generación de rostros (ThisPersonDoesNotExist)
- Completar imágenes (inpainting)

**Arquitectura básica:**

```python
# Generator
generator = tf.keras.Sequential([
    tf.keras.layers.Dense(7*7*256, input_shape=(100,)),
    tf.keras.layers.Reshape((7, 7, 256)),
    tf.keras.layers.Conv2DTranspose(128, 5, strides=1, padding='same', activation='relu'),
    tf.keras.layers.Conv2DTranspose(64, 5, strides=2, padding='same', activation='relu'),
    tf.keras.layers.Conv2DTranspose(1, 5, strides=2, padding='same', activation='tanh')
])

# Discriminator
discriminator = tf.keras.Sequential([
    tf.keras.layers.Conv2D(64, 5, strides=2, padding='same', input_shape=[28, 28, 1]),
    tf.keras.layers.LeakyReLU(),
    tf.keras.layers.Dropout(0.3),
    tf.keras.layers.Conv2D(128, 5, strides=2, padding='same'),
    tf.keras.layers.LeakyReLU(),
    tf.keras.layers.Dropout(0.3),
    tf.keras.layers.Flatten(),
    tf.keras.layers.Dense(1)
])
```

**Tipos de GANs:**
- DCGAN (Deep Convolutional GAN)
- WGAN (Wasserstein GAN)
- StyleGAN
- CycleGAN
- Pix2Pix

### 2. Autoencoders

**¿Qué son?**

Redes que aprenden a comprimir y reconstruir datos:

```
Input → [Encoder] → Latent Space → [Decoder] → Output
(784)      ↓         (32)             ↑        (784)
        Compress                    Reconstruct
```

**Arquitectura:**

```python
# Encoder
encoder = tf.keras.Sequential([
    tf.keras.layers.Dense(128, activation='relu', input_shape=(784,)),
    tf.keras.layers.Dense(64, activation='relu'),
    tf.keras.layers.Dense(32, activation='relu')  # Latent space
])

# Decoder
decoder = tf.keras.Sequential([
    tf.keras.layers.Dense(64, activation='relu', input_shape=(32,)),
    tf.keras.layers.Dense(128, activation='relu'),
    tf.keras.layers.Dense(784, activation='sigmoid')
])

# Autoencoder completo
autoencoder = tf.keras.Sequential([encoder, decoder])
```

**Aplicaciones:**
- Reducción de dimensionalidad
- Denoising (eliminación de ruido)
- Detección de anomalías
- Generación de datos
- Compresión de imágenes

**Variational Autoencoders (VAE):**
- Genera distribuciones en lugar de puntos fijos
- Permite generar nuevas muestras
- Latent space más continuo y estructurado

### 3. Attention y Transformers

**Mecanismo de Atención:**

Permite al modelo "enfocarse" en partes relevantes de la entrada:

```python
# Multi-head attention
attention_layer = tf.keras.layers.MultiHeadAttention(
    num_heads=8,
    key_dim=64
)
```

**Transformers:**

Arquitectura revolucionaria para NLP y más:

**Componentes:**
- Multi-Head Self-Attention
- Feed-Forward Networks
- Positional Encoding
- Layer Normalization

**Modelos famosos basados en Transformers:**
- BERT (Google)
- GPT (OpenAI)
- T5 (Google)
- Vision Transformer (ViT)

### 4. Object Detection

**Detectar y localizar objetos en imágenes:**

```
Input Image → [Model] → Bounding Boxes + Classes
```

**Arquitecturas populares:**

1. **YOLO (You Only Look Once)**
   - Muy rápido (tiempo real)
   - Una sola pasada por la red
   - Excelente para video

2. **Faster R-CNN**
   - Más preciso
   - Más lento
   - Region Proposal Network

3. **SSD (Single Shot Detector)**
   - Balance velocidad/precisión
   - Multiple scale feature maps

4. **EfficientDet**
   - Estado del arte
   - Eficiente y preciso

**Uso con TensorFlow:**

```python
import tensorflow_hub as hub

# Cargar modelo preentrenado
detector = hub.load("https://tfhub.dev/tensorflow/ssd_mobilenet_v2/2")

# Detectar objetos
results = detector(image)
boxes = results['detection_boxes']
classes = results['detection_classes']
scores = results['detection_scores']
```

## 📂 Contenido del Módulo

### Archivos de Ejemplo

1. **01_autoencoder_mnist.py** - Autoencoder para MNIST
2. **02_gan_simple.py** - GAN básica para generar dígitos
3. **03_object_detection.py** - Detección de objetos
4. **04_model_deployment.py** - Deploy con TensorFlow Serving
5. **05_optimization.py** - Optimización de modelos

## 🚀 Despliegue en Producción

### TensorFlow Serving

**Exportar modelo:**

```python
# Guardar en formato SavedModel
model.save('my_model/1')  # 1 = versión
```

**Servir con Docker:**

```bash
docker pull tensorflow/serving
docker run -p 8501:8501 \
  --mount type=bind,source=/path/to/my_model,target=/models/my_model \
  -e MODEL_NAME=my_model -t tensorflow/serving
```

**Hacer predicciones:**

```python
import requests
import json

data = json.dumps({"instances": test_data.tolist()})
headers = {"content-type": "application/json"}
response = requests.post(
    'http://localhost:8501/v1/models/my_model:predict',
    data=data,
    headers=headers
)
predictions = response.json()['predictions']
```

### TensorFlow Lite (Dispositivos móviles)

**Convertir modelo:**

```python
# Convertir a TensorFlow Lite
converter = tf.lite.TFLiteConverter.from_keras_model(model)
tflite_model = converter.convert()

# Guardar
with open('model.tflite', 'wb') as f:
    f.write(tflite_model)
```

**Optimizaciones:**

```python
converter.optimizations = [tf.lite.Optimize.DEFAULT]
converter.target_spec.supported_types = [tf.float16]  # Quantización
```

### TensorFlow.js (Navegador)

**Convertir modelo:**

```bash
pip install tensorflowjs
tensorflowjs_converter --input_format=keras \
  model.h5 \
  tfjs_model/
```

**Usar en JavaScript:**

```javascript
const model = await tf.loadLayersModel('tfjs_model/model.json');
const prediction = model.predict(tf.tensor2d(data));
```

## ⚡ Optimización de Modelos

### 1. Quantización

Reduce precisión de pesos (float32 → int8):

```python
converter = tf.lite.TFLiteConverter.from_keras_model(model)
converter.optimizations = [tf.lite.Optimize.DEFAULT]
tflite_quant_model = converter.convert()
```

**Beneficios:**
- Modelo 4x más pequeño
- Inferencia más rápida
- Menor consumo de energía

### 2. Pruning (Poda)

Elimina conexiones innecesarias:

```python
import tensorflow_model_optimization as tfmot

prune_low_magnitude = tfmot.sparsity.keras.prune_low_magnitude
pruned_model = prune_low_magnitude(model)
```

### 3. Knowledge Distillation

Entrenar modelo pequeño (student) con modelo grande (teacher):

```python
# Teacher: modelo grande preentrenado
teacher_predictions = teacher_model(x_train)

# Student: modelo pequeño
student_model.compile(...)
student_model.fit(x_train, teacher_predictions)
```

### 4. Mixed Precision Training

Usa float16 para velocidad, float32 para estabilidad:

```python
from tensorflow.keras import mixed_precision
policy = mixed_precision.Policy('mixed_float16')
mixed_precision.set_global_policy(policy)
```

## 📊 Métricas Avanzadas

### Para Object Detection
- mAP (mean Average Precision)
- IoU (Intersection over Union)
- Precision-Recall curves

### Para GANs
- Inception Score (IS)
- Fréchet Inception Distance (FID)
- Qualitative evaluation (visual)

### Para Autoencoders
- Reconstruction error
- SSIM (Structural Similarity Index)
- Latent space visualization

## 💡 Proyectos Finales Sugeridos

### 1. Sistema de Recomendación
- Collaborative filtering
- Content-based filtering
- Hybrid approach

### 2. Chatbot con LSTM/Transformer
- Seq2seq architecture
- Attention mechanism
- Context handling

### 3. Clasificador de Imágenes Médicas
- X-rays, CT scans, MRI
- Transfer learning
- Explainability (Grad-CAM)

### 4. Generador de Arte con GAN
- StyleGAN
- Conditional GAN
- Web interface

### 5. Sistema de Vigilancia Inteligente
- Object detection
- Tracking
- Anomaly detection

### 6. Traductor Automático
- Seq2seq with attention
- Transformer
- Multiple languages

## 🔬 Herramientas Avanzadas

### TensorBoard
Visualización de entrenamiento:

```python
tensorboard_callback = tf.keras.callbacks.TensorBoard(log_dir='./logs')
model.fit(..., callbacks=[tensorboard_callback])
```

### tf.data Pipeline
Pipeline eficiente de datos:

```python
dataset = tf.data.Dataset.from_tensor_slices((x_train, y_train))
dataset = dataset.shuffle(10000).batch(32).prefetch(tf.data.AUTOTUNE)
```

### TensorFlow Profiler
Analizar performance:

```python
tf.profiler.experimental.start('logdir')
# ... entrenamiento ...
tf.profiler.experimental.stop()
```

## 🎓 Recursos Adicionales

### Papers Importantes
- "Attention Is All You Need" (Transformers)
- "Generative Adversarial Networks" (GANs)
- "Auto-Encoding Variational Bayes" (VAE)
- "You Only Look Once" (YOLO)

### Datasets Avanzados
- ImageNet
- COCO (Object Detection)
- OpenImages
- CelebA (rostros)
- WikiText (NLP)

### Competencias
- Kaggle
- DrivenData
- AIcrowd

## ➡️ Próximos Pasos

**Después de completar este curso:**

1. **Practica constantemente**
   - Participa en Kaggle
   - Contribuye a proyectos open source
   - Crea tu portafolio

2. **Mantente actualizado**
   - Lee papers recientes (arxiv.org)
   - Sigue blogs técnicos
   - Asiste a conferencias (NeurIPS, ICML, CVPR)

3. **Especialízate**
   - Computer Vision
   - NLP
   - Reinforcement Learning
   - MLOps

---

**¡Felicidades por completar el curso de TensorFlow!** 🎉

Has aprendido desde los fundamentos hasta técnicas avanzadas. Ahora tienes las herramientas para crear proyectos increíbles con Deep Learning.

**¡Empieza a construir y nunca dejes de aprender!** 🚀
