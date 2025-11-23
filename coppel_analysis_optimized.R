#### 🚀 Limpieza inicial ####
rm(list = ls(all = TRUE)); if (length(dev.list()) > 0) dev.off()

#### 📚 Librerías ####
if (!require("pacman")) install.packages("pacman")
pacman::p_load(readr, stringr, dplyr, readxl, lubridate, purrr, tidyr, data.table)

#### 📂 Directorios y parámetros ####
root0 <- "C:"
root <- file.path(root0, "Users/FROJAS/Documents/HonorBI/B2B_Coppel_LVP/Codigo_COPPEL_LVP/Coppel/2025/Buenos/")
setwd(root)

nom_col <- c("Region", "Tienda", "clase", "Familia", "Marca", "Modelo", "Date", "SO")

# 🔹 Optimización: combinar todas las palabras a quitar en un único patrón regex
palabras_quitar <- c(
  # Colores
  "GREEN","BLUE","YELLOW","ORANGE","PURPLE","BLACK","WHITE","GRAY","PINK","GOLD","ROJO","AZUL","AMARILLO","NARANJA","VIOLETA","CIAN","PLATA","MORADO","NEGRO","BLANCO","ROSA","GRIS","COBRE","LIMA","PURPURA","LAVANDA","BEIGE","CAFE","LILA","MORA","SILVER","CORAL","DORADO","OSCURO","BRONCE","MENTA","CLARO","MARINO","AURORA","NATURAL","SIERRA","ALPINE","PROFUNDO","OBSCURO","PERLA","DEEP INDIGO","STARLIGHTH","STARLIGT","MIDNIGHTH","MIDNIGT","ULTRAMA","GLACIAR","MAGENTA","MULTICOLOR","SPACE","DEEP","GRAPHITE",
  # Variantes
  "MORAD","GRAFIT","GRAFITO","PLAT","VERD","AMARILL","AMARI","NARAN","LAVAN","AZU","BLAN","GRI","NEGR","NEG","NARA","NAT","BLA","NRNJ","VER","MOR","VIO",
  # Promociones
  "COMBO","COMB2","COMB","COM2","COM3","DUO","DUO3","BUNDLE","HBUNDLE","BUND","BUN","PROMO","KIT","RENATO","ESPECIAL","ESPE","MOCHILA",
  # Tecnología
  "IOTAIR3","IOT","W40","5G","4G","3G","64","128","256","512","12GB",
  # Otros
  "2020","CIA","PV","IU","BCO","STAR","OBS","MAR","/"
)

# Crear patrón único para optimizar (se usa una sola vez)
patron_palabras <- paste0("\\b(", paste(palabras_quitar, collapse = "|"), ")\\b")

#### 🧹 Funciones ####

# 🔹 Limpieza de nombres de modelo - OPTIMIZADA
limpiar_modelo <- function(Modelo) {
  Modelo %>%
    str_replace_all("\xa0", " ") %>%
    str_to_upper() %>%
    # Optimización: combinar múltiples patrones en una sola llamada
    str_remove_all(paste0(
      "\\b(\\d+GB|\\d+MB)\\b",                                                      # Capacidad
      "|\\b(2G|3G|4G|5G|GSM|4\\.5G|3-G)\\b",                                       # Redes
      "|", patron_palabras,                                                         # Palabras a quitar
      "|\\b(KIT|BUNDLE|IU|OTA|AIR4-BES)\\b",                                       # Palabras extra
      "|\\b\\w{3}-\\w{3}\\b",                                                       # Códigos XXX-YYY
      "|\\b(SM-[A-Z0-9]+|XT[0-9-]+|CPH[0-9]+|2[2-4][A-Z0-9]+|BRP-[A-Z0-9]+|RMX[0-9]+)\\b",  # Códigos específicos
      "|\\b[a-zA-Z]{2}\\b",                                                         # Palabras de 2 letras
      "|[[:punct:]/]"                                                               # Puntuación
    )) %>%
    str_squish()  # squish ya elimina espacios múltiples, no necesita str_replace_all
}

# 🔹 Lectura de archivos Coppel - OPTIMIZADA
leer_archivos_coppel <- function(mes) {
  cat(sprintf("Procesando M%02d\n", mes))
  archivos <- dir(pattern = sprintf("Coppel_SO_M%02d_.*", mes))

  if (length(archivos) == 0) {
    warning(sprintf("No se encontraron archivos para el mes %02d", mes))
    return(data.frame())
  }

  # Optimización: usar lapply en lugar de map para mejor rendimiento
  ldf <- lapply(archivos, function(f) {
    cat(sprintf("   Leyendo: %s\n", f))

    df <- read_excel(f, col_types = "text")
    names(df) <- nom_col

    # Optimización: convertir a numeric de forma más eficiente
    df$SO <- as.numeric(df$SO)

    # Optimización: manejo de fechas simplificado
    df$Date <- if (mes == 5) {
      as.Date(df$Date, format = "%m-%d-%Y")
    } else {
      as.Date(gsub("\\\\", "-", df$Date), format = "%d-%m-%Y")
    }

    # Limpieza de modelo aplicada una vez
    df$Modelo_Limpia <- limpiar_modelo(df$Modelo)

    return(df)
  })

  # Optimización: usar rbindlist de data.table (más rápido que bind_rows)
  rbindlist(ldf, fill = TRUE) %>% as_tibble()
}

# 🔹 Resumen de ventas - OPTIMIZADA
resumir_ventas <- function(df_ventas, df_hc, frecuencia = "semana", output_file) {

  # Optimización: operaciones encadenadas más eficientes
  df_ventas <- df_ventas %>%
    mutate(
      Date = as.Date(Date),
      Year = year(Date),
      # Calcular ambas frecuencias condicionalmente
      periodo = if (frecuencia == "semana") week(Date) else month(Date, label = TRUE, abbr = TRUE)
    )

  # Optimización: usar nombres dinámicos de forma más clara
  df_resumido <- df_ventas %>%
    group_by(Region, ID, Tienda, Familia, Marca, Modelo, Year, periodo) %>%
    summarise(Sales = sum(SO, na.rm = TRUE), .groups = "drop") %>%
    rename(!!frecuencia := periodo) %>%  # Renombrar al nombre correcto
    arrange(Year, !!sym(frecuencia))

  # Preparar HC - OPTIMIZADO
  names(df_hc) <- make.unique(names(df_hc))

  df_hc3 <- df_hc %>%
    filter(Customer == "COPPEL", RG %in% c("R1","R2","R3")) %>%
    select(ID, NAME, `ID used  in CHANNEL`, Estado, `FIXED PROMOTER`,
           `Promoter name`, `CM name`) %>%
    rename(ID_Honor = ID) %>%
    distinct(`ID used  in CHANNEL`, .keep_all = TRUE)

  # Join optimizado
  df_final <- df_resumido %>%
    left_join(df_hc3, by = c("ID" = "ID used  in CHANNEL"))

  # Exportar
  write_csv(df_final, output_file)
  cat(sprintf("✅ Archivo guardado: %s\n", output_file))

  return(df_final)
}

#### 📊 Ejecución ####

# Medir tiempo de ejecución
inicio <- Sys.time()

# 1️⃣ Leer y combinar todos los meses (OPTIMIZADO con progreso)
cat("\n📂 Leyendo archivos de meses 5-10...\n")
Coppel_all <- map_dfr(5:10, leer_archivos_coppel) %>%
  separate(Tienda, into = c("ID", "Tienda"), sep = "•", extra = "merge") %>%
  mutate(
    ID = trimws(ID),
    Tienda = trimws(Tienda),
    SO = as.numeric(SO),
    # Optimización: extraer Familia de forma más eficiente
    Familia = str_trim(str_split_fixed(Familia, "•", 2)[,2])
  )

cat(sprintf("✅ Registros leídos: %s\n", format(nrow(Coppel_all), big.mark = ",")))

# 2️⃣ Cargar HC
cat("\n📂 Cargando archivo HC...\n")
hc_path <- file.path(root0, "Users/FROJAS/Documents/HonorBI/B2B_Coppel_LVP/Codigo_COPPEL_LVP/HC_W44_October_Final.csv")

df_hc <- read.csv(hc_path, header = FALSE)
names(df_hc) <- df_hc[1,]
df_hc <- df_hc[-1,]
names(df_hc)[12] <- 'Direccion'

cat(sprintf("✅ Registros HC: %s\n", format(nrow(df_hc), big.mark = ",")))

# 3️⃣ Resumir ventas
cat("\n📊 Resumiendo ventas...\n")
frec <- "semana" # "semana" o "mes"
output <- sprintf("PriceList_Coppel_All_by_%s.csv", frec)

df_final <- resumir_ventas(Coppel_all, df_hc, frecuencia = frec, output_file = output)

# Tiempo total
fin <- Sys.time()
cat(sprintf("\n⏱️  Tiempo total: %.2f segundos\n", as.numeric(difftime(fin, inicio, units = "secs"))))
cat(sprintf("✅ Procesamiento completo. Registros finales: %s\n", format(nrow(df_final), big.mark = ",")))
