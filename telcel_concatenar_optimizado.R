# ==================================================================================
# SCRIPT OPTIMIZADO: Concatenar archivos Telcel con manejo de fechas Excel serial
# Versión optimizada con mejor rendimiento y legibilidad
# ==================================================================================

# Librerías necesarias
library(readxl)
library(dplyr)
library(purrr)
library(openxlsx)
library(lubridate)
library(stringr)

# Configurar directorio de trabajo
# Modificar según necesidad
setwd("C:/Users/FROJAS/Desktop/ArchivosTelcelAnalisisSemanas/SemanasTabletas")

# ==================================================================================
# FUNCIONES OPTIMIZADAS
# ==================================================================================

#' Corregir encoding de texto
#' @param text_vector Vector de texto a corregir
#' @return Vector con encoding corregido
fix_encoding <- function(text_vector) {
  if (is.null(text_vector) || length(text_vector) == 0) return(text_vector)

  text_vector <- as.character(text_vector)

  # Mapeo de correcciones
  corrections <- list(
    # Minúsculas
    "Ã¡" = "á", "Ã©" = "é", "Ã." = "í", "Ã³" = "ó", "Ãº" = "ú", "Ã±" = "ñ",
    # Mayúsculas
    "Ã\u0081" = "Á", "Ã‰" = "É", "Ã\u008D" = "Í", "Ã" = "Ó", "Ãš" = "Ú", "Ã'" = "Ñ",
    # Doble encoding
    "ÃƒÂ¡" = "á", "ÃƒÂ©" = "é", "ÃƒÂ." = "í", "ÃƒÂ³" = "ó", "ÃƒÂº" = "ú", "ÃƒÂ±" = "ñ",
    # Palabras completas
    "RegiÃ³n" = "Región", "DescripciÃ³n" = "Descripción",
    "RegiÃƒÂ³n" = "Región", "DescripciÃƒÂ³n" = "Descripción",
    # Otros
    "Ã¼" = "ü", "Ãœ" = "Ü", "Ã§" = "ç"
  )

  # Aplicar correcciones
  for (pattern in names(corrections)) {
    text_vector <- gsub(pattern, corrections[[pattern]], text_vector, fixed = TRUE)
  }

  text_vector
}

#' Estandarizar nombres de columnas
#' @param df Dataframe con columnas a estandarizar
#' @param verbose Mostrar cambios
#' @return Dataframe con columnas estandarizadas
standardize_columns <- function(df, verbose = FALSE) {
  column_mapping <- c(
    "Region" = "Región", "region" = "Región", "REGION" = "Región",
    "NombreVenta" = "Nombre Venta", "nombreventa" = "Nombre Venta",
    "Nombre_Venta" = "Nombre Venta", "NombredeVenta" = "Nombre Venta",
    "WEEK" = "Week", "WeekNum" = "Week", "weeknum" = "Week", "Semana" = "Week",
    "Descripcion" = "Descripción", "DESCRIPCION" = "Descripción"
  )

  current_names <- fix_encoding(names(df))

  for (i in seq_along(current_names)) {
    if (current_names[i] %in% names(column_mapping)) {
      old_name <- current_names[i]
      new_name <- column_mapping[[current_names[i]]]
      current_names[i] <- new_name
      if (verbose) cat(sprintf("     Renombrando: '%s' → '%s'\n", old_name, new_name))
    }
  }

  names(df) <- current_names
  df
}

#' Convertir número serial de Excel a fecha
#' @param serial_num Número serial de Excel
#' @return Fecha en formato Date
excel_serial_to_date <- function(serial_num) {
  # Excel cuenta días desde 1900-01-01 (con bug de año bisiesto)
  ifelse(serial_num > 59,
         as.Date("1899-12-30") + serial_num,
         as.Date("1899-12-31") + serial_num)
}

#' Procesar columna de fechas
#' @param fecha_values Vector de fechas en diferentes formatos
#' @return Vector de fechas en formato Date
process_dates <- function(fecha_values) {
  fechas_convertidas <- rep(as.Date(NA), length(fecha_values))

  for (i in seq_along(fecha_values)) {
    if (is.na(fecha_values[i]) || fecha_values[i] == "") next

    # Detectar número serial de Excel (5 dígitos)
    if (grepl("^[0-9]{5}$", fecha_values[i])) {
      fechas_convertidas[i] <- excel_serial_to_date(as.numeric(fecha_values[i]))
    } else {
      # Intentar formatos estándar
      fechas_convertidas[i] <- tryCatch({
        as.Date(fecha_values[i], tryFormats = c(
          "%Y-%m-%d", "%d/%m/%Y", "%d-%m-%Y",
          "%Y/%m/%d", "%Y-%m-%d %H:%M:%S"
        ))
      }, error = function(e) NA)
    }
  }

  fechas_convertidas
}

#' Procesar tipos de datos del dataframe
#' @param df Dataframe a procesar
#' @param verbose Mostrar progreso
#' @return Dataframe procesado
process_data_types <- function(df, verbose = FALSE) {
  # Convertir a character para evitar conflictos en bind_rows
  char_cols <- c("Material", "Cantidad", "Importe", "Week", "Venta")
  for (col in char_cols) {
    if (col %in% names(df)) df[[col]] <- as.character(df[[col]])
  }

  # Convertir Fecha a character temporalmente
  if ("Fecha" %in% names(df)) {
    if (inherits(df$Fecha, c("POSIXct", "POSIXt", "Date"))) {
      df$Fecha <- as.character(as.Date(df$Fecha))
    }
  }

  # Procesar columna Week
  if ("Week" %in% names(df)) {
    # Convertir valores numéricos a formato W##
    numeric_idx <- grepl("^[0-9]+$", df$Week)
    if (any(numeric_idx)) {
      df$Week[numeric_idx] <- sprintf("W%02d", as.numeric(df$Week[numeric_idx]))
      if (verbose) cat(sprintf("     Convertidos %d valores numéricos a W##\n", sum(numeric_idx)))
    }

    # Procesar W# a W0#
    w_single <- grepl("^W[0-9]$", df$Week)
    if (any(w_single)) {
      week_nums <- as.numeric(gsub("W", "", df$Week[w_single]))
      df$Week[w_single] <- sprintf("W%02d", week_nums)
      if (verbose) cat(sprintf("     Reformateados %d valores W# a W0#\n", sum(w_single)))
    }
  }

  # Aplicar corrección de encoding a columnas de texto
  df <- df %>% mutate(across(where(is.character), fix_encoding))

  df
}

#' Restaurar tipos numéricos después de combinar
#' @param df Dataframe combinado
#' @return Dataframe con tipos restaurados
restore_numeric_columns <- function(df) {
  # Convertir columnas numéricas
  numeric_cols <- c("Cantidad", "Importe", "Material")
  for (col in numeric_cols) {
    if (col %in% names(df)) df[[col]] <- as.numeric(df[[col]])
  }

  # Procesar fechas
  if ("Fecha" %in% names(df)) {
    cat("   Procesando fechas...\n")
    df$Fecha <- process_dates(df$Fecha)

    fechas_validas <- sum(!is.na(df$Fecha))
    total <- length(df$Fecha)
    cat(sprintf("   Fechas convertidas: %d de %d (%.1f%%)\n",
                fechas_validas, total, (fechas_validas / total) * 100))
  }

  df
}

#' Procesar un archivo Telcel
#' @param file_path Ruta del archivo
#' @param verbose Mostrar progreso
#' @return Lista con data e info del procesamiento
process_telcel_file <- function(file_path, verbose = TRUE) {
  if (verbose) cat(sprintf("\n📂 Procesando: %s\n", basename(file_path)))

  tryCatch({
    # Leer archivo
    sheet_names <- excel_sheets(file_path)
    target_sheet <- sheet_names[1]

    # Buscar hoja con patrón R+números
    r_pattern_sheets <- sheet_names[grepl("^R[0-9]+$", sheet_names)]
    if (length(r_pattern_sheets) > 0) target_sheet <- r_pattern_sheets[1]

    df <- read_excel(file_path, sheet = target_sheet)

    if (verbose) {
      cat(sprintf("   📄 Hoja: '%s' | 📊 %d filas × %d columnas\n",
                  target_sheet, nrow(df), ncol(df)))
    }

    # Estandarizar y procesar
    df <- df %>%
      standardize_columns(verbose = verbose) %>%
      process_data_types(verbose = verbose)

    df$source_file <- basename(file_path)

    if (verbose) cat("   ✅ Procesamiento completado\n")

    list(data = df, filename = basename(file_path), success = TRUE)

  }, error = function(e) {
    if (verbose) cat(sprintf("   ❌ ERROR: %s\n", e$message))
    list(data = NULL, filename = basename(file_path),
         success = FALSE, error = e$message)
  })
}

#' Crear análisis de semanas
#' @param df Dataframe combinado
#' @return Dataframe con análisis por semana
create_week_analysis <- function(df) {
  if (!all(c("Week", "Fecha", "Región") %in% names(df))) return(NULL)

  df %>%
    group_by(Week) %>%
    summarise(
      Fecha_Inicio = min(Fecha, na.rm = TRUE),
      Fecha_Fin = max(Fecha, na.rm = TRUE),
      Dias_Unicos = n_distinct(Fecha, na.rm = TRUE),
      Total_Registros = n(),
      Regiones = paste(sort(unique(Región)), collapse = ", "),
      Fechas_Presentes = paste(sort(unique(format(Fecha, "%d/%m/%Y"))), collapse = ", "),
      .groups = 'drop'
    ) %>%
    mutate(Rango_Fechas = paste(format(Fecha_Inicio, "%d/%m/%Y"),
                                "a",
                                format(Fecha_Fin, "%d/%m/%Y"))) %>%
    select(Week, Rango_Fechas, Dias_Unicos, Total_Registros, Regiones, Fechas_Presentes) %>%
    arrange(Week)
}

#' Guardar Excel con formato de fechas
#' @param df Dataframe a guardar
#' @param filename Nombre del archivo
save_formatted_excel <- function(df, filename) {
  wb <- createWorkbook()
  addWorksheet(wb, "Datos_Consolidados")
  writeData(wb, "Datos_Consolidados", df)

  # Aplicar formato dd/mm/yyyy a columnas de fecha
  date_cols <- which(sapply(df, function(x) inherits(x, c("Date", "POSIXct"))))
  if (length(date_cols) > 0) {
    dateStyle <- createStyle(numFmt = "dd/mm/yyyy")
    addStyle(wb, "Datos_Consolidados", style = dateStyle,
             rows = 2:(nrow(df) + 1), cols = date_cols, gridExpand = TRUE)
  }

  saveWorkbook(wb, filename, overwrite = TRUE)
}

# ==================================================================================
# PROCESO PRINCIPAL
# ==================================================================================

cat("🚀 PROCESAMIENTO DE ARCHIVOS TELCEL - VERSIÓN OPTIMIZADA\n")
cat(strrep("=", 70), "\n")
cat("📅 Inicio:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n\n")

# Buscar archivos
files <- list.files(pattern = "^Telcel_WK[0-9]+_.*\\.xlsx$", full.names = TRUE)
cat(sprintf("📁 Archivos encontrados: %d\n", length(files)))

if (length(files) == 0) stop("❌ No se encontraron archivos para procesar")

# Mostrar archivos
cat("\n📋 Archivos a procesar:\n")
walk(seq_along(files), ~cat(sprintf("   %2d. %s\n", .x, basename(files[.x]))))

# Procesar archivos
cat("\n⚙️  PROCESAMIENTO\n", strrep("=", 50), "\n")

results <- map(files, process_telcel_file, verbose = TRUE)
successful_data <- keep(results, ~.x$success) %>% map("data")

# Resumen
successful_count <- sum(map_lgl(results, ~.x$success))
cat(sprintf("\n📊 RESUMEN:\n   ✅ Exitosos: %d\n   ❌ Errores: %d\n",
            successful_count, length(files) - successful_count))

# Combinar datos
if (length(successful_data) > 0) {
  cat("\n🔗 COMBINANDO DATOS\n", strrep("=", 40), "\n")

  combined <- bind_rows(successful_data) %>%
    restore_numeric_columns()

  # Remover columna auxiliar
  combined_for_save <- combined %>% select(-source_file)

  cat(sprintf("\n✅ Datos combinados:\n   • Filas: %s\n   • Columnas: %d\n",
              format(nrow(combined), big.mark = ","), ncol(combined_for_save)))

  # Distribución por semana
  if ("Week" %in% names(combined)) {
    cat("\n📅 Distribución por semana:\n")
    combined %>%
      count(Week, sort = TRUE) %>%
      mutate(Porcentaje = round(n / sum(n) * 100, 1)) %>%
      print(n = Inf)
  }

  # Guardar archivos
  cat("\n💾 GUARDANDO ARCHIVOS\n", strrep("=", 40), "\n")

  # Excel principal
  output_xlsx <- "Telcel_ALL_WK_sep_Reg.xlsx"
  save_formatted_excel(combined_for_save, output_xlsx)
  cat(sprintf("   ✅ Excel: %s\n", output_xlsx))

  # CSV
  output_csv <- "Telcel_ALL_WK_Sep_Reg.csv"
  temp_df <- combined_for_save
  if ("Fecha" %in% names(temp_df) && inherits(temp_df$Fecha, "Date")) {
    temp_df$Fecha <- format(temp_df$Fecha, "%d/%m/%Y")
  }
  names(temp_df) <- fix_encoding(names(temp_df))

  write.csv(temp_df, file = output_csv, row.names = FALSE,
            fileEncoding = "UTF-8-BOM", na = "")
  cat(sprintf("   ✅ CSV: %s\n", output_csv))

  # Reporte de análisis
  week_analysis <- create_week_analysis(combined)

  if (!is.null(week_analysis)) {
    wb_report <- createWorkbook()
    addWorksheet(wb_report, "Analisis_Semanas")
    writeData(wb_report, "Analisis_Semanas", week_analysis)

    headerStyle <- createStyle(fontSize = 12, fontColour = "#FFFFFF",
                               halign = "center", fgFill = "#4472C4",
                               border = "TopBottomLeftRight")
    addStyle(wb_report, "Analisis_Semanas", style = headerStyle,
             rows = 1, cols = 1:ncol(week_analysis), gridExpand = TRUE)

    setColWidths(wb_report, "Analisis_Semanas",
                 cols = 1:ncol(week_analysis),
                 widths = c(10, 25, 15, 15, 30, 80))

    report_filename <- sprintf("Telcel_Analisis_%s.xlsx",
                               format(Sys.time(), "%Y%m%d_%H%M%S"))
    saveWorkbook(wb_report, report_filename, overwrite = TRUE)
    cat(sprintf("   ✅ Reporte: %s\n", report_filename))
  }

  # Resumen final
  cat("\n🎯 COMPLETADO\n", strrep("=", 40), "\n")
  cat(sprintf("   • Archivos procesados: %d de %d\n", successful_count, length(files)))
  cat(sprintf("   • Total registros: %s\n", format(nrow(combined), big.mark = ",")))

} else {
  cat("\n❌ No se procesaron archivos exitosamente\n")
}

cat("\n✨ Finalizado:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n")
