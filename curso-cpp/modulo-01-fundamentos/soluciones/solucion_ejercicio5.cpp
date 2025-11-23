/*
 * SOLUCIÓN - EJERCICIO 5: Calculadora de IMC
 *
 * Este programa calcula el Índice de Masa Corporal
 * y clasifica el resultado
 */

#include <iostream>

int main() {
    double peso, altura, imc;

    std::cout << "=== CALCULADORA DE IMC ===" << std::endl << std::endl;

    // Solicitar datos al usuario
    std::cout << "Ingresa tu peso (kg): ";
    std::cin >> peso;

    std::cout << "Ingresa tu altura (m): ";
    std::cin >> altura;

    // Calcular el IMC
    // Fórmula: IMC = peso / (altura × altura)
    imc = peso / (altura * altura);

    // Mostrar el resultado
    std::cout << std::endl;
    std::cout << "Tu IMC es: " << imc << std::endl;

    // Clasificar el resultado usando estructuras if-else
    std::cout << "Clasificación: ";

    if (imc < 18.5) {
        std::cout << "Bajo peso" << std::endl;
    } else if (imc < 25) {
        std::cout << "Peso normal" << std::endl;
    } else if (imc < 30) {
        std::cout << "Sobrepeso" << std::endl;
    } else {
        std::cout << "Obesidad" << std::endl;
    }

    // Información adicional
    std::cout << std::endl;
    std::cout << "Rangos de IMC:" << std::endl;
    std::cout << "  Bajo peso: < 18.5" << std::endl;
    std::cout << "  Normal: 18.5 - 24.9" << std::endl;
    std::cout << "  Sobrepeso: 25.0 - 29.9" << std::endl;
    std::cout << "  Obesidad: >= 30.0" << std::endl;

    return 0;
}

/*
 * CONCEPTOS APLICADOS:
 * - Variables de tipo double para cálculos precisos
 * - Operaciones aritméticas (división y multiplicación)
 * - Estructuras condicionales if-else encadenadas
 * - Comparaciones numéricas
 *
 * MEJORA POSIBLE:
 * Agregar validación para asegurar que peso y altura sean positivos
 */
