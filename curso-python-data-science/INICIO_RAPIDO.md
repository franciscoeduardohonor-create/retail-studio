# 🚀 Inicio Rápido

## ¡Bienvenido al Curso de Python para Ciencia de Datos!

---

## ⚡ Configuración en 3 Pasos

### 1️⃣ Instalar Python

Si no tienes Python instalado:

**Windows:**
- Descarga desde: https://www.python.org/downloads/
- Durante instalación, marca "Add Python to PATH"

**Mac:**
```bash
brew install python3
```

**Linux:**
```bash
sudo apt-get update
sudo apt-get install python3 python3-pip
```

Verifica la instalación:
```bash
python --version  # Debe ser 3.7 o superior
```

---

### 2️⃣ Instalar Librerías

Abre una terminal/consola y ejecuta:

```bash
# Opción 1: Instalación completa (recomendado)
pip install numpy pandas matplotlib seaborn scikit-learn jupyter

# Opción 2: Desde requirements.txt
pip install -r requirements.txt

# Opción 3: Si usas Anaconda
conda install numpy pandas matplotlib seaborn scikit-learn jupyter
```

**Verificar instalación:**
```bash
python -c "import pandas; print('✓ Pandas instalado correctamente')"
python -c "import numpy; print('✓ NumPy instalado correctamente')"
python -c "import matplotlib; print('✓ Matplotlib instalado correctamente')"
```

---

### 3️⃣ Ejecutar Tu Primera Lección

```bash
# Navega a la carpeta del curso
cd curso-python-data-science/modulo1-fundamentos

# Ejecuta el primer script
python 01_variables_y_tipos.py
```

¡Deberías ver la salida del programa! 🎉

---

## 📝 Formas de Trabajar con el Curso

### Opción A: Scripts de Python (Principiantes)

Ejecuta cada archivo directamente:
```bash
python 01_variables_y_tipos.py
```

**Ventajas:**
- Simple y directo
- No requiere herramientas adicionales
- Perfecto para empezar

---

### Opción B: Jupyter Notebook (Recomendado)

Los Notebooks permiten ejecutar código por secciones y ver resultados inmediatamente.

**Iniciar Jupyter:**
```bash
# Desde la carpeta del curso
jupyter notebook
```

Se abrirá tu navegador. Navega a cualquier archivo `.py` y:
1. Haz clic derecho → "Open With" → "Notebook"
2. O crea un nuevo notebook y copia el código

**Ventajas:**
- Ejecución interactiva
- Visualizaciones inline
- Experimentación fácil
- Perfecto para aprender

---

### Opción C: IDE (Avanzado)

Usa un IDE como VS Code o PyCharm:

**VS Code:**
1. Descarga: https://code.visualstudio.com/
2. Instala extensión de Python
3. Abre la carpeta del curso
4. Ejecuta archivos con F5

**PyCharm:**
1. Descarga: https://www.jetbrains.com/pycharm/
2. Abre proyecto
3. Ejecuta con Shift+F10

**Ventajas:**
- Autocompletado inteligente
- Debugging potente
- Perfecto para proyectos grandes

---

## 📚 Ruta de Aprendizaje Sugerida

### Semana 1-2: Fundamentos
```
✓ modulo1-fundamentos/01_variables_y_tipos.py
✓ modulo1-fundamentos/02_estructuras_datos.py
✓ modulo1-fundamentos/03_funciones_control_flujo.py
```

**Meta:** Sentirte cómodo con Python básico

---

### Semana 3: NumPy
```
✓ modulo2-numpy/01_introduccion_numpy.py
✓ modulo2-numpy/02_operaciones_arrays.py
```

**Meta:** Entender arrays y operaciones vectorizadas

---

### Semana 4-6: Pandas
```
✓ modulo3-pandas/01_introduccion_pandas.py
✓ modulo3-pandas/02_limpieza_datos.py
```

**Meta:** Dominar análisis de datos con Pandas

---

### Semana 7-8: Visualización
```
✓ modulo4-visualizacion/01_matplotlib_basico.py
✓ modulo4-visualizacion/02_seaborn_estadistico.py
```

**Meta:** Crear visualizaciones profesionales

---

### Semana 9-11: Machine Learning
```
✓ modulo5-machine-learning/01_regresion.py
✓ modulo5-machine-learning/02_clasificacion.py
```

**Meta:** Construir modelos predictivos

---

### Semana 12+: Proyectos
```
✓ modulo6-proyectos-avanzados/proyecto1_analisis_ecommerce.py
✓ Tu propio proyecto
```

**Meta:** Aplicar todo lo aprendido

---

## 💡 Consejos para Principiantes

### 1. No Tengas Miedo de los Errores
Los errores son normales y necesarios para aprender.

```python
# ❌ Error común
print(variable_que_no_existe)
# Mensaje: NameError: name 'variable_que_no_existe' is not defined

# ✅ Solución
variable = 42
print(variable)
```

### 2. Lee los Comentarios
Cada línea de código tiene comentarios explicativos:

```python
# Este comentario explica qué hace el código
resultado = 5 + 3  # Suma dos números
```

### 3. Experimenta
Modifica el código y observa qué pasa:

```python
# Original
nombre = "Ana"

# Experimenta cambiando el valor
nombre = "Tu Nombre Aquí"
```

### 4. Usa print() para Entender
Imprime variables para ver sus valores:

```python
edad = 25
print(f"La edad es: {edad}")
print(f"Tipo de dato: {type(edad)}")
```

### 5. Practica Diariamente
15-30 minutos cada día es mejor que 3 horas una vez por semana.

---

## 🆘 Solución de Problemas Comunes

### Problema: "ModuleNotFoundError: No module named 'pandas'"
**Solución:**
```bash
pip install pandas
```

---

### Problema: "python: command not found"
**Solución:**
- Instala Python desde python.org
- En Windows, marca "Add to PATH" durante instalación
- En Mac/Linux, usa `python3` en lugar de `python`

---

### Problema: "SyntaxError: invalid syntax"
**Solución:**
- Verifica que copiaste el código correctamente
- Revisa paréntesis, comillas y dos puntos
- Python es sensible a la indentación

---

### Problema: Las gráficas no se muestran
**Solución:**
```python
import matplotlib.pyplot as plt

# Agrega esta línea al final
plt.show()

# O en Jupyter
%matplotlib inline
```

---

## 📖 Recursos Adicionales

### Documentación Oficial
- Python: https://docs.python.org/3/
- NumPy: https://numpy.org/doc/
- Pandas: https://pandas.pydata.org/docs/
- Matplotlib: https://matplotlib.org/
- Scikit-learn: https://scikit-learn.org/

### Comunidades
- Stack Overflow (español): https://es.stackoverflow.com/
- Reddit r/learnpython: https://reddit.com/r/learnpython
- Python Discord: https://pythondiscord.com/

### Práctica
- Kaggle Learn: https://www.kaggle.com/learn
- LeetCode: https://leetcode.com/
- HackerRank: https://www.hackerrank.com/domains/python

---

## ✅ Checklist de Inicio

Antes de empezar, asegúrate de:

- [ ] Python 3.7+ instalado
- [ ] Librerías instaladas (numpy, pandas, matplotlib)
- [ ] Editor de código listo (Jupyter, VS Code, o Python IDLE)
- [ ] Carpeta del curso descargada
- [ ] Primera lección ejecutada exitosamente

---

## 🎯 Tu Primera Sesión (30 minutos)

### Minuto 0-5: Configuración
```bash
cd curso-python-data-science/modulo1-fundamentos
```

### Minuto 5-20: Ejecuta y Lee
```bash
python 01_variables_y_tipos.py
```
Lee el código y los comentarios

### Minuto 20-30: Experimenta
Abre el archivo en tu editor y:
1. Cambia valores de variables
2. Agrega tus propios ejemplos
3. Completa el primer ejercicio

---

## 🚀 ¡Estás Listo!

```python
# Tu viaje en ciencia de datos comienza aquí
nombre = "Tu nombre"
objetivo = "Convertirme en Data Scientist"

print(f"¡Hola {nombre}!")
print(f"Mi objetivo: {objetivo}")
print("¡Vamos a lograrlo! 💪📊🐍")
```

---

## 📞 ¿Necesitas Ayuda?

1. **Lee los comentarios** en el código
2. **Busca el error** en Google (en inglés funciona mejor)
3. **Consulta la documentación** oficial
4. **Pregunta en Stack Overflow** con código de ejemplo
5. **Revisa el README.md** para más información

---

## 🎉 ¡A Programar!

No necesitas memorizar todo. Solo:
- Entiende los conceptos
- Practica con los ejemplos
- Experimenta y equivócate
- Repite y mejora

**¡El mejor momento para empezar es AHORA!**

```bash
# Ejecuta esto y comienza tu aventura
python modulo1-fundamentos/01_variables_y_tipos.py
```

**¡Mucha suerte y disfruta el viaje! 🌟**
