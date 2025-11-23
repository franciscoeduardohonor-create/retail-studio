"""
GENERADOR DE DATASETS DE PRÁCTICA

Este script genera varios datasets en formato CSV para practicar
análisis de datos y machine learning.

Ejecuta este script para crear los archivos CSV en la carpeta datasets/
"""

import pandas as pd
import numpy as np
from datetime import datetime, timedelta

print("="*70)
print("GENERANDO DATASETS DE PRÁCTICA")
print("="*70)

# ============================================
# 1. DATASET DE ESTUDIANTES
# ============================================

print("\n1. Generando dataset de estudiantes...")

np.random.seed(42)
n_estudiantes = 200

estudiantes = pd.DataFrame({
    'id': range(1, n_estudiantes + 1),
    'nombre': [f'Estudiante_{i}' for i in range(1, n_estudiantes + 1)],
    'edad': np.random.randint(18, 25, n_estudiantes),
    'genero': np.random.choice(['M', 'F'], n_estudiantes),
    'carrera': np.random.choice(['Ingeniería', 'Medicina', 'Derecho', 'Economía', 'Arte'], n_estudiantes),
    'promedio': np.random.uniform(60, 100, n_estudiantes).round(2),
    'creditos_cursados': np.random.randint(0, 240, n_estudiantes),
    'ciudad': np.random.choice(['Madrid', 'Barcelona', 'Valencia', 'Sevilla', 'Bilbao'], n_estudiantes),
    'becado': np.random.choice([True, False], n_estudiantes, p=[0.3, 0.7])
})

estudiantes.to_csv('/home/user/retail-studio/curso-python-data-science/datasets/estudiantes.csv', index=False)
print(f"   ✓ Guardado: estudiantes.csv ({len(estudiantes)} registros)")

# ============================================
# 2. DATASET DE VENTAS
# ============================================

print("\n2. Generando dataset de ventas...")

np.random.seed(42)
fechas = pd.date_range('2023-01-01', '2024-12-31', freq='D')
n_ventas = 5000

ventas = pd.DataFrame({
    'id_venta': range(1, n_ventas + 1),
    'fecha': np.random.choice(fechas, n_ventas),
    'producto': np.random.choice(['Laptop', 'Mouse', 'Teclado', 'Monitor', 'Audífonos',
                                  'Webcam', 'Tablet', 'Smartphone'], n_ventas),
    'categoria': np.random.choice(['Electrónica', 'Accesorios', 'Computadoras'], n_ventas),
    'cantidad': np.random.randint(1, 10, n_ventas),
    'precio_unitario': np.random.uniform(10, 1500, n_ventas).round(2),
    'descuento_pct': np.random.choice([0, 5, 10, 15, 20], n_ventas),
    'vendedor': np.random.choice(['Ana', 'Luis', 'María', 'Pedro', 'Laura'], n_ventas),
    'region': np.random.choice(['Norte', 'Sur', 'Este', 'Oeste'], n_ventas)
})

ventas['precio_total'] = (ventas['cantidad'] * ventas['precio_unitario']).round(2)
ventas['descuento'] = (ventas['precio_total'] * ventas['descuento_pct'] / 100).round(2)
ventas['precio_final'] = (ventas['precio_total'] - ventas['descuento']).round(2)

ventas.to_csv('/home/user/retail-studio/curso-python-data-science/datasets/ventas.csv', index=False)
print(f"   ✓ Guardado: ventas.csv ({len(ventas)} registros)")

# ============================================
# 3. DATASET DE EMPLEADOS
# ============================================

print("\n3. Generando dataset de empleados...")

np.random.seed(42)
n_empleados = 150

empleados = pd.DataFrame({
    'id_empleado': range(1, n_empleados + 1),
    'nombre': [f'Empleado_{i}' for i in range(1, n_empleados + 1)],
    'edad': np.random.randint(22, 65, n_empleados),
    'genero': np.random.choice(['M', 'F'], n_empleados),
    'departamento': np.random.choice(['Ventas', 'IT', 'RRHH', 'Finanzas', 'Marketing', 'Operaciones'], n_empleados),
    'puesto': np.random.choice(['Analista', 'Gerente', 'Director', 'Especialista', 'Coordinador'], n_empleados),
    'años_experiencia': np.random.randint(0, 30, n_empleados),
    'salario_miles': np.random.uniform(25, 150, n_empleados).round(1),
    'nivel_educacion': np.random.choice(['Licenciatura', 'Maestría', 'Doctorado', 'Técnico'], n_empleados),
    'satisfaccion': np.random.randint(1, 11, n_empleados),
    'renuncio': np.random.choice([0, 1], n_empleados, p=[0.85, 0.15])
})

empleados.to_csv('/home/user/retail-studio/curso-python-data-science/datasets/empleados.csv', index=False)
print(f"   ✓ Guardado: empleados.csv ({len(empleados)} registros)")

# ============================================
# 4. DATASET DE CASAS (para regresión)
# ============================================

print("\n4. Generando dataset de casas...")

np.random.seed(42)
n_casas = 500

casas = pd.DataFrame({
    'id': range(1, n_casas + 1),
    'area_m2': np.random.uniform(50, 300, n_casas).round(1),
    'habitaciones': np.random.randint(1, 6, n_casas),
    'baños': np.random.randint(1, 4, n_casas),
    'antiguedad_años': np.random.randint(0, 50, n_casas),
    'pisos': np.random.randint(1, 4, n_casas),
    'garaje': np.random.choice([0, 1], n_casas, p=[0.3, 0.7]),
    'jardin': np.random.choice([0, 1], n_casas, p=[0.6, 0.4]),
    'distancia_centro_km': np.random.uniform(0.5, 30, n_casas).round(1),
    'zona': np.random.choice(['Centro', 'Norte', 'Sur', 'Este', 'Oeste'], n_casas),
    'calificacion_zona': np.random.randint(1, 11, n_casas)
})

# Generar precio basado en características
casas['precio_miles'] = (
    2.5 * casas['area_m2'] +
    20 * casas['habitaciones'] +
    15 * casas['baños'] -
    1 * casas['antiguedad_años'] +
    10 * casas['garaje'] +
    15 * casas['jardin'] -
    2 * casas['distancia_centro_km'] +
    5 * casas['calificacion_zona'] +
    np.random.normal(0, 30, n_casas) +
    100
).round(2)

casas.to_csv('/home/user/retail-studio/curso-python-data-science/datasets/casas.csv', index=False)
print(f"   ✓ Guardado: casas.csv ({len(casas)} registros)")

# ============================================
# 5. DATASET DE CLIENTES (para clasificación)
# ============================================

print("\n5. Generando dataset de clientes...")

np.random.seed(42)
n_clientes = 1000

clientes = pd.DataFrame({
    'id_cliente': range(1, n_clientes + 1),
    'edad': np.random.randint(18, 75, n_clientes),
    'genero': np.random.choice(['M', 'F'], n_clientes),
    'ingresos_anuales_miles': np.random.uniform(20, 200, n_clientes).round(1),
    'score_credito': np.random.randint(300, 850, n_clientes),
    'años_cliente': np.random.randint(0, 20, n_clientes),
    'num_productos': np.random.randint(1, 5, n_clientes),
    'tiene_tarjeta_credito': np.random.choice([0, 1], n_clientes, p=[0.3, 0.7]),
    'esta_activo': np.random.choice([0, 1], n_clientes, p=[0.2, 0.8]),
    'balance_cuenta': np.random.uniform(0, 100000, n_clientes).round(2),
    'num_quejas': np.random.randint(0, 10, n_clientes)
})

# Generar abandono (churn) basado en características
prob_abandono = (
    -0.01 * clientes['años_cliente'] +
    0.002 * clientes['num_quejas'] * 10 +
    -0.001 * clientes['score_credito'] +
    -0.1 * clientes['esta_activo'] +
    np.random.uniform(-0.2, 0.2, n_clientes)
)
clientes['abandono'] = (prob_abandono > 0).astype(int)

clientes.to_csv('/home/user/retail-studio/curso-python-data-science/datasets/clientes.csv', index=False)
print(f"   ✓ Guardado: clientes.csv ({len(clientes)} registros)")

# ============================================
# 6. DATASET DE TEMPERATURAS
# ============================================

print("\n6. Generando dataset de temperaturas...")

np.random.seed(42)
fechas = pd.date_range('2020-01-01', '2024-12-31', freq='D')

temperaturas = pd.DataFrame({
    'fecha': fechas,
    'ciudad': np.random.choice(['Madrid', 'Barcelona', 'Valencia'], len(fechas)),
    'temperatura_max': np.random.uniform(10, 40, len(fechas)).round(1),
    'temperatura_min': np.random.uniform(-5, 25, len(fechas)).round(1),
    'humedad': np.random.uniform(20, 90, len(fechas)).round(1),
    'precipitacion_mm': np.random.exponential(5, len(fechas)).round(1),
    'viento_kmh': np.random.uniform(0, 50, len(fechas)).round(1)
})

temperaturas['temperatura_promedio'] = ((temperaturas['temperatura_max'] + temperaturas['temperatura_min']) / 2).round(1)

temperaturas.to_csv('/home/user/retail-studio/curso-python-data-science/datasets/temperaturas.csv', index=False)
print(f"   ✓ Guardado: temperaturas.csv ({len(temperaturas)} registros)")

# ============================================
# 7. DATASET CON DATOS SUCIOS (para limpieza)
# ============================================

print("\n7. Generando dataset con datos sucios...")

np.random.seed(42)
n_registros = 300

# Dataset intencionalmente sucio
datos_sucios = pd.DataFrame({
    'id': range(1, n_registros + 1),
    'nombre': ['  ' + f'Cliente {i}' + '  ' if np.random.random() > 0.3 else np.nan
               for i in range(1, n_registros + 1)],
    'email': [f'cliente{i}@test.com' if np.random.random() > 0.1 else ('invalido' if np.random.random() > 0.5 else np.nan)
              for i in range(1, n_registros + 1)],
    'edad': [np.random.randint(18, 80) if np.random.random() > 0.15 else np.nan
             for i in range(n_registros)],
    'ingresos': [np.random.uniform(1000, 10000) if np.random.random() > 0.2 else np.nan
                 for i in range(n_registros)],
    'ciudad': np.random.choice(['Madrid', 'BARCELONA', 'valencia', '  Sevilla  ', np.nan], n_registros)
})

# Añadir duplicados
datos_sucios = pd.concat([datos_sucios, datos_sucios.sample(30)], ignore_index=True)

datos_sucios.to_csv('/home/user/retail-studio/curso-python-data-science/datasets/datos_sucios.csv', index=False)
print(f"   ✓ Guardado: datos_sucios.csv ({len(datos_sucios)} registros)")

# ============================================
# RESUMEN
# ============================================

print("\n" + "="*70)
print("DATASETS GENERADOS EXITOSAMENTE")
print("="*70)

print(f"""
📁 DATASETS DISPONIBLES:

1. estudiantes.csv       - {len(estudiantes)} estudiantes con promedios y datos demográficos
2. ventas.csv           - {len(ventas)} transacciones de ventas con detalles
3. empleados.csv        - {len(empleados)} empleados con salarios y satisfacción
4. casas.csv            - {len(casas)} propiedades para predicción de precios
5. clientes.csv         - {len(clientes)} clientes para predicción de abandono
6. temperaturas.csv     - {len(temperaturas)} registros meteorológicos
7. datos_sucios.csv     - {len(datos_sucios)} registros con problemas de calidad

💡 CASOS DE USO:

- estudiantes.csv     → Análisis exploratorio, visualización
- ventas.csv         → GroupBy, análisis temporal, dashboard
- empleados.csv      → Análisis de RRHH, correlaciones
- casas.csv          → Regresión (predecir precios)
- clientes.csv       → Clasificación (predecir abandono)
- temperaturas.csv   → Series temporales, análisis climático
- datos_sucios.csv   → Práctica de limpieza de datos

📚 ÚSALOS EN TUS EJERCICIOS:

import pandas as pd

# Cargar dataset
df = pd.read_csv('datasets/ventas.csv')

# Explorar
print(df.head())
print(df.info())

# Analizar
print(df.groupby('producto')['precio_final'].sum())

¡Feliz análisis de datos! 📊
""")
