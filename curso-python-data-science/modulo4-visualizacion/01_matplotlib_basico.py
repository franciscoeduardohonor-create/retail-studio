"""
MÓDULO 4 - VISUALIZACIÓN DE DATOS
Lección 1: Matplotlib Básico

La visualización de datos es fundamental para:
- Explorar y entender los datos
- Comunicar hallazgos
- Detectar patrones y anomalías

Matplotlib es la librería base para visualización en Python.

En esta lección aprenderás:
- Gráficas de líneas
- Gráficas de barras
- Histogramas
- Gráficas de dispersión
- Personalización
"""

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

# Configuración para mejor visualización
plt.style.use('default')  # Estilo por defecto

# ============================================
# 1. GRÁFICA DE LÍNEAS
# ============================================

print("="*60)
print("GRÁFICAS DE LÍNEAS")
print("="*60)

# Datos de ejemplo
x = np.linspace(0, 10, 100)
y = np.sin(x)

# Crear gráfica básica
plt.figure(figsize=(10, 6))
plt.plot(x, y)
plt.title('Función Seno')
plt.xlabel('X')
plt.ylabel('sin(x)')
plt.grid(True)
plt.savefig('/home/user/retail-studio/curso-python-data-science/modulo4-visualizacion/01_linea_basica.png', dpi=100, bbox_inches='tight')
plt.close()

print("✓ Gráfica guardada: 01_linea_basica.png")

# Múltiples líneas
plt.figure(figsize=(10, 6))
plt.plot(x, np.sin(x), label='sin(x)', linewidth=2)
plt.plot(x, np.cos(x), label='cos(x)', linewidth=2)
plt.plot(x, np.sin(x) * np.cos(x), label='sin(x)*cos(x)', linewidth=2)
plt.title('Funciones Trigonométricas', fontsize=16)
plt.xlabel('X', fontsize=12)
plt.ylabel('Y', fontsize=12)
plt.legend(fontsize=12)
plt.grid(True, alpha=0.3)
plt.savefig('/home/user/retail-studio/curso-python-data-science/modulo4-visualizacion/02_multiples_lineas.png', dpi=100, bbox_inches='tight')
plt.close()

print("✓ Gráfica guardada: 02_multiples_lineas.png")

# Ejemplo práctico: Ventas mensuales
meses = ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic']
ventas_2023 = [15000, 18000, 22000, 19000, 25000, 28000, 32000, 30000, 27000, 29000, 35000, 40000]
ventas_2024 = [18000, 20000, 24000, 22000, 28000, 31000, 35000, 33000, 31000, 34000, 39000, 45000]

plt.figure(figsize=(12, 6))
plt.plot(meses, ventas_2023, marker='o', linewidth=2, markersize=8, label='2023')
plt.plot(meses, ventas_2024, marker='s', linewidth=2, markersize=8, label='2024')
plt.title('Comparación de Ventas Mensuales', fontsize=16, fontweight='bold')
plt.xlabel('Mes', fontsize=12)
plt.ylabel('Ventas ($)', fontsize=12)
plt.legend(fontsize=12)
plt.grid(True, alpha=0.3)
plt.tight_layout()
plt.savefig('/home/user/retail-studio/curso-python-data-science/modulo4-visualizacion/03_ventas_mensuales.png', dpi=100, bbox_inches='tight')
plt.close()

print("✓ Gráfica guardada: 03_ventas_mensuales.png")

# ============================================
# 2. GRÁFICAS DE BARRAS
# ============================================

print("\n" + "="*60)
print("GRÁFICAS DE BARRAS")
print("="*60)

# Barras verticales
productos = ['Laptop', 'Mouse', 'Teclado', 'Monitor', 'Audífonos']
ventas_prod = [45, 120, 85, 60, 95]

plt.figure(figsize=(10, 6))
plt.bar(productos, ventas_prod, color='steelblue', edgecolor='black')
plt.title('Ventas por Producto', fontsize=16, fontweight='bold')
plt.xlabel('Producto', fontsize=12)
plt.ylabel('Unidades Vendidas', fontsize=12)
plt.grid(axis='y', alpha=0.3)
plt.tight_layout()
plt.savefig('/home/user/retail-studio/curso-python-data-science/modulo4-visualizacion/04_barras_verticales.png', dpi=100, bbox_inches='tight')
plt.close()

print("✓ Gráfica guardada: 04_barras_verticales.png")

# Barras horizontales
plt.figure(figsize=(10, 6))
plt.barh(productos, ventas_prod, color='coral', edgecolor='black')
plt.title('Ventas por Producto', fontsize=16, fontweight='bold')
plt.xlabel('Unidades Vendidas', fontsize=12)
plt.ylabel('Producto', fontsize=12)
plt.grid(axis='x', alpha=0.3)
plt.tight_layout()
plt.savefig('/home/user/retail-studio/curso-python-data-science/modulo4-visualizacion/05_barras_horizontales.png', dpi=100, bbox_inches='tight')
plt.close()

print("✓ Gráfica guardada: 05_barras_horizontales.png")

# Barras agrupadas
regiones = ['Norte', 'Sur', 'Este', 'Oeste']
q1 = [20, 35, 30, 25]
q2 = [25, 32, 34, 27]
q3 = [30, 38, 36, 29]
q4 = [35, 40, 38, 32]

x = np.arange(len(regiones))
width = 0.2

plt.figure(figsize=(12, 6))
plt.bar(x - 1.5*width, q1, width, label='Q1', color='#ff6b6b')
plt.bar(x - 0.5*width, q2, width, label='Q2', color='#4ecdc4')
plt.bar(x + 0.5*width, q3, width, label='Q3', color='#45b7d1')
plt.bar(x + 1.5*width, q4, width, label='Q4', color='#96ceb4')

plt.title('Ventas Trimestrales por Región', fontsize=16, fontweight='bold')
plt.xlabel('Región', fontsize=12)
plt.ylabel('Ventas (miles $)', fontsize=12)
plt.xticks(x, regiones)
plt.legend()
plt.grid(axis='y', alpha=0.3)
plt.tight_layout()
plt.savefig('/home/user/retail-studio/curso-python-data-science/modulo4-visualizacion/06_barras_agrupadas.png', dpi=100, bbox_inches='tight')
plt.close()

print("✓ Gráfica guardada: 06_barras_agrupadas.png")

# Barras apiladas
plt.figure(figsize=(12, 6))
plt.bar(regiones, q1, label='Q1', color='#ff6b6b')
plt.bar(regiones, q2, bottom=q1, label='Q2', color='#4ecdc4')
plt.bar(regiones, q3, bottom=np.array(q1)+np.array(q2), label='Q3', color='#45b7d1')
plt.bar(regiones, q4, bottom=np.array(q1)+np.array(q2)+np.array(q3), label='Q4', color='#96ceb4')

plt.title('Ventas Anuales por Región (Apiladas)', fontsize=16, fontweight='bold')
plt.xlabel('Región', fontsize=12)
plt.ylabel('Ventas Totales (miles $)', fontsize=12)
plt.legend()
plt.grid(axis='y', alpha=0.3)
plt.tight_layout()
plt.savefig('/home/user/retail-studio/curso-python-data-science/modulo4-visualizacion/07_barras_apiladas.png', dpi=100, bbox_inches='tight')
plt.close()

print("✓ Gráfica guardada: 07_barras_apiladas.png")

# ============================================
# 3. HISTOGRAMAS
# ============================================

print("\n" + "="*60)
print("HISTOGRAMAS")
print("="*60)

# Generar datos de distribución normal
np.random.seed(42)
datos = np.random.normal(100, 15, 1000)  # media=100, desv=15, n=1000

plt.figure(figsize=(10, 6))
plt.hist(datos, bins=30, color='skyblue', edgecolor='black', alpha=0.7)
plt.title('Distribución de Calificaciones', fontsize=16, fontweight='bold')
plt.xlabel('Calificación', fontsize=12)
plt.ylabel('Frecuencia', fontsize=12)
plt.axvline(datos.mean(), color='red', linestyle='--', linewidth=2, label=f'Media: {datos.mean():.1f}')
plt.legend()
plt.grid(axis='y', alpha=0.3)
plt.tight_layout()
plt.savefig('/home/user/retail-studio/curso-python-data-science/modulo4-visualizacion/08_histograma.png', dpi=100, bbox_inches='tight')
plt.close()

print("✓ Gráfica guardada: 08_histograma.png")

# Múltiples histogramas
hombres = np.random.normal(175, 7, 500)
mujeres = np.random.normal(165, 7, 500)

plt.figure(figsize=(10, 6))
plt.hist(hombres, bins=30, alpha=0.5, label='Hombres', color='blue', edgecolor='black')
plt.hist(mujeres, bins=30, alpha=0.5, label='Mujeres', color='red', edgecolor='black')
plt.title('Distribución de Alturas por Género', fontsize=16, fontweight='bold')
plt.xlabel('Altura (cm)', fontsize=12)
plt.ylabel('Frecuencia', fontsize=12)
plt.legend()
plt.grid(axis='y', alpha=0.3)
plt.tight_layout()
plt.savefig('/home/user/retail-studio/curso-python-data-science/modulo4-visualizacion/09_histograma_multiple.png', dpi=100, bbox_inches='tight')
plt.close()

print("✓ Gráfica guardada: 09_histograma_multiple.png")

# ============================================
# 4. GRÁFICAS DE DISPERSIÓN (SCATTER)
# ============================================

print("\n" + "="*60)
print("GRÁFICAS DE DISPERSIÓN")
print("="*60)

# Relación entre publicidad y ventas
np.random.seed(42)
publicidad = np.random.uniform(10, 100, 50)
ventas_scatter = 2.5 * publicidad + np.random.normal(0, 15, 50) + 50

plt.figure(figsize=(10, 6))
plt.scatter(publicidad, ventas_scatter, alpha=0.6, s=100, color='purple', edgecolors='black')
plt.title('Relación: Inversión en Publicidad vs Ventas', fontsize=16, fontweight='bold')
plt.xlabel('Inversión en Publicidad (miles $)', fontsize=12)
plt.ylabel('Ventas (miles $)', fontsize=12)
plt.grid(True, alpha=0.3)
plt.tight_layout()
plt.savefig('/home/user/retail-studio/curso-python-data-science/modulo4-visualizacion/10_scatter.png', dpi=100, bbox_inches='tight')
plt.close()

print("✓ Gráfica guardada: 10_scatter.png")

# Scatter con colores y tamaños
np.random.seed(42)
x = np.random.rand(50) * 100
y = np.random.rand(50) * 100
colores = np.random.rand(50)
tamaños = np.random.rand(50) * 500

plt.figure(figsize=(10, 6))
scatter = plt.scatter(x, y, c=colores, s=tamaños, alpha=0.6, cmap='viridis', edgecolors='black')
plt.colorbar(scatter, label='Valor de Color')
plt.title('Scatter con Colores y Tamaños Variables', fontsize=16, fontweight='bold')
plt.xlabel('X', fontsize=12)
plt.ylabel('Y', fontsize=12)
plt.grid(True, alpha=0.3)
plt.tight_layout()
plt.savefig('/home/user/retail-studio/curso-python-data-science/modulo4-visualizacion/11_scatter_avanzado.png', dpi=100, bbox_inches='tight')
plt.close()

print("✓ Gráfica guardada: 11_scatter_avanzado.png")

# ============================================
# 5. SUBPLOTS - MÚLTIPLES GRÁFICAS
# ============================================

print("\n" + "="*60)
print("SUBPLOTS - MÚLTIPLES GRÁFICAS")
print("="*60)

# Crear figura con múltiples subplots
fig, axes = plt.subplots(2, 2, figsize=(14, 10))

# Subplot 1: Líneas
axes[0, 0].plot(meses, ventas_2023, marker='o', label='2023')
axes[0, 0].plot(meses, ventas_2024, marker='s', label='2024')
axes[0, 0].set_title('Ventas Mensuales', fontweight='bold')
axes[0, 0].set_xlabel('Mes')
axes[0, 0].set_ylabel('Ventas ($)')
axes[0, 0].legend()
axes[0, 0].grid(True, alpha=0.3)
axes[0, 0].tick_params(axis='x', rotation=45)

# Subplot 2: Barras
axes[0, 1].bar(productos, ventas_prod, color='steelblue', edgecolor='black')
axes[0, 1].set_title('Ventas por Producto', fontweight='bold')
axes[0, 1].set_xlabel('Producto')
axes[0, 1].set_ylabel('Unidades')
axes[0, 1].tick_params(axis='x', rotation=45)
axes[0, 1].grid(axis='y', alpha=0.3)

# Subplot 3: Histograma
axes[1, 0].hist(datos, bins=30, color='coral', edgecolor='black', alpha=0.7)
axes[1, 0].set_title('Distribución de Datos', fontweight='bold')
axes[1, 0].set_xlabel('Valor')
axes[1, 0].set_ylabel('Frecuencia')
axes[1, 0].axvline(datos.mean(), color='red', linestyle='--', linewidth=2)
axes[1, 0].grid(axis='y', alpha=0.3)

# Subplot 4: Scatter
axes[1, 1].scatter(publicidad, ventas_scatter, alpha=0.6, s=100, color='green', edgecolors='black')
axes[1, 1].set_title('Publicidad vs Ventas', fontweight='bold')
axes[1, 1].set_xlabel('Publicidad')
axes[1, 1].set_ylabel('Ventas')
axes[1, 1].grid(True, alpha=0.3)

plt.tight_layout()
plt.savefig('/home/user/retail-studio/curso-python-data-science/modulo4-visualizacion/12_subplots.png', dpi=100, bbox_inches='tight')
plt.close()

print("✓ Gráfica guardada: 12_subplots.png")

# ============================================
# 6. GRÁFICA DE PASTEL (PIE)
# ============================================

print("\n" + "="*60)
print("GRÁFICAS DE PASTEL")
print("="*60)

categorias = ['Electrónica', 'Ropa', 'Alimentos', 'Hogar', 'Otros']
valores = [35, 25, 20, 15, 5]
colores_pie = ['#ff6b6b', '#4ecdc4', '#45b7d1', '#96ceb4', '#ffeaa7']
explode = (0.1, 0, 0, 0, 0)  # Separar primer sector

plt.figure(figsize=(10, 8))
plt.pie(valores, labels=categorias, autopct='%1.1f%%', startangle=90,
        colors=colores_pie, explode=explode, shadow=True)
plt.title('Distribución de Ventas por Categoría', fontsize=16, fontweight='bold')
plt.axis('equal')
plt.tight_layout()
plt.savefig('/home/user/retail-studio/curso-python-data-science/modulo4-visualizacion/13_pie.png', dpi=100, bbox_inches='tight')
plt.close()

print("✓ Gráfica guardada: 13_pie.png")

# ============================================
# 7. PERSONALIZACIÓN AVANZADA
# ============================================

print("\n" + "="*60)
print("PERSONALIZACIÓN AVANZADA")
print("="*60)

# Gráfica con estilo personalizado
plt.figure(figsize=(12, 7))

# Datos
x = np.linspace(0, 10, 100)
y1 = np.exp(-x/10) * np.cos(2*np.pi*x)
y2 = np.exp(-x/10)
y3 = -np.exp(-x/10)

# Plot
plt.plot(x, y1, 'b-', linewidth=2, label='Señal')
plt.plot(x, y2, 'r--', linewidth=1.5, label='Envolvente Superior')
plt.plot(x, y3, 'r--', linewidth=1.5, label='Envolvente Inferior')

# Llenar área
plt.fill_between(x, y2, y3, alpha=0.2, color='red')

# Personalización
plt.title('Señal Amortiguada con Envolventes', fontsize=18, fontweight='bold', pad=20)
plt.xlabel('Tiempo (s)', fontsize=14, fontweight='bold')
plt.ylabel('Amplitud', fontsize=14, fontweight='bold')
plt.legend(loc='upper right', fontsize=12, framealpha=0.9)
plt.grid(True, linestyle=':', alpha=0.5)
plt.xlim(0, 10)
plt.ylim(-1.2, 1.2)

# Anotación
plt.annotate('Máximo inicial',
             xy=(0, 1), xytext=(2, 0.8),
             arrowprops=dict(arrowstyle='->', color='black', lw=2),
             fontsize=12, fontweight='bold')

plt.tight_layout()
plt.savefig('/home/user/retail-studio/curso-python-data-science/modulo4-visualizacion/14_personalizada.png', dpi=100, bbox_inches='tight')
plt.close()

print("✓ Gráfica guardada: 14_personalizada.png")

# ============================================
# RESUMEN
# ============================================

print("\n" + "="*60)
print("RESUMEN")
print("="*60)
print("""
TIPOS DE GRÁFICAS:

1. Líneas (plt.plot):
   - Series temporales
   - Tendencias
   - Comparaciones continuas

2. Barras (plt.bar / plt.barh):
   - Comparar categorías
   - Datos discretos
   - Rankings

3. Histogramas (plt.hist):
   - Distribuciones
   - Frecuencias
   - Análisis estadístico

4. Dispersión (plt.scatter):
   - Relaciones entre variables
   - Correlaciones
   - Outliers

5. Pastel (plt.pie):
   - Proporciones
   - Porcentajes
   - Composición

PERSONALIZACIÓN COMÚN:
- plt.title()     # Título
- plt.xlabel()    # Etiqueta X
- plt.ylabel()    # Etiqueta Y
- plt.legend()    # Leyenda
- plt.grid()      # Cuadrícula
- plt.xlim/ylim() # Límites de ejes
- plt.savefig()   # Guardar imagen

ESTILO:
- linewidth       # Grosor de línea
- color          # Color
- alpha          # Transparencia
- marker         # Marcadores
- linestyle      # Estilo de línea
- edgecolor      # Color de borde

Todas las gráficas han sido guardadas en:
curso-python-data-science/modulo4-visualizacion/
""")

# ============================================
# EJERCICIOS PARA PRACTICAR
# ============================================

print("\n" + "="*60)
print("EJERCICIOS PARA TI:")
print("="*60)
print("""
1. LÍNEAS:
   - Grafica temperatura de 3 ciudades durante un año
   - Incluye líneas de promedio
   - Personaliza colores y estilos

2. BARRAS:
   - Crea gráfica de top 10 países por población
   - Usa colores diferentes para cada barra
   - Agrega valores encima de cada barra

3. HISTOGRAMAS:
   - Genera datos de altura de 1000 personas
   - Compara hombres vs mujeres
   - Agrega líneas de media y mediana

4. SCATTER:
   - Visualiza relación entre estudio y salario
   - Agrega línea de tendencia
   - Colorea por categoría laboral

5. DASHBOARD:
   - Crea un dashboard con 6 gráficas
   - Tema: Análisis de ventas
   - Incluye: líneas, barras, pie, scatter
   - Personaliza completamente

¡La visualización es clave para comunicar resultados!
""")
