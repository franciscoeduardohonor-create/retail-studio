# =============================================================================
# GENERADOR DE DATASETS DE EJEMPLO
# =============================================================================
# Este script crea datasets de práctica para los ejercicios del curso
# Ejecuta este script para generar los archivos CSV que usarás en tus prácticas

# =============================================================================
# CONFIGURACIÓN
# =============================================================================

set.seed(123)  # Para reproducibilidad

# Crear directorio para guardar los CSVs si no existe
if (!dir.exists("datos_csv")) {
  dir.create("datos_csv")
}

# =============================================================================
# DATASET 1: VENTAS DE TIENDA
# =============================================================================

n_ventas <- 1000
ventas_tienda <- data.frame(
  id_venta = 1:n_ventas,
  fecha = seq.Date(from = as.Date("2023-01-01"),
                   to = as.Date("2023-12-31"),
                   length.out = n_ventas),
  producto = sample(c("Laptop", "Tablet", "Smartphone", "Monitor",
                     "Teclado", "Mouse", "Audífonos", "Webcam"),
                   n_ventas, replace = TRUE),
  categoria = sample(c("Electrónica", "Accesorios"), n_ventas,
                    replace = TRUE, prob = c(0.6, 0.4)),
  cantidad = sample(1:5, n_ventas, replace = TRUE),
  precio_unitario = round(runif(n_ventas, min = 200, max = 25000), 2),
  vendedor = sample(c("Ana García", "Luis Rodríguez", "María López",
                     "Carlos Pérez", "Elena Torres"), n_ventas, replace = TRUE),
  region = sample(c("Norte", "Sur", "Este", "Oeste", "Centro"),
                 n_ventas, replace = TRUE),
  metodo_pago = sample(c("Efectivo", "Tarjeta", "Transferencia"),
                      n_ventas, replace = TRUE, prob = c(0.3, 0.5, 0.2))
)

ventas_tienda$venta_total <- ventas_tienda$cantidad * ventas_tienda$precio_unitario

write.csv(ventas_tienda, "datos_csv/ventas_tienda.csv", row.names = FALSE)
print("✓ Dataset 1 creado: ventas_tienda.csv")

# =============================================================================
# DATASET 2: ESTUDIANTES Y CALIFICACIONES
# =============================================================================

n_estudiantes <- 200
estudiantes <- data.frame(
  id_estudiante = 1:n_estudiantes,
  nombre = paste("Estudiante", 1:n_estudiantes),
  edad = sample(18:25, n_estudiantes, replace = TRUE),
  genero = sample(c("M", "F"), n_estudiantes, replace = TRUE),
  carrera = sample(c("Ingeniería", "Administración", "Medicina",
                    "Derecho", "Psicología"), n_estudiantes, replace = TRUE),
  semestre = sample(1:8, n_estudiantes, replace = TRUE),
  promedio = round(rnorm(n_estudiantes, mean = 8.0, sd = 1.2), 2),
  horas_estudio_semanal = round(abs(rnorm(n_estudiantes, mean = 20, sd = 8))),
  asistencia_pct = round(runif(n_estudiantes, min = 60, max = 100), 1),
  trabaja = sample(c("Sí", "No"), n_estudiantes, replace = TRUE, prob = c(0.4, 0.6)),
  beca = sample(c("Sí", "No"), n_estudiantes, replace = TRUE, prob = c(0.3, 0.7))
)

# Ajustar promedios a escala 0-10
estudiantes$promedio <- pmin(pmax(estudiantes$promedio, 0), 10)

write.csv(estudiantes, "datos_csv/estudiantes.csv", row.names = FALSE)
print("✓ Dataset 2 creado: estudiantes.csv")

# =============================================================================
# DATASET 3: EMPLEADOS Y SALARIOS
# =============================================================================

n_empleados <- 300
empleados <- data.frame(
  id_empleado = 1:n_empleados,
  nombre = paste("Empleado", 1:n_empleados),
  departamento = sample(c("Ventas", "TI", "RRHH", "Finanzas", "Marketing", "Operaciones"),
                       n_empleados, replace = TRUE),
  puesto = sample(c("Junior", "Senior", "Manager", "Director"),
                 n_empleados, replace = TRUE, prob = c(0.4, 0.35, 0.2, 0.05)),
  antiguedad_años = round(abs(rnorm(n_empleados, mean = 5, sd = 4)), 1),
  edad = sample(22:65, n_empleados, replace = TRUE),
  educacion = sample(c("Licenciatura", "Maestría", "Doctorado"),
                    n_empleados, replace = TRUE, prob = c(0.6, 0.3, 0.1)),
  salario_mensual = round(rnorm(n_empleados, mean = 25000, sd = 10000)),
  evaluacion_desempeno = round(runif(n_empleados, min = 1, max = 5), 1),
  horas_capacitacion = round(abs(rnorm(n_empleados, mean = 40, sd = 20)))
)

# Ajustar salarios para que sean positivos y razonables
empleados$salario_mensual <- pmax(empleados$salario_mensual, 8000)

write.csv(empleados, "datos_csv/empleados.csv", row.names = FALSE)
print("✓ Dataset 3 creado: empleados.csv")

# =============================================================================
# DATASET 4: CLIENTES Y CHURN
# =============================================================================

n_clientes <- 500
clientes <- data.frame(
  id_cliente = 1:n_clientes,
  antiguedad_meses = round(abs(rnorm(n_clientes, mean = 24, sd = 18))),
  edad = sample(18:75, n_clientes, replace = TRUE),
  genero = sample(c("M", "F"), n_clientes, replace = TRUE),
  plan = sample(c("Básico", "Estándar", "Premium"), n_clientes,
               replace = TRUE, prob = c(0.5, 0.3, 0.2)),
  gasto_mensual = round(rnorm(n_clientes, mean = 500, sd = 200), 2),
  llamadas_soporte = round(abs(rnorm(n_clientes, mean = 2, sd = 2))),
  num_productos = sample(1:5, n_clientes, replace = TRUE),
  satisfaccion = round(runif(n_clientes, min = 1, max = 10), 1),
  uso_app_movil = sample(c("Sí", "No"), n_clientes, replace = TRUE, prob = c(0.7, 0.3)),
  churn = sample(c(0, 1), n_clientes, replace = TRUE, prob = c(0.75, 0.25))
)

clientes$gasto_mensual <- pmax(clientes$gasto_mensual, 100)

write.csv(clientes, "datos_csv/clientes_churn.csv", row.names = FALSE)
print("✓ Dataset 4 creado: clientes_churn.csv")

# =============================================================================
# DATASET 5: CASAS (PARA REGRESIÓN)
# =============================================================================

n_casas <- 400
casas <- data.frame(
  id_casa = 1:n_casas,
  metros_cuadrados = round(rnorm(n_casas, mean = 120, sd = 40)),
  habitaciones = sample(1:6, n_casas, replace = TRUE, prob = c(0.1, 0.2, 0.3, 0.25, 0.1, 0.05)),
  baños = sample(1:4, n_casas, replace = TRUE, prob = c(0.2, 0.4, 0.3, 0.1)),
  estacionamientos = sample(0:3, n_casas, replace = TRUE, prob = c(0.1, 0.3, 0.4, 0.2)),
  antiguedad_años = round(abs(rnorm(n_casas, mean = 15, sd = 12))),
  distancia_centro_km = round(abs(rnorm(n_casas, mean = 10, sd = 6)), 1),
  zona = sample(c("Residencial", "Comercial", "Mixta"), n_casas,
               replace = TRUE, prob = c(0.6, 0.2, 0.2)),
  tiene_jardin = sample(c("Sí", "No"), n_casas, replace = TRUE, prob = c(0.6, 0.4)),
  piso = sample(c("PB", "1", "2", "3", "4+"), n_casas, replace = TRUE)
)

# Calcular precio basado en características
casas$precio <- 500000 +
  3000 * casas$metros_cuadrados +
  100000 * casas$habitaciones +
  50000 * casas$baños +
  80000 * casas$estacionamientos -
  8000 * casas$antiguedad_años -
  15000 * casas$distancia_centro_km +
  rnorm(n_casas, mean = 0, sd = 100000)

casas$precio <- round(pmax(casas$precio, 200000), 0)

write.csv(casas, "datos_csv/casas.csv", row.names = FALSE)
print("✓ Dataset 5 creado: casas.csv")

# =============================================================================
# DATASET 6: PRODUCTOS Y INVENTARIO
# =============================================================================

productos <- data.frame(
  codigo_producto = paste0("PROD", 1001:1100),
  nombre_producto = paste("Producto", 1:100),
  categoria = sample(c("Electrónica", "Ropa", "Alimentos", "Hogar", "Deportes"),
                    100, replace = TRUE),
  subcategoria = sample(c("A", "B", "C", "D"), 100, replace = TRUE),
  precio_compra = round(runif(100, min = 50, max = 5000), 2),
  precio_venta = 0,  # Se calculará
  stock_actual = sample(0:200, 100, replace = TRUE),
  stock_minimo = sample(10:50, 100, replace = TRUE),
  proveedor = sample(c("Proveedor A", "Proveedor B", "Proveedor C", "Proveedor D"),
                    100, replace = TRUE),
  unidades_vendidas_mes = sample(0:150, 100, replace = TRUE),
  calificacion = round(runif(100, min = 1, max = 5), 1)
)

# Calcular precio de venta (margen 30-70%)
productos$precio_venta <- round(productos$precio_compra * runif(100, 1.3, 1.7), 2)

write.csv(productos, "datos_csv/productos_inventario.csv", row.names = FALSE)
print("✓ Dataset 6 creado: productos_inventario.csv")

# =============================================================================
# DATASET 7: ENCUESTA DE SATISFACCIÓN
# =============================================================================

n_respuestas <- 300
encuesta <- data.frame(
  id_respuesta = 1:n_respuestas,
  fecha = sample(seq.Date(from = as.Date("2024-01-01"),
                         to = as.Date("2024-03-31"), by = "day"),
                n_respuestas, replace = TRUE),
  edad_grupo = sample(c("18-25", "26-35", "36-45", "46-55", "56+"),
                     n_respuestas, replace = TRUE),
  genero = sample(c("M", "F", "Otro"), n_respuestas, replace = TRUE, prob = c(0.48, 0.48, 0.04)),
  calidad_producto = sample(1:10, n_respuestas, replace = TRUE),
  atencion_cliente = sample(1:10, n_respuestas, replace = TRUE),
  tiempo_entrega = sample(1:10, n_respuestas, replace = TRUE),
  precio_valor = sample(1:10, n_respuestas, replace = TRUE),
  satisfaccion_general = 0,  # Se calculará
  recomendaria = sample(c("Sí", "No", "Tal vez"), n_respuestas,
                       replace = TRUE, prob = c(0.6, 0.2, 0.2)),
  volveria_comprar = sample(c("Sí", "No"), n_respuestas, replace = TRUE, prob = c(0.75, 0.25))
)

# Calcular satisfacción general como promedio
encuesta$satisfaccion_general <- round(
  (encuesta$calidad_producto + encuesta$atencion_cliente +
   encuesta$tiempo_entrega + encuesta$precio_valor) / 4, 1
)

write.csv(encuesta, "datos_csv/encuesta_satisfaccion.csv", row.names = FALSE)
print("✓ Dataset 7 creado: encuesta_satisfaccion.csv")

# =============================================================================
# RESUMEN
# =============================================================================

print("\n=============================================================================")
print("DATASETS GENERADOS EXITOSAMENTE")
print("=============================================================================")
print("")
print("Los siguientes datasets están disponibles en la carpeta 'datos_csv':")
print("")
print("1. ventas_tienda.csv - Datos de ventas de una tienda de electrónica")
print("2. estudiantes.csv - Información de estudiantes y su rendimiento")
print("3. empleados.csv - Datos de empleados, salarios y evaluaciones")
print("4. clientes_churn.csv - Clientes y probabilidad de cancelación")
print("5. casas.csv - Características y precios de casas")
print("6. productos_inventario.csv - Catálogo de productos e inventario")
print("7. encuesta_satisfaccion.csv - Respuestas de encuesta de satisfacción")
print("")
print("=============================================================================")
print("")
print("CÓMO USAR ESTOS DATASETS:")
print("")
print("# Cargar un dataset:")
print("datos <- read.csv('datos_csv/ventas_tienda.csv')")
print("")
print("# Ver primeras filas:")
print("head(datos)")
print("")
print("# Explorar estructura:")
print("str(datos)")
print("summary(datos)")
print("")
print("=============================================================================")

# Crear un archivo README para los datasets
readme_content <- "# DATASETS DE PRÁCTICA

Este directorio contiene datasets generados para practicar análisis estadístico con R.

## Datasets Disponibles

### 1. ventas_tienda.csv
- **Filas**: 1000
- **Descripción**: Transacciones de ventas de una tienda de electrónica
- **Columnas**: id_venta, fecha, producto, categoria, cantidad, precio_unitario, vendedor, region, metodo_pago, venta_total
- **Uso**: Análisis de ventas, series de tiempo, agrupamiento por región/vendedor

### 2. estudiantes.csv
- **Filas**: 200
- **Descripción**: Información académica de estudiantes
- **Columnas**: id_estudiante, nombre, edad, genero, carrera, semestre, promedio, horas_estudio_semanal, asistencia_pct, trabaja, beca
- **Uso**: Análisis de rendimiento académico, correlaciones, comparación de grupos

### 3. empleados.csv
- **Filas**: 300
- **Descripción**: Datos de recursos humanos
- **Columnas**: id_empleado, nombre, departamento, puesto, antiguedad_años, edad, educacion, salario_mensual, evaluacion_desempeno, horas_capacitacion
- **Uso**: Análisis salarial, evaluación de desempeño, regresión

### 4. clientes_churn.csv
- **Filas**: 500
- **Descripción**: Clientes y su comportamiento de cancelación
- **Columnas**: id_cliente, antiguedad_meses, edad, genero, plan, gasto_mensual, llamadas_soporte, num_productos, satisfaccion, uso_app_movil, churn
- **Uso**: Modelos de clasificación, regresión logística, predicción de churn

### 5. casas.csv
- **Filas**: 400
- **Descripción**: Características y precios de propiedades
- **Columnas**: id_casa, metros_cuadrados, habitaciones, baños, estacionamientos, antiguedad_años, distancia_centro_km, zona, tiene_jardin, piso, precio
- **Uso**: Regresión lineal múltiple, predicción de precios

### 6. productos_inventario.csv
- **Filas**: 100
- **Descripción**: Catálogo de productos con inventario
- **Columnas**: codigo_producto, nombre_producto, categoria, subcategoria, precio_compra, precio_venta, stock_actual, stock_minimo, proveedor, unidades_vendidas_mes, calificacion
- **Uso**: Análisis de inventario, optimización, márgenes de ganancia

### 7. encuesta_satisfaccion.csv
- **Filas**: 300
- **Descripción**: Respuestas de encuesta de satisfacción de clientes
- **Columnas**: id_respuesta, fecha, edad_grupo, genero, calidad_producto, atencion_cliente, tiempo_entrega, precio_valor, satisfaccion_general, recomendaria, volveria_comprar
- **Uso**: Análisis de satisfacción, correlaciones, pruebas de hipótesis

## Cómo Cargar los Datos

```r
# Cargar un dataset
ventas <- read.csv('datos_csv/ventas_tienda.csv')

# Explorar
head(ventas)
str(ventas)
summary(ventas)
```

## Regenerar Datasets

Si necesitas regenerar los datasets con nuevos datos aleatorios:

```r
source('generar_datasets.R')
```
"

writeLines(readme_content, "README_DATASETS.md")
print("✓ README de datasets creado")

print("\n¡Todos los datasets han sido generados exitosamente!")
print("Ejecuta los scripts de las lecciones para aprender a analizarlos.")
