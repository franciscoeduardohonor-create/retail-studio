/*
 * ============================================================================
 * PROGRAMA: Manejo de Archivos
 * DESCRIPCIÓN: Leer y escribir archivos de texto
 * NIVEL: Intermedio-Avanzado
 * ============================================================================
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {

    printf("========== MANEJO DE ARCHIVOS ==========\n\n");

    // ========== ESCRIBIR EN ARCHIVO ==========

    printf("--- Escribir en archivo ---\n");

    FILE *archivo;  // Puntero a archivo

    // fopen() abre archivo
    // "w" = write (sobreescribe si existe)
    archivo = fopen("ejemplo.txt", "w");

    if (archivo == NULL) {
        printf("Error al abrir archivo\n");
        return 1;
    }

    // fprintf() escribe en archivo (como printf pero a archivo)
    fprintf(archivo, "Hola, este es un archivo de texto\n");
    fprintf(archivo, "Esta es la segunda línea\n");
    fprintf(archivo, "Número: %d\n", 42);
    fprintf(archivo, "Decimal: %.2f\n", 3.14159);

    // IMPORTANTE: Cerrar archivo
    fclose(archivo);

    printf("Archivo 'ejemplo.txt' creado exitosamente\n\n");

    // ========== LEER DE ARCHIVO ==========

    printf("--- Leer de archivo ---\n");

    // "r" = read (solo lectura)
    archivo = fopen("ejemplo.txt", "r");

    if (archivo == NULL) {
        printf("Error al abrir archivo\n");
        return 1;
    }

    char linea[100];

    // fgets() lee línea por línea
    printf("Contenido del archivo:\n");
    while (fgets(linea, 100, archivo) != NULL) {
        printf("%s", linea);
    }

    fclose(archivo);
    printf("\n");

    // ========== AÑADIR AL FINAL (APPEND) ==========

    printf("--- Añadir al archivo ---\n");

    // "a" = append (añade al final sin borrar)
    archivo = fopen("ejemplo.txt", "a");

    if (archivo == NULL) {
        printf("Error al abrir archivo\n");
        return 1;
    }

    fprintf(archivo, "Esta línea se añadió después\n");
    fprintf(archivo, "Y esta también\n");

    fclose(archivo);

    printf("Líneas añadidas al archivo\n\n");

    // ========== LEER CON fscanf ==========

    printf("--- Leer con fscanf ---\n");

    // Crear archivo con datos estructurados
    archivo = fopen("datos.txt", "w");
    fprintf(archivo, "Juan 25 1.75\n");
    fprintf(archivo, "María 30 1.68\n");
    fprintf(archivo, "Pedro 22 1.80\n");
    fclose(archivo);

    // Leer datos estructurados
    archivo = fopen("datos.txt", "r");

    char nombre[50];
    int edad;
    float altura;

    printf("Personas en el archivo:\n");
    while (fscanf(archivo, "%s %d %f", nombre, &edad, &altura) == 3) {
        printf("Nombre: %s, Edad: %d, Altura: %.2f\n", nombre, edad, altura);
    }

    fclose(archivo);
    printf("\n");

    // ========== CONTAR LÍNEAS DE UN ARCHIVO ==========

    printf("--- Contar líneas ---\n");

    archivo = fopen("ejemplo.txt", "r");

    int contador = 0;
    while (fgets(linea, 100, archivo) != NULL) {
        contador++;
    }

    printf("El archivo tiene %d líneas\n", contador);

    fclose(archivo);
    printf("\n");

    // ========== VERIFICAR SI ARCHIVO EXISTE ==========

    printf("--- Verificar existencia ---\n");

    archivo = fopen("noexiste.txt", "r");

    if (archivo == NULL) {
        printf("El archivo 'noexiste.txt' no existe\n");
    } else {
        printf("El archivo existe\n");
        fclose(archivo);
    }

    printf("\n");

    // ========== COPIAR ARCHIVO ==========

    printf("--- Copiar archivo ---\n");

    FILE *origen = fopen("ejemplo.txt", "r");
    FILE *destino = fopen("copia.txt", "w");

    if (origen == NULL || destino == NULL) {
        printf("Error al abrir archivos\n");
        return 1;
    }

    char c;
    while ((c = fgetc(origen)) != EOF) {  // EOF = End Of File
        fputc(c, destino);
    }

    fclose(origen);
    fclose(destino);

    printf("Archivo copiado a 'copia.txt'\n\n");

    // ========== EJEMPLO PRÁCTICO: AGENDA ==========

    printf("--- Agenda de contactos ---\n");

    typedef struct {
        char nombre[50];
        char telefono[15];
        char email[50];
    } Contacto;

    // Guardar contactos
    FILE *agenda = fopen("agenda.txt", "w");

    Contacto contactos[3] = {
        {"Juan Pérez", "555-1234", "juan@email.com"},
        {"María García", "555-5678", "maria@email.com"},
        {"Pedro López", "555-9012", "pedro@email.com"}
    };

    for (int i = 0; i < 3; i++) {
        fprintf(agenda, "%s|%s|%s\n",
                contactos[i].nombre,
                contactos[i].telefono,
                contactos[i].email);
    }

    fclose(agenda);

    // Leer contactos
    agenda = fopen("agenda.txt", "r");

    printf("\nContactos guardados:\n");
    Contacto temp;

    while (fscanf(agenda, "%[^|]|%[^|]|%[^\n]\n",
                  temp.nombre, temp.telefono, temp.email) == 3) {
        printf("Nombre: %s\n", temp.nombre);
        printf("Teléfono: %s\n", temp.telefono);
        printf("Email: %s\n\n", temp.email);
    }

    fclose(agenda);

    return 0;
}

/*
 * CONCEPTOS CLAVE:
 *
 * MODOS DE APERTURA:
 *   "r"  - Lectura (archivo debe existir)
 *   "w"  - Escritura (crea nuevo o sobreescribe)
 *   "a"  - Append (añade al final)
 *   "r+" - Lectura/escritura (archivo debe existir)
 *   "w+" - Lectura/escritura (crea nuevo)
 *   "a+" - Lectura/append
 *
 * FUNCIONES PRINCIPALES:
 *   fopen()   - Abrir archivo
 *   fclose()  - Cerrar archivo
 *   fprintf() - Escribir formato
 *   fscanf()  - Leer formato
 *   fgets()   - Leer línea
 *   fputs()   - Escribir línea
 *   fgetc()   - Leer carácter
 *   fputc()   - Escribir carácter
 *
 * BUENAS PRÁCTICAS:
 * 1. SIEMPRE verificar si fopen() retorna NULL
 * 2. SIEMPRE cerrar archivos con fclose()
 * 3. Usar modo apropiado ("r", "w", "a")
 * 4. Verificar errores en lectura/escritura
 *
 * ERRORES COMUNES:
 * 1. No verificar si archivo se abrió
 * 2. Olvidar cerrar archivo
 * 3. Usar modo incorrecto
 * 4. No verificar EOF
 *
 * EJERCICIOS:
 * 1. Programa que cuente palabras en un archivo
 * 2. Editor de texto simple
 * 3. Sistema de log que guarde eventos
 * 4. Buscar y reemplazar texto en archivo
 * 5. Unir múltiples archivos en uno
 */
