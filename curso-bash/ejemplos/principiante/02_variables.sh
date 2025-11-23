#!/bin/bash

################################################################################
# Ejemplo 02: Variables
# Descripción: Aprende a declarar y usar variables en BASH
# Nivel: Principiante
################################################################################

echo "=== DECLARACIÓN DE VARIABLES ==="

# Declarar variables (¡SIN espacios alrededor del =!)
nombre="Carlos"
edad=30
ciudad="Madrid"
precio=99.99

# Imprimir variables (usar $ antes del nombre)
echo "Nombre: $nombre"
echo "Edad: $edad"
echo "Ciudad: $ciudad"
echo "Precio: $precio"

echo -e "\n=== VARIABLES CON LLAVES ==="

# Usar llaves {} para mayor claridad
echo "Mi nombre es ${nombre} y vivo en ${ciudad}"

# Las llaves son útiles cuando concatenas texto
echo "El archivo se llama ${nombre}_datos.txt"

echo -e "\n=== VARIABLES DE ENTORNO ==="

# Variables predefinidas del sistema
echo "Usuario: $USER"
echo "Directorio home: $HOME"
echo "Directorio actual: $PWD"
echo "Shell actual: $SHELL"
echo "Nombre del host: $HOSTNAME"

echo -e "\n=== OPERACIONES CON VARIABLES ==="

# Operaciones aritméticas
numero1=10
numero2=5

# Método 1: usando $(( ))
suma=$((numero1 + numero2))
resta=$((numero1 - numero2))
multiplicacion=$((numero1 * numero2))
division=$((numero1 / numero2))

echo "Suma: $numero1 + $numero2 = $suma"
echo "Resta: $numero1 - $numero2 = $resta"
echo "Multiplicación: $numero1 * $numero2 = $multiplicacion"
echo "División: $numero1 / $numero2 = $division"

# Método 2: usando let
let resultado=numero1+numero2
echo "Resultado con let: $resultado"

# Método 3: usando expr (antiguo)
resultado2=$(expr $numero1 + $numero2)
echo "Resultado con expr: $resultado2"

echo -e "\n=== VARIABLES DE SOLO LECTURA ==="

# Variable de solo lectura (constante)
readonly PI=3.14159
echo "PI = $PI"

# Si intentas cambiarla, dará error:
# PI=3.14  # Descomenta para ver el error

echo -e "\n=== VARIABLES VACÍAS Y NULAS ==="

# Variable vacía
variable_vacia=""
echo "Variable vacía: '$variable_vacia'"

# Variable no definida
echo "Variable no definida: '$variable_no_existe'"

# Asignar valor por defecto si está vacía
nombre_usuario=${usuario:-"Invitado"}
echo "Nombre de usuario: $nombre_usuario"

echo -e "\n=== LONGITUD DE STRINGS ==="

texto="Hola Mundo"
echo "Texto: $texto"
echo "Longitud: ${#texto} caracteres"

echo -e "\n=== EXPORTAR VARIABLES ==="

# Exportar variable para que esté disponible en subprocesos
export MI_VARIABLE="Valor global"
echo "Variable exportada: $MI_VARIABLE"

# Ver todas las variables de entorno
echo -e "\nPara ver todas las variables, ejecuta: printenv o env"
