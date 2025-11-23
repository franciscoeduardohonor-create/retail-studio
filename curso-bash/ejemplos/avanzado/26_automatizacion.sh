#!/bin/bash

################################################################################
# Ejemplo 26: Automatización Avanzada
# Descripción: Scripts para automatizar tareas complejas
# Nivel: Avanzado
################################################################################

echo "=== BACKUP AUTOMATIZADO ==="

backup_script() {
    local source_dir=${1:-$HOME/documentos}
    local backup_dir=${2:-$HOME/backups}
    local fecha=$(date +%Y%m%d_%H%M%S)
    local backup_file="$backup_dir/backup_$fecha.tar.gz"

    echo "Creando backup..."
    echo "  Origen: $source_dir"
    echo "  Destino: $backup_file"

    # mkdir -p "$backup_dir"
    # tar -czf "$backup_file" -C "$(dirname $source_dir)" "$(basename $source_dir)"
    echo "✓ Backup completado (simulado)"

    # Limpiar backups antiguos (mantener últimos 7)
    echo "Limpiando backups antiguos..."
    # find "$backup_dir" -name "backup_*.tar.gz" -mtime +7 -delete
    echo "✓ Limpieza completada"
}

backup_script

echo -e "\n=== DEPLOYMENT AUTOMATIZADO ==="

deploy_app() {
    local app_dir="/var/www/app"
    local repo_url="https://github.com/user/app.git"

    echo "Deployment automatizado:"
    echo "1. Crear backup"
    echo "  ✓ Backup creado"

    echo "2. Pull código actualizado"
    # cd "$app_dir" && git pull
    echo "  ✓ Código actualizado"

    echo "3. Instalar dependencias"
    # npm install
    echo "  ✓ Dependencias instaladas"

    echo "4. Ejecutar tests"
    # npm test
    echo "  ✓ Tests pasados"

    echo "5. Rebuild aplicación"
    # npm run build
    echo "  ✓ Build completado"

    echo "6. Reiniciar servicio"
    # systemctl restart app
    echo "  ✓ Servicio reiniciado"

    echo -e "\n✓ Deployment completado"
}

deploy_script() {
    local start=$(date +%s)

    # Validaciones
    echo "Validando ambiente..."

    # Deploy
    deploy_app

    # Tiempo total
    local end=$(date +%s)
    local duration=$((end - start))
    echo "Tiempo total: ${duration}s"
}

deploy_script

echo -e "\n=== MONITOREO DE SERVICIOS ==="

monitor_service() {
    local service=$1
    local email="admin@example.com"

    # Verificar si el servicio está corriendo
    # if ! systemctl is-active --quiet "$service"; then
    #     echo "ALERTA: $service está caído"
    #     # Intentar reiniciar
    #     systemctl restart "$service"
    #     # Enviar email
    #     echo "Servicio $service reiniciado" | mail -s "ALERTA" "$email"
    # fi

    echo "✓ Monitoreo de $service (simulado)"
}

monitor_service "nginx"
monitor_service "mysql"

echo -e "\n=== LIMPIEZA AUTOMATIZADA ==="

cleanup_system() {
    echo "Limpieza del sistema:"

    echo "1. Logs antiguos"
    # find /var/log -name "*.log" -mtime +30 -delete
    echo "  ✓ Logs limpiados"

    echo "2. Archivos temporales"
    # find /tmp -type f -mtime +7 -delete
    echo "  ✓ Temporales eliminados"

    echo "3. Cache de apt"
    # apt-get clean
    echo "  ✓ Cache limpiado"

    echo "4. Docker unused"
    # docker system prune -af
    echo "  ✓ Docker limpiado"

    echo -e "\n✓ Sistema limpiado"
}

cleanup_system

echo -e "\n=== TAREAS PROGRAMADAS (CRON) ==="

cat << 'EOF'
Ejemplos de crontab:

# Backup diario a las 2 AM
0 2 * * * /home/user/scripts/backup.sh

# Limpieza cada domingo a las 3 AM
0 3 * * 0 /home/user/scripts/cleanup.sh

# Monitoreo cada 5 minutos
*/5 * * * * /home/user/scripts/monitor.sh

# Deploy cada viernes a las 6 PM
0 18 * * 5 /home/user/scripts/deploy.sh
EOF

echo -e "\n¡Automatización completada!"
