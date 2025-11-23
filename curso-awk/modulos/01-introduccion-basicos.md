# Módulo 1: Introducción y Conceptos Básicos de AWK

## ¿Qué es AWK?

AWK es un lenguaje de programación diseñado para el procesamiento de texto y extracción de datos. Fue creado en 1977 por Alfred Aho, Peter Weinberger y Brian Kernighan (de ahí el nombre AWK). Es especialmente útil para:

- Procesar archivos de texto columnar
- Generar reportes formateados
- Transformar datos
- Análisis de logs
- Procesamiento de datos CSV, TSV, etc.

## Estructura Básica de un Programa AWK

```awk
patrón { acción }
```

- **patrón**: Define cuándo se ejecuta la acción (opcional)
- **acción**: Comandos a ejecutar cuando el patrón coincide

## Bloques Especiales

AWK tiene dos bloques especiales:

```awk
BEGIN {
    # Se ejecuta ANTES de procesar cualquier línea
    # Útil para inicializar variables, imprimir encabezados
}

{
    # Se ejecuta para CADA línea del archivo
}

END {
    # Se ejecuta DESPUÉS de procesar todas las líneas
    # Útil para imprimir totales, resúmenes
}
```

## Variables Integradas Fundamentales

- `$0` - Línea completa actual
- `$1, $2, $3...` - Campo 1, campo 2, campo 3, etc.
- `NF` - Número de campos (Number of Fields)
- `NR` - Número de registro/línea actual (Number of Records)
- `FS` - Separador de campos (Field Separator), por defecto espacio/tab
- `OFS` - Separador de campos de salida (Output Field Separator)

---

## EJEMPLO 1: Tu Primer Programa AWK

### Imprimir todas las líneas de un archivo

```bash
# Sintaxis: awk '{ print }' archivo
# O simplemente:
awk '{ print $0 }' archivo.txt
```

**Código comentado:**
```awk
# $0 representa la línea completa
# print sin argumentos también imprime $0
{ print $0 }
```

### Prueba tú mismo:
Crea un archivo llamado `nombres.txt`:
```
Juan Pérez
María García
Carlos López
Ana Martínez
```

Ejecuta:
```bash
awk '{ print $0 }' nombres.txt
```

---

## EJEMPLO 2: Imprimir Campos Específicos

```bash
# Imprimir solo el primer campo (nombre)
awk '{ print $1 }' nombres.txt
```

**Salida:**
```
Juan
María
Carlos
Ana
```

```bash
# Imprimir el segundo campo (apellido)
awk '{ print $2 }' nombres.txt
```

**Salida:**
```
Pérez
García
López
Martínez
```

```bash
# Imprimir ambos campos en orden inverso
awk '{ print $2, $1 }' nombres.txt
```

**Salida:**
```
Pérez Juan
García María
López Carlos
Martínez Ana
```

**Explicación del código:**
```awk
{
    # $1 es el primer campo (primera palabra)
    # $2 es el segundo campo (segunda palabra)
    # La coma agrega un espacio entre los campos
    print $2, $1
}
```

---

## EJEMPLO 3: Usando BEGIN y END

Crea un archivo `empleados.txt`:
```
Ana 2500
Luis 3000
Pedro 2800
Carmen 3200
```

```bash
awk 'BEGIN { print "REPORTE DE SALARIOS" }
     { print $1, "-", $2 }
     END { print "Fin del reporte" }' empleados.txt
```

**Salida:**
```
REPORTE DE SALARIOS
Ana - 2500
Luis - 3000
Pedro - 2800
Carmen - 3200
Fin del reporte
```

**Código comentado:**
```awk
BEGIN {
    # Esto se ejecuta UNA VEZ antes de leer el archivo
    print "REPORTE DE SALARIOS"
}

{
    # Esto se ejecuta para CADA línea del archivo
    # $1 = nombre, $2 = salario
    print $1, "-", $2
}

END {
    # Esto se ejecuta UNA VEZ después de procesar todo
    print "Fin del reporte"
}
```

---

## EJEMPLO 4: Contador de Líneas con NR

```bash
awk '{ print NR, $0 }' empleados.txt
```

**Salida:**
```
1 Ana 2500
2 Luis 3000
3 Pedro 2800
4 Carmen 3200
```

**Código comentado:**
```awk
{
    # NR = número de línea actual (Number of Records)
    # $0 = línea completa
    print NR, $0
}
```

---

## EJEMPLO 5: Número de Campos con NF

```bash
awk '{ print "Línea", NR, "tiene", NF, "campos" }' empleados.txt
```

**Salida:**
```
Línea 1 tiene 2 campos
Línea 2 tiene 2 campos
Línea 3 tiene 2 campos
Línea 4 tiene 2 campos
```

```bash
# Imprimir el último campo de cada línea
awk '{ print $NF }' empleados.txt
```

**Salida:**
```
2500
3000
2800
3200
```

**Código comentado:**
```awk
{
    # NF contiene el número total de campos
    # $NF accede al último campo
    # Si NF=2, entonces $NF es equivalente a $2
    print $NF
}
```

---

## EJEMPLO 6: Operaciones Aritméticas Básicas

```bash
# Calcular suma total de salarios
awk 'BEGIN { total = 0 }
     { total = total + $2 }
     END { print "Total:", total }' empleados.txt
```

**Salida:**
```
Total: 11500
```

**Código comentado:**
```awk
BEGIN {
    # Inicializar variable total en 0
    # (En AWK las variables no declaradas son 0 por defecto)
    total = 0
}

{
    # Para cada línea, sumar el segundo campo (salario) al total
    # $2 contiene el salario de cada empleado
    total = total + $2
    # Forma corta: total += $2
}

END {
    # Después de procesar todas las líneas, imprimir el total
    print "Total:", total
}
```

---

## EJEMPLO 7: Calcular Promedio

```bash
awk 'BEGIN { suma = 0; contador = 0 }
     { suma += $2; contador++ }
     END { print "Promedio:", suma/contador }' empleados.txt
```

**Salida:**
```
Promedio: 2875
```

**Código comentado:**
```awk
BEGIN {
    suma = 0       # Acumulador para la suma
    contador = 0   # Contador de líneas
}

{
    suma += $2        # Sumar salario actual (equivale a: suma = suma + $2)
    contador++        # Incrementar contador (equivale a: contador = contador + 1)
}

END {
    # Calcular y mostrar el promedio
    print "Promedio:", suma/contador
    # También podríamos usar NR en lugar de contador:
    # print "Promedio:", suma/NR
}
```

---

## EJEMPLO 8: Cambiar el Separador de Campos (FS)

Crea un archivo `datos.csv`:
```
Juan,30,España
María,25,México
Carlos,35,Argentina
```

```bash
# Usar -F para especificar el separador (coma)
awk -F',' '{ print $1, "tiene", $2, "años" }' datos.csv
```

**Salida:**
```
Juan tiene 30 años
María tiene 25 años
Carlos tiene 35 años
```

**Código comentado:**
```awk
# -F',' establece el separador de campos como coma
# Alternativa: BEGIN { FS = "," }

{
    # $1 = nombre
    # $2 = edad
    # $3 = país
    print $1, "tiene", $2, "años"
}
```

---

## EJEMPLO 9: Formatear Salida con printf

```bash
awk 'BEGIN { print "NOMBRE     SALARIO" }
     { printf "%-10s %7d\n", $1, $2 }' empleados.txt
```

**Salida:**
```
NOMBRE     SALARIO
Ana           2500
Luis          3000
Pedro         2800
Carmen        3200
```

**Código comentado:**
```awk
BEGIN {
    # Imprimir encabezado
    print "NOMBRE     SALARIO"
}

{
    # printf permite formato controlado
    # %-10s = string alineado a izquierda, 10 caracteres de ancho
    # %7d = entero, 7 caracteres de ancho, alineado a derecha
    # \n = nueva línea
    printf "%-10s %7d\n", $1, $2
}
```

**Especificadores de formato printf:**
- `%s` - string (texto)
- `%d` - entero (número)
- `%f` - flotante (decimal)
- `%-10s` - texto alineado a izquierda, 10 caracteres
- `%10s` - texto alineado a derecha, 10 caracteres
- `%.2f` - decimal con 2 cifras decimales

---

## EJEMPLO 10: Combinar Todo - Reporte Completo

```bash
awk -F',' 'BEGIN {
        print "====================================="
        print "      REPORTE DE EMPLEADOS"
        print "====================================="
        printf "%-15s %5s %15s\n", "NOMBRE", "EDAD", "PAÍS"
        print "-------------------------------------"
        total_edad = 0
    }
    {
        # Procesar cada línea
        printf "%-15s %5d %15s\n", $1, $2, $3
        total_edad += $2
    }
    END {
        print "====================================="
        printf "Edad promedio: %.1f años\n", total_edad/NR
        print "Total de empleados:", NR
        print "====================================="
    }' datos.csv
```

**Salida:**
```
=====================================
      REPORTE DE EMPLEADOS
=====================================
NOMBRE          EDAD            PAÍS
-------------------------------------
Juan               30          España
María              25          México
Carlos             35       Argentina
=====================================
Edad promedio: 30.0 años
Total de empleados: 3
=====================================
```

---

## EJERCICIOS PRÁCTICOS - NIVEL BÁSICO

### Ejercicio 1: Crear y Procesar Lista de Productos

1. Crea un archivo `productos.txt` con este contenido:
```
Laptop 850
Mouse 25
Teclado 45
Monitor 320
Impresora 280
```

2. Tareas:
   - a) Imprime solo los nombres de productos
   - b) Imprime solo los precios
   - c) Imprime los productos con su número de línea
   - d) Calcula el precio total de todos los productos
   - e) Calcula el precio promedio

### Ejercicio 2: Archivo CSV

1. Crea `ventas.csv`:
```
Producto,Cantidad,Precio
Manzanas,10,1.5
Peras,15,2.0
Naranjas,8,1.8
Uvas,12,3.5
```

2. Tareas:
   - a) Imprime solo la columna de productos (ignorando el encabezado)
   - b) Calcula el total de cada línea (Cantidad * Precio)
   - c) Muestra un reporte formateado con printf

### Ejercicio 3: Análisis de Texto

1. Crea `texto.txt` con cualquier texto de varias líneas

2. Tareas:
   - a) Cuenta cuántas líneas tiene el archivo
   - b) Imprime el número de palabras en cada línea
   - c) Encuentra la línea con más palabras

---

## SOLUCIONES

Encontrarás las soluciones en el archivo `../soluciones/01-soluciones-basicos.md`

---

## RESUMEN DEL MÓDULO 1

Has aprendido:
- ✅ Qué es AWK y para qué sirve
- ✅ Estructura básica de un programa AWK
- ✅ Bloques BEGIN y END
- ✅ Variables integradas: $0, $1, $2, NR, NF, FS
- ✅ Operaciones aritméticas básicas
- ✅ Uso de print y printf
- ✅ Cambiar separadores de campos

## Próximo Módulo

En el **Módulo 2** aprenderás sobre:
- Patrones y expresiones regulares
- Operadores de comparación
- Operadores lógicos
- Rangos de líneas
- Filtrado de datos avanzado
