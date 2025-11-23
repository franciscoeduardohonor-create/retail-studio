# 🚀 INICIO RÁPIDO - Curso de Estadística con R

## ⚡ Empezar en 5 Minutos

### 1️⃣ Abre RStudio

Si aún no tienes RStudio instalado:
- Descarga R: https://cran.r-project.org/
- Descarga RStudio: https://posit.co/download/rstudio-desktop/

### 2️⃣ Configura tu Directorio de Trabajo

```r
# En RStudio, ve a Session > Set Working Directory > Choose Directory
# O usa este comando (cambia la ruta):
setwd("ruta/completa/a/curso-r-estadistica")

# Verifica que estás en el lugar correcto:
getwd()
```

### 3️⃣ Instala Paquetes Necesarios (Solo una vez)

```r
# Copia y pega esto en la consola de RStudio:
install.packages("tidyverse")
install.packages("car")
install.packages("pROC")
```

**Nota**: Este proceso puede tomar 5-10 minutos. ¡Ten paciencia!

### 4️⃣ Genera los Datasets de Práctica

```r
# Ejecuta este script para crear los archivos CSV:
source("datasets/generar_datasets.R")
```

Verás mensajes como:
```
✓ Dataset 1 creado: ventas_tienda.csv
✓ Dataset 2 creado: estudiantes.csv
...
```

### 5️⃣ ¡Abre Tu Primera Lección!

```r
# Abre la primera lección en el editor:
file.edit("modulo1-fundamentos/leccion1_introduccion.R")
```

---

## 📝 Cómo Ejecutar el Código

### Método 1: Línea por Línea (Recomendado para Principiantes)
1. Coloca el cursor en la línea que quieres ejecutar
2. Presiona **Ctrl + Enter** (Windows/Linux) o **Cmd + Enter** (Mac)
3. La línea se ejecutará y el cursor se moverá a la siguiente

### Método 2: Seleccionar y Ejecutar
1. Selecciona el código que quieres ejecutar
2. Presiona **Ctrl + Enter** (Windows/Linux) o **Cmd + Enter** (Mac)
3. Todo el código seleccionado se ejecutará

### Método 3: Ejecutar Todo el Script
1. Presiona **Ctrl + Shift + S** (Windows/Linux) o **Cmd + Shift + S** (Mac)
2. Todo el archivo se ejecutará de principio a fin

---

## 🎯 Tu Primera Sesión (30 Minutos)

### Ejercicio Práctico - Analiza Ventas

```r
# 1. Carga los datos de ventas
ventas <- read.csv("datasets/datos_csv/ventas_tienda.csv")

# 2. Mira las primeras filas
head(ventas)

# 3. Resumen estadístico
summary(ventas)

# 4. ¿Cuántas ventas hay?
nrow(ventas)

# 5. ¿Cuál es la venta promedio?
mean(ventas$venta_total)

# 6. ¿Cuál fue la venta más grande?
max(ventas$venta_total)

# 7. Ventas por vendedor
table(ventas$vendedor)

# 8. Gráfico simple de barras
barplot(table(ventas$categoria),
        main = "Ventas por Categoría",
        col = "steelblue")
```

¡Si pudiste ejecutar este código, estás listo para el curso! 🎉

---

## 🗺️ Ruta de Aprendizaje (12 Semanas)

### Semanas 1-2: Fundamentos
- ✅ Lección 1: Introducción a R
- ✅ Lección 2: Vectores
- ✅ Lección 3: Matrices y Data Frames
- 🎯 **Meta**: Sentirte cómodo con sintaxis básica de R

### Semanas 3-4: Manipulación de Datos
- ✅ Lección 1: dplyr básico
- ✅ Lección 2: tidyr y reestructuración
- 🎯 **Meta**: Limpiar y transformar cualquier dataset

### Semanas 5-6: Visualización
- ✅ Lección 1: ggplot2 fundamentos
- 🎯 **Meta**: Crear gráficos profesionales

### Semanas 7-9: Estadística
- ✅ Lección 1: Estadística descriptiva
- ✅ Lección 2: Estadística inferencial
- 🎯 **Meta**: Realizar análisis estadísticos completos

### Semanas 10-12: Modelos Avanzados
- ✅ Lección 1: Regresión lineal
- ✅ Lección 2: Regresión logística
- 🎯 **Meta**: Construir modelos predictivos

---

## 💡 Consejos de Estudio

### ✅ HAZ
- Ejecuta cada línea de código
- Completa todos los ejercicios
- Experimenta modificando el código
- Practica con los datasets incluidos
- Toma notas de lo que aprendes

### ❌ NO HAGAS
- No copies/pegues sin entender
- No te saltes ejercicios
- No pases a la siguiente lección sin dominar la actual
- No memorices, entiende la lógica

---

## 🆘 Resolución de Problemas Comunes

### Problema: "Error: could not find function"
**Solución**: Carga la librería necesaria
```r
library(dplyr)    # Para funciones de dplyr
library(ggplot2)  # Para gráficos
library(tidyr)    # Para reestructuración
```

### Problema: "Error in file(file, "rt"): cannot open the connection"
**Solución**: Verifica tu directorio de trabajo
```r
# Ver dónde estás:
getwd()

# Cambiar al directorio correcto:
setwd("ruta/correcta/curso-r-estadistica")
```

### Problema: "object not found"
**Solución**: Asegúrate de haber ejecutado las líneas anteriores que crean ese objeto
```r
# Primero debes crear el objeto:
x <- 5

# Luego puedes usarlo:
print(x)
```

### Problema: Los gráficos no se ven
**Solución**: Verifica que el panel "Plots" esté visible en RStudio
- En RStudio: View > Panes > Show All Panes

---

## 📚 Estructura de una Lección

Cada lección tiene esta estructura:

```
1. ENCABEZADO
   - Título y objetivos

2. CONTENIDO
   - Explicaciones detalladas
   - Ejemplos comentados

3. EJERCICIOS
   - Espacios para practicar
   - Marcados con "# Tu código aquí:"

4. EJEMPLO PRÁCTICO
   - Caso de uso real completo

5. RESUMEN
   - Conceptos clave cubiertos
```

---

## 🎓 Certificado de Finalización

Al completar el curso, habrás:

✅ Ejecutado más de **2,000 líneas de código**
✅ Completado más de **50 ejercicios prácticos**
✅ Analizado **7 datasets diferentes**
✅ Creado **docenas de gráficos**
✅ Construido **modelos estadísticos**

---

## 📞 Siguiente Paso

```r
# ¡Abre tu primera lección AHORA!
file.edit("modulo1-fundamentos/leccion1_introduccion.R")
```

**¡El mejor momento para empezar es ahora!** 🚀

---

## 🌟 Motivación

> "La mejor forma de aprender a programar es programando."

- No necesitas entender todo de inmediato
- Está bien cometer errores (así se aprende)
- La práctica constante es más importante que la intensidad
- Cada línea de código que escribas te hace mejor

**¡Tú puedes hacerlo!** 💪

---

¿Listo? ¡Comienza con la Lección 1! 📊✨
