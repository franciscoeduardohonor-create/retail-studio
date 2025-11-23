#!/bin/bash

################################################################################
# Ejemplo 16: Manejo de Fechas y Tiempo
# Descripción: Trabajar con fechas, horas y timestamps
# Nivel: Intermedio
################################################################################

echo "=== FECHA Y HORA ACTUAL ==="
echo "Fecha completa: $(date)"
echo "Fecha ISO 8601: $(date -I)"
echo "Fecha/Hora: $(date '+%Y-%m-%d %H:%M:%S')"
echo "Solo fecha: $(date '+%Y-%m-%d')"
echo "Solo hora: $(date '+%H:%M:%S')"

echo -e "\n=== FORMATOS PERSONALIZADOS ==="
echo "Día: $(date '+%d')"
echo "Mes: $(date '+%m')"
echo "Año: $(date '+%Y')"
echo "Día de la semana: $(date '+%A')"
echo "Mes en texto: $(date '+%B')"
echo "Formato US: $(date '+%m/%d/%Y')"
echo "Hora 12h: $(date '+%I:%M %p')"

echo -e "\n=== TIMESTAMPS ==="
# Timestamp Unix (segundos desde 1970-01-01)
timestamp=$(date +%s)
echo "Timestamp actual: $timestamp"

# Convertir timestamp a fecha
echo "Fecha del timestamp: $(date -d @$timestamp '+%Y-%m-%d %H:%M:%S')"

echo -e "\n=== OPERACIONES CON FECHAS ==="
echo "Ayer: $(date -d 'yesterday' '+%Y-%m-%d')"
echo "Mañana: $(date -d 'tomorrow' '+%Y-%m-%d')"
echo "Hace 7 días: $(date -d '7 days ago' '+%Y-%m-%d')"
echo "En 30 días: $(date -d '30 days' '+%Y-%m-%d')"
echo "Próximo mes: $(date -d 'next month' '+%Y-%m-%d')"

echo -e "\n=== CALCULAR DIFERENCIA ==="
fecha1=$(date -d '2024-01-01' +%s)
fecha2=$(date -d '2024-12-31' +%s)
diferencia=$((fecha2 - fecha1))
dias=$((diferencia / 86400))  # 86400 segundos en un día
echo "Días entre 2024-01-01 y 2024-12-31: $dias días"

echo -e "\n=== VALIDAR FECHAS ==="
validar_fecha() {
    local fecha=$1
    if date -d "$fecha" &>/dev/null; then
        echo "✓ '$fecha' es válida"
        return 0
    else
        echo "✗ '$fecha' NO es válida"
        return 1
    fi
}

validar_fecha "2024-02-29"
validar_fecha "2024-02-30"

echo -e "\n=== MEDIR TIEMPOS ==="
inicio=$(date +%s%N)
sleep 0.5
fin=$(date +%s%N)
duracion=$(( (fin - inicio) / 1000000 ))
echo "Operación tardó: ${duracion}ms"

echo -e "\n=== EJEMPLO: NOMBRES CON FECHA ==="
backup_file="backup_$(date +%Y%m%d_%H%M%S).tar.gz"
log_file="log_$(date +%Y-%m-%d).txt"
echo "Archivo de backup: $backup_file"
echo "Archivo de log: $log_file"

echo -e "\n=== EJEMPLO: EDAD EN DÍAS ==="
nacimiento="1990-01-01"
hoy=$(date +%s)
nac_ts=$(date -d "$nacimiento" +%s)
edad_dias=$(( (hoy - nac_ts) / 86400 ))
echo "Días desde $nacimiento: $edad_dias días"

echo -e "\n¡Fechas y tiempo completado!"
