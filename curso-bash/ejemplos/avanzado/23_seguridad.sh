#!/bin/bash

################################################################################
# Ejemplo 23: Seguridad en Scripts
# Descripción: Mejores prácticas de seguridad
# Nivel: Avanzado
################################################################################

echo "=== MODO SEGURO ==="
set -euo pipefail
echo "✓ Modo seguro activado:"
echo "  -e: salir si hay error"
echo "  -u: error en variables no definidas"
echo "  -o pipefail: detectar errores en pipes"

echo -e "\n=== VALIDAR ENTRADAS ==="

# NUNCA confiar en input del usuario
validar_input() {
    local input=$1

    # Verificar que no contenga caracteres peligrosos
    if [[ $input =~ [\;\|\&\$\`] ]]; then
        echo "✗ Input contiene caracteres peligrosos"
        return 1
    fi

    # Validar formato esperado
    if [[ ! $input =~ ^[a-zA-Z0-9_-]+$ ]]; then
        echo "✗ Input inválido"
        return 1
    fi

    echo "✓ Input válido: $input"
}

validar_input "archivo_ok"
validar_input "archivo; rm -rf /" || true

echo -e "\n=== EVITAR COMMAND INJECTION ==="

# MAL: Vulnerable a inyección
procesar_mal() {
    local archivo=$1
    # eval "cat $archivo"  # ¡NUNCA HACER ESTO!
    echo "✗ Evitar: eval con input del usuario"
}

# BIEN: Usar comillas y validación
procesar_bien() {
    local archivo=$1

    if [ ! -f "$archivo" ]; then
        echo "✗ Archivo no existe"
        return 1
    fi

    cat "$archivo"  # Seguro con comillas
}

echo "✓ Siempre validar y usar comillas"

echo -e "\n=== PERMISOS SEGUROS ==="

# Crear archivos con permisos restrictivos
crear_seguro() {
    local archivo=$1

    # Establecer umask para permisos seguros
    local old_umask=$(umask)
    umask 077  # rw------- (600)

    echo "datos sensibles" > "$archivo"

    umask "$old_umask"

    ls -l "$archivo" | awk '{print "Permisos: "$1}'
    rm -f "$archivo"
}

crear_seguro "/tmp/secure_$$"

echo -e "\n=== LIMPIAR VARIABLES SENSIBLES ==="

limpiar_sensible() {
    local password="mi_password"

    # Usar la variable...

    # Limpiar de memoria
    unset password
    echo "✓ Variable limpiada"
}

limpiar_sensible

echo -e "\n=== PATH TRAVERSAL ==="

# Prevenir path traversal
validar_path() {
    local archivo=$1
    local base_dir="/tmp"

    # Resolver path real
    local real_path=$(readlink -f "$archivo" 2>/dev/null)

    # Verificar que esté dentro del directorio permitido
    if [[ ! $real_path == $base_dir/* ]]; then
        echo "✗ Path fuera del directorio permitido"
        return 1
    fi

    echo "✓ Path válido: $real_path"
}

validar_path "/tmp/test.txt"
validar_path "/etc/passwd" || true

echo -e "\n=== TMPFILE SEGURO ==="

# Crear archivo temporal seguro
crear_tmp_seguro() {
    # mktemp crea archivo único y seguro
    local tmpfile=$(mktemp)
    echo "✓ Tmpfile seguro: $tmpfile"

    echo "datos" > "$tmpfile"

    # Limpiar
    rm -f "$tmpfile"
}

crear_tmp_seguro

echo -e "\n=== VERIFICAR CHECKSUMS ==="

verificar_checksum() {
    local archivo=$1
    local checksum_esperado=$2

    echo "test data" > "$archivo"

    local checksum_actual=$(sha256sum "$archivo" | awk '{print $1}')

    echo "Checksum: $checksum_actual"

    # En producción, comparar con checksum esperado
    # if [ "$checksum_actual" != "$checksum_esperado" ]; then
    #     echo "✗ Checksum no coincide!"
    #     return 1
    # fi

    rm -f "$archivo"
}

verificar_checksum "/tmp/test_$$.txt" "abc123"

echo -e "\n=== NO MOSTRAR INFORMACIÓN SENSIBLE ==="

# NO hacer:
# echo "Password: $PASSWORD"
# ls -la ~/.ssh/

# En su lugar, usar logging seguro
log_seguro() {
    local mensaje=$1
    # Filtrar información sensible
    echo "$mensaje" | sed 's/password=.*/password=***/gi'
}

log_seguro "Conectando con password=secreto123"

echo -e "\n¡Seguridad completada!"
