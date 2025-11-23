#!/usr/bin/env python3
"""
============================================================================
HC (Head Count) Analysis - Python Implementation
============================================================================
Este script procesa archivos HC en formato .xlsb y genera tablas de tiempo
con datos de Promotores y Management (Autorizados, Contratados, Vacantes, Standby)

Implementación optimizada en Python con:
- Estructura orientada a objetos
- Type hints para mejor mantenibilidad
- Logging para debugging
- Manejo robusto de errores
- Configuración flexible

Dependencias:
    pip install pandas openpyxl pyxlsb pathlib2
============================================================================
"""

import os
import sys
from pathlib import Path
from typing import List, Dict, Any, Tuple
from dataclasses import dataclass, field
from datetime import datetime, timedelta
import logging

import pandas as pd
from pyxlsb import open_workbook
from openpyxl import Workbook
from openpyxl.utils.dataframe import dataframe_to_rows

# ============================================================================
# CONFIGURACIÓN DE LOGGING
# ============================================================================
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)


# ============================================================================
# CONFIGURACIÓN
# ============================================================================
@dataclass
class HCConfig:
    """Configuración centralizada para el análisis HC"""

    # Directorios
    root: str = "D:/Documentos/BI_Honor/Honor/HC"
    output: str = "Tablas_de_Tiempo/"

    # Configuración de hojas
    sheet_names: List[str] = field(default_factory=lambda: [
        "Authorized Promoters",
        "Authorized Management",
        "Hired Promoters",
        "Hired Management",
        "Vacancy Promoters",
        "Vacancy Management",
        "Standby Promoters"
    ])

    # Configuración de rangos por versión de semana
    ranges: Dict[str, List[str]] = field(default_factory=lambda: {
        'wk6_8': [
            "B3:I12", "L3:U12", "B18:I27", "L18:U27",
            "B33:I42", "L33:U42", "B48:I57"
        ],
        'wk9_16': [
            "B3:I12", "M3:V12", "B18:I27", "M18:V27",
            "B33:I42", "M33:V42", "B48:I57"
        ],
        'wk17_18': [
            "B3:I12", "N3:W12", "B18:I27", "N18:W27",
            "B33:I42", "N33:W42", "B48:I57"
        ],
        'wk19_plus': [
            "B3:I12", "N3:P12", "R3:X12", "B18:I27",
            "N18:W27", "R18:X27", "B33:I42", "N33:W42",
            "R33:X42", "B48:I57"
        ]
    })

    # Parámetros temporales
    week_start: int = 6
    date_start: str = "2024-02-05"
    sheet_name: str = "SUMMARY"

    def get_root_path(self) -> Path:
        """Retorna el path raíz como objeto Path"""
        return Path(self.root)

    def get_output_path(self) -> Path:
        """Retorna el path de salida como objeto Path"""
        return self.get_root_path() / self.output


# ============================================================================
# CLASE PRINCIPAL
# ============================================================================
class HCAnalyzer:
    """Analizador de datos HC (Head Count)"""

    def __init__(self, config: HCConfig = None):
        """
        Inicializa el analizador HC

        Args:
            config: Configuración personalizada (opcional)
        """
        self.config = config or HCConfig()
        self.hc_files: List[Path] = []
        self.hc_data: Dict[str, Dict[str, pd.DataFrame]] = {}
        self.week_labels: List[str] = []

    def get_hc_files(self) -> List[Path]:
        """
        Obtiene la lista de archivos HC (.xlsb)

        Returns:
            Lista de rutas de archivos .xlsb
        """
        root_path = self.config.get_root_path()
        files = list(root_path.rglob("*.xlsb"))
        logger.info(f"Encontrados {len(files)} archivos .xlsb")
        return sorted(files)

    def get_ranges_for_week(self, week: int) -> List[str]:
        """
        Determina qué configuración de rangos usar según la semana

        Args:
            week: Número de semana

        Returns:
            Lista de rangos correspondiente
        """
        if 6 <= week <= 8:
            return self.config.ranges['wk6_8']
        elif 9 <= week <= 16:
            return self.config.ranges['wk9_16']
        elif 17 <= week <= 18:
            return self.config.ranges['wk17_18']
        else:
            return self.config.ranges['wk19_plus']

    def parse_range(self, range_str: str) -> Tuple[str, int, str, int]:
        """
        Parsea un rango de Excel (ej: "B3:I12")

        Args:
            range_str: String con rango de Excel

        Returns:
            Tupla con (col_inicio, fila_inicio, col_fin, fila_fin)
        """
        start, end = range_str.split(':')

        # Extraer columna y fila del inicio
        start_col = ''.join(filter(str.isalpha, start))
        start_row = int(''.join(filter(str.isdigit, start)))

        # Extraer columna y fila del fin
        end_col = ''.join(filter(str.isalpha, end))
        end_row = int(''.join(filter(str.isdigit, end)))

        return start_col, start_row, end_col, end_row

    def read_xlsb_range(
        self,
        file_path: Path,
        sheet_name: str,
        range_str: str
    ) -> pd.DataFrame:
        """
        Lee un rango específico de un archivo .xlsb

        Args:
            file_path: Ruta del archivo
            sheet_name: Nombre de la hoja
            range_str: Rango de celdas (ej: "B3:I12")

        Returns:
            DataFrame con los datos leídos
        """
        start_col, start_row, end_col, end_row = self.parse_range(range_str)

        data = []
        with open_workbook(str(file_path)) as wb:
            with wb.get_sheet(sheet_name) as sheet:
                # Leer filas en el rango especificado
                for row_idx, row in enumerate(sheet.rows(), start=1):
                    if start_row <= row_idx <= end_row:
                        row_data = [cell.v for cell in row]
                        data.append(row_data)

        if not data:
            logger.warning(f"No se encontraron datos en {range_str}")
            return pd.DataFrame()

        # Primera fila como headers
        df = pd.DataFrame(data[1:], columns=data[0])

        # Convertir a formato largo (melt)
        id_vars = df.columns[:2].tolist()  # Primeras 2 columnas como identificadores
        df_melted = df.melt(
            id_vars=id_vars,
            var_name='variable',
            value_name='value'
        )

        return df_melted

    def process_week_data(
        self,
        week_num: int,
        file_path: Path
    ) -> Dict[str, pd.DataFrame]:
        """
        Procesa datos de una semana específica

        Args:
            week_num: Número de semana
            file_path: Ruta del archivo a procesar

        Returns:
            Diccionario con datos procesados por categoría
        """
        ranges = self.get_ranges_for_week(week_num)
        result = {}

        for i, range_str in enumerate(ranges):
            if i < len(self.config.sheet_names):
                category = self.config.sheet_names[i]
                try:
                    df = self.read_xlsb_range(
                        file_path,
                        self.config.sheet_name,
                        range_str
                    )
                    result[category] = df
                except Exception as e:
                    logger.error(
                        f"Error procesando {category} en semana {week_num}: {e}"
                    )
                    result[category] = pd.DataFrame()

        return result

    def process_all_weeks(self) -> None:
        """Procesa todos los archivos HC"""
        week_final = len(self.hc_files) + self.config.week_start - 1

        for week_num in range(self.config.week_start, week_final + 1):
            week_label = f"WK{week_num:02d}"
            file_index = week_num - self.config.week_start

            if file_index < len(self.hc_files):
                file_path = self.hc_files[file_index]
                logger.info(f"Procesando semana {week_label}: {file_path.name}")

                self.hc_data[week_label] = self.process_week_data(
                    week_num,
                    file_path
                )

                self.week_labels.append(week_label)

    def create_consolidated_df(self, category: str) -> pd.DataFrame:
        """
        Crea dataframe consolidado para una categoría

        Args:
            category: Nombre de la categoría

        Returns:
            DataFrame consolidado
        """
        if not self.week_labels:
            logger.error("No hay datos procesados")
            return pd.DataFrame()

        # Usar primera semana como base
        first_week = self.week_labels[0]
        base_df = self.hc_data[first_week][category]

        if base_df.empty:
            logger.warning(f"No hay datos base para {category}")
            return pd.DataFrame()

        # Crear dataframe con las primeras dos columnas
        result_df = base_df.iloc[:, :2].copy()

        # Agregar columnas para cada semana
        for week in self.week_labels:
            if week in self.hc_data and category in self.hc_data[week]:
                result_df[week] = self.hc_data[week][category]['value'].values

        # Renombrar columnas
        result_df.columns = ['Region', 'Variable'] + self.week_labels

        return result_df

    def save_to_excel(self, output_path: Path) -> None:
        """
        Guarda datos en archivo Excel

        Args:
            output_path: Ruta del archivo de salida
        """
        # Crear directorio de salida si no existe
        output_path.parent.mkdir(parents=True, exist_ok=True)

        with pd.ExcelWriter(output_path, engine='openpyxl') as writer:
            for category in self.config.sheet_names:
                df = self.create_consolidated_df(category)

                if not df.empty:
                    # Nombre de hoja sin espacios
                    sheet_name = category.replace(" ", "")
                    df.to_excel(writer, sheet_name=sheet_name, index=False)
                    logger.info(f"Hoja creada: {sheet_name}")

        logger.info(f"Archivo guardado: {output_path}")

    def save_week_dates(self, output_path: Path) -> None:
        """
        Crea y guarda tabla de fechas de semanas

        Args:
            output_path: Ruta del archivo de salida
        """
        # Crear directorio de salida si no existe
        output_path.parent.mkdir(parents=True, exist_ok=True)

        # Generar fechas
        start_date = datetime.strptime(self.config.date_start, "%Y-%m-%d")
        current_date = datetime.now()

        dates = []
        date = start_date
        while date <= current_date:
            dates.append(date.strftime("%Y-%m-%d"))
            date += timedelta(weeks=1)

        # Ajustar longitud
        n_weeks = min(len(self.week_labels), len(dates))

        # Crear DataFrame
        df_semanas = pd.DataFrame({
            'Semana': self.week_labels[:n_weeks],
            'Fecha_i': dates[:n_weeks]
        })

        # Guardar CSV
        df_semanas.to_csv(output_path, index=False)
        logger.info(f"Tabla de fechas guardada: {output_path}")

    def run(self) -> None:
        """Ejecuta el análisis completo"""
        logger.info("=" * 60)
        logger.info("Iniciando procesamiento de HC")
        logger.info("=" * 60)

        # Obtener archivos
        self.hc_files = self.get_hc_files()

        if not self.hc_files:
            raise FileNotFoundError(
                f"No se encontraron archivos .xlsb en {self.config.root}"
            )

        # Procesar todos los archivos
        logger.info("\nProcesando archivos...")
        self.process_all_weeks()

        # Guardar resultados en Excel
        logger.info("\n" + "=" * 60)
        logger.info("Guardando resultados en Excel...")
        logger.info("=" * 60)

        output_file = self.config.get_output_path() / f"TS_Vacantes_V{self.week_labels[-1]}.xlsx"
        self.save_to_excel(output_file)

        # Guardar tabla de fechas
        logger.info("\n" + "=" * 60)
        logger.info("Generando tabla de fechas...")
        logger.info("=" * 60)

        dates_file = self.config.get_output_path() / "SemanasYFecha.csv"
        self.save_week_dates(dates_file)

        logger.info("\n" + "=" * 60)
        logger.info("Procesamiento completado exitosamente")
        logger.info("=" * 60)


# ============================================================================
# EJECUCIÓN PRINCIPAL
# ============================================================================
def main():
    """Función principal"""
    try:
        # Crear analizador con configuración por defecto
        analyzer = HCAnalyzer()

        # Ejecutar análisis
        analyzer.run()

    except Exception as e:
        logger.error(f"Error durante el procesamiento: {e}", exc_info=True)
        sys.exit(1)


if __name__ == "__main__":
    main()
