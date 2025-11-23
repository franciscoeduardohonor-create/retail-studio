#!/bin/bash

################################################################################
# Ejemplo 11: Expresiones Regulares (Regex)
# Descripción: Aprende a usar expresiones regulares en BASH
# Nivel: Intermedio
################################################################################

echo "=== REGEX BÁSICO CON [[ ]] ==="

texto="Hola Mundo 2024"

# Coincidencia simple
if [[ $texto =~ Hola ]]; then
    echo "✓ Contiene 'Hola'"
fi

# Inicio de línea ^
if [[ $texto =~ ^Hola ]]; then
    echo "✓ Comienza con 'Hola'"
fi

# Fin de línea $
if [[ $texto =~ 2024$ ]]; then
    echo "✓ Termina con '2024'"
fi

echo -e "\n=== CLASES DE CARACTERES ==="

# [abc] - uno de estos caracteres
palabra="gato"
if [[ $palabra =~ [aeiou] ]]; then
    echo "✓ '$palabra' contiene una vocal"
fi

# [a-z] - rango de caracteres
if [[ $palabra =~ ^[a-z]+$ ]]; then
    echo "✓ '$palabra' solo contiene minúsculas"
fi

# [^abc] - NO estos caracteres
texto2="12345"
if [[ $texto2 =~ ^[^a-zA-Z]+$ ]]; then
    echo "✓ '$texto2' no contiene letras"
fi

echo -e "\n=== CUANTIFICADORES ==="

# * - cero o más
texto="Hola"
if [[ $texto =~ ^H.*a$ ]]; then
    echo "✓ Comienza con H y termina con a"
fi

# + - uno o más
numero="12345"
if [[ $numero =~ ^[0-9]+$ ]]; then
    echo "✓ '$numero' es un número válido"
fi

# ? - cero o uno
color="color"  # o "colour"
if [[ $color =~ colou?r ]]; then
    echo "✓ '$color' coincide con el patrón"
fi

# {n} - exactamente n veces
telefono="555-1234"
if [[ $telefono =~ ^[0-9]{3}-[0-9]{4}$ ]]; then
    echo "✓ Formato de teléfono válido"
fi

# {n,m} - entre n y m veces
codigo="ABC123"
if [[ $codigo =~ ^[A-Z]{2,4}[0-9]{2,4}$ ]]; then
    echo "✓ Código válido"
fi

echo -e "\n=== GRUPOS Y ALTERNATIVAS ==="

# | - alternativa (OR)
fruta="manzana"
if [[ $fruta =~ ^(manzana|pera|uva)$ ]]; then
    echo "✓ '$fruta' es una fruta válida"
fi

# () - grupos
fecha="2024-01-15"
if [[ $fecha =~ ^([0-9]{4})-([0-9]{2})-([0-9]{2})$ ]]; then
    echo "✓ Fecha válida: $fecha"
    echo "  Año: ${BASH_REMATCH[1]}"
    echo "  Mes: ${BASH_REMATCH[2]}"
    echo "  Día: ${BASH_REMATCH[3]}"
fi

echo -e "\n=== CARACTERES ESPECIALES ==="

# \d - dígito (usar [0-9] en BASH)
# \w - palabra (usar [a-zA-Z0-9_])
# \s - espacio (usar [[:space:]])

# . - cualquier carácter
texto="a1b2c3"
if [[ $texto =~ ^.{6}$ ]]; then
    echo "✓ '$texto' tiene exactamente 6 caracteres"
fi

# \ - escapar caracteres especiales
url="https://example.com"
if [[ $url =~ ^https?:// ]]; then
    echo "✓ URL válida"
fi

echo -e "\n=== CLASES POSIX ==="

# [:alpha:] - letras
nombre="Juan"
if [[ $nombre =~ ^[[:alpha:]]+$ ]]; then
    echo "✓ '$nombre' solo contiene letras"
fi

# [:digit:] - dígitos
edad="25"
if [[ $edad =~ ^[[:digit:]]+$ ]]; then
    echo "✓ '$edad' solo contiene dígitos"
fi

# [:alnum:] - alfanumérico
usuario="user123"
if [[ $usuario =~ ^[[:alnum:]]+$ ]]; then
    echo "✓ '$usuario' es alfanumérico"
fi

# [:space:] - espacios en blanco
texto="Hola Mundo"
if [[ $texto =~ [[:space:]] ]]; then
    echo "✓ Contiene espacios"
fi

echo -e "\n=== GREP CON REGEX ==="

# Crear archivo de prueba
cat > datos.txt << EOF
Juan Pérez - juan@example.com - 555-1234
María García - maria@test.es - 555-5678
Pedro López - pedro.lopez@mail.com - 555-9012
Ana Martínez - ana_martinez@company.co - 555-3456
EOF

echo "Archivo de datos creado"

# Buscar emails
echo -e "\nEmails encontrados:"
grep -oE '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}' datos.txt

# Buscar teléfonos
echo -e "\nTeléfonos encontrados:"
grep -oE '[0-9]{3}-[0-9]{4}' datos.txt

# Buscar líneas que comienzan con vocal
echo -e "\nLíneas que comienzan con vocal:"
grep -E '^[AEIOU]' datos.txt

echo -e "\n=== SED CON REGEX ==="

# Reemplazar con sed
echo -e "\nOcultar parte de emails:"
sed -E 's/([a-zA-Z0-9._%+-]+)@([a-zA-Z0-9.-]+\.[a-zA-Z]{2,})/\1@****/g' datos.txt

# Extraer solo números
echo -e "\nSolo números de teléfono:"
sed -E 's/.*([0-9]{3}-[0-9]{4}).*/\1/' datos.txt

echo -e "\n=== AWK CON REGEX ==="

# Usar awk con regex
echo -e "\nFiltrar por dominio .com:"
awk '/@.*\.com/ {print $3}' datos.txt

# Capturar grupos
echo -e "\nNombres de usuarios de email:"
awk 'match($0, /([a-z._]+)@/, arr) {print arr[1]}' datos.txt

echo -e "\n=== VALIDACIONES COMUNES ==="

# Función validar email
validar_email() {
    local email=$1
    if [[ $email =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        echo "✓ Email válido: $email"
        return 0
    else
        echo "✗ Email inválido: $email"
        return 1
    fi
}

validar_email "usuario@example.com"
validar_email "correo_invalido"
validar_email "test.user+tag@sub.domain.co.uk"

# Función validar URL
validar_url() {
    local url=$1
    if [[ $url =~ ^https?://[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}(/.*)?$ ]]; then
        echo "✓ URL válida: $url"
        return 0
    else
        echo "✗ URL inválida: $url"
        return 1
    fi
}

echo ""
validar_url "https://www.example.com"
validar_url "http://test.co/path"
validar_url "ftp://invalid.com"

# Función validar teléfono
validar_telefono() {
    local tel=$1
    # Formatos: 555-1234 o (555) 123-4567 o 555.123.4567
    if [[ $tel =~ ^(\([0-9]{3}\)[[:space:]]?|[0-9]{3}[-.]?)[0-9]{3}[-.]?[0-9]{4}$ ]]; then
        echo "✓ Teléfono válido: $tel"
        return 0
    else
        echo "✗ Teléfono inválido: $tel"
        return 1
    fi
}

echo ""
validar_telefono "555-1234"
validar_telefono "(555) 123-4567"
validar_telefono "555.123.4567"
validar_telefono "12345"

# Función validar IP
validar_ip() {
    local ip=$1
    if [[ $ip =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
        # Verificar rangos
        local valido=true
        IFS='.' read -ra octetos <<< "$ip"
        for octeto in "${octetos[@]}"; do
            if [ $octeto -gt 255 ]; then
                valido=false
                break
            fi
        done

        if [ "$valido" = true ]; then
            echo "✓ IP válida: $ip"
            return 0
        fi
    fi
    echo "✗ IP inválida: $ip"
    return 1
}

echo ""
validar_ip "192.168.1.1"
validar_ip "10.0.0.255"
validar_ip "256.1.1.1"

echo -e "\n=== EXTRAER INFORMACIÓN ==="

# Extraer información de texto
texto="El precio es $125.50 y el descuento es 15%"

# Extraer números
if [[ $texto =~ \$([0-9]+\.[0-9]+) ]]; then
    precio="${BASH_REMATCH[1]}"
    echo "Precio extraído: \$$precio"
fi

if [[ $texto =~ ([0-9]+)% ]]; then
    descuento="${BASH_REMATCH[1]}"
    echo "Descuento extraído: $descuento%"
fi

echo -e "\n=== VALIDAR FORMATOS ==="

# Validar fecha (YYYY-MM-DD)
validar_fecha() {
    local fecha=$1
    if [[ $fecha =~ ^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$ ]]; then
        echo "✓ Fecha válida: $fecha"
        return 0
    else
        echo "✗ Fecha inválida: $fecha"
        return 1
    fi
}

echo ""
validar_fecha "2024-01-15"
validar_fecha "2024-13-01"
validar_fecha "2024-01-32"

# Validar hora (HH:MM:SS)
validar_hora() {
    local hora=$1
    if [[ $hora =~ ^([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9]$ ]]; then
        echo "✓ Hora válida: $hora"
        return 0
    else
        echo "✗ Hora inválida: $hora"
        return 1
    fi
}

echo ""
validar_hora "14:30:45"
validar_hora "09:05:00"
validar_hora "25:00:00"

echo -e "\n=== EJEMPLO PRÁCTICO: PARSEAR LOG ==="

# Crear log de ejemplo
cat > server.log << EOF
[2024-01-15 10:30:15] INFO User logged in: john@example.com
[2024-01-15 10:31:22] ERROR Failed connection from 192.168.1.100
[2024-01-15 10:32:45] WARNING High memory usage: 85%
[2024-01-15 10:33:10] INFO User logged out: mary@test.com
[2024-01-15 10:34:55] ERROR Database timeout
EOF

echo "Procesando server.log..."

# Extraer solo errores
echo -e "\nErrores:"
grep -E '^\[[^]]+\] ERROR' server.log

# Extraer emails
echo -e "\nEmails en el log:"
grep -oE '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}' server.log | sort -u

# Extraer IPs
echo -e "\nIPs en el log:"
grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}' server.log

# Extraer y formatear timestamps
echo -e "\nTimestamps:"
grep -oE '\[[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}\]' server.log

echo -e "\n=== EJEMPLO PRÁCTICO: LIMPIAR DATOS ==="

# Datos con formato inconsistente
cat > datos_sucios.txt << EOF
  john@EXAMPLE.com
MARY@test.COM
  pedro@Mail.ES
  ANA@Company.CO.UK
EOF

echo "Limpiando y normalizando datos..."

while IFS= read -r linea; do
    # Limpiar espacios
    linea=$(echo "$linea" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
    # Convertir a minúsculas
    linea=$(echo "$linea" | tr '[:upper:]' '[:lower:]')
    # Validar y mostrar
    if [[ $linea =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        echo "  ✓ $linea"
    fi
done < datos_sucios.txt

echo -e "\n=== LIMPIEZA ==="

rm -f datos.txt server.log datos_sucios.txt

echo "✓ Archivos de prueba eliminados"
echo -e "\n¡Expresiones regulares completadas!"
