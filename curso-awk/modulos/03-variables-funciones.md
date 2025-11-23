# Módulo 3: Variables y Funciones Integradas

## Variables Integradas de AWK

AWK proporciona muchas variables integradas útiles. Ya conoces algunas, ahora veremos todas en detalle.

### Variables de Campos y Registros

| Variable | Descripción |
|----------|-------------|
| `$0` | Línea/registro completo |
| `$1, $2, $3...` | Campo 1, 2, 3, etc. |
| `NF` | Número de campos en el registro actual |
| `NR` | Número de registro/línea actual (desde inicio) |
| `FNR` | Número de registro en el archivo actual |
| `FILENAME` | Nombre del archivo actual |

### Variables de Separadores

| Variable | Descripción | Valor por Defecto |
|----------|-------------|-------------------|
| `FS` | Separador de campos de entrada | Espacio/Tab |
| `OFS` | Separador de campos de salida | Espacio |
| `RS` | Separador de registros de entrada | Newline (\n) |
| `ORS` | Separador de registros de salida | Newline (\n) |

### Otras Variables Útiles

| Variable | Descripción |
|----------|-------------|
| `ARGC` | Número de argumentos de línea de comandos |
| `ARGV` | Array de argumentos de línea de comandos |
| `ENVIRON` | Array de variables de entorno |
| `RLENGTH` | Longitud de la cadena coincidente con match() |
| `RSTART` | Inicio de la cadena coincidente con match() |

---

## EJEMPLO 1: Trabajando con NF y NR

Archivo `datos.txt`:
```
Ana Luis
Pedro
Carlos María Jorge
Elena
```

```bash
awk '{
    print "Línea", NR, "tiene", NF, "campo(s):", $0
}' datos.txt
```

**Salida:**
```
Línea 1 tiene 2 campo(s): Ana Luis
Línea 2 tiene 1 campo(s): Pedro
Línea 3 tiene 3 campo(s): Carlos María Jorge
Línea 4 tiene 1 campo(s): Elena
```

**Código comentado:**
```awk
{
    # NR = número de línea actual (contador global)
    # NF = número de campos en la línea actual
    # $0 = línea completa
    print "Línea", NR, "tiene", NF, "campo(s):", $0
}
```

---

## EJEMPLO 2: Acceder al Último Campo con $NF

```bash
# Imprimir el último campo de cada línea
awk '{ print $NF }' datos.txt
```

**Salida:**
```
Luis
Pedro
Jorge
Elena
```

```bash
# Imprimir penúltimo campo
awk 'NF >= 2 { print $(NF-1) }' datos.txt
```

**Salida:**
```
Ana
María
```

**Código comentado:**
```awk
{
    # $NF accede al último campo
    # Si NF = 3, entonces $NF = $3
    print $NF
}

NF >= 2 {
    # $(NF-1) accede al penúltimo campo
    # Paréntesis necesarios para la expresión aritmética
    print $(NF-1)
}
```

---

## EJEMPLO 3: Diferencia entre NR y FNR

```bash
# Crear dos archivos
echo -e "Línea 1\nLínea 2" > archivo1.txt
echo -e "Línea A\nLínea B\nLínea C" > archivo2.txt

# Procesar ambos archivos
awk '{ print FILENAME, "- NR:", NR, "FNR:", FNR, "-", $0 }' archivo1.txt archivo2.txt
```

**Salida:**
```
archivo1.txt - NR: 1 FNR: 1 - Línea 1
archivo1.txt - NR: 2 FNR: 2 - Línea 2
archivo2.txt - NR: 3 FNR: 1 - Línea A
archivo2.txt - NR: 4 FNR: 2 - Línea B
archivo2.txt - NR: 5 FNR: 3 - Línea C
```

**Código comentado:**
```awk
{
    # FILENAME = nombre del archivo actual
    # NR = contador global de líneas (continúa entre archivos)
    # FNR = contador de líneas del archivo actual (se reinicia)
    print FILENAME, "- NR:", NR, "FNR:", FNR, "-", $0
}
```

---

## EJEMPLO 4: Modificar Separadores (OFS)

Archivo `personas.txt`:
```
Juan Pérez 30
María García 25
Carlos López 35
```

```bash
# Cambiar el separador de salida
awk 'BEGIN { OFS = " | " } { print $1, $2, $3 }' personas.txt
```

**Salida:**
```
Juan | Pérez | 30
María | García | 25
Carlos | López | 35
```

**Código comentado:**
```awk
BEGIN {
    # OFS = Output Field Separator
    # Define qué se pone entre campos cuando usas print con comas
    OFS = " | "
}

{
    # La coma entre campos se reemplaza por OFS
    print $1, $2, $3
}
```

---

## EJEMPLO 5: Modificar FS (Field Separator)

Archivo `datos.csv`:
```
nombre,edad,ciudad
Juan,30,Madrid
María,25,Barcelona
Pedro,35,Valencia
```

```bash
# Cambiar separador a coma
awk 'BEGIN { FS = ","; OFS = " - " }
     NR > 1 { print $1, $2, $3 }' datos.csv
```

**Salida:**
```
Juan - 30 - Madrid
María - 25 - Barcelona
Pedro - 35 - Valencia
```

**Código comentado:**
```awk
BEGIN {
    # FS = Field Separator (entrada)
    # Establecer coma como separador de campos
    FS = ","
    # OFS = Output Field Separator (salida)
    OFS = " - "
}

NR > 1 {  # Saltar encabezado (línea 1)
    print $1, $2, $3
}
```

---

## FUNCIONES DE CADENA (STRING)

### Principales Funciones de String

| Función | Descripción |
|---------|-------------|
| `length(s)` | Longitud de la cadena s |
| `substr(s, i, n)` | Subcadena de s desde posición i, n caracteres |
| `index(s, t)` | Posición de t en s (0 si no existe) |
| `tolower(s)` | Convertir s a minúsculas |
| `toupper(s)` | Convertir s a mayúsculas |
| `split(s, a, sep)` | Dividir s en array a usando sep |
| `sub(regex, repl, target)` | Reemplazar primera ocurrencia |
| `gsub(regex, repl, target)` | Reemplazar todas las ocurrencias |
| `match(s, regex)` | Buscar regex en s |
| `sprintf(fmt, ...)` | Formatear cadena |

---

## EJEMPLO 6: Función length()

```bash
awk '{
    len = length($0)
    print "Línea", NR, "tiene", len, "caracteres"
}' personas.txt
```

**Salida:**
```
Línea 1 tiene 14 caracteres
Línea 2 tiene 17 caracteres
Línea 3 tiene 16 caracteres
```

```bash
# Encontrar la línea más larga
awk 'length($0) > max { max = length($0); linea = $0 }
     END { print "Línea más larga:", linea, "(" max, "caracteres)" }' personas.txt
```

**Código comentado:**
```awk
# Patrón: cuando la longitud actual es mayor que el máximo
length($0) > max {
    max = length($0)    # Actualizar máximo
    linea = $0          # Guardar la línea
}

END {
    print "Línea más larga:", linea, "(" max, "caracteres)"
}
```

---

## EJEMPLO 7: Función substr()

```bash
# Extraer los primeros 3 caracteres de cada nombre
awk '{ print substr($1, 1, 3) }' personas.txt
```

**Salida:**
```
Jua
Mar
Car
```

```bash
# Extraer desde el carácter 2 hasta el final
awk '{ print substr($1, 2) }' personas.txt
```

**Salida:**
```
uan
aría
arlos
```

**Código comentado:**
```awk
{
    # substr(cadena, inicio, longitud)
    # inicio: posición inicial (1 = primer carácter)
    # longitud: número de caracteres (opcional)

    # substr($1, 1, 3) = primeros 3 caracteres del campo 1
    print substr($1, 1, 3)

    # substr($1, 2) = desde el carácter 2 hasta el final
    print substr($1, 2)
}
```

---

## EJEMPLO 8: Funciones toupper() y tolower()

```bash
# Convertir nombres a mayúsculas
awk '{ print toupper($1), $2, $3 }' personas.txt
```

**Salida:**
```
JUAN Pérez 30
MARÍA García 25
CARLOS López 35
```

```bash
# Convertir apellidos a minúsculas
awk '{ print $1, tolower($2), $3 }' personas.txt
```

**Salida:**
```
Juan pérez 30
María garcía 25
Carlos lópez 35
```

**Código comentado:**
```awk
{
    # toupper(cadena) - convierte a MAYÚSCULAS
    print toupper($1), $2, $3

    # tolower(cadena) - convierte a minúsculas
    print $1, tolower($2), $3
}
```

---

## EJEMPLO 9: Función index()

Archivo `emails.txt`:
```
juan@gmail.com
maria@empresa.com
pedro_sin_arroba.com
```

```bash
# Verificar si contiene @
awk '{
    pos = index($0, "@")
    if (pos > 0) {
        print "✓", $0, "- @ en posición", pos
    } else {
        print "✗", $0, "- sin @"
    }
}' emails.txt
```

**Salida:**
```
✓ juan@gmail.com - @ en posición 5
✓ maria@empresa.com - @ en posición 6
✗ pedro_sin_arroba.com - sin @
```

**Código comentado:**
```awk
{
    # index(cadena, búsqueda)
    # Retorna la posición de la primera ocurrencia
    # Retorna 0 si no se encuentra
    pos = index($0, "@")

    if (pos > 0) {
        print "✓", $0, "- @ en posición", pos
    } else {
        print "✗", $0, "- sin @"
    }
}
```

---

## EJEMPLO 10: Funciones sub() y gsub()

```bash
# Reemplazar primera "a" por "X"
awk '{ sub(/a/, "X"); print }' personas.txt
```

**Salida:**
```
JuXn Pérez 30
MXría García 25
CXrlos López 35
```

```bash
# Reemplazar TODAS las "a" por "X"
awk '{ gsub(/a/, "X"); print }' personas.txt
```

**Salida:**
```
JuXn Pérez 30
MXríX GXrcíX 25
CXrlos López 35
```

**Código comentado:**
```awk
{
    # sub(regex, reemplazo, target)
    # Reemplaza solo la PRIMERA ocurrencia
    # Si no se especifica target, usa $0
    sub(/a/, "X")
    print
}

{
    # gsub(regex, reemplazo, target)
    # Reemplaza TODAS las ocurrencias
    gsub(/a/, "X")
    print
}
```

---

## EJEMPLO 11: Limpiar Espacios con sub/gsub

Archivo `datos_sucios.txt`:
```
  Juan   Pérez
María García
   Carlos   López
```

```bash
# Eliminar espacios al inicio y final
awk '{
    gsub(/^[ \t]+/, "")   # Eliminar al inicio
    gsub(/[ \t]+$/, "")   # Eliminar al final
    print "[" $0 "]"
}' datos_sucios.txt
```

**Salida:**
```
[Juan   Pérez]
[María García]
[Carlos   López]
```

**Código comentado:**
```awk
{
    # gsub(/^[ \t]+/, "")
    #   ^ = inicio de línea
    #   [ \t]+ = uno o más espacios o tabs
    #   Reemplazar con "" (nada)
    gsub(/^[ \t]+/, "")

    # gsub(/[ \t]+$/, "")
    #   [ \t]+ = uno o más espacios o tabs
    #   $ = final de línea
    gsub(/[ \t]+$/, "")

    print "[" $0 "]"  # Corchetes para ver los límites
}
```

---

## EJEMPLO 12: Función split()

```bash
# Dividir una fecha
echo "2024-03-15" | awk '{
    split($0, fecha, "-")
    print "Año:", fecha[1]
    print "Mes:", fecha[2]
    print "Día:", fecha[3]
}'
```

**Salida:**
```
Año: 2024
Mes: 03
Día: 15
```

**Código comentado:**
```awk
{
    # split(cadena, array, separador)
    # Divide la cadena y la guarda en un array
    # Retorna el número de elementos
    n = split($0, fecha, "-")

    # Los arrays en AWK empiezan en índice 1
    print "Año:", fecha[1]
    print "Mes:", fecha[2]
    print "Día:", fecha[3]
}
```

---

## EJEMPLO 13: Función sprintf()

```bash
awk '{
    # Formatear con sprintf (como printf pero retorna string)
    texto = sprintf("%-10s tiene %2d años", $1, $3)
    print texto
}' personas.txt
```

**Salida:**
```
Juan       tiene 30 años
María      tiene 25 años
Carlos     tiene 35 años
```

**Código comentado:**
```awk
{
    # sprintf(formato, valores...)
    # Similar a printf pero RETORNA la cadena en lugar de imprimirla
    # Útil para guardar texto formateado en variables
    texto = sprintf("%-10s tiene %2d años", $1, $3)
    print texto
}
```

---

## FUNCIONES MATEMÁTICAS

| Función | Descripción |
|---------|-------------|
| `int(x)` | Parte entera de x |
| `sqrt(x)` | Raíz cuadrada de x |
| `exp(x)` | e^x |
| `log(x)` | Logaritmo natural de x |
| `sin(x)` | Seno de x (radianes) |
| `cos(x)` | Coseno de x (radianes) |
| `atan2(y, x)` | Arctangente de y/x |
| `rand()` | Número aleatorio entre 0 y 1 |
| `srand(x)` | Inicializar generador aleatorio |

---

## EJEMPLO 14: Funciones Matemáticas

```bash
# Redondear y calcular raíces
echo "25.7 16 100" | awk '{
    print "Número:", $1
    print "  Parte entera:", int($1)
    print "Raíz de", $2, "=", sqrt($2)
    print "Raíz de", $3, "=", sqrt($3)
}'
```

**Salida:**
```
Número: 25.7
  Parte entera: 25
Raíz de 16 = 4
Raíz de 100 = 10
```

**Código comentado:**
```awk
{
    # int(x) - retorna la parte entera (trunca decimales)
    print "Parte entera:", int($1)

    # sqrt(x) - raíz cuadrada
    print "Raíz de", $2, "=", sqrt($2)
}
```

---

## EJEMPLO 15: Números Aleatorios

```bash
# Generar 5 números aleatorios
awk 'BEGIN {
    srand()  # Inicializar con tiempo actual
    for (i = 1; i <= 5; i++) {
        # rand() retorna número entre 0 y 1
        # Multiplicar por 100 para números entre 0-100
        num = int(rand() * 100)
        print "Número", i ":", num
    }
}'
```

**Salida (ejemplo):**
```
Número 1: 42
Número 2: 17
Número 3: 89
Número 4: 5
Número 5: 63
```

**Código comentado:**
```awk
BEGIN {
    # srand() - inicializa el generador de números aleatorios
    # Sin argumentos usa el tiempo actual como semilla
    srand()

    for (i = 1; i <= 5; i++) {
        # rand() - retorna número aleatorio entre 0.0 y 1.0
        # rand() * 100 - número entre 0.0 y 100.0
        # int(...) - convertir a entero
        num = int(rand() * 100)
        print "Número", i ":", num
    }
}
```

---

## EJEMPLO 16: Redondear Números

```bash
# Función para redondear (AWK no tiene round() integrada)
awk 'BEGIN {
    numeros = "2.3 2.5 2.7 -2.3 -2.7"
    split(numeros, arr, " ")

    for (i in arr) {
        num = arr[i]
        redondeado = int(num + (num > 0 ? 0.5 : -0.5))
        printf "%.1f -> %d\n", num, redondeado
    }
}'
```

**Salida:**
```
2.3 -> 2
2.5 -> 3
2.7 -> 3
-2.3 -> -2
-2.7 -> -3
```

**Código comentado:**
```awk
# Técnica de redondeo:
# Para positivos: int(num + 0.5)
# Para negativos: int(num - 0.5)
# Usando operador ternario:
redondeado = int(num + (num > 0 ? 0.5 : -0.5))

# Explicación:
# Si num = 2.7: int(2.7 + 0.5) = int(3.2) = 3
# Si num = 2.3: int(2.3 + 0.5) = int(2.8) = 2
# Si num = -2.7: int(-2.7 + -0.5) = int(-3.2) = -3
```

---

## EJEMPLO 17: Trabajar con Variables de Entorno

```bash
# Mostrar variables de entorno
awk 'BEGIN {
    print "Usuario:", ENVIRON["USER"]
    print "Home:", ENVIRON["HOME"]
    print "Path:", ENVIRON["PATH"]
}'
```

**Código comentado:**
```awk
BEGIN {
    # ENVIRON es un array asociativo con las variables de entorno
    # Acceder con ENVIRON["NOMBRE_VARIABLE"]
    print "Usuario:", ENVIRON["USER"]
    print "Home:", ENVIRON["HOME"]
}
```

---

## EJEMPLO 18: Procesar Múltiples Archivos

```bash
# Crear archivos de ejemplo
echo -e "10\n20\n30" > numeros1.txt
echo -e "5\n15\n25" > numeros2.txt

# Sumar totales por archivo
awk '{
    suma += $1
}
FNR == 1 && NR > 1 {
    # Nuevo archivo detectado
    print "Total", archivo_anterior ":", suma_anterior
    suma = 0
}
{
    archivo_actual = FILENAME
}
END {
    print "Total", FILENAME ":", suma
}' numeros1.txt numeros2.txt
```

**Código comentado:**
```awk
{
    # Acumular suma para el archivo actual
    suma += $1
}

# Cuando FNR==1 (primera línea de archivo) pero NR>1 (no es el primer archivo)
FNR == 1 && NR > 1 {
    # Imprimir total del archivo anterior
    print "Total", archivo_anterior ":", suma_anterior
    suma = 0  # Reiniciar suma para nuevo archivo
}

{
    # Guardar el nombre del archivo actual
    archivo_actual = FILENAME
}

END {
    # Imprimir total del último archivo
    print "Total", FILENAME ":", suma
}
```

---

## EJEMPLO 19: Formateo Avanzado con printf

Archivo `productos.txt`:
```
Laptop 1250.5
Mouse 24.99
Teclado 79.95
Monitor 349.00
```

```bash
awk 'BEGIN {
    print "╔════════════════╦═══════════╗"
    print "║ PRODUCTO       ║   PRECIO  ║"
    print "╠════════════════╬═══════════╣"
}
{
    printf "║ %-14s ║ $%8.2f ║\n", $1, $2
}
END {
    print "╚════════════════╩═══════════╝"
}' productos.txt
```

**Salida:**
```
╔════════════════╦═══════════╗
║ PRODUCTO       ║   PRECIO  ║
╠════════════════╬═══════════╣
║ Laptop         ║ $ 1250.50 ║
║ Mouse          ║ $   24.99 ║
║ Teclado        ║ $   79.95 ║
║ Monitor        ║ $  349.00 ║
╚════════════════╩═══════════╝
```

**Código comentado:**
```awk
BEGIN {
    # Imprimir encabezado con caracteres de caja
    print "╔════════════════╦═══════════╗"
    print "║ PRODUCTO       ║   PRECIO  ║"
    print "╠════════════════╬═══════════╣"
}

{
    # %-14s = string, 14 caracteres, alineado a izquierda
    # $%8.2f = número, 8 caracteres totales, 2 decimales
    printf "║ %-14s ║ $%8.2f ║\n", $1, $2
}

END {
    print "╚════════════════╩═══════════╝"
}
```

---

## EJEMPLO 20: Proyecto Integrador - Análisis de Ventas

Archivo `ventas_completo.txt`:
```
2024-01-15,Laptop,5,1250.50,Norte
2024-01-15,Mouse,50,24.99,Sur
2024-01-16,Teclado,20,79.95,Norte
2024-01-16,Monitor,10,349.00,Este
2024-01-17,Laptop,3,1250.50,Sur
2024-01-17,Mouse,30,24.99,Oeste
```

```bash
awk -F',' '
BEGIN {
    print "═══════════════════════════════════════════════════"
    print "           REPORTE DE VENTAS DETALLADO"
    print "═══════════════════════════════════════════════════"
    printf "\n%-12s %-10s %8s %10s %12s\n", "FECHA", "PRODUCTO", "CANT", "PRECIO", "TOTAL"
    print "---------------------------------------------------"
}
{
    # Procesar cada venta
    fecha = $1
    producto = $2
    cantidad = $3
    precio = $4
    region = $5

    # Calcular total de la línea
    total = cantidad * precio

    # Imprimir línea formateada
    printf "%-12s %-10s %8d $%9.2f $%11.2f\n", fecha, producto, cantidad, precio, total

    # Acumular por producto
    ventas_producto[producto] += total
    unidades_producto[producto] += cantidad

    # Acumular por región
    ventas_region[region] += total

    # Total general
    total_general += total
}
END {
    print "═══════════════════════════════════════════════════"
    print "\nRESUMEN POR PRODUCTO:"
    for (prod in ventas_producto) {
        printf "  %-10s: %3d unidades = $%10.2f\n", prod, unidades_producto[prod], ventas_producto[prod]
    }

    print "\nRESUMEN POR REGIÓN:"
    for (reg in ventas_region) {
        porcentaje = (ventas_region[reg] / total_general) * 100
        printf "  %-10s: $%10.2f (%5.1f%%)\n", reg, ventas_region[reg], porcentaje
    }

    print "\n═══════════════════════════════════════════════════"
    printf "TOTAL GENERAL: $%.2f\n", total_general
    print "═══════════════════════════════════════════════════"
}
' ventas_completo.txt
```

---

## EJERCICIOS PRÁCTICOS - NIVEL INTERMEDIO-AVANZADO

### Ejercicio 1: Manipulación de Strings

Crea `textos.txt`:
```
HOLA mundo
AWK es GENIAL
Procesamiento DE texto
```

Tareas:
- a) Convierte todo a minúsculas
- b) Convierte todo a mayúsculas
- c) Convierte la primera letra de cada palabra a mayúscula
- d) Cuenta cuántos caracteres tiene cada línea
- e) Extrae los primeros 5 caracteres de cada línea

### Ejercicio 2: Validación de Emails

Crea `emails_validar.txt`:
```
juan@gmail.com
maria.garcia@empresa.co.mx
pedro_email.com
ana@dominio
luis@test.com
carmen@
@servidor.com
```

Tareas:
- a) Valida que tengan @ y al menos un punto después del @
- b) Extrae el dominio (parte después del @)
- c) Cuenta cuántos emails son de cada dominio
- d) Encuentra el email más largo

### Ejercicio 3: Análisis de Logs con Fechas

Crea `logs_fecha.txt`:
```
2024-01-15 08:30:15 INFO Inicio de sistema
2024-01-15 08:35:22 ERROR Fallo de conexión
2024-01-15 08:40:10 INFO Reconexión exitosa
2024-01-16 09:15:45 WARNING Memoria baja
2024-01-16 09:20:30 ERROR Disco lleno
2024-01-17 10:05:12 INFO Mantenimiento completado
```

Tareas:
- a) Separa fecha y hora en campos distintos
- b) Cuenta errores por día
- c) Encuentra el primer y último evento de cada día
- d) Calcula cuánto tiempo pasó entre el primer y último evento

### Ejercicio 4: Cálculos Matemáticos

Crea `numeros_calcular.txt`:
```
25 16
100 64
49 81
```

Tareas:
- a) Calcula la raíz cuadrada de cada número
- b) Calcula el promedio de cada fila
- c) Encuentra el número más grande de todo el archivo
- d) Calcula la desviación de cada número respecto al promedio total

---

## SOLUCIONES

Las soluciones están en `../soluciones/03-soluciones-variables.md`

---

## RESUMEN DEL MÓDULO 3

Has aprendido:
- ✅ Variables integradas: NF, NR, FNR, FILENAME
- ✅ Variables de separadores: FS, OFS, RS, ORS
- ✅ Funciones de string: length, substr, index, toupper, tolower
- ✅ Funciones de sustitución: sub, gsub
- ✅ Función split para dividir cadenas
- ✅ Funciones matemáticas: int, sqrt, rand, srand
- ✅ Formateo con sprintf
- ✅ Variables de entorno con ENVIRON
- ✅ Procesamiento de múltiples archivos

## Próximo Módulo

En el **Módulo 4** aprenderás sobre:
- Arrays asociativos
- Arrays multidimensionales
- Ordenamiento de arrays
- Técnicas avanzadas con arrays
- Conteo y agrupación de datos
