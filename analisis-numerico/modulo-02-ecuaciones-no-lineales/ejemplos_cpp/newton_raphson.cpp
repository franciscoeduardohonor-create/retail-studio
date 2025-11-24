/**
 * @file newton_raphson.cpp
 * @brief Implementación del Método de Newton-Raphson
 *
 * El método de Newton-Raphson es uno de los métodos más eficientes para
 * encontrar raíces de funciones. Usa la derivada de la función para
 * generar una sucesión que converge cuadráticamente a la raíz.
 *
 * Fórmula: x_(n+1) = x_n - f(x_n)/f'(x_n)
 *
 * Características:
 * - Convergencia cuadrática (muy rápida)
 * - Requiere derivada de la función
 * - Necesita buena estimación inicial
 * - Puede diverger si x_0 mal elegido
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
struct ResultadoNewton {
    double raiz;                    // Raíz encontrada
    int iteraciones;                // Número de iteraciones
    double error_estimado;          // Error estimado
    bool convergencia;              // ¿Convergió?
    vector<double> aproximaciones;  // Historial
    vector<double> errores;         // Historial de errores
};

/**
 * @brief Implementa el método de Newton-Raphson
 *
 * @param f Función cuya raíz se busca
 * @param df Derivada de f
 * @param x0 Aproximación inicial
 * @param tolerancia Tolerancia para el error
 * @param max_iter Número máximo de iteraciones
 * @return ResultadoNewton con la solución y diagnósticos
 */
ResultadoNewton newtonRaphson(
    function<double(double)> f,
    function<double(double)> df,
    double x0,
    double tolerancia = 1e-6,
    int max_iter = 100
) {
    ResultadoNewton resultado;
    resultado.convergencia = false;

    cout << "\n┌────────┬──────────────────┬──────────────┬──────────────┬──────────────┐" << endl;
    cout << "│  Iter  │        x_n       │     f(x_n)   │    f'(x_n)   │   |x_n+1-x_n|│" << endl;
    cout << "├────────┼──────────────────┼──────────────┼──────────────┼──────────────┤" << endl;

    double x = x0;
    double x_anterior = x0;

    for (int n = 0; n < max_iter; n++) {
        double fx = f(x);
        double dfx = df(x);

        // Guardar aproximación
        resultado.aproximaciones.push_back(x);

        // Verificar si la derivada es muy pequeña
        if (abs(dfx) < 1e-15) {
            cerr << "\nERROR: Derivada muy pequeña en x = " << x << endl;
            cerr << "f'(x) = " << dfx << endl;
            resultado.iteraciones = n;
            resultado.raiz = x;
            return resultado;
        }

        // Calcular siguiente aproximación
        double x_nuevo = x - fx / dfx;
        double incremento = abs(x_nuevo - x);

        // Mostrar iteración
        cout << "│ " << setw(6) << n
             << " │ " << fixed << setprecision(15) << setw(16) << x
             << " │ " << scientific << setprecision(4) << setw(12) << fx
             << " │ " << setw(12) << dfx
             << " │ " << setw(12) << incremento
             << " │" << endl;

        resultado.errores.push_back(abs(fx));

        // Criterios de parada
        if (abs(fx) < tolerancia || incremento < tolerancia) {
            resultado.convergencia = true;
            resultado.raiz = x_nuevo;
            resultado.iteraciones = n + 1;
            resultado.error_estimado = incremento;
            break;
        }

        x_anterior = x;
        x = x_nuevo;
    }

    cout << "└────────┴──────────────────┴──────────────┴──────────────┴──────────────┘" << endl;

    if (!resultado.convergencia) {
        resultado.raiz = x;
        resultado.iteraciones = max_iter;
        resultado.error_estimado = abs(f(x));
        cerr << "\nADVERTENCIA: No se alcanzó la tolerancia en " << max_iter << " iteraciones" << endl;
    }

    return resultado;
}

/**
 * @brief Ejemplo 1: Encontrar √2 resolviendo x² - 2 = 0
 */
void ejemplo1_raiz_cuadrada() {
    cout << "\n" << string(75, '=') << endl;
    cout << "EJEMPLO 1: ENCONTRAR √2 CON NEWTON-RAPHSON" << endl;
    cout << "Ecuación: f(x) = x² - 2 = 0" << endl;
    cout << "Derivada: f'(x) = 2x" << endl;
    cout << string(75, '=') << endl;

    auto f = [](double x) { return x*x - 2.0; };
    auto df = [](double x) { return 2.0*x; };

    double x0 = 1.5;  // Aproximación inicial

    cout << "\nAproximación inicial: x₀ = " << x0 << endl;

    ResultadoNewton resultado = newtonRaphson(f, df, x0, 1e-15);

    if (resultado.convergencia) {
        cout << "\n✓ CONVERGENCIA EXITOSA" << endl;
        cout << fixed << setprecision(15);
        cout << "Raíz encontrada:     " << resultado.raiz << endl;
        cout << "√2 (referencia):     " << sqrt(2.0) << endl;
        cout << "Error absoluto:      " << abs(resultado.raiz - sqrt(2.0)) << endl;
        cout << "Iteraciones:         " << resultado.iteraciones << endl;
        cout << scientific;
        cout << "Error estimado:      " << resultado.error_estimado << endl;

        cout << "\nNota: Newton-Raphson encontró √2 con " << resultado.iteraciones
             << " iteraciones." << endl;
        cout << "Compare esto con ~40 iteraciones que necesitaría bisección." << endl;
    }
}

/**
 * @brief Ejemplo 2: Resolver x³ - x - 2 = 0
 */
void ejemplo2_polinomio_cubico() {
    cout << "\n" << string(75, '=') << endl;
    cout << "EJEMPLO 2: ECUACIÓN CÚBICA" << endl;
    cout << "Ecuación: f(x) = x³ - x - 2 = 0" << endl;
    cout << "Derivada: f'(x) = 3x² - 1" << endl;
    cout << string(75, '=') << endl;

    auto f = [](double x) { return x*x*x - x - 2.0; };
    auto df = [](double x) { return 3.0*x*x - 1.0; };

    double x0 = 1.5;

    cout << "\nAproximación inicial: x₀ = " << x0 << endl;

    ResultadoNewton resultado = newtonRaphson(f, df, x0, 1e-12);

    if (resultado.convergencia) {
        double x = resultado.raiz;
        cout << "\n✓ Raíz encontrada: x = " << fixed << setprecision(15) << x << endl;
        cout << "Verificación: f(" << x << ") = " << scientific << setprecision(6)
             << f(x) << endl;
    }
}

/**
 * @brief Ejemplo 3: Resolver cos(x) = x (ecuación trascendental)
 */
void ejemplo3_trascendental() {
    cout << "\n" << string(75, '=') << endl;
    cout << "EJEMPLO 3: ECUACIÓN TRASCENDENTAL" << endl;
    cout << "Ecuación: f(x) = cos(x) - x = 0" << endl;
    cout << "Derivada: f'(x) = -sin(x) - 1" << endl;
    cout << string(75, '=') << endl;

    auto f = [](double x) { return cos(x) - x; };
    auto df = [](double x) { return -sin(x) - 1.0; };

    double x0 = 0.5;

    cout << "\nAproximación inicial: x₀ = " << x0 << endl;

    ResultadoNewton resultado = newtonRaphson(f, df, x0, 1e-12);

    if (resultado.convergencia) {
        double x = resultado.raiz;
        cout << "\n✓ Solución: x = " << fixed << setprecision(15) << x << endl;
        cout << "Verificación:" << endl;
        cout << "  cos(" << x << ") = " << cos(x) << endl;
        cout << "  Diferencia |cos(x) - x| = " << scientific << abs(cos(x) - x) << endl;
    }
}

/**
 * @brief Ejemplo 4: Dependencia de la aproximación inicial
 */
void ejemplo4_sensibilidad_x0() {
    cout << "\n" << string(75, '=') << endl;
    cout << "EJEMPLO 4: SENSIBILIDAD A LA APROXIMACIÓN INICIAL" << endl;
    cout << "Ecuación: f(x) = x³ - 2x + 2 = 0" << endl;
    cout << string(75, '=') << endl;

    auto f = [](double x) { return x*x*x - 2.0*x + 2.0; };
    auto df = [](double x) { return 3.0*x*x - 2.0; };

    vector<double> valores_x0 = {-2.0, -1.5, -1.0, 0.0, 1.0};

    cout << "\nProbando diferentes valores iniciales:" << endl;

    for (double x0 : valores_x0) {
        cout << "\n--- Con x₀ = " << x0 << " ---" << endl;
        ResultadoNewton resultado = newtonRaphson(f, df, x0, 1e-8, 20);

        if (resultado.convergencia) {
            cout << "✓ Convergió a: x = " << fixed << setprecision(10)
                 << resultado.raiz << " en " << resultado.iteraciones << " iteraciones" << endl;
        } else {
            cout << "✗ No convergió" << endl;
        }
    }
}

/**
 * @brief Ejemplo 5: Problema con derivada cercana a cero
 */
void ejemplo5_derivada_pequeña() {
    cout << "\n" << string(75, '=') << endl;
    cout << "EJEMPLO 5: PROBLEMAS CUANDO f'(x) ≈ 0" << endl;
    cout << "Ecuación: f(x) = x³ - 2x² + 4x/3 - 8/27 = 0" << endl;
    cout << string(75, '=') << endl;

    // Esta función tiene una raíz triple en x = 2/3
    auto f = [](double x) {
        return x*x*x - 2.0*x*x + 4.0*x/3.0 - 8.0/27.0;
    };
    auto df = [](double x) {
        return 3.0*x*x - 4.0*x + 4.0/3.0;
    };

    cout << "\nNota: Esta función tiene una raíz múltiple en x = 2/3" << endl;
    cout << "Las raíces múltiples causan f'(x) = 0 en la raíz." << endl;
    cout << "\nProblema: Newton-Raphson tiene convergencia lineal (no cuadrática)" << endl;
    cout << "para raíces múltiples.\n" << endl;

    ResultadoNewton resultado = newtonRaphson(f, df, 1.0, 1e-8, 30);

    if (resultado.convergencia) {
        cout << "\n✓ Raíz encontrada: x = " << fixed << setprecision(10)
             << resultado.raiz << endl;
        cout << "Valor exacto: x = " << (2.0/3.0) << endl;
        cout << "Iteraciones necesarias: " << resultado.iteraciones << endl;
        cout << "(Más de lo usual debido a la multiplicidad)" << endl;
    }
}

/**
 * @brief Análisis de convergencia cuadrática
 */
void analisis_convergencia() {
    cout << "\n" << string(75, '=') << endl;
    cout << "ANÁLISIS DE CONVERGENCIA CUADRÁTICA" << endl;
    cout << string(75, '=') << endl;

    auto f = [](double x) { return x*x - 2.0; };
    auto df = [](double x) { return 2.0*x; };

    ResultadoNewton resultado = newtonRaphson(f, df, 1.5, 1e-15, 10);

    double valor_exacto = sqrt(2.0);

    cout << "\nVerificación de convergencia cuadrática:" << endl;
    cout << "En convergencia cuadrática: error_(n+1) ≈ C × error_n²" << endl;

    if (resultado.aproximaciones.size() > 2) {
        cout << "\n┌────────┬──────────────────┬──────────────┬───────────────┐" << endl;
        cout << "│  Iter  │   Aproximación   │   Error_n    │ Error_n+1/Error_n² │" << endl;
        cout << "├────────┼──────────────────┼──────────────┼───────────────┤" << endl;

        for (size_t i = 0; i < resultado.aproximaciones.size() - 1; i++) {
            double aprox = resultado.aproximaciones[i];
            double error_n = abs(aprox - valor_exacto);
            double error_n1 = abs(resultado.aproximaciones[i+1] - valor_exacto);

            double ratio = 0.0;
            if (error_n > 1e-15) {  // Evitar división por cero
                ratio = error_n1 / (error_n * error_n);
            }

            cout << "│ " << setw(6) << i
                 << " │ " << fixed << setprecision(15) << setw(16) << aprox
                 << " │ " << scientific << setprecision(4) << setw(12) << error_n
                 << " │ " << setw(13) << ratio
                 << " │" << endl;
        }

        cout << "└────────┴──────────────────┴──────────────┴───────────────┘" << endl;
        cout << "\nNota: El ratio Error_(n+1)/Error_n² debería ser aproximadamente constante." << endl;
        cout << "Esto confirma la convergencia cuadrática." << endl;
    }
}

/**
 * @brief Derivación geométrica del método
 */
void interpretacion_geometrica() {
    cout << "\n" << string(75, '=') << endl;
    cout << "INTERPRETACIÓN GEOMÉTRICA DEL MÉTODO DE NEWTON-RAPHSON" << endl;
    cout << string(75, '=') << endl;

    cout << "\nEl método de Newton-Raphson puede entenderse geométricamente:" << endl;
    cout << "\n1. En el punto (xₙ, f(xₙ)), trazamos la tangente a la curva" << endl;
    cout << "2. La ecuación de la tangente es:" << endl;
    cout << "   y - f(xₙ) = f'(xₙ)(x - xₙ)" << endl;
    cout << "\n3. La tangente cruza el eje x cuando y = 0:" << endl;
    cout << "   0 - f(xₙ) = f'(xₙ)(x - xₙ)" << endl;
    cout << "   -f(xₙ) = f'(xₙ)(x - xₙ)" << endl;
    cout << "   x = xₙ - f(xₙ)/f'(xₙ)" << endl;
    cout << "\n4. Este punto x es nuestra siguiente aproximación xₙ₊₁" << endl;

    cout << "\n┌─────────────────────────────────────────────────────────────────────┐" << endl;
    cout << "│                     VISUALIZACIÓN ASCII                             │" << endl;
    cout << "├─────────────────────────────────────────────────────────────────────┤" << endl;
    cout << "│                                                                     │" << endl;
    cout << "│        y                                                            │" << endl;
    cout << "│        │       f(x)                                                 │" << endl;
    cout << "│        │      /                                                     │" << endl;
    cout << "│        │     /                                                      │" << endl;
    cout << "│        │    /  ● (x₀, f(x₀))                                       │" << endl;
    cout << "│        │   /   │\\                                                   │" << endl;
    cout << "│        │  /    │ \\  Tangente                                       │" << endl;
    cout << "│        │ /     │  \\                                                │" << endl;
    cout << "│        │/      │   \\                                               │" << endl;
    cout << "│ ───────●───────┼────●────────────── x                              │" << endl;
    cout << "│      x*       x₁   x₀                                               │" << endl;
    cout << "│                                                                     │" << endl;
    cout << "│  x* = raíz verdadera                                                │" << endl;
    cout << "│  x₀ = aproximación inicial                                          │" << endl;
    cout << "│  x₁ = siguiente aproximación (donde tangente cruza eje x)           │" << endl;
    cout << "└─────────────────────────────────────────────────────────────────────┘" << endl;
}

/**
 * @brief Función principal
 */
int main() {
    cout << "╔═══════════════════════════════════════════════════════════════════════╗" << endl;
    cout << "║           MÉTODO DE NEWTON-RAPHSON - ANÁLISIS NUMÉRICO                ║" << endl;
    cout << "╚═══════════════════════════════════════════════════════════════════════╝" << endl;

    interpretacion_geometrica();
    ejemplo1_raiz_cuadrada();
    ejemplo2_polinomio_cubico();
    ejemplo3_trascendental();
    ejemplo4_sensibilidad_x0();
    ejemplo5_derivada_pequeña();
    analisis_convergencia();

    cout << "\n╔═══════════════════════════════════════════════════════════════════════╗" << endl;
    cout << "║ PRINCIPIOS CLAVE DEL MÉTODO DE NEWTON-RAPHSON:                       ║" << endl;
    cout << "╠═══════════════════════════════════════════════════════════════════════╣" << endl;
    cout << "║ 1. Fórmula: x_(n+1) = x_n - f(x_n)/f'(x_n)                           ║" << endl;
    cout << "║ 2. Convergencia cuadrática cerca de raíces simples                   ║" << endl;
    cout << "║ 3. Requiere buena aproximación inicial                               ║" << endl;
    cout << "║ 4. Problemas si f'(x) ≈ 0                                            ║" << endl;
    cout << "║ 5. Puede diverger con x₀ mal elegido                                 ║" << endl;
    cout << "║ 6. Muy eficiente cuando converge (típicamente 4-6 iteraciones)       ║" << endl;
    cout << "║ 7. Raíces múltiples causan convergencia lineal                       ║" << endl;
    cout << "╚═══════════════════════════════════════════════════════════════════════╝" << endl;

    return 0;
}
