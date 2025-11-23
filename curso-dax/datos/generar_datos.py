#!/usr/bin/env python3
"""
Script para generar datos de ejemplo para el curso de DAX
Datos realistas de un escenario de retail (ventas de electrónicos)
"""

import pandas as pd
import numpy as np
from datetime import datetime, timedelta
import random

# Configurar semilla para reproducibilidad
np.random.seed(42)
random.seed(42)

print("🚀 Generando datos de ejemplo para el curso de DAX...\n")

# ============================================================================
# 1. TABLA DE PRODUCTOS
# ============================================================================
print("📱 Creando catálogo de productos...")

marcas = {
    'Smartphones': ['SAMSUNG', 'XIAOMI', 'MOTOROLA', 'APPLE', 'OPPO', 'HUAWEI'],
    'Laptops': ['LENOVO', 'HP', 'DELL', 'ASUS', 'ACER'],
    'Tablets': ['SAMSUNG', 'LENOVO', 'HUAWEI', 'APPLE'],
    'Smartwatches': ['SAMSUNG', 'XIAOMI', 'APPLE', 'HUAWEI'],
    'Auriculares': ['SAMSUNG', 'JBL', 'SONY', 'XIAOMI', 'APPLE']
}

familias = {
    'Smartphones': ['Galaxy S', 'Galaxy A', 'Redmi', 'iPhone', 'Reno', 'P Series'],
    'Laptops': ['ThinkPad', 'Pavilion', 'Inspiron', 'VivoBook', 'Aspire'],
    'Tablets': ['Galaxy Tab', 'Tab M', 'MatePad', 'iPad'],
    'Smartwatches': ['Galaxy Watch', 'Mi Watch', 'Apple Watch', 'Watch GT'],
    'Auriculares': ['Galaxy Buds', 'Tune', 'WH-1000X', 'Redmi Buds', 'AirPods']
}

productos = []
producto_id = 1

for categoria, marcas_cat in marcas.items():
    num_productos_cat = {
        'Smartphones': 80,
        'Laptops': 40,
        'Tablets': 30,
        'Smartwatches': 25,
        'Auriculares': 25
    }[categoria]

    for _ in range(num_productos_cat):
        marca = random.choice(marcas_cat)
        familia = random.choice(familias[categoria])

        # Generar modelo único
        modelo = f"{familia} {random.choice(['Pro', 'Plus', 'Ultra', 'Lite', 'Standard', ''])}"

        # Precio según categoría
        precios_base = {
            'Smartphones': (3000, 25000),
            'Laptops': (8000, 35000),
            'Tablets': (3000, 15000),
            'Smartwatches': (1500, 8000),
            'Auriculares': (500, 5000)
        }

        precio_min, precio_max = precios_base[categoria]
        precio_lista = round(random.uniform(precio_min, precio_max), 2)

        productos.append({
            'ProductoID': f'P{producto_id:04d}',
            'Categoria': categoria,
            'Marca': marca,
            'Familia': familia,
            'Modelo': modelo.strip(),
            'PrecioLista': precio_lista
        })

        producto_id += 1

df_productos = pd.DataFrame(productos)
df_productos.to_csv('productos.csv', index=False, encoding='utf-8-sig')
print(f"   ✅ {len(df_productos)} productos creados")

# ============================================================================
# 2. TABLA DE TIENDAS
# ============================================================================
print("\n🏪 Creando catálogo de tiendas...")

regiones = {
    'Norte': ['Chihuahua', 'Sonora', 'Nuevo León', 'Coahuila'],
    'Centro': ['CDMX', 'Estado de México', 'Querétaro', 'Guanajuato'],
    'Sur': ['Oaxaca', 'Chiapas', 'Veracruz', 'Puebla'],
    'Occidente': ['Jalisco', 'Michoacán', 'Nayarit', 'Colima'],
    'Bajío': ['Aguascalientes', 'Zacatecas', 'San Luis Potosí']
}

ciudades_por_estado = {
    'Chihuahua': ['Chihuahua', 'Ciudad Juárez'],
    'Sonora': ['Hermosillo', 'Nogales'],
    'Nuevo León': ['Monterrey', 'San Pedro', 'Guadalupe'],
    'Coahuila': ['Saltillo', 'Torreón'],
    'CDMX': ['Polanco', 'Santa Fe', 'Interlomas', 'Coapa'],
    'Estado de México': ['Toluca', 'Naucalpan', 'Ecatepec'],
    'Querétaro': ['Querétaro', 'San Juan del Río'],
    'Guanajuato': ['León', 'Guanajuato', 'Celaya'],
    'Oaxaca': ['Oaxaca'],
    'Chiapas': ['Tuxtla Gutiérrez'],
    'Veracruz': ['Veracruz', 'Xalapa'],
    'Puebla': ['Puebla', 'Cholula'],
    'Jalisco': ['Guadalajara', 'Zapopan', 'Tlaquepaque'],
    'Michoacán': ['Morelia', 'Uruapan'],
    'Nayarit': ['Tepic'],
    'Colima': ['Colima'],
    'Aguascalientes': ['Aguascalientes'],
    'Zacatecas': ['Zacatecas'],
    'San Luis Potosí': ['San Luis Potosí']
}

tiendas = []
tienda_id = 1

for region, estados in regiones.items():
    # Más tiendas en Norte y Centro
    num_tiendas_region = {
        'Norte': 25,
        'Centro': 30,
        'Sur': 15,
        'Occidente': 20,
        'Bajío': 10
    }[region]

    for _ in range(num_tiendas_region):
        estado = random.choice(estados)
        ciudad = random.choice(ciudades_por_estado[estado])

        tiendas.append({
            'TiendaID': f'T{tienda_id:03d}',
            'NombreTienda': f'Tienda {ciudad} {random.choice(["Centro", "Plaza", "Forum", "Galerias", "Mall"])}',
            'Ciudad': ciudad,
            'Estado': estado,
            'Region': region
        })

        tienda_id += 1

df_tiendas = pd.DataFrame(tiendas)
df_tiendas.to_csv('tiendas.csv', index=False, encoding='utf-8-sig')
print(f"   ✅ {len(df_tiendas)} tiendas creadas")

# ============================================================================
# 3. TABLA DE CALENDARIO
# ============================================================================
print("\n📅 Creando tabla de calendario...")

fecha_inicio = datetime(2023, 1, 1)
fecha_fin = datetime(2025, 12, 31)

fechas = pd.date_range(start=fecha_inicio, end=fecha_fin, freq='D')

calendario = []
for fecha in fechas:
    calendario.append({
        'Fecha': fecha.strftime('%Y-%m-%d'),
        'Año': fecha.year,
        'Trimestre': f'Q{(fecha.month-1)//3 + 1}',
        'Mes': fecha.month,
        'NombreMes': fecha.strftime('%B'),
        'MesCorto': fecha.strftime('%b'),
        'Semana': fecha.isocalendar()[1],
        'DiaSemana': fecha.weekday() + 1,
        'NombreDia': fecha.strftime('%A'),
        'EsFinDeSemana': 1 if fecha.weekday() >= 5 else 0
    })

df_calendario = pd.DataFrame(calendario)
df_calendario.to_csv('calendario.csv', index=False, encoding='utf-8-sig')
print(f"   ✅ {len(df_calendario)} días creados (2023-2025)")

# ============================================================================
# 4. TABLA DE VENTAS (La más grande)
# ============================================================================
print("\n💰 Generando datos de ventas (esto puede tomar un momento)...")

ventas = []
venta_id = 1

# Generar ventas para cada mes de 2023-2024
fecha_actual = datetime(2023, 1, 1)
fecha_fin_ventas = datetime(2024, 12, 31)

# Productos y tiendas para selección rápida
productos_list = df_productos['ProductoID'].tolist()
tiendas_list = df_tiendas['TiendaID'].tolist()

# Diccionario de precios para acceso rápido
precios_dict = dict(zip(df_productos['ProductoID'], df_productos['PrecioLista']))

while fecha_actual <= fecha_fin_ventas:
    # Número de ventas por día (más ventas en fin de semana)
    es_fin_semana = fecha_actual.weekday() >= 5
    num_ventas_dia = random.randint(150, 250) if es_fin_semana else random.randint(80, 150)

    # Estacionalidad (más ventas en Nov-Dic)
    if fecha_actual.month in [11, 12]:
        num_ventas_dia = int(num_ventas_dia * 1.5)

    for _ in range(num_ventas_dia):
        producto_id = random.choice(productos_list)
        tienda_id = random.choice(tiendas_list)

        # Cantidad vendida (mayoría 1, algunos 2-3)
        cantidad = random.choices([1, 2, 3], weights=[85, 12, 3])[0]

        # Precio con descuento aleatorio (0-30%)
        precio_lista = precios_dict[producto_id]
        descuento = random.uniform(0, 0.30)
        precio_venta = precio_lista * (1 - descuento)

        monto_total = cantidad * precio_venta

        ventas.append({
            'VentaID': f'V{venta_id:07d}',
            'Fecha': fecha_actual.strftime('%Y-%m-%d'),
            'TiendaID': tienda_id,
            'ProductoID': producto_id,
            'Cantidad': cantidad,
            'PrecioUnitario': round(precio_venta, 2),
            'MontoTotal': round(monto_total, 2),
            'Descuento': round(descuento * 100, 1)
        })

        venta_id += 1

    # Siguiente día
    fecha_actual += timedelta(days=1)

    # Mostrar progreso cada 30 días
    if fecha_actual.day == 1:
        print(f"   📊 Progreso: {fecha_actual.strftime('%Y-%m')}")

df_ventas = pd.DataFrame(ventas)
df_ventas.to_csv('ventas_retail.csv', index=False, encoding='utf-8-sig')
print(f"\n   ✅ {len(df_ventas):,} transacciones de venta creadas")

# ============================================================================
# 5. RESUMEN DE DATOS GENERADOS
# ============================================================================
print("\n" + "="*60)
print("📊 RESUMEN DE DATOS GENERADOS")
print("="*60)
print(f"\n✅ Productos:     {len(df_productos):,} registros")
print(f"✅ Tiendas:       {len(df_tiendas):,} registros")
print(f"✅ Calendario:    {len(df_calendario):,} registros")
print(f"✅ Ventas:        {len(df_ventas):,} registros")

# Estadísticas de ventas
monto_total = df_ventas['MontoTotal'].sum()
print(f"\n💰 Monto total de ventas: ${monto_total:,.2f}")
print(f"📈 Ticket promedio: ${df_ventas['MontoTotal'].mean():,.2f}")
print(f"📦 Unidades vendidas: {df_ventas['Cantidad'].sum():,}")

print("\n" + "="*60)
print("✅ ¡DATOS GENERADOS EXITOSAMENTE!")
print("="*60)
print("\nArchivos creados en la carpeta actual:")
print("  - productos.csv")
print("  - tiendas.csv")
print("  - calendario.csv")
print("  - ventas_retail.csv")
print("\n🎓 ¡Ya puedes empezar el curso de DAX!")
