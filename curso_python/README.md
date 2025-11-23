# 🐍 Curso Práctico de Python con VSCode

## De Principiante a Avanzado

Bienvenido al curso más completo y práctico de Python. Este curso está diseñado para llevarte desde cero hasta un nivel avanzado con ejemplos reales, código comentado y ejercicios prácticos.

---

## 📚 Contenido del Curso

### 📗 Nivel 1: Principiante

**Módulo 1: Variables y Tipos de Datos** (`01_variables_tipos_datos.py`)
- Variables y asignaciones
- Tipos de datos (str, int, float, bool)
- Conversión de tipos
- Operaciones con strings
- Entrada de datos del usuario

**Módulo 2: Operadores** (`02_operadores.py`)
- Operadores aritméticos
- Operadores de comparación
- Operadores lógicos (and, or, not)
- Operadores de asignación
- Precedencia de operadores

**Módulo 3: Estructuras de Control** (`03_estructuras_control.py`)
- Condicionales (if, elif, else)
- Operadores in y not in
- Operador ternario
- Ejemplos prácticos

**Módulo 4: Bucles** (`04_bucles.py`)
- Bucle for
- Función range()
- Bucle while
- break y continue
- Bucles anidados
- enumerate() y zip()
- List comprehension

**Módulo 5: Funciones** (`05_funciones.py`)
- Definir funciones
- Parámetros y argumentos
- Return
- Parámetros por defecto
- *args y **kwargs
- Scope de variables
- Funciones lambda

**Módulo 6: Estructuras de Datos** (`06_estructuras_datos.py`)
- Listas (lists)
- Tuplas (tuples)
- Diccionarios (dictionaries)
- Conjuntos (sets)
- Operaciones y métodos
- Cuándo usar cada estructura

---

### 📘 Nivel 2: Intermedio

**Módulo 1: Programación Orientada a Objetos** (`01_programacion_orientada_objetos.py`)
- Clases y objetos
- Atributos y métodos
- Constructor __init__
- Métodos especiales (__str__, __repr__, etc.)
- Herencia
- Encapsulamiento
- Polimorfismo
- Ejemplos prácticos

**Módulo 2: Manejo de Archivos** (`02_manejo_archivos.py`)
- Leer y escribir archivos
- Context manager (with)
- Trabajar con CSV
- Trabajar con JSON
- Pathlib para rutas
- Ejemplos prácticos

**Módulo 3: Excepciones** (`03_excepciones.py`)
- Try-except-finally
- Múltiples excepciones
- Excepciones personalizadas
- Raise y assert
- Buenas prácticas

---

### 📕 Nivel 3: Avanzado

**Módulo 1: Decoradores** (`01_decoradores.py`)
- Funciones como objetos
- Decoradores básicos
- Decoradores con argumentos
- @staticmethod y @classmethod
- Decoradores útiles
- Ejemplos prácticos

---

## 🚀 Cómo Usar Este Curso

### 1. Configuración Inicial

#### Instalar Python
```bash
# Verificar si Python está instalado
python --version
# o
python3 --version

# Si no está instalado, descárgalo de:
# https://www.python.org/downloads/
```

#### Instalar Visual Studio Code
1. Descarga VSCode: https://code.visualstudio.com/
2. Instala las siguientes extensiones:
   - **Python** (Microsoft) - Esencial
   - **Pylance** (Microsoft) - IntelliSense mejorado
   - **Python Indent** - Mejor indentación
   - **autoDocstring** - Generar docstrings automáticamente
   - **Better Comments** - Comentarios de colores

### 2. Configurar VSCode para Python

#### Abrir el curso en VSCode
```bash
# Desde la terminal
cd curso_python
code .
```

#### Configuración recomendada de VSCode

Crea un archivo `.vscode/settings.json` en la carpeta del curso:

```json
{
    "python.linting.enabled": true,
    "python.linting.pylintEnabled": true,
    "python.formatting.provider": "autopep8",
    "python.formatting.autopep8Args": [
        "--max-line-length=100"
    ],
    "editor.formatOnSave": true,
    "editor.rulers": [80, 100],
    "files.autoSave": "afterDelay",
    "files.autoSaveDelay": 1000,
    "python.terminal.activateEnvironment": true,
    "[python]": {
        "editor.tabSize": 4,
        "editor.insertSpaces": true,
        "editor.formatOnSave": true,
        "editor.codeActionsOnSave": {
            "source.organizeImports": true
        }
    }
}
```

### 3. Ejecutar los Archivos

#### Método 1: Desde VSCode
1. Abre el archivo `.py` que quieras estudiar
2. Haz clic derecho → "Run Python File in Terminal"
3. O presiona `F5` para ejecutar con debugging

#### Método 2: Desde la Terminal
```bash
# Ejecutar un archivo específico
python 01_principiante/01_variables_tipos_datos.py

# En algunos sistemas:
python3 01_principiante/01_variables_tipos_datos.py
```

### 4. Atajos de Teclado Útiles en VSCode

| Atajo | Acción |
|-------|--------|
| `Ctrl + /` | Comentar/descomentar línea |
| `Ctrl + Shift + P` | Paleta de comandos |
| `F5` | Iniciar debugging |
| `Ctrl + Space` | Autocompletado |
| `Ctrl + F` | Buscar en archivo |
| `Ctrl + H` | Buscar y reemplazar |
| `Alt + Up/Down` | Mover línea arriba/abajo |
| `Ctrl + D` | Seleccionar siguiente ocurrencia |
| `Ctrl + Shift + L` | Seleccionar todas las ocurrencias |

---

## 📖 Metodología de Estudio

### Ruta de Aprendizaje Recomendada

#### Semana 1-2: Fundamentos (Principiante)
- **Día 1-2**: Variables y tipos de datos
- **Día 3-4**: Operadores
- **Día 5-6**: Estructuras de control
- **Día 7-8**: Bucles
- **Día 9-10**: Funciones
- **Día 11-14**: Estructuras de datos + Ejercicios de repaso

#### Semana 3-4: Intermedio
- **Día 1-5**: Programación Orientada a Objetos
- **Día 6-8**: Manejo de archivos
- **Día 9-10**: Excepciones
- **Día 11-14**: Proyecto integrador + Ejercicios

#### Semana 5-6: Avanzado
- **Día 1-3**: Decoradores
- **Día 4-6**: Generadores y iteradores
- **Día 7-9**: Context managers
- **Día 10-14**: Programación asíncrona + Proyecto final

### Cómo Estudiar Cada Módulo

1. **Lee el código**: Lee todo el archivo antes de ejecutarlo
2. **Ejecuta el código**: Ejecuta el archivo completo
3. **Experimenta**: Modifica valores y observa los cambios
4. **Practica**: Intenta los ejercicios al final de cada módulo
5. **Crea tus propios ejemplos**: Aplica lo aprendido a problemas reales

### Consejos de Estudio

✅ **HACER:**
- Practica todos los días (aunque sea 30 minutos)
- Escribe el código tú mismo, no solo leas
- Experimenta con modificaciones
- Resuelve los ejercicios propuestos
- Crea tus propios proyectos pequeños
- Usa Google y Stack Overflow cuando te atasques

❌ **EVITAR:**
- Copiar y pegar sin entender
- Pasar al siguiente tema sin dominar el actual
- Memorizar sintaxis (mejor entender conceptos)
- Estudiar muchas horas sin práctica

---

## 💻 Debugging en VSCode

### Configurar Breakpoints
1. Haz clic en el margen izquierdo (junto al número de línea)
2. Aparecerá un punto rojo
3. Ejecuta con `F5`
4. El programa se detendrá en ese punto

### Panel de Debug
- **Variables**: Ver valores actuales
- **Watch**: Observar expresiones específicas
- **Call Stack**: Ver el flujo de ejecución
- **Debug Console**: Ejecutar código en tiempo real

### Controles de Debug
- `F5` - Continuar
- `F10` - Paso siguiente (over)
- `F11` - Paso dentro (into)
- `Shift + F11` - Salir (out)
- `Ctrl + Shift + F5` - Reiniciar
- `Shift + F5` - Detener

---

## 📝 Ejercicios y Proyectos

### Ejercicios por Módulo
Cada módulo incluye ejercicios al final. Resuélvelos para afianzar conocimientos.

### Proyectos Sugeridos

#### Principiante
1. **Calculadora**: Operaciones básicas con menú
2. **Lista de Tareas**: Agregar, eliminar, marcar completadas
3. **Juego de Adivinanza**: Adivinar número entre 1-100
4. **Conversor de Unidades**: Temperatura, moneda, distancia
5. **Calculadora de IMC**: Con interpretación de resultados

#### Intermedio
1. **Sistema de Inventario**: CRUD completo con archivos
2. **Gestor de Contactos**: Guardar en JSON, búsquedas
3. **Analizador de Texto**: Estadísticas de archivos de texto
4. **Sistema de Estudiantes**: Calificaciones, promedios, reportes
5. **API de Productos**: Simulación con clases y excepciones

#### Avanzado
1. **Web Scraper**: Extraer datos de sitios web
2. **Bot de Telegram**: Automatización de tareas
3. **Dashboard de Datos**: Visualización con bibliotecas
4. **Sistema de Login**: Autenticación, sesiones, decoradores
5. **API REST**: Crear tu propia API con Flask/FastAPI

---

## 🔧 Troubleshooting

### Python no se reconoce
```bash
# Windows: Agregar Python al PATH
# Durante instalación, marcar "Add Python to PATH"

# Verificar:
python --version
```

### ModuleNotFoundError
```bash
# Instalar módulos con pip
pip install nombre_modulo

# Ejemplo:
pip install requests
```

### Problemas de encoding
```python
# Siempre usar encoding UTF-8
with open("archivo.txt", "r", encoding="utf-8") as f:
    contenido = f.read()
```

### VSCode no encuentra Python
1. `Ctrl + Shift + P`
2. Buscar "Python: Select Interpreter"
3. Seleccionar la instalación de Python

---

## 📚 Recursos Adicionales

### Documentación Oficial
- [Python.org](https://www.python.org/)
- [Python Docs](https://docs.python.org/3/)
- [PEP 8 - Style Guide](https://pep8.org/)

### Práctica Interactiva
- [LeetCode](https://leetcode.com/) - Algoritmos
- [HackerRank](https://www.hackerrank.com/) - Práctica
- [Codewars](https://www.codewars.com/) - Desafíos
- [Python Tutor](https://pythontutor.com/) - Visualizador

### Comunidades
- [Stack Overflow](https://stackoverflow.com/questions/tagged/python)
- [Reddit r/learnpython](https://www.reddit.com/r/learnpython/)
- [Python Discord](https://pythondiscord.com/)

### Bibliotecas Populares para Aprender Después
- **Web**: Flask, Django, FastAPI
- **Data Science**: NumPy, Pandas, Matplotlib
- **Machine Learning**: Scikit-learn, TensorFlow
- **Automatización**: Selenium, BeautifulSoup
- **APIs**: Requests, aiohttp

---

## 🎯 Próximos Pasos

### Después de Completar el Curso

1. **Profundiza en un área específica**:
   - Desarrollo Web
   - Ciencia de Datos
   - Automatización
   - Machine Learning

2. **Contribuye a proyectos Open Source**:
   - Busca proyectos en GitHub
   - Lee código de otros desarrolladores
   - Contribuye con mejoras

3. **Crea tu portafolio**:
   - Proyectos personales en GitHub
   - Blog técnico
   - Certificaciones

4. **Nunca dejes de aprender**:
   - Python se actualiza constantemente
   - Nuevas bibliotecas y frameworks
   - Mejores prácticas evolucionan

---

## 📧 Contacto y Contribuciones

Si encuentras errores o tienes sugerencias:
- Abre un issue en el repositorio
- Envía un pull request con mejoras
- Comparte el curso con otros estudiantes

---

## 📄 Licencia

Este curso es de uso libre para aprendizaje personal y educativo.

---

## 🌟 Consejos Finales

> "La mejor manera de aprender a programar es programando."

1. **Sé constante**: 30 minutos diarios son mejor que 5 horas una vez a la semana
2. **Practica activamente**: No solo leas, escribe código
3. **No te rindas**: Es normal atascarse, forma parte del aprendizaje
4. **Construye proyectos**: Aplica lo aprendido a problemas reales
5. **Comparte tu conocimiento**: Enseñar refuerza tu aprendizaje

---

**¡Mucho éxito en tu viaje de aprendizaje de Python! 🚀🐍**

---

## Estructura del Curso

```
curso_python/
│
├── README.md (Este archivo)
│
├── 01_principiante/
│   ├── 01_variables_tipos_datos.py
│   ├── 02_operadores.py
│   ├── 03_estructuras_control.py
│   ├── 04_bucles.py
│   ├── 05_funciones.py
│   └── 06_estructuras_datos.py
│
├── 02_intermedio/
│   ├── 01_programacion_orientada_objetos.py
│   ├── 02_manejo_archivos.py
│   └── 03_excepciones.py
│
├── 03_avanzado/
│   └── 01_decoradores.py
│
└── proyectos_practicos/
    └── (tus proyectos aquí)
```
