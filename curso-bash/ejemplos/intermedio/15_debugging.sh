#!/bin/bash

################################################################################
# Ejemplo 15: Debugging de Scripts
# Descripción: Técnicas para depurar scripts de BASH
# Nivel: Intermedio
################################################################################

echo "=== MODO DEBUG: set -x ==="

# set -x muestra cada comando antes de ejecutarlo
echo "Activando modo debug:"
set -x
nombre="Juan"
edad=30
echo "Hola $nombre, tienes $edad años"
set +x  # Desactivar
echo "Debug desactivado"

echo -e "\n=== MODO VERBOSE: set -v ==="

# set -v muestra las líneas del script antes de ejecutarlas
echo "Activando modo verbose:"
set -v
for i in 1 2 3; do
    echo "Número: $i"
done
set +v
echo "Verbose desactivado"

echo -e "\n=== EJECUTAR SCRIPT CON DEBUG ==="

# Desde línea de comandos:
# bash -x script.sh     # Modo debug
# bash -v script.sh     # Modo verbose
# bash -xv script.sh    # Ambos

echo "Para ejecutar con debug desde terminal:"
echo "  bash -x script.sh"
echo "  bash -v script.sh"
echo "  bash -xv script.sh"

echo -e "\n=== DEBUG PARCIAL ==="

# Activar debug solo en secciones específicas
debug_seccion() {
    echo "Sección normal"

    set -x  # Activar debug
    local var1="valor1"
    local var2="valor2"
    echo "Debug: $var1 + $var2"
    set +x  # Desactivar debug

    echo "Sección normal de nuevo"
}

debug_seccion

echo -e "\n=== PUNTOS DE CONTROL (BREAKPOINTS) ==="

# Pausar ejecución en puntos específicos
checkpoint() {
    local mensaje="${1:-Presiona ENTER para continuar...}"
    echo "🔴 CHECKPOINT: $mensaje"
    read -p "" dummy
}

echo "Ejecutando con checkpoints:"
echo "Paso 1"
# checkpoint "Verificar que Paso 1 se completó"
echo "Paso 2"
# checkpoint
echo "Paso 3"
echo "✓ Completado (checkpoints comentados para demostración)"

echo -e "\n=== MOSTRAR VALORES DE VARIABLES ==="

# Función para debug de variables
debug_var() {
    local var_name=$1
    local var_value="${!var_name}"  # Indirección
    echo "🐛 DEBUG: $var_name = '$var_value'"
}

# Uso
usuario="admin"
edad=25
activo=true

debug_var "usuario"
debug_var "edad"
debug_var "activo"

echo -e "\n=== LOGGING AVANZADO ==="

# Sistema de logging con niveles
declare -g LOG_LEVEL=${LOG_LEVEL:-"INFO"}
declare -g LOG_FILE="/tmp/debug_$$.log"

log_debug() {
    [[ "$LOG_LEVEL" == "DEBUG" ]] && log "DEBUG" "$@"
}

log_info() {
    log "INFO" "$@"
}

log_warn() {
    log "WARN" "$@"
}

log_error() {
    log "ERROR" "$@"
}

log() {
    local nivel=$1
    shift
    local mensaje="$@"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] [$nivel] $mensaje" | tee -a "$LOG_FILE" >&2
}

# Probar logging
LOG_LEVEL="DEBUG"
log_debug "Mensaje de debug"
log_info "Información general"
log_warn "Advertencia"
log_error "Error crítico"

echo -e "\nLog guardado en: $LOG_FILE"

echo -e "\n=== STACK TRACE ==="

# Función para mostrar stack trace
stack_trace() {
    local frame=0
    echo "📚 Stack Trace:"
    while caller $frame; do
        ((frame++))
    done | awk '{printf "  [%d] %s (línea %d)\n", NR-1, $2, $1}'
}

# Funciones anidadas para demostrar
funcion_a() {
    echo "En función_a"
    funcion_b
}

funcion_b() {
    echo "En función_b"
    funcion_c
}

funcion_c() {
    echo "En función_c"
    stack_trace
}

echo "Demostrando stack trace:"
funcion_a

echo -e "\n=== TRAP PARA DEBUG ==="

# Ejecutar función antes de cada comando
debug_trap() {
    echo "  → Ejecutando: $BASH_COMMAND"
}

echo "Con trap DEBUG (limitado):"
# trap debug_trap DEBUG  # Descomentado causaría mucha salida
echo "Variable: test"
echo "Cálculo: $((2+2))"
# trap - DEBUG

echo "✓ Demostración completada (trap comentado)"

echo -e "\n=== ASSERT (AFIRMACIONES) ==="

# Función assert para verificaciones
assert() {
    local condicion="$1"
    local mensaje="${2:-Afirmación falló}"

    if ! eval "$condicion"; then
        echo "❌ ASSERT FAILED: $mensaje" >&2
        echo "   Condición: $condicion" >&2
        stack_trace
        return 1
    fi
}

# Pruebas
x=10
y=5

assert "[ $x -gt $y ]" "x debe ser mayor que y"
echo "✓ Assert pasó"

assert "[ $x -eq $y ]" "x debe ser igual a y" || echo "✓ Assert falló correctamente"

echo -e "\n=== CONTADOR DE EJECUCIONES ==="

# Contar cuántas veces se ejecuta una función
declare -A call_count

count_calls() {
    local func_name="${FUNCNAME[1]}"
    ((call_count[$func_name]++))
}

funcion_contador() {
    count_calls
    echo "  Ejecutando función..."
}

# Llamar varias veces
for i in {1..3}; do
    funcion_contador
done

echo "Estadísticas de llamadas:"
for func in "${!call_count[@]}"; do
    echo "  $func: ${call_count[$func]} veces"
done

echo -e "\n=== TIEMPO DE EJECUCIÓN ==="

# Medir tiempo de función
time_function() {
    local func_name=$1
    shift
    local inicio=$(date +%s%N)

    # Ejecutar función
    "$func_name" "$@"
    local codigo=$?

    local fin=$(date +%s%N)
    local duracion=$(( (fin - inicio) / 1000000 ))  # Convertir a ms

    echo "⏱ $func_name tardó ${duracion}ms"
    return $codigo
}

# Función de prueba
tarea_lenta() {
    sleep 0.1
    echo "  Tarea completada"
}

echo "Midiendo tiempo:"
time_function tarea_lenta

echo -e "\n=== VALIDAR SINTAXIS ==="

# Verificar sintaxis sin ejecutar
validar_sintaxis() {
    local script=$1

    if bash -n "$script" 2>&1; then
        echo "✓ Sintaxis correcta"
        return 0
    else
        echo "✗ Error de sintaxis"
        return 1
    fi
}

# Crear script de prueba
cat > /tmp/test_syntax_$$.sh << 'EOF'
#!/bin/bash
echo "Hola"
if [ $x -eq 1 ]; then
    echo "x es 1"
fi
EOF

echo "Validando sintaxis:"
validar_sintaxis "/tmp/test_syntax_$$.sh"
rm -f "/tmp/test_syntax_$$.sh"

echo -e "\n=== EJEMPLO PRÁCTICO: DEBUG COMPLETO ==="

# Script con debugging completo
script_debuggable() {
    # Setup
    set -euo pipefail  # Modo strict
    local debug=${DEBUG:-0}

    # Logging personalizado
    debug_log() {
        [ "$debug" -eq 1 ] && echo "🐛 $@" >&2
    }

    # Iniciar
    debug_log "Iniciando script"
    debug_log "Parámetros: $@"

    # Procesamiento
    local contador=0
    for item in "$@"; do
        debug_log "Procesando: $item"
        ((contador++))
        debug_log "Contador: $contador"
    done

    debug_log "Script completado"
    echo "✓ Procesados $contador items"
}

echo "Sin debug:"
script_debuggable "item1" "item2" "item3"

echo -e "\nCon debug:"
DEBUG=1 script_debuggable "item1" "item2" "item3"

echo -e "\n=== EJEMPLO PRÁCTICO: PROFILING ==="

# Función para profiling (medir rendimiento)
profile_script() {
    local script_inicio=$(date +%s)

    echo "Iniciando profiling..."

    # Simular operaciones
    echo -n "  Operación 1... "
    sleep 0.1
    echo "✓"

    echo -n "  Operación 2... "
    sleep 0.2
    echo "✓"

    echo -n "  Operación 3... "
    sleep 0.15
    echo "✓"

    local script_fin=$(date +%s)
    local total=$((script_fin - script_inicio))

    echo "⏱ Tiempo total: ${total}s"
}

profile_script

echo -e "\n=== LIMPIEZA ==="
rm -f "$LOG_FILE"
echo "✓ Archivos de prueba eliminados"

echo -e "\n¡Debugging completado!"
echo -e "\n💡 TIPS:"
echo "  - Usa 'set -x' para debug"
echo "  - Usa 'set -euo pipefail' para scripts robustos"
echo "  - Agrega logging en puntos críticos"
echo "  - Valida entradas y salidas"
echo "  - Usa shellcheck para análisis estático"
