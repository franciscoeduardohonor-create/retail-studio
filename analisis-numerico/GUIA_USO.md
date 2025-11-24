# 📘 Guía de Uso del Curso de Análisis Numérico

## 🎯 Introducción

Esta guía te ayudará a compilar y ejecutar todos los programas del curso, tanto en C++ como en Python.

---

## 📋 Requisitos Previos

### Para C++

#### Linux/Mac:
```bash
# Instalar compilador g++
sudo apt-get install g++        # Ubuntu/Debian
sudo yum install gcc-c++        # RedHat/CentOS
brew install gcc                # macOS (con Homebrew)

# Verificar instalación
g++ --version
```

#### Windows:
- Instalar MinGW o MSYS2
- O usar Visual Studio con soporte de C++

### Para Python

```bash
# Python 3.7 o superior
python --version

# Instalar dependencias
pip install numpy scipy matplotlib
```

---

## 🔧 Compilación de Programas C++

### Compilación Simple

Para compilar un programa individual:

```bash
cd analisis-numerico/modulo-XX-NOMBRE/ejemplos_cpp/
g++ -o programa programa.cpp -std=c++11
./programa
```

### Ejemplo Completo - Módulo 1

```bash
# Navegar al directorio
cd analisis-numerico/modulo-01-errores/ejemplos_cpp/

# Compilar epsilon_maquina.cpp
g++ -o epsilon_maquina epsilon_maquina.cpp -std=c++11

# Ejecutar
./epsilon_maquina

# Compilar errores_basicos.cpp
g++ -o errores_basicos errores_basicos.cpp -std=c++11
./errores_basicos

# Compilar cancelacion_catastrofica.cpp
g++ -o cancelacion cancelacion_catastrofica.cpp -std=c++11
./cancelacion
```

### Compilación con Optimización

Para mejor rendimiento:

```bash
g++ -o programa programa.cpp -std=c++11 -O2 -Wall
```

Flags explicados:
- `-std=c++11`: Usar estándar C++11
- `-O2`: Optimización nivel 2
- `-Wall`: Mostrar todas las advertencias
- `-lm`: Enlazar librería matemática (si es necesario)

### Compilación de Todos los Programas de un Módulo

Script de ejemplo para compilar todo el Módulo 2:

```bash
#!/bin/bash
cd analisis-numerico/modulo-02-ecuaciones-no-lineales/ejemplos_cpp/

echo "Compilando Módulo 2..."

g++ -o biseccion biseccion.cpp -std=c++11 -O2
g++ -o newton newton_raphson.cpp -std=c++11 -O2

echo "Compilación completa. Ejecutar con:"
echo "  ./biseccion"
echo "  ./newton"
```

---

## 🐍 Ejecución de Programas Python

### Ejecutar Directamente

```bash
cd analisis-numerico/modulo-01-errores/ejemplos_python/
python errores_basicos.py
```

### Crear Entorno Virtual (Recomendado)

```bash
# Crear entorno virtual
python -m venv venv_analisis

# Activar
source venv_analisis/bin/activate  # Linux/Mac
venv_analisis\Scripts\activate     # Windows

# Instalar dependencias
pip install numpy scipy matplotlib

# Ejecutar programas
python errores_basicos.py
```

### Ejemplo con Visualizaciones

```bash
cd analisis-numerico/modulo-02-ecuaciones-no-lineales/ejemplos_python/
python comparacion_visual.py

# Las gráficas se guardarán como archivos PNG y se mostrarán en ventanas
```

---

## 📚 Estructura de Cada Módulo

```
modulo-XX-nombre/
├── README.md                 # Teoría y explicaciones
├── ejemplos_cpp/             # Ejemplos en C++
│   ├── programa1.cpp
│   ├── programa2.cpp
│   └── ...
├── ejemplos_python/          # Ejemplos en Python
│   ├── programa1.py
│   ├── programa2.py
│   └── ...
└── ejercicios/               # Ejercicios propuestos
    └── soluciones/           # Soluciones a ejercicios
```

---

## 🚀 Ruta de Aprendizaje Recomendada

### 1️⃣ **Semana 1-2: Fundamentos**

**Módulo 1: Errores Numéricos**
```bash
# C++
cd modulo-01-errores/ejemplos_cpp/
g++ -o epsilon epsilon_maquina.cpp -std=c++11 && ./epsilon
g++ -o errores errores_basicos.cpp -std=c++11 && ./errores
g++ -o cancelacion cancelacion_catastrofica.cpp -std=c++11 && ./cancelacion

# Python
cd ../ejemplos_python/
python errores_basicos.py
```

**Conceptos clave a dominar:**
- ✅ Epsilon de máquina
- ✅ Error absoluto vs relativo
- ✅ Cancelación catastrófica
- ✅ Propagación de errores

### 2️⃣ **Semana 3-4: Ecuaciones No Lineales**

**Módulo 2: Ecuaciones No Lineales**
```bash
# C++
cd modulo-02-ecuaciones-no-lineales/ejemplos_cpp/
g++ -o biseccion biseccion.cpp -std=c++11 && ./biseccion
g++ -o newton newton_raphson.cpp -std=c++11 && ./newton

# Python con visualización
cd ../ejemplos_python/
python comparacion_visual.py
```

**Conceptos clave:**
- ✅ Método de Bisección
- ✅ Método de Newton-Raphson
- ✅ Convergencia cuadrática
- ✅ Análisis de errores

**Ejercicio práctico:**
Implementa un método híbrido que use bisección para localizar la raíz y luego Newton-Raphson para refinar.

### 3️⃣ **Semana 5-6: Integración Numérica**

**Módulo 7: Integración**
```bash
cd modulo-07-integracion/ejemplos_cpp/
g++ -o integracion metodos_integracion.cpp -std=c++11 -O2 && ./integracion
```

**Conceptos clave:**
- ✅ Regla del Trapecio
- ✅ Regla de Simpson
- ✅ Cuadratura de Gauss
- ✅ Métodos adaptativos

**Ejercicio práctico:**
Calcula π usando integración numérica de 4∫₀¹ √(1-x²) dx

### 4️⃣ **Semana 7-8: Ecuaciones Diferenciales**

**Módulo 8: EDOs**
```bash
cd modulo-08-edos/ejemplos_cpp/
g++ -o edos metodos_edos.cpp -std=c++11 -O2 && ./edos
```

**Conceptos clave:**
- ✅ Método de Euler
- ✅ Runge-Kutta 4 (RK4)
- ✅ Sistemas de EDOs
- ✅ Aplicaciones físicas

**Proyecto final:**
Simula el movimiento de un péndulo simple con fricción.

---

## 💡 Consejos para Aprender Efectivamente

### 1. **Lee el Código Antes de Ejecutarlo**
```bash
# Usa less o cat para leer el código primero
less programa.cpp

# Luego compila y ejecuta
g++ -o programa programa.cpp -std=c++11 && ./programa
```

### 2. **Modifica y Experimenta**
- Cambia parámetros (tolerancia, número de iteraciones, paso h)
- Prueba diferentes funciones
- Compara resultados

### 3. **Compara C++ y Python**
```bash
# Ejecuta la versión C++
cd ejemplos_cpp/
g++ -o programa programa.cpp -std=c++11 && time ./programa

# Ejecuta la versión Python
cd ../ejemplos_python/
time python programa.py

# Compara velocidad y precisión
```

### 4. **Usa Gráficas para Entender**
```python
# Los programas Python generan visualizaciones
# Estúdialas para entender la convergencia
python comparacion_visual.py  # Genera gráficas
```

### 5. **Resuelve los Ejercicios**
Cada módulo tiene ejercicios propuestos. Intenta resolverlos antes de ver las soluciones.

---

## 🐛 Solución de Problemas Comunes

### Error: "g++: command not found"
```bash
# Instalar g++
sudo apt-get install g++  # Linux
brew install gcc          # macOS
```

### Error: "undefined reference to 'sqrt'"
```bash
# Añadir flag -lm para enlazar matemáticas
g++ -o programa programa.cpp -std=c++11 -lm
```

### Error: "No module named 'numpy'"
```bash
# Instalar numpy
pip install numpy matplotlib scipy
```

### Programa C++ Crashea
```bash
# Compilar con información de depuración
g++ -o programa programa.cpp -std=c++11 -g

# Ejecutar con gdb
gdb ./programa
```

### Gráficas No Aparecen en Python
```python
# Añadir al final del script
plt.show()  # Asegúrate de que esta línea esté presente
```

---

## 📊 Generación de Datos para Graficar

Muchos programas C++ pueden generar datos para graficar:

```cpp
// Guardar datos en archivo
ofstream file("datos.txt");
for (int i = 0; i < n; i++) {
    file << x[i] << " " << y[i] << "\n";
}
file.close();
```

Luego graficar con Python:
```python
import matplotlib.pyplot as plt
import numpy as np

# Leer datos
data = np.loadtxt('datos.txt')
x = data[:, 0]
y = data[:, 1]

# Graficar
plt.plot(x, y, 'o-')
plt.xlabel('x')
plt.ylabel('y')
plt.grid(True)
plt.show()
```

O con gnuplot:
```bash
gnuplot
> plot 'datos.txt' with linespoints
```

---

## 🎓 Proyectos Sugeridos

### Proyecto 1: Calculadora de Raíces
Crea un programa que:
- Permita al usuario elegir el método (bisección, Newton, secante)
- Ingrese una función (como string)
- Encuentre todas las raíces en un intervalo
- Grafique la función y las raíces encontradas

### Proyecto 2: Simulador de Población
- Implementa varios modelos (exponencial, logístico, depredador-presa)
- Compara diferentes métodos (Euler, RK2, RK4)
- Visualiza la evolución temporal
- Analiza estabilidad

### Proyecto 3: Biblioteca de Análisis Numérico
Crea tu propia biblioteca con:
```cpp
// analisis_numerico.h
namespace AnalisisNumerico {
    double biseccion(function<double(double)> f, double a, double b);
    double newton(function<double(double)> f, function<double(double)> df, double x0);
    double simpson(function<double(double)> f, double a, double b, int n);
    SolucionEDO rk4(FuncionEDO f, double x0, double y0, double h, int n);
}
```

---

## 📖 Recursos Adicionales

### Libros Recomendados
1. "Numerical Analysis" - Burden & Faires
2. "Numerical Recipes in C++" - Press et al.
3. "Introduction to Numerical Analysis" - Stoer & Bulirsch

### Videos y Tutoriales
- 3Blue1Brown (YouTube) - Visualizaciones matemáticas
- MIT OpenCourseWare - Numerical Methods
- Khan Academy - Cálculo y Álgebra Lineal

### Herramientas Online
- WolframAlpha - Verificar resultados
- Desmos - Graficar funciones
- Compiler Explorer - Analizar código C++

---

## 🤝 Contribuciones y Feedback

Si encuentras errores o tienes sugerencias:
1. Revisa el código cuidadosamente
2. Intenta diferentes parámetros
3. Compara con soluciones analíticas cuando sea posible
4. Documenta tus experimentos

---

## ✅ Checklist de Progreso

Marca cada módulo a medida que lo completes:

- [ ] Módulo 1: Errores Numéricos
  - [ ] Entiendo el epsilon de máquina
  - [ ] Puedo calcular errores absolutos y relativos
  - [ ] Reconozco la cancelación catastrófica

- [ ] Módulo 2: Ecuaciones No Lineales
  - [ ] Implementé bisección
  - [ ] Implementé Newton-Raphson
  - [ ] Comprendo la convergencia cuadrática

- [ ] Módulo 7: Integración Numérica
  - [ ] Implementé trapecio y Simpson
  - [ ] Entiendo cuadratura de Gauss
  - [ ] Puedo usar métodos adaptativos

- [ ] Módulo 8: EDOs
  - [ ] Implementé Euler y RK4
  - [ ] Resolví sistemas de EDOs
  - [ ] Simulé un sistema físico real

---

**¡Éxito en tu aprendizaje del Análisis Numérico!** 🚀

Para preguntas o dudas, revisa primero los comentarios en el código y la teoría en los README de cada módulo.
