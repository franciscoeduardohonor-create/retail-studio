#!/usr/bin/env python3
"""
Honor Sales Report Analysis - Optimized Python Version

Description: Combines and analyzes sales data from QuantityVerify and
             SeriaList Excel files, applies corrections, and generates
             consolidated reports.

Author: Optimized version
Date: 2025-11-23
"""

import os
import glob
import warnings
from datetime import datetime
from typing import List, Dict, Optional
import pandas as pd
import numpy as np
from pathlib import Path

# Suppress warnings for cleaner output
warnings.filterwarnings('ignore')


class SalesReportAnalyzer:
    """
    Class to handle Honor Sales Report analysis and consolidation.
    """

    def __init__(self, config: Dict):
        """
        Initialize the analyzer with configuration.

        Args:
            config: Dictionary with configuration parameters
        """
        self.config = config
        self.root_path = os.path.join(config['root'], config['sales_path'])
        self.region_path = os.path.join(self.root_path, config['region'].lstrip('/'))

        # Set working directory
        os.chdir(self.root_path)

    def optimizar_lectura(self, base_pattern: str) -> pd.DataFrame:
        """
        Read and merge Excel files incrementally to avoid duplicates.

        Args:
            base_pattern: File pattern to search for

        Returns:
            DataFrame with merged records
        """
        # Get list of files
        search_path = os.path.join(self.region_path, f"*{base_pattern}*")
        archivos = sorted(glob.glob(search_path))

        if not archivos:
            raise FileNotFoundError(f"No files found for pattern: {base_pattern}")

        print(f"\nProcessing {len(archivos)} files for {base_pattern}")

        # Read first file to initialize
        df_todos = pd.read_excel(archivos[0], sheet_name=0)
        df_todos['Upload Time(Local)'] = pd.to_datetime(
            df_todos['Upload Time(Local)'],
            format='%Y-%m-%d %H:%M:%S',
            errors='coerce'
        )

        # Remove inconsistent columns
        cols_to_remove = [col for col in self.config['columns_to_remove']
                         if col in df_todos.columns]
        if cols_to_remove:
            df_todos = df_todos.drop(columns=cols_to_remove)

        # Sort by date
        df_todos = df_todos.sort_values('Upload Time(Local)').reset_index(drop=True)

        # Process remaining files
        for k, archivo in enumerate(archivos[1:], start=2):
            ultima_fecha = df_todos['Upload Time(Local)'].max()

            # Read new file
            df_temp = pd.read_excel(archivo, sheet_name=0)
            df_temp['Upload Time(Local)'] = pd.to_datetime(
                df_temp['Upload Time(Local)'],
                format='%Y-%m-%d %H:%M:%S',
                errors='coerce'
            )

            # Remove inconsistent columns
            cols_to_remove = [col for col in self.config['columns_to_remove']
                             if col in df_temp.columns]
            if cols_to_remove:
                df_temp = df_temp.drop(columns=cols_to_remove)

            # Sort by date
            df_temp = df_temp.sort_values('Upload Time(Local)').reset_index(drop=True)

            # Find last date index
            i_ultima_fecha = df_temp[df_temp['Upload Time(Local)'] == ultima_fecha].index

            if len(i_ultima_fecha) == 0:
                # If date not found, add all records
                registros_faltantes = df_temp.index
            else:
                # Take the last occurrence
                i_ultima_fecha = i_ultima_fecha[-1]

                # Check if dates are in ascending order
                if i_ultima_fecha > 0:
                    comparacion_fecha = (
                        df_temp.loc[i_ultima_fecha - 1, 'Upload Time(Local)'] <=
                        df_temp.loc[i_ultima_fecha, 'Upload Time(Local)']
                    )
                else:
                    comparacion_fecha = True

                if comparacion_fecha:
                    # Add records after the last date
                    if i_ultima_fecha < len(df_temp) - 1:
                        registros_faltantes = df_temp.index[i_ultima_fecha + 1:]
                    else:
                        registros_faltantes = []
                else:
                    # Dates in descending order, take records before
                    registros_faltantes = df_temp.index[:i_ultima_fecha]
                    print(f"\nWarning: Descending dates in file {os.path.basename(archivo)}")

            # Append new records
            if len(registros_faltantes) > 0:
                df_todos = pd.concat([df_todos, df_temp.loc[registros_faltantes]],
                                    ignore_index=True)

            # Progress indicator
            if k % 5 == 0:
                print(f"  Processed {k}/{len(archivos)} files...")

        print(f"Total records: {len(df_todos)}")

        return df_todos

    def standardize_names(self, df: pd.DataFrame) -> pd.DataFrame:
        """
        Standardize column names by replacing spaces and parentheses with dots.

        Args:
            df: DataFrame with original column names

        Returns:
            DataFrame with standardized column names
        """
        df.columns = df.columns.str.replace(r'[ ()]', '.', regex=True)
        return df

    def process_quantity_verify(self, df: pd.DataFrame) -> pd.DataFrame:
        """
        Process QuantityVerify data.

        Args:
            df: Raw QuantityVerify DataFrame

        Returns:
            Processed DataFrame
        """
        df = self.standardize_names(df)

        columns = [
            'CBG.Region', 'Province', 'City', 'Store.Code', 'Store.Name',
            'Store.Monthly.Capacity', 'Sales.Person.Duty', 'Sales.Account',
            'Sales.Person.Name', 'Sales.Position', 'Sales.Date', 'City.Manager',
            'Supervisor.Name', 'Category', 'Series', 'Marketing.Name', 'Color',
            'Sales.Volume', 'Upload.Time.Local.'
        ]

        df_processed = df[columns].copy()

        # Add missing columns
        df_processed['SN/IMEI.Check.Status'] = np.nan
        df_processed['Hota.Check.Status'] = np.nan
        df_processed['HOTA.Activation.time.quantum'] = np.nan
        df_processed['Reported.By.Other'] = np.nan

        return df_processed

    def process_serial_list(self, df: pd.DataFrame) -> pd.DataFrame:
        """
        Process SeriaList data.

        Args:
            df: Raw SeriaList DataFrame

        Returns:
            Processed DataFrame with standardized column names
        """
        df_orig = df.copy()
        df = self.standardize_names(df)

        columns = [
            'MSS.Region', 'Province', 'City', 'Store.Code', 'Store.Name',
            'Store.Monthly.Capacity', 'Sales.Person.Duty', 'Sales.Account',
            'Sales.Person.Name', 'Sales.person..position', 'Sales.Date',
            'City.Manager.Name', 'Supervisor.Name', 'Category', 'Series',
            'MKT.Name', 'Color'
        ]

        df_processed = df[columns].copy()

        # Add Sales.Volume (always 1 for SeriaList)
        df_processed['Sales.Volume'] = 1

        # Add Upload.Time.Local
        df_processed['Upload.Time.Local.'] = df['Upload.Time.Local.']

        # Add verification status columns
        df_processed['SN/IMEI.Check.Status'] = df.get('SN/IMEI.Verification.Status', np.nan)
        df_processed['Hota.Check.Status'] = df.get('Hota.Verification.Status', np.nan)
        df_processed['HOTA.Activation.time.quantum'] = df.get('HOTA.Activation.Time.Range', np.nan)
        df_processed['Reported.By.Other'] = df.get('Uploaded.By.Others', np.nan)

        # Rename columns to match QuantityVerify
        column_mapping = {
            'MSS.Region': 'CBG.Region',
            'Sales.person..position': 'Sales.Position',
            'City.Manager.Name': 'City.Manager',
            'MKT.Name': 'Marketing.Name'
        }

        df_processed = df_processed.rename(columns=column_mapping)

        return df_processed

    def apply_corrections(self, df: pd.DataFrame) -> pd.DataFrame:
        """
        Apply data corrections to the combined dataset.

        Args:
            df: Combined DataFrame

        Returns:
            Corrected DataFrame
        """
        print("\nApplying data corrections...")

        # 1. Filter sales volume >= 10 for Sales Advisors
        mask = (df['Sales.Volume'] >= self.config['max_sales_volume']) & \
               (df['Sales.Person.Duty'] == 'Sales Advisor')
        df.loc[mask, 'Sales.Volume'] = 0

        # 2. Fix Magic 6 Pro -> Magic 6 Lite for dates before April 2024
        mask = (df['Marketing.Name'] == "HONOR Magic6 Pro") & \
               (df['Sales.Date'] < self.config['magic6_lite_cutoff_date'])
        count = mask.sum()
        if count > 0:
            df.loc[mask, 'Marketing.Name'] = "HONOR Magic6 Lite 5G"
            print(f"  - Corrected {count} Magic6 Pro -> Lite records")

        # 3. Standardize product names
        df['Marketing.Name'] = df['Marketing.Name'].str.replace(
            "HONOR Magic6 Lite 5G", "HONOR Magic6 Lite", regex=False
        )
        df['Marketing.Name'] = df['Marketing.Name'].str.replace(
            "HONOR Magic5 Lite 5G", "HONOR Magic5 Lite", regex=False
        )
        df['Marketing.Name'] = df['Marketing.Name'].str.upper()

        # 4. Fix supervisor names
        df['Supervisor.Name'] = df['Supervisor.Name'].str.replace(
            "BARRAZA NAVARRETE ANWAR ALEJAN,COLMENARES JOACHIN OSCAR JAVIE",
            "BARRAZA NAVARRETE ANWAR ALEJAN",
            regex=False
        )

        # 5. Fix region for specific supervisor
        mask = df['Supervisor.Name'] == "VEGA LEON ALFREDO JESUS"
        if mask.any():
            df.loc[mask, 'Region'] = "R1"

        # 6. Clean City Manager names (remove text after comma)
        df['City.Manager'] = df['City.Manager'].str.split(',').str[0]

        # 7. Fix specific City Manager
        mask = df['City.Manager'] == "MARTINEZ HORI LAURA"
        if mask.any():
            df.loc[mask, 'City.Manager'] = np.nan

        # 8. December 2024 Magic6 Lite correction for Telcel stores
        mask = (df['Marketing.Name'] == "HONOR MAGIC6 LITE") & \
               (df['Mes'] == 12) & \
               (df['Sales.Person.Duty'] == "Sales Advisor") & \
               (df['Store.Name'].str.contains("TELCEL", case=False, na=False))
        count = mask.sum()
        if count > 0:
            df.loc[mask, 'Sales.Volume'] = df.loc[mask, 'Sales.Volume'] * 2
            print(f"  - Doubled sales for {count} Telcel Magic6 Lite records in December")

        return df

    def add_targets(self, df: pd.DataFrame, targets_path: str) -> pd.DataFrame:
        """
        Add sales targets to the dataset.

        Args:
            df: Main DataFrame
            targets_path: Path to targets CSV file

        Returns:
            DataFrame with targets added
        """
        if not os.path.exists(targets_path):
            print(f"Warning: Targets file not found: {targets_path}")
            df['Target'] = np.nan
            return df

        print("\nAdding targets...")
        df_targets = pd.read_csv(targets_path)

        df['Target'] = np.nan

        for _, row in df_targets.iterrows():
            mask = (df['Store.Code'] == row['ID.Honor.']) & (df['Mes'] == row['Mes'])
            df.loc[mask, 'Target'] = row['Target']

        count = df['Target'].notna().sum()
        print(f"  - Added targets for {count} records")

        return df

    def update_capa(self, df: pd.DataFrame, capa_path: str) -> pd.DataFrame:
        """
        Update CAPA (store capacity) from external file.

        Args:
            df: Main DataFrame
            capa_path: Path to CAPA CSV file

        Returns:
            DataFrame with updated CAPA values
        """
        if not os.path.exists(capa_path):
            print(f"Warning: CAPA file not found: {capa_path}")
            return df

        print("\nUpdating CAPA (store capacity)...")
        df_capa = pd.read_csv(capa_path)

        stores_updated = 0

        for _, row in df_capa.iterrows():
            mask = df['Store.Code'] == row['ID_Honor']
            if mask.any():
                df.loc[mask, 'Store.Monthly.Capacity'] = row['Mean']
                stores_updated += 1

        print(f"  - Updated CAPA for {stores_updated} stores")

        return df

    def run(self) -> pd.DataFrame:
        """
        Execute the complete analysis pipeline.

        Returns:
            Final processed DataFrame
        """
        tiempo_inicio = datetime.now()

        print("\n" + "=" * 80)
        print("  HONOR SALES REPORT ANALYSIS - OPTIMIZED PYTHON VERSION")
        print("=" * 80)

        print(f"\nWorking directory: {os.getcwd()}")
        print(f"Region: {self.config['region']}")

        # STEP 1: Read and merge incremental files
        print("\n" + "=" * 80)
        print("  STEP 1: Reading and merging files")
        print("=" * 80)

        df_QV = self.optimizar_lectura(self.config['quantity_verify_pattern'])
        df_SL = self.optimizar_lectura(self.config['serial_list_pattern'])

        # STEP 2: Process and standardize data
        print("\n" + "=" * 80)
        print("  STEP 2: Processing and standardizing data")
        print("=" * 80)

        df_QV_processed = self.process_quantity_verify(df_QV)
        df_SL_processed = self.process_serial_list(df_SL)

        print(f"QuantityVerify records: {len(df_QV_processed)}")
        print(f"SerialList records: {len(df_SL_processed)}")

        # Combine both datasets
        df_combined = pd.concat([df_QV_processed, df_SL_processed], ignore_index=True)

        # Format dates and numeric fields
        df_combined['Upload.Time.Local.'] = pd.to_datetime(
            df_combined['Upload.Time.Local.'],
            format='%Y-%m-%d %H:%M:%S',
            errors='coerce'
        )
        df_combined['Sales.Date'] = pd.to_datetime(df_combined['Sales.Date'], errors='coerce')
        df_combined['Sales.Volume'] = pd.to_numeric(df_combined['Sales.Volume'], errors='coerce')

        # Sort by upload time
        df_combined = df_combined.sort_values('Upload.Time.Local.').reset_index(drop=True)

        # Add region and month
        df_combined['Region'] = df_combined['CBG.Region'].str.replace('Region', 'R', regex=False)
        df_combined = df_combined.drop(columns=['CBG.Region'])
        df_combined['Mes'] = df_combined['Sales.Date'].dt.month

        print(f"Combined records: {len(df_combined)}")

        # Save intermediate file
        intermediate_file = os.path.join(self.region_path, "All", "Z_SalesReport_ALL.csv")
        os.makedirs(os.path.dirname(intermediate_file), exist_ok=True)
        df_combined.to_csv(intermediate_file, index=False)
        print(f"Intermediate file saved: {intermediate_file}")

        # STEP 3: Merge with historical data
        print("\n" + "=" * 80)
        print("  STEP 3: Merging with historical data")
        print("=" * 80)

        historical_file = os.path.join(self.region_path, "All", "SalesReport_All_ALL_ene-oct.csv")

        if os.path.exists(historical_file):
            df_historical = pd.read_csv(historical_file)

            # Remove Target column if exists
            if 'Target' in df_historical.columns:
                df_historical = df_historical.drop(columns=['Target'])

            # Format dates
            df_historical['Upload.Time.Local.'] = pd.to_datetime(
                df_historical['Upload.Time.Local.'],
                format='%d/%m/%Y %H:%M',
                errors='coerce'
            )
            df_historical['Upload.Time.Local.'] = df_historical['Upload.Time.Local.'].dt.strftime(
                '%Y-%m-%d %H:%M:%S'
            )
            df_historical['Sales.Date'] = pd.to_datetime(
                df_historical['Sales.Date'],
                format='%d/%m/%Y',
                errors='coerce'
            )
            df_historical['Sales.Date'] = df_historical['Sales.Date'].dt.strftime('%Y-%m-%d')

            # Convert back to datetime for proper handling
            df_historical['Upload.Time.Local.'] = pd.to_datetime(
                df_historical['Upload.Time.Local.']
            )
            df_historical['Sales.Date'] = pd.to_datetime(df_historical['Sales.Date'])

            # Combine with new data
            df_all = pd.concat([df_historical, df_combined], ignore_index=True)
            df_all = df_all.sort_values('Upload.Time.Local.').reset_index(drop=True)

            print(f"Historical records: {len(df_historical)}")
            print(f"Total records after merge: {len(df_all)}")
        else:
            print(f"Warning: Historical file not found: {historical_file}")
            df_all = df_combined

        # STEP 4: Apply corrections
        print("\n" + "=" * 80)
        print("  STEP 4: Applying data corrections")
        print("=" * 80)

        df_all = self.apply_corrections(df_all)

        # STEP 5: Add targets and CAPA
        print("\n" + "=" * 80)
        print("  STEP 5: Adding targets and CAPA")
        print("=" * 80)

        targets_file = os.path.join(self.root_path, "Targets", "Targets_ALL.csv")
        df_all = self.add_targets(df_all, targets_file)

        capa_file = os.path.join(self.root_path, "Telcel", "Capa.csv")
        df_all = self.update_capa(df_all, capa_file)

        # STEP 6: Save final output
        print("\n" + "=" * 80)
        print("  STEP 6: Saving final output")
        print("=" * 80)

        output_file = os.path.join(self.root_path, "SalesReport_All_ALL.csv")
        df_all.to_csv(output_file, index=False)

        tiempo_fin = datetime.now()
        tiempo_transcurrido = (tiempo_fin - tiempo_inicio).total_seconds()

        # Summary
        print("\n" + "=" * 80)
        print("  SUMMARY")
        print("=" * 80)
        print(f"Total records: {len(df_all)}")
        print(f"Date range: {df_all['Sales.Date'].min()} to {df_all['Sales.Date'].max()}")
        print(f"Last update: {df_all['Upload.Time.Local.'].max()}")
        print(f"Output file: {output_file}")
        print(f"Execution time: {tiempo_transcurrido:.2f} seconds")
        print("=" * 80)
        print()

        return df_all


def main():
    """Main execution function."""

    # Configuration
    CONFIG = {
        'root': "C:/Users/FROJAS/Documents/",
        'sales_path': "HonorBI/Sales_report/",
        'region': "/RAll",

        # Column mappings
        'columns_to_remove': [
            'Back Cover SN', 'Back Cover Photo',
            'Human Judgement Result', 'Valid Sales'
        ],

        # Data corrections
        'max_sales_volume': 10,
        'magic6_lite_cutoff_date': pd.Timestamp('2024-04-01'),

        # File patterns
        'quantity_verify_pattern': 'QuantityVerify',
        'serial_list_pattern': 'SeriaList'
    }

    # Create analyzer instance and run
    analyzer = SalesReportAnalyzer(CONFIG)
    df_result = analyzer.run()

    return df_result


if __name__ == "__main__":
    main()
