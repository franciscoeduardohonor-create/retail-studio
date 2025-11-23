# Módulo 6: Técnicas Avanzadas y Casos de Uso Reales

## Comando getline - Lectura Avanzada

`getline` permite leer datos de forma avanzada, no secuencial:

```awk
getline              # Lee siguiente línea del archivo actual
getline < "archivo"  # Lee de un archivo específico
getline var          # Lee y guarda en variable var
"comando" | getline  # Lee salida de un comando
```

---

## EJEMPLO 1: getline Básico

Archivo `datos_pares.txt`:
```
Nombre:
Juan
Edad:
25
Ciudad:
Madrid
```

```bash
awk '{
    if ($0 ~ /:$/) {
        # Si termina en ":", leer la siguiente línea
        etiqueta = substr($0, 1, length($0) - 1)  # Quitar ":"
        getline valor
        print etiqueta, "=", valor
    }
}' datos_pares.txt
```

**Salida:**
```
Nombre = Juan
Edad = 25
Ciudad = Madrid
```

**Código comentado:**
```awk
{
    # Si la línea termina en ":"
    if ($0 ~ /:$/) {
        # Guardar la etiqueta (sin los dos puntos)
        etiqueta = substr($0, 1, length($0) - 1)

        # getline: lee la SIGUIENTE línea
        # y actualiza $0, $1, $2, etc.
        getline valor

        print etiqueta, "=", valor
    }
}
```

---

## EJEMPLO 2: getline con Variable

```bash
awk 'BEGIN {
    # Leer del teclado (stdin)
    print "¿Cuál es tu nombre?"
    getline nombre < "/dev/stdin"

    print "¿Cuál es tu edad?"
    getline edad < "/dev/stdin"

    print "\nHola", nombre ", tienes", edad, "años"
}'
```

**Código comentado:**
```awk
BEGIN {
    # getline variable < archivo
    # Lee una línea del archivo y la guarda en variable
    # No actualiza $0, $1, etc., solo la variable

    getline nombre < "/dev/stdin"
    # nombre ahora contiene la línea leída
}
```

---

## EJEMPLO 3: getline desde Comando

```bash
awk 'BEGIN {
    # Ejecutar comando y leer su salida
    "date" | getline fecha_actual
    print "Fecha actual:", fecha_actual

    # Leer nombre de usuario
    "whoami" | getline usuario
    print "Usuario:", usuario

    # IMPORTANTE: cerrar el pipe
    close("date")
    close("whoami")
}'
```

**Código comentado:**
```awk
BEGIN {
    # "comando" | getline variable
    # Ejecuta el comando y lee su salida en variable

    "date" | getline fecha_actual

    # IMPORTANTE: cerrar el pipe cuando termines
    # Libera recursos del sistema
    close("date")
}
```

---

## EJEMPLO 4: Procesar Pares de Líneas

Archivo `transacciones.txt`:
```
DEPOSITO
500
RETIRO
200
DEPOSITO
1000
RETIRO
150
```

```bash
awk '
NR % 2 == 1 {
    # Líneas impares: tipo de transacción
    tipo = $0
    # Leer siguiente línea (monto)
    getline monto

    # Procesar según tipo
    if (tipo == "DEPOSITO") {
        balance += monto
        print "✓ Depósito de $" monto " | Balance: $" balance
    } else if (tipo == "RETIRO") {
        balance -= monto
        print "✗ Retiro de $" monto " | Balance: $" balance
    }
}
END {
    print "\n═══════════════════════"
    print "Balance Final: $" balance
    print "═══════════════════════"
}
' transacciones.txt
```

**Salida:**
```
✓ Depósito de $500 | Balance: $500
✗ Retiro de $200 | Balance: $300
✓ Depósito de $1000 | Balance: $1300
✗ Retiro de $150 | Balance: $1150

═══════════════════════
Balance Final: $1150
═══════════════════════
```

---

## EJEMPLO 5: Procesar Archivos de Configuración Multi-línea

Archivo `config.ini`:
```
[database]
host=localhost
port=5432

[server]
host=0.0.0.0
port=8080
timeout=30
```

```bash
awk '
/^\[.*\]$/ {
    # Nueva sección
    seccion = substr($0, 2, length($0) - 2)
    next
}

/=/ {
    # Separar clave=valor
    split($0, partes, "=")
    clave = partes[1]
    valor = partes[2]

    # Guardar con sección
    config[seccion, clave] = valor
}

END {
    print "Configuración cargada:\n"

    print "[database]"
    print "  host:", config["database", "host"]
    print "  port:", config["database", "port"]

    print "\n[server]"
    print "  host:", config["server", "host"]
    print "  port:", config["server", "port"]
    print "  timeout:", config["server", "timeout"]
}
' config.ini
```

---

## EJEMPLO 6: Sistema de Pipeline (AWK con Pipes)

```bash
# Generar datos, procesarlos con AWK, y visualizarlos
echo -e "10\n5\n8\n12\n3\n15" | awk '
{
    # Guardar datos
    datos[NR] = $1
    suma += $1
    if ($1 > max) max = $1
}
END {
    promedio = suma / NR

    print "ESTADÍSTICAS:"
    print "  Total:", suma
    print "  Promedio:", promedio
    print "  Máximo:", max

    print "\nGRÁFICO DE BARRAS:"
    for (i = 1; i <= NR; i++) {
        printf "%3d: ", datos[i]

        # Crear barra proporcional
        barras = int((datos[i] / max) * 20)
        for (j = 1; j <= barras; j++) {
            printf "█"
        }
        print ""
    }
}
'
```

---

## EJEMPLO 7: Procesamiento de JSON Simple

Archivo `datos.json`:
```
{"nombre":"Juan","edad":30,"ciudad":"Madrid"}
{"nombre":"María","edad":25,"ciudad":"Barcelona"}
{"nombre":"Pedro","edad":35,"ciudad":"Valencia"}
```

```bash
awk -F'[":,{}]+' '
{
    # Extraer campos del JSON simple
    for (i = 1; i <= NF; i++) {
        if ($i == "nombre") nombre = $(i+1)
        if ($i == "edad") edad = $(i+1)
        if ($i == "ciudad") ciudad = $(i+1)
    }

    # Limpiar espacios
    gsub(/^[ \t]+|[ \t]+$/, "", nombre)
    gsub(/^[ \t]+|[ \t]+$/, "", edad)
    gsub(/^[ \t]+|[ \t]+$/, "", ciudad)

    if (nombre != "") {
        printf "%-10s | Edad: %2d | Ciudad: %-10s\n", nombre, edad, ciudad
    }
}
' datos.json
```

---

## EJEMPLO 8: Procesar Logs de Apache/Nginx

Archivo `access.log`:
```
192.168.1.10 - - [15/Jan/2024:10:23:15 +0000] "GET /index.html HTTP/1.1" 200 2326
192.168.1.20 - - [15/Jan/2024:10:24:33 +0000] "GET /api/users HTTP/1.1" 200 1543
192.168.1.10 - - [15/Jan/2024:10:25:01 +0000] "POST /api/login HTTP/1.1" 401 156
192.168.1.30 - - [15/Jan/2024:10:26:15 +0000] "GET /products HTTP/1.1" 404 324
192.168.1.20 - - [15/Jan/2024:10:27:22 +0000] "GET /index.html HTTP/1.1" 200 2326
```

```bash
awk '
{
    # Extraer campos del log
    ip = $1
    fecha = substr($4, 2)
    metodo = substr($6, 2)
    url = $7
    codigo = $9
    bytes = $10

    # Estadísticas por IP
    requests_por_ip[ip]++
    bytes_por_ip[ip] += bytes

    # Estadísticas por código
    codigos[codigo]++

    # Estadísticas por URL
    urls[url]++

    # Total
    total_bytes += bytes
    total_requests++
}

END {
    print "╔════════════════════════════════════════════╗"
    print "║      ANÁLISIS DE LOGS DE ACCESO           ║"
    print "╠════════════════════════════════════════════╣"

    print "\nREQUESTS POR IP:"
    for (ip in requests_por_ip) {
        kb = bytes_por_ip[ip] / 1024
        printf "  %-15s: %3d requests, %.1f KB\n", ip, requests_por_ip[ip], kb
    }

    print "\nCÓDIGOS DE RESPUESTA:"
    for (cod in codigos) {
        printf "  %s: %d\n", cod, codigos[cod]
    }

    print "\nURLs MÁS ACCEDIDAS:"
    for (url in urls) {
        printf "  %-20s: %d veces\n", url, urls[url]
    }

    print "\n╠════════════════════════════════════════════╣"
    printf "║ Total Requests: %-26d ║\n", total_requests
    printf "║ Total Bytes: %-29.0f ║\n", total_bytes
    printf "║ Total KB: %-32.1f ║\n", total_bytes/1024
    print "╚════════════════════════════════════════════╝"
}
' access.log
```

---

## EJEMPLO 9: Análisis de CSV Complejo

Archivo `ventas_tienda.csv`:
```
fecha,tienda,producto,cantidad,precio_unitario,vendedor
2024-01-15,Norte,Laptop,2,1200.00,Juan
2024-01-15,Sur,Mouse,10,25.00,María
2024-01-15,Norte,Teclado,5,75.00,Juan
2024-01-16,Este,Laptop,1,1200.00,Pedro
2024-01-16,Sur,Monitor,3,350.00,María
2024-01-16,Oeste,Mouse,8,25.00,Ana
```

```bash
awk -F',' '
# Saltar encabezado
NR == 1 {
    # Guardar nombres de columnas si es necesario
    for (i = 1; i <= NF; i++) {
        col_names[i] = $i
    }
    next
}

{
    fecha = $1
    tienda = $2
    producto = $3
    cantidad = $4
    precio = $5
    vendedor = $6

    total = cantidad * precio

    # Acumuladores multidimensionales
    ventas_tienda[tienda] += total
    ventas_producto[producto] += total
    ventas_vendedor[vendedor] += total
    ventas_fecha[fecha] += total

    # Contadores
    unidades_producto[producto] += cantidad

    # Total general
    total_general += total
}

END {
    print "═══════════════════════════════════════════════════════════"
    print "              REPORTE DE VENTAS CONSOLIDADO"
    print "═══════════════════════════════════════════════════════════\n"

    # Ventas por tienda
    print "VENTAS POR TIENDA:"
    for (t in ventas_tienda) {
        porcentaje = (ventas_tienda[t] / total_general) * 100
        printf "  %-10s: $%10.2f (%5.1f%%)\n", t, ventas_tienda[t], porcentaje
    }

    # Ventas por producto
    print "\nVENTAS POR PRODUCTO:"
    for (p in ventas_producto) {
        printf "  %-10s: %3d unidades = $%10.2f\n",
               p, unidades_producto[p], ventas_producto[p]
    }

    # Ventas por vendedor
    print "\nVENTAS POR VENDEDOR:"
    max_venta = 0
    mejor_vendedor = ""
    for (v in ventas_vendedor) {
        printf "  %-10s: $%10.2f\n", v, ventas_vendedor[v]
        if (ventas_vendedor[v] > max_venta) {
            max_venta = ventas_vendedor[v]
            mejor_vendedor = v
        }
    }

    # Ventas por fecha
    print "\nVENTAS POR FECHA:"
    for (f in ventas_fecha) {
        printf "  %s: $%10.2f\n", f, ventas_fecha[f]
    }

    print "\n═══════════════════════════════════════════════════════════"
    printf "TOTAL GENERAL: $%.2f\n", total_general
    printf "MEJOR VENDEDOR: %s ($%.2f)\n", mejor_vendedor, max_venta
    print "═══════════════════════════════════════════════════════════"
}
' ventas_tienda.csv
```

---

## EJEMPLO 10: Generar Código SQL desde CSV

```bash
awk -F',' '
NR == 1 { next }  # Saltar encabezado

BEGIN {
    print "-- SQL generado automáticamente"
    print "-- Fecha:", strftime("%Y-%m-%d %H:%M:%S")
    print ""
}

{
    nombre = $1
    edad = $2
    ciudad = $3

    # Limpiar comillas si existen
    gsub(/"/, "", nombre)
    gsub(/"/, "", ciudad)

    # Generar INSERT
    printf "INSERT INTO personas (nombre, edad, ciudad) VALUES ('\''%s'\'', %d, '\''%s'\'');\n",
           nombre, edad, ciudad
}

END {
    print ""
    print "-- Total de registros:", NR - 1
}
' datos.csv
```

---

## EJEMPLO 11: Convertir CSV a JSON

```bash
awk -F',' '
NR == 1 {
    # Guardar encabezados
    for (i = 1; i <= NF; i++) {
        headers[i] = $i
    }
    next
}

{
    printf "{\n"
    for (i = 1; i <= NF; i++) {
        # Limpiar espacios
        value = $i
        gsub(/^[ \t]+|[ \t]+$/, "", value)

        # Determinar si es número o string
        if (value ~ /^[0-9]+(\.[0-9]+)?$/) {
            # Es número
            printf "  \"%s\": %s", headers[i], value
        } else {
            # Es string
            printf "  \"%s\": \"%s\"", headers[i], value
        }

        if (i < NF) printf ","
        printf "\n"
    }
    printf "}"
    if (NR > 2) printf ","
    printf "\n"
}

BEGIN { print "[" }
END { print "]" }
' datos.csv
```

---

## EJEMPLO 12: Monitoreo de Procesos del Sistema

```bash
# Analizar salida de ps
ps aux | awk '
NR == 1 {
    # Encabezado
    print $0
    next
}

{
    user = $1
    pid = $2
    cpu = $3
    mem = $4
    command = $11

    # Acumular por usuario
    cpu_por_usuario[user] += cpu
    mem_por_usuario[user] += mem
    procesos_por_usuario[user]++

    # Encontrar proceso que más consume CPU
    if (cpu > max_cpu) {
        max_cpu = cpu
        max_cpu_process = command
        max_cpu_pid = pid
    }
}

END {
    print "\n╔════════════════════════════════════════════╗"
    print "║      RESUMEN DE PROCESOS POR USUARIO       ║"
    print "╠════════════════════════════════════════════╣"

    for (u in cpu_por_usuario) {
        printf "║ %-10s | CPU: %5.1f%% | MEM: %5.1f%% | Procs: %3d ║\n",
               u, cpu_por_usuario[u], mem_por_usuario[u], procesos_por_usuario[u]
    }

    print "╠════════════════════════════════════════════╣"
    printf "║ Proceso con más CPU: %-20s ║\n", max_cpu_process
    printf "║ PID: %-5d | CPU: %5.1f%%                    ║\n", max_cpu_pid, max_cpu
    print "╚════════════════════════════════════════════╝"
}
'
```

---

## EJEMPLO 13: Análisis de Archivos de Código Fuente

```bash
# Contar líneas de código, comentarios y vacías en archivos Python
find . -name "*.py" -exec awk '
BEGIN { archivo = FILENAME }

# Líneas vacías
/^[ \t]*$/ { vacias++; next }

# Comentarios (líneas que empiezan con #)
/^[ \t]*#/ { comentarios++; next }

# Líneas de código
{ codigo++ }

FILENAME != archivo {
    # Cambio de archivo
    print archivo ":"
    printf "  Código: %d | Comentarios: %d | Vacías: %d\n",
           codigo, comentarios, vacias
    archivo = FILENAME
    total_codigo += codigo
    total_comentarios += comentarios
    total_vacias += vacias
    codigo = comentarios = vacias = 0
}

END {
    if (FILENAME != "") {
        print archivo ":"
        printf "  Código: %d | Comentarios: %d | Vacías: %d\n",
               codigo, comentarios, vacias
        total_codigo += codigo
        total_comentarios += comentarios
        total_vacias += vacias
    }

    print "\n════════════════════════════════"
    print "TOTALES:"
    print "  Líneas de código:", total_codigo
    print "  Comentarios:", total_comentarios
    print "  Líneas vacías:", total_vacias
    print "  TOTAL:", total_codigo + total_comentarios + total_vacias
}
' {} +
```

---

## EJEMPLO 14: Generar Reporte HTML

```bash
awk -F',' '
BEGIN {
    print "<!DOCTYPE html>"
    print "<html><head>"
    print "<title>Reporte de Ventas</title>"
    print "<style>"
    print "table { border-collapse: collapse; width: 100%; }"
    print "th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }"
    print "th { background-color: #4CAF50; color: white; }"
    print "tr:nth-child(even) { background-color: #f2f2f2; }"
    print "</style>"
    print "</head><body>"
    print "<h1>Reporte de Ventas</h1>"
    print "<table>"
}

NR == 1 {
    # Encabezado
    print "<tr>"
    for (i = 1; i <= NF; i++) {
        print "<th>" $i "</th>"
    }
    print "<th>Total</th>"
    print "</tr>"
    next
}

{
    total = $4 * $5
    print "<tr>"
    for (i = 1; i <= NF; i++) {
        print "<td>" $i "</td>"
    }
    printf "<td>$%.2f</td>\n", total
    print "</tr>"

    suma_total += total
}

END {
    print "</table>"
    printf "<h2>Total General: $%.2f</h2>\n", suma_total
    print "</body></html>"
}
' ventas_tienda.csv > reporte.html
```

---

## EJEMPLO 15: Procesamiento de Logs Multi-línea

Archivo `error.log`:
```
[2024-01-15 10:23:15] ERROR: Database connection failed
  at connect() line 45
  at main() line 10
[2024-01-15 10:25:30] INFO: System started
[2024-01-15 10:30:12] ERROR: File not found: /tmp/data.txt
  at readFile() line 78
```

```bash
awk '
/^\[.*\] ERROR:/ {
    # Inicio de error
    fecha = substr($1, 2, length($1) - 1)
    time = substr($2, 1, length($2) - 1)
    mensaje = substr($0, index($0, "ERROR:") + 7)

    errores++

    # Leer stack trace (líneas que empiezan con espacios)
    stack = ""
    while ((getline) > 0) {
        if ($0 ~ /^[ \t]+at/) {
            stack = stack "\n  " $0
        } else {
            # Fin del stack trace, procesar siguiente línea normal
            # Guardar la línea para procesarla después
            ultima_linea = $0
            break
        }
    }

    # Imprimir error formateado
    printf "\n══════════════════════════════════════════\n"
    printf "ERROR #%d\n", errores
    printf "Fecha/Hora: %s %s\n", fecha, time
    printf "Mensaje: %s\n", mensaje
    if (stack != "") {
        print "Stack Trace:" stack
    }
    printf "══════════════════════════════════════════\n"

    # Si hay una línea guardada, procesarla
    if (ultima_linea != "" && ultima_linea ~ /^\[.*\]/) {
        $0 = ultima_linea
        ultima_linea = ""
    }
}

END {
    print "\nTotal de errores encontrados:", errores
}
' error.log
```

---

## BEST PRACTICES Y OPTIMIZACIÓN

### 1. Evitar Expresiones Regulares Innecesarias

```bash
# ❌ LENTO
awk '/pattern/ { if ($1 == "value") print }'

# ✓ RÁPIDO
awk '$1 == "value" && /pattern/ { print }'
```

### 2. Usar Variables en Lugar de Subcadenas Repetidas

```bash
# ❌ INEFICIENTE
awk '{ print substr($1, 1, 5), substr($1, 1, 5), substr($1, 1, 5) }'

# ✓ EFICIENTE
awk '{ prefix = substr($1, 1, 5); print prefix, prefix, prefix }'
```

### 3. Evitar Llamadas a Comandos Externos

```bash
# ❌ LENTO (ejecuta date por cada línea)
awk '{ "date" | getline fecha; print $0, fecha }'

# ✓ RÁPIDO (ejecuta date una sola vez)
awk 'BEGIN { "date" | getline fecha } { print $0, fecha }'
```

### 4. Usar Arrays en Lugar de Múltiples Variables

```bash
# ❌ POCO MANTENIBLE
awk '{ suma1 += $1; suma2 += $2; suma3 += $3 }'

# ✓ MEJOR
awk '{ for (i=1; i<=NF; i++) suma[i] += $i }'
```

---

## EJERCICIOS PRÁCTICOS FINALES

### Proyecto 1: Analizador de Logs de Servidor Web

Crea un script que:
- Lea logs de Apache/Nginx
- Genere estadísticas por IP, URL, código de estado
- Detecte patrones sospechosos (muchos 404, muchos requests de una IP)
- Genere reporte HTML con gráficos de texto

### Proyecto 2: Procesador de Datos Financieros

Crea un script que:
- Lea archivo CSV de transacciones bancarias
- Categorice transacciones automáticamente
- Calcule balance diario, mensual
- Genere alertas de gastos inusuales
- Exporte a formato SQL e HTML

### Proyecto 3: Monitor de Sistema

Crea un script que:
- Use comandos del sistema (ps, df, free, etc.)
- Procese la salida con AWK
- Genere alertas si CPU/memoria/disco superan umbrales
- Genere reporte histórico

### Proyecto 4: Conversor de Formatos

Crea un script que:
- Convierta entre CSV, JSON, XML, SQL
- Valide datos durante la conversión
- Maneje errores graciosamente
- Genere logs de conversión

---

## RECURSOS ADICIONALES

### Documentación Oficial
- Manual de GNU AWK: `man gawk`
- The AWK Programming Language (Aho, Weinberger, Kernighan)

### Comandos Útiles para Combinar con AWK
```bash
# Ordenar resultados
awk '...' file | sort -n

# Filtrar resultados
awk '...' file | grep pattern

# Contar resultados
awk '...' file | wc -l

# Eliminar duplicados
awk '...' file | sort -u

# Paginar resultados
awk '...' file | less
```

### Debugging AWK

```bash
# Usar gawk con --dump-variables
gawk --dump-variables '{ print $1 }' file

# Agregar prints de debug
awk '{ print "DEBUG:", $0, NR, NF > "/dev/stderr"; ... }'

# Usar opciones de profiling
gawk --profile '{ ... }' file
```

---

## SOLUCIONES A EJERCICIOS FINALES

Las soluciones completas están en `../soluciones/06-soluciones-avanzadas.md`

---

## CONCLUSIÓN DEL CURSO

¡Felicitaciones! Has completado el curso de AWK desde principiante hasta avanzado.

### Lo que has aprendido:

✅ **Módulo 1:** Fundamentos de AWK, variables básicas, print y printf
✅ **Módulo 2:** Patrones, expresiones regulares, operadores
✅ **Módulo 3:** Variables integradas, funciones de string y matemáticas
✅ **Módulo 4:** Arrays asociativos, estructuras de datos
✅ **Módulo 5:** Control de flujo, funciones personalizadas, recursividad
✅ **Módulo 6:** Técnicas avanzadas, getline, casos de uso reales

### Siguientes Pasos:

1. **Practica regularmente**: Usa AWK en tus tareas diarias
2. **Combina con otras herramientas**: sed, grep, sort, uniq
3. **Lee código de otros**: Busca scripts AWK en GitHub
4. **Resuelve problemas reales**: Procesa tus propios logs y datos
5. **Contribuye**: Comparte tus scripts con la comunidad

### Recursos para Continuar:

- Stackexchange: Preguntas y respuestas de AWK
- GitHub: Busca "awesome-awk" para colecciones de scripts
- GNU AWK Manual: Referencia completa
- The AWK Programming Language: Libro clásico

---

## ¡GRACIAS POR COMPLETAR EL CURSO!

AWK es una herramienta poderosa que, dominada correctamente, puede ahorrarte
horas de trabajo en procesamiento de texto y análisis de datos.

**Keep AWKing!** 🚀
