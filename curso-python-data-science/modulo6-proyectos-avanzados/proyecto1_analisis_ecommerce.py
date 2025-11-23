"""
MÓDULO 6 - PROYECTOS INTEGRADOS
Proyecto 1: Análisis Completo de E-Commerce

Este proyecto integra TODO lo aprendido en el curso:
- Python fundamentals
- NumPy para cálculos
- Pandas para análisis de datos
- Matplotlib y Seaborn para visualización
- Machine Learning para predicciones

OBJETIVO: Analizar datos de un e-commerce y predecir ventas futuras
"""

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestRegressor, RandomForestClassifier
from sklearn.metrics import mean_squared_error, r2_score, classification_report
import warnings
warnings.filterwarnings('ignore')

# Configuración
sns.set_theme(style="whitegrid")
np.random.seed(42)

print("="*80)
print("PROYECTO 1: ANÁLISIS COMPLETO DE E-COMMERCE")
print("="*80)

# ============================================
# 1. GENERAR DATOS REALISTAS
# ============================================

print("\n" + "="*80)
print("PASO 1: GENERACIÓN DE DATOS")
print("="*80)

# Generar 12 meses de datos
fechas = pd.date_range('2024-01-01', periods=365, freq='D')
n_transacciones = len(fechas) * np.random.randint(50, 150)

# Crear dataset de transacciones
transacciones = pd.DataFrame({
    'fecha': np.random.choice(fechas, n_transacciones),
    'cliente_id': np.random.randint(1000, 5000, n_transacciones),
    'producto_id': np.random.randint(1, 100, n_transacciones),
    'categoria': np.random.choice(['Electrónica', 'Ropa', 'Hogar', 'Deportes', 'Libros'], n_transacciones),
    'cantidad': np.random.randint(1, 5, n_transacciones),
    'precio_unitario': np.random.uniform(10, 500, n_transacciones),
    'descuento_pct': np.random.choice([0, 5, 10, 15, 20, 25], n_transacciones),
    'metodo_pago': np.random.choice(['Tarjeta', 'PayPal', 'Transferencia'], n_transacciones),
    'region': np.random.choice(['Norte', 'Sur', 'Este', 'Oeste'], n_transacciones)
})

# Calcular campos derivados
transacciones['precio_total'] = transacciones['cantidad'] * transacciones['precio_unitario']
transacciones['descuento_valor'] = transacciones['precio_total'] * (transacciones['descuento_pct'] / 100)
transacciones['precio_final'] = transacciones['precio_total'] - transacciones['descuento_valor']

# Añadir día de la semana y mes
transacciones['dia_semana'] = transacciones['fecha'].dt.day_name()
transacciones['mes'] = transacciones['fecha'].dt.month
transacciones['mes_nombre'] = transacciones['fecha'].dt.month_name()

print(f"\nDataset generado:")
print(f"- Total de transacciones: {len(transacciones):,}")
print(f"- Período: {transacciones['fecha'].min()} a {transacciones['fecha'].max()}")
print(f"- Clientes únicos: {transacciones['cliente_id'].nunique():,}")
print(f"- Productos únicos: {transacciones['producto_id'].nunique()}")

print("\nPrimeras transacciones:")
print(transacciones.head())

# ============================================
# 2. ANÁLISIS EXPLORATORIO DE DATOS (EDA)
# ============================================

print("\n" + "="*80)
print("PASO 2: ANÁLISIS EXPLORATORIO DE DATOS")
print("="*80)

# Estadísticas básicas
print("\n--- ESTADÍSTICAS DESCRIPTIVAS ---")
print(transacciones[['cantidad', 'precio_unitario', 'precio_final']].describe())

# Información del dataset
print("\n--- INFORMACIÓN DEL DATASET ---")
print(transacciones.info())

# Valores faltantes
print(f"\nValores faltantes: {transacciones.isna().sum().sum()}")

# KPIs principales
print("\n" + "="*80)
print("KPIs PRINCIPALES")
print("="*80)

ventas_totales = transacciones['precio_final'].sum()
ticket_promedio = transacciones.groupby(['cliente_id', 'fecha'])['precio_final'].sum().mean()
clientes_unicos = transacciones['cliente_id'].nunique()
transacciones_promedio_dia = len(transacciones) / transacciones['fecha'].nunique()

print(f"💰 Ventas totales: ${ventas_totales:,.2f}")
print(f"🎫 Ticket promedio: ${ticket_promedio:.2f}")
print(f"👥 Clientes únicos: {clientes_unicos:,}")
print(f"📊 Transacciones promedio/día: {transacciones_promedio_dia:.1f}")

# ============================================
# 3. ANÁLISIS POR CATEGORÍAS
# ============================================

print("\n" + "="*80)
print("PASO 3: ANÁLISIS POR CATEGORÍAS")
print("="*80)

# Ventas por categoría
ventas_categoria = transacciones.groupby('categoria').agg({
    'precio_final': ['sum', 'mean', 'count'],
    'cliente_id': 'nunique'
}).round(2)

ventas_categoria.columns = ['Ventas_Total', 'Venta_Promedio', 'Transacciones', 'Clientes']
ventas_categoria = ventas_categoria.sort_values('Ventas_Total', ascending=False)

print("\n--- VENTAS POR CATEGORÍA ---")
print(ventas_categoria)

# Visualización 1: Ventas por categoría
fig, axes = plt.subplots(2, 2, figsize=(15, 12))

# Ventas totales por categoría
axes[0, 0].bar(ventas_categoria.index, ventas_categoria['Ventas_Total'],
               color='steelblue', edgecolor='black')
axes[0, 0].set_title('Ventas Totales por Categoría', fontweight='bold', fontsize=12)
axes[0, 0].set_ylabel('Ventas ($)')
axes[0, 0].tick_params(axis='x', rotation=45)
axes[0, 0].grid(axis='y', alpha=0.3)

# Transacciones por categoría
axes[0, 1].bar(ventas_categoria.index, ventas_categoria['Transacciones'],
               color='coral', edgecolor='black')
axes[0, 1].set_title('Transacciones por Categoría', fontweight='bold', fontsize=12)
axes[0, 1].set_ylabel('Cantidad')
axes[0, 1].tick_params(axis='x', rotation=45)
axes[0, 1].grid(axis='y', alpha=0.3)

# Distribución de precios por categoría
transacciones.boxplot(column='precio_final', by='categoria', ax=axes[1, 0])
axes[1, 0].set_title('Distribución de Precios por Categoría', fontweight='bold', fontsize=12)
axes[1, 0].set_xlabel('Categoría')
axes[1, 0].set_ylabel('Precio ($)')
plt.sca(axes[1, 0])
plt.xticks(rotation=45)

# Pie chart de participación
axes[1, 1].pie(ventas_categoria['Ventas_Total'], labels=ventas_categoria.index,
               autopct='%1.1f%%', startangle=90)
axes[1, 1].set_title('Participación de Ventas por Categoría', fontweight='bold', fontsize=12)

plt.tight_layout()
plt.savefig('/home/user/retail-studio/curso-python-data-science/modulo6-proyectos-avanzados/01_analisis_categorias.png', dpi=100)
plt.close()

print("\n✓ Visualización guardada: 01_analisis_categorias.png")

# ============================================
# 4. ANÁLISIS TEMPORAL
# ============================================

print("\n" + "="*80)
print("PASO 4: ANÁLISIS TEMPORAL")
print("="*80)

# Ventas por mes
ventas_mensuales = transacciones.groupby('mes_nombre')['precio_final'].agg(['sum', 'mean', 'count'])
ventas_mensuales.index = pd.CategoricalIndex(ventas_mensuales.index,
    categories=['January', 'February', 'March', 'April', 'May', 'June',
                'July', 'August', 'September', 'October', 'November', 'December'],
    ordered=True)
ventas_mensuales = ventas_mensuales.sort_index()

print("\n--- VENTAS MENSUALES ---")
print(ventas_mensuales)

# Ventas por día de la semana
ventas_dia_semana = transacciones.groupby('dia_semana')['precio_final'].agg(['sum', 'mean', 'count'])
orden_dias = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
ventas_dia_semana = ventas_dia_semana.reindex(orden_dias)

print("\n--- VENTAS POR DÍA DE LA SEMANA ---")
print(ventas_dia_semana)

# Visualización 2: Análisis temporal
fig, axes = plt.subplots(2, 1, figsize=(15, 10))

# Ventas mensuales
axes[0].plot(range(len(ventas_mensuales)), ventas_mensuales['sum'],
             marker='o', linewidth=2, markersize=8, color='blue')
axes[0].set_title('Evolución de Ventas Mensuales', fontweight='bold', fontsize=14)
axes[0].set_xlabel('Mes')
axes[0].set_ylabel('Ventas ($)')
axes[0].set_xticks(range(len(ventas_mensuales)))
axes[0].set_xticklabels([m[:3] for m in ventas_mensuales.index], rotation=45)
axes[0].grid(True, alpha=0.3)

# Ventas por día de la semana
axes[1].bar(range(len(ventas_dia_semana)), ventas_dia_semana['sum'],
            color='green', edgecolor='black')
axes[1].set_title('Ventas por Día de la Semana', fontweight='bold', fontsize=14)
axes[1].set_xlabel('Día')
axes[1].set_ylabel('Ventas ($)')
axes[1].set_xticks(range(len(ventas_dia_semana)))
axes[1].set_xticklabels([d[:3] for d in orden_dias], rotation=45)
axes[1].grid(axis='y', alpha=0.3)

plt.tight_layout()
plt.savefig('/home/user/retail-studio/curso-python-data-science/modulo6-proyectos-avanzados/02_analisis_temporal.png', dpi=100)
plt.close()

print("\n✓ Visualización guardada: 02_analisis_temporal.png")

# ============================================
# 5. ANÁLISIS DE CLIENTES
# ============================================

print("\n" + "="*80)
print("PASO 5: ANÁLISIS DE CLIENTES")
print("="*80)

# RFM Analysis simplificado
clientes_rfm = transacciones.groupby('cliente_id').agg({
    'fecha': 'max',  # Última compra
    'precio_final': 'sum',  # Valor total
    'cliente_id': 'count'  # Frecuencia
})
clientes_rfm.columns = ['ultima_compra', 'valor_total', 'frecuencia']
clientes_rfm['dias_desde_compra'] = (transacciones['fecha'].max() - clientes_rfm['ultima_compra']).dt.days

# Top clientes
top_clientes = clientes_rfm.nlargest(10, 'valor_total')
print("\n--- TOP 10 CLIENTES POR VALOR ---")
print(top_clientes[['valor_total', 'frecuencia', 'dias_desde_compra']])

# Segmentación simple
clientes_rfm['segmento'] = pd.cut(clientes_rfm['valor_total'],
                                  bins=[0, 500, 2000, 10000],
                                  labels=['Bajo', 'Medio', 'Alto'])

print("\n--- SEGMENTACIÓN DE CLIENTES ---")
print(clientes_rfm['segmento'].value_counts())

# ============================================
# 6. MACHINE LEARNING: PREDECIR VENTAS
# ============================================

print("\n" + "="*80)
print("PASO 6: MACHINE LEARNING - PREDICCIÓN DE VENTAS")
print("="*80)

# Preparar datos para ML
ml_data = transacciones.copy()

# Crear features
ml_data['es_fin_semana'] = ml_data['dia_semana'].isin(['Saturday', 'Sunday']).astype(int)
ml_data['trimestre'] = ml_data['mes'].apply(lambda x: (x-1)//3 + 1)

# Encoding de variables categóricas
ml_data = pd.get_dummies(ml_data, columns=['categoria', 'metodo_pago', 'region'], drop_first=True)

# Features y target
features = ['cantidad', 'precio_unitario', 'descuento_pct', 'mes', 'es_fin_semana', 'trimestre'] + \
           [col for col in ml_data.columns if col.startswith(('categoria_', 'metodo_pago_', 'region_'))]

X = ml_data[features]
y = ml_data['precio_final']

print(f"\nFeatures para el modelo: {len(features)}")
print(f"Muestras: {len(X)}")

# Dividir datos
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Entrenar modelo
print("\nEntrenando modelo Random Forest...")
modelo = RandomForestRegressor(n_estimators=100, max_depth=10, random_state=42, n_jobs=-1)
modelo.fit(X_train, y_train)

# Evaluar
y_pred = modelo.predict(X_test)
r2 = r2_score(y_test, y_pred)
rmse = np.sqrt(mean_squared_error(y_test, y_pred))

print(f"\n--- RESULTADOS DEL MODELO ---")
print(f"R² Score: {r2:.4f}")
print(f"RMSE: ${rmse:.2f}")

# Importancia de características
importancias = pd.DataFrame({
    'feature': features,
    'importancia': modelo.feature_importances_
}).sort_values('importancia', ascending=False).head(10)

print("\n--- TOP 10 CARACTERÍSTICAS MÁS IMPORTANTES ---")
print(importancias)

# Visualización 3: Resultados ML
fig, axes = plt.subplots(1, 2, figsize=(15, 6))

# Predicciones vs Real
axes[0].scatter(y_test, y_pred, alpha=0.5, edgecolors='black')
axes[0].plot([y_test.min(), y_test.max()], [y_test.min(), y_test.max()], 'r--', lw=2)
axes[0].set_xlabel('Precio Real ($)', fontsize=12)
axes[0].set_ylabel('Precio Predicho ($)', fontsize=12)
axes[0].set_title(f'Predicciones vs Real (R² = {r2:.3f})', fontweight='bold', fontsize=14)
axes[0].grid(True, alpha=0.3)

# Importancia de características
axes[1].barh(importancias['feature'], importancias['importancia'], color='steelblue', edgecolor='black')
axes[1].set_xlabel('Importancia', fontsize=12)
axes[1].set_title('Top 10 Características Más Importantes', fontweight='bold', fontsize=14)
axes[1].invert_yaxis()

plt.tight_layout()
plt.savefig('/home/user/retail-studio/curso-python-data-science/modulo6-proyectos-avanzados/03_ml_resultados.png', dpi=100)
plt.close()

print("\n✓ Visualización guardada: 03_ml_resultados.png")

# ============================================
# 7. DASHBOARD FINAL
# ============================================

print("\n" + "="*80)
print("PASO 7: DASHBOARD EJECUTIVO")
print("="*80)

# Crear dashboard con métricas clave
fig = plt.figure(figsize=(18, 12))
gs = fig.add_gridspec(3, 3, hspace=0.3, wspace=0.3)

# 1. KPIs
ax1 = fig.add_subplot(gs[0, :])
ax1.axis('off')
kpis_text = f"""
INDICADORES CLAVE DE RENDIMIENTO (KPIs)

💰 Ventas Totales: ${ventas_totales:,.2f}        🎫 Ticket Promedio: ${ticket_promedio:.2f}        👥 Clientes: {clientes_unicos:,}

📊 Transacciones/día: {transacciones_promedio_dia:.1f}        🏆 Categoría Top: {ventas_categoria.index[0]}        📈 R² Modelo ML: {r2:.3f}
"""
ax1.text(0.5, 0.5, kpis_text, ha='center', va='center', fontsize=14,
         bbox=dict(boxstyle='round', facecolor='lightblue', alpha=0.5))

# 2. Ventas por categoría
ax2 = fig.add_subplot(gs[1, 0])
ax2.bar(ventas_categoria.index, ventas_categoria['Ventas_Total'], color='steelblue', edgecolor='black')
ax2.set_title('Ventas por Categoría', fontweight='bold')
ax2.tick_params(axis='x', rotation=45)
ax2.grid(axis='y', alpha=0.3)

# 3. Evolución mensual
ax3 = fig.add_subplot(gs[1, 1:])
ax3.plot(range(len(ventas_mensuales)), ventas_mensuales['sum'], marker='o', linewidth=2, markersize=6)
ax3.set_title('Evolución de Ventas Mensuales', fontweight='bold')
ax3.set_xticks(range(len(ventas_mensuales)))
ax3.set_xticklabels([m[:3] for m in ventas_mensuales.index], rotation=45)
ax3.grid(True, alpha=0.3)

# 4. Distribución de precios
ax4 = fig.add_subplot(gs[2, 0])
ax4.hist(transacciones['precio_final'], bins=50, color='coral', edgecolor='black', alpha=0.7)
ax4.set_title('Distribución de Precios', fontweight='bold')
ax4.set_xlabel('Precio ($)')
ax4.set_ylabel('Frecuencia')
ax4.grid(axis='y', alpha=0.3)

# 5. Ventas por región
ax5 = fig.add_subplot(gs[2, 1])
ventas_region = transacciones.groupby('region')['precio_final'].sum().sort_values(ascending=False)
ax5.pie(ventas_region, labels=ventas_region.index, autopct='%1.1f%%', startangle=90)
ax5.set_title('Ventas por Región', fontweight='bold')

# 6. Predicciones ML
ax6 = fig.add_subplot(gs[2, 2])
ax6.scatter(y_test[:500], y_pred[:500], alpha=0.5, s=20, edgecolors='black')
ax6.plot([y_test.min(), y_test.max()], [y_test.min(), y_test.max()], 'r--', lw=2)
ax6.set_title(f'ML: Predicciones (R²={r2:.3f})', fontweight='bold')
ax6.set_xlabel('Real')
ax6.set_ylabel('Predicho')
ax6.grid(True, alpha=0.3)

fig.suptitle('DASHBOARD EJECUTIVO - E-COMMERCE', fontsize=18, fontweight='bold', y=0.995)
plt.savefig('/home/user/retail-studio/curso-python-data-science/modulo6-proyectos-avanzados/04_dashboard_ejecutivo.png', dpi=100)
plt.close()

print("\n✓ Dashboard guardado: 04_dashboard_ejecutivo.png")

# ============================================
# CONCLUSIONES Y RECOMENDACIONES
# ============================================

print("\n" + "="*80)
print("CONCLUSIONES Y RECOMENDACIONES")
print("="*80)

print(f"""
📊 RESUMEN EJECUTIVO:

1. RENDIMIENTO GENERAL:
   - Ventas totales: ${ventas_totales:,.2f}
   - {clientes_unicos:,} clientes únicos generaron {len(transacciones):,} transacciones
   - Ticket promedio: ${ticket_promedio:.2f}

2. CATEGORÍAS:
   - Categoría líder: {ventas_categoria.index[0]} (${ventas_categoria.iloc[0]['Ventas_Total']:,.2f})
   - Mejor relación precio/volumen: Analizar categorías de alto valor

3. TEMPORALIDAD:
   - Día más fuerte: {ventas_dia_semana.idxmax()[0]}
   - Considerar promociones en días más débiles

4. MODELO PREDICTIVO:
   - R² de {r2:.3f} indica {'buen' if r2 > 0.7 else 'aceptable'} poder predictivo
   - Variables más importantes: precio_unitario, cantidad, categoría

💡 RECOMENDACIONES:

1. Enfocar marketing en categoría {ventas_categoria.index[0]}
2. Implementar programa de fidelización para segmento Alto
3. Promociones estratégicas en días de menor venta
4. Usar modelo ML para optimizar inventario y precios
5. Analizar clientes con alta frecuencia y bajo valor (oportunidad de upselling)

✅ PROYECTO COMPLETADO CON ÉXITO
""")

print("\n" + "="*80)
print("FIN DEL PROYECTO 1")
print("="*80)
