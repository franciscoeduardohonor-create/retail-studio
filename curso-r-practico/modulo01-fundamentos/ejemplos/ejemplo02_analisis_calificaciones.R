# ============================================================================
# EJEMPLO PRÁCTICO 2: ANÁLISIS DE CALIFICACIONES
# ============================================================================
# Analiza las calificaciones de un estudiante durante un semestre

# Paso 1: Calificaciones en diferentes materias (escala 0-100)
matematicas <- c(85, 90, 88, 92, 87)      # 5 exámenes
fisica <- c(78, 82, 80, 85, 88)
programacion <- c(95, 92, 98, 96, 94)
ingles <- c(70, 75, 72, 78, 80)
historia <- c(88, 85, 90, 87, 89)

# Paso 2: Calcular promedios por materia
promedio_mat <- mean(matematicas)
promedio_fis <- mean(fisica)
promedio_prog <- mean(programacion)
promedio_ing <- mean(ingles)
promedio_hist <- mean(historia)

print("=== PROMEDIOS POR MATERIA ===")
print(paste("Matemáticas:", round(promedio_mat, 2)))
print(paste("Física:", round(promedio_fis, 2)))
print(paste("Programación:", round(promedio_prog, 2)))
print(paste("Inglés:", round(promedio_ing, 2)))
print(paste("Historia:", round(promedio_hist, 2)))

# Paso 3: Calcular el promedio general
todos_promedios <- c(promedio_mat, promedio_fis, promedio_prog,
                     promedio_ing, promedio_hist)
promedio_general <- mean(todos_promedios)

print(paste("\nPromedio General:", round(promedio_general, 2)))

# Paso 4: Identificar mejor y peor materia
nombres_materias <- c("Matemáticas", "Física", "Programación",
                      "Inglés", "Historia")

mejor_materia <- nombres_materias[which.max(todos_promedios)]
peor_materia <- nombres_materias[which.min(todos_promedios)]

print(paste("Mejor materia:", mejor_materia, "con",
            round(max(todos_promedios), 2)))
print(paste("Materia a reforzar:", peor_materia, "con",
            round(min(todos_promedios), 2)))

# Paso 5: Análisis de mejora en cada materia
print("\n=== ANÁLISIS DE PROGRESO ===")

# Matemáticas: comparar primer y último examen
mejora_mat <- matematicas[5] - matematicas[1]
print(paste("Matemáticas - Cambio:", mejora_mat, "puntos"))

# Física
mejora_fis <- fisica[5] - fisica[1]
print(paste("Física - Cambio:", mejora_fis, "puntos"))

# Programación
mejora_prog <- programacion[5] - programacion[1]
print(paste("Programación - Cambio:", mejora_prog, "puntos"))

# Inglés
mejora_ing <- ingles[5] - ingles[1]
print(paste("Inglés - Cambio:", mejora_ing, "puntos"))

# Historia
mejora_hist <- historia[5] - historia[1]
print(paste("Historia - Cambio:", mejora_hist, "puntos"))

# Paso 6: Calcular variabilidad (consistencia)
print("\n=== CONSISTENCIA EN CALIFICACIONES ===")
print(paste("Matemáticas - Desv. Est.:", round(sd(matematicas), 2)))
print(paste("Física - Desv. Est.:", round(sd(fisica), 2)))
print(paste("Programación - Desv. Est.:", round(sd(programacion), 2)))
print(paste("Inglés - Desv. Est.:", round(sd(ingles), 2)))
print(paste("Historia - Desv. Est.:", round(sd(historia), 2)))
print("(Menor desviación = más consistente)")

# Paso 7: Evaluación final
print("\n=== EVALUACIÓN FINAL ===")
if (promedio_general >= 90) {
  print("¡Excelente rendimiento! Honor Roll")
} else if (promedio_general >= 80) {
  print("Buen rendimiento. Sigue así!")
} else if (promedio_general >= 70) {
  print("Rendimiento aceptable. Hay margen de mejora")
} else {
  print("Se requiere más esfuerzo")
}

# Paso 8: Materias aprobadas (>=70)
materias_aprobadas <- sum(todos_promedios >= 70)
print(paste("Materias aprobadas:", materias_aprobadas, "de 5"))

# ============================================================================
# AHORA PRUÉBALO TÚ
# ============================================================================
# 1. Cambia las calificaciones con tus propios datos
# 2. Agrega más exámenes a cada materia
# 3. Agrega nuevas materias
# 4. Calcula cuánto necesitas en el próximo examen para tener promedio de 90
# 5. Identifica en qué materias tuviste más mejora
