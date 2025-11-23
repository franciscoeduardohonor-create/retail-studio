/*
 * ============================================================================
 * PROGRAMA: Variables en C
 * DESCRIPCIÓN: Aprende a declarar y usar variables
 * NIVEL: Principiante
 * ============================================================================
 */

#include <stdio.h>

int main() {

    // ========== DECLARACIÓN DE VARIABLES ==========

    /*
     * Sintaxis: tipo_de_dato nombre_variable;
     * Las variables DEBEN ser declaradas antes de usarse
     */

    int edad;              // Variable para números enteros
    float altura;          // Variable para números decimales
    char inicial;          // Variable para un solo carácter

    // También podemos declarar múltiples variables del mismo tipo
    int dia, mes, anio;

    // ========== ASIGNACIÓN DE VALORES ==========

    // Usamos el operador = para asignar valores
    edad = 25;
    altura = 1.75;        // 1.75 metros
    inicial = 'J';        // Los caracteres van entre comillas simples

    dia = 15;
    mes = 8;
    anio = 2024;

    // ========== DECLARACIÓN E INICIALIZACIÓN SIMULTÁNEA ==========

    // Podemos declarar y asignar en una sola línea
    int temperatura = 28;
    float precio = 49.99;
    char grado = 'A';

    // ========== IMPRIMIENDO VARIABLES ==========

    printf("=== INFORMACIÓN PERSONAL ===\n");

    // %d es un "especificador de formato" para enteros (int)
    printf("Edad: %d años\n", edad);

    // %f es para números decimales (float)
    printf("Altura: %f metros\n", altura);

    // %.2f muestra solo 2 decimales
    printf("Altura: %.2f metros\n", altura);

    // %c es para caracteres (char)
    printf("Inicial: %c\n", inicial);

    printf("\n=== FECHA ===\n");
    // Podemos usar múltiples especificadores en un printf
    printf("Fecha: %d/%d/%d\n", dia, mes, anio);

    printf("\n=== OTROS DATOS ===\n");
    printf("Temperatura: %d°C\n", temperatura);
    printf("Precio: $%.2f\n", precio);
    printf("Calificación: %c\n", grado);

    // ========== MODIFICANDO VARIABLES ==========

    printf("\n=== MODIFICACIÓN DE VARIABLES ===\n");
    printf("Edad original: %d\n", edad);

    edad = 26;  // Cambiamos el valor
    printf("Edad actualizada: %d\n", edad);

    // ========== OPERACIONES CON VARIABLES ==========

    int numero1 = 10;
    int numero2 = 5;
    int suma;

    suma = numero1 + numero2;
    printf("\n%d + %d = %d\n", numero1, numero2, suma);

    return 0;
}

/*
 * CONCEPTOS CLAVE:
 *
 * 1. TIPOS DE DATOS BÁSICOS:
 *    - int: números enteros (-2, 0, 42, 1000)
 *    - float: números decimales (3.14, -0.5, 2.0)
 *    - char: un solo carácter ('A', 'z', '3', '$')
 *
 * 2. NOMBRES DE VARIABLES:
 *    - Pueden contener letras, números y guión bajo (_)
 *    - DEBEN empezar con letra o guión bajo
 *    - No pueden usar palabras reservadas (int, float, if, etc.)
 *    - C es sensible a mayúsculas: edad ≠ Edad ≠ EDAD
 *
 * 3. ESPECIFICADORES DE FORMATO:
 *    - %d o %i: enteros (int)
 *    - %f: decimales (float)
 *    - %c: caracteres (char)
 *    - %.2f: decimal con 2 decimales
 *
 * EJERCICIOS PARA PRACTICAR:
 *
 * 1. Crea variables para almacenar:
 *    - Tu nombre (pista: necesitarás char para cada letra)
 *    - Tu peso
 *    - Tu año de nacimiento
 *
 * 2. Calcula tu edad basándote en el año actual y tu año de nacimiento
 *
 * 3. Crea un programa que almacene las dimensiones de un rectángulo
 *    (largo y ancho) y luego calcule su área
 *
 * 4. Experimenta con diferentes especificadores de formato:
 *    - ¿Qué pasa si usas %d para imprimir un float?
 *    - ¿Qué pasa si usas %f para imprimir un int?
 */
