/*
 * ============================================================================
 * PROGRAMA: Hola Mundo
 * DESCRIPCIÓN: Tu primer programa en C
 * NIVEL: Principiante
 * ============================================================================
 */

// Esta línea incluye la biblioteca estándar de entrada/salida
// stdio.h contiene funciones como printf() y scanf()
#include <stdio.h>

/*
 * main() es la función principal de todo programa en C
 * int indica que esta función retorna un número entero
 * El programa SIEMPRE comienza ejecutándose desde main()
 */
int main() {

    // printf() imprime texto en la pantalla
    // \n es un "carácter de nueva línea" que mueve el cursor a la siguiente línea
    printf("¡Hola, Mundo!\n");
    printf("Bienvenido al curso de C\n");

    // Podemos usar printf() múltiples veces
    printf("Este es mi primer programa\n");

    /*
     * return 0 indica que el programa terminó exitosamente
     * 0 = éxito, cualquier otro número = error
     * El sistema operativo puede leer este valor
     */
    return 0;
}

/*
 * CÓMO COMPILAR Y EJECUTAR:
 *
 * En Linux/Mac:
 *   gcc 01_hola_mundo.c -o hola_mundo
 *   ./hola_mundo
 *
 * En Windows:
 *   gcc 01_hola_mundo.c -o hola_mundo.exe
 *   hola_mundo.exe
 *
 * EJERCICIO PARA TI:
 * 1. Modifica el programa para que imprima tu nombre
 * 2. Agrega más líneas con printf() para crear un mensaje de bienvenida
 * 3. Experimenta quitando el \n y observa qué pasa
 */
