#### 🚀 Limpieza inicial ####
rm(list = ls(all = TRUE)); if (length(dev.list()) > 0) dev.off()

#### 📚 Librerías ####
if (!require("pacman")) install.packages("pacman")
pacman::p_load(readr, stringr, dplyr, readxl, lubridate, purrr, data.table)

#### 📂 Directorios y parámetros ####
# CONFIGURACIÓN: Cambiar estas rutas según tu sistema
root0 <- 'C:'
root <- file.path(root0, "Users/FROJAS/Documents/HonorBI/B2B_Coppel_LVP/datos_telcel/Telcel/CrudBase/2025/Junto")
setwd(root)

#### 📋 Variables ####
# Semanas a procesar
weeks <- 20:44
name_data_telcel <- "Telcel_WK20-44_R1"

# Nombres de columnas
nom_col <- c('Region', 'Canal', 'Sector', 'Venta', 'Nombre_Venta', 'Material',
             'Descripcion', 'Marca', 'Fecha', 'Cantidad', 'Precio')

# 🔹 Optimización: Lista de palabras a eliminar
palabras_quitar <- c(
  # Colores (español e inglés)
  "RED", "GREEN", "BLUE", "YELLOW", "ORANGE", "PURPLE", "BLACK", "WHITE", "GRAY", "PINK", "GOLD",
  "ROJO", "AZUL", "AMARILLO", "NARANJA", "VIOLETA", "CIAN", "CYAN", "PLATA", "MORADO", "NEGRO",
  "BLANCO", "ROSA", "GRIS", "COBRE", "LIMA", "PURPURA", "LAVANDA", "BEIGE", "MOKA", "CAFE", "LILA",
  "MORA", "SILVER", "CORAL", "DORADO", "OSCURO", "BRONCE", "MENTA", "CLARO", "MARINO", "AURORA",
  "NATURAL", "SIERRA", "ALPINE", "PROFUNDO", "OBSCURO", "PERLA", "DEEP INDIGO", "STARLIGHTH",
  "STARLIGT", "MIDNIGHTH", "MIDNIGT", "ULTRAMA", "PACIFIC", "GLACIAR", "MAGENTA", "MULTICOLOR",
  "SPACE", "DEEP", "GRAPHITE", "VERDE", "TITANIO", "STARLIGTH", "STARLIGHT", "MIDNIGTH", "DESIERTO",
  "GRAFITO", "MIDNIGHT", "DESIERT",

  # Variantes, tonos y errores tipográficos
  "MORAD", "GRAFIT", "PLAT", "VERD", "AMARILL", "AMARI", "VIOLET", "NARANJ", "NARAN", "LAVAN",
  "AZU", "BLAN", "GRI", "NEGR", "NEG", "NARA", "NAT", "OBSCU", "BLA", "NRNJ", "VER", "MOR", "VIO",
  "NEO", "MENT", "MEN", "PLA", "CORE", "COBR", "VDE", "BEIG", "CLA",

  # Combos, bundles y promociones
  "COMBO2", "COMBO", "COMB2", "COMB", "COM2", "COM3", "DUO", "DUO3", "HBUNDLE", "BUNDLE", "HBUNDL",
  "BUND", "BUN", "PROMO", "KIT", "RENATO", "ESPECIAL", "ESPE", "MOCHILA",

  # Tecnología y capacidad
  "IOTAIR3", "IOT", "W40", "LTE", "5G", "4G", "3G", "64", "128", "256", "512", "12GB", "1TB", "4/64",

  # Códigos y siglas
  "2020", "CIA", "PV", "IU", "BCO", "STAR", "OBS", "MAR", "/"
)

# 🔹 Crear patrón único para optimizar (se construye una sola vez)
patron_palabras <- paste0("\\b(", paste(palabras_quitar, collapse = "|"), ")\\b")

#### 🧹 Funciones Optimizadas ####

# 🔹 Procesar un archivo de Excel
procesar_archivo <- function(archivo) {
  df <- read_excel(archivo)
  names(df) <- nom_col
  df %>% select(-c('Canal', 'Material'))
}

# 🔹 Limpieza de descripciones - OPTIMIZADA
limpiar_descripcion <- function(descripcion) {
  # Optimización: combinar todas las operaciones de limpieza en una sola llamada str_remove_all
  descripcion %>%
    str_replace_all("\xa0", " ") %>%
    toupper() %>%
    str_remove_all(paste0(
      "\\b(\\d+GB|\\d+MB)\\b",                                                      # Tamaños de almacenamiento
      "|\\b(2G|3G|4G|5G|GSM|4\\.5G|3-G)\\b",                                       # Redes móviles
      "|", patron_palabras,                                                         # Palabras a quitar
      "|\\b(KIT|BUNDLE|IU|OTA|AIR4-BES)\\b",                                       # Etiquetas irrelevantes
      "|/",                                                                         # Barras
      "|\\b\\w{3}-\\w{3}\\b",                                                       # Códigos XXX-YYY
      "|\\b(SM-[A-Z0-9]+|XT[0-9-]+|CPH[0-9]+|2[2-5][A-Z0-9]+|BRP-[A-Z0-9]+|RMX[0-9]+)\\b",  # Códigos técnicos
      "|\\b[a-zA-Z]{2}\\b",                                                         # Palabras de 2 letras
      "|[[:punct:]/]"                                                               # Puntuación
    )) %>%
    str_squish()  # Normalizar espacios (más eficiente que str_replace_all + str_trim)
}

# 🔹 Resumir ventas por semana o mes - OPTIMIZADA
resumir_ventas <- function(df_ventas, df_tiendas_telcel, df_tiendas, frecuencia = "semana", output_file) {

  # Convertir fechas y preparar periodo
  df_ventas <- df_ventas %>%
    mutate(
      DATE = as.Date(DATE),
      Year = year(DATE),
      # 🔹 Optimización: calcular periodo condicionalmente en una sola operación
      periodo = if (frecuencia == "semana") week(DATE) else month(DATE, label = TRUE)
    )

  # Resumir datos por periodo
  df_resumido <- df_ventas %>%
    group_by(Venta, Modelos, Marca, Precio, Year, periodo) %>%
    summarise(Sales = sum(Cantidad, na.rm = TRUE), .groups = "drop") %>%
    rename(!!frecuencia := periodo) %>%  # Renombrar dinámicamente
    arrange(Year, !!sym(frecuencia))

  # Preparar datos de tiendas
  df_tiendas_13 <- df_tiendas %>%
    filter(RG %in% c('R1', 'R2', 'R3'), Custumer == 'TELCEL')

  df_hc3 <- df_tiendas_13 %>%
    select(ID, NAME, Estado, `FIXED PROMOTER`, `Promoter name`, `CM name`) %>%
    distinct(NAME, .keep_all = TRUE)

  # 🔹 Optimización: usar left_join en lugar de match manual
  df_tiendas_telcel <- df_tiendas_telcel %>%
    left_join(
      df_hc3 %>% select(-ID),  # Evitar conflicto con ID
      by = c("Name_Honor" = "NAME")
    ) %>%
    mutate(ID_Honor = df_hc3$ID[match(Name_Honor, df_hc3$NAME)])

  # Añadir columnas al dataframe resumido
  df_resumido <- df_resumido %>%
    left_join(df_tiendas_telcel, by = c("Venta" = "Tiendas_Telcel"))

  # 🔹 Optimización: usar write_csv en lugar de write.table (más rápido)
  write_csv(df_resumido, output_file)
  cat(sprintf("✅ Archivo guardado: %s\n", output_file))

  return(df_resumido)
}

#### 📊 Procesamiento Principal ####

cat("\n" %>% paste0(rep("=", 60), collapse = "") %>% paste0("\n"))
cat("🚀 ANÁLISIS DE VENTAS TELCEL\n")
cat(rep("=", 60) %>% paste0(collapse = "") %>% paste0("\n\n"))

# Medir tiempo de ejecución
inicio <- Sys.time()

# 1️⃣ Procesar todas las semanas
cat(sprintf("📂 Procesando semanas %d a %d...\n\n", min(weeks), max(weeks)))

# 🔹 Optimización: usar rbindlist en lugar de bind_rows
telcel_all <- lapply(weeks, function(wk) {
  cat(sprintf("Procesando Semana %02d\n", wk))

  # Obtener archivos de la semana
  patron <- sprintf("Telcel_WK%02d_*", wk)
  archivos <- dir(pattern = patron)

  if (length(archivos) == 0) {
    warning(sprintf("No se encontraron archivos para la semana %d", wk))
    return(NULL)
  }

  cat(sprintf("   Encontrados %d archivos\n", length(archivos)))

  # Procesar archivos de la semana
  df_semana <- lapply(archivos, function(archivo) {
    region <- which(archivos == archivo)
    cat(sprintf("   Procesando Región %d: %s\n", region, archivo))
    procesar_archivo(archivo)
  }) %>% rbindlist(fill = TRUE)  # 🔹 Más rápido que bind_rows

  # Limpiar descripciones
  df_semana$Modelos <- limpiar_descripcion(df_semana$Descripcion)

  return(as.data.frame(df_semana))
}) %>%
  rbindlist(fill = TRUE) %>%
  as_tibble()

# Agregar columna de semana
telcel_all$Week <- week(telcel_all$Fecha)

cat(sprintf("\n✅ Procesamiento completo. Total de registros: %s\n",
            format(nrow(telcel_all), big.mark = ",")))

# 2️⃣ Guardar archivo completo
cat("\n💾 Guardando archivo completo...\n")
archivo_completo <- file.path(
  root0,
  "Users/FROJAS/Documents/HonorBI/B2B_Coppel_LVP/datos_telcel/Telcel/DBBueno",
  sprintf("PriceList_telcel_%s.csv", name_data_telcel)
)

write_csv(telcel_all, archivo_completo)
cat(sprintf("✅ Archivo guardado: %s\n", archivo_completo))

#### 📊 Uso de la función resumir ####

cat("\n📂 Cargando datos de tiendas...\n")

# Cargar archivos de tiendas
df_tiendas_telcel <- read_excel(file.path(
  root0,
  "Users/FROJAS/Documents/HonorBI/B2B_Coppel_LVP/datos_telcel/Telcel/TiendasHC/Tiendas_Telcel.csv.xlsx"
))

df_tiendas <- read_csv(
  file.path(root0, "Users/FROJAS/Documents/HonorBI/B2B_Coppel_LVP/datos_telcel/Telcel/TiendasHC/Tiendas.csv"),
  col_names = TRUE
)
names(df_tiendas)[2] <- "Custumer"

# Renombrar columna de fecha
names(telcel_all)[7] <- "DATE"
df_ventas <- telcel_all

# 3️⃣ Resumir ventas
cat("\n📊 Generando resumen de ventas...\n")
frec <- "semana"  # Cambiar a "mes" si se desea
name_file <- file.path(
  root0,
  "Users/FROJAS/Documents/HonorBI/B2B_Coppel_LVP/datos_telcel/Telcel/DBBueno",
  sprintf("PriceList_telcel_All_by_%s.csv", frec)
)

df_resumido <- resumir_ventas(df_ventas, df_tiendas_telcel, df_tiendas,
                               frecuencia = frec, output_file = name_file)

# Tiempo total
fin <- Sys.time()
tiempo_total <- as.numeric(difftime(fin, inicio, units = "secs"))

cat("\n" %>% paste0(rep("=", 60), collapse = "") %>% paste0("\n"))
cat(sprintf("⏱️  Tiempo total: %.2f segundos\n", tiempo_total))
cat(sprintf("✅ Procesamiento resumido de '%s' completo\n", frec))
cat(sprintf("✅ Registros finales: %s\n", format(nrow(df_resumido), big.mark = ",")))
cat(rep("=", 60) %>% paste0(collapse = "") %>% paste0("\n\n"))
