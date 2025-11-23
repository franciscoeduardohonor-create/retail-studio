"""
MÓDULO 5: CLASIFICACIÓN Y REGRESIÓN LOGÍSTICA
==============================================

La clasificación es uno de los problemas más comunes en ML:
- Detectar spam en emails
- Diagnosticar enfermedades
- Reconocer dígitos escritos a mano
- Clasificar imágenes
- Y mucho más...

Regresión Logística: Algoritmo para clasificación binaria (2 clases)
"""

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import train_test_split, cross_val_score
from sklearn.metrics import (
    accuracy_score, precision_score, recall_score, f1_score,
    confusion_matrix, classification_report, roc_curve, auc
)
from sklearn.preprocessing import StandardScaler
from sklearn.datasets import make_classification

# =============================================================================
# 1. FUNCIÓN SIGMOIDE (Base de la regresión logística)
# =============================================================================

print("=" * 70)
print("1. FUNCIÓN SIGMOIDE")
print("=" * 70)

"""
La función sigmoide convierte cualquier valor en un número entre 0 y 1:

σ(x) = 1 / (1 + e^(-x))

Propiedades:
- σ(0) = 0.5
- σ(∞) = 1
- σ(-∞) = 0
"""

def sigmoid(x):
    """Función sigmoide"""
    return 1 / (1 + np.exp(-x))

# Visualizar la sigmoide
x = np.linspace(-10, 10, 200)
y = sigmoid(x)

plt.figure(figsize=(10, 6))
plt.plot(x, y, 'b-', linewidth=2)
plt.axhline(y=0.5, color='r', linestyle='--', alpha=0.5, label='Umbral = 0.5')
plt.axvline(x=0, color='r', linestyle='--', alpha=0.5)
plt.xlabel('x', fontsize=12)
plt.ylabel('σ(x)', fontsize=12)
plt.title('Función Sigmoide', fontsize=14, fontweight='bold')
plt.grid(True, alpha=0.3)
plt.legend()
plt.savefig('sigmoid_function.png', dpi=150, bbox_inches='tight')
plt.close()

print("La función sigmoide convierte valores continuos en probabilidades [0, 1]")
print(f"  σ(-5) = {sigmoid(-5):.4f} ≈ 0")
print(f"  σ(0) = {sigmoid(0):.4f}")
print(f"  σ(5) = {sigmoid(5):.4f} ≈ 1")
print("\n✓ Gráfica guardada como 'sigmoid_function.png'")
print()

# =============================================================================
# 2. CLASIFICACIÓN BINARIA SIMPLE
# =============================================================================

print("=" * 70)
print("2. CLASIFICACIÓN BINARIA SIMPLE")
print("=" * 70)

# Generar datos sintéticos para clasificación binaria
np.random.seed(42)
X, y = make_classification(
    n_samples=200,
    n_features=2,
    n_informative=2,
    n_redundant=0,
    n_clusters_per_class=1,
    flip_y=0.1,  # 10% de ruido
    random_state=42
)

print(f"Dataset generado:")
print(f"  Muestras: {len(X)}")
print(f"  Features: {X.shape[1]}")
print(f"  Clases: {np.unique(y)}")
print(f"  Distribución de clases: Clase 0: {(y==0).sum()}, Clase 1: {(y==1).sum()}")
print()

# Dividir en train/test
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42, stratify=y  # stratify mantiene proporción
)

# Crear y entrenar modelo
modelo = LogisticRegression(random_state=42)
modelo.fit(X_train, y_train)

print("Modelo entrenado:")
print(f"  Coeficientes: {modelo.coef_}")
print(f"  Intercepto: {modelo.intercept_}")
print()

# Hacer predicciones
y_pred = modelo.predict(X_test)

# Obtener probabilidades
y_proba = modelo.predict_proba(X_test)

print("Primeras 5 predicciones:")
print("  Real | Pred | Prob Clase 0 | Prob Clase 1")
for i in range(5):
    print(f"   {y_test[i]}   |  {y_pred[i]}   |    {y_proba[i][0]:.4f}    |    {y_proba[i][1]:.4f}")
print()

# =============================================================================
# 3. MÉTRICAS DE CLASIFICACIÓN
# =============================================================================

print("=" * 70)
print("3. MÉTRICAS DE CLASIFICACIÓN")
print("=" * 70)

"""
Métricas principales:

1. ACCURACY (Exactitud): % de predicciones correctas
   accuracy = (TP + TN) / total

2. PRECISION (Precisión): De las predicciones positivas, ¿cuántas son correctas?
   precision = TP / (TP + FP)

3. RECALL (Sensibilidad): De los positivos reales, ¿cuántos detectamos?
   recall = TP / (TP + FN)

4. F1-SCORE: Media armónica de precision y recall
   f1 = 2 * (precision * recall) / (precision + recall)

Donde:
TP = True Positives (positivos correctos)
TN = True Negatives (negativos correctos)
FP = False Positives (falsos positivos)
FN = False Negatives (falsos negativos)
"""

# Calcular métricas
accuracy = accuracy_score(y_test, y_pred)
precision = precision_score(y_test, y_pred)
recall = recall_score(y_test, y_pred)
f1 = f1_score(y_test, y_pred)

print("MÉTRICAS DEL MODELO:")
print(f"  Accuracy (Exactitud):  {accuracy:.4f} ({accuracy*100:.2f}%)")
print(f"  Precision (Precisión): {precision:.4f}")
print(f"  Recall (Sensibilidad): {recall:.4f}")
print(f"  F1-Score:              {f1:.4f}")
print()

# =============================================================================
# 4. MATRIZ DE CONFUSIÓN
# =============================================================================

print("=" * 70)
print("4. MATRIZ DE CONFUSIÓN")
print("=" * 70)

"""
La matriz de confusión muestra:
                 Predicho
               0        1
Real   0      TN       FP
       1      FN       TP
"""

cm = confusion_matrix(y_test, y_pred)
print("Matriz de Confusión:")
print(cm)
print()
print(f"  True Negatives (TN):  {cm[0, 0]}")
print(f"  False Positives (FP): {cm[0, 1]}")
print(f"  False Negatives (FN): {cm[1, 0]}")
print(f"  True Positives (TP):  {cm[1, 1]}")
print()

# Reporte de clasificación completo
print("REPORTE DE CLASIFICACIÓN:")
print(classification_report(y_test, y_pred, target_names=['Clase 0', 'Clase 1']))
print()

# =============================================================================
# 5. CURVA ROC Y AUC
# =============================================================================

print("=" * 70)
print("5. CURVA ROC Y AUC")
print("=" * 70)

"""
ROC (Receiver Operating Characteristic):
- Gráfica de True Positive Rate vs False Positive Rate
- Muestra el rendimiento del modelo en diferentes umbrales

AUC (Area Under Curve):
- Área bajo la curva ROC
- AUC = 1.0: Clasificador perfecto
- AUC = 0.5: Clasificador aleatorio
- AUC < 0.5: Peor que aleatorio
"""

# Obtener probabilidades para la clase positiva
y_proba_pos = modelo.predict_proba(X_test)[:, 1]

# Calcular curva ROC
fpr, tpr, thresholds = roc_curve(y_test, y_proba_pos)
roc_auc = auc(fpr, tpr)

print(f"AUC-ROC Score: {roc_auc:.4f}")
print()

# Visualizar curva ROC
plt.figure(figsize=(10, 8))
plt.plot(fpr, tpr, color='darkorange', lw=2, label=f'ROC curve (AUC = {roc_auc:.2f})')
plt.plot([0, 1], [0, 1], color='navy', lw=2, linestyle='--', label='Aleatorio')
plt.xlim([0.0, 1.0])
plt.ylim([0.0, 1.05])
plt.xlabel('False Positive Rate', fontsize=12)
plt.ylabel('True Positive Rate', fontsize=12)
plt.title('Curva ROC (Receiver Operating Characteristic)', fontsize=14, fontweight='bold')
plt.legend(loc="lower right")
plt.grid(True, alpha=0.3)
plt.savefig('roc_curve.png', dpi=150, bbox_inches='tight')
plt.close()

print("✓ Curva ROC guardada como 'roc_curve.png'")
print()

# =============================================================================
# 6. VALIDACIÓN CRUZADA
# =============================================================================

print("=" * 70)
print("6. VALIDACIÓN CRUZADA (Cross-Validation)")
print("=" * 70)

"""
Validación cruzada k-fold:
1. Divide los datos en k partes (folds)
2. Entrena k veces, cada vez usando k-1 folds para entrenar y 1 para validar
3. Promedia los resultados

Beneficios:
- Uso más eficiente de los datos
- Estimación más robusta del rendimiento
- Detecta overfitting
"""

# Realizar validación cruzada con 5 folds
scores = cross_val_score(modelo, X, y, cv=5, scoring='accuracy')

print("Validación Cruzada (5-fold):")
print(f"  Scores: {scores}")
print(f"  Promedio: {scores.mean():.4f}")
print(f"  Desviación estándar: {scores.std():.4f}")
print()

# =============================================================================
# 7. EJEMPLO PRÁCTICO: DETECCIÓN DE SPAM
# =============================================================================

print("=" * 70)
print("7. EJEMPLO PRÁCTICO: Detección de Spam")
print("=" * 70)

# Simular características de emails
np.random.seed(42)
n_emails = 1000

# Características:
# - Cantidad de palabras "gratis", "oferta", etc.
# - Cantidad de signos de exclamación
# - Cantidad de mayúsculas
# - Longitud del email

emails = pd.DataFrame({
    'palabras_spam': np.random.poisson(3, n_emails),
    'exclamaciones': np.random.poisson(2, n_emails),
    'mayusculas_pct': np.random.uniform(0, 50, n_emails),
    'longitud': np.random.randint(50, 500, n_emails),
})

# Generar etiquetas (spam/no spam) basadas en las características
spam_score = (
    emails['palabras_spam'] * 0.3 +
    emails['exclamaciones'] * 0.25 +
    emails['mayusculas_pct'] * 0.02 +
    np.random.randn(n_emails) * 0.5
)

emails['es_spam'] = (spam_score > 1.5).astype(int)

print("Dataset de emails:")
print(emails.head(10))
print()
print(f"Total de emails: {len(emails)}")
print(f"Emails spam: {emails['es_spam'].sum()} ({emails['es_spam'].sum()/len(emails)*100:.1f}%)")
print(f"Emails legítimos: {(1-emails['es_spam']).sum()} ({(1-emails['es_spam']).sum()/len(emails)*100:.1f}%)")
print()

# Preparar datos
X = emails.drop('es_spam', axis=1).values
y = emails['es_spam'].values

# Dividir datos
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42, stratify=y
)

# Normalizar (importante para regresión logística)
scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train)
X_test_scaled = scaler.transform(X_test)

# Entrenar modelo
modelo_spam = LogisticRegression(random_state=42, max_iter=1000)
modelo_spam.fit(X_train_scaled, y_train)

# Evaluar
y_pred = modelo_spam.predict(X_test_scaled)

print("RESULTADOS DEL DETECTOR DE SPAM:")
print("=" * 70)
print(f"Accuracy:  {accuracy_score(y_test, y_pred):.4f}")
print(f"Precision: {precision_score(y_test, y_pred):.4f} (de los marcados como spam, % que son spam)")
print(f"Recall:    {recall_score(y_test, y_pred):.4f} (de los spam reales, % que detectamos)")
print(f"F1-Score:  {f1_score(y_test, y_pred):.4f}")
print()

print("Matriz de Confusión:")
cm = confusion_matrix(y_test, y_pred)
print(cm)
print()
print(f"  Emails legítimos correctos (TN): {cm[0, 0]}")
print(f"  Emails legítimos marcados como spam (FP): {cm[0, 1]} ❌")
print(f"  Spam no detectado (FN): {cm[1, 0]} ❌")
print(f"  Spam correctamente detectado (TP): {cm[1, 1]} ✓")
print()

# Importancia de características
feature_names = ['palabras_spam', 'exclamaciones', 'mayusculas_pct', 'longitud']
importances = pd.DataFrame({
    'Feature': feature_names,
    'Coeficiente': modelo_spam.coef_[0]
}).sort_values('Coeficiente', ascending=False, key=abs)

print("Importancia de características:")
print(importances)
print()

# Probar con un nuevo email
nuevo_email = np.array([[5, 8, 35, 200]])  # muchas palabras spam, exclamaciones, mayúsculas
nuevo_email_scaled = scaler.transform(nuevo_email)
prediccion = modelo_spam.predict(nuevo_email_scaled)
probabilidad = modelo_spam.predict_proba(nuevo_email_scaled)

print("Predicción para nuevo email:")
print(f"  Características: {nuevo_email[0]}")
print(f"  Predicción: {'SPAM' if prediccion[0] == 1 else 'LEGÍTIMO'}")
print(f"  Probabilidad de ser spam: {probabilidad[0][1]:.2%}")
print()

# =============================================================================
# 8. VISUALIZACIONES FINALES
# =============================================================================

print("=" * 70)
print("8. VISUALIZACIONES")
print("=" * 70)

fig, axes = plt.subplots(2, 2, figsize=(14, 12))

# 1. Frontera de decisión (solo para 2 features)
ax1 = axes[0, 0]
# Usar solo las primeras 2 características para visualización
X_2d = X[:, :2]
modelo_2d = LogisticRegression(random_state=42, max_iter=1000)
scaler_2d = StandardScaler()
X_2d_scaled = scaler_2d.fit_transform(X_2d)
modelo_2d.fit(X_2d_scaled, y)

# Crear malla
h = 0.02
x_min, x_max = X_2d_scaled[:, 0].min() - 1, X_2d_scaled[:, 0].max() + 1
y_min, y_max = X_2d_scaled[:, 1].min() - 1, X_2d_scaled[:, 1].max() + 1
xx, yy = np.meshgrid(np.arange(x_min, x_max, h), np.arange(y_min, y_max, h))

Z = modelo_2d.predict(np.c_[xx.ravel(), yy.ravel()])
Z = Z.reshape(xx.shape)

ax1.contourf(xx, yy, Z, alpha=0.3, cmap='RdYlBu')
scatter = ax1.scatter(X_2d_scaled[:, 0], X_2d_scaled[:, 1], c=y, cmap='RdYlBu', edgecolors='black', alpha=0.6)
ax1.set_xlabel('Feature 1 (normalizada)', fontsize=10)
ax1.set_ylabel('Feature 2 (normalizada)', fontsize=10)
ax1.set_title('Frontera de Decisión', fontweight='bold')
plt.colorbar(scatter, ax=ax1)

# 2. Matriz de confusión (heatmap)
ax2 = axes[0, 1]
im = ax2.imshow(cm, interpolation='nearest', cmap='Blues')
ax2.set_title('Matriz de Confusión', fontweight='bold')
plt.colorbar(im, ax=ax2)
tick_marks = np.arange(2)
ax2.set_xticks(tick_marks)
ax2.set_yticks(tick_marks)
ax2.set_xticklabels(['Legítimo', 'Spam'])
ax2.set_yticklabels(['Legítimo', 'Spam'])
ax2.set_ylabel('Real', fontsize=10)
ax2.set_xlabel('Predicción', fontsize=10)

# Añadir valores
for i in range(2):
    for j in range(2):
        ax2.text(j, i, str(cm[i, j]), ha="center", va="center", color="black", fontsize=14, fontweight='bold')

# 3. Distribución de probabilidades
ax3 = axes[1, 0]
y_proba_all = modelo_spam.predict_proba(X_test_scaled)[:, 1]
ax3.hist(y_proba_all[y_test == 0], bins=30, alpha=0.5, label='Legítimo', color='blue')
ax3.hist(y_proba_all[y_test == 1], bins=30, alpha=0.5, label='Spam', color='red')
ax3.axvline(x=0.5, color='green', linestyle='--', lw=2, label='Umbral')
ax3.set_xlabel('Probabilidad de Spam', fontsize=10)
ax3.set_ylabel('Frecuencia', fontsize=10)
ax3.set_title('Distribución de Probabilidades Predichas', fontweight='bold')
ax3.legend()
ax3.grid(True, alpha=0.3)

# 4. Importancia de características
ax4 = axes[1, 1]
colors = ['green' if x > 0 else 'red' for x in importances['Coeficiente']]
ax4.barh(importances['Feature'], importances['Coeficiente'], color=colors, alpha=0.7)
ax4.set_xlabel('Coeficiente', fontsize=10)
ax4.set_title('Importancia de Características', fontweight='bold')
ax4.grid(True, alpha=0.3, axis='x')

plt.tight_layout()
plt.savefig('clasificacion_analisis.png', dpi=150, bbox_inches='tight')
print("✓ Visualizaciones guardadas como 'clasificacion_analisis.png'")
plt.close()

print("\n" + "=" * 70)
print("¡Has completado el módulo de Clasificación!")
print("=" * 70)
print("\nResumen de lo aprendido:")
print("✓ Función sigmoide")
print("✓ Regresión logística")
print("✓ Métricas: Accuracy, Precision, Recall, F1-Score")
print("✓ Matriz de confusión")
print("✓ Curva ROC y AUC")
print("✓ Validación cruzada")
print("✓ Proyecto completo: Detector de spam")
