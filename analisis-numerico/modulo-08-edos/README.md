# Módulo 8: Ecuaciones Diferenciales Ordinarias (EDOs)

## 📚 Contenido

1. [Introducción](#introducción)
2. [Método de Euler](#método-de-euler)
3. [Métodos de Runge-Kutta](#métodos-de-runge-kutta)
4. [Sistemas de EDOs](#sistemas-de-edos)
5. [Problemas de Orden Superior](#problemas-de-orden-superior)
6. [Estabilidad y Rigidez](#estabilidad-y-rigidez)

---

## 🎯 Objetivos de Aprendizaje

- Resolver EDOs numéricamente
- Implementar métodos de Euler y Runge-Kutta
- Resolver sistemas de EDOs
- Entender estabilidad y precisión de métodos
- Aplicar a problemas físicos reales

---

## 1. Introducción

### El Problema

Resolver el **problema de valor inicial (PVI)**:

```
dy/dx = f(x, y)
y(x₀) = y₀
```

Queremos encontrar y(x) para x en [x₀, xₙ].

### Ejemplos de Aplicación

- **Física**: Movimiento de proyectiles, circuitos eléctricos
- **Biología**: Crecimiento poblacional, epidemias
- **Química**: Reacciones químicas
- **Ingeniería**: Sistemas de control, vibraciones

### Métodos Numéricos

Los métodos generan una secuencia de aproximaciones:
```
y₀, y₁, y₂, ..., yₙ
```
en puntos
```
x₀, x₁, x₂, ..., xₙ
```

---

## 2. Método de Euler

### Idea

Aproximar la derivada por diferencias finitas y avanzar paso a paso.

### Fórmula

```
yₙ₊₁ = yₙ + h·f(xₙ, yₙ)
```

donde h = paso (Δx)

### Interpretación Geométrica

Seguir la tangente en cada punto:
- En (xₙ, yₙ), la tangente tiene pendiente f(xₙ, yₙ)
- Avanzamos siguiendo la tangente una distancia h

### Algoritmo

```
Entrada: f, x₀, y₀, h, N (número de pasos)
Para n = 0, 1, ..., N-1:
    yₙ₊₁ = yₙ + h·f(xₙ, yₙ)
    xₙ₊₁ = xₙ + h
Salida: (x₁, y₁), (x₂, y₂), ..., (xₙ, yₙ)
```

### Error

- **Error local**: O(h²) por paso
- **Error global**: O(h) total
- Método de **primer orden**

### Ventajas y Desventajas

✅ **Ventajas**:
- Muy simple de implementar
- Bajo costo computacional
- Intuitivo geométricamente

❌ **Desventajas**:
- Baja precisión (error O(h))
- Puede ser inestable
- Requiere pasos pequeños

---

## 3. Métodos de Runge-Kutta

### Runge-Kutta de Orden 2 (RK2)

También llamado método del punto medio mejorado.

```
k₁ = h·f(xₙ, yₙ)
k₂ = h·f(xₙ + h/2, yₙ + k₁/2)
yₙ₊₁ = yₙ + k₂
```

- Error local: O(h³)
- Error global: O(h²)

### Runge-Kutta de Orden 4 (RK4)

El método más popular para EDOs. Balance perfecto entre precisión y eficiencia.

```
k₁ = h·f(xₙ, yₙ)
k₂ = h·f(xₙ + h/2, yₙ + k₁/2)
k₃ = h·f(xₙ + h/2, yₙ + k₂/2)
k₄ = h·f(xₙ + h, yₙ + k₃)

yₙ₊₁ = yₙ + (k₁ + 2k₂ + 2k₃ + k₄)/6
```

### Interpretación

RK4 es un **promedio ponderado** de pendientes:
- k₁: pendiente al inicio
- k₂, k₃: pendientes en el punto medio (ponderadas ×2)
- k₄: pendiente al final

### Error

- **Error local**: O(h⁵)
- **Error global**: O(h⁴)
- Método de **cuarto orden**

### ¿Por qué RK4 es tan popular?

- Excelente precisión con paso razonable
- No requiere derivadas de f
- Estable para la mayoría de problemas
- Balance ideal costo/precisión

---

## 4. Sistemas de EDOs

### Problema

Resolver:
```
dy₁/dx = f₁(x, y₁, y₂, ..., yₙ)
dy₂/dx = f₂(x, y₁, y₂, ..., yₙ)
...
dyₙ/dx = fₙ(x, y₁, y₂, ..., yₙ)

Condiciones iniciales: y₁(x₀), y₂(x₀), ..., yₙ(x₀)
```

### Forma Vectorial

```
dy/dx = f(x, y)
```

donde **y** y **f** son vectores.

### RK4 para Sistemas

El mismo algoritmo, pero con vectores:

```
k₁ = h·f(xₙ, yₙ)
k₂ = h·f(xₙ + h/2, yₙ + k₁/2)
k₃ = h·f(xₙ + h/2, yₙ + k₂/2)
k₄ = h·f(xₙ + h, yₙ + k₃)

yₙ₊₁ = yₙ + (k₁ + 2k₂ + 2k₃ + k₄)/6
```

---

## 5. Problemas de Orden Superior

### Reducción a Sistema de Primer Orden

Una EDO de orden n:
```
y⁽ⁿ⁾ = f(x, y, y', y'', ..., y⁽ⁿ⁻¹⁾)
```

se reduce a un sistema de n ecuaciones de primer orden.

### Ejemplo: Ecuación de Segundo Orden

```
y'' = f(x, y, y')
y(x₀) = y₀
y'(x₀) = v₀
```

Definir: y₁ = y, y₂ = y'

Sistema equivalente:
```
y₁' = y₂
y₂' = f(x, y₁, y₂)

y₁(x₀) = y₀
y₂(x₀) = v₀
```

---

## 6. Estabilidad y Rigidez

### Estabilidad

Un método es **estable** si pequeños errores no se amplifican descontroladamente.

### Problemas Rígidos (Stiff)

EDOs donde:
- La solución varía lentamente
- Pero pequeñas perturbaciones decaen rápidamente

Características:
- Requieren pasos muy pequeños con métodos explícitos
- Mejor usar métodos implícitos (no cubierto aquí)

### Ejemplo de Rigidez

```
y' = -1000y + 3000 - 2000e⁻ˣ
y(0) = 0
```

Solución: y = 3 - 0.998e⁻¹⁰⁰⁰ˣ - 2.002e⁻ˣ

El término e⁻¹⁰⁰⁰ˣ decae muy rápido, causando rigidez.

---

## 💻 Ejemplos Prácticos

### Ejemplos en C++
1. [euler.cpp](./ejemplos_cpp/euler.cpp) - Método de Euler
2. [rk4.cpp](./ejemplos_cpp/rk4.cpp) - Runge-Kutta 4
3. [comparacion_metodos.cpp](./ejemplos_cpp/comparacion_metodos.cpp) - Comparación
4. [sistemas.cpp](./ejemplos_cpp/sistemas.cpp) - Sistemas de EDOs
5. [pendulo.cpp](./ejemplos_cpp/pendulo.cpp) - Péndulo simple

### Ejemplos en Python
1. [metodos_basicos.py](./ejemplos_python/metodos_basicos.py) - Euler y RK4
2. [visualizacion.py](./ejemplos_python/visualizacion.py) - Gráficas de soluciones
3. [sistema_depredador_presa.py](./ejemplos_python/sistema_depredador_presa.py) - Modelo de Lotka-Volterra
4. [oscilador_armonico.py](./ejemplos_python/oscilador_armonico.py) - Sistema masa-resorte

---

## 🎯 Ejercicios Propuestos

### Nivel Básico
1. Resuelve y' = y, y(0) = 1 con Euler y compara con y = eˣ
2. Implementa RK2 (punto medio mejorado)
3. Compara error de Euler vs RK4 para diferentes h

### Nivel Intermedio
4. Resuelve el crecimiento logístico: y' = ry(1 - y/K)
5. Implementa el oscilador armónico: y'' + ω²y = 0
6. Resuelve el sistema depredador-presa (Lotka-Volterra)

### Nivel Avanzado
7. Simula el péndulo con fricción: θ'' + bθ' + (g/L)sin(θ) = 0
8. Resuelve el problema de tres cuerpos (versión simplificada)
9. Implementa control de paso adaptativo

---

## 🔑 Conceptos Clave

- **Euler**: Simple, error O(h), útil para prototipado
- **RK4**: Estándar de facto, error O(h⁴), excelente precisión
- EDOs de orden superior se reducen a **sistemas de primer orden**
- El **paso h** determina precisión y estabilidad
- Verificar soluciones con **conservación de energía** cuando aplique

---

## 📖 Referencias

- Burden & Faires, "Numerical Analysis", Capítulo 5
- Numerical Recipes, Capítulo 16
- Press et al., "Numerical Recipes in C++"
- Hairer, Nørsett, Wanner, "Solving Ordinary Differential Equations"

---

**Anterior**: [Módulo 7: Integración Numérica](../modulo-07-integracion/)
**Siguiente**: [Módulo 9: Temas Avanzados](../modulo-09-avanzado/)
