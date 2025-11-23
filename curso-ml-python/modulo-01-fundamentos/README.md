# Módulo 1: Fundamentos de Python y NumPy

## 🎯 Objetivos del Módulo

Al completar este módulo serás capaz de:
- ✅ Crear y manipular arrays de NumPy
- ✅ Realizar operaciones vectorizadas eficientes
- ✅ Indexar y hacer slicing de arrays multidimensionales
- ✅ Aplicar operaciones estadísticas y agregaciones
- ✅ Entender y usar broadcasting
- ✅ Realizar operaciones básicas de álgebra lineal

## 📚 Contenido

### 1. **01_introduccion_numpy.py**
Introducción completa a NumPy con ejemplos prácticos:
- Creación de arrays (1D, 2D, especiales)
- Operaciones básicas
- Indexación y slicing
- Reshape y transpose
- Agregaciones y estadísticas
- Broadcasting
- Álgebra lineal básica
- Ejercicio práctico de análisis de datos

### 2. **02_ejercicios_numpy.py**
6 ejercicios prácticos con soluciones:
- Ejercicio 1: Creación de arrays
- Ejercicio 2: Indexación y slicing
- Ejercicio 3: Operaciones y estadísticas
- Ejercicio 4: Broadcasting y normalización
- Ejercicio 5: Álgebra lineal
- Ejercicio 6: Proyecto mini - Análisis de temperaturas

## 🚀 Cómo usar este módulo

### Paso 1: Ejecuta el archivo de introducción
```bash
python 01_introduccion_numpy.py
```

Lee cuidadosamente cada sección y los comentarios.

### Paso 2: Practica con los ejercicios

**IMPORTANTE**: Antes de ver las soluciones, intenta resolver cada ejercicio por tu cuenta.

```bash
python 02_ejercicios_numpy.py
```

### Paso 3: Experimenta

Modifica los ejemplos:
- Cambia los valores de los arrays
- Prueba diferentes operaciones
- Rompe el código (para aprender qué NO hacer)
- Crea tus propios ejercicios

## 💡 Conceptos Clave

### 1. Arrays vs Listas de Python
```python
# Lista de Python (lenta)
lista = [1, 2, 3, 4, 5]
resultado = [x * 2 for x in lista]  # Loop explícito

# Array de NumPy (rápido)
array = np.array([1, 2, 3, 4, 5])
resultado = array * 2  # Vectorizado
```

### 2. Broadcasting
Permite operar arrays de diferentes formas:
```python
matriz = np.array([[1, 2, 3],
                   [4, 5, 6]])
vector = np.array([10, 20, 30])

resultado = matriz + vector  # Vector se "transmite" a cada fila
```

### 3. Axis
- `axis=0` → Operación por columnas (verticalmente)
- `axis=1` → Operación por filas (horizontalmente)

```python
matriz = np.array([[1, 2, 3],
                   [4, 5, 6]])

matriz.sum(axis=0)  # [5, 7, 9] - suma cada columna
matriz.sum(axis=1)  # [6, 15] - suma cada fila
```

## 🔑 Comandos Importantes

```python
# Creación
np.array([1, 2, 3])          # De lista a array
np.zeros((3, 4))              # Matriz de ceros
np.ones((2, 3))               # Matriz de unos
np.eye(3)                     # Matriz identidad
np.arange(0, 10, 2)           # Rango
np.linspace(0, 1, 5)          # Espaciado lineal
np.random.rand(3, 3)          # Aleatorio [0,1]
np.random.randn(3, 3)         # Normal (μ=0, σ=1)

# Propiedades
arr.shape                     # Forma
arr.ndim                      # Dimensiones
arr.size                      # Total de elementos
arr.dtype                     # Tipo de dato

# Operaciones
arr.sum()                     # Suma
arr.mean()                    # Media
arr.std()                     # Desviación estándar
arr.min()                     # Mínimo
arr.max()                     # Máximo
arr.argmax()                  # Índice del máximo
arr.argmin()                  # Índice del mínimo

# Reshape
arr.reshape(3, 4)             # Cambiar forma
arr.T                         # Transpuesta
arr.flatten()                 # Convertir a 1D

# Álgebra lineal
np.dot(a, b)                  # Producto punto
np.linalg.inv(A)              # Inversa
np.linalg.det(A)              # Determinante
```

## 📝 Ejercicios Adicionales

Intenta resolver estos por tu cuenta:

1. **Matriz de Multiplicación**: Crea una tabla de multiplicar del 1 al 10
2. **Normalización**: Normaliza un array para que tenga media 0 y std 1
3. **Filtrado**: De un array de 100 números aleatorios, extrae solo los primos
4. **Matriz de Correlación**: Calcula la correlación entre columnas de una matriz

## ⏭️ Siguiente Paso

Una vez que domines NumPy, continúa con:
**Módulo 2: Pandas y Análisis de Datos**

NumPy es la base, ¡pero Pandas hará tu vida mucho más fácil para trabajar con datos reales!

## 🤔 ¿Preguntas Frecuentes?

**P: ¿Por qué NumPy es más rápido que las listas de Python?**
R: NumPy está implementado en C y usa vectorización. Las operaciones se hacen a nivel de C, no de Python.

**P: ¿Cuándo usar listas vs arrays?**
R: Usa listas para colecciones generales. Usa arrays para cálculos numéricos.

**P: ¿Qué es el broadcasting?**
R: Es la capacidad de NumPy de operar arrays de diferentes formas automáticamente.

¡Éxito en tu aprendizaje! 🚀
