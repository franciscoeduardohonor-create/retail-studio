/**
 * @file epsilon_maquina.cpp
 * @brief Cálculo del epsilon de máquina para diferentes tipos de datos
 *
 * El epsilon de máquina es el número positivo más pequeño ε tal que 1.0 + ε > 1.0
 * Este valor determina la precisión de los cálculos en punto flotante.
 *
 * Conceptos clave:
 * - Precisión finita de números en punto flotante
 * - Diferencias entre float, double y long double
 * - Límites de representación numérica
 */

#include <iostream>
#include <iomanip>
#include <limits>
#include <cmath>

using namespace std;

/**
 * @brief Calcula el epsilon de máquina mediante un algoritmo iterativo
 *
 * Algoritmo:
 * 1. Comenzamos con epsilon = 1.0
 * 2. Dividimos epsilon por 2 iterativamente
 * 3. Verificamos si 1.0 + epsilon/2 sigue siendo diferente de 1.0
 * 4. Cuando ya no es diferente, epsilon es el epsilon de máquina
 *
 * @tparam T Tipo de dato (float, double, long double)
 * @return El epsilon de máquina para el tipo T
 */
template<typename T>
T calcularEpsilonMaquina() {
    T epsilon = 1.0;
    int iteraciones = 0;

    // Mientras 1.0 + epsilon/2 sea diferente de 1.0
    while ((T)(1.0 + epsilon / 2.0) != (T)1.0) {
        epsilon = epsilon / 2.0;
        iteraciones++;
    }

    cout << "Iteraciones necesarias: " << iteraciones << endl;
    return epsilon;
}

/**
 * @brief Demuestra el efecto del epsilon con ejemplos prácticos
 *
 * @tparam T Tipo de dato a demostrar
 */
template<typename T>
void demostrarEpsilon() {
    T epsilon = calcularEpsilonMaquina<T>();

    // Pruebas para verificar el epsilon
    T uno_mas_epsilon = 1.0 + epsilon;
    T uno_mas_epsilon_medio = 1.0 + epsilon / 2.0;

    cout << "\nDemostracion:" << endl;
    cout << "1.0 + epsilon = " << fixed << setprecision(20) << uno_mas_epsilon << endl;
    cout << "¿Es diferente de 1.0? " << (uno_mas_epsilon != 1.0 ? "SI" : "NO") << endl;

    cout << "\n1.0 + epsilon/2 = " << uno_mas_epsilon_medio << endl;
    cout << "¿Es diferente de 1.0? " << (uno_mas_epsilon_medio != 1.0 ? "SI" : "NO") << endl;
}

/**
 * @brief Compara el epsilon calculado con el valor de la biblioteca estándar
 *
 * @tparam T Tipo de dato a comparar
 */
template<typename T>
void compararConSTL() {
    cout << "\n" << string(60, '=') << endl;
    cout << "Tipo: " << typeid(T).name() << endl;
    cout << string(60, '=') << endl;

    T epsilon_calculado = calcularEpsilonMaquina<T>();
    T epsilon_stl = numeric_limits<T>::epsilon();

    cout << scientific << setprecision(10);
    cout << "Epsilon calculado:     " << epsilon_calculado << endl;
    cout << "Epsilon de STL:        " << epsilon_stl << endl;
    cout << "Diferencia:            " << abs(epsilon_calculado - epsilon_stl) << endl;

    demostrarEpsilon<T>();
}

/**
 * @brief Muestra información adicional sobre los límites del tipo
 *
 * @tparam T Tipo de dato a analizar
 */
template<typename T>
void mostrarLimites() {
    cout << "\nInformacion adicional:" << endl;
    cout << "Digitos decimales de precision: " << numeric_limits<T>::digits10 << endl;
    cout << "Valor minimo normalizado:       " << numeric_limits<T>::min() << endl;
    cout << "Valor maximo:                   " << numeric_limits<T>::max() << endl;
    cout << "Tiene infinito:                 " << (numeric_limits<T>::has_infinity ? "SI" : "NO") << endl;
    cout << "Tiene NaN:                      " << (numeric_limits<T>::has_quiet_NaN ? "SI" : "NO") << endl;
}

/**
 * @brief Ejemplo de problemas causados por precisión finita
 */
void ejemploProblemasPresicion() {
    cout << "\n" << string(60, '=') << endl;
    cout << "EJEMPLOS DE PROBLEMAS CON PRECISION FINITA" << endl;
    cout << string(60, '=') << endl;

    // Ejemplo 1: Suma repetida de números pequeños
    cout << "\nEjemplo 1: Sumar 0.1 diez veces" << endl;
    float suma_float = 0.0f;
    double suma_double = 0.0;

    for (int i = 0; i < 10; i++) {
        suma_float += 0.1f;
        suma_double += 0.1;
    }

    cout << fixed << setprecision(20);
    cout << "Suma con float:  " << suma_float << endl;
    cout << "Suma con double: " << suma_double << endl;
    cout << "Valor esperado:  1.00000000000000000000" << endl;
    cout << "Error con float:  " << abs(suma_float - 1.0f) << endl;
    cout << "Error con double: " << abs(suma_double - 1.0) << endl;

    // Ejemplo 2: Comparación de números en punto flotante
    cout << "\nEjemplo 2: Comparacion de numeros" << endl;
    double a = 0.1 + 0.2;
    double b = 0.3;

    cout << "a = 0.1 + 0.2 = " << a << endl;
    cout << "b = 0.3       = " << b << endl;
    cout << "¿a == b?        " << (a == b ? "SI" : "NO") << " (¡Problema!)" << endl;
    cout << "Diferencia:     " << abs(a - b) << endl;

    // Forma correcta de comparar
    double epsilon = 1e-10;
    cout << "¿|a - b| < epsilon? " << (abs(a - b) < epsilon ? "SI" : "NO") << " (Correcto)" << endl;
}

/**
 * @brief Función principal - ejecuta todos los ejemplos
 */
int main() {
    cout << "╔════════════════════════════════════════════════════════════╗" << endl;
    cout << "║     EPSILON DE MAQUINA - ANALISIS NUMERICO                 ║" << endl;
    cout << "╚════════════════════════════════════════════════════════════╝" << endl;

    // Analizar float
    compararConSTL<float>();
    mostrarLimites<float>();

    // Analizar double
    compararConSTL<double>();
    mostrarLimites<double>();

    // Analizar long double
    compararConSTL<long double>();
    mostrarLimites<long double>();

    // Ejemplos de problemas
    ejemploProblemasPresicion();

    cout << "\n╔════════════════════════════════════════════════════════════╗" << endl;
    cout << "║ CONCLUSIONES IMPORTANTES:                                  ║" << endl;
    cout << "╠════════════════════════════════════════════════════════════╣" << endl;
    cout << "║ 1. Nunca uses == para comparar numeros en punto flotante  ║" << endl;
    cout << "║ 2. Usa double en lugar de float cuando sea posible        ║" << endl;
    cout << "║ 3. Ten en cuenta el epsilon al diseñar algoritmos         ║" << endl;
    cout << "║ 4. Los errores de redondeo se acumulan                    ║" << endl;
    cout << "╚════════════════════════════════════════════════════════════╝" << endl;

    return 0;
}
