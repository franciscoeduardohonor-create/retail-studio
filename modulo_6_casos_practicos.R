# ============================================
# MÓDULO 6: CASOS PRÁCTICOS DEL MUNDO REAL
# ============================================
# Curso: PSO y Algoritmos Genéticos en R
# Nivel: AVANZADO - APLICACIONES
# Duración estimada: 5-6 horas

# ============================================
# TABLA DE CONTENIDOS
# ============================================
# 1. Optimización de carteras de inversión
# 2. Ajuste de hiperparámetros en Machine Learning
# 3. Problema del vendedor viajero (TSP)
# 4. Diseño de redes neuronales
# 5. Optimización de funciones complejas multimodales
# 6. Scheduling y planificación
# 7. Comparación final PSO vs AG
# 8. Proyectos finales

# ============================================
# SECCIÓN 1: OPTIMIZACIÓN DE CARTERAS
# ============================================

cat("\n💰 CASO 1: OPTIMIZACIÓN DE CARTERA DE INVERSIONES\n\n")

cat("PROBLEMA: Maximizar rendimiento, minimizar riesgo\n")
cat("VARIABLES: Proporción invertida en cada activo\n")
cat("RESTRICCIONES: Suma de proporciones = 1, cada proporción >= 0\n\n")

# Datos simulados de activos
set.seed(42)
n_activos <- 5

# Rendimientos esperados (%)
rendimientos <- c(8, 12, 15, 10, 7)

# Matriz de covarianza (riesgo)
cov_matriz <- matrix(c(
  4.0, 1.2, 0.8, 1.0, 0.5,
  1.2, 9.0, 2.0, 1.5, 0.8,
  0.8, 2.0, 16.0, 2.5, 1.0,
  1.0, 1.5, 2.5, 6.25, 0.7,
  0.5, 0.8, 1.0, 0.7, 2.25
), nrow = 5, byrow = TRUE)

cat("Activos disponibles:\n")
for (i in 1:n_activos) {
  cat(sprintf("  Activo %d: Rendimiento = %d%%, Riesgo = %.2f%%\n",
              i, rendimientos[i], sqrt(cov_matriz[i,i])))
}
cat("\n")

# Función objetivo: Ratio de Sharpe
# Maximizar: (Rendimiento - tasa_libre_riesgo) / Riesgo

calcular_cartera <- function(pesos) {
  # Normalizar pesos para que sumen 1
  pesos <- pesos / sum(pesos)

  # Rendimiento de la cartera
  rendimiento_cartera <- sum(pesos * rendimientos)

  # Riesgo de la cartera (desviación estándar)
  varianza_cartera <- t(pesos) %*% cov_matriz %*% pesos
  riesgo_cartera <- sqrt(varianza_cartera)

  # Ratio de Sharpe (asumiendo tasa libre de riesgo = 2%)
  tasa_libre <- 2
  if (riesgo_cartera > 0) {
    sharpe <- (rendimiento_cartera - tasa_libre) / riesgo_cartera
  } else {
    sharpe <- 0
  }

  return(sharpe)
}

# Optimizar con PSO
cat("Optimizando cartera con PSO...\n")

# Cargar implementación PSO del módulo 4
source("modulo_4_pso_basico.R", local = TRUE)

resultado_cartera <- PSO(
  funcion_objetivo = calcular_cartera,
  dimension = n_activos,
  limites = c(0, 1),
  n_particulas = 50,
  n_iteraciones = 100,
  minimizar = FALSE,  # Maximizar Sharpe
  verbose = FALSE
)

# Normalizar pesos finales
pesos_optimos <- resultado_cartera$mejor_posicion
pesos_optimos <- pesos_optimos / sum(pesos_optimos)

cat("\n✅ CARTERA ÓPTIMA:\n")
for (i in 1:n_activos) {
  cat(sprintf("  Activo %d: %.1f%%\n", i, pesos_optimos[i] * 100))
}

rendimiento_final <- sum(pesos_optimos * rendimientos)
varianza_final <- t(pesos_optimos) %*% cov_matriz %*% pesos_optimos
riesgo_final <- sqrt(varianza_final)

cat(sprintf("\nRendimiento esperado: %.2f%%\n", rendimiento_final))
cat(sprintf("Riesgo (σ): %.2f%%\n", riesgo_final))
cat(sprintf("Ratio de Sharpe: %.2f\n\n", resultado_cartera$mejor_fitness))

# Visualizar
barplot(pesos_optimos * 100,
        names.arg = paste("Activo", 1:n_activos),
        col = rainbow(n_activos),
        main = "Distribución Óptima de Cartera",
        ylab = "Porcentaje (%)",
        ylim = c(0, max(pesos_optimos * 100) * 1.2))
grid()

# ============================================
# SECCIÓN 2: HIPERPARÁMETROS ML
# ============================================

cat("\n🤖 CASO 2: AJUSTE DE HIPERPARÁMETROS EN MACHINE LEARNING\n\n")

cat("PROBLEMA: Encontrar mejores hiperparámetros para un modelo\n")
cat("EJEMPLO: Random Forest para clasificación\n\n")

# Generar datos sintéticos
set.seed(123)
n_samples <- 200
X1 <- rnorm(n_samples)
X2 <- rnorm(n_samples)
y <- factor(ifelse(X1^2 + X2^2 > 1, "A", "B"))

datos <- data.frame(X1 = X1, X2 = X2, y = y)

cat("Datos generados:", n_samples, "muestras\n")
cat("Distribución de clases:\n")
print(table(y))
cat("\n")

# Función de evaluación (cross-validation)
if (require("randomForest", quietly = TRUE)) {

  evaluar_modelo <- function(params) {
    # params: [ntree, mtry, maxnodes]
    # Redondear a enteros
    ntree <- round(max(10, min(500, params[1])))
    mtry <- round(max(1, min(2, params[2])))
    maxnodes <- round(max(5, min(50, params[3])))

    # Entrenar con validación cruzada simple (80-20)
    set.seed(42)
    indices <- sample(1:nrow(datos), 0.8 * nrow(datos))
    train <- datos[indices, ]
    test <- datos[-indices, ]

    # Entrenar modelo
    tryCatch({
      modelo <- randomForest::randomForest(
        y ~ X1 + X2,
        data = train,
        ntree = ntree,
        mtry = mtry,
        maxnodes = maxnodes
      )

      # Predecir
      pred <- predict(modelo, test)

      # Accuracy
      accuracy <- sum(pred == test$y) / length(pred)

      return(accuracy)

    }, error = function(e) {
      return(0)
    })
  }

  cat("Optimizando hiperparámetros con PSO...\n")

  resultado_hp <- PSO(
    funcion_objetivo = evaluar_modelo,
    dimension = 3,
    limites = c(10, 500),  # Para simplificar, mismo límite
    n_particulas = 20,
    n_iteraciones = 30,
    minimizar = FALSE,
    verbose = FALSE
  )

  cat("\n✅ HIPERPARÁMETROS ÓPTIMOS:\n")
  cat("ntree:", round(resultado_hp$mejor_posicion[1]), "\n")
  cat("mtry:", round(resultado_hp$mejor_posicion[2]), "\n")
  cat("maxnodes:", round(resultado_hp$mejor_posicion[3]), "\n")
  cat("Accuracy:", resultado_hp$mejor_fitness, "\n\n")

} else {
  cat("Instala 'randomForest' para ejecutar este ejemplo\n")
  cat("install.packages('randomForest')\n\n")
}

# ============================================
# SECCIÓN 3: PROBLEMA DEL VENDEDOR VIAJERO
# ============================================

cat("\n🗺️ CASO 3: PROBLEMA DEL VENDEDOR VIAJERO (TSP)\n\n")

cat("PROBLEMA: Encontrar la ruta más corta que visita todas las ciudades\n")
cat("TIPO: Optimización combinatoria (permutación)\n\n")

# Crear ciudades aleatorias
n_ciudades <- 10
set.seed(42)
ciudades <- data.frame(
  x = runif(n_ciudades, 0, 100),
  y = runif(n_ciudades, 0, 100)
)

# Matriz de distancias
distancias <- matrix(0, n_ciudades, n_ciudades)
for (i in 1:n_ciudades) {
  for (j in 1:n_ciudades) {
    if (i != j) {
      distancias[i, j] <- sqrt((ciudades$x[i] - ciudades$x[j])^2 +
                              (ciudades$y[i] - ciudades$y[j])^2)
    }
  }
}

# Función objetivo: longitud total del tour
longitud_tour <- function(tour) {
  distancia_total <- 0
  for (i in 1:(length(tour) - 1)) {
    distancia_total <- distancia_total + distancias[tour[i], tour[i+1]]
  }
  # Volver al inicio
  distancia_total <- distancia_total + distancias[tour[length(tour)], tour[1]]
  return(-distancia_total)  # Negativo porque PSO maximiza
}

# AG para TSP con operador PMX
cat("Resolviendo TSP con Algoritmo Genético...\n")

AG_TSP <- function(n_generaciones = 200, tam_poblacion = 50) {

  # Población inicial: permutaciones aleatorias
  poblacion <- matrix(0, tam_poblacion, n_ciudades)
  for (i in 1:tam_poblacion) {
    poblacion[i, ] <- sample(1:n_ciudades)
  }

  mejor_tour <- NULL
  mejor_distancia <- Inf

  for (gen in 1:n_generaciones) {
    # Evaluar fitness
    fitness <- apply(poblacion, 1, longitud_tour)

    # Actualizar mejor
    idx_mejor <- which.max(fitness)  # max porque es negativo
    if (-fitness[idx_mejor] < mejor_distancia) {
      mejor_distancia <- -fitness[idx_mejor]
      mejor_tour <- poblacion[idx_mejor, ]
    }

    # Nueva población
    nueva_pob <- matrix(0, tam_poblacion, n_ciudades)

    # Elitismo
    nueva_pob[1, ] <- mejor_tour

    # Reproducción
    for (i in 2:tam_poblacion) {
      # Selección por torneo
      idx1 <- sample(1:tam_poblacion, 3)
      idx2 <- sample(1:tam_poblacion, 3)
      padre1 <- poblacion[idx1[which.max(fitness[idx1])], ]
      padre2 <- poblacion[idx2[which.max(fitness[idx2])], ]

      # Cruce OX (Order Crossover)
      if (runif(1) < 0.8) {
        puntos <- sort(sample(2:(n_ciudades-1), 2))
        hijo <- rep(NA, n_ciudades)
        hijo[puntos[1]:puntos[2]] <- padre1[puntos[1]:puntos[2]]

        # Completar con padre2
        pos <- puntos[2] + 1
        for (j in 1:n_ciudades) {
          ciudad <- padre2[((puntos[2] + j - 1) %% n_ciudades) + 1]
          if (!(ciudad %in% hijo)) {
            if (pos > n_ciudades) pos <- 1
            hijo[pos] <- ciudad
            pos <- pos + 1
          }
        }
      } else {
        hijo <- padre1
      }

      # Mutación: intercambiar dos ciudades
      if (runif(1) < 0.2) {
        idx <- sample(1:n_ciudades, 2)
        temp <- hijo[idx[1]]
        hijo[idx[1]] <- hijo[idx[2]]
        hijo[idx[2]] <- temp
      }

      nueva_pob[i, ] <- hijo
    }

    poblacion <- nueva_pob
  }

  return(list(tour = mejor_tour, distancia = mejor_distancia))
}

resultado_tsp <- AG_TSP(n_generaciones = 200, tam_poblacion = 50)

cat("\n✅ MEJOR RUTA ENCONTRADA:\n")
cat("Tour:", resultado_tsp$tour, "\n")
cat("Distancia total:", round(resultado_tsp$distancia, 2), "\n\n")

# Visualizar
plot(ciudades$x, ciudades$y, pch = 19, cex = 2, col = "red",
     main = "Problema del Vendedor Viajero",
     xlab = "X", ylab = "Y", asp = 1)
text(ciudades$x, ciudades$y, 1:n_ciudades, pos = 3, cex = 0.8)

# Dibujar ruta
tour <- resultado_tsp$tour
for (i in 1:(length(tour) - 1)) {
  arrows(ciudades$x[tour[i]], ciudades$y[tour[i]],
         ciudades$x[tour[i+1]], ciudades$y[tour[i+1]],
         length = 0.1, col = "blue", lwd = 2)
}
# Volver al inicio
arrows(ciudades$x[tour[length(tour)]], ciudades$y[tour[length(tour)]],
       ciudades$x[tour[1]], ciudades$y[tour[1]],
       length = 0.1, col = "blue", lwd = 2)

# ============================================
# SECCIÓN 4: FUNCIONES MULTIMODALES COMPLEJAS
# ============================================

cat("\n📈 CASO 4: OPTIMIZACIÓN DE FUNCIONES MULTIMODALES\n\n")

cat("PROBLEMA: Función con múltiples óptimos locales\n")
cat("FUNCIÓN: Ackley en 5D\n\n")

# Función de Ackley
ackley <- function(x) {
  n <- length(x)
  a <- 20
  b <- 0.2
  c <- 2 * pi

  suma1 <- sum(x^2)
  suma2 <- sum(cos(c * x))

  term1 <- -a * exp(-b * sqrt(suma1 / n))
  term2 <- -exp(suma2 / n)

  return(term1 + term2 + a + exp(1))
}

cat("Comparando PSO vs AG en Ackley (5D)...\n\n")

# PSO
cat("Ejecutando PSO...\n")
resultado_pso_ackley <- PSO(
  funcion_objetivo = ackley,
  dimension = 5,
  limites = c(-5, 5),
  n_particulas = 40,
  n_iteraciones = 100,
  minimizar = TRUE,
  verbose = FALSE
)

cat("PSO - Mejor fitness:", resultado_pso_ackley$mejor_fitness, "\n")

# AG (usando implementación simple)
cat("Ejecutando AG...\n")

# Usar paquete GA
if (require("GA", quietly = TRUE)) {
  resultado_ga_ackley <- GA::ga(
    type = "real-valued",
    fitness = function(x) -ackley(x),  # Negativo para maximizar
    lower = rep(-5, 5),
    upper = rep(5, 5),
    popSize = 40,
    maxiter = 100,
    monitor = FALSE
  )
  cat("AG - Mejor fitness:", -resultado_ga_ackley@fitnessValue, "\n\n")
}

cat("Óptimo global: 0 en (0,0,0,0,0)\n\n")

# Comparar convergencia
plot(1:100, resultado_pso_ackley$historial,
     type = "l", col = "blue", lwd = 2,
     main = "PSO vs AG en Función Ackley",
     xlab = "Iteración", ylab = "Mejor fitness (log)",
     log = "y", ylim = c(1e-10, 10))
if (exists("resultado_ga_ackley")) {
  lines(1:100, -resultado_ga_ackley@summary[, "max"],
        col = "red", lwd = 2)
  legend("topright", c("PSO", "AG"), col = c("blue", "red"), lwd = 2)
}
abline(h = 0, lty = 2, col = "green")
grid()

# ============================================
# SECCIÓN 5: COMPARACIÓN SISTEMÁTICA
# ============================================

cat("\n⚔️ COMPARACIÓN SISTEMÁTICA: PSO vs AG\n\n")

# Funciones de benchmark
funciones_test <- list(
  Esfera = function(x) sum(x^2),
  Rosenbrock = function(x) {
    n <- length(x)
    suma <- 0
    for (i in 1:(n-1)) {
      suma <- suma + 100*(x[i+1] - x[i]^2)^2 + (1 - x[i])^2
    }
    suma
  },
  Rastrigin = function(x) {
    n <- length(x)
    10*n + sum(x^2 - 10*cos(2*pi*x))
  }
)

cat("Probando en 3 funciones de benchmark (dimensión 5)...\n\n")

resultados_comparacion <- data.frame(
  Funcion = character(),
  PSO_Mejor = numeric(),
  PSO_Tiempo = numeric(),
  AG_Mejor = numeric(),
  AG_Tiempo = numeric(),
  stringsAsFactors = FALSE
)

for (nombre in names(funciones_test)) {
  cat("Probando", nombre, "...\n")

  # PSO
  tiempo_pso <- system.time({
    res_pso <- PSO(
      funcion_objetivo = funciones_test[[nombre]],
      dimension = 5,
      limites = c(-5, 5),
      n_particulas = 30,
      n_iteraciones = 50,
      verbose = FALSE
    )
  })

  # AG
  if (require("GA", quietly = TRUE)) {
    tiempo_ag <- system.time({
      res_ag <- GA::ga(
        type = "real-valued",
        fitness = function(x) -funciones_test[[nombre]](x),
        lower = rep(-5, 5),
        upper = rep(5, 5),
        popSize = 30,
        maxiter = 50,
        monitor = FALSE
      )
    })

    resultados_comparacion <- rbind(resultados_comparacion, data.frame(
      Funcion = nombre,
      PSO_Mejor = res_pso$mejor_fitness,
      PSO_Tiempo = tiempo_pso["elapsed"],
      AG_Mejor = -res_ag@fitnessValue,
      AG_Tiempo = tiempo_ag["elapsed"]
    ))
  }
}

cat("\n📊 RESULTADOS DE COMPARACIÓN:\n\n")
print(resultados_comparacion)

cat("\n💡 CONCLUSIONES:\n")
cat("  • PSO suele ser más rápido en funciones continuas suaves\n")
cat("  • AG puede ser mejor en funciones muy multimodales\n")
cat("  • Ambos son efectivos, la elección depende del problema\n\n")

# ============================================
# SECCIÓN 6: PROYECTOS FINALES
# ============================================

cat("\n🎯 PROYECTOS FINALES PARA PRACTICAR\n\n")

cat("PROYECTO 1: OPTIMIZACIÓN DE RUTAS DE ENTREGA\n")
cat("  • 20 puntos de entrega en un mapa\n")
cat("  • Minimizar distancia total + tiempo\n")
cat("  • Restricción: capacidad del vehículo\n")
cat("  • Usa AG con representación permutacional\n\n")

cat("PROYECTO 2: DISEÑO DE RED NEURONAL\n")
cat("  • Optimizar arquitectura: #capas, #neuronas, tasa aprendizaje\n")
cat("  • Dataset: clasificación de dígitos\n")
cat("  • Usa PSO para hiperparámetros\n")
cat("  • Objetivo: maximizar accuracy, minimizar tiempo\n\n")

cat("PROYECTO 3: SCHEDULING DE TAREAS\n")
cat("  • 15 tareas con dependencias\n")
cat("  • 3 procesadores disponibles\n")
cat("  • Minimizar tiempo total (makespan)\n")
cat("  • Usa AG con cromosoma de asignaciones\n\n")

cat("PROYECTO 4: CALIBRACIÓN DE MODELO FINANCIERO\n")
cat("  • Modelo de Black-Scholes para opciones\n")
cat("  • Calibrar parámetros: volatilidad, tasa, etc.\n")
cat("  • Minimizar error con datos reales\n")
cat("  • Compara PSO vs AG\n\n")

cat("PROYECTO 5: FEATURE SELECTION\n")
cat("  • Dataset con 50 características\n")
cat("  • Seleccionar las mejores 10\n")
cat("  • Maximizar AUC del clasificador\n")
cat("  • Usa PSO binario\n\n")

# ============================================
# PLANTILLA PARA PROYECTOS
# ============================================

cat("\n📝 PLANTILLA PARA TUS PROYECTOS:\n\n")

cat("
# ============================================
# MI PROYECTO: [NOMBRE]
# ============================================

# 1. DEFINIR EL PROBLEMA
problema_descripcion <- '
  [Describe tu problema aquí]
'

# 2. FUNCIÓN OBJETIVO
mi_funcion_objetivo <- function(solucion) {
  # [Implementa cómo evaluar una solución]
  fitness <- 0
  # ... tu código ...
  return(fitness)
}

# 3. CONFIGURAR ALGORITMO
usar_pso <- TRUE  # FALSE para AG

if (usar_pso) {
  resultado <- PSO(
    funcion_objetivo = mi_funcion_objetivo,
    dimension = ...,
    limites = c(..., ...),
    n_particulas = 30,
    n_iteraciones = 100
  )
} else {
  # Configurar AG
  resultado <- GA::ga(...)
}

# 4. ANALIZAR RESULTADOS
cat('Mejor solución:', resultado$mejor_posicion, '\\n')
cat('Fitness:', resultado$mejor_fitness, '\\n')

# 5. VISUALIZAR
plot(resultado$historial, type='l', main='Convergencia')

# ============================================
")

# ============================================
# RECURSOS ADICIONALES
# ============================================

cat("\n📚 RECURSOS PARA CONTINUAR APRENDIENDO:\n\n")

cat("LIBROS:\n")
cat("  • 'Swarm Intelligence' - Kennedy & Eberhart\n")
cat("  • 'Genetic Algorithms in Search...' - Goldberg\n")
cat("  • 'Introduction to Evolutionary Computing' - Eiben & Smith\n\n")

cat("PAQUETES DE R:\n")
cat("  • GA - Algoritmos Genéticos\n")
cat("  • pso - Particle Swarm Optimization\n")
cat("  • DEoptim - Differential Evolution\n")
cat("  • cmaes - Covariance Matrix Adaptation ES\n")
cat("  • mco - Optimización Multiobjetivo\n\n")

cat("PAPERS IMPORTANTES:\n")
cat("  • Kennedy & Eberhart (1995) - PSO original\n")
cat("  • Clerc & Kennedy (2002) - PSO con constricción\n")
cat("  • Deb et al. (2002) - NSGA-II\n")
cat("  • Shi & Eberhart (1998) - PSO con inercia\n\n")

cat("BENCHMARKS ONLINE:\n")
cat("  • CEC Benchmark Functions\n")
cat("  • Black-Box Optimization Benchmarking (BBOB)\n\n")

# ============================================
# RESUMEN FINAL DEL CURSO
# ============================================

cat("\n", rep("🎓", 40), "\n")
cat("FELICIDADES - HAS COMPLETADO EL CURSO!\n")
cat(rep("🎓", 40), "\n\n")

cat("✅ LO QUE HAS APRENDIDO:\n\n")

cat("MÓDULO 1 - Fundamentos:\n")
cat("  • Conceptos de optimización\n")
cat("  • Funciones de benchmark\n")
cat("  • Tu primer optimizador\n\n")

cat("MÓDULO 2 - Algoritmos Genéticos Básicos:\n")
cat("  • Selección, cruce, mutación\n")
cat("  • Implementación desde cero\n")
cat("  • Visualización evolutiva\n\n")

cat("MÓDULO 3 - AG Avanzados:\n")
cat("  • Operadores especializados\n")
cat("  • Adaptación de parámetros\n")
cat("  • Optimización multiobjetivo\n\n")

cat("MÓDULO 4 - PSO Básico:\n")
cat("  • Movimiento de partículas\n")
cat("  • Inercia, cognitivo, social\n")
cat("  • Implementación completa\n\n")

cat("MÓDULO 5 - PSO Avanzado:\n")
cat("  • Variantes de PSO\n")
cat("  • PSO binario\n")
cat("  • Hibridación PSO+AG\n\n")

cat("MÓDULO 6 - Casos Prácticos:\n")
cat("  • Carteras de inversión\n")
cat("  • Hiperparámetros ML\n")
cat("  • TSP y problemas reales\n\n")

cat("🎯 HABILIDADES ADQUIRIDAS:\n")
cat("  ✓ Implementar PSO desde cero\n")
cat("  ✓ Implementar AG desde cero\n")
cat("  ✓ Elegir el algoritmo apropiado\n")
cat("  ✓ Ajustar parámetros efectivamente\n")
cat("  ✓ Aplicar a problemas reales\n")
cat("  ✓ Visualizar y analizar resultados\n")
cat("  ✓ Usar paquetes profesionales\n\n")

cat("🚀 PRÓXIMOS PASOS:\n")
cat("  1. Practica con tus propios problemas\n")
cat("  2. Experimenta con variaciones\n")
cat("  3. Lee papers científicos\n")
cat("  4. Participa en competencias (Kaggle, CEC)\n")
cat("  5. Contribuye a proyectos open-source\n")
cat("  6. ¡Comparte tu conocimiento!\n\n")

cat("💡 RECUERDA:\n")
cat("  • No existe 'el mejor' algoritmo para todo\n")
cat("  • La práctica hace al maestro\n")
cat("  • Siempre compara con baselines simples\n")
cat("  • Visualiza para entender\n")
cat("  • Comparte y aprende de otros\n\n")

cat("¡GRACIAS POR COMPLETAR ESTE CURSO!\n")
cat("¡Mucho éxito en tus proyectos de optimización! 🎉\n\n")
