/*
 * MÓDULO 1: FUNDAMENTOS BÁSICOS DE C++
 * Ejemplo 1: Hola Mundo
 *
 * Este es el programa más simple en C++
 * Aquí aprenderás:
 * - La estructura básica de un programa en C++
 * - Cómo usar iostream para entrada/salida
 * - La función main()
 */

#include <iostream>  // Biblioteca para entrada/salida estándar

// La función main() es el punto de entrada de todo programa C++
int main() {
    // std::cout se usa para mostrar texto en la consola
    // << es el operador de inserción
    // std::endl inserta un salto de línea y limpia el buffer
    std::cout << "¡Hola Mundo!" << std::endl;

    // return 0 indica que el programa terminó correctamente
    return 0;
}

/*
 * CÓMO COMPILAR Y EJECUTAR:
 *
 * En terminal:
 * g++ 01_hola_mundo.cpp -o hola_mundo
 * ./hola_mundo
 *
 * SALIDA ESPERADA:
 * ¡Hola Mundo!
 */
