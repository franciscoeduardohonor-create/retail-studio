/**
 * @file errores_basicos.cpp
 * @brief Cálculo y análisis de errores absolutos y relativos
 *
 * Este programa demuestra cómo calcular, interpretar y visualizar diferentes
 * tipos de errores en análisis numérico.
 *
 * Conceptos clave:
 * - Error absoluto
 * - Error relativo
 * - Error porcentual
 * - Cifras significativas
 */

#include <iostream>
#include <iomanip>
#include <cmath>
#include <vector>
#include <string>

using namespace std;

/**
 * @brief Clase para manejar cálculos de errores
 */
class CalculadorError {
private:
    double valor_exacto;
    double valor_aproximado;

public:
    /**
     * @brief Constructor
     * @param exacto Valor exacto o de referencia
     * @param aproximado Valor aproximado o calculado
     */
    CalculadorError(double exacto, double aproximado)
        : valor_exacto(exacto), valor_aproximado(aproximado) {}

    /**
     * @brief Calcula el error absoluto
     * Error absoluto = |valor_exacto - valor_aproximado|
     * @return Error absoluto
     */
    double errorAbsoluto() const {
        return abs(valor_exacto - valor_aproximado);
    }

    /**
     * @brief Calcula el error relativo
     * Error relativo = |valor_exacto - valor_aproximado| / |valor_exacto|
     * @return Error relativo
     */
    double errorRelativo() const {
        if (abs(valor_exacto) < 1e-15) {
            cerr << "Advertencia: División por valor muy cercano a cero" << endl;
            return INFINITY;
        }
        return errorAbsoluto() / abs(valor_exacto);
    }

    /**
     * @brief Calcula el error porcentual
     * Error porcentual = error relativo × 100%
     * @return Error porcentual
     */
    double errorPorcentual() const {
        return errorRelativo() * 100.0;
    }

    /**
     * @brief Calcula el número de cifras significativas correctas
     * @return Número de cifras significativas
     */
    int cifrasSignificativas() const {
        double err_rel = errorRelativo();
        if (err_rel == 0.0) return 16; // Precisión máxima de double
        if (err_rel >= 1.0) return 0;

        // Número de cifras ≈ -log₁₀(error_relativo)
        return static_cast<int>(-log10(err_rel));
    }

    /**
     * @brief Muestra un reporte completo de errores
     */
    void mostrarReporte() const {
        cout << fixed << setprecision(15);
        cout << "\nValor exacto:      " << valor_exacto << endl;
        cout << "Valor aproximado:  " << valor_aproximado << endl;

        cout << scientific << setprecision(6);
        cout << "\nError absoluto:    " << errorAbsoluto() << endl;
        cout << "Error relativo:    " << errorRelativo() << endl;

        cout << fixed << setprecision(8);
        cout << "Error porcentual:  " << errorPorcentual() << " %" << endl;
        cout << "Cifras significativas correctas: " << cifrasSignificativas() << endl;
    }
};

/**
 * @brief Ejemplo 1: Aproximaciones de π
 */
void ejemplo1_aproximaciones_pi() {
    cout << "\n" << string(70, '=') << endl;
    cout << "EJEMPLO 1: APROXIMACIONES DE π" << endl;
    cout << string(70, '=') << endl;

    const double PI_EXACTO = M_PI; // Valor de referencia

    // Diferentes aproximaciones históricas de π
    vector<pair<string, double>> aproximaciones = {
        {"Antigua (22/7)", 22.0 / 7.0},
        {"Arquímedes", 3.1418},
        {"Ptolemeo", 3.14166},
        {"Zu Chongzhi (355/113)", 355.0 / 113.0},
        {"Al-Kashi", 3.14159265358979},
        {"Moderna", 3.14159265}
    };

    for (const auto& aprox : aproximaciones) {
        cout << "\nAproximacion: " << aprox.first << endl;
        CalculadorError calc(PI_EXACTO, aprox.second);
        calc.mostrarReporte();
    }
}

/**
 * @brief Ejemplo 2: Aproximaciones de e (número de Euler)
 * Usando la serie: e = 1 + 1/1! + 1/2! + 1/3! + ...
 */
void ejemplo2_aproximaciones_e() {
    cout << "\n" << string(70, '=') << endl;
    cout << "EJEMPLO 2: APROXIMACIÓN DE e MEDIANTE SERIE" << endl;
    cout << string(70, '=') << endl;

    const double E_EXACTO = M_E; // Valor de referencia

    cout << "\nCalculando e mediante serie: e = 1 + 1/1! + 1/2! + 1/3! + ..." << endl;
    cout << "\n┌──────────┬─────────────────┬─────────────┬─────────────┬──────────┐" << endl;
    cout << "│ Términos │ Aproximación    │ Error Abs   │ Error Rel   │  Cifras  │" << endl;
    cout << "├──────────┼─────────────────┼─────────────┼─────────────┼──────────┤" << endl;

    double suma = 0.0;
    double factorial = 1.0;

    for (int n = 0; n <= 20; n++) {
        if (n > 0) {
            factorial *= n;
        }
        suma += 1.0 / factorial;

        if (n % 2 == 0 || n > 10) { // Mostrar cada 2 términos, luego todos
            CalculadorError calc(E_EXACTO, suma);

            cout << "│ " << setw(8) << n
                 << " │ " << fixed << setprecision(12) << setw(15) << suma
                 << " │ " << scientific << setprecision(2) << setw(11) << calc.errorAbsoluto()
                 << " │ " << setw(11) << calc.errorRelativo()
                 << " │ " << setw(8) << calc.cifrasSignificativas()
                 << " │" << endl;
        }
    }

    cout << "└──────────┴─────────────────┴─────────────┴─────────────┴──────────┘" << endl;
}

/**
 * @brief Ejemplo 3: Raíces cuadradas y comparación con función de biblioteca
 */
void ejemplo3_raices_cuadradas() {
    cout << "\n" << string(70, '=') << endl;
    cout << "EJEMPLO 3: APROXIMACIÓN DE RAÍCES CUADRADAS" << endl;
    cout << "Método de Herón (Método Babilónico)" << endl;
    cout << string(70, '=') << endl;

    double numero = 2.0;
    double exacto = sqrt(numero);

    cout << "\nCalculando √" << numero << " usando el método de Herón:" << endl;
    cout << "Fórmula: x_(n+1) = (x_n + S/x_n) / 2" << endl;

    cout << "\n┌────────┬─────────────────┬─────────────┬─────────────┐" << endl;
    cout << "│  Iter  │  Aproximación   │  Error Abs  │  Error Rel  │" << endl;
    cout << "├────────┼─────────────────┼─────────────┼─────────────┤" << endl;

    double x = 1.0; // Estimación inicial

    for (int i = 0; i <= 10; i++) {
        CalculadorError calc(exacto, x);

        cout << "│ " << setw(6) << i
             << " │ " << fixed << setprecision(12) << setw(15) << x
             << " │ " << scientific << setprecision(2) << setw(11) << calc.errorAbsoluto()
             << " │ " << setw(11) << calc.errorRelativo()
             << " │" << endl;

        // Siguiente iteración: x_(n+1) = (x_n + S/x_n) / 2
        x = (x + numero / x) / 2.0;
    }

    cout << "└────────┴─────────────────┴─────────────┴─────────────┘" << endl;
    cout << fixed << setprecision(15);
    cout << "\nValor de referencia (sqrt): " << exacto << endl;
}

/**
 * @brief Ejemplo 4: Impacto del error en operaciones
 */
void ejemplo4_propagacion_errores() {
    cout << "\n" << string(70, '=') << endl;
    cout << "EJEMPLO 4: PROPAGACIÓN DE ERRORES EN OPERACIONES" << endl;
    cout << string(70, '=') << endl;

    // Valores con pequeño error
    double a_exacto = 10.0;
    double b_exacto = 3.0;

    double a_aprox = 10.01;  // 0.1% de error
    double b_aprox = 3.003;  // 0.1% de error

    cout << fixed << setprecision(6);
    cout << "\nValores de entrada:" << endl;
    cout << "a exacto = " << a_exacto << ", a aproximado = " << a_aprox << endl;
    cout << "b exacto = " << b_exacto << ", b aproximado = " << b_aprox << endl;

    CalculadorError err_a(a_exacto, a_aprox);
    CalculadorError err_b(b_exacto, b_aprox);

    cout << "\nErrores de entrada:" << endl;
    cout << "Error en a: " << err_a.errorPorcentual() << "%" << endl;
    cout << "Error en b: " << err_b.errorPorcentual() << "%" << endl;

    // Operaciones
    cout << "\n┌─────────────────┬───────────┬───────────┬─────────────┐" << endl;
    cout << "│   Operación     │  Exacto   │  Aprox    │  Error %    │" << endl;
    cout << "├─────────────────┼───────────┼───────────┼─────────────┤" << endl;

    // Suma
    double suma_exacta = a_exacto + b_exacto;
    double suma_aprox = a_aprox + b_aprox;
    CalculadorError err_suma(suma_exacta, suma_aprox);
    cout << "│ a + b           │ " << setw(9) << suma_exacta
         << " │ " << setw(9) << suma_aprox
         << " │ " << setw(11) << err_suma.errorPorcentual() << " │" << endl;

    // Resta
    double resta_exacta = a_exacto - b_exacto;
    double resta_aprox = a_aprox - b_aprox;
    CalculadorError err_resta(resta_exacta, resta_aprox);
    cout << "│ a - b           │ " << setw(9) << resta_exacta
         << " │ " << setw(9) << resta_aprox
         << " │ " << setw(11) << err_resta.errorPorcentual() << " │" << endl;

    // Multiplicación
    double mult_exacta = a_exacto * b_exacto;
    double mult_aprox = a_aprox * b_aprox;
    CalculadorError err_mult(mult_exacta, mult_aprox);
    cout << "│ a × b           │ " << setw(9) << mult_exacta
         << " │ " << setw(9) << mult_aprox
         << " │ " << setw(11) << err_mult.errorPorcentual() << " │" << endl;

    // División
    double div_exacta = a_exacto / b_exacto;
    double div_aprox = a_aprox / b_aprox;
    CalculadorError err_div(div_exacta, div_aprox);
    cout << "│ a ÷ b           │ " << setw(9) << div_exacta
         << " │ " << setw(9) << div_aprox
         << " │ " << setw(11) << err_div.errorPorcentual() << " │" << endl;

    cout << "└─────────────────┴───────────┴───────────┴─────────────┘" << endl;

    cout << "\nObservación: Los errores se propagan de forma diferente" << endl;
    cout << "según la operación. En general:" << endl;
    cout << "  - Suma/Resta: Los errores absolutos se suman" << endl;
    cout << "  - Multiplicación/División: Los errores relativos se suman" << endl;
}

/**
 * @brief Función principal
 */
int main() {
    cout << "╔══════════════════════════════════════════════════════════════════╗" << endl;
    cout << "║        ERRORES ABSOLUTOS Y RELATIVOS - ANÁLISIS NUMÉRICO         ║" << endl;
    cout << "╚══════════════════════════════════════════════════════════════════╝" << endl;

    ejemplo1_aproximaciones_pi();
    ejemplo2_aproximaciones_e();
    ejemplo3_raices_cuadradas();
    ejemplo4_propagacion_errores();

    cout << "\n╔══════════════════════════════════════════════════════════════════╗" << endl;
    cout << "║ LECCIONES CLAVE:                                                 ║" << endl;
    cout << "╠══════════════════════════════════════════════════════════════════╣" << endl;
    cout << "║ 1. Error absoluto mide la magnitud de la diferencia             ║" << endl;
    cout << "║ 2. Error relativo es independiente de la escala                 ║" << endl;
    cout << "║ 3. Los errores se propagan en cálculos sucesivos                ║" << endl;
    cout << "║ 4. Más iteraciones generalmente → menor error                   ║" << endl;
    cout << "║ 5. Cifras significativas indican la confiabilidad del resultado ║" << endl;
    cout << "╚══════════════════════════════════════════════════════════════════╝" << endl;

    return 0;
}
