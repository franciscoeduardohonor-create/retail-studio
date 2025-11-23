#!/bin/bash

################################################################################
# Ejemplo 17: Opciones y Parámetros
# Descripción: Procesar opciones como comandos profesionales
# Nivel: Intermedio
################################################################################

echo "=== PARÁMETROS POSICIONALES ==="
echo "Script: $0"
echo "Todos los parámetros: $@"
echo "Número de parámetros: $#"
echo "Primer parámetro: ${1:-no definido}"
echo "Segundo parámetro: ${2:-no definido}"

echo -e "\n=== SHIFT (DESPLAZAR PARÁMETROS) ==="
demo_shift() {
    echo "Parámetros iniciales: $@"
    shift
    echo "Después de shift: $@"
    shift 2
    echo "Después de shift 2: $@"
}
demo_shift a b c d e f

echo -e "\n=== PROCESAR OPCIONES SIMPLES ==="
procesar_simple() {
    while [ $# -gt 0 ]; do
        case $1 in
            -h|--help)
                echo "Ayuda del script"
                ;;
            -v|--verbose)
                echo "Modo verbose activado"
                ;;
            -f|--file)
                echo "Archivo: $2"
                shift
                ;;
            *)
                echo "Opción desconocida: $1"
                ;;
        esac
        shift
    done
}

procesar_simple -v --file datos.txt -h

echo -e "\n=== USAR GETOPTS (RECOMENDADO) ==="
demo_getopts() {
    local verbose=false
    local archivo=""
    local numero=0

    # getopts procesa opciones cortas
    while getopts "hvf:n:" opt; do
        case $opt in
            h)
                echo "Uso: script -h -v -f archivo -n número"
                return 0
                ;;
            v)
                verbose=true
                ;;
            f)
                archivo="$OPTARG"
                ;;
            n)
                numero="$OPTARG"
                ;;
            \?)
                echo "Opción inválida: -$OPTARG" >&2
                return 1
                ;;
        esac
    done

    shift $((OPTIND - 1))

    echo "Configuración:"
    echo "  Verbose: $verbose"
    echo "  Archivo: ${archivo:-ninguno}"
    echo "  Número: $numero"
    echo "  Argumentos restantes: $@"
}

demo_getopts -v -f datos.txt -n 42 arg1 arg2

echo -e "\n=== VALIDAR OPCIONES REQUERIDAS ==="
script_con_validacion() {
    local archivo=""
    local output=""

    while getopts "f:o:" opt; do
        case $opt in
            f) archivo="$OPTARG" ;;
            o) output="$OPTARG" ;;
        esac
    done

    # Validar opciones requeridas
    if [ -z "$archivo" ]; then
        echo "Error: -f archivo es requerido" >&2
        return 1
    fi

    echo "✓ Archivo de entrada: $archivo"
    echo "✓ Archivo de salida: ${output:-salida.txt}"
}

script_con_validacion -f entrada.txt -o resultado.txt

echo -e "\n=== EJEMPLO COMPLETO ==="
script_completo() {
    # Configuración por defecto
    local verbose=false
    local debug=false
    local archivo_entrada=""
    local archivo_salida="output.txt"
    local modo="normal"

    # Procesar opciones
    while getopts "hvdf:o:m:" opt; do
        case $opt in
            h)
                cat << EOF
Uso: script [opciones] [argumentos]

Opciones:
  -h          Mostrar esta ayuda
  -v          Modo verbose
  -d          Modo debug
  -f ARCHIVO  Archivo de entrada (requerido)
  -o ARCHIVO  Archivo de salida (default: output.txt)
  -m MODO     Modo de operación: normal|rapido|completo

Ejemplos:
  script -f datos.txt
  script -v -f entrada.txt -o salida.txt -m completo
EOF
                return 0
                ;;
            v) verbose=true ;;
            d) debug=true ;;
            f) archivo_entrada="$OPTARG" ;;
            o) archivo_salida="$OPTARG" ;;
            m) modo="$OPTARG" ;;
            \?)
                echo "Opción inválida: -$OPTARG" >&2
                echo "Usa -h para ayuda"
                return 1
                ;;
            :)
                echo "La opción -$OPTARG requiere un argumento" >&2
                return 1
                ;;
        esac
    done

    shift $((OPTIND - 1))

    # Validaciones
    if [ -z "$archivo_entrada" ]; then
        echo "Error: -f archivo es requerido" >&2
        return 1
    fi

    case $modo in
        normal|rapido|completo)
            ;;
        *)
            echo "Error: Modo '$modo' inválido" >&2
            return 1
            ;;
    esac

    # Mostrar configuración
    echo "Configuración:"
    echo "  Verbose: $verbose"
    echo "  Debug: $debug"
    echo "  Entrada: $archivo_entrada"
    echo "  Salida: $archivo_salida"
    echo "  Modo: $modo"
    echo "  Argumentos extras: $@"
}

echo "Ejemplo 1 (solo ayuda):"
script_completo -h

echo -e "\nEjemplo 2 (completo):"
script_completo -v -d -f datos.txt -o resultado.txt -m completo extra1 extra2

echo -e "\n¡Opciones y parámetros completado!"
