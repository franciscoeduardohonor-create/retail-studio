#!/bin/bash

################################################################################
# Ejemplo 01: Hola Mundo
# Descripción: El script más básico - imprimir texto en pantalla
# Nivel: Principiante
################################################################################

# El comando 'echo' imprime texto en la terminal
echo "¡Hola Mundo!"

# Puedes usar comillas simples o dobles
echo '¡Bienvenido al curso de BASH!'

# Sin comillas para texto sin espacios
echo Hola

# Echo con salto de línea adicional
echo -e "Primera línea\nSegunda línea"

# Echo sin salto de línea al final (el siguiente texto continúa en la misma línea)
echo -n "Texto sin salto de línea "
echo "continúa aquí"

# Imprimir con colores (códigos ANSI)
echo -e "\e[32m¡Texto en verde!\e[0m"
echo -e "\e[31m¡Texto en rojo!\e[0m"
echo -e "\e[33m¡Texto en amarillo!\e[0m"
echo -e "\e[34m¡Texto en azul!\e[0m"

# Imprimir la fecha actual
echo "Fecha actual: $(date)"

# Imprimir nombre del usuario
echo "Usuario actual: $USER"
