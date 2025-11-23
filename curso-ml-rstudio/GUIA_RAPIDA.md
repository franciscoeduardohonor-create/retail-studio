# 🚀 Guía Rápida de Inicio

## ¿Por dónde empezar?

### Para Principiantes Absolutos (Sin experiencia en programación)

**Semanas 1-2: Fundamentos**
```r
# 1. Abre RStudio
# 2. Instala los paquetes necesarios (copia esto en la consola):
install.packages(c("tidyverse", "caret", "randomForest"))

# 3. Comienza con el Módulo 1
# Abre y ejecuta línea por línea:
```

**Ruta de aprendizaje:**
1. `modulo1-fundamentos/leccion1-introduccion.R` (2-3 horas)
2. `modulo1-fundamentos/leccion2-estructuras-datos.R` (3-4 horas)
3. `modulo1-fundamentos/leccion3-control-flujo.R` (3-4 horas)
4. `modulo2-datos/leccion1-manipulacion-dplyr.R` (4-5 horas)
5. `modulo2-datos/leccion2-visualizacion-ggplot2.R` (5-6 horas)

**Dedica:** 1-2 meses en esta fase

---

### Para Usuarios con Experiencia en R

**Empieza aquí:**
```r
# Refresca conceptos si es necesario
modulo2-datos/leccion1-manipulacion-dplyr.R

# Luego directo a Machine Learning
modulo4-supervisado/leccion1-regresion-lineal.R
```

**Ruta de aprendizaje:**
1. Módulo 4 completo (Algoritmos supervisados)
2. Proyectos prácticos
3. Módulo 5 (Algoritmos no supervisados)
4. Módulo 6 (Avanzado)

**Dedica:** 2-3 semanas

---

### Para Expertos en ML que Aprenden R

**Empieza aquí:**
```r
# Aprende sintaxis de R rápidamente
modulo1-fundamentos/leccion1-introduccion.R (1 hora, lectura rápida)

# Aprende manipulación de datos en R
modulo2-datos/leccion1-manipulacion-dplyr.R

# Implementaciones de algoritmos
modulo4-supervisado/leccion1-regresion-lineal.R
modulo4-supervisado/leccion3-random-forest.R
```

**Ruta de aprendizaje:**
- Enfócate en sintaxis y librerías de R
- Salta teoría de ML si ya la conoces
- Ve directo a proyectos prácticos

**Dedica:** 1 semana

---

## 📁 Estructura del Curso

```
curso-ml-rstudio/
│
├── modulo1-fundamentos/          # Fundamentos de R
│   ├── leccion1-introduccion.R           # Variables, vectores, operaciones
│   ├── leccion2-estructuras-datos.R      # Matrices, listas, data frames
│   └── leccion3-control-flujo.R          # if, for, funciones
│
├── modulo2-datos/                # Manipulación y Visualización
│   ├── leccion1-manipulacion-dplyr.R     # dplyr: filter, select, mutate
│   └── leccion2-visualizacion-ggplot2.R  # ggplot2: gráficos profesionales
│
├── modulo4-supervisado/          # Machine Learning Supervisado
│   ├── leccion1-regresion-lineal.R       # Primer algoritmo de ML
│   └── leccion3-random-forest.R          # Árboles y Random Forest
│
└── proyectos/                    # Proyectos Completos
    └── proyecto1-prediccion-ventas.R     # Proyecto end-to-end
```

---

## 💻 Cómo Usar los Archivos

### Opción 1: Ejecutar Línea por Línea (RECOMENDADO para aprender)

1. Abre el archivo `.R` en RStudio
2. Coloca el cursor en la primera línea
3. Presiona `Ctrl + Enter` (Windows/Linux) o `Cmd + Enter` (Mac)
4. Lee el resultado en la consola
5. Repite con cada línea

**Ventaja:** Entiendes cada paso

### Opción 2: Ejecutar Todo el Archivo

1. Abre el archivo `.R` en RStudio
2. Presiona `Ctrl + Shift + Enter` o haz clic en "Source"

**Ventaja:** Rápido para ver resultados

### Opción 3: Copiar y Experimentar

1. Copia el código que te interese
2. Pégalo en un nuevo script
3. Modifícalo y experimenta

**Ventaja:** Aprendizaje activo

---

## 🎯 Cómo Maximizar tu Aprendizaje

### ✅ DO (Hacer):
- ✓ Ejecuta CADA línea de código
- ✓ Modifica los ejemplos para ver qué pasa
- ✓ Haz TODOS los ejercicios
- ✓ Experimenta con tus propios datos
- ✓ Toma notas de conceptos difíciles
- ✓ Practica diariamente (30 min mínimo)

### ❌ DON'T (No hacer):
- ✗ Solo leer el código sin ejecutar
- ✗ Copiar y pegar sin entender
- ✗ Saltar ejercicios
- ✗ Avanzar sin dominar lo anterior
- ✗ Estudiar 8 horas un día y nada el resto de la semana

---

## 📚 Instalación de Paquetes

### Instalación Inicial

```r
# Copia y pega esto en la consola de RStudio
# Solo necesitas hacerlo UNA VEZ

install.packages(c(
  # Manipulación de datos
  "tidyverse", "dplyr", "tidyr", "readr",

  # Machine Learning
  "caret", "randomForest", "e1071",
  "rpart", "rpart.plot",

  # Visualización
  "ggplot2", "corrplot", "scales",

  # Utilidades
  "lubridate"
))
```

### Cargar Paquetes (Cada sesión)

```r
# Copia esto al inicio de cada sesión
library(tidyverse)
library(caret)
library(ggplot2)
```

---

## 🐛 Problemas Comunes y Soluciones

### Problema 1: "could not find function"

**Error:**
```r
Error in filter(...) : could not find function "filter"
```

**Solución:**
```r
library(dplyr)  # Cargar la librería primero
```

### Problema 2: "object not found"

**Error:**
```r
Error: object 'datos' not found
```

**Solución:**
- Ejecuta las líneas anteriores primero
- Las variables se crean en orden

### Problema 3: Paquete no instalado

**Error:**
```r
Error in library(caret) : there is no package called 'caret'
```

**Solución:**
```r
install.packages("caret")
```

### Problema 4: Error de sintaxis

**Error:**
```r
Error: unexpected ',' in "datos <- read_csv(,"
```

**Solución:**
- Revisa que copiaste todo el código
- Verifica paréntesis y comillas

---

## 📊 Datasets de Práctica

Cada lección incluye datasets generados automáticamente, pero también puedes usar:

### Datasets incluidos en R:
```r
# Ver datasets disponibles
data()

# Usar dataset Iris
data(iris)
head(iris)

# Otros datasets útiles
data(mtcars)  # Autos
data(airquality)  # Calidad del aire
data(diamonds)  # Requiere ggplot2
```

### Cargar tus propios datos:
```r
# CSV
datos <- read.csv("archivo.csv")

# Excel (requiere readxl)
library(readxl)
datos <- read_excel("archivo.xlsx")
```

---

## 🎓 Plan de Estudio Sugerido

### Plan Intensivo (4-6 semanas, tiempo completo)

**Semana 1:**
- Módulo 1 completo
- Práctica diaria: 4-6 horas

**Semana 2:**
- Módulo 2 completo
- Práctica diaria: 4-6 horas

**Semana 3-4:**
- Módulo 4 (Machine Learning)
- Práctica diaria: 6-8 horas

**Semana 5-6:**
- Proyectos prácticos
- Proyecto personal

### Plan Normal (3-4 meses, medio tiempo)

**Mes 1:**
- Módulo 1 y 2
- Práctica diaria: 1-2 horas

**Mes 2:**
- Módulo 4 (primeras lecciones)
- Práctica diaria: 1-2 horas

**Mes 3:**
- Módulo 4 (completar)
- Práctica diaria: 1-2 horas

**Mes 4:**
- Proyectos prácticos
- Portfolio personal

### Plan Relajado (6 meses, 30 min/día)

**Consistencia > Intensidad**
- 30 minutos diarios sin fallar
- Un módulo a la vez
- Repetir ejercicios hasta dominar

---

## 🏆 Certificado de Completación

### Para considerarte "graduado":

✅ Completar todos los módulos
✅ Hacer todos los ejercicios
✅ Completar al menos 2 proyectos
✅ Crear un proyecto personal con tus propios datos

### Proyecto Personal Sugerido:

Elige uno:
1. Predecir precios de algo que te interese
2. Clasificar datos de tu trabajo/escuela
3. Analizar datos de tu hobby
4. Resolver un problema real de tu comunidad

---

## 📞 Soporte y Recursos

### Si te atascas:

1. **Revisa los comentarios:** Cada línea está explicada
2. **Ejecuta línea por línea:** Identifica dónde falla
3. **Busca en Google:** "R [tu error]" + stackoverflow
4. **Experimenta:** Cambia valores y observa qué pasa

### Recursos Adicionales:

- [R Documentation](https://www.rdocumentation.org/)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/r)
- [RStudio Cheatsheets](https://www.rstudio.com/resources/cheatsheets/)
- [R for Data Science (libro gratuito)](https://r4ds.had.co.nz/)

---

## 🎯 Tu Primer Día

### Checklist:

```r
# 1. ¿Instalaste R y RStudio?
# Descarga: https://cran.r-project.org/
#          https://www.rstudio.com/products/rstudio/download/

# 2. Abre RStudio

# 3. Prueba ejecutar esto:
print("¡Hola, mundo del Machine Learning!")
2 + 2

# 4. Instala paquetes básicos:
install.packages("tidyverse")

# 5. Abre tu primera lección:
# File > Open File > modulo1-fundamentos/leccion1-introduccion.R

# 6. ¡Empieza a aprender! 🚀
```

---

## 💪 Mantén la Motivación

### Recuerda:

- **El error es aprendizaje:** Cada error te enseña algo
- **La práctica hace al maestro:** 30 min diarios > 8 horas una vez
- **No compares tu progreso:** Cada quien aprende a su ritmo
- **Celebra pequeños logros:** Completar una lección es un logro
- **Usa lo aprendido:** Aplica ML a problemas reales

### Hitos del Curso:

🎉 Primera línea de código ejecutada
🎉 Primer data frame creado
🎉 Primera visualización
🎉 Primer modelo de ML entrenado
🎉 Primera predicción correcta
🎉 Primer proyecto completado

---

## 🚀 ¡Estás Listo!

```r
# Tu viaje comienza aquí:
source("modulo1-fundamentos/leccion1-introduccion.R")
```

**¡Mucho éxito en tu aprendizaje de Machine Learning con R! 🎓📊🤖**

---

*Última actualización: Noviembre 2025*
