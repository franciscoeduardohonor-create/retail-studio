# Guía Rápida de AWK - Referencia

## Sintaxis Básica

```bash
awk 'patrón { acción }' archivo
awk -F',' '{ print $1 }' archivo.csv
awk -f script.awk archivo
```

## Variables Integradas

| Variable | Descripción |
|----------|-------------|
| `$0` | Línea completa |
| `$1, $2, $3...` | Campo 1, 2, 3, etc. |
| `NF` | Número de campos |
| `NR` | Número de línea/registro |
| `FNR` | Número de línea en archivo actual |
| `FILENAME` | Nombre del archivo |
| `FS` | Separador de campos entrada (default: espacio) |
| `OFS` | Separador de campos salida (default: espacio) |
| `RS` | Separador de registros entrada (default: \n) |
| `ORS` | Separador de registros salida (default: \n) |

## Bloques Especiales

```awk
BEGIN { # Ejecuta antes de leer archivo }
{ # Ejecuta para cada línea }
END { # Ejecuta después de procesar todo }
```

## Operadores

### Aritméticos
```awk
+  -  *  /  %  ^  ++  --
+=  -=  *=  /=  %=
```

### Comparación
```awk
==  !=  <  <=  >  >=
~   !~              # Coincide / No coincide regex
```

### Lógicos
```awk
&&  ||  !           # AND, OR, NOT
```

## Patrones Comunes

```awk
/regex/              # Líneas que coinciden con regex
$1 == "valor"        # Campo 1 igual a "valor"
$2 > 100            # Campo 2 mayor que 100
NR == 1             # Primera línea
NR > 1              # Todas excepto primera
NF > 5              # Líneas con más de 5 campos
/inicio/,/fin/      # Desde "inicio" hasta "fin"
```

## Funciones de String

| Función | Descripción | Ejemplo |
|---------|-------------|---------|
| `length(s)` | Longitud de cadena | `length("hello")` → 5 |
| `substr(s, i, n)` | Subcadena | `substr("hello", 2, 3)` → "ell" |
| `index(s, t)` | Posición de t en s | `index("hello", "ll")` → 3 |
| `tolower(s)` | A minúsculas | `tolower("HOLA")` → "hola" |
| `toupper(s)` | A MAYÚSCULAS | `toupper("hola")` → "HOLA" |
| `split(s, a, sep)` | Dividir cadena | `split("a,b,c", arr, ",")` |
| `sub(r, s)` | Reemplazar primera | `sub(/a/, "X")` |
| `gsub(r, s)` | Reemplazar todas | `gsub(/a/, "X")` |
| `match(s, r)` | Buscar regex | `match($0, /[0-9]+/)` |
| `sprintf(fmt, ...)` | Formatear string | `sprintf("%d", 42)` |

## Funciones Matemáticas

| Función | Descripción |
|---------|-------------|
| `int(x)` | Parte entera |
| `sqrt(x)` | Raíz cuadrada |
| `sin(x), cos(x)` | Seno, coseno |
| `exp(x)` | e^x |
| `log(x)` | Logaritmo natural |
| `rand()` | Aleatorio [0,1) |
| `srand(x)` | Inicializar random |

## Arrays

```awk
# Crear array
array[indice] = valor

# Iterar
for (i in array) {
    print i, array[i]
}

# Verificar existencia
if (indice in array) { ... }

# Eliminar
delete array[indice]

# Array multidimensional
array[fila, columna] = valor
```

## Control de Flujo

### Condicionales
```awk
if (condición) {
    # código
} else if (condición2) {
    # código
} else {
    # código
}

# Operador ternario
variable = (condición) ? valor_true : valor_false
```

### Bucles
```awk
# While
while (condición) {
    # código
}

# For
for (i = 1; i <= 10; i++) {
    # código
}

# For-in (arrays)
for (clave in array) {
    # código
}

# Do-while
do {
    # código
} while (condición)
```

### Control de Flujo
```awk
break       # Salir de bucle
continue    # Siguiente iteración
next        # Siguiente registro/línea
exit        # Terminar programa (ejecuta END)
```

## Funciones Personalizadas

```awk
function nombre(parametro1, parametro2,    local1, local2) {
    # parametro1, parametro2: parámetros reales
    # local1, local2: variables locales (espacios extras para claridad)

    # código
    return valor
}

# Uso
resultado = nombre(arg1, arg2)
```

## Ejemplos Comunes

### 1. Imprimir columnas específicas
```bash
awk '{ print $1, $3 }' archivo
```

### 2. Sumar columna
```bash
awk '{ suma += $2 } END { print suma }' archivo
```

### 3. Contar líneas que cumplen condición
```bash
awk '$3 > 100 { contador++ } END { print contador }' archivo
```

### 4. Procesar CSV
```bash
awk -F',' '{ print $1, $2 }' archivo.csv
```

### 5. Calcular promedio
```bash
awk '{ suma += $1; n++ } END { print suma/n }' archivo
```

### 6. Filtrar y formatear
```bash
awk '$3 > 1000 { printf "%-10s $%.2f\n", $1, $3 }' archivo
```

### 7. Eliminar duplicados
```bash
awk '!visto[$1]++' archivo
```

### 8. Contar ocurrencias
```bash
awk '{ contador[$1]++ } END { for (i in contador) print i, contador[i] }' archivo
```

### 9. Transponer datos
```bash
awk '{ for (i=1; i<=NF; i++) a[i,NR]=$i; cols=NF }
     END { for (i=1; i<=cols; i++) {
         for (j=1; j<=NR; j++) printf "%s ", a[i,j]; print ""
     } }' archivo
```

### 10. Generar rangos
```bash
awk 'BEGIN { for (i=1; i<=10; i++) print i }'
```

## Formateo con printf

```awk
%s      # String
%d      # Entero
%f      # Flotante
%e      # Notación científica
%x      # Hexadecimal

%-10s   # String alineado izquierda, 10 caracteres
%10s    # String alineado derecha, 10 caracteres
%5.2f   # Flotante: 5 caracteres total, 2 decimales
%08d    # Entero: 8 dígitos, rellenar con ceros
```

## Expresiones Regulares

```awk
^       # Inicio de línea
$       # Fin de línea
.       # Cualquier carácter
*       # 0 o más repeticiones
+       # 1 o más repeticiones
?       # 0 o 1 repetición
[abc]   # a, b, o c
[^abc]  # Cualquier cosa excepto a, b, c
[0-9]   # Dígito
[a-z]   # Letra minúscula
\d      # Dígito (en algunos AWK)
\w      # Palabra (en algunos AWK)
|       # OR
()      # Agrupar
```

## Trucos Útiles

### Imprimir líneas 5 a 10
```bash
awk 'NR >= 5 && NR <= 10' archivo
```

### Imprimir última columna
```bash
awk '{ print $NF }' archivo
```

### Imprimir penúltima columna
```bash
awk '{ print $(NF-1) }' archivo
```

### Invertir orden de campos
```bash
awk '{ for (i=NF; i>0; i--) printf "%s ", $i; print "" }' archivo
```

### Numerar líneas
```bash
awk '{ print NR, $0 }' archivo
```

### Saltar primera línea (encabezado)
```bash
awk 'NR > 1' archivo
```

### Procesar múltiples archivos
```bash
awk 'FNR == 1 { print "Archivo:", FILENAME } { print }' archivo1 archivo2
```

### Usar variables shell
```bash
VAR="valor"
awk -v var="$VAR" '{ print var, $1 }' archivo
```

## Consejos de Rendimiento

1. ✅ Evita expresiones regulares innecesarias
2. ✅ Usa comparaciones exactas cuando sea posible
3. ✅ Minimiza llamadas a funciones externas
4. ✅ Usa arrays en lugar de múltiples variables
5. ✅ Coloca patrones más específicos primero
6. ✅ Usa `next` para saltar procesamiento innecesario

## Debugging

```bash
# Imprimir todas las variables al final
awk --dump-variables script.awk archivo

# Agregar prints de debug
awk '{ print "DEBUG:", NR, NF, $0 > "/dev/stderr"; ... }' archivo

# Modo verbose
awk -v DEBUG=1 '{ if (DEBUG) print "Procesando:", NR }' archivo
```

---

## Recursos

- Manual: `man awk`
- GNU AWK Manual: https://www.gnu.org/software/gawk/manual/
- Libro: "The AWK Programming Language" (Aho, Weinberger, Kernighan)

---

**Recuerda:** AWK procesa línea por línea, campo por campo. ¡Piensa en patrones y acciones!
