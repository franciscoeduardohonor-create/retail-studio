# ============================================================================
# Optimized Attendance Analysis Script
# ============================================================================
# Author: Honor BI
# Description: Processes clock-in/clock-out records for store employees
# Optimizations: Vectorized operations, reduced code duplication, improved performance
# ============================================================================

# Clear environment and close graphics devices
rm(list = ls(all = TRUE))
if (length(dev.list()) > 0) { dev.off() }

# Start timer
ti <- Sys.time()

# Load required libraries
library(readr)
library(dplyr)
library(readxl)

# ============================================================================
# CONFIGURATION
# ============================================================================

# Set paths (update these to your local paths)
root <- "C:/Users/FROJAS/Documents/HonorBI/Asistencias"
region <- '/RAll/'
RG <- gsub('/', '', region)

# Set working directory
setwd(paste0(root, region))
output <- paste0(root, region)

# ============================================================================
# DATA LOADING
# ============================================================================

cat("Loading data...\n")

df_pasar_lista0 <- read_excel("ClockInDailyRecords.xlsx")

# Select relevant columns
df_pasar_lista <- df_pasar_lista0[, c(1:8, 14, 17:22, 24:26, 28)] %>%
  arrange(Name)

# ============================================================================
# DATA PREPROCESSING
# ============================================================================

cat("Preprocessing data...\n")

df_pasar_lista <- df_pasar_lista %>%
  mutate(
    Date = as.Date(Date),
    `First Check In` = as.POSIXct(`First Check In`, format = "%Y-%m-%d %H:%M:%S"),
    `Last Check In` = as.POSIXct(`Last Check In`, format = "%Y-%m-%d %H:%M:%S"),
    `Time in store(Mins)` = as.numeric(`Time in store(Mins)`)
  )

# ============================================================================
# HELPER FUNCTION: Process Attendance
# ============================================================================

process_attendance <- function(df, duty_type, min_shift_minutes, use_aggregated_checkins = FALSE) {
  """
  Process attendance data for a specific duty type

  Args:
    df: Input dataframe
    duty_type: Type of duty (e.g., 'Middle Management', 'Sales Advisor')
    min_shift_minutes: Minimum minutes for a complete shift
    use_aggregated_checkins: If TRUE, aggregate multiple check-ins per day (for Middle Management)

  Returns:
    Processed dataframe with attendance metrics
  """

  if (use_aggregated_checkins) {
    # For Middle Management: aggregate multiple check-ins per day
    df_processed <- df %>%
      group_by(Name, Date) %>%
      mutate(tiempo_tienda = sum(`Time in store(Mins)`, na.rm = TRUE)) %>%
      summarise(
        Account = first(Account),
        `Employee ID` = first(`Employee ID`),
        Duty = first(Duty),
        Department = first(Department),
        Store = first(Store),
        Area = first(Area),
        Province = first(Province),
        City = first(City),
        `First Check In` = min(`First Check In`, na.rm = TRUE),
        `Last Check In` = max(`Last Check In`, na.rm = TRUE),
        `In Address` = first(`In Address`),
        `Out Address` = last(`Out Address`),
        `Time in store(Mins)` = first(`Time in store(Mins)`),
        tiempo_tienda = first(tiempo_tienda),
        .groups = "drop"
      )
  } else {
    # For Sales Advisors: direct calculation
    df_processed <- df %>%
      group_by(Name, Date) %>%
      mutate(tiempo_tienda = sum(`Time in store(Mins)`, na.rm = TRUE)) %>%
      ungroup()
  }

  # Calculate work time and attendance metrics
  df_final <- df_processed %>%
    mutate(
      work_time = as.numeric(difftime(`Last Check In`, `First Check In`, units = "mins")),
      Turno_Completo = ifelse(work_time >= min_shift_minutes, "Yes", "No"),
      Week = as.numeric(format(Date - 1, "%U")) + 1,
      Turno_efectivoMoI6 = ifelse(
        if (use_aggregated_checkins) work_time >= 360 else tiempo_tienda >= 360,
        "Yes",
        "No"
      ),
      chekout_final = ifelse(is.na(`Last Check In`), "No", "Yes")
    ) %>%
    group_by(Name, Week) %>%
    mutate(
      Unique_Days = n_distinct(Date),
      Dias_MoI_6 = ifelse(Unique_Days >= 6, "Yes", "No")
    ) %>%
    ungroup()

  return(df_final)
}

# ============================================================================
# PROCESS MIDDLE MANAGEMENT
# ============================================================================

cat("Processing Middle Management...\n")

duty_sales_advisor <- 'Sales Advisor'

df_super <- df_pasar_lista %>%
  filter(Duty != duty_sales_advisor) %>%
  select(1:14, 16, 17, 19)

# Process with aggregated check-ins (480 minutes = 8 hours)
df_asistencias <- process_attendance(
  df_super,
  duty_type = "Middle Management",
  min_shift_minutes = 480,
  use_aggregated_checkins = TRUE
)

cat("Completado: Middle Management\n")

# ============================================================================
# PROCESS SALES ADVISORS
# ============================================================================

cat("Processing Sales Advisors...\n")

df_promotores <- df_pasar_lista %>%
  filter(Duty == duty_sales_advisor) %>%
  select(1:14, 16, 17, 19)

# Process without aggregation (540 minutes = 9 hours)
df_asistencias_promo <- process_attendance(
  df_promotores,
  duty_type = "Sales Advisor",
  min_shift_minutes = 540,
  use_aggregated_checkins = FALSE
)

cat("Completado: Sales Advisor\n")

# ============================================================================
# COMBINE AND EXPORT RESULTS
# ============================================================================

cat("Combining results...\n")

df_asistencias_all <- bind_rows(df_asistencias, df_asistencias_promo) %>%
  mutate(
    Region = gsub('Region', 'R', Area)
  ) %>%
  arrange(Name, Date)

# Export to CSV
output_file <- paste0(root, "/Asistencias_All.csv")
write.table(
  df_asistencias_all,
  output_file,
  row.names = FALSE,
  col.names = TRUE,
  sep = ','
)

cat("Completado: Asistencias_All\n")
cat(paste0("File saved to: ", output_file, "\n"))

# ============================================================================
# PERFORMANCE SUMMARY
# ============================================================================

tf <- Sys.time()
duration <- tf - ti

cat("\n")
cat("============================================\n")
cat("EXECUTION SUMMARY\n")
cat("============================================\n")
cat(paste0("Total records processed: ", nrow(df_asistencias_all), "\n"))
cat(paste0("Middle Management: ", nrow(df_asistencias), "\n"))
cat(paste0("Sales Advisors: ", nrow(df_asistencias_promo), "\n"))
cat(paste0("Duration: ", round(duration, 2), " ", attr(duration, "units"), "\n"))
cat("============================================\n")

# ============================================================================
# KEY OPTIMIZATIONS IMPLEMENTED
# ============================================================================
# 1. Eliminated for loops - replaced with vectorized dplyr operations
# 2. Created reusable function to avoid code duplication
# 3. Removed temporary dataframe initialization (no more "Temp Temp" rows)
# 4. Simplified check-in/check-out aggregation logic
# 5. Used bind_rows instead of rbind.data.frame for better performance
# 6. Added progress messages and execution summary
# 7. Removed commented-out code for clarity
# ============================================================================
