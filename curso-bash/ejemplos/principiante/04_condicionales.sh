#!/bin/bash

################################################################################
# Ejemplo 04: Condicionales (if/else)
# Descripción: Aprende a usar estructuras condicionales en BASH
# Nivel: Principiante
################################################################################

echo "=== IF BÁSICO ==="

edad=20

# Condicional simple
if [ $edad -ge 18 ]; then
    echo "Eres mayor de edad"
fi

echo -e "\n=== IF-ELSE ==="

edad=15

if [ $edad -ge 18 ]; then
    echo "Eres mayor de edad"
else
    echo "Eres menor de edad"
fi

echo -e "\n=== IF-ELIF-ELSE ==="

nota=75

if [ $nota -ge 90 ]; then
    echo "Calificación: A - Excelente"
elif [ $nota -ge 80 ]; then
    echo "Calificación: B - Muy Bien"
elif [ $nota -ge 70 ]; then
    echo "Calificación: C - Bien"
elif [ $nota -ge 60 ]; then
    echo "Calificación: D - Suficiente"
else
    echo "Calificación: F - Reprobado"
fi

echo -e "\n=== COMPARACIÓN DE NÚMEROS ==="

num1=10
num2=20

# Operadores numéricos:
# -eq : igual (equal)
# -ne : diferente (not equal)
# -gt : mayor que (greater than)
# -lt : menor que (less than)
# -ge : mayor o igual (greater or equal)
# -le : menor o igual (less or equal)

if [ $num1 -eq $num2 ]; then
    echo "$num1 es igual a $num2"
else
    echo "$num1 NO es igual a $num2"
fi

if [ $num1 -lt $num2 ]; then
    echo "$num1 es menor que $num2"
fi

if [ $num1 -ne $num2 ]; then
    echo "$num1 es diferente de $num2"
fi

echo -e "\n=== COMPARACIÓN DE STRINGS ==="

nombre1="Juan"
nombre2="Pedro"

# Operadores de string:
# = o == : igual
# != : diferente
# -z : string vacío (zero length)
# -n : string no vacío (non-zero length)

if [ "$nombre1" = "$nombre2" ]; then
    echo "Los nombres son iguales"
else
    echo "Los nombres son diferentes"
fi

if [ "$nombre1" != "$nombre2" ]; then
    echo "$nombre1 es diferente de $nombre2"
fi

# Verificar si un string está vacío
texto=""
if [ -z "$texto" ]; then
    echo "El texto está vacío"
fi

# Verificar si un string NO está vacío
texto2="Hola"
if [ -n "$texto2" ]; then
    echo "El texto NO está vacío: $texto2"
fi

echo -e "\n=== OPERADORES LÓGICOS ==="

edad=25
licencia="si"

# AND lógico: -a o &&
if [ $edad -ge 18 ] && [ "$licencia" = "si" ]; then
    echo "Puedes conducir (AND con &&)"
fi

# También se puede usar -a dentro de [ ]
if [ $edad -ge 18 -a "$licencia" = "si" ]; then
    echo "Puedes conducir (AND con -a)"
fi

# OR lógico: -o o ||
dia="sábado"
if [ "$dia" = "sábado" ] || [ "$dia" = "domingo" ]; then
    echo "Es fin de semana (OR con ||)"
fi

# También se puede usar -o dentro de [ ]
if [ "$dia" = "sábado" -o "$dia" = "domingo" ]; then
    echo "Es fin de semana (OR con -o)"
fi

# NOT lógico: !
if [ ! $edad -lt 18 ]; then
    echo "NO eres menor de edad (NOT)"
fi

echo -e "\n=== VERIFICACIÓN DE ARCHIVOS ==="

# Operadores de archivos:
# -e : existe
# -f : es un archivo regular
# -d : es un directorio
# -r : tiene permiso de lectura
# -w : tiene permiso de escritura
# -x : tiene permiso de ejecución
# -s : el archivo existe y no está vacío

archivo="test_file.txt"

# Crear archivo de prueba
echo "contenido" > "$archivo"

if [ -e "$archivo" ]; then
    echo "El archivo $archivo existe"
fi

if [ -f "$archivo" ]; then
    echo "$archivo es un archivo regular"
fi

if [ -r "$archivo" ]; then
    echo "Puedes leer $archivo"
fi

if [ -w "$archivo" ]; then
    echo "Puedes escribir en $archivo"
fi

if [ -s "$archivo" ]; then
    echo "$archivo no está vacío"
fi

# Limpiar
rm "$archivo"

echo -e "\n=== CONDICIONAL CON [[ ]] (MODERNO) ==="

# [[ ]] es más moderno y permite regex
texto="Hola Mundo"

if [[ $texto == Hola* ]]; then
    echo "El texto comienza con 'Hola'"
fi

# Comparación de rangos
letra="m"
if [[ $letra == [a-z] ]]; then
    echo "$letra es una letra minúscula"
fi

# Regex
email="usuario@example.com"
if [[ $email =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
    echo "Email válido"
else
    echo "Email inválido"
fi

echo -e "\n=== CASE (SWITCH) ==="

read -p "Ingresa un número del 1 al 3: " opcion

case $opcion in
    1)
        echo "Seleccionaste la opción 1"
        ;;
    2)
        echo "Seleccionaste la opción 2"
        ;;
    3)
        echo "Seleccionaste la opción 3"
        ;;
    *)
        echo "Opción inválida"
        ;;
esac

echo -e "\n=== CASE CON PATRONES ==="

read -p "Ingresa una fruta: " fruta

case $fruta in
    manzana|pera)
        echo "Es una fruta de pepita"
        ;;
    naranja|limón|lima)
        echo "Es un cítrico"
        ;;
    uva|fresa)
        echo "Es una fruta pequeña"
        ;;
    *)
        echo "No reconozco esa fruta"
        ;;
esac

echo -e "\n=== OPERADOR TERNARIO (ABREVIADO) ==="

edad=18
# Forma abreviada con && y ||
[ $edad -ge 18 ] && echo "Mayor de edad" || echo "Menor de edad"

# También con variables
mensaje=$([ $edad -ge 18 ] && echo "Adulto" || echo "Joven")
echo "Categoría: $mensaje"

echo -e "\n¡Condicionales completados!"
