#!/bin/bash

################################################################################
# Ejemplo 22: Coprocessos y Named Pipes
# Descripción: Comunicación avanzada entre procesos
# Nivel: Avanzado
################################################################################

echo "=== NAMED PIPES (FIFOS) ==="

# Crear named pipe
pipe="/tmp/mypipe_$$"
mkfifo "$pipe"
echo "✓ Named pipe creado: $pipe"

# Escribir en background
echo "datos de prueba" > "$pipe" &

# Leer del pipe
datos=$(cat "$pipe")
echo "Datos recibidos: $datos"

rm -f "$pipe"

echo -e "\n=== COMUNICACIÓN BIDIRECCIONAL ==="

# Crear dos pipes para comunicación bidireccional
pipe1="/tmp/pipe1_$$"
pipe2="/tmp/pipe2_$$"
mkfifo "$pipe1" "$pipe2"

# Proceso 1 (background)
{
    echo "Mensaje desde proceso 1" > "$pipe1"
    respuesta=$(cat "$pipe2")
    echo "Proceso 1 recibió: $respuesta"
} &
pid1=$!

# Proceso 2 (background)
{
    mensaje=$(cat "$pipe1")
    echo "Proceso 2 recibió: $mensaje"
    echo "Respuesta desde proceso 2" > "$pipe2"
} &
pid2=$!

wait $pid1 $pid2
rm -f "$pipe1" "$pipe2"

echo -e "\n=== COPROCESS (COPROC) ==="

# Coproc ejecuta comando en background con pipes
coproc CAT { cat; }

# Escribir al coprocess
echo "Hola coproc" >&${CAT[1]}

# Leer del coprocess
read -u ${CAT[0]} respuesta
echo "Respuesta: $respuesta"

# Cerrar coprocess
eval "exec ${CAT[1]}>&-"
wait $CAT_PID

echo -e "\n=== EJEMPLO: PRODUCTOR-CONSUMIDOR ==="

productor_consumidor() {
    local pipe="/tmp/pc_pipe_$$"
    mkfifo "$pipe"

    # Productor
    {
        for i in {1..5}; do
            echo "Item $i"
            sleep 0.1
        done
    } > "$pipe" &

    # Consumidor
    {
        while read item; do
            echo "  Procesando: $item"
        done
    } < "$pipe" &

    wait
    rm -f "$pipe"
}

echo "Productor-Consumidor:"
productor_consumidor

echo -e "\n=== PIPELINE COMPLEJO ==="

# Múltiples procesos conectados
{
    echo -e "1\n2\n3\n4\n5" |
    while read num; do
        echo $((num * 2))
    done |
    while read result; do
        echo "Resultado: $result"
    done
}

echo -e "\n¡Coprocessos y pipes completado!"
