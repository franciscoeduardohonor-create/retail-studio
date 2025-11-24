/**
 * @file cancelacion_catastrofica.cpp
 * @brief Demostración de cancelación catastrófica y cómo evitarla
 *
 * La cancelación catastrófica ocurre cuando se restan dos números muy similares,
 * perdiendo cifras significativas y amplificando errores de redondeo.
 *
 * Este programa muestra:
 * - Ejemplos donde ocurre cancelación catastrófica
 * - Cómo reformular problemas para evitarla
 * - Técnicas de estabilización numérica
 */

#include <iostream>
#include <iomanip>
#include <cmath>
#include <vector>

using namespace std;

/**
 * @brief Ejemplo 1: Fórmula cuadrática - método inestable vs estable
 *
 * Para ax² + bx + c = 0, las raíces son:
 * x = (-b ± √(b² - 4ac)) / (2a)
 *
 * Problema: Cuando b² >> 4ac, una de las raíces sufre cancelación catastrófica
 * Solución: Usar fórmulas alternativas
 */
void ejemplo1_formula_cuadratica() {
    cout << "\n" << string(75, '=') << endl;
    cout << "EJEMPLO 1: FÓRMULA CUADRÁTICA Y CANCELACIÓN CATASTRÓFICA" << endl;
    cout << string(75, '=') << endl;

    // Ejemplo: x² - 5000.002x + 10 = 0
    // Raíces exactas (calculadas con alta precisión): x₁ ≈ 5000.000, x₂ ≈ 0.002
    double a = 1.0;
    double b = -5000.002;
    double c = 10.0;

    cout << "\nEcuación: " << a << "x² + (" << b << ")x + " << c << " = 0" << endl;

    double discriminante = b * b - 4 * a * c;
    double sqrt_disc = sqrt(discriminante);

    cout << "\nDiscriminante: " << fixed << setprecision(10) << discriminante << endl;
    cout << "√Discriminante: " << sqrt_disc << endl;

    // MÉTODO INESTABLE (fórmula estándar directa)
    cout << "\n┌─────────────────────────────────────────────────────┐" << endl;
    cout << "│ MÉTODO INESTABLE (Fórmula estándar)                │" << endl;
    cout << "└─────────────────────────────────────────────────────┘" << endl;

    double x1_inestable = (-b + sqrt_disc) / (2 * a);
    double x2_inestable = (-b - sqrt_disc) / (2 * a);

    cout << setprecision(15);
    cout << "x₁ = (-b + √Δ) / 2a = " << x1_inestable << endl;
    cout << "x₂ = (-b - √Δ) / 2a = " << x2_inestable << endl;

    // MÉTODO ESTABLE (usando fórmulas alternativas)
    cout << "\n┌─────────────────────────────────────────────────────┐" << endl;
    cout << "│ MÉTODO ESTABLE (Fórmulas mejoradas)                │" << endl;
    cout << "└─────────────────────────────────────────────────────┘" << endl;

    // Calcular la raíz más grande primero
    double x1_estable;
    if (b > 0) {
        x1_estable = (-b - sqrt_disc) / (2 * a);
    } else {
        x1_estable = (-b + sqrt_disc) / (2 * a);
    }

    // Usar la relación x₁ · x₂ = c/a para calcular la segunda raíz
    double x2_estable = c / (a * x1_estable);

    cout << "x₁ (calculada directamente) = " << x1_estable << endl;
    cout << "x₂ (usando x₁·x₂ = c/a)     = " << x2_estable << endl;

    // Verificación: Sustituir en la ecuación original
    cout << "\n┌─────────────────────────────────────────────────────┐" << endl;
    cout << "│ VERIFICACIÓN: Sustituir en la ecuación original    │" << endl;
    cout << "└─────────────────────────────────────────────────────┘" << endl;

    auto verificar = [a, b, c](double x, const string& nombre) {
        double resultado = a * x * x + b * x + c;
        cout << nombre << ": " << a << "(" << x << ")² + " << b << "(" << x << ") + " << c
             << " = " << scientific << setprecision(6) << resultado << endl;
    };

    cout << fixed << setprecision(15);
    verificar(x1_inestable, "x₁ inestable");
    verificar(x2_inestable, "x₂ inestable");
    verificar(x1_estable, "x₁ estable  ");
    verificar(x2_estable, "x₂ estable  ");

    // Análisis del error
    cout << "\n┌─────────────────────────────────────────────────────┐" << endl;
    cout << "│ ANÁLISIS DEL ERROR                                  │" << endl;
    cout << "└─────────────────────────────────────────────────────┘" << endl;

    double producto_inestable = x1_inestable * x2_inestable;
    double producto_estable = x1_estable * x2_estable;
    double producto_exacto = c / a; // Por la relación de Vieta

    cout << "Producto de raíces (debe ser c/a = " << producto_exacto << "):" << endl;
    cout << "Método inestable: " << producto_inestable
         << " (error: " << abs(producto_inestable - producto_exacto) << ")" << endl;
    cout << "Método estable:   " << producto_estable
         << " (error: " << abs(producto_estable - producto_exacto) << ")" << endl;
}

/**
 * @brief Ejemplo 2: Cálculo de ln(1 + x) para x pequeño
 *
 * Problema: ln(1 + x) calculado directamente pierde precisión para x pequeño
 * Solución: Usar la función log1p(x) o series de Taylor
 */
void ejemplo2_logaritmo() {
    cout << "\n" << string(75, '=') << endl;
    cout << "EJEMPLO 2: CÁLCULO DE ln(1 + x) PARA x PEQUEÑO" << endl;
    cout << string(75, '=') << endl;

    cout << "\n┌────────────┬──────────────────┬──────────────────┬──────────────┐" << endl;
    cout << "│     x      │  log(1+x)        │  log1p(x)        │  Diferencia  │" << endl;
    cout << "├────────────┼──────────────────┼──────────────────┼──────────────┤" << endl;

    vector<double> valores_x = {1e-1, 1e-2, 1e-5, 1e-10, 1e-15, 1e-17};

    for (double x : valores_x) {
        double metodo1 = log(1.0 + x);  // Método inestable
        double metodo2 = log1p(x);       // Método estable (biblioteca)
        double diferencia = abs(metodo1 - metodo2);

        cout << "│ " << scientific << setprecision(2) << setw(10) << x
             << " │ " << setprecision(15) << setw(16) << metodo1
             << " │ " << setw(16) << metodo2
             << " │ " << scientific << setprecision(2) << setw(12) << diferencia
             << " │" << endl;
    }

    cout << "└────────────┴──────────────────┴──────────────────┴──────────────┘" << endl;

    cout << "\nExplicación:" << endl;
    cout << "Para x muy pequeño, 1 + x se redondea a 1.0 en la representación" << endl;
    cout << "de punto flotante, y log(1.0) = 0, perdiendo toda la información." << endl;
    cout << "La función log1p(x) está diseñada para manejar este caso." << endl;
}

/**
 * @brief Ejemplo 3: Cálculo de √(x² + 1) - 1 para x pequeño
 */
void ejemplo3_raiz_cuadrada() {
    cout << "\n" << string(75, '=') << endl;
    cout << "EJEMPLO 3: CÁLCULO DE √(x² + 1) - 1 PARA x PEQUEÑO" << endl;
    cout << string(75, '=') << endl;

    cout << "\nProblema: Calcular f(x) = √(x² + 1) - 1 para x pequeño" << endl;

    cout << "\n┌────────────┬──────────────────┬──────────────────┬──────────────┐" << endl;
    cout << "│     x      │  Método Directo  │  Método Estable  │  Error Rel % │" << endl;
    cout << "├────────────┼──────────────────┼──────────────────┼──────────────┤" << endl;

    vector<double> valores_x = {1e-1, 1e-2, 1e-4, 1e-6, 1e-8};

    for (double x : valores_x) {
        // Método inestable: directo
        double inestable = sqrt(x * x + 1.0) - 1.0;

        // Método estable: racionalizar
        // √(x² + 1) - 1 = (√(x² + 1) - 1)(√(x² + 1) + 1) / (√(x² + 1) + 1)
        //               = (x² + 1 - 1) / (√(x² + 1) + 1)
        //               = x² / (√(x² + 1) + 1)
        double estable = (x * x) / (sqrt(x * x + 1.0) + 1.0);

        // Para x pequeño, el valor verdadero es aproximadamente x²/2
        double valor_verdadero = x * x / 2.0;
        double error_relativo = abs((inestable - valor_verdadero) / valor_verdadero) * 100.0;

        cout << "│ " << scientific << setprecision(2) << setw(10) << x
             << " │ " << setprecision(15) << setw(16) << inestable
             << " │ " << setw(16) << estable
             << " │ " << fixed << setprecision(6) << setw(12) << error_relativo
             << " │" << endl;
    }

    cout << "└────────────┴──────────────────┴──────────────────┴──────────────┘" << endl;

    cout << "\nSolución: Racionalizar la expresión para evitar la resta:" << endl;
    cout << "  √(x² + 1) - 1 = x² / (√(x² + 1) + 1)" << endl;
}

/**
 * @brief Ejemplo 4: Cálculo de derivadas numéricas
 */
void ejemplo4_derivadas_numericas() {
    cout << "\n" << string(75, '=') << endl;
    cout << "EJEMPLO 4: DERIVADAS NUMÉRICAS Y CANCELACIÓN" << endl;
    cout << string(75, '=') << endl;

    // Función: f(x) = sin(x)
    // Derivada exacta: f'(x) = cos(x)
    double x0 = 1.0;
    double derivada_exacta = cos(x0);

    cout << "\nCalculando f'(1) donde f(x) = sin(x)" << endl;
    cout << "Valor exacto: f'(1) = cos(1) = " << fixed << setprecision(15)
         << derivada_exacta << endl;

    cout << "\nFórmula: f'(x) ≈ (f(x+h) - f(x)) / h" << endl;

    cout << "\n┌─────────────┬──────────────────┬──────────────┬──────────────┐" << endl;
    cout << "│      h      │   f'(x) aprox    │  Error Abs   │  Error Rel % │" << endl;
    cout << "├─────────────┼──────────────────┼──────────────┼──────────────┤" << endl;

    for (int i = 1; i <= 16; i++) {
        double h = pow(10.0, -i);
        double derivada_numerica = (sin(x0 + h) - sin(x0)) / h;
        double error_abs = abs(derivada_numerica - derivada_exacta);
        double error_rel = (error_abs / abs(derivada_exacta)) * 100.0;

        cout << "│ " << scientific << setprecision(2) << setw(11) << h
             << " │ " << fixed << setprecision(15) << setw(16) << derivada_numerica
             << " │ " << scientific << setprecision(2) << setw(12) << error_abs
             << " │ " << fixed << setprecision(6) << setw(12) << error_rel
             << " │" << endl;
    }

    cout << "└─────────────┴──────────────────┴──────────────┴──────────────┘" << endl;

    cout << "\nObservación:" << endl;
    cout << "- Para h muy grande: Error de truncamiento domina" << endl;
    cout << "- Para h muy pequeño: Cancelación catastrófica domina" << endl;
    cout << "- Existe un h óptimo (típicamente h ≈ √ε, donde ε es epsilon de máquina)" << endl;
}

/**
 * @brief Muestra guía de prevención de cancelación catastrófica
 */
void guia_prevencion() {
    cout << "\n" << string(75, '=') << endl;
    cout << "GUÍA DE PREVENCIÓN DE CANCELACIÓN CATASTRÓFICA" << endl;
    cout << string(75, '=') << endl;

    cout << "\n1. RACIONALIZACIÓN" << endl;
    cout << "   Malo:  √(x² + 1) - 1" << endl;
    cout << "   Bueno: x² / (√(x² + 1) + 1)" << endl;

    cout << "\n2. USAR FUNCIONES ESPECIALIZADAS" << endl;
    cout << "   Malo:  log(1 + x)" << endl;
    cout << "   Bueno: log1p(x)" << endl;
    cout << "   Malo:  exp(x) - 1" << endl;
    cout << "   Bueno: expm1(x)" << endl;

    cout << "\n3. REORDENAR OPERACIONES" << endl;
    cout << "   Malo:  (a + b) - (a + c)    // si a >> b, c" << endl;
    cout << "   Bueno: b - c" << endl;

    cout << "\n4. USAR SERIES DE TAYLOR PARA VALORES PEQUEÑOS" << endl;
    cout << "   Para |x| < ε: sin(x) ≈ x - x³/6 + ..." << endl;

    cout << "\n5. ALGORITMOS ESTABLES PARA FÓRMULA CUADRÁTICA" << endl;
    cout << "   Calcular la raíz más grande primero" << endl;
    cout << "   Usar x₁·x₂ = c/a para la segunda raíz" << endl;
}

/**
 * @brief Función principal
 */
int main() {
    cout << "╔═══════════════════════════════════════════════════════════════════════╗" << endl;
    cout << "║          CANCELACIÓN CATASTRÓFICA - ANÁLISIS NUMÉRICO                 ║" << endl;
    cout << "╚═══════════════════════════════════════════════════════════════════════╝" << endl;

    ejemplo1_formula_cuadratica();
    ejemplo2_logaritmo();
    ejemplo3_raiz_cuadrada();
    ejemplo4_derivadas_numericas();
    guia_prevencion();

    cout << "\n╔═══════════════════════════════════════════════════════════════════════╗" << endl;
    cout << "║ PRINCIPIOS CLAVE:                                                     ║" << endl;
    cout << "╠═══════════════════════════════════════════════════════════════════════╣" << endl;
    cout << "║ 1. NUNCA restes números casi iguales si puedes evitarlo              ║" << endl;
    cout << "║ 2. Reformula problemas para evitar cancelación                       ║" << endl;
    cout << "║ 3. Usa funciones de biblioteca diseñadas para estabilidad            ║" << endl;
    cout << "║ 4. Verifica tus resultados con diferentes métodos                    ║" << endl;
    cout << "║ 5. Comprende el rango de valores donde tu algoritmo es estable       ║" << endl;
    cout << "╚═══════════════════════════════════════════════════════════════════════╝" << endl;

    return 0;
}
