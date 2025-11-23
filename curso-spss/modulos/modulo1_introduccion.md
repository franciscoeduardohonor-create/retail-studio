# Módulo 1: Introducción y Conceptos Básicos de SPSS

## 📋 Contenido
1. ¿Qué es SPSS?
2. Interfaz de SPSS
3. Tipos de variables
4. Creación y manipulación de datos
5. Importación y exportación de datos
6. Sintaxis básica

---

## 1. ¿Qué es SPSS?

**SPSS (Statistical Package for the Social Sciences)** es un software estadístico utilizado para:
- Análisis de datos cuantitativos
- Gestión de datos
- Generación de gráficos
- Análisis estadísticos complejos

### Ventajas de SPSS:
✅ Interfaz gráfica intuitiva
✅ Sintaxis potente para automatización
✅ Amplia gama de procedimientos estadísticos
✅ Excelente manejo de grandes bases de datos

---

## 2. Interfaz de SPSS

SPSS tiene **dos ventanas principales**:

### 2.1 Vista de Datos (Data View)
- Muestra los datos en formato de hoja de cálculo
- Filas = casos/observaciones
- Columnas = variables

### 2.2 Vista de Variables (Variable View)
- Define las propiedades de cada variable
- Permite configurar tipo, etiquetas, valores perdidos, etc.

---

## 3. Tipos de Variables en SPSS

### 3.1 Según el Tipo de Dato

| Tipo | Descripción | Ejemplo |
|------|-------------|---------|
| **Numérico** | Números con o sin decimales | 25, 3.14, -10 |
| **Cadena** | Texto alfanumérico | "Madrid", "A1B2" |
| **Fecha** | Fechas y horas | 01/01/2024 |

### 3.2 Según la Escala de Medición

| Escala | Descripción | Ejemplo |
|--------|-------------|---------|
| **Nominal** | Categorías sin orden | Sexo, ciudad, color |
| **Ordinal** | Categorías con orden | Nivel educativo, satisfacción |
| **Escala** | Numérica continua | Edad, peso, ingresos |

---

## 4. Propiedades de Variables

En la Vista de Variables, podemos configurar:

1. **Nombre**: Nombre de la variable (sin espacios)
2. **Tipo**: Numérico, cadena, fecha, etc.
3. **Anchura**: Número de caracteres
4. **Decimales**: Número de decimales
5. **Etiqueta**: Descripción completa de la variable
6. **Valores**: Etiquetas para valores numéricos
7. **Perdidos**: Definir valores perdidos
8. **Columnas**: Ancho de columna en vista de datos
9. **Alineación**: Izquierda, centro, derecha
10. **Medida**: Escala, ordinal, nominal
11. **Rol**: Input, target, both, none, partition, split

---

## 5. Sintaxis Básica de SPSS

La sintaxis de SPSS permite **automatizar y reproducir** análisis.

### 5.1 Estructura Básica

```spss
* Esto es un comentario.
* Los comandos terminan con un punto.

COMANDO subcomando
  /OPCIÓN1 = valor1
  /OPCIÓN2 = valor2.
```

### 5.2 Reglas Importantes

- Los comandos se escriben en MAYÚSCULAS (no obligatorio pero es convención)
- Cada comando termina con un **punto (.)**
- Los comentarios comienzan con **asterisco (*)**
- Las opciones se separan con **barras (/)**
- La sintaxis NO distingue mayúsculas/minúsculas

---

## 6. Ejemplos Prácticos

### Ejemplo 1: Crear un Dataset Simple

**Objetivo**: Crear una base de datos de estudiantes con sus calificaciones.

```spss
* ================================================.
* EJEMPLO 1: CREAR DATASET DE ESTUDIANTES.
* ================================================.

* Crear nuevo dataset.
NEW FILE.

* Definir variables.
DATA LIST FREE
  / estudiante_id (F3.0) nombre (A20) edad (F2.0)
    calificacion (F5.2) aprobado (F1.0).

* Ingresar datos.
BEGIN DATA
1 "Juan García" 20 8.5 1
2 "María López" 19 6.3 1
3 "Pedro Sánchez" 21 4.2 0
4 "Ana Martínez" 20 9.1 1
5 "Luis Rodríguez" 22 5.8 0
END DATA.

* Asignar etiquetas a variables.
VARIABLE LABELS
  estudiante_id 'ID del Estudiante'
  nombre 'Nombre Completo'
  edad 'Edad en años'
  calificacion 'Calificación Final'
  aprobado 'Estado de Aprobación'.

* Asignar etiquetas a valores.
VALUE LABELS
  aprobado 0 'No Aprobado' 1 'Aprobado'.

* Definir nivel de medición.
VARIABLE LEVEL
  estudiante_id (NOMINAL)
  edad (SCALE)
  calificacion (SCALE)
  aprobado (NOMINAL).

* Guardar dataset.
SAVE OUTFILE='C:/MisCursos/SPSS/estudiantes.sav'.

* Mostrar los datos.
LIST.
```

**Explicación línea por línea:**

1. `NEW FILE`: Crea un nuevo archivo de datos
2. `DATA LIST FREE`: Define la estructura de variables
   - `FREE` indica que los datos están separados por espacios
   - `(F3.0)` = Formato numérico, 3 dígitos, 0 decimales
   - `(A20)` = Formato alfanumérico, 20 caracteres
   - `(F5.2)` = Formato numérico, 5 dígitos totales, 2 decimales
3. `BEGIN DATA` y `END DATA`: Delimitan los datos ingresados
4. `VARIABLE LABELS`: Asigna descripciones a las variables
5. `VALUE LABELS`: Asigna etiquetas a valores específicos
6. `VARIABLE LEVEL`: Define el nivel de medición
7. `SAVE OUTFILE`: Guarda el archivo de datos
8. `LIST`: Muestra todos los casos

---

### Ejemplo 2: Importar Datos desde Excel

```spss
* ================================================.
* EJEMPLO 2: IMPORTAR DATOS DESDE EXCEL.
* ================================================.

* Importar archivo Excel.
GET DATA
  /TYPE=XLSX
  /FILE='C:/MisCursos/SPSS/datos_ventas.xlsx'
  /SHEET=name 'Ventas2024'
  /CELLRANGE=FULL
  /READNAMES=ON
  /DATATYPEMIN PERCENTAGE=95.0
  /HIDDEN IGNORE=YES.

* Ejecutar el comando.
EXECUTE.

* Verificar importación mostrando primeros 10 casos.
LIST /CASES=FROM 1 TO 10.
```

**Explicación:**
- `TYPE=XLSX`: Tipo de archivo (también puede ser XLS, CSV, etc.)
- `FILE`: Ruta completa del archivo
- `SHEET`: Nombre de la hoja de Excel
- `CELLRANGE=FULL`: Importar toda la hoja
- `READNAMES=ON`: Primera fila contiene nombres de variables
- `EXECUTE`: Ejecuta el comando de importación

---

### Ejemplo 3: Crear Variables Nuevas

```spss
* ================================================.
* EJEMPLO 3: CREAR Y TRANSFORMAR VARIABLES.
* ================================================.

* Supongamos que tenemos datos de ventas mensuales.

* Crear variable calculada: ventas anuales.
COMPUTE ventas_anuales = ventas_enero + ventas_febrero + ventas_marzo +
                         ventas_abril + ventas_mayo + ventas_junio +
                         ventas_julio + ventas_agosto + ventas_septiembre +
                         ventas_octubre + ventas_noviembre + ventas_diciembre.

* Etiquetar la nueva variable.
VARIABLE LABELS ventas_anuales 'Total de Ventas Anuales'.

* Crear variable categórica basada en condiciones.
RECODE ventas_anuales
  (LOWEST THRU 50000 = 1)
  (50000 THRU 100000 = 2)
  (100000 THRU HIGHEST = 3)
  INTO categoria_vendedor.

* Asignar etiquetas.
VARIABLE LABELS categoria_vendedor 'Categoría del Vendedor'.
VALUE LABELS categoria_vendedor
  1 'Bajo'
  2 'Medio'
  3 'Alto'.

* Crear variable condicional usando IF.
IF (ventas_anuales > 100000 AND antiguedad >= 5) vendedor_estrella = 1.
IF (ventas_anuales <= 100000 OR antiguedad < 5) vendedor_estrella = 0.

VALUE LABELS vendedor_estrella
  0 'No'
  1 'Sí'.

* Ejecutar transformaciones.
EXECUTE.
```

**Explicación:**
- `COMPUTE`: Crea una nueva variable mediante cálculos
- `RECODE ... INTO`: Recodifica valores en una nueva variable
- `IF`: Crea variable basada en condiciones lógicas
- Operadores: `AND`, `OR`, `>`, `<`, `>=`, `<=`, `=`

---

### Ejemplo 4: Seleccionar Casos

```spss
* ================================================.
* EJEMPLO 4: FILTRAR Y SELECCIONAR CASOS.
* ================================================.

* Seleccionar solo casos que cumplan una condición.
USE ALL.
COMPUTE filter_$ = (edad >= 18 AND edad <= 65).
VARIABLE LABELS filter_$ 'Edad entre 18 y 65 años'.
VALUE LABELS filter_$ 0 'No seleccionado' 1 'Seleccionado'.
FILTER BY filter_$.

* Alternativa: Seleccionar temporalmente.
SELECT IF (sexo = 1 AND ciudad = 'Madrid').

* Eliminar casos duplicados.
SORT CASES BY dni.
MATCH FILES
  /FILE=*
  /BY dni
  /FIRST=PrimaryLast
  /LAST=PrimaryLast.
SELECT IF (PrimaryLast).

* Restaurar todos los casos.
USE ALL.
```

---

### Ejemplo 5: Ordenar y Reorganizar Datos

```spss
* ================================================.
* EJEMPLO 5: ORDENAR Y REORGANIZAR DATOS.
* ================================================.

* Ordenar casos por una variable (ascendente).
SORT CASES BY apellido (A).

* Ordenar por múltiples variables.
SORT CASES BY provincia (A) edad (D).
* (A) = Ascendente, (D) = Descendente.

* Reorganizar orden de variables en el dataset.
ADD FILES /FILE=*
  /KEEP=estudiante_id nombre apellido edad sexo ciudad
         calificacion_matematicas calificacion_lengua
         ALL.

* Renombrar variables.
RENAME VARIABLES
  (calif_mat = calificacion_matematicas)
  (calif_leng = calificacion_lengua).
```

---

## 7. Funciones Útiles en SPSS

### 7.1 Funciones Matemáticas

```spss
* Funciones matemáticas comunes.
COMPUTE raiz = SQRT(numero).           * Raíz cuadrada.
COMPUTE absoluto = ABS(numero).        * Valor absoluto.
COMPUTE redondeado = RND(numero).      * Redondear.
COMPUTE truncado = TRUNC(numero).      * Truncar decimales.
COMPUTE logaritmo = LG10(numero).      * Logaritmo base 10.
COMPUTE exponencial = EXP(numero).     * e^x.
COMPUTE potencia = numero**2.          * Elevar al cuadrado.
```

### 7.2 Funciones Estadísticas

```spss
* Media de varias variables.
COMPUTE promedio = MEAN(var1, var2, var3, var4).

* Suma de varias variables.
COMPUTE total = SUM(var1, var2, var3, var4).

* Mínimo y máximo.
COMPUTE minimo = MIN(var1, var2, var3).
COMPUTE maximo = MAX(var1, var2, var3).

* Desviación estándar.
COMPUTE desv_std = SD(var1, var2, var3).
```

### 7.3 Funciones de Texto

```spss
* Convertir a mayúsculas.
COMPUTE nombre_mayus = UPCASE(nombre).

* Convertir a minúsculas.
COMPUTE nombre_minus = LOWER(nombre).

* Longitud de cadena.
COMPUTE longitud = LENGTH(RTRIM(nombre)).

* Concatenar texto.
STRING nombre_completo (A50).
COMPUTE nombre_completo = CONCAT(RTRIM(nombre), ' ', RTRIM(apellido)).

* Extraer subcadena.
COMPUTE iniciales = SUBSTR(nombre, 1, 1).
```

### 7.4 Funciones de Fecha

```spss
* Fecha actual.
COMPUTE fecha_hoy = $TIME.

* Extraer componentes de fecha.
COMPUTE anio = XDATE.YEAR(fecha_nacimiento).
COMPUTE mes = XDATE.MONTH(fecha_nacimiento).
COMPUTE dia = XDATE.MDAY(fecha_nacimiento).

* Calcular edad.
COMPUTE edad = DATEDIFF($TIME, fecha_nacimiento, "years").
```

---

## 8. Valores Perdidos (Missing Values)

```spss
* ================================================.
* MANEJO DE VALORES PERDIDOS.
* ================================================.

* Definir valores perdidos para una variable.
MISSING VALUES edad (999).
MISSING VALUES ingresos (999999, -1).
MISSING VALUES sexo (9).

* Valores perdidos por rango.
MISSING VALUES calificacion (LOWEST THRU 0).

* Para variables de texto.
MISSING VALUES nombre ('', 'NA', 'N/A').

* Reemplazar valores perdidos con la media.
COMPUTE edad_imputada = edad.
IF MISSING(edad) edad_imputada = $SYSMIS.

* Identificar casos con valores perdidos.
COMPUTE tiene_perdidos = 0.
IF MISSING(edad) OR MISSING(ingresos) tiene_perdidos = 1.
```

---

## 9. Exportar Datos

```spss
* ================================================.
* EXPORTAR DATOS A DIFERENTES FORMATOS.
* ================================================.

* Exportar a Excel.
SAVE TRANSLATE OUTFILE='C:/MisCursos/SPSS/resultado.xlsx'
  /TYPE=XLS
  /VERSION=12
  /MAP
  /REPLACE
  /FIELDNAMES
  /CELLS=VALUES.

* Exportar a CSV.
SAVE TRANSLATE OUTFILE='C:/MisCursos/SPSS/resultado.csv'
  /TYPE=CSV
  /ENCODING='UTF8'
  /MAP
  /REPLACE
  /FIELDNAMES
  /CELLS=VALUES.

* Exportar sintaxis a archivo de texto.
OUTPUT EXPORT
  /CONTENTS EXPORT=ALL LAYERS=PRINTSETTING MODELVIEWS=PRINTSETTING
  /TXT DOCUMENTFILE='C:/MisCursos/SPSS/resultados.txt'.
```

---

## 🎯 Ejercicio Práctico 1

**Objetivo**: Crear tu primera base de datos en SPSS

### Instrucciones:

1. Crea un nuevo archivo de datos con información de 10 productos de una tienda:
   - ID del producto
   - Nombre del producto
   - Categoría (1=Electrónica, 2=Ropa, 3=Alimentos)
   - Precio
   - Stock disponible
   - En oferta (0=No, 1=Sí)

2. Asigna etiquetas apropiadas a todas las variables

3. Crea una variable nueva llamada `valor_inventario` = precio * stock

4. Crea una variable categórica `nivel_precio`:
   - Bajo: precio < 20
   - Medio: precio entre 20 y 50
   - Alto: precio > 50

5. Guarda el archivo como `inventario_tienda.sav`

### Solución:

```spss
* ================================================.
* EJERCICIO 1: BASE DE DATOS DE INVENTARIO.
* ================================================.

NEW FILE.

DATA LIST FREE
  / producto_id (F3.0) nombre (A30) categoria (F1.0)
    precio (F6.2) stock (F4.0) en_oferta (F1.0).

BEGIN DATA
1 "Laptop HP" 1 899.99 15 0
2 "Camiseta Nike" 2 29.99 50 1
3 "Arroz 1kg" 3 2.50 200 0
4 "Smartphone Samsung" 1 599.00 25 1
5 "Pantalón Levis" 2 75.00 30 0
6 "Aceite Oliva 500ml" 3 8.99 100 0
7 "Tablet iPad" 1 450.00 10 0
8 "Zapatos Adidas" 2 89.99 20 1
9 "Café 250g" 3 5.50 150 0
10 "Auriculares Sony" 1 120.00 40 1
END DATA.

* Etiquetas de variables.
VARIABLE LABELS
  producto_id 'ID del Producto'
  nombre 'Nombre del Producto'
  categoria 'Categoría del Producto'
  precio 'Precio en Euros'
  stock 'Stock Disponible'
  en_oferta 'Producto en Oferta'.

* Etiquetas de valores.
VALUE LABELS
  categoria 1 'Electrónica' 2 'Ropa' 3 'Alimentos'
  /en_oferta 0 'No' 1 'Sí'.

* Nivel de medición.
VARIABLE LEVEL
  producto_id (NOMINAL)
  categoria (NOMINAL)
  precio (SCALE)
  stock (SCALE)
  en_oferta (NOMINAL).

* Crear variable: valor del inventario.
COMPUTE valor_inventario = precio * stock.
VARIABLE LABELS valor_inventario 'Valor Total del Inventario'.

* Crear variable categórica: nivel de precio.
RECODE precio
  (LOWEST THRU 20 = 1)
  (20 THRU 50 = 2)
  (50 THRU HIGHEST = 3)
  INTO nivel_precio.

VARIABLE LABELS nivel_precio 'Nivel de Precio'.
VALUE LABELS nivel_precio
  1 'Bajo'
  2 'Medio'
  3 'Alto'.

EXECUTE.

* Mostrar resultados.
LIST producto_id nombre precio stock valor_inventario nivel_precio.

* Guardar archivo.
SAVE OUTFILE='C:/MisCursos/SPSS/inventario_tienda.sav'.
```

---

## 🎯 Ejercicio Práctico 2

**Tu turno**: Crea una base de datos de empleados con:
- ID empleado
- Nombre completo
- Departamento (Ventas, IT, RRHH, Finanzas)
- Salario mensual
- Años de antigüedad
- Género (M/F)

Luego:
1. Calcula el salario anual
2. Crea una variable de bono (10% del salario anual si antigüedad > 5 años, 5% si no)
3. Clasifica salarios en rangos: Bajo, Medio, Alto

---

## 📝 Resumen del Módulo 1

### Has aprendido:
✅ La interfaz de SPSS y sus componentes principales
✅ Tipos de variables y escalas de medición
✅ Sintaxis básica de SPSS
✅ Crear y manipular datasets
✅ Importar y exportar datos
✅ Transformar variables con COMPUTE, RECODE, IF
✅ Funciones matemáticas, estadísticas y de texto
✅ Manejo de valores perdidos
✅ Seleccionar y filtrar casos

### Próximo paso:
Continúa con el **Módulo 2: Estadística Descriptiva** donde aprenderás a analizar tus datos con medidas de tendencia central, dispersión y tablas de frecuencias.

---

## 💡 Consejos Importantes

1. **Guarda tu sintaxis**: Siempre trabaja con archivos de sintaxis (.sps) para poder reproducir tus análisis

2. **Comenta tu código**: Usa asteriscos (*) para documentar qué hace cada sección

3. **Verifica tus datos**: Usa LIST o DESCRIPTIVES para verificar que las transformaciones funcionaron

4. **Haz copias de seguridad**: Antes de transformar datos, guarda una copia del archivo original

5. **Usa nombres descriptivos**: Las variables deben tener nombres que indiquen claramente su contenido

6. **EXECUTE es importante**: Algunos comandos necesitan EXECUTE para aplicar los cambios

---

**¡Felicidades!** Has completado el Módulo 1. Ahora tienes las bases para trabajar con SPSS de manera profesional.
