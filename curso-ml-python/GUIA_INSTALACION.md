# 🚀 Guía de Instalación - Curso de Machine Learning con Python

## Requisitos Previos

Antes de comenzar, asegúrate de tener instalado:
- **Python 3.8 o superior** (recomendado: Python 3.9 o 3.10)
- **pip** (gestor de paquetes de Python)

### Verificar instalación de Python

```bash
python --version
# o
python3 --version
```

Deberías ver algo como: `Python 3.9.7`

### Verificar pip

```bash
pip --version
# o
pip3 --version
```

## Opción 1: Instalación Rápida (Recomendada)

### Paso 1: Clonar o descargar el repositorio

```bash
cd curso-ml-python
```

### Paso 2: Crear un entorno virtual (ALTAMENTE RECOMENDADO)

Un entorno virtual mantiene las dependencias del proyecto aisladas.

**En Windows:**
```bash
python -m venv venv
venv\Scripts\activate
```

**En macOS/Linux:**
```bash
python3 -m venv venv
source venv/bin/activate
```

Verás `(venv)` al inicio de tu terminal, indicando que el entorno está activo.

### Paso 3: Instalar todas las dependencias

```bash
pip install -r requirements.txt
```

Esto instalará todas las librerías necesarias:
- NumPy, Pandas, Matplotlib, Seaborn
- Scikit-learn
- TensorFlow y Keras
- Jupyter Notebooks
- Y más...

⏱️ **Tiempo estimado:** 5-10 minutos dependiendo de tu conexión a internet.

### Paso 4: Verificar la instalación

```bash
python -c "import numpy, pandas, sklearn, tensorflow; print('✓ Todo instalado correctamente')"
```

Si no hay errores, ¡estás listo para comenzar! 🎉

## Opción 2: Instalación Manual (Paso a Paso)

Si prefieres instalar las librerías una por una:

### 1. NumPy (Computación numérica)
```bash
pip install numpy
```

### 2. Pandas (Análisis de datos)
```bash
pip install pandas
```

### 3. Matplotlib y Seaborn (Visualización)
```bash
pip install matplotlib seaborn
```

### 4. Scikit-learn (Machine Learning)
```bash
pip install scikit-learn
```

### 5. TensorFlow (Deep Learning)
```bash
pip install tensorflow
```

### 6. Jupyter (Notebooks interactivos - Opcional)
```bash
pip install jupyter
```

## Opción 3: Usando Anaconda (Alternativa)

Anaconda viene con muchas librerías pre-instaladas.

### Paso 1: Descargar Anaconda
Visita: https://www.anaconda.com/download

### Paso 2: Crear un entorno conda
```bash
conda create -n ml-course python=3.9
conda activate ml-course
```

### Paso 3: Instalar dependencias
```bash
conda install numpy pandas matplotlib seaborn scikit-learn jupyter
pip install tensorflow
```

## Verificación Completa de la Instalación

Crea un archivo `test_installation.py` con este contenido:

```python
import sys
print(f"Python version: {sys.version}\n")

# Probar cada librería
libraries = {
    'numpy': 'NumPy',
    'pandas': 'Pandas',
    'matplotlib': 'Matplotlib',
    'seaborn': 'Seaborn',
    'sklearn': 'Scikit-learn',
    'tensorflow': 'TensorFlow',
    'keras': 'Keras'
}

print("Verificando instalación de librerías:\n")
for module, name in libraries.items():
    try:
        lib = __import__(module)
        version = getattr(lib, '__version__', 'N/A')
        print(f"✓ {name:15} - Versión {version}")
    except ImportError:
        print(f"✗ {name:15} - NO INSTALADO")

print("\n¡Instalación completa!")
```

Luego ejecuta:
```bash
python test_installation.py
```

## Cómo Ejecutar los Módulos del Curso

### Método 1: Línea de comandos

```bash
# Navega a la carpeta del módulo
cd modulo-01-fundamentos

# Ejecuta el script
python 01_introduccion_numpy.py
```

### Método 2: Jupyter Notebook (Interactivo)

```bash
# Iniciar Jupyter
jupyter notebook

# Se abrirá tu navegador
# Navega a la carpeta del módulo y crea un nuevo notebook
# Copia y pega el código de los módulos
```

### Método 3: IDE (VS Code, PyCharm, etc.)

1. Abre el proyecto en tu IDE favorito
2. Configura el intérprete de Python al del entorno virtual
3. Ejecuta los archivos directamente

## Solución de Problemas Comunes

### ❌ Error: "pip no se reconoce como comando"

**Solución:** Asegúrate de que Python está en el PATH del sistema.

**Windows:** Reinstala Python y marca "Add Python to PATH"

**macOS/Linux:** Usa `python3 -m pip` en lugar de `pip`

### ❌ Error al instalar TensorFlow

**Solución para Windows:**
```bash
pip install --upgrade pip
pip install tensorflow
```

**Solución para macOS con chip M1/M2:**
```bash
conda install -c apple tensorflow-deps
pip install tensorflow-macos
pip install tensorflow-metal
```

### ❌ "ModuleNotFoundError" al ejecutar scripts

**Solución:** Asegúrate de que el entorno virtual está activado:
```bash
# Deberías ver (venv) en tu terminal
# Si no:
source venv/bin/activate  # macOS/Linux
venv\Scripts\activate     # Windows
```

### ❌ Problemas con permisos en Linux/macOS

**Solución:** Usa `--user` al instalar:
```bash
pip install --user -r requirements.txt
```

## Actualizaciones

Para actualizar todas las librerías a las últimas versiones:

```bash
pip install --upgrade -r requirements.txt
```

## Recursos Adicionales

- **Documentación de NumPy:** https://numpy.org/doc/
- **Documentación de Pandas:** https://pandas.pydata.org/docs/
- **Documentación de Scikit-learn:** https://scikit-learn.org/
- **Documentación de TensorFlow:** https://www.tensorflow.org/
- **Tutoriales de Keras:** https://keras.io/

## ¿Necesitas Ayuda?

Si encuentras algún problema:
1. Revisa esta guía completamente
2. Busca el error en Google (incluye el mensaje completo)
3. Consulta Stack Overflow
4. Revisa los issues del repositorio del curso

## ¡Estás Listo! 🎯

Una vez que todo esté instalado correctamente:

1. Comienza con el **Módulo 1: Fundamentos de NumPy**
2. Sigue el orden de los módulos
3. Practica con los ejercicios
4. Experimenta modificando el código

**¡Mucha suerte en tu viaje de aprendizaje de Machine Learning!** 🚀

---

**Última actualización:** 2024
**Versión del curso:** 1.0
