#!/bin/bash

################################################################################
# Ejemplo 25: Optimización y Performance
# Descripción: Técnicas para mejorar rendimiento
# Nivel: Avanzado
################################################################################

echo "=== MEDIR TIEMPO DE EJECUCIÓN ==="

benchmark() {
    local nombre=$1
    shift
    local inicio=$(date +%s%N)

    "$@" > /dev/null 2>&1

    local fin=$(date +%s%N)
    local duracion=$(( (fin - inicio) / 1000000 ))
    printf "%-30s %6d ms\n" "$nombre:" "$duracion"
}

echo -e "\n=== OPTIMIZACIÓN: EVITAR SUBSHELLS ==="

# LENTO: Usa subshell
lento() {
    local suma=0
    for i in {1..100}; do
        suma=$(($suma + $i))
    done
}

# RÁPIDO: Aritmética directa
rapido() {
    local suma=0
    for i in {1..100}; do
        ((suma += i))
    done
}

benchmark "Con \$(...)" lento
benchmark "Con (( ))" rapido

echo -e "\n=== OPTIMIZACIÓN: USAR BUILT-INS ==="

# LENTO: Llamar comandos externos
con_externos() {
    for i in {1..50}; do
        echo "$i" | grep "5" > /dev/null
    done
}

# RÁPIDO: Usar operadores built-in
con_builtins() {
    for i in {1..50}; do
        [[ $i == *5* ]]
    done
}

benchmark "Con comandos externos" con_externos
benchmark "Con built-ins" con_builtins

echo -e "\n=== OPTIMIZACIÓN: PROCESAMIENTO PARALELO ==="

# LENTO: Secuencial
secuencial() {
    for i in {1..5}; do
        sleep 0.1
    done
}

# RÁPIDO: Paralelo
paralelo() {
    for i in {1..5}; do
        sleep 0.1 &
    done
    wait
}

benchmark "Secuencial" secuencial
benchmark "Paralelo" paralelo

echo -e "\n=== CACHEAR RESULTADOS ==="

declare -A cache

operacion_costosa() {
    sleep 0.05
    echo "resultado_$1"
}

con_cache() {
    local key=$1

    if [ -z "${cache[$key]}" ]; then
        cache[$key]=$(operacion_costosa "$key")
    fi

    echo "${cache[$key]}"
}

benchmark "Sin cache (3 llamadas)" bash -c '
    operacion_costosa() { sleep 0.05; echo "resultado_$1"; }
    operacion_costosa 1
    operacion_costosa 1
    operacion_costosa 1
'

benchmark "Con cache (3 llamadas)" bash -c '
    declare -A cache
    operacion_costosa() { sleep 0.05; echo "resultado_$1"; }
    con_cache() {
        local key=$1
        if [ -z "${cache[$key]}" ]; then
            cache[$key]=$(operacion_costosa "$key")
        fi
        echo "${cache[$key]}"
    }
    con_cache 1
    con_cache 1
    con_cache 1
'

echo -e "\n=== TIPS DE OPTIMIZACIÓN ==="
cat << 'EOF'
1. Usa built-ins de bash en lugar de comandos externos
2. Evita subshells innecesarios con $()
3. Usa (( )) para aritmética
4. Procesa en paralelo cuando sea posible
5. Cachea resultados de operaciones costosas
6. Lee archivos una vez, no línea por línea con comandos
7. Usa [[ ]] en lugar de [ ]
8. Evita pipes innecesarios
EOF

echo -e "\n¡Performance completado!"
