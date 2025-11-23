#!/bin/bash

################################################################################
# Ejemplo 18: Señales y Traps
# Descripción: Manejo de señales del sistema
# Nivel: Intermedio
################################################################################

echo "=== ¿QUÉ SON LAS SEÑALES? ==="
echo "Las señales son notificaciones que el SO envía a procesos"
echo "Ejemplos: SIGINT (Ctrl+C), SIGTERM (kill), SIGHUP, etc."

echo -e "\n=== LISTAR SEÑALES ==="
echo "Señales disponibles (kill -l):"
kill -l | head -5
echo "... (más señales disponibles)"

echo -e "\n=== TRAP BÁSICO ==="
# trap ejecuta comando cuando se recibe señal
cleanup() {
    echo -e "\n🧹 Limpiando antes de salir..."
    rm -f /tmp/temp_$$_*
    echo "✓ Limpieza completada"
}

trap cleanup EXIT
echo "✓ Trap configurado para EXIT"
touch /tmp/temp_$$_{1,2,3}.txt
echo "Archivos temporales creados"
# Se limpiarán automáticamente al salir

echo -e "\n=== CAPTURAR CTRL+C (SIGINT) ==="
capturar_ctrlc() {
    echo "Presiona Ctrl+C para probar (esperando 3s)..."

    trap 'echo -e "\n⚠ Ctrl+C capturado! No se puede interrumpir."; return' INT

    sleep 3
    echo "✓ Tiempo completado"

    trap - INT  # Restaurar comportamiento normal
}

# capturar_ctrlc  # Comentado para no bloquear

echo -e "\n=== TRAP PARA MÚLTIPLES SEÑALES ==="
handler_multi() {
    echo -e "\n📡 Señal recibida: saliendo ordenadamente..."
    exit 0
}

trap handler_multi INT TERM HUP
echo "✓ Traps configurados para INT, TERM y HUP"

echo -e "\n=== TRAP PARA ERRORES ==="
trap 'echo "❌ Error en línea $LINENO"' ERR
echo "✓ Trap configurado para ERR"

# Este comando fallaría:
# ls /directorio_inexistente

trap - ERR  # Desactivar

echo -e "\n=== TRAP DEBUG ==="
# Se ejecuta antes de cada comando
contador_comandos=0
trap 'let contador_comandos++' DEBUG

echo "Comando 1"
echo "Comando 2"
echo "Comando 3"

trap - DEBUG
echo "Comandos ejecutados (aproximado): $contador_comandos"

echo -e "\n=== IGNORAR SEÑALES ==="
ignorar_señales() {
    echo "Ignorando SIGINT por 5 segundos..."
    trap '' INT  # Ignorar SIGINT

    echo "Presiona Ctrl+C ahora (no funcionará)..."
    sleep 2

    trap - INT  # Restaurar
    echo "✓ SIGINT restaurado"
}

# ignorar_señales  # Comentado

echo -e "\n=== EJEMPLO: SCRIPT ROBUSTO ==="
script_robusto() {
    local temp_file="/tmp/trabajo_$$.tmp"

    # Cleanup al salir
    trap "rm -f $temp_file; echo '🧹 Limpieza realizada'" EXIT

    # Manejo de Ctrl+C
    trap 'echo "⚠ Interrumpido por usuario"; exit 130' INT

    # Manejo de TERM
    trap 'echo "⚠ Terminación solicitada"; exit 143' TERM

    echo "Trabajando..."
    echo "datos" > "$temp_file"
    sleep 1
    echo "✓ Trabajo completado"
}

script_robusto

echo -e "\n=== EJEMPLO: LOCK FILE ==="
usar_lock() {
    local lockfile="/tmp/script_$$.lock"

    # Crear lock
    if [ -e "$lockfile" ]; then
        echo "✗ Script ya está corriendo"
        return 1
    fi

    touch "$lockfile"
    trap "rm -f $lockfile" EXIT

    echo "✓ Lock adquirido"
    sleep 1
    echo "✓ Trabajo realizado"
    # Lock se eliminará automáticamente
}

usar_lock

echo -e "\n¡Señales y traps completado!"
