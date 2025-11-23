#!/bin/bash

################################################################################
# Ejemplo 21: Módulos y Sourcing
# Descripción: Organizar código en módulos reutilizables
# Nivel: Avanzado
################################################################################

echo "=== SOURCING DE ARCHIVOS ==="

# Crear módulo de utilidades
cat > /tmp/utils_$$.sh << 'EOF'
#!/bin/bash
# Módulo de utilidades

log_info() {
    echo "[INFO] $@"
}

log_error() {
    echo "[ERROR] $@" >&2
}

validar_email() {
    [[ $1 =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]
}
EOF

# Source el módulo
source /tmp/utils_$$.sh

# Usar funciones del módulo
log_info "Script iniciado"
log_error "Esto es un error de prueba"

if validar_email "test@example.com"; then
    log_info "Email válido"
fi

echo -e "\n=== DIFERENCIA ENTRE SOURCE Y EJECUCIÓN ==="
echo "source script.sh  - Ejecuta en el shell actual"
echo "./script.sh       - Ejecuta en subshell (no afecta variables)"

cat > /tmp/test_source_$$.sh << 'EOF'
#!/bin/bash
TEST_VAR="valor desde script"
EOF

chmod +x /tmp/test_source_$$.sh

# Con source, la variable queda disponible
source /tmp/test_source_$$.sh
echo "Con source: TEST_VAR=$TEST_VAR"

# Con ejecución, la variable NO queda disponible
unset TEST_VAR
/tmp/test_source_$$.sh
echo "Con ejecución: TEST_VAR=$TEST_VAR (vacía)"

echo -e "\n=== LIBRERÍAS REUTILIZABLES ==="

# Crear librería de strings
cat > /tmp/string_lib_$$.sh << 'EOF'
#!/bin/bash

string_upper() {
    echo "$1" | tr '[:lower:]' '[:upper:]'
}

string_lower() {
    echo "$1" | tr '[:upper:]' '[:lower:]'
}

string_reverse() {
    echo "$1" | rev
}

string_length() {
    echo "${#1}"
}
EOF

source /tmp/string_lib_$$.sh

# Usar la librería
texto="Hola Mundo"
echo "Original: $texto"
echo "Mayúsculas: $(string_upper "$texto")"
echo "Minúsculas: $(string_lower "$texto")"
echo "Reverso: $(string_reverse "$texto")"
echo "Longitud: $(string_length "$texto")"

echo -e "\n=== AUTOLOAD (CARGAR BAJO DEMANDA) ==="

# Función que carga módulo solo si se necesita
cargar_modulo() {
    local modulo=$1
    if [ ! -f "$modulo" ]; then
        echo "Error: Módulo $modulo no existe" >&2
        return 1
    fi
    source "$modulo"
}

# Uso
# cargar_modulo "/path/to/modulo.sh"

echo -e "\n=== NAMESPACE SIMULADO ==="

# Usar prefijos para evitar colisiones
cat > /tmp/math_lib_$$.sh << 'EOF'
math_suma() { echo $(($1 + $2)); }
math_resta() { echo $(($1 - $2)); }
math_mult() { echo $(($1 * $2)); }
EOF

source /tmp/math_lib_$$.sh

echo "Suma: $(math_suma 10 5)"
echo "Resta: $(math_resta 10 5)"
echo "Multiplicación: $(math_mult 10 5)"

echo -e "\n=== EJEMPLO: SISTEMA MODULAR ==="

# Crear estructura de módulos
mkdir -p /tmp/proyecto_$$/lib

# Módulo de configuración
cat > /tmp/proyecto_$$/lib/config.sh << 'EOF'
#!/bin/bash
readonly APP_NAME="MiApp"
readonly APP_VERSION="1.0.0"
readonly DEBUG=${DEBUG:-false}
EOF

# Módulo de logging
cat > /tmp/proyecto_$$/lib/log.sh << 'EOF'
#!/bin/bash
log() {
    local nivel=$1
    shift
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$nivel] $@"
}
EOF

# Módulo de utilidades
cat > /tmp/proyecto_$$/lib/utils.sh << 'EOF'
#!/bin/bash
confirmar() {
    read -p "$1 (s/n): " respuesta
    [[ $respuesta =~ ^[Ss]$ ]]
}
EOF

# Script principal
cat > /tmp/proyecto_$$/main.sh << 'EOF'
#!/bin/bash

# Cargar todos los módulos
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/config.sh"
source "$SCRIPT_DIR/lib/log.sh"
source "$SCRIPT_DIR/lib/utils.sh"

# Usar funciones de los módulos
log "INFO" "$APP_NAME v$APP_VERSION iniciado"

if confirmar "¿Continuar?"; then
    log "INFO" "Usuario confirmó"
else
    log "WARN" "Usuario canceló"
fi
EOF

chmod +x /tmp/proyecto_$$/main.sh

echo "Ejecutando proyecto modular:"
echo "s" | /tmp/proyecto_$$/main.sh

# Limpiar
rm -rf /tmp/*_$$.sh /tmp/proyecto_$$

echo -e "\n¡Módulos y sourcing completado!"
