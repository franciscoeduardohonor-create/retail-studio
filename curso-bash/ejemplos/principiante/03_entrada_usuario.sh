#!/bin/bash

################################################################################
# Ejemplo 03: Entrada del Usuario
# Descripción: Aprende a solicitar y procesar entrada del usuario
# Nivel: Principiante
################################################################################

echo "=== ENTRADA BÁSICA ==="

# Solicitar entrada básica
echo "¿Cómo te llamas?"
read nombre
echo "¡Hola $nombre! Bienvenido al curso de BASH"

echo -e "\n=== ENTRADA CON PROMPT ==="

# Usar -p para mostrar un prompt en la misma línea
read -p "¿Cuál es tu edad? " edad
echo "Tienes $edad años"

echo -e "\n=== ENTRADA SILENCIOSA (CONTRASEÑAS) ==="

# Usar -s para ocultar la entrada (útil para contraseñas)
read -sp "Ingresa tu contraseña: " password
echo # Salto de línea después de la entrada oculta
echo "Contraseña guardada (tiene ${#password} caracteres)"

echo -e "\n=== MÚLTIPLES VALORES ==="

# Leer múltiples valores en una línea
read -p "Ingresa tu nombre y apellido: " nombre apellido
echo "Nombre: $nombre"
echo "Apellido: $apellido"

echo -e "\n=== ENTRADA CON VALOR POR DEFECTO ==="

# Proporcionar un valor por defecto
read -p "¿Cuál es tu ciudad? [Madrid]: " ciudad
ciudad=${ciudad:-Madrid}  # Si está vacía, usa Madrid
echo "Ciudad: $ciudad"

echo -e "\n=== ENTRADA CON TIEMPO LÍMITE ==="

# Usar -t para establecer un timeout en segundos
echo "Tienes 5 segundos para ingresar tu color favorito:"
if read -t 5 -p "Color: " color; then
    echo "Tu color favorito es: $color"
else
    echo -e "\n¡Tiempo agotado! Usando color por defecto: azul"
    color="azul"
fi

echo -e "\n=== LEER SOLO UN CARÁCTER ==="

# Usar -n para leer solo N caracteres
read -n 1 -p "Presiona S para continuar o N para salir: " respuesta
echo # Salto de línea
if [ "$respuesta" = "S" ] || [ "$respuesta" = "s" ]; then
    echo "¡Continuando!"
else
    echo "Saliendo..."
fi

echo -e "\n=== LEER ARRAY ==="

# Leer múltiples valores en un array
read -p "Ingresa 3 frutas separadas por espacio: " -a frutas
echo "Fruta 1: ${frutas[0]}"
echo "Fruta 2: ${frutas[1]}"
echo "Fruta 3: ${frutas[2]}"
echo "Todas las frutas: ${frutas[@]}"

echo -e "\n=== ARGUMENTOS DEL SCRIPT ==="

# Los argumentos se pasan al ejecutar el script
# Ejemplo: bash 03_entrada_usuario.sh arg1 arg2 arg3

echo "Nombre del script: $0"
echo "Primer argumento: $1"
echo "Segundo argumento: $2"
echo "Todos los argumentos: $@"
echo "Número de argumentos: $#"

# Ejemplo de uso:
echo -e "\nPrueba ejecutar:"
echo "bash $0 Juan 25 Madrid"

echo -e "\n=== VALIDACIÓN DE ENTRADA ==="

# Solicitar un número y validar
while true; do
    read -p "Ingresa un número entre 1 y 10: " numero

    # Verificar si es un número
    if [[ "$numero" =~ ^[0-9]+$ ]]; then
        # Verificar si está en el rango
        if [ "$numero" -ge 1 ] && [ "$numero" -le 10 ]; then
            echo "¡Correcto! Ingresaste: $numero"
            break
        else
            echo "Error: El número debe estar entre 1 y 10"
        fi
    else
        echo "Error: Debes ingresar un número válido"
    fi
done

echo -e "\n¡Ejemplo completado!"
