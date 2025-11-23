# ============================================
# MÓDULO 4: PSO - PARTICLE SWARM OPTIMIZATION (BÁSICO)
# ============================================
# Curso: PSO y Algoritmos Genéticos en R
# Nivel: INTERMEDIO
# Duración estimada: 3-4 horas

# ============================================
# TABLA DE CONTENIDOS
# ============================================
# 1. Introducción: Inspiración en enjambres
# 2. Conceptos fundamentales de PSO
# 3. Componentes matemáticos
# 4. Implementación desde cero
# 5. Parámetros y su efecto
# 6. Visualización del enjambre
# 7. Comparación PSO vs AG
# 8. Ejercicios prácticos

# ============================================
# SECCIÓN 1: INSPIRACIÓN EN ENJAMBRES
# ============================================

cat("\n🐦 PSO: OPTIMIZACIÓN POR ENJAMBRE DE PARTÍCULAS\n\n")

cat("INSPIRACIÓN NATURAL:\n")
cat("  🐦 Bandada de pájaros buscando comida\n")
cat("  🐟 Cardumen de peces moviéndose juntos\n")
cat("  🐝 Enjambre de abejas explorando\n\n")

cat("COMPORTAMIENTO OBSERVADO:\n")
cat("  1. Cada individuo tiene su propia experiencia\n")
cat("  2. Aprenden de los vecinos (inteligencia social)\n")
cat("  3. Se mueven hacia las mejores zonas encontradas\n")
cat("  4. Balance entre exploración individual y seguir al grupo\n\n")

cat("DIFERENCIA CLAVE CON ALGORITMOS GENÉTICOS:\n")
cat("  AG  → Evolución, reproducción, generaciones\n")
cat("  PSO → Movimiento, velocidad, memoria\n\n")

# ============================================
# SECCIÓN 2: CONCEPTOS FUNDAMENTALES
# ============================================

cat("📖 CONCEPTOS FUNDAMENTALES DE PSO:\n\n")

cat("1. PARTÍCULA:\n")
cat("   - Solución candidata que 'vuela' por el espacio de búsqueda\n")
cat("   - Tiene POSICIÓN (x) y VELOCIDAD (v)\n\n")

cat("2. POSICIÓN:\n")
cat("   - Representa una solución al problema\n")
cat("   - Ejemplo: [2.5, 3.1] para problema 2D\n\n")

cat("3. VELOCIDAD:\n")
cat("   - Qué tan rápido y en qué dirección se mueve\n")
cat("   - Ejemplo: [0.5, -0.2] (moverse +0.5 en x, -0.2 en y)\n\n")

cat("4. MEJOR PERSONAL (pbest):\n")
cat("   - Mejor posición que HA ENCONTRADO esta partícula\n")
cat("   - Memoria individual\n\n")

cat("5. MEJOR GLOBAL (gbest):\n")
cat("   - Mejor posición encontrada por TODO el enjambre\n")
cat("   - Conocimiento compartido\n\n")

# Ejemplo conceptual
cat("EJEMPLO SIMPLE:\n")
particula <- list(
  posicion = c(2.5, 3.0),
  velocidad = c(0.3, -0.1),
  mejor_personal = c(2.0, 2.8),
  fitness_personal = 5.2
)

mejor_global <- c(1.5, 2.5)
fitness_global <- 6.8

cat("Partícula:\n")
cat("  Posición actual:", particula$posicion, "\n")
cat("  Velocidad:", particula$velocidad, "\n")
cat("  Mejor personal:", particula$mejor_personal, "(fitness =", particula$fitness_personal, ")\n")
cat("\nEnjambre:\n")
cat("  Mejor global:", mejor_global, "(fitness =", fitness_global, ")\n\n")

# ============================================
# SECCIÓN 3: MATEMÁTICA DE PSO
# ============================================

cat("\n🧮 FÓRMULAS MATEMÁTICAS DE PSO:\n\n")

cat("ACTUALIZACIÓN DE VELOCIDAD:\n")
cat("v(t+1) = w·v(t) + c1·r1·(pbest - x(t)) + c2·r2·(gbest - x(t))\n\n")

cat("Donde:\n")
cat("  w  = coeficiente de inercia (momento)\n")
cat("  c1 = coeficiente cognitivo (confianza en sí mismo)\n")
cat("  c2 = coeficiente social (confianza en el grupo)\n")
cat("  r1, r2 = números aleatorios [0,1]\n")
cat("  pbest = mejor posición personal\n")
cat("  gbest = mejor posición global\n")
cat("  x(t) = posición actual\n\n")

cat("TRES COMPONENTES DE LA VELOCIDAD:\n\n")

cat("1. INERCIA: w·v(t)\n")
cat("   - Mantiene la dirección actual\n")
cat("   - w alto → más exploración\n")
cat("   - w bajo → más explotación\n\n")

cat("2. COGNITIVO: c1·r1·(pbest - x(t))\n")
cat("   - Atracción hacia su mejor personal\n")
cat("   - 'Memoria individual'\n\n")

cat("3. SOCIAL: c2·r2·(gbest - x(t))\n")
cat("   - Atracción hacia el mejor global\n")
cat("   - 'Aprendizaje del grupo'\n\n")

cat("ACTUALIZACIÓN DE POSICIÓN:\n")
cat("x(t+1) = x(t) + v(t+1)\n\n")

# Demostración numérica
cat("DEMOSTRACIÓN NUMÉRICA:\n\n")

# Parámetros típicos
w <- 0.7
c1 <- 1.5
c2 <- 1.5

# Estado actual
x_actual <- 3.0
v_actual <- 0.5
pbest <- 2.0
gbest <- 1.0

# Números aleatorios
set.seed(42)
r1 <- runif(1)
r2 <- runif(1)

cat("Estado actual:\n")
cat("  x =", x_actual, ", v =", v_actual, "\n")
cat("  pbest =", pbest, ", gbest =", gbest, "\n")
cat("  r1 =", round(r1, 3), ", r2 =", round(r2, 3), "\n\n")

# Calcular componentes
inercia <- w * v_actual
cognitivo <- c1 * r1 * (pbest - x_actual)
social <- c2 * r2 * (gbest - x_actual)

cat("Componentes de la nueva velocidad:\n")
cat("  Inercia:   ", round(inercia, 3), "\n")
cat("  Cognitivo: ", round(cognitivo, 3), "\n")
cat("  Social:    ", round(social, 3), "\n")

# Nueva velocidad
v_nueva <- inercia + cognitivo + social
x_nueva <- x_actual + v_nueva

cat("\nNuevo estado:\n")
cat("  v_nueva =", round(v_nueva, 3), "\n")
cat("  x_nueva =", round(x_nueva, 3), "\n\n")

# ============================================
# SECCIÓN 4: IMPLEMENTACIÓN DESDE CERO
# ============================================

cat("\n🚀 IMPLEMENTACIÓN COMPLETA DE PSO DESDE CERO\n\n")

PSO <- function(funcion_objetivo,
                dimension,
                limites = c(-10, 10),
                n_particulas = 30,
                n_iteraciones = 100,
                w = 0.7,
                c1 = 1.5,
                c2 = 1.5,
                v_max = NULL,
                minimizar = TRUE,
                verbose = TRUE) {

  # =========================================
  # PARÁMETROS:
  # =========================================
  # funcion_objetivo: función a optimizar
  # dimension: número de variables
  # limites: c(min, max) para cada variable
  # n_particulas: tamaño del enjambre
  # n_iteraciones: número de iteraciones
  # w: coeficiente de inercia
  # c1: coeficiente cognitivo
  # c2: coeficiente social
  # v_max: velocidad máxima permitida
  # minimizar: TRUE para minimizar, FALSE para maximizar

  # =========================================
  # INICIALIZACIÓN
  # =========================================

  # Velocidad máxima (si no se especifica)
  if (is.null(v_max)) {
    rango <- limites[2] - limites[1]
    v_max <- rango * 0.2  # 20% del rango
  }

  # Inicializar posiciones aleatorias
  posiciones <- matrix(
    runif(n_particulas * dimension, limites[1], limites[2]),
    nrow = n_particulas,
    ncol = dimension
  )

  # Inicializar velocidades aleatorias pequeñas
  velocidades <- matrix(
    runif(n_particulas * dimension, -v_max, v_max),
    nrow = n_particulas,
    ncol = dimension
  )

  # Mejor personal = posición inicial
  pbest <- posiciones
  pbest_fitness <- apply(posiciones, 1, funcion_objetivo)

  # Mejor global
  if (minimizar) {
    mejor_idx <- which.min(pbest_fitness)
  } else {
    mejor_idx <- which.max(pbest_fitness)
  }
  gbest <- posiciones[mejor_idx, ]
  gbest_fitness <- pbest_fitness[mejor_idx]

  # Historial
  historial_gbest <- numeric(n_iteraciones)

  # =========================================
  # ITERACIONES
  # =========================================

  for (iter in 1:n_iteraciones) {

    # Para cada partícula
    for (i in 1:n_particulas) {

      # Números aleatorios
      r1 <- runif(dimension)
      r2 <- runif(dimension)

      # ACTUALIZAR VELOCIDAD
      velocidades[i, ] <- w * velocidades[i, ] +
        c1 * r1 * (pbest[i, ] - posiciones[i, ]) +
        c2 * r2 * (gbest - posiciones[i, ])

      # Limitar velocidad
      velocidades[i, ] <- pmax(pmin(velocidades[i, ], v_max), -v_max)

      # ACTUALIZAR POSICIÓN
      posiciones[i, ] <- posiciones[i, ] + velocidades[i, ]

      # Mantener dentro de límites
      posiciones[i, ] <- pmax(pmin(posiciones[i, ], limites[2]), limites[1])

      # EVALUAR FITNESS
      fitness <- funcion_objetivo(posiciones[i, ])

      # ACTUALIZAR MEJOR PERSONAL
      if (minimizar) {
        if (fitness < pbest_fitness[i]) {
          pbest[i, ] <- posiciones[i, ]
          pbest_fitness[i] <- fitness
        }
      } else {
        if (fitness > pbest_fitness[i]) {
          pbest[i, ] <- posiciones[i, ]
          pbest_fitness[i] <- fitness
        }
      }

      # ACTUALIZAR MEJOR GLOBAL
      if (minimizar) {
        if (fitness < gbest_fitness) {
          gbest <- posiciones[i, ]
          gbest_fitness <- fitness
        }
      } else {
        if (fitness > gbest_fitness) {
          gbest <- posiciones[i, ]
          gbest_fitness <- fitness
        }
      }
    }

    # Guardar historial
    historial_gbest[iter] <- gbest_fitness

    # Mostrar progreso
    if (verbose && iter %% 10 == 0) {
      cat(sprintf("Iteración %d: gbest = %.6f\n", iter, gbest_fitness))
    }
  }

  # =========================================
  # RETORNAR RESULTADOS
  # =========================================

  return(list(
    mejor_posicion = gbest,
    mejor_fitness = gbest_fitness,
    historial = historial_gbest,
    posiciones_finales = posiciones,
    velocidades_finales = velocidades
  ))
}

cat("✅ PSO implementado desde cero!\n\n")

# ============================================
# SECCIÓN 5: EJEMPLOS PRÁCTICOS
# ============================================

cat("\n📊 EJEMPLO 1: Función esférica (simple)\n\n")

esfera <- function(x) {
  return(sum(x^2))
}

cat("Minimizar f(x,y) = x^2 + y^2\n")
cat("Óptimo: (0, 0), f(0,0) = 0\n\n")

resultado_pso1 <- PSO(
  funcion_objetivo = esfera,
  dimension = 2,
  limites = c(-10, 10),
  n_particulas = 30,
  n_iteraciones = 50,
  verbose = FALSE
)

cat("✅ RESULTADOS:\n")
cat("Mejor posición:", resultado_pso1$mejor_posicion, "\n")
cat("Mejor fitness:", resultado_pso1$mejor_fitness, "\n\n")

# Visualizar convergencia
plot(1:length(resultado_pso1$historial),
     resultado_pso1$historial,
     type = "l", col = "blue", lwd = 2,
     main = "Convergencia PSO - Función Esférica",
     xlab = "Iteración",
     ylab = "Mejor fitness",
     log = "y")  # Escala logarítmica
abline(h = 0, col = "red", lty = 2)
grid()

cat("\n📊 EJEMPLO 2: Función de Rosenbrock (difícil)\n\n")

rosenbrock <- function(x) {
  n <- length(x)
  suma <- 0
  for (i in 1:(n-1)) {
    suma <- suma + 100*(x[i+1] - x[i]^2)^2 + (1 - x[i])^2
  }
  return(suma)
}

cat("Minimizar Rosenbrock en 2D\n")
cat("Óptimo: (1, 1), f(1,1) = 0\n\n")

resultado_pso2 <- PSO(
  funcion_objetivo = rosenbrock,
  dimension = 2,
  limites = c(-2, 2),
  n_particulas = 50,
  n_iteraciones = 100,
  w = 0.6,      # Menor inercia para función difícil
  c1 = 2.0,     # Más cognitivo
  c2 = 2.0,     # Más social
  verbose = FALSE
)

cat("✅ RESULTADOS:\n")
cat("Mejor posición:", resultado_pso2$mejor_posicion, "\n")
cat("Mejor fitness:", resultado_pso2$mejor_fitness, "\n\n")

# ============================================
# SECCIÓN 6: EFECTO DE LOS PARÁMETROS
# ============================================

cat("\n⚙️ EFECTO DE LOS PARÁMETROS DE PSO\n\n")

# 6.1 EFECTO DE LA INERCIA (w)
cat("6.1 EFECTO DE LA INERCIA (w):\n\n")

valores_w <- c(0.3, 0.5, 0.7, 0.9)
resultados_w <- list()

cat("Probando diferentes valores de w...\n")
for (w_val in valores_w) {
  resultado <- PSO(
    funcion_objetivo = esfera,
    dimension = 2,
    limites = c(-10, 10),
    n_particulas = 20,
    n_iteraciones = 50,
    w = w_val,
    c1 = 1.5,
    c2 = 1.5,
    verbose = FALSE
  )
  resultados_w[[as.character(w_val)]] <- resultado
  cat(sprintf("w = %.1f: fitness final = %.6f\n", w_val, resultado$mejor_fitness))
}

# Visualizar
plot(1:50, resultados_w[["0.3"]]$historial,
     type = "l", col = "red", lwd = 2,
     main = "Efecto de la Inercia (w)",
     xlab = "Iteración", ylab = "Mejor fitness",
     ylim = c(0, max(sapply(resultados_w, function(r) max(r$historial)))))

for (i in 2:length(valores_w)) {
  lines(1:50, resultados_w[[i]]$historial,
        col = rainbow(length(valores_w))[i], lwd = 2)
}

legend("topright",
       paste("w =", valores_w),
       col = rainbow(length(valores_w)),
       lwd = 2)
grid()

cat("\n💡 OBSERVACIÓN:\n")
cat("  w bajo (0.3) → Convergencia rápida, puede quedar atrapado\n")
cat("  w alto (0.9) → Más exploración, convergencia más lenta\n")
cat("  w medio (0.6-0.7) → Balance óptimo para la mayoría de problemas\n\n")

# 6.2 EFECTO DEL TAMAÑO DEL ENJAMBRE
cat("6.2 EFECTO DEL TAMAÑO DEL ENJAMBRE:\n\n")

tamanios <- c(10, 30, 50, 100)
resultados_tam <- list()

cat("Probando diferentes tamaños de enjambre...\n")
for (tam in tamanios) {
  resultado <- PSO(
    funcion_objetivo = rosenbrock,
    dimension = 2,
    limites = c(-2, 2),
    n_particulas = tam,
    n_iteraciones = 50,
    verbose = FALSE
  )
  resultados_tam[[as.character(tam)]] <- resultado
  cat(sprintf("n = %3d: fitness final = %.6f\n", tam, resultado$mejor_fitness))
}

cat("\n💡 OBSERVACIÓN:\n")
cat("  Más partículas → mejor exploración del espacio\n")
cat("  Pero también más cálculos por iteración\n")
cat("  Balance típico: 20-50 partículas\n\n")

# ============================================
# SECCIÓN 7: VISUALIZACIÓN DEL ENJAMBRE
# ============================================

cat("\n🎨 VISUALIZACIÓN DEL MOVIMIENTO DEL ENJAMBRE\n\n")

# Función para visualizar PSO en 2D
visualizar_PSO <- function(funcion_objetivo, titulo = "PSO") {

  # Crear malla para el contorno
  x_vals <- seq(-5, 5, length.out = 100)
  y_vals <- seq(-5, 5, length.out = 100)
  z_vals <- outer(x_vals, y_vals, function(x, y) {
    sapply(1:length(x), function(i) funcion_objetivo(c(x[i], y[i])))
  })

  # Configurar gráfico
  par(mfrow = c(2, 2))

  # Ejecutar PSO paso a paso
  dimension <- 2
  n_particulas <- 20
  limites <- c(-5, 5)
  w <- 0.7
  c1 <- 1.5
  c2 <- 1.5

  # Inicializar
  posiciones <- matrix(runif(n_particulas * dimension, limites[1], limites[2]),
                      nrow = n_particulas, ncol = dimension)
  velocidades <- matrix(runif(n_particulas * dimension, -1, 1),
                       nrow = n_particulas, ncol = dimension)

  pbest <- posiciones
  pbest_fitness <- apply(posiciones, 1, funcion_objetivo)
  gbest_idx <- which.min(pbest_fitness)
  gbest <- posiciones[gbest_idx, ]

  # Visualizar en iteraciones específicas
  for (iter in c(1, 5, 20, 50)) {

    # Evolucionar hasta la iteración
    for (i in 1:iter) {
      for (j in 1:n_particulas) {
        r1 <- runif(dimension)
        r2 <- runif(dimension)

        velocidades[j, ] <- w * velocidades[j, ] +
          c1 * r1 * (pbest[j, ] - posiciones[j, ]) +
          c2 * r2 * (gbest - posiciones[j, ])

        posiciones[j, ] <- posiciones[j, ] + velocidades[j, ]
        posiciones[j, ] <- pmax(pmin(posiciones[j, ], limites[2]), limites[1])

        fitness <- funcion_objetivo(posiciones[j, ])
        if (fitness < pbest_fitness[j]) {
          pbest[j, ] <- posiciones[j, ]
          pbest_fitness[j] <- fitness
        }
        if (fitness < funcion_objetivo(gbest)) {
          gbest <- posiciones[j, ]
        }
      }
    }

    # Graficar
    contour(x_vals, y_vals, z_vals,
            nlevels = 20,
            main = paste(titulo, "- Iteración", iter),
            xlab = "x", ylab = "y")

    # Dibujar partículas
    points(posiciones[, 1], posiciones[, 2],
           col = "blue", pch = 19, cex = 1.2)

    # Dibujar mejor global
    points(gbest[1], gbest[2],
           col = "red", pch = 19, cex = 2)

    # Flechas de velocidad
    arrows(posiciones[, 1], posiciones[, 2],
           posiciones[, 1] + velocidades[, 1] * 0.5,
           posiciones[, 2] + velocidades[, 2] * 0.5,
           length = 0.05, col = "blue", lwd = 0.5)
  }

  par(mfrow = c(1, 1))
}

cat("Descomenta la siguiente línea para ver la visualización:\n")
cat("# visualizar_PSO(esfera, 'Función Esférica')\n\n")

# visualizar_PSO(esfera, "Función Esférica")

# ============================================
# SECCIÓN 8: COMPARACIÓN PSO vs AG
# ============================================

cat("\n⚔️ COMPARACIÓN: PSO vs ALGORITMOS GENÉTICOS\n\n")

cat("VENTAJAS DE PSO:\n")
cat("  ✅ Más simple de implementar\n")
cat("  ✅ Menos parámetros que ajustar\n")
cat("  ✅ Convergencia rápida en problemas continuos\n")
cat("  ✅ Bueno para espacios de alta dimensión\n")
cat("  ✅ No requiere operadores especializados\n\n")

cat("VENTAJAS DE AG:\n")
cat("  ✅ Más flexible para problemas discretos\n")
cat("  ✅ Mejor exploración global (menos convergencia prematura)\n")
cat("  ✅ Fácil de paralelizar (generaciones)\n")
cat("  ✅ Funciona bien con funciones ruidosas\n")
cat("  ✅ Multiobjetivo más natural (NSGA-II)\n\n")

cat("CUÁNDO USAR PSO:\n")
cat("  • Problemas de optimización continua\n")
cat("  • Espacios de búsqueda suaves\n")
cat("  • Necesitas convergencia rápida\n")
cat("  • Funciones diferenciables\n\n")

cat("CUÁNDO USAR AG:\n")
cat("  • Problemas combinatorios o discretos\n")
cat("  • Optimización multiobjetivo\n")
cat("  • Espacios de búsqueda complejos/discontinuos\n")
cat("  • Necesitas diversidad poblacional\n\n")

# Comparación empírica
cat("COMPARACIÓN EMPÍRICA EN FUNCIÓN ESFÉRICA:\n\n")

# Ya tenemos resultado PSO
cat("PSO:\n")
cat("  Fitness final:", resultado_pso1$mejor_fitness, "\n")

# Cargar AG del módulo anterior (simulado)
AG_simple <- function(fitness_fn, dim, limites, n_iter) {
  # Implementación simplificada para comparación
  mejor <- Inf
  for (i in 1:n_iter) {
    x <- runif(dim, limites[1], limites[2])
    val <- fitness_fn(x)
    if (val < mejor) mejor <- val
  }
  return(mejor)
}

resultado_ag <- AG_simple(esfera, 2, c(-10, 10), 50 * 30)  # 50 iter × 30 evals

cat("AG (simplificado):\n")
cat("  Fitness final:", resultado_ag, "\n\n")

cat("💡 En problemas continuos, PSO suele converger más rápido!\n\n")

# ============================================
# SECCIÓN 9: EJERCICIOS PRÁCTICOS
# ============================================

cat("\n✏️ EJERCICIOS PARA PRACTICAR:\n\n")

cat("EJERCICIO 1 (FÁCIL):\n")
cat("Optimiza f(x) = x^2 - 4x + 4 con PSO\n")
cat("Encuentra el mínimo (debe ser x=2, f(2)=0)\n\n")

cat("EJERCICIO 2 (FÁCIL):\n")
cat("Experimenta con diferentes valores de c1 y c2:\n")
cat("  - c1 alto, c2 bajo (más cognitivo)\n")
cat("  - c1 bajo, c2 alto (más social)\n")
cat("  - c1 = c2 (balanceado)\n")
cat("¿Cuál funciona mejor para la función esférica?\n\n")

cat("EJERCICIO 3 (MEDIO):\n")
cat("Implementa PSO con inercia decreciente:\n")
cat("  w empieza en 0.9 y termina en 0.4\n")
cat("  w(t) = w_max - (w_max - w_min) * t / T\n")
cat("Compara con w constante\n\n")

cat("EJERCICIO 4 (MEDIO):\n")
cat("Aplica PSO a la función de Rastrigin:\n")
cat("  f(x,y) = 20 + x^2 + y^2 - 10*(cos(2πx) + cos(2πy))\n")
cat("Esta función tiene muchos óptimos locales. ¿PSO los evita?\n\n")

cat("EJERCICIO 5 (DIFÍCIL):\n")
cat("Implementa PSO con topología de vecindario:\n")
cat("  - En lugar de gbest global, cada partícula solo conoce\n")
cat("    el mejor de sus 3 vecinos cercanos\n")
cat("  - Esto se llama 'lbest' (local best)\n")
cat("  - Compara resultados con gbest\n\n")

cat("EJERCICIO 6 (DIFÍCIL):\n")
cat("Visualiza la trayectoria de UNA partícula a lo largo del tiempo\n")
cat("  - Guarda su posición en cada iteración\n")
cat("  - Grafica su camino sobre el contorno de la función\n")
cat("  - ¿Qué patrón observas?\n\n")

cat("EJERCICIO 7 (MUY DIFÍCIL):\n")
cat("Implementa PSO Binario para el problema de la mochila:\n")
cat("  - Posiciones son 0 o 1 (llevar objeto o no)\n")
cat("  - Velocidad se interpreta como probabilidad\n")
cat("  - Usa función sigmoide: P(x=1) = 1/(1+exp(-v))\n\n")

# ============================================
# SOLUCIONES
# ============================================

cat("\n", rep("=", 60), "\n")
cat("SOLUCIONES\n")
cat(rep("=", 60), "\n\n")

# SOLUCIÓN EJERCICIO 1
cat("SOLUCIÓN EJERCICIO 1:\n")
f_ej1 <- function(x) x[1]^2 - 4*x[1] + 4

sol_ej1 <- PSO(f_ej1, dimension = 1, limites = c(-10, 10),
               n_particulas = 20, n_iteraciones = 30, verbose = FALSE)
cat("Mínimo encontrado: x =", sol_ej1$mejor_posicion, "\n")
cat("f(x) =", sol_ej1$mejor_fitness, "\n")
cat("Respuesta exacta: x = 2, f(2) = 0\n\n")

# SOLUCIÓN EJERCICIO 3
cat("SOLUCIÓN EJERCICIO 3:\n\n")

PSO_inercia_adaptativa <- function(funcion_objetivo, dimension,
                                   limites = c(-10, 10),
                                   n_particulas = 30,
                                   n_iteraciones = 100,
                                   w_max = 0.9,
                                   w_min = 0.4) {

  # Similar a PSO pero con w variable
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
    # INERCIA ADAPTATIVA
    w <- w_max - (w_max - w_min) * iter / n_iteraciones

    for (i in 1:n_particulas) {
      r1 <- runif(dimension)
      r2 <- runif(dimension)

      velocidades[i, ] <- w * velocidades[i, ] +
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

    historial[iter] <- gbest_fitness
  }

  return(list(mejor_posicion = gbest,
              mejor_fitness = gbest_fitness,
              historial = historial))
}

sol_ej3 <- PSO_inercia_adaptativa(esfera, dimension = 2,
                                   n_iteraciones = 50)
cat("Con inercia adaptativa:\n")
cat("Mejor fitness:", sol_ej3$mejor_fitness, "\n\n")

# ============================================
# RESUMEN
# ============================================

cat("\n", rep("🎓", 30), "\n")
cat("RESUMEN MÓDULO 4: PSO BÁSICO\n")
cat(rep("🎓", 30), "\n\n")

cat("✅ Has dominado:\n")
cat("  1. Inspiración y fundamentos de PSO\n")
cat("  2. Componentes: posición, velocidad, pbest, gbest\n")
cat("  3. Matemática de actualización de velocidad\n")
cat("  4. Implementación completa desde cero\n")
cat("  5. Efecto de parámetros (w, c1, c2, tamaño)\n")
cat("  6. Visualización del enjambre\n")
cat("  7. Comparación PSO vs AG\n\n")

cat("💡 Conceptos clave:\n")
cat("  • PSO = memoria individual + aprendizaje social\n")
cat("  • Inercia (w) controla exploración/explotación\n")
cat("  • Balance cognitivo (c1) y social (c2)\n")
cat("  • Excelente para optimización continua\n")
cat("  • Simple pero muy efectivo\n\n")

cat("🚀 Próximo nivel:\n")
cat("  PSO avanzado: variantes, adaptación, aplicaciones especiales\n\n")

cat("➡️  Continúa con: modulo_5_pso_avanzado.R\n\n")
