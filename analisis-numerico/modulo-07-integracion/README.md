# Módulo 7: Integración Numérica

## 📚 Contenido

1. [Introducción](#introducción)
2. [Regla del Trapecio](#regla-del-trapecio)
3. [Regla de Simpson](#regla-de-simpson)
4. [Cuadratura de Gauss](#cuadratura-de-gauss)
5. [Métodos Adaptativos](#métodos-adaptativos)
6. [Integración de Monte Carlo](#integración-de-monte-carlo)

---

## 🎯 Objetivos de Aprendizaje

- Aproximar integrales definidas numéricamente
- Implementar y comparar diferentes métodos de integración
- Entender el error de cuadratura
- Aplicar métodos adaptativos para mejorar precisión
- Calcular integrales múltiples

---

## 1. Introducción

### El Problema

Calcular:
```
∫ᵇₐ f(x) dx
```

donde f(x) puede:
- No tener antiderivada cerrada (e.g., e^(-x²))
- Ser costosa de integrar analíticamente
- Estar definida solo por puntos (datos experimentales)

### Idea General

Aproximar el área bajo la curva usando formas geométricas simples:
- Rectángulos
- Trapecios
- Parábolas

---

## 2. Regla del Trapecio

### Fórmula Simple

```
∫ᵇₐ f(x) dx ≈ (b-a)/2 · [f(a) + f(b)]
```

Aproxima el área por un trapecio.

### Regla del Trapecio Compuesta

Divide [a,b] en n subintervalos:

```
∫ᵇₐ f(x) dx ≈ h/2 · [f(x₀) + 2f(x₁) + 2f(x₂) + ... + 2f(xₙ₋₁) + f(xₙ)]
```

donde h = (b-a)/n

### Error

```
Error = -(b-a)³/(12n²) · f''(ξ)
```

- Error es O(h²)
- Exacto para funciones lineales

---

## 3. Regla de Simpson

### Regla de Simpson 1/3

Aproxima f(x) por parábolas (polinomios de grado 2).

```
∫ˣ²ₓ₀ f(x) dx ≈ h/3 · [f(x₀) + 4f(x₁) + f(x₂)]
```

donde h = (x₂ - x₀)/2

### Regla de Simpson Compuesta

Para n intervalos (n debe ser par):

```
∫ᵇₐ f(x) dx ≈ h/3 · [f(x₀) + 4f(x₁) + 2f(x₂) + 4f(x₃) + ... + 4f(xₙ₋₁) + f(xₙ)]
```

Patrón: 1, 4, 2, 4, 2, ..., 4, 1

### Error

```
Error = -(b-a)⁵/(180n⁴) · f⁽⁴⁾(ξ)
```

- Error es O(h⁴)
- Exacto para polinomios de grado ≤ 3

---

## 4. Cuadratura de Gauss

### Idea

Elegir **óptimamente** los puntos de evaluación y sus pesos.

### Cuadratura de Gauss con 2 puntos

```
∫¹₋₁ f(x) dx ≈ f(-1/√3) + f(1/√3)
```

Exacto para polinomios de grado ≤ 3 con solo 2 evaluaciones.

### Transformación al Intervalo [a,b]

```
∫ᵇₐ f(x) dx = (b-a)/2 · ∫¹₋₁ f((b-a)t/2 + (b+a)/2) dt
```

### Puntos y Pesos de Gauss

| n puntos | Grado exacto |
|----------|--------------|
| 1        | 1            |
| 2        | 3            |
| 3        | 5            |
| n        | 2n-1         |

---

## 5. Métodos Adaptativos

### Problema

Algunas funciones necesitan más puntos en ciertas regiones.

### Integración Adaptativa de Simpson

1. Calcular I₁ = Simpson(a,b) con paso h
2. Calcular I₂ = Simpson(a,c) + Simpson(c,b) con paso h/2, c=(a+b)/2
3. Si |I₂ - I₁| < tolerancia: aceptar I₂
4. Si no: recursivamente aplicar a [a,c] y [c,b]

### Ventajas

- Concentra puntos donde la función varía rápidamente
- Automáticamente ajusta el paso
- Más eficiente que métodos de paso fijo

---

## 6. Integración de Monte Carlo

### Idea

Usar números aleatorios para estimar integrales.

### Método Básico

```
∫ᵇₐ f(x) dx ≈ (b-a) · (1/N) · Σf(xᵢ)
```

donde xᵢ son puntos aleatorios en [a,b]

### Ventajas

- Excelente para integrales múltiples de alta dimensión
- Error ∝ 1/√N independiente de la dimensión
- Simple de implementar

### Desventajas

- Convergencia lenta (O(1/√N))
- No aprovecha suavidad de f

---

## 💻 Ejemplos Prácticos

### Ejemplos en C++
1. [trapecio.cpp](./ejemplos_cpp/trapecio.cpp) - Regla del trapecio
2. [simpson.cpp](./ejemplos_cpp/simpson.cpp) - Regla de Simpson
3. [gauss.cpp](./ejemplos_cpp/gauss.cpp) - Cuadratura de Gauss
4. [adaptativa.cpp](./ejemplos_cpp/adaptativa.cpp) - Integración adaptativa
5. [comparacion.cpp](./ejemplos_cpp/comparacion.cpp) - Comparación de métodos

### Ejemplos en Python
1. [metodos_basicos.py](./ejemplos_python/metodos_basicos.py) - Trapecio y Simpson
2. [visualizacion.py](./ejemplos_python/visualizacion.py) - Visualización de métodos
3. [monte_carlo.py](./ejemplos_python/monte_carlo.py) - Integración Monte Carlo
4. [aplicaciones.py](./ejemplos_python/aplicaciones.py) - Aplicaciones prácticas

---

## 🎯 Ejercicios Propuestos

### Nivel Básico
1. Calcula ∫₀¹ x² dx con trapecio y Simpson, compara con valor exacto
2. Implementa la regla del punto medio
3. Compara error de trapecio vs Simpson para diferentes n

### Nivel Intermedio
4. Calcula ∫₀^∞ e^(-x²) dx (aproxima ∞ por un valor grande)
5. Implementa cuadratura de Gauss con 3 puntos
6. Calcula la longitud de arco de una curva

### Nivel Avanzado
7. Implementa integración adaptativa de Simpson
8. Calcula una integral doble: ∫₀¹∫₀¹ e^(xy) dx dy
9. Usa Monte Carlo para calcular π

---

## 🔑 Conceptos Clave

- Los métodos de **cuadratura** aproximan integrales por sumas ponderadas
- **Trapecio**: O(h²), simple pero lento
- **Simpson**: O(h⁴), mejor precisión
- **Gauss**: Óptimo para número fijo de evaluaciones
- **Adaptativos**: Ajustan automáticamente el paso
- **Monte Carlo**: Ideal para alta dimensión

---

## 📖 Referencias

- Burden & Faires, "Numerical Analysis", Capítulo 4
- Numerical Recipes, Capítulo 4
- Atkinson, "An Introduction to Numerical Analysis"

---

**Anterior**: [Módulo 6: Diferenciación Numérica](../modulo-06-diferenciacion/)
**Siguiente**: [Módulo 8: Ecuaciones Diferenciales](../modulo-08-edos/)
