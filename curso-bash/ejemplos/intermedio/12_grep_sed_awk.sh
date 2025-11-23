#!/bin/bash

################################################################################
# Ejemplo 12: GREP, SED y AWK
# Descripción: Domina las herramientas de procesamiento de texto
# Nivel: Intermedio
################################################################################

# Crear archivo de datos para ejemplos
cat > empleados.txt << EOF
ID,Nombre,Edad,Departamento,Salario
001,Juan Pérez,30,Ventas,45000
002,María García,28,IT,55000
003,Pedro López,35,Ventas,48000
004,Ana Martínez,32,IT,60000
005,Luis Rodríguez,29,Marketing,42000
006,Carmen Sánchez,31,IT,58000
007,José Fernández,27,Ventas,40000
EOF

echo "=== GREP: BUSCAR EN ARCHIVOS ==="

# Búsqueda básica
echo "Empleados de IT:"
grep "IT" empleados.txt

# Case insensitive
echo -e "\nBúsqueda sin distinguir mayúsculas:"
grep -i "ventas" empleados.txt

# Contar coincidencias
echo -e "\nNúmero de empleados en IT:"
grep -c "IT" empleados.txt

# Mostrar número de línea
echo -e "\nCon números de línea:"
grep -n "IT" empleados.txt

# Invertir coincidencia (líneas que NO contienen)
echo -e "\nEmpleados NO de IT:"
grep -v "IT" empleados.txt | tail -n +2

# Mostrar solo la parte que coincide
echo -e "\nSolo los departamentos:"
grep -o "IT\|Ventas\|Marketing" empleados.txt

echo -e "\n=== GREP CON REGEX ==="

# Buscar con expresiones regulares
echo "Empleados de 30 a 35 años:"
grep -E ",(3[0-5])," empleados.txt

# Buscar múltiples patrones
echo -e "\nIT o Marketing:"
grep -E "IT|Marketing" empleados.txt

# Buscar al inicio de línea
echo -e "\nIDs que empiezan con 00:"
grep "^00" empleados.txt

# Buscar al final de línea
echo -e "\nSalarios de 60000:"
grep "60000$" empleados.txt

echo -e "\n=== GREP RECURSIVO ==="

# Crear estructura de archivos
mkdir -p proyecto/{src,docs,tests}
echo "código python" > proyecto/src/main.py
echo "documentación" > proyecto/docs/README.md
echo "tests unitarios" > proyecto/tests/test.py

# Buscar en directorios recursivamente
echo "Buscar 'python' en todos los archivos:"
grep -r "python" proyecto/ 2>/dev/null

# Buscar solo en archivos específicos
echo -e "\nSolo en archivos .py:"
grep -r --include="*.py" "python" proyecto/ 2>/dev/null

echo -e "\n=== SED: EDITOR DE STREAM ==="

# Sustitución básica (primera ocurrencia)
echo "Reemplazar primera 'IT' por 'Tecnología':"
sed 's/IT/Tecnología/' empleados.txt | head -3

# Sustitución global (todas las ocurrencias)
echo -e "\nReemplazar todas las 'IT':"
sed 's/IT/Tecnología/g' empleados.txt | head -3

# Sustitución en línea específica
echo -e "\nReemplazar solo en línea 3:"
sed '3s/Ventas/Comercial/' empleados.txt | head -5

# Eliminar líneas
echo -e "\nEliminar línea 2:"
sed '2d' empleados.txt | head -4

# Eliminar líneas que coinciden con patrón
echo -e "\nEliminar líneas con 'Ventas':"
sed '/Ventas/d' empleados.txt

# Imprimir solo líneas específicas
echo -e "\nSolo líneas 2-4:"
sed -n '2,4p' empleados.txt

echo -e "\n=== SED AVANZADO ==="

# Múltiples sustituciones
echo "Múltiples cambios:"
sed -e 's/IT/Tecnología/g' -e 's/Ventas/Comercial/g' empleados.txt | head -4

# Agregar texto al inicio de línea
echo -e "\nAgregar '>> ' al inicio:"
sed 's/^/>> /' empleados.txt | head -3

# Agregar texto al final de línea
echo -e "\nAgregar ' <<' al final:"
sed 's/$/ <</' empleados.txt | head -3

# Insertar línea antes
echo -e "\nInsertar línea antes de línea 2:"
sed '2i\--- EMPLEADOS ---' empleados.txt | head -4

# Insertar línea después
echo -e "\nInsertar línea después de línea 1:"
sed '1a\--- DATOS ---' empleados.txt | head -3

# Reemplazar línea completa
echo -e "\nReemplazar línea 2:"
sed '2c\002,Nuevo Empleado,25,IT,50000' empleados.txt | head -3

echo -e "\n=== AWK: PROCESAMIENTO DE COLUMNAS ==="

# Imprimir columnas específicas
echo "Nombres y departamentos:"
awk -F',' '{print $2, $4}' empleados.txt | head -5

# Imprimir con formato
echo -e "\nCon formato:"
awk -F',' '{printf "%-20s %s\n", $2, $4}' empleados.txt | head -5

# Filtrar con condiciones
echo -e "\nSalarios mayores a 50000:"
awk -F',' '$5 > 50000 {print $2, $5}' empleados.txt

# Calcular suma
echo -e "\nSuma total de salarios:"
awk -F',' 'NR>1 {suma+=$5} END {print "Total: $" suma}' empleados.txt

# Calcular promedio
echo -e "\nPromedio de salarios:"
awk -F',' 'NR>1 {suma+=$5; cont++} END {print "Promedio: $" suma/cont}' empleados.txt

# Contar líneas
echo -e "\nTotal de empleados:"
awk 'END {print NR-1}' empleados.txt

echo -e "\n=== AWK VARIABLES Y OPERADORES ==="

# Variables incorporadas
echo "Variables de AWK:"
awk -F',' 'NR==2 {
    print "NR (número de línea):", NR
    print "NF (número de campos):", NF
    print "Primer campo:", $1
    print "Último campo:", $NF
}' empleados.txt

# Operadores
echo -e "\nEmpleados de IT con salario > 55000:"
awk -F',' '$4=="IT" && $5>55000 {print $2, $5}' empleados.txt

# Pattern matching
echo -e "\nNombres que contienen 'María' o 'Ana':"
awk -F',' '$2 ~ /María|Ana/ {print $2}' empleados.txt

echo -e "\n=== AWK BLOQUES BEGIN/END ==="

# BEGIN se ejecuta antes de procesar
# END se ejecuta después de procesar
echo "Reporte formateado:"
awk -F',' '
BEGIN {
    print "========================================="
    print "       REPORTE DE EMPLEADOS"
    print "========================================="
}
NR>1 {
    print $2 " - " $4 " - $" $5
    total += $5
}
END {
    print "========================================="
    print "Salario total: $" total
    print "========================================="
}' empleados.txt

echo -e "\n=== AWK FUNCIONES ==="

# Funciones de string
echo "Procesamiento de texto:"
awk -F',' 'NR>1 {
    print "Original:", $2
    print "Mayúsculas:", toupper($2)
    print "Minúsculas:", tolower($2)
    print "Longitud:", length($2)
    print "---"
}' empleados.txt | head -8

# Funciones matemáticas
echo -e "\nFunciones matemáticas:"
awk '
BEGIN {
    print "sqrt(16) =", sqrt(16)
    print "int(3.7) =", int(3.7)
    print "sin(0) =", sin(0)
    print "cos(0) =", cos(0)
}'

echo -e "\n=== COMBINANDO HERRAMIENTAS ==="

# Pipeline complejo
echo "Empleados de IT, ordenados por salario (mayor a menor):"
grep "IT" empleados.txt | \
    awk -F',' '{print $2, $5}' | \
    sort -t' ' -k2 -rn

# Estadísticas por departamento
echo -e "\nEmpleados por departamento:"
tail -n +2 empleados.txt | \
    awk -F',' '{print $4}' | \
    sort | \
    uniq -c

echo -e "\n=== EJEMPLO PRÁCTICO: PROCESAR LOG ==="

# Crear log de servidor
cat > access.log << EOF
192.168.1.100 - - [15/Jan/2024:10:30:15] "GET /index.html" 200 1234
192.168.1.101 - - [15/Jan/2024:10:31:22] "POST /api/login" 200 567
192.168.1.100 - - [15/Jan/2024:10:32:45] "GET /dashboard" 200 2345
192.168.1.102 - - [15/Jan/2024:10:33:10] "GET /api/data" 404 89
192.168.1.101 - - [15/Jan/2024:10:34:55] "POST /api/logout" 500 234
192.168.1.103 - - [15/Jan/2024:10:35:20] "GET /index.html" 200 1234
EOF

echo "Análisis de access.log:"

# Contar requests por IP
echo -e "\nRequests por IP:"
awk '{print $1}' access.log | sort | uniq -c | sort -rn

# Errores (códigos 4xx y 5xx)
echo -e "\nErrores:"
awk '$9 >= 400 {print $0}' access.log

# Páginas más visitadas
echo -e "\nPáginas más visitadas:"
awk '{print $7}' access.log | sort | uniq -c | sort -rn

# Total de bytes transferidos
echo -e "\nBytes transferidos:"
awk '{sum+=$10} END {print "Total:", sum, "bytes"}' access.log

echo -e "\n=== EJEMPLO PRÁCTICO: CONVERTIR CSV A TSV ==="

echo "Convertir CSV a TSV (tab-separated):"
sed 's/,/\t/g' empleados.txt > empleados.tsv
echo "✓ Creado empleados.tsv"
head -3 empleados.tsv

echo -e "\n=== EJEMPLO PRÁCTICO: EXTRAER COLUMNA ==="

# Extraer solo nombres y salarios
echo "Crear reporte de salarios:"
awk -F',' 'NR==1 {print $2","$5} NR>1 {print $2","$5}' empleados.txt > salarios.csv
echo "✓ Creado salarios.csv"
cat salarios.csv

echo -e "\n=== EJEMPLO PRÁCTICO: BUSCAR Y REEMPLAZAR EN MÚLTIPLES ARCHIVOS ==="

# Crear archivos
mkdir -p config
cat > config/app.conf << EOF
server=localhost
port=8080
debug=true
EOF

cat > config/db.conf << EOF
server=localhost
database=mydb
port=5432
EOF

echo "Cambiar 'localhost' por '192.168.1.1' en todos los archivos:"
# Simular cambio (sin -i para no modificar realmente)
grep -r "localhost" config/ | sed 's/localhost/192.168.1.1/'

echo -e "\n=== EJEMPLO PRÁCTICO: ANÁLISIS DE DATOS ==="

# Estadísticas por departamento
echo "Salario promedio por departamento:"
tail -n +2 empleados.txt | awk -F',' '
{
    dept[$4] += $5
    count[$4]++
}
END {
    for (d in dept) {
        printf "%-15s $%.2f\n", d, dept[d]/count[d]
    }
}' | sort -k2 -rn

# Empleado con mayor/menor salario
echo -e "\nEmpleado con mayor salario:"
tail -n +2 empleados.txt | awk -F',' '
NR==1 || $5 > max {max=$5; nombre=$2; dept=$4}
END {print nombre, "-", dept, "- $" max}
'

echo -e "\nEmpleado con menor salario:"
tail -n +2 empleados.txt | awk -F',' '
NR==1 {min=$5}
$5 < min {min=$5; nombre=$2; dept=$4}
END {print nombre, "-", dept, "- $" min}
'

echo -e "\n=== EJEMPLO PRÁCTICO: FORMATEAR TEXTO ==="

# Crear texto sin formato
cat > texto_plano.txt << EOF
esto es un texto sin formato
con varias líneas
que necesita ser formateado
EOF

echo "Texto original:"
cat texto_plano.txt

echo -e "\nTexto formateado (primera letra mayúscula):"
sed 's/\b\(.\)/\u\1/g' texto_plano.txt

echo -e "\nTexto con numeración:"
sed = texto_plano.txt | sed 'N;s/\n/. /'

echo -e "\n=== LIMPIEZA ==="

rm -f empleados.txt empleados.tsv salarios.csv access.log
rm -f texto_plano.txt
rm -rf proyecto config

echo "✓ Archivos de prueba eliminados"
echo -e "\n¡GREP, SED y AWK completados!"
