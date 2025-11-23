/*
 * ============================================================================
 * PROGRAMA: Punteros Básicos
 * DESCRIPCIÓN: Introducción a punteros y direcciones de memoria
 * NIVEL: Intermedio-Avanzado
 * ============================================================================
 */

#include <stdio.h>
#include <stdlib.h>  // Para malloc, free

int main() {

    // ========== QUÉ ES UN PUNTERO ==========

    printf("========== PUNTEROS EN C ==========\n\n");

    /*
     * Un puntero es una variable que almacena la DIRECCIÓN
     * de memoria de otra variable
     *
     * Operadores:
     *   &  - Obtiene la dirección de una variable (address-of)
     *   *  - Accede al valor en una dirección (dereference)
     */

    int edad = 25;
    int *ptr;  // Declaración de puntero a int

    ptr = &edad;  // ptr ahora apunta a edad

    printf("--- Conceptos básicos ---\n");
    printf("Valor de edad: %d\n", edad);
    printf("Dirección de edad: %p\n", (void*)&edad);
    printf("Valor de ptr (dirección que guarda): %p\n", (void*)ptr);
    printf("Valor apuntado por ptr: %d\n", *ptr);
    printf("\n");

    // ========== MODIFICAR A TRAVÉS DE PUNTEROS ==========

    printf("--- Modificar mediante punteros ---\n");

    printf("Antes: edad = %d\n", edad);

    *ptr = 30;  // Modifica edad a través del puntero

    printf("Después: edad = %d\n", edad);
    printf("*ptr = %d\n\n", *ptr);

    // ========== PUNTEROS CON DIFERENTES TIPOS ==========

    printf("--- Punteros con diferentes tipos ---\n");

    float precio = 19.99;
    float *ptr_float = &precio;

    char letra = 'A';
    char *ptr_char = &letra;

    printf("precio = %.2f, *ptr_float = %.2f\n", precio, *ptr_float);
    printf("letra = %c, *ptr_char = %c\n\n", letra, *ptr_char);

    // ========== PUNTERO NULL ==========

    printf("--- Puntero NULL ---\n");

    int *ptr_null = NULL;  // Puntero que no apunta a nada

    if (ptr_null == NULL) {
        printf("El puntero es NULL (no apunta a ninguna dirección válida)\n\n");
    }

    // NUNCA hagas esto: *ptr_null = 10;  // ¡SEGMENTATION FAULT!

    // ========== PUNTEROS Y ARRAYS ==========

    printf("--- Punteros y arrays ---\n");

    int numeros[] = {10, 20, 30, 40, 50};
    int *ptr_array = numeros;  // El nombre del array ES un puntero

    printf("Primer elemento: %d\n", *ptr_array);
    printf("Segundo elemento: %d\n", *(ptr_array + 1));
    printf("Tercer elemento: %d\n", *(ptr_array + 2));
    printf("\n");

    // Recorrer array con puntero
    printf("Recorriendo array con puntero:\n");
    for (int i = 0; i < 5; i++) {
        printf("numeros[%d] = %d\n", i, *(ptr_array + i));
    }
    printf("\n");

    // ========== ARITMÉTICA DE PUNTEROS ==========

    printf("--- Aritmética de punteros ---\n");

    int arr[] = {1, 2, 3, 4, 5};
    int *p = arr;

    printf("*p = %d (elemento 0)\n", *p);

    p++;  // Avanza al siguiente elemento
    printf("*p = %d (elemento 1)\n", *p);

    p += 2;  // Avanza 2 elementos
    printf("*p = %d (elemento 3)\n", *p);

    p--;  // Retrocede un elemento
    printf("*p = %d (elemento 2)\n\n", *p);

    // ========== MEMORIA DINÁMICA ==========

    printf("--- Memoria dinámica ---\n");

    // malloc() reserva memoria en tiempo de ejecución
    int *dinamico = (int*) malloc(5 * sizeof(int));

    if (dinamico == NULL) {
        printf("Error al reservar memoria\n");
        return 1;
    }

    // Usar memoria dinámica como array
    for (int i = 0; i < 5; i++) {
        dinamico[i] = (i + 1) * 10;
    }

    printf("Array dinámico: ");
    for (int i = 0; i < 5; i++) {
        printf("%d ", dinamico[i]);
    }
    printf("\n");

    // IMPORTANTE: Liberar memoria cuando termines
    free(dinamico);
    dinamico = NULL;  // Buena práctica

    printf("\n");

    // ========== CALLOC - RESERVA E INICIALIZA ==========

    printf("--- calloc (inicializa a cero) ---\n");

    int *ceros = (int*) calloc(5, sizeof(int));

    if (ceros == NULL) {
        printf("Error al reservar memoria\n");
        return 1;
    }

    printf("Array con calloc (inicializado a 0): ");
    for (int i = 0; i < 5; i++) {
        printf("%d ", ceros[i]);
    }
    printf("\n");

    free(ceros);
    printf("\n");

    // ========== REALLOC - REDIMENSIONAR ==========

    printf("--- realloc (redimensionar) ---\n");

    int *expandible = (int*) malloc(3 * sizeof(int));

    expandible[0] = 1;
    expandible[1] = 2;
    expandible[2] = 3;

    printf("Array original (3 elementos): ");
    for (int i = 0; i < 3; i++) {
        printf("%d ", expandible[i]);
    }
    printf("\n");

    // Expandir a 5 elementos
    expandible = (int*) realloc(expandible, 5 * sizeof(int));

    expandible[3] = 4;
    expandible[4] = 5;

    printf("Array expandido (5 elementos): ");
    for (int i = 0; i < 5; i++) {
        printf("%d ", expandible[i]);
    }
    printf("\n");

    free(expandible);
    printf("\n");

    // ========== PASO POR REFERENCIA ==========

    printf("--- Paso por referencia ---\n");

    int x = 10;
    printf("Antes: x = %d\n", x);

    // Función local que modifica x mediante puntero
    void duplicar(int *num) {
        *num = *num * 2;
    }

    duplicar(&x);  // Pasamos la DIRECCIÓN de x

    printf("Después: x = %d\n", x);

    return 0;
}

/*
 * CONCEPTOS CLAVE:
 *
 * DECLARACIÓN:
 *   int *ptr;     // Puntero a int
 *   float *ptr;   // Puntero a float
 *   char *ptr;    // Puntero a char
 *
 * OPERADORES:
 *   &variable     // Obtiene dirección de variable
 *   *puntero      // Accede al valor apuntado
 *
 * EJEMPLO:
 *   int x = 5;
 *   int *p = &x;  // p guarda dirección de x
 *   *p = 10;      // Modifica x a través de p
 *
 * MEMORIA DINÁMICA:
 *   malloc(size)           // Reserva memoria
 *   calloc(n, size)        // Reserva e inicializa a 0
 *   realloc(ptr, new_size) // Redimensiona
 *   free(ptr)              // Libera memoria
 *
 * REGLAS DE ORO:
 * 1. SIEMPRE inicializa punteros (NULL si no apuntan a nada)
 * 2. SIEMPRE verifica si malloc/calloc retorna NULL
 * 3. SIEMPRE libera memoria con free()
 * 4. Pon punteros a NULL después de free()
 * 5. NO accedas memoria después de free()
 * 6. NO pierdas la dirección original (memory leak)
 *
 * ERRORES COMUNES:
 *
 * 1. PUNTERO NO INICIALIZADO:
 *    int *p;
 *    *p = 5;  // ¡ERROR! p no apunta a nada válido
 *
 * 2. OLVIDAR free():
 *    int *p = malloc(100);
 *    // ... usar p ...
 *    // ¡OLVIDO free(p)! = Memory leak
 *
 * 3. USAR DESPUÉS DE free():
 *    int *p = malloc(sizeof(int));
 *    free(p);
 *    *p = 5;  // ¡ERROR! Memoria ya liberada
 *
 * 4. CONFUNDIR * EN DECLARACIÓN Y USO:
 *    int *p;    // * es parte del tipo
 *    *p = 5;    // * es operador de indirección
 *
 * EJERCICIOS:
 * 1. Programa que intercambie dos variables usando punteros
 * 2. Función que retorne máximo y mínimo usando punteros
 * 3. Array dinámico que crezca según necesidad
 * 4. Lista enlazada simple
 * 5. Calculadora de matrices con memoria dinámica
 */
