/*
 * MÓDULO 1: FUNDAMENTOS BÁSICOS
 * Ejemplo 3: Operadores en C++
 *
 * Aprenderás:
 * - Operadores aritméticos
 * - Operadores de comparación
 * - Operadores lógicos
 * - Operadores de asignación
 */

#include <iostream>

int main() {
    std::cout << "=== OPERADORES EN C++ ===" << std::endl << std::endl;

    // OPERADORES ARITMÉTICOS
    std::cout << "--- OPERADORES ARITMÉTICOS ---" << std::endl;
    int a = 10, b = 3;

    std::cout << "a = " << a << ", b = " << b << std::endl;
    std::cout << "Suma (a + b): " << (a + b) << std::endl;
    std::cout << "Resta (a - b): " << (a - b) << std::endl;
    std::cout << "Multiplicación (a * b): " << (a * b) << std::endl;
    std::cout << "División (a / b): " << (a / b) << std::endl;  // División entera
    std::cout << "División decimal: " << (a / (double)b) << std::endl;  // Casting
    std::cout << "Módulo (a % b): " << (a % b) << std::endl;  // Residuo
    std::cout << std::endl;

    // OPERADORES DE INCREMENTO Y DECREMENTO
    std::cout << "--- INCREMENTO Y DECREMENTO ---" << std::endl;
    int contador = 5;
    std::cout << "Contador inicial: " << contador << std::endl;

    std::cout << "Post-incremento (contador++): " << contador++ << std::endl;
    std::cout << "Valor después: " << contador << std::endl;

    std::cout << "Pre-incremento (++contador): " << ++contador << std::endl;
    std::cout << "Valor después: " << contador << std::endl;

    std::cout << "Post-decremento (contador--): " << contador-- << std::endl;
    std::cout << "Valor después: " << contador << std::endl;
    std::cout << std::endl;

    // OPERADORES DE COMPARACIÓN
    std::cout << "--- OPERADORES DE COMPARACIÓN ---" << std::endl;
    std::cout << std::boolalpha;  // Mostrar true/false en lugar de 1/0

    int x = 10, y = 20;
    std::cout << "x = " << x << ", y = " << y << std::endl;
    std::cout << "x == y (igual): " << (x == y) << std::endl;
    std::cout << "x != y (diferente): " << (x != y) << std::endl;
    std::cout << "x > y (mayor que): " << (x > y) << std::endl;
    std::cout << "x < y (menor que): " << (x < y) << std::endl;
    std::cout << "x >= y (mayor o igual): " << (x >= y) << std::endl;
    std::cout << "x <= y (menor o igual): " << (x <= y) << std::endl;
    std::cout << std::endl;

    // OPERADORES LÓGICOS
    std::cout << "--- OPERADORES LÓGICOS ---" << std::endl;
    bool esAdulto = true;
    bool tieneLicencia = false;

    std::cout << "Es adulto: " << esAdulto << std::endl;
    std::cout << "Tiene licencia: " << tieneLicencia << std::endl;

    std::cout << "AND (&&) - Ambos verdaderos: " << (esAdulto && tieneLicencia) << std::endl;
    std::cout << "OR (||) - Al menos uno verdadero: " << (esAdulto || tieneLicencia) << std::endl;
    std::cout << "NOT (!) - Negación: " << (!tieneLicencia) << std::endl;
    std::cout << std::endl;

    // OPERADORES DE ASIGNACIÓN COMPUESTA
    std::cout << "--- OPERADORES DE ASIGNACIÓN COMPUESTA ---" << std::endl;
    int num = 10;
    std::cout << "Valor inicial: " << num << std::endl;

    num += 5;  // Equivalente a: num = num + 5
    std::cout << "Después de += 5: " << num << std::endl;

    num -= 3;  // Equivalente a: num = num - 3
    std::cout << "Después de -= 3: " << num << std::endl;

    num *= 2;  // Equivalente a: num = num * 2
    std::cout << "Después de *= 2: " << num << std::endl;

    num /= 4;  // Equivalente a: num = num / 4
    std::cout << "Después de /= 4: " << num << std::endl;

    num %= 5;  // Equivalente a: num = num % 5
    std::cout << "Después de %= 5: " << num << std::endl;
    std::cout << std::endl;

    // PRECEDENCIA DE OPERADORES
    std::cout << "--- PRECEDENCIA DE OPERADORES ---" << std::endl;
    int resultado1 = 5 + 3 * 2;        // * tiene mayor precedencia
    int resultado2 = (5 + 3) * 2;      // Los paréntesis cambian la precedencia

    std::cout << "5 + 3 * 2 = " << resultado1 << std::endl;
    std::cout << "(5 + 3) * 2 = " << resultado2 << std::endl;

    // Orden de precedencia (de mayor a menor):
    // 1. Paréntesis ()
    // 2. Incremento/Decremento ++, --
    // 3. Multiplicación/División/Módulo *, /, %
    // 4. Suma/Resta +, -
    // 5. Comparación <, >, <=, >=
    // 6. Igualdad ==, !=
    // 7. AND lógico &&
    // 8. OR lógico ||
    // 9. Asignación =, +=, -=, etc.

    return 0;
}

/*
 * CÓMO COMPILAR Y EJECUTAR:
 * g++ 03_operadores.cpp -o operadores
 * ./operadores
 *
 * CONSEJOS:
 * - Usa paréntesis para hacer el código más legible
 * - Ten cuidado con la división entera (10/3 = 3, no 3.33)
 * - El operador % (módulo) solo funciona con enteros
 */
