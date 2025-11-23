#### 🚀 Análisis de Ventas Coppel - Versión Optimizada ####
# Optimizaciones realizadas:
# - Uso de data.table para mayor velocidad
# - Expresiones regulares compiladas
# - Procesamiento vectorizado
# - Manejo eficiente de memoria

#### 🧹 Limpieza inicial ####
rm(list = ls(all = TRUE))
if (length(dev.list()) > 0) dev.off()

#### 📚 Librerías ####
if (!require("pacman")) install.packages("pacman")
pacman::p_load(readr, stringr, stringdist, data.table, readxl, lubridate, purrr)

#### 📂 Directorios y parámetros ####
root0 <- "C:"
root <- file.path(root0, "Users/FROJAS/Documents/HonorBI/B2B_Coppel_LVP/Codigo_COPPEL_LVP/Coppel/2025/Buenos/")
setwd(root)

nom_col <- c("Region", "Tienda", "clase", "Familia", "Marca", "Modelo", "Date", "SO")

# Lista consolidada de palabras a remover
palabras_quitar <- c(
  # Colores
  "GREEN", "BLUE", "YELLOW", "ORANGE", "PURPLE", "BLACK", "WHITE", "GRAY", "PINK",
  "GOLD", "ROJO", "AZUL", "AMARILLO", "NARANJA", "VIOLETA", "CIAN", "PLATA",
  "MORADO", "NEGRO", "BLANCO", "ROSA", "GRIS", "COBRE", "LIMA", "PURPURA",
  "LAVANDA", "BEIGE", "CAFE", "LILA", "MORA", "SILVER", "CORAL", "DORADO",
  "OSCURO", "BRONCE", "MENTA", "CLARO", "MARINO", "AURORA", "NATURAL", "SIERRA",
  "ALPINE", "PROFUNDO", "OBSCURO", "PERLA", "DEEP INDIGO", "STARLIGHTH",
  "STARLIGT", "MIDNIGHTH", "MIDNIGT", "ULTRAMA", "GLACIAR", "MAGENTA",
  "MULTICOLOR", "SPACE", "DEEP", "GRAPHITE",
  # Variantes
  "MORAD", "GRAFIT", "GRAFITO", "PLAT", "VERD", "AMARILL", "AMARI", "NARAN",
  "LAVAN", "AZU", "BLAN", "GRI", "NEGR", "NEG", "NARA", "NAT", "BLA", "NRNJ",
  "VER", "MOR", "VIO",
  # Promociones
  "COMBO", "COMB2", "COMB", "COM2", "COM3", "DUO", "DUO3", "BUNDLE", "HBUNDLE",
  "BUND", "BUN", "PROMO", "KIT", "RENATO", "ESPECIAL", "ESPE", "MOCHILA",
  # Tecnología
  "IOTAIR3", "IOT", "W40", "5G", "4G", "3G", "64", "128", "256", "512", "12GB",
  # Otros
  "2020", "CIA", "PV", "IU", "BCO", "STAR", "OBS", "MAR", "/"
)

# Patrón compilado para eficiencia
patron_palabras <- paste0("\\b(", paste(palabras_quitar, collapse = "|"), ")\\b")
patron_codigo_modelo <- "\\b(SM-[A-Z0-9]+|XT[0-9-]+|CPH[0-9]+|2[2-4][A-Z0-9]+|BRP-[A-Z0-9]+|RMX[0-9]+)\\b"

#### 🧹 Funciones ####

# 🔹 Limpieza de nombres de modelo (optimizada)
limpiar_modelo <- function(modelo) {
  modelo %>%
    str_replace_all("\xa0", " ") %>%
    str_to_upper() %>%
    str_remove_all("\\b(\\d+GB|\\d+MB)\\b") %>%
    str_remove_all("\\b(2G|3G|4G|5G|GSM|4\\.5G|3-G)\\b") %>%
    str_remove_all(patron_palabras) %>%
    str_remove_all("\\b(KIT|BUNDLE|IU|OTA|AIR4-BES)\\b") %>%
    str_remove_all("\\b\\w{3}-\\w{3}\\b") %>%
    str_remove_all(patron_codigo_modelo) %>%
    str_remove_all("\\b[a-zA-Z]{2}\\b") %>%
    str_remove_all("[[:punct:]/]") %>%
    str_replace_all("\\s+", " ") %>%
    str_squish()
}

# 🔹 Lectura de archivos Coppel (optimizada con data.table)
leer_archivos_coppel <- function(mes) {
  cat(sprintf("M%02d\n", mes))
  archivos <- dir(pattern = sprintf("Coppel_SO_M%02d_*", mes))

  if (length(archivos) == 0) {
    warning(sprintf("No se encontraron archivos para el mes %02d", mes))
    return(data.table())
  }

  ldf <- lapply(archivos, function(f) {
    cat(sprintf("   Leyendo: %s\n", f))

    # Leer y convertir a data.table
    df <- setDT(as.data.frame(read_excel(f, col_types = "text")))
    setnames(df, nom_col)

    # Conversiones de tipo
    df[, SO := as.numeric(SO)]

    # Manejo de fechas según mes
    df[, Date := if (mes == 5) {
      as.Date(Date, format = "%m-%d-%Y")
    } else {
      as.Date(gsub("\\\\", "-", Date), format = "%d-%m-%Y")
    }]

    # Limpieza de modelo
    df[, Modelo_Limpia := limpiar_modelo(Modelo)]

    return(df)
  })

  rbindlist(ldf, use.names = TRUE, fill = TRUE)
}

# 🔹 Resumen de ventas (optimizada con data.table)
resumir_ventas <- function(dt_ventas, dt_hc, frecuencia = "semana", output_file) {

  # Convertir a data.table si no lo es
  if (!is.data.table(dt_ventas)) dt_ventas <- as.data.table(dt_ventas)
  if (!is.data.table(dt_hc)) dt_hc <- as.data.table(dt_hc)

  # Asegurar formato de fecha
  dt_ventas[, `:=`(
    Date = as.Date(Date),
    Year = year(Date)
  )]

  # Agregar columna según frecuencia
  if (frecuencia == "semana") {
    dt_ventas[, semana := week(Date)]
    cols_grupo <- c("Region", "ID", "Tienda", "Familia", "Marca", "Modelo", "Year", "semana")
    cols_orden <- c("Year", "semana")
  } else if (frecuencia == "mes") {
    dt_ventas[, mes := month(Date, label = TRUE, abbr = TRUE)]
    cols_grupo <- c("Region", "ID", "Tienda", "Familia", "Marca", "Modelo", "Year", "mes")
    cols_orden <- c("Year", "mes")
  } else if (frecuencia == "dia") {
    dt_ventas[, dia := Date]
    cols_grupo <- c("Region", "ID", "Tienda", "Familia", "Marca", "Modelo", "Date", "Year")
    cols_orden <- "Date"
  } else {
    stop("Frecuencia no válida. Use 'dia', 'semana' o 'mes'")
  }

  # Agrupar y sumarizar
  if (frecuencia == "dia") {
    dt_resumido <- dt_ventas[, .(Sales = sum(SO, na.rm = TRUE)),
                              by = cols_grupo][order(Date)]
    setnames(dt_resumido, "Date", "dia")
  } else {
    dt_resumido <- dt_ventas[, .(Sales = sum(SO, na.rm = TRUE)),
                              by = cols_grupo][order(get(cols_orden[1]), get(cols_orden[2]))]
  }

  # Preparar HC
  setnames(dt_hc, make.unique(names(dt_hc)))
  dt_hc2 <- dt_hc[Customer == "COPPEL" & RG %in% c("R1", "R2", "R3")]

  dt_hc3 <- dt_hc2[, .(
    ID_Honor = ID,
    `ID used  in CHANNEL`,
    NAME,
    Estado,
    `FIXED PROMOTER`,
    `Promoter name`,
    `CM name`
  )]

  # Eliminar duplicados
  dt_hc3 <- unique(dt_hc3, by = "ID used  in CHANNEL")

  # Merge
  dt_final <- merge(dt_resumido, dt_hc3,
                    by.x = "ID", by.y = "ID used  in CHANNEL",
                    all.x = TRUE)

  # Agregar columna de frecuencia
  dt_final[, Frecuencia_Agregacion := frecuencia]

  # Escribir archivo
  fwrite(dt_final, output_file)

  # Reporte
  cat(sprintf("✅ Archivo generado: %s\n", output_file))
  cat(sprintf("   - Registros: %,d\n", nrow(dt_final)))
  cat(sprintf("   - Ventas totales: %,d\n", sum(dt_final$Sales, na.rm = TRUE)))

  return(dt_final)
}

#### 📊 Ejecución ####

# 1️⃣ Leer y combinar todos los meses
cat("🔄 Leyendo archivos de Coppel...\n")
Coppel_all <- rbindlist(lapply(5:10, leer_archivos_coppel), use.names = TRUE, fill = TRUE)

# Separar columna Tienda
Coppel_all[, c("ID", "Tienda") := tstrsplit(Tienda, "•", fixed = TRUE, keep = 1:2)]
Coppel_all[, `:=`(
  ID = trimws(ID),
  Tienda = trimws(Tienda),
  SO = as.numeric(SO)
)]

# Limpiar columna Familia
Coppel_all[, Familia := str_trim(str_split_fixed(Familia, "•", 2)[, 2])]

# 2️⃣ Cargar HC
cat("\n📁 Cargando archivo HC...\n")
df_hc <- fread(file.path(root0, "Users/FROJAS/Documents/HonorBI/B2B_Coppel_LVP/Codigo_COPPEL_LVP/HC_W41_October_Final.csv"),
               header = FALSE)
setnames(df_hc, as.character(df_hc[1, ]))
df_hc <- df_hc[-1, ]
setnames(df_hc, 12, "Direccion")

# 3️⃣ Generar los tres archivos de resumen
cat("\n📊 Generando archivos de resumen...\n")
cat(strrep("=", 50), "\n")

# Por día
cat("\n📅 Procesando ventas por DÍA...\n")
df_dia <- resumir_ventas(
  Coppel_all,
  df_hc,
  frecuencia = "dia",
  output_file = "PriceList_Coppel_All_by_dia.csv"
)

# Por semana
cat("\n📅 Procesando ventas por SEMANA...\n")
df_semana <- resumir_ventas(
  Coppel_all,
  df_hc,
  frecuencia = "semana",
  output_file = "PriceList_Coppel_All_by_semana.csv"
)

# Por mes
cat("\n📅 Procesando ventas por MES...\n")
df_mes <- resumir_ventas(
  Coppel_all,
  df_hc,
  frecuencia = "mes",
  output_file = "PriceList_Coppel_All_by_mes.csv"
)

# 4️⃣ Resumen final
cat("\n\n")
cat(strrep("=", 50), "\n")
cat("✨ PROCESAMIENTO COMPLETADO ✨\n")
cat(strrep("=", 50), "\n")
cat(sprintf("📊 Total de registros procesados: %,d\n", nrow(Coppel_all)))
cat(sprintf("📊 Ventas totales: %,d unidades\n", sum(Coppel_all$SO, na.rm = TRUE)))
cat(sprintf("📊 Rango de fechas: %s a %s\n",
            min(Coppel_all$Date, na.rm = TRUE),
            max(Coppel_all$Date, na.rm = TRUE)))
cat("\n📁 Archivos generados:\n")
cat("   ✓ PriceList_Coppel_All_by_dia.csv\n")
cat("   ✓ PriceList_Coppel_All_by_semana.csv\n")
cat("   ✓ PriceList_Coppel_All_by_mes.csv\n")
cat(strrep("=", 50), "\n")

# Vista previa
cat("\n🔍 Vista previa de registros por frecuencia:\n")
cat(sprintf("   - Por día: %,d registros únicos\n", nrow(df_dia)))
cat(sprintf("   - Por semana: %,d registros únicos\n", nrow(df_semana)))
cat(sprintf("   - Por mes: %,d registros únicos\n", nrow(df_mes)))
