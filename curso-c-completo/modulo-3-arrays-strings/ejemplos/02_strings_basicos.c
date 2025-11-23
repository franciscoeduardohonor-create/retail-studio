/*
 * ============================================================================
 * PROGRAMA: Strings (Cadenas de Texto)
 * DESCRIPCIÓN: Trabajar con cadenas de caracteres
 * NIVEL: Intermedio
 * ============================================================================
 */

#include <stdio.h>
#include <string.h>  // Funciones de manejo de strings

int main() {

    // ========== DECLARACIÓN DE STRINGS ==========

    printf("========== STRINGS EN C ==========\n\n");

    /*
     * Un string es un array de char que termina con '\0'
     * '\0' es el carácter nulo (null terminator)
     */

    // Formas de declarar strings
    char nombre1[] = "Carlos";  // Tamaño automático (7: 6 letras + '\0')
    char nombre2[50] = "María";  // Tamaño fijo de 50
    char nombre3[] = {'J', 'u', 'a', 'n', '\0'};  // Manual (debe incluir '\0')

    printf("Nombre 1: %s\n", nombre1);
    printf("Nombre 2: %s\n", nombre2);
    printf("Nombre 3: %s\n\n", nombre3);

    // ========== LONGITUD DE UN STRING ==========

    printf("--- Longitud de strings ---\n");

    // strlen() retorna la longitud SIN contar '\0'
    printf("Longitud de '%s': %lu\n", nombre1, strlen(nombre1));
    printf("Tamaño del array: %lu\n\n", sizeof(nombre1));

    // ========== COPIAR STRINGS ==========

    printf("--- Copiar strings ---\n");

    char original[50] = "Hola Mundo";
    char copia[50];

    // INCORRECTO: copia = original;  // ¡NO funciona con strings!

    // CORRECTO: usar strcpy()
    strcpy(copia, original);

    printf("Original: %s\n", original);
    printf("Copia: %s\n\n", copia);

    // strncpy() - copia n caracteres (más seguro)
    char parcial[50];
    strncpy(parcial, original, 4);
    parcial[4] = '\0';  // Agregar terminador manualmente
    printf("Copia parcial (4 chars): %s\n\n", parcial);

    // ========== CONCATENAR STRINGS ==========

    printf("--- Concatenar strings ---\n");

    char str1[50] = "Hola ";
    char str2[] = "Mundo";

    strcat(str1, str2);  // Agrega str2 al final de str1
    printf("Concatenación: %s\n\n", str1);

    // ========== COMPARAR STRINGS ==========

    printf("--- Comparar strings ---\n");

    char pass1[] = "secreto";
    char pass2[] = "secreto";
    char pass3[] = "publico";

    // INCORRECTO: if (pass1 == pass2)  // Compara direcciones, no contenido

    // CORRECTO: usar strcmp()
    // strcmp() retorna:
    //   0 si son iguales
    //   <0 si str1 < str2
    //   >0 si str1 > str2

    if (strcmp(pass1, pass2) == 0) {
        printf("pass1 y pass2 son iguales\n");
    }

    if (strcmp(pass1, pass3) != 0) {
        printf("pass1 y pass3 son diferentes\n\n");
    }

    // ========== LEER STRINGS ==========

    printf("--- Entrada de strings ---\n");

    char nombre[50];

    // scanf() lee hasta el primer espacio
    printf("Ingresa tu nombre (sin espacios): ");
    scanf("%s", nombre);  // NO necesita &
    printf("Hola, %s!\n\n", nombre);

    // Limpiar buffer
    while (getchar() != '\n');

    // fgets() lee línea completa (incluyendo espacios)
    char nombre_completo[100];
    printf("Ingresa tu nombre completo: ");
    fgets(nombre_completo, 100, stdin);

    // fgets() incluye '\n', podemos quitarlo:
    nombre_completo[strcspn(nombre_completo, "\n")] = '\0';

    printf("Nombre completo: %s\n\n", nombre_completo);

    // ========== BUSCAR EN STRINGS ==========

    printf("--- Buscar en strings ---\n");

    char texto[] = "Programación en C es divertido";

    // strchr() - busca un carácter
    char *pos = strchr(texto, 'C');
    if (pos != NULL) {
        printf("'C' encontrado en posición: %ld\n", pos - texto);
    }

    // strstr() - busca un substring
    char *encontrado = strstr(texto, "divertido");
    if (encontrado != NULL) {
        printf("'divertido' encontrado: %s\n\n", encontrado);
    }

    // ========== CONVERTIR MAYÚSCULAS/MINÚSCULAS ==========

    printf("--- Convertir case ---\n");

    char frase[] = "Hola Mundo";

    printf("Original: %s\n", frase);

    // A mayúsculas
    for (int i = 0; frase[i] != '\0'; i++) {
        if (frase[i] >= 'a' && frase[i] <= 'z') {
            frase[i] = frase[i] - 32;  // 'a' - 'A' = 32
        }
    }
    printf("Mayúsculas: %s\n", frase);

    // A minúsculas
    for (int i = 0; frase[i] != '\0'; i++) {
        if (frase[i] >= 'A' && frase[i] <= 'Z') {
            frase[i] = frase[i] + 32;
        }
    }
    printf("Minúsculas: %s\n\n", frase);

    // ========== CONTAR CARACTERES ==========

    printf("--- Contar caracteres ---\n");

    char oracion[] = "la casa de la esquina";
    char buscar_char = 'a';
    int contador = 0;

    for (int i = 0; oracion[i] != '\0'; i++) {
        if (oracion[i] == buscar_char) {
            contador++;
        }
    }

    printf("'%c' aparece %d veces en \"%s\"\n\n", buscar_char, contador, oracion);

    // ========== INVERTIR STRING ==========

    printf("--- Invertir string ---\n");

    char palabra[] = "reconocer";
    int len = strlen(palabra);

    printf("Original: %s\n", palabra);

    for (int i = 0; i < len / 2; i++) {
        char temp = palabra[i];
        palabra[i] = palabra[len - 1 - i];
        palabra[len - 1 - i] = temp;
    }

    printf("Invertido: %s\n", palabra);

    return 0;
}

/*
 * FUNCIONES IMPORTANTES DE string.h:
 *
 * strlen(str)           - Longitud del string
 * strcpy(dest, src)     - Copia src a dest
 * strncpy(dest, src, n) - Copia n caracteres
 * strcat(dest, src)     - Concatena src al final de dest
 * strcmp(str1, str2)    - Compara dos strings
 * strchr(str, c)        - Busca carácter c
 * strstr(str, substr)   - Busca substring
 *
 * IMPORTANTE:
 * - Strings DEBEN terminar con '\0'
 * - No usar = para copiar strings (usar strcpy)
 * - No usar == para comparar (usar strcmp)
 * - scanf() no es seguro para strings con espacios
 * - Usar fgets() para leer líneas completas
 *
 * EJERCICIOS:
 * 1. Programa que determine si un string es palíndromo
 * 2. Contador de palabras en una frase
 * 3. Remover espacios de un string
 * 4. Validador de contraseña (mínimo 8 chars, 1 número, 1 mayúscula)
 * 5. Cifrado César (rotar letras n posiciones)
 */
