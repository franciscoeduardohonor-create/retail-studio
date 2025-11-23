# ============================================================================
# MÓDULO 3: PROGRAMACIÓN Y CONTROL DE FLUJO
# ============================================================================
# Aprenderás estructuras de control (if, loops) y cómo crear funciones

# ============================================================================
# 1. CONDICIONALES: IF, ELSE IF, ELSE
# ============================================================================

# Estructura básica IF
edad <- 20

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
  print("Excelente - A")
} else if (calificacion >= 80) {
  print("Muy bien - B")
} else if (calificacion >= 70) {
  print("Bien - C")
} else if (calificacion >= 60) {
  print("Suficiente - D")
} else {
  print("Reprobado - F")
}

# Condicionales con operadores lógicos
edad <- 25
tiene_licencia <- TRUE

if (edad >= 18 & tiene_licencia) {
  print("Puede conducir")
} else {
  print("No puede conducir")
}

# Condicionales anidados
salario <- 50000
años_experiencia <- 8

if (salario > 45000) {
  if (años_experiencia > 5) {
    categoria <- "Senior Alto"
  } else {
    categoria <- "Senior Inicial"
  }
} else {
  if (años_experiencia > 3) {
    categoria <- "Mid"
  } else {
    categoria <- "Junior"
  }
}
print(categoria)

# ============================================================================
# 2. IFELSE - FORMA VECTORIZADA
# ============================================================================

# ifelse() es vectorizado (funciona con vectores)
edades <- c(15, 20, 30, 12, 45)
categorias <- ifelse(edades >= 18, "Adulto", "Menor")
print(categorias)

# ifelse anidado
calificaciones <- c(95, 82, 67, 45, 88)
letras <- ifelse(calificaciones >= 90, "A",
          ifelse(calificaciones >= 80, "B",
          ifelse(calificaciones >= 70, "C",
          ifelse(calificaciones >= 60, "D", "F"))))
print(letras)

# Ejemplo práctico: categorizar ventas
ventas <- c(1200, 3500, 800, 5000, 2100)
performance <- ifelse(ventas >= 3000, "Excelente",
               ifelse(ventas >= 2000, "Bueno",
               ifelse(ventas >= 1000, "Regular", "Bajo")))
print(performance)

# ============================================================================
# 3. BUCLE FOR
# ============================================================================

# Iterar sobre una secuencia de números
for (i in 1:5) {
  print(i)
}

# Iterar sobre un vector
frutas <- c("Manzana", "Banana", "Naranja")
for (fruta in frutas) {
  print(paste("Me gusta la", fruta))
}

# For con índices
numeros <- c(10, 20, 30, 40, 50)
for (i in 1:length(numeros)) {
  print(paste("Posición", i, "=", numeros[i]))
}

# Ejemplo práctico: calcular cuadrados
numeros <- 1:10
cuadrados <- numeric(10)  # Vector vacío para almacenar resultados

for (i in 1:10) {
  cuadrados[i] <- numeros[i]^2
}
print(cuadrados)

# Ejemplo: suma acumulativa
ventas_diarias <- c(100, 150, 200, 180, 220)
suma_acumulada <- 0

for (venta in ventas_diarias) {
  suma_acumulada <- suma_acumulada + venta
  print(paste("Suma acumulada:", suma_acumulada))
}

# For anidado (tabla de multiplicar)
for (i in 1:3) {
  for (j in 1:3) {
    resultado <- i * j
    print(paste(i, "x", j, "=", resultado))
  }
}

# ============================================================================
# 4. BUCLE WHILE
# ============================================================================

# While: ejecuta mientras la condición sea TRUE
contador <- 1

while (contador <= 5) {
  print(paste("Contador:", contador))
  contador <- contador + 1
}

# Ejemplo práctico: búsqueda
numeros <- c(5, 12, 8, 20, 3, 15)
i <- 1
encontrado <- FALSE

while (i <= length(numeros) & !encontrado) {
  if (numeros[i] > 15) {
    print(paste("Encontrado número mayor a 15:", numeros[i], "en posición", i))
    encontrado <- TRUE
  }
  i <- i + 1
}

# Ejemplo: interés compuesto
capital <- 1000
objetivo <- 2000
tasa_interes <- 0.05
años <- 0

while (capital < objetivo) {
  capital <- capital * (1 + tasa_interes)
  años <- años + 1
  print(paste("Año", años, ": $", round(capital, 2)))
}
print(paste("Se alcanzó el objetivo en", años, "años"))

# ============================================================================
# 5. BREAK Y NEXT
# ============================================================================

# BREAK: sale del bucle inmediatamente
for (i in 1:10) {
  if (i == 6) {
    print("¡Llegamos a 6, salimos!")
    break
  }
  print(i)
}

# NEXT: salta a la siguiente iteración
for (i in 1:10) {
  if (i %% 2 == 0) {
    next  # Salta los números pares
  }
  print(i)  # Solo imprime impares
}

# Ejemplo práctico: buscar un valor
productos <- c("Laptop", "Mouse", "Teclado", "Monitor", "Webcam")
producto_buscado <- "Teclado"

for (i in 1:length(productos)) {
  if (productos[i] == producto_buscado) {
    print(paste("Producto encontrado en posición", i))
    break
  }
}

# ============================================================================
# 6. FUNCIONES - CREACIÓN Y USO
# ============================================================================

# Función básica sin parámetros
saludar <- function() {
  print("¡Hola, bienvenido!")
}

saludar()  # Llamar la función

# Función con parámetros
saludar_nombre <- function(nombre) {
  mensaje <- paste("¡Hola", nombre, "!")
  print(mensaje)
}

saludar_nombre("Ana")
saludar_nombre("Juan")

# Función con múltiples parámetros
sumar <- function(a, b) {
  resultado <- a + b
  return(resultado)
}

suma1 <- sumar(5, 3)  # 8
suma2 <- sumar(10, 20)  # 30
print(suma1)
print(suma2)

# Función con parámetro por defecto
saludar_completo <- function(nombre, saludo = "Hola") {
  mensaje <- paste(saludo, nombre, "!")
  return(mensaje)
}

print(saludar_completo("Ana"))  # Usa "Hola" por defecto
print(saludar_completo("Juan", "Buenos días"))  # Usa "Buenos días"

# ============================================================================
# 7. FUNCIONES PRÁCTICAS
# ============================================================================

# Función para calcular el área de un rectángulo
area_rectangulo <- function(base, altura) {
  area <- base * altura
  return(area)
}

print(area_rectangulo(5, 10))  # 50

# Función para calcular promedio
calcular_promedio <- function(numeros) {
  promedio <- sum(numeros) / length(numeros)
  return(promedio)
}

calificaciones <- c(85, 90, 78, 92, 88)
print(calcular_promedio(calificaciones))  # 86.6

# Función con múltiples valores de retorno (usando lista)
estadisticas <- function(numeros) {
  resultado <- list(
    promedio = mean(numeros),
    mediana = median(numeros),
    minimo = min(numeros),
    maximo = max(numeros),
    desviacion = sd(numeros)
  )
  return(resultado)
}

datos <- c(10, 20, 15, 25, 18, 22)
stats <- estadisticas(datos)
print(stats)
print(paste("Promedio:", stats$promedio))

# Función para calcular descuento
calcular_precio_final <- function(precio, descuento_porcentaje = 0) {
  descuento <- precio * (descuento_porcentaje / 100)
  precio_final <- precio - descuento

  resultado <- list(
    precio_original = precio,
    descuento_aplicado = descuento,
    precio_final = precio_final
  )
  return(resultado)
}

compra <- calcular_precio_final(100, 20)
print(compra)

# ============================================================================
# 8. FUNCIONES CON CONDICIONALES
# ============================================================================

# Función para clasificar edad
clasificar_edad <- function(edad) {
  if (edad < 13) {
    return("Niño")
  } else if (edad < 18) {
    return("Adolescente")
  } else if (edad < 65) {
    return("Adulto")
  } else {
    return("Adulto Mayor")
  }
}

print(clasificar_edad(10))  # Niño
print(clasificar_edad(16))  # Adolescente
print(clasificar_edad(30))  # Adulto
print(clasificar_edad(70))  # Adulto Mayor

# Función para validar calificación
validar_calificacion <- function(nota) {
  if (nota < 0 | nota > 100) {
    return("Calificación inválida")
  } else if (nota >= 60) {
    return("Aprobado")
  } else {
    return("Reprobado")
  }
}

print(validar_calificacion(85))   # Aprobado
print(validar_calificacion(45))   # Reprobado
print(validar_calificacion(105))  # Inválida

# ============================================================================
# 9. FUNCIONES CON BUCLES
# ============================================================================

# Función para calcular factorial
factorial <- function(n) {
  resultado <- 1
  for (i in 1:n) {
    resultado <- resultado * i
  }
  return(resultado)
}

print(factorial(5))  # 120
print(factorial(7))  # 5040

# Función para encontrar números pares en un vector
encontrar_pares <- function(numeros) {
  pares <- c()
  for (num in numeros) {
    if (num %% 2 == 0) {
      pares <- c(pares, num)
    }
  }
  return(pares)
}

numeros <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
print(encontrar_pares(numeros))  # 2, 4, 6, 8, 10

# Función para contar vocales
contar_vocales <- function(texto) {
  texto <- tolower(texto)
  vocales <- c("a", "e", "i", "o", "u")
  contador <- 0

  for (letra in strsplit(texto, "")[[1]]) {
    if (letra %in% vocales) {
      contador <- contador + 1
    }
  }
  return(contador)
}

print(contar_vocales("Hola Mundo"))  # 4

# ============================================================================
# 10. EJEMPLO INTEGRADOR: SISTEMA DE CALIFICACIONES
# ============================================================================

# Función principal para procesar calificaciones
procesar_estudiante <- function(nombre, calificaciones) {
  # Validar que haya al menos una calificación
  if (length(calificaciones) == 0) {
    return("Error: no hay calificaciones")
  }

  # Calcular estadísticas
  promedio <- mean(calificaciones)
  nota_maxima <- max(calificaciones)
  nota_minima <- min(calificaciones)

  # Determinar si aprobó (promedio >= 70)
  aprobo <- promedio >= 70

  # Determinar letra
  if (promedio >= 90) {
    letra <- "A"
  } else if (promedio >= 80) {
    letra <- "B"
  } else if (promedio >= 70) {
    letra <- "C"
  } else if (promedio >= 60) {
    letra <- "D"
  } else {
    letra <- "F"
  }

  # Crear reporte
  reporte <- list(
    nombre = nombre,
    numero_examenes = length(calificaciones),
    promedio = round(promedio, 2),
    nota_maxima = nota_maxima,
    nota_minima = nota_minima,
    letra = letra,
    aprobo = aprobo
  )

  return(reporte)
}

# Usar la función
estudiante1 <- procesar_estudiante("Ana García", c(85, 90, 88, 92))
print(estudiante1)

estudiante2 <- procesar_estudiante("Juan Pérez", c(65, 70, 68, 72))
print(estudiante2)

# Función para procesar múltiples estudiantes
procesar_clase <- function(estudiantes_lista) {
  resultados <- list()

  for (i in 1:length(estudiantes_lista)) {
    nombre <- estudiantes_lista[[i]]$nombre
    notas <- estudiantes_lista[[i]]$notas
    resultados[[i]] <- procesar_estudiante(nombre, notas)
  }

  return(resultados)
}

# Lista de estudiantes
clase <- list(
  list(nombre = "Ana", notas = c(85, 90, 88)),
  list(nombre = "Juan", notas = c(75, 78, 80)),
  list(nombre = "María", notas = c(95, 92, 98))
)

resultados_clase <- procesar_clase(clase)
for (resultado in resultados_clase) {
  print(paste(resultado$nombre, "- Promedio:", resultado$promedio,
              "- Letra:", resultado$letra))
}

print("\n¡Felicidades! Has completado el Módulo 3")
