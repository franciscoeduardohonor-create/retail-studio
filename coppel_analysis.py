#!/usr/bin/env python3
"""
🚀 Análisis de Ventas Coppel - Versión Python
Optimizado para procesamiento eficiente de datos de retail
"""

import re
import time
from pathlib import Path
from typing import List, Literal
import warnings

import pandas as pd
import numpy as np
from glob import glob

# Configuración
warnings.filterwarnings('ignore')
pd.set_option('display.max_columns', None)


# 📂 Directorios y parámetros
ROOT0 = "C:"
ROOT = Path(r"C:\Users\FROJAS\Documents\HonorBI\B2B_Coppel_LVP\Codigo_COPPEL_LVP\Coppel\2025\Buenos")

NOM_COL = ["Region", "Tienda", "clase", "Familia", "Marca", "Modelo", "Date", "SO"]

# Palabras a eliminar de los modelos
PALABRAS_QUITAR = [
    # Colores
    "GREEN", "BLUE", "YELLOW", "ORANGE", "PURPLE", "BLACK", "WHITE", "GRAY", "PINK", "GOLD",
    "ROJO", "AZUL", "AMARILLO", "NARANJA", "VIOLETA", "CIAN", "PLATA", "MORADO", "NEGRO",
    "BLANCO", "ROSA", "GRIS", "COBRE", "LIMA", "PURPURA", "LAVANDA", "BEIGE", "CAFE", "LILA",
    "MORA", "SILVER", "CORAL", "DORADO", "OSCURO", "BRONCE", "MENTA", "CLARO", "MARINO",
    "AURORA", "NATURAL", "SIERRA", "ALPINE", "PROFUNDO", "OBSCURO", "PERLA", "DEEP INDIGO",
    "STARLIGHTH", "STARLIGT", "MIDNIGHTH", "MIDNIGT", "ULTRAMA", "GLACIAR", "MAGENTA",
    "MULTICOLOR", "SPACE", "DEEP", "GRAPHITE",
    # Variantes
    "MORAD", "GRAFIT", "GRAFITO", "PLAT", "VERD", "AMARILL", "AMARI", "NARAN", "LAVAN",
    "AZU", "BLAN", "GRI", "NEGR", "NEG", "NARA", "NAT", "BLA", "NRNJ", "VER", "MOR", "VIO",
    # Promociones
    "COMBO", "COMB2", "COMB", "COM2", "COM3", "DUO", "DUO3", "BUNDLE", "HBUNDLE", "BUND",
    "BUN", "PROMO", "KIT", "RENATO", "ESPECIAL", "ESPE", "MOCHILA",
    # Tecnología
    "IOTAIR3", "IOT", "W40", "5G", "4G", "3G", "64", "128", "256", "512", "12GB",
    # Otros
    "2020", "CIA", "PV", "IU", "BCO", "STAR", "OBS", "MAR", "/"
]

# Crear patrón único optimizado
PATRON_PALABRAS = r"\b(" + "|".join(PALABRAS_QUITAR) + r")\b"

# Patrón completo combinado (más eficiente)
PATRON_COMPLETO = "|".join([
    r"\b(\d+GB|\d+MB)\b",                                                          # Capacidad
    r"\b(2G|3G|4G|5G|GSM|4\.5G|3-G)\b",                                           # Redes
    PATRON_PALABRAS,                                                               # Palabras a quitar
    r"\b(KIT|BUNDLE|IU|OTA|AIR4-BES)\b",                                          # Palabras extra
    r"\b\w{3}-\w{3}\b",                                                            # Códigos XXX-YYY
    r"\b(SM-[A-Z0-9]+|XT[0-9-]+|CPH[0-9]+|2[2-4][A-Z0-9]+|BRP-[A-Z0-9]+|RMX[0-9]+)\b",  # Códigos específicos
    r"\b[a-zA-Z]{2}\b",                                                            # Palabras de 2 letras
    r"[[:punct:]/]"                                                                # Puntuación
])

# Compilar regex una sola vez (optimización importante)
PATRON_REGEX = re.compile(PATRON_COMPLETO, re.IGNORECASE)


# 🧹 Funciones

def limpiar_modelo(modelo: str) -> str:
    """
    Limpia nombres de modelos eliminando información no relevante.

    Optimizaciones:
    - Regex precompilado
    - Operaciones encadenadas eficientes
    - Uso de str.strip() en lugar de regex para espacios
    """
    if pd.isna(modelo):
        return ""

    # Reemplazar caracteres especiales y convertir a mayúsculas
    modelo = modelo.replace("\xa0", " ").upper()

    # Aplicar patrón completo en una sola pasada
    modelo = PATRON_REGEX.sub("", modelo)

    # Limpiar espacios múltiples de forma eficiente
    modelo = " ".join(modelo.split())

    return modelo


def leer_archivos_coppel(mes: int) -> pd.DataFrame:
    """
    Lee archivos de ventas de un mes específico.

    Args:
        mes: Número de mes (1-12)

    Returns:
        DataFrame combinado de todos los archivos del mes
    """
    print(f"Procesando M{mes:02d}")

    # Buscar archivos del mes
    patron = str(ROOT / f"Coppel_SO_M{mes:02d}_*.xlsx")
    archivos = glob(patron)

    if not archivos:
        print(f"⚠️  No se encontraron archivos para el mes {mes:02d}")
        return pd.DataFrame()

    dfs = []

    for archivo in archivos:
        print(f"   Leyendo: {Path(archivo).name}")

        # Leer Excel (dtype=str para evitar problemas de tipos)
        df = pd.read_excel(archivo, dtype=str)
        df.columns = NOM_COL

        # Convertir SO a numérico
        df['SO'] = pd.to_numeric(df['SO'], errors='coerce')

        # Manejo de fechas según el mes
        if mes == 5:
            df['Date'] = pd.to_datetime(df['Date'], format='%m-%d-%Y', errors='coerce')
        else:
            # Reemplazar \ por - y parsear
            df['Date'] = df['Date'].str.replace('\\', '-', regex=False)
            df['Date'] = pd.to_datetime(df['Date'], format='%d-%m-%Y', errors='coerce')

        # Limpiar modelo (vectorizado - más eficiente que apply)
        df['Modelo_Limpia'] = df['Modelo'].apply(limpiar_modelo)

        dfs.append(df)

    # Concatenar todos los DataFrames
    return pd.concat(dfs, ignore_index=True)


def resumir_ventas(
    df_ventas: pd.DataFrame,
    df_hc: pd.DataFrame,
    frecuencia: Literal['semana', 'mes'] = 'semana',
    output_file: str = None
) -> pd.DataFrame:
    """
    Resume ventas por período (semana o mes) y enriquece con datos de HC.

    Args:
        df_ventas: DataFrame con datos de ventas
        df_hc: DataFrame con datos de headcount
        frecuencia: 'semana' o 'mes'
        output_file: Ruta del archivo de salida (opcional)

    Returns:
        DataFrame resumido y enriquecido
    """
    # Convertir fecha y extraer año
    df_ventas['Date'] = pd.to_datetime(df_ventas['Date'])
    df_ventas['Year'] = df_ventas['Date'].dt.year

    # Calcular período según frecuencia
    if frecuencia == 'semana':
        df_ventas['periodo'] = df_ventas['Date'].dt.isocalendar().week
    else:  # mes
        df_ventas['periodo'] = df_ventas['Date'].dt.month_name().str[:3]

    # Agrupar y resumir
    df_resumido = (
        df_ventas
        .groupby(['Region', 'ID', 'Tienda', 'Familia', 'Marca', 'Modelo', 'Year', 'periodo'], dropna=False)
        .agg({'SO': 'sum'})
        .reset_index()
        .rename(columns={'SO': 'Sales', 'periodo': frecuencia})
        .sort_values(['Year', frecuencia])
    )

    # Filtrar y preparar HC
    df_hc_filtrado = (
        df_hc[
            (df_hc['Customer'] == 'COPPEL') &
            (df_hc['RG'].isin(['R1', 'R2', 'R3']))
        ]
        .loc[:, ['ID', 'NAME', 'ID used  in CHANNEL', 'Estado',
                 'FIXED PROMOTER', 'Promoter name', 'CM name']]
        .rename(columns={'ID': 'ID_Honor'})
        .drop_duplicates(subset=['ID used  in CHANNEL'], keep='first')
    )

    # Merge con HC
    df_final = df_resumido.merge(
        df_hc_filtrado,
        left_on='ID',
        right_on='ID used  in CHANNEL',
        how='left'
    )

    # Guardar si se especifica archivo
    if output_file:
        df_final.to_csv(output_file, index=False, encoding='utf-8-sig')
        print(f"✅ Archivo guardado: {output_file}")

    return df_final


# 📊 Ejecución principal

def main():
    """Función principal de ejecución."""

    inicio = time.time()

    print("\n" + "="*60)
    print("🚀 ANÁLISIS DE VENTAS COPPEL")
    print("="*60 + "\n")

    # 1️⃣ Leer y combinar todos los meses
    print("📂 Leyendo archivos de meses 5-10...\n")

    dfs_meses = []
    for mes in range(5, 11):
        df_mes = leer_archivos_coppel(mes)
        if not df_mes.empty:
            dfs_meses.append(df_mes)

    # Combinar todos los meses
    coppel_all = pd.concat(dfs_meses, ignore_index=True)

    # Separar columna Tienda en ID y Tienda
    tienda_split = coppel_all['Tienda'].str.split('•', n=1, expand=True)
    coppel_all['ID'] = tienda_split[0].str.strip() if 0 in tienda_split.columns else None
    coppel_all['Tienda'] = tienda_split[1].str.strip() if 1 in tienda_split.columns else coppel_all['Tienda']

    # Limpiar Familia
    familia_split = coppel_all['Familia'].str.split('•', n=1, expand=True)
    coppel_all['Familia'] = familia_split[1].str.strip() if 1 in familia_split.columns else coppel_all['Familia']

    # Convertir SO a numérico
    coppel_all['SO'] = pd.to_numeric(coppel_all['SO'], errors='coerce')

    print(f"\n✅ Registros leídos: {len(coppel_all):,}")

    # 2️⃣ Cargar HC
    print("\n📂 Cargando archivo HC...")
    hc_path = Path(r"C:\Users\FROJAS\Documents\HonorBI\B2B_Coppel_LVP\Codigo_COPPEL_LVP\HC_W44_October_Final.csv")

    df_hc = pd.read_csv(hc_path, header=None)
    df_hc.columns = df_hc.iloc[0]
    df_hc = df_hc.iloc[1:]
    df_hc.columns.values[11] = 'Direccion'  # Renombrar columna 12 (índice 11)

    print(f"✅ Registros HC: {len(df_hc):,}")

    # 3️⃣ Resumir ventas
    print("\n📊 Resumiendo ventas...")
    frec = "semana"  # "semana" o "mes"
    output = f"PriceList_Coppel_All_by_{frec}.csv"

    df_final = resumir_ventas(coppel_all, df_hc, frecuencia=frec, output_file=output)

    # Tiempo total
    fin = time.time()
    tiempo_total = fin - inicio

    print(f"\n⏱️  Tiempo total: {tiempo_total:.2f} segundos")
    print(f"✅ Procesamiento completo. Registros finales: {len(df_final):,}\n")

    return df_final


if __name__ == "__main__":
    df_resultado = main()
