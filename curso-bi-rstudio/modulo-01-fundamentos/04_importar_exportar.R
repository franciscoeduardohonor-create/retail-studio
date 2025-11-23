# ============================================================================
# MÓDULO 1 - LECCIÓN 4: IMPORTAR Y EXPORTAR DATOS
# ============================================================================
# Objetivo: Aprender a leer y escribir datos en diferentes formatos
# ============================================================================

# En Business Intelligence, constantemente trabajamos con datos de diferentes
# fuentes: Excel, CSV, bases de datos, etc.
# Esta lección es FUNDAMENTAL para tu trabajo diario.

# ============================================================================
# 1. CONFIGURACIÓN DEL ENTORNO
# ============================================================================

# Instalar paquetes necesarios (ejecuta solo la primera vez)
# install.packages("readxl")   # Para leer Excel
# install.packages("writexl")  # Para escribir Excel
# install.packages("readr")    # Para CSV optimizado
# install.packages("data.table")  # Para archivos grandes

# Cargar librerías
library(readxl)
library(writexl)
library(readr)

# Ver directorio de trabajo actual
getwd()

# Cambiar directorio de trabajo si es necesario
# setwd("C:/mis_proyectos/bi_curso")  # Windows
# setwd("/Users/usuario/bi_curso")    # Mac/Linux

# Crear carpeta para datos si no existe
if (!dir.exists("datos")) {
  dir.create("datos")
}

# ============================================================================
# 2. ARCHIVOS CSV (COMMA-SEPARATED VALUES)
# ============================================================================

# CSV es el formato más común en análisis de datos
# Son archivos de texto plano con valores separados por comas

# -----------------------------------------------
# LEER ARCHIVOS CSV
# -----------------------------------------------

# Método 1: read.csv (base R)
# Asume que el separador es coma y el decimal es punto

# Ejemplo básico (cuando exista el archivo):
# datos <- read.csv("datos/ventas.csv")

# Crear datos de ejemplo para demostración
ventas_ejemplo <- data.frame(
  fecha = seq(as.Date("2024-01-01"), by = "day", length.out = 10),
  producto = rep(c("Laptop", "Mouse", "Teclado", "Monitor", "Webcam"), 2),
  cantidad = c(5, 15, 12, 8, 10, 7, 18, 14, 6, 11),
  precio_unitario = c(899.99, 25.50, 45.99, 199.99, 89.99,
                      899.99, 25.50, 45.99, 199.99, 89.99),
  vendedor = rep(c("Ana", "Carlos"), each = 5)
)

# Ver datos
ventas_ejemplo

# Guardar como CSV
write.csv(ventas_ejemplo, "datos/ventas_ejemplo.csv", row.names = FALSE)
# row.names = FALSE evita que se guarde una columna extra con números de fila

# Leer el CSV
datos_csv <- read.csv("datos/ventas_ejemplo.csv")
head(datos_csv)
str(datos_csv)

# Parámetros importantes de read.csv:
# - header: TRUE si la primera fila tiene nombres de columnas
# - sep: separador de columnas (por defecto ",")
# - dec: separador decimal (por defecto ".")
# - stringsAsFactors: si convierte texto a factor (FALSE recomendado)

# -----------------------------------------------
# LEER CSV CON read.csv2 (para formato europeo)
# -----------------------------------------------

# En algunos países se usa punto y coma (;) como separador
# y coma (,) como separador decimal

# write.csv2(ventas_ejemplo, "datos/ventas_europeo.csv", row.names = FALSE)
# datos_csv2 <- read.csv2("datos/ventas_europeo.csv")

# -----------------------------------------------
# LEER CSV CON readr (más rápido y moderno)
# -----------------------------------------------

# El paquete readr es más rápido y detecta mejor los tipos de datos

datos_readr <- read_csv("datos/ventas_ejemplo.csv")
head(datos_readr)

# Ventajas de read_csv:
# - Más rápido con archivos grandes
# - Mejor detección automática de tipos
# - Muestra progreso en archivos grandes
# - No convierte texto a factor automáticamente

# -----------------------------------------------
# LEER CON PARÁMETROS PERSONALIZADOS
# -----------------------------------------------

# Ejemplo con diferentes separadores
# datos <- read.csv(
#   "datos/archivo.csv",
#   header = TRUE,           # Primera fila son nombres
#   sep = ";",               # Separador punto y coma
#   dec = ",",               # Decimal con coma
#   encoding = "UTF-8",      # Codificación para acentos
#   stringsAsFactors = FALSE # No convertir a factor
# )

# ============================================================================
# 3. ARCHIVOS EXCEL
# ============================================================================

# Excel es muy común en ambientes corporativos

# -----------------------------------------------
# ESCRIBIR ARCHIVOS EXCEL
# -----------------------------------------------

# Crear data frame de ejemplo
empleados <- data.frame(
  id = 1:10,
  nombre = c("Ana García", "Carlos López", "Diana Martínez", "Eduardo Sánchez",
             "Fernanda Rodríguez", "Gabriel Hernández", "Isabel Torres",
             "Jorge Ramírez", "Laura Flores", "Miguel Castro"),
  departamento = c("Ventas", "IT", "Ventas", "RRHH", "IT",
                   "Marketing", "Ventas", "IT", "RRHH", "Marketing"),
  salario = c(3500, 4200, 3800, 3600, 4500, 3900, 3300, 4100, 3700, 4000),
  antiguedad = c(3, 5, 4, 6, 7, 2, 3, 8, 5, 4)
)

# Guardar en Excel (una sola hoja)
write_xlsx(empleados, "datos/empleados.xlsx")

# Guardar múltiples hojas en un archivo Excel
lista_datos <- list(
  "Empleados" = empleados,
  "Ventas" = ventas_ejemplo
)

write_xlsx(lista_datos, "datos/reporte_completo.xlsx")

# -----------------------------------------------
# LEER ARCHIVOS EXCEL
# -----------------------------------------------

# Leer la primera hoja
datos_excel <- read_excel("datos/empleados.xlsx")
head(datos_excel)

# Leer hoja específica por nombre
datos_empleados <- read_excel("datos/reporte_completo.xlsx", sheet = "Empleados")
datos_ventas <- read_excel("datos/reporte_completo.xlsx", sheet = "Ventas")

# Leer hoja específica por número (1, 2, 3...)
datos_hoja1 <- read_excel("datos/reporte_completo.xlsx", sheet = 1)

# Ver nombres de todas las hojas
excel_sheets("datos/reporte_completo.xlsx")

# Leer rango específico de celdas
# datos <- read_excel("archivo.xlsx", range = "A1:D10")
# datos <- read_excel("archivo.xlsx", range = "Ventas!A1:D10")

# Saltar filas al inicio
# datos <- read_excel("archivo.xlsx", skip = 2)  # Salta 2 filas

# ============================================================================
# 4. ARCHIVOS DE TEXTO (TXT)
# ============================================================================

# Archivos delimitados por tabuladores u otros separadores

# Crear ejemplo
texto_ejemplo <- data.frame(
  codigo = 1:5,
  descripcion = c("Producto A", "Producto B", "Producto C", "Producto D", "Producto E"),
  stock = c(100, 50, 75, 120, 30)
)

# Guardar con tabulador como separador
write.table(texto_ejemplo, "datos/productos.txt",
            sep = "\t", row.names = FALSE, quote = FALSE)

# Leer archivo de texto
datos_txt <- read.table("datos/productos.txt",
                        header = TRUE, sep = "\t")
datos_txt

# Leer con read.delim (específico para tabuladores)
datos_delim <- read.delim("datos/productos.txt")
datos_delim

# ============================================================================
# 5. ARCHIVOS RDS Y RData (FORMATOS NATIVOS DE R)
# ============================================================================

# RDS y RData son formatos nativos de R
# Ventajas: más rápidos, preservan tipos de datos exactos, compresión

# -----------------------------------------------
# RDS: guardar UN SOLO objeto
# -----------------------------------------------

# Guardar
saveRDS(empleados, "datos/empleados.rds")

# Cargar (asignándole un nombre)
empleados_cargados <- readRDS("datos/empleados.rds")
head(empleados_cargados)

# -----------------------------------------------
# RData: guardar MÚLTIPLES objetos
# -----------------------------------------------

# Crear varios objetos
ventas_2023 <- 150000
ventas_2024 <- 180000
clientes <- data.frame(
  id = 1:3,
  nombre = c("Empresa A", "Empresa B", "Empresa C")
)

# Guardar múltiples objetos
save(ventas_2023, ventas_2024, clientes, file = "datos/datos_empresa.RData")

# Limpiar entorno
rm(ventas_2023, ventas_2024, clientes)

# Cargar (restaura todos los objetos con sus nombres originales)
load("datos/datos_empresa.RData")
ventas_2023
ventas_2024
clientes

# ============================================================================
# 6. EXPORTAR DATOS
# ============================================================================

# -----------------------------------------------
# Exportar a CSV
# -----------------------------------------------

# Calcular resumen de ventas por producto
resumen_ventas <- aggregate(cantidad ~ producto, data = ventas_ejemplo, FUN = sum)
resumen_ventas

# Guardar resumen
write.csv(resumen_ventas, "datos/resumen_ventas.csv", row.names = FALSE)

# -----------------------------------------------
# Exportar a Excel con formato
# -----------------------------------------------

# Crear reporte
reporte_departamentos <- aggregate(salario ~ departamento,
                                   data = empleados, FUN = mean)
names(reporte_departamentos) <- c("Departamento", "Salario_Promedio")
reporte_departamentos

write_xlsx(reporte_departamentos, "datos/reporte_salarios.xlsx")

# ============================================================================
# 7. TRABAJAR CON ARCHIVOS GRANDES
# ============================================================================

# Para archivos muy grandes (millones de filas), usa data.table

# install.packages("data.table")
library(data.table)

# fread es extremadamente rápido
# datos_grandes <- fread("datos/archivo_enorme.csv")

# Leer solo ciertas columnas
# datos <- fread("archivo.csv", select = c("columna1", "columna2"))

# Leer solo N filas
# datos <- fread("archivo.csv", nrows = 1000)

# ============================================================================
# 8. MANEJO DE RUTAS Y DIRECTORIOS
# ============================================================================

# Listar archivos en un directorio
list.files("datos")

# Listar solo archivos CSV
list.files("datos", pattern = "\\.csv$")

# Listar solo archivos Excel
list.files("datos", pattern = "\\.xlsx$")

# Verificar si un archivo existe
file.exists("datos/ventas_ejemplo.csv")

# Obtener información del archivo
file.info("datos/ventas_ejemplo.csv")

# Crear directorio
if (!dir.exists("datos/reportes")) {
  dir.create("datos/reportes", recursive = TRUE)
}

# Eliminar archivo (¡CUIDADO!)
# file.remove("datos/archivo_temporal.csv")

# ============================================================================
# 9. BUENAS PRÁCTICAS
# ============================================================================

# 1. SIEMPRE usa rutas relativas (no absolutas)
# BIEN:   "datos/ventas.csv"
# MAL:    "C:/Users/Juan/Desktop/datos/ventas.csv"

# 2. Verifica que el archivo existe antes de leer
archivo <- "datos/ventas_ejemplo.csv"
if (file.exists(archivo)) {
  datos <- read.csv(archivo)
  print("Archivo cargado exitosamente")
} else {
  print("ERROR: Archivo no encontrado")
}

# 3. Usa row.names = FALSE al exportar CSV
# Evita columnas extra innecesarias

# 4. Define explícitamente stringsAsFactors = FALSE
# Para tener control sobre tipos de datos

# 5. Documenta la fuente de tus datos
# Usa comentarios para indicar de dónde vienen los datos

# ============================================================================
# EJERCICIO PRÁCTICO 1: IMPORTAR Y ANALIZAR
# ============================================================================

# 1. Lee el archivo empleados.xlsx
empleados_data <- read_excel("datos/empleados.xlsx")

# 2. Calcula el salario promedio por departamento
salario_por_depto <- aggregate(salario ~ departamento,
                               data = empleados_data, FUN = mean)
print("Salario promedio por departamento:")
print(salario_por_depto)

# 3. Encuentra el empleado con mayor salario
empleado_mayor_salario <- empleados_data[which.max(empleados_data$salario), ]
print("Empleado con mayor salario:")
print(empleado_mayor_salario)

# 4. Exporta los resultados a un nuevo Excel
write_xlsx(salario_por_depto, "datos/analisis_salarios.xlsx")

# ============================================================================
# EJERCICIO PRÁCTICO 2: PIPELINE COMPLETO
# ============================================================================

# Simula un flujo de trabajo real de BI:

# 1. Crear datos de transacciones
transacciones <- data.frame(
  fecha = seq(as.Date("2024-01-01"), by = "day", length.out = 30),
  monto = round(runif(30, 100, 1000), 2),
  categoria = sample(c("Electrónica", "Ropa", "Alimentos", "Hogar"), 30, replace = TRUE),
  cliente_id = sample(1:10, 30, replace = TRUE)
)

# 2. Exportar a CSV
write.csv(transacciones, "datos/transacciones.csv", row.names = FALSE)

# 3. Leer de nuevo (simula recibir datos)
datos_importados <- read.csv("datos/transacciones.csv")

# 4. Analizar
resumen_categoria <- aggregate(monto ~ categoria, data = datos_importados, FUN = sum)
resumen_categoria <- resumen_categoria[order(-resumen_categoria$monto), ]

# 5. Exportar resumen a Excel
write_xlsx(resumen_categoria, "datos/reporte_categorias.xlsx")

print("Pipeline completado:")
print(resumen_categoria)

# ============================================================================
# EJERCICIOS PARA PRACTICAR TÚ
# ============================================================================

# 1. Crea un data frame con datos de productos (código, nombre, precio, stock)
#    Guárdalo en CSV y Excel
#    Léelo de nuevo y verifica que los datos son correctos

# TU CÓDIGO AQUÍ:




# 2. Lee el archivo de empleados.xlsx
#    Filtra solo empleados del departamento "IT"
#    Guarda el resultado en un nuevo archivo Excel

# TU CÓDIGO AQUÍ:




# 3. Crea un reporte que combine datos de ventas_ejemplo.csv
#    con empleados.xlsx (usando el vendedor)
#    Calcula total de ventas por vendedor
#    Exporta a Excel

# TU CÓDIGO AQUÍ:




# ============================================================================
# ¡EXCELENTE TRABAJO!
# ============================================================================
# Ahora dominas:
# ✓ Importar datos desde CSV y Excel
# ✓ Exportar datos en diferentes formatos
# ✓ Manejar archivos RDS y RData
# ✓ Trabajar con rutas y directorios
# ✓ Implementar flujos de trabajo completos
#
# ¡Estás listo para el Módulo 2!
# ============================================================================
