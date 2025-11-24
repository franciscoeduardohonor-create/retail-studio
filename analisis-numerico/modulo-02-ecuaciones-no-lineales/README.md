# Módulo 2: Solución de Ecuaciones No Lineales

## 📚 Contenido

1. [Introducción](#introducción)
2. [Método de Bisección](#método-de-bisección)
3. [Método de Newton-Raphson](#método-de-newton-raphson)
4. [Método de la Secante](#método-de-la-secante)
5. [Método de Punto Fijo](#método-de-punto-fijo)
6. [Comparación de Métodos](#comparación-de-métodos)

---

## 🎯 Objetivos de Aprendizaje

- Entender el problema de encontrar raíces de funciones no lineales
- Implementar y analizar diferentes métodos numéricos
- Comprender las ventajas y limitaciones de cada método
- Aplicar criterios de convergencia apropiados
- Elegir el método más adecuado según el problema

---

## 1. Introducción

### El Problema

Encontrar x tal que f(x) = 0, donde f es una función no lineal.

**Ejemplos**:
- x³ - 2x - 5 = 0
- cos(x) - x = 0
- e^x - 3x = 0

En general, **no existen fórmulas analíticas** para resolver estas ecuaciones.
Necesitamos **métodos numéricos iterativos**.

### Conceptos Clave

**Raíz o cero**: Valor x* tal que f(x*) = 0

**Convergencia**: La sucesión {xₙ} converge a x* si lim(n→∞) xₙ = x*

**Orden de convergencia**:
- Lineal: |eₙ₊₁| ≈ C|eₙ| (C < 1)
- Cuadrático: |eₙ₊₁| ≈ C|eₙ|²
- Superlineal: entre lineal y cuadrático

---

## 2. Método de Bisección

### Descripción

Método robusto basado en el **Teorema del Valor Intermedio**:
Si f(a)·f(b) < 0, entonces existe al menos una raíz en [a,b].

### Algoritmo

```
1. Verificar que f(a)·f(b) < 0
2. c = (a + b) / 2
3. Si f(c) = 0 o |b-a| < tolerancia, retornar c
4. Si f(a)·f(c) < 0:
      b = c
   Si no:
      a = c
5. Repetir desde paso 2
```

### Características

✅ **Ventajas**:
- Siempre converge (si hay cambio de signo)
- Muy robusto
- Error predecible: |eₙ| ≤ (b-a)/2ⁿ

❌ **Desventajas**:
- Convergencia lenta (lineal)
- Requiere cambio de signo
- No aprovecha información de la derivada

### Convergencia

**Orden**: Lineal
**Iteraciones para precisión ε**: n ≥ log₂((b-a)/ε)

---

## 3. Método de Newton-Raphson

### Descripción

Método muy eficiente que usa la derivada de la función.
Aproxima la función por su tangente.

### Fórmula

```
xₙ₊₁ = xₙ - f(xₙ)/f'(xₙ)
```

### Interpretación Geométrica

La tangente en (xₙ, f(xₙ)) cruza el eje x en xₙ₊₁.

### Algoritmo

```
1. Elegir x₀ (estimación inicial)
2. Mientras |f(xₙ)| > tolerancia:
     xₙ₊₁ = xₙ - f(xₙ)/f'(xₙ)
     n = n + 1
3. Retornar xₙ₊₁
```

### Características

✅ **Ventajas**:
- Convergencia cuadrática (muy rápida)
- Muy eficiente cerca de la raíz

❌ **Desventajas**:
- Requiere calcular la derivada
- Puede diverger si x₀ está mal elegido
- Problemas si f'(x) ≈ 0

### Condiciones de Convergencia

- x₀ suficientemente cerca de la raíz
- f'(x*) ≠ 0 (raíz simple)
- f' y f'' continuas cerca de x*

---

## 4. Método de la Secante

### Descripción

Similar a Newton-Raphson pero **aproxima la derivada** usando dos puntos.

### Fórmula

```
xₙ₊₁ = xₙ - f(xₙ)·(xₙ - xₙ₋₁)/(f(xₙ) - f(xₙ₋₁))
```

### Características

✅ **Ventajas**:
- No requiere calcular la derivada
- Convergencia superlineal (orden ≈ 1.618)
- Más rápido que bisección

❌ **Desventajas**:
- Requiere dos puntos iniciales
- Puede diverger
- Más lento que Newton-Raphson

---

## 5. Método de Punto Fijo

### Descripción

Reformula f(x) = 0 como x = g(x) y encuentra el punto fijo.

### Algoritmo

```
1. Reescribir f(x) = 0 como x = g(x)
2. Elegir x₀
3. xₙ₊₁ = g(xₙ)
4. Repetir hasta convergencia
```

### Condición de Convergencia

El método converge si |g'(x)| < 1 cerca de la raíz.

### Ejemplos de Reformulación

Para f(x) = x² - 2 = 0:
- g₁(x) = 2/x (converge)
- g₂(x) = x² (diverge)
- g₃(x) = (x + 2/x)/2 (converge, es Newton!)

---

## 6. Comparación de Métodos

| Método | Convergencia | Evaluaciones/iter | Requiere derivada | Robustez |
|--------|--------------|-------------------|-------------------|----------|
| Bisección | Lineal | 1 | No | Alta |
| Newton-Raphson | Cuadrática | 2 (f y f') | Sí | Media |
| Secante | ~1.618 | 1 | No | Media |
| Punto Fijo | Variable | 1 | No | Baja |

### Cuándo usar cada método

**Bisección**:
- Cuando necesitas garantía de convergencia
- Para localizar raíces aproximadas
- Cuando la función es costosa de evaluar

**Newton-Raphson**:
- Cuando tienes buena estimación inicial
- Cuando puedes calcular f' eficientemente
- Cuando necesitas alta precisión rápidamente

**Secante**:
- Cuando f' es difícil de calcular
- Como alternativa a Newton-Raphson
- Para funciones suaves

**Punto Fijo**:
- Cuando tienes una reformulación conveniente
- Para análisis teórico
- En problemas con estructura especial

---

## 💻 Ejemplos Prácticos

### Ejemplos en C++
1. [biseccion.cpp](./ejemplos_cpp/biseccion.cpp) - Método de bisección
2. [newton_raphson.cpp](./ejemplos_cpp/newton_raphson.cpp) - Método de Newton-Raphson
3. [secante.cpp](./ejemplos_cpp/secante.cpp) - Método de la secante
4. [punto_fijo.cpp](./ejemplos_cpp/punto_fijo.cpp) - Método de punto fijo
5. [comparacion_metodos.cpp](./ejemplos_cpp/comparacion_metodos.cpp) - Comparación de todos

### Ejemplos en Python
1. [biseccion.py](./ejemplos_python/biseccion.py) - Método de bisección con gráficas
2. [newton_raphson.py](./ejemplos_python/newton_raphson.py) - Newton-Raphson visual
3. [secante.py](./ejemplos_python/secante.py) - Método de la secante
4. [comparacion_visual.py](./ejemplos_python/comparacion_visual.py) - Comparación visual

---

## 🎯 Ejercicios Propuestos

### Nivel Básico
1. Encuentra √2 resolviendo x² - 2 = 0 con bisección
2. Encuentra π resolviendo sin(x) = 0 con Newton-Raphson (x₀ = 3)
3. Compara la velocidad de convergencia de bisección vs Newton

### Nivel Intermedio
4. Implementa un método híbrido: bisección para localizar + Newton para refinar
5. Encuentra todas las raíces de x³ - 7x + 6 = 0
6. Resuelve cos(x) = x con diferentes métodos y compara

### Nivel Avanzado
7. Implementa Newton con búsqueda de línea (line search)
8. Encuentra raíces múltiples de (x-1)² = 0 (modificar Newton)
9. Implementa el método de Brent (combinación de bisección y secante)

[Ver soluciones](./ejercicios/soluciones/)

---

## 🔑 Conceptos Clave

- Los métodos iterativos generan sucesiones que **convergen** a la raíz
- **Bisección** es lento pero robusto
- **Newton-Raphson** es rápido pero requiere derivada y buena inicial
- **Secante** es compromiso entre bisección y Newton
- El **orden de convergencia** determina la rapidez
- Siempre usar **criterios de parada** apropiados

---

## 📖 Referencias

- Burden & Faires, "Numerical Analysis", Capítulo 2
- Numerical Recipes, Capítulo 9
- Heath, "Scientific Computing", Capítulo 5

---

**Anterior**: [Módulo 1: Errores Numéricos](../modulo-01-errores/)
**Siguiente**: [Módulo 3: Sistemas Lineales](../modulo-03-sistemas-lineales/)
