#!/bin/bash

################################################################################
# Ejemplo 06: Funciones
# Descripción: Aprende a crear y usar funciones en BASH
# Nivel: Principiante
################################################################################

echo "=== FUNCIÓN BÁSICA ==="

# Definir una función simple
saludar() {
    echo "¡Hola desde una función!"
}

# Llamar a la función
saludar

echo -e "\n=== FUNCIONES CON PARÁMETROS ==="

# Función que recibe parámetros
# $1 = primer parámetro, $2 = segundo, etc.
saludar_persona() {
    echo "¡Hola $1! Bienvenido"
}

# Llamar con argumentos
saludar_persona "Carlos"
saludar_persona "María"

echo -e "\n=== FUNCIÓN CON MÚLTIPLES PARÁMETROS ==="

# Función con varios parámetros
presentar() {
    local nombre=$1
    local edad=$2
    local ciudad=$3

    echo "Me llamo $nombre, tengo $edad años y vivo en $ciudad"
}

presentar "Juan" 25 "Madrid"
presentar "Ana" 30 "Barcelona"

echo -e "\n=== VARIABLES LOCALES ==="

# Variables locales solo existen dentro de la función
variable_global="Soy global"

funcion_con_locales() {
    local variable_local="Soy local"
    echo "Dentro de la función:"
    echo "  - Variable local: $variable_local"
    echo "  - Variable global: $variable_global"
}

funcion_con_locales
echo "Fuera de la función:"
echo "  - Variable global: $variable_global"
echo "  - Variable local: $variable_local"  # Estará vacía

echo -e "\n=== FUNCIONES QUE RETORNAN VALORES ==="

# En BASH, las funciones no retornan valores como en otros lenguajes
# Usan códigos de salida (0-255) o imprimen el resultado

# Método 1: Usando echo y capturando con $()
suma() {
    local resultado=$(($1 + $2))
    echo $resultado  # "Retornar" con echo
}

resultado=$(suma 10 5)
echo "10 + 5 = $resultado"

# Método 2: Usando return (solo para códigos de salida 0-255)
es_par() {
    if [ $(($1 % 2)) -eq 0 ]; then
        return 0  # Verdadero (éxito)
    else
        return 1  # Falso (error)
    fi
}

numero=10
if es_par $numero; then
    echo "$numero es par"
else
    echo "$numero es impar"
fi

echo -e "\n=== FUNCIÓN CON VALIDACIÓN ==="

# Función que valida parámetros
dividir() {
    # Verificar que se pasaron 2 parámetros
    if [ $# -ne 2 ]; then
        echo "Error: Se requieren 2 números"
        return 1
    fi

    # Verificar división por cero
    if [ $2 -eq 0 ]; then
        echo "Error: No se puede dividir por cero"
        return 1
    fi

    # Realizar división
    local resultado=$(($1 / $2))
    echo $resultado
    return 0
}

echo "20 / 4 = $(dividir 20 4)"
echo "10 / 0 = $(dividir 10 0)"
echo "Falta argumento: $(dividir 10)"

echo -e "\n=== FUNCIÓN RECURSIVA ==="

# Función que se llama a sí misma
factorial() {
    local n=$1

    if [ $n -le 1 ]; then
        echo 1
    else
        local anterior=$(factorial $((n - 1)))
        echo $((n * anterior))
    fi
}

echo "Factorial de 5 = $(factorial 5)"
echo "Factorial de 7 = $(factorial 7)"

echo -e "\n=== FUNCIÓN CON ARRAY ==="

# Función que recibe y procesa arrays
mostrar_lista() {
    echo "Lista de elementos:"
    local contador=1
    for item in "$@"; do  # $@ contiene todos los argumentos
        echo "  $contador. $item"
        ((contador++))
    done
}

mostrar_lista "Manzana" "Pera" "Uva" "Naranja"

echo -e "\n=== FUNCIÓN QUE MODIFICA VARIABLES GLOBALES ==="

contador_global=0

incrementar() {
    ((contador_global++))
    echo "Contador ahora es: $contador_global"
}

echo "Contador inicial: $contador_global"
incrementar
incrementar
incrementar
echo "Contador final: $contador_global"

echo -e "\n=== EJEMPLO PRÁCTICO: CALCULADORA ==="

# Calculadora con funciones
calculadora() {
    local operacion=$1
    local num1=$2
    local num2=$3

    case $operacion in
        suma|+)
            echo $((num1 + num2))
            ;;
        resta|-)
            echo $((num1 - num2))
            ;;
        mult|multiplicacion|*)
            echo $((num1 * num2))
            ;;
        div|division|/)
            if [ $num2 -eq 0 ]; then
                echo "Error: División por cero"
                return 1
            fi
            echo $((num1 / num2))
            ;;
        *)
            echo "Operación no válida"
            return 1
            ;;
    esac
}

echo "Calculadora:"
echo "10 + 5 = $(calculadora suma 10 5)"
echo "10 - 5 = $(calculadora resta 10 5)"
echo "10 * 5 = $(calculadora mult 10 5)"
echo "10 / 5 = $(calculadora div 10 5)"

echo -e "\n=== EJEMPLO PRÁCTICO: VALIDADOR ==="

# Función para validar email
validar_email() {
    local email=$1

    if [[ $email =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        echo "✓ Email válido: $email"
        return 0
    else
        echo "✗ Email inválido: $email"
        return 1
    fi
}

validar_email "usuario@example.com"
validar_email "correo_invalido"
validar_email "otro@dominio.es"

echo -e "\n=== EJEMPLO PRÁCTICO: UTILIDADES ==="

# Función para crear directorio si no existe
crear_directorio() {
    local dir=$1

    if [ -d "$dir" ]; then
        echo "El directorio '$dir' ya existe"
    else
        mkdir -p "$dir"
        echo "Directorio '$dir' creado"
    fi
}

crear_directorio "test_dir"
crear_directorio "test_dir"  # Ya existe
rm -rf test_dir  # Limpiar

# Función para hacer backup de archivo
backup_archivo() {
    local archivo=$1
    local backup="${archivo}.backup.$(date +%Y%m%d_%H%M%S)"

    if [ -f "$archivo" ]; then
        cp "$archivo" "$backup"
        echo "Backup creado: $backup"
    else
        echo "Error: El archivo '$archivo' no existe"
        return 1
    fi
}

# Crear archivo de prueba
echo "contenido" > test.txt
backup_archivo "test.txt"
rm -f test.txt test.txt.backup.*  # Limpiar

echo -e "\n=== FUNCIÓN CON OPCIONES ==="

# Función que procesa opciones como los comandos de Linux
procesar_opciones() {
    local verbose=false
    local archivo=""

    # Procesar opciones
    while [ $# -gt 0 ]; do
        case $1 in
            -v|--verbose)
                verbose=true
                ;;
            -f|--file)
                archivo=$2
                shift  # Saltar el siguiente argumento
                ;;
            *)
                echo "Opción desconocida: $1"
                ;;
        esac
        shift  # Pasar al siguiente argumento
    done

    # Usar las opciones
    if [ "$verbose" = true ]; then
        echo "Modo verbose activado"
    fi

    if [ -n "$archivo" ]; then
        echo "Archivo especificado: $archivo"
    fi
}

procesar_opciones -v --file "datos.txt"

echo -e "\n¡Funciones completadas!"
