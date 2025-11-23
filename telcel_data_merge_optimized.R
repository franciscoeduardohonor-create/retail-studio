# ===================================================================================
# SCRIPT OPTIMIZADO: Unir datos de tiendas Telcel con información adicional
# OBJETIVO: Agregar columnas Name_Honor, DEUR y CITY MANAGER al archivo principal
# MEJORAS: Código optimizado, vectorizado y más eficiente
# ===================================================================================

# 1) Cargar librerías necesarias
suppressPackageStartupMessages({
  library(readxl)
  library(dplyr)
  library(openxlsx)
  library(stringdist)
  library(stringr)
  library(data.table)  # Para operaciones más rápidas
})

# 2) Configuración centralizada
CONFIG <- list(
  # Rutas de archivos - MODIFICAR SEGÚN SEA NECESARIO
  work_dir = "C:/Users/FROJAS/Desktop/ArchivosTelcelAnalisisSemanas/TELCEL_SO/CODIGO3440",
  input_file = "Telcel_ALL_WK_3440_Reg.xlsx",
  reference_file = "Referencias_Tiendas_Telcel_CACR123REF.xlsx",
  output_file = "Telcel_Todas_WK_3440_Regiones_Name.xlsx",
  unmatched_file = "Tiendas_Sin_Match_Revisar.csv",

  # Parámetros
  input_sheet = "Datos_Consolidados",
  reference_sheet = "TiendasR123",
  similarity_threshold = 0.8,

  # Columnas esperadas
  store_col_ventas = "Venta",
  store_col_ref = "Tiendas_Telcel",
  columns_to_add = c("Name_Honor", "DEUR", "CITY MANAGER")
)

# 3) Función optimizada para limpiar nombres (vectorizada)
clean_store_names <- function(store_names) {
  store_names %>%
    as.character() %>%
    toupper() %>%
    str_trim() %>%
    str_replace_all("\\s+", " ") %>%
    str_replace_all("[^A-Z0-9\\s]", "") %>%
    str_trim()
}

# 4) Función optimizada para matching aproximado (vectorizada)
find_approximate_matches <- function(unmatched_stores, reference_stores, threshold = 0.8) {
  if (length(unmatched_stores) == 0) {
    return(data.frame(
      original_name = character(),
      matched_name = character(),
      similarity_score = numeric(),
      stringsAsFactors = FALSE
    ))
  }

  cat(sprintf("\nBuscando matches aproximados para %d tiendas...\n", length(unmatched_stores)))

  # Calcular matriz de distancias de forma vectorizada
  # Usar método 'jw' (Jaro-Winkler) que es bueno para nombres
  dist_matrix <- stringdistmatrix(unmatched_stores, reference_stores, method = "jw")

  # Convertir a matriz de similitud
  sim_matrix <- 1 - as.matrix(dist_matrix)

  # Encontrar el mejor match para cada tienda
  best_matches <- apply(sim_matrix, 1, which.max)
  best_scores <- apply(sim_matrix, 1, max)

  # Filtrar por threshold
  valid_matches <- best_scores >= threshold

  results <- data.frame(
    original_name = unmatched_stores[valid_matches],
    matched_name = reference_stores[best_matches[valid_matches]],
    similarity_score = best_scores[valid_matches],
    stringsAsFactors = FALSE
  )

  cat(sprintf("✓ Matches aproximados encontrados: %d de %d (%.1f%%)\n",
              nrow(results), length(unmatched_stores),
              (nrow(results) / length(unmatched_stores)) * 100))

  return(results)
}

# 5) Función principal optimizada
smart_data_join <- function(config = CONFIG) {
  cat("=== PROCESO DE UNIÓN INTELIGENTE DE DATOS ===\n\n")

  # Verificar directorio
  if (!dir.exists(config$work_dir)) {
    stop(sprintf("ERROR: El directorio no existe: %s", config$work_dir))
  }
  setwd(config$work_dir)

  # Leer datos
  cat("Leyendo archivos...\n")
  ventas_data <- read_excel(config$input_file, sheet = config$input_sheet)
  tiendas_ref <- read_excel(config$reference_file, sheet = config$reference_sheet)

  cat(sprintf("✓ Ventas: %s filas, %s columnas\n",
              format(nrow(ventas_data), big.mark = ","), ncol(ventas_data)))
  cat(sprintf("✓ Referencia: %s tiendas\n\n",
              format(nrow(tiendas_ref), big.mark = ",")))

  # Validar columnas requeridas
  if (!config$store_col_ventas %in% names(ventas_data)) {
    stop(sprintf("ERROR: Columna '%s' no encontrada en archivo de ventas", config$store_col_ventas))
  }
  if (!config$store_col_ref %in% names(tiendas_ref)) {
    stop(sprintf("ERROR: Columna '%s' no encontrada en archivo de referencia", config$store_col_ref))
  }

  # Identificar columnas disponibles para agregar
  available_cols <- intersect(config$columns_to_add, names(tiendas_ref))
  if (length(available_cols) == 0) {
    stop("ERROR: No se encontraron columnas válidas para agregar")
  }

  missing_cols <- setdiff(config$columns_to_add, available_cols)
  if (length(missing_cols) > 0) {
    cat(sprintf("ADVERTENCIA: Columnas no disponibles: %s\n\n",
                paste(missing_cols, collapse = ", ")))
  }

  # Limpiar nombres de tiendas
  cat("Limpiando nombres de tiendas...\n")
  ventas_data$Store_Clean <- clean_store_names(ventas_data[[config$store_col_ventas]])
  tiendas_ref$Store_Clean <- clean_store_names(tiendas_ref[[config$store_col_ref]])

  # Preparar referencia (remover duplicados)
  tiendas_for_join <- tiendas_ref %>%
    select(Store_Clean, all_of(available_cols)) %>%
    distinct(Store_Clean, .keep_all = TRUE)

  # Unión exacta
  cat("Realizando matching exacto...\n")
  result <- ventas_data %>%
    left_join(tiendas_for_join, by = "Store_Clean")

  # Estadísticas de matching exacto
  primary_col <- available_cols[1]
  exact_matches <- sum(!is.na(result[[primary_col]]))
  total_rows <- nrow(result)

  cat(sprintf("✓ Matches exactos: %s de %s (%.1f%%)\n",
              format(exact_matches, big.mark = ","),
              format(total_rows, big.mark = ","),
              (exact_matches / total_rows) * 100))

  # Matching aproximado para no coincidencias
  unmatched_stores <- result %>%
    filter(is.na(.data[[primary_col]])) %>%
    pull(Store_Clean) %>%
    unique() %>%
    .[!is.na(.)]

  if (length(unmatched_stores) > 0) {
    approx_matches <- find_approximate_matches(
      unmatched_stores,
      unique(tiendas_ref$Store_Clean),
      config$similarity_threshold
    )

    if (nrow(approx_matches) > 0) {
      # Aplicar matches aproximados de forma eficiente
      match_map <- setNames(approx_matches$matched_name, approx_matches$original_name)

      result <- result %>%
        mutate(
          Matched_Store = if_else(
            is.na(.data[[primary_col]]) & Store_Clean %in% names(match_map),
            match_map[Store_Clean],
            Store_Clean
          )
        ) %>%
        select(-all_of(available_cols)) %>%
        left_join(tiendas_for_join, by = c("Matched_Store" = "Store_Clean")) %>%
        select(-Matched_Store)

      # Recalcular estadísticas
      final_matches <- sum(!is.na(result[[primary_col]]))
      cat(sprintf("✓ Total después de matching aproximado: %s de %s (%.1f%%)\n",
                  format(final_matches, big.mark = ","),
                  format(total_rows, big.mark = ","),
                  (final_matches / total_rows) * 100))
    }
  }

  # Remover columna auxiliar y reordenar
  result <- result %>% select(-Store_Clean)

  # Reordenar columnas: Name_Honor y DEUR después de Venta, CITY MANAGER al final
  original_cols <- setdiff(names(result), available_cols)
  venta_idx <- which(original_cols == config$store_col_ventas)

  cols_after_venta <- intersect(c("Name_Honor", "DEUR"), available_cols)
  city_manager_col <- intersect("CITY MANAGER", available_cols)

  if (venta_idx < length(original_cols)) {
    new_order <- c(
      original_cols[1:venta_idx],
      cols_after_venta,
      original_cols[(venta_idx + 1):length(original_cols)],
      city_manager_col
    )
  } else {
    new_order <- c(original_cols, cols_after_venta, city_manager_col)
  }

  result <- result[, new_order]

  cat(sprintf("\n✓ Datos finales: %s filas, %s columnas\n\n",
              format(nrow(result), big.mark = ","), ncol(result)))

  return(result)
}

# 6) Función optimizada para guardar resultados
save_results_and_report <- function(final_data, config = CONFIG) {
  cat("=== GUARDANDO RESULTADOS ===\n")

  # Guardar Excel
  wb <- createWorkbook()
  addWorksheet(wb, "Datos_Enriquecidos")
  writeData(wb, "Datos_Enriquecidos", final_data)

  # Formato para fechas
  date_cols <- which(sapply(final_data, function(x) inherits(x, c("Date", "POSIXct"))))
  if (length(date_cols) > 0) {
    addStyle(wb, "Datos_Enriquecidos",
             style = createStyle(numFmt = "dd/mm/yyyy"),
             rows = 2:(nrow(final_data) + 1),
             cols = date_cols,
             gridExpand = TRUE)
  }

  saveWorkbook(wb, config$output_file, overwrite = TRUE)
  cat(sprintf("✓ Archivo guardado: %s\n\n", config$output_file))

  # Reporte de calidad
  cat("=== REPORTE DE CALIDAD ===\n")

  available_new_cols <- intersect(config$columns_to_add, names(final_data))

  for (col in available_new_cols) {
    non_na <- sum(!is.na(final_data[[col]]))
    pct <- (non_na / nrow(final_data)) * 100
    cat(sprintf("%-15s: %s (%.1f%%)\n", col, format(non_na, big.mark = ","), pct))
  }

  # Top valores
  cat("\nTop 10 valores por columna:\n")
  for (col in available_new_cols) {
    cat(sprintf("\n%s:\n", col))
    top_values <- final_data %>%
      filter(!is.na(.data[[col]])) %>%
      count(.data[[col]], sort = TRUE, name = "n") %>%
      slice_head(n = 10)
    print(top_values)
  }

  # Tiendas sin match
  primary_col <- available_new_cols[1]
  unmatched <- final_data %>%
    filter(is.na(.data[[primary_col]])) %>%
    count(.data[[config$store_col_ventas]], sort = TRUE, name = "Registros")

  if (nrow(unmatched) > 0) {
    cat(sprintf("\nTiendas sin match: %d (requieren revisión manual)\n", nrow(unmatched)))
    write.csv(unmatched, config$unmatched_file, row.names = FALSE, fileEncoding = "UTF-8")
    cat(sprintf("✓ Lista guardada: %s\n", config$unmatched_file))
  } else {
    cat("\n¡Excelente! Todas las tiendas hicieron match.\n")
  }
}

# 7) EJECUCIÓN PRINCIPAL
main <- function() {
  tryCatch({
    cat("\n")
    cat("╔═══════════════════════════════════════════════════════════╗\n")
    cat("║  TELCEL DATA MERGE - VERSIÓN OPTIMIZADA                  ║\n")
    cat("╚═══════════════════════════════════════════════════════════╝\n\n")

    start_time <- Sys.time()

    # Ejecutar proceso
    final_result <- smart_data_join()
    save_results_and_report(final_result)

    end_time <- Sys.time()
    elapsed <- as.numeric(difftime(end_time, start_time, units = "secs"))

    cat("\n")
    cat("╔═══════════════════════════════════════════════════════════╗\n")
    cat(sprintf("║  PROCESO COMPLETADO EN %.2f SEGUNDOS                    ║\n", elapsed))
    cat("╚═══════════════════════════════════════════════════════════╝\n")

  }, error = function(e) {
    cat("\n❌ ERROR:\n")
    cat(e$message, "\n")
    cat("\nVerifica la configuración en la variable CONFIG.\n")
  })
}

# Ejecutar si se corre como script
if (!interactive()) {
  main()
} else {
  cat("Script cargado. Ejecuta main() para iniciar el proceso.\n")
  cat("Modifica CONFIG para cambiar la configuración.\n")
}
