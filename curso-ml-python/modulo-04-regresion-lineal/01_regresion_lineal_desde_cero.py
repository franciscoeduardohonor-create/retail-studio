"""
MÓDULO 4: REGRESIÓN LINEAL - IMPLEMENTACIÓN DESDE CERO
=======================================================

La regresión lineal es el algoritmo de ML más fundamental.
En este módulo aprenderás:
- Teoría matemática de la regresión lineal
- Implementación desde cero (sin librerías de ML)
- Gradiente descendente
- Evaluación de modelos

Ecuación: y = mx + b (forma simple)
         y = β₀ + β₁x₁ + β₂x₂ + ... + βₙxₙ (forma general)
"""

import numpy as np
import matplotlib.pyplot as plt

# =============================================================================
# 1. REGRESIÓN LINEAL SIMPLE - TEORÍA
# =============================================================================

print("=" * 70)
print("1. REGRESIÓN LINEAL SIMPLE")
print("=" * 70)

# Generar datos sintéticos
np.random.seed(42)
X = np.array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
# y = 3x + 2 + ruido
y = 3 * X + 2 + np.random.randn(10) * 2

print("Datos de entrenamiento:")
for i in range(len(X)):
    print(f"  X={X[i]}, y={y[i]:.2f}")
print()

# =============================================================================
# 2. MÉTODO DE MÍNIMOS CUADRADOS (SOLUCIÓN ANALÍTICA)
# =============================================================================

print("=" * 70)
print("2. MÉTODO DE MÍNIMOS CUADRADOS")
print("=" * 70)

"""
Fórmulas de mínimos cuadrados:
m (pendiente) = (n∑xy - ∑x∑y) / (n∑x² - (∑x)²)
b (intercepto) = (∑y - m∑x) / n
"""

n = len(X)
sum_x = np.sum(X)
sum_y = np.sum(y)
sum_xy = np.sum(X * y)
sum_x2 = np.sum(X ** 2)

# Calcular pendiente e intercepto
m = (n * sum_xy - sum_x * sum_y) / (n * sum_x2 - sum_x ** 2)
b = (sum_y - m * sum_x) / n

print(f"Parámetros calculados:")
print(f"  Pendiente (m): {m:.4f}")
print(f"  Intercepto (b): {b:.4f}")
print(f"\nEcuación de la recta: y = {m:.4f}x + {b:.4f}")
print()

# Predicciones
y_pred = m * X + b

# Calcular error (MSE - Mean Squared Error)
mse = np.mean((y - y_pred) ** 2)
rmse = np.sqrt(mse)

print(f"Error Cuadrático Medio (MSE): {mse:.4f}")
print(f"Raíz del Error Cuadrático Medio (RMSE): {rmse:.4f}")
print()

# Coeficiente de determinación (R²)
ss_tot = np.sum((y - np.mean(y)) ** 2)  # Suma total de cuadrados
ss_res = np.sum((y - y_pred) ** 2)       # Suma residual de cuadrados
r2 = 1 - (ss_res / ss_tot)

print(f"R² (Coeficiente de determinación): {r2:.4f}")
print(f"  R² = 1 significa ajuste perfecto")
print(f"  R² = 0 significa que el modelo no explica nada")
print()

# =============================================================================
# 3. CLASE DE REGRESIÓN LINEAL DESDE CERO
# =============================================================================

print("=" * 70)
print("3. IMPLEMENTACIÓN ORIENTADA A OBJETOS")
print("=" * 70)

class RegresionLineal:
    """
    Implementación de Regresión Lineal desde cero
    usando el método de mínimos cuadrados.
    """

    def __init__(self):
        self.m = None  # Pendiente
        self.b = None  # Intercepto

    def fit(self, X, y):
        """
        Entrena el modelo con los datos X e y.

        Parámetros:
        -----------
        X : array de forma (n_samples,)
            Variables independientes
        y : array de forma (n_samples,)
            Variable dependiente
        """
        n = len(X)
        sum_x = np.sum(X)
        sum_y = np.sum(y)
        sum_xy = np.sum(X * y)
        sum_x2 = np.sum(X ** 2)

        # Calcular parámetros
        self.m = (n * sum_xy - sum_x * sum_y) / (n * sum_x2 - sum_x ** 2)
        self.b = (sum_y - self.m * sum_x) / n

        return self

    def predict(self, X):
        """
        Realiza predicciones con el modelo entrenado.

        Parámetros:
        -----------
        X : array de forma (n_samples,)
            Datos para predecir

        Retorna:
        --------
        array de predicciones
        """
        if self.m is None or self.b is None:
            raise Exception("El modelo no ha sido entrenado. Llama a fit() primero.")

        return self.m * X + self.b

    def score(self, X, y):
        """
        Calcula el coeficiente R² del modelo.

        Parámetros:
        -----------
        X : array de forma (n_samples,)
        y : array de forma (n_samples,)

        Retorna:
        --------
        r2_score : float
        """
        y_pred = self.predict(X)
        ss_tot = np.sum((y - np.mean(y)) ** 2)
        ss_res = np.sum((y - y_pred) ** 2)
        return 1 - (ss_res / ss_tot)

# Usar nuestra clase
modelo = RegresionLineal()
modelo.fit(X, y)

print(f"Modelo entrenado:")
print(f"  m = {modelo.m:.4f}")
print(f"  b = {modelo.b:.4f}")
print()

# Hacer predicciones
X_nuevo = np.array([11, 12, 13])
predicciones = modelo.predict(X_nuevo)

print("Predicciones para nuevos datos:")
for x, pred in zip(X_nuevo, predicciones):
    print(f"  X={x} → y={pred:.2f}")
print()

# Evaluar el modelo
r2_score = modelo.score(X, y)
print(f"R² Score: {r2_score:.4f}")
print()

# =============================================================================
# 4. GRADIENTE DESCENDENTE
# =============================================================================

print("=" * 70)
print("4. REGRESIÓN LINEAL CON GRADIENTE DESCENDENTE")
print("=" * 70)

"""
Gradiente Descendente es un algoritmo iterativo para minimizar
la función de costo.

Función de costo (MSE): J(m,b) = (1/n) Σ(y - (mx + b))²

Actualización de parámetros:
m = m - α * ∂J/∂m
b = b - α * ∂J/∂b

donde α es la tasa de aprendizaje (learning rate)
"""

class RegresionLinealGD:
    """
    Regresión Lineal usando Gradiente Descendente
    """

    def __init__(self, learning_rate=0.01, n_iterations=1000):
        self.learning_rate = learning_rate
        self.n_iterations = n_iterations
        self.m = 0  # Inicializar en 0
        self.b = 0
        self.cost_history = []  # Historial de costos

    def fit(self, X, y):
        """
        Entrena el modelo usando gradiente descendente.
        """
        n = len(X)

        for i in range(self.n_iterations):
            # Predicciones con parámetros actuales
            y_pred = self.m * X + self.b

            # Calcular el error
            error = y_pred - y

            # Calcular el costo (MSE)
            cost = (1/n) * np.sum(error ** 2)
            self.cost_history.append(cost)

            # Calcular gradientes
            dm = (2/n) * np.sum(error * X)
            db = (2/n) * np.sum(error)

            # Actualizar parámetros
            self.m = self.m - self.learning_rate * dm
            self.b = self.b - self.learning_rate * db

            # Imprimir progreso cada 100 iteraciones
            if (i + 1) % 100 == 0:
                print(f"  Iteración {i+1}: Cost={cost:.4f}, m={self.m:.4f}, b={self.b:.4f}")

        return self

    def predict(self, X):
        return self.m * X + self.b

    def score(self, X, y):
        y_pred = self.predict(X)
        ss_tot = np.sum((y - np.mean(y)) ** 2)
        ss_res = np.sum((y - y_pred) ** 2)
        return 1 - (ss_res / ss_tot)

# Entrenar con gradiente descendente
modelo_gd = RegresionLinealGD(learning_rate=0.01, n_iterations=1000)
print("\nEntrenando con Gradiente Descendente...")
modelo_gd.fit(X, y)

print(f"\nParámetros finales:")
print(f"  m = {modelo_gd.m:.4f}")
print(f"  b = {modelo_gd.b:.4f}")
print(f"  R² = {modelo_gd.score(X, y):.4f}")
print()

# =============================================================================
# 5. VISUALIZACIÓN
# =============================================================================

print("=" * 70)
print("5. VISUALIZACIÓN")
print("=" * 70)

# Crear figura con subplots
fig, axes = plt.subplots(1, 2, figsize=(14, 5))

# Subplot 1: Datos y línea de regresión
ax1 = axes[0]
ax1.scatter(X, y, color='blue', alpha=0.6, s=100, label='Datos reales')
ax1.plot(X, modelo.predict(X), color='red', linewidth=2, label=f'y = {modelo.m:.2f}x + {modelo.b:.2f}')
ax1.set_xlabel('X', fontsize=12)
ax1.set_ylabel('y', fontsize=12)
ax1.set_title('Regresión Lineal Simple', fontsize=14, fontweight='bold')
ax1.legend()
ax1.grid(True, alpha=0.3)

# Subplot 2: Historial de costo (Gradiente Descendente)
ax2 = axes[1]
ax2.plot(modelo_gd.cost_history, color='green', linewidth=2)
ax2.set_xlabel('Iteración', fontsize=12)
ax2.set_ylabel('Costo (MSE)', fontsize=12)
ax2.set_title('Convergencia del Gradiente Descendente', fontsize=14, fontweight='bold')
ax2.grid(True, alpha=0.3)

plt.tight_layout()
plt.savefig('regresion_lineal.png', dpi=150, bbox_inches='tight')
print("✓ Gráfica guardada como 'regresion_lineal.png'")
plt.close()

# =============================================================================
# 6. EJEMPLO PRÁCTICO: PREDICCIÓN DE PRECIOS
# =============================================================================

print("\n" + "=" * 70)
print("6. EJEMPLO PRÁCTICO: Predicción de Precios de Casas")
print("=" * 70)

# Datos: Área en m² vs Precio en miles de pesos
area = np.array([50, 60, 70, 80, 90, 100, 110, 120, 130, 140])
precio = np.array([150, 180, 210, 240, 270, 300, 330, 360, 390, 420]) + np.random.randn(10) * 20

print("Datos de casas (Área vs Precio):")
for a, p in zip(area, precio):
    print(f"  {a}m² → ${p:.0f}k")
print()

# Entrenar modelo
modelo_casa = RegresionLineal()
modelo_casa.fit(area, precio)

print(f"Modelo entrenado:")
print(f"  Precio = {modelo_casa.m:.2f} × Área + {modelo_casa.b:.2f}")
print(f"  R² = {modelo_casa.score(area, precio):.4f}")
print()

# Predicciones
areas_nuevas = np.array([75, 95, 150])
precios_pred = modelo_casa.predict(areas_nuevas)

print("Predicciones para casas nuevas:")
for a, p in zip(areas_nuevas, precios_pred):
    print(f"  Casa de {a}m² → ${p:.0f}k estimado")
print()

print("=" * 70)
print("¡Has completado el módulo de Regresión Lineal!")
print("=" * 70)
print("\nConceptos clave aprendidos:")
print("✓ Ecuación de la recta: y = mx + b")
print("✓ Método de mínimos cuadrados")
print("✓ Gradiente descendente")
print("✓ Métricas: MSE, RMSE, R²")
print("✓ Implementación desde cero")
