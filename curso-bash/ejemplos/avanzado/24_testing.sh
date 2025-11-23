#!/bin/bash

################################################################################
# Ejemplo 24: Testing de Scripts
# Descripción: Cómo hacer pruebas de tus scripts
# Nivel: Avanzado
################################################################################

echo "=== FRAMEWORK DE TESTING SIMPLE ==="

# Contadores
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0

# Función assert
assert_equals() {
    local esperado=$1
    local actual=$2
    local mensaje="${3:-}"

    ((TESTS_RUN++))

    if [ "$esperado" = "$actual" ]; then
        echo "✓ PASS: $mensaje"
        ((TESTS_PASSED++))
    else
        echo "✗ FAIL: $mensaje"
        echo "  Esperado: $esperado"
        echo "  Actual: $actual"
        ((TESTS_FAILED++))
    fi
}

assert_true() {
    local condicion="$1"
    local mensaje="${2:-}"

    ((TESTS_RUN++))

    if eval "$condicion"; then
        echo "✓ PASS: $mensaje"
        ((TESTS_PASSED++))
    else
        echo "✗ FAIL: $mensaje"
        ((TESTS_FAILED++))
    fi
}

# Reporte final
test_summary() {
    echo -e "\n═══════════════════════════════"
    echo "Tests ejecutados: $TESTS_RUN"
    echo "Tests pasados: $TESTS_PASSED"
    echo "Tests fallados: $TESTS_FAILED"
    echo "═══════════════════════════════"

    if [ $TESTS_FAILED -eq 0 ]; then
        echo "✓ TODOS LOS TESTS PASARON"
        return 0
    else
        echo "✗ ALGUNOS TESTS FALLARON"
        return 1
    fi
}

echo -e "\n=== TESTS DE FUNCIONES ==="

# Función a testear
suma() {
    echo $(($1 + $2))
}

# Tests
echo "Testing función suma():"
assert_equals 5 "$(suma 2 3)" "suma(2,3) = 5"
assert_equals 0 "$(suma -5 5)" "suma(-5,5) = 0"
assert_equals 20 "$(suma 10 10)" "suma(10,10) = 20"

echo -e "\n=== TESTS DE CONDICIONES ==="

# Función a testear
es_par() {
    [ $(($1 % 2)) -eq 0 ]
}

echo "Testing función es_par():"
assert_true "es_par 4" "4 es par"
assert_true "! es_par 5" "5 no es par"
assert_true "es_par 0" "0 es par"

echo -e "\n=== TESTS DE ARCHIVOS ==="

# Función a testear
crear_archivo() {
    local archivo=$1
    echo "contenido" > "$archivo"
}

echo "Testing función crear_archivo():"
archivo_test="/tmp/test_$$.txt"
crear_archivo "$archivo_test"
assert_true "[ -f '$archivo_test' ]" "Archivo creado"
assert_true "[ -s '$archivo_test' ]" "Archivo no vacío"
rm -f "$archivo_test"

echo -e "\n=== MOCK DE COMANDOS ==="

# Simular comando externo
curl() {
    echo '{"status":"ok"}'
}

# Test
echo "Testing con mock:"
resultado=$(curl)
assert_equals '{"status":"ok"}' "$resultado" "curl retorna JSON"

# Restaurar
unset -f curl

echo -e "\n=== TEST COVERAGE ==="

funcion_con_branches() {
    local x=$1

    if [ $x -gt 10 ]; then
        echo "mayor"
    elif [ $x -eq 10 ]; then
        echo "igual"
    else
        echo "menor"
    fi
}

echo "Testing coverage de ramas:"
assert_equals "mayor" "$(funcion_con_branches 15)" "Branch: mayor"
assert_equals "igual" "$(funcion_con_branches 10)" "Branch: igual"
assert_equals "menor" "$(funcion_con_branches 5)" "Branch: menor"

echo -e "\n=== EJEMPLO COMPLETO ==="

# Función real
validar_email() {
    local email=$1
    [[ $email =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]
}

# Suite de tests
echo "Suite de tests para validar_email():"
assert_true "validar_email 'test@example.com'" "Email válido simple"
assert_true "validar_email 'user.name@domain.co.uk'" "Email con subdominios"
assert_true "! validar_email 'invalid'" "Email inválido"
assert_true "! validar_email '@example.com'" "Email sin usuario"
assert_true "! validar_email 'test@'" "Email sin dominio"

# Mostrar resumen
test_summary

echo -e "\n¡Testing completado!"
