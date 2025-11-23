#!/usr/bin/env python3
"""
===================================================================================
SCRIPT: Unir datos de tiendas Telcel con información adicional
DESCRIPCIÓN: Versión Python optimizada del proceso de matching de tiendas
CARACTERÍSTICAS:
  - Matching exacto y aproximado de nombres de tiendas
  - Usa pandas para manipulación eficiente de datos
  - Usa rapidfuzz para matching aproximado de alto rendimiento
  - Genera reportes de calidad
===================================================================================
"""

import os
import re
from pathlib import Path
from typing import Tuple, Optional, List

import pandas as pd
import numpy as np
from rapidfuzz import fuzz, process
from openpyxl import Workbook
from openpyxl.styles import numbers

# Configuración
WORK_DIR = r"C:\Users\FROJAS\Desktop\ArchivosTelcelAnalisisSemanas\SemanasTabletas\NOMBRES"
MAIN_FILE = "Telcel_Todas_WK_SEPT_Regiones.xlsx"
REF_FILE = "Referencias_Tiendas_Telcel_CACR123REF.xlsx"
OUTPUT_FILE = "Telcel_Todas_WKs_SEPT_Regiones_Name.xlsx"
SIMILARITY_THRESHOLD = 80  # 0-100 scale for rapidfuzz


def clean_store_names(names_series: pd.Series) -> pd.Series:
    """
    Limpia y estandariza nombres de tiendas.

    Convierte a mayúsculas, elimina espacios extra y caracteres especiales.

    Args:
        names_series: Serie de pandas con nombres de tiendas

    Returns:
        Serie con nombres limpios
    """
    return (
        names_series
        .astype(str)
        .str.upper()
        .str.strip()
        .str.replace(r'\s+', ' ', regex=True)
        .str.replace(r'[^A-Z0-9\s]', '', regex=True)
        .str.strip()
    )


def find_approximate_matches(
    unmatched: List[str],
    reference: List[str],
    threshold: int = SIMILARITY_THRESHOLD
) -> pd.DataFrame:
    """
    Encuentra matches aproximados usando algoritmo Jaro-Winkler.

    Args:
        unmatched: Lista de nombres sin match exacto
        reference: Lista de nombres de referencia
        threshold: Umbral de similitud (0-100)

    Returns:
        DataFrame con matches aproximados y sus scores
    """
    if not unmatched:
        return pd.DataFrame(columns=['original_name', 'matched_name', 'similarity_score'])

    print(f"\nBuscando matches aproximados para {len(unmatched)} tiendas (threshold: {threshold})...")

    matches = []

    for store in unmatched:
        # Buscar mejor match usando Jaro-Winkler
        result = process.extractOne(
            store,
            reference,
            scorer=fuzz.WRatio,  # Weighted Ratio, similar a Jaro-Winkler
            score_cutoff=threshold
        )

        if result:
            matched_name, score, _ = result
            matches.append({
                'original_name': store,
                'matched_name': matched_name,
                'similarity_score': score
            })

    df_matches = pd.DataFrame(matches)

    if not df_matches.empty:
        print(f"Matches aproximados encontrados: {len(df_matches)} de {len(unmatched)} "
              f"({100 * len(df_matches) / len(unmatched):.1f}%)")
    else:
        print("No se encontraron matches aproximados con el threshold especificado")

    return df_matches


def smart_data_join(work_dir: str = WORK_DIR) -> Tuple[pd.DataFrame, bool]:
    """
    Función principal para unir datos de ventas con información de tiendas.

    Args:
        work_dir: Directorio de trabajo

    Returns:
        Tuple (DataFrame con datos unidos, bool si tiene city manager)
    """
    print("\n=== PROCESO DE UNIÓN INTELIGENTE DE DATOS ===\n")

    # Cambiar directorio
    os.chdir(work_dir)
    print(f"Directorio de trabajo: {work_dir}\n")

    # Cargar datos
    print("Cargando datos...")
    df_ventas = pd.read_excel(
        MAIN_FILE,
        sheet_name="Datos_Consolidados"
    )
    df_tiendas = pd.read_excel(
        REF_FILE,
        sheet_name="TiendasR123"
    )

    print(f"✓ Ventas: {len(df_ventas):,} filas")
    print(f"✓ Tiendas referencia: {len(df_tiendas):,} filas")

    # Validar columnas requeridas
    if 'Venta' not in df_ventas.columns:
        raise ValueError("ERROR: Columna 'Venta' no encontrada en archivo principal")

    required_cols = ['Tiendas_Telcel', 'Name_Honor', 'DEUR']
    missing_cols = [col for col in required_cols if col not in df_tiendas.columns]

    if missing_cols:
        raise ValueError(f"ERROR: Columnas faltantes en referencia: {', '.join(missing_cols)}")

    # Detectar columna City Manager
    city_manager_cols = [col for col in df_tiendas.columns
                         if re.search(r'CITY.*MANAGER', col, re.IGNORECASE)]
    has_city_manager = len(city_manager_cols) > 0

    if has_city_manager:
        city_manager_col = city_manager_cols[0]
        print(f"✓ Columna City Manager encontrada: '{city_manager_col}'")
    else:
        city_manager_col = None

    # Limpiar nombres
    print("\nLimpiando nombres de tiendas...")
    df_ventas['Venta_Clean'] = clean_store_names(df_ventas['Venta'])
    df_tiendas['Tiendas_Clean'] = clean_store_names(df_tiendas['Tiendas_Telcel'])

    # Preparar referencia (eliminar duplicados)
    cols_to_keep = ['Tiendas_Clean', 'Name_Honor', 'DEUR']
    if has_city_manager:
        cols_to_keep.append(city_manager_col)

    df_tiendas_unique = df_tiendas[cols_to_keep].drop_duplicates(
        subset=['Tiendas_Clean'],
        keep='first'
    )

    print(f"✓ Tiendas únicas en ventas: {df_ventas['Venta_Clean'].nunique()}")
    print(f"✓ Tiendas únicas en referencia: {len(df_tiendas_unique)}")

    # Join exacto
    print("\nRealizando join exacto...")
    df_result = df_ventas.merge(
        df_tiendas_unique,
        left_on='Venta_Clean',
        right_on='Tiendas_Clean',
        how='left'
    )

    # Renombrar City Manager si existe
    if has_city_manager:
        df_result.rename(columns={city_manager_col: 'CITY_MANAGER'}, inplace=True)

    exact_matches = df_result['Name_Honor'].notna().sum()
    total_rows = len(df_result)

    print(f"✓ Matches exactos: {exact_matches:,} de {total_rows:,} "
          f"({100 * exact_matches / total_rows:.1f}%)")

    # Matching aproximado
    unmatched = df_result.loc[df_result['Name_Honor'].isna(), 'Venta_Clean'].unique()
    unmatched = [x for x in unmatched if pd.notna(x)]

    if unmatched:
        print(f"\nProcesando {len(unmatched)} tiendas sin match exacto...")

        df_approx = find_approximate_matches(
            unmatched,
            df_tiendas_unique['Tiendas_Clean'].tolist(),
            SIMILARITY_THRESHOLD
        )

        if not df_approx.empty:
            # Crear mapeo de aproximados a datos de referencia
            df_mapping = df_approx.merge(
                df_tiendas_unique,
                left_on='matched_name',
                right_on='Tiendas_Clean',
                how='left'
            )

            # Actualizar matches aproximados
            for _, row in df_mapping.iterrows():
                mask = (
                    (df_result['Venta_Clean'] == row['original_name']) &
                    (df_result['Name_Honor'].isna())
                )

                df_result.loc[mask, 'Name_Honor'] = row['Name_Honor']
                df_result.loc[mask, 'DEUR'] = row['DEUR']

                if has_city_manager:
                    df_result.loc[mask, 'CITY_MANAGER'] = row['CITY_MANAGER']

            new_matches = df_result['Name_Honor'].notna().sum()
            print(f"✓ Total matches: {new_matches:,} de {total_rows:,} "
                  f"({100 * new_matches / total_rows:.1f}%)")

    # Reorganizar columnas
    print("\nReorganizando columnas...")

    # Eliminar columnas auxiliares
    df_result.drop(columns=['Venta_Clean', 'Tiendas_Clean'], inplace=True, errors='ignore')

    # Obtener columnas originales
    all_cols = df_result.columns.tolist()
    new_cols = ['Name_Honor', 'DEUR', 'CITY_MANAGER'] if has_city_manager else ['Name_Honor', 'DEUR']
    original_cols = [col for col in all_cols if col not in new_cols]

    # Encontrar posición de Venta
    try:
        venta_idx = original_cols.index('Venta')

        # Reorganizar: columnas antes de Venta + Venta + nuevas columnas + resto
        new_order = (
            original_cols[:venta_idx + 1] +
            ['Name_Honor', 'DEUR'] +
            original_cols[venta_idx + 1:]
        )

        if has_city_manager:
            new_order.append('CITY_MANAGER')

        # Filtrar solo columnas existentes
        new_order = [col for col in new_order if col in all_cols]
        df_result = df_result[new_order]

    except ValueError:
        print("⚠ Columna 'Venta' no encontrada, manteniendo orden original")

    print(f"✓ Dataset final: {len(df_result):,} filas, {len(df_result.columns)} columnas")

    return df_result, has_city_manager


def save_results_and_report(
    df: pd.DataFrame,
    has_city_manager: bool = False,
    work_dir: str = WORK_DIR
) -> None:
    """
    Guarda resultados y genera reporte de calidad.

    Args:
        df: DataFrame con datos procesados
        has_city_manager: Si incluye columna City Manager
        work_dir: Directorio de trabajo
    """
    print("\n=== GUARDANDO RESULTADOS ===")

    # Guardar Excel
    output_path = Path(work_dir) / OUTPUT_FILE

    with pd.ExcelWriter(output_path, engine='openpyxl') as writer:
        df.to_excel(writer, sheet_name='Datos_Enriquecidos', index=False)

        # Formatear fechas si existen
        workbook = writer.book
        worksheet = writer.sheets['Datos_Enriquecidos']

        for idx, col in enumerate(df.columns, 1):
            if pd.api.types.is_datetime64_any_dtype(df[col]):
                for row in range(2, len(df) + 2):
                    cell = worksheet.cell(row=row, column=idx)
                    cell.number_format = numbers.FORMAT_DATE_XLSX14

    print(f"✓ Archivo guardado: {OUTPUT_FILE}")

    # Reporte de calidad
    print("\n=== REPORTE DE CALIDAD ===")
    total = len(df)

    print(f"Total filas: {total:,}")
    print(f"Con Name_Honor: {df['Name_Honor'].notna().sum():,} "
          f"({100 * df['Name_Honor'].notna().sum() / total:.1f}%)")
    print(f"Con DEUR: {df['DEUR'].notna().sum():,} "
          f"({100 * df['DEUR'].notna().sum() / total:.1f}%)")

    if has_city_manager and 'CITY_MANAGER' in df.columns:
        print(f"Con CITY_MANAGER: {df['CITY_MANAGER'].notna().sum():,} "
              f"({100 * df['CITY_MANAGER'].notna().sum() / total:.1f}%)")

    # Top valores
    print("\nTop 10 Name_Honor:")
    print(df['Name_Honor'].value_counts().head(10))

    print("\nTop 10 DEUR:")
    print(df['DEUR'].value_counts().head(10))

    if has_city_manager and 'CITY_MANAGER' in df.columns:
        print("\nTop 10 CITY_MANAGER:")
        print(df['CITY_MANAGER'].value_counts().head(10))

    # Tiendas sin match
    df_unmatched = df[df['Name_Honor'].isna()].groupby('Venta').size().reset_index(name='count')
    df_unmatched = df_unmatched.sort_values('count', ascending=False)

    if not df_unmatched.empty:
        print(f"\n⚠ Tiendas sin match: {len(df_unmatched)}")
        print("\nTop 10 tiendas sin match:")
        print(df_unmatched.head(10))

        unmatched_path = Path(work_dir) / "Tiendas_Sin_Match_Revisar.csv"
        df_unmatched.to_csv(unmatched_path, index=False, encoding='utf-8-sig')
        print(f"✓ Lista guardada: Tiendas_Sin_Match_Revisar.csv")
    else:
        print("\n✓ Todas las tiendas tienen match exitoso")


def main():
    """Función principal."""
    try:
        # Verificar archivos
        main_path = Path(WORK_DIR) / MAIN_FILE
        ref_path = Path(WORK_DIR) / REF_FILE

        if not main_path.exists():
            raise FileNotFoundError(f"ERROR: No se encuentra {MAIN_FILE}")
        if not ref_path.exists():
            raise FileNotFoundError(f"ERROR: No se encuentra {REF_FILE}")

        # Ejecutar proceso
        df_final, has_cm = smart_data_join(WORK_DIR)
        save_results_and_report(df_final, has_cm, WORK_DIR)

        print("\n=== PROCESO COMPLETADO ===")
        return df_final

    except Exception as e:
        print(f"\n❌ ERROR: {e}")
        raise


if __name__ == "__main__":
    main()
