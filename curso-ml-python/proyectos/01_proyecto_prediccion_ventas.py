"""
PROYECTO INTEGRADOR 1: PREDICCIÓN DE VENTAS
============================================

Este proyecto integra todos los conceptos aprendidos:
- Análisis exploratorio con Pandas
- Visualización con Matplotlib/Seaborn
- Preprocesamiento de datos
- Regresión lineal múltiple
- Evaluación de modelos
- Interpretación de resultados

CONTEXTO DEL NEGOCIO:
Una cadena de tiendas retail quiere predecir las ventas futuras basándose en:
- Inversión en publicidad (TV, Radio, Redes Sociales)
- Estación del año
- Promociones activas
- Ubicación de la tienda

OBJETIVO:
Construir un modelo de ML que prediga las ventas semanales y ayude a optimizar
la inversión en marketing.
"""

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.model_selection import train_test_split, cross_val_score
from sklearn.linear_model import LinearRegression
from sklearn.preprocessing import StandardScaler
from sklearn.metrics import mean_squared_error, r2_score, mean_absolute_error

# Configuración de visualización
sns.set_style("whitegrid")
plt.rcParams['figure.figsize'] = (12, 6)

print("=" * 80)
print(" " * 20 + "PROYECTO: PREDICCIÓN DE VENTAS")
print("=" * 80)
print()

# =============================================================================
# PASO 1: GENERACIÓN Y CARGA DE DATOS
# =============================================================================

print("PASO 1: GENERACIÓN DE DATOS SINTÉTICOS")
print("-" * 80)

np.random.seed(42)
n_samples = 500

# Generar características
datos = pd.DataFrame({
    'tv_ads': np.random.uniform(0, 300, n_samples),          # Miles de $ en publicidad TV
    'radio_ads': np.random.uniform(0, 50, n_samples),        # Miles de $ en publicidad Radio
    'social_ads': np.random.uniform(0, 100, n_samples),      # Miles de $ en Redes Sociales
    'estacion': np.random.choice(['Primavera', 'Verano', 'Otoño', 'Invierno'], n_samples),
    'promocion': np.random.choice([0, 1], n_samples, p=[0.7, 0.3]),  # 30% con promoción
    'ubicacion': np.random.choice(['Centro', 'Suburbio', 'Rural'], n_samples),
    'competencia_cercana': np.random.choice([0, 1], n_samples, p=[0.6, 0.4])
})

# Generar ventas basadas en las características (con algo de ruido)
ventas = (
    10000 +  # Base
    50 * datos['tv_ads'] +
    30 * datos['radio_ads'] +
    40 * datos['social_ads'] +
    2000 * datos['promocion'] +
    np.where(datos['estacion'] == 'Invierno', 3000, 0) +
    np.where(datos['estacion'] == 'Verano', 2000, 0) +
    np.where(datos['ubicacion'] == 'Centro', 5000,
             np.where(datos['ubicacion'] == 'Suburbio', 2000, 0)) +
    -1500 * datos['competencia_cercana'] +
    np.random.normal(0, 2000, n_samples)  # Ruido
)

datos['ventas'] = ventas.round(2)

print(f"✓ Dataset generado con {n_samples} muestras")
print(f"✓ Variables: {list(datos.columns)}")
print()

# Guardar datos
datos.to_csv('ventas_retail.csv', index=False)
print("✓ Datos guardados en 'ventas_retail.csv'\n")

# =============================================================================
# PASO 2: ANÁLISIS EXPLORATORIO DE DATOS (EDA)
# =============================================================================

print("PASO 2: ANÁLISIS EXPLORATORIO DE DATOS")
print("-" * 80)

print("\nPrimeras 5 filas del dataset:")
print(datos.head())
print()

print("Información del dataset:")
print(datos.info())
print()

print("Estadísticas descriptivas:")
print(datos.describe())
print()

print("Valores faltantes por columna:")
print(datos.isnull().sum())
print()

# Distribución de la variable objetivo
print("Estadísticas de ventas:")
print(f"  Media: ${datos['ventas'].mean():,.2f}")
print(f"  Mediana: ${datos['ventas'].median():,.2f}")
print(f"  Std: ${datos['ventas'].std():,.2f}")
print(f"  Min: ${datos['ventas'].min():,.2f}")
print(f"  Max: ${datos['ventas'].max():,.2f}")
print()

# Correlaciones
print("Correlaciones con ventas:")
correlaciones = datos[['tv_ads', 'radio_ads', 'social_ads', 'promocion',
                        'competencia_cercana', 'ventas']].corr()['ventas'].sort_values(ascending=False)
print(correlaciones)
print()

# =============================================================================
# PASO 3: VISUALIZACIONES
# =============================================================================

print("PASO 3: VISUALIZACIONES")
print("-" * 80)

# Crear figura con múltiples subplots
fig = plt.figure(figsize=(16, 12))

# 1. Distribución de ventas
ax1 = plt.subplot(3, 3, 1)
ax1.hist(datos['ventas'], bins=30, edgecolor='black', alpha=0.7, color='skyblue')
ax1.set_xlabel('Ventas ($)', fontsize=10)
ax1.set_ylabel('Frecuencia', fontsize=10)
ax1.set_title('Distribución de Ventas', fontweight='bold')
ax1.axvline(datos['ventas'].mean(), color='red', linestyle='--', linewidth=2, label='Media')
ax1.legend()

# 2. TV Ads vs Ventas
ax2 = plt.subplot(3, 3, 2)
ax2.scatter(datos['tv_ads'], datos['ventas'], alpha=0.5, s=20)
ax2.set_xlabel('Inversión en TV ($k)', fontsize=10)
ax2.set_ylabel('Ventas ($)', fontsize=10)
ax2.set_title('TV Ads vs Ventas', fontweight='bold')
# Línea de tendencia
z = np.polyfit(datos['tv_ads'], datos['ventas'], 1)
p = np.poly1d(z)
ax2.plot(datos['tv_ads'], p(datos['tv_ads']), "r--", linewidth=2, alpha=0.8)

# 3. Radio Ads vs Ventas
ax3 = plt.subplot(3, 3, 3)
ax3.scatter(datos['radio_ads'], datos['ventas'], alpha=0.5, s=20, color='orange')
ax3.set_xlabel('Inversión en Radio ($k)', fontsize=10)
ax3.set_ylabel('Ventas ($)', fontsize=10)
ax3.set_title('Radio Ads vs Ventas', fontweight='bold')

# 4. Social Ads vs Ventas
ax4 = plt.subplot(3, 3, 4)
ax4.scatter(datos['social_ads'], datos['ventas'], alpha=0.5, s=20, color='green')
ax4.set_xlabel('Inversión en Redes Sociales ($k)', fontsize=10)
ax4.set_ylabel('Ventas ($)', fontsize=10)
ax4.set_title('Social Media Ads vs Ventas', fontweight='bold')

# 5. Ventas por estación
ax5 = plt.subplot(3, 3, 5)
datos.boxplot(column='ventas', by='estacion', ax=ax5)
ax5.set_xlabel('Estación', fontsize=10)
ax5.set_ylabel('Ventas ($)', fontsize=10)
ax5.set_title('Ventas por Estación', fontweight='bold')
plt.sca(ax5)
plt.xticks(rotation=45)

# 6. Ventas por ubicación
ax6 = plt.subplot(3, 3, 6)
datos.boxplot(column='ventas', by='ubicacion', ax=ax6)
ax6.set_xlabel('Ubicación', fontsize=10)
ax6.set_ylabel('Ventas ($)', fontsize=10)
ax6.set_title('Ventas por Ubicación', fontweight='bold')
plt.sca(ax6)
plt.xticks(rotation=45)

# 7. Efecto de promociones
ax7 = plt.subplot(3, 3, 7)
datos.boxplot(column='ventas', by='promocion', ax=ax7)
ax7.set_xlabel('Promoción (0=No, 1=Sí)', fontsize=10)
ax7.set_ylabel('Ventas ($)', fontsize=10)
ax7.set_title('Efecto de Promociones', fontweight='bold')

# 8. Matriz de correlación
ax8 = plt.subplot(3, 3, 8)
corr_matrix = datos[['tv_ads', 'radio_ads', 'social_ads', 'promocion', 'ventas']].corr()
sns.heatmap(corr_matrix, annot=True, fmt='.2f', cmap='coolwarm', ax=ax8, cbar=True)
ax8.set_title('Matriz de Correlación', fontweight='bold')

# 9. Comparación de inversión total en ads
ax9 = plt.subplot(3, 3, 9)
datos['total_ads'] = datos['tv_ads'] + datos['radio_ads'] + datos['social_ads']
ax9.scatter(datos['total_ads'], datos['ventas'], alpha=0.5, s=20, color='purple')
ax9.set_xlabel('Inversión Total en Publicidad ($k)', fontsize=10)
ax9.set_ylabel('Ventas ($)', fontsize=10)
ax9.set_title('Inversión Total vs Ventas', fontweight='bold')

plt.tight_layout()
plt.savefig('eda_ventas.png', dpi=150, bbox_inches='tight')
plt.close()
print("✓ Visualizaciones guardadas en 'eda_ventas.png'\n")

# =============================================================================
# PASO 4: PREPROCESAMIENTO DE DATOS
# =============================================================================

print("PASO 4: PREPROCESAMIENTO DE DATOS")
print("-" * 80)

# Convertir variables categóricas a dummies (one-hot encoding)
datos_procesados = pd.get_dummies(datos, columns=['estacion', 'ubicacion'], drop_first=True)

print("Variables después de one-hot encoding:")
print(datos_procesados.columns.tolist())
print()

# Separar features (X) y target (y)
X = datos_procesados.drop('ventas', axis=1)
y = datos_procesados['ventas']

print(f"Forma de X: {X.shape}")
print(f"Forma de y: {y.shape}")
print()

# Dividir en train/test
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42
)

print(f"Tamaño de entrenamiento: {X_train.shape[0]} ({X_train.shape[0]/len(X)*100:.1f}%)")
print(f"Tamaño de prueba: {X_test.shape[0]} ({X_test.shape[0]/len(X)*100:.1f}%)")
print()

# Normalizar features
scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train)
X_test_scaled = scaler.transform(X_test)

print("✓ Datos normalizados (media=0, std=1)")
print()

# =============================================================================
# PASO 5: ENTRENAMIENTO DEL MODELO
# =============================================================================

print("PASO 5: ENTRENAMIENTO DEL MODELO")
print("-" * 80)

# Crear y entrenar modelo
modelo = LinearRegression()
modelo.fit(X_train_scaled, y_train)

print("✓ Modelo entrenado exitosamente")
print()

# Coeficientes del modelo
print("Coeficientes del modelo:")
coef_df = pd.DataFrame({
    'Feature': X.columns,
    'Coeficiente': modelo.coef_
}).sort_values('Coeficiente', ascending=False, key=abs)

print(coef_df.to_string(index=False))
print()
print(f"Intercepto: ${modelo.intercept_:,.2f}")
print()

# =============================================================================
# PASO 6: EVALUACIÓN DEL MODELO
# =============================================================================

print("PASO 6: EVALUACIÓN DEL MODELO")
print("-" * 80)

# Predicciones
y_train_pred = modelo.predict(X_train_scaled)
y_test_pred = modelo.predict(X_test_scaled)

# Métricas en entrenamiento
r2_train = r2_score(y_train, y_train_pred)
rmse_train = np.sqrt(mean_squared_error(y_train, y_train_pred))
mae_train = mean_absolute_error(y_train, y_train_pred)

# Métricas en prueba
r2_test = r2_score(y_test, y_test_pred)
rmse_test = np.sqrt(mean_squared_error(y_test, y_test_pred))
mae_test = mean_absolute_error(y_test, y_test_pred)

print("MÉTRICAS EN ENTRENAMIENTO:")
print(f"  R² Score:  {r2_train:.4f}")
print(f"  RMSE:      ${rmse_train:,.2f}")
print(f"  MAE:       ${mae_train:,.2f}")
print()

print("MÉTRICAS EN PRUEBA:")
print(f"  R² Score:  {r2_test:.4f}")
print(f"  RMSE:      ${rmse_test:,.2f}")
print(f"  MAE:       ${mae_test:,.2f}")
print()

# Validación cruzada
cv_scores = cross_val_score(modelo, X_train_scaled, y_train, cv=5,
                            scoring='r2')
print(f"VALIDACIÓN CRUZADA (5-fold):")
print(f"  R² Scores: {cv_scores}")
print(f"  R² Promedio: {cv_scores.mean():.4f} (+/- {cv_scores.std() * 2:.4f})")
print()

# =============================================================================
# PASO 7: INTERPRETACIÓN Y ANÁLISIS
# =============================================================================

print("PASO 7: INTERPRETACIÓN DE RESULTADOS")
print("-" * 80)

# Importancia de features (valor absoluto de coeficientes)
importancia = pd.DataFrame({
    'Feature': X.columns,
    'Importancia': np.abs(modelo.coef_)
}).sort_values('Importancia', ascending=False)

print("Top 5 características más importantes:")
print(importancia.head().to_string(index=False))
print()

# Visualización de resultados
fig, axes = plt.subplots(2, 2, figsize=(14, 10))

# 1. Predicciones vs Real (Test)
ax1 = axes[0, 0]
ax1.scatter(y_test, y_test_pred, alpha=0.5, s=40)
ax1.plot([y_test.min(), y_test.max()], [y_test.min(), y_test.max()],
         'r--', lw=2, label='Predicción perfecta')
ax1.set_xlabel('Ventas Reales ($)', fontsize=10)
ax1.set_ylabel('Ventas Predichas ($)', fontsize=10)
ax1.set_title(f'Predicciones vs Real (R²={r2_test:.3f})', fontweight='bold')
ax1.legend()
ax1.grid(True, alpha=0.3)

# 2. Residuos
ax2 = axes[0, 1]
residuos = y_test - y_test_pred
ax2.scatter(y_test_pred, residuos, alpha=0.5, s=40)
ax2.axhline(y=0, color='r', linestyle='--', lw=2)
ax2.set_xlabel('Predicciones ($)', fontsize=10)
ax2.set_ylabel('Residuos ($)', fontsize=10)
ax2.set_title('Gráfico de Residuos', fontweight='bold')
ax2.grid(True, alpha=0.3)

# 3. Distribución de residuos
ax3 = axes[1, 0]
ax3.hist(residuos, bins=30, edgecolor='black', alpha=0.7)
ax3.axvline(x=0, color='r', linestyle='--', lw=2)
ax3.set_xlabel('Residuo ($)', fontsize=10)
ax3.set_ylabel('Frecuencia', fontsize=10)
ax3.set_title('Distribución de Residuos', fontweight='bold')
ax3.grid(True, alpha=0.3, axis='y')

# 4. Importancia de características
ax4 = axes[1, 1]
top_10 = importancia.head(10)
colors = ['green' if x > 0 else 'red' for x in modelo.coef_[top_10.index]]
ax4.barh(range(len(top_10)), top_10['Importancia'], color=colors, alpha=0.7)
ax4.set_yticks(range(len(top_10)))
ax4.set_yticklabels(top_10['Feature'], fontsize=9)
ax4.set_xlabel('Importancia (|Coeficiente|)', fontsize=10)
ax4.set_title('Top 10 Características Más Importantes', fontweight='bold')
ax4.grid(True, alpha=0.3, axis='x')

plt.tight_layout()
plt.savefig('modelo_evaluacion.png', dpi=150, bbox_inches='tight')
plt.close()
print("✓ Gráficas de evaluación guardadas en 'modelo_evaluacion.png'\n")

# =============================================================================
# PASO 8: PREDICCIONES Y RECOMENDACIONES
# =============================================================================

print("PASO 8: PREDICCIONES Y RECOMENDACIONES DE NEGOCIO")
print("-" * 80)

# Escenarios de predicción
escenarios = pd.DataFrame({
    'tv_ads': [100, 200, 150],
    'radio_ads': [20, 30, 25],
    'social_ads': [50, 75, 60],
    'promocion': [0, 1, 1],
    'competencia_cercana': [0, 0, 1],
    'estacion_Primavera': [0, 0, 1],
    'estacion_Verano': [1, 0, 0],
    'estacion_Otoño': [0, 0, 0],
    'ubicacion_Rural': [0, 0, 0],
    'ubicacion_Suburbio': [0, 1, 0]
})

# Asegurar que tenemos todas las columnas en el orden correcto
for col in X.columns:
    if col not in escenarios.columns:
        escenarios[col] = 0

escenarios = escenarios[X.columns]

# Normalizar y predecir
escenarios_scaled = scaler.transform(escenarios)
predicciones = modelo.predict(escenarios_scaled)

print("PREDICCIONES PARA DIFERENTES ESCENARIOS:\n")
for i, pred in enumerate(predicciones):
    print(f"Escenario {i+1}:")
    print(f"  - TV: ${escenarios.iloc[i]['tv_ads']}k")
    print(f"  - Radio: ${escenarios.iloc[i]['radio_ads']}k")
    print(f"  - Social Media: ${escenarios.iloc[i]['social_ads']}k")
    print(f"  - Promoción: {'Sí' if escenarios.iloc[i]['promocion'] == 1 else 'No'}")
    print(f"  → VENTAS PREDICHAS: ${pred:,.2f}")
    print()

# =============================================================================
# PASO 9: CONCLUSIONES
# =============================================================================

print("=" * 80)
print("CONCLUSIONES DEL PROYECTO")
print("=" * 80)

print(f"""
1. RENDIMIENTO DEL MODELO:
   - El modelo explica el {r2_test*100:.1f}% de la varianza en las ventas (R²)
   - Error promedio de predicción: ${mae_test:,.2f} (MAE)
   - El modelo generaliza bien (diferencia train-test pequeña)

2. FACTORES CLAVE QUE INFLUYEN EN LAS VENTAS:
   - {importancia.iloc[0]['Feature']}: Mayor impacto
   - {importancia.iloc[1]['Feature']}: Segundo mayor impacto
   - {importancia.iloc[2]['Feature']}: Tercer mayor impacto

3. RECOMENDACIONES DE NEGOCIO:
   ✓ Optimizar inversión en publicidad según los coeficientes del modelo
   ✓ Considerar estacionalidad al planificar campañas
   ✓ Las promociones tienen un impacto significativo en ventas
   ✓ La ubicación es un factor determinante

4. PRÓXIMOS PASOS:
   - Recopilar más datos históricos para mejorar el modelo
   - Probar modelos más complejos (Random Forest, XGBoost)
   - Implementar el modelo en producción
   - Monitorear el rendimiento en tiempo real
""")

print("=" * 80)
print("¡PROYECTO COMPLETADO EXITOSAMENTE!")
print("=" * 80)
print("\nArchivos generados:")
print("  - ventas_retail.csv (datos)")
print("  - eda_ventas.png (análisis exploratorio)")
print("  - modelo_evaluacion.png (evaluación del modelo)")
