#!/bin/bash

################################################################################
# Ejemplo 08: Operaciones con Strings
# Descripción: Aprende a manipular cadenas de texto en BASH
# Nivel: Principiante
################################################################################

echo "=== LONGITUD DE STRING ==="

texto="Hola Mundo"
echo "Texto: $texto"
echo "Longitud: ${#texto} caracteres"

nombre="BASH"
echo "Nombre: $nombre (${#nombre} letras)"

echo -e "\n=== EXTRAER SUBCADENAS ==="

# Sintaxis: ${variable:posicion:longitud}
texto="Programación en BASH"

echo "Texto completo: $texto"
echo "Desde posición 0, 11 caracteres: ${texto:0:11}"
echo "Desde posición 16: ${texto:16}"
echo "Primeros 11 caracteres: ${texto::11}"
echo "Últimos 4 caracteres: ${texto: -4}"

echo -e "\n=== CONCATENACIÓN DE STRINGS ==="

# Método 1: Simple concatenación
nombre="Juan"
apellido="Pérez"
completo="$nombre $apellido"
echo "Nombre completo: $completo"

# Método 2: Usando +=
mensaje="Hola"
mensaje+=" "
mensaje+="Mundo"
echo "Mensaje: $mensaje"

# Método 3: Sin espacios
prefijo="pre"
sufijo="fijo"
palabra="${prefijo}${sufijo}"
echo "Palabra: $palabra"

echo -e "\n=== CONVERTIR MAYÚSCULAS/MINÚSCULAS ==="

texto="Hola Mundo"

# A mayúsculas
echo "Original: $texto"
echo "Mayúsculas: ${texto^^}"
echo "Minúsculas: ${texto,,}"

# Primera letra mayúscula
echo "Primera en mayúscula: ${texto^}"

# Primera letra minúscula
TEXTO="HOLA MUNDO"
echo "Primera en minúscula: ${TEXTO,}"

# Invertir case
echo "Invertir case: ${texto~~}"

echo -e "\n=== REEMPLAZAR TEXTO ==="

frase="Me gusta Python, Python es genial"

# Reemplazar primera ocurrencia
echo "Original: $frase"
echo "Reemplazar primera: ${frase/Python/BASH}"

# Reemplazar todas las ocurrencias
echo "Reemplazar todas: ${frase//Python/BASH}"

# Reemplazar al inicio
archivo="test.txt"
echo "Archivo: $archivo"
echo "Cambiar inicio: ${archivo/#test/archivo}"

# Reemplazar al final
echo "Cambiar final: ${archivo/%.txt/.log}"

echo -e "\n=== ELIMINAR PARTES DEL STRING ==="

ruta="/home/usuario/documentos/archivo.txt"

# Eliminar desde el inicio (más corto)
echo "Ruta completa: $ruta"
echo "Sin /home: ${ruta#/home}"

# Eliminar desde el inicio (más largo)
echo "Sin /home/usuario: ${ruta##*/}"

# Eliminar desde el final (más corto)
echo "Sin extensión: ${ruta%.txt}"

# Eliminar desde el final (más largo)
echo "Solo nombre: ${ruta##*/}"

echo -e "\n=== EXTRAER NOMBRE Y EXTENSIÓN ==="

archivo="/ruta/al/archivo.tar.gz"

# Extraer nombre
nombre_archivo="${archivo##*/}"
echo "Archivo: $nombre_archivo"

# Extraer extensión
extension="${archivo##*.}"
echo "Extensión: $extension"

# Nombre sin extensión
nombre_sin_ext="${nombre_archivo%.*}"
echo "Sin extensión: $nombre_sin_ext"

echo -e "\n=== BUSCAR SUBSTRING ==="

texto="El curso de BASH es interesante"

# Verificar si contiene una palabra
if [[ $texto == *"BASH"* ]]; then
    echo "✓ El texto contiene 'BASH'"
fi

if [[ $texto == *"Python"* ]]; then
    echo "✓ El texto contiene 'Python'"
else
    echo "✗ El texto NO contiene 'Python'"
fi

# Verificar inicio
if [[ $texto == "El curso"* ]]; then
    echo "✓ El texto comienza con 'El curso'"
fi

# Verificar final
if [[ $texto == *"interesante" ]]; then
    echo "✓ El texto termina con 'interesante'"
fi

echo -e "\n=== COMPARAR STRINGS ==="

str1="hola"
str2="HOLA"
str3="hola"

# Comparación exacta
if [ "$str1" = "$str3" ]; then
    echo "'$str1' es igual a '$str3'"
fi

if [ "$str1" != "$str2" ]; then
    echo "'$str1' es diferente de '$str2' (case sensitive)"
fi

# Comparación sin case sensitivity
if [[ "${str1,,}" = "${str2,,}" ]]; then
    echo "'$str1' y '$str2' son iguales (ignorando mayúsculas)"
fi

echo -e "\n=== STRINGS VACÍOS Y NULOS ==="

vacio=""
no_definido=""

# Verificar si está vacío
if [ -z "$vacio" ]; then
    echo "El string está vacío"
fi

# Verificar si NO está vacío
texto="Hola"
if [ -n "$texto" ]; then
    echo "El string '$texto' NO está vacío"
fi

# Valor por defecto si vacío
nombre=""
nombre_default=${nombre:-"Usuario"}
echo "Nombre con default: $nombre_default"

# Asignar default si vacío
edad=""
edad=${edad:=18}
echo "Edad asignada: $edad"

echo -e "\n=== DIVIDIR STRING (SPLIT) ==="

# Dividir por delimitador
datos="Juan,30,Madrid,Programador"

IFS=',' read -ra campos <<< "$datos"

echo "Datos originales: $datos"
echo "Nombre: ${campos[0]}"
echo "Edad: ${campos[1]}"
echo "Ciudad: ${campos[2]}"
echo "Profesión: ${campos[3]}"

echo -e "\n=== UNIR ARRAY EN STRING (JOIN) ==="

# Unir elementos de array
frutas=("manzana" "pera" "uva" "naranja")

# Método 1: Con espacio
echo "Con espacio: ${frutas[*]}"

# Método 2: Con delimitador personalizado
IFS=','
echo "Con comas: ${frutas[*]}"
IFS=' '  # Restaurar IFS

# Método 3: Con printf
frutas_string=$(printf "%s, " "${frutas[@]}")
frutas_string=${frutas_string%, }  # Eliminar última coma
echo "Con printf: $frutas_string"

echo -e "\n=== PADDING (RELLENAR) ==="

# Rellenar con espacios a la izquierda
numero=7
numero_formateado=$(printf "%05d" $numero)
echo "Número con padding: $numero_formateado"

# Rellenar string
texto="Hola"
printf "Con padding: '%10s'\n" "$texto"
printf "Alineado izq: '%-10s'\n" "$texto"

echo -e "\n=== REPETIR STRING ==="

# Repetir un carácter
linea=$(printf '=%.0s' {1..50})
echo "$linea"
echo "TÍTULO"
echo "$linea"

# Repetir palabra
palabra="BASH "
repetido=$(printf "$palabra%.0s" {1..5})
echo "Repetido: $repetido"

echo -e "\n=== INVERTIR STRING ==="

# Invertir string usando rev
texto="Hola Mundo"
invertido=$(echo "$texto" | rev)
echo "Original: $texto"
echo "Invertido: $invertido"

echo -e "\n=== VALIDACIONES COMUNES ==="

# Validar email
validar_email() {
    local email=$1
    if [[ $email =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        echo "✓ Email válido: $email"
    else
        echo "✗ Email inválido: $email"
    fi
}

validar_email "usuario@example.com"
validar_email "correo_invalido"

# Validar número de teléfono
validar_telefono() {
    local tel=$1
    if [[ $tel =~ ^[0-9]{3}-[0-9]{3}-[0-9]{4}$ ]]; then
        echo "✓ Teléfono válido: $tel"
    else
        echo "✗ Teléfono inválido: $tel"
    fi
}

validar_telefono "555-123-4567"
validar_telefono "12345"

# Validar URL
validar_url() {
    local url=$1
    if [[ $url =~ ^https?:// ]]; then
        echo "✓ URL válida: $url"
    else
        echo "✗ URL inválida: $url"
    fi
}

validar_url "https://example.com"
validar_url "ftp://servidor.com"

echo -e "\n=== EJEMPLO PRÁCTICO: FORMATEAR TEXTO ==="

# Formatear nombre (Primera letra mayúscula)
formatear_nombre() {
    local nombre=$1
    nombre=${nombre,,}  # Todo minúsculas
    nombre=${nombre^}   # Primera mayúscula
    echo "$nombre"
}

echo "juan pérez -> $(formatear_nombre 'juan pérez')"
echo "MARIA GARCIA -> $(formatear_nombre 'MARIA GARCIA')"

echo -e "\n=== EJEMPLO PRÁCTICO: LIMPIAR STRING ==="

# Eliminar espacios al inicio y final
limpiar() {
    local texto="$1"
    # Eliminar espacios al inicio
    texto="${texto#"${texto%%[![:space:]]*}"}"
    # Eliminar espacios al final
    texto="${texto%"${texto##*[![:space:]]}"}"
    echo "$texto"
}

texto_sucio="   Hola Mundo   "
echo "Original: '$texto_sucio'"
echo "Limpio: '$(limpiar "$texto_sucio")'"

echo -e "\n=== EJEMPLO PRÁCTICO: GENERAR SLUG ==="

# Convertir texto a slug (URL friendly)
generar_slug() {
    local texto=$1
    texto=${texto,,}  # Minúsculas
    texto=${texto// /-}  # Espacios a guiones
    texto=${texto//[^a-z0-9-]/}  # Solo letras, números y guiones
    echo "$texto"
}

titulo="Curso de BASH 2024!"
slug=$(generar_slug "$titulo")
echo "Título: $titulo"
echo "Slug: $slug"

echo -e "\n¡Operaciones con strings completadas!"
