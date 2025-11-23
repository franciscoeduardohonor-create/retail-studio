#!/bin/bash

################################################################################
# Ejemplo 05: Bucles (Loops)
# Descripción: Aprende a usar bucles for, while y until
# Nivel: Principiante
################################################################################

echo "=== FOR LOOP BÁSICO ==="

# Iterar sobre una lista de valores
for i in 1 2 3 4 5; do
    echo "Número: $i"
done

echo -e "\n=== FOR CON RANGO ==="

# Iterar sobre un rango (estilo C)
for ((i=1; i<=5; i++)); do
    echo "Contador: $i"
done

echo -e "\n=== FOR CON SECUENCIA ==="

# Usar el comando seq para generar secuencia
echo "Del 1 al 10:"
for i in $(seq 1 10); do
    echo -n "$i "
done
echo # Salto de línea

# Secuencia con incremento
echo -e "\nNúmeros pares del 0 al 20:"
for i in $(seq 0 2 20); do
    echo -n "$i "
done
echo

# Secuencia con brace expansion {}
echo -e "\nUsando {inicio..fin}:"
for i in {1..10}; do
    echo -n "$i "
done
echo

# Con incremento
echo -e "\nDel 0 al 100 de 10 en 10:"
for i in {0..100..10}; do
    echo -n "$i "
done
echo

echo -e "\n=== FOR CON ARRAYS ==="

# Iterar sobre un array
frutas=("manzana" "pera" "uva" "naranja" "plátano")

echo "Frutas disponibles:"
for fruta in "${frutas[@]}"; do
    echo "- $fruta"
done

echo -e "\n=== FOR CON ARCHIVOS ==="

# Iterar sobre archivos (crear algunos primero)
touch file1.txt file2.txt file3.txt

echo "Archivos .txt en el directorio actual:"
for archivo in *.txt; do
    if [ -f "$archivo" ]; then
        echo "- $archivo"
    fi
done

# Limpiar archivos de prueba
rm -f file1.txt file2.txt file3.txt

echo -e "\n=== FOR CON LÍNEAS DE COMANDO ==="

# Iterar sobre la salida de un comando
echo "Usuarios del sistema:"
for usuario in $(cut -d: -f1 /etc/passwd | head -5); do
    echo "- $usuario"
done

echo -e "\n=== WHILE LOOP ==="

# While ejecuta mientras la condición sea verdadera
contador=1
echo "Contando del 1 al 5 con while:"
while [ $contador -le 5 ]; do
    echo "Contador: $contador"
    ((contador++))  # Incrementar contador
done

echo -e "\n=== WHILE CON LECTURA DE ARCHIVO ==="

# Crear archivo de prueba
cat > datos.txt << EOF
Línea 1
Línea 2
Línea 3
EOF

echo "Leyendo archivo línea por línea:"
while IFS= read -r linea; do
    echo "-> $linea"
done < datos.txt

# Limpiar
rm -f datos.txt

echo -e "\n=== WHILE INFINITO (CON BREAK) ==="

# Bucle infinito con condición de salida
contador=0
while true; do
    ((contador++))
    echo "Iteración: $contador"

    if [ $contador -eq 3 ]; then
        echo "Saliendo del bucle con break"
        break
    fi
done

echo -e "\n=== UNTIL LOOP ==="

# Until ejecuta HASTA que la condición sea verdadera (opuesto a while)
contador=1
echo "Contando con until:"
until [ $contador -gt 5 ]; do
    echo "Contador: $contador"
    ((contador++))
done

echo -e "\n=== CONTINUE (SALTAR ITERACIÓN) ==="

# Continue salta a la siguiente iteración
echo "Números del 1 al 10, saltando el 5:"
for i in {1..10}; do
    if [ $i -eq 5 ]; then
        continue  # Saltar esta iteración
    fi
    echo -n "$i "
done
echo

echo -e "\n=== BREAK (SALIR DEL BUCLE) ==="

# Break sale completamente del bucle
echo "Buscando el número 7:"
for i in {1..10}; do
    echo "Revisando: $i"
    if [ $i -eq 7 ]; then
        echo "¡Encontrado!"
        break  # Salir del bucle
    fi
done

echo -e "\n=== FOR CON ÍNDICES ==="

# Iterar con índices
frutas=("manzana" "pera" "uva" "naranja")

echo "Frutas con índice:"
for i in "${!frutas[@]}"; do
    echo "[$i] = ${frutas[$i]}"
done

echo -e "\n=== BUCLES ANIDADOS ==="

# Bucles dentro de bucles
echo "Tabla de multiplicar (3x3):"
for i in {1..3}; do
    for j in {1..3}; do
        resultado=$((i * j))
        echo -n "$i x $j = $resultado  |  "
    done
    echo  # Nueva línea
done

echo -e "\n=== SELECT (MENÚ INTERACTIVO) ==="

# Select crea un menú automáticamente
echo "Selecciona tu lenguaje favorito:"
select lenguaje in "Python" "JavaScript" "Bash" "Salir"; do
    case $lenguaje in
        "Python")
            echo "¡Excelente elección! Python es muy versátil"
            break
            ;;
        "JavaScript")
            echo "¡Genial! JavaScript domina la web"
            break
            ;;
        "Bash")
            echo "¡Perfecto! Estás en el curso correcto"
            break
            ;;
        "Salir")
            echo "Adiós"
            break
            ;;
        *)
            echo "Opción inválida, intenta de nuevo"
            ;;
    esac
done

echo -e "\n=== EJEMPLO PRÁCTICO: MENÚ ==="

# Menú completo con while
while true; do
    echo -e "\n--- MENÚ PRINCIPAL ---"
    echo "1. Ver fecha"
    echo "2. Ver usuario"
    echo "3. Ver directorio"
    echo "4. Salir"
    read -p "Selecciona una opción: " opcion

    case $opcion in
        1)
            echo "Fecha: $(date)"
            ;;
        2)
            echo "Usuario: $USER"
            ;;
        3)
            echo "Directorio: $PWD"
            ;;
        4)
            echo "¡Hasta luego!"
            break
            ;;
        *)
            echo "Opción inválida"
            ;;
    esac
done

echo -e "\n=== EJEMPLO PRÁCTICO: PROCESAMIENTO ==="

# Procesar múltiples archivos
echo "Creando y procesando archivos:"
for i in {1..3}; do
    archivo="test_$i.log"
    echo "Datos del archivo $i" > "$archivo"
    echo "Creado: $archivo"
done

echo -e "\nProcesando archivos:"
for archivo in test_*.log; do
    if [ -f "$archivo" ]; then
        echo "Procesando: $archivo"
        cat "$archivo"
    fi
done

# Limpiar
rm -f test_*.log

echo -e "\n¡Bucles completados!"
