# Datasets del Curso SPSS

Este directorio contiene conjuntos de datos en formato CSV listos para importar en SPSS.

---

## 📊 Datasets Disponibles

### 1. empleados.csv

**Descripción**: Datos de 50 empleados de una empresa ficticia.

**Variables y Etiquetas:**

| Variable | Tipo | Descripción | Valores/Etiquetas |
|----------|------|-------------|-------------------|
| `empleado_id` | Numérica | ID único del empleado | 1001-1050 |
| `nombre` | Cadena | Nombre completo | Texto |
| `departamento` | Categórica | Departamento | 1=Ventas, 2=Marketing, 3=IT, 4=RRHH |
| `genero` | Categórica | Género | 1=Hombre, 2=Mujer |
| `edad` | Numérica | Edad en años | 25-46 |
| `antiguedad` | Numérica | Años en la empresa | 1-16 |
| `salario_mensual` | Numérica | Salario mensual en EUR | 2300-3800 |
| `nivel_educativo` | Categórica | Nivel de estudios | 2=Universitario, 3=Posgrado |
| `satisfaccion` | Escala | Satisfacción laboral | 1-10 (continua) |
| `productividad` | Escala | Índice de productividad | 0-100 (continua) |

**Sintaxis para Asignar Etiquetas:**
```spss
VALUE LABELS
  departamento
    1 'Ventas'
    2 'Marketing'
    3 'IT'
    4 'RRHH'
  /genero
    1 'Hombre'
    2 'Mujer'
  /nivel_educativo
    1 'Secundaria'
    2 'Universitario'
    3 'Posgrado'.

VARIABLE LABELS
  empleado_id 'ID del Empleado'
  nombre 'Nombre Completo'
  departamento 'Departamento'
  genero 'Género'
  edad 'Edad (años)'
  antiguedad 'Años de Antigüedad'
  salario_mensual 'Salario Mensual (EUR)'
  nivel_educativo 'Nivel Educativo'
  satisfaccion 'Satisfacción Laboral (1-10)'
  productividad 'Productividad (0-100)'.

VARIABLE LEVEL
  empleado_id (NOMINAL)
  departamento (NOMINAL)
  genero (NOMINAL)
  edad (SCALE)
  antiguedad (SCALE)
  salario_mensual (SCALE)
  nivel_educativo (ORDINAL)
  satisfaccion (SCALE)
  productividad (SCALE).
```

**Análisis Sugeridos:**
- Comparar salarios entre departamentos (ANOVA)
- Diferencias de género en salario (t-test independiente)
- Correlación antigüedad-salario
- Regresión: predecir productividad
- Análisis por grupos de edad

---

### 2. estudiantes.csv

**Descripción**: Datos de 50 estudiantes universitarios.

**Variables y Etiquetas:**

| Variable | Tipo | Descripción | Valores/Etiquetas |
|----------|------|-------------|-------------------|
| `estudiante_id` | Numérica | ID único del estudiante | 1-50 |
| `nombre` | Cadena | Nombre completo | Texto |
| `edad` | Numérica | Edad en años | 19-22 |
| `genero` | Categórica | Género | 1=Hombre, 2=Mujer |
| `facultad` | Categórica | Facultad | 1=Ciencias, 2=Humanidades, 3=Ingeniería, 4=Medicina |
| `promedio` | Escala | Calificación promedio | 0-10 (continua) |
| `horas_estudio` | Numérica | Horas semanales de estudio | 14-33 |
| `asistencia` | Escala | Porcentaje de asistencia | 80-99 |
| `beca` | Categórica | Tiene beca | 0=No, 1=Sí |
| `satisfaccion` | Escala | Satisfacción académica | 1-10 (continua) |

**Sintaxis para Asignar Etiquetas:**
```spss
VALUE LABELS
  genero
    1 'Hombre'
    2 'Mujer'
  /facultad
    1 'Ciencias'
    2 'Humanidades'
    3 'Ingeniería'
    4 'Medicina'
  /beca
    0 'No'
    1 'Sí'.

VARIABLE LABELS
  estudiante_id 'ID del Estudiante'
  nombre 'Nombre Completo'
  edad 'Edad (años)'
  genero 'Género'
  facultad 'Facultad'
  promedio 'Promedio General (0-10)'
  horas_estudio 'Horas de Estudio Semanales'
  asistencia 'Asistencia (%)'
  beca 'Tiene Beca'
  satisfaccion 'Satisfacción Académica (1-10)'.

VARIABLE LEVEL
  estudiante_id (NOMINAL)
  edad (SCALE)
  genero (NOMINAL)
  facultad (NOMINAL)
  promedio (SCALE)
  horas_estudio (SCALE)
  asistencia (SCALE)
  beca (NOMINAL)
  satisfaccion (SCALE).
```

**Análisis Sugeridos:**
- Comparar promedios entre facultades (ANOVA)
- Efecto de la beca en el rendimiento (t-test)
- Correlación horas de estudio vs promedio
- Regresión múltiple prediciendo promedio
- Tabla cruzada género × facultad

---

## 🔧 Cómo Importar los Datasets

### Método 1: Mediante la Interfaz

1. **Abrir SPSS**
2. **File → Open → Data**
3. **Cambiar tipo de archivo a "Text (*.txt, *.dat, *.csv)"**
4. **Seleccionar el archivo CSV**
5. **En el asistente de importación:**
   - ✅ Marcar "First case contains variable names"
   - Delimitador: Coma
   - Verificar que las variables se lean correctamente
6. **Finish**

### Método 2: Sintaxis para empleados.csv

```spss
* ================================================================.
* IMPORTAR EMPLEADOS.CSV.
* ================================================================.

GET DATA
  /TYPE=TXT
  /FILE='C:/ruta/a/curso-spss/datasets/empleados.csv'
  /DELCASE=LINE
  /DELIMITERS=","
  /QUALIFIER='"'
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /DATATYPEMIN PERCENTAGE=95.0
  /VARIABLES=
    empleado_id F4.0
    nombre A30
    departamento F1.0
    genero F1.0
    edad F2.0
    antiguedad F2.0
    salario_mensual F7.2
    nivel_educativo F1.0
    satisfaccion F3.1
    productividad F5.2.
CACHE.
EXECUTE.

* Asignar etiquetas.
VALUE LABELS
  departamento 1 'Ventas' 2 'Marketing' 3 'IT' 4 'RRHH'
  /genero 1 'Hombre' 2 'Mujer'
  /nivel_educativo 2 'Universitario' 3 'Posgrado'.

VARIABLE LABELS
  empleado_id 'ID del Empleado'
  nombre 'Nombre Completo'
  departamento 'Departamento'
  genero 'Género'
  edad 'Edad (años)'
  antiguedad 'Años de Antigüedad'
  salario_mensual 'Salario Mensual (EUR)'
  nivel_educativo 'Nivel Educativo'
  satisfaccion 'Satisfacción Laboral (1-10)'
  productividad 'Productividad (0-100)'.

VARIABLE LEVEL
  empleado_id (NOMINAL)
  departamento (NOMINAL)
  genero (NOMINAL)
  edad (SCALE)
  antiguedad (SCALE)
  salario_mensual (SCALE)
  nivel_educativo (ORDINAL)
  satisfaccion (SCALE)
  productividad (SCALE).

EXECUTE.
```

### Método 3: Sintaxis para estudiantes.csv

```spss
* ================================================================.
* IMPORTAR ESTUDIANTES.CSV.
* ================================================================.

GET DATA
  /TYPE=TXT
  /FILE='C:/ruta/a/curso-spss/datasets/estudiantes.csv'
  /DELCASE=LINE
  /DELIMITERS=","
  /QUALIFIER='"'
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /DATATYPEMIN PERCENTAGE=95.0
  /VARIABLES=
    estudiante_id F3.0
    nombre A30
    edad F2.0
    genero F1.0
    facultad F1.0
    promedio F4.2
    horas_estudio F4.1
    asistencia F3.0
    beca F1.0
    satisfaccion F3.1.
CACHE.
EXECUTE.

* Asignar etiquetas.
VALUE LABELS
  genero 1 'Hombre' 2 'Mujer'
  /facultad 1 'Ciencias' 2 'Humanidades' 3 'Ingeniería' 4 'Medicina'
  /beca 0 'No' 1 'Sí'.

VARIABLE LABELS
  estudiante_id 'ID del Estudiante'
  nombre 'Nombre Completo'
  edad 'Edad (años)'
  genero 'Género'
  facultad 'Facultad'
  promedio 'Promedio General (0-10)'
  horas_estudio 'Horas de Estudio Semanales'
  asistencia 'Asistencia (%)'
  beca 'Tiene Beca'
  satisfaccion 'Satisfacción Académica (1-10)'.

VARIABLE LEVEL
  estudiante_id (NOMINAL)
  edad (SCALE)
  genero (NOMINAL)
  facultad (NOMINAL)
  promedio (SCALE)
  horas_estudio (SCALE)
  asistencia (SCALE)
  beca (NOMINAL)
  satisfaccion (SCALE).

EXECUTE.
```

---

## 📈 Estadísticas Descriptivas de los Datasets

### empleados.csv

**Resumen:**
- N = 50 empleados
- 4 departamentos
- Distribución por género: aproximadamente 50/50
- Edad: 25-46 años (M ≈ 35)
- Salario: 2,300-3,800 EUR (M ≈ 3,000)
- Antigüedad: 1-16 años (M ≈ 7)

**Casos de uso:**
- Práctica de ANOVA (salarios entre departamentos)
- Práctica de t-test (diferencias de género)
- Práctica de correlación/regresión
- Tablas de contingencia

### estudiantes.csv

**Resumen:**
- N = 50 estudiantes
- 4 facultades
- Distribución por género: aproximadamente 50/50
- Edad: 19-22 años
- Promedio: 6.5-9.2 (M ≈ 8.0)
- 50% con beca

**Casos de uso:**
- Práctica de ANOVA (promedios entre facultades)
- Práctica de t-test (efecto de beca)
- Práctica de correlación (estudio vs calificación)
- Regresión múltiple

---

## 🎯 Ejercicios Sugeridos por Dataset

### Con empleados.csv

**Ejercicio 1: Análisis Descriptivo**
```spss
DESCRIPTIVES VARIABLES=edad antiguedad salario_mensual
                       satisfaccion productividad
  /STATISTICS=MEAN STDDEV MIN MAX.

FREQUENCIES VARIABLES=departamento genero nivel_educativo.
```

**Ejercicio 2: Comparaciones**
```spss
* ¿Hay diferencias salariales entre géneros?
T-TEST GROUPS=genero(1 2)
  /VARIABLES=salario_mensual.

* ¿Hay diferencias salariales entre departamentos?
ONEWAY salario_mensual BY departamento
  /POSTHOC=TUKEY.
```

**Ejercicio 3: Relaciones**
```spss
* Correlación antigüedad-salario.
CORRELATIONS /VARIABLES=antiguedad salario_mensual.

* Predecir productividad.
REGRESSION /DEPENDENT=productividad
           /METHOD=ENTER satisfaccion salario_mensual antiguedad.
```

### Con estudiantes.csv

**Ejercicio 1: Análisis Descriptivo**
```spss
MEANS TABLES=promedio horas_estudio asistencia satisfaccion BY facultad
  /CELLS=MEAN STDDEV COUNT.
```

**Ejercicio 2: Efecto de la Beca**
```spss
T-TEST GROUPS=beca(0 1)
  /VARIABLES=promedio horas_estudio satisfaccion.
```

**Ejercicio 3: Modelo Predictivo**
```spss
REGRESSION /DEPENDENT=promedio
           /METHOD=ENTER horas_estudio asistencia beca.
```

---

## 💾 Guardar Datasets como .sav

Después de importar y configurar etiquetas:

```spss
SAVE OUTFILE='C:/MisCursos/SPSS/empleados.sav'
  /COMPRESSED.

SAVE OUTFILE='C:/MisCursos/SPSS/estudiantes.sav'
  /COMPRESSED.
```

---

## ✅ Verificación de Importación

Después de importar, verifica:

```spss
* Ver primeros 10 casos.
LIST /CASES=FROM 1 TO 10.

* Resumen de variables.
DISPLAY DICTIONARY.

* Valores perdidos.
FREQUENCIES VARIABLES=ALL
  /FORMAT=NOTABLE
  /STATISTICS=NONE.
```

---

**¡Listo para analizar!** 🚀

Usa estos datasets para practicar todos los ejemplos del curso.
