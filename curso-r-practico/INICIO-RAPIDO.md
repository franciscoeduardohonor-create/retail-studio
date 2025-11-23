# 🚀 Guía de Inicio Rápido

## ¡Bienvenido al Curso de R!

Esta guía te ayudará a empezar en **5 minutos**.

---

## Paso 1: Instalar R y RStudio

### Instalar R
1. Ve a https://cran.r-project.org/
2. Descarga R para tu sistema operativo
3. Instala el programa

### Instalar RStudio
1. Ve a https://posit.co/download/rstudio-desktop/
2. Descarga RStudio Desktop (gratis)
3. Instala el programa

---

## Paso 2: Configurar RStudio

Abre RStudio y ejecuta esto en la consola:

```r
# Instalar paquetes necesarios
install.packages(c("ggplot2", "dplyr", "tidyr", "readr", "purrr", "magrittr"))
```

Espera a que se instalen (puede tomar unos minutos).

---

## Paso 3: Tu Primer Script

1. En RStudio: **File → New File → R Script**
2. Copia y pega este código:

```r
# Mi primer script en R
print("¡Hola, R!")

# Crear algunos datos
numeros <- c(1, 2, 3, 4, 5)
print(numeros)

# Calcular promedio
promedio <- mean(numeros)
print(paste("El promedio es:", promedio))

# Crear un gráfico simple
plot(numeros, type = "b", col = "blue",
     main = "Mi Primer Gráfico",
     xlab = "Posición", ylab = "Valor")
```

3. Guarda el archivo: **File → Save**
4. Ejecuta el código: **Ctrl+Shift+Enter** (o Cmd+Shift+Enter en Mac)

---

## Paso 4: Empezar el Curso

Abre el primer módulo:

```r
# Navega a la carpeta del curso
setwd("ruta/al/curso-r-practico")

# Abre el primer archivo
file.edit("modulo01-fundamentos/01-introduccion.R")
```

O simplemente abre el archivo manualmente en RStudio.

---

## Consejos Rápidos

### Atajos de Teclado Útiles
- **Ejecutar línea:** `Ctrl+Enter` (Cmd+Enter en Mac)
- **Ejecutar todo:** `Ctrl+Shift+Enter`
- **Comentar/descomentar:** `Ctrl+Shift+C`
- **Ver ayuda:** `F1` sobre una función

### Panel de RStudio
- **Arriba-Izquierda:** Tu código (editor)
- **Abajo-Izquierda:** Consola (donde se ejecuta)
- **Arriba-Derecha:** Objetos en memoria
- **Abajo-Derecha:** Gráficos, ayuda, archivos

### Primeros Comandos
```r
# Ver tu directorio actual
getwd()

# Listar objetos en memoria
ls()

# Limpiar consola
cat("\014")

# Ver ayuda
?mean
help(plot)
```

---

## Orden de Estudio

Sigue este orden:

1. **Módulo 1:** Fundamentos (2-3 horas)
2. **Módulo 2:** Estructuras de datos (3-4 horas)
3. **Módulo 3:** Programación (3-4 horas)
4. **Módulo 4:** Visualización (4-5 horas)
5. **Módulo 5:** Manipulación de datos (4-5 horas)
6. **Módulo 6:** Estadística (5-6 horas)
7. **Módulo 7:** Avanzado (5-6 horas)

---

## ¿Problemas?

### R no ejecuta el código
- Verifica que hayas seleccionado la línea correcta
- Revisa que no haya errores de sintaxis
- Lee el mensaje de error (¡es tu amigo!)

### No encuentro un paquete
```r
# Instálalo
install.packages("nombre_paquete")

# Cárgalo
library(nombre_paquete)
```

### Quiero empezar de nuevo
```r
# Limpiar todo de la memoria
rm(list = ls())

# Reiniciar sesión: Session → Restart R
```

---

## Recursos de Emergencia

- **Ayuda en R:** `?funcion` o `help(funcion)`
- **Ejemplos:** `example(funcion)`
- **Stack Overflow:** https://stackoverflow.com/questions/tagged/r
- **Google:** "R como hacer [lo que quieras]"

---

## 🎯 Tu Objetivo Hoy

Si es tu primer día:
1. ✅ Instala R y RStudio
2. ✅ Ejecuta tu primer script
3. ✅ Completa la primera sección del Módulo 1

---

## ¡Estás Listo!

Ahora ve al **README.md** para ver el contenido completo o directo a **modulo01-fundamentos/01-introduccion.R** para empezar.

**¡Disfruta el viaje! 🚀**
