# 🚀 Guía de Inicio Rápido
## Curso PSO y Algoritmos Genéticos en R

---

## ⚡ Empezar en 5 Minutos

### 1. Instalar Paquetes Necesarios

```r
# Copiar y ejecutar en RStudio
install.packages(c(
  "ggplot2",      # Visualización
  "GA",           # Algoritmos Genéticos
  "pso",          # PSO
  "randomForest"  # Para ejemplos de ML (opcional)
))
```

### 2. Abrir el Primer Módulo

```r
# En RStudio, abrir el archivo:
# modulo_1_fundamentos.R

# Ejecutar línea por línea con: Ctrl + Enter (Windows/Linux) o Cmd + Enter (Mac)
```

### 3. Tu Primer Algoritmo

```r
# Copiar este código y ejecutar:

# Cargar módulo 4 (PSO básico)
source("modulo_4_pso_basico.R")

# Función a optimizar: minimizar x^2
mi_funcion <- function(x) sum(x^2)

# Ejecutar PSO
resultado <- PSO(
  funcion_objetivo = mi_funcion,
  dimension = 2,           # 2 variables
  limites = c(-10, 10),    # Rango [-10, 10]
  n_particulas = 30,       # 30 partículas
  n_iteraciones = 50,      # 50 iteraciones
  minimizar = TRUE
)

# Ver resultado
cat("Mejor solución:", resultado$mejor_posicion, "\n")
cat("Valor óptimo:", resultado$mejor_fitness, "\n")

# Graficar convergencia
plot(resultado$historial, type='l', lwd=2, col='blue',
     main="Mi Primer PSO", xlab="Iteración", ylab="Fitness")
```

---

## 📚 Estructura del Curso

### Para Principiantes (Empieza aquí)

1. **modulo_1_fundamentos.R** (2-3 horas)
   - ¿Qué es optimización?
   - Funciones de benchmark
   - Tu primer optimizador

2. **modulo_2_geneticos_basico.R** (3-4 horas)
   - Algoritmos Genéticos desde cero
   - Selección, cruce, mutación
   - Muchos ejemplos prácticos

### Para Nivel Intermedio

3. **modulo_3_geneticos_avanzado.R** (4-5 horas)
   - Operadores especializados
   - Optimización multiobjetivo
   - Casos avanzados

4. **modulo_4_pso_basico.R** (3-4 horas)
   - PSO desde cero
   - Visualización de partículas
   - Comparación con AG

### Para Nivel Avanzado

5. **modulo_5_pso_avanzado.R** (4-5 horas)
   - Variantes de PSO
   - PSO binario
   - Hibridación PSO+AG

6. **modulo_6_casos_practicos.R** (5-6 horas)
   - Carteras de inversión
   - Machine Learning
   - Proyectos reales

---

## 🎯 Rutas de Aprendizaje

### Ruta 1: Solo quiero aprender PSO
```
Módulo 1 → Módulo 4 → Módulo 5 → Módulo 6
```

### Ruta 2: Solo quiero aprender Algoritmos Genéticos
```
Módulo 1 → Módulo 2 → Módulo 3 → Módulo 6
```

### Ruta 3: Quiero dominar ambos (Recomendado)
```
Módulo 1 → Módulo 2 → Módulo 3 → Módulo 4 → Módulo 5 → Módulo 6
```

### Ruta 4: Tengo prisa, lo básico
```
Módulo 1 → Módulo 2 (hasta sección 5) → Módulo 4 (hasta sección 5)
```

---

## 💡 Consejos para Aprovechar el Curso

### ✅ Haz esto:
- **Ejecuta cada línea de código** - No solo leas
- **Haz los ejercicios** - La práctica es clave
- **Experimenta** - Cambia parámetros y observa
- **Toma notas** - Escribe lo que aprendes
- **Visualiza** - Los gráficos ayudan a entender

### ❌ Evita esto:
- Copiar/pegar sin entender
- Saltarte los ejercicios
- Pasar al siguiente módulo sin dominar el anterior
- Ver las soluciones antes de intentar
- Estudiar solo teoría sin práctica

---

## 🔧 Problemas Comunes

### Error: "could not find function 'PSO'"

**Solución:** Debes cargar el módulo primero
```r
source("modulo_4_pso_basico.R")
```

### Error: "there is no package called 'GA'"

**Solución:** Instalar el paquete
```r
install.packages("GA")
```

### El algoritmo no converge bien

**Solución:** Ajusta los parámetros
```r
# Aumentar iteraciones
n_iteraciones = 200  # En lugar de 50

# Aumentar población
n_particulas = 50  # En lugar de 30

# Para AG, aumentar probabilidad de mutación
prob_mutacion = 0.2  # En lugar de 0.1
```

### Los gráficos no se ven

**Solución:** Asegúrate de tener ventana gráfica abierta
```r
# En RStudio, ir a: View > Panes > Show All Panes
dev.new()  # Abrir nueva ventana gráfica
```

---

## 📖 Ejemplos Rápidos

### Ejemplo 1: Maximizar una función

```r
# Cargar PSO
source("modulo_4_pso_basico.R")

# Función a maximizar: -(x-5)^2 + 10
maximizar <- function(x) {
  return(-(x[1] - 5)^2 + 10)
}

# Ejecutar (PSO maximiza por defecto si minimizar=FALSE)
resultado <- PSO(
  funcion_objetivo = maximizar,
  dimension = 1,
  limites = c(0, 10),
  n_particulas = 20,
  n_iteraciones = 30,
  minimizar = FALSE
)

cat("Máximo en x =", resultado$mejor_posicion, "\n")
cat("Valor máximo =", resultado$mejor_fitness, "\n")
```

### Ejemplo 2: Usar Algoritmo Genético

```r
# Usando el paquete GA
library(GA)

# Función a minimizar
funcion <- function(x) sum(x^2)

# Ejecutar AG
resultado_ag <- ga(
  type = "real-valued",
  fitness = function(x) -funcion(x),  # Negativo porque GA maximiza
  lower = c(-10, -10),
  upper = c(10, 10),
  popSize = 30,
  maxiter = 50
)

# Ver resultado
summary(resultado_ag)
plot(resultado_ag)
```

### Ejemplo 3: Comparar PSO vs AG

```r
source("modulo_4_pso_basico.R")
library(GA)

# Función de prueba
rosenbrock <- function(x) {
  100*(x[2] - x[1]^2)^2 + (1 - x[1])^2
}

# PSO
res_pso <- PSO(rosenbrock, dimension = 2, limites = c(-2, 2),
               n_particulas = 30, n_iteraciones = 100, minimizar = TRUE)

# AG
res_ag <- ga(type = "real-valued", fitness = function(x) -rosenbrock(x),
             lower = c(-2, -2), upper = c(2, 2),
             popSize = 30, maxiter = 100)

# Comparar
cat("PSO:", res_pso$mejor_fitness, "\n")
cat("AG:", -res_ag@fitnessValue, "\n")
```

---

## 🎓 Certificación Personal

Cuando completes el curso, habrás dominado:

- [ ] Conceptos de optimización metaheurística
- [ ] Implementar AG desde cero
- [ ] Implementar PSO desde cero
- [ ] Elegir algoritmo apropiado para cada problema
- [ ] Ajustar parámetros efectivamente
- [ ] Aplicar a problemas reales
- [ ] Usar paquetes profesionales (GA, pso)
- [ ] Resolver al menos 30 ejercicios
- [ ] Completar 3 proyectos prácticos

---

## 📞 Siguiente Paso

### Si eres principiante:
**👉 Abre `modulo_1_fundamentos.R` ahora**

### Si tienes experiencia en R:
**👉 Abre `modulo_2_geneticos_basico.R` o `modulo_4_pso_basico.R`**

### Si ya conoces AG y PSO:
**👉 Ve directo a `modulo_6_casos_practicos.R`**

---

## 💬 Comentarios Finales

Este curso está diseñado para ser:
- **Práctico**: Más código, menos teoría abstracta
- **Progresivo**: De simple a complejo
- **Completo**: Desde cero hasta aplicaciones reales
- **Auto-contenido**: Todo el código incluido

**¡Disfruta el aprendizaje y mucho éxito! 🚀**

---

## 📚 Recursos Adicionales

- **Documentación GA**: `?ga` después de `library(GA)`
- **Documentación PSO**: `?psoptim` después de `library(pso)`
- **Índice completo**: Ver `CURSO_PSO_GENETICOS_R.md`

---

**Última actualización**: 2025
**Versión**: 1.0
