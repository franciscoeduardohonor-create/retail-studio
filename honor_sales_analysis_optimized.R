#!/usr/bin/env Rscript
################################################################################
# Honor Sales Report Analysis - Optimized Version
#
# Description: Combines and analyzes sales data from QuantityVerify and
#              SeriaList Excel files, applies corrections, and generates
#              consolidated reports.
#
# Author: Optimized version
# Date: 2025-11-23
################################################################################

#### Libraries ####
suppressPackageStartupMessages({
  library(dplyr)
  library(readxl)
  library(lubridate)
})

#### Configuration ####
CONFIG <- list(
  # Adjust these paths according to your environment
  root = "C:/Users/FROJAS/Documents/",
  sales_path = "HonorBI/Sales_report/",
  region = "/RAll",

  # Column mappings
  columns_to_remove = c('Back Cover SN', 'Back Cover Photo',
                        'Human Judgement Result', 'Valid Sales'),

  # Data corrections
  max_sales_volume = 10,
  magic6_lite_cutoff_date = as.Date("2024-04-01"),

  # File patterns
  quantity_verify_pattern = 'QuantityVerify',
  serial_list_pattern = 'SeriaList'
)

################################################################################
# FUNCTION: Read and Merge Incremental Files
################################################################################
#' Optimized function to read Excel files incrementally
#'
#' @param base Character string with file pattern to search
#' @param region Character string with region path
#' @param root Character string with root directory
#' @return data.frame with merged records
optimizar_lectura <- function(base, region, root) {

  # Get list of files
  archivos <- list.files(
    paste0(root, region),
    pattern = base,
    recursive = FALSE,
    full.names = TRUE
  )

  if (length(archivos) == 0) {
    stop(paste("No files found for pattern:", base))
  }

  cat(sprintf("\nProcessing %d files for %s\n", length(archivos), base))

  # Progress bar
  pb <- txtProgressBar(min = 0, max = length(archivos), style = 3)

  # Read first file to initialize
  df_todos <- read_excel(archivos[1], sheet = 1, col_names = TRUE)
  df_todos$`Upload Time(Local)` <- as.POSIXct(
    df_todos$`Upload Time(Local)`,
    format = "%Y-%m-%d %H:%M:%S"
  )

  # Remove inconsistent columns
  df_todos <- df_todos[, !(names(df_todos) %in% CONFIG$columns_to_remove)]

  # Sort by date
  df_todos <- df_todos[order(df_todos$`Upload Time(Local)`), ]

  setTxtProgressBar(pb, 1)

  # Process remaining files
  for (k in 2:length(archivos)) {
    ultima_fecha <- max(df_todos$`Upload Time(Local)`, na.rm = TRUE)

    # Read new file
    df_temp <- read_excel(archivos[k], sheet = 1, col_names = TRUE)
    df_temp$`Upload Time(Local)` <- as.POSIXct(
      df_temp$`Upload Time(Local)`,
      format = "%Y-%m-%d %H:%M:%S"
    )

    # Remove inconsistent columns
    df_temp <- df_temp[, !(names(df_temp) %in% CONFIG$columns_to_remove)]

    # Sort by date
    df_temp <- df_temp[order(df_temp$`Upload Time(Local)`), ]

    # Find last date index
    i_ultima_fecha <- which(df_temp$`Upload Time(Local)` == ultima_fecha)

    if (length(i_ultima_fecha) == 0) {
      # If date not found, add all records
      registros_faltantes <- seq_len(nrow(df_temp))
    } else {
      # Take the last occurrence
      i_ultima_fecha <- tail(i_ultima_fecha, 1)

      # Check if dates are in ascending order
      if (i_ultima_fecha > 1) {
        comparacion_fecha <- df_temp$`Upload Time(Local)`[i_ultima_fecha - 1] <=
                            df_temp$`Upload Time(Local)`[i_ultima_fecha]
      } else {
        comparacion_fecha <- TRUE
      }

      if (comparacion_fecha) {
        # Add records after the last date
        if (i_ultima_fecha < nrow(df_temp)) {
          registros_faltantes <- seq(i_ultima_fecha + 1, nrow(df_temp))
        } else {
          registros_faltantes <- integer(0)
        }
      } else {
        # Dates in descending order, take records before
        registros_faltantes <- seq(1, i_ultima_fecha - 1)
        cat(sprintf("\nWarning: Descending dates in file %s\n", basename(archivos[k])))
      }
    }

    # Append new records
    if (length(registros_faltantes) > 0) {
      df_todos <- rbind(df_todos, df_temp[registros_faltantes, ])
    }

    setTxtProgressBar(pb, k)
  }

  close(pb)
  cat(sprintf("\nTotal records: %d\n", nrow(df_todos)))

  return(df_todos)
}

################################################################################
# FUNCTION: Standardize Column Names
################################################################################
#' Standardize column names by replacing spaces and parentheses with dots
#'
#' @param df data.frame
#' @return data.frame with standardized column names
standardize_names <- function(df) {
  names(df) <- gsub('[ ()]', '.', names(df))
  return(df)
}

################################################################################
# FUNCTION: Process QuantityVerify Data
################################################################################
process_quantity_verify <- function(df) {
  df <- standardize_names(df)

  df_processed <- df %>%
    select(
      CBG.Region, Province, City, Store.Code, Store.Name,
      Store.Monthly.Capacity, Sales.Person.Duty, Sales.Account,
      Sales.Person.Name, Sales.Position, Sales.Date, City.Manager,
      Supervisor.Name, Category, Series, Marketing.Name, Color,
      Sales.Volume, Upload.Time.Local.
    ) %>%
    mutate(
      `SN/IMEI.Check.Status` = NA,
      `Hota.Check.Status` = NA,
      `HOTA.Activation.time.quantum` = NA,
      `Reported.By.Other` = NA
    )

  return(df_processed)
}

################################################################################
# FUNCTION: Process SeriaList Data
################################################################################
process_serial_list <- function(df) {
  df <- standardize_names(df)

  df_processed <- df %>%
    select(
      MSS.Region, Province, City, Store.Code, Store.Name,
      Store.Monthly.Capacity, Sales.Person.Duty, Sales.Account,
      Sales.Person.Name, Sales.person..position, Sales.Date,
      City.Manager.Name, Supervisor.Name, Category, Series,
      MKT.Name, Color
    ) %>%
    mutate(
      Sales.Volume = 1,
      Upload.Time.Local. = df$Upload.Time.Local.,
      `SN/IMEI.Verification.Status` = df$`SN/IMEI.Verification.Status`,
      `Hota.Verification.Status` = df$Hota.Verification.Status,
      `HOTA.Activation.Time.Range` = df$HOTA.Activation.Time.Range,
      `Uploaded.By.Others` = df$Uploaded.By.Others
    )

  # Rename columns to match QuantityVerify
  names(df_processed) <- c(
    "CBG.Region", "Province", "City", "Store.Code", "Store.Name",
    "Store.Monthly.Capacity", "Sales.Person.Duty", "Sales.Account",
    "Sales.Person.Name", "Sales.Position", "Sales.Date", "City.Manager",
    "Supervisor.Name", "Category", "Series", "Marketing.Name", "Color",
    "Sales.Volume", "Upload.Time.Local.", "SN/IMEI.Check.Status",
    "Hota.Check.Status", "HOTA.Activation.time.quantum", "Reported.By.Other"
  )

  return(df_processed)
}

################################################################################
# FUNCTION: Apply Data Corrections
################################################################################
apply_corrections <- function(df) {

  cat("\nApplying data corrections...\n")

  # 1. Filter sales volume >= 10 for Sales Advisors
  df$Sales.Volume <- ifelse(
    (df$Sales.Volume >= CONFIG$max_sales_volume &
     df$Sales.Person.Duty == 'Sales Advisor'),
    0,
    df$Sales.Volume
  )

  # 2. Fix Magic 6 Pro -> Magic 6 Lite for dates before April 2024
  magic6_indices <- which(
    df$Marketing.Name == "HONOR Magic6 Pro" &
    df$Sales.Date < CONFIG$magic6_lite_cutoff_date
  )
  if (length(magic6_indices) > 0) {
    df$Marketing.Name[magic6_indices] <- "HONOR Magic6 Lite 5G"
    cat(sprintf("  - Corrected %d Magic6 Pro -> Lite records\n", length(magic6_indices)))
  }

  # 3. Standardize product names
  df$Marketing.Name <- gsub("HONOR Magic6 Lite 5G", "HONOR Magic6 Lite", df$Marketing.Name)
  df$Marketing.Name <- gsub("HONOR Magic5 Lite 5G", "HONOR Magic5 Lite", df$Marketing.Name)
  df$Marketing.Name <- toupper(df$Marketing.Name)

  # 4. Fix supervisor names
  df$Supervisor.Name <- gsub(
    "BARRAZA NAVARRETE ANWAR ALEJAN,COLMENARES JOACHIN OSCAR JAVIE",
    "BARRAZA NAVARRETE ANWAR ALEJAN",
    df$Supervisor.Name
  )

  # 5. Fix region for specific supervisor
  vega_indices <- which(df$Supervisor.Name == "VEGA LEON ALFREDO JESUS")
  if (length(vega_indices) > 0) {
    df$Region[vega_indices] <- "R1"
  }

  # 6. Clean City Manager names (remove text after comma)
  df$City.Manager <- sub(",.*", "", df$City.Manager)

  # 7. Fix specific City Manager
  martinez_indices <- which(df$City.Manager == "MARTINEZ HORI LAURA")
  if (length(martinez_indices) > 0) {
    df$City.Manager[martinez_indices] <- NA
  }

  # 8. December 2024 Magic6 Lite correction for Telcel stores
  dec_magic6_indices <- which(
    df$Marketing.Name == "HONOR MAGIC6 LITE" &
    df$Mes == 12 &
    df$Sales.Person.Duty == "Sales Advisor"
  )
  if (length(dec_magic6_indices) > 0) {
    telcel_indices_in_subset <- grep("TELCEL", df$Store.Name[dec_magic6_indices])
    if (length(telcel_indices_in_subset) > 0) {
      actual_indices <- dec_magic6_indices[telcel_indices_in_subset]
      df$Sales.Volume[actual_indices] <- df$Sales.Volume[actual_indices] * 2
      cat(sprintf("  - Doubled sales for %d Telcel Magic6 Lite records in December\n",
                  length(actual_indices)))
    }
  }

  return(df)
}

################################################################################
# FUNCTION: Add Targets
################################################################################
add_targets <- function(df, targets_path) {

  if (!file.exists(targets_path)) {
    warning(sprintf("Targets file not found: %s", targets_path))
    df$Target <- NA
    return(df)
  }

  cat("\nAdding targets...\n")
  df_targets <- read.csv(targets_path)

  df$Target <- NA

  for (i in seq_len(nrow(df_targets))) {
    i_target <- which(
      df_targets$ID.Honor.[i] == df$Store.Code &
      df_targets$Mes[i] == df$Mes
    )
    if (length(i_target) > 0) {
      df$Target[i_target] <- df_targets$Target[i]
    }
  }

  cat(sprintf("  - Added targets for %d records\n", sum(!is.na(df$Target))))

  return(df)
}

################################################################################
# FUNCTION: Update CAPA (Store Capacity)
################################################################################
update_capa <- function(df, capa_path) {

  if (!file.exists(capa_path)) {
    warning(sprintf("CAPA file not found: %s", capa_path))
    return(df)
  }

  cat("\nUpdating CAPA (store capacity)...\n")
  df_capa <- read.csv(capa_path)

  stores_updated <- 0

  for (i in seq_len(nrow(df_capa))) {
    i_capa <- which(df_capa$ID_Honor[i] == df$Store.Code)
    if (length(i_capa) > 0) {
      df$Store.Monthly.Capacity[i_capa] <- df_capa$Mean[i]
      stores_updated <- stores_updated + 1
    }
  }

  cat(sprintf("  - Updated CAPA for %d stores\n", stores_updated))

  return(df)
}

################################################################################
# MAIN EXECUTION
################################################################################
main <- function() {

  tiempo_inicio <- Sys.time()

  cat("\n")
  cat("================================================================================\n")
  cat("  HONOR SALES REPORT ANALYSIS - OPTIMIZED VERSION\n")
  cat("================================================================================\n")

  # Setup paths
  root_path <- paste0(CONFIG$root, CONFIG$sales_path)
  setwd(root_path)

  region_path <- paste0(getwd(), CONFIG$region)

  cat(sprintf("\nWorking directory: %s\n", getwd()))
  cat(sprintf("Region: %s\n", CONFIG$region))

  #### STEP 1: Read and merge incremental files ####
  cat("\n")
  cat("================================================================================\n")
  cat("  STEP 1: Reading and merging files\n")
  cat("================================================================================\n")

  df_QV <- optimizar_lectura(CONFIG$quantity_verify_pattern, CONFIG$region, getwd())
  df_SL <- optimizar_lectura(CONFIG$serial_list_pattern, CONFIG$region, getwd())

  #### STEP 2: Process and standardize data ####
  cat("\n")
  cat("================================================================================\n")
  cat("  STEP 2: Processing and standardizing data\n")
  cat("================================================================================\n")

  df_QV_processed <- process_quantity_verify(df_QV)
  df_SL_processed <- process_serial_list(df_SL)

  cat(sprintf("QuantityVerify records: %d\n", nrow(df_QV_processed)))
  cat(sprintf("SerialList records: %d\n", nrow(df_SL_processed)))

  # Combine both datasets
  df_combined <- rbind.data.frame(df_QV_processed, df_SL_processed)

  # Format dates and numeric fields
  df_combined$Upload.Time.Local. <- strptime(
    df_combined$Upload.Time.Local.,
    format = "%Y-%m-%d %H:%M:%S"
  )
  df_combined$Sales.Date <- as.Date(df_combined$Sales.Date)
  df_combined$Sales.Volume <- as.numeric(df_combined$Sales.Volume)

  # Sort by upload time
  df_combined <- df_combined[order(df_combined$Upload.Time.Local.), ]

  # Add region and month
  df_combined$Region <- gsub('Region', 'R', df_combined$CBG.Region)
  df_combined <- subset(df_combined, select = -CBG.Region)
  df_combined$Mes <- month(df_combined$Sales.Date)

  cat(sprintf("Combined records: %d\n", nrow(df_combined)))

  # Save intermediate file
  intermediate_file <- paste0(region_path, "/All/Z_SalesReport_ALL.csv")
  write.table(
    df_combined,
    intermediate_file,
    row.names = FALSE,
    col.names = TRUE,
    sep = ','
  )
  cat(sprintf("Intermediate file saved: %s\n", intermediate_file))

  #### STEP 3: Merge with historical data ####
  cat("\n")
  cat("================================================================================\n")
  cat("  STEP 3: Merging with historical data\n")
  cat("================================================================================\n")

  historical_file <- paste0(region_path, "/All/SalesReport_All_ALL_ene-oct.csv")

  if (file.exists(historical_file)) {
    df_historical <- read.csv(historical_file)
    df_historical$Target <- NULL  # Remove Target column

    # Format dates
    df_historical$Upload.Time.Local. <- as.POSIXct(
      df_historical$Upload.Time.Local.,
      format = "%d/%m/%Y %H:%M"
    )
    df_historical$Upload.Time.Local. <- format(
      df_historical$Upload.Time.Local.,
      "%Y-%m-%d %H:%M:%S"
    )
    df_historical$Sales.Date <- as.Date(
      df_historical$Sales.Date,
      format = "%d/%m/%Y"
    )
    df_historical$Sales.Date <- format(df_historical$Sales.Date, "%Y-%m-%d")

    # Combine with new data
    df_all <- rbind.data.frame(df_historical, df_combined)
    df_all <- df_all[order(df_all$Upload.Time.Local.), ]

    cat(sprintf("Historical records: %d\n", nrow(df_historical)))
    cat(sprintf("Total records after merge: %d\n", nrow(df_all)))
  } else {
    warning(sprintf("Historical file not found: %s", historical_file))
    df_all <- df_combined
  }

  #### STEP 4: Apply corrections ####
  cat("\n")
  cat("================================================================================\n")
  cat("  STEP 4: Applying data corrections\n")
  cat("================================================================================\n")

  df_all <- apply_corrections(df_all)

  #### STEP 5: Add targets and CAPA ####
  cat("\n")
  cat("================================================================================\n")
  cat("  STEP 5: Adding targets and CAPA\n")
  cat("================================================================================\n")

  targets_file <- paste0(getwd(), "/Targets/Targets_ALL.csv")
  df_all <- add_targets(df_all, targets_file)

  capa_file <- paste0(getwd(), "/Telcel/Capa.csv")
  df_all <- update_capa(df_all, capa_file)

  #### STEP 6: Save final output ####
  cat("\n")
  cat("================================================================================\n")
  cat("  STEP 6: Saving final output\n")
  cat("================================================================================\n")

  output_file <- paste0(getwd(), "/SalesReport_All_ALL.csv")
  write.table(
    df_all,
    output_file,
    row.names = FALSE,
    col.names = TRUE,
    sep = ','
  )

  tiempo_fin <- Sys.time()
  tiempo_transcurrido <- as.numeric(difftime(tiempo_fin, tiempo_inicio, units = "secs"))

  cat("\n")
  cat("================================================================================\n")
  cat("  SUMMARY\n")
  cat("================================================================================\n")
  cat(sprintf("Total records: %d\n", nrow(df_all)))
  cat(sprintf("Date range: %s to %s\n",
              min(df_all$Sales.Date, na.rm = TRUE),
              max(df_all$Sales.Date, na.rm = TRUE)))
  cat(sprintf("Last update: %s\n", max(df_all$Upload.Time.Local., na.rm = TRUE)))
  cat(sprintf("Output file: %s\n", output_file))
  cat(sprintf("Execution time: %.2f seconds\n", tiempo_transcurrido))
  cat("================================================================================\n")
  cat("\n")

  return(invisible(df_all))
}

# Execute main function
if (!interactive()) {
  main()
}
