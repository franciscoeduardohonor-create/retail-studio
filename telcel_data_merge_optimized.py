#!/usr/bin/env python3
"""
===================================================================================
SCRIPT OPTIMIZADO: Unir datos de tiendas Telcel con información adicional
OBJETIVO: Agregar columnas Name_Honor, DEUR y CITY MANAGER al archivo principal
VERSIÓN: Python optimizado con pandas y rapidfuzz
===================================================================================
"""

import os
import re
import time
from pathlib import Path
from typing import Dict, List, Tuple, Optional

import pandas as pd
import numpy as np
from rapidfuzz import process, fuzz
from openpyxl import load_workbook
from openpyxl.styles import numbers


class TelcelDataMerger:
    """Clase optimizada para unir datos de tiendas Telcel con información adicional."""

    def __init__(self, config: Optional[Dict] = None):
        """
        Inicializar el merger con configuración.

        Args:
            config: Diccionario de configuración. Si es None, usa valores por defecto.
        """
        self.config = config or self._default_config()
        self._validate_config()

    @staticmethod
    def _default_config() -> Dict:
        """Retorna configuración por defecto."""
        return {
            # Rutas - MODIFICAR SEGÚN SEA NECESARIO
            'work_dir': r'C:\Users\FROJAS\Desktop\ArchivosTelcelAnalisisSemanas\TELCEL_SO\CODIGO3440',
            'input_file': 'Telcel_ALL_WK_3440_Reg.xlsx',
            'reference_file': 'Referencias_Tiendas_Telcel_CACR123REF.xlsx',
            'output_file': 'Telcel_Todas_WK_3440_Regiones_Name.xlsx',
            'unmatched_file': 'Tiendas_Sin_Match_Revisar.csv',

            # Parámetros
            'input_sheet': 'Datos_Consolidados',
            'reference_sheet': 'TiendasR123',
            'similarity_threshold': 80,  # 0-100 en rapidfuzz

            # Columnas
            'store_col_ventas': 'Venta',
            'store_col_ref': 'Tiendas_Telcel',
            'columns_to_add': ['Name_Honor', 'DEUR', 'CITY MANAGER']
        }

    def _validate_config(self):
        """Validar que el directorio de trabajo existe."""
        work_dir = Path(self.config['work_dir'])
        if not work_dir.exists():
            raise ValueError(f"ERROR: El directorio no existe: {work_dir}")

    @staticmethod
    def clean_store_names(series: pd.Series) -> pd.Series:
        """
        Limpia y estandariza nombres de tiendas (vectorizado).

        Args:
            series: Serie de pandas con nombres de tiendas

        Returns:
            Serie con nombres limpios
        """
        return (
            series
            .astype(str)
            .str.upper()
            .str.strip()
            .str.replace(r'\s+', ' ', regex=True)
            .str.replace(r'[^A-Z0-9\s]', '', regex=True)
            .str.strip()
        )

    def find_approximate_matches(
        self,
        unmatched_stores: List[str],
        reference_stores: List[str],
        threshold: int = 80
    ) -> pd.DataFrame:
        """
        Encuentra matches aproximados usando fuzzy matching (optimizado).

        Args:
            unmatched_stores: Lista de tiendas sin match exacto
            reference_stores: Lista de tiendas de referencia
            threshold: Umbral de similitud (0-100)

        Returns:
            DataFrame con matches aproximados
        """
        if not unmatched_stores:
            return pd.DataFrame(columns=['original_name', 'matched_name', 'similarity_score'])

        print(f"\nBuscando matches aproximados para {len(unmatched_stores)} tiendas...")

        # Usar process.extract para encontrar los mejores matches de forma vectorizada
        matches = []

        for store in unmatched_stores:
            # Encontrar el mejor match usando Jaro-Winkler (similar a R)
            match = process.extractOne(
                store,
                reference_stores,
                scorer=fuzz.WRatio,
                score_cutoff=threshold
            )

            if match:
                matches.append({
                    'original_name': store,
                    'matched_name': match[0],
                    'similarity_score': match[1]
                })

        result = pd.DataFrame(matches)

        if not result.empty:
            print(f"✓ Matches aproximados encontrados: {len(result)} de {len(unmatched_stores)} "
                  f"({len(result)/len(unmatched_stores)*100:.1f}%)")
        else:
            print("No se encontraron matches aproximados válidos.")

        return result

    def load_data(self) -> Tuple[pd.DataFrame, pd.DataFrame]:
        """
        Carga los archivos de datos.

        Returns:
            Tupla con (datos_ventas, datos_referencia)
        """
        work_dir = Path(self.config['work_dir'])
        os.chdir(work_dir)

        print("Leyendo archivos...")

        # Leer datos de ventas
        ventas_file = work_dir / self.config['input_file']
        ventas_data = pd.read_excel(
            ventas_file,
            sheet_name=self.config['input_sheet']
        )

        # Leer datos de referencia
        ref_file = work_dir / self.config['reference_file']
        tiendas_ref = pd.read_excel(
            ref_file,
            sheet_name=self.config['reference_sheet']
        )

        print(f"✓ Ventas: {len(ventas_data):,} filas, {len(ventas_data.columns)} columnas")
        print(f"✓ Referencia: {len(tiendas_ref):,} tiendas\n")

        return ventas_data, tiendas_ref

    def validate_columns(self, ventas_data: pd.DataFrame, tiendas_ref: pd.DataFrame) -> List[str]:
        """
        Valida que las columnas necesarias existan.

        Args:
            ventas_data: DataFrame de ventas
            tiendas_ref: DataFrame de referencia

        Returns:
            Lista de columnas disponibles para agregar
        """
        # Validar columna de tienda en ventas
        if self.config['store_col_ventas'] not in ventas_data.columns:
            raise ValueError(
                f"ERROR: Columna '{self.config['store_col_ventas']}' no encontrada en archivo de ventas"
            )

        # Validar columna de tienda en referencia
        if self.config['store_col_ref'] not in tiendas_ref.columns:
            raise ValueError(
                f"ERROR: Columna '{self.config['store_col_ref']}' no encontrada en archivo de referencia"
            )

        # Identificar columnas disponibles
        available_cols = [
            col for col in self.config['columns_to_add']
            if col in tiendas_ref.columns
        ]

        if not available_cols:
            raise ValueError("ERROR: No se encontraron columnas válidas para agregar")

        missing_cols = set(self.config['columns_to_add']) - set(available_cols)
        if missing_cols:
            print(f"ADVERTENCIA: Columnas no disponibles: {', '.join(missing_cols)}\n")

        return available_cols

    def merge_data(
        self,
        ventas_data: pd.DataFrame,
        tiendas_ref: pd.DataFrame,
        available_cols: List[str]
    ) -> pd.DataFrame:
        """
        Realiza el merge inteligente de datos.

        Args:
            ventas_data: DataFrame de ventas
            tiendas_ref: DataFrame de referencia
            available_cols: Columnas disponibles para agregar

        Returns:
            DataFrame con datos unidos
        """
        print("Limpiando nombres de tiendas...")

        # Limpiar nombres
        ventas_data = ventas_data.copy()
        ventas_data['Store_Clean'] = self.clean_store_names(
            ventas_data[self.config['store_col_ventas']]
        )

        tiendas_ref = tiendas_ref.copy()
        tiendas_ref['Store_Clean'] = self.clean_store_names(
            tiendas_ref[self.config['store_col_ref']]
        )

        # Preparar referencia (remover duplicados)
        tiendas_for_join = (
            tiendas_ref[['Store_Clean'] + available_cols]
            .drop_duplicates(subset='Store_Clean', keep='first')
        )

        # Merge exacto
        print("Realizando matching exacto...")
        result = ventas_data.merge(
            tiendas_for_join,
            on='Store_Clean',
            how='left'
        )

        # Estadísticas de matching exacto
        primary_col = available_cols[0]
        exact_matches = result[primary_col].notna().sum()
        total_rows = len(result)

        print(f"✓ Matches exactos: {exact_matches:,} de {total_rows:,} "
              f"({exact_matches/total_rows*100:.1f}%)")

        # Matching aproximado
        unmatched_stores = (
            result.loc[result[primary_col].isna(), 'Store_Clean']
            .dropna()
            .unique()
            .tolist()
        )

        if unmatched_stores:
            approx_matches = self.find_approximate_matches(
                unmatched_stores,
                tiendas_ref['Store_Clean'].unique().tolist(),
                self.config['similarity_threshold']
            )

            if not approx_matches.empty:
                # Crear mapping
                match_map = dict(zip(
                    approx_matches['original_name'],
                    approx_matches['matched_name']
                ))

                # Aplicar matches aproximados
                result['Matched_Store'] = result['Store_Clean'].map(match_map).fillna(result['Store_Clean'])

                # Re-merge con las tiendas matched
                result = result.drop(columns=available_cols)
                result = result.merge(
                    tiendas_for_join,
                    left_on='Matched_Store',
                    right_on='Store_Clean',
                    how='left',
                    suffixes=('', '_ref')
                )

                # Limpiar columnas duplicadas
                result = result.drop(columns=['Matched_Store', 'Store_Clean_ref'])

                # Recalcular estadísticas
                final_matches = result[primary_col].notna().sum()
                print(f"✓ Total después de matching aproximado: {final_matches:,} de {total_rows:,} "
                      f"({final_matches/total_rows*100:.1f}%)")

        # Remover columna auxiliar
        result = result.drop(columns=['Store_Clean'])

        print(f"\n✓ Datos finales: {len(result):,} filas, {len(result.columns)} columnas\n")

        return result

    def reorder_columns(self, df: pd.DataFrame, available_cols: List[str]) -> pd.DataFrame:
        """
        Reordena columnas según especificación.

        Args:
            df: DataFrame con datos
            available_cols: Columnas que se agregaron

        Returns:
            DataFrame con columnas reordenadas
        """
        original_cols = [col for col in df.columns if col not in available_cols]

        # Encontrar posición de Venta
        venta_col = self.config['store_col_ventas']
        if venta_col not in original_cols:
            return df

        venta_idx = original_cols.index(venta_col)

        # Separar columnas
        cols_after_venta = [col for col in ['Name_Honor', 'DEUR'] if col in available_cols]
        city_manager_col = [col for col in ['CITY MANAGER'] if col in available_cols]

        # Construir nuevo orden
        if venta_idx < len(original_cols) - 1:
            new_order = (
                original_cols[:venta_idx + 1] +
                cols_after_venta +
                original_cols[venta_idx + 1:] +
                city_manager_col
            )
        else:
            new_order = original_cols + cols_after_venta + city_manager_col

        return df[new_order]

    def save_results(self, final_data: pd.DataFrame, available_cols: List[str]):
        """
        Guarda resultados y genera reportes.

        Args:
            final_data: DataFrame con datos finales
            available_cols: Columnas que se agregaron
        """
        print("=== GUARDANDO RESULTADOS ===")

        output_file = Path(self.config['work_dir']) / self.config['output_file']

        # Guardar Excel
        with pd.ExcelWriter(output_file, engine='openpyxl') as writer:
            final_data.to_excel(writer, sheet_name='Datos_Enriquecidos', index=False)

        print(f"✓ Archivo guardado: {output_file}\n")

        # Reporte de calidad
        print("=== REPORTE DE CALIDAD ===")

        for col in available_cols:
            non_na = final_data[col].notna().sum()
            pct = (non_na / len(final_data)) * 100
            print(f"{col:<15}: {non_na:,} ({pct:.1f}%)")

        # Top valores
        print("\nTop 10 valores por columna:")
        for col in available_cols:
            print(f"\n{col}:")
            top_values = (
                final_data[final_data[col].notna()]
                .groupby(col)
                .size()
                .sort_values(ascending=False)
                .head(10)
            )
            for value, count in top_values.items():
                print(f"  {value}: {count:,}")

        # Tiendas sin match
        primary_col = available_cols[0]
        unmatched = (
            final_data[final_data[primary_col].isna()]
            .groupby(self.config['store_col_ventas'])
            .size()
            .sort_values(ascending=False)
            .reset_index(name='Registros')
        )

        if not unmatched.empty:
            print(f"\nTiendas sin match: {len(unmatched)} (requieren revisión manual)")
            unmatched_file = Path(self.config['work_dir']) / self.config['unmatched_file']
            unmatched.to_csv(unmatched_file, index=False, encoding='utf-8-sig')
            print(f"✓ Lista guardada: {unmatched_file}")
        else:
            print("\n¡Excelente! Todas las tiendas hicieron match.")

    def run(self) -> pd.DataFrame:
        """
        Ejecuta el proceso completo de merge.

        Returns:
            DataFrame con datos finales
        """
        try:
            # Cargar datos
            ventas_data, tiendas_ref = self.load_data()

            # Validar columnas
            available_cols = self.validate_columns(ventas_data, tiendas_ref)

            # Merge
            result = self.merge_data(ventas_data, tiendas_ref, available_cols)

            # Reordenar columnas
            result = self.reorder_columns(result, available_cols)

            # Guardar
            self.save_results(result, available_cols)

            return result

        except Exception as e:
            print(f"\n❌ ERROR: {e}")
            raise


def main():
    """Función principal."""
    print("\n" + "=" * 65)
    print("  TELCEL DATA MERGE - VERSIÓN OPTIMIZADA PYTHON")
    print("=" * 65 + "\n")

    start_time = time.time()

    # Crear configuración personalizada si es necesario
    config = TelcelDataMerger._default_config()

    # Ejecutar merger
    merger = TelcelDataMerger(config)
    result = merger.run()

    elapsed = time.time() - start_time

    print("\n" + "=" * 65)
    print(f"  PROCESO COMPLETADO EN {elapsed:.2f} SEGUNDOS")
    print("=" * 65 + "\n")

    return result


if __name__ == "__main__":
    result = main()
