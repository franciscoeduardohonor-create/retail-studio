#!/usr/bin/env python3
"""
===================================================================
🚀 OPTIMIZED: Visit Plan vs Attendance Analysis (Python Version)
Análisis de Planes de Visita vs Asistencia Real
===================================================================

Este script procesa datos de Visit Plans y Attendance, comparando
planes vs ejecución real y enriqueciéndolos con datos de Headcount.

Dependencias:
    pip install pandas openpyxl rapidfuzz

Autor: Honor BI Team
"""

import time
from pathlib import Path
from typing import List, Tuple
import warnings

import pandas as pd
from rapidfuzz import process, fuzz

# Configuración
warnings.filterwarnings('ignore')
pd.set_option('display.max_columns', None)
pd.set_option('display.width', None)


# ===================================================================
# 📂 CONFIGURACIÓN
# ===================================================================

# Directorio de trabajo
WORK_DIR = Path("D:/Documentos/BI_Honor/Honor/HC")

# Semana a procesar
WK = 50
SEMANA = f"WK{WK}/"

# Lista estándar de duties
STANDARD_DUTIES = ['FIXED PROMOTER', 'SUPERVISOR', 'CITY MANAGER', 'MERCHANDISER', 'TRAINER']

# Mapeo manual de duties especiales
DUTY_MAPPING = {
    'TRAINING MANAGER': 'TRAINER',
    'SALES ADVISOR': 'FIXED PROMOTER'
}


# ===================================================================
# 🔧 FUNCIONES
# ===================================================================

def read_excel_sheet(file_path: Path, sheet: int = 0) -> pd.DataFrame:
    """
    Lee una hoja específica de un archivo Excel.

    Args:
        file_path: Ruta al archivo Excel
        sheet: Número de hoja (0-indexed)

    Returns:
        DataFrame con los datos
    """
    return pd.read_excel(file_path, sheet_name=sheet)


def normalize_duties(df: pd.DataFrame, duty_col: str, duty_list: List[str]) -> pd.DataFrame:
    """
    Normaliza nombres de duties usando fuzzy matching.

    Usa rapidfuzz (más rápido que fuzzywuzzy) para encontrar
    el duty más cercano de la lista estándar.

    Args:
        df: DataFrame a procesar
        duty_col: Nombre de la columna con duties
        duty_list: Lista de duties estándar

    Returns:
        DataFrame con duties normalizados
    """
    # Convertir a mayúsculas
    df[duty_col] = df[duty_col].str.upper()

    # Normalizar usando fuzzy matching
    def match_duty(duty_name: str) -> str:
        if pd.isna(duty_name):
            return duty_name

        # Buscar coincidencia más cercana
        match, score, _ = process.extractOne(
            duty_name,
            duty_list,
            scorer=fuzz.ratio
        )
        return match

    # Aplicar normalización (vectorizado internamente por rapidfuzz)
    df[duty_col] = df[duty_col].apply(match_duty)

    return df


def load_data(work_dir: Path, week: int) -> Tuple[pd.DataFrame, pd.DataFrame, pd.DataFrame]:
    """
    Carga todos los archivos necesarios.

    Args:
        work_dir: Directorio de trabajo
        week: Número de semana

    Returns:
        Tupla con (df_HC, df_VP, df_ATT)
    """
    semana_path = work_dir / f"WK{week}"

    print("📥 Cargando archivos...")

    # Cargar Headcount
    hc_file = semana_path / f"HC W{week} R1 to R3.csv"
    print(f"   • {hc_file.name}")
    df_HC = pd.read_csv(hc_file, header=None)

    # Cargar Visit Plan
    vp_file = semana_path / f"VP WK {week}.xlsx"
    print(f"   • {vp_file.name}")
    df_VP = read_excel_sheet(vp_file, 0)

    # Cargar Attendance
    att_file = semana_path / f"ATT WK {week}.xlsx"
    print(f"   • {att_file.name}")
    df_ATT = read_excel_sheet(att_file, 0)

    print(f"✅ Archivos cargados: HC ({len(df_HC)}), VP ({len(df_VP)}), ATT ({len(df_ATT)})\n")

    return df_HC, df_VP, df_ATT


def prepare_headcount(df_HC: pd.DataFrame) -> pd.DataFrame:
    """
    Prepara datos de Headcount.

    Args:
        df_HC: DataFrame de Headcount

    Returns:
        DataFrame preparado
    """
    print("🔧 Preparando datos de Headcount...")

    # Usar primera fila como nombres de columnas
    df_HC.columns = df_HC.iloc[0]
    df_HC = df_HC.iloc[1:].reset_index(drop=True)

    # Descomentar si es necesario renombrar columna 12
    # df_HC.columns.values[11] = 'Direccion'

    return df_HC


def prepare_visit_plan_attendance(
    df_VP: pd.DataFrame,
    df_ATT: pd.DataFrame
) -> Tuple[pd.DataFrame, pd.DataFrame]:
    """
    Prepara y normaliza datos de Visit Plan y Attendance.

    Args:
        df_VP: DataFrame de Visit Plan
        df_ATT: DataFrame de Attendance

    Returns:
        Tupla con (df_VP2, df_ATT2) preparados
    """
    print("📝 Normalizando duties y positions...")

    # Convertir a mayúsculas
    df_ATT['Duty'] = df_ATT['Duty'].str.upper()
    df_VP['Position'] = df_VP['Position'].str.upper()

    # Reemplazos manuales específicos
    df_VP['Position'] = df_VP['Position'].replace(DUTY_MAPPING)
    df_ATT['Duty'] = df_ATT['Duty'].replace(DUTY_MAPPING)

    # Normalización automática usando fuzzy matching
    df_ATT = normalize_duties(df_ATT, 'Duty', STANDARD_DUTIES)
    df_VP = normalize_duties(df_VP, 'Position', STANDARD_DUTIES)

    print("🔄 Filtrando y preparando Visit Plan y Attendance...")

    # Visit Plan: eliminar duplicados
    df_VP2 = df_VP[['Store Code', 'Store Name', 'Store Visitor Account',
                    'Store Visitor', 'Position']].drop_duplicates()

    # Attendance: filtrar FIXED PROMOTER
    df_ATT2 = df_ATT[['Store Code', 'Store Name', 'Account', 'Name', 'Duty']].copy()
    df_ATT2 = df_ATT2[df_ATT2['Duty'] != 'FIXED PROMOTER']

    # Renombrar columnas para que coincidan
    df_VP2.columns = df_ATT2.columns

    print(f"   • VP filtrado: {len(df_VP2)} registros")
    print(f"   • ATT filtrado: {len(df_ATT2)} registros (sin Fixed Promoters)\n")

    return df_VP2, df_ATT2


def analyze_vp_vs_att(
    df_VP2: pd.DataFrame,
    df_ATT2: pd.DataFrame
) -> Tuple[pd.DataFrame, pd.DataFrame]:
    """
    Analiza coincidencias entre Visit Plan y Attendance.

    Args:
        df_VP2: DataFrame de Visit Plan preparado
        df_ATT2: DataFrame de Attendance preparado

    Returns:
        Tupla con (df_VP2_marked, df_no_match)
    """
    print("🔍 Analizando coincidencias entre Visit Plan y Attendance...")

    # Marcar registros de VP
    df_VP2 = df_VP2.copy()
    df_VP2['VP'] = 1

    # Crear claves únicas
    df_VP2['key'] = df_VP2['Store Code'].astype(str) + '_' + df_VP2['Account'].astype(str)
    df_ATT2['key'] = df_ATT2['Store Code'].astype(str) + '_' + df_ATT2['Account'].astype(str)

    # Verificar asistencia (optimizado con isin)
    df_VP2['att'] = df_VP2['key'].isin(df_ATT2['key']).astype(int)

    vp_con_att = df_VP2['att'].sum()
    total_vp = len(df_VP2)
    pct_att = 100 * vp_con_att / total_vp if total_vp > 0 else 0

    print(f"   • VP con asistencia: {vp_con_att} / {total_vp} ({pct_att:.1f}%)")

    print("📊 Identificando asistencias sin Visit Plan...")

    # Asistencias sin VP (anti-join optimizado)
    df_no_match = df_ATT2[~df_ATT2['key'].isin(df_VP2['key'])].copy()
    df_no_match['VP'] = 0
    df_no_match['att'] = 1
    df_no_match = df_no_match.drop(columns=['key'])

    print(f"   • Asistencias sin VP: {len(df_no_match)}\n")

    # Eliminar columna temporal
    df_VP2 = df_VP2.drop(columns=['key'])

    return df_VP2, df_no_match


def enrich_with_headcount(
    df_combined: pd.DataFrame,
    df_HC: pd.DataFrame
) -> pd.DataFrame:
    """
    Enriquece datos combinados con información de Headcount.

    Args:
        df_combined: DataFrame combinado de VP y Attendance
        df_HC: DataFrame de Headcount

    Returns:
        DataFrame enriquecido
    """
    print("🏢 Enriqueciendo con datos de Headcount...")

    # Crear diccionario de lookup para match eficiente
    hc_lookup = df_HC.set_index('ID')[[
        'CUSTUMER', 'RG', 'Estado', 'Ciudad', 'FIXED PROMOTER'
    ]].to_dict('index')

    # Mapear datos de HC
    df_combined['CUSTUMER'] = df_combined['Store Code'].map(
        lambda x: hc_lookup.get(x, {}).get('CUSTUMER', None)
    )
    df_combined['RG'] = df_combined['Store Code'].map(
        lambda x: hc_lookup.get(x, {}).get('RG', None)
    )
    df_combined['Estado'] = df_combined['Store Code'].map(
        lambda x: hc_lookup.get(x, {}).get('Estado', None)
    )
    df_combined['Ciudad'] = df_combined['Store Code'].map(
        lambda x: hc_lookup.get(x, {}).get('Ciudad', None)
    )
    df_combined['FP'] = df_combined['Store Code'].map(
        lambda x: hc_lookup.get(x, {}).get('FIXED PROMOTER', None)
    )

    return df_combined


def format_final_output(df: pd.DataFrame) -> pd.DataFrame:
    """
    Formatea el DataFrame final con las columnas correctas.

    Args:
        df: DataFrame a formatear

    Returns:
        DataFrame formateado
    """
    print("📋 Organizando columnas finales...")

    # Seleccionar y reordenar columnas
    df_final = df[[
        'CUSTUMER', 'RG', 'Estado', 'Ciudad', 'Store Code', 'Store Name',
        'FP', 'VP', 'att', 'Duty', 'Name', 'Account'
    ]].copy()

    # Renombrar a formato final
    df_final.columns = [
        'CUSTUMER', 'RG', 'Estado', 'Ciudad', 'ID', 'NAME',
        'FIXED PROMOTER', 'VP', 'Att', 'duty', 'Name_P', 'Acount'
    ]

    return df_final


def print_summary(df_final: pd.DataFrame):
    """
    Imprime resumen ejecutivo del análisis.

    Args:
        df_final: DataFrame final procesado
    """
    print("\n" + "="*60)
    print("📊 RESUMEN EJECUTIVO")
    print("="*60)

    total = len(df_final)
    vp_total = (df_final['VP'] == 1).sum()
    att_total = (df_final['Att'] == 1).sum()
    vp_con_att = ((df_final['VP'] == 1) & (df_final['Att'] == 1)).sum()
    att_sin_vp = ((df_final['VP'] == 0) & (df_final['Att'] == 1)).sum()
    vp_sin_att = ((df_final['VP'] == 1) & (df_final['Att'] == 0)).sum()

    pct_vp_con_att = 100 * vp_con_att / vp_total if vp_total > 0 else 0

    print(f"Total de registros procesados: {total:,}")
    print(f"  • Visit Plans: {vp_total:,}")
    print(f"  • Asistencias: {att_total:,}")
    print(f"  • VP con asistencia: {vp_con_att:,} ({pct_vp_con_att:.1f}%)")
    print(f"  • Asistencias sin VP: {att_sin_vp:,}")
    print(f"  • VP sin asistencia: {vp_sin_att:,}\n")

    print("Distribución por Duty:")
    duty_summary = df_final.groupby('duty').agg({
        'duty': 'count',
        'VP': 'sum',
        'Att': 'sum'
    }).rename(columns={'duty': 'Total'})

    duty_summary = duty_summary.sort_values('Total', ascending=False)
    print(duty_summary.to_string())


# ===================================================================
# 📊 FUNCIÓN PRINCIPAL
# ===================================================================

def main():
    """Función principal de ejecución."""

    inicio = time.time()

    print("\n" + "="*60)
    print(f"  ANÁLISIS DE VISIT PLAN VS ATTENDANCE - WK {WK}")
    print("="*60 + "\n")

    # 1. Cargar datos
    df_HC, df_VP, df_ATT = load_data(WORK_DIR, WK)

    # 2. Preparar Headcount
    df_HC = prepare_headcount(df_HC)

    # 3. Preparar VP y ATT
    df_VP2, df_ATT2 = prepare_visit_plan_attendance(df_VP, df_ATT)

    # 4. Analizar coincidencias
    df_VP2, df_no_match = analyze_vp_vs_att(df_VP2, df_ATT2)

    # 5. Combinar datasets
    print("🔗 Combinando Visit Plan y Asistencias...")
    df_combined = pd.concat([df_VP2, df_no_match], ignore_index=True)
    print(f"   • Total de registros combinados: {len(df_combined)}\n")

    # 6. Enriquecer con Headcount
    df_combined = enrich_with_headcount(df_combined, df_HC)

    # 7. Formatear salida final
    df_final = format_final_output(df_combined)

    # 8. Guardar resultado
    print("💾 Guardando resultado...")
    output_file = WORK_DIR / SEMANA / "HC_VpAtt_All_.csv"
    df_final.to_csv(output_file, index=False)
    print(f"✅ Archivo guardado: {output_file}\n")

    # 9. Resumen ejecutivo
    print_summary(df_final)

    # Tiempo total
    fin = time.time()
    tiempo_total = fin - inicio

    print("\n" + "="*60)
    print(f"⏱️  Tiempo total de ejecución: {tiempo_total:.2f} segundos")
    print("="*60)

    return df_final


# ===================================================================
# 🚀 EJECUCIÓN
# ===================================================================

if __name__ == "__main__":
    df_resultado = main()
