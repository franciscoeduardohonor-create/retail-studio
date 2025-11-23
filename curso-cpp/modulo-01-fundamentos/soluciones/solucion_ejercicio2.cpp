/*
 * SOLUCIÓN - EJERCICIO 2: Conversor de Temperatura
 *
 * Este programa convierte grados Celsius a Fahrenheit
 */

#include <iostream>

int main() {
    // Declarar variable para almacenar la temperatura en Celsius
    double celsius;

    // Solicitar la temperatura al usuario
    std::cout << "=== CONVERSOR DE TEMPERATURA ===" << std::endl;
    std::cout << "Ingresa temperatura en Celsius: ";
    std::cin >> celsius;

    // Aplicar la fórmula de conversión
    // F = (C × 9/5) + 32
    double fahrenheit = (celsius * 9.0 / 5.0) + 32.0;

    // Mostrar el resultado
    std::cout << celsius << "°C = " << fahrenheit << "°F" << std::endl;

    return 0;
}

/*
 * CONCEPTOS APLICADOS:
 * - Variables de tipo double para números decimales
 * - Entrada de usuario con cin
 * - Operaciones aritméticas
 * - Salida formateada con cout
 *
 * NOTA IMPORTANTE:
 * Usamos 9.0 y 5.0 (con punto decimal) en lugar de 9 y 5
 * para asegurar que la división sea decimal y no entera.
 */
