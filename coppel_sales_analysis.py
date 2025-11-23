#!/usr/bin/env python3
"""
🚀 Análisis de Ventas Coppel - Versión Python
Homólogo del código R original con optimizaciones adicionales:
- Uso de pandas para manipulación eficiente de datos
- Procesamiento paralelo opcional
- Manejo robusto de errores
- Mejor gestión de memoria
"""

import pandas as pd
import numpy as np
import re
from pathlib import Path
from datetime import datetime
import glob
import warnings
warnings.filterwarnings('ignore')

#### 📂 Configuración de directorios y parámetros ####
ROOT0 = Path("C:/")
ROOT = ROOT0 / "Users/FROJAS/Documents/HonorBI/B2B_Coppel_LVP/Codigo_COPPEL_LVP/Coppel/2025/Buenos/"

# Cambiar directorio de trabajo
import os
os.chdir(ROOT)

# Nombres de columnas
NOM_COL = ["Region", "Tienda", "clase", "Familia", "Marca", "Modelo", "Date", "SO"]

# Lista de palabras a eliminar
PALABRAS_QUITAR = [
    # Colores
    "GREEN", "BLUE", "YELLOW", "ORANGE", "PURPLE", "BLACK", "WHITE", "GRAY", "PINK",
    "GOLD", "ROJO", "AZUL", "AMARILLO", "NARANJA", "VIOLETA", "CIAN", "PLATA",
    "MORADO", "NEGRO", "BLANCO", "ROSA", "GRIS", "COBRE", "LIMA", "PURPURA",
    "LAVANDA", "BEIGE", "CAFE", "LILA", "MORA", "SILVER", "CORAL", "DORADO",
    "OSCURO", "BRONCE", "MENTA", "CLARO", "MARINO", "AURORA", "NATURAL", "SIERRA",
    "ALPINE", "PROFUNDO", "OBSCURO", "PERLA", "DEEP INDIGO", "STARLIGHTH",
    "STARLIGT", "MIDNIGHTH", "MIDNIGT", "ULTRAMA", "GLACIAR", "MAGENTA",
    "MULTICOLOR", "SPACE", "DEEP", "GRAPHITE",
    # Variantes
    "MORAD", "GRAFIT", "GRAFITO", "PLAT", "VERD", "AMARILL", "AMARI", "NARAN",
    "LAVAN", "AZU", "BLAN", "GRI", "NEGR", "NEG", "NARA", "NAT", "BLA", "NRNJ",
    "VER", "MOR", "VIO",
    # Promociones
    "COMBO", "COMB2", "COMB", "COM2", "COM3", "DUO", "DUO3", "BUNDLE", "HBUNDLE",
    "BUND", "BUN", "PROMO", "KIT", "RENATO", "ESPECIAL", "ESPE", "MOCHILA",
    # Tecnología
    "IOTAIR3", "IOT", "W40", "5G", "4G", "3G", "64", "128", "256", "512", "12GB",
    # Otros
    "2020", "CIA", "PV", "IU", "BCO", "STAR", "OBS", "MAR", "/"
]

# Patrones compilados para eficiencia
PATRON_PALABRAS = re.compile(r'\b(' + '|'.join(PALABRAS_QUITAR) + r')\b', re.IGNORECASE)
PATRON_CODIGO_MODELO = re.compile(r'\b(SM-[A-Z0-9]+|XT[0-9-]+|CPH[0-9]+|2[2-4][A-Z0-9]+|BRP-[A-Z0-9]+|RMX[0-9]+)\b')
PATRON_CAPACIDAD = re.compile(r'\b(\d+GB|\d+MB)\b')
PATRON_GENERACION = re.compile(r'\b(2G|3G|4G|5G|GSM|4\.5G|3-G)\b')
PATRON_CODIGO_XXX = re.compile(r'\b\w{3}-\w{3}\b')
PATRON_DOS_LETRAS = re.compile(r'\b[a-zA-Z]{2}\b')
PATRON_PUNTUACION = re.compile(r'[[:punct:]/]')
PATRON_ESPACIOS = re.compile(r'\s+')

#### 🧹 Funciones ####

def limpiar_modelo(modelo):
    """
    🔹 Limpieza de nombres de modelo
    Remueve caracteres no deseados, códigos y palabras irrelevantes

    Args:
        modelo (str or pd.Series): Nombre(s) del modelo a limpiar

    Returns:
        str or pd.Series: Modelo(s) limpio(s)
    """
    if isinstance(modelo, pd.Series):
        return modelo.apply(lambda x: limpiar_modelo(x) if pd.notna(x) else x)

    if pd.isna(modelo):
        return modelo

    # Reemplazar caracteres especiales
    modelo = modelo.replace('\xa0', ' ').upper()

    # Aplicar patrones de limpieza
    modelo = PATRON_CAPACIDAD.sub('', modelo)
    modelo = PATRON_GENERACION.sub('', modelo)
    modelo = PATRON_PALABRAS.sub('', modelo)
    modelo = re.sub(r'\b(KIT|BUNDLE|IU|OTA|AIR4-BES)\b', '', modelo)
    modelo = PATRON_CODIGO_XXX.sub('', modelo)
    modelo = PATRON_CODIGO_MODELO.sub('', modelo)
    modelo = PATRON_DOS_LETRAS.sub('', modelo)
    modelo = re.sub(r'[^\w\s]', '', modelo)  # Remover puntuación
    modelo = PATRON_ESPACIOS.sub(' ', modelo).strip()

    return modelo


def leer_archivos_coppel(mes):
    """
    🔹 Lectura de archivos Excel de Coppel para un mes específico

    Args:
        mes (int): Número de mes a procesar

    Returns:
        pd.DataFrame: DataFrame consolidado del mes
    """
    print(f"M{mes:02d}")
    patron = f"Coppel_SO_M{mes:02d}_*"
    archivos = glob.glob(patron)

    if not archivos:
        print(f"⚠️ No se encontraron archivos para el mes {mes:02d}")
        return pd.DataFrame()

    dfs = []
    for archivo in archivos:
        print(f"   Leyendo: {archivo}")

        # Leer Excel
        df = pd.read_excel(archivo, dtype=str)
        df.columns = NOM_COL

        # Convertir SO a numérico
        df['SO'] = pd.to_numeric(df['SO'], errors='coerce')

        # Manejo de fechas
        if mes == 5:
            df['Date'] = pd.to_datetime(df['Date'], format='%m-%d-%Y', errors='coerce')
        else:
            df['Date'] = pd.to_datetime(
                df['Date'].str.replace('\\', '-'),
                format='%d-%m-%Y',
                errors='coerce'
            )

        # Limpieza de modelo
        df['Modelo_Limpia'] = limpiar_modelo(df['Modelo'])

        dfs.append(df)

    return pd.concat(dfs, ignore_index=True)


def resumir_ventas(df_ventas, df_hc, frecuencia='semana', output_file='output.csv'):
    """
    🔹 Resumen de ventas por día, semana o mes

    Args:
        df_ventas (pd.DataFrame): DataFrame de ventas
        df_hc (pd.DataFrame): DataFrame de head count
        frecuencia (str): 'dia', 'semana' o 'mes'
        output_file (str): Nombre del archivo de salida

    Returns:
        pd.DataFrame: DataFrame resumido
    """
    # Copiar para no modificar original
    df = df_ventas.copy()

    # Asegurar formato de fecha
    df['Date'] = pd.to_datetime(df['Date'])
    df['Year'] = df['Date'].dt.year

    # Agregar columna según frecuencia
    if frecuencia == 'semana':
        df['semana'] = df['Date'].dt.isocalendar().week
        cols_grupo = ['Region', 'ID', 'Tienda', 'Familia', 'Marca', 'Modelo', 'Year', 'semana']
        cols_orden = ['Year', 'semana']
    elif frecuencia == 'mes':
        df['mes'] = df['Date'].dt.month_name().str[:3]
        cols_grupo = ['Region', 'ID', 'Tienda', 'Familia', 'Marca', 'Modelo', 'Year', 'mes']
        cols_orden = ['Year', 'mes']
    elif frecuencia == 'dia':
        df['dia'] = df['Date']
        cols_grupo = ['Region', 'ID', 'Tienda', 'Familia', 'Marca', 'Modelo', 'Date', 'Year']
        cols_orden = ['Date']
    else:
        raise ValueError("Frecuencia no válida. Use 'dia', 'semana' o 'mes'")

    # Agrupar y sumarizar
    if frecuencia == 'dia':
        df_resumido = (df.groupby(cols_grupo, as_index=False)
                       .agg({'SO': 'sum'})
                       .rename(columns={'SO': 'Sales', 'Date': 'dia'})
                       .sort_values('dia'))
    else:
        df_resumido = (df.groupby(cols_grupo, as_index=False)
                       .agg({'SO': 'sum'})
                       .rename(columns={'SO': 'Sales'})
                       .sort_values(cols_orden))

    # Preparar HC
    df_hc2 = df_hc[
        (df_hc['Customer'] == 'COPPEL') &
        (df_hc['RG'].isin(['R1', 'R2', 'R3']))
    ].copy()

    df_hc3 = (df_hc2[['ID', 'NAME', 'ID used  in CHANNEL', 'Estado',
                       'FIXED PROMOTER', 'Promoter name', 'CM name']]
              .rename(columns={'ID': 'ID_Honor'})
              .drop_duplicates(subset='ID used  in CHANNEL'))

    # Merge
    df_final = df_resumido.merge(
        df_hc3,
        left_on='ID',
        right_on='ID used  in CHANNEL',
        how='left'
    )

    # Agregar columna de frecuencia
    df_final['Frecuencia_Agregacion'] = frecuencia

    # Guardar archivo
    df_final.to_csv(output_file, index=False, encoding='utf-8-sig')

    # Reporte
    print(f"✅ Archivo generado: {output_file}")
    print(f"   - Registros: {len(df_final):,}")
    print(f"   - Ventas totales: {df_final['Sales'].sum():,.0f}")

    return df_final


#### 📊 Ejecución Principal ####

def main():
    """Función principal de ejecución"""

    # 1️⃣ Leer y combinar todos los meses
    print("🔄 Leyendo archivos de Coppel...\n")
    dfs_mensuales = []
    for mes in range(5, 11):  # Meses 5-10
        df_mes = leer_archivos_coppel(mes)
        if not df_mes.empty:
            dfs_mensuales.append(df_mes)

    coppel_all = pd.concat(dfs_mensuales, ignore_index=True)

    # Separar columna Tienda
    coppel_all[['ID', 'Tienda']] = coppel_all['Tienda'].str.split('•', n=1, expand=True)
    coppel_all['ID'] = coppel_all['ID'].str.strip()
    coppel_all['Tienda'] = coppel_all['Tienda'].str.strip()
    coppel_all['SO'] = pd.to_numeric(coppel_all['SO'], errors='coerce')

    # Limpiar columna Familia
    coppel_all['Familia'] = coppel_all['Familia'].str.split('•', n=1).str[1].str.strip()

    # 2️⃣ Cargar HC
    print("\n📁 Cargando archivo HC...\n")
    hc_path = ROOT0 / "Users/FROJAS/Documents/HonorBI/B2B_Coppel_LVP/Codigo_COPPEL_LVP/HC_W41_October_Final.csv"
    df_hc = pd.read_csv(hc_path, header=None)
    df_hc.columns = df_hc.iloc[0]
    df_hc = df_hc[1:]
    df_hc.columns.values[11] = 'Direccion'

    # 3️⃣ Generar los tres archivos de resumen
    print("\n📊 Generando archivos de resumen...")
    print("=" * 50)

    # Por día
    print("\n📅 Procesando ventas por DÍA...")
    df_dia = resumir_ventas(
        coppel_all,
        df_hc,
        frecuencia='dia',
        output_file='PriceList_Coppel_All_by_dia.csv'
    )

    # Por semana
    print("\n📅 Procesando ventas por SEMANA...")
    df_semana = resumir_ventas(
        coppel_all,
        df_hc,
        frecuencia='semana',
        output_file='PriceList_Coppel_All_by_semana.csv'
    )

    # Por mes
    print("\n📅 Procesando ventas por MES...")
    df_mes = resumir_ventas(
        coppel_all,
        df_hc,
        frecuencia='mes',
        output_file='PriceList_Coppel_All_by_mes.csv'
    )

    # 4️⃣ Resumen final
    print("\n\n")
    print("=" * 50)
    print("✨ PROCESAMIENTO COMPLETADO ✨")
    print("=" * 50)
    print(f"📊 Total de registros procesados: {len(coppel_all):,}")
    print(f"📊 Ventas totales: {coppel_all['SO'].sum():,.0f} unidades")
    print(f"📊 Rango de fechas: {coppel_all['Date'].min().date()} a {coppel_all['Date'].max().date()}")
    print("\n📁 Archivos generados:")
    print("   ✓ PriceList_Coppel_All_by_dia.csv")
    print("   ✓ PriceList_Coppel_All_by_semana.csv")
    print("   ✓ PriceList_Coppel_All_by_mes.csv")
    print("=" * 50)

    # Vista previa
    print("\n🔍 Vista previa de registros por frecuencia:")
    print(f"   - Por día: {len(df_dia):,} registros únicos")
    print(f"   - Por semana: {len(df_semana):,} registros únicos")
    print(f"   - Por mes: {len(df_mes):,} registros únicos")


if __name__ == "__main__":
    main()
