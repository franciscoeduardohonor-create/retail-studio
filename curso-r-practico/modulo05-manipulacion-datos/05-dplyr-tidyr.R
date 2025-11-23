# ============================================================================
# MÓDULO 5: MANIPULACIÓN DE DATOS CON DPLYR Y TIDYR
# ============================================================================
# Aprenderás las herramientas más poderosas para manipular datos en R

# Instalar y cargar paquetes (solo instalar una vez)
# install.packages("dplyr")
# install.packages("tidyr")
library(dplyr)
library(tidyr)

# ============================================================================
# 1. INTRODUCCIÓN A DPLYR - LOS VERBOS PRINCIPALES
# ============================================================================

# Crear datos de ejemplo
empleados <- data.frame(
  id = 1:10,
  nombre = c("Ana", "Juan", "María", "Pedro", "Lucía",
             "Carlos", "Laura", "Miguel", "Sofía", "Diego"),
  departamento = c("Ventas", "IT", "Ventas", "IT", "RRHH",
                   "Ventas", "IT", "RRHH", "Ventas", "IT"),
  salario = c(35000, 55000, 38000, 58000, 42000,
              36000, 56000, 43000, 37000, 57000),
  años_exp = c(3, 7, 4, 8, 5, 3, 7, 5, 4, 8)
)

# ============================================================================
# 2. SELECT - Seleccionar columnas
# ============================================================================

# Seleccionar columnas específicas
empleados %>%
  select(nombre, salario)

# Seleccionar múltiples columnas
empleados %>%
  select(nombre, departamento, salario)

# Excluir columnas
empleados %>%
  select(-id)

# Seleccionar rango de columnas
empleados %>%
  select(nombre:salario)

# Seleccionar por patrón
empleados %>%
  select(starts_with("s"))  # columnas que empiezan con "s"

# ============================================================================
# 3. FILTER - Filtrar filas
# ============================================================================

# Filtrar por una condición
empleados %>%
  filter(salario > 40000)

# Múltiples condiciones (AND)
empleados %>%
  filter(departamento == "IT" & salario > 55000)

# Condición OR
empleados %>%
  filter(departamento == "IT" | departamento == "RRHH")

# Usar %in% para múltiples valores
empleados %>%
  filter(departamento %in% c("IT", "RRHH"))

# Filtrar por rangos
empleados %>%
  filter(salario >= 40000 & salario <= 50000)

# Filtrar con between
empleados %>%
  filter(between(salario, 40000, 50000))

# ============================================================================
# 4. MUTATE - Crear o modificar columnas
# ============================================================================

# Crear nueva columna
empleados %>%
  mutate(salario_mensual = salario / 12)

# Múltiples columnas nuevas
empleados %>%
  mutate(
    salario_mensual = salario / 12,
    bono = salario * 0.10,
    salario_total = salario + bono
  )

# Modificar columna existente
empleados %>%
  mutate(salario = salario * 1.05)  # Aumento del 5%

# Con condiciones
empleados %>%
  mutate(
    nivel = case_when(
      años_exp >= 7 ~ "Senior",
      años_exp >= 4 ~ "Mid",
      TRUE ~ "Junior"
    )
  )

# ============================================================================
# 5. ARRANGE - Ordenar filas
# ============================================================================

# Ordenar ascendente
empleados %>%
  arrange(salario)

# Ordenar descendente
empleados %>%
  arrange(desc(salario))

# Ordenar por múltiples columnas
empleados %>%
  arrange(departamento, desc(salario))

# ============================================================================
# 6. SUMMARISE/SUMMARIZE - Resumir datos
# ============================================================================

# Resumen simple
empleados %>%
  summarise(
    salario_promedio = mean(salario),
    salario_max = max(salario),
    total_empleados = n()
  )

# Múltiples estadísticas
empleados %>%
  summarise(
    promedio = mean(salario),
    mediana = median(salario),
    minimo = min(salario),
    maximo = max(salario),
    desviacion = sd(salario),
    total = n()
  )

# ============================================================================
# 7. GROUP_BY - Agrupar datos
# ============================================================================

# Agrupar por departamento
empleados %>%
  group_by(departamento) %>%
  summarise(
    num_empleados = n(),
    salario_promedio = mean(salario),
    salario_total = sum(salario)
  )

# Agrupar por múltiples variables
empleados %>%
  mutate(nivel = if_else(años_exp >= 5, "Senior", "Junior")) %>%
  group_by(departamento, nivel) %>%
  summarise(
    cantidad = n(),
    promedio_salario = mean(salario)
  )

# ============================================================================
# 8. PIPE OPERATOR %>% - Encadenar operaciones
# ============================================================================

# Ejemplo completo usando pipe
resultado <- empleados %>%
  filter(salario > 35000) %>%              # Filtrar
  mutate(bono = salario * 0.10) %>%        # Crear columna
  select(nombre, departamento, salario, bono) %>%  # Seleccionar
  arrange(desc(salario))                   # Ordenar

print(resultado)

# Análisis completo
analisis <- empleados %>%
  filter(años_exp >= 4) %>%
  mutate(
    salario_anual_total = salario * 1.10,
    nivel = case_when(
      años_exp >= 7 ~ "Senior",
      años_exp >= 5 ~ "Mid-Senior",
      TRUE ~ "Mid"
    )
  ) %>%
  group_by(departamento, nivel) %>%
  summarise(
    cantidad = n(),
    promedio = round(mean(salario_anual_total), 2),
    .groups = "drop"
  ) %>%
  arrange(departamento, desc(promedio))

print(analisis)

# ============================================================================
# 9. JOINS - Unir tablas
# ============================================================================

# Crear tablas de ejemplo
ventas <- data.frame(
  empleado_id = c(1, 2, 3, 1, 2, 4),
  mes = c("Ene", "Ene", "Ene", "Feb", "Feb", "Feb"),
  venta = c(5000, 6000, 5500, 5200, 6200, 4800)
)

info_empleados <- data.frame(
  id = 1:5,
  nombre = c("Ana", "Juan", "María", "Pedro", "Lucía")
)

# Left join
ventas %>%
  left_join(info_empleados, by = c("empleado_id" = "id"))

# Inner join (solo coincidencias)
ventas %>%
  inner_join(info_empleados, by = c("empleado_id" = "id"))

# ============================================================================
# 10. TIDYR - REESTRUCTURAR DATOS
# ============================================================================

# PIVOT_LONGER: De ancho a largo
ventas_wide <- data.frame(
  producto = c("A", "B", "C"),
  ene = c(100, 150, 120),
  feb = c(110, 160, 125),
  mar = c(105, 155, 130)
)

ventas_long <- ventas_wide %>%
  pivot_longer(
    cols = c(ene, feb, mar),
    names_to = "mes",
    values_to = "ventas"
  )

print(ventas_long)

# PIVOT_WIDER: De largo a ancho
ventas_long %>%
  pivot_wider(
    names_from = mes,
    values_from = ventas
  )

# SEPARATE: Separar columnas
datos <- data.frame(
  nombre_completo = c("Ana García", "Juan Pérez", "María López")
)

datos %>%
  separate(nombre_completo,
           into = c("nombre", "apellido"),
           sep = " ")

# UNITE: Unir columnas
datos_separados <- data.frame(
  nombre = c("Ana", "Juan", "María"),
  apellido = c("García", "Pérez", "López")
)

datos_separados %>%
  unite("nombre_completo", nombre, apellido, sep = " ")

# ============================================================================
# 11. EJEMPLO PRÁCTICO INTEGRADOR
# ============================================================================

# Dataset de ventas
set.seed(123)
ventas_completo <- data.frame(
  fecha = rep(seq(as.Date("2024-01-01"), by = "month", length.out = 6), 3),
  vendedor = rep(c("Ana", "Juan", "María"), each = 6),
  producto = sample(c("A", "B", "C"), 18, replace = TRUE),
  unidades = sample(50:200, 18, replace = TRUE),
  precio_unitario = sample(c(10, 15, 20, 25), 18, replace = TRUE)
)

# Análisis completo
analisis_ventas <- ventas_completo %>%
  # Crear columnas calculadas
  mutate(
    venta_total = unidades * precio_unitario,
    mes = format(fecha, "%B"),
    trimestre = case_when(
      format(fecha, "%m") %in% c("01", "02", "03") ~ "Q1",
      format(fecha, "%m") %in% c("04", "05", "06") ~ "Q2",
      TRUE ~ "Q3"
    )
  ) %>%
  # Agrupar y resumir
  group_by(vendedor, trimestre) %>%
  summarise(
    total_ventas = sum(venta_total),
    total_unidades = sum(unidades),
    num_transacciones = n(),
    ticket_promedio = round(mean(venta_total), 2),
    .groups = "drop"
  ) %>%
  # Ordenar
  arrange(desc(total_ventas))

print(analisis_ventas)

# Top productos
top_productos <- ventas_completo %>%
  mutate(venta_total = unidades * precio_unitario) %>%
  group_by(producto) %>%
  summarise(
    ventas_totales = sum(venta_total),
    unidades_totales = sum(unidades),
    .groups = "drop"
  ) %>%
  arrange(desc(ventas_totales))

print(top_productos)

# ============================================================================
# 12. FUNCIONES ÚTILES ADICIONALES
# ============================================================================

# COUNT - Contar ocurrencias
empleados %>%
  count(departamento)

# DISTINCT - Valores únicos
empleados %>%
  distinct(departamento)

# RENAME - Renombrar columnas
empleados %>%
  rename(experience = años_exp)

# SLICE - Seleccionar filas por posición
empleados %>%
  slice(1:3)  # Primeras 3 filas

# TOP_N - Top N valores
empleados %>%
  top_n(3, salario)  # Top 3 salarios

# ============================================================================
# CONSEJOS PARA MANIPULACIÓN DE DATOS
# ============================================================================

# 1. Usa el pipe %>% para código más legible
# 2. Agrupa primero, luego resume (group_by + summarise)
# 3. Usa mutate para crear columnas, select para quedarte solo con las necesarias
# 4. filter antes de otras operaciones para trabajar con menos datos
# 5. Practica combinando múltiples verbos

print("\n¡Felicidades! Has completado el Módulo 5")
print("Ahora dominas la manipulación de datos con dplyr y tidyr")
