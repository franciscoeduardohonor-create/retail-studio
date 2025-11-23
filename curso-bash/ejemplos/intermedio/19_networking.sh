#!/bin/bash

################################################################################
# Ejemplo 19: Networking y HTTP
# Descripción: Operaciones de red básicas
# Nivel: Intermedio
################################################################################

echo "=== INFORMACIÓN DE RED ==="
echo "Hostname: $(hostname)"
echo "IP interna: $(hostname -I | awk '{print $1}')"

echo -e "\n=== CURL - REQUESTS HTTP ==="
echo "Verificando conectividad a Google..."
if curl -s --head --connect-timeout 2 https://www.google.com > /dev/null; then
    echo "✓ Conectividad OK"
else
    echo "✗ Sin conectividad"
fi

echo -e "\n=== DESCARGAR ARCHIVO ==="
# curl -O descarga archivo
echo "Descarga con curl:"
echo "  curl -O https://ejemplo.com/archivo.zip"
echo "  curl -o nombre.zip https://ejemplo.com/archivo.zip"

echo -e "\n=== HTTP GET ==="
# Hacer request GET
echo "GET request:"
echo '  respuesta=$(curl -s https://api.ejemplo.com/datos)'

echo -e "\n=== HTTP POST ==="
# POST con datos JSON
echo "POST request:"
cat << 'EOF'
  curl -X POST https://api.ejemplo.com/users \
    -H "Content-Type: application/json" \
    -d '{"name":"Juan","age":30}'
EOF

echo -e "\n=== VERIFICAR SITIO WEB ==="
verificar_sitio() {
    local url=$1
    local status=$(curl -s -o /dev/null -w "%{http_code}" "$url")

    case $status in
        200)
            echo "✓ $url está activo (HTTP $status)"
            ;;
        404)
            echo "✗ $url no encontrado (HTTP $status)"
            ;;
        500|502|503)
            echo "✗ $url tiene error de servidor (HTTP $status)"
            ;;
        *)
            echo "? $url código: $status"
            ;;
    esac
}

verificar_sitio "https://www.google.com"

echo -e "\n=== PING - VERIFICAR HOST ==="
# Ping para verificar conectividad
ping_host() {
    local host=$1
    if ping -c 1 -W 1 "$host" &> /dev/null; then
        echo "✓ $host es alcanzable"
    else
        echo "✗ $host NO es alcanzable"
    fi
}

ping_host "8.8.8.8"

echo -e "\n=== DESCARGAR Y PROCESAR ==="
# Descargar y procesar en un pipeline
echo "Descargar y procesar JSON (ejemplo):"
cat << 'EOF'
  curl -s https://api.ejemplo.com/users | \
    grep -o '"name":"[^"]*"' | \
    cut -d'"' -f4
EOF

echo -e "\n=== TIMEOUT EN REQUESTS ==="
echo "Request con timeout de 5 segundos:"
echo '  curl --connect-timeout 5 --max-time 10 https://ejemplo.com'

echo -e "\n=== SEGUIR REDIRECCIONES ==="
echo "Seguir redirecciones HTTP:"
echo '  curl -L https://bit.ly/ejemplo'

echo -e "\n=== HEADERS PERSONALIZADOS ==="
echo "Agregar headers:"
cat << 'EOF'
  curl -H "Authorization: Bearer TOKEN" \
       -H "User-Agent: MiScript/1.0" \
       https://api.ejemplo.com
EOF

echo -e "\n=== EJEMPLO PRÁCTICO: MONITOR ==="
monitorear_sitios() {
    local sitios=(
        "https://www.google.com"
        "https://www.github.com"
    )

    echo "Monitoreando sitios..."
    for sitio in "${sitios[@]}"; do
        if curl -s --head --connect-timeout 2 "$sitio" > /dev/null; then
            echo "  ✓ $(echo $sitio | cut -d'/' -f3)"
        else
            echo "  ✗ $(echo $sitio | cut -d'/' -f3) CAÍDO"
        fi
    done
}

monitorear_sitios

echo -e "\n¡Networking completado!"
