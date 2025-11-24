# Módulo 1: Introducción y Errores Numéricos

## 📚 Contenido

1. [Representación de Números en Computadora](#representación-de-números)
2. [Tipos de Errores](#tipos-de-errores)
3. [Error Absoluto y Relativo](#error-absoluto-y-relativo)
4. [Propagación de Errores](#propagación-de-errores)
5. [Estabilidad Numérica](#estabilidad-numérica)

---

## 🎯 Objetivos de Aprendizaje

- Entender cómo se representan los números en una computadora
- Identificar y cuantificar diferentes tipos de errores
- Calcular error absoluto y relativo
- Comprender la propagación de errores en cálculos
- Reconocer problemas numéricamente inestables

---

## 1. Representación de Números en Computadora

### Sistema de Punto Flotante (IEEE 754)

Los números se representan en formato:

```
± d₁.d₂d₃...dₚ × βᵉ
```

Donde:
- **Mantisa**: d₁.d₂d₃...dₚ (dígitos significativos)
- **Base**: β (usualmente 2)
- **Exponente**: e

#### Precisión Finita

- **float (32 bits)**: ~7 dígitos decimales
- **double (64 bits)**: ~15-16 dígitos decimales

### Epsilon de Máquina (ε)

El epsilon de máquina es el número más pequeño tal que `1.0 + ε > 1.0`

Para double: ε ≈ 2.22 × 10⁻¹⁶

---

## 2. Tipos de Errores

### 2.1 Error de Redondeo

Ocurre al representar un número real en precisión finita.

**Ejemplo**: π = 3.14159265358979...
- float: 3.1415927
- double: 3.141592653589793

### 2.2 Error de Truncamiento

Ocurre al aproximar procesos infinitos por procesos finitos.

**Ejemplo**: Serie de Taylor
```
eˣ = 1 + x + x²/2! + x³/3! + ...
```
Truncar después de n términos introduce error.

### 2.3 Error de Entrada/Datos

Errores en los datos iniciales (mediciones, etc.)

---

## 3. Error Absoluto y Relativo

### Error Absoluto

```
E_abs = |valor_exacto - valor_aproximado|
```

### Error Relativo

```
E_rel = |valor_exacto - valor_aproximado| / |valor_exacto|
```

### Error Relativo Porcentual

```
E_rel% = E_rel × 100%
```

**Ejemplo**:
- Valor exacto: π = 3.14159265...
- Aproximación: 3.14
- E_abs = |3.14159265 - 3.14| = 0.00159265
- E_rel = 0.00159265 / 3.14159265 = 0.000507 ≈ 0.0507%

---

## 4. Propagación de Errores

Los errores se propagan y pueden amplificarse en operaciones sucesivas.

### Suma y Resta
Si x = x̄ ± εₓ y y = ȳ ± εᵧ, entonces:
```
x + y = (x̄ + ȳ) ± (εₓ + εᵧ)
```

### Multiplicación
```
xy = x̄ȳ(1 ± (εₓ/x̄ + εᵧ/ȳ))
```

### Cancelación Catastrófica

Problema serio al restar números casi iguales.

**Ejemplo**: Resolver x² - 5000.002x + 10
```
x = (5000.002 ± √(5000.002² - 40)) / 2
```

---

## 5. Estabilidad Numérica

### Algoritmo Estable
Pequeños errores en los datos producen pequeños errores en el resultado.

### Algoritmo Inestable
Pequeños errores se amplifican significativamente.

### Número de Condición

Mide la sensibilidad de un problema a cambios en los datos:
```
κ = |x| × |f'(x)| / |f(x)|
```

- κ ≈ 1: Bien condicionado
- κ >> 1: Mal condicionado

---

## 💻 Ejemplos Prácticos

### Ejemplos en C++
1. [epsilon_maquina.cpp](./ejemplos_cpp/epsilon_maquina.cpp) - Calcular epsilon de máquina
2. [errores_basicos.cpp](./ejemplos_cpp/errores_basicos.cpp) - Errores absolutos y relativos
3. [cancelacion_catastrofica.cpp](./ejemplos_cpp/cancelacion_catastrofica.cpp) - Demostración de cancelación
4. [suma_series.cpp](./ejemplos_cpp/suma_series.cpp) - Error de truncamiento

### Ejemplos en Python
1. [epsilon_maquina.py](./ejemplos_python/epsilon_maquina.py) - Epsilon de máquina
2. [errores_basicos.py](./ejemplos_python/errores_basicos.py) - Cálculo de errores
3. [cancelacion_catastrofica.py](./ejemplos_python/cancelacion_catastrofica.py) - Problemas de cancelación
4. [visualizacion_errores.py](./ejemplos_python/visualizacion_errores.py) - Gráficas de errores

---

## 🎯 Ejercicios Propuestos

1. **Básico**: Calcula el epsilon de máquina para float y double
2. **Intermedio**: Implementa una función que sume 0.1 diez veces y compara con 1.0
3. **Avanzado**: Resuelve la ecuación cuadrática ax² + bx + c = 0 evitando cancelación catastrófica
4. **Desafío**: Implementa la suma de Kahan para reducir errores de redondeo

[Ver soluciones](./ejercicios/soluciones/)

---

## 🔑 Conceptos Clave

- Los números en computadora tienen **precisión finita**
- El **epsilon de máquina** caracteriza la precisión
- **Error absoluto** mide diferencia directa, **error relativo** es proporcional
- **Cancelación catastrófica** ocurre al restar números similares
- Los algoritmos deben diseñarse considerando la **estabilidad numérica**

---

## 📖 Referencias

- Burden & Faires, "Numerical Analysis", Capítulo 1
- Numerical Recipes, Capítulo 1
- IEEE 754 Standard for Floating-Point Arithmetic

---

**Siguiente**: [Módulo 2: Ecuaciones No Lineales](../modulo-02-ecuaciones-no-lineales/)
