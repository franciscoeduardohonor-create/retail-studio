# ============================================
# MÓDULO 1: FUNDAMENTOS DE OPTIMIZACIÓN
# ============================================
# Curso: PSO y Algoritmos Genéticos en R
# Nivel: PRINCIPIANTE
# Duración estimada: 2-3 horas

# ============================================
# TABLA DE CONTENIDOS
# ============================================
# 1. ¿Qué es la optimización?
# 2. Componentes de un problema de optimización
# 3. Tipos de optimización
# 4. Búsqueda exhaustiva vs inteligente
# 5. Funciones de benchmark
# 6. Tu primer optimizador simple
# 7. Ejercicios prácticos

# ============================================
# SECCIÓN 1: ¿QUÉ ES LA OPTIMIZACIÓN?
# ============================================

# La optimización busca encontrar la MEJOR solución a un problema
# dentro de un conjunto de posibles soluciones.

# EJEMPLO COTIDIANO: Encontrar la ruta más corta para ir al trabajo
# - Espacio de soluciones: Todas las rutas posibles
# - Función objetivo: Tiempo de viaje
# - Objetivo: MINIMIZAR el tiempo

# EJEMPLO EN R: Encontrar el máximo de una función simple
# Supongamos que queremos maximizar: f(x) = -x^2 + 4x + 1

# Definir la función
f <- function(x) {
  return(-x^2 + 4*x + 1)
}

# Probar algunos valores
valores_x <- seq(0, 4, by = 0.5)
valores_f <- sapply(valores_x, f)

# Mostrar resultados
data.frame(x = valores_x, f_x = valores_f)

# Visualizar
plot(valores_x, valores_f, type = "b",
     col = "blue", lwd = 2,
     main = "Función f(x) = -x^2 + 4x + 1",
     xlab = "x", ylab = "f(x)",
     pch = 19)

# ¿Dónde está el máximo? Cerca de x = 2
# El máximo exacto está en x = 2, donde f(2) = 5

cat("\n🎯 LECCIÓN 1: La optimización busca el mejor valor de x que maximiza o minimiza f(x)\n")

# ============================================
# SECCIÓN 2: COMPONENTES DE UN PROBLEMA
# ============================================

# Todo problema de optimización tiene:
# 1. VARIABLES DE DECISIÓN: Lo que podemos cambiar (x)
# 2. FUNCIÓN OBJETIVO: Lo que queremos optimizar (f(x))
# 3. RESTRICCIONES: Límites en las variables (ej: x >= 0)
# 4. ESPACIO DE BÚSQUEDA: Conjunto de soluciones posibles

# EJEMPLO: Maximizar ganancias de una tienda

# Variables de decisión: cantidad de producto A y B
# Función objetivo: ganancia = 5*A + 3*B
# Restricciones:
#   - A >= 0, B >= 0 (no puedo vender cantidades negativas)
#   - A + B <= 100 (capacidad del almacén)
#   - 2*A + B <= 150 (tiempo disponible)

ganancia <- function(A, B) {
  # Si viola restricciones, retornar valor muy bajo
  if (A < 0 || B < 0 || A + B > 100 || 2*A + B > 150) {
    return(-Inf)
  }
  return(5*A + 3*B)
}

# Probar algunas combinaciones
cat("\nEJEMPLO DE OPTIMIZACIÓN CON RESTRICCIONES:\n")
cat("Ganancia(10, 20) =", ganancia(10, 20), "\n")
cat("Ganancia(50, 50) =", ganancia(50, 50), "(viola restricción)\n")
cat("Ganancia(40, 30) =", ganancia(40, 30), "\n")

# ============================================
# SECCIÓN 3: TIPOS DE OPTIMIZACIÓN
# ============================================

cat("\n📊 TIPOS DE OPTIMIZACIÓN:\n\n")

# 3.1 SEGÚN EL OBJETIVO
cat("1. MINIMIZACIÓN: Buscar el valor más pequeño\n")
cat("   Ejemplo: Minimizar costos, tiempo, errores\n\n")

cat("2. MAXIMIZACIÓN: Buscar el valor más grande\n")
cat("   Ejemplo: Maximizar ganancias, eficiencia\n\n")

# Truco: Maximizar f(x) = Minimizar -f(x)

# 3.2 SEGÚN EL ESPACIO DE BÚSQUEDA
cat("3. CONTINUA: Variables pueden tomar cualquier valor real\n")
cat("   Ejemplo: x = 2.5384...\n\n")

cat("4. DISCRETA: Variables toman valores enteros\n")
cat("   Ejemplo: x = {0, 1, 2, 3, ...}\n\n")

cat("5. COMBINATORIA: Ordenar o seleccionar elementos\n")
cat("   Ejemplo: Ruta de ciudades en un viaje\n\n")

# 3.3 SEGÚN LOS OBJETIVOS
cat("6. UNIOBJETIVO: Un solo objetivo\n")
cat("   Ejemplo: Minimizar solo el costo\n\n")

cat("7. MULTIOBJETIVO: Varios objetivos simultáneos\n")
cat("   Ejemplo: Minimizar costo Y maximizar calidad\n\n")

# ============================================
# SECCIÓN 4: BÚSQUEDA EXHAUSTIVA VS INTELIGENTE
# ============================================

cat("\n🔍 COMPARACIÓN DE MÉTODOS DE BÚSQUEDA:\n\n")

# 4.1 BÚSQUEDA EXHAUSTIVA (Fuerza bruta)
# Probar TODAS las posibles soluciones

funcion_compleja <- function(x) {
  return(sin(x) * cos(x/2) + x/10)
}

# Búsqueda exhaustiva en intervalo [0, 20]
cat("BÚSQUEDA EXHAUSTIVA:\n")
inicio <- Sys.time()

# Probar 10,000 puntos
puntos <- seq(0, 20, length.out = 10000)
valores <- sapply(puntos, funcion_compleja)
mejor_idx <- which.max(valores)
mejor_x_exhaustivo <- puntos[mejor_idx]
mejor_valor_exhaustivo <- valores[mejor_idx]

tiempo_exhaustivo <- Sys.time() - inicio

cat("Mejor x encontrado:", mejor_x_exhaustivo, "\n")
cat("Mejor valor:", mejor_valor_exhaustivo, "\n")
cat("Tiempo:", tiempo_exhaustivo, "\n\n")

# 4.2 BÚSQUEDA ALEATORIA
# Probar puntos al azar

cat("BÚSQUEDA ALEATORIA:\n")
inicio <- Sys.time()

set.seed(42)
n_intentos <- 1000
puntos_aleatorios <- runif(n_intentos, 0, 20)
valores_aleatorios <- sapply(puntos_aleatorios, funcion_compleja)
mejor_idx_aleatorio <- which.max(valores_aleatorios)
mejor_x_aleatorio <- puntos_aleatorios[mejor_idx_aleatorio]
mejor_valor_aleatorio <- valores_aleatorios[mejor_idx_aleatorio]

tiempo_aleatorio <- Sys.time() - inicio

cat("Mejor x encontrado:", mejor_x_aleatorio, "\n")
cat("Mejor valor:", mejor_valor_aleatorio, "\n")
cat("Tiempo:", tiempo_aleatorio, "\n\n")

# 4.3 BÚSQUEDA INTELIGENTE (Hill Climbing simple)
# Empezar en un punto y moverse hacia mejores soluciones

cat("BÚSQUEDA INTELIGENTE (Hill Climbing):\n")
inicio <- Sys.time()

hill_climbing <- function(f, x_inicio, paso = 0.1, max_iter = 100) {
  x_actual <- x_inicio
  valor_actual <- f(x_actual)

  for (i in 1:max_iter) {
    # Probar vecinos
    vecinos <- c(x_actual - paso, x_actual + paso)
    valores_vecinos <- sapply(vecinos, f)

    # Si algún vecino es mejor, moverse allí
    mejor_vecino_idx <- which.max(valores_vecinos)
    if (valores_vecinos[mejor_vecino_idx] > valor_actual) {
      x_actual <- vecinos[mejor_vecino_idx]
      valor_actual <- valores_vecinos[mejor_vecino_idx]
    } else {
      break  # No hay mejora, terminar
    }
  }

  return(list(x = x_actual, valor = valor_actual))
}

resultado_hill <- hill_climbing(funcion_compleja, x_inicio = 5)
tiempo_hill <- Sys.time() - inicio

cat("Mejor x encontrado:", resultado_hill$x, "\n")
cat("Mejor valor:", resultado_hill$valor, "\n")
cat("Tiempo:", tiempo_hill, "\n\n")

# Visualizar todos los métodos
plot(puntos, valores, type = "l", col = "gray", lwd = 2,
     main = "Comparación de Métodos de Búsqueda",
     xlab = "x", ylab = "f(x)")
points(mejor_x_exhaustivo, mejor_valor_exhaustivo, col = "blue", pch = 19, cex = 2)
points(mejor_x_aleatorio, mejor_valor_aleatorio, col = "red", pch = 17, cex = 2)
points(resultado_hill$x, resultado_hill$valor, col = "green", pch = 15, cex = 2)
legend("topright",
       c("Exhaustiva", "Aleatoria", "Hill Climbing"),
       col = c("blue", "red", "green"),
       pch = c(19, 17, 15))

cat("💡 LECCIÓN: Los métodos inteligentes encuentran buenas soluciones más rápido!\n")

# ============================================
# SECCIÓN 5: FUNCIONES DE BENCHMARK
# ============================================

cat("\n📐 FUNCIONES DE BENCHMARK CLÁSICAS:\n\n")

# Estas funciones se usan para probar algoritmos de optimización

# 5.1 FUNCIÓN ESFÉRICA (Sphere)
# Muy simple, un solo óptimo en (0,0)
esfera <- function(x) {
  return(sum(x^2))  # Minimizar, óptimo en x = (0, 0, ..., 0)
}

cat("1. FUNCIÓN ESFÉRICA:\n")
cat("   f(x) = x1^2 + x2^2 + ... + xn^2\n")
cat("   Óptimo: (0, 0, ..., 0)\n")
cat("   f(0,0) =", esfera(c(0,0)), "\n")
cat("   f(2,3) =", esfera(c(2,3)), "\n\n")

# Visualizar en 2D
x1 <- seq(-5, 5, length.out = 50)
x2 <- seq(-5, 5, length.out = 50)
z <- outer(x1, x2, function(x, y) esfera(c(x, y)))

contour(x1, x2, z, nlevels = 20,
        main = "Función Esférica",
        xlab = "x1", ylab = "x2")
points(0, 0, col = "red", pch = 19, cex = 2)  # Óptimo

# 5.2 FUNCIÓN DE ROSENBROCK
# Más difícil, valle largo y estrecho
rosenbrock <- function(x) {
  n <- length(x)
  suma <- 0
  for (i in 1:(n-1)) {
    suma <- suma + 100*(x[i+1] - x[i]^2)^2 + (1 - x[i])^2
  }
  return(suma)  # Minimizar, óptimo en x = (1, 1, ..., 1)
}

cat("2. FUNCIÓN DE ROSENBROCK:\n")
cat("   Óptimo: (1, 1, ..., 1)\n")
cat("   f(1,1) =", rosenbrock(c(1,1)), "\n")
cat("   f(0,0) =", rosenbrock(c(0,0)), "\n\n")

# Visualizar
z_rosen <- outer(x1, x2, function(x, y) rosenbrock(c(x, y)))
contour(x1, x2, z_rosen, nlevels = 30,
        main = "Función de Rosenbrock (Valle)",
        xlab = "x1", ylab = "x2")
points(1, 1, col = "red", pch = 19, cex = 2)  # Óptimo

# 5.3 FUNCIÓN DE RASTRIGIN
# Múltiples óptimos locales, muy difícil!
rastrigin <- function(x) {
  n <- length(x)
  A <- 10
  return(A*n + sum(x^2 - A*cos(2*pi*x)))  # Minimizar, óptimo en (0,0)
}

cat("3. FUNCIÓN DE RASTRIGIN:\n")
cat("   Muchos óptimos locales!\n")
cat("   Óptimo global: (0, 0, ..., 0)\n")
cat("   f(0,0) =", rastrigin(c(0,0)), "\n\n")

# Visualizar
x1_rast <- seq(-5, 5, length.out = 100)
x2_rast <- seq(-5, 5, length.out = 100)
z_rast <- outer(x1_rast, x2_rast, function(x, y) rastrigin(c(x, y)))

contour(x1_rast, x2_rast, z_rast, nlevels = 30,
        main = "Función de Rastrigin (Múltiples Óptimos)",
        xlab = "x1", ylab = "x2",
        col = terrain.colors(30))
points(0, 0, col = "red", pch = 19, cex = 2)  # Óptimo global

cat("💡 LECCIÓN: Algunas funciones son MUY difíciles de optimizar!\n")
cat("   Aquí es donde PSO y Algoritmos Genéticos brillan!\n\n")

# ============================================
# SECCIÓN 6: TU PRIMER OPTIMIZADOR SIMPLE
# ============================================

cat("\n🚀 CONSTRUYAMOS TU PRIMER OPTIMIZADOR:\n\n")

# Algoritmo: BÚSQUEDA ALEATORIA MEJORADA
# Idea: Generar soluciones aleatorias, pero recordar la mejor

optimizador_simple <- function(funcion_objetivo,
                               dimension,
                               limites = c(-10, 10),
                               n_iteraciones = 100,
                               verbose = TRUE) {
  # funcion_objetivo: función a MINIMIZAR
  # dimension: número de variables
  # limites: vector c(minimo, maximo) para cada variable
  # n_iteraciones: cuántas soluciones probar
  # verbose: mostrar progreso

  # Inicializar
  mejor_solucion <- NULL
  mejor_valor <- Inf
  historial <- numeric(n_iteraciones)

  for (i in 1:n_iteraciones) {
    # Generar solución aleatoria
    solucion <- runif(dimension, limites[1], limites[2])

    # Evaluar
    valor <- funcion_objetivo(solucion)

    # ¿Es mejor que la mejor actual?
    if (valor < mejor_valor) {
      mejor_valor <- valor
      mejor_solucion <- solucion
      if (verbose) {
        cat("Iteración", i, ": Nuevo mejor =", mejor_valor, "\n")
      }
    }

    # Guardar historial
    historial[i] <- mejor_valor
  }

  return(list(
    solucion = mejor_solucion,
    valor = mejor_valor,
    historial = historial
  ))
}

# PROBAR CON FUNCIÓN ESFÉRICA
cat("Optimizando función esférica en 2D:\n")
resultado <- optimizador_simple(
  funcion_objetivo = esfera,
  dimension = 2,
  limites = c(-10, 10),
  n_iteraciones = 50,
  verbose = TRUE
)

cat("\n✅ RESULTADO FINAL:\n")
cat("Mejor solución encontrada:", resultado$solucion, "\n")
cat("Valor óptimo:", resultado$valor, "\n")
cat("Solución exacta: (0, 0) con valor 0\n")

# Visualizar convergencia
plot(1:length(resultado$historial), resultado$historial,
     type = "l", col = "blue", lwd = 2,
     main = "Convergencia del Optimizador",
     xlab = "Iteración",
     ylab = "Mejor valor encontrado",
     ylim = c(0, max(resultado$historial)))
abline(h = 0, col = "red", lty = 2)  # Óptimo real
grid()

cat("\n💡 LECCIÓN: ¡Has creado tu primer optimizador!\n")
cat("   Aunque simple, muestra los conceptos básicos.\n\n")

# ============================================
# SECCIÓN 7: EJERCICIOS PRÁCTICOS
# ============================================

cat("\n✏️ EJERCICIOS PARA PRACTICAR:\n\n")

cat("EJERCICIO 1 (FÁCIL):\n")
cat("Encuentra el mínimo de f(x) = (x-3)^2 + 5\n")
cat("Pista: El mínimo está en x = 3, f(3) = 5\n\n")

# TU CÓDIGO AQUÍ:
# ejercicio_1 <- function(x) {
#   # Completa esta función
# }
# resultado_1 <- optimizador_simple(ejercicio_1, dimension = 1, limites = c(0, 10))

cat("EJERCICIO 2 (FÁCIL):\n")
cat("Maximiza f(x) = -x^2 + 6x - 2\n")
cat("Pista: Para maximizar, minimiza -f(x)\n\n")

# TU CÓDIGO AQUÍ:

cat("EJERCICIO 3 (MEDIO):\n")
cat("Minimiza la función esférica en 5 dimensiones\n")
cat("Usa 200 iteraciones\n\n")

# TU CÓDIGO AQUÍ:

cat("EJERCICIO 4 (MEDIO):\n")
cat("Crea una función que encuentre el máximo de f(x,y) = -(x^2 + y^2) + 4\n")
cat("El máximo está en (0,0) con valor 4\n\n")

# TU CÓDIGO AQUÍ:

cat("EJERCICIO 5 (DIFÍCIL):\n")
cat("Modifica el optimizador_simple para que:\n")
cat("- Guarde las 10 mejores soluciones (no solo la mejor)\n")
cat("- Calcule la desviación estándar de las mejores soluciones\n")
cat("- Retorne estadísticas adicionales\n\n")

# TU CÓDIGO AQUÍ:

# ============================================
# SOLUCIONES A LOS EJERCICIOS
# ============================================
# (Desplázate hacia abajo solo después de intentar los ejercicios)

cat("\n" , rep("=", 50), "\n")
cat("SOLUCIONES - ¡No hagas trampa! Intenta primero\n")
cat(rep("=", 50), "\n\n")

# SOLUCIÓN EJERCICIO 1
ejercicio_1 <- function(x) {
  return((x - 3)^2 + 5)
}

cat("SOLUCIÓN EJERCICIO 1:\n")
solucion_1 <- optimizador_simple(ejercicio_1, dimension = 1,
                                  limites = c(0, 10),
                                  n_iteraciones = 50,
                                  verbose = FALSE)
cat("Mínimo encontrado en x =", solucion_1$solucion, "\n")
cat("Valor mínimo =", solucion_1$valor, "\n")
cat("Respuesta correcta: x = 3, f(3) = 5\n\n")

# SOLUCIÓN EJERCICIO 2
ejercicio_2 <- function(x) {
  # Para maximizar f(x), minimizamos -f(x)
  return(-(-x^2 + 6*x - 2))  # = x^2 - 6x + 2
}

cat("SOLUCIÓN EJERCICIO 2:\n")
solucion_2 <- optimizador_simple(ejercicio_2, dimension = 1,
                                  limites = c(0, 10),
                                  n_iteraciones = 50,
                                  verbose = FALSE)
cat("Máximo encontrado en x =", solucion_2$solucion, "\n")
cat("Valor máximo = ", -solucion_2$valor, "(negativo del mínimo)\n")
cat("Respuesta correcta: x = 3, f(3) = 7\n\n")

# SOLUCIÓN EJERCICIO 3
cat("SOLUCIÓN EJERCICIO 3:\n")
solucion_3 <- optimizador_simple(esfera, dimension = 5,
                                  limites = c(-10, 10),
                                  n_iteraciones = 200,
                                  verbose = FALSE)
cat("Mínimo encontrado:", solucion_3$solucion, "\n")
cat("Valor mínimo =", solucion_3$valor, "\n\n")

# SOLUCIÓN EJERCICIO 4
ejercicio_4 <- function(x) {
  # x es un vector c(x, y)
  return(-(-(x[1]^2 + x[2]^2) + 4))  # Minimizar la negación
}

cat("SOLUCIÓN EJERCICIO 4:\n")
solucion_4 <- optimizador_simple(ejercicio_4, dimension = 2,
                                  limites = c(-5, 5),
                                  n_iteraciones = 100,
                                  verbose = FALSE)
cat("Máximo encontrado en:", solucion_4$solucion, "\n")
cat("Valor máximo =", -solucion_4$valor, "\n\n")

# SOLUCIÓN EJERCICIO 5
optimizador_avanzado <- function(funcion_objetivo,
                                 dimension,
                                 limites = c(-10, 10),
                                 n_iteraciones = 100,
                                 n_mejores = 10) {
  # Guardar las n_mejores soluciones
  mejores_soluciones <- matrix(NA, nrow = n_mejores, ncol = dimension)
  mejores_valores <- rep(Inf, n_mejores)
  historial <- numeric(n_iteraciones)

  for (i in 1:n_iteraciones) {
    # Generar solución aleatoria
    solucion <- runif(dimension, limites[1], limites[2])
    valor <- funcion_objetivo(solucion)

    # ¿Entra en el top n_mejores?
    peor_idx <- which.max(mejores_valores)
    if (valor < mejores_valores[peor_idx]) {
      mejores_valores[peor_idx] <- valor
      mejores_soluciones[peor_idx, ] <- solucion
    }

    historial[i] <- min(mejores_valores)
  }

  # Ordenar por valor
  orden <- order(mejores_valores)
  mejores_soluciones <- mejores_soluciones[orden, ]
  mejores_valores <- mejores_valores[orden]

  # Calcular estadísticas
  estadisticas <- list(
    media = mean(mejores_valores),
    mediana = median(mejores_valores),
    desv_std = sd(mejores_valores),
    rango = range(mejores_valores)
  )

  return(list(
    mejor_solucion = mejores_soluciones[1, ],
    mejor_valor = mejores_valores[1],
    top_soluciones = mejores_soluciones,
    top_valores = mejores_valores,
    estadisticas = estadisticas,
    historial = historial
  ))
}

cat("SOLUCIÓN EJERCICIO 5:\n")
solucion_5 <- optimizador_avanzado(esfera, dimension = 2,
                                    n_iteraciones = 100,
                                    n_mejores = 10)
cat("Mejor solución:", solucion_5$mejor_solucion, "\n")
cat("Top 10 valores:", solucion_5$top_valores, "\n")
cat("Media de top 10:", solucion_5$estadisticas$media, "\n")
cat("Desviación estándar:", solucion_5$estadisticas$desv_std, "\n\n")

# ============================================
# RESUMEN DEL MÓDULO 1
# ============================================

cat("\n", rep("🎓", 20), "\n")
cat("RESUMEN DEL MÓDULO 1: FUNDAMENTOS DE OPTIMIZACIÓN\n")
cat(rep("🎓", 20), "\n\n")

cat("✅ Has aprendido:\n")
cat("  1. Qué es la optimización y sus componentes\n")
cat("  2. Tipos de problemas de optimización\n")
cat("  3. Diferencia entre búsqueda exhaustiva e inteligente\n")
cat("  4. Funciones de benchmark clásicas\n")
cat("  5. Cómo crear un optimizador simple desde cero\n\n")

cat("🎯 Próximos pasos:\n")
cat("  1. Completa todos los ejercicios\n")
cat("  2. Experimenta con diferentes funciones\n")
cat("  3. Modifica los parámetros y observa qué pasa\n")
cat("  4. Cuando te sientas cómodo, pasa al Módulo 2\n\n")

cat("🚀 Continúa con: modulo_2_geneticos_basico.R\n\n")

cat("💡 CONSEJO FINAL:\n")
cat("   La optimización es un arte. No hay 'una sola' respuesta correcta.\n")
cat("   Experimenta, prueba, aprende de los errores.\n")
cat("   ¡Los mejores algoritmos nacen de la creatividad y la práctica!\n\n")
