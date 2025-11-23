# 🎓 Curso Práctico: Algoritmos PSO y Genéticos en R
## Desde Principiante hasta Avanzado

---

## 📋 Índice del Curso

### **NIVEL PRINCIPIANTE**

#### [Módulo 1: Fundamentos de Optimización](./modulo_1_fundamentos.R)
- ¿Qué es la optimización?
- Tipos de problemas de optimización
- Conceptos básicos: función objetivo, restricciones, espacio de búsqueda
- Tu primer problema de optimización en R
- **Ejercicios prácticos**: 5 problemas para resolver

#### [Módulo 2: Algoritmos Genéticos - Básico](./modulo_2_geneticos_basico.R)
- Inspiración biológica: Evolución natural
- Componentes de un AG: población, cromosomas, genes
- Operadores genéticos: selección, cruce, mutación
- Implementación paso a paso desde cero
- **Ejercicios prácticos**: 8 problemas con dificultad incremental

### **NIVEL INTERMEDIO**

#### [Módulo 3: Algoritmos Genéticos - Avanzado](./modulo_3_geneticos_avanzado.R)
- Codificación binaria vs real
- Estrategias de selección avanzadas
- Tipos de cruce especializados
- Elitismo y presión selectiva
- Optimización multiobjetivo (NSGA-II)
- **Ejercicios prácticos**: 10 problemas complejos

#### [Módulo 4: PSO - Particle Swarm Optimization Básico](./modulo_4_pso_basico.R)
- Inspiración: Comportamiento de enjambres
- Conceptos: partículas, velocidad, posición
- Parámetros: inercia, cognición, social
- Implementación desde cero
- Visualización del movimiento de partículas
- **Ejercicios prácticos**: 7 problemas

### **NIVEL AVANZADO**

#### [Módulo 5: PSO - Avanzado](./modulo_5_pso_avanzado.R)
- Variantes de PSO: APSO, CPSO, HPSO
- PSO con restricciones
- PSO multiobjetivo
- Hibridación PSO + Algoritmos Genéticos
- Ajuste adaptativo de parámetros
- **Ejercicios prácticos**: 8 problemas avanzados

#### [Módulo 6: Casos Prácticos del Mundo Real](./modulo_6_casos_practicos.R)
- Optimización de carteras de inversión
- Diseño de redes neuronales
- Scheduling y planificación
- Optimización de rutas (TSP)
- Feature selection en Machine Learning
- Calibración de modelos
- **Proyectos finales**: 5 proyectos completos

### **RECURSOS ADICIONALES**

#### [Ejercicios para Practicar](./ejercicios_practica.R)
- 50+ ejercicios clasificados por dificultad
- Soluciones comentadas paso a paso
- Desafíos para aplicar lo aprendido

#### [Funciones Útiles y Biblioteca](./biblioteca_funciones.R)
- Funciones de benchmark clásicas
- Utilidades para visualización
- Plantillas reutilizables

---

## 🎯 Objetivos del Curso

Al finalizar este curso, podrás:

✅ Entender los fundamentos de la optimización metaheurística
✅ Implementar Algoritmos Genéticos desde cero en R
✅ Implementar PSO desde cero en R
✅ Aplicar estos algoritmos a problemas reales
✅ Ajustar parámetros para mejorar rendimiento
✅ Comparar y elegir el algoritmo adecuado
✅ Visualizar y analizar resultados
✅ Crear variantes personalizadas

---

## 📚 Requisitos Previos

### Conocimientos:
- R básico (variables, funciones, bucles)
- Conceptos matemáticos básicos
- (Opcional) Programación orientada a objetos

### Software:
```r
# Instalar paquetes necesarios
install.packages(c(
  "ggplot2",      # Visualización
  "GA",           # Paquete de algoritmos genéticos
  "pso",          # Paquete PSO
  "plotly",       # Gráficos interactivos
  "animation",    # Animaciones
  "parallel",     # Computación paralela
  "microbenchmark" # Benchmarking
))
```

---

## 🚀 Cómo Usar Este Curso

### Para Principiantes:
1. **Sigue el orden**: Comienza con Módulo 1
2. **Ejecuta cada línea**: Prueba el código en tu RStudio
3. **Haz los ejercicios**: No pases al siguiente módulo sin practicar
4. **Experimenta**: Cambia parámetros y observa qué pasa

### Para Nivel Intermedio:
1. Revisa Módulo 1 rápidamente
2. Enfócate en Módulos 3-4
3. Implementa las variantes avanzadas

### Para Nivel Avanzado:
1. Ve directo a Módulos 5-6
2. Estudia los casos prácticos
3. Crea tus propias implementaciones

---

## 💡 Metodología de Aprendizaje

Cada módulo incluye:

1. **📖 Teoría breve**: Conceptos explicados de forma simple
2. **💻 Código comentado**: Implementaciones paso a paso
3. **🎨 Visualizaciones**: Gráficos para entender el comportamiento
4. **🔬 Experimentos**: Pruebas con diferentes parámetros
5. **✏️ Ejercicios**: Problemas para que resuelvas
6. **✅ Soluciones**: Respuestas comentadas

---

## 📞 Estructura de Cada Módulo

```r
# ============================================
# SECCIÓN 1: TEORÍA
# ============================================
# Explicación conceptual

# ============================================
# SECCIÓN 2: IMPLEMENTACIÓN DESDE CERO
# ============================================
# Código paso a paso con comentarios detallados

# ============================================
# SECCIÓN 3: EJEMPLOS PRÁCTICOS
# ============================================
# Aplicaciones a problemas reales

# ============================================
# SECCIÓN 4: VISUALIZACIÓN
# ============================================
# Gráficos para entender el algoritmo

# ============================================
# SECCIÓN 5: EJERCICIOS
# ============================================
# Problemas para que practiques

# ============================================
# SECCIÓN 6: SOLUCIONES
# ============================================
# Respuestas comentadas
```

---

## 🎓 Certificación (Auto-evaluación)

Al final del curso:
- [ ] Puedo implementar un AG básico de memoria
- [ ] Puedo implementar PSO básico de memoria
- [ ] Entiendo cuándo usar cada algoritmo
- [ ] Puedo ajustar parámetros efectivamente
- [ ] He resuelto al menos 30 ejercicios
- [ ] He completado 3 proyectos finales

---

## 🌟 Comienza Ahora

**¡Abre el [Módulo 1: Fundamentos de Optimización](./modulo_1_fundamentos.R) y comienza tu viaje!**

---

## 📖 Referencias y Recursos Adicionales

- Kennedy, J., & Eberhart, R. (1995). "Particle swarm optimization"
- Holland, J. H. (1992). "Adaptation in natural and artificial systems"
- Deb, K. (2001). "Multi-objective optimization using evolutionary algorithms"
- Documentación del paquete `GA`: https://cran.r-project.org/package=GA
- Documentación del paquete `pso`: https://cran.r-project.org/package=pso

---

**¡Éxito en tu aprendizaje! 🚀**
