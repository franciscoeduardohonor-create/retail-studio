#!/bin/bash

################################################################################
# Ejemplo 27: APIs y JSON
# Descripción: Trabajar con APIs REST y datos JSON
# Nivel: Avanzado
################################################################################

echo "=== HACER REQUESTS HTTP ==="

# GET request
hacer_get() {
    local url=$1
    curl -s -X GET "$url"
}

# POST request
hacer_post() {
    local url=$1
    local datos=$2

    curl -s -X POST "$url" \
        -H "Content-Type: application/json" \
        -d "$datos"
}

echo "Ejemplos de requests:"
echo "  GET:  curl -s https://api.ejemplo.com/users"
echo "  POST: curl -s -X POST -d '{\"name\":\"Juan\"}' ..."

echo -e "\n=== PARSEAR JSON ==="

# JSON de ejemplo
json='{"name":"Juan","age":30,"city":"Madrid","skills":["bash","python","docker"]}'

# Usando grep/sed (básico)
echo "Parseo básico con grep:"
echo "$json" | grep -o '"name":"[^"]*"' | cut -d'"' -f4

# Mejor: usar jq si está disponible
if command -v jq &> /dev/null; then
    echo -e "\nParseo con jq:"
    echo "$json" | jq -r '.name'
    echo "$json" | jq -r '.skills[]'
else
    echo -e "\n(jq no está instalado)"
fi

echo -e "\n=== CREAR JSON ==="

crear_json() {
    local nombre=$1
    local edad=$2

    cat <<EOF
{
  "nombre": "$nombre",
  "edad": $edad,
  "timestamp": "$(date -Iseconds)",
  "activo": true
}
EOF
}

echo "JSON creado:"
crear_json "María" 28

echo -e "\n=== API PÚBLICA (EJEMPLO) ==="

# Simular llamada a API pública
consultar_api() {
    local endpoint="https://jsonplaceholder.typicode.com/users/1"

    echo "Consultando API: $endpoint"
    # local respuesta=$(curl -s "$endpoint")

    # if command -v jq &> /dev/null; then
    #     echo "$respuesta" | jq -r '.name'
    # fi

    echo "✓ (Ejemplo simulado - requiere conexión)"
}

consultar_api

echo -e "\n=== AUTENTICACIÓN CON TOKEN ==="

api_con_auth() {
    local url="https://api.ejemplo.com/protected"
    local token="mi_token_secreto"

    echo "Request con autenticación:"
    echo "curl -H \"Authorization: Bearer $token\" $url"
}

api_con_auth

echo -e "\n=== PROCESAR RESPUESTA JSON ==="

procesar_json_response() {
    # Simular respuesta
    local json='[
        {"id":1,"status":"active"},
        {"id":2,"status":"inactive"},
        {"id":3,"status":"active"}
    ]'

    echo "Procesando lista de usuarios activos:"

    # Sin jq (básico)
    echo "$json" | grep -o '"status":"active"' | wc -l | \
        xargs echo "Usuarios activos:"

    # Con jq sería:
    # echo "$json" | jq '[.[] | select(.status=="active")] | length'
}

procesar_json_response

echo -e "\n=== EJEMPLO COMPLETO: WEBHOOK ==="

webhook_handler() {
    local payload=$1

    # Parsear evento
    local event=$(echo "$payload" | grep -o '"event":"[^"]*"' | cut -d'"' -f4)

    echo "Webhook recibido: $event"

    case $event in
        "push")
            echo "  → Ejecutando deploy..."
            ;;
        "pull_request")
            echo "  → Ejecutando tests..."
            ;;
        *)
            echo "  → Evento no manejado"
            ;;
    esac
}

# Simular payload
payload='{"event":"push","branch":"main"}'
webhook_handler "$payload"

echo -e "\n¡APIs y JSON completado!"
