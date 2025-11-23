# 📚 Módulo 1: Fundamentos de TensorFlow

## 🎯 Objetivos del Módulo

En este módulo aprenderás:
- ✅ Qué es TensorFlow y por qué es importante
- ✅ Conceptos básicos de tensores
- ✅ Operaciones matemáticas con tensores
- ✅ Variables y constantes
- ✅ Grafos computacionales
- ✅ Primeros pasos en computación numérica

## 📖 ¿Qué es TensorFlow?

TensorFlow es una biblioteca de código abierto desarrollada por Google para realizar cálculos numéricos de alto rendimiento. Es especialmente útil para:

- 🧠 Machine Learning y Deep Learning
- 🔢 Computación científica
- 📊 Análisis de datos a gran escala
- 🤖 Inteligencia Artificial

### ¿Qué es un Tensor?

Un **tensor** es un contenedor multidimensional de datos. Piensa en él como una generalización de matrices:

- **Escalar (0D)**: Un solo número → `5`
- **Vector (1D)**: Una lista de números → `[1, 2, 3]`
- **Matriz (2D)**: Una tabla de números → `[[1, 2], [3, 4]]`
- **Tensor (3D+)**: Arreglos multidimensionales → `[[[1, 2]], [[3, 4]]]`

## 📂 Contenido del Módulo

### Archivos de Ejemplo

1. **01_introduccion_tensores.py** - Creación y tipos de tensores
2. **02_operaciones_basicas.py** - Operaciones matemáticas fundamentales
3. **03_variables_constantes.py** - Diferencia entre variables y constantes
4. **04_broadcasting.py** - Broadcasting en operaciones
5. **05_indexing_slicing.py** - Indexación y slicing de tensores
6. **06_proyecto_calculadora.py** - Proyecto: Calculadora con TensorFlow
7. **07_proyecto_analisis_datos.py** - Proyecto: Análisis de datos

## 🚀 Cómo usar este módulo

1. Lee este README completo
2. Ejecuta cada archivo Python en orden
3. Lee todos los comentarios del código
4. Experimenta modificando los valores
5. Completa los ejercicios propuestos

## 💻 Instalación rápida

Si no has instalado las dependencias:

```bash
pip install tensorflow numpy matplotlib
```

## 📊 Conceptos Clave

### Shape (Forma)
El **shape** define las dimensiones de un tensor:
```python
tensor_1d = [1, 2, 3]           # Shape: (3,)
tensor_2d = [[1, 2], [3, 4]]    # Shape: (2, 2)
tensor_3d = [[[1], [2]]]        # Shape: (1, 2, 1)
```

### Dtype (Tipo de dato)
Los tensores pueden contener diferentes tipos de datos:
- `tf.float32` - Números decimales (más común en ML)
- `tf.int32` - Números enteros
- `tf.bool` - Valores booleanos
- `tf.string` - Cadenas de texto

### Rank (Rango)
El **rank** es el número de dimensiones:
- Escalar: rank 0
- Vector: rank 1
- Matriz: rank 2
- Tensor 3D: rank 3

## 🎓 Ejercicios Propuestos

Después de completar todos los ejemplos, intenta:

1. **Ejercicio 1**: Crea un tensor 3D que represente imágenes RGB (alto × ancho × canales)
2. **Ejercicio 2**: Implementa la función de distancia euclidiana usando operaciones de TensorFlow
3. **Ejercicio 3**: Crea una función que normalice un tensor (resta media, divide por desviación estándar)
4. **Ejercicio 4**: Implementa la multiplicación de matrices sin usar `tf.matmul`

## 📚 Recursos Adicionales

- [TensorFlow Tensors Guide](https://www.tensorflow.org/guide/tensor)
- [TensorFlow API: tf.Tensor](https://www.tensorflow.org/api_docs/python/tf/Tensor)

## ➡️ Siguiente Paso

Una vez que te sientas cómodo con estos conceptos, avanza al **Módulo 2: Redes Neuronales Básicas**.

---

**¡Comienza con el primer ejemplo: `01_introduccion_tensores.py`!** 🚀
