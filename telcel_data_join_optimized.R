# ===================================================================================
# SCRIPT OPTIMIZADO: Unir datos de tiendas Telcel con información adicional
# OPTIMIZACIONES:
#   - Uso de data.table para operaciones más rápidas
#   - Vectorización mejorada
#   - Reducción de loops innecesarios
#   - Procesamiento por lotes en matching aproximado
# ===================================================================================

# Cargar librerías
suppressPackageStartupMessages({
  library(readxl)
  library(data.table)
  library(openxlsx)
  library(stringdist)
  library(stringr)
})

# Configuración
WORK_DIR <- "C:/Users/FROJAS/Desktop/ArchivosTelcelAnalisisSemanas/SemanasTabletas/NOMBRES"
MAIN_FILE <- "Telcel_Todas_WK_SEPT_Regiones.xlsx"
REF_FILE <- "Referencias_Tiendas_Telcel_CACR123REF.xlsx"
OUTPUT_FILE <- "Telcel_Todas_WKs_SEPT_Regiones_Name.xlsx"
SIMILARITY_THRESHOLD <- 0.8

# Función para limpiar nombres de tiendas (vectorizada)
clean_store_names <- function(names_vec) {
  names_vec %>%
    as.character() %>%
    toupper() %>%
    str_trim() %>%
    str_replace_all("\\s+", " ") %>%
    str_replace_all("[^A-Z0-9\\s]", "") %>%
    str_trim()
}

# Función optimizada para matching aproximado usando vectorización
find_approximate_matches <- function(unmatched, reference, threshold = 0.8) {
  if (length(unmatched) == 0) return(data.table())

  cat(sprintf("Buscando matches aproximados para %d tiendas (threshold: %.2f)...\n",
              length(unmatched), threshold))

  # Calcular matriz de similitud de una vez
  dist_matrix <- stringdistmatrix(unmatched, reference, method = "jw")
  similarity_matrix <- 1 - dist_matrix

  # Encontrar mejor match para cada tienda
  best_matches <- max.col(similarity_matrix)
  best_scores <- similarity_matrix[cbind(seq_along(unmatched), best_matches)]

  # Filtrar por threshold
  valid_matches <- best_scores >= threshold

  result <- data.table(
    original_name = unmatched[valid_matches],
    matched_name = reference[best_matches[valid_matches]],
    similarity_score = best_scores[valid_matches]
  )

  cat(sprintf("Matches aproximados encontrados: %d de %d (%.1f%%)\n",
              nrow(result), length(unmatched), 100 * nrow(result) / length(unmatched)))

  return(result)
}

# Función principal optimizada
smart_data_join <- function() {
  cat("\n=== PROCESO DE UNIÓN INTELIGENTE DE DATOS ===\n\n")

  # Cargar datos
  cat("Cargando datos...\n")
  ventas_dt <- as.data.table(read_excel(file.path(WORK_DIR, MAIN_FILE),
                                        sheet = "Datos_Consolidados"))
  tiendas_dt <- as.data.table(read_excel(file.path(WORK_DIR, REF_FILE),
                                         sheet = "TiendasR123"))

  cat(sprintf("✓ Ventas: %s filas\n", format(nrow(ventas_dt), big.mark = ",")))
  cat(sprintf("✓ Tiendas referencia: %s filas\n", format(nrow(tiendas_dt), big.mark = ",")))

  # Validar columnas requeridas
  required_ventas <- "Venta"
  required_ref <- c("Tiendas_Telcel", "Name_Honor", "DEUR")

  if (!required_ventas %in% names(ventas_dt)) {
    stop("ERROR: Columna 'Venta' no encontrada en archivo principal")
  }

  missing_cols <- setdiff(required_ref, names(tiendas_dt))
  if (length(missing_cols) > 0) {
    stop(sprintf("ERROR: Columnas faltantes en referencia: %s",
                 paste(missing_cols, collapse = ", ")))
  }

  # Detectar columna City Manager
  city_manager_col <- names(tiendas_dt)[grepl("CITY.*MANAGER", names(tiendas_dt),
                                               ignore.case = TRUE)]
  has_city_manager <- length(city_manager_col) > 0

  if (has_city_manager) {
    city_manager_col <- city_manager_col[1]
    cat(sprintf("✓ Columna City Manager encontrada: '%s'\n", city_manager_col))
  }

  # Limpiar nombres
  cat("\nLimpiando nombres de tiendas...\n")
  ventas_dt[, Venta_Clean := clean_store_names(Venta)]
  tiendas_dt[, Tiendas_Clean := clean_store_names(Tiendas_Telcel)]

  # Preparar referencia (eliminar duplicados)
  cols_select <- c("Tiendas_Clean", "Name_Honor", "DEUR")
  if (has_city_manager) cols_select <- c(cols_select, city_manager_col)

  tiendas_unique <- unique(tiendas_dt[, ..cols_select], by = "Tiendas_Clean")

  cat(sprintf("✓ Tiendas únicas en ventas: %d\n", uniqueN(ventas_dt$Venta_Clean)))
  cat(sprintf("✓ Tiendas únicas en referencia: %d\n", nrow(tiendas_unique)))

  # Join exacto
  cat("\nRealizando join exacto...\n")
  setkey(ventas_dt, Venta_Clean)
  setkey(tiendas_unique, Tiendas_Clean)

  result_dt <- tiendas_unique[ventas_dt]

  # Renombrar columnas para claridad
  if (has_city_manager) {
    setnames(result_dt, old = city_manager_col, new = "CITY_MANAGER", skip_absent = TRUE)
  }

  exact_matches <- sum(!is.na(result_dt$Name_Honor))
  cat(sprintf("✓ Matches exactos: %s de %s (%.1f%%)\n",
              format(exact_matches, big.mark = ","),
              format(nrow(result_dt), big.mark = ","),
              100 * exact_matches / nrow(result_dt)))

  # Matching aproximado para los no matched
  unmatched <- result_dt[is.na(Name_Honor), unique(Venta_Clean)]
  unmatched <- unmatched[!is.na(unmatched)]

  if (length(unmatched) > 0) {
    cat(sprintf("\nProcesando %d tiendas sin match exacto...\n", length(unmatched)))

    approx_matches <- find_approximate_matches(
      unmatched,
      tiendas_unique$Tiendas_Clean,
      SIMILARITY_THRESHOLD
    )

    if (nrow(approx_matches) > 0) {
      # Crear mapeo para actualizar
      setkey(approx_matches, original_name)
      setkey(tiendas_unique, Tiendas_Clean)

      mapping <- tiendas_unique[approx_matches[, .(matched_name)],
                                on = .(Tiendas_Clean = matched_name)]
      mapping[, original_name := approx_matches$original_name]

      # Actualizar matches aproximados
      for (i in seq_len(nrow(mapping))) {
        idx <- result_dt$Venta_Clean == mapping$original_name[i] &
               is.na(result_dt$Name_Honor)

        if (any(idx)) {
          set(result_dt, which(idx), "Name_Honor", mapping$Name_Honor[i])
          set(result_dt, which(idx), "DEUR", mapping$DEUR[i])
          if (has_city_manager) {
            set(result_dt, which(idx), "CITY_MANAGER", mapping$CITY_MANAGER[i])
          }
        }
      }

      new_matches <- sum(!is.na(result_dt$Name_Honor))
      cat(sprintf("✓ Total matches: %s de %s (%.1f%%)\n",
                  format(new_matches, big.mark = ","),
                  format(nrow(result_dt), big.mark = ","),
                  100 * new_matches / nrow(result_dt)))
    }
  }

  # Reorganizar columnas: Name_Honor y DEUR después de Venta, CITY_MANAGER al final
  cat("\nReorganizando columnas...\n")
  result_dt[, Tiendas_Clean := NULL]  # Eliminar columna auxiliar

  all_cols <- names(result_dt)
  original_cols <- setdiff(all_cols, c("Name_Honor", "DEUR", "CITY_MANAGER"))

  venta_idx <- which(original_cols == "Venta")

  if (venta_idx < length(original_cols)) {
    new_order <- c(
      original_cols[1:venta_idx],
      "Name_Honor", "DEUR",
      original_cols[(venta_idx + 1):length(original_cols)]
    )
  } else {
    new_order <- c(original_cols, "Name_Honor", "DEUR")
  }

  if (has_city_manager) {
    new_order <- c(new_order, "CITY_MANAGER")
  }

  # Asegurar que solo usemos columnas existentes
  new_order <- new_order[new_order %in% all_cols]
  setcolorder(result_dt, new_order)

  cat(sprintf("✓ Dataset final: %s filas, %s columnas\n",
              format(nrow(result_dt), big.mark = ","), ncol(result_dt)))

  return(result_dt)
}

# Función para guardar resultados
save_results_and_report <- function(final_dt, has_city_manager = FALSE) {
  cat("\n=== GUARDANDO RESULTADOS ===\n")

  # Guardar archivo Excel
  wb <- createWorkbook()
  addWorksheet(wb, "Datos_Enriquecidos")
  writeData(wb, "Datos_Enriquecidos", final_dt)

  # Formatear fechas si existen
  date_cols <- which(sapply(final_dt, function(x) inherits(x, c("Date", "POSIXct"))))
  if (length(date_cols) > 0) {
    addStyle(wb, "Datos_Enriquecidos",
             style = createStyle(numFmt = "dd/mm/yyyy"),
             rows = 2:(nrow(final_dt) + 1),
             cols = date_cols)
  }

  saveWorkbook(wb, file.path(WORK_DIR, OUTPUT_FILE), overwrite = TRUE)
  cat(sprintf("✓ Archivo guardado: %s\n", OUTPUT_FILE))

  # Reporte de calidad
  cat("\n=== REPORTE DE CALIDAD ===\n")
  total <- nrow(final_dt)

  cat(sprintf("Total filas: %s\n", format(total, big.mark = ",")))
  cat(sprintf("Con Name_Honor: %s (%.1f%%)\n",
              format(sum(!is.na(final_dt$Name_Honor)), big.mark = ","),
              100 * sum(!is.na(final_dt$Name_Honor)) / total))
  cat(sprintf("Con DEUR: %s (%.1f%%)\n",
              format(sum(!is.na(final_dt$DEUR)), big.mark = ","),
              100 * sum(!is.na(final_dt$DEUR)) / total))

  if (has_city_manager && "CITY_MANAGER" %in% names(final_dt)) {
    cat(sprintf("Con CITY_MANAGER: %s (%.1f%%)\n",
                format(sum(!is.na(final_dt$CITY_MANAGER)), big.mark = ","),
                100 * sum(!is.na(final_dt$CITY_MANAGER)) / total))
  }

  # Identificar y guardar tiendas sin match
  unmatched <- final_dt[is.na(Name_Honor), .N, by = Venta][order(-N)]

  if (nrow(unmatched) > 0) {
    cat(sprintf("\n⚠ Tiendas sin match: %d\n", nrow(unmatched)))
    print(head(unmatched, 10))

    fwrite(unmatched, file.path(WORK_DIR, "Tiendas_Sin_Match_Revisar.csv"),
           bom = TRUE)
    cat("✓ Lista guardada: Tiendas_Sin_Match_Revisar.csv\n")
  } else {
    cat("\n✓ Todas las tiendas tienen match exitoso\n")
  }
}

# EJECUCIÓN PRINCIPAL
main <- function() {
  setwd(WORK_DIR)
  cat("Directorio de trabajo:", getwd(), "\n")

  # Verificar archivos
  if (!file.exists(MAIN_FILE)) {
    stop(sprintf("ERROR: No se encuentra %s", MAIN_FILE))
  }
  if (!file.exists(REF_FILE)) {
    stop(sprintf("ERROR: No se encuentra %s", REF_FILE))
  }

  # Ejecutar proceso
  final_data <- smart_data_join()
  has_cm <- "CITY_MANAGER" %in% names(final_data)
  save_results_and_report(final_data, has_cm)

  cat("\n=== PROCESO COMPLETADO ===\n")
  return(invisible(final_data))
}

# Ejecutar
if (!interactive()) {
  main()
}
