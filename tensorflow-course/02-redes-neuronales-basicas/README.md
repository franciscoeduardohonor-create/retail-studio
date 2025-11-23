# 📚 Módulo 2: Redes Neuronales Básicas

## 🎯 Objetivos del Módulo

En este módulo aprenderás:
- ✅ Fundamentos de redes neuronales
- ✅ Regresión lineal y logística con TensorFlow
- ✅ Perceptrón y redes densas (fully connected)
- ✅ Funciones de activación
- ✅ Optimizadores y funciones de pérdida
- ✅ Proceso completo de entrenamiento

## 📖 Conceptos Clave

### ¿Qué es una Red Neuronal?

Una red neuronal es un modelo computacional inspirado en el cerebro humano, compuesto por:

- **Neuronas (nodos)**: Unidades de procesamiento
- **Pesos (weights)**: Parámetros que la red aprende
- **Bias (sesgo)**: Término independiente en cada neurona
- **Funciones de activación**: Introducen no-linealidad

### Arquitectura Básica

```
Input Layer → Hidden Layers → Output Layer
    |              |              |
  [x₁]          [h₁ h₂]         [ŷ]
  [x₂]          [h₃ h₄]
  [x₃]
```

## 📂 Contenido del Módulo

### Archivos de Ejemplo

1. **01_regresion_lineal.py** - Regresión lineal desde cero
2. **02_regresion_logistica.py** - Clasificación binaria
3. **03_mnist_clasificacion.py** - Clasificación de dígitos MNIST
4. **04_funciones_activacion.py** - Explorando funciones de activación
5. **05_optimizadores.py** - Comparación de optimizadores
6. **06_proyecto_prediccion_casas.py** - Proyecto: Predicción de precios

## 🧠 Funciones de Activación

Las funciones de activación más comunes:

### 1. **Sigmoid** (σ)
```python
output = 1 / (1 + e^(-x))
```
- Rango: (0, 1)
- Uso: Clasificación binaria (última capa)

### 2. **ReLU** (Rectified Linear Unit)
```python
output = max(0, x)
```
- Rango: [0, ∞)
- Uso: Capas ocultas (más común)

### 3. **Tanh** (Tangente hiperbólica)
```python
output = (e^x - e^(-x)) / (e^x + e^(-x))
```
- Rango: (-1, 1)
- Uso: Capas ocultas (alternativa a ReLU)

### 4. **Softmax**
```python
output_i = e^(x_i) / Σ(e^(x_j))
```
- Rango: (0, 1), suma = 1
- Uso: Clasificación multiclase (última capa)

## 📊 Funciones de Pérdida (Loss Functions)

### Para Regresión
- **MSE** (Mean Squared Error): `(y - ŷ)²`
- **MAE** (Mean Absolute Error): `|y - ŷ|`

### Para Clasificación
- **Binary Crossentropy**: Clasificación binaria
- **Categorical Crossentropy**: Clasificación multiclase
- **Sparse Categorical Crossentropy**: Multiclase con etiquetas enteras

## ⚙️ Optimizadores

Los optimizadores ajustan los pesos durante el entrenamiento:

1. **SGD** (Stochastic Gradient Descent)
   - Simple y confiable
   - Learning rate fijo

2. **Adam** (Adaptive Moment Estimation)
   - Más usado actualmente
   - Learning rate adaptativo
   - Combina momentum y RMSprop

3. **RMSprop**
   - Learning rate adaptativo
   - Bueno para RNNs

## 🔄 Proceso de Entrenamiento

```python
# 1. Definir modelo
model = tf.keras.Sequential([
    tf.keras.layers.Dense(64, activation='relu'),
    tf.keras.layers.Dense(10, activation='softmax')
])

# 2. Compilar
model.compile(
    optimizer='adam',
    loss='sparse_categorical_crossentropy',
    metrics=['accuracy']
)

# 3. Entrenar
model.fit(X_train, y_train, epochs=10, validation_split=0.2)

# 4. Evaluar
model.evaluate(X_test, y_test)

# 5. Predecir
predictions = model.predict(X_new)
```

## 💡 Consejos Importantes

### Preparación de Datos
1. **Normalizar** los datos de entrada (escala 0-1 o estandarización)
2. **Dividir** en train/validation/test (típicamente 70/15/15)
3. **Shuffle** los datos de entrenamiento

### Arquitectura del Modelo
1. Comenzar simple, luego aumentar complejidad
2. Número de neuronas en capa de salida = número de clases
3. Activación de salida:
   - Regresión → linear (sin activación)
   - Clasificación binaria → sigmoid
   - Clasificación multiclase → softmax

### Entrenamiento
1. Usar **early stopping** para evitar overfitting
2. Monitorear tanto loss como accuracy
3. Validar en datos no vistos

## 🎓 Ejercicios del Módulo

Al finalizar este módulo, deberías poder:

1. ✅ Implementar regresión lineal con Keras
2. ✅ Crear un clasificador binario
3. ✅ Entrenar un modelo para MNIST
4. ✅ Elegir funciones de activación apropiadas
5. ✅ Comparar diferentes optimizadores
6. ✅ Construir un proyecto end-to-end

## 📚 Datasets Utilizados

- **MNIST**: Dígitos escritos a mano (28×28 píxeles, 10 clases)
- **Fashion MNIST**: Prendas de ropa (28×28 píxeles, 10 clases)
- **Iris**: Clasificación de flores (4 features, 3 clases)
- **Boston Housing**: Predicción de precios de casas

## ➡️ Siguiente Paso

Una vez completado este módulo, estarás listo para:
**Módulo 3: Redes Neuronales Convolucionales (CNN)**

---

**¡Comienza con `01_regresion_lineal.py`!** 🚀
