"""
MÓDULO 5 - MACHINE LEARNING
Lección 1: Regresión con Scikit-Learn

Machine Learning (Aprendizaje Automático) permite a las computadoras aprender
de los datos sin ser explícitamente programadas.

REGRESIÓN: Predecir valores continuos (precios, temperaturas, ventas, etc.)

En esta lección aprenderás:
- Conceptos básicos de ML
- Preparación de datos
- Regresión Lineal
- Evaluación de modelos
- Validación cruzada
"""

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.model_selection import train_test_split, cross_val_score
from sklearn.linear_model import LinearRegression, Ridge, Lasso
from sklearn.preprocessing import StandardScaler
from sklearn.metrics import mean_squared_error, r2_score, mean_absolute_error
import warnings
warnings.filterwarnings('ignore')

# ============================================
# 1. CONCEPTOS BÁSICOS
# ============================================

print("="*70)
print("MACHINE LEARNING - CONCEPTOS BÁSICOS")
print("="*70)

print("""
TIPOS DE MACHINE LEARNING:

1. SUPERVISADO (tenemos las respuestas correctas):
   - Regresión: predecir valores continuos
   - Clasificación: predecir categorías

2. NO SUPERVISADO (sin respuestas):
   - Clustering: agrupar datos similares
   - Reducción de dimensionalidad

3. REFUERZO:
   - Aprender por recompensas

FLUJO DE TRABAJO:
1. Obtener datos
2. Explorar y limpiar datos
3. Dividir en entrenamiento y prueba
4. Elegir y entrenar modelo
5. Evaluar modelo
6. Ajustar y mejorar
7. Hacer predicciones

MÉTRICAS DE REGRESIÓN:
- MSE (Mean Squared Error): Error cuadrático medio
- RMSE (Root MSE): Raíz del MSE
- MAE (Mean Absolute Error): Error absoluto medio
- R² (R-squared): Qué tan bien el modelo explica la varianza (0-1, mejor cerca de 1)
""")

# ============================================
# 2. REGRESIÓN LINEAL SIMPLE
# ============================================

print("\n" + "="*70)
print("REGRESIÓN LINEAL SIMPLE")
print("="*70)

# Generar datos sintéticos
np.random.seed(42)
X_simple = np.linspace(0, 10, 100).reshape(-1, 1)  # reshape para sklearn
y_simple = 2.5 * X_simple.ravel() + 5 + np.random.normal(0, 2, 100)

print(f"\nDatos generados: {len(X_simple)} puntos")
print(f"Ecuación real: y = 2.5*x + 5 + ruido")

# Dividir en entrenamiento y prueba
X_train, X_test, y_train, y_test = train_test_split(
    X_simple, y_simple, test_size=0.2, random_state=42
)

print(f"\nEntrenamiento: {len(X_train)} puntos")
print(f"Prueba: {len(X_test)} puntos")

# Crear y entrenar modelo
modelo = LinearRegression()
modelo.fit(X_train, y_train)

print(f"\n--- MODELO ENTRENADO ---")
print(f"Pendiente (coeficiente): {modelo.coef_[0]:.2f}")
print(f"Intercepto: {modelo.intercept_:.2f}")
print(f"Ecuación del modelo: y = {modelo.coef_[0]:.2f}*x + {modelo.intercept_:.2f}")

# Hacer predicciones
y_pred_train = modelo.predict(X_train)
y_pred_test = modelo.predict(X_test)

# Evaluar modelo
r2_train = r2_score(y_train, y_pred_train)
r2_test = r2_score(y_test, y_pred_test)
mse_test = mean_squared_error(y_test, y_pred_test)
rmse_test = np.sqrt(mse_test)
mae_test = mean_absolute_error(y_test, y_pred_test)

print(f"\n--- EVALUACIÓN ---")
print(f"R² entrenamiento: {r2_train:.4f}")
print(f"R² prueba: {r2_test:.4f}")
print(f"RMSE prueba: {rmse_test:.2f}")
print(f"MAE prueba: {mae_test:.2f}")

# Visualizar
plt.figure(figsize=(12, 5))

# Subplot 1: Datos de entrenamiento
plt.subplot(1, 2, 1)
plt.scatter(X_train, y_train, alpha=0.6, label='Datos reales')
plt.plot(X_train, y_pred_train, 'r-', linewidth=2, label='Predicción')
plt.xlabel('X')
plt.ylabel('y')
plt.title(f'Entrenamiento (R² = {r2_train:.3f})')
plt.legend()
plt.grid(True, alpha=0.3)

# Subplot 2: Datos de prueba
plt.subplot(1, 2, 2)
plt.scatter(X_test, y_test, alpha=0.6, label='Datos reales', color='green')
plt.plot(X_test, y_pred_test, 'r-', linewidth=2, label='Predicción')
plt.xlabel('X')
plt.ylabel('y')
plt.title(f'Prueba (R² = {r2_test:.3f})')
plt.legend()
plt.grid(True, alpha=0.3)

plt.tight_layout()
plt.savefig('/home/user/retail-studio/curso-python-data-science/modulo5-machine-learning/01_regresion_simple.png', dpi=100)
plt.close()

print("\n✓ Visualización guardada: 01_regresion_simple.png")

# ============================================
# 3. REGRESIÓN LINEAL MÚLTIPLE
# ============================================

print("\n" + "="*70)
print("REGRESIÓN LINEAL MÚLTIPLE")
print("="*70)

# Crear dataset de casas
np.random.seed(42)
n_casas = 500

datos_casas = pd.DataFrame({
    'area_m2': np.random.uniform(50, 250, n_casas),
    'habitaciones': np.random.randint(1, 6, n_casas),
    'antiguedad_años': np.random.randint(0, 50, n_casas),
    'distancia_centro_km': np.random.uniform(1, 30, n_casas)
})

# Generar precio basado en características (con ruido)
datos_casas['precio_miles'] = (
    2.5 * datos_casas['area_m2'] +
    15 * datos_casas['habitaciones'] -
    0.5 * datos_casas['antiguedad_años'] -
    2 * datos_casas['distancia_centro_km'] +
    np.random.normal(0, 30, n_casas) +
    100
)

print("\nDataset de casas:")
print(datos_casas.head(10))
print(f"\nForma: {datos_casas.shape}")

# Análisis exploratorio
print("\n--- ESTADÍSTICAS DESCRIPTIVAS ---")
print(datos_casas.describe())

# Matriz de correlación
correlacion = datos_casas.corr()
print("\n--- CORRELACIÓN CON PRECIO ---")
print(correlacion['precio_miles'].sort_values(ascending=False))

# Visualizar correlación
plt.figure(figsize=(10, 8))
sns.heatmap(correlacion, annot=True, fmt='.2f', cmap='coolwarm', center=0, square=True)
plt.title('Matriz de Correlación - Dataset de Casas', fontsize=14, fontweight='bold')
plt.tight_layout()
plt.savefig('/home/user/retail-studio/curso-python-data-science/modulo5-machine-learning/02_correlacion_casas.png', dpi=100)
plt.close()

print("✓ Visualización guardada: 02_correlacion_casas.png")

# Preparar datos para modelo
X = datos_casas.drop('precio_miles', axis=1)
y = datos_casas['precio_miles']

# Dividir datos
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42
)

print(f"\n--- DIVISIÓN DE DATOS ---")
print(f"Entrenamiento: {len(X_train)} casas")
print(f"Prueba: {len(X_test)} casas")

# Entrenar modelo
modelo_casas = LinearRegression()
modelo_casas.fit(X_train, y_train)

# Coeficientes
print(f"\n--- COEFICIENTES DEL MODELO ---")
print(f"Intercepto: {modelo_casas.intercept_:.2f}")
for feature, coef in zip(X.columns, modelo_casas.coef_):
    print(f"{feature}: {coef:.2f}")

# Predicciones
y_pred_train = modelo_casas.predict(X_train)
y_pred_test = modelo_casas.predict(X_test)

# Evaluación
print(f"\n--- EVALUACIÓN DEL MODELO ---")
print(f"R² entrenamiento: {r2_score(y_train, y_pred_train):.4f}")
print(f"R² prueba: {r2_score(y_test, y_pred_test):.4f}")
print(f"RMSE prueba: {np.sqrt(mean_squared_error(y_test, y_pred_test)):.2f} miles")
print(f"MAE prueba: {mean_absolute_error(y_test, y_pred_test):.2f} miles")

# Visualizar predicciones vs reales
plt.figure(figsize=(10, 6))
plt.scatter(y_test, y_pred_test, alpha=0.6, edgecolors='black')
plt.plot([y_test.min(), y_test.max()], [y_test.min(), y_test.max()], 'r--', lw=2)
plt.xlabel('Precio Real (miles $)', fontsize=12)
plt.ylabel('Precio Predicho (miles $)', fontsize=12)
plt.title(f'Predicciones vs Realidad (R² = {r2_score(y_test, y_pred_test):.3f})',
          fontsize=14, fontweight='bold')
plt.grid(True, alpha=0.3)
plt.tight_layout()
plt.savefig('/home/user/retail-studio/curso-python-data-science/modulo5-machine-learning/03_predicciones_casas.png', dpi=100)
plt.close()

print("✓ Visualización guardada: 03_predicciones_casas.png")

# ============================================
# 4. REGULARIZACIÓN (Ridge y Lasso)
# ============================================

print("\n" + "="*70)
print("REGULARIZACIÓN - RIDGE Y LASSO")
print("="*70)

print("""
REGULARIZACIÓN: Técnica para prevenir overfitting (sobreajuste)

- Ridge (L2): Penaliza coeficientes grandes
- Lasso (L1): Puede hacer coeficientes = 0 (selección de características)
- Alpha: Fuerza de regularización (mayor = más penalización)
""")

# Normalizar datos (importante para regularización)
scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train)
X_test_scaled = scaler.transform(X_test)

# Entrenar modelos
modelos = {
    'Linear': LinearRegression(),
    'Ridge': Ridge(alpha=1.0),
    'Lasso': Lasso(alpha=1.0)
}

resultados = {}

print("\n--- COMPARACIÓN DE MODELOS ---")
for nombre, modelo in modelos.items():
    modelo.fit(X_train_scaled, y_train)
    y_pred = modelo.predict(X_test_scaled)

    r2 = r2_score(y_test, y_pred)
    rmse = np.sqrt(mean_squared_error(y_test, y_pred))

    resultados[nombre] = {'R2': r2, 'RMSE': rmse}

    print(f"\n{nombre}:")
    print(f"  R²: {r2:.4f}")
    print(f"  RMSE: {rmse:.2f}")

# Visualizar comparación
fig, axes = plt.subplots(1, 2, figsize=(14, 5))

# Subplot 1: R²
nombres = list(resultados.keys())
r2_scores = [resultados[n]['R2'] for n in nombres]
axes[0].bar(nombres, r2_scores, color=['blue', 'green', 'red'], edgecolor='black')
axes[0].set_ylabel('R² Score')
axes[0].set_title('R² por Modelo', fontweight='bold')
axes[0].set_ylim([0, 1])
axes[0].grid(axis='y', alpha=0.3)

# Subplot 2: RMSE
rmse_scores = [resultados[n]['RMSE'] for n in nombres]
axes[1].bar(nombres, rmse_scores, color=['blue', 'green', 'red'], edgecolor='black')
axes[1].set_ylabel('RMSE')
axes[1].set_title('RMSE por Modelo', fontweight='bold')
axes[1].grid(axis='y', alpha=0.3)

plt.tight_layout()
plt.savefig('/home/user/retail-studio/curso-python-data-science/modulo5-machine-learning/04_comparacion_modelos.png', dpi=100)
plt.close()

print("\n✓ Visualización guardada: 04_comparacion_modelos.png")

# ============================================
# 5. VALIDACIÓN CRUZADA
# ============================================

print("\n" + "="*70)
print("VALIDACIÓN CRUZADA")
print("="*70)

print("""
Validación Cruzada (Cross-Validation):
- Divide datos en K partes (folds)
- Entrena K veces, usando cada fold como validación
- Promedia resultados para evaluación más robusta
- Reduce varianza en la evaluación
""")

# Validación cruzada con 5 folds
modelo_cv = LinearRegression()
scores = cross_val_score(modelo_cv, X, y, cv=5, scoring='r2')

print(f"\n--- VALIDACIÓN CRUZADA (5-Fold) ---")
print(f"Scores individuales: {scores}")
print(f"Promedio: {scores.mean():.4f}")
print(f"Desviación estándar: {scores.std():.4f}")
print(f"Rango: [{scores.min():.4f}, {scores.max():.4f}]")

# ============================================
# 6. HACER PREDICCIONES NUEVAS
# ============================================

print("\n" + "="*70)
print("HACER PREDICCIONES CON DATOS NUEVOS")
print("="*70)

# Entrenar modelo final con todos los datos
modelo_final = LinearRegression()
modelo_final.fit(X, y)

# Nuevas casas para predecir
nuevas_casas = pd.DataFrame({
    'area_m2': [120, 80, 200],
    'habitaciones': [3, 2, 4],
    'antiguedad_años': [5, 15, 2],
    'distancia_centro_km': [10, 20, 5]
})

print("\nNuevas casas para predecir:")
print(nuevas_casas)

# Hacer predicciones
predicciones = modelo_final.predict(nuevas_casas)

print("\n--- PREDICCIONES ---")
for i, precio in enumerate(predicciones):
    print(f"Casa {i+1}: ${precio:.2f} mil")

# Agregar predicciones al DataFrame
nuevas_casas['precio_predicho_miles'] = predicciones
print("\nDataFrame con predicciones:")
print(nuevas_casas)

# ============================================
# RESUMEN
# ============================================

print("\n" + "="*70)
print("RESUMEN")
print("="*70)
print("""
PROCESO DE REGRESIÓN:

1. PREPARAR DATOS:
   - Limpiar datos
   - Explorar correlaciones
   - Dividir en train/test

2. ENTRENAR MODELO:
   - LinearRegression() para regresión básica
   - Ridge/Lasso para regularización
   - fit(X_train, y_train)

3. EVALUAR:
   - R²: qué tan bien explica la varianza (0-1)
   - RMSE: error promedio en unidades originales
   - MAE: error absoluto promedio
   - Validación cruzada para robustez

4. PREDECIR:
   - predict(X_new)

MÉTRICAS:
- R² = 1.0 → Perfecto (raro)
- R² > 0.7 → Bueno
- R² > 0.5 → Aceptable
- R² < 0.3 → Malo

CUÁNDO USAR:
- Predecir precios
- Estimar ventas
- Proyectar tendencias
- Cualquier valor continuo
""")

# ============================================
# EJERCICIOS PARA PRACTICAR
# ============================================

print("\n" + "="*70)
print("EJERCICIOS PARA TI:")
print("="*70)
print("""
1. REGRESIÓN SIMPLE:
   - Genera datos de temperatura vs ventas de helado
   - Entrena modelo de regresión
   - Evalúa con R² y RMSE
   - Visualiza resultados

2. REGRESIÓN MÚLTIPLE:
   - Dataset: predecir salario
   - Variables: años_experiencia, edad, nivel_educación
   - Entrena modelo
   - Analiza qué variable es más importante

3. COMPARACIÓN:
   - Usa el mismo dataset
   - Entrena Linear, Ridge y Lasso
   - Compara resultados
   - ¿Cuál funciona mejor?

4. VALIDACIÓN:
   - Aplica validación cruzada (k=10)
   - Compara con split simple
   - Analiza diferencias

5. PROYECTO COMPLETO:
   - Busca o genera dataset de casas/autos
   - EDA completo
   - Entrena múltiples modelos
   - Evalúa y compara
   - Haz predicciones
   - Crea visualizaciones profesionales

¡La regresión es fundamental en Data Science!
""")
