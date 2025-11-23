#!/bin/bash

################################################################################
# Ejemplo 30: Proyecto Completo
# Descripción: Sistema de gestión de tareas (Task Manager)
# Nivel: Avanzado
################################################################################

# Modo seguro
set -euo pipefail

# Configuración
readonly APP_NAME="TaskManager"
readonly APP_VERSION="1.0.0"
readonly DATA_FILE="${HOME}/.taskmanager.db"
readonly LOG_FILE="${HOME}/.taskmanager.log"

# Colores
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m'  # No Color

# ============================================================================
# LOGGING
# ============================================================================

log() {
    local nivel=$1
    shift
    local mensaje="$@"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$nivel] $mensaje" >> "$LOG_FILE"
}

log_info() { log "INFO" "$@"; }
log_error() { log "ERROR" "$@"; }

# ============================================================================
# BASE DE DATOS
# ============================================================================

db_init() {
    if [ ! -f "$DATA_FILE" ]; then
        sqlite3 "$DATA_FILE" << 'EOF'
CREATE TABLE tareas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo TEXT NOT NULL,
    descripcion TEXT,
    estado TEXT DEFAULT 'pendiente',
    prioridad TEXT DEFAULT 'media',
    fecha_creacion TEXT DEFAULT CURRENT_TIMESTAMP,
    fecha_completado TEXT
);
EOF
        log_info "Base de datos inicializada"
    fi
}

# ============================================================================
# FUNCIONES DE TAREAS
# ============================================================================

tarea_agregar() {
    local titulo=$1
    local descripcion=${2:-""}
    local prioridad=${3:-"media"}

    sqlite3 "$DATA_FILE" << EOF
INSERT INTO tareas (titulo, descripcion, prioridad)
VALUES ('$titulo', '$descripcion', '$prioridad');
EOF

    echo -e "${GREEN}✓${NC} Tarea agregada: $titulo"
    log_info "Tarea agregada: $titulo"
}

tarea_listar() {
    local filtro=${1:-"all"}

    echo -e "\n${BLUE}═══════════════════════════════════════${NC}"
    echo -e "${BLUE}  LISTA DE TAREAS${NC}"
    echo -e "${BLUE}═══════════════════════════════════════${NC}\n"

    local query="SELECT id, titulo, estado, prioridad FROM tareas"

    case $filtro in
        pendiente)
            query="$query WHERE estado='pendiente'"
            ;;
        completado)
            query="$query WHERE estado='completado'"
            ;;
    esac

    query="$query ORDER BY
        CASE prioridad
            WHEN 'alta' THEN 1
            WHEN 'media' THEN 2
            WHEN 'baja' THEN 3
        END,
        fecha_creacion DESC"

    sqlite3 -header -column "$DATA_FILE" "$query"
    echo ""
}

tarea_completar() {
    local id=$1

    sqlite3 "$DATA_FILE" << EOF
UPDATE tareas
SET estado='completado', fecha_completado=CURRENT_TIMESTAMP
WHERE id=$id;
EOF

    echo -e "${GREEN}✓${NC} Tarea $id completada"
    log_info "Tarea $id completada"
}

tarea_eliminar() {
    local id=$1

    sqlite3 "$DATA_FILE" "DELETE FROM tareas WHERE id=$id;"

    echo -e "${GREEN}✓${NC} Tarea $id eliminada"
    log_info "Tarea $id eliminada"
}

tarea_estadisticas() {
    echo -e "\n${BLUE}═══════════════════════════════════════${NC}"
    echo -e "${BLUE}  ESTADÍSTICAS${NC}"
    echo -e "${BLUE}═══════════════════════════════════════${NC}\n"

    local total=$(sqlite3 "$DATA_FILE" "SELECT COUNT(*) FROM tareas;")
    local pendientes=$(sqlite3 "$DATA_FILE" "SELECT COUNT(*) FROM tareas WHERE estado='pendiente';")
    local completadas=$(sqlite3 "$DATA_FILE" "SELECT COUNT(*) FROM tareas WHERE estado='completado';")

    echo "Total de tareas: $total"
    echo "Pendientes: $pendientes"
    echo "Completadas: $completadas"

    if [ $total -gt 0 ]; then
        local porcentaje=$((completadas * 100 / total))
        echo "Progreso: $porcentaje%"
    fi

    echo ""
}

# ============================================================================
# INTERFAZ DE USUARIO
# ============================================================================

mostrar_ayuda() {
    cat << EOF

${BLUE}$APP_NAME v$APP_VERSION${NC}
Sistema de gestión de tareas

${YELLOW}Uso:${NC}
  $0 <comando> [argumentos]

${YELLOW}Comandos:${NC}
  add <título> [descripción] [prioridad]   Agregar tarea
  list [filtro]                             Listar tareas
  complete <id>                             Completar tarea
  delete <id>                               Eliminar tarea
  stats                                     Ver estadísticas
  help                                      Mostrar ayuda

${YELLOW}Ejemplos:${NC}
  $0 add "Estudiar BASH" "Completar el curso" alta
  $0 list pendiente
  $0 complete 1
  $0 delete 2
  $0 stats

EOF
}

menu_interactivo() {
    while true; do
        echo -e "\n${BLUE}═══════════════════════════════════════${NC}"
        echo -e "${BLUE}  $APP_NAME v$APP_VERSION${NC}"
        echo -e "${BLUE}═══════════════════════════════════════${NC}"
        echo "1. Agregar tarea"
        echo "2. Listar tareas"
        echo "3. Completar tarea"
        echo "4. Eliminar tarea"
        echo "5. Estadísticas"
        echo "6. Salir"
        echo -e "${BLUE}═══════════════════════════════════════${NC}"

        read -p "Selecciona opción: " opcion

        case $opcion in
            1)
                read -p "Título: " titulo
                read -p "Descripción: " desc
                read -p "Prioridad (alta/media/baja): " prio
                tarea_agregar "$titulo" "$desc" "${prio:-media}"
                ;;
            2)
                read -p "Filtro (all/pendiente/completado): " filtro
                tarea_listar "${filtro:-all}"
                ;;
            3)
                tarea_listar "pendiente"
                read -p "ID de tarea a completar: " id
                tarea_completar "$id"
                ;;
            4)
                tarea_listar
                read -p "ID de tarea a eliminar: " id
                tarea_eliminar "$id"
                ;;
            5)
                tarea_estadisticas
                ;;
            6)
                echo -e "${GREEN}¡Hasta luego!${NC}"
                exit 0
                ;;
            *)
                echo -e "${RED}Opción inválida${NC}"
                ;;
        esac
    done
}

# ============================================================================
# MAIN
# ============================================================================

main() {
    # Inicializar base de datos
    if command -v sqlite3 &> /dev/null; then
        db_init
    else
        echo -e "${RED}Error: SQLite no está instalado${NC}"
        exit 1
    fi

    # Procesar argumentos
    if [ $# -eq 0 ]; then
        menu_interactivo
        return 0
    fi

    local comando=$1
    shift

    case $comando in
        add)
            if [ $# -lt 1 ]; then
                echo -e "${RED}Error: Título requerido${NC}"
                exit 1
            fi
            tarea_agregar "$@"
            ;;
        list)
            tarea_listar "$@"
            ;;
        complete)
            if [ $# -lt 1 ]; then
                echo -e "${RED}Error: ID requerido${NC}"
                exit 1
            fi
            tarea_completar "$1"
            ;;
        delete)
            if [ $# -lt 1 ]; then
                echo -e "${RED}Error: ID requerido${NC}"
                exit 1
            fi
            tarea_eliminar "$1"
            ;;
        stats)
            tarea_estadisticas
            ;;
        help|--help|-h)
            mostrar_ayuda
            ;;
        *)
            echo -e "${RED}Comando desconocido: $comando${NC}"
            mostrar_ayuda
            exit 1
            ;;
    esac
}

# ============================================================================
# EJECUCIÓN
# ============================================================================

# Trap para limpieza
trap 'log_info "Aplicación cerrada"' EXIT

# Ejecutar main
main "$@"
