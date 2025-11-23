"""
============================================================================
Optimized Attendance Analysis Script (Python Version)
============================================================================
Author: Honor BI
Description: Processes clock-in/clock-out records for store employees
This is the Python equivalent of attendance_optimized.R
============================================================================
"""

import pandas as pd
import numpy as np
from datetime import datetime, timedelta
import time
import os

# ============================================================================
# CONFIGURATION
# ============================================================================

# Set paths (update these to your local paths)
ROOT = "C:/Users/FROJAS/Documents/HonorBI/Asistencias"
REGION = '/RAll/'
RG = REGION.replace('/', '')

# Set working directory
WORKING_DIR = f"{ROOT}{REGION}"
OUTPUT_DIR = f"{ROOT}{REGION}"

# ============================================================================
# HELPER FUNCTION: Process Attendance
# ============================================================================

def process_attendance(df, duty_type, min_shift_minutes, use_aggregated_checkins=False):
    """
    Process attendance data for a specific duty type

    Args:
        df: Input dataframe
        duty_type: Type of duty (e.g., 'Middle Management', 'Sales Advisor')
        min_shift_minutes: Minimum minutes for a complete shift
        use_aggregated_checkins: If True, aggregate multiple check-ins per day (for Middle Management)

    Returns:
        Processed dataframe with attendance metrics
    """

    df_copy = df.copy()

    if use_aggregated_checkins:
        # For Middle Management: aggregate multiple check-ins per day

        # First, calculate tiempo_tienda (total time in store per day)
        df_copy['tiempo_tienda'] = df_copy.groupby(['Name', 'Date'])['Time in store(Mins)'].transform('sum')

        # Aggregate by Name and Date
        agg_dict = {
            'Account': 'first',
            'Employee ID': 'first',
            'Duty': 'first',
            'Department': 'first',
            'Store': 'first',
            'Area': 'first',
            'Province': 'first',
            'City': 'first',
            'First Check In': 'min',
            'Last Check In': 'max',
            'In Address': 'first',
            'Out Address': 'last',
            'Time in store(Mins)': 'first',
            'tiempo_tienda': 'first'
        }

        df_processed = df_copy.groupby(['Name', 'Date'], as_index=False).agg(agg_dict)

    else:
        # For Sales Advisors: direct calculation
        df_processed = df_copy.copy()
        df_processed['tiempo_tienda'] = df_processed.groupby(['Name', 'Date'])['Time in store(Mins)'].transform('sum')

    # Calculate work time (difference between last check out and first check in)
    df_processed['work_time'] = (
        df_processed['Last Check In'] - df_processed['First Check In']
    ).dt.total_seconds() / 60  # Convert to minutes

    # Calculate Turno_Completo (Complete Shift)
    df_processed['Turno_Completo'] = np.where(
        df_processed['work_time'] >= min_shift_minutes,
        'Yes',
        'No'
    )

    # Calculate Week number (ISO week, adjusted)
    df_processed['Week'] = (
        (df_processed['Date'] - pd.Timedelta(days=1))
        .dt.isocalendar()
        .week
    )

    # Calculate Turno_efectivoMoI6 (Effective shift >= 6 hours)
    if use_aggregated_checkins:
        condition_value = df_processed['work_time']
    else:
        condition_value = df_processed['tiempo_tienda']

    df_processed['Turno_efectivoMoI6'] = np.where(
        condition_value >= 360,
        'Yes',
        'No'
    )

    # Check if there's a final checkout
    df_processed['chekout_final'] = np.where(
        df_processed['Last Check In'].isna(),
        'No',
        'Yes'
    )

    # Calculate unique days and Dias_MoI_6 per week
    week_stats = df_processed.groupby(['Name', 'Week'], as_index=False).agg({
        'Date': 'nunique'
    }).rename(columns={'Date': 'Unique_Days'})

    week_stats['Dias_MoI_6'] = np.where(
        week_stats['Unique_Days'] >= 6,
        'Yes',
        'No'
    )

    # Merge back to main dataframe
    df_final = df_processed.merge(
        week_stats,
        on=['Name', 'Week'],
        how='left'
    )

    return df_final


# ============================================================================
# MAIN EXECUTION
# ============================================================================

def main():
    """Main execution function"""

    # Start timer
    ti = time.time()

    print("=" * 60)
    print("ATTENDANCE ANALYSIS - STARTING")
    print("=" * 60)

    # ========================================================================
    # DATA LOADING
    # ========================================================================

    print("\nLoading data...")

    try:
        # Load Excel file
        df_pasar_lista0 = pd.read_excel(
            os.path.join(WORKING_DIR, "ClockInDailyRecords.xlsx")
        )

        # Select relevant columns (Python uses 0-based indexing)
        columns_to_keep = list(range(0, 8)) + [13] + list(range(16, 22)) + [23, 24, 25, 27]
        df_pasar_lista = df_pasar_lista0.iloc[:, columns_to_keep].copy()

        # Sort by Name
        df_pasar_lista = df_pasar_lista.sort_values('Name').reset_index(drop=True)

        print(f"Loaded {len(df_pasar_lista)} records")

    except FileNotFoundError:
        print(f"ERROR: File not found at {WORKING_DIR}")
        print("Please update the ROOT and REGION paths in the script")
        return
    except Exception as e:
        print(f"ERROR loading data: {str(e)}")
        return

    # ========================================================================
    # DATA PREPROCESSING
    # ========================================================================

    print("Preprocessing data...")

    df_pasar_lista['Date'] = pd.to_datetime(df_pasar_lista['Date']).dt.date
    df_pasar_lista['Date'] = pd.to_datetime(df_pasar_lista['Date'])
    df_pasar_lista['First Check In'] = pd.to_datetime(df_pasar_lista['First Check In'])
    df_pasar_lista['Last Check In'] = pd.to_datetime(df_pasar_lista['Last Check In'])
    df_pasar_lista['Time in store(Mins)'] = pd.to_numeric(
        df_pasar_lista['Time in store(Mins)'],
        errors='coerce'
    )

    # ========================================================================
    # PROCESS MIDDLE MANAGEMENT
    # ========================================================================

    print("\nProcessing Middle Management...")

    duty_sales_advisor = 'Sales Advisor'

    # Filter for non-Sales Advisors
    df_super = df_pasar_lista[
        df_pasar_lista['Duty'] != duty_sales_advisor
    ].copy()

    # Select columns (equivalent to select(1:14, 16, 17, 19))
    cols_super = list(range(0, 14)) + [15, 16, 18]
    df_super = df_super.iloc[:, cols_super]

    # Process with aggregated check-ins (480 minutes = 8 hours)
    df_asistencias = process_attendance(
        df_super,
        duty_type="Middle Management",
        min_shift_minutes=480,
        use_aggregated_checkins=True
    )

    print(f"Completado: Middle Management ({len(df_asistencias)} records)")

    # ========================================================================
    # PROCESS SALES ADVISORS
    # ========================================================================

    print("\nProcessing Sales Advisors...")

    # Filter for Sales Advisors
    df_promotores = df_pasar_lista[
        df_pasar_lista['Duty'] == duty_sales_advisor
    ].copy()

    # Select columns
    df_promotores = df_promotores.iloc[:, cols_super]

    # Process without aggregation (540 minutes = 9 hours)
    df_asistencias_promo = process_attendance(
        df_promotores,
        duty_type="Sales Advisor",
        min_shift_minutes=540,
        use_aggregated_checkins=False
    )

    print(f"Completado: Sales Advisor ({len(df_asistencias_promo)} records)")

    # ========================================================================
    # COMBINE AND EXPORT RESULTS
    # ========================================================================

    print("\nCombining results...")

    df_asistencias_all = pd.concat(
        [df_asistencias, df_asistencias_promo],
        ignore_index=True
    )

    # Add Region column
    df_asistencias_all['Region'] = df_asistencias_all['Area'].str.replace(
        'Region',
        'R',
        regex=False
    )

    # Sort by Name and Date
    df_asistencias_all = df_asistencias_all.sort_values(
        ['Name', 'Date']
    ).reset_index(drop=True)

    # Export to CSV
    output_file = os.path.join(ROOT, "Asistencias_All.csv")
    df_asistencias_all.to_csv(output_file, index=False)

    print(f"Completado: Asistencias_All")
    print(f"File saved to: {output_file}")

    # ========================================================================
    # PERFORMANCE SUMMARY
    # ========================================================================

    tf = time.time()
    duration = tf - ti

    print("\n" + "=" * 60)
    print("EXECUTION SUMMARY")
    print("=" * 60)
    print(f"Total records processed: {len(df_asistencias_all)}")
    print(f"Middle Management: {len(df_asistencias)}")
    print(f"Sales Advisors: {len(df_asistencias_promo)}")
    print(f"Duration: {duration:.2f} seconds")
    print("=" * 60)


# ============================================================================
# KEY OPTIMIZATIONS IMPLEMENTED
# ============================================================================
# 1. Eliminated for loops - replaced with vectorized pandas operations
# 2. Created reusable function to avoid code duplication
# 3. Used groupby().transform() for efficient aggregations
# 4. Used np.where() for vectorized conditional operations
# 5. Used pd.concat() instead of iterative appends for better performance
# 6. Added proper error handling and progress messages
# 7. Clean, readable code structure with docstrings
# ============================================================================

if __name__ == "__main__":
    main()
