"""
MÓDULO 4 - VISUALIZACIÓN DE DATOS
Lección 2: Seaborn - Visualización Estadística

Seaborn es una librería de visualización de alto nivel construida sobre Matplotlib.
Está diseñada específicamente para análisis estadístico y se integra perfectamente con Pandas.

En esta lección aprenderás:
- Gráficas de distribución
- Gráficas de relación
- Gráficas categóricas
- Matrices de correlación
- Pairplots
"""

import seaborn as sns
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np

# Configurar estilo de seaborn
sns.set_theme(style="whitegrid")

# ============================================
# 1. DATASETS DE SEABORN
# ============================================

print("="*60)
print("DATASETS DE EJEMPLO EN SEABORN")
print("="*60)

# Seaborn incluye datasets de ejemplo
tips = sns.load_dataset('tips')
print("\nDataset 'tips' (propinas en restaurante):")
print(tips.head())
print(f"\nForma: {tips.shape}")
print(f"\nColumnas: {list(tips.columns)}")

iris = sns.load_dataset('iris')
print("\nDataset 'iris' (flores):")
print(iris.head())

# ============================================
# 2. GRÁFICAS DE DISTRIBUCIÓN
# ============================================

print("\n" + "="*60)
print("GRÁFICAS DE DISTRIBUCIÓN")
print("="*60)

# Histograma con KDE (Kernel Density Estimation)
plt.figure(figsize=(10, 6))
sns.histplot(data=tips, x='total_bill', kde=True, bins=30, color='skyblue')
plt.title('Distribución de Cuentas Totales', fontsize=16, fontweight='bold')
plt.xlabel('Cuenta Total ($)', fontsize=12)
plt.ylabel('Frecuencia', fontsize=12)
plt.tight_layout()
plt.savefig('/home/user/retail-studio/curso-python-data-science/modulo4-visualizacion/15_histplot.png', dpi=100, bbox_inches='tight')
plt.close()

print("✓ Gráfica guardada: 15_histplot.png")

# KDE plot (solo curva de densidad)
plt.figure(figsize=(10, 6))
sns.kdeplot(data=tips, x='total_bill', fill=True, color='coral')
plt.title('Densidad de Cuentas Totales', fontsize=16, fontweight='bold')
plt.xlabel('Cuenta Total ($)', fontsize=12)
plt.tight_layout()
plt.savefig('/home/user/retail-studio/curso-python-data-science/modulo4-visualizacion/16_kdeplot.png', dpi=100, bbox_inches='tight')
plt.close()

print("✓ Gráfica guardada: 16_kdeplot.png")

# Distribución por categoría
plt.figure(figsize=(10, 6))
sns.histplot(data=tips, x='total_bill', hue='sex', kde=True, bins=20, alpha=0.6)
plt.title('Distribución de Cuentas por Género', fontsize=16, fontweight='bold')
plt.xlabel('Cuenta Total ($)', fontsize=12)
plt.ylabel('Frecuencia', fontsize=12)
plt.tight_layout()
plt.savefig('/home/user/retail-studio/curso-python-data-science/modulo4-visualizacion/17_histplot_hue.png', dpi=100, bbox_inches='tight')
plt.close()

print("✓ Gráfica guardada: 17_histplot_hue.png")

# ============================================
# 3. BOX PLOTS Y VIOLIN PLOTS
# ============================================

print("\n" + "="*60)
print("BOX PLOTS Y VIOLIN PLOTS")
print("="*60)

# Box plot - muestra mediana, cuartiles, outliers
plt.figure(figsize=(10, 6))
sns.boxplot(data=tips, x='day', y='total_bill', palette='Set2')
plt.title('Distribución de Cuentas por Día', fontsize=16, fontweight='bold')
plt.xlabel('Día', fontsize=12)
plt.ylabel('Cuenta Total ($)', fontsize=12)
plt.tight_layout()
plt.savefig('/home/user/retail-studio/curso-python-data-science/modulo4-visualizacion/18_boxplot.png', dpi=100, bbox_inches='tight')
plt.close()

print("✓ Gráfica guardada: 18_boxplot.png")

# Box plot con hue
plt.figure(figsize=(12, 6))
sns.boxplot(data=tips, x='day', y='total_bill', hue='sex', palette='Set1')
plt.title('Distribución de Cuentas por Día y Género', fontsize=16, fontweight='bold')
plt.xlabel('Día', fontsize=12)
plt.ylabel('Cuenta Total ($)', fontsize=12)
plt.tight_layout()
plt.savefig('/home/user/retail-studio/curso-python-data-science/modulo4-visualizacion/19_boxplot_hue.png', dpi=100, bbox_inches='tight')
plt.close()

print("✓ Gráfica guardada: 19_boxplot_hue.png")

# Violin plot - combina box plot con KDE
plt.figure(figsize=(12, 6))
sns.violinplot(data=tips, x='day', y='total_bill', hue='sex', split=True, palette='muted')
plt.title('Violin Plot: Cuentas por Día y Género', fontsize=16, fontweight='bold')
plt.xlabel('Día', fontsize=12)
plt.ylabel('Cuenta Total ($)', fontsize=12)
plt.tight_layout()
plt.savefig('/home/user/retail-studio/curso-python-data-science/modulo4-visualizacion/20_violinplot.png', dpi=100, bbox_inches='tight')
plt.close()

print("✓ Gráfica guardada: 20_violinplot.png")

# ============================================
# 4. GRÁFICAS DE RELACIÓN
# ============================================

print("\n" + "="*60)
print("GRÁFICAS DE RELACIÓN")
print("="*60)

# Scatter plot con regresión
plt.figure(figsize=(10, 6))
sns.regplot(data=tips, x='total_bill', y='tip', scatter_kws={'alpha':0.5})
plt.title('Relación: Cuenta Total vs Propina', fontsize=16, fontweight='bold')
plt.xlabel('Cuenta Total ($)', fontsize=12)
plt.ylabel('Propina ($)', fontsize=12)
plt.tight_layout()
plt.savefig('/home/user/retail-studio/curso-python-data-science/modulo4-visualizacion/21_regplot.png', dpi=100, bbox_inches='tight')
plt.close()

print("✓ Gráfica guardada: 21_regplot.png")

# Scatter plot con categorías
plt.figure(figsize=(10, 6))
sns.scatterplot(data=tips, x='total_bill', y='tip', hue='time', style='sex', s=100, alpha=0.7)
plt.title('Propinas: Cuenta vs Propina (por tiempo y género)', fontsize=16, fontweight='bold')
plt.xlabel('Cuenta Total ($)', fontsize=12)
plt.ylabel('Propina ($)', fontsize=12)
plt.tight_layout()
plt.savefig('/home/user/retail-studio/curso-python-data-science/modulo4-visualizacion/22_scatterplot.png', dpi=100, bbox_inches='tight')
plt.close()

print("✓ Gráfica guardada: 22_scatterplot.png")

# ============================================
# 5. GRÁFICAS CATEGÓRICAS
# ============================================

print("\n" + "="*60)
print("GRÁFICAS CATEGÓRICAS")
print("="*60)

# Bar plot (con estadísticas automáticas)
plt.figure(figsize=(10, 6))
sns.barplot(data=tips, x='day', y='total_bill', estimator=np.mean, palette='viridis')
plt.title('Promedio de Cuentas por Día', fontsize=16, fontweight='bold')
plt.xlabel('Día', fontsize=12)
plt.ylabel('Cuenta Promedio ($)', fontsize=12)
plt.tight_layout()
plt.savefig('/home/user/retail-studio/curso-python-data-science/modulo4-visualizacion/23_barplot.png', dpi=100, bbox_inches='tight')
plt.close()

print("✓ Gráfica guardada: 23_barplot.png")

# Count plot (conteo automático)
plt.figure(figsize=(10, 6))
sns.countplot(data=tips, x='day', hue='sex', palette='pastel')
plt.title('Cantidad de Clientes por Día y Género', fontsize=16, fontweight='bold')
plt.xlabel('Día', fontsize=12)
plt.ylabel('Cantidad', fontsize=12)
plt.tight_layout()
plt.savefig('/home/user/retail-studio/curso-python-data-science/modulo4-visualizacion/24_countplot.png', dpi=100, bbox_inches='tight')
plt.close()

print("✓ Gráfica guardada: 24_countplot.png")

# Point plot (muestra estimador con intervalos de confianza)
plt.figure(figsize=(10, 6))
sns.pointplot(data=tips, x='day', y='total_bill', hue='sex', markers=['o', 's'], linestyles=['-', '--'])
plt.title('Tendencia de Cuentas por Día y Género', fontsize=16, fontweight='bold')
plt.xlabel('Día', fontsize=12)
plt.ylabel('Cuenta Promedio ($)', fontsize=12)
plt.tight_layout()
plt.savefig('/home/user/retail-studio/curso-python-data-science/modulo4-visualizacion/25_pointplot.png', dpi=100, bbox_inches='tight')
plt.close()

print("✓ Gráfica guardada: 25_pointplot.png")

# ============================================
# 6. HEATMAPS - MATRICES DE CORRELACIÓN
# ============================================

print("\n" + "="*60)
print("HEATMAPS - MATRICES DE CORRELACIÓN")
print("="*60)

# Crear dataset numérico
datos_numericos = tips[['total_bill', 'tip', 'size']].copy()

# Calcular correlación
correlacion = datos_numericos.corr()
print("\nMatriz de correlación:")
print(correlacion)

# Heatmap de correlación
plt.figure(figsize=(8, 6))
sns.heatmap(correlacion, annot=True, fmt='.2f', cmap='coolwarm', center=0,
            square=True, linewidths=1, cbar_kws={'label': 'Correlación'})
plt.title('Matriz de Correlación', fontsize=16, fontweight='bold')
plt.tight_layout()
plt.savefig('/home/user/retail-studio/curso-python-data-science/modulo4-visualizacion/26_heatmap.png', dpi=100, bbox_inches='tight')
plt.close()

print("✓ Gráfica guardada: 26_heatmap.png")

# Heatmap de datos
np.random.seed(42)
datos_matriz = np.random.rand(10, 12)
meses_cortos = ['E', 'F', 'M', 'A', 'My', 'Jn', 'Jl', 'Ag', 'S', 'O', 'N', 'D']

plt.figure(figsize=(12, 8))
sns.heatmap(datos_matriz, annot=True, fmt='.2f', cmap='YlOrRd',
            xticklabels=meses_cortos, yticklabels=[f'P{i+1}' for i in range(10)],
            cbar_kws={'label': 'Ventas'})
plt.title('Ventas por Producto y Mes', fontsize=16, fontweight='bold')
plt.xlabel('Mes', fontsize=12)
plt.ylabel('Producto', fontsize=12)
plt.tight_layout()
plt.savefig('/home/user/retail-studio/curso-python-data-science/modulo4-visualizacion/27_heatmap_datos.png', dpi=100, bbox_inches='tight')
plt.close()

print("✓ Gráfica guardada: 27_heatmap_datos.png")

# ============================================
# 7. PAIRPLOT - RELACIONES MÚLTIPLES
# ============================================

print("\n" + "="*60)
print("PAIRPLOT - ANÁLISIS MULTIVARIABLE")
print("="*60)

# Pairplot del dataset iris
pairplot_fig = sns.pairplot(iris, hue='species', palette='husl', diag_kind='kde', height=2.5)
pairplot_fig.fig.suptitle('Pairplot del Dataset Iris', y=1.02, fontsize=16, fontweight='bold')
plt.tight_layout()
plt.savefig('/home/user/retail-studio/curso-python-data-science/modulo4-visualizacion/28_pairplot.png', dpi=100, bbox_inches='tight')
plt.close()

print("✓ Gráfica guardada: 28_pairplot.png")

# ============================================
# 8. FACETGRID - SUBPLOTS CONDICIONALES
# ============================================

print("\n" + "="*60)
print("FACETGRID - MÚLTIPLES PANELES")
print("="*60)

# FacetGrid para crear múltiples paneles
g = sns.FacetGrid(tips, col='time', row='sex', height=4, aspect=1.2)
g.map(sns.scatterplot, 'total_bill', 'tip', alpha=0.7)
g.add_legend()
g.fig.suptitle('Propinas por Género y Momento del Día', y=1.02, fontsize=16, fontweight='bold')
plt.tight_layout()
plt.savefig('/home/user/retail-studio/curso-python-data-science/modulo4-visualizacion/29_facetgrid.png', dpi=100, bbox_inches='tight')
plt.close()

print("✓ Gráfica guardada: 29_facetgrid.png")

# ============================================
# 9. EJERCICIO INTEGRADOR
# ============================================

print("\n" + "="*60)
print("EJERCICIO INTEGRADOR: DASHBOARD DE ANÁLISIS")
print("="*60)

# Crear figura con múltiples subplots
fig = plt.figure(figsize=(16, 12))
gs = fig.add_gridspec(3, 3, hspace=0.3, wspace=0.3)

# 1. Distribución de cuentas
ax1 = fig.add_subplot(gs[0, :2])
sns.histplot(data=tips, x='total_bill', kde=True, bins=25, color='skyblue', ax=ax1)
ax1.set_title('Distribución de Cuentas Totales', fontweight='bold')
ax1.set_xlabel('Cuenta Total ($)')

# 2. Propinas por día
ax2 = fig.add_subplot(gs[0, 2])
sns.boxplot(data=tips, y='tip', x='day', palette='Set2', ax=ax2)
ax2.set_title('Propinas por Día', fontweight='bold')
ax2.set_xlabel('Día')
ax2.set_ylabel('Propina ($)')

# 3. Relación cuenta-propina
ax3 = fig.add_subplot(gs[1, :2])
sns.scatterplot(data=tips, x='total_bill', y='tip', hue='time', style='sex', s=80, alpha=0.6, ax=ax3)
ax3.set_title('Relación Cuenta vs Propina', fontweight='bold')
ax3.set_xlabel('Cuenta Total ($)')
ax3.set_ylabel('Propina ($)')

# 4. Conteo por día
ax4 = fig.add_subplot(gs[1, 2])
sns.countplot(data=tips, x='day', palette='pastel', ax=ax4)
ax4.set_title('Clientes por Día', fontweight='bold')
ax4.set_xlabel('Día')
ax4.set_ylabel('Cantidad')

# 5. Violin plot
ax5 = fig.add_subplot(gs[2, :])
sns.violinplot(data=tips, x='day', y='total_bill', hue='sex', split=True, palette='muted', ax=ax5)
ax5.set_title('Distribución de Cuentas por Día y Género', fontweight='bold')
ax5.set_xlabel('Día')
ax5.set_ylabel('Cuenta Total ($)')

fig.suptitle('DASHBOARD: Análisis de Propinas en Restaurante', fontsize=18, fontweight='bold', y=0.995)
plt.savefig('/home/user/retail-studio/curso-python-data-science/modulo4-visualizacion/30_dashboard.png', dpi=100, bbox_inches='tight')
plt.close()

print("✓ Dashboard guardado: 30_dashboard.png")

# ============================================
# RESUMEN
# ============================================

print("\n" + "="*60)
print("RESUMEN")
print("="*60)
print("""
GRÁFICAS DE SEABORN:

DISTRIBUCIÓN:
- histplot()    # Histograma con KDE
- kdeplot()     # Solo curva de densidad
- displot()     # Combinación de distribuciones

CATEGÓRICAS:
- boxplot()     # Cajas y bigotes
- violinplot()  # Violín (box + KDE)
- barplot()     # Barras con estadísticas
- countplot()   # Conteo automático
- pointplot()   # Puntos con intervalos

RELACIÓN:
- scatterplot() # Dispersión
- lineplot()    # Líneas
- regplot()     # Con regresión

MATRICES:
- heatmap()     # Mapa de calor
- clustermap()  # Con clustering

MULTIVARIABLE:
- pairplot()    # Todas vs todas
- FacetGrid()   # Paneles condicionales

VENTAJAS DE SEABORN:
✓ Más fácil que matplotlib
✓ Gráficas estadísticas automáticas
✓ Estilos profesionales por defecto
✓ Integración con Pandas
✓ Colores y paletas optimizadas

Parámetros comunes:
- data: DataFrame
- x, y: columnas
- hue: variable de color
- style: variable de estilo
- palette: paleta de colores
""")

# ============================================
# EJERCICIOS PARA PRACTICAR
# ============================================

print("\n" + "="*60)
print("EJERCICIOS PARA TI:")
print("="*60)
print("""
1. EXPLORACIÓN:
   - Carga el dataset 'diamonds' de seaborn
   - Crea histograms de precio
   - Box plots de precio por corte
   - Scatter de quilates vs precio

2. CORRELACIÓN:
   - Usa el dataset 'iris'
   - Crea matriz de correlación con heatmap
   - Identifica las variables más correlacionadas
   - Crea pairplot coloreado por especie

3. COMPARACIÓN:
   - Dataset: 'penguins'
   - Compara distribuciones por especie
   - Violin plots de características
   - Scatter plots multivariables

4. DASHBOARD:
   - Crea un dashboard completo con seaborn
   - Mínimo 6 visualizaciones diferentes
   - Usa el dataset 'tips' o cualquier otro
   - Incluye título y estilo profesional

5. PROYECTO:
   - Genera tus propios datos o usa CSV
   - Análisis exploratorio completo
   - Al menos 10 visualizaciones
   - Documenta insights encontrados

¡Seaborn hace las visualizaciones muy fáciles!
""")
