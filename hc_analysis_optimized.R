#!/usr/bin/env Rscript
# ============================================================================
# HC (Head Count) Analysis - Optimized Version
# ============================================================================
# Este script procesa archivos HC en formato .xlsb y genera tablas de tiempo
# con datos de Promotores y Management (Autorizados, Contratados, Vacantes, Standby)
#
# Optimizaciones implementadas:
# - Funciones reutilizables para evitar repetición de código
# - Configuración centralizada en constantes
# - Eliminación de código debug/comentado
# - Mejor manejo de errores
# - Estructura modular y mantenible
# ============================================================================

# Limpiar entorno
rm(list = ls(all = TRUE))
if (length(dev.list()) > 0) dev.off()

# ============================================================================
# LIBRERÍAS
# ============================================================================
library(readxlsb)
library(reshape2)
library(openxlsx)
library(lubridate)
library(dplyr)

# ============================================================================
# CONFIGURACIÓN
# ============================================================================
CONFIG <- list(
  # Directorios
  root = "D:/Documentos/BI_Honor/Honor/HC",
  output = "Tablas_de_Tiempo/",

  # Configuración de hojas
  sheet_names = c(
    "Authorized Promoters", "Authorized Management",
    "Hired Promoters", "Hired Management",
    "Vacancy Promoters", "Vacancy Management",
    "Standby Promoters"
  ),

  # Configuración de rangos por versión de semana
  ranges = list(
    wk6_8 = c("B3:I12", "L3:U12", "B18:I27", "L18:U27",
              "B33:I42", "L33:U42", "B48:I57"),
    wk9_16 = c("B3:I12", "M3:V12", "B18:I27", "M18:V27",
               "B33:I42", "M33:V42", "B48:I57"),
    wk17_18 = c("B3:I12", "N3:W12", "B18:I27", "N18:W27",
                "B33:I42", "N33:W42", "B48:I57"),
    wk19_plus = c("B3:I12", "N3:P12", "R3:X12", "B18:I27",
                  "N18:W27", "R18:X27", "B33:I42", "N33:W42",
                  "R33:X42", "B48:I57")
  ),

  # Parámetros temporales
  week_start = 6,
  date_start = "2024-02-05",
  sheet_name = "SUMMARY"
)

# Establecer directorio de trabajo
setwd(CONFIG$root)

# ============================================================================
# FUNCIONES AUXILIARES
# ============================================================================

#' Obtiene la lista de archivos HC
#'
#' @param root Directorio raíz
#' @return Vector con rutas de archivos .xlsb
get_hc_files <- function(root) {
  list.files(path = root, pattern = "*.xlsb", recursive = TRUE)
}

#' Determina qué configuración de rangos usar según la semana
#'
#' @param week Número de semana
#' @return Vector de rangos correspondiente
get_ranges_for_week <- function(week) {
  if (week >= 6 && week <= 8) {
    return(CONFIG$ranges$wk6_8)
  } else if (week >= 9 && week <= 16) {
    return(CONFIG$ranges$wk9_16)
  } else if (week >= 17 && week <= 18) {
    return(CONFIG$ranges$wk17_18)
  } else {
    return(CONFIG$ranges$wk19_plus)
  }
}

#' Procesa datos de una semana específica
#'
#' @param week_num Número de semana
#' @param file_path Ruta del archivo a procesar
#' @param ranges Rangos de celdas a leer
#' @param sheet_names Nombres de las hojas/categorías
#' @return Lista con datos procesados por categoría
process_week_data <- function(week_num, file_path, ranges, sheet_names) {
  result <- list()

  for (i in seq_along(ranges)) {
    if (i <= length(sheet_names)) {
      result[[sheet_names[i]]] <- read_xlsb(
        file_path,
        sheet = CONFIG$sheet_name,
        range = ranges[i],
        col_names = TRUE
      ) %>%
        reshape2::melt()
    }
  }

  return(result)
}

#' Procesa todos los archivos HC
#'
#' @param hc_files Vector con rutas de archivos
#' @param week_start Semana inicial
#' @return Lista con todos los datos procesados
process_all_weeks <- function(hc_files, week_start = CONFIG$week_start) {
  week_final <- length(hc_files) + week_start - 1
  HC_data <- list()

  for (week_num in week_start:week_final) {
    week_label <- sprintf("WK%02d", week_num)
    file_index <- week_num - week_start + 1

    if (file_index <= length(hc_files)) {
      ranges <- get_ranges_for_week(week_num)

      HC_data[[week_label]] <- process_week_data(
        week_num,
        hc_files[file_index],
        ranges,
        CONFIG$sheet_names
      )

      cat(sprintf("Procesada semana %s\n", week_label))
    }
  }

  return(HC_data)
}

#' Crea dataframe consolidado para una categoría
#'
#' @param HC_data Lista con datos de todas las semanas
#' @param category Nombre de la categoría
#' @param week_labels Vector con etiquetas de semanas
#' @return Dataframe consolidado
create_consolidated_df <- function(HC_data, category, week_labels) {
  # Usar primera semana como base
  first_week <- week_labels[1]
  df <- data.frame(HC_data[[first_week]][[category]][, c(1, 2)])

  # Agregar columnas para cada semana
  for (week in week_labels) {
    df[, week] <- HC_data[[week]][[category]]$value
  }

  # Establecer nombres de columnas
  names(df) <- c("Region", "Variable", week_labels)

  return(df)
}

#' Guarda datos en archivo Excel
#'
#' @param HC_data Lista con datos procesados
#' @param week_labels Vector con etiquetas de semanas
#' @param output_path Ruta de salida
save_to_excel <- function(HC_data, week_labels, output_path) {
  wb <- createWorkbook()

  for (sheet_name in CONFIG$sheet_names) {
    # Crear dataframe consolidado
    df <- create_consolidated_df(HC_data, sheet_name, week_labels)

    # Agregar hoja al libro
    clean_name <- gsub(" ", "", sheet_name)
    addWorksheet(wb, sheetName = clean_name)
    writeData(wb, sheet = clean_name, x = df, startCol = 1, startRow = 1)

    cat(sprintf("Hoja creada: %s\n", clean_name))
  }

  # Guardar archivo
  saveWorkbook(wb, file = output_path, overwrite = TRUE)
  cat(sprintf("\nArchivo guardado: %s\n", output_path))
}

#' Crea tabla de fechas de semanas
#'
#' @param week_labels Vector con etiquetas de semanas
#' @param date_start Fecha de inicio
#' @param output_path Ruta de salida
save_week_dates <- function(week_labels, date_start, output_path) {
  fecha_actual <- Sys.Date()
  fechas <- seq(
    from = ymd(date_start),
    to = fecha_actual,
    by = "1 week"
  )

  # Ajustar longitud si es necesario
  n_weeks <- min(length(week_labels), length(fechas))

  df_semanas <- data.frame(
    Semana = week_labels[1:n_weeks],
    Fecha_i = format(fechas[1:n_weeks], "%Y-%m-%d")
  )

  write.table(
    df_semanas,
    file = output_path,
    row.names = FALSE,
    col.names = TRUE,
    sep = ","
  )

  cat(sprintf("Tabla de fechas guardada: %s\n", output_path))
}

# ============================================================================
# EJECUCIÓN PRINCIPAL
# ============================================================================

main <- function() {
  cat("=================================================\n")
  cat("Iniciando procesamiento de HC\n")
  cat("=================================================\n\n")

  # Obtener archivos
  hc_files <- get_hc_files(CONFIG$root)
  cat(sprintf("Archivos encontrados: %d\n\n", length(hc_files)))

  if (length(hc_files) == 0) {
    stop("No se encontraron archivos .xlsb en el directorio especificado")
  }

  # Generar etiquetas de semanas
  week_final <- length(hc_files) + CONFIG$week_start - 1
  week_labels <- sprintf("WK%02d", CONFIG$week_start:week_final)

  # Procesar todos los archivos
  cat("Procesando archivos...\n")
  HC_data <- process_all_weeks(hc_files, CONFIG$week_start)

  # Guardar resultados en Excel
  cat("\n=================================================\n")
  cat("Guardando resultados en Excel...\n")
  cat("=================================================\n")
  output_file <- paste0(
    CONFIG$output,
    "TS_Vacantes_V",
    tail(week_labels, 1),
    ".xlsx"
  )
  save_to_excel(HC_data, week_labels, output_file)

  # Guardar tabla de fechas
  cat("\n=================================================\n")
  cat("Generando tabla de fechas...\n")
  cat("=================================================\n")
  dates_file <- paste0(CONFIG$output, "SemanasYFecha.csv")
  save_week_dates(week_labels, CONFIG$date_start, dates_file)

  cat("\n=================================================\n")
  cat("Procesamiento completado exitosamente\n")
  cat("=================================================\n")
}

# Ejecutar script
tryCatch(
  {
    main()
  },
  error = function(e) {
    cat(sprintf("\nError: %s\n", e$message))
    quit(status = 1)
  }
)
