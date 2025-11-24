/**
 * @file metodos_integracion.cpp
 * @brief Implementación de métodos de integración numérica
 *
 * Este programa implementa los métodos principales de integración numérica:
 * - Regla del Trapecio
 * - Regla de Simpson 1/3
 * - Cuadratura de Gauss
 * - Integración adaptativa
 *
 * Incluye análisis de error y comparación de métodos.
 */

#include <iostream>
#include <iomanip>
#include <cmath>
#include <functional>
#include <vector>
#include <string>

using namespace std;

/**
 * @brief Regla del Trapecio simple
 *
 * Aproxima ∫ᵇₐ f(x) dx mediante un trapecio
 *
 * @param f Función a integrar
 * @param a Límite inferior
 * @param b Límite superior
 * @return Aproximación de la integral
 */
double trapecio_simple(function<double(double)> f, double a, double b) {
    return (b - a) * (f(a) + f(b)) / 2.0;
}

/**
 * @brief Regla del Trapecio compuesta
 *
 * Divide el intervalo en n subintervalos y aplica trapecio en cada uno
 *
 * Fórmula: h/2 · [f(x₀) + 2f(x₁) + 2f(x₂) + ... + 2f(xₙ₋₁) + f(xₙ)]
 * donde h = (b-a)/n
 *
 * @param f Función a integrar
 * @param a Límite inferior
 * @param b Límite superior
 * @param n Número de subintervalos
 * @return Aproximación de la integral
 */
double trapecio_compuesta(function<double(double)> f, double a, double b, int n) {
    double h = (b - a) / n;
    double suma = f(a) + f(b);  // Extremos con coeficiente 1

    // Puntos interiores con coeficiente 2
    for (int i = 1; i < n; i++) {
        double x = a + i * h;
        suma += 2.0 * f(x);
    }

    return (h / 2.0) * suma;
}

/**
 * @brief Regla de Simpson 1/3 simple
 *
 * Aproxima ∫ᵇₐ f(x) dx usando una parábola
 * Requiere que b-a se divida en 2 partes iguales
 *
 * @param f Función a integrar
 * @param a Límite inferior
 * @param b Límite superior
 * @return Aproximación de la integral
 */
double simpson_simple(function<double(double)> f, double a, double b) {
    double c = (a + b) / 2.0;
    return (b - a) * (f(a) + 4.0 * f(c) + f(b)) / 6.0;
}

/**
 * @brief Regla de Simpson 1/3 compuesta
 *
 * Aplica Simpson en n subintervalos (n debe ser par)
 *
 * Fórmula: h/3 · [f(x₀) + 4f(x₁) + 2f(x₂) + 4f(x₃) + ... + f(xₙ)]
 * Patrón de coeficientes: 1, 4, 2, 4, 2, ..., 4, 1
 *
 * @param f Función a integrar
 * @param a Límite inferior
 * @param b Límite superior
 * @param n Número de subintervalos (debe ser par)
 * @return Aproximación de la integral
 */
double simpson_compuesta(function<double(double)> f, double a, double b, int n) {
    if (n % 2 != 0) {
        cerr << "ERROR: n debe ser par para Simpson compuesta" << endl;
        n++; // Hacer par
    }

    double h = (b - a) / n;
    double suma = f(a) + f(b);  // Extremos con coeficiente 1

    // Puntos impares: coeficiente 4
    for (int i = 1; i < n; i += 2) {
        double x = a + i * h;
        suma += 4.0 * f(x);
    }

    // Puntos pares (excepto extremos): coeficiente 2
    for (int i = 2; i < n; i += 2) {
        double x = a + i * h;
        suma += 2.0 * f(x);
    }

    return (h / 3.0) * suma;
}

/**
 * @brief Cuadratura de Gauss con 2 puntos
 *
 * Integra en [-1, 1] usando dos puntos óptimos
 * Exacto para polinomios de grado ≤ 3
 *
 * @param f Función a integrar
 * @param a Límite inferior
 * @param b Límite superior
 * @return Aproximación de la integral
 */
double gauss2(function<double(double)> f, double a, double b) {
    // Puntos de Gauss en [-1, 1]
    double t1 = -1.0 / sqrt(3.0);  // ≈ -0.577350
    double t2 =  1.0 / sqrt(3.0);  // ≈  0.577350

    // Pesos (ambos iguales a 1 para 2 puntos)
    double w1 = 1.0;
    double w2 = 1.0;

    // Transformación al intervalo [a, b]
    auto g = [&](double t) {
        double x = ((b - a) * t + (b + a)) / 2.0;
        return f(x);
    };

    double integral = w1 * g(t1) + w2 * g(t2);

    return (b - a) / 2.0 * integral;
}

/**
 * @brief Cuadratura de Gauss con 3 puntos
 *
 * Exacto para polinomios de grado ≤ 5
 *
 * @param f Función a integrar
 * @param a Límite inferior
 * @param b Límite superior
 * @return Aproximación de la integral
 */
double gauss3(function<double(double)> f, double a, double b) {
    // Puntos de Gauss en [-1, 1]
    double t1 = -sqrt(3.0 / 5.0);  // ≈ -0.774597
    double t2 =  0.0;
    double t3 =  sqrt(3.0 / 5.0);  // ≈  0.774597

    // Pesos
    double w1 = 5.0 / 9.0;  // ≈ 0.555556
    double w2 = 8.0 / 9.0;  // ≈ 0.888889
    double w3 = 5.0 / 9.0;

    // Transformación al intervalo [a, b]
    auto g = [&](double t) {
        double x = ((b - a) * t + (b + a)) / 2.0;
        return f(x);
    };

    double integral = w1 * g(t1) + w2 * g(t2) + w3 * g(t3);

    return (b - a) / 2.0 * integral;
}

/**
 * @brief Integración adaptativa de Simpson
 *
 * Ajusta automáticamente el paso según la suavidad de la función
 *
 * @param f Función a integrar
 * @param a Límite inferior
 * @param b Límite superior
 * @param tol Tolerancia deseada
 * @param nivel_max Máximo nivel de recursión
 * @return Aproximación de la integral
 */
double simpson_adaptativa_recursiva(function<double(double)> f, double a, double b,
                                    double tol, int nivel_max, int nivel_actual = 0) {
    double c = (a + b) / 2.0;

    // Calcular Simpson en todo el intervalo
    double S_ab = simpson_simple(f, a, b);

    // Calcular Simpson en las dos mitades
    double S_ac = simpson_simple(f, a, c);
    double S_cb = simpson_simple(f, c, b);
    double S_acb = S_ac + S_cb;

    // Estimación del error
    double error = abs(S_acb - S_ab) / 15.0;  // Factor de corrección de Simpson

    if (error < tol || nivel_actual >= nivel_max) {
        // Aceptar el resultado mejorado
        return S_acb + (S_acb - S_ab) / 15.0;
    } else {
        // Subdividir recursivamente
        double izq = simpson_adaptativa_recursiva(f, a, c, tol / 2.0, nivel_max, nivel_actual + 1);
        double der = simpson_adaptativa_recursiva(f, c, b, tol / 2.0, nivel_max, nivel_actual + 1);
        return izq + der;
    }
}

double simpson_adaptativa(function<double(double)> f, double a, double b, double tol = 1e-6) {
    return simpson_adaptativa_recursiva(f, a, b, tol, 50);
}

/**
 * @brief Ejemplo 1: Integrar x² en [0, 1]
 * Valor exacto: 1/3
 */
void ejemplo1_polinomio() {
    cout << "\n" << string(75, '=') << endl;
    cout << "EJEMPLO 1: INTEGRAL DE x² EN [0, 1]" << endl;
    cout << "Valor exacto: 1/3 = 0.333333..." << endl;
    cout << string(75, '=') << endl;

    auto f = [](double x) { return x * x; };
    double a = 0.0, b = 1.0;
    double exacto = 1.0 / 3.0;

    cout << "\n┌──────────────────────┬──────────────────┬──────────────┬────────────┐" << endl;
    cout << "│       Método         │    Resultado     │     Error    │ Evaluaciones│" << endl;
    cout << "├──────────────────────┼──────────────────┼──────────────┼────────────┤" << endl;

    // Trapecio con diferentes n
    for (int n : {4, 8, 16, 32}) {
        double resultado = trapecio_compuesta(f, a, b, n);
        double error = abs(resultado - exacto);
        cout << "│ Trapecio (n=" << setw(2) << n << ")     │ "
             << fixed << setprecision(15) << setw(16) << resultado << " │ "
             << scientific << setprecision(4) << setw(12) << error << " │ "
             << setw(10) << (n + 1) << " │" << endl;
    }

    // Simpson con diferentes n
    for (int n : {4, 8, 16, 32}) {
        double resultado = simpson_compuesta(f, a, b, n);
        double error = abs(resultado - exacto);
        cout << "│ Simpson (n=" << setw(2) << n << ")      │ "
             << fixed << setprecision(15) << setw(16) << resultado << " │ "
             << scientific << setprecision(4) << setw(12) << error << " │ "
             << setw(10) << (n + 1) << " │" << endl;
    }

    // Gauss
    double gauss2_resultado = gauss2(f, a, b);
    double gauss3_resultado = gauss3(f, a, b);
    cout << "│ Gauss-2 puntos       │ "
         << fixed << setprecision(15) << setw(16) << gauss2_resultado << " │ "
         << scientific << setprecision(4) << setw(12) << abs(gauss2_resultado - exacto) << " │ "
         << setw(10) << 2 << " │" << endl;
    cout << "│ Gauss-3 puntos       │ "
         << fixed << setprecision(15) << setw(16) << gauss3_resultado << " │ "
         << scientific << setprecision(4) << setw(12) << abs(gauss3_resultado - exacto) << " │ "
         << setw(10) << 3 << " │" << endl;

    cout << "└──────────────────────┴──────────────────┴──────────────┴────────────┘" << endl;

    cout << "\nObservación:" << endl;
    cout << "- Simpson es más preciso que Trapecio para el mismo n" << endl;
    cout << "- Gauss-3 es exacto (f es polinomio de grado 2 ≤ 5)" << endl;
}

/**
 * @brief Ejemplo 2: Integrar sin(x) en [0, π]
 * Valor exacto: 2
 */
void ejemplo2_trascendental() {
    cout << "\n" << string(75, '=') << endl;
    cout << "EJEMPLO 2: INTEGRAL DE sen(x) EN [0, π]" << endl;
    cout << "Valor exacto: 2" << endl;
    cout << string(75, '=') << endl;

    auto f = [](double x) { return sin(x); };
    double a = 0.0, b = M_PI;
    double exacto = 2.0;

    cout << "\n┌──────────────────────┬──────────────────┬──────────────┐" << endl;
    cout << "│       Método         │    Resultado     │     Error    │" << endl;
    cout << "├──────────────────────┼──────────────────┼──────────────┤" << endl;

    double trap = trapecio_compuesta(f, a, b, 10);
    double simp = simpson_compuesta(f, a, b, 10);
    double g2 = gauss2(f, a, b);
    double g3 = gauss3(f, a, b);

    cout << "│ Trapecio (n=10)      │ "
         << fixed << setprecision(15) << setw(16) << trap << " │ "
         << scientific << setprecision(4) << setw(12) << abs(trap - exacto) << " │" << endl;
    cout << "│ Simpson (n=10)       │ "
         << fixed << setprecision(15) << setw(16) << simp << " │ "
         << scientific << setprecision(4) << setw(12) << abs(simp - exacto) << " │" << endl;
    cout << "│ Gauss-2              │ "
         << fixed << setprecision(15) << setw(16) << g2 << " │ "
         << scientific << setprecision(4) << setw(12) << abs(g2 - exacto) << " │" << endl;
    cout << "│ Gauss-3              │ "
         << fixed << setprecision(15) << setw(16) << g3 << " │ "
         << scientific << setprecision(4) << setw(12) << abs(g3 - exacto) << " │" << endl;

    cout << "└──────────────────────┴──────────────────┴──────────────┘" << endl;
}

/**
 * @brief Ejemplo 3: Integral sin antiderivada elemental
 * f(x) = e^(-x²) en [0, 1]
 */
void ejemplo3_gaussiana() {
    cout << "\n" << string(75, '=') << endl;
    cout << "EJEMPLO 3: INTEGRAL DE e^(-x²) EN [0, 1]" << endl;
    cout << "No tiene antiderivada elemental (función error)" << endl;
    cout << string(75, '=') << endl;

    auto f = [](double x) { return exp(-x * x); };
    double a = 0.0, b = 1.0;

    // Valor de referencia (calculado con alta precisión)
    double referencia = 0.746824132812427;

    cout << "\n┌──────────────────────┬──────────────────┬──────────────┐" << endl;
    cout << "│       Método         │    Resultado     │     Error    │" << endl;
    cout << "├──────────────────────┼──────────────────┼──────────────┤" << endl;

    double trap = trapecio_compuesta(f, a, b, 100);
    double simp = simpson_compuesta(f, a, b, 100);
    double g3 = gauss3(f, a, b);
    double adap = simpson_adaptativa(f, a, b, 1e-10);

    cout << "│ Trapecio (n=100)     │ "
         << fixed << setprecision(15) << setw(16) << trap << " │ "
         << scientific << setprecision(4) << setw(12) << abs(trap - referencia) << " │" << endl;
    cout << "│ Simpson (n=100)      │ "
         << fixed << setprecision(15) << setw(16) << simp << " │ "
         << scientific << setprecision(4) << setw(12) << abs(simp - referencia) << " │" << endl;
    cout << "│ Gauss-3              │ "
         << fixed << setprecision(15) << setw(16) << g3 << " │ "
         << scientific << setprecision(4) << setw(12) << abs(g3 - referencia) << " │" << endl;
    cout << "│ Simpson Adaptativa   │ "
         << fixed << setprecision(15) << setw(16) << adap << " │ "
         << scientific << setprecision(4) << setw(12) << abs(adap - referencia) << " │" << endl;

    cout << "└──────────────────────┴──────────────────┴──────────────┘" << endl;
}

/**
 * @brief Ejemplo 4: Función con singularidad suave
 */
void ejemplo4_singularidad() {
    cout << "\n" << string(75, '=') << endl;
    cout << "EJEMPLO 4: INTEGRAL DE 1/√x EN [0, 1]" << endl;
    cout << "Valor exacto: 2" << endl;
    cout << "Función tiene singularidad en x=0" << endl;
    cout << string(75, '=') << endl;

    // Evitar división por cero empezando ligeramente después de 0
    auto f = [](double x) { return 1.0 / sqrt(x + 1e-10); };
    double a = 1e-10, b = 1.0;
    double exacto = 2.0;

    cout << "\nNota: Los métodos estándar tienen dificultades con singularidades" << endl;

    double simp = simpson_compuesta(f, a, b, 1000);
    double adap = simpson_adaptativa(f, a, b, 1e-4);

    cout << "\nSimpson (n=1000):  " << fixed << setprecision(10) << simp
         << "  (error: " << scientific << setprecision(4) << abs(simp - exacto) << ")" << endl;
    cout << "Simpson adaptativa: " << fixed << setprecision(10) << adap
         << "  (error: " << scientific << setprecision(4) << abs(adap - exacto) << ")" << endl;

    cout << "\nLa integración adaptativa maneja mejor la singularidad" << endl;
    cout << "concentrando más puntos cerca de x=0." << endl;
}

/**
 * @brief Función principal
 */
int main() {
    cout << "╔═══════════════════════════════════════════════════════════════════════╗" << endl;
    cout << "║            INTEGRACIÓN NUMÉRICA - ANÁLISIS NUMÉRICO                   ║" << endl;
    cout << "╚═══════════════════════════════════════════════════════════════════════╝" << endl;

    ejemplo1_polinomio();
    ejemplo2_trascendental();
    ejemplo3_gaussiana();
    ejemplo4_singularidad();

    cout << "\n╔═══════════════════════════════════════════════════════════════════════╗" << endl;
    cout << "║ PRINCIPIOS CLAVE DE INTEGRACIÓN NUMÉRICA:                            ║" << endl;
    cout << "╠═══════════════════════════════════════════════════════════════════════╣" << endl;
    cout << "║ 1. Trapecio: Simple, error O(h²), requiere muchos puntos             ║" << endl;
    cout << "║ 2. Simpson: Error O(h⁴), mucho más preciso                           ║" << endl;
    cout << "║ 3. Gauss: Óptimo para número fijo de evaluaciones                    ║" << endl;
    cout << "║ 4. Métodos adaptativos: Ajustan paso automáticamente                 ║" << endl;
    cout << "║ 5. Más puntos → mayor precisión pero más costo                       ║" << endl;
    cout << "║ 6. Elección del método depende de la función y precisión requerida   ║" << endl;
    cout << "╚═══════════════════════════════════════════════════════════════════════╝" << endl;

    return 0;
}
