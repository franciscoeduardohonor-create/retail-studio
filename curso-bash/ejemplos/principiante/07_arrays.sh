#!/bin/bash

################################################################################
# Ejemplo 07: Arrays (Arreglos)
# Descripción: Aprende a trabajar con arrays en BASH
# Nivel: Principiante
################################################################################

echo "=== DECLARAR ARRAYS ==="

# Método 1: Declarar array con valores
frutas=("manzana" "pera" "uva" "naranja")

# Método 2: Declarar array vacío
declare -a numeros

# Método 3: Asignar valores individualmente
colores[0]="rojo"
colores[1]="verde"
colores[2]="azul"

echo "Arrays creados"

echo -e "\n=== ACCEDER A ELEMENTOS ==="

# Acceder a un elemento específico (índice comienza en 0)
echo "Primera fruta: ${frutas[0]}"
echo "Segunda fruta: ${frutas[1]}"
echo "Tercer color: ${colores[2]}"

# Último elemento
echo "Última fruta: ${frutas[-1]}"

echo -e "\n=== MOSTRAR TODO EL ARRAY ==="

# Mostrar todos los elementos
echo "Todas las frutas: ${frutas[@]}"
echo "Todas las frutas (alternativo): ${frutas[*]}"

# Diferencia entre @ y * se nota con comillas
echo "Con [@]: ${frutas[@]}"
echo "Con [*]: ${frutas[*]}"

echo -e "\n=== LONGITUD DEL ARRAY ==="

# Número de elementos
echo "Cantidad de frutas: ${#frutas[@]}"
echo "Cantidad de colores: ${#colores[@]}"

# Longitud de un elemento específico
echo "Longitud de la primera fruta: ${#frutas[0]} caracteres"

echo -e "\n=== ITERAR SOBRE ARRAY ==="

# Método 1: Iterar sobre valores
echo "Lista de frutas:"
for fruta in "${frutas[@]}"; do
    echo "  - $fruta"
done

# Método 2: Iterar sobre índices
echo -e "\nFrutas con índice:"
for i in "${!frutas[@]}"; do
    echo "  [$i] = ${frutas[$i]}"
done

echo -e "\n=== AÑADIR ELEMENTOS ==="

# Añadir al final del array
frutas+=("plátano")
frutas+=("kiwi" "melón")

echo "Frutas después de añadir: ${frutas[@]}"
echo "Total: ${#frutas[@]} frutas"

echo -e "\n=== MODIFICAR ELEMENTOS ==="

# Cambiar un elemento
frutas[1]="mango"
echo "Frutas después de modificar [1]: ${frutas[@]}"

echo -e "\n=== ELIMINAR ELEMENTOS ==="

# Eliminar un elemento específico
unset frutas[2]
echo "Después de eliminar [2]: ${frutas[@]}"
echo "Nota: El índice 2 ahora está vacío pero existe"

# Eliminar todo el array
# unset frutas

echo -e "\n=== EXTRAER PARTES DEL ARRAY ==="

# Crear array de números
numeros=(1 2 3 4 5 6 7 8 9 10)

# Slice: ${array[@]:inicio:cantidad}
echo "Array completo: ${numeros[@]}"
echo "Desde índice 2, 3 elementos: ${numeros[@]:2:3}"
echo "Desde índice 5: ${numeros[@]:5}"
echo "Últimos 3 elementos: ${numeros[@]: -3}"

echo -e "\n=== BUSCAR EN ARRAY ==="

# Buscar un elemento
buscar="uva"
encontrado=false

for fruta in "${frutas[@]}"; do
    if [ "$fruta" = "$buscar" ]; then
        encontrado=true
        break
    fi
done

if [ "$encontrado" = true ]; then
    echo "✓ '$buscar' está en el array"
else
    echo "✗ '$buscar' NO está en el array"
fi

echo -e "\n=== ORDENAR ARRAY ==="

# Crear array desordenado
nombres=("Carlos" "Ana" "Beatriz" "David")
echo "Array original: ${nombres[@]}"

# Ordenar usando sort
IFS=$'\n' nombres_ordenados=($(sort <<<"${nombres[*]}"))
unset IFS

echo "Array ordenado: ${nombres_ordenados[@]}"

echo -e "\n=== ARRAY ASOCIATIVO (HASH/DICCIONARIO) ==="

# Los arrays asociativos usan strings como índices
declare -A persona

persona["nombre"]="Juan"
persona["edad"]=30
persona["ciudad"]="Madrid"
persona["profesion"]="Programador"

echo "Nombre: ${persona["nombre"]}"
echo "Edad: ${persona["edad"]}"
echo "Ciudad: ${persona["ciudad"]}"
echo "Profesión: ${persona["profesion"]}"

echo -e "\n=== ITERAR ARRAY ASOCIATIVO ==="

# Obtener todas las claves
echo "Claves: ${!persona[@]}"

# Iterar sobre claves y valores
echo -e "\nDatos de la persona:"
for clave in "${!persona[@]}"; do
    echo "  $clave: ${persona[$clave]}"
done

echo -e "\n=== COPIAR ARRAY ==="

# Copiar un array
frutas_copia=("${frutas[@]}")
echo "Array original: ${frutas[@]}"
echo "Array copia: ${frutas_copia[@]}"

echo -e "\n=== COMBINAR ARRAYS ==="

# Unir dos arrays
array1=(1 2 3)
array2=(4 5 6)
array_combinado=("${array1[@]}" "${array2[@]}")

echo "Array 1: ${array1[@]}"
echo "Array 2: ${array2[@]}"
echo "Combinado: ${array_combinado[@]}"

echo -e "\n=== VERIFICAR SI ELEMENTO EXISTE ==="

# Verificar si un índice existe
frutas[10]="sandía"

if [ -v frutas[10] ]; then
    echo "El índice 10 existe: ${frutas[10]}"
fi

if [ -v frutas[99] ]; then
    echo "El índice 99 existe"
else
    echo "El índice 99 NO existe"
fi

echo -e "\n=== ARRAY DE MÚLTIPLES LÍNEAS ==="

# Leer comando en array (una línea por elemento)
IFS=$'\n' archivos=($(ls -1))

echo "Archivos en el directorio:"
for archivo in "${archivos[@]}"; do
    echo "  - $archivo"
done

echo -e "\n=== EJEMPLO PRÁCTICO: ESTADÍSTICAS ==="

# Calcular promedio de calificaciones
calificaciones=(85 92 78 90 88 95 82)

echo "Calificaciones: ${calificaciones[@]}"

# Calcular suma
suma=0
for nota in "${calificaciones[@]}"; do
    suma=$((suma + nota))
done

# Calcular promedio
cantidad=${#calificaciones[@]}
promedio=$((suma / cantidad))

echo "Suma: $suma"
echo "Cantidad: $cantidad"
echo "Promedio: $promedio"

# Encontrar máximo y mínimo
maximo=${calificaciones[0]}
minimo=${calificaciones[0]}

for nota in "${calificaciones[@]}"; do
    if [ $nota -gt $maximo ]; then
        maximo=$nota
    fi
    if [ $nota -lt $minimo ]; then
        minimo=$nota
    fi
done

echo "Nota máxima: $maximo"
echo "Nota mínima: $minimo"

echo -e "\n=== EJEMPLO PRÁCTICO: AGENDA ==="

# Crear una agenda simple
declare -A agenda

agenda["Juan"]="555-1234"
agenda["María"]="555-5678"
agenda["Pedro"]="555-9012"

echo "Agenda de contactos:"
for nombre in "${!agenda[@]}"; do
    echo "  $nombre: ${agenda[$nombre]}"
done

# Buscar contacto
buscar="María"
if [ -v agenda[$buscar] ]; then
    echo -e "\nTeléfono de $buscar: ${agenda[$buscar]}"
fi

echo -e "\n=== EJEMPLO PRÁCTICO: LISTA DE TAREAS ==="

# Sistema simple de tareas
tareas=()

# Añadir tareas
tareas+=("Comprar comida")
tareas+=("Hacer ejercicio")
tareas+=("Estudiar BASH")
tareas+=("Leer libro")

echo "Lista de Tareas:"
for i in "${!tareas[@]}"; do
    echo "  $((i+1)). ${tareas[$i]}"
done

# Marcar tarea como completada (eliminarla)
echo -e "\nCompletando tarea 2..."
unset tareas[1]

echo "Tareas pendientes:"
contador=1
for tarea in "${tareas[@]}"; do
    if [ -n "$tarea" ]; then
        echo "  $contador. $tarea"
        ((contador++))
    fi
done

echo -e "\n¡Arrays completados!"
