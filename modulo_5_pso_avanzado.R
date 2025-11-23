# ============================================
# MÓDULO 5: PSO AVANZADO
# ============================================
# Curso: PSO y Algoritmos Genéticos en R
# Nivel: AVANZADO
# Duración estimada: 4-5 horas

# ============================================
# TABLA DE CONTENIDOS
# ============================================
# 1. Variantes de PSO
# 2. PSO con constricciones (CPSO)
# 3. PSO adaptativo (APSO)
# 4. Topologías de vecindario
# 5. PSO binario y discreto
# 6. Hibridación PSO + AG
# 7. PSO multiobjetivo
# 8. Aplicaciones especializadas

# Cargar paquetes
if (!require("pso")) install.packages("pso")
library(pso)

# ============================================
# SECCIÓN 1: VARIANTES DE PSO
# ============================================

cat("\n🔬 VARIANTES AVANZADAS DE PSO\n\n")

cat("PSO ha evolucionado con muchas variantes:\n")
cat("  • PSO con constricciones (CPSO)\n")
cat("  • PSO adaptativo (APSO)\n")
cat("  • PSO con factor de constricción\n")
cat("  • PSO binario (BPSO)\n")
cat("  • PSO multiobjetivo (MOPSO)\n")
cat("  • PSO cuántico (QPSO)\n\n")

# ============================================
# SECCIÓN 2: PSO CON FACTOR DE CONSTRICCIÓN
# ============================================

cat("\n⚡ PSO CON FACTOR DE CONSTRICCIÓN (Clerc)\n\n")

cat("PROBLEMA CON PSO ESTÁNDAR:\n")
cat("  Las partículas pueden diverger (velocidad infinita)\n\n")

cat("SOLUCIÓN: Factor de constricción χ (chi)\n")
cat("  v(t+1) = χ [v(t) + c1·r1·(pbest - x) + c2·r2·(gbest - x)]\n\n")

cat("FÓRMULA DE χ:\n")
cat("  φ = c1 + c2 (debe ser > 4)\n")
cat("  χ = 2 / |2 - φ - sqrt(φ² - 4φ)|\n\n")

cat("VALORES TÍPICOS:\n")
cat("  c1 = c2 = 2.05 → φ = 4.1 → χ ≈ 0.7298\n\n")

calcular_chi <- function(c1, c2) {
  phi <- c1 + c2
  if (phi <= 4) {
    warning("φ debe ser > 4")
    return(1.0)
  }
  chi <- 2 / abs(2 - phi - sqrt(phi^2 - 4*phi))
  return(chi)
}

chi <- calcular_chi(2.05, 2.05)
cat("Con c1=c2=2.05: χ =", round(chi, 4), "\n\n")

# Implementación
PSO_constriccion <- function(funcion_objetivo, dimension,
                             limites = c(-10, 10),
                             n_particulas = 30,
                             n_iteraciones = 100,
                             c1 = 2.05,
                             c2 = 2.05) {

  chi <- calcular_chi(c1, c2)

  posiciones <- matrix(runif(n_particulas * dimension, limites[1], limites[2]),
                      nrow = n_particulas, ncol = dimension)
  velocidades <- matrix(runif(n_particulas * dimension, -1, 1),
                       nrow = n_particulas, ncol = dimension)

  pbest <- posiciones
  pbest_fitness <- apply(posiciones, 1, funcion_objetivo)
  gbest <- posiciones[which.min(pbest_fitness), ]
  gbest_fitness <- min(pbest_fitness)

  historial <- numeric(n_iteraciones)

  for (iter in 1:n_iteraciones) {
    for (i in 1:n_particulas) {
      r1 <- runif(dimension)
      r2 <- runif(dimension)

      # VELOCIDAD CON CONSTRICCIÓN
      v_componente <- velocidades[i, ] +
        c1 * r1 * (pbest[i, ] - posiciones[i, ]) +
        c2 * r2 * (gbest - posiciones[i, ])

      velocidades[i, ] <- chi * v_componente

      posiciones[i, ] <- posiciones[i, ] + velocidades[i, ]
      posiciones[i, ] <- pmax(pmin(posiciones[i, ], limites[2]), limites[1])

      fitness <- funcion_objetivo(posiciones[i, ])
      if (fitness < pbest_fitness[i]) {
        pbest[i, ] <- posiciones[i, ]
        pbest_fitness[i] <- fitness
      }
      if (fitness < gbest_fitness) {
        gbest <- posiciones[i, ]
        gbest_fitness <- fitness
      }
    }
    historial[iter] <- gbest_fitness
  }

  return(list(mejor_posicion = gbest,
              mejor_fitness = gbest_fitness,
              historial = historial))
}

# Probar
esfera <- function(x) sum(x^2)

cat("Probando PSO con constricción...\n")
resultado_cpso <- PSO_constriccion(esfera, dimension = 5,
                                   n_iteraciones = 50)
cat("Mejor fitness:", resultado_cpso$mejor_fitness, "\n\n")

# ============================================
# SECCIÓN 3: PSO ADAPTATIVO
# ============================================

cat("\n🎯 PSO ADAPTATIVO (APSO)\n\n")

cat("IDEA: Ajustar parámetros automáticamente según el estado del enjambre\n\n")

cat("ESTADOS DEL ENJAMBRE:\n")
cat("  1. EXPLORACIÓN: Partículas dispersas, búsqueda global\n")
cat("  2. EXPLOTACIÓN: Partículas concentradas, refinamiento\n")
cat("  3. CONVERGENCIA: Partículas muy juntas\n")
cat("  4. SALTO: Re-explorar si está atascado\n\n")

# Medir diversidad del enjambre
calcular_diversidad <- function(posiciones) {
  n <- nrow(posiciones)
  centro <- colMeans(posiciones)
  distancias <- apply(posiciones, 1, function(x) sqrt(sum((x - centro)^2)))
  return(mean(distancias))
}

PSO_adaptativo <- function(funcion_objetivo, dimension,
                           limites = c(-10, 10),
                           n_particulas = 30,
                           n_iteraciones = 100) {

  posiciones <- matrix(runif(n_particulas * dimension, limites[1], limites[2]),
                      nrow = n_particulas, ncol = dimension)
  velocidades <- matrix(runif(n_particulas * dimension, -0.5, 0.5),
                       nrow = n_particulas, ncol = dimension)

  pbest <- posiciones
  pbest_fitness <- apply(posiciones, 1, funcion_objetivo)
  gbest <- posiciones[which.min(pbest_fitness), ]
  gbest_fitness <- min(pbest_fitness)

  historial <- numeric(n_iteraciones)
  historial_diversidad <- numeric(n_iteraciones)

  # Parámetros iniciales
  w <- 0.9
  c1 <- 2.0
  c2 <- 2.0

  for (iter in 1:n_iteraciones) {

    # CALCULAR ESTADO DEL ENJAMBRE
    diversidad <- calcular_diversidad(posiciones)
    historial_diversidad[iter] <- diversidad

    # ADAPTAR PARÁMETROS según diversidad
    if (diversidad > 0.5 * (limites[2] - limites[1])) {
      # Alta dispersión → EXPLORACIÓN
      w <- 0.9
      c1 <- 2.5  # Más cognitivo
      c2 <- 0.5  # Menos social
    } else if (diversidad > 0.1 * (limites[2] - limites[1])) {
      # Dispersión media → BALANCE
      w <- 0.7
      c1 <- 1.5
      c2 <- 1.5
    } else {
      # Baja dispersión → EXPLOTACIÓN
      w <- 0.4
      c1 <- 0.5  # Menos cognitivo
      c2 <- 2.5  # Más social
    }

    # Si está muy convergido sin buen resultado → SALTO
    if (diversidad < 0.01 * (limites[2] - limites[1]) &&
        gbest_fitness > 0.01) {
      # Reiniciar algunas partículas
      n_reiniciar <- round(n_particulas * 0.3)
      indices <- sample(1:n_particulas, n_reiniciar)
      for (idx in indices) {
        posiciones[idx, ] <- runif(dimension, limites[1], limites[2])
        velocidades[idx, ] <- runif(dimension, -0.5, 0.5)
      }
    }

    # ACTUALIZAR ENJAMBRE
    for (i in 1:n_particulas) {
      r1 <- runif(dimension)
      r2 <- runif(dimension)

      velocidades[i, ] <- w * velocidades[i, ] +
        c1 * r1 * (pbest[i, ] - posiciones[i, ]) +
        c2 * r2 * (gbest - posiciones[i, ])

      posiciones[i, ] <- posiciones[i, ] + velocidades[i, ]
      posiciones[i, ] <- pmax(pmin(posiciones[i, ], limites[2]), limites[1])

      fitness <- funcion_objetivo(posiciones[i, ])
      if (fitness < pbest_fitness[i]) {
        pbest[i, ] <- posiciones[i, ]
        pbest_fitness[i] <- fitness
      }
      if (fitness < gbest_fitness) {
        gbest <- posiciones[i, ]
        gbest_fitness <- fitness
      }
    }

    historial[iter] <- gbest_fitness
  }

  return(list(mejor_posicion = gbest,
              mejor_fitness = gbest_fitness,
              historial = historial,
              historial_diversidad = historial_diversidad))
}

cat("Probando PSO adaptativo...\n")
resultado_apso <- PSO_adaptativo(esfera, dimension = 5,
                                 n_iteraciones = 80)
cat("Mejor fitness:", resultado_apso$mejor_fitness, "\n\n")

# Visualizar adaptación
par(mfrow = c(1, 2))
plot(resultado_apso$historial, type = "l", lwd = 2, col = "blue",
     main = "Convergencia APSO", xlab = "Iteración", ylab = "Fitness")
grid()

plot(resultado_apso$historial_diversidad, type = "l", lwd = 2, col = "red",
     main = "Diversidad del Enjambre", xlab = "Iteración", ylab = "Diversidad")
grid()
par(mfrow = c(1, 1))

cat("\n💡 Observa cómo la diversidad disminuye conforme converge\n\n")

# ============================================
# SECCIÓN 4: TOPOLOGÍAS DE VECINDARIO
# ============================================

cat("\n🌐 TOPOLOGÍAS DE VECINDARIO\n\n")

cat("PSO ESTÁNDAR: gbest (estrella)\n")
cat("  Todas las partículas conocen el mejor global\n")
cat("  Convergencia rápida, puede quedar atrapado\n\n")

cat("PSO LBEST: Vecindario local (anillo)\n")
cat("  Cada partícula solo conoce a sus k vecinos\n")
cat("  Convergencia más lenta, mejor exploración\n\n")

# PSO con topología de anillo
PSO_lbest <- function(funcion_objetivo, dimension,
                      limites = c(-10, 10),
                      n_particulas = 30,
                      n_iteraciones = 100,
                      k_vecinos = 3) {

  posiciones <- matrix(runif(n_particulas * dimension, limites[1], limites[2]),
                      nrow = n_particulas, ncol = dimension)
  velocidades <- matrix(runif(n_particulas * dimension, -1, 1),
                       nrow = n_particulas, ncol = dimension)

  pbest <- posiciones
  pbest_fitness <- apply(posiciones, 1, funcion_objetivo)

  # lbest para cada partícula (mejor en su vecindario)
  lbest <- pbest
  lbest_fitness <- pbest_fitness

  historial_gbest <- numeric(n_iteraciones)

  for (iter in 1:n_iteraciones) {

    # Actualizar lbest de cada partícula
    for (i in 1:n_particulas) {
      # Vecinos en topología de anillo
      vecinos <- c()
      for (offset in -k_vecinos:k_vecinos) {
        vecino_idx <- ((i - 1 + offset) %% n_particulas) + 1
        vecinos <- c(vecinos, vecino_idx)
      }

      # Encontrar mejor en el vecindario
      mejor_vecino_idx <- vecinos[which.min(pbest_fitness[vecinos])]
      lbest[i, ] <- pbest[mejor_vecino_idx, ]
      lbest_fitness[i] <- pbest_fitness[mejor_vecino_idx]
    }

    # Actualizar partículas
    for (i in 1:n_particulas) {
      r1 <- runif(dimension)
      r2 <- runif(dimension)

      # Usar lbest en lugar de gbest
      velocidades[i, ] <- 0.7 * velocidades[i, ] +
        1.5 * r1 * (pbest[i, ] - posiciones[i, ]) +
        1.5 * r2 * (lbest[i, ] - posiciones[i, ])

      posiciones[i, ] <- posiciones[i, ] + velocidades[i, ]
      posiciones[i, ] <- pmax(pmin(posiciones[i, ], limites[2]), limites[1])

      fitness <- funcion_objetivo(posiciones[i, ])
      if (fitness < pbest_fitness[i]) {
        pbest[i, ] <- posiciones[i, ]
        pbest_fitness[i] <- fitness
      }
    }

    historial_gbest[iter] <- min(pbest_fitness)
  }

  gbest_idx <- which.min(pbest_fitness)
  return(list(mejor_posicion = pbest[gbest_idx, ],
              mejor_fitness = pbest_fitness[gbest_idx],
              historial = historial_gbest))
}

cat("Comparando topologías...\n")
resultado_lbest <- PSO_lbest(esfera, dimension = 5,
                             n_particulas = 30,
                             n_iteraciones = 80,
                             k_vecinos = 2)

cat("lbest fitness:", resultado_lbest$mejor_fitness, "\n")
cat("gbest fitness:", resultado_cpso$mejor_fitness, "\n\n")

# ============================================
# SECCIÓN 5: PSO BINARIO
# ============================================

cat("\n🔢 PSO BINARIO (BPSO)\n\n")

cat("Para problemas donde las variables son 0 o 1\n")
cat("Ejemplo: Problema de la mochila, selección de características\n\n")

cat("MODIFICACIÓN CLAVE:\n")
cat("  Velocidad → Probabilidad de cambiar a 1\n")
cat("  Sigmoide: P(x=1) = 1 / (1 + exp(-v))\n\n")

PSO_binario <- function(funcion_fitness, n_bits,
                        n_particulas = 30,
                        n_iteraciones = 100) {

  # Inicializar posiciones binarias
  posiciones <- matrix(sample(c(0, 1), n_particulas * n_bits, replace = TRUE),
                      nrow = n_particulas, ncol = n_bits)

  # Velocidades continuas
  velocidades <- matrix(runif(n_particulas * n_bits, -4, 4),
                       nrow = n_particulas, ncol = n_bits)

  pbest <- posiciones
  pbest_fitness <- apply(posiciones, 1, funcion_fitness)
  gbest <- posiciones[which.max(pbest_fitness), ]  # MAXIMIZAR
  gbest_fitness <- max(pbest_fitness)

  historial <- numeric(n_iteraciones)

  for (iter in 1:n_iteraciones) {
    for (i in 1:n_particulas) {
      r1 <- runif(n_bits)
      r2 <- runif(n_bits)

      # Actualizar velocidad (continua)
      velocidades[i, ] <- 0.7 * velocidades[i, ] +
        1.5 * r1 * (pbest[i, ] - posiciones[i, ]) +
        1.5 * r2 * (gbest - posiciones[i, ])

      # Limitar velocidad
      velocidades[i, ] <- pmax(pmin(velocidades[i, ], 4), -4)

      # Actualizar posición con sigmoide
      for (j in 1:n_bits) {
        prob <- 1 / (1 + exp(-velocidades[i, j]))
        posiciones[i, j] <- ifelse(runif(1) < prob, 1, 0)
      }

      # Evaluar
      fitness <- funcion_fitness(posiciones[i, ])
      if (fitness > pbest_fitness[i]) {
        pbest[i, ] <- posiciones[i, ]
        pbest_fitness[i] <- fitness
      }
      if (fitness > gbest_fitness) {
        gbest <- posiciones[i, ]
        gbest_fitness <- fitness
      }
    }

    historial[iter] <- gbest_fitness
  }

  return(list(mejor_solucion = gbest,
              mejor_fitness = gbest_fitness,
              historial = historial))
}

# Ejemplo: Problema de la mochila
objetos <- data.frame(
  peso = c(10, 20, 30, 40, 50),
  valor = c(60, 100, 120, 240, 310)
)
capacidad <- 100

fitness_mochila <- function(cromosoma) {
  peso_total <- sum(cromosoma * objetos$peso)
  valor_total <- sum(cromosoma * objetos$valor)
  if (peso_total > capacidad) return(0)
  return(valor_total)
}

cat("Resolviendo mochila con PSO binario...\n")
sol_mochila <- PSO_binario(fitness_mochila,
                           n_bits = nrow(objetos),
                           n_particulas = 30,
                           n_iteraciones = 50)

cat("Objetos seleccionados:", which(sol_mochila$mejor_solucion == 1), "\n")
cat("Valor total:", sol_mochila$mejor_fitness, "$\n\n")

# ============================================
# SECCIÓN 6: HIBRIDACIÓN PSO + AG
# ============================================

cat("\n🔄 HIBRIDACIÓN: PSO + ALGORITMO GENÉTICO\n\n")

cat("IDEA: Combinar las fortalezas de ambos\n")
cat("  PSO → Exploración rápida, convergencia\n")
cat("  AG  → Diversidad, escape de óptimos locales\n\n")

cat("ESTRATEGIAS DE HIBRIDACIÓN:\n")
cat("  1. PSO primero, luego AG para refinar\n")
cat("  2. AG primero, luego PSO para optimizar\n")
cat("  3. Alternar PSO y AG en cada generación\n")
cat("  4. PSO con operadores de mutación de AG\n\n")

# Implementación simple: PSO + Mutación
PSO_hibrido <- function(funcion_objetivo, dimension,
                        limites = c(-10, 10),
                        n_particulas = 30,
                        n_iteraciones = 100,
                        prob_mutacion = 0.1) {

  posiciones <- matrix(runif(n_particulas * dimension, limites[1], limites[2]),
                      nrow = n_particulas, ncol = dimension)
  velocidades <- matrix(runif(n_particulas * dimension, -1, 1),
                       nrow = n_particulas, ncol = dimension)

  pbest <- posiciones
  pbest_fitness <- apply(posiciones, 1, funcion_objetivo)
  gbest <- posiciones[which.min(pbest_fitness), ]
  gbest_fitness <- min(pbest_fitness)

  historial <- numeric(n_iteraciones)

  for (iter in 1:n_iteraciones) {

    # FASE PSO
    for (i in 1:n_particulas) {
      r1 <- runif(dimension)
      r2 <- runif(dimension)

      velocidades[i, ] <- 0.7 * velocidades[i, ] +
        1.5 * r1 * (pbest[i, ] - posiciones[i, ]) +
        1.5 * r2 * (gbest - posiciones[i, ])

      posiciones[i, ] <- posiciones[i, ] + velocidades[i, ]
      posiciones[i, ] <- pmax(pmin(posiciones[i, ], limites[2]), limites[1])

      fitness <- funcion_objetivo(posiciones[i, ])
      if (fitness < pbest_fitness[i]) {
        pbest[i, ] <- posiciones[i, ]
        pbest_fitness[i] <- fitness
      }
      if (fitness < gbest_fitness) {
        gbest <- posiciones[i, ]
        gbest_fitness <- fitness
      }
    }

    # FASE MUTACIÓN (estilo AG)
    for (i in 1:n_particulas) {
      for (j in 1:dimension) {
        if (runif(1) < prob_mutacion) {
          # Mutación gaussiana
          sigma <- (limites[2] - limites[1]) * 0.1
          posiciones[i, j] <- posiciones[i, j] + rnorm(1, 0, sigma)
          posiciones[i, j] <- max(limites[1], min(limites[2], posiciones[i, j]))

          # Re-evaluar
          fitness <- funcion_objetivo(posiciones[i, ])
          if (fitness < pbest_fitness[i]) {
            pbest[i, ] <- posiciones[i, ]
            pbest_fitness[i] <- fitness
          }
          if (fitness < gbest_fitness) {
            gbest <- posiciones[i, ]
            gbest_fitness <- fitness
          }
        }
      }
    }

    historial[iter] <- gbest_fitness
  }

  return(list(mejor_posicion = gbest,
              mejor_fitness = gbest_fitness,
              historial = historial))
}

cat("Probando PSO híbrido...\n")
rastrigin <- function(x) {
  n <- length(x)
  return(10*n + sum(x^2 - 10*cos(2*pi*x)))
}

sol_hibrida <- PSO_hibrido(rastrigin, dimension = 2,
                           limites = c(-5, 5),
                           n_iteraciones = 100,
                           prob_mutacion = 0.15)

cat("Mejor fitness (Rastrigin):", sol_hibrida$mejor_fitness, "\n")
cat("Óptimo es 0 en (0,0)\n\n")

# ============================================
# SECCIÓN 7: USO DEL PAQUETE PSO
# ============================================

cat("\n📦 USANDO EL PAQUETE 'pso' DE R\n\n")

cat("El paquete 'pso' implementa PSO profesional\n\n")

# Ejemplo con el paquete
cat("Optimizando Rosenbrock con paquete pso...\n")

rosenbrock <- function(x) {
  n <- length(x)
  suma <- 0
  for (i in 1:(n-1)) {
    suma <- suma + 100*(x[i+1] - x[i]^2)^2 + (1 - x[i])^2
  }
  return(suma)
}

resultado_pso_pkg <- psoptim(
  par = rep(0, 2),        # Punto inicial
  fn = rosenbrock,
  lower = c(-2, -2),
  upper = c(2, 2),
  control = list(
    maxit = 100,          # Iteraciones
    s = 30,               # Tamaño enjambre
    trace = 0,            # Sin output
    REPORT = 10
  )
)

cat("Mejor posición:", resultado_pso_pkg$par, "\n")
cat("Mejor fitness:", resultado_pso_pkg$value, "\n")
cat("Óptimo: (1,1), f(1,1) = 0\n\n")

# ============================================
# SECCIÓN 8: EJERCICIOS AVANZADOS
# ============================================

cat("\n✏️ EJERCICIOS AVANZADOS:\n\n")

cat("EJERCICIO 1 (MEDIO):\n")
cat("Implementa PSO con inercia linealmente decreciente:\n")
cat("  w(t) = w_max - (w_max - w_min) * t / T\n")
cat("  w_max = 0.9, w_min = 0.4\n")
cat("Compara con w constante en función Rastrigin\n\n")

cat("EJERCICIO 2 (MEDIO):\n")
cat("Usa PSO binario para selección de características:\n")
cat("  10 características disponibles\n")
cat("  Selecciona las mejores 5 para clasificación\n")
cat("  Fitness = precisión del modelo\n\n")

cat("EJERCICIO 3 (DIFÍCIL):\n")
cat("Implementa PSO con topología de estrella dinámica:\n")
cat("  Las partículas cambian sus conexiones cada N iteraciones\n")
cat("  Conexiones basadas en distancia euclidiana\n\n")

cat("EJERCICIO 4 (DIFÍCIL):\n")
cat("PSO multiobjetivo simple:\n")
cat("  Optimiza f1(x) = x^2 y f2(x) = (x-2)^2 simultáneamente\n")
cat("  Mantén un archivo de soluciones no-dominadas\n")
cat("  Visualiza el frente de Pareto\n\n")

cat("EJERCICIO 5 (MUY DIFÍCIL):\n")
cat("Implementa PSO cuántico (QPSO):\n")
cat("  No usa velocidad, usa función de onda cuántica\n")
cat("  x(t+1) = p ± β|mbest - x(t)| * ln(1/u)\n")
cat("  donde p es punto de atracción y u es aleatorio [0,1]\n\n")

# ============================================
# RESUMEN
# ============================================

cat("\n", rep("🎓", 30), "\n")
cat("RESUMEN MÓDULO 5: PSO AVANZADO\n")
cat(rep("🎓", 30), "\n\n")

cat("✅ Has dominado:\n")
cat("  1. PSO con factor de constricción\n")
cat("  2. PSO adaptativo (APSO)\n")
cat("  3. Topologías de vecindario (lbest)\n")
cat("  4. PSO binario para problemas discretos\n")
cat("  5. Hibridación PSO + AG\n")
cat("  6. Uso del paquete 'pso' profesional\n\n")

cat("💡 Conceptos clave:\n")
cat("  • Muchas variantes de PSO para diferentes problemas\n")
cat("  • Adaptación automática mejora robustez\n")
cat("  • Topología afecta exploración/explotación\n")
cat("  • PSO binario para optimización combinatoria\n")
cat("  • Hibridación combina lo mejor de ambos mundos\n\n")

cat("🚀 Siguiente paso:\n")
cat("  Aplicar PSO y AG a problemas del mundo real\n\n")

cat("➡️  Continúa con: modulo_6_casos_practicos.R\n\n")
