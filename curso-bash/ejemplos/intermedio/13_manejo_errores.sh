#!/bin/bash

################################################################################
# Ejemplo 13: Manejo de Errores
# Descripción: Aprende a manejar errores y crear scripts robustos
# Nivel: Intermedio
################################################################################

echo "=== CÓDIGOS DE SALIDA ==="

# Todo comando retorna un código de salida (0-255)
# 0 = éxito, cualquier otro = error

# Ejecutar comando exitoso
ls / > /dev/null
echo "Código de salida de 'ls /': $?"

# Ejecutar comando que falla
ls /directorio_inexistente 2>/dev/null
echo "Código de salida de 'ls inexistente': $?"

# El código de salida se guarda en $?
# Solo es válido inmediatamente después del comando

echo -e "\n=== USAR CÓDIGOS DE SALIDA ==="

# Verificar éxito de comando
if ls /tmp > /dev/null 2>&1; then
    echo "✓ Comando exitoso"
else
    echo "✗ Comando falló"
fi

# Forma abreviada con &&
mkdir /tmp/test_$$  && echo "✓ Directorio creado"

# Forma abreviada con ||
ls /inexistente 2>/dev/null || echo "✗ No se pudo listar"

# Limpiar
rmdir /tmp/test_$$ 2>/dev/null

echo -e "\n=== RETORNAR CÓDIGOS DE ERROR ==="

# Funciones pueden retornar códigos
dividir() {
    local a=$1
    local b=$2

    if [ $b -eq 0 ]; then
        echo "Error: División por cero" >&2
        return 1  # Código de error
    fi

    echo $((a / b))
    return 0  # Éxito
}

# Usar la función
if resultado=$(dividir 10 2); then
    echo "✓ Resultado: $resultado"
fi

if dividir 10 0 > /dev/null 2>&1; then
    echo "División exitosa"
else
    echo "✗ División falló (esperado)"
fi

echo -e "\n=== SET -e (EXIT ON ERROR) ==="

# set -e hace que el script termine si hay error
# Útil para scripts que deben ser completamente exitosos

demo_set_e() {
    echo "Iniciando función con set -e"
    set -e  # Activar

    echo "Comando 1: OK"
    ls /tmp > /dev/null

    echo "Comando 2: Este fallará"
    # ls /inexistente  # Esto terminaría el script

    echo "Comando 3: No se ejecutará si el anterior falla"
    set +e  # Desactivar
}

demo_set_e
echo "✓ Función completada"

echo -e "\n=== SET -u (ERROR ON UNDEFINED) ==="

# set -u causa error si se usa variable no definida
demo_set_u() {
    local nombre="Juan"

    echo "Variable definida: $nombre"

    # set -u  # Activar
    # echo "Variable no definida: $apellido"  # Esto causaría error
    # set +u  # Desactivar
}

demo_set_u
echo "✓ Función completada"

echo -e "\n=== SET -o pipefail ==="

# Normalmente, un pipeline retorna el código del último comando
# pipefail hace que retorne el código del primer comando que falló

echo "Sin pipefail:"
set +o pipefail
ls /inexistente 2>/dev/null | wc -l
echo "Código: $?"  # Será 0 (de wc)

echo -e "\nCon pipefail:"
set -o pipefail
ls /inexistente 2>/dev/null | wc -l
codigo=$?
echo "Código: $codigo"  # Será no-cero (de ls)
set +o pipefail

echo -e "\n=== COMBINACIÓN: SET -euo pipefail ==="

# Modo "strict" - muy recomendado para scripts robustos
modo_strict() {
    set -euo pipefail
    echo "✓ Modo strict activado"
    echo "  -e: salir si hay error"
    echo "  -u: error en variables no definidas"
    echo "  -o pipefail: detectar errores en pipes"
    set +euo pipefail
}

modo_strict

echo -e "\n=== TRAP (CAPTURAR ERRORES) ==="

# trap ejecuta código cuando ocurre un evento
# Útil para limpieza

cleanup() {
    echo -e "\n🧹 Ejecutando limpieza..."
    rm -f /tmp/temp_$$_*
    echo "✓ Archivos temporales eliminados"
}

# Ejecutar cleanup al salir
trap cleanup EXIT

# Crear archivos temporales
echo "Creando archivos temporales..."
touch /tmp/temp_$$_{1,2,3}.txt
echo "✓ Archivos creados"

echo -e "\n=== TRAP PARA ERRORES ==="

# Capturar errores específicos
error_handler() {
    echo -e "\n❌ Error en línea $1"
    echo "Último comando: $BASH_COMMAND"
    echo "Código de salida: $?"
}

# Activar handler
trap 'error_handler $LINENO' ERR

# Este comando fallará pero capturaremos el error
# ls /directorio_inexistente 2>/dev/null

# Desactivar
trap - ERR

echo -e "\n=== VALIDACIÓN DE ENTRADA ==="

# Siempre validar entradas
procesar_archivo() {
    local archivo=$1

    # Verificar que se pasó argumento
    if [ -z "$archivo" ]; then
        echo "Error: Se requiere nombre de archivo" >&2
        return 1
    fi

    # Verificar que existe
    if [ ! -f "$archivo" ]; then
        echo "Error: Archivo '$archivo' no existe" >&2
        return 2
    fi

    # Verificar que es legible
    if [ ! -r "$archivo" ]; then
        echo "Error: No se puede leer '$archivo'" >&2
        return 3
    fi

    # Procesar
    echo "✓ Procesando: $archivo"
    return 0
}

# Crear archivo de prueba
echo "test" > /tmp/test_file.txt

# Probar validaciones
procesar_archivo ""
procesar_archivo "inexistente.txt"
procesar_archivo "/tmp/test_file.txt"

# Limpiar
rm -f /tmp/test_file.txt

echo -e "\n=== VALIDACIÓN DE ARGUMENTOS ==="

# Script con argumentos obligatorios
script_con_args() {
    # Verificar número de argumentos
    if [ $# -lt 2 ]; then
        echo "Uso: $0 <nombre> <edad>" >&2
        return 1
    fi

    local nombre=$1
    local edad=$2

    # Validar que edad es número
    if ! [[ $edad =~ ^[0-9]+$ ]]; then
        echo "Error: Edad debe ser un número" >&2
        return 1
    fi

    # Validar rango
    if [ $edad -lt 0 ] || [ $edad -gt 120 ]; then
        echo "Error: Edad debe estar entre 0 y 120" >&2
        return 1
    fi

    echo "✓ Nombre: $nombre, Edad: $edad"
    return 0
}

# Probar
script_con_args "Juan" "30"
script_con_args "Ana" "abc"
script_con_args "Pedro" "150"

echo -e "\n=== TRY-CATCH SIMULADO ==="

# BASH no tiene try-catch, pero se puede simular
try_catch() {
    local error_occurred=false

    # Intentar ejecutar comando
    {
        echo "Intentando operación..."
        # ls /directorio_inexistente
        mkdir /tmp/test_dir_$$ || error_occurred=true
    } 2>/dev/null

    # Verificar si hubo error
    if [ "$error_occurred" = true ]; then
        echo "✗ Operación falló, ejecutando alternativa..."
        mkdir -p /tmp/test_dir_$$
    else
        echo "✓ Operación exitosa"
    fi

    # Limpiar
    rmdir /tmp/test_dir_$$ 2>/dev/null
}

try_catch

echo -e "\n=== LOGGING DE ERRORES ==="

# Sistema de logging
LOG_FILE="/tmp/script_$$.log"

log() {
    local nivel=$1
    shift
    local mensaje="$@"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')

    echo "[$timestamp] [$nivel] $mensaje" | tee -a "$LOG_FILE"
}

log "INFO" "Script iniciado"
log "DEBUG" "Procesando datos..."
log "WARNING" "Memoria baja"
log "ERROR" "Falló conexión a DB"
log "INFO" "Script finalizado"

echo -e "\nContenido del log:"
cat "$LOG_FILE"
rm -f "$LOG_FILE"

echo -e "\n=== REINTENTOS (RETRY) ==="

# Función con reintentos automáticos
retry() {
    local max_attempts=3
    local timeout=1
    local attempt=1
    local exitCode=0

    while [ $attempt -le $max_attempts ]; do
        # Ejecutar comando
        "$@"
        exitCode=$?

        if [ $exitCode -eq 0 ]; then
            echo "✓ Comando exitoso en intento $attempt"
            return 0
        fi

        echo "⚠ Intento $attempt falló, reintentando en ${timeout}s..."
        sleep $timeout
        attempt=$((attempt + 1))
        timeout=$((timeout * 2))  # Backoff exponencial
    done

    echo "✗ Comando falló después de $max_attempts intentos"
    return $exitCode
}

# Simular comando que falla
comando_falible() {
    # Fallar las primeras 2 veces
    if [ ${intento:-0} -lt 2 ]; then
        intento=$((intento + 1))
        return 1
    fi
    return 0
}

echo "Probando con reintentos:"
intento=0
retry comando_falible

echo -e "\n=== VERIFICACIÓN DE DEPENDENCIAS ==="

# Verificar que comandos necesarios estén disponibles
check_dependencies() {
    local deps=("$@")
    local missing=()

    for cmd in "${deps[@]}"; do
        if ! command -v "$cmd" &> /dev/null; then
            missing+=("$cmd")
        fi
    done

    if [ ${#missing[@]} -gt 0 ]; then
        echo "Error: Dependencias faltantes:" >&2
        printf '  - %s\n' "${missing[@]}" >&2
        return 1
    fi

    echo "✓ Todas las dependencias están instaladas"
    return 0
}

# Verificar dependencias comunes
check_dependencies "bash" "grep" "sed" "awk"
check_dependencies "bash" "grep" "comando_inexistente"

echo -e "\n=== EJEMPLO PRÁCTICO: SCRIPT ROBUSTO ==="

# Script completo con manejo de errores
script_robusto() {
    # Modo strict
    set -euo pipefail

    # Variables
    local archivo_entrada="$1"
    local archivo_salida="${2:-salida.txt}"

    # Validar entrada
    if [ ! -f "$archivo_entrada" ]; then
        echo "Error: '$archivo_entrada' no existe" >&2
        return 1
    fi

    # Crear backup
    local backup="${archivo_salida}.backup"
    if [ -f "$archivo_salida" ]; then
        cp "$archivo_salida" "$backup"
        echo "✓ Backup creado: $backup"
    fi

    # Procesar
    echo "Procesando $archivo_entrada..."
    cat "$archivo_entrada" | tr '[:lower:]' '[:upper:]' > "$archivo_salida"

    echo "✓ Resultado guardado en: $archivo_salida"
    return 0
}

# Probar script
echo "datos de prueba" > /tmp/entrada.txt
script_robusto "/tmp/entrada.txt" "/tmp/salida.txt"
cat /tmp/salida.txt
rm -f /tmp/entrada.txt /tmp/salida.txt /tmp/salida.txt.backup

echo -e "\n=== EJEMPLO PRÁCTICO: MANEJO COMPLETO ==="

# Función con manejo completo de errores
procesar_datos() {
    local archivo=$1

    # Validaciones
    if [ -z "$archivo" ]; then
        echo "Error: Archivo requerido" >&2
        return 1
    fi

    if [ ! -f "$archivo" ]; then
        echo "Error: '$archivo' no existe" >&2
        return 2
    fi

    # Setup
    local temp_file="/tmp/temp_$$_$(date +%s).tmp"
    local error_log="/tmp/error_$$.log"

    # Trap para limpieza
    trap "rm -f $temp_file $error_log" RETURN

    # Procesamiento con captura de errores
    {
        echo "Procesando..."
        cat "$archivo" > "$temp_file"
        echo "✓ Datos procesados"
    } 2> "$error_log"

    # Verificar errores
    if [ -s "$error_log" ]; then
        echo "⚠ Se encontraron advertencias:"
        cat "$error_log"
    fi

    return 0
}

# Probar
echo "datos" > /tmp/test.txt
procesar_datos "/tmp/test.txt"
rm -f /tmp/test.txt

echo -e "\n¡Manejo de errores completado!"
