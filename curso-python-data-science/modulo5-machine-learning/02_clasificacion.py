"""
MÓDULO 5 - MACHINE LEARNING
Lección 2: Clasificación con Scikit-Learn

CLASIFICACIÓN: Predecir categorías/clases (spam/no spam, enfermo/sano, etc.)

En esta lección aprenderás:
- Regresión Logística
- Árboles de Decisión
- Random Forest
- Métricas de clasificación
- Matriz de confusión
"""

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.model_selection import train_test_split, cross_val_score
from sklearn.linear_model import LogisticRegression
from sklearn.tree import DecisionTreeClassifier, plot_tree
from sklearn.ensemble import RandomForestClassifier
from sklearn.preprocessing import StandardScaler
from sklearn.metrics import (accuracy_score, precision_score, recall_score, f1_score,
                             confusion_matrix, classification_report)
from sklearn.datasets import make_classification
import warnings
warnings.filterwarnings('ignore')

# ============================================
# 1. CONCEPTOS BÁSICOS
# ============================================

print("="*70)
print("CLASIFICACIÓN - CONCEPTOS BÁSICOS")
print("="*70)

print("""
CLASIFICACIÓN: Asignar categorías a datos

TIPOS:
- Binaria: 2 clases (Sí/No, Spam/No spam)
- Multiclase: 3+ clases (Bajo/Medio/Alto)

ALGORITMOS COMUNES:
1. Regresión Logística (simple, interpretable)
2. Árboles de Decisión (interpretable, no lineal)
3. Random Forest (potente, menos interpretable)
4. SVM, KNN, Naive Bayes, etc.

MÉTRICAS:
- Accuracy: % predicciones correctas
- Precision: De los predichos positivos, % correctos
- Recall: De los realmente positivos, % detectados
- F1-Score: Media armónica de precision y recall

MATRIZ DE CONFUSIÓN:
                 Predicho
                 Neg  Pos
Real   Neg       TN   FP
       Pos       FN   TP

TN: True Negative, TP: True Positive
FN: False Negative, FP: False Positive
""")

# ============================================
# 2. DATASET DE EJEMPLO
# ============================================

print("\n" + "="*70)
print("CREAR DATASET DE CLIENTES")
print("="*70)

# Generar dataset de clientes que compran/no compran
np.random.seed(42)
n_clientes = 1000

datos = pd.DataFrame({
    'edad': np.random.randint(18, 70, n_clientes),
    'ingresos_miles': np.random.uniform(20, 150, n_clientes),
    'visitas_web': np.random.randint(0, 50, n_clientes),
    'tiempo_cliente_meses': np.random.randint(0, 60, n_clientes)
})

# Generar variable objetivo (compra o no)
# Probabilidad basada en características
prob_compra = (
    0.01 * datos['edad'] +
    0.02 * datos['ingresos_miles'] +
    0.03 * datos['visitas_web'] +
    0.02 * datos['tiempo_cliente_meses']
) / 10

# Añadir ruido y convertir a 0/1
datos['compra'] = (prob_compra + np.random.uniform(0, 0.3, n_clientes) > 0.5).astype(int)

print("Dataset de clientes:")
print(datos.head(10))
print(f"\nForma: {datos.shape}")

# Distribución de clases
print("\n--- DISTRIBUCIÓN DE CLASES ---")
print(datos['compra'].value_counts())
print(f"Porcentaje que compra: {datos['compra'].mean()*100:.1f}%")

# ============================================
# 3. REGRESIÓN LOGÍSTICA
# ============================================

print("\n" + "="*70)
print("REGRESIÓN LOGÍSTICA")
print("="*70)

# Preparar datos
X = datos.drop('compra', axis=1)
y = datos['compra']

# Dividir datos
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42, stratify=y
)

print(f"Entrenamiento: {len(X_train)} | Prueba: {len(X_test)}")
print(f"Clases en train: {y_train.value_counts().to_dict()}")
print(f"Clases en test: {y_test.value_counts().to_dict()}")

# Normalizar (importante para regresión logística)
scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train)
X_test_scaled = scaler.transform(X_test)

# Entrenar modelo
log_reg = LogisticRegression(random_state=42, max_iter=1000)
log_reg.fit(X_train_scaled, y_train)

# Predicciones
y_pred = log_reg.predict(X_test_scaled)
y_pred_proba = log_reg.predict_proba(X_test_scaled)[:, 1]  # Probabilidad de clase 1

# Evaluar
print("\n--- EVALUACIÓN ---")
print(f"Accuracy: {accuracy_score(y_test, y_pred):.4f}")
print(f"Precision: {precision_score(y_test, y_pred):.4f}")
print(f"Recall: {recall_score(y_test, y_pred):.4f}")
print(f"F1-Score: {f1_score(y_test, y_pred):.4f}")

# Matriz de confusión
cm = confusion_matrix(y_test, y_pred)
print("\n--- MATRIZ DE CONFUSIÓN ---")
print(cm)

# Visualizar matriz de confusión
plt.figure(figsize=(8, 6))
sns.heatmap(cm, annot=True, fmt='d', cmap='Blues', cbar=False)
plt.title('Matriz de Confusión - Regresión Logística', fontsize=14, fontweight='bold')
plt.ylabel('Real', fontsize=12)
plt.xlabel('Predicho', fontsize=12)
plt.xticks([0.5, 1.5], ['No Compra', 'Compra'])
plt.yticks([0.5, 1.5], ['No Compra', 'Compra'])
plt.tight_layout()
plt.savefig('/home/user/retail-studio/curso-python-data-science/modulo5-machine-learning/05_confusion_matrix.png', dpi=100)
plt.close()

print("✓ Visualización guardada: 05_confusion_matrix.png")

# Reporte de clasificación
print("\n--- REPORTE COMPLETO ---")
print(classification_report(y_test, y_pred, target_names=['No Compra', 'Compra']))

# Importancia de características (coeficientes)
print("\n--- IMPORTANCIA DE CARACTERÍSTICAS ---")
importancias = pd.DataFrame({
    'caracteristica': X.columns,
    'coeficiente': log_reg.coef_[0]
}).sort_values('coeficiente', ascending=False)
print(importancias)

# ============================================
# 4. ÁRBOL DE DECISIÓN
# ============================================

print("\n" + "="*70)
print("ÁRBOL DE DECISIÓN")
print("="*70)

# Entrenar árbol (sin normalización - no es necesaria)
tree = DecisionTreeClassifier(max_depth=4, random_state=42)
tree.fit(X_train, y_train)

# Predicciones
y_pred_tree = tree.predict(X_test)

# Evaluar
print("\n--- EVALUACIÓN ---")
print(f"Accuracy: {accuracy_score(y_test, y_pred_tree):.4f}")
print(f"Precision: {precision_score(y_test, y_pred_tree):.4f}")
print(f"Recall: {recall_score(y_test, y_pred_tree):.4f}")
print(f"F1-Score: {f1_score(y_test, y_pred_tree):.4f}")

# Visualizar árbol
plt.figure(figsize=(20, 10))
plot_tree(tree, feature_names=X.columns, class_names=['No', 'Sí'],
          filled=True, rounded=True, fontsize=10)
plt.title('Árbol de Decisión', fontsize=16, fontweight='bold')
plt.tight_layout()
plt.savefig('/home/user/retail-studio/curso-python-data-science/modulo5-machine-learning/06_arbol_decision.png', dpi=100)
plt.close()

print("✓ Visualización guardada: 06_arbol_decision.png")

# Importancia de características
importancia_tree = pd.DataFrame({
    'caracteristica': X.columns,
    'importancia': tree.feature_importances_
}).sort_values('importancia', ascending=False)

print("\n--- IMPORTANCIA DE CARACTERÍSTICAS ---")
print(importancia_tree)

# Visualizar importancia
plt.figure(figsize=(10, 6))
plt.barh(importancia_tree['caracteristica'], importancia_tree['importancia'],
         color='steelblue', edgecolor='black')
plt.xlabel('Importancia', fontsize=12)
plt.title('Importancia de Características - Árbol de Decisión',
          fontsize=14, fontweight='bold')
plt.tight_layout()
plt.savefig('/home/user/retail-studio/curso-python-data-science/modulo5-machine-learning/07_importancia.png', dpi=100)
plt.close()

print("✓ Visualización guardada: 07_importancia.png")

# ============================================
# 5. RANDOM FOREST
# ============================================

print("\n" + "="*70)
print("RANDOM FOREST")
print("="*70)

print("""
Random Forest:
- Conjunto (ensemble) de múltiples árboles
- Cada árbol entrena con subset aleatorio de datos
- Predicción final por votación mayoritaria
- Más robusto que un solo árbol
- Reduce overfitting
""")

# Entrenar Random Forest
rf = RandomForestClassifier(n_estimators=100, max_depth=5, random_state=42)
rf.fit(X_train, y_train)

# Predicciones
y_pred_rf = rf.predict(X_test)

# Evaluar
print("\n--- EVALUACIÓN ---")
print(f"Accuracy: {accuracy_score(y_test, y_pred_rf):.4f}")
print(f"Precision: {precision_score(y_test, y_pred_rf):.4f}")
print(f"Recall: {recall_score(y_test, y_pred_rf):.4f}")
print(f"F1-Score: {f1_score(y_test, y_pred_rf):.4f}")

# Importancia de características
importancia_rf = pd.DataFrame({
    'caracteristica': X.columns,
    'importancia': rf.feature_importances_
}).sort_values('importancia', ascending=False)

print("\n--- IMPORTANCIA DE CARACTERÍSTICAS ---")
print(importancia_rf)

# ============================================
# 6. COMPARACIÓN DE MODELOS
# ============================================

print("\n" + "="*70)
print("COMPARACIÓN DE MODELOS")
print("="*70)

# Recopilar métricas
modelos_resultados = pd.DataFrame({
    'Modelo': ['Regresión Logística', 'Árbol de Decisión', 'Random Forest'],
    'Accuracy': [
        accuracy_score(y_test, y_pred),
        accuracy_score(y_test, y_pred_tree),
        accuracy_score(y_test, y_pred_rf)
    ],
    'Precision': [
        precision_score(y_test, y_pred),
        precision_score(y_test, y_pred_tree),
        precision_score(y_test, y_pred_rf)
    ],
    'Recall': [
        recall_score(y_test, y_pred),
        recall_score(y_test, y_pred_tree),
        recall_score(y_test, y_pred_rf)
    ],
    'F1-Score': [
        f1_score(y_test, y_pred),
        f1_score(y_test, y_pred_tree),
        f1_score(y_test, y_pred_rf)
    ]
})

print("\n--- TABLA DE COMPARACIÓN ---")
print(modelos_resultados.to_string(index=False))

# Visualizar comparación
fig, axes = plt.subplots(2, 2, figsize=(14, 10))

metricas = ['Accuracy', 'Precision', 'Recall', 'F1-Score']
for idx, metrica in enumerate(metricas):
    ax = axes[idx // 2, idx % 2]
    ax.bar(modelos_resultados['Modelo'], modelos_resultados[metrica],
           color=['blue', 'green', 'red'], edgecolor='black')
    ax.set_ylabel(metrica, fontsize=12)
    ax.set_title(f'{metrica} por Modelo', fontsize=12, fontweight='bold')
    ax.set_ylim([0, 1])
    ax.grid(axis='y', alpha=0.3)
    ax.tick_params(axis='x', rotation=15)

plt.tight_layout()
plt.savefig('/home/user/retail-studio/curso-python-data-science/modulo5-machine-learning/08_comparacion_modelos.png', dpi=100)
plt.close()

print("\n✓ Visualización guardada: 08_comparacion_modelos.png")

# ============================================
# 7. HACER PREDICCIONES
# ============================================

print("\n" + "="*70)
print("HACER PREDICCIONES CON NUEVOS CLIENTES")
print("="*70)

# Nuevos clientes
nuevos_clientes = pd.DataFrame({
    'edad': [25, 45, 60],
    'ingresos_miles': [35, 90, 120],
    'visitas_web': [5, 25, 40],
    'tiempo_cliente_meses': [3, 24, 48]
})

print("Nuevos clientes:")
print(nuevos_clientes)

# Predecir con el mejor modelo (Random Forest)
predicciones = rf.predict(nuevos_clientes)
probabilidades = rf.predict_proba(nuevos_clientes)

print("\n--- PREDICCIONES ---")
for i, (pred, proba) in enumerate(zip(predicciones, probabilidades)):
    print(f"\nCliente {i+1}:")
    print(f"  Predicción: {'COMPRARÁ' if pred == 1 else 'NO COMPRARÁ'}")
    print(f"  Probabilidad No Compra: {proba[0]:.2%}")
    print(f"  Probabilidad Compra: {proba[1]:.2%}")

# ============================================
# 8. VALIDACIÓN CRUZADA
# ============================================

print("\n" + "="*70)
print("VALIDACIÓN CRUZADA")
print("="*70)

# Validar con cross-validation
for nombre, modelo in [
    ('Regresión Logística', LogisticRegression(max_iter=1000)),
    ('Árbol de Decisión', DecisionTreeClassifier(max_depth=4)),
    ('Random Forest', RandomForestClassifier(n_estimators=100, max_depth=5))
]:
    scores = cross_val_score(modelo, X, y, cv=5, scoring='f1')
    print(f"\n{nombre}:")
    print(f"  F1-Scores: {scores}")
    print(f"  Promedio: {scores.mean():.4f} (+/- {scores.std():.4f})")

# ============================================
# RESUMEN
# ============================================

print("\n" + "="*70)
print("RESUMEN")
print("="*70)
print("""
CLASIFICACIÓN:

MODELOS:
1. Regresión Logística:
   - Simple, rápido
   - Interpretable
   - Bueno para problemas lineales

2. Árbol de Decisión:
   - Muy interpretable
   - No requiere normalización
   - Puede hacer overfitting

3. Random Forest:
   - Más preciso
   - Robusto
   - Menos interpretable

MÉTRICAS:
- Accuracy: % total correcto
- Precision: De predichos positivos, % correctos
- Recall: De reales positivos, % detectados
- F1: Promedio de precision y recall

CUÁNDO USAR QUÉ:
- Accuracy: Clases balanceadas
- Precision: Minimizar falsos positivos (ej: spam)
- Recall: Minimizar falsos negativos (ej: cáncer)
- F1: Balance entre precision y recall

PROCESO:
1. Preparar datos (limpiar, dividir)
2. Entrenar modelos
3. Evaluar con múltiples métricas
4. Comparar modelos
5. Validación cruzada
6. Seleccionar mejor modelo
7. Predecir nuevos datos
""")

# ============================================
# EJERCICIOS PARA PRACTICAR
# ============================================

print("\n" + "="*70)
print("EJERCICIOS PARA TI:")
print("="*70)
print("""
1. CLASIFICACIÓN BINARIA:
   - Dataset: predecir si un email es spam
   - Genera datos sintéticos
   - Entrena 3 modelos
   - Compara resultados

2. MATRIZ DE CONFUSIÓN:
   - Analiza en detalle la matriz
   - Calcula manualmente precision y recall
   - Interpreta falsos positivos y negativos

3. IMPORTANCIA DE CARACTERÍSTICAS:
   - Identifica qué variables son más importantes
   - Entrena modelo solo con top 3 características
   - Compara con modelo completo

4. AJUSTE DE HIPERPARÁMETROS:
   - Árbol: prueba max_depth de 2 a 10
   - Random Forest: prueba n_estimators 10, 50, 100, 200
   - ¿Cómo afecta el rendimiento?

5. PROYECTO COMPLETO:
   - Dataset: predecir abandono de clientes (churn)
   - Genera o descarga dataset
   - EDA completo
   - Prueba 5+ modelos
   - Optimiza hiperparámetros
   - Valida con cross-validation
   - Presenta resultados con visualizaciones

¡La clasificación es esencial en ML!
""")
