/**
 * @file biseccion.cpp
 * @brief Implementación del Método de Bisección para encontrar raíces
 *
 * El método de bisección es un algoritmo robusto basado en el Teorema del Valor
 * Intermedio: si f es continua en [a,b] y f(a)·f(b) < 0, entonces existe al menos
 * una raíz en el intervalo.
 *
 * Características:
 * - Convergencia garantizada (si hay cambio de signo)
 * - Convergencia lineal (lenta)
 * - No requiere derivadas
 * - Error predecible: |error| ≤ (b-a)/2^n
 */

#include <iostream>
#include <iomanip>
#include <cmath>
#include <functional>
#include <vector>
#include <string>

using namespace std;

/**
 * @brief Estructura para almacenar el resultado del método
 */
struct ResultadoBiseccion {
    double raiz;           // Raíz encontrada
    int iteraciones;       // Número de iteraciones realizadas
    double error;          // Error estimado
    bool convergencia;     // ¿Convergió?
    vector<double> aproximaciones;  // Historial de aproximaciones
};

/**
 * @brief Implementa el método de bisección
 *
 * @param f Función cuya raíz se busca
 * @param a Extremo izquierdo del intervalo
 * @param b Extremo derecho del intervalo
 * @param tolerancia Tolerancia para el error
 * @param max_iter Número máximo de iteraciones
 * @return ResultadoBiseccion con la solución y diagnósticos
 */
ResultadoBiseccion biseccion(
    function<double(double)> f,
    double a,
    double b,
    double tolerancia = 1e-6,
    int max_iter = 100
) {
    ResultadoBiseccion resultado;
    resultado.convergencia = false;

    double fa = f(a);
    double fb = f(b);

    // Verificar que hay cambio de signo
    if (fa * fb > 0) {
        cerr << "ERROR: No hay cambio de signo en el intervalo [" << a << ", " << b << "]" << endl;
        cerr << "f(" << a << ") = " << fa << endl;
        cerr << "f(" << b << ") = " << fb << endl;
        resultado.iteraciones = 0;
        resultado.raiz = NAN;
        return resultado;
    }

    cout << "\n┌────────┬─────────────┬─────────────┬─────────────┬─────────────┬─────────────┐" << endl;
    cout << "│  Iter  │      a      │      b      │      c      │     f(c)    │  |b - a|   │" << endl;
    cout << "├────────┼─────────────┼─────────────┼─────────────┼─────────────┼─────────────┤" << endl;

    double c, fc;
    int n = 0;

    while (n < max_iter) {
        // Calcular punto medio
        c = (a + b) / 2.0;
        fc = f(c);

        double ancho = abs(b - a);

        // Guardar aproximación
        resultado.aproximaciones.push_back(c);

        // Mostrar iteración
        cout << "│ " << setw(6) << n
             << " │ " << fixed << setprecision(8) << setw(11) << a
             << " │ " << setw(11) << b
             << " │ " << setw(11) << c
             << " │ " << scientific << setprecision(4) << setw(11) << fc
             << " │ " << setw(11) << ancho
             << " │" << endl;

        // Criterios de parada
        if (abs(fc) < tolerancia || ancho < tolerancia) {
            resultado.convergencia = true;
            resultado.raiz = c;
            resultado.iteraciones = n + 1;
            resultado.error = ancho / 2.0;
            break;
        }

        // Actualizar intervalo
        if (fa * fc < 0) {
            b = c;
            fb = fc;
        } else {
            a = c;
            fa = fc;
        }

        n++;
    }

    cout << "└────────┴─────────────┴─────────────┴─────────────┴─────────────┴─────────────┘" << endl;

    if (!resultado.convergencia) {
        resultado.raiz = c;
        resultado.iteraciones = max_iter;
        resultado.error = abs(b - a) / 2.0;
        cerr << "\nADVERTENCIA: No se alcanzó la tolerancia en " << max_iter << " iteraciones" << endl;
    }

    return resultado;
}

/**
 * @brief Calcula el número teórico de iteraciones necesarias
 *
 * @param a Extremo izquierdo
 * @param b Extremo derecho
 * @param tolerancia Tolerancia deseada
 * @return Número de iteraciones necesarias
 */
int iteraciones_necesarias(double a, double b, double tolerancia) {
    // n >= log2((b-a)/tolerancia)
    return static_cast<int>(ceil(log2((b - a) / tolerancia)));
}

/**
 * @brief Ejemplo 1: Encontrar √2 resolviendo x² - 2 = 0
 */
void ejemplo1_raiz_cuadrada() {
    cout << "\n" << string(75, '=') << endl;
    cout << "EJEMPLO 1: ENCONTRAR √2" << endl;
    cout << "Ecuación: x² - 2 = 0" << endl;
    cout << string(75, '=') << endl;

    // Función f(x) = x² - 2
    auto f = [](double x) { return x*x - 2.0; };

    double a = 1.0;
    double b = 2.0;
    double tolerancia = 1e-6;

    cout << "\nIntervalo inicial: [" << a << ", " << b << "]" << endl;
    cout << "Tolerancia: " << tolerancia << endl;

    int iter_teoricas = iteraciones_necesarias(a, b, tolerancia);
    cout << "Iteraciones teóricas necesarias: " << iter_teoricas << endl;

    ResultadoBiseccion resultado = biseccion(f, a, b, tolerancia);

    if (resultado.convergencia) {
        cout << "\n✓ CONVERGENCIA EXITOSA" << endl;
        cout << fixed << setprecision(15);
        cout << "Raíz encontrada:     " << resultado.raiz << endl;
        cout << "√2 (referencia):     " << sqrt(2.0) << endl;
        cout << "Error absoluto:      " << abs(resultado.raiz - sqrt(2.0)) << endl;
        cout << "Iteraciones usadas:  " << resultado.iteraciones << endl;
        cout << "Error estimado:      " << resultado.error << endl;
    }
}

/**
 * @brief Ejemplo 2: Resolver x³ - x - 2 = 0
 */
void ejemplo2_polinomio_cubico() {
    cout << "\n" << string(75, '=') << endl;
    cout << "EJEMPLO 2: ECUACIÓN CÚBICA" << endl;
    cout << "Ecuación: x³ - x - 2 = 0" << endl;
    cout << string(75, '=') << endl;

    // Función f(x) = x³ - x - 2
    auto f = [](double x) { return x*x*x - x - 2.0; };

    // Localizar la raíz explorando
    cout << "\nLocalizando raíces..." << endl;
    cout << "f(0) = " << f(0) << endl;
    cout << "f(1) = " << f(1) << endl;
    cout << "f(2) = " << f(2) << endl;
    cout << "\nHay cambio de signo en [1, 2]" << endl;

    ResultadoBiseccion resultado = biseccion(f, 1.0, 2.0, 1e-10);

    if (resultado.convergencia) {
        double x = resultado.raiz;
        cout << "\n✓ Raíz encontrada: x = " << fixed << setprecision(15) << x << endl;
        cout << "Verificación: f(" << x << ") = " << scientific << setprecision(6)
             << f(x) << endl;
    }
}

/**
 * @brief Ejemplo 3: Resolver cos(x) = x
 * Equivalente a cos(x) - x = 0
 */
void ejemplo3_trascendental() {
    cout << "\n" << string(75, '=') << endl;
    cout << "EJEMPLO 3: ECUACIÓN TRASCENDENTAL" << endl;
    cout << "Ecuación: cos(x) - x = 0" << endl;
    cout << string(75, '=') << endl;

    // Función f(x) = cos(x) - x
    auto f = [](double x) { return cos(x) - x; };

    cout << "\nBuscando intervalo con cambio de signo..." << endl;
    for (double x = 0; x <= 1.5; x += 0.25) {
        cout << "f(" << fixed << setprecision(2) << x << ") = "
             << setprecision(6) << f(x) << endl;
    }
    cout << "\nHay cambio de signo en [0, 1]" << endl;

    ResultadoBiseccion resultado = biseccion(f, 0.0, 1.0, 1e-8);

    if (resultado.convergencia) {
        double x = resultado.raiz;
        cout << "\n✓ Solución: x = " << fixed << setprecision(15) << x << endl;
        cout << "Verificación:" << endl;
        cout << "  cos(" << x << ") = " << cos(x) << endl;
        cout << "  Diferencia |cos(x) - x| = " << scientific << abs(cos(x) - x) << endl;
    }
}

/**
 * @brief Ejemplo 4: Múltiples raíces
 */
void ejemplo4_multiples_raices() {
    cout << "\n" << string(75, '=') << endl;
    cout << "EJEMPLO 4: ENCONTRAR MÚLTIPLES RAÍCES" << endl;
    cout << "Ecuación: x³ - 7x + 6 = 0" << endl;
    cout << string(75, '=') << endl;

    // Función f(x) = x³ - 7x + 6
    auto f = [](double x) { return x*x*x - 7*x + 6; };

    // Esta ecuación tiene tres raíces: x = -3, 1, 2

    cout << "\nBuscando raíces en diferentes intervalos..." << endl;

    vector<pair<double, double>> intervalos = {
        {-4.0, -2.0},
        {0.5, 1.5},
        {1.5, 2.5}
    };

    vector<double> raices;

    for (size_t i = 0; i < intervalos.size(); i++) {
        double a = intervalos[i].first;
        double b = intervalos[i].second;

        cout << "\n--- Intervalo " << (i+1) << ": [" << a << ", " << b << "] ---" << endl;

        if (f(a) * f(b) < 0) {
            ResultadoBiseccion resultado = biseccion(f, a, b, 1e-8, 50);
            if (resultado.convergencia) {
                raices.push_back(resultado.raiz);
            }
        } else {
            cout << "No hay cambio de signo en este intervalo." << endl;
        }
    }

    cout << "\n" << string(75, '=') << endl;
    cout << "RESUMEN DE RAÍCES ENCONTRADAS" << endl;
    cout << string(75, '=') << endl;

    for (size_t i = 0; i < raices.size(); i++) {
        double x = raices[i];
        cout << fixed << setprecision(10);
        cout << "Raíz " << (i+1) << ": x = " << x << "  (f(x) = "
             << scientific << setprecision(2) << f(x) << ")" << endl;
    }

    cout << "\nRaíces exactas: x = -3, 1, 2" << endl;
}

/**
 * @brief Análisis de convergencia del método
 */
void analisis_convergencia() {
    cout << "\n" << string(75, '=') << endl;
    cout << "ANÁLISIS DE CONVERGENCIA" << endl;
    cout << string(75, '=') << endl;

    auto f = [](double x) { return x*x - 2.0; };
    ResultadoBiseccion resultado = biseccion(f, 1.0, 2.0, 1e-10, 50);

    double valor_exacto = sqrt(2.0);

    cout << "\n┌────────┬──────────────────┬──────────────┐" << endl;
    cout << "│  Iter  │  Aproximación    │  Error Abs   │" << endl;
    cout << "├────────┼──────────────────┼──────────────┤" << endl;

    for (size_t i = 0; i < resultado.aproximaciones.size(); i++) {
        double aprox = resultado.aproximaciones[i];
        double error = abs(aprox - valor_exacto);

        cout << "│ " << setw(6) << i
             << " │ " << fixed << setprecision(15) << setw(16) << aprox
             << " │ " << scientific << setprecision(4) << setw(12) << error
             << " │" << endl;
    }

    cout << "└────────┴──────────────────┴──────────────┘" << endl;

    // Verificar convergencia lineal
    cout << "\nVerificación de convergencia lineal:" << endl;
    cout << "En cada iteración, el error debería reducirse aproximadamente a la mitad." << endl;

    if (resultado.aproximaciones.size() > 2) {
        cout << "\n┌────────┬──────────────┬───────────────┐" << endl;
        cout << "│  Iter  │  Error_n     │  Error_n+1/Error_n │" << endl;
        cout << "├────────┼──────────────┼───────────────┤" << endl;

        for (size_t i = 0; i < resultado.aproximaciones.size() - 1; i++) {
            double error_n = abs(resultado.aproximaciones[i] - valor_exacto);
            double error_n1 = abs(resultado.aproximaciones[i+1] - valor_exacto);
            double ratio = error_n1 / error_n;

            cout << "│ " << setw(6) << i
                 << " │ " << scientific << setprecision(4) << setw(12) << error_n
                 << " │ " << fixed << setprecision(6) << setw(15) << ratio
                 << " │" << endl;
        }

        cout << "└────────┴──────────────┴───────────────┘" << endl;
        cout << "\nNota: El ratio debería ser aproximadamente 0.5 (convergencia lineal)" << endl;
    }
}

/**
 * @brief Función principal
 */
int main() {
    cout << "╔═══════════════════════════════════════════════════════════════════════╗" << endl;
    cout << "║             MÉTODO DE BISECCIÓN - ANÁLISIS NUMÉRICO                   ║" << endl;
    cout << "╚═══════════════════════════════════════════════════════════════════════╝" << endl;

    ejemplo1_raiz_cuadrada();
    ejemplo2_polinomio_cubico();
    ejemplo3_trascendental();
    ejemplo4_multiples_raices();
    analisis_convergencia();

    cout << "\n╔═══════════════════════════════════════════════════════════════════════╗" << endl;
    cout << "║ PRINCIPIOS CLAVE DEL MÉTODO DE BISECCIÓN:                            ║" << endl;
    cout << "╠═══════════════════════════════════════════════════════════════════════╣" << endl;
    cout << "║ 1. Requiere intervalo con cambio de signo: f(a)·f(b) < 0             ║" << endl;
    cout << "║ 2. Convergencia garantizada (robustez)                               ║" << endl;
    cout << "║ 3. Convergencia lineal (error se divide por 2 cada iteración)        ║" << endl;
    cout << "║ 4. No requiere derivadas                                             ║" << endl;
    cout << "║ 5. Error predecible: |error| ≤ (b-a)/2^n                             ║" << endl;
    cout << "║ 6. Útil para localizar raíces, luego refinar con método más rápido   ║" << endl;
    cout << "╚═══════════════════════════════════════════════════════════════════════╝" << endl;

    return 0;
}
