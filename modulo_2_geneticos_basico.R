# ============================================
# MÓDULO 2: ALGORITMOS GENÉTICOS - BÁSICO
# ============================================
# Curso: PSO y Algoritmos Genéticos en R
# Nivel: PRINCIPIANTE
# Duración estimada: 3-4 horas

# ============================================
# TABLA DE CONTENIDOS
# ============================================
# 1. Introducción: Inspiración biológica
# 2. Componentes de un AG
# 3. Representación: Cromosomas y genes
# 4. Operadores genéticos
# 5. Implementación paso a paso
# 6. Tu primer AG completo
# 7. Visualización del proceso evolutivo
# 8. Ejercicios prácticos

# ============================================
# SECCIÓN 1: INSPIRACIÓN BIOLÓGICA
# ============================================

cat("\n🧬 ALGORITMOS GENÉTICOS: Imitando la Evolución Natural\n\n")

cat("LA EVOLUCIÓN EN LA NATURALEZA:\n")
cat("  🐘 Poblaciones de individuos (animales, plantas)\n")
cat("  🧬 Cada individuo tiene genes (ADN)\n")
cat("  🏆 Los más aptos sobreviven (selección natural)\n")
cat("  👶 Se reproducen y crean descendencia\n")
cat("  🎲 Mutaciones aleatorias crean variedad\n")
cat("  ⏰ Generación tras generación, mejora la especie\n\n")

cat("TRADUCCIÓN A ALGORITMOS:\n")
cat("  Individuos → Soluciones candidatas\n")
cat("  Genes → Variables del problema\n")
cat("  Aptitud (fitness) → Qué tan buena es la solución\n")
cat("  Selección → Elegir las mejores soluciones\n")
cat("  Cruce → Combinar soluciones para crear nuevas\n")
cat("  Mutación → Cambios aleatorios para explorar\n")
cat("  Generaciones → Iteraciones del algoritmo\n\n")

# ============================================
# SECCIÓN 2: COMPONENTES DE UN AG
# ============================================

cat("📦 COMPONENTES PRINCIPALES:\n\n")

# 2.1 POBLACIÓN
cat("1. POBLACIÓN:\n")
cat("   Conjunto de soluciones candidatas\n")
cat("   Ejemplo: 50 individuos (soluciones)\n\n")

# Ejemplo de población simple para función f(x) = x^2
# Representamos cada individuo como un número
poblacion_ejemplo <- c(2.5, 1.8, 3.2, 0.5, 4.1)
cat("   Población ejemplo:", poblacion_ejemplo, "\n\n")

# 2.2 FITNESS (APTITUD)
cat("2. FITNESS (APTITUD):\n")
cat("   Mide qué tan buena es una solución\n")
cat("   Mayor fitness = Mejor solución\n\n")

# Función de fitness: queremos minimizar x^2, así que fitness = 1/(1+x^2)
fitness_ejemplo <- function(x) {
  return(1 / (1 + x^2))
}

aptitudes <- sapply(poblacion_ejemplo, fitness_ejemplo)
cat("   Fitness de cada individuo:", round(aptitudes, 3), "\n")
cat("   Mejor individuo:", poblacion_ejemplo[which.max(aptitudes)], "\n\n")

# 2.3 SELECCIÓN
cat("3. SELECCIÓN:\n")
cat("   Elegir individuos para reproducción\n")
cat("   Los más aptos tienen mayor probabilidad\n\n")

# 2.4 CRUCE (CROSSOVER)
cat("4. CRUCE (CROSSOVER):\n")
cat("   Combinar dos padres para crear hijos\n")
cat("   Ejemplo: Padre1=[1,2,3], Padre2=[4,5,6]\n")
cat("            Hijo=[1,2,6] (toma genes de ambos)\n\n")

# 2.5 MUTACIÓN
cat("5. MUTACIÓN:\n")
cat("   Cambio aleatorio en un gen\n")
cat("   Mantiene diversidad en la población\n\n")

# ============================================
# SECCIÓN 3: REPRESENTACIÓN
# ============================================

cat("\n🧬 REPRESENTACIÓN: CROMOSOMAS Y GENES\n\n")

# 3.1 REPRESENTACIÓN BINARIA
cat("REPRESENTACIÓN BINARIA:\n")
cat("Cada variable se codifica como una cadena de 0s y 1s\n\n")

# Ejemplo: Codificar x en [0, 15] con 4 bits
binario_a_decimal <- function(cromosoma) {
  # cromosoma es un vector de 0s y 1s
  decimal <- sum(cromosoma * 2^((length(cromosoma)-1):0))
  return(decimal)
}

decimal_a_binario <- function(numero, n_bits = 4) {
  binario <- integer(n_bits)
  for (i in n_bits:1) {
    binario[i] <- numero %% 2
    numero <- numero %/% 2
  }
  return(rev(binario))
}

# Ejemplos
cromosoma1 <- c(1, 0, 1, 0)  # En binario: 1010
cat("Cromosoma binario:", cromosoma1, "\n")
cat("Valor decimal:", binario_a_decimal(cromosoma1), "\n\n")

numero <- 7
cat("Número decimal:", numero, "\n")
cat("En binario:", decimal_a_binario(numero), "\n\n")

# 3.2 REPRESENTACIÓN REAL
cat("REPRESENTACIÓN REAL:\n")
cat("Cada variable se representa directamente como un número real\n")
cat("Más natural para muchos problemas\n\n")

# Ejemplo: Optimizar f(x,y) = -(x^2 + y^2)
cromosoma_real <- c(2.5, -1.3)
cat("Cromosoma real (x,y):", cromosoma_real, "\n")
cat("f(x,y) =", -(cromosoma_real[1]^2 + cromosoma_real[2]^2), "\n\n")

# ============================================
# SECCIÓN 4: OPERADORES GENÉTICOS
# ============================================

cat("\n⚙️ OPERADORES GENÉTICOS EN DETALLE\n\n")

# 4.1 SELECCIÓN POR RULETA
cat("4.1 SELECCIÓN POR RULETA (Roulette Wheel):\n")
cat("Probabilidad de selección proporcional al fitness\n\n")

seleccion_ruleta <- function(poblacion, fitness_values) {
  # Normalizar fitness para que sumen 1 (probabilidades)
  probabilidades <- fitness_values / sum(fitness_values)

  # Ruleta: generar número aleatorio [0,1]
  r <- runif(1)

  # Seleccionar individuo
  suma_acumulada <- 0
  for (i in 1:length(poblacion)) {
    suma_acumulada <- suma_acumulada + probabilidades[i]
    if (r <= suma_acumulada) {
      return(poblacion[i])
    }
  }
  return(poblacion[length(poblacion)])
}

# Ejemplo
set.seed(42)
poblacion <- c(1, 2, 3, 4, 5)
fitness_vals <- c(0.1, 0.15, 0.25, 0.3, 0.2)
cat("Población:", poblacion, "\n")
cat("Fitness:", fitness_vals, "\n")
seleccionado <- seleccion_ruleta(poblacion, fitness_vals)
cat("Individuo seleccionado:", seleccionado, "\n\n")

# 4.2 SELECCIÓN POR TORNEO
cat("4.2 SELECCIÓN POR TORNEO:\n")
cat("Elegir k individuos al azar, seleccionar el mejor\n\n")

seleccion_torneo <- function(poblacion, fitness_values, k = 3) {
  # Elegir k individuos al azar
  indices <- sample(1:length(poblacion), k, replace = FALSE)

  # Encontrar el mejor entre ellos
  mejor_idx <- indices[which.max(fitness_values[indices])]

  return(poblacion[mejor_idx])
}

# Ejemplo
seleccionado_torneo <- seleccion_torneo(poblacion, fitness_vals, k = 3)
cat("Selección por torneo (k=3):", seleccionado_torneo, "\n\n")

# 4.3 CRUCE DE UN PUNTO
cat("4.3 CRUCE DE UN PUNTO:\n")
cat("Dividir en un punto, intercambiar segmentos\n\n")

cruce_un_punto <- function(padre1, padre2) {
  # Elegir punto de corte aleatorio
  n <- length(padre1)
  punto_corte <- sample(1:(n-1), 1)

  # Crear hijos
  hijo1 <- c(padre1[1:punto_corte], padre2[(punto_corte+1):n])
  hijo2 <- c(padre2[1:punto_corte], padre1[(punto_corte+1):n])

  return(list(hijo1 = hijo1, hijo2 = hijo2))
}

# Ejemplo con cromosomas binarios
padre1 <- c(1, 1, 0, 0, 1, 0)
padre2 <- c(0, 1, 1, 1, 0, 1)
cat("Padre 1:", padre1, "\n")
cat("Padre 2:", padre2, "\n")
hijos <- cruce_un_punto(padre1, padre2)
cat("Hijo 1: ", hijos$hijo1, "\n")
cat("Hijo 2: ", hijos$hijo2, "\n\n")

# 4.4 CRUCE ARITMÉTICO (para representación real)
cat("4.4 CRUCE ARITMÉTICO:\n")
cat("Para números reales: promedio ponderado\n\n")

cruce_aritmetico <- function(padre1, padre2, alpha = 0.5) {
  # alpha = 0.5 → promedio simple
  # alpha aleatorio → más variedad
  hijo1 <- alpha * padre1 + (1 - alpha) * padre2
  hijo2 <- (1 - alpha) * padre1 + alpha * padre2
  return(list(hijo1 = hijo1, hijo2 = hijo2))
}

# Ejemplo
padre1_real <- c(2.5, 3.7)
padre2_real <- c(1.2, 4.8)
cat("Padre 1:", padre1_real, "\n")
cat("Padre 2:", padre2_real, "\n")
hijos_real <- cruce_aritmetico(padre1_real, padre2_real, alpha = 0.5)
cat("Hijo 1: ", hijos_real$hijo1, "\n")
cat("Hijo 2: ", hijos_real$hijo2, "\n\n")

# 4.5 MUTACIÓN BINARIA
cat("4.5 MUTACIÓN BINARIA:\n")
cat("Invertir un bit aleatorio (0→1 o 1→0)\n\n")

mutacion_binaria <- function(cromosoma, prob_mutacion = 0.1) {
  for (i in 1:length(cromosoma)) {
    if (runif(1) < prob_mutacion) {
      cromosoma[i] <- 1 - cromosoma[i]  # Invertir bit
    }
  }
  return(cromosoma)
}

# Ejemplo
original <- c(1, 0, 1, 1, 0, 0, 1, 0)
cat("Original: ", original, "\n")
set.seed(123)
mutado <- mutacion_binaria(original, prob_mutacion = 0.3)
cat("Mutado:   ", mutado, "\n\n")

# 4.6 MUTACIÓN GAUSSIANA (para representación real)
cat("4.6 MUTACIÓN GAUSSIANA:\n")
cat("Añadir ruido gaussiano a los genes\n\n")

mutacion_gaussiana <- function(cromosoma, prob_mutacion = 0.1, sigma = 0.5) {
  for (i in 1:length(cromosoma)) {
    if (runif(1) < prob_mutacion) {
      cromosoma[i] <- cromosoma[i] + rnorm(1, mean = 0, sd = sigma)
    }
  }
  return(cromosoma)
}

# Ejemplo
original_real <- c(2.5, 3.7, 1.2)
cat("Original:", original_real, "\n")
set.seed(123)
mutado_real <- mutacion_gaussiana(original_real, prob_mutacion = 0.5, sigma = 0.3)
cat("Mutado:  ", round(mutado_real, 2), "\n\n")

# ============================================
# SECCIÓN 5: ALGORITMO GENÉTICO COMPLETO
# ============================================

cat("\n🚀 IMPLEMENTACIÓN COMPLETA DE UN AG DESDE CERO\n\n")

algoritmo_genetico <- function(funcion_fitness,
                               dimension,
                               limites = c(-10, 10),
                               tam_poblacion = 50,
                               n_generaciones = 100,
                               prob_cruce = 0.8,
                               prob_mutacion = 0.1,
                               elitismo = TRUE,
                               verbose = TRUE) {
  # =========================================
  # PARÁMETROS:
  # =========================================
  # funcion_fitness: función a MAXIMIZAR (mayor = mejor)
  # dimension: número de variables
  # limites: c(min, max) para cada variable
  # tam_poblacion: número de individuos
  # n_generaciones: iteraciones
  # prob_cruce: probabilidad de aplicar cruce
  # prob_mutacion: probabilidad de mutar cada gen
  # elitismo: mantener el mejor individuo
  # verbose: mostrar progreso

  # =========================================
  # INICIALIZACIÓN
  # =========================================
  # Crear población inicial aleatoria
  poblacion <- matrix(
    runif(tam_poblacion * dimension, limites[1], limites[2]),
    nrow = tam_poblacion,
    ncol = dimension
  )

  # Historial para análisis
  mejor_fitness_hist <- numeric(n_generaciones)
  fitness_promedio_hist <- numeric(n_generaciones)

  # Mejor solución global
  mejor_solucion_global <- NULL
  mejor_fitness_global <- -Inf

  # =========================================
  # EVOLUCIÓN
  # =========================================
  for (gen in 1:n_generaciones) {

    # 1. EVALUAR FITNESS de toda la población
    fitness <- apply(poblacion, 1, funcion_fitness)

    # 2. Guardar mejor de esta generación
    mejor_idx <- which.max(fitness)
    if (fitness[mejor_idx] > mejor_fitness_global) {
      mejor_fitness_global <- fitness[mejor_idx]
      mejor_solucion_global <- poblacion[mejor_idx, ]
    }

    # 3. Estadísticas
    mejor_fitness_hist[gen] <- mejor_fitness_global
    fitness_promedio_hist[gen] <- mean(fitness)

    if (verbose && gen %% 10 == 0) {
      cat(sprintf("Generación %d: Mejor fitness = %.4f, Promedio = %.4f\n",
                  gen, mejor_fitness_global, mean(fitness)))
    }

    # 4. SELECCIÓN: Crear nueva población
    nueva_poblacion <- matrix(0, nrow = tam_poblacion, ncol = dimension)

    # Elitismo: preservar el mejor
    idx_nueva_pob <- 1
    if (elitismo) {
      nueva_poblacion[1, ] <- poblacion[mejor_idx, ]
      idx_nueva_pob <- 2
    }

    # 5. REPRODUCCIÓN
    while (idx_nueva_pob <= tam_poblacion) {

      # Seleccionar dos padres (por torneo)
      padre1 <- poblacion[seleccion_torneo_idx(fitness, k = 3), ]
      padre2 <- poblacion[seleccion_torneo_idx(fitness, k = 3), ]

      # CRUCE
      if (runif(1) < prob_cruce) {
        # Cruce aritmético
        alpha <- runif(1)
        hijo1 <- alpha * padre1 + (1 - alpha) * padre2
        hijo2 <- (1 - alpha) * padre1 + alpha * padre2
      } else {
        # Sin cruce, copiar padres
        hijo1 <- padre1
        hijo2 <- padre2
      }

      # MUTACIÓN
      hijo1 <- mutacion_real(hijo1, prob_mutacion, limites)
      hijo2 <- mutacion_real(hijo2, prob_mutacion, limites)

      # Añadir a nueva población
      if (idx_nueva_pob <= tam_poblacion) {
        nueva_poblacion[idx_nueva_pob, ] <- hijo1
        idx_nueva_pob <- idx_nueva_pob + 1
      }
      if (idx_nueva_pob <= tam_poblacion) {
        nueva_poblacion[idx_nueva_pob, ] <- hijo2
        idx_nueva_pob <- idx_nueva_pob + 1
      }
    }

    # 6. REEMPLAZAR población vieja con nueva
    poblacion <- nueva_poblacion
  }

  # =========================================
  # RETORNAR RESULTADOS
  # =========================================
  return(list(
    mejor_solucion = mejor_solucion_global,
    mejor_fitness = mejor_fitness_global,
    historial_mejor = mejor_fitness_hist,
    historial_promedio = fitness_promedio_hist
  ))
}

# =========================================
# FUNCIONES AUXILIARES
# =========================================

seleccion_torneo_idx <- function(fitness, k = 3) {
  # Retorna el ÍNDICE del ganador del torneo
  indices <- sample(1:length(fitness), k, replace = FALSE)
  ganador_idx <- indices[which.max(fitness[indices])]
  return(ganador_idx)
}

mutacion_real <- function(cromosoma, prob_mutacion, limites) {
  # Mutación gaussiana con límites
  for (i in 1:length(cromosoma)) {
    if (runif(1) < prob_mutacion) {
      # Añadir ruido proporcional al rango
      rango <- limites[2] - limites[1]
      cromosoma[i] <- cromosoma[i] + rnorm(1, 0, rango * 0.1)

      # Mantener dentro de límites
      cromosoma[i] <- max(limites[1], min(limites[2], cromosoma[i]))
    }
  }
  return(cromosoma)
}

cat("✅ Algoritmo Genético implementado!\n\n")

# ============================================
# SECCIÓN 6: EJEMPLOS PRÁCTICOS
# ============================================

cat("\n📊 EJEMPLO 1: Maximizar función simple f(x) = -(x-5)^2 + 10\n\n")

# La función tiene su máximo en x=5, f(5)=10
funcion_ejemplo1 <- function(x) {
  return(-(x[1] - 5)^2 + 10)
}

cat("Ejecutando AG...\n")
resultado1 <- algoritmo_genetico(
  funcion_fitness = funcion_ejemplo1,
  dimension = 1,
  limites = c(0, 10),
  tam_poblacion = 30,
  n_generaciones = 50,
  prob_cruce = 0.8,
  prob_mutacion = 0.1,
  elitismo = TRUE,
  verbose = FALSE
)

cat("\n✅ RESULTADOS:\n")
cat("Mejor solución encontrada: x =", resultado1$mejor_solucion, "\n")
cat("Mejor fitness:", resultado1$mejor_fitness, "\n")
cat("Solución exacta: x = 5, f(5) = 10\n\n")

# Visualizar convergencia
plot(1:length(resultado1$historial_mejor),
     resultado1$historial_mejor,
     type = "l", col = "blue", lwd = 2,
     main = "Convergencia del AG - Ejemplo 1",
     xlab = "Generación", ylab = "Fitness",
     ylim = c(0, 10))
lines(1:length(resultado1$historial_promedio),
      resultado1$historial_promedio,
      col = "red", lwd = 2, lty = 2)
abline(h = 10, col = "green", lty = 2)
legend("bottomright",
       c("Mejor", "Promedio", "Óptimo"),
       col = c("blue", "red", "green"),
       lwd = 2, lty = c(1, 2, 2))
grid()

cat("\n📊 EJEMPLO 2: Función esférica en 2D\n\n")
cat("Minimizar f(x,y) = x^2 + y^2\n")
cat("Nota: Para minimizar, maximizamos -f(x,y)\n\n")

funcion_esfera_fitness <- function(x) {
  # Maximizar = minimizar x^2 + y^2
  # Entonces retornamos el negativo
  return(-(x[1]^2 + x[2]^2))
}

resultado2 <- algoritmo_genetico(
  funcion_fitness = funcion_esfera_fitness,
  dimension = 2,
  limites = c(-10, 10),
  tam_poblacion = 50,
  n_generaciones = 100,
  verbose = FALSE
)

cat("✅ RESULTADOS:\n")
cat("Mejor solución: (x, y) =", resultado2$mejor_solucion, "\n")
cat("f(x,y) =", -resultado2$mejor_fitness, "(valor minimizado)\n")
cat("Solución exacta: (0, 0), f(0,0) = 0\n\n")

# ============================================
# SECCIÓN 7: VISUALIZACIÓN AVANZADA
# ============================================

cat("\n🎨 VISUALIZACIÓN: Evolución de la población\n\n")

# Vamos a crear un AG con visualización paso a paso
# Para función 2D: f(x,y) = -(x^2 + y^2)

AG_con_visualizacion <- function(n_generaciones = 20) {

  # Configuración
  dimension <- 2
  tam_poblacion <- 30
  limites <- c(-5, 5)

  # Función fitness
  fitness_fn <- function(x) {
    return(-(x[1]^2 + x[2]^2))
  }

  # Población inicial
  poblacion <- matrix(
    runif(tam_poblacion * dimension, limites[1], limites[2]),
    nrow = tam_poblacion,
    ncol = dimension
  )

  # Configurar visualización
  par(mfrow = c(2, 2))

  for (gen in c(1, 5, 10, 20)) {

    # Evolucionar hasta la generación deseada
    while (gen > 1) {
      fitness <- apply(poblacion, 1, fitness_fn)
      nueva_poblacion <- matrix(0, nrow = tam_poblacion, ncol = dimension)

      for (i in 1:tam_poblacion) {
        padre1 <- poblacion[seleccion_torneo_idx(fitness, 3), ]
        padre2 <- poblacion[seleccion_torneo_idx(fitness, 3), ]

        if (runif(1) < 0.8) {
          alpha <- runif(1)
          hijo <- alpha * padre1 + (1 - alpha) * padre2
        } else {
          hijo <- padre1
        }

        hijo <- mutacion_real(hijo, 0.1, limites)
        nueva_poblacion[i, ] <- hijo
      }

      poblacion <- nueva_poblacion
      gen <- gen - 1
    }

    # Visualizar población actual
    plot(poblacion[, 1], poblacion[, 2],
         xlim = limites, ylim = limites,
         xlab = "x", ylab = "y",
         main = paste("Generación", gen),
         pch = 19, col = "blue")
    points(0, 0, col = "red", pch = 19, cex = 2)  # Óptimo
    grid()
  }

  par(mfrow = c(1, 1))
}

# Descomentar para ver la animación:
# AG_con_visualizacion(20)

cat("✅ Visualización lista. Descomenta el código para verla.\n\n")

# ============================================
# SECCIÓN 8: EJERCICIOS PRÁCTICOS
# ============================================

cat("\n✏️ EJERCICIOS PARA PRACTICAR:\n\n")

cat("EJERCICIO 1 (FÁCIL):\n")
cat("Usa el AG para maximizar f(x) = sin(x) * x en [0, 10]\n")
cat("Pista: El máximo está cerca de x ≈ 7.9\n\n")

# TU CÓDIGO AQUÍ:

cat("EJERCICIO 2 (FÁCIL):\n")
cat("Minimiza f(x,y) = (x-2)^2 + (y+3)^2\n")
cat("Recuerda: Para minimizar, maximiza el negativo\n")
cat("Pista: Mínimo en (2, -3)\n\n")

# TU CÓDIGO AQUÍ:

cat("EJERCICIO 3 (MEDIO):\n")
cat("Optimiza la función de Rosenbrock en 2D:\n")
cat("f(x,y) = 100*(y - x^2)^2 + (1 - x)^2\n")
cat("Mínimo en (1, 1), f(1,1) = 0\n\n")

# TU CÓDIGO AQUÍ:

cat("EJERCICIO 4 (MEDIO):\n")
cat("Experimenta con diferentes tamaños de población:\n")
cat("- Prueba con 10, 50, 100, 200 individuos\n")
cat("- Compara la velocidad de convergencia\n")
cat("- ¿Cuál es mejor?\n\n")

# TU CÓDIGO AQUÍ:

cat("EJERCICIO 5 (DIFÍCIL):\n")
cat("Implementa SELECCIÓN POR RULETA en lugar de torneo\n")
cat("Modifica la función algoritmo_genetico\n")
cat("Compara los resultados\n\n")

# TU CÓDIGO AQUÍ:

cat("EJERCICIO 6 (DIFÍCIL):\n")
cat("Función de Rastrigin (muchos óptimos locales!):\n")
cat("f(x,y) = 20 + x^2 + y^2 - 10*(cos(2*pi*x) + cos(2*pi*y))\n")
cat("Mínimo global en (0, 0)\n")
cat("¿Puede el AG encontrarlo?\n\n")

# TU CÓDIGO AQUÍ:

cat("EJERCICIO 7 (DIFÍCIL):\n")
cat("Problema del vendedor viajero (TSP) simple:\n")
cat("4 ciudades con distancias conocidas\n")
cat("Encuentra la ruta más corta que visita todas\n")
cat("Pista: Usa representación permutacional\n\n")

# TU CÓDIGO AQUÍ:

cat("EJERCICIO 8 (MUY DIFÍCIL):\n")
cat("Añade visualización en tiempo real al AG:\n")
cat("- Graficar la población en cada generación\n")
cat("- Crear una animación del proceso evolutivo\n")
cat("- Mostrar convergencia en tiempo real\n\n")

# TU CÓDIGO AQUÍ:

# ============================================
# SOLUCIONES A LOS EJERCICIOS
# ============================================

cat("\n", rep("=", 60), "\n")
cat("SOLUCIONES - ¡Intenta primero antes de mirar!\n")
cat(rep("=", 60), "\n\n")

# SOLUCIÓN EJERCICIO 1
cat("SOLUCIÓN EJERCICIO 1:\n")
fitness_ej1 <- function(x) {
  return(sin(x[1]) * x[1])
}

sol_ej1 <- algoritmo_genetico(
  funcion_fitness = fitness_ej1,
  dimension = 1,
  limites = c(0, 10),
  tam_poblacion = 40,
  n_generaciones = 50,
  verbose = FALSE
)

cat("Mejor x:", sol_ej1$mejor_solucion, "\n")
cat("Máximo:", sol_ej1$mejor_fitness, "\n\n")

# SOLUCIÓN EJERCICIO 2
cat("SOLUCIÓN EJERCICIO 2:\n")
fitness_ej2 <- function(x) {
  # Minimizar (x-2)^2 + (y+3)^2 → maximizar su negativo
  return(-((x[1] - 2)^2 + (x[2] + 3)^2))
}

sol_ej2 <- algoritmo_genetico(
  funcion_fitness = fitness_ej2,
  dimension = 2,
  limites = c(-10, 10),
  tam_poblacion = 50,
  n_generaciones = 80,
  verbose = FALSE
)

cat("Mejor (x, y):", sol_ej2$mejor_solucion, "\n")
cat("Valor minimizado:", -sol_ej2$mejor_fitness, "\n")
cat("Óptimo esperado: (2, -3), valor = 0\n\n")

# SOLUCIÓN EJERCICIO 3
cat("SOLUCIÓN EJERCICIO 3:\n")
fitness_ej3 <- function(x) {
  # Rosenbrock: minimizar
  rosenbrock_val <- 100*(x[2] - x[1]^2)^2 + (1 - x[1])^2
  return(-rosenbrock_val)
}

sol_ej3 <- algoritmo_genetico(
  funcion_fitness = fitness_ej3,
  dimension = 2,
  limites = c(-2, 2),
  tam_poblacion = 100,  # Más individuos para función difícil
  n_generaciones = 200,  # Más generaciones
  prob_mutacion = 0.15,  # Más exploración
  verbose = FALSE
)

cat("Mejor (x, y):", sol_ej3$mejor_solucion, "\n")
cat("Valor Rosenbrock:", -sol_ej3$mejor_fitness, "\n")
cat("Óptimo: (1, 1), valor = 0\n\n")

# SOLUCIÓN EJERCICIO 4
cat("SOLUCIÓN EJERCICIO 4:\n")
tamanios <- c(10, 50, 100, 200)
resultados_ej4 <- list()

for (tam in tamanios) {
  resultado <- algoritmo_genetico(
    funcion_fitness = fitness_ej2,
    dimension = 2,
    limites = c(-10, 10),
    tam_poblacion = tam,
    n_generaciones = 50,
    verbose = FALSE
  )
  resultados_ej4[[as.character(tam)]] <- resultado
  cat(sprintf("Población = %d: Fitness final = %.4f\n",
              tam, resultado$mejor_fitness))
}

# Comparar convergencia
plot(1:50, resultados_ej4[["10"]]$historial_mejor,
     type = "l", col = "red", lwd = 2,
     main = "Comparación de Tamaños de Población",
     xlab = "Generación", ylab = "Mejor Fitness")
lines(1:50, resultados_ej4[["50"]]$historial_mejor, col = "blue", lwd = 2)
lines(1:50, resultados_ej4[["100"]]$historial_mejor, col = "green", lwd = 2)
lines(1:50, resultados_ej4[["200"]]$historial_mejor, col = "purple", lwd = 2)
legend("bottomright",
       paste("Pob =", tamanios),
       col = c("red", "blue", "green", "purple"),
       lwd = 2)
grid()

cat("\n💡 Observación: Más individuos → mejor solución, pero más lento\n\n")

# SOLUCIÓN EJERCICIO 6
cat("SOLUCIÓN EJERCICIO 6:\n")
fitness_rastrigin <- function(x) {
  # Rastrigin: muy difícil!
  rastrigin_val <- 20 + x[1]^2 + x[2]^2 -
    10*(cos(2*pi*x[1]) + cos(2*pi*x[2]))
  return(-rastrigin_val)
}

sol_ej6 <- algoritmo_genetico(
  funcion_fitness = fitness_rastrigin,
  dimension = 2,
  limites = c(-5, 5),
  tam_poblacion = 100,
  n_generaciones = 200,
  prob_mutacion = 0.2,  # Alta mutación para explorar
  verbose = FALSE
)

cat("Mejor (x, y):", sol_ej6$mejor_solucion, "\n")
cat("Valor Rastrigin:", -sol_ej6$mejor_fitness, "\n")
cat("Óptimo: (0, 0), valor = 0\n")
cat("Nota: Esta función es MUY difícil. Incluso cerca del óptimo es un éxito!\n\n")

# ============================================
# RESUMEN DEL MÓDULO 2
# ============================================

cat("\n", rep("🎓", 30), "\n")
cat("RESUMEN DEL MÓDULO 2: ALGORITMOS GENÉTICOS BÁSICOS\n")
cat(rep("🎓", 30), "\n\n")

cat("✅ Has aprendido:\n")
cat("  1. Inspiración biológica de los AGs\n")
cat("  2. Componentes: población, fitness, selección, cruce, mutación\n")
cat("  3. Representación binaria vs real\n")
cat("  4. Operadores genéticos en detalle\n")
cat("  5. Implementación completa de un AG desde cero\n")
cat("  6. Aplicación a problemas de optimización\n")
cat("  7. Visualización del proceso evolutivo\n\n")

cat("🎯 Conceptos clave:\n")
cat("  • Los AGs imitan la evolución natural\n")
cat("  • Balance entre EXPLORACIÓN y EXPLOTACIÓN\n")
cat("  • Elitismo preserva las mejores soluciones\n")
cat("  • Mutación mantiene diversidad\n")
cat("  • Cruce combina buenas características\n\n")

cat("💡 Consejos prácticos:\n")
cat("  1. Población grande → mejor exploración, más lento\n")
cat("  2. Mutación alta → más exploración\n")
cat("  3. Mutación baja → más explotación\n")
cat("  4. Elitismo casi siempre ayuda\n")
cat("  5. Experimenta con parámetros!\n\n")

cat("🚀 Próximos pasos:\n")
cat("  1. Completa TODOS los ejercicios\n")
cat("  2. Experimenta con tus propias funciones\n")
cat("  3. Cuando domines esto, pasa al Módulo 3\n\n")

cat("➡️  Continúa con: modulo_3_geneticos_avanzado.R\n\n")
