#!/usr/bin/env Rscript
# ==============================================================================
# 🔍 HC File Tester - Versión Optimizada
# ==============================================================================
# Script para verificar la lectura y validación de archivos Excel de HC
#
# Mejoras de la versión optimizada:
# - Código modularizado con funciones reutilizables
# - Mejor manejo de errores y validaciones
# - Salida más clara y estructurada
# - Parámetros configurables
# - Documentación mejorada
# ==============================================================================

# 📚 Librerías
suppressPackageStartupMessages({
  library(readxl)
})

# ⚙️ CONFIGURACIÓN
# ==============================================================================
RUTA_BASE <- "C:/Users/FROJAS/Documents/HonorBI/Sales_report/HC_WK/HC_Weekend/HC_Comparador/CodigoHC_Testeador_Columnas_Codigo_Comparador_HCs_2025/"
ARCHIVO_W26 <- paste0(RUTA_BASE, "HC_W26.xlsx")
NOMBRE_HOJA <- "FF"
NUM_PREVIEW <- 5  # Filas/columnas para preview


# 🔧 FUNCIONES AUXILIARES
# ==============================================================================

#' Imprime encabezado de sección
#' @param texto Texto del encabezado
imprimir_seccion <- function(texto) {
  cat("\n")
  cat(strrep("=", 70), "\n")
  cat(texto, "\n")
  cat(strrep("=", 70), "\n\n")
}

#' Imprime subsección
#' @param numero Número de la subsección
#' @param texto Texto descriptivo
imprimir_subseccion <- function(numero, texto) {
  cat(sprintf("\n%d. %s\n", numero, texto))
  cat(strrep("-", 50), "\n")
}

#' Verifica existencia de archivo
#' @param ruta Ruta del archivo
#' @return TRUE si existe, FALSE y detiene ejecución si no
verificar_archivo <- function(ruta) {
  if (file.exists(ruta)) {
    cat(sprintf("✓ Archivo encontrado: %s\n", basename(ruta)))
    return(TRUE)
  } else {
    cat(sprintf("✗ ERROR: Archivo NO encontrado\n"))
    cat(sprintf("   Ruta buscada: %s\n", ruta))
    stop("No se puede continuar sin el archivo", call. = FALSE)
  }
}

#' Lee datos crudos del Excel
#' @param archivo Ruta del archivo
#' @param hoja Nombre de la hoja
#' @param max_filas Número máximo de filas a leer
#' @return DataFrame con datos crudos
leer_datos_raw <- function(archivo, hoja, max_filas = 10) {
  datos <- read_excel(
    archivo,
    sheet = hoja,
    col_names = FALSE,
    n_max = max_filas
  )
  return(datos)
}

#' Muestra dimensiones del dataset
#' @param datos DataFrame
mostrar_dimensiones <- function(datos) {
  cat(sprintf("   📊 Dimensiones: %d filas × %d columnas\n",
              nrow(datos), ncol(datos)))
}

#' Muestra preview del dataset
#' @param datos DataFrame
#' @param n_filas Número de filas a mostrar
#' @param n_cols Número de columnas a mostrar
mostrar_preview <- function(datos, n_filas = 5, n_cols = 5) {
  cat(sprintf("\n   Vista previa (%dx%d):\n\n", n_filas, n_cols))

  # Limitar a las dimensiones del dataset
  n_filas <- min(n_filas, nrow(datos))
  n_cols <- min(n_cols, ncol(datos))

  print(datos[1:n_filas, 1:n_cols])
}

#' Busca fila con headers
#' @param datos DataFrame
#' @param patron Patrón a buscar (por defecto "Customer")
#' @return Número de fila donde se encuentra el header
buscar_headers <- function(datos, patron = "Customer") {
  cat(sprintf("   Buscando patrón: '%s'\n", patron))

  fila_encontrada <- NULL

  for (i in 1:nrow(datos)) {
    fila <- unlist(datos[i, ])

    if (any(grepl(patron, fila, ignore.case = TRUE))) {
      cat(sprintf("   ✓ Header encontrado en fila %d\n", i))

      # Mostrar primeros elementos no vacíos
      elementos <- head(fila[!is.na(fila)], 10)
      cat("   Primeros elementos: ")
      cat(paste(elementos, collapse = " | "), "\n")

      if (is.null(fila_encontrada)) {
        fila_encontrada <- i
      }
    }
  }

  if (is.null(fila_encontrada)) {
    cat(sprintf("   ⚠️  No se encontró el patrón '%s'\n", patron))
  }

  return(fila_encontrada)
}

#' Lee datos con headers
#' @param archivo Ruta del archivo
#' @param hoja Nombre de la hoja
#' @param skip Número de filas a saltar
#' @return DataFrame con headers
leer_con_headers <- function(archivo, hoja, skip = 1) {
  datos <- read_excel(
    archivo,
    sheet = hoja,
    skip = skip
  )
  return(datos)
}

#' Muestra información de columnas
#' @param datos DataFrame
#' @param max_cols Máximo de columnas a mostrar
mostrar_columnas <- function(datos, max_cols = 10) {
  nombres <- names(datos)
  n_cols <- min(max_cols, length(nombres))

  cat(sprintf("   Primeras %d columnas:\n", n_cols))
  for (i in 1:n_cols) {
    cat(sprintf("      %2d. %s\n", i, nombres[i]))
  }

  if (length(nombres) > max_cols) {
    cat(sprintf("      ... (%d columnas más)\n", length(nombres) - max_cols))
  }
}

#' Analiza columna ID
#' @param datos DataFrame
analizar_columna_id <- function(datos) {
  if ("ID" %in% names(datos)) {
    # Contar IDs válidos
    ids_validos <- !is.na(datos$ID) & datos$ID != ""
    n_validos <- sum(ids_validos, na.rm = TRUE)

    cat(sprintf("   ✓ Columna 'ID' encontrada\n"))
    cat(sprintf("   📊 Registros con ID válido: %d / %d (%.1f%%)\n",
                n_validos, nrow(datos),
                100 * n_validos / nrow(datos)))

    # Muestra de IDs
    cat("\n   Muestra de IDs (primeros 10 válidos):\n")
    ids_muestra <- head(datos$ID[ids_validos], 10)
    for (i in seq_along(ids_muestra)) {
      cat(sprintf("      %2d. %s\n", i, ids_muestra[i]))
    }

  } else {
    cat("   ⚠️  Columna 'ID' NO encontrada\n")

    # Buscar columnas similares
    cols_con_id <- grep("ID", names(datos), value = TRUE, ignore.case = TRUE)

    if (length(cols_con_id) > 0) {
      cat("\n   Columnas que contienen 'ID':\n")
      for (col in cols_con_id) {
        cat(sprintf("      - %s\n", col))
      }
    } else {
      cat("   No se encontraron columnas con 'ID' en el nombre\n")
    }
  }
}


# 🚀 EJECUCIÓN PRINCIPAL
# ==============================================================================

ejecutar_test <- function() {

  imprimir_seccion("🔍 TEST DE LECTURA DE ARCHIVOS HC")

  # 1. Verificar archivo
  imprimir_subseccion(1, "Verificando existencia del archivo")
  verificar_archivo(ARCHIVO_W26)

  # 2. Lectura cruda
  imprimir_subseccion(2, "Lectura preliminar (primeras 10 filas)")
  datos_raw <- leer_datos_raw(ARCHIVO_W26, NOMBRE_HOJA, max_filas = 10)
  mostrar_dimensiones(datos_raw)
  mostrar_preview(datos_raw, NUM_PREVIEW, NUM_PREVIEW)

  # 3. Buscar headers
  imprimir_subseccion(3, "Búsqueda de fila con headers")
  fila_header <- buscar_headers(datos_raw, patron = "Customer")

  # 4. Leer con headers
  skip_filas <- if (!is.null(fila_header)) fila_header - 1 else 1

  imprimir_subseccion(4, sprintf("Lectura con headers (skip = %d)", skip_filas))
  datos_con_headers <- leer_con_headers(ARCHIVO_W26, NOMBRE_HOJA, skip = skip_filas)

  mostrar_dimensiones(datos_con_headers)
  mostrar_columnas(datos_con_headers, max_cols = 10)

  # 5. Preview de datos
  imprimir_subseccion(5, "Vista previa de datos (primeras 3 filas)")
  mostrar_preview(datos_con_headers, n_filas = 3, n_cols = 5)

  # 6. Analizar columna ID
  imprimir_subseccion(6, "Análisis de columna ID")
  analizar_columna_id(datos_con_headers)

  # Resumen final
  imprimir_seccion("✅ TEST COMPLETADO")
  cat(sprintf("Total de registros procesados: %d\n", nrow(datos_con_headers)))
  cat(sprintf("Total de columnas identificadas: %d\n", ncol(datos_con_headers)))

  invisible(datos_con_headers)
}

# Ejecutar test
if (!interactive()) {
  resultado <- ejecutar_test()
} else {
  cat("Script cargado. Ejecuta: resultado <- ejecutar_test()\n")
}
