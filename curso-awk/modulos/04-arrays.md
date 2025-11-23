# Módulo 4: Arrays y Estructuras de Datos

## Introducción a los Arrays en AWK

Los arrays en AWK son **asociativos** (también llamados hashes o diccionarios), lo que significa que:
- Los índices pueden ser números O strings
- No necesitan ser declarados
- Se crean automáticamente al usarse
- No tienen tamaño fijo

```awk
# Ejemplos de arrays
edad["Juan"] = 25
edad["María"] = 30

numeros[1] = 100
numeros[2] = 200

# Índices pueden ser cualquier expresión
datos["usuario_" i] = valor
```

---

## EJEMPLO 1: Arrays Básicos

```bash
awk 'BEGIN {
    # Crear array con índices numéricos
    frutas[1] = "Manzana"
    frutas[2] = "Pera"
    frutas[3] = "Naranja"

    # Acceder a elementos
    print "Fruta 1:", frutas[1]
    print "Fruta 2:", frutas[2]
    print "Fruta 3:", frutas[3]
}'
```

**Salida:**
```
Fruta 1: Manzana
Fruta 2: Pera
Fruta 3: Naranja
```

**Código comentado:**
```awk
BEGIN {
    # Crear array con índices numéricos (como lista)
    frutas[1] = "Manzana"
    frutas[2] = "Pera"
    frutas[3] = "Naranja"

    # Acceder con array[índice]
    print "Fruta 1:", frutas[1]
}
```

---

## EJEMPLO 2: Arrays Asociativos (String como Índice)

```bash
awk 'BEGIN {
    # Índices de tipo string
    edad["Juan"] = 25
    edad["María"] = 30
    edad["Carlos"] = 35

    print "Juan tiene", edad["Juan"], "años"
    print "María tiene", edad["María"], "años"
    print "Carlos tiene", edad["Carlos"], "años"
}'
```

**Salida:**
```
Juan tiene 25 años
María tiene 30 años
Carlos tiene 35 años
```

**Código comentado:**
```awk
BEGIN {
    # Array asociativo: índice es string, valor es número
    edad["Juan"] = 25
    edad["María"] = 30

    # Acceder usando el nombre como índice
    print "Juan tiene", edad["Juan"], "años"
}
```

---

## EJEMPLO 3: Iterar sobre Arrays con for-in

```bash
awk 'BEGIN {
    frutas[1] = "Manzana"
    frutas[2] = "Pera"
    frutas[3] = "Naranja"

    # Iterar sobre todos los elementos
    for (indice in frutas) {
        print "Índice:", indice, "- Valor:", frutas[indice]
    }
}'
```

**Salida:**
```
Índice: 1 - Valor: Manzana
Índice: 2 - Valor: Pera
Índice: 3 - Valor: Naranja
```

**Código comentado:**
```awk
BEGIN {
    # Crear array
    frutas[1] = "Manzana"
    frutas[2] = "Pera"
    frutas[3] = "Naranja"

    # for (variable in array)
    # variable toma el valor de cada ÍNDICE (no el valor)
    for (indice in frutas) {
        print "Índice:", indice, "- Valor:", frutas[indice]
    }
}
```

**IMPORTANTE:** El orden de iteración NO está garantizado. AWK no mantiene orden de inserción.

---

## EJEMPLO 4: Verificar si un Índice Existe

```bash
awk 'BEGIN {
    edad["Juan"] = 25
    edad["María"] = 30

    # Verificar si existe un índice
    if ("Juan" in edad) {
        print "Juan está en el array"
    }

    if ("Pedro" in edad) {
        print "Pedro está en el array"
    } else {
        print "Pedro NO está en el array"
    }
}'
```

**Salida:**
```
Juan está en el array
Pedro NO está en el array
```

**Código comentado:**
```awk
BEGIN {
    edad["Juan"] = 25

    # Operador: "índice" in array
    # Retorna 1 (true) si existe, 0 (false) si no existe
    if ("Juan" in edad) {
        print "Juan está en el array"
    }

    # IMPORTANTE: NO hacer if (array[indice])
    # Porque eso CREARÍA el elemento con valor 0
    # Siempre usar: if (indice in array)
}
```

---

## EJEMPLO 5: Eliminar Elementos del Array

```bash
awk 'BEGIN {
    frutas[1] = "Manzana"
    frutas[2] = "Pera"
    frutas[3] = "Naranja"

    print "Antes de eliminar:"
    for (i in frutas) print frutas[i]

    # Eliminar elemento
    delete frutas[2]

    print "\nDespués de eliminar frutas[2]:"
    for (i in frutas) print frutas[i]
}'
```

**Salida:**
```
Antes de eliminar:
Manzana
Pera
Naranja

Después de eliminar frutas[2]:
Manzana
Naranja
```

**Código comentado:**
```awk
{
    # delete array[índice]
    # Elimina el elemento con ese índice
    delete frutas[2]

    # También se puede eliminar todo el array:
    # delete frutas
}
```

---

## EJEMPLO 6: Contar Ocurrencias

Archivo `palabras.txt`:
```
manzana
pera
manzana
naranja
pera
manzana
```

```bash
awk '{
    # Contar ocurrencias de cada palabra
    contador[$1]++
}
END {
    # Mostrar resultados
    for (palabra in contador) {
        print palabra, "aparece", contador[palabra], "veces"
    }
}' palabras.txt
```

**Salida:**
```
manzana aparece 3 veces
pera aparece 2 veces
naranja aparece 1 veces
```

**Código comentado:**
```awk
{
    # $1 es la palabra
    # contador[$1]++ incrementa el contador para esa palabra
    # Si no existe, se inicializa en 0 automáticamente
    contador[$1]++
}

END {
    # Iterar sobre todas las palabras únicas
    for (palabra in contador) {
        print palabra, "aparece", contador[palabra], "veces"
    }
}
```

---

## EJEMPLO 7: Agrupar y Sumar por Categoría

Archivo `ventas_cat.txt`:
```
Laptop Electrónica 1200
Mouse Electrónica 25
Mesa Muebles 350
Silla Muebles 180
Teclado Electrónica 75
Escritorio Muebles 420
```

```bash
awk '{
    categoria = $2
    precio = $3

    # Acumular por categoría
    total[categoria] += precio
    items[categoria]++
}
END {
    print "RESUMEN POR CATEGORÍA:\n"
    for (cat in total) {
        printf "%-15s: %2d items = $%7.2f\n", cat, items[cat], total[cat]
    }
}' ventas_cat.txt
```

**Salida:**
```
RESUMEN POR CATEGORÍA:

Electrónica    :  3 items = $1300.00
Muebles        :  3 items = $ 950.00
```

**Código comentado:**
```awk
{
    categoria = $2   # "Electrónica" o "Muebles"
    precio = $3      # Precio del producto

    # Acumular precio por categoría
    # total["Electrónica"] += precio
    total[categoria] += precio

    # Contar items por categoría
    items[categoria]++
}

END {
    # Mostrar resumen de cada categoría
    for (cat in total) {
        printf "%-15s: %2d items = $%7.2f\n", cat, items[cat], total[cat]
    }
}
```

---

## EJEMPLO 8: Array Multidimensional (Simulado)

AWK no tiene arrays multidimensionales reales, pero se pueden simular usando el separador SUBSEP.

```bash
awk 'BEGIN {
    # Simular array 2D: matriz[fila, columna]
    matriz[1, 1] = "A"
    matriz[1, 2] = "B"
    matriz[2, 1] = "C"
    matriz[2, 2] = "D"

    # Acceder a elementos
    print "Elemento [1,1]:", matriz[1, 1]
    print "Elemento [1,2]:", matriz[1, 2]
    print "Elemento [2,1]:", matriz[2, 1]
    print "Elemento [2,2]:", matriz[2, 2]

    print "\nIterando:"
    for (clave in matriz) {
        print "Clave:", clave, "- Valor:", matriz[clave]
    }
}'
```

**Salida:**
```
Elemento [1,1]: A
Elemento [1,2]: B
Elemento [2,1]: C
Elemento [2,2]: D

Iterando:
Clave: 1 2 - Valor: D
Clave: 1 1 - Valor: A
Clave: 2 1 - Valor: C
Clave: 2 2 - Valor: B
```

**Código comentado:**
```awk
BEGIN {
    # matriz[fila, columna] = valor
    # AWK convierte automáticamente [1, 1] a "1\0341" usando SUBSEP
    # SUBSEP por defecto es \034 (carácter no imprimible)
    matriz[1, 1] = "A"
    matriz[1, 2] = "B"

    # Para iterar, la clave será "fila SUBSEP columna"
    for (clave in matriz) {
        # clave será algo como "1\0341"
        print "Clave:", clave, "- Valor:", matriz[clave]
    }
}
```

---

## EJEMPLO 9: Separar Índices Multidimensionales

```bash
awk 'BEGIN {
    # Crear matriz
    ventas["Norte", "Laptop"] = 5000
    ventas["Norte", "Mouse"] = 500
    ventas["Sur", "Laptop"] = 3000
    ventas["Sur", "Mouse"] = 800

    # Iterar y separar índices
    for (clave in ventas) {
        # Dividir la clave compuesta
        split(clave, indices, SUBSEP)
        region = indices[1]
        producto = indices[2]
        monto = ventas[clave]

        printf "Región: %-8s | Producto: %-8s | Ventas: $%.2f\n", region, producto, monto
    }
}'
```

**Salida:**
```
Región: Norte    | Producto: Laptop   | Ventas: $5000.00
Región: Norte    | Producto: Mouse    | Ventas: $500.00
Región: Sur      | Producto: Laptop   | Ventas: $3000.00
Región: Sur      | Producto: Mouse    | Ventas: $800.00
```

**Código comentado:**
```awk
BEGIN {
    # Array multidimensional
    ventas["Norte", "Laptop"] = 5000

    for (clave in ventas) {
        # split(clave, array_destino, separador)
        # SUBSEP es el separador usado internamente
        split(clave, indices, SUBSEP)

        # indices[1] = "Norte"
        # indices[2] = "Laptop"
        region = indices[1]
        producto = indices[2]
    }
}
```

---

## EJEMPLO 10: Encontrar Máximo y Mínimo con Arrays

Archivo `temperaturas.txt`:
```
2024-01-15 22.5
2024-01-16 18.3
2024-01-17 25.8
2024-01-18 20.1
2024-01-19 23.4
```

```bash
awk 'BEGIN { max = -999; min = 999 }
{
    fecha = $1
    temp = $2

    # Guardar en array
    temperatura[fecha] = temp

    # Actualizar máximo
    if (temp > max) {
        max = temp
        fecha_max = fecha
    }

    # Actualizar mínimo
    if (temp < min) {
        min = temp
        fecha_min = fecha
    }
}
END {
    print "TEMPERATURAS REGISTRADAS:"
    for (f in temperatura) {
        printf "  %s: %.1f°C\n", f, temperatura[f]
    }

    print "\nESTADÍSTICAS:"
    printf "  Máxima: %.1f°C el %s\n", max, fecha_max
    printf "  Mínima: %.1f°C el %s\n", min, fecha_min
}' temperaturas.txt
```

**Código comentado:**
```awk
BEGIN {
    # Inicializar con valores extremos
    max = -999  # Valor muy bajo para empezar
    min = 999   # Valor muy alto para empezar
}

{
    fecha = $1
    temp = $2

    # Guardar cada temperatura en array
    temperatura[fecha] = temp

    # Encontrar máximo
    if (temp > max) {
        max = temp
        fecha_max = fecha  # Recordar la fecha
    }

    # Encontrar mínimo
    if (temp < min) {
        min = temp
        fecha_min = fecha
    }
}
```

---

## EJEMPLO 11: Ordenar Resultados de Arrays

AWK no ordena arrays automáticamente, pero podemos usar pipes a sort:

```bash
# Método 1: Ordenar con pipe a sort
awk '{
    contador[$1]++
}
END {
    for (palabra in contador) {
        print contador[palabra], palabra
    }
}' palabras.txt | sort -rn
```

**Código comentado:**
```awk
END {
    for (palabra in contador) {
        # Imprimir: cantidad palabra
        # Luego usar sort -rn (reverse numeric)
        print contador[palabra], palabra
    }
}
# | sort -rn
# -r = reverse (descendente)
# -n = numeric sort
```

---

## EJEMPLO 12: Ordenar Arrays Manualmente (Bubble Sort)

```bash
awk 'BEGIN {
    # Datos desordenados
    numeros[1] = 45
    numeros[2] = 12
    numeros[3] = 67
    numeros[4] = 23
    numeros[5] = 89
    n = 5

    print "Antes de ordenar:"
    for (i = 1; i <= n; i++) {
        print numeros[i]
    }

    # Bubble sort
    for (i = 1; i <= n; i++) {
        for (j = 1; j < n; j++) {
            if (numeros[j] > numeros[j + 1]) {
                # Intercambiar
                temp = numeros[j]
                numeros[j] = numeros[j + 1]
                numeros[j + 1] = temp
            }
        }
    }

    print "\nDespués de ordenar:"
    for (i = 1; i <= n; i++) {
        print numeros[i]
    }
}'
```

**Código comentado:**
```awk
# Algoritmo Bubble Sort
for (i = 1; i <= n; i++) {
    for (j = 1; j < n; j++) {
        # Si el actual es mayor que el siguiente
        if (numeros[j] > numeros[j + 1]) {
            # Intercambiar posiciones
            temp = numeros[j]
            numeros[j] = numeros[j + 1]
            numeros[j + 1] = temp
        }
    }
}
```

---

## EJEMPLO 13: Histograma de Datos

Archivo `edades.txt`:
```
25
30
22
28
35
27
31
26
29
33
```

```bash
awk '{
    edad = $1

    # Clasificar por rango
    if (edad < 25) {
        rangos["18-24"]++
    } else if (edad < 30) {
        rangos["25-29"]++
    } else if (edad < 35) {
        rangos["30-34"]++
    } else {
        rangos["35+"]++
    }
}
END {
    print "DISTRIBUCIÓN DE EDADES:\n"

    # Definir orden de rangos
    orden[1] = "18-24"
    orden[2] = "25-29"
    orden[3] = "30-34"
    orden[4] = "35+"

    for (i = 1; i <= 4; i++) {
        rango = orden[i]
        cantidad = rangos[rango]

        # Crear barra visual
        printf "%-8s [%2d]: ", rango, cantidad
        for (j = 1; j <= cantidad; j++) {
            printf "█"
        }
        print ""
    }
}' edades.txt
```

**Salida:**
```
DISTRIBUCIÓN DE EDADES:

18-24    [ 1]: █
25-29    [ 5]: █████
30-34    [ 3]: ███
35+      [ 1]: █
```

---

## EJEMPLO 14: Transponer Datos con Arrays

Archivo `matriz.txt`:
```
1 2 3
4 5 6
7 8 9
```

```bash
# Leer matriz y transponer
awk '{
    for (i = 1; i <= NF; i++) {
        matriz[NR, i] = $i
    }
    if (NF > max_col) max_col = NF
}
END {
    # Imprimir transpuesta
    print "Matriz original:"
    for (fila = 1; fila <= NR; fila++) {
        for (col = 1; col <= max_col; col++) {
            printf "%3d ", matriz[fila, col]
        }
        print ""
    }

    print "\nMatriz transpuesta:"
    for (col = 1; col <= max_col; col++) {
        for (fila = 1; fila <= NR; fila++) {
            printf "%3d ", matriz[fila, col]
        }
        print ""
    }
}' matriz.txt
```

**Salida:**
```
Matriz original:
  1   2   3
  4   5   6
  7   8   9

Matriz transpuesta:
  1   4   7
  2   5   8
  3   6   9
```

---

## EJEMPLO 15: Eliminar Duplicados Manteniendo Orden

Archivo `numeros_duplicados.txt`:
```
10
20
10
30
20
40
10
```

```bash
awk '!vistos[$1]++ { print $1 }' numeros_duplicados.txt
```

**Salida:**
```
10
20
30
40
```

**Código comentado:**
```awk
# Técnica avanzada: usar patrón sin acción explícita
!vistos[$1]++ {
    # Explicación paso a paso:
    # 1. vistos[$1] obtiene el valor (0 si no existe)
    # 2. vistos[$1]++ retorna el valor actual y luego incrementa
    # 3. ! invierte: !0 = true (1), !1 = false (0), !2 = false
    # 4. Si true, ejecuta la acción por defecto: print $0

    print $1  # Acción explícita: imprimir el número
}

# Primera vez que ve 10: vistos[10] = 0, !0 = true, imprime, incrementa a 1
# Segunda vez que ve 10: vistos[10] = 1, !1 = false, no imprime
```

---

## EJEMPLO 16: Tabla de Frecuencias con Porcentajes

Archivo `frutas_vendidas.txt`:
```
Manzana
Pera
Manzana
Naranja
Manzana
Pera
Plátano
Manzana
```

```bash
awk '{
    frutas[$1]++
    total++
}
END {
    print "TABLA DE FRECUENCIAS:\n"
    printf "%-12s %10s %12s\n", "FRUTA", "CANTIDAD", "PORCENTAJE"
    print "----------------------------------------"

    for (fruta in frutas) {
        cantidad = frutas[fruta]
        porcentaje = (cantidad / total) * 100
        printf "%-12s %10d %11.1f%%\n", fruta, cantidad, porcentaje
    }

    print "----------------------------------------"
    printf "%-12s %10d %11.1f%%\n", "TOTAL", total, 100.0
}' frutas_vendidas.txt
```

**Salida:**
```
TABLA DE FRECUENCIAS:

FRUTA         CANTIDAD   PORCENTAJE
----------------------------------------
Manzana              4        50.0%
Pera                 2        25.0%
Naranja              1        12.5%
Plátano              1        12.5%
----------------------------------------
TOTAL                8       100.0%
```

---

## EJEMPLO 17: Procesar CSV con Campos Complejos

Archivo `empleados.csv`:
```
nombre,departamento,salario,habilidades
Juan,IT,3000,"Python,Java,SQL"
María,Ventas,2500,"Negociación,CRM"
Pedro,IT,3500,"Python,AWS,Docker"
Ana,Marketing,2800,"SEO,Analytics"
```

```bash
awk -F',' '{
    # Saltar encabezado
    if (NR == 1) next

    nombre = $1
    depto = $2
    salario = $3

    # Acumular por departamento
    suma_salario[depto] += salario
    empleados[depto]++
    total_general += salario
}
END {
    print "ANÁLISIS POR DEPARTAMENTO:\n"
    printf "%-12s %10s %12s %12s\n", "DEPTO", "EMPLEADOS", "TOTAL", "PROMEDIO"
    print "---------------------------------------------------"

    for (depto in suma_salario) {
        total = suma_salario[depto]
        cant = empleados[depto]
        promedio = total / cant

        printf "%-12s %10d $%11.2f $%11.2f\n", depto, cant, total, promedio
    }

    print "---------------------------------------------------"
    printf "%-12s %10d $%11.2f\n", "TOTAL", NR - 1, total_general
}' empleados.csv
```

---

## EJEMPLO 18: Relación Entre Dos Archivos con Arrays

Archivo `productos.txt`:
```
P001 Laptop
P002 Mouse
P003 Teclado
P004 Monitor
```

Archivo `precios.txt`:
```
P001 1200
P002 25
P003 75
P004 350
```

```bash
# Procesar ambos archivos
awk 'NR == FNR {
    # Primer archivo: guardar nombres
    nombre[$1] = $2
    next
}
{
    # Segundo archivo: combinar con precios
    codigo = $1
    precio = $2
    printf "%-8s %-10s $%8.2f\n", codigo, nombre[codigo], precio
}' productos.txt precios.txt
```

**Salida:**
```
P001     Laptop     $  1200.00
P002     Mouse      $    25.00
P003     Teclado    $    75.00
P004     Monitor    $   350.00
```

**Código comentado:**
```awk
# Técnica de dos pasadas con dos archivos

# NR == FNR: solo es true para el PRIMER archivo
NR == FNR {
    # Primer archivo: guardar datos en array
    # $1 = código, $2 = nombre
    nombre[$1] = $2
    next  # Saltar al siguiente registro
}

# Esta parte se ejecuta solo para el SEGUNDO archivo
{
    # Segundo archivo: usar array del primer archivo
    codigo = $1
    precio = $2
    # nombre[codigo] obtiene el nombre del array
    printf "%-8s %-10s $%8.2f\n", codigo, nombre[codigo], precio
}
```

---

## EJERCICIOS PRÁCTICOS - NIVEL AVANZADO

### Ejercicio 1: Análisis de Logs de Acceso

Crea `access.log`:
```
192.168.1.10 - - [15/Jan/2024:10:23:15] "GET /index.html" 200
192.168.1.20 - - [15/Jan/2024:10:24:33] "GET /about.html" 200
192.168.1.10 - - [15/Jan/2024:10:25:01] "GET /products.html" 200
192.168.1.30 - - [15/Jan/2024:10:26:15] "GET /index.html" 404
192.168.1.20 - - [15/Jan/2024:10:27:22] "POST /contact" 200
192.168.1.10 - - [15/Jan/2024:10:28:45] "GET /index.html" 200
```

Tareas:
- a) Cuenta cuántas solicitudes hizo cada IP
- b) Cuenta cuántas veces se solicitó cada página
- c) Cuenta cuántos errores 404 hubo
- d) Encuentra la IP más activa
- e) Crea un reporte de métodos HTTP usados (GET, POST)

### Ejercicio 2: Análisis de Ventas Multi-Regional

Crea `ventas_regiones.txt`:
```
Norte,Laptop,5,1200
Sur,Mouse,50,25
Norte,Teclado,20,75
Este,Laptop,3,1200
Sur,Monitor,10,350
Oeste,Mouse,30,25
Norte,Monitor,8,350
```

Tareas:
- a) Total de ventas por región
- b) Total de ventas por producto
- c) Ventas cruzadas: región x producto (matriz)
- d) Región con mayores ventas
- e) Producto más vendido (por cantidad)

### Ejercicio 3: Procesamiento de Calificaciones

Crea `calificaciones.txt`:
```
Juan,Matemáticas,85
Juan,Física,78
Juan,Química,92
María,Matemáticas,95
María,Física,88
María,Química,90
Pedro,Matemáticas,70
Pedro,Física,75
Pedro,Química,68
```

Tareas:
- a) Promedio por estudiante
- b) Promedio por materia
- c) Mejor estudiante (promedio más alto)
- d) Materia más difícil (promedio más bajo)
- e) Crear tabla de estudiantes x materias

---

## SOLUCIONES

Las soluciones están en `../soluciones/04-soluciones-arrays.md`

---

## RESUMEN DEL MÓDULO 4

Has aprendido:
- ✅ Arrays asociativos en AWK
- ✅ Crear y acceder a arrays
- ✅ Iterar con for-in
- ✅ Verificar existencia con "in"
- ✅ Eliminar elementos con delete
- ✅ Contar y agrupar datos
- ✅ Arrays multidimensionales (simulados)
- ✅ Encontrar máximos y mínimos
- ✅ Ordenar datos
- ✅ Eliminar duplicados
- ✅ Procesar múltiples archivos con arrays
- ✅ Crear tablas de frecuencias y estadísticas

## Próximo Módulo

En el **Módulo 5** aprenderás sobre:
- Estructuras de control de flujo (if, else, while, for)
- Funciones definidas por el usuario
- Recursividad
- next y exit
- getline para lectura avanzada
