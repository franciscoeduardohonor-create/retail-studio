#!/bin/bash

################################################################################
# Ejemplo 09: Trabajar con Archivos y Directorios
# Descripción: Aprende a manipular archivos y directorios en BASH
# Nivel: Principiante
################################################################################

echo "=== VERIFICAR SI EXISTE ==="

# Crear archivo de prueba
touch archivo_test.txt

# Verificar si un archivo existe
if [ -e "archivo_test.txt" ]; then
    echo "✓ archivo_test.txt existe"
fi

# Verificar si es un archivo regular
if [ -f "archivo_test.txt" ]; then
    echo "✓ Es un archivo regular"
fi

# Verificar si es un directorio
if [ -d "/home" ]; then
    echo "✓ /home es un directorio"
fi

# Verificar si NO existe
if [ ! -e "no_existe.txt" ]; then
    echo "✓ no_existe.txt NO existe"
fi

echo -e "\n=== PERMISOS DE ARCHIVO ==="

# Verificar permisos
if [ -r "archivo_test.txt" ]; then
    echo "✓ Tienes permiso de lectura"
fi

if [ -w "archivo_test.txt" ]; then
    echo "✓ Tienes permiso de escritura"
fi

if [ -x "archivo_test.txt" ]; then
    echo "✓ Tienes permiso de ejecución"
else
    echo "✗ NO tienes permiso de ejecución"
fi

echo -e "\n=== INFORMACIÓN DEL ARCHIVO ==="

# Verificar si está vacío
if [ -s "archivo_test.txt" ]; then
    echo "✓ El archivo NO está vacío"
else
    echo "✓ El archivo está vacío"
fi

# Escribir contenido
echo "Hola BASH" > archivo_test.txt

if [ -s "archivo_test.txt" ]; then
    echo "✓ Ahora el archivo tiene contenido"
fi

echo -e "\n=== CREAR ARCHIVOS ==="

# Crear archivo vacío
touch nuevo_archivo.txt
echo "✓ Archivo creado: nuevo_archivo.txt"

# Crear archivo con contenido
echo "Este es el contenido" > archivo_con_contenido.txt
echo "✓ Archivo creado: archivo_con_contenido.txt"

# Crear múltiples archivos
touch file1.txt file2.txt file3.txt
echo "✓ Creados: file1.txt, file2.txt, file3.txt"

echo -e "\n=== ESCRIBIR EN ARCHIVOS ==="

# Sobrescribir (>)
echo "Primera línea" > datos.txt
echo "✓ Archivo datos.txt creado"

# Añadir al final (>>)
echo "Segunda línea" >> datos.txt
echo "Tercera línea" >> datos.txt
echo "✓ Líneas añadidas"

# Mostrar contenido
echo "Contenido de datos.txt:"
cat datos.txt

echo -e "\n=== LEER ARCHIVOS ==="

# Leer todo el archivo
echo "Leer archivo completo:"
cat datos.txt

# Leer con número de línea
echo -e "\nCon números de línea:"
cat -n datos.txt

# Leer primeras líneas
echo -e "\nPrimeras 2 líneas:"
head -n 2 datos.txt

# Leer últimas líneas
echo -e "\nÚltimas 2 líneas:"
tail -n 2 datos.txt

echo -e "\n=== LEER LÍNEA POR LÍNEA ==="

# Crear archivo con varias líneas
cat > lista.txt << EOF
Manzana
Pera
Uva
Naranja
EOF

echo "Leyendo lista.txt línea por línea:"
while IFS= read -r linea; do
    echo "  - $linea"
done < lista.txt

echo -e "\n=== COPIAR ARCHIVOS ==="

# Copiar archivo
cp datos.txt datos_backup.txt
echo "✓ Archivo copiado: datos_backup.txt"

# Copiar con confirmación
cp -i datos.txt datos_backup.txt 2>/dev/null
echo "✓ Copia con confirmación"

# Copiar directorio recursivamente
mkdir -p dir_original
echo "contenido" > dir_original/archivo.txt
cp -r dir_original dir_copia
echo "✓ Directorio copiado recursivamente"

echo -e "\n=== MOVER/RENOMBRAR ARCHIVOS ==="

# Crear archivo para mover
echo "test" > archivo_mover.txt

# Renombrar archivo
mv archivo_mover.txt archivo_renombrado.txt
echo "✓ Archivo renombrado"

# Mover a directorio
mkdir -p carpeta_destino
echo "contenido" > mover.txt
mv mover.txt carpeta_destino/
echo "✓ Archivo movido a carpeta_destino/"

echo -e "\n=== ELIMINAR ARCHIVOS ==="

# Crear archivos temporales
touch temp1.txt temp2.txt

# Eliminar archivo
rm temp1.txt
echo "✓ temp1.txt eliminado"

# Eliminar con confirmación (interactivo)
# rm -i temp2.txt

# Eliminar forzosamente
rm -f temp2.txt
echo "✓ temp2.txt eliminado (forzoso)"

echo -e "\n=== CREAR DIRECTORIOS ==="

# Crear directorio simple
mkdir mi_directorio
echo "✓ Directorio creado: mi_directorio"

# Crear directorios anidados
mkdir -p ruta/a/directorios/anidados
echo "✓ Directorios anidados creados"

# Crear múltiples directorios
mkdir dir1 dir2 dir3
echo "✓ Múltiples directorios creados"

echo -e "\n=== LISTAR CONTENIDO ==="

# Listar archivos
echo "Archivos en directorio actual:"
ls

# Listar con detalles
echo -e "\nListado detallado:"
ls -l *.txt 2>/dev/null | head -3

# Listar incluyendo ocultos
echo -e "\nListado con ocultos:"
ls -la | head -5

# Listar solo directorios
echo -e "\nSolo directorios:"
ls -d */ 2>/dev/null | head -3

echo -e "\n=== INFORMACIÓN DE ARCHIVOS ==="

# Tamaño de archivo
echo "Tamaño de datos.txt:"
ls -lh datos.txt 2>/dev/null | awk '{print $5}'

# Fecha de modificación
echo "Última modificación:"
ls -l datos.txt 2>/dev/null | awk '{print $6, $7, $8}'

# Tipo de archivo
echo "Tipo de archivo:"
file datos.txt

echo -e "\n=== BUSCAR ARCHIVOS ==="

# Buscar por nombre
echo "Buscar archivos .txt:"
find . -name "*.txt" -type f 2>/dev/null | head -5

# Buscar directorios
echo -e "\nBuscar directorios:"
find . -type d -name "dir*" 2>/dev/null | head -3

# Buscar por tamaño
echo -e "\nBuscar archivos mayores a 0 bytes:"
find . -type f -size +0 -name "*.txt" 2>/dev/null | head -3

echo -e "\n=== ELIMINAR DIRECTORIOS ==="

# Eliminar directorio vacío
mkdir directorio_vacio
rmdir directorio_vacio
echo "✓ Directorio vacío eliminado"

# Eliminar directorio con contenido
rm -rf dir1
echo "✓ Directorio con contenido eliminado"

echo -e "\n=== CAMBIAR PERMISOS ==="

# Crear archivo de prueba
echo "test" > permisos_test.txt

# Dar permisos de ejecución
chmod +x permisos_test.txt
echo "✓ Permisos de ejecución añadidos"

# Quitar permisos de escritura
chmod -w permisos_test.txt
echo "✓ Permisos de escritura quitados"

# Restaurar permisos
chmod +w permisos_test.txt

# Permisos numéricos (rwxr-xr-x = 755)
chmod 644 permisos_test.txt
echo "✓ Permisos establecidos a 644"

echo -e "\n=== COMPARAR ARCHIVOS ==="

# Crear dos archivos
echo "Línea 1" > file_a.txt
echo "Línea 2" >> file_a.txt

echo "Línea 1" > file_b.txt
echo "Línea 2 modificada" >> file_b.txt

# Comparar archivos
echo "Comparando archivos:"
if diff -q file_a.txt file_b.txt > /dev/null 2>&1; then
    echo "✓ Los archivos son idénticos"
else
    echo "✗ Los archivos son diferentes"
    echo "Diferencias:"
    diff file_a.txt file_b.txt
fi

echo -e "\n=== ENLACES SIMBÓLICOS ==="

# Crear archivo original
echo "contenido original" > original.txt

# Crear enlace simbólico
ln -s original.txt enlace.txt
echo "✓ Enlace simbólico creado"

# Verificar si es un enlace
if [ -L "enlace.txt" ]; then
    echo "✓ enlace.txt es un enlace simbólico"
fi

# Ver a dónde apunta
echo "Enlace apunta a: $(readlink enlace.txt)"

echo -e "\n=== EJEMPLO PRÁCTICO: BACKUP ==="

# Función para hacer backup
hacer_backup() {
    local archivo=$1
    local fecha=$(date +%Y%m%d_%H%M%S)
    local backup="${archivo}.backup_${fecha}"

    if [ -f "$archivo" ]; then
        cp "$archivo" "$backup"
        echo "✓ Backup creado: $backup"
    else
        echo "✗ Error: $archivo no existe"
        return 1
    fi
}

hacer_backup "datos.txt"

echo -e "\n=== EJEMPLO PRÁCTICO: ORGANIZAR ARCHIVOS ==="

# Crear archivos de diferentes tipos
touch documento.pdf imagen.jpg video.mp4 audio.mp3

# Organizar por extensión
organizar_archivos() {
    # Crear directorios
    mkdir -p documentos imagenes videos audios

    # Mover archivos
    mv *.pdf documentos/ 2>/dev/null && echo "✓ PDFs movidos"
    mv *.jpg *.png documentos/ 2>/dev/null && echo "✓ Imágenes movidas"
    mv *.mp4 videos/ 2>/dev/null && echo "✓ Videos movidos"
    mv *.mp3 audios/ 2>/dev/null && echo "✓ Audios movidos"
}

# organizar_archivos

echo -e "\n=== EJEMPLO PRÁCTICO: LIMPIAR TEMPORALES ==="

# Función para eliminar archivos temporales
limpiar_temporales() {
    echo "Eliminando archivos temporales..."

    # Contar archivos antes
    antes=$(find . -name "*.tmp" -type f 2>/dev/null | wc -l)

    # Eliminar
    find . -name "*.tmp" -type f -delete 2>/dev/null

    # Contar después
    despues=$(find . -name "*.tmp" -type f 2>/dev/null | wc -l)

    echo "✓ Eliminados $((antes - despues)) archivos temporales"
}

# Crear archivos temporales
touch temp1.tmp temp2.tmp temp3.tmp
limpiar_temporales

echo -e "\n=== LIMPIEZA FINAL ==="

# Limpiar todos los archivos de prueba
rm -f *.txt enlace.txt original.txt
rm -rf mi_directorio dir2 dir3 dir_original dir_copia
rm -rf carpeta_destino ruta documentos imagenes videos audios
rm -f documento.pdf imagen.jpg video.mp4 audio.mp3

echo "✓ Archivos de prueba eliminados"
echo -e "\n¡Trabajo con archivos y directorios completado!"
