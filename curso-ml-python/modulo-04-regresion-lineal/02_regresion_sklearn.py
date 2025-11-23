"""
MÓDULO 4: REGRESIÓN LINEAL CON SCIKIT-LEARN
============================================

Ahora que entiendes cómo funciona la regresión lineal internamente,
aprenderás a usar scikit-learn, la librería profesional de ML.

scikit-learn proporciona:
- Implementaciones optimizadas
- API consistente
- Herramientas de evaluación
- Validación cruzada
- Y mucho más...
"""

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error, r2_score, mean_absolute_error
from sklearn.preprocessing import StandardScaler

# =============================================================================
# 1. REGRESIÓN LINEAL SIMPLE CON SKLEARN
# =============================================================================

print("=" * 70)
print("1. REGRESIÓN LINEAL SIMPLE CON SCIKIT-LEARN")
print("=" * 70)

# Generar datos
np.random.seed(42)
X = np.array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]).reshape(-1, 1)  # sklearn requiere forma 2D
y = 3 * X.ravel() + 2 + np.random.randn(10) * 2

print("Datos de entrenamiento:")
print(f"  X shape: {X.shape}")
print(f"  y shape: {y.shape}")
print()

# Crear y entrenar el modelo
modelo = LinearRegression()
modelo.fit(X, y)

print("Modelo entrenado:")
print(f"  Coeficiente (pendiente): {modelo.coef_[0]:.4f}")
print(f"  Intercepto: {modelo.intercept_:.4f}")
print()

# Hacer predicciones
y_pred = modelo.predict(X)

# Evaluar
r2 = r2_score(y, y_pred)
mse = mean_squared_error(y, y_pred)
rmse = np.sqrt(mse)

print("Métricas de evaluación:")
print(f"  R²: {r2:.4f}")
print(f"  MSE: {mse:.4f}")
print(f"  RMSE: {rmse:.4f}")
print()

# =============================================================================
# 2. DIVISIÓN DE DATOS: ENTRENAMIENTO Y PRUEBA
# =============================================================================

print("=" * 70)
print("2. DIVISIÓN TRAIN/TEST")
print("=" * 70)

"""
Es CRUCIAL dividir los datos en:
- Conjunto de entrenamiento (train): Para entrenar el modelo
- Conjunto de prueba (test): Para evaluar el modelo en datos no vistos

Regla común: 80% entrenamiento, 20% prueba
"""

# Generar más datos
np.random.seed(42)
X = np.random.rand(100, 1) * 10
y = 2.5 * X.ravel() + 5 + np.random.randn(100) * 2

# Dividir en train/test
X_train, X_test, y_train, y_test = train_test_split(
    X, y,
    test_size=0.2,    # 20% para prueba
    random_state=42   # Para reproducibilidad
)

print(f"Tamaño total del dataset: {len(X)}")
print(f"Tamaño de entrenamiento: {len(X_train)} ({len(X_train)/len(X)*100:.0f}%)")
print(f"Tamaño de prueba: {len(X_test)} ({len(X_test)/len(X)*100:.0f}%)")
print()

# Entrenar solo con datos de entrenamiento
modelo = LinearRegression()
modelo.fit(X_train, y_train)

# Evaluar en entrenamiento
y_train_pred = modelo.predict(X_train)
r2_train = r2_score(y_train, y_train_pred)

# Evaluar en prueba (datos no vistos)
y_test_pred = modelo.predict(X_test)
r2_test = r2_score(y_test, y_test_pred)

print("Resultados:")
print(f"  R² en entrenamiento: {r2_train:.4f}")
print(f"  R² en prueba: {r2_test:.4f}")
print()

if abs(r2_train - r2_test) < 0.1:
    print("✓ El modelo generaliza bien (diferencia < 0.1)")
else:
    print("⚠ Posible overfitting (gran diferencia entre train y test)")
print()

# =============================================================================
# 3. REGRESIÓN LINEAL MÚLTIPLE
# =============================================================================

print("=" * 70)
print("3. REGRESIÓN LINEAL MÚLTIPLE")
print("=" * 70)

"""
Regresión múltiple: Múltiples variables independientes
Ecuación: y = β₀ + β₁x₁ + β₂x₂ + ... + βₙxₙ
"""

# Generar datos con múltiples features
np.random.seed(42)
n_samples = 200

# 3 características
X1 = np.random.rand(n_samples) * 10      # Área
X2 = np.random.randint(1, 5, n_samples)  # Habitaciones
X3 = np.random.randint(1, 4, n_samples)  # Baños

# Precio = 30*Área + 50*Habitaciones + 20*Baños + 100 + ruido
y = 30 * X1 + 50 * X2 + 20 * X3 + 100 + np.random.randn(n_samples) * 20

# Combinar features en matriz
X = np.column_stack([X1, X2, X3])

print(f"Dataset con múltiples features:")
print(f"  Forma de X: {X.shape} (samples, features)")
print(f"  Features: Área, Habitaciones, Baños")
print()

# Crear DataFrame para mejor visualización
df = pd.DataFrame(X, columns=['Área', 'Habitaciones', 'Baños'])
df['Precio'] = y

print("Primeras 5 muestras:")
print(df.head())
print()

print("Correlaciones con el precio:")
print(df.corr()['Precio'].sort_values(ascending=False))
print()

# Dividir datos
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Entrenar modelo
modelo = LinearRegression()
modelo.fit(X_train, y_train)

print("Modelo entrenado:")
print(f"  Intercepto: {modelo.intercept_:.2f}")
print(f"  Coeficientes:")
for i, coef in enumerate(modelo.coef_):
    feature_name = ['Área', 'Habitaciones', 'Baños'][i]
    print(f"    {feature_name}: {coef:.2f}")
print()

# Ecuación del modelo
print("Ecuación del modelo:")
print(f"  Precio = {modelo.intercept_:.2f} + "
      f"{modelo.coef_[0]:.2f}*Área + "
      f"{modelo.coef_[1]:.2f}*Habitaciones + "
      f"{modelo.coef_[2]:.2f}*Baños")
print()

# Evaluar
y_pred = modelo.predict(X_test)
r2 = r2_score(y_test, y_pred)
mse = mean_squared_error(y_test, y_pred)
mae = mean_absolute_error(y_test, y_pred)

print("Métricas de evaluación:")
print(f"  R²: {r2:.4f}")
print(f"  MSE: {mse:.2f}")
print(f"  RMSE: {np.sqrt(mse):.2f}")
print(f"  MAE: {mae:.2f}")
print()

# Hacer predicciones
nuevas_casas = np.array([
    [100, 3, 2],  # 100m², 3 habitaciones, 2 baños
    [80, 2, 1],   # 80m², 2 habitaciones, 1 baño
    [150, 4, 3]   # 150m², 4 habitaciones, 3 baños
])

predicciones = modelo.predict(nuevas_casas)

print("Predicciones para casas nuevas:")
for i, (casa, pred) in enumerate(zip(nuevas_casas, predicciones)):
    print(f"  Casa {i+1}: {casa[0]:.0f}m², {casa[1]:.0f} hab, {casa[2]:.0f} baños → ${pred:.2f}")
print()

# =============================================================================
# 4. PREPROCESAMIENTO: NORMALIZACIÓN
# =============================================================================

print("=" * 70)
print("4. NORMALIZACIÓN DE DATOS")
print("=" * 70)

"""
Normalización (StandardScaler): Escala los datos para tener:
- Media = 0
- Desviación estándar = 1

Beneficios:
- Mejora la convergencia del gradiente descendente
- Evita que features con rangos grandes dominen
- Facilita la interpretación de coeficientes
"""

# Datos con diferentes escalas
X_original = np.array([
    [2000, 3, 2],    # Área en m², habitaciones, baños
    [1500, 2, 1],
    [3000, 4, 3],
    [1800, 3, 2],
    [2500, 3, 2]
])

print("Datos originales (diferentes escalas):")
print(X_original)
print(f"\nMedia de cada feature: {X_original.mean(axis=0)}")
print(f"Std de cada feature: {X_original.std(axis=0)}")
print()

# Normalizar
scaler = StandardScaler()
X_scaled = scaler.fit_transform(X_original)

print("Datos normalizados:")
print(X_scaled)
print(f"\nMedia de cada feature: {X_scaled.mean(axis=0).round(10)}")  # ~0
print(f"Std de cada feature: {X_scaled.std(axis=0)}")  # ~1
print()

# =============================================================================
# 5. PIPELINE COMPLETO DE REGRESIÓN
# =============================================================================

print("=" * 70)
print("5. PIPELINE COMPLETO DE MACHINE LEARNING")
print("=" * 70)

# Generar dataset realista
np.random.seed(42)
n = 500

datos = pd.DataFrame({
    'area': np.random.uniform(50, 200, n),
    'habitaciones': np.random.randint(1, 6, n),
    'antiguedad': np.random.uniform(0, 30, n),
    'distancia_centro': np.random.uniform(0, 20, n),
    'precio': 0  # Lo calcularemos
})

# Precio basado en las características + ruido
datos['precio'] = (
    2000 * datos['area'] +
    500000 * datos['habitaciones'] -
    10000 * datos['antiguedad'] -
    30000 * datos['distancia_centro'] +
    np.random.randn(n) * 100000
)

print("Dataset de casas:")
print(datos.head())
print()

print("Estadísticas descriptivas:")
print(datos.describe())
print()

# 1. Separar features (X) y target (y)
X = datos.drop('precio', axis=1).values
y = datos['precio'].values

# 2. Dividir en train/test
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42
)

# 3. Normalizar
scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train)
X_test_scaled = scaler.transform(X_test)  # Usar parámetros del train

# 4. Entrenar modelo
modelo = LinearRegression()
modelo.fit(X_train_scaled, y_train)

# 5. Evaluar
y_train_pred = modelo.predict(X_train_scaled)
y_test_pred = modelo.predict(X_test_scaled)

print("RESULTADOS DEL MODELO:")
print("=" * 70)
print(f"R² Train: {r2_score(y_train, y_train_pred):.4f}")
print(f"R² Test:  {r2_score(y_test, y_test_pred):.4f}")
print()
print(f"RMSE Train: ${np.sqrt(mean_squared_error(y_train, y_train_pred)):,.0f}")
print(f"RMSE Test:  ${np.sqrt(mean_squared_error(y_test, y_test_pred)):,.0f}")
print()
print(f"MAE Train: ${mean_absolute_error(y_train, y_train_pred):,.0f}")
print(f"MAE Test:  ${mean_absolute_error(y_test, y_test_pred):,.0f}")
print()

# Importancia de features (coeficientes)
feature_names = ['area', 'habitaciones', 'antigüedad', 'distancia_centro']
feature_importance = pd.DataFrame({
    'Feature': feature_names,
    'Coeficiente': modelo.coef_
}).sort_values('Coeficiente', ascending=False, key=abs)

print("Importancia de características:")
print(feature_importance)
print()

# =============================================================================
# 6. VISUALIZACIONES
# =============================================================================

print("=" * 70)
print("6. VISUALIZACIONES")
print("=" * 70)

# Crear figura
fig, axes = plt.subplots(2, 2, figsize=(14, 10))

# 1. Predicciones vs Valores Reales
ax1 = axes[0, 0]
ax1.scatter(y_test, y_test_pred, alpha=0.5, s=30)
ax1.plot([y_test.min(), y_test.max()], [y_test.min(), y_test.max()],
         'r--', lw=2, label='Predicción perfecta')
ax1.set_xlabel('Precio Real', fontsize=10)
ax1.set_ylabel('Precio Predicho', fontsize=10)
ax1.set_title('Predicciones vs Valores Reales', fontweight='bold')
ax1.legend()
ax1.grid(True, alpha=0.3)

# 2. Residuos
ax2 = axes[0, 1]
residuos = y_test - y_test_pred
ax2.scatter(y_test_pred, residuos, alpha=0.5, s=30)
ax2.axhline(y=0, color='r', linestyle='--', lw=2)
ax2.set_xlabel('Predicciones', fontsize=10)
ax2.set_ylabel('Residuos', fontsize=10)
ax2.set_title('Gráfico de Residuos', fontweight='bold')
ax2.grid(True, alpha=0.3)

# 3. Distribución de errores
ax3 = axes[1, 0]
ax3.hist(residuos, bins=30, edgecolor='black', alpha=0.7)
ax3.axvline(x=0, color='r', linestyle='--', lw=2)
ax3.set_xlabel('Residuo', fontsize=10)
ax3.set_ylabel('Frecuencia', fontsize=10)
ax3.set_title('Distribución de Residuos', fontweight='bold')
ax3.grid(True, alpha=0.3)

# 4. Importancia de features
ax4 = axes[1, 1]
colors = ['green' if x > 0 else 'red' for x in feature_importance['Coeficiente']]
ax4.barh(feature_importance['Feature'], feature_importance['Coeficiente'], color=colors, alpha=0.7)
ax4.set_xlabel('Coeficiente', fontsize=10)
ax4.set_title('Importancia de Características', fontweight='bold')
ax4.grid(True, alpha=0.3, axis='x')

plt.tight_layout()
plt.savefig('regresion_sklearn_analisis.png', dpi=150, bbox_inches='tight')
print("✓ Gráficas guardadas como 'regresion_sklearn_analisis.png'")
plt.close()

print("\n" + "=" * 70)
print("¡Has completado el módulo de Regresión con scikit-learn!")
print("=" * 70)
print("\nResumen de lo aprendido:")
print("✓ API de scikit-learn (fit, predict, score)")
print("✓ División train/test")
print("✓ Regresión lineal múltiple")
print("✓ Normalización de datos")
print("✓ Pipeline completo de ML")
print("✓ Métricas: R², MSE, RMSE, MAE")
print("✓ Visualización de resultados")
