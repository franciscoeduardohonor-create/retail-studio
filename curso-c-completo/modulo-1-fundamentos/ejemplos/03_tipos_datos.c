/*
 * ============================================================================
 * PROGRAMA: Tipos de Datos en C
 * DESCRIPCIÓN: Exploración completa de todos los tipos de datos básicos
 * NIVEL: Principiante
 * ============================================================================
 */

#include <stdio.h>
#include <limits.h>  // Contiene los límites de los tipos enteros
#include <float.h>   // Contiene los límites de los tipos decimales

int main() {

    printf("========== TIPOS DE DATOS EN C ==========\n\n");

    // ========== ENTEROS (INT) ==========

    printf("--- ENTEROS (int) ---\n");

    int numero_entero = 42;
    printf("int: %d\n", numero_entero);
    printf("Tamaño: %lu bytes\n", sizeof(int));
    printf("Rango: %d a %d\n", INT_MIN, INT_MAX);
    printf("\n");

    // ========== ENTEROS CORTOS (SHORT) ==========

    printf("--- ENTEROS CORTOS (short) ---\n");

    short int numero_corto = 1000;
    // También se puede escribir solo como: short numero_corto = 1000;
    printf("short: %d\n", numero_corto);
    printf("Tamaño: %lu bytes\n", sizeof(short));
    printf("Rango: %d a %d\n", SHRT_MIN, SHRT_MAX);
    printf("\n");

    // ========== ENTEROS LARGOS (LONG) ==========

    printf("--- ENTEROS LARGOS (long) ---\n");

    long int numero_largo = 1000000L;  // La 'L' indica que es long
    printf("long: %ld\n", numero_largo);
    printf("Tamaño: %lu bytes\n", sizeof(long));
    printf("Rango: %ld a %ld\n", LONG_MIN, LONG_MAX);
    printf("\n");

    // ========== ENTEROS SIN SIGNO (UNSIGNED) ==========

    printf("--- ENTEROS SIN SIGNO (unsigned) ---\n");

    /*
     * unsigned significa "sin signo" (solo números positivos)
     * Útil cuando sabes que un número NUNCA será negativo
     * Ejemplo: edad, cantidad de productos, etc.
     */

    unsigned int positivo = 100;
    printf("unsigned int: %u\n", positivo);
    printf("Tamaño: %lu bytes\n", sizeof(unsigned int));
    printf("Rango: 0 a %u\n", UINT_MAX);
    printf("\n");

    // ========== CARACTERES (CHAR) ==========

    printf("--- CARACTERES (char) ---\n");

    char letra = 'A';
    char simbolo = '@';
    char digito = '5';  // Nota: esto es diferente del número 5

    printf("letra: %c\n", letra);
    printf("símbolo: %c\n", simbolo);
    printf("dígito: %c\n", digito);
    printf("Tamaño: %lu byte\n", sizeof(char));

    // Los char en realidad son números pequeños (código ASCII)
    printf("Valor ASCII de 'A': %d\n", letra);
    printf("\n");

    // ========== DECIMALES DE PRECISIÓN SIMPLE (FLOAT) ==========

    printf("--- DECIMALES (float) ---\n");

    float pi = 3.14159265359;
    float precio = 19.99;

    printf("pi (6 decimales): %f\n", pi);
    printf("pi (2 decimales): %.2f\n", pi);
    printf("pi (10 decimales): %.10f\n", pi);
    printf("precio: $%.2f\n", precio);
    printf("Tamaño: %lu bytes\n", sizeof(float));
    printf("Precisión: aproximadamente 6-7 dígitos\n");
    printf("\n");

    // ========== DECIMALES DE PRECISIÓN DOBLE (DOUBLE) ==========

    printf("--- DECIMALES DE DOBLE PRECISIÓN (double) ---\n");

    double pi_preciso = 3.14159265358979323846;
    double distancia = 384400.0;  // Distancia a la Luna en km

    printf("pi (double): %.15f\n", pi_preciso);
    printf("distancia a la Luna: %.2f km\n", distancia);
    printf("Tamaño: %lu bytes\n", sizeof(double));
    printf("Precisión: aproximadamente 15-16 dígitos\n");
    printf("\n");

    // ========== COMPARACIÓN DE TAMAÑOS ==========

    printf("--- TABLA DE TAMAÑOS ---\n");
    printf("%-15s %10s\n", "Tipo", "Bytes");
    printf("%-15s %10lu\n", "char", sizeof(char));
    printf("%-15s %10lu\n", "short", sizeof(short));
    printf("%-15s %10lu\n", "int", sizeof(int));
    printf("%-15s %10lu\n", "long", sizeof(long));
    printf("%-15s %10lu\n", "float", sizeof(float));
    printf("%-15s %10lu\n", "double", sizeof(double));
    printf("\n");

    // ========== EJEMPLOS PRÁCTICOS ==========

    printf("--- EJEMPLOS PRÁCTICOS ---\n");

    // Edad de una persona (int o unsigned int)
    unsigned int edad = 25;
    printf("Edad: %u años\n", edad);

    // Altura en metros (float o double)
    float altura = 1.75;
    printf("Altura: %.2f m\n", altura);

    // Calificación (char)
    char calificacion = 'A';
    printf("Calificación: %c\n", calificacion);

    // Precio de producto (float)
    float precio_producto = 149.99;
    printf("Precio: $%.2f\n", precio_producto);

    // Población de un país (long)
    long poblacion = 128000000L;
    printf("Población: %ld habitantes\n", poblacion);

    return 0;
}

/*
 * GUÍA RÁPIDA DE TIPOS DE DATOS:
 *
 * ENTEROS:
 *   char         1 byte   -128 a 127
 *   short        2 bytes  -32,768 a 32,767
 *   int          4 bytes  -2,147,483,648 a 2,147,483,647
 *   long         8 bytes  -9,223,372,036,854,775,808 a 9,223,372,036,854,775,807
 *
 * DECIMALES:
 *   float        4 bytes  ~6-7 dígitos de precisión
 *   double       8 bytes  ~15-16 dígitos de precisión
 *
 * MODIFICADORES:
 *   unsigned: solo valores positivos (duplica el rango positivo)
 *   signed: valores positivos y negativos (por defecto)
 *
 * CUÁNDO USAR CADA UNO:
 *   - char: caracteres individuales, números muy pequeños
 *   - int: números enteros en general (edad, cantidad, etc.)
 *   - long: números enteros muy grandes (población, distancias, etc.)
 *   - float: decimales donde no importa mucha precisión (precios, temperaturas)
 *   - double: decimales que requieren alta precisión (cálculos científicos)
 *
 * ESPECIFICADORES DE FORMATO:
 *   %c    char
 *   %d    int, short
 *   %ld   long
 *   %u    unsigned int
 *   %f    float, double
 *   %.2f  float/double con 2 decimales
 *   %lu   tamaño (sizeof)
 *
 * EJERCICIOS:
 *
 * 1. Crea variables para representar:
 *    - Número de estudiantes en una clase
 *    - Precio de un auto
 *    - Distancia entre dos ciudades
 *    - Inicial de tu apellido
 *    - Temperatura actual
 *
 * 2. Experimenta con los límites:
 *    - ¿Qué pasa si intentas guardar 1000 en un char?
 *    - ¿Qué pasa si intentas guardar -5 en un unsigned int?
 *
 * 3. Compara la precisión de float vs double:
 *    - Guarda el número 0.123456789012345 en float y double
 *    - Imprime ambos con %.15f
 *    - Observa la diferencia
 */
