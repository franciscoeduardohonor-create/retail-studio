# ===================================================================
# 🚀 OPTIMIZED: Visit Plan vs Attendance Analysis
# Análisis de Planes de Visita vs Asistencia Real
# ===================================================================

# 🧹 Limpieza inicial
rm(list = ls(all = TRUE))
if (length(dev.list()) > 0) dev.off()

# 📚 Librerías (instalación automática si no existen)
if (!require("pacman")) install.packages("pacman")
pacman::p_load(dplyr, readxl, stringdist, data.table)

# ⏱️ Inicio de medición de tiempo
inicio <- Sys.time()

# ===================================================================
# 📂 CONFIGURACIÓN
# ===================================================================

# Directorio de trabajo
setwd("D:/Documentos/BI_Honor/Honor/HC")

# Semana a procesar
wk <- 50
semana <- paste0('WK', wk, '/')

cat("════════════════════════════════════════════════════════════\n")
cat("  ANÁLISIS DE VISIT PLAN VS ATTENDANCE - WK", wk, "\n")
cat("════════════════════════════════════════════════════════════\n\n")

# ===================================================================
# 🔧 FUNCIONES
# ===================================================================

# Función para leer archivos Excel
read_excel_sheet <- function(file, sheet) {
  read_excel(file, sheet = sheet, col_names = TRUE)
}

# Función optimizada para normalizar duties usando stringdist
normalize_duties <- function(df, duty_col, duty_list) {
  # Convertir a mayúsculas
  df[[duty_col]] <- toupper(df[[duty_col]])

  # Calcular matriz de distancias una sola vez
  dist_matrix <- stringdistmatrix(df[[duty_col]], duty_list, method = "lv")

  # Encontrar el duty más cercano para cada registro
  indices_duty <- apply(dist_matrix, 1, which.min)

  # Asignar duties normalizados
  df[[duty_col]] <- duty_list[indices_duty]

  return(df)
}

# ===================================================================
# 📥 CARGAR DATOS
# ===================================================================

cat("📥 Cargando archivos...\n")

# Cargar Headcount
cat("   • HC W", wk, " R1 to R3.csv\n", sep = "")
df_HC <- read.csv(paste0(semana, "HC W", wk, " R1 to R3.csv"), header = FALSE)

# Cargar Visit Plan
cat("   • VP WK ", wk, ".xlsx\n", sep = "")
df_VP <- read_excel_sheet(paste0(semana, "VP WK ", wk, ".xlsx"), 1)

# Cargar Attendance
cat("   • ATT WK ", wk, ".xlsx\n", sep = "")
df_ATT <- read_excel_sheet(paste0(semana, "ATT WK ", wk, ".xlsx"), 1)

cat(sprintf("✅ Archivos cargados: HC (%d), VP (%d), ATT (%d)\n\n",
            nrow(df_HC), nrow(df_VP), nrow(df_ATT)))

# ===================================================================
# 🔧 PREPARAR HEADCOUNT
# ===================================================================

cat("🔧 Preparando datos de Headcount...\n")

# Usar primera fila como nombres de columnas
names(df_HC) <- df_HC[1, ]
df_HC <- df_HC[-1, ]

# Descomentar si es necesario renombrar columna 12
# names(df_HC)[12] <- 'Direccion'

# ===================================================================
# 📝 NORMALIZAR DUTIES/POSITIONS
# ===================================================================

cat("📝 Normalizando duties y positions...\n")

# Lista estándar de duties
dutys <- c('FIXED PROMOTER', 'SUPERVISOR', 'CITY MANAGER', 'MERCHANDISER', 'TRAINER')

# Normalización manual de casos especiales
df_ATT$Duty <- toupper(df_ATT$Duty)
df_VP$Position <- toupper(df_VP$Position)

# Reemplazos específicos
df_VP$Position[df_VP$Position == "TRAINING MANAGER"] <- 'TRAINER'
df_ATT$Duty[df_ATT$Duty == "SALES ADVISOR"] <- 'FIXED PROMOTER'
df_ATT$Duty[df_ATT$Duty == "TRAINING MANAGER"] <- 'TRAINER'

# Normalización automática usando stringdist
df_ATT <- normalize_duties(df_ATT, "Duty", dutys)
df_VP <- normalize_duties(df_VP, "Position", dutys)

# ===================================================================
# 🔄 PREPARAR VISIT PLAN Y ATTENDANCE
# ===================================================================

cat("🔄 Filtrando y preparando Visit Plan y Attendance...\n")

# Visit Plan: distinct para eliminar duplicados
df_VP2 <- df_VP %>%
  distinct(`Store Code`, `Store Name`, `Store Visitor Account`, `Store Visitor`, Position)

# Attendance: filtrar FIXED PROMOTER (solo supervisión y arriba)
df_ATT2 <- df_ATT %>%
  select(`Store Code`, `Store Name`, Account, Name, Duty) %>%
  filter(Duty != 'FIXED PROMOTER')

# Renombrar columnas para que coincidan
names(df_VP2) <- names(df_ATT2)

cat(sprintf("   • VP filtrado: %d registros\n", nrow(df_VP2)))
cat(sprintf("   • ATT filtrado: %d registros (sin Fixed Promoters)\n\n", nrow(df_ATT2)))

# ===================================================================
# 🔍 ANÁLISIS DE COINCIDENCIAS VP vs ATT
# ===================================================================

cat("🔍 Analizando coincidencias entre Visit Plan y Attendance...\n")

# Marcar registros de VP
df_VP2$VP <- 1

# 🔹 OPTIMIZACIÓN: Usar %in% en lugar de apply
# Crear claves únicas combinando Store Code y Account
df_VP2$key <- paste0(df_VP2$`Store Code`, "_", df_VP2$Account)
df_ATT2$key <- paste0(df_ATT2$`Store Code`, "_", df_ATT2$Account)

# Verificar si cada registro de VP tiene asistencia
df_VP2$att <- ifelse(df_VP2$key %in% df_ATT2$key, 1, 0)

cat(sprintf("   • VP con asistencia: %d / %d (%.1f%%)\n",
            sum(df_VP2$att), nrow(df_VP2),
            100 * sum(df_VP2$att) / nrow(df_VP2)))

# ===================================================================
# 📊 ENCONTRAR ASISTENCIAS SIN VISIT PLAN
# ===================================================================

cat("📊 Identificando asistencias sin Visit Plan...\n")

# 🔹 OPTIMIZACIÓN: Usar anti-join en lugar de match negativo
df_no_match <- df_ATT2 %>%
  anti_join(df_VP2, by = "key") %>%
  mutate(VP = 0, att = 1) %>%
  select(-key)  # Eliminar columna temporal

cat(sprintf("   • Asistencias sin VP: %d\n\n", nrow(df_no_match)))

# Eliminar columna temporal de VP2
df_VP2 <- df_VP2 %>% select(-key)

# ===================================================================
# 🔗 COMBINAR DATASETS
# ===================================================================

cat("🔗 Combinando Visit Plan y Asistencias...\n")

# Combinar VP y asistencias sin VP
temp <- rbind(df_VP2, df_no_match)

cat(sprintf("   • Total de registros combinados: %d\n\n", nrow(temp)))

# ===================================================================
# 🏢 ENRIQUECER CON DATOS DE HEADCOUNT
# ===================================================================

cat("🏢 Enriqueciendo con datos de Headcount...\n")

# 🔹 OPTIMIZACIÓN: Usar match una sola vez
i_match <- match(temp$`Store Code`, df_HC$ID)

# Extraer columnas de HC de forma vectorizada
temp$CUSTUMER <- df_HC$CUSTUMER[i_match]
temp$RG <- df_HC$RG[i_match]
temp$Estado <- df_HC$Estado[i_match]
temp$Ciudad <- df_HC$Ciudad[i_match]
temp$FP <- df_HC$`FIXED PROMOTER`[i_match]

# Nota: Tier comentado en código original (descomentar si es necesario)
# temp$Tier <- df_HC$Tier[i_match]

# ===================================================================
# 📋 REORGANIZAR COLUMNAS FINALES
# ===================================================================

cat("📋 Organizando columnas finales...\n")

# Seleccionar y reordenar columnas
df_HC_All <- temp %>%
  select(CUSTUMER, RG, Estado, Ciudad, `Store Code`, `Store Name`,
         FP, VP, att, Duty, Name, Account)

# Renombrar columnas al formato final
names(df_HC_All) <- c('CUSTUMER', 'RG', 'Estado', 'Ciudad', 'ID', 'NAME',
                      'FIXED PROMOTER', 'VP', 'Att', 'duty', 'Name_P', 'Acount')

# ===================================================================
# 💾 GUARDAR RESULTADO
# ===================================================================

cat("💾 Guardando resultado...\n")

output_file <- paste0(semana, "HC_VpAtt_All_.csv")
write.table(df_HC_All, output_file, row.names = FALSE, col.names = TRUE, sep = ',')

cat(sprintf("✅ Archivo guardado: %s\n\n", output_file))

# ===================================================================
# 📊 RESUMEN EJECUTIVO
# ===================================================================

cat("════════════════════════════════════════════════════════════\n")
cat("📊 RESUMEN EJECUTIVO\n")
cat("════════════════════════════════════════════════════════════\n")

cat(sprintf("Total de registros procesados: %s\n",
            format(nrow(df_HC_All), big.mark = ",")))

cat(sprintf("  • Visit Plans: %s\n",
            format(sum(df_HC_All$VP == 1), big.mark = ",")))

cat(sprintf("  • Asistencias: %s\n",
            format(sum(df_HC_All$Att == 1), big.mark = ",")))

cat(sprintf("  • VP con asistencia: %s (%.1f%%)\n",
            format(sum(df_HC_All$VP == 1 & df_HC_All$Att == 1), big.mark = ","),
            100 * sum(df_HC_All$VP == 1 & df_HC_All$Att == 1) / sum(df_HC_All$VP == 1)))

cat(sprintf("  • Asistencias sin VP: %s\n",
            format(sum(df_HC_All$VP == 0 & df_HC_All$Att == 1), big.mark = ",")))

cat(sprintf("  • VP sin asistencia: %s\n\n",
            format(sum(df_HC_All$VP == 1 & df_HC_All$Att == 0), big.mark = ",")))

# Distribución por duty
cat("Distribución por Duty:\n")
duty_summary <- df_HC_All %>%
  group_by(duty) %>%
  summarise(
    Total = n(),
    VP = sum(VP),
    Att = sum(Att),
    .groups = "drop"
  ) %>%
  arrange(desc(Total))

print(duty_summary, n = Inf)

# ⏱️ Tiempo de ejecución
fin <- Sys.time()
tiempo_total <- as.numeric(difftime(fin, inicio, units = "secs"))

cat("\n════════════════════════════════════════════════════════════\n")
cat(sprintf("⏱️  Tiempo total de ejecución: %.2f segundos\n", tiempo_total))
cat("════════════════════════════════════════════════════════════\n")
