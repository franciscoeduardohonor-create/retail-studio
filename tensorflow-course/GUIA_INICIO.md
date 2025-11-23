# 🚀 Guía de Inicio Rápido - Curso de TensorFlow

¡Bienvenido al curso más completo de TensorFlow en español! Esta guía te ayudará a comenzar.

## 📋 Requisitos Previos

### Conocimientos
- ✅ Python básico (variables, funciones, listas, diccionarios)
- ✅ Matemáticas básicas (álgebra, estadística básica)
- ⭐ Numpy (recomendado, pero no obligatorio)

### Software
- Python 3.8 o superior
- pip o conda para instalar paquetes

## ⚡ Instalación Rápida

### Opción 1: Entorno Virtual (Recomendado)

```bash
# 1. Crear entorno virtual
python -m venv tensorflow-env

# 2. Activar entorno virtual
# En Windows:
tensorflow-env\Scripts\activate
# En Linux/Mac:
source tensorflow-env/bin/activate

# 3. Instalar dependencias
pip install -r requirements.txt
```

### Opción 2: Instalación Global

```bash
pip install tensorflow numpy pandas matplotlib seaborn scikit-learn jupyter
```

### Opción 3: Google Colab (Sin instalación)

1. Ve a [Google Colab](https://colab.research.google.com/)
2. Sube los archivos .py del curso
3. ¡Empieza a aprender! (TensorFlow ya está instalado)

## 📚 Estructura del Curso

```
tensorflow-course/
├── 01-fundamentos/              ← EMPIEZA AQUÍ
│   ├── README.md
│   ├── 01_introduccion_tensores.py
│   ├── 02_operaciones_basicas.py
│   └── ...
├── 02-redes-neuronales-basicas/
├── 03-redes-convolutionales/
├── 04-redes-recurrentes/
├── 05-transfer-learning/
├── 06-proyectos-avanzados/
└── requirements.txt
```

## 🎯 Cómo Usar Este Curso

### Para Principiantes Completos

**Semana 1-2: Módulo 1**
```bash
cd 01-fundamentos
python 01_introduccion_tensores.py
python 02_operaciones_basicas.py
# ... continúa con todos los archivos
```

**Semana 3-4: Módulo 2**
```bash
cd ../02-redes-neuronales-basicas
python 01_regresion_lineal.py
# ...
```

**Continúa secuencialmente** hasta completar todos los módulos.

### Para Estudiantes Intermedios

Si ya conoces Python y ML básico:
- **Semana 1:** Módulos 1-2 (repaso rápido)
- **Semana 2:** Módulo 3 (CNNs)
- **Semana 3:** Módulo 4 (RNNs)
- **Semana 4:** Módulos 5-6 (Transfer Learning y Avanzados)

### Para Profesionales

Enfócate en los temas específicos que necesites:
- **Computer Vision** → Módulos 3 y 5
- **NLP** → Módulo 4
- **Producción** → Módulo 6

## 💡 Consejos para Aprovechar el Curso

### 1. **Ejecuta TODOS los ejemplos**
```bash
python ejemplo.py
```
No solo leas el código, ¡ejecútalo!

### 2. **Lee los comentarios**
Cada línea de código está documentada:
```python
# Este comentario explica qué hace esta línea
X_train = X_train / 255.0  # Normalizar a [0, 1]
```

### 3. **Experimenta**
Modifica los parámetros:
```python
# Cambia esto:
epochs = 10
# Por esto:
epochs = 20
# ¿Qué pasa?
```

### 4. **Haz los ejercicios**
Cada archivo tiene ejercicios prácticos al final.

### 5. **Toma notas**
Crea tu propio notebook o documento con apuntes.

## 🔧 Verificar Instalación

Ejecuta este código para verificar que todo está instalado:

```python
import tensorflow as tf
import numpy as np
import matplotlib.pyplot as plt

print(f"✓ TensorFlow version: {tf.__version__}")
print(f"✓ NumPy version: {np.__version__}")
print(f"✓ Python version: {import sys; sys.version}")

# Verificar GPU (opcional)
if tf.config.list_physical_devices('GPU'):
    print("✓ GPU disponible!")
else:
    print("⚠ CPU solamente (GPU no detectada)")
```

## 🎓 Plan de Estudio Sugerido

### Plan Intensivo (4 semanas)

**Semana 1:**
- Lunes-Martes: Módulo 1 (Fundamentos)
- Miércoles-Viernes: Módulo 2 (Redes Neuronales Básicas)

**Semana 2:**
- Lunes-Viernes: Módulo 3 (CNNs)

**Semana 3:**
- Lunes-Viernes: Módulo 4 (RNNs/LSTM)

**Semana 4:**
- Lunes-Miércoles: Módulo 5 (Transfer Learning)
- Jueves-Viernes: Módulo 6 (Proyectos Avanzados)

### Plan Regular (8 semanas)

- **Semanas 1-2:** Módulos 1-2
- **Semanas 3-4:** Módulo 3
- **Semanas 5-6:** Módulo 4
- **Semana 7:** Módulo 5
- **Semana 8:** Módulo 6 + Proyecto final

### Plan Relajado (12 semanas)

- **Semanas 1-3:** Módulos 1-2
- **Semanas 4-6:** Módulo 3
- **Semanas 7-9:** Módulo 4
- **Semanas 10-11:** Módulo 5
- **Semana 12:** Módulo 6

## ❓ Solución de Problemas

### "ModuleNotFoundError: No module named 'tensorflow'"

```bash
pip install tensorflow
```

### "No se encuentra el dataset"

Los datasets se descargan automáticamente la primera vez. Asegúrate de tener conexión a internet.

### "Out of Memory (OOM)"

Reduce el batch size:
```python
# Cambia:
batch_size = 128
# Por:
batch_size = 32
```

### Código muy lento

- Asegúrate de tener GPU (opcional pero recomendado)
- Reduce el número de épocas para pruebas
- Usa datasets más pequeños para experimentar

## 📖 Recursos Complementarios

### Documentación Oficial
- [TensorFlow.org](https://www.tensorflow.org/)
- [TensorFlow Tutorials](https://www.tensorflow.org/tutorials)
- [Keras API](https://keras.io/api/)

### Videos Recomendados
- [3Blue1Brown - Neural Networks](https://www.youtube.com/playlist?list=PLZHQObOWTQDNU6R1_67000Dx_ZCJB-3pi)
- [Sentdex - Deep Learning](https://www.youtube.com/playlist?list=PLQVvvaa0QuDfKTOs3Keq_kaG2P55YRn5v)

### Libros
- "Deep Learning" - Ian Goodfellow
- "Hands-On Machine Learning" - Aurélien Géron
- "Deep Learning with Python" - François Chollet

### Comunidades
- [r/MachineLearning](https://reddit.com/r/MachineLearning)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/tensorflow)
- [TensorFlow Forum](https://discuss.tensorflow.org/)

## 🎯 Objetivos de Aprendizaje

Al completar este curso, serás capaz de:

✅ Entender los fundamentos de TensorFlow y Deep Learning
✅ Construir y entrenar redes neuronales desde cero
✅ Implementar CNNs para visión por computadora
✅ Crear RNNs para procesamiento de secuencias y texto
✅ Aplicar Transfer Learning a problemas reales
✅ Implementar modelos avanzados (GANs, Autoencoders)
✅ Desplegar modelos en producción
✅ Optimizar y mejorar el rendimiento de tus modelos

## 🚀 ¡Comienza Ahora!

```bash
cd 01-fundamentos
python 01_introduccion_tensores.py
```

## 💬 Feedback

¿Encontraste un error? ¿Tienes sugerencias?
Este curso está en constante mejora. ¡Tu feedback es valioso!

---

**¡Mucha suerte en tu viaje de aprendizaje!** 🌟

*"The only way to learn is by doing."*

**Dirígete al [Módulo 1](./01-fundamentos/) para empezar →**
