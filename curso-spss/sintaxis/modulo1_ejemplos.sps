* ================================================================.
* SINTAXIS DEL MÓDULO 1: INTRODUCCIÓN Y CONCEPTOS BÁSICOS
* Autor: Curso Práctico de SPSS
* Descripción: Ejemplos prácticos del Módulo 1
* ================================================================.

* ================================================================.
* EJEMPLO 1: CREAR DATASET DE ESTUDIANTES
* ================================================================.

NEW FILE.

DATA LIST FREE
  / estudiante_id (F3.0) nombre (A20) edad (F2.0)
    calificacion (F5.2) aprobado (F1.0).

BEGIN DATA
1 "Juan García" 20 8.5 1
2 "María López" 19 6.3 1
3 "Pedro Sánchez" 21 4.2 0
4 "Ana Martínez" 20 9.1 1
5 "Luis Rodríguez" 22 5.8 0
6 "Carmen Fernández" 19 7.8 1
7 "Jorge Díaz" 20 3.9 0
8 "Laura Morales" 21 8.2 1
9 "Miguel Torres" 19 6.5 1
10 "Elena Ruiz" 20 9.5 1
END DATA.

VARIABLE LABELS
  estudiante_id 'ID del Estudiante'
  nombre 'Nombre Completo'
  edad 'Edad en años'
  calificacion 'Calificación Final'
  aprobado 'Estado de Aprobación'.

VALUE LABELS
  aprobado 0 'No Aprobado' 1 'Aprobado'.

VARIABLE LEVEL
  estudiante_id (NOMINAL)
  edad (SCALE)
  calificacion (SCALE)
  aprobado (NOMINAL).

* Mostrar los datos.
LIST.

* ================================================================.
* EJEMPLO 2: CREAR VARIABLES CALCULADAS
* ================================================================.

* Crear variable: nota sobre 100.
COMPUTE nota_100 = calificacion * 10.
VARIABLE LABELS nota_100 'Calificación sobre 100'.

* Crear categoría de rendimiento.
RECODE calificacion
  (LOWEST THRU 5 = 1)
  (5 THRU 7 = 2)
  (7 THRU 9 = 3)
  (9 THRU HIGHEST = 4)
  INTO rendimiento.

VARIABLE LABELS rendimiento 'Nivel de Rendimiento'.
VALUE LABELS rendimiento
  1 'Insuficiente'
  2 'Suficiente'
  3 'Notable'
  4 'Sobresaliente'.

* Crear indicador de estudiante destacado.
IF (calificacion >= 9.0) estudiante_destacado = 1.
IF (calificacion < 9.0) estudiante_destacado = 0.

VARIABLE LABELS estudiante_destacado 'Estudiante Destacado'.
VALUE LABELS estudiante_destacado
  0 'No'
  1 'Sí'.

EXECUTE.

* Mostrar resultados.
LIST estudiante_id nombre calificacion rendimiento estudiante_destacado.

* ================================================================.
* EJEMPLO 3: DATASET DE EMPLEADOS (MÁS COMPLETO)
* ================================================================.

NEW FILE.

DATA LIST FREE
  / empleado_id (F4.0) nombre (A25) departamento (F1.0)
    salario_mensual (F7.2) antiguedad (F2.0) genero (F1.0).

BEGIN DATA
1001 "Carlos Gómez" 1 2500.00 8 1
1002 "Laura Jiménez" 2 3200.00 5 2
1003 "Roberto Álvarez" 3 2800.00 3 1
1004 "Patricia Soto" 4 3500.00 10 2
1005 "Fernando Cruz" 1 2300.00 2 1
1006 "Isabel Romero" 2 3800.00 7 2
1007 "Andrés Navarro" 1 2600.00 6 1
1008 "Mónica Herrera" 3 2900.00 4 2
1009 "Javier Medina" 4 3300.00 9 1
1010 "Cristina Vega" 2 3600.00 11 2
1011 "Ricardo Pascual" 1 2400.00 1 1
1012 "Beatriz Castro" 3 2700.00 5 2
1013 "Manuel Ortiz" 4 3400.00 8 1
1014 "Rosa Ramírez" 2 3100.00 6 2
1015 "Pablo Guerrero" 1 2550.00 4 1
END DATA.

VARIABLE LABELS
  empleado_id 'ID del Empleado'
  nombre 'Nombre Completo'
  departamento 'Departamento'
  salario_mensual 'Salario Mensual (EUR)'
  antiguedad 'Años de Antigüedad'
  genero 'Género'.

VALUE LABELS
  departamento 1 'Ventas' 2 'IT' 3 'RRHH' 4 'Finanzas'
  /genero 1 'Masculino' 2 'Femenino'.

VARIABLE LEVEL
  empleado_id (NOMINAL)
  departamento (NOMINAL)
  salario_mensual (SCALE)
  antiguedad (SCALE)
  genero (NOMINAL).

* Calcular salario anual.
COMPUTE salario_anual = salario_mensual * 12.
VARIABLE LABELS salario_anual 'Salario Anual (EUR)'.

* Calcular bono (10% si antigüedad > 5, 5% si no).
IF (antiguedad > 5) bono = salario_anual * 0.10.
IF (antiguedad <= 5) bono = salario_anual * 0.05.
VARIABLE LABELS bono 'Bono Anual (EUR)'.

* Calcular compensación total.
COMPUTE compensacion_total = salario_anual + bono.
VARIABLE LABELS compensacion_total 'Compensación Total Anual (EUR)'.

* Clasificar salarios en rangos.
RECODE salario_mensual
  (LOWEST THRU 2500 = 1)
  (2500 THRU 3000 = 2)
  (3000 THRU HIGHEST = 3)
  INTO rango_salarial.

VARIABLE LABELS rango_salarial 'Rango Salarial'.
VALUE LABELS rango_salarial
  1 'Bajo'
  2 'Medio'
  3 'Alto'.

* Identificar empleados senior.
IF (antiguedad >= 8) empleado_senior = 1.
IF (antiguedad < 8) empleado_senior = 0.

VARIABLE LABELS empleado_senior 'Empleado Senior'.
VALUE LABELS empleado_senior
  0 'No'
  1 'Sí'.

EXECUTE.

* Mostrar resumen.
LIST empleado_id nombre departamento salario_mensual antiguedad
     salario_anual bono compensacion_total rango_salarial empleado_senior.

* ================================================================.
* EJEMPLO 4: FUNCIONES ÚTILES
* ================================================================.

* Agregar algunas variables calculadas interesantes.

* Promedio de salario del departamento (se calculará en análisis).
SORT CASES BY departamento.

* Crear ID único combinado.
STRING id_unico (A30).
COMPUTE id_unico = CONCAT('EMP-', STRING(empleado_id, F4.0)).
VARIABLE LABELS id_unico 'ID Único del Empleado'.

* Calcular percentil de salario (relativo).
RANK VARIABLES=salario_mensual (A)
  /PERCENT
  /PRINT=YES
  /TIES=MEAN.

* Renombrar la variable de percentil.
RENAME VARIABLES (Psalario_mensual = percentil_salario).
VARIABLE LABELS percentil_salario 'Percentil de Salario'.

EXECUTE.

* Estadísticas rápidas.
DESCRIPTIVES VARIABLES=salario_mensual antiguedad salario_anual bono
  /STATISTICS=MEAN STDDEV MIN MAX.

* ================================================================.
* EJEMPLO 5: SELECCIÓN Y FILTRADO
* ================================================================.

* Seleccionar solo empleados del departamento de IT.
USE ALL.
COMPUTE filtro_it = (departamento = 2).
VARIABLE LABELS filtro_it 'Empleados de IT'.
VALUE LABELS filtro_it 0 'No' 1 'Sí'.
FILTER BY filtro_it.

* Mostrar solo empleados de IT.
FREQUENCIES VARIABLES=genero rango_salarial.

* Quitar filtro.
FILTER OFF.

* Seleccionar empleados con salario > 3000 y antigüedad > 5.
SELECT IF (salario_mensual > 3000 AND antiguedad > 5).

* Mostrar selección.
LIST.

* ================================================================.
* EJEMPLO 6: ORDENAR DATOS
* ================================================================.

* Restaurar todos los datos primero.
GET FILE='*'.

* Ordenar por departamento y luego por salario (descendente).
SORT CASES BY departamento (A) salario_mensual (D).

LIST departamento nombre salario_mensual.

* ================================================================.
* GUARDAR ARCHIVOS
* ================================================================.

* Guardar como archivo de SPSS.
* SAVE OUTFILE='C:/MisCursos/SPSS/empleados.sav'.

* Exportar a Excel.
* SAVE TRANSLATE OUTFILE='C:/MisCursos/SPSS/empleados.xlsx'
*   /TYPE=XLS
*   /VERSION=12
*   /MAP
*   /REPLACE
*   /FIELDNAMES
*   /CELLS=VALUES.

* Exportar a CSV.
* SAVE TRANSLATE OUTFILE='C:/MisCursos/SPSS/empleados.csv'
*   /TYPE=CSV
*   /ENCODING='UTF8'
*   /MAP
*   /REPLACE
*   /FIELDNAMES
*   /CELLS=VALUES.

* ================================================================.
* FIN DE LA SINTAXIS DEL MÓDULO 1
* ================================================================.
