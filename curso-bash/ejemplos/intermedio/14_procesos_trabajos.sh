#!/bin/bash

################################################################################
# Ejemplo 14: Procesos y Trabajos
# Descripción: Aprende a manejar procesos y trabajos en background
# Nivel: Intermedio
################################################################################

echo "=== INFORMACIÓN DE PROCESOS ==="

# PID del script actual
echo "PID de este script: $$"

# PPID (Parent Process ID)
echo "PPID (proceso padre): $PPID"

# Último PID en background
sleep 0.1 &
echo "Último proceso en background: $!"

# Esperar a que termine
wait $!

echo -e "\n=== EJECUTAR EN BACKGROUND ==="

# & ejecuta comando en background
echo "Iniciando proceso en background..."
sleep 2 &
pid_sleep=$!
echo "PID del proceso: $pid_sleep"

# Continuar mientras el proceso corre
echo "Haciendo otras cosas..."
echo "El proceso sigue corriendo en background..."

# Esperar a que termine
wait $pid_sleep
echo "✓ Proceso completado"

echo -e "\n=== MÚLTIPLES PROCESOS EN BACKGROUND ==="

# Ejecutar varios procesos
echo "Iniciando 3 procesos en background..."
sleep 1 &
pid1=$!
sleep 2 &
pid2=$!
sleep 3 &
pid3=$!

echo "PIDs: $pid1, $pid2, $pid3"

# Esperar a todos
echo "Esperando a que terminen todos..."
wait $pid1 $pid2 $pid3
echo "✓ Todos los procesos completados"

echo -e "\n=== WAIT SIN ARGUMENTOS ==="

# wait sin argumentos espera a TODOS los procesos hijos
echo "Iniciando procesos..."
sleep 0.5 &
sleep 0.5 &
sleep 0.5 &

echo "Esperando a todos..."
wait
echo "✓ Todos completados"

echo -e "\n=== VERIFICAR SI PROCESO ESTÁ CORRIENDO ==="

# Iniciar proceso largo
sleep 10 &
pid_largo=$!

# Verificar si está corriendo
if kill -0 $pid_largo 2>/dev/null; then
    echo "✓ Proceso $pid_largo está corriendo"
    # Terminarlo
    kill $pid_largo
    wait $pid_largo 2>/dev/null
    echo "✓ Proceso terminado"
else
    echo "✗ Proceso no está corriendo"
fi

echo -e "\n=== COMANDO JOBS ==="

# Crear varios jobs
echo "Creando jobs..."
sleep 20 &
sleep 30 &
sleep 40 &

# Listar jobs
echo "Jobs actuales:"
jobs

# Matar todos los jobs
echo "Terminando todos los jobs..."
jobs -p | xargs -r kill 2>/dev/null
wait 2>/dev/null

echo -e "\n=== PROCESAMIENTO PARALELO ==="

# Función que simula trabajo
procesar_archivo() {
    local archivo=$1
    echo "  Procesando $archivo..."
    sleep 0.5
    echo "  ✓ $archivo completado"
}

# Crear archivos
mkdir -p /tmp/paralelo_$$
touch /tmp/paralelo_$$/{file1,file2,file3,file4}.txt

# Procesar en paralelo
echo "Procesando archivos en paralelo:"
for archivo in /tmp/paralelo_$$/*.txt; do
    procesar_archivo "$archivo" &
done

# Esperar a todos
wait
echo "✓ Procesamiento paralelo completado"

# Limpiar
rm -rf /tmp/paralelo_$$

echo -e "\n=== LIMITAR PROCESOS CONCURRENTES ==="

# Ejecutar máximo N procesos en paralelo
max_jobs=2
job_count=0

procesar_con_limite() {
    local archivo=$1

    # Esperar si hay muchos jobs
    while [ $(jobs -r | wc -l) -ge $max_jobs ]; do
        sleep 0.1
    done

    # Iniciar nuevo job
    {
        echo "  Procesando $archivo..."
        sleep 0.5
        echo "  ✓ $archivo completado"
    } &
}

echo "Procesando con límite de $max_jobs procesos:"
for i in {1..5}; do
    procesar_con_limite "archivo_$i"
done

wait
echo "✓ Todos completados"

echo -e "\n=== XARGS PARA PARALELIZAR ==="

# xargs -P especifica procesos paralelos
echo "Usando xargs para paralelizar:"

# Crear lista de archivos
seq 1 5 | sed 's/^/archivo_/' > /tmp/lista_$$.txt

# Procesar en paralelo con xargs
cat /tmp/lista_$$.txt | xargs -P 3 -I {} bash -c '
    echo "Procesando {}"
    sleep 0.3
    echo "✓ {} completado"
'

rm -f /tmp/lista_$$.txt

echo -e "\n=== TIMEOUT PARA COMANDOS ==="

# Ejecutar comando con timeout
ejecutar_con_timeout() {
    local timeout=$1
    shift
    local comando="$@"

    # Ejecutar comando en background
    bash -c "$comando" &
    local pid=$!

    # Esperar con timeout
    local count=0
    while kill -0 $pid 2>/dev/null; do
        if [ $count -ge $timeout ]; then
            echo "⚠ Timeout alcanzado, terminando proceso..."
            kill $pid 2>/dev/null
            wait $pid 2>/dev/null
            return 124  # Código estándar de timeout
        fi
        sleep 1
        ((count++))
    done

    # Proceso terminó antes del timeout
    wait $pid
    return $?
}

echo "Comando que termina a tiempo:"
ejecutar_con_timeout 3 "sleep 1 && echo 'Completado'"

echo -e "\nComando que excede timeout:"
ejecutar_con_timeout 2 "sleep 5 && echo 'Esto no se verá'"

echo -e "\n=== PRIORIDAD DE PROCESOS (NICE) ==="

# nice ejecuta comando con prioridad diferente
# Valores: -20 (máxima) a 19 (mínima)
# Solo root puede usar valores negativos

echo "Ejecutando con baja prioridad (nice 10):"
nice -n 10 bash -c 'echo "Proceso con baja prioridad"'

echo "Ejecutando con prioridad normal:"
bash -c 'echo "Proceso normal"'

echo -e "\n=== CREAR POOL DE WORKERS ==="

# Sistema de pool de workers
worker_pool() {
    local max_workers=3
    local task_queue=()

    # Función worker
    worker() {
        local task=$1
        echo "  Worker ejecutando: $task"
        sleep 0.5
        echo "  ✓ $task completado"
    }

    # Agregar tareas
    for i in {1..8}; do
        task_queue+=("tarea_$i")
    done

    # Procesar con pool
    for task in "${task_queue[@]}"; do
        # Esperar si hay muchos workers
        while [ $(jobs -r | wc -l) -ge $max_workers ]; do
            sleep 0.1
        done

        worker "$task" &
    done

    wait
    echo "✓ Pool de workers completado"
}

echo "Ejecutando pool de workers:"
worker_pool

echo -e "\n=== SUBSHELLS ==="

# ( ) crea un subshell
echo "Shell principal: $$"

(
    echo "Subshell: $$"
    cd /tmp
    echo "Directorio en subshell: $PWD"
)

echo "Directorio en shell principal: $PWD"

# Variables en subshell no afectan al padre
contador=0
(
    contador=10
    echo "Contador en subshell: $contador"
)
echo "Contador en shell principal: $contador"

echo -e "\n=== COMMAND SUBSTITUTION EN PARALELO ==="

# Ejecutar comandos en paralelo y capturar salida
echo "Ejecutando comandos en paralelo:"

resultado1=$(sleep 0.5 && echo "Comando 1") &
pid1=$!
resultado2=$(sleep 0.5 && echo "Comando 2") &
pid2=$!
resultado3=$(sleep 0.5 && echo "Comando 3") &
pid3=$!

wait $pid1 $pid2 $pid3

# Nota: Las variables no capturan en este caso
# Mejor usar archivos temporales
echo "Usando archivos temporales:"

temp1="/tmp/out1_$$.txt"
temp2="/tmp/out2_$$.txt"
temp3="/tmp/out3_$$.txt"

{ sleep 0.3 && echo "Resultado 1" > "$temp1"; } &
{ sleep 0.3 && echo "Resultado 2" > "$temp2"; } &
{ sleep 0.3 && echo "Resultado 3" > "$temp3"; } &

wait

cat "$temp1" "$temp2" "$temp3"
rm -f "$temp1" "$temp2" "$temp3"

echo -e "\n=== EJEMPLO PRÁCTICO: PROCESAMIENTO BATCH ==="

# Procesar muchos archivos en paralelo
procesar_batch() {
    local directorio=$1
    local max_parallel=4

    # Crear archivos de prueba
    mkdir -p "$directorio"
    for i in {1..10}; do
        echo "datos $i" > "$directorio/archivo_$i.txt"
    done

    # Función de procesamiento
    procesar() {
        local archivo=$1
        # Simular procesamiento
        wc -w "$archivo" > "${archivo}.procesado"
    }

    # Exportar función para usar en subshells
    export -f procesar

    # Procesar en paralelo
    find "$directorio" -name "*.txt" -type f | \
        xargs -P $max_parallel -I {} bash -c 'procesar "{}"'

    echo "✓ Procesamiento batch completado"
    echo "Archivos procesados:"
    ls -1 "$directorio"/*.procesado | wc -l

    # Limpiar
    rm -rf "$directorio"
}

procesar_batch "/tmp/batch_$$"

echo -e "\n=== EJEMPLO PRÁCTICO: MONITOR DE PROCESOS ==="

# Función para monitorear proceso
monitorear_proceso() {
    local comando="$@"
    local inicio=$(date +%s)

    echo "Iniciando: $comando"

    # Ejecutar comando
    eval "$comando" &
    local pid=$!

    # Monitorear
    while kill -0 $pid 2>/dev/null; do
        local transcurrido=$(($(date +%s) - inicio))
        echo -ne "\rTiempo transcurrido: ${transcurrido}s "
        sleep 1
    done

    # Obtener código de salida
    wait $pid
    local codigo=$?

    local total=$(($(date +%s) - inicio))
    echo -e "\n✓ Proceso completado en ${total}s (código: $codigo)"

    return $codigo
}

echo "Monitoreando proceso:"
monitorear_proceso "sleep 3"

echo -e "\n=== EJEMPLO PRÁCTICO: DESCARGAS PARALELAS ==="

# Simular descarga de URLs en paralelo
descargar_urls() {
    local urls=(
        "http://ejemplo.com/archivo1"
        "http://ejemplo.com/archivo2"
        "http://ejemplo.com/archivo3"
        "http://ejemplo.com/archivo4"
    )

    # Función de descarga (simulada)
    descargar() {
        local url=$1
        local archivo=$(basename "$url")
        echo "  Descargando $url..."
        sleep 0.5  # Simular descarga
        echo "datos" > "/tmp/$archivo"
        echo "  ✓ $archivo descargado"
    }

    export -f descargar

    # Descargar en paralelo
    printf '%s\n' "${urls[@]}" | xargs -P 2 -I {} bash -c 'descargar "{}"'

    echo "✓ Todas las descargas completadas"

    # Limpiar
    rm -f /tmp/archivo{1..4}
}

echo "Simulando descargas paralelas:"
descargar_urls

echo -e "\n¡Procesos y trabajos completados!"
