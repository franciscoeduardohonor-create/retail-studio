#!/bin/bash

################################################################################
# Ejemplo 20: Utilidades del Sistema
# Descripción: Comandos útiles del sistema Linux
# Nivel: Intermedio
################################################################################

echo "=== INFORMACIÓN DEL SISTEMA ==="
echo "Sistema operativo: $(uname -s)"
echo "Kernel: $(uname -r)"
echo "Arquitectura: $(uname -m)"
echo "Hostname: $(hostname)"
echo "Usuario: $USER"
echo "Home: $HOME"
echo "Shell: $SHELL"

echo -e "\n=== ESPACIO EN DISCO ==="
echo "Uso de disco:"
df -h / | tail -1 | awk '{print "  Usado: "$3" / "$2" ("$5")"}'

echo -e "\n=== MEMORIA ==="
echo "Uso de memoria:"
free -h | grep "Mem:" | awk '{print "  Usado: "$3" / "$2}'

echo -e "\n=== PROCESOS ==="
echo "Procesos del usuario $USER:"
ps aux | grep "^$USER" | head -5 | awk '{print "  "$2, $11}'

echo -e "\n=== VARIABLES DE ENTORNO ==="
echo "Variables importantes:"
echo "  PATH: ${PATH:0:50}..."
echo "  LANG: $LANG"
echo "  PWD: $PWD"

echo -e "\n=== USUARIOS EN EL SISTEMA ==="
echo "Usuarios (primeros 5):"
cut -d: -f1 /etc/passwd | head -5 | awk '{print "  "$0}'

echo -e "\n=== UPTIME ==="
echo "Sistema activo: $(uptime -p 2>/dev/null || uptime)"

echo -e "\n=== ENCONTRAR ARCHIVOS GRANDES ==="
encontrar_archivos_grandes() {
    local dir=${1:-.}
    local size=${2:-10M}
    echo "Archivos mayores a $size en $dir:"
    find "$dir" -type f -size +$size 2>/dev/null | head -5
}

# encontrar_archivos_grandes /var/log 1M

echo -e "\n=== ARCHIVOS RECIENTES ==="
echo "Archivos modificados en la última hora (en /tmp):"
find /tmp -type f -mmin -60 -user $USER 2>/dev/null | head -5

echo -e "\n=== COMANDO WHICH ==="
echo "Ubicación de comandos:"
echo "  bash: $(which bash)"
echo "  grep: $(which grep)"
echo "  awk: $(which awk)"

echo -e "\n=== CHECKSUMS (MD5/SHA) ==="
crear_checksum() {
    local archivo=$1
    echo "test data" > "$archivo"
    echo "MD5: $(md5sum $archivo | awk '{print $1}')"
    echo "SHA256: $(sha256sum $archivo | awk '{print $1}')"
    rm -f "$archivo"
}

crear_checksum "/tmp/test_$$.txt"

echo -e "\n=== COMPRIMIR/DESCOMPRIMIR ==="
echo "Crear archivo tar.gz:"
echo "  tar -czf archivo.tar.gz directorio/"
echo "Extraer:"
echo "  tar -xzf archivo.tar.gz"

echo -e "\n=== TAR EN LA PRÁCTICA ==="
# Crear backup
mkdir -p /tmp/backup_$$
echo "datos" > /tmp/backup_$$/file.txt
tar -czf /tmp/backup_$$.tar.gz -C /tmp backup_$$
echo "✓ Backup creado: $(ls -lh /tmp/backup_$$.tar.gz | awk '{print $5}')"
rm -rf /tmp/backup_$$ /tmp/backup_$$.tar.gz

echo -e "\n=== CRON JOBS (TAREAS PROGRAMADAS) ==="
echo "Ver cron jobs del usuario:"
echo "  crontab -l"
echo -e "\nFormato de crontab:"
echo "  * * * * * comando"
echo "  │ │ │ │ │"
echo "  │ │ │ │ └─── Día de semana (0-7, 0 y 7 = Domingo)"
echo "  │ │ │ └───── Mes (1-12)"
echo "  │ │ └─────── Día del mes (1-31)"
echo "  │ └───────── Hora (0-23)"
echo "  └─────────── Minuto (0-59)"

echo -e "\n=== EJEMPLO PRÁCTICO: INFO DEL SISTEMA ==="
system_info() {
    cat << EOF
╔════════════════════════════════════════╗
║      INFORMACIÓN DEL SISTEMA           ║
╚════════════════════════════════════════╝

Sistema: $(uname -s) $(uname -r)
Hostname: $(hostname)
Usuario: $USER
Uptime: $(uptime -p 2>/dev/null || echo "N/A")
CPU: $(nproc) cores
Memoria: $(free -h | grep Mem: | awk '{print $3" / "$2}')
Disco: $(df -h / | tail -1 | awk '{print $3" / "$2}')

EOF
}

system_info

echo -e "\n=== EJEMPLO PRÁCTICO: LIMPIEZA DE DISCO ==="
limpiar_temporales() {
    echo "Limpiando archivos temporales..."

    # Archivos antiguos en /tmp
    local count=$(find /tmp -type f -user $USER -mtime +7 2>/dev/null | wc -l)
    echo "  Archivos en /tmp > 7 días: $count"

    # Logs antiguos
    local logs=$(find ~/.cache -type f -name "*.log" 2>/dev/null | wc -l)
    echo "  Logs en cache: $logs"

    echo "✓ Análisis completado (no se eliminó nada)"
}

limpiar_temporales

echo -e "\n¡Utilidades del sistema completado!"
