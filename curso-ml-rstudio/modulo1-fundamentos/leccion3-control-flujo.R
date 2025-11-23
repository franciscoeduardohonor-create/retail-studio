# ============================================================================
# MÓDULO 1 - LECCIÓN 3: CONTROL DE FLUJO Y FUNCIONES
# ============================================================================
# Descripción: Aprenderás estructuras de control (if, for, while) y cómo
#              crear tus propias funciones
# Nivel: Principiante-Intermedio
# Duración estimada: 3-4 horas
# Prerequisito: Lecciones 1 y 2
# ============================================================================

# ----------------------------------------------------------------------------
# SECCIÓN 1: CONDICIONALES - IF, ELSE, ELSE IF
# ----------------------------------------------------------------------------

# Las estructuras condicionales permiten ejecutar código según condiciones

# IF básico
edad <- 18

if (edad >= 18) {
  print("Eres mayor de edad")
}

# IF-ELSE
edad <- 15

if (edad >= 18) {
  print("Eres mayor de edad")
} else {
  print("Eres menor de edad")
}

# IF-ELSE IF-ELSE (múltiples condiciones)
calificacion <- 85

if (calificacion >= 90) {
  print("Excelente")
} else if (calificacion >= 80) {
  print("Bueno")
} else if (calificacion >= 70) {
  print("Aprobado")
} else {
  print("Reprobado")
}

# Ejemplo práctico: Categorizar ventas
venta <- 15000

categoria <- if (venta >= 20000) {
  "Venta Premium"
} else if (venta >= 10000) {
  "Venta Alta"
} else if (venta >= 5000) {
  "Venta Media"
} else {
  "Venta Baja"
}

cat("Categoría:", categoria, "\n")

# Condiciones múltiples con AND (&, &&) y OR (|, ||)

# && y || evalúan solo el primer elemento (más eficiente)
# & y | evalúan todos los elementos (útil para vectores)

temperatura <- 25
lluvia <- FALSE

# AND: ambas condiciones deben ser TRUE
if (temperatura > 20 && !lluvia) {
  print("Buen día para salir")
}

# OR: al menos una condición debe ser TRUE
dia_semana <- "Sábado"

if (dia_semana == "Sábado" || dia_semana == "Domingo") {
  print("Es fin de semana")
}

# Operador %in% (muy útil)
fruta <- "manzana"

if (fruta %in% c("manzana", "pera", "naranja")) {
  print("Es una fruta común")
}

# ifelse() - Versión vectorizada
# Sintaxis: ifelse(condición, valor_si_TRUE, valor_si_FALSE)

edades <- c(15, 20, 17, 25, 30, 16)
categorias <- ifelse(edades >= 18, "Adulto", "Menor")
print(categorias)

# ifelse anidado
calificaciones <- c(95, 85, 75, 65, 90)
niveles <- ifelse(calificaciones >= 90, "Excelente",
                 ifelse(calificaciones >= 80, "Bueno",
                       ifelse(calificaciones >= 70, "Aprobado", "Reprobado")))
print(niveles)

# ----------------------------------------------------------------------------
# SECCIÓN 2: BUCLES FOR
# ----------------------------------------------------------------------------

# Los bucles permiten repetir código múltiples veces

# Bucle básico
for (i in 1:5) {
  print(i)
}

# Bucle con vector
frutas <- c("manzana", "pera", "naranja", "plátano")

for (fruta in frutas) {
  print(fruta)
}

# Ejemplo práctico: Calcular factorial
n <- 5
factorial <- 1

for (i in 1:n) {
  factorial <- factorial * i
}

cat("El factorial de", n, "es", factorial, "\n")

# Bucle con índice
precios <- c(100, 200, 150, 300, 250)

for (i in 1:length(precios)) {
  cat("Producto", i, ": $", precios[i], "\n")
}

# Bucle con seq_along() (más seguro)
for (i in seq_along(precios)) {
  cat("Producto", i, ": $", precios[i], "\n")
}

# Bucles anidados (matriz)
cat("\nTabla de multiplicar 3x3:\n")

for (i in 1:3) {
  for (j in 1:3) {
    cat(i * j, "\t")
  }
  cat("\n")
}

# Ejemplo práctico: Procesar ventas por día
ventas_semana <- data.frame(
  dia = c("Lun", "Mar", "Mié", "Jue", "Vie", "Sáb", "Dom"),
  venta = c(1500, 2000, 1800, 2200, 1900, 2500, 1700)
)

cat("\n=== REPORTE DE VENTAS ===\n")
for (i in 1:nrow(ventas_semana)) {
  dia <- ventas_semana$dia[i]
  venta <- ventas_semana$venta[i]

  if (venta >= 2000) {
    estado <- "¡Excelente!"
  } else if (venta >= 1800) {
    estado <- "Bueno"
  } else {
    estado <- "Regular"
  }

  cat(dia, ": $", venta, " - ", estado, "\n", sep = "")
}

# ----------------------------------------------------------------------------
# SECCIÓN 3: BUCLES WHILE
# ----------------------------------------------------------------------------

# El bucle while se ejecuta mientras una condición sea TRUE

# Ejemplo básico
contador <- 1

while (contador <= 5) {
  print(contador)
  contador <- contador + 1
}

# Ejemplo práctico: Ahorro hasta alcanzar meta
ahorro <- 0
meta <- 1000
mensualidad <- 150
mes <- 0

cat("\n=== PLAN DE AHORRO ===\n")
while (ahorro < meta) {
  mes <- mes + 1
  ahorro <- ahorro + mensualidad
  cat("Mes", mes, ": $", ahorro, "\n")
}
cat("¡Meta alcanzada en", mes, "meses!\n")

# IMPORTANTE: Cuidado con bucles infinitos
# Siempre asegúrate de que la condición eventualmente sea FALSE

# Ejemplo con break (salir del bucle)
contador <- 1

while (TRUE) {  # Bucle "infinito"
  print(contador)
  contador <- contador + 1

  if (contador > 5) {
    break  # Salir del bucle
  }
}

# Ejemplo con next (saltar a la siguiente iteración)
for (i in 1:10) {
  if (i %% 2 == 0) {
    next  # Saltar números pares
  }
  print(i)  # Solo imprime impares
}

# ----------------------------------------------------------------------------
# SECCIÓN 4: FUNCIONES
# ----------------------------------------------------------------------------

# Las funciones son bloques de código reutilizable
# Sintaxis: nombre <- function(parámetros) { código }

# Función simple sin parámetros
saludar <- function() {
  print("¡Hola!")
}

saludar()

# Función con parámetros
saludar_persona <- function(nombre) {
  mensaje <- paste("¡Hola,", nombre, "!")
  print(mensaje)
}

saludar_persona("Juan")
saludar_persona("María")

# Función con múltiples parámetros
calcular_area_rectangulo <- function(base, altura) {
  area <- base * altura
  return(area)
}

resultado <- calcular_area_rectangulo(5, 3)
cat("Área del rectángulo:", resultado, "\n")

# Función con valor de retorno implícito
# R devuelve automáticamente la última expresión
suma <- function(a, b) {
  a + b  # No necesita return()
}

print(suma(5, 3))

# Función con parámetros por defecto
calcular_precio_final <- function(precio, descuento = 0, iva = 0.16) {
  precio_con_descuento <- precio * (1 - descuento)
  precio_final <- precio_con_descuento * (1 + iva)
  return(precio_final)
}

# Usar valores por defecto
calcular_precio_final(100)  # Solo IVA

# Especificar descuento
calcular_precio_final(100, descuento = 0.10)

# Especificar todos los parámetros
calcular_precio_final(100, 0.15, 0.16)

# Parámetros nombrados (más claro)
calcular_precio_final(precio = 100, iva = 0.08, descuento = 0.20)

# Función que devuelve múltiples valores (usando lista)
estadisticas <- function(numeros) {
  resultado <- list(
    media = mean(numeros),
    mediana = median(numeros),
    desv_std = sd(numeros),
    minimo = min(numeros),
    maximo = max(numeros)
  )
  return(resultado)
}

datos <- c(10, 20, 15, 25, 18, 22, 30)
stats <- estadisticas(datos)
print(stats)

# Acceder a los resultados
cat("Media:", stats$media, "\n")
cat("Mediana:", stats$mediana, "\n")

# Ejemplo práctico: Función para categorizar clientes
categorizar_cliente <- function(gasto_anual) {
  if (gasto_anual >= 50000) {
    categoria <- "Platinum"
    descuento <- 0.20
  } else if (gasto_anual >= 30000) {
    categoria <- "Gold"
    descuento <- 0.15
  } else if (gasto_anual >= 10000) {
    categoria <- "Silver"
    descuento <- 0.10
  } else {
    categoria <- "Bronce"
    descuento <- 0.05
  }

  return(list(
    categoria = categoria,
    descuento = descuento,
    gasto = gasto_anual
  ))
}

# Usar la función
cliente1 <- categorizar_cliente(45000)
cat("\nCategoria:", cliente1$categoria)
cat("\nDescuento:", cliente1$descuento * 100, "%\n")

# Función con validación de parámetros
dividir <- function(a, b) {
  if (b == 0) {
    stop("Error: No se puede dividir por cero")
  }
  return(a / b)
}

print(dividir(10, 2))
# dividir(10, 0)  # Esto generaría un error

# Función con advertencia
calcular_raiz <- function(numero) {
  if (numero < 0) {
    warning("Cuidado: raíz de número negativo")
    return(NA)
  }
  return(sqrt(numero))
}

print(calcular_raiz(16))
print(calcular_raiz(-4))

# ----------------------------------------------------------------------------
# SECCIÓN 5: FAMILIA APPLY
# ----------------------------------------------------------------------------

# La familia apply es una alternativa eficiente a los bucles
# Son funciones de "alto orden" que aplican otras funciones

# lapply() - Aplica función a cada elemento de una lista, devuelve lista
numeros_lista <- list(1:5, 6:10, 11:15)
sumas <- lapply(numeros_lista, sum)
print(sumas)

# sapply() - Como lapply pero simplifica el resultado
sumas_vector <- sapply(numeros_lista, sum)
print(sumas_vector)

# Ejemplo con vectores
nombres <- c("juan", "maría", "pedro")
nombres_mayuscula <- sapply(nombres, toupper)
print(nombres_mayuscula)

# Función personalizada con sapply
precios <- c(100, 200, 150, 300)
precios_con_iva <- sapply(precios, function(x) x * 1.16)
print(precios_con_iva)

# apply() - Para matrices y data frames
# MARGIN = 1 para filas, 2 para columnas

ventas_matriz <- matrix(
  c(1000, 1200, 1100, 1300,
    800, 900, 850, 950,
    1500, 1600, 1550, 1700),
  nrow = 3,
  byrow = TRUE
)

# Suma por fila (total por producto)
totales_fila <- apply(ventas_matriz, 1, sum)
print(totales_fila)

# Promedio por columna (promedio por mes)
promedios_col <- apply(ventas_matriz, 2, mean)
print(promedios_col)

# tapply() - Aplica función a grupos
# Muy útil para análisis agrupado

ventas <- c(100, 200, 150, 300, 250, 180, 220)
categorias <- c("A", "B", "A", "B", "A", "B", "A")

# Promedio de ventas por categoría
promedio_por_cat <- tapply(ventas, categorias, mean)
print(promedio_por_cat)

# Ejemplo práctico con data frame
empleados <- data.frame(
  nombre = c("Ana", "Luis", "María", "Carlos", "Pedro", "Laura"),
  departamento = c("Ventas", "IT", "Ventas", "IT", "Ventas", "IT"),
  salario = c(15000, 25000, 18000, 28000, 16000, 24000)
)

# Promedio de salario por departamento
salario_promedio <- tapply(empleados$salario,
                           empleados$departamento,
                           mean)
print(salario_promedio)

# mapply() - Versión multivariada
# Aplica función a múltiples vectores en paralelo

precios <- c(100, 200, 150)
cantidades <- c(2, 3, 4)

totales <- mapply(function(p, q) p * q, precios, cantidades)
print(totales)

# ----------------------------------------------------------------------------
# SECCIÓN 6: EJERCICIOS PRÁCTICOS
# ----------------------------------------------------------------------------

cat("\n=== EJERCICIOS PRÁCTICOS ===\n\n")

# EJERCICIO 1: Función para calcular IMC
cat("EJERCICIO 1: Calculadora de IMC\n")

calcular_imc <- function(peso, altura) {
  # IMC = peso (kg) / altura^2 (m)
  imc <- peso / (altura ^ 2)

  # Categorizar
  if (imc < 18.5) {
    categoria <- "Bajo peso"
  } else if (imc < 25) {
    categoria <- "Normal"
  } else if (imc < 30) {
    categoria <- "Sobrepeso"
  } else {
    categoria <- "Obesidad"
  }

  return(list(
    imc = round(imc, 2),
    categoria = categoria
  ))
}

# Probar la función
persona1 <- calcular_imc(70, 1.75)
cat("IMC:", persona1$imc, "- Categoría:", persona1$categoria, "\n")

# EJERCICIO 2: Números primos
cat("\n\nEJERCICIO 2: Encontrar números primos\n")

es_primo <- function(n) {
  if (n <= 1) return(FALSE)
  if (n == 2) return(TRUE)
  if (n %% 2 == 0) return(FALSE)

  for (i in 3:sqrt(n)) {
    if (n %% i == 0) {
      return(FALSE)
    }
  }
  return(TRUE)
}

# Encontrar primos hasta 30
primos <- c()
for (i in 1:30) {
  if (es_primo(i)) {
    primos <- c(primos, i)
  }
}
cat("Números primos del 1 al 30:", primos, "\n")

# EJERCICIO 3: Análisis de ventas por vendedor
cat("\n\nEJERCICIO 3: Análisis de ventas\n")

analizar_ventas <- function(df) {
  # Resumen por vendedor
  vendedores <- unique(df$vendedor)

  resultados <- data.frame(
    vendedor = character(),
    total_ventas = numeric(),
    num_transacciones = integer(),
    promedio = numeric(),
    stringsAsFactors = FALSE
  )

  for (v in vendedores) {
    ventas_vendedor <- df[df$vendedor == v, ]
    total <- sum(ventas_vendedor$monto)
    num <- nrow(ventas_vendedor)
    prom <- mean(ventas_vendedor$monto)

    resultados <- rbind(resultados, data.frame(
      vendedor = v,
      total_ventas = total,
      num_transacciones = num,
      promedio = prom
    ))
  }

  # Ordenar por total de ventas
  resultados <- resultados[order(resultados$total_ventas, decreasing = TRUE), ]

  return(resultados)
}

# Datos de ejemplo
ventas_data <- data.frame(
  vendedor = c("Ana", "Luis", "Ana", "Carlos", "Luis", "Ana", "Carlos"),
  monto = c(1500, 2000, 1800, 2200, 1900, 2500, 1700)
)

resultado_analisis <- analizar_ventas(ventas_data)
print(resultado_analisis)

# EJERCICIO 4: Simulador de crecimiento de inversión
cat("\n\nEJERCICIO 4: Simulador de inversión\n")

simular_inversion <- function(capital_inicial, tasa_anual, años) {
  cat("\n=== SIMULACIÓN DE INVERSIÓN ===\n")
  cat("Capital inicial: $", capital_inicial, "\n")
  cat("Tasa anual:", tasa_anual * 100, "%\n")
  cat("Plazo:", años, "años\n\n")

  capital <- capital_inicial

  for (año in 1:años) {
    interes <- capital * tasa_anual
    capital <- capital + interes

    cat("Año", año, ": $", round(capital, 2),
        " (Ganancia: $", round(interes, 2), ")\n")
  }

  ganancia_total <- capital - capital_inicial
  cat("\nCapital final: $", round(capital, 2), "\n")
  cat("Ganancia total: $", round(ganancia_total, 2), "\n")
  cat("Rendimiento total:", round(ganancia_total / capital_inicial * 100, 2), "%\n")

  return(capital)
}

# Simular inversión de $10,000 al 8% anual por 5 años
capital_final <- simular_inversion(10000, 0.08, 5)

# ----------------------------------------------------------------------------
# SECCIÓN 7: DESAFÍOS AVANZADOS
# ----------------------------------------------------------------------------

cat("\n\n=== DESAFÍOS AVANZADOS ===\n\n")

# DESAFÍO 1: Fibonacci recursivo
fibonacci <- function(n) {
  if (n <= 1) {
    return(n)
  } else {
    return(fibonacci(n - 1) + fibonacci(n - 2))
  }
}

cat("DESAFÍO 1: Serie Fibonacci\n")
cat("Primeros 10 números de Fibonacci:\n")
for (i in 0:9) {
  cat(fibonacci(i), " ")
}
cat("\n")

# DESAFÍO 2: Validador de tarjeta de crédito (Algoritmo de Luhn)
validar_tarjeta <- function(numero) {
  # Convertir a vector de dígitos
  digitos <- as.numeric(strsplit(as.character(numero), "")[[1]])

  # Duplicar cada segundo dígito de derecha a izquierda
  for (i in seq(length(digitos) - 1, 1, -2)) {
    digitos[i] <- digitos[i] * 2
    if (digitos[i] > 9) {
      digitos[i] <- digitos[i] - 9
    }
  }

  # La suma debe ser divisible por 10
  suma <- sum(digitos)
  return(suma %% 10 == 0)
}

cat("\n\nDESAFÍO 2: Validador de tarjeta\n")
cat("¿Es válida 4532015112830366?", validar_tarjeta(4532015112830366), "\n")
cat("¿Es válida 1234567812345670?", validar_tarjeta(1234567812345670), "\n")

# DESAFÍO 3: Sistema de inventario con funciones
cat("\n\nDESAFÍO 3: Sistema de inventario\n")

# Crear inventario
crear_inventario <- function() {
  return(data.frame(
    codigo = character(),
    producto = character(),
    cantidad = integer(),
    precio = numeric(),
    stringsAsFactors = FALSE
  ))
}

# Agregar producto
agregar_producto <- function(inv, codigo, producto, cantidad, precio) {
  nuevo <- data.frame(
    codigo = codigo,
    producto = producto,
    cantidad = cantidad,
    precio = precio
  )
  return(rbind(inv, nuevo))
}

# Actualizar stock
actualizar_stock <- function(inv, codigo, cantidad) {
  inv$cantidad[inv$codigo == codigo] <- inv$cantidad[inv$codigo == codigo] + cantidad
  return(inv)
}

# Valor total del inventario
valor_inventario <- function(inv) {
  return(sum(inv$cantidad * inv$precio))
}

# Usar el sistema
inventario <- crear_inventario()
inventario <- agregar_producto(inventario, "P001", "Laptop", 10, 15000)
inventario <- agregar_producto(inventario, "P002", "Mouse", 50, 250)
inventario <- agregar_producto(inventario, "P003", "Teclado", 30, 800)

print(inventario)

# Actualizar stock
inventario <- actualizar_stock(inventario, "P001", 5)

cat("\nValor total del inventario: $", valor_inventario(inventario), "\n")

# ----------------------------------------------------------------------------
# RESUMEN
# ----------------------------------------------------------------------------

cat("\n=== RESUMEN DE LA LECCIÓN 3 ===\n")
cat("Aprendiste:\n")
cat("1. Condicionales: if, else if, else, ifelse()\n")
cat("2. Bucles: for, while, break, next\n")
cat("3. Crear funciones personalizadas\n")
cat("4. Parámetros y valores de retorno\n")
cat("5. Familia apply: lapply, sapply, apply, tapply\n")
cat("6. Recursión y funciones avanzadas\n")
cat("\n¡Excelente! Completa el Módulo 1 con la Lección 4\n")

# ============================================================================
# FIN DE LA LECCIÓN 3
# ============================================================================
