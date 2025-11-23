# 🚀 Guía de Inicio Rápido - Curso SPSS

## ¡Bienvenido al Curso Práctico de SPSS!

Esta guía te ayudará a comenzar rápidamente con el curso.

---

## 📦 Contenido del Curso

```
curso-spss/
├── README.md                    # Índice principal del curso
├── GUIA_INICIO_RAPIDO.md       # Este archivo
├── modulos/                     # 7 módulos teóricos
│   ├── modulo1_introduccion.md
│   ├── modulo2_estadistica_descriptiva.md
│   ├── modulo3_graficos.md
│   ├── modulo4_pruebas_hipotesis.md
│   ├── modulo5_correlacion_regresion.md
│   ├── modulo6_anova.md
│   └── modulo7_tecnicas_avanzadas.md
├── sintaxis/                    # Archivos de sintaxis .sps
│   ├── modulo1_ejemplos.sps
│   └── modulo2_estadistica_descriptiva.sps
├── datasets/                    # Conjuntos de datos CSV
│   ├── empleados.csv
│   └── estudiantes.csv
└── ejercicios/                  # Ejercicios prácticos
```

---

## 🎯 Ruta de Aprendizaje Recomendada

### Nivel Principiante (Semanas 1-2)

**Día 1-2: Módulo 1 - Introducción**
- [ ] Lee `modulos/modulo1_introduccion.md`
- [ ] Abre SPSS y familiarízate con la interfaz
- [ ] Ejecuta el archivo `sintaxis/modulo1_ejemplos.sps`
- [ ] Completa el Ejercicio Práctico 1 del módulo

**Día 3-4: Módulo 2 - Estadística Descriptiva**
- [ ] Lee `modulos/modulo2_estadistica_descriptiva.md`
- [ ] Importa `datasets/empleados.csv` en SPSS
- [ ] Ejecuta `sintaxis/modulo2_estadistica_descriptiva.sps`
- [ ] Realiza los ejercicios del módulo

**Día 5-7: Módulo 3 - Gráficos**
- [ ] Lee `modulos/modulo3_graficos.md`
- [ ] Crea al menos 5 tipos diferentes de gráficos
- [ ] Personaliza tus gráficos
- [ ] Exporta gráficos a diferentes formatos

### Nivel Intermedio (Semanas 3-4)

**Semana 3: Módulo 4 - Pruebas de Hipótesis**
- [ ] Lee `modulos/modulo4_pruebas_hipotesis.md`
- [ ] Practica pruebas t (una muestra, independiente, pareada)
- [ ] Realiza pruebas Chi-cuadrado
- [ ] Ejecuta pruebas no paramétricas

**Semana 4: Módulo 5 - Correlación y Regresión**
- [ ] Lee `modulos/modulo5_correlacion_regresion.md`
- [ ] Calcula correlaciones
- [ ] Construye modelos de regresión simple
- [ ] Construye modelos de regresión múltiple
- [ ] Verifica supuestos de regresión

### Nivel Avanzado (Semanas 5-6)

**Semana 5: Módulo 6 - ANOVA**
- [ ] Lee `modulos/modulo6_anova.md`
- [ ] Realiza ANOVA de un factor
- [ ] Ejecuta pruebas post-hoc
- [ ] Practica ANOVA factorial
- [ ] ANOVA de medidas repetidas

**Semana 6: Módulo 7 - Técnicas Avanzadas**
- [ ] Lee `modulos/modulo7_tecnicas_avanzadas.md`
- [ ] Análisis factorial
- [ ] Regresión logística
- [ ] Análisis de conglomerados
- [ ] Proyecto final integrador

---

## 💻 Cómo Usar los Archivos del Curso

### 1. Importar Datasets CSV en SPSS

**Opción A: Mediante la Interfaz**
1. File → Open → Data
2. Selecciona el archivo CSV
3. Verifica que la primera fila contenga nombres de variables
4. Haz clic en OK

**Opción B: Mediante Sintaxis**
```spss
GET DATA
  /TYPE=TXT
  /FILE='C:/ruta/a/datasets/empleados.csv'
  /DELCASE=LINE
  /DELIMITERS=","
  /FIRSTCASE=2
  /DATATYPEMIN PERCENTAGE=95.0
  /VARIABLES=
    empleado_id F4.0
    nombre A25
    departamento F1.0
    genero F1.0
    edad F2.0
    antiguedad F2.0
    salario_mensual F7.2
    nivel_educativo F1.0
    satisfaccion F3.1
    productividad F5.2.
EXECUTE.
```

### 2. Ejecutar Archivos de Sintaxis (.sps)

1. Abre el archivo .sps en SPSS
2. Selecciona todo el código (Ctrl+A)
3. Haz clic en Run → All (o presiona Ctrl+A y luego Ctrl+R)
4. Revisa los resultados en la ventana de Output

### 3. Guardar tu Trabajo

**Guardar datos:**
```spss
SAVE OUTFILE='C:/MisCursos/SPSS/mi_archivo.sav'.
```

**Guardar sintaxis:**
- File → Save As → tipo: Syntax (*.sps)

**Guardar resultados:**
- File → Export → PDF/Word/Excel

---

## 📚 Datasets Incluidos

### 1. empleados.csv
**50 registros de empleados**

Variables:
- `empleado_id`: ID único
- `nombre`: Nombre del empleado
- `departamento`: 1=Ventas, 2=Marketing, 3=IT, 4=RRHH
- `genero`: 1=Hombre, 2=Mujer
- `edad`: Edad en años
- `antiguedad`: Años en la empresa
- `salario_mensual`: Salario en EUR
- `nivel_educativo`: 1=Secundaria, 2=Universitario, 3=Posgrado
- `satisfaccion`: Escala 1-10
- `productividad`: Escala 0-100

**Análisis sugeridos:**
- Estadísticos descriptivos por departamento
- Comparar salarios entre géneros (t-test)
- Correlación entre antigüedad y salario
- Regresión: predecir productividad
- ANOVA: comparar salarios entre departamentos

### 2. estudiantes.csv
**50 registros de estudiantes**

Variables:
- `estudiante_id`: ID único
- `nombre`: Nombre del estudiante
- `edad`: Edad en años
- `genero`: 1=Hombre, 2=Mujer
- `facultad`: 1=Ciencias, 2=Humanidades, 3=Ingeniería, 4=Medicina
- `promedio`: Calificación promedio (0-10)
- `horas_estudio`: Horas semanales de estudio
- `asistencia`: Porcentaje de asistencia
- `beca`: 0=No, 1=Sí
- `satisfaccion`: Escala 1-10

**Análisis sugeridos:**
- Promedios por facultad
- Comparar rendimiento con/sin beca
- Correlación horas de estudio vs promedio
- Regresión múltiple prediciendo promedio
- ANOVA por facultad

---

## 🎓 Consejos para Aprender Efectivamente

### 1. Aprende Haciendo
- **No solo leas**: Ejecuta cada ejemplo en SPSS
- **Modifica ejemplos**: Cambia parámetros y observa qué pasa
- **Practica diariamente**: 30 minutos diarios es mejor que 3 horas una vez por semana

### 2. Documenta tu Aprendizaje
- **Crea tu propia sintaxis**: Copia ejemplos y añade comentarios
- **Guarda tus análisis**: Crea una carpeta de ejercicios resueltos
- **Toma notas**: Anota interpretaciones y hallazgos

### 3. Verifica tu Comprensión
- **Explica con tus palabras**: Si puedes explicarlo, lo entiendes
- **Haz todos los ejercicios**: No te saltes ninguno
- **Compara resultados**: Verifica que tus resultados coincidan con lo esperado

### 4. Usa Recursos Adicionales
- **IBM SPSS Documentation**: Documentación oficial
- **Foros y comunidades**: Stack Overflow, ResearchGate
- **Videos complementarios**: YouTube tiene excelentes tutoriales

---

## 🔧 Comandos Más Usados (Cheat Sheet)

### Importar/Exportar
```spss
GET DATA /TYPE=TXT /FILE='archivo.csv'.
SAVE OUTFILE='archivo.sav'.
EXPORT /CSV.
```

### Descriptivos
```spss
DESCRIPTIVES VARIABLES=var1 var2.
FREQUENCIES VARIABLES=var1.
EXAMINE VARIABLES=var1 BY grupo.
```

### Gráficos
```spss
GRAPH /HISTOGRAM=var1.
GRAPH /BOXPLOT=var1 BY grupo.
GRAPH /SCATTERPLOT=var1 WITH var2.
```

### Transformaciones
```spss
COMPUTE nueva_var = var1 + var2.
RECODE var1 (1 THRU 5=1) (6 THRU 10=2) INTO var_cat.
IF (condicion) nueva_var = valor.
```

### Inferencia
```spss
T-TEST /TESTVAL=50 /VARIABLES=var1.
T-TEST GROUPS=grupo(1 2) /VARIABLES=var1.
CORRELATIONS /VARIABLES=var1 var2.
REGRESSION /DEPENDENT=y /METHOD=ENTER x1 x2.
ONEWAY var1 BY grupo /POSTHOC=TUKEY.
```

---

## 🚨 Errores Comunes y Soluciones

### Error 1: "Variable no definida"
**Causa**: Intentas usar una variable que no existe
**Solución**: Verifica el nombre exacto en Vista de Variables

### Error 2: "End of file"
**Causa**: Falta un punto (.) al final del comando
**Solución**: Asegúrate de que cada comando termine con punto

### Error 3: "Invalid syntax"
**Causa**: Error de escritura en el comando
**Solución**: Revisa la sintaxis exacta en los ejemplos

### Error 4: Resultados extraños
**Causa**: Datos mal codificados o valores perdidos
**Solución**: Usa FREQUENCIES para verificar tus datos

### Error 5: Gráficos no aparecen
**Causa**: Ventana de Output cerrada
**Solución**: Ve a Window → Output para ver resultados

---

## 📞 ¿Necesitas Ayuda?

### Durante el Curso:
1. **Revisa el módulo correspondiente**: La respuesta suele estar ahí
2. **Busca en la documentación de SPSS**: IBM SPSS tiene excelente documentación
3. **Consulta foros**: Muchos problemas ya fueron resueltos por otros

### Recursos Útiles:
- **IBM SPSS Tutorials**: www.ibm.com/spss/tutorials
- **Statistics Solutions**: www.statisticssolutions.com
- **Cross Validated**: stats.stackexchange.com

---

## ✅ Checklist de Preparación

Antes de empezar, asegúrate de tener:

- [ ] SPSS Statistics instalado (versión 20+)
- [ ] Todos los archivos del curso descargados
- [ ] Carpeta de trabajo organizada
- [ ] Editor de texto para notas (opcional)
- [ ] Tiempo dedicado (mínimo 30 min/día)
- [ ] Motivación para aprender 😊

---

## 🎯 Tu Primer Día con SPSS

### Ejercicio Inicial (15 minutos)

1. **Abre SPSS**
2. **Importa empleados.csv**
3. **Ejecuta estos comandos:**

```spss
* Mi primer análisis en SPSS.

* Descriptivos básicos.
DESCRIPTIVES VARIABLES=edad salario_mensual.

* Tabla de frecuencias.
FREQUENCIES VARIABLES=departamento.

* Gráfico simple.
GRAPH /HISTOGRAM=salario_mensual.

* Estadísticos por grupo.
MEANS TABLES=salario_mensual BY departamento
  /CELLS=MEAN STDDEV COUNT.
```

4. **Interpreta los resultados** que aparecen en la ventana Output

**¡Felicidades! Has completado tu primer análisis en SPSS** 🎉

---

## 📅 Plan de Estudio Sugerido

### Plan Intensivo (2 semanas)
- **Lunes-Miércoles**: Módulos 1-3
- **Jueves-Viernes**: Módulo 4
- **Sábado-Domingo**: Módulo 5
- **Semana 2 - Lunes-Miércoles**: Módulo 6
- **Semana 2 - Jueves-Domingo**: Módulo 7 + Proyecto Final

### Plan Regular (6 semanas)
- **Semana 1**: Módulo 1 + práctica
- **Semana 2**: Módulo 2 + práctica
- **Semana 3**: Módulo 3 + práctica
- **Semana 4**: Módulos 4-5
- **Semana 5**: Módulo 6
- **Semana 6**: Módulo 7 + Proyecto Final

### Plan Relajado (12 semanas)
- **Semanas 1-2**: Módulo 1
- **Semanas 3-4**: Módulo 2
- **Semanas 5-6**: Módulo 3
- **Semanas 7-8**: Módulos 4-5
- **Semanas 9-10**: Módulo 6
- **Semanas 11-12**: Módulo 7 + Proyecto Final

---

## 🎖️ Certificación Personal

Al completar el curso, habrás:
- ✅ Dominado la sintaxis de SPSS
- ✅ Realizado análisis descriptivos completos
- ✅ Aplicado pruebas de hipótesis
- ✅ Construido modelos de regresión
- ✅ Ejecutado ANOVAs complejos
- ✅ Implementado técnicas multivariantes
- ✅ Completado un proyecto integrador

**Documenta tu progreso** y crea tu portafolio de análisis estadísticos.

---

## 🚀 ¡Comienza Ahora!

**Tu siguiente paso:**
1. Abre `modulos/modulo1_introduccion.md`
2. Lee la introducción
3. Ejecuta tu primer análisis
4. ¡Disfruta aprendiendo SPSS!

---

**¡Éxito en tu aprendizaje!** 📊✨

Si tienes preguntas, recuerda que la práctica constante es la clave del dominio.
