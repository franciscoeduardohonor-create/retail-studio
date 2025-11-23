# ============================================
# MÓDULO 3: ALGORITMOS GENÉTICOS - AVANZADO
# ============================================
# Curso: PSO y Algoritmos Genéticos en R
# Nivel: INTERMEDIO-AVANZADO
# Duración estimada: 4-5 horas

# ============================================
# TABLA DE CONTENIDOS
# ============================================
# 1. Estrategias de selección avanzadas
# 2. Operadores de cruce especializados
# 3. Adaptación dinámica de parámetros
# 4. Restricciones y penalizaciones
# 5. Optimización multiobjetivo (NSGA-II)
# 6. Algoritmos genéticos paralelos
# 7. Casos de uso especializados
# 8. Ejercicios avanzados

# Cargar librerías necesarias
if (!require("GA")) install.packages("GA")
library(GA)

# ============================================
# SECCIÓN 1: SELECCIÓN AVANZADA
# ============================================

cat("\n🎯 ESTRATEGIAS DE SELECCIÓN AVANZADAS\n\n")

# 1.1 SELECCIÓN POR RANKING
cat("1.1 SELECCIÓN POR RANKING:\n")
cat("Los individuos se ordenan por fitness, no por valor absoluto\n")
cat("Evita dominación por individuos con fitness muy alto\n\n")

seleccion_ranking <- function(poblacion, fitness, presion = 1.5) {
  # presion: 1.5 = ranking lineal moderado, 2 = más presión
  n <- length(fitness)

  # Ordenar por fitness
  orden <- order(fitness, decreasing = TRUE)
  poblacion_ordenada <- poblacion[orden, , drop = FALSE]

  # Calcular probabilidades basadas en ranking
  ranks <- n:1  # Los mejores tienen rank bajo
  probabilidades <- (2 - presion) + 2 * (presion - 1) * (ranks - 1) / (n - 1)
  probabilidades <- probabilidades / sum(probabilidades)

  # Seleccionar
  idx <- sample(1:n, 1, prob = probabilidades)
  return(poblacion_ordenada[idx, ])
}

# Ejemplo
set.seed(42)
poblacion_ejemplo <- matrix(rnorm(20), nrow = 5, ncol = 4)
fitness_ejemplo <- c(10, 100, 15, 5, 50)  # Un individuo muy dominante

cat("Fitness:", fitness_ejemplo, "\n")
seleccionados <- replicate(1000, seleccion_ranking(poblacion_ejemplo, fitness_ejemplo))
cat("Individuo 2 (fitness=100) seleccionado:", sum(seleccionados[1,] == poblacion_ejemplo[2,1]) / 1000 * 100, "%\n\n")

# 1.2 SELECCIÓN ESTOCÁSTICA UNIVERSAL (SUS)
cat("1.2 SELECCIÓN ESTOCÁSTICA UNIVERSAL (SUS):\n")
cat("Variante de ruleta con menor varianza\n")
cat("Selecciona múltiples individuos con un solo 'giro'\n\n")

seleccion_SUS <- function(poblacion, fitness, n_seleccionar) {
  # Calcular probabilidades
  fitness_total <- sum(fitness)
  probabilidades <- fitness / fitness_total

  # Calcular puntos de selección
  punto_inicio <- runif(1, 0, 1/n_seleccionar)
  puntos <- punto_inicio + (0:(n_seleccionar-1)) / n_seleccionar

  # Seleccionar individuos
  seleccionados <- matrix(NA, nrow = n_seleccionar, ncol = ncol(poblacion))
  suma_acumulada <- cumsum(probabilidades)

  for (i in 1:n_seleccionar) {
    idx <- which(suma_acumulada >= puntos[i])[1]
    seleccionados[i, ] <- poblacion[idx, ]
  }

  return(seleccionados)
}

# Ejemplo
seleccionados_sus <- seleccion_SUS(poblacion_ejemplo, fitness_ejemplo, 3)
cat("Seleccionados 3 individuos con SUS\n\n")

# ============================================
# SECCIÓN 2: OPERADORES DE CRUCE AVANZADOS
# ============================================

cat("\n🧬 OPERADORES DE CRUCE ESPECIALIZADOS\n\n")

# 2.1 CRUCE BLX-α (Blend Crossover)
cat("2.1 CRUCE BLX-α:\n")
cat("Permite exploración más allá del rango de los padres\n")
cat("α controla cuánto se puede alejar de los padres\n\n")

cruce_BLX_alpha <- function(padre1, padre2, alpha = 0.5) {
  n <- length(padre1)
  hijo1 <- numeric(n)
  hijo2 <- numeric(n)

  for (i in 1:n) {
    # Calcular rango
    min_val <- min(padre1[i], padre2[i])
    max_val <- max(padre1[i], padre2[i])
    rango <- max_val - min_val

    # Expandir rango con alpha
    lower <- min_val - alpha * rango
    upper <- max_val + alpha * rango

    # Generar hijos en el rango expandido
    hijo1[i] <- runif(1, lower, upper)
    hijo2[i] <- runif(1, lower, upper)
  }

  return(list(hijo1 = hijo1, hijo2 = hijo2))
}

# Ejemplo
padre1 <- c(2.0, 5.0, 1.5)
padre2 <- c(3.0, 4.0, 2.5)
cat("Padre 1:", padre1, "\n")
cat("Padre 2:", padre2, "\n")

hijos_blx <- cruce_BLX_alpha(padre1, padre2, alpha = 0.5)
cat("Hijo 1: ", round(hijos_blx$hijo1, 2), "\n")
cat("Hijo 2: ", round(hijos_blx$hijo2, 2), "\n\n")

# 2.2 CRUCE SBX (Simulated Binary Crossover)
cat("2.2 CRUCE SBX:\n")
cat("Simula el comportamiento del cruce binario de un punto\n")
cat("Muy usado en optimización de funciones reales\n\n")

cruce_SBX <- function(padre1, padre2, eta = 20) {
  # eta: parámetro de distribución (mayor = hijos más cercanos a padres)
  n <- length(padre1)
  hijo1 <- numeric(n)
  hijo2 <- numeric(n)

  for (i in 1:n) {
    if (abs(padre1[i] - padre2[i]) > 1e-14) {
      if (padre1[i] < padre2[i]) {
        y1 <- padre1[i]
        y2 <- padre2[i]
      } else {
        y1 <- padre2[i]
        y2 <- padre1[i]
      }

      # Calcular beta
      rand <- runif(1)
      if (rand <= 0.5) {
        beta <- (2 * rand)^(1 / (eta + 1))
      } else {
        beta <- (1 / (2 * (1 - rand)))^(1 / (eta + 1))
      }

      # Crear hijos
      hijo1[i] <- 0.5 * ((y1 + y2) - beta * (y2 - y1))
      hijo2[i] <- 0.5 * ((y1 + y2) + beta * (y2 - y1))
    } else {
      hijo1[i] <- padre1[i]
      hijo2[i] <- padre2[i]
    }
  }

  return(list(hijo1 = hijo1, hijo2 = hijo2))
}

# Ejemplo
hijos_sbx <- cruce_SBX(padre1, padre2, eta = 20)
cat("Con SBX (eta=20):\n")
cat("Hijo 1: ", round(hijos_sbx$hijo1, 2), "\n")
cat("Hijo 2: ", round(hijos_sbx$hijo2, 2), "\n\n")

# 2.3 CRUCE PMX (Partially Mapped Crossover) - Para permutaciones
cat("2.3 CRUCE PMX:\n")
cat("Especial para problemas de permutaciones (ej: TSP)\n")
cat("Preserva la validez de la permutación\n\n")

cruce_PMX <- function(padre1, padre2) {
  n <- length(padre1)

  # Seleccionar dos puntos de corte
  puntos <- sort(sample(1:n, 2))
  p1 <- puntos[1]
  p2 <- puntos[2]

  # Crear hijos copiando el segmento medio
  hijo1 <- rep(NA, n)
  hijo2 <- rep(NA, n)

  hijo1[p1:p2] <- padre1[p1:p2]
  hijo2[p1:p2] <- padre2[p1:p2]

  # Mapeo para completar
  for (i in p1:p2) {
    # Para hijo1
    if (!(padre2[i] %in% hijo1)) {
      pos <- i
      while (pos >= p1 && pos <= p2) {
        pos <- which(padre2 == padre1[pos])
      }
      hijo1[pos] <- padre2[i]
    }

    # Para hijo2
    if (!(padre1[i] %in% hijo2)) {
      pos <- i
      while (pos >= p1 && pos <= p2) {
        pos <- which(padre1 == padre2[pos])
      }
      hijo2[pos] <- padre1[i]
    }
  }

  # Completar posiciones restantes
  for (i in 1:n) {
    if (is.na(hijo1[i])) hijo1[i] <- padre2[i]
    if (is.na(hijo2[i])) hijo2[i] <- padre1[i]
  }

  return(list(hijo1 = hijo1, hijo2 = hijo2))
}

# Ejemplo con permutación
padre1_perm <- c(1, 2, 3, 4, 5, 6, 7, 8)
padre2_perm <- c(3, 7, 5, 1, 6, 8, 2, 4)
cat("Padre 1:", padre1_perm, "\n")
cat("Padre 2:", padre2_perm, "\n")

hijos_pmx <- cruce_PMX(padre1_perm, padre2_perm)
cat("Hijo 1: ", hijos_pmx$hijo1, "\n")
cat("Hijo 2: ", hijos_pmx$hijo2, "\n\n")

# ============================================
# SECCIÓN 3: ADAPTACIÓN DINÁMICA
# ============================================

cat("\n⚡ ADAPTACIÓN DINÁMICA DE PARÁMETROS\n\n")

# 3.1 MUTACIÓN ADAPTATIVA
cat("3.1 MUTACIÓN ADAPTATIVA:\n")
cat("La probabilidad de mutación cambia durante la evolución\n")
cat("Alta al inicio (exploración), baja al final (explotación)\n\n")

prob_mutacion_adaptativa <- function(generacion, max_generaciones,
                                     prob_inicial = 0.3,
                                     prob_final = 0.01) {
  # Decrecimiento lineal
  prob <- prob_inicial - (prob_inicial - prob_final) * generacion / max_generaciones
  return(prob)
}

# Visualizar
gens <- 1:100
probs <- sapply(gens, prob_mutacion_adaptativa, max_generaciones = 100)
plot(gens, probs, type = "l", lwd = 2, col = "blue",
     main = "Probabilidad de Mutación Adaptativa",
     xlab = "Generación", ylab = "Prob. Mutación")
grid()

cat("\n")

# 3.2 AG CON PARÁMETROS ADAPTATIVOS
cat("3.2 AG CON PARÁMETROS ADAPTATIVOS:\n\n")

AG_adaptativo <- function(funcion_fitness, dimension, limites = c(-10, 10),
                         tam_poblacion = 50, n_generaciones = 100) {

  # Inicialización
  poblacion <- matrix(runif(tam_poblacion * dimension, limites[1], limites[2]),
                     nrow = tam_poblacion, ncol = dimension)

  historial_mejor <- numeric(n_generaciones)
  mejor_global <- -Inf
  mejor_solucion_global <- NULL

  for (gen in 1:n_generaciones) {
    # Evaluar fitness
    fitness <- apply(poblacion, 1, funcion_fitness)

    # Actualizar mejor
    mejor_idx <- which.max(fitness)
    if (fitness[mejor_idx] > mejor_global) {
      mejor_global <- fitness[mejor_idx]
      mejor_solucion_global <- poblacion[mejor_idx, ]
    }

    historial_mejor[gen] <- mejor_global

    # PARÁMETROS ADAPTATIVOS
    prob_mut <- prob_mutacion_adaptativa(gen, n_generaciones, 0.3, 0.01)
    prob_cruce <- 0.9 - 0.2 * gen / n_generaciones  # Disminuye levemente

    # Nueva población
    nueva_pob <- matrix(0, nrow = tam_poblacion, ncol = dimension)
    nueva_pob[1, ] <- poblacion[mejor_idx, ]  # Elitismo

    for (i in 2:tam_poblacion) {
      # Selección por torneo
      idx1 <- sample(1:tam_poblacion, 3)
      idx2 <- sample(1:tam_poblacion, 3)
      p1 <- poblacion[idx1[which.max(fitness[idx1])], ]
      p2 <- poblacion[idx2[which.max(fitness[idx2])], ]

      # Cruce
      if (runif(1) < prob_cruce) {
        alpha <- runif(1)
        hijo <- alpha * p1 + (1 - alpha) * p2
      } else {
        hijo <- p1
      }

      # Mutación adaptativa
      for (j in 1:dimension) {
        if (runif(1) < prob_mut) {
          # Sigma también se adapta
          sigma <- (limites[2] - limites[1]) * (1 - gen / n_generaciones) * 0.1
          hijo[j] <- hijo[j] + rnorm(1, 0, sigma)
          hijo[j] <- max(limites[1], min(limites[2], hijo[j]))
        }
      }

      nueva_pob[i, ] <- hijo
    }

    poblacion <- nueva_pob

    if (gen %% 20 == 0) {
      cat(sprintf("Gen %d: Mejor = %.4f, P(mut) = %.3f\n",
                  gen, mejor_global, prob_mut))
    }
  }

  return(list(mejor_solucion = mejor_solucion_global,
              mejor_fitness = mejor_global,
              historial = historial_mejor))
}

# Probar con función esférica
fitness_esfera <- function(x) -sum(x^2)

cat("Ejecutando AG adaptativo...\n")
resultado_adapt <- AG_adaptativo(fitness_esfera, dimension = 5,
                                 limites = c(-10, 10),
                                 n_generaciones = 100)

cat("\n✅ Mejor solución:", round(resultado_adapt$mejor_solucion, 4), "\n")
cat("Fitness:", resultado_adapt$mejor_fitness, "\n\n")

# ============================================
# SECCIÓN 4: RESTRICCIONES Y PENALIZACIONES
# ============================================

cat("\n🚧 MANEJO DE RESTRICCIONES\n\n")

# 4.1 MÉTODO DE PENALIZACIÓN
cat("4.1 MÉTODO DE PENALIZACIÓN:\n")
cat("Reducir el fitness de soluciones que violan restricciones\n\n")

# Problema: Maximizar x + y
# Restricciones: x + y <= 10, x >= 0, y >= 0, x^2 + y^2 <= 25

fitness_con_restricciones <- function(x, penalizacion = 1000) {
  x_val <- x[1]
  y_val <- x[2]

  # Función objetivo
  obj <- x_val + y_val

  # Calcular violaciones
  violacion <- 0

  if (x_val + y_val > 10) {
    violacion <- violacion + (x_val + y_val - 10)^2
  }

  if (x_val < 0) {
    violacion <- violacion + x_val^2
  }

  if (y_val < 0) {
    violacion <- violacion + y_val^2
  }

  if (x_val^2 + y_val^2 > 25) {
    violacion <- violacion + (x_val^2 + y_val^2 - 25)^2
  }

  # Fitness con penalización
  fitness <- obj - penalizacion * violacion

  return(fitness)
}

# Optimizar
cat("Optimizando problema con restricciones...\n")
resultado_rest <- AG_adaptativo(fitness_con_restricciones,
                                dimension = 2,
                                limites = c(-5, 10),
                                n_generaciones = 80)

cat("Mejor (x,y):", round(resultado_rest$mejor_solucion, 2), "\n")
cat("x + y =", sum(resultado_rest$mejor_solucion), "(debe ser <= 10)\n")
cat("x^2 + y^2 =", sum(resultado_rest$mejor_solucion^2), "(debe ser <= 25)\n\n")

# ============================================
# SECCIÓN 5: OPTIMIZACIÓN MULTIOBJETIVO
# ============================================

cat("\n🎯 OPTIMIZACIÓN MULTIOBJETIVO (NSGA-II Simplificado)\n\n")

cat("PROBLEMA: Optimizar dos objetivos simultáneamente\n")
cat("Ejemplo: Minimizar costo Y maximizar calidad\n")
cat("No hay una única solución, sino un Frente de Pareto\n\n")

# Funciones objetivo
objetivo1 <- function(x) x^2          # Minimizar
objetivo2 <- function(x) (x - 2)^2    # Minimizar

# Dominancia de Pareto
domina <- function(fitness1, fitness2) {
  # ¿fitness1 domina a fitness2?
  # (es mejor en al menos un objetivo y no peor en ninguno)
  mejor_en_alguno <- any(fitness1 < fitness2)  # Minimización
  no_peor_en_ninguno <- all(fitness1 <= fitness2)
  return(mejor_en_alguno && no_peor_en_ninguno)
}

# Encontrar frente de Pareto
frente_pareto <- function(poblacion_fitness) {
  n <- nrow(poblacion_fitness)
  frente <- logical(n)

  for (i in 1:n) {
    dominado <- FALSE
    for (j in 1:n) {
      if (i != j && domina(poblacion_fitness[j, ], poblacion_fitness[i, ])) {
        dominado <- TRUE
        break
      }
    }
    frente[i] <- !dominado
  }

  return(frente)
}

# Generar población ejemplo
set.seed(42)
x_vals <- runif(50, -2, 4)
fitness_multiobj <- cbind(
  sapply(x_vals, objetivo1),
  sapply(x_vals, objetivo2)
)

# Encontrar frente
pareto <- frente_pareto(fitness_multiobj)

# Visualizar
plot(fitness_multiobj[, 1], fitness_multiobj[, 2],
     col = ifelse(pareto, "red", "blue"),
     pch = 19, cex = 1.5,
     xlab = "Objetivo 1 (x^2)",
     ylab = "Objetivo 2 ((x-2)^2)",
     main = "Frente de Pareto")
legend("topright",
       c("Frente de Pareto", "Dominadas"),
       col = c("red", "blue"),
       pch = 19)
grid()

cat("Soluciones en el frente de Pareto:", sum(pareto), "\n")
cat("Soluciones dominadas:", sum(!pareto), "\n\n")

# ============================================
# SECCIÓN 6: USO DEL PAQUETE GA
# ============================================

cat("\n📦 USANDO EL PAQUETE 'GA' DE R\n\n")

cat("El paquete GA implementa AGs profesionales\n")
cat("Vamos a compararlo con nuestra implementación\n\n")

# Función a maximizar
rastrigin_fitness <- function(x) {
  -(-20 - sum(x^2 - 10*cos(2*pi*x)))  # Negativo porque GA maximiza
}

# Usando el paquete GA
cat("Ejecutando con paquete GA...\n")
ga_result <- ga(
  type = "real-valued",
  fitness = rastrigin_fitness,
  lower = c(-5, -5),
  upper = c(5, 5),
  popSize = 50,
  maxiter = 100,
  pmutation = 0.1,
  pcrossover = 0.8,
  elitism = base::max(1, round(50*0.05)),
  monitor = FALSE
)

cat("\n✅ Resultados con paquete GA:\n")
cat("Mejor solución:", ga_result@solution[1,], "\n")
cat("Mejor fitness:", ga_result@fitnessValue, "\n\n")

# Visualizar evolución
plot(ga_result)

# ============================================
# SECCIÓN 7: CASOS DE USO ESPECIALIZADOS
# ============================================

cat("\n💼 CASOS DE USO ESPECIALIZADOS\n\n")

# 7.1 PROBLEMA DE LA MOCHILA (KNAPSACK)
cat("7.1 PROBLEMA DE LA MOCHILA:\n")
cat("Seleccionar objetos que maximicen valor sin exceder peso\n\n")

# Datos: peso, valor
objetos <- data.frame(
  peso = c(10, 20, 30, 40, 50),
  valor = c(60, 100, 120, 240, 310)
)
capacidad_mochila <- 100

cat("Objetos disponibles:\n")
print(objetos)
cat("Capacidad de la mochila:", capacidad_mochila, "\n\n")

# Fitness para mochila (cromosoma binario: 1 = llevar, 0 = no llevar)
fitness_mochila <- function(cromosoma) {
  peso_total <- sum(cromosoma * objetos$peso)
  valor_total <- sum(cromosoma * objetos$valor)

  # Si excede capacidad, penalizar
  if (peso_total > capacidad_mochila) {
    return(0)
  }

  return(valor_total)
}

# Resolver con GA
ga_mochila <- ga(
  type = "binary",
  fitness = fitness_mochila,
  nBits = nrow(objetos),
  popSize = 30,
  maxiter = 50,
  monitor = FALSE
)

cat("✅ Solución óptima:\n")
solucion <- ga_mochila@solution[1,]
cat("Objetos seleccionados:", which(solucion == 1), "\n")
cat("Peso total:", sum(solucion * objetos$peso), "kg\n")
cat("Valor total:", sum(solucion * objetos$valor), "$\n\n")

# ============================================
# SECCIÓN 8: EJERCICIOS AVANZADOS
# ============================================

cat("\n✏️ EJERCICIOS AVANZADOS:\n\n")

cat("EJERCICIO 1 (MEDIO):\n")
cat("Implementa selección por ranking en el AG adaptativo\n")
cat("Compara resultados con selección por torneo\n\n")

cat("EJERCICIO 2 (MEDIO):\n")
cat("Usa cruce BLX-α en el AG adaptativo\n")
cat("Experimenta con diferentes valores de α (0.0, 0.5, 1.0)\n\n")

cat("EJERCICIO 3 (DIFÍCIL):\n")
cat("Implementa un AG para el problema del vendedor viajero (TSP)\n")
cat("Usa cruce PMX y mutación por intercambio\n")
cat("Ciudades: distancias aleatorias entre 8 ciudades\n\n")

cat("EJERCICIO 4 (DIFÍCIL):\n")
cat("Resuelve un problema multiobjetivo:\n")
cat("- Minimizar f1(x,y) = x^2 + y^2\n")
cat("- Minimizar f2(x,y) = (x-1)^2 + (y-1)^2\n")
cat("Encuentra el frente de Pareto\n\n")

cat("EJERCICIO 5 (MUY DIFÍCIL):\n")
cat("Implementa un AG paralelo con islas:\n")
cat("- 4 sub-poblaciones evolucionan independientemente\n")
cat("- Cada 10 generaciones, migran los mejores individuos\n")
cat("- Usa el paquete 'parallel' de R\n\n")

# ============================================
# SOLUCIONES PARCIALES
# ============================================

cat("\n", rep("=", 60), "\n")
cat("SOLUCIONES Y PISTAS\n")
cat(rep("=", 60), "\n\n")

# SOLUCIÓN EJERCICIO 3: TSP Simple
cat("PISTA EJERCICIO 3 - Estructura para TSP:\n\n")

cat("
# Matriz de distancias entre ciudades
crear_matriz_distancias <- function(n_ciudades) {
  dist_matrix <- matrix(0, n_ciudades, n_ciudades)
  for (i in 1:(n_ciudades-1)) {
    for (j in (i+1):n_ciudades) {
      dist <- runif(1, 10, 100)
      dist_matrix[i, j] <- dist
      dist_matrix[j, i] <- dist
    }
  }
  return(dist_matrix)
}

# Fitness: longitud total del tour
fitness_tsp <- function(tour, dist_matrix) {
  n <- length(tour)
  distancia_total <- 0
  for (i in 1:(n-1)) {
    distancia_total <- distancia_total +
      dist_matrix[tour[i], tour[i+1]]
  }
  # Volver al inicio
  distancia_total <- distancia_total +
    dist_matrix[tour[n], tour[1]]

  return(-distancia_total)  # Negativo porque GA maximiza
}

# Usa esto como base y completa el AG!
")

cat("\nPISTA EJERCICIO 4 - Multiobjetivo:\n")
cat("1. Evalúa ambos objetivos para cada individuo\n")
cat("2. Usa la función frente_pareto() del módulo\n")
cat("3. Selección: prefiere individuos en el frente\n")
cat("4. Visualiza con plot(obj1, obj2)\n\n")

# ============================================
# RESUMEN
# ============================================

cat("\n", rep("🎓", 30), "\n")
cat("RESUMEN MÓDULO 3: ALGORITMOS GENÉTICOS AVANZADOS\n")
cat(rep("🎓", 30), "\n\n")

cat("✅ Has dominado:\n")
cat("  1. Selección avanzada: Ranking, SUS\n")
cat("  2. Cruces especializados: BLX-α, SBX, PMX\n")
cat("  3. Adaptación dinámica de parámetros\n")
cat("  4. Manejo de restricciones\n")
cat("  5. Optimización multiobjetivo (Pareto)\n")
cat("  6. Uso del paquete GA profesional\n")
cat("  7. Problemas especializados (mochila, TSP)\n\n")

cat("💡 Conceptos clave:\n")
cat("  • No existe 'el mejor' AG para todo\n")
cat("  • Adapta el algoritmo al problema\n")
cat("  • Experimenta con operadores\n")
cat("  • Multiobjetivo → Frente de Pareto\n")
cat("  • Usa paquetes profesionales cuando sea apropiado\n\n")

cat("🚀 Próximo nivel:\n")
cat("  Ahora que dominas AGs, es hora de aprender PSO!\n")
cat("  Los PSO son completamente diferentes pero igual de poderosos\n\n")

cat("➡️  Continúa con: modulo_4_pso_basico.R\n\n")
