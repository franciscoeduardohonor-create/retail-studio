/*
 * MÓDULO 2: CONTROL DE FLUJO
 * Ejemplo 5: Funciones Avanzadas
 *
 * Aprenderás:
 * - Sobrecarga de funciones (function overloading)
 * - Paso por valor vs paso por referencia
 * - Parámetros con valores por defecto
 * - Funciones inline
 */

#include <iostream>
#include <string>

// SOBRECARGA DE FUNCIONES (mismo nombre, diferentes parámetros)
int maximo(int a, int b);
double maximo(double a, double b);
int maximo(int a, int b, int c);

// PASO POR REFERENCIA (&)
void incrementar(int x);           // Paso por valor (no modifica el original)
void incrementarRef(int &x);       // Paso por referencia (modifica el original)
void intercambiar(int &a, int &b); // Intercambia dos variables

// PARÁMETROS POR DEFECTO
void imprimirMensaje(std::string mensaje, int veces = 1);
double calcularArea(double base, double altura = 1.0);

// FUNCIÓN INLINE (sugerencia de optimización)
inline int cuadrado(int x) {
    return x * x;
}

int main() {
    std::cout << "=== FUNCIONES AVANZADAS ===" << std::endl << std::endl;

    // SOBRECARGA DE FUNCIONES
    std::cout << "--- SOBRECARGA DE FUNCIONES ---" << std::endl;
    std::cout << "Máximo entre 5 y 10: " << maximo(5, 10) << std::endl;
    std::cout << "Máximo entre 3.5 y 7.2: " << maximo(3.5, 7.2) << std::endl;
    std::cout << "Máximo entre 3, 7 y 5: " << maximo(3, 7, 5) << std::endl;
    std::cout << std::endl;

    // PASO POR VALOR vs PASO POR REFERENCIA
    std::cout << "--- PASO POR VALOR vs REFERENCIA ---" << std::endl;

    int numero = 10;
    std::cout << "Valor inicial: " << numero << std::endl;

    incrementar(numero);  // Paso por valor
    std::cout << "Después de incrementar (por valor): " << numero << std::endl;

    incrementarRef(numero);  // Paso por referencia
    std::cout << "Después de incrementarRef (por referencia): " << numero << std::endl;
    std::cout << std::endl;

    // INTERCAMBIO DE VARIABLES
    std::cout << "--- INTERCAMBIO ---" << std::endl;
    int a = 100, b = 200;

    std::cout << "Antes: a = " << a << ", b = " << b << std::endl;
    intercambiar(a, b);
    std::cout << "Después: a = " << a << ", b = " << b << std::endl;
    std::cout << std::endl;

    // PARÁMETROS POR DEFECTO
    std::cout << "--- PARÁMETROS POR DEFECTO ---" << std::endl;

    imprimirMensaje("Hola");      // Usa el valor por defecto (1 vez)
    imprimirMensaje("Adiós", 3);  // Especifica las veces

    std::cout << std::endl;

    // Cálculo de área con parámetro por defecto
    std::cout << "Área con base=5, altura=3: " << calcularArea(5.0, 3.0) << std::endl;
    std::cout << "Área con base=5 (altura por defecto=1): " << calcularArea(5.0) << std::endl;
    std::cout << std::endl;

    // FUNCIÓN INLINE
    std::cout << "--- FUNCIÓN INLINE ---" << std::endl;
    std::cout << "Cuadrado de 7: " << cuadrado(7) << std::endl;
    std::cout << "Cuadrado de 12: " << cuadrado(12) << std::endl;

    return 0;
}

// IMPLEMENTACIÓN DE FUNCIONES SOBRECARGADAS
int maximo(int a, int b) {
    return (a > b) ? a : b;
}

double maximo(double a, double b) {
    return (a > b) ? a : b;
}

int maximo(int a, int b, int c) {
    int max = a;
    if (b > max) max = b;
    if (c > max) max = c;
    return max;
}

// PASO POR VALOR: crea una COPIA de la variable
void incrementar(int x) {
    x++;  // Solo modifica la copia, no el original
    std::cout << "  Dentro de incrementar: x = " << x << std::endl;
}

// PASO POR REFERENCIA: trabaja con la variable ORIGINAL
void incrementarRef(int &x) {
    x++;  // Modifica el original directamente
    std::cout << "  Dentro de incrementarRef: x = " << x << std::endl;
}

// Intercambiar dos variables usando referencias
void intercambiar(int &a, int &b) {
    int temp = a;
    a = b;
    b = temp;
}

// PARÁMETRO POR DEFECTO: veces = 1 si no se especifica
void imprimirMensaje(std::string mensaje, int veces) {
    for (int i = 0; i < veces; i++) {
        std::cout << mensaje << std::endl;
    }
}

// Calcula área de rectángulo, usa altura=1 si no se especifica
double calcularArea(double base, double altura) {
    return base * altura;
}

/*
 * CÓMO COMPILAR Y EJECUTAR:
 * g++ 05_funciones_avanzadas.cpp -o func_avanzadas
 * ./func_avanzadas
 *
 * CONCEPTOS EXPLICADOS:
 *
 * 1. SOBRECARGA DE FUNCIONES:
 * - Múltiples funciones con el MISMO NOMBRE
 * - Deben tener diferentes parámetros (tipo o cantidad)
 * - El compilador elige la versión correcta automáticamente
 * - NO se puede sobrecargar solo cambiando el tipo de retorno
 *
 * Ejemplo válido:
 * void funcion(int x);
 * void funcion(double x);
 * void funcion(int x, int y);
 *
 * Ejemplo inválido:
 * int funcion(int x);
 * double funcion(int x);  // ERROR: mismos parámetros
 *
 * 2. PASO POR VALOR:
 * - Se crea una COPIA de la variable
 * - Los cambios NO afectan el original
 * - Usa más memoria
 * - Útil cuando no quieres modificar el original
 *
 * 3. PASO POR REFERENCIA (&):
 * - Trabaja con la variable ORIGINAL
 * - Los cambios SÍ afectan el original
 * - Más eficiente (no copia)
 * - Útil para modificar variables o evitar copias de objetos grandes
 *
 * Ejemplo:
 * void funcion(int x);    // Paso por valor
 * void funcion(int &x);   // Paso por referencia
 *
 * 4. PARÁMETROS POR DEFECTO:
 * - Valores predefinidos si no se especifican
 * - Se definen en el PROTOTIPO, no en la definición
 * - Deben ser los ÚLTIMOS parámetros
 *
 * Correcto:
 * void funcion(int a, int b = 10, int c = 20);
 *
 * Incorrecto:
 * void funcion(int a = 10, int b);  // ERROR: no puede venir después de uno sin defecto
 *
 * 5. FUNCIONES INLINE:
 * - Sugerencia al compilador para "expandir" la función en línea
 * - Evita la sobrecarga de llamadas a función
 * - Útil para funciones PEQUEÑAS y llamadas frecuentemente
 * - El compilador puede ignorar la sugerencia si la función es compleja
 *
 * CUÁNDO USAR PASO POR REFERENCIA:
 * ✓ Cuando quieres modificar la variable original
 * ✓ Para evitar copiar objetos grandes (más eficiente)
 * ✓ Cuando una función necesita "retornar" múltiples valores
 *
 * CUÁNDO USAR PASO POR VALOR:
 * ✓ Para tipos simples (int, double, char)
 * ✓ Cuando NO quieres modificar el original
 * ✓ Cuando la función solo necesita leer el valor
 */
