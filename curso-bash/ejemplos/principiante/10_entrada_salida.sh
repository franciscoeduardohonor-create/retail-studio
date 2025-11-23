#!/bin/bash

################################################################################
# Ejemplo 10: Entrada/Salida y Redirecciones
# Descripción: Aprende a redirigir entrada, salida y errores en BASH
# Nivel: Principiante
################################################################################

echo "=== SALIDA ESTÁNDAR (stdout) ==="

# stdout es la salida normal de los comandos
echo "Esto va a stdout (pantalla)"
echo "También puedo mostrar variables: $USER"

# Mostrar sin salto de línea
echo -n "Sin salto de línea... "
echo "continúa aquí"

echo -e "\n=== REDIRIGIR SALIDA A ARCHIVO ==="

# > redirige stdout a un archivo (sobrescribe)
echo "Primera línea" > salida.txt
echo "✓ Contenido escrito en salida.txt"

# Sobrescribir
echo "Nueva primera línea" > salida.txt
echo "✓ Archivo sobrescrito"

cat salida.txt

echo -e "\n=== AÑADIR A ARCHIVO ==="

# >> añade al final del archivo
echo "Primera línea" > log.txt
echo "Segunda línea" >> log.txt
echo "Tercera línea" >> log.txt
echo "✓ Líneas añadidas a log.txt"

echo "Contenido de log.txt:"
cat log.txt

echo -e "\n=== ERROR ESTÁNDAR (stderr) ==="

# stderr es para mensajes de error (descriptor 2)
echo "Mensaje normal a stdout"
echo "Mensaje de error a stderr" >&2

# Comando que genera error
ls archivo_inexistente.txt 2>/dev/null || echo "✓ Error suprimido"

echo -e "\n=== REDIRIGIR ERRORES ==="

# 2> redirige stderr a un archivo
echo "Intentando listar archivo inexistente..."
ls archivo_inexistente.txt 2> errores.log

if [ -s errores.log ]; then
    echo "✓ Error guardado en errores.log:"
    cat errores.log
fi

echo -e "\n=== REDIRIGIR TODO ==="

# &> redirige stdout y stderr al mismo archivo
# Crear comando que genera salida y error
{
    echo "Salida normal"
    ls archivo_inexistente.txt
} &> todo.log 2>&1

echo "✓ Todo redirigido a todo.log:"
cat todo.log

echo -e "\n=== SEPARAR SALIDA Y ERRORES ==="

# Redirigir a archivos diferentes
{
    echo "Salida correcta"
    ls archivo_inexistente.txt
} > salida_ok.txt 2> salida_error.txt

echo "Salida normal:"
cat salida_ok.txt 2>/dev/null
echo -e "\nErrores:"
cat salida_error.txt 2>/dev/null

echo -e "\n=== /dev/null (DESCARTAR) ==="

# /dev/null es como un agujero negro, todo lo que va ahí desaparece
echo "Este mensaje se verá"
echo "Este mensaje desaparece" > /dev/null
echo "✓ Mensaje descartado en /dev/null"

# Descartar errores
ls archivo_inexistente.txt 2>/dev/null
echo "✓ Error descartado"

# Descartar todo
ls archivo_inexistente.txt &> /dev/null
echo "✓ Todo descartado"

echo -e "\n=== ENTRADA ESTÁNDAR (stdin) ==="

# < redirige stdin desde un archivo
cat < log.txt
echo "✓ Contenido leído desde archivo"

# Ejemplo con while
echo -e "\nLeyendo línea por línea:"
while read linea; do
    echo "  -> $linea"
done < log.txt

echo -e "\n=== HERE DOCUMENT (<<) ==="

# Here document permite crear entrada multi-línea
cat > documento.txt << EOF
Este es un documento
con múltiples líneas
creado con here document.
EOF

echo "✓ Documento creado:"
cat documento.txt

# Here document con variables
nombre="BASH"
cat << EOF

Hola desde $nombre
La fecha es: $(date +%Y-%m-%d)
Usuario: $USER
EOF

# Here document sin expandir variables (usar 'EOF')
cat << 'EOF'

Esto no expande: $nombre
Literal: $(date)
EOF

echo -e "\n=== HERE STRING (<<<) ==="

# Here string pasa un string como entrada
cat <<< "Esta es una línea única"

# Útil con comandos
while read palabra; do
    echo "  - $palabra"
done <<< "Manzana
Pera
Uva"

echo -e "\n=== PIPES (|) ==="

# Pipe conecta stdout de un comando con stdin del siguiente
echo "Usando pipes:"

# Ejemplo 1: contar líneas
echo -e "uno\ndos\ntres" | wc -l

# Ejemplo 2: buscar y contar
echo "Contar archivos .sh:"
ls -1 *.sh 2>/dev/null | wc -l

# Ejemplo 3: cadena de pipes
echo "Los tres primeros archivos:"
ls -1 2>/dev/null | head -3 | sort

echo -e "\n=== TEE (DUPLICAR SALIDA) ==="

# tee envía la salida tanto a pantalla como a archivo
echo "Este mensaje va a pantalla y archivo" | tee mensaje.txt
echo "✓ Mensaje guardado en mensaje.txt"

# tee con append
echo "Segunda línea" | tee -a mensaje.txt > /dev/null
echo "✓ Línea añadida (sin mostrar en pantalla)"

cat mensaje.txt

echo -e "\n=== COMMAND SUBSTITUTION ==="

# Capturar salida de comando en variable
fecha=$(date +%Y-%m-%d)
echo "Fecha capturada: $fecha"

# Múltiples comandos
archivos=$(ls -1 *.txt 2>/dev/null | wc -l)
echo "Número de archivos .txt: $archivos"

# Forma antigua (backticks) - no recomendado
usuario=`whoami`
echo "Usuario (backticks): $usuario"

echo -e "\n=== PROCESS SUBSTITUTION ==="

# <() crea un archivo temporal con la salida del comando
# Útil para comandos que esperan archivos

# Comparar salidas de dos comandos
diff <(echo "contenido A") <(echo "contenido B") || echo "✓ Contenidos diferentes"

# Otro ejemplo
echo "Comparando listados:"
diff <(ls /tmp | head -3) <(ls /home 2>/dev/null | head -3) &> /dev/null || echo "✓ Directorios tienen contenido diferente"

echo -e "\n=== EJEMPLO PRÁCTICO: LOGGER ==="

# Función de logging
log() {
    local nivel=$1
    shift
    local mensaje="$@"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')

    echo "[$timestamp] [$nivel] $mensaje" | tee -a app.log
}

# Usar logger
log "INFO" "Aplicación iniciada"
log "WARNING" "Memoria baja"
log "ERROR" "Falló la conexión"

echo -e "\nContenido de app.log:"
cat app.log

echo -e "\n=== EJEMPLO PRÁCTICO: SCRIPT CON LOGS ==="

# Script que registra éxitos y errores por separado
procesar_archivo() {
    local archivo=$1

    if [ -f "$archivo" ]; then
        echo "✓ Procesando: $archivo" >> success.log
        return 0
    else
        echo "✗ No existe: $archivo" >> error.log
        return 1
    fi
}

# Limpiar logs anteriores
> success.log
> error.log

# Procesar varios archivos
procesar_archivo "log.txt"
procesar_archivo "inexistente.txt"
procesar_archivo "documento.txt"

echo "Éxitos:"
cat success.log
echo -e "\nErrores:"
cat error.log

echo -e "\n=== EJEMPLO PRÁCTICO: PIPELINE COMPLEJO ==="

# Crear archivo con datos
cat > datos.csv << EOF
Nombre,Edad,Ciudad
Juan,25,Madrid
María,30,Barcelona
Pedro,22,Valencia
Ana,28,Sevilla
Luis,35,Bilbao
EOF

echo "Procesando datos.csv:"
echo "Personas mayores de 25 años:"

# Pipeline: leer, filtrar, procesar
cat datos.csv | tail -n +2 | while IFS=',' read nombre edad ciudad; do
    if [ $edad -gt 25 ]; then
        echo "  - $nombre ($edad años) de $ciudad"
    fi
done

echo -e "\n=== EJEMPLO PRÁCTICO: CAPTURAR Y VALIDAR ==="

# Ejecutar comando y capturar código de salida
validar_comando() {
    local cmd="$1"

    # Ejecutar y capturar salida y código
    output=$(eval $cmd 2>&1)
    codigo=$?

    if [ $codigo -eq 0 ]; then
        echo "✓ Comando exitoso:"
        echo "$output" | head -3
    else
        echo "✗ Comando falló (código: $codigo)"
        echo "$output" | head -3
    fi

    return $codigo
}

validar_comando "ls log.txt"
validar_comando "ls archivo_inexistente.txt"

echo -e "\n=== DESCRIPTORES DE ARCHIVO PERSONALIZADOS ==="

# Abrir archivo para lectura (descriptor 3)
exec 3< log.txt

# Leer del descriptor
echo "Leyendo del descriptor 3:"
read linea <&3
echo "  Primera línea: $linea"

# Cerrar descriptor
exec 3<&-

# Abrir archivo para escritura (descriptor 4)
exec 4> custom.txt

# Escribir al descriptor
echo "Línea escrita al descriptor 4" >&4
echo "Otra línea" >&4

# Cerrar descriptor
exec 4>&-

echo "✓ Archivo custom.txt creado:"
cat custom.txt

echo -e "\n=== EJEMPLO PRÁCTICO: SCRIPT ROBUSTO ==="

# Script con manejo completo de I/O
procesar_con_logs() {
    local entrada="$1"
    local salida="${entrada}.procesado"
    local errores="${entrada}.errores"

    echo "Procesando $entrada..." | tee -a proceso.log

    # Procesar y separar salida/errores
    if grep "ERROR" "$entrada" > "$errores" 2>&1; then
        echo "  ⚠ Errores encontrados" | tee -a proceso.log
    else
        echo "  ✓ Sin errores" | tee -a proceso.log
    fi

    # Crear archivo procesado
    grep -v "ERROR" "$entrada" 2>/dev/null > "$salida"

    echo "  ✓ Resultado en: $salida" | tee -a proceso.log
}

# Crear archivo de entrada
cat > input.txt << EOF
Línea normal 1
ERROR: Algo salió mal
Línea normal 2
ERROR: Otro error
Línea normal 3
EOF

procesar_con_logs "input.txt"

echo -e "\nArchivo procesado:"
cat input.txt.procesado

echo -e "\n=== LIMPIEZA ==="

# Limpiar archivos de prueba
rm -f salida.txt log.txt errores.log todo.log
rm -f salida_ok.txt salida_error.txt documento.txt mensaje.txt
rm -f app.log success.log error.log datos.csv custom.txt
rm -f proceso.log input.txt input.txt.procesado input.txt.errores

echo "✓ Archivos de prueba eliminados"
echo -e "\n¡Entrada/Salida y Redirecciones completadas!"
