# ============================================================================
# MÓDULO 7: PROGRAMACIÓN AVANZADA EN R
# ============================================================================
# Aprenderás técnicas avanzadas: apply, programación funcional, y más

# ============================================================================
# 1. FAMILIA APPLY
# ============================================================================

# APPLY - Aplica función a filas o columnas de matriz
matriz <- matrix(1:12, nrow = 3, ncol = 4)
print(matriz)

# Suma por filas (MARGIN = 1)
apply(matriz, 1, sum)

# Suma por columnas (MARGIN = 2)
apply(matriz, 2, sum)

# Media por columnas
apply(matriz, 2, mean)

# Función personalizada
apply(matriz, 1, function(x) max(x) - min(x))

# LAPPLY - Aplica función a lista, devuelve lista
lista_numeros <- list(a = 1:5, b = 6:10, c = 11:15)
lapply(lista_numeros, sum)
lapply(lista_numeros, mean)

# SAPPLY - Como lapply pero simplifica el resultado
sapply(lista_numeros, sum)    # Devuelve vector
sapply(lista_numeros, mean)

# VAPPLY - Como sapply pero especificas el tipo de salida
vapply(lista_numeros, sum, FUN.VALUE = numeric(1))

# MAPPLY - Apply multivariado
x <- 1:5
y <- 6:10
mapply(function(a, b) a + b, x, y)

# TAPPLY - Aplica función a subgrupos
# Datos de ejemplo
ventas <- c(100, 150, 200, 120, 180, 220)
region <- c("Norte", "Sur", "Norte", "Sur", "Norte", "Sur")

tapply(ventas, region, mean)  # Media por región
tapply(ventas, region, sum)   # Suma por región

# ============================================================================
# 2. PROGRAMACIÓN FUNCIONAL CON PURRR
# ============================================================================

# install.packages("purrr")
library(purrr)

# MAP - Equivalente a lapply
numeros <- list(1:5, 6:10, 11:15)
map(numeros, mean)

# MAP_DBL - Devuelve vector numérico
map_dbl(numeros, mean)

# MAP_CHR - Devuelve vector de caracteres
nombres <- list("ana", "juan", "maria")
map_chr(nombres, toupper)

# MAP2 - Iterar sobre dos listas
x <- list(1, 2, 3)
y <- list(10, 20, 30)
map2_dbl(x, y, ~ .x + .y)

# WALK - Como map pero para efectos secundarios (print, write, etc.)
walk(1:3, print)

# ============================================================================
# 3. FUNCIONES ANÓNIMAS (LAMBDA)
# ============================================================================

# Forma tradicional
lapply(1:5, function(x) x^2)

# Forma corta con fórmula (purrr)
map_dbl(1:5, ~ .x^2)

# Múltiples argumentos
map2_dbl(1:5, 6:10, ~ .x * .y)

# ============================================================================
# 4. COMPOSICIÓN DE FUNCIONES
# ============================================================================

# Crear funciones pequeñas y componibles
duplicar <- function(x) x * 2
sumar_diez <- function(x) x + 10
elevar_cuadrado <- function(x) x^2

# Componer funciones manualmente
resultado <- elevar_cuadrado(sumar_diez(duplicar(5)))
print(resultado)  # ((5*2) + 10)^2 = 400

# Usando pipes
library(magrittr)
5 %>%
  duplicar() %>%
  sumar_diez() %>%
  elevar_cuadrado()

# ============================================================================
# 5. MANEJO DE ERRORES
# ============================================================================

# TRY - Capturar errores
resultado <- try({
  x <- 10
  y <- 0
  x / y
}, silent = TRUE)

if (class(resultado) == "try-error") {
  print("Hubo un error")
}

# TRYCATCH - Manejo más sofisticado
division_segura <- function(x, y) {
  tryCatch(
    {
      resultado <- x / y
      return(resultado)
    },
    error = function(e) {
      message("Error: ", e$message)
      return(NA)
    },
    warning = function(w) {
      message("Advertencia: ", w$message)
      return(NULL)
    }
  )
}

division_segura(10, 2)   # 5
division_segura(10, 0)   # NA con mensaje

# SAFELY (purrr) - Wrapper seguro
safe_log <- safely(log)
safe_log(10)     # Lista con resultado y error NULL
safe_log("abc")  # Lista con NULL y mensaje de error

# ============================================================================
# 6. OPERADORES ESPECIALES
# ============================================================================

# %in% - Pertenencia
5 %in% c(1, 3, 5, 7)  # TRUE
6 %in% c(1, 3, 5, 7)  # FALSE

# %% - Módulo (residuo)
10 %% 3  # 1

# %/% - División entera
10 %/% 3  # 3

# %*% - Multiplicación matricial
A <- matrix(1:4, 2, 2)
B <- matrix(5:8, 2, 2)
A %*% B

# %>% - Pipe (ya visto)
# %<>% - Pipe con asignación
library(magrittr)
x <- c(1, 2, 3, 4, 5)
x %<>% sqrt() %>% round(2)

# ============================================================================
# 7. PROGRAMACIÓN ORIENTADA A OBJETOS (S3)
# ============================================================================

# Crear una clase S3 simple
crear_estudiante <- function(nombre, edad, calificaciones) {
  estudiante <- list(
    nombre = nombre,
    edad = edad,
    calificaciones = calificaciones
  )
  class(estudiante) <- "Estudiante"
  return(estudiante)
}

# Método print personalizado
print.Estudiante <- function(obj) {
  cat("Estudiante:", obj$nombre, "\n")
  cat("Edad:", obj$edad, "\n")
  cat("Promedio:", mean(obj$calificaciones), "\n")
}

# Método summary personalizado
summary.Estudiante <- function(obj) {
  cat("=== Resumen del Estudiante ===\n")
  cat("Nombre:", obj$nombre, "\n")
  cat("Edad:", obj$edad, "\n")
  cat("Número de calificaciones:", length(obj$calificaciones), "\n")
  cat("Promedio:", mean(obj$calificaciones), "\n")
  cat("Mejor nota:", max(obj$calificaciones), "\n")
  cat("Peor nota:", min(obj$calificaciones), "\n")
}

# Usar la clase
alumno <- crear_estudiante("Ana García", 20, c(85, 90, 88, 92))
print(alumno)
summary(alumno)

# ============================================================================
# 8. EXPRESIONES REGULARES (REGEX)
# ============================================================================

# grep - Buscar patrón
textos <- c("apple", "banana", "apricot", "cherry")
grep("^a", textos)              # Índices que empiezan con "a"
grep("^a", textos, value = TRUE)  # Valores que empiezan con "a"

# grepl - Devuelve lógico
grepl("^a", textos)

# sub - Reemplazar primera ocurrencia
sub("a", "X", "banana")  # "bXnana"

# gsub - Reemplazar todas las ocurrencias
gsub("a", "X", "banana")  # "bXnXnX"

# Ejemplos prácticos
emails <- c("user@example.com", "invalid", "test@test.org")
grepl("@.*\\.", emails)  # Validación simple de email

# Extraer números
texto <- "Precio: $123.45"
gsub("[^0-9.]", "", texto)  # "123.45"

# ============================================================================
# 9. LECTURA Y ESCRITURA DE ARCHIVOS
# ============================================================================

# CSV
# write.csv(data, "archivo.csv", row.names = FALSE)
# datos <- read.csv("archivo.csv")

# RDS (formato nativo de R, más eficiente)
# saveRDS(objeto, "archivo.rds")
# objeto <- readRDS("archivo.rds")

# Excel (requiere paquete)
# library(readxl)
# datos <- read_excel("archivo.xlsx")

# library(writexl)
# write_xlsx(datos, "archivo.xlsx")

# ============================================================================
# 10. EJEMPLO INTEGRADOR AVANZADO
# ============================================================================

# Sistema de procesamiento de ventas
library(dplyr)
library(purrr)

# Datos de múltiples tiendas
tiendas <- list(
  tienda1 = data.frame(
    producto = c("A", "B", "C"),
    ventas = c(100, 150, 120),
    precio = c(10, 15, 12)
  ),
  tienda2 = data.frame(
    producto = c("A", "B", "C"),
    ventas = c(120, 130, 140),
    precio = c(10, 15, 12)
  ),
  tienda3 = data.frame(
    producto = c("A", "B", "C"),
    ventas = c(90, 160, 110),
    precio = c(10, 15, 12)
  )
)

# Procesar cada tienda
procesar_tienda <- function(df, nombre_tienda) {
  df %>%
    mutate(
      ingreso = ventas * precio,
      tienda = nombre_tienda
    )
}

# Aplicar a todas las tiendas
resultados <- map2(tiendas, names(tiendas), procesar_tienda)

# Combinar todas las tiendas
todos_datos <- bind_rows(resultados)

# Análisis consolidado
analisis_final <- todos_datos %>%
  group_by(producto) %>%
  summarise(
    ventas_totales = sum(ventas),
    ingreso_total = sum(ingreso),
    precio_promedio = mean(precio),
    num_tiendas = n_distinct(tienda)
  ) %>%
  arrange(desc(ingreso_total))

print(analisis_final)

# Usar safely para procesamiento robusto
procesar_seguro <- safely(procesar_tienda)
resultados_seguros <- map2(tiendas, names(tiendas), procesar_seguro)

# Extraer resultados exitosos
resultados_ok <- map(resultados_seguros, "result") %>%
  compact()  # Elimina NULL

# ============================================================================
# CONSEJOS AVANZADOS
# ============================================================================

# 1. Usa apply para operaciones vectorizadas eficientes
# 2. Prefiere purrr::map sobre lapply para código más legible
# 3. Usa tryCatch para manejo de errores en producción
# 4. Las expresiones regulares son poderosas, úsalas con cuidado
# 5. POO en R es útil para crear APIs consistentes

print("\n¡FELICIDADES!")
print("Has completado el curso de R desde principiante hasta avanzado")
print("Ahora tienes las herramientas para ser un experto en R")
