# =============================================================================
# MÓDULO 2: MANIPULACIÓN DE DATOS
# Lección 2: tidyr - Reestructuración de datos
# =============================================================================

# tidyr ayuda a crear datos "ordenados" (tidy data)
# Principios de tidy data:
# 1. Cada variable es una columna
# 2. Cada observación es una fila
# 3. Cada tipo de unidad observacional es una tabla

# CONTENIDO:
# 1. pivot_longer() - De ancho a largo
# 2. pivot_wider() - De largo a ancho
# 3. separate() y unite() - Separar y unir columnas
# 4. drop_na() y fill() - Manejo de valores faltantes

# =============================================================================
# INSTALACIÓN Y CARGA
# =============================================================================

# install.packages("tidyr")  # Descomenta si no lo tienes instalado
library(tidyr)
library(dplyr)

# =============================================================================
# 1. PIVOT_LONGER - Convertir de formato ancho a largo
# =============================================================================

# Datos en formato "ancho" (cada mes es una columna)
ventas_ancho <- data.frame(
  producto = c("Laptop", "Mouse", "Teclado"),
  enero = c(100, 250, 180),
  febrero = c(120, 230, 200),
  marzo = c(110, 270, 190)
)

print("Formato ANCHO:")
print(ventas_ancho)

# Convertir a formato "largo" (una fila por mes-producto)
ventas_largo <- ventas_ancho %>%
  pivot_longer(
    cols = c(enero, febrero, marzo),    # Columnas a transformar
    names_to = "mes",                   # Nombre de la columna para los nombres
    values_to = "ventas"                # Nombre de la columna para los valores
  )

print("Formato LARGO:")
print(ventas_largo)

# Otra forma: seleccionar columnas excluyendo
ventas_largo2 <- ventas_ancho %>%
  pivot_longer(
    cols = -producto,                   # Todas excepto 'producto'
    names_to = "mes",
    values_to = "ventas"
  )

# Ejemplo con datos de temperaturas
temperaturas_ancho <- data.frame(
  ciudad = c("CDMX", "Guadalajara", "Monterrey"),
  temp_min = c(12, 15, 10),
  temp_max = c(25, 30, 28)
)

print(temperaturas_ancho)

temperaturas_largo <- temperaturas_ancho %>%
  pivot_longer(
    cols = starts_with("temp_"),
    names_to = "tipo_temperatura",
    values_to = "grados"
  )

print(temperaturas_largo)

# EJERCICIO 1: Tienes estos datos de calificaciones
calificaciones_ancho <- data.frame(
  estudiante = c("Ana", "Luis", "María"),
  matematicas = c(85, 90, 88),
  ciencias = c(92, 87, 95),
  historia = c(78, 85, 90)
)
# Convierte a formato largo con columnas: estudiante, materia, calificacion
# Tu código aquí:




# =============================================================================
# 2. PIVOT_WIDER - Convertir de formato largo a ancho
# =============================================================================

# El proceso inverso: de largo a ancho
ventas_largo_ejemplo <- data.frame(
  producto = c("Laptop", "Laptop", "Mouse", "Mouse", "Teclado", "Teclado"),
  mes = c("enero", "febrero", "enero", "febrero", "enero", "febrero"),
  ventas = c(100, 120, 250, 230, 180, 200)
)

print("Formato LARGO:")
print(ventas_largo_ejemplo)

# Convertir a ancho
ventas_ancho_resultado <- ventas_largo_ejemplo %>%
  pivot_wider(
    names_from = mes,        # De qué columna sacar los nombres
    values_from = ventas     # De qué columna sacar los valores
  )

print("Formato ANCHO:")
print(ventas_ancho_resultado)

# Ejemplo: datos de encuestas
respuestas <- data.frame(
  persona = c("Juan", "Juan", "Ana", "Ana", "Luis", "Luis"),
  pregunta = c("edad", "salario", "edad", "salario", "edad", "salario"),
  respuesta = c(25, 30000, 28, 35000, 30, 40000)
)

print(respuestas)

respuestas_ancho <- respuestas %>%
  pivot_wider(
    names_from = pregunta,
    values_from = respuesta
  )

print(respuestas_ancho)

# EJERCICIO 2: Convierte este data frame a formato ancho
datos_largo <- data.frame(
  tienda = c("A", "A", "B", "B", "C", "C"),
  metrica = c("ventas", "gastos", "ventas", "gastos", "ventas", "gastos"),
  valor = c(10000, 7000, 12000, 8000, 9000, 6500)
)
# Resultado esperado: tienda | ventas | gastos
# Tu código aquí:




# =============================================================================
# 3. SEPARATE - Separar una columna en múltiples
# =============================================================================

# Separar una columna que contiene múltiples datos
datos_combinados <- data.frame(
  id = 1:4,
  nombre_completo = c("Ana López", "Luis García", "María Torres", "Carlos Ruiz"),
  fecha_venta = c("2024-01-15", "2024-02-20", "2024-03-10", "2024-04-05")
)

print(datos_combinados)

# Separar nombre en nombre y apellido
datos_separados <- datos_combinados %>%
  separate(
    col = nombre_completo,              # Columna a separar
    into = c("nombre", "apellido"),     # Nuevas columnas
    sep = " "                           # Separador
  )

print(datos_separados)

# Separar fecha en año, mes, día
datos_fecha <- datos_separados %>%
  separate(
    col = fecha_venta,
    into = c("año", "mes", "dia"),
    sep = "-"
  )

print(datos_fecha)

# Mantener la columna original con remove = FALSE
datos_con_original <- datos_combinados %>%
  separate(
    col = nombre_completo,
    into = c("nombre", "apellido"),
    sep = " ",
    remove = FALSE                      # No eliminar la columna original
  )

print(datos_con_original)

# EJERCICIO 3: Separa esta columna
productos <- data.frame(
  codigo = c("ELEC-001", "ROPA-045", "ALIM-123", "ELEC-002"),
  precio = c(1500, 450, 80, 2300)
)
# Separa 'codigo' en 'categoria' y 'numero'
# Tu código aquí:




# =============================================================================
# 4. UNITE - Unir múltiples columnas en una
# =============================================================================

# El proceso inverso a separate()
datos_para_unir <- data.frame(
  nombre = c("Ana", "Luis", "María"),
  apellido = c("López", "García", "Torres"),
  año = c(2024, 2024, 2024),
  mes = c("01", "02", "03"),
  dia = c("15", "20", "10")
)

print(datos_para_unir)

# Unir nombre y apellido
datos_unidos <- datos_para_unir %>%
  unite(
    col = "nombre_completo",            # Nueva columna
    nombre, apellido,                   # Columnas a unir
    sep = " "                           # Separador
  )

print(datos_unidos)

# Unir fecha
datos_con_fecha <- datos_unidos %>%
  unite(
    col = "fecha",
    año, mes, dia,
    sep = "-"
  )

print(datos_con_fecha)

# Mantener columnas originales con remove = FALSE
datos_mantener <- datos_para_unir %>%
  unite(
    col = "nombre_completo",
    nombre, apellido,
    sep = " ",
    remove = FALSE
  )

print(datos_mantener)

# EJERCICIO 4: Une estas columnas
direccion <- data.frame(
  calle = c("5 de Mayo", "Reforma", "Juárez"),
  numero = c("123", "456", "789"),
  ciudad = c("CDMX", "Guadalajara", "Monterrey")
)
# Crea una columna 'direccion_completa' que combine calle, numero, ciudad
# Tu código aquí:




# =============================================================================
# 5. MANEJO DE VALORES FALTANTES
# =============================================================================

# Datos con valores faltantes (NA)
datos_na <- data.frame(
  producto = c("A", "B", "C", "D", "E"),
  precio = c(100, NA, 150, NA, 200),
  stock = c(50, 30, NA, 40, 60),
  categoria = c("X", "Y", NA, "X", "Y")
)

print(datos_na)

# drop_na() - Eliminar filas con NA

# Eliminar filas con NA en cualquier columna
sin_na_completo <- datos_na %>%
  drop_na()
print(sin_na_completo)

# Eliminar filas con NA solo en columnas específicas
sin_na_precio <- datos_na %>%
  drop_na(precio)
print(sin_na_precio)

# replace_na() - Reemplazar NA con un valor específico
datos_reemplazados <- datos_na %>%
  mutate(
    precio = replace_na(precio, 0),
    stock = replace_na(stock, 0)
  )
print(datos_reemplazados)

# fill() - Rellenar NA con valores anteriores o siguientes
datos_secuencia <- data.frame(
  dia = 1:7,
  temperatura = c(20, 22, NA, NA, 25, NA, 27)
)

print(datos_secuencia)

# Rellenar hacia abajo (con el valor anterior)
relleno_abajo <- datos_secuencia %>%
  fill(temperatura, .direction = "down")
print(relleno_abajo)

# Rellenar hacia arriba (con el valor siguiente)
relleno_arriba <- datos_secuencia %>%
  fill(temperatura, .direction = "up")
print(relleno_arriba)

# EJERCICIO 5: Trabaja con valores faltantes
datos_ejercicio <- data.frame(
  id = 1:6,
  valor_a = c(10, NA, 30, NA, 50, 60),
  valor_b = c(NA, 20, 30, 40, NA, 60)
)
# 1. Elimina filas con NA en valor_a
# 2. Reemplaza NA en valor_b con 0
# Tu código aquí:




# =============================================================================
# EJEMPLO PRÁCTICO COMPLETO: REESTRUCTURACIÓN DE DATOS DE VENTAS
# =============================================================================

# Datos originales en formato ancho
ventas_mensuales <- data.frame(
  region = c("Norte", "Sur", "Este", "Oeste"),
  vendedor = c("Juan", "Ana", "Luis", "María"),
  ene = c(10000, 12000, 11000, 13000),
  feb = c(11000, 13000, 10500, 14000),
  mar = c(12000, 14000, 12500, 15000)
)

print("DATOS ORIGINALES:")
print(ventas_mensuales)

# Análisis: Convertir a formato largo para análisis
analisis <- ventas_mensuales %>%
  # 1. Convertir a formato largo
  pivot_longer(
    cols = c(ene, feb, mar),
    names_to = "mes",
    values_to = "ventas"
  ) %>%
  # 2. Calcular crecimiento mes a mes por vendedor
  group_by(vendedor) %>%
  mutate(
    venta_anterior = lag(ventas),       # Venta del mes anterior
    crecimiento = ventas - venta_anterior,
    porcentaje_crecimiento = round((crecimiento / venta_anterior) * 100, 2)
  ) %>%
  # 3. Filtrar solo datos con crecimiento calculado
  filter(!is.na(crecimiento))

print("ANÁLISIS DE CRECIMIENTO:")
print(analisis)

# Resumen por vendedor
resumen_vendedor <- analisis %>%
  group_by(vendedor) %>%
  summarise(
    ventas_totales = sum(ventas),
    crecimiento_promedio = mean(porcentaje_crecimiento),
    mejor_mes = mes[which.max(ventas)]
  ) %>%
  arrange(desc(ventas_totales))

print("RESUMEN POR VENDEDOR:")
print(resumen_vendedor)

# =============================================================================
# RESUMEN DE LA LECCIÓN
# =============================================================================
# ✓ pivot_longer(): ancho → largo
# ✓ pivot_wider(): largo → ancho
# ✓ separate(): dividir columnas
# ✓ unite(): combinar columnas
# ✓ drop_na(), replace_na(), fill(): manejo de NA

# =============================================================================
# ¡Felicidades! Has completado la Lección 2 del Módulo 2
# Continúa con el Módulo 3 - Visualización de Datos
# =============================================================================
