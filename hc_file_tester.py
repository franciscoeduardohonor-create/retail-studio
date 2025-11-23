#!/usr/bin/env python3
"""
🔍 HC File Tester - Versión Python
==================================
Script para verificar la lectura y validación de archivos Excel de HC

Mejoras de la versión optimizada:
- Código modularizado con funciones reutilizables
- Mejor manejo de errores y validaciones
- Salida más clara y estructurada
- Type hints para mejor documentación
- Logging estructurado
"""

from pathlib import Path
from typing import Optional, Tuple
import pandas as pd
import sys


# ⚙️ CONFIGURACIÓN
# =============================================================================
RUTA_BASE = Path(r"C:/Users/FROJAS/Documents/HonorBI/Sales_report/HC_WK/HC_Weekend/HC_Comparador/CodigoHC_Testeador_Columnas_Codigo_Comparador_HCs_2025")
ARCHIVO_W26 = RUTA_BASE / "HC_W26.xlsx"
NOMBRE_HOJA = "FF"
NUM_PREVIEW = 5  # Filas/columnas para preview


# 🎨 UTILIDADES DE FORMATO
# =============================================================================

def imprimir_seccion(texto: str) -> None:
    """Imprime encabezado de sección."""
    print("\n" + "=" * 70)
    print(texto)
    print("=" * 70 + "\n")


def imprimir_subseccion(numero: int, texto: str) -> None:
    """Imprime subsección numerada."""
    print(f"\n{numero}. {texto}")
    print("-" * 50)


# 🔧 FUNCIONES DE PROCESAMIENTO
# =============================================================================

def verificar_archivo(ruta: Path) -> bool:
    """
    Verifica la existencia de un archivo.

    Args:
        ruta: Path del archivo a verificar

    Returns:
        True si existe

    Raises:
        SystemExit: Si el archivo no existe
    """
    if ruta.exists():
        print(f"✓ Archivo encontrado: {ruta.name}")
        return True
    else:
        print("✗ ERROR: Archivo NO encontrado")
        print(f"   Ruta buscada: {ruta}")
        sys.exit(1)


def leer_datos_raw(
    archivo: Path,
    hoja: str,
    max_filas: int = 10
) -> pd.DataFrame:
    """
    Lee datos crudos del Excel sin procesar headers.

    Args:
        archivo: Ruta del archivo Excel
        hoja: Nombre de la hoja
        max_filas: Número máximo de filas a leer

    Returns:
        DataFrame con datos crudos
    """
    return pd.read_excel(
        archivo,
        sheet_name=hoja,
        header=None,
        nrows=max_filas
    )


def mostrar_dimensiones(datos: pd.DataFrame) -> None:
    """Muestra las dimensiones del dataset."""
    filas, cols = datos.shape
    print(f"   📊 Dimensiones: {filas} filas × {cols} columnas")


def mostrar_preview(
    datos: pd.DataFrame,
    n_filas: int = 5,
    n_cols: int = 5
) -> None:
    """
    Muestra preview del dataset.

    Args:
        datos: DataFrame a mostrar
        n_filas: Número de filas
        n_cols: Número de columnas
    """
    print(f"\n   Vista previa ({n_filas}x{n_cols}):\n")

    # Limitar a las dimensiones disponibles
    n_filas = min(n_filas, len(datos))
    n_cols = min(n_cols, len(datos.columns))

    preview = datos.iloc[:n_filas, :n_cols]

    # Formatear para mejor visualización
    pd.set_option('display.max_columns', n_cols)
    pd.set_option('display.width', 100)
    print(preview.to_string(index=True))
    pd.reset_option('display.max_columns')
    pd.reset_option('display.width')


def buscar_headers(
    datos: pd.DataFrame,
    patron: str = "Customer"
) -> Optional[int]:
    """
    Busca la fila que contiene los headers.

    Args:
        datos: DataFrame donde buscar
        patron: Patrón a buscar en los headers

    Returns:
        Índice de la fila con headers (0-indexed) o None
    """
    print(f"   Buscando patrón: '{patron}'")

    fila_encontrada = None

    for i in range(len(datos)):
        fila = datos.iloc[i].astype(str)

        # Buscar patrón (case insensitive)
        if fila.str.contains(patron, case=False, na=False).any():
            print(f"   ✓ Header encontrado en fila {i + 1} (índice {i})")

            # Mostrar primeros elementos no vacíos
            elementos = fila[fila.notna()].head(10)
            print("   Primeros elementos: " + " | ".join(elementos.values))

            if fila_encontrada is None:
                fila_encontrada = i

    if fila_encontrada is None:
        print(f"   ⚠️  No se encontró el patrón '{patron}'")

    return fila_encontrada


def leer_con_headers(
    archivo: Path,
    hoja: str,
    skip: int = 1
) -> pd.DataFrame:
    """
    Lee datos con headers procesados.

    Args:
        archivo: Ruta del archivo Excel
        hoja: Nombre de la hoja
        skip: Número de filas a saltar antes de los headers

    Returns:
        DataFrame con headers procesados
    """
    return pd.read_excel(
        archivo,
        sheet_name=hoja,
        skiprows=skip
    )


def mostrar_columnas(datos: pd.DataFrame, max_cols: int = 10) -> None:
    """
    Muestra información de las columnas del dataset.

    Args:
        datos: DataFrame
        max_cols: Máximo número de columnas a mostrar
    """
    columnas = datos.columns.tolist()
    n_cols = min(max_cols, len(columnas))

    print(f"   Primeras {n_cols} columnas:")
    for i in range(n_cols):
        print(f"      {i + 1:2d}. {columnas[i]}")

    if len(columnas) > max_cols:
        print(f"      ... ({len(columnas) - max_cols} columnas más)")


def analizar_columna_id(datos: pd.DataFrame) -> None:
    """
    Analiza la columna ID del dataset.

    Args:
        datos: DataFrame a analizar
    """
    if 'ID' in datos.columns:
        # Contar IDs válidos (no nulos y no vacíos)
        ids_validos = datos['ID'].notna() & (datos['ID'] != '')
        n_validos = ids_validos.sum()
        total = len(datos)
        porcentaje = 100 * n_validos / total if total > 0 else 0

        print("   ✓ Columna 'ID' encontrada")
        print(f"   📊 Registros con ID válido: {n_validos} / {total} ({porcentaje:.1f}%)")

        # Muestra de IDs válidos
        ids_muestra = datos.loc[ids_validos, 'ID'].head(10)

        if len(ids_muestra) > 0:
            print("\n   Muestra de IDs (primeros 10 válidos):")
            for i, id_val in enumerate(ids_muestra, 1):
                print(f"      {i:2d}. {id_val}")
        else:
            print("\n   ⚠️  No hay IDs válidos en el dataset")

    else:
        print("   ⚠️  Columna 'ID' NO encontrada")

        # Buscar columnas similares
        cols_con_id = [col for col in datos.columns if 'ID' in str(col).upper()]

        if cols_con_id:
            print("\n   Columnas que contienen 'ID':")
            for col in cols_con_id:
                print(f"      - {col}")
        else:
            print("   No se encontraron columnas con 'ID' en el nombre")


# 🚀 EJECUCIÓN PRINCIPAL
# =============================================================================

def ejecutar_test() -> pd.DataFrame:
    """
    Ejecuta el test completo de lectura del archivo HC.

    Returns:
        DataFrame con los datos procesados
    """
    imprimir_seccion("🔍 TEST DE LECTURA DE ARCHIVOS HC")

    # 1. Verificar archivo
    imprimir_subseccion(1, "Verificando existencia del archivo")
    verificar_archivo(ARCHIVO_W26)

    # 2. Lectura cruda
    imprimir_subseccion(2, "Lectura preliminar (primeras 10 filas)")
    datos_raw = leer_datos_raw(ARCHIVO_W26, NOMBRE_HOJA, max_filas=10)
    mostrar_dimensiones(datos_raw)
    mostrar_preview(datos_raw, NUM_PREVIEW, NUM_PREVIEW)

    # 3. Buscar headers
    imprimir_subseccion(3, "Búsqueda de fila con headers")
    fila_header = buscar_headers(datos_raw, patron="Customer")

    # 4. Leer con headers
    skip_filas = fila_header if fila_header is not None else 1

    imprimir_subseccion(4, f"Lectura con headers (skip = {skip_filas})")
    datos_con_headers = leer_con_headers(ARCHIVO_W26, NOMBRE_HOJA, skip=skip_filas)

    mostrar_dimensiones(datos_con_headers)
    mostrar_columnas(datos_con_headers, max_cols=10)

    # 5. Preview de datos
    imprimir_subseccion(5, "Vista previa de datos (primeras 3 filas)")
    mostrar_preview(datos_con_headers, n_filas=3, n_cols=5)

    # 6. Analizar columna ID
    imprimir_subseccion(6, "Análisis de columna ID")
    analizar_columna_id(datos_con_headers)

    # Resumen final
    imprimir_seccion("✅ TEST COMPLETADO")
    print(f"Total de registros procesados: {len(datos_con_headers)}")
    print(f"Total de columnas identificadas: {len(datos_con_headers.columns)}\n")

    return datos_con_headers


# =============================================================================
# Punto de entrada
# =============================================================================

if __name__ == "__main__":
    try:
        resultado = ejecutar_test()
        print("💾 Datos cargados en variable 'resultado'")
    except Exception as e:
        print(f"\n❌ Error durante la ejecución: {e}")
        sys.exit(1)
