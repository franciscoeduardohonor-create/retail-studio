/*
 * MÓDULO 2: CONTROL DE FLUJO
 * Ejemplo 4: Funciones
 *
 * Aprenderás:
 * - Cómo crear funciones
 * - Parámetros y valores de retorno
 * - Prototipos de funciones
 * - Sobrecarga de funciones
 * - Funciones recursivas
 */

#include <iostream>
#include <string>

// PROTOTIPOS DE FUNCIONES (declaraciones)
// Se declaran antes de main() y se definen después
void saludar();
void saludarPersona(std::string nombre);
int sumar(int a, int b);
double calcularPromedio(double num1, double num2, double num3);
bool esPar(int numero);
int factorial(int n);

// FUNCIÓN PRINCIPAL
int main() {
    std::cout << "=== FUNCIONES EN C++ ===" << std::endl << std::endl;

    // LLAMAR FUNCIONES SIN PARÁMETROS
    std::cout << "--- FUNCIÓN SIN PARÁMETROS ---" << std::endl;
    saludar();  // Simplemente se llama por su nombre
    std::cout << std::endl;

    // LLAMAR FUNCIONES CON PARÁMETROS
    std::cout << "--- FUNCIÓN CON PARÁMETROS ---" << std::endl;
    saludarPersona("Francisco");
    saludarPersona("María");
    std::cout << std::endl;

    // FUNCIONES QUE RETORNAN VALORES
    std::cout << "--- FUNCIÓN CON RETORNO ---" << std::endl;
    int resultado = sumar(5, 3);
    std::cout << "5 + 3 = " << resultado << std::endl;

    // Puedes usar el resultado directamente
    std::cout << "10 + 20 = " << sumar(10, 20) << std::endl;
    std::cout << std::endl;

    // FUNCIÓN CON MÚLTIPLES PARÁMETROS
    std::cout << "--- MÚLTIPLES PARÁMETROS ---" << std::endl;
    double promedio = calcularPromedio(8.5, 9.0, 7.5);
    std::cout << "Promedio: " << promedio << std::endl;
    std::cout << std::endl;

    // FUNCIÓN QUE RETORNA BOOLEANO
    std::cout << "--- FUNCIÓN BOOLEANA ---" << std::endl;
    int num = 8;

    if (esPar(num)) {
        std::cout << num << " es par" << std::endl;
    } else {
        std::cout << num << " es impar" << std::endl;
    }
    std::cout << std::endl;

    // FUNCIÓN RECURSIVA
    std::cout << "--- RECURSIÓN ---" << std::endl;
    int n = 5;
    std::cout << n << "! = " << factorial(n) << std::endl;

    return 0;
}

// DEFINICIONES DE LAS FUNCIONES

// Función simple sin parámetros ni retorno
void saludar() {
    std::cout << "¡Hola Mundo desde una función!" << std::endl;
}

// Función con un parámetro, sin retorno
void saludarPersona(std::string nombre) {
    std::cout << "¡Hola " << nombre << "!" << std::endl;
}

// Función con parámetros que retorna un valor
int sumar(int a, int b) {
    int resultado = a + b;
    return resultado;  // Devuelve el valor
    // Código después de return NO se ejecuta
}

// Función con múltiples parámetros
double calcularPromedio(double num1, double num2, double num3) {
    double suma = num1 + num2 + num3;
    return suma / 3.0;
}

// Función que retorna booleano
bool esPar(int numero) {
    return (numero % 2 == 0);  // Retorna true si es par, false si no
}

// Función RECURSIVA (se llama a sí misma)
int factorial(int n) {
    // Caso base: detiene la recursión
    if (n <= 1) {
        return 1;
    }

    // Caso recursivo: la función se llama a sí misma
    return n * factorial(n - 1);
}

/*
 * Ejemplo de cómo funciona factorial(5):
 * factorial(5) = 5 * factorial(4)
 *              = 5 * (4 * factorial(3))
 *              = 5 * (4 * (3 * factorial(2)))
 *              = 5 * (4 * (3 * (2 * factorial(1))))
 *              = 5 * (4 * (3 * (2 * 1)))
 *              = 5 * 4 * 3 * 2 * 1
 *              = 120
 */

/*
 * CÓMO COMPILAR Y EJECUTAR:
 * g++ 04_funciones.cpp -o funciones
 * ./funciones
 *
 * ANATOMÍA DE UNA FUNCIÓN:
 *
 * tipo_retorno nombre_funcion(tipo_parametro parametro) {
 *     // Cuerpo de la función
 *     return valor;
 * }
 *
 * PARTES:
 * 1. tipo_retorno: Qué tipo de dato devuelve (int, double, bool, void)
 *    - void significa que no retorna nada
 *
 * 2. nombre_funcion: Debe ser descriptivo (calcularArea, esPrimo)
 *
 * 3. parametros: Variables que recibe (pueden ser 0 o más)
 *
 * 4. return: Devuelve un valor (no se usa con void)
 *
 * PROTOTIPOS vs DEFINICIONES:
 *
 * PROTOTIPO (declaración):
 * - Se escribe antes de main()
 * - Solo muestra la "firma" de la función
 * - Ejemplo: int sumar(int a, int b);
 *
 * DEFINICIÓN:
 * - Contiene el código real de la función
 * - Puede estar antes o después de main()
 * - Si está después, NECESITAS el prototipo
 *
 * VENTAJAS DE LAS FUNCIONES:
 * ✓ Reutilización de código
 * ✓ Organización y legibilidad
 * ✓ Facilita el mantenimiento
 * ✓ Permite el testing individual
 * ✓ Divide problemas complejos en partes simples
 *
 * BUENAS PRÁCTICAS:
 * - Una función debe hacer UNA cosa bien
 * - Usa nombres descriptivos (calcular, verificar, obtener)
 * - Limita el número de parámetros (máximo 4-5)
 * - Documenta funciones complejas con comentarios
 */
