/*
 * MÓDULO 1: FUNDAMENTOS BÁSICOS
 * Ejemplo 4: Entrada del Usuario
 *
 * Aprenderás:
 * - Cómo leer datos del usuario con cin
 * - Diferencia entre cin y getline
 * - Validación básica de entrada
 */

#include <iostream>
#include <string>
#include <limits>  // Para limpiar el buffer

int main() {
    std::cout << "=== ENTRADA DEL USUARIO ===" << std::endl << std::endl;

    // ENTRADA SIMPLE CON CIN
    std::cout << "--- ENTRADA SIMPLE ---" << std::endl;
    std::string nombre;
    int edad;

    std::cout << "Ingresa tu nombre (sin espacios): ";
    std::cin >> nombre;  // Lee hasta encontrar un espacio o salto de línea

    std::cout << "Ingresa tu edad: ";
    std::cin >> edad;

    std::cout << "Hola " << nombre << ", tienes " << edad << " años." << std::endl << std::endl;

    // LIMPIAR EL BUFFER (importante antes de usar getline después de cin)
    std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');

    // ENTRADA DE TEXTO CON ESPACIOS (getline)
    std::cout << "--- ENTRADA CON ESPACIOS ---" << std::endl;
    std::string nombreCompleto;

    std::cout << "Ingresa tu nombre completo: ";
    std::getline(std::cin, nombreCompleto);  // Lee toda la línea, incluyendo espacios

    std::cout << "Tu nombre completo es: " << nombreCompleto << std::endl << std::endl;

    // ENTRADA DE MÚLTIPLES VALORES
    std::cout << "--- MÚLTIPLES VALORES ---" << std::endl;
    double num1, num2;

    std::cout << "Ingresa dos números separados por espacio: ";
    std::cin >> num1 >> num2;

    double suma = num1 + num2;
    double producto = num1 * num2;

    std::cout << "Suma: " << suma << std::endl;
    std::cout << "Producto: " << producto << std::endl << std::endl;

    // CALCULADORA SIMPLE
    std::cout << "--- CALCULADORA SIMPLE ---" << std::endl;
    double a, b;
    char operador;

    std::cout << "Ingresa el primer número: ";
    std::cin >> a;

    std::cout << "Ingresa el operador (+, -, *, /): ";
    std::cin >> operador;

    std::cout << "Ingresa el segundo número: ";
    std::cin >> b;

    std::cout << std::endl << "Resultado: ";

    // Usar el operador ingresado
    if (operador == '+') {
        std::cout << a << " + " << b << " = " << (a + b) << std::endl;
    } else if (operador == '-') {
        std::cout << a << " - " << b << " = " << (a - b) << std::endl;
    } else if (operador == '*') {
        std::cout << a << " * " << b << " = " << (a * b) << std::endl;
    } else if (operador == '/') {
        if (b != 0) {
            std::cout << a << " / " << b << " = " << (a / b) << std::endl;
        } else {
            std::cout << "Error: No se puede dividir entre cero" << std::endl;
        }
    } else {
        std::cout << "Operador inválido" << std::endl;
    }

    return 0;
}

/*
 * CÓMO COMPILAR Y EJECUTAR:
 * g++ 04_entrada_usuario.cpp -o entrada
 * ./entrada
 *
 * EJEMPLO DE EJECUCIÓN:
 * Ingresa tu nombre (sin espacios): Francisco
 * Ingresa tu edad: 25
 * Hola Francisco, tienes 25 años.
 *
 * DIFERENCIAS IMPORTANTES:
 *
 * cin >> variable
 * - Lee hasta encontrar un espacio, tabulador o salto de línea
 * - Ideal para números y palabras sueltas
 * - Deja el salto de línea en el buffer
 *
 * getline(cin, variable)
 * - Lee toda la línea hasta el salto de línea
 * - Ideal para textos con espacios
 * - Consume el salto de línea
 *
 * IMPORTANTE:
 * - Siempre usa cin.ignore() después de cin >> si vas a usar getline
 * - Valida las entradas del usuario (como división entre cero)
 */
