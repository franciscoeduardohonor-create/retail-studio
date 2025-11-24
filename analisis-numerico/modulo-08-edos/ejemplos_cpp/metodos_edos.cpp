/**
 * @file metodos_edos.cpp
 * @brief Métodos numéricos para Ecuaciones Diferenciales Ordinarias
 *
 * Implementa:
 * - Método de Euler
 * - Runge-Kutta de orden 2 (RK2)
 * - Runge-Kutta de orden 4 (RK4)
 * - Aplicaciones a problemas físicos
 *
 * Incluye ejemplos con soluciones analíticas conocidas para verificar precisión.
 */

#include <iostream>
#include <iomanip>
#include <cmath>
#include <functional>
#include <vector>
#include <fstream>
#include <string>

using namespace std;

// Tipo para funciones de EDOs: dy/dx = f(x, y)
using FuncionEDO = function<double(double, double)>;

// Tipo para sistemas de EDOs: dy/dx = f(x, y)
using FuncionSistema = function<vector<double>(double, const vector<double>&)>;

/**
 * @brief Estructura para almacenar resultados de la solución
 */
struct SolucionEDO {
    vector<double> x;  // Puntos x
    vector<double> y;  // Valores y
};

/**
 * @brief Método de Euler
 *
 * Resuelve dy/dx = f(x, y) con y(x0) = y0
 *
 * Fórmula: y_{n+1} = y_n + h*f(x_n, y_n)
 *
 * @param f Función f(x, y)
 * @param x0 Valor inicial de x
 * @param y0 Valor inicial de y
 * @param h Tamaño del paso
 * @param n_pasos Número de pasos
 * @return Solución (vectores x, y)
 */
SolucionEDO euler(FuncionEDO f, double x0, double y0, double h, int n_pasos) {
    SolucionEDO sol;
    sol.x.reserve(n_pasos + 1);
    sol.y.reserve(n_pasos + 1);

    double x = x0;
    double y = y0;

    sol.x.push_back(x);
    sol.y.push_back(y);

    for (int i = 0; i < n_pasos; i++) {
        // yn+1 = yn + h*f(xn, yn)
        y = y + h * f(x, y);
        x = x + h;

        sol.x.push_back(x);
        sol.y.push_back(y);
    }

    return sol;
}

/**
 * @brief Método de Runge-Kutta de orden 2 (RK2)
 *
 * También conocido como método del punto medio mejorado
 *
 * k1 = h*f(xn, yn)
 * k2 = h*f(xn + h/2, yn + k1/2)
 * yn+1 = yn + k2
 *
 * @param f Función f(x, y)
 * @param x0 Valor inicial de x
 * @param y0 Valor inicial de y
 * @param h Tamaño del paso
 * @param n_pasos Número de pasos
 * @return Solución (vectores x, y)
 */
SolucionEDO rk2(FuncionEDO f, double x0, double y0, double h, int n_pasos) {
    SolucionEDO sol;
    sol.x.reserve(n_pasos + 1);
    sol.y.reserve(n_pasos + 1);

    double x = x0;
    double y = y0;

    sol.x.push_back(x);
    sol.y.push_back(y);

    for (int i = 0; i < n_pasos; i++) {
        double k1 = h * f(x, y);
        double k2 = h * f(x + h/2.0, y + k1/2.0);

        y = y + k2;
        x = x + h;

        sol.x.push_back(x);
        sol.y.push_back(y);
    }

    return sol;
}

/**
 * @brief Método de Runge-Kutta de orden 4 (RK4)
 *
 * El método más popular para EDOs
 *
 * k1 = h*f(xn, yn)
 * k2 = h*f(xn + h/2, yn + k1/2)
 * k3 = h*f(xn + h/2, yn + k2/2)
 * k4 = h*f(xn + h, yn + k3)
 * yn+1 = yn + (k1 + 2*k2 + 2*k3 + k4)/6
 *
 * @param f Función f(x, y)
 * @param x0 Valor inicial de x
 * @param y0 Valor inicial de y
 * @param h Tamaño del paso
 * @param n_pasos Número de pasos
 * @return Solución (vectores x, y)
 */
SolucionEDO rk4(FuncionEDO f, double x0, double y0, double h, int n_pasos) {
    SolucionEDO sol;
    sol.x.reserve(n_pasos + 1);
    sol.y.reserve(n_pasos + 1);

    double x = x0;
    double y = y0;

    sol.x.push_back(x);
    sol.y.push_back(y);

    for (int i = 0; i < n_pasos; i++) {
        double k1 = h * f(x, y);
        double k2 = h * f(x + h/2.0, y + k1/2.0);
        double k3 = h * f(x + h/2.0, y + k2/2.0);
        double k4 = h * f(x + h, y + k3);

        y = y + (k1 + 2.0*k2 + 2.0*k3 + k4) / 6.0;
        x = x + h;

        sol.x.push_back(x);
        sol.y.push_back(y);
    }

    return sol;
}

/**
 * @brief RK4 para sistemas de EDOs
 *
 * @param f Vector de funciones f(x, y_vector)
 * @param x0 Valor inicial de x
 * @param y0 Vector de condiciones iniciales
 * @param h Tamaño del paso
 * @param n_pasos Número de pasos
 * @return Vector de soluciones
 */
struct SolucionSistema {
    vector<double> x;
    vector<vector<double>> y;  // y[i][j] = componente j en el paso i
};

SolucionSistema rk4_sistema(FuncionSistema f, double x0, const vector<double>& y0,
                            double h, int n_pasos) {
    SolucionSistema sol;
    int dim = y0.size();

    sol.x.reserve(n_pasos + 1);
    sol.y.reserve(n_pasos + 1);

    double x = x0;
    vector<double> y = y0;

    sol.x.push_back(x);
    sol.y.push_back(y);

    for (int i = 0; i < n_pasos; i++) {
        vector<double> k1 = f(x, y);
        for (auto& k : k1) k *= h;

        vector<double> y_temp(dim);
        for (int j = 0; j < dim; j++) {
            y_temp[j] = y[j] + k1[j]/2.0;
        }
        vector<double> k2 = f(x + h/2.0, y_temp);
        for (auto& k : k2) k *= h;

        for (int j = 0; j < dim; j++) {
            y_temp[j] = y[j] + k2[j]/2.0;
        }
        vector<double> k3 = f(x + h/2.0, y_temp);
        for (auto& k : k3) k *= h;

        for (int j = 0; j < dim; j++) {
            y_temp[j] = y[j] + k3[j];
        }
        vector<double> k4 = f(x + h, y_temp);
        for (auto& k : k4) k *= h;

        for (int j = 0; j < dim; j++) {
            y[j] = y[j] + (k1[j] + 2.0*k2[j] + 2.0*k3[j] + k4[j]) / 6.0;
        }
        x = x + h;

        sol.x.push_back(x);
        sol.y.push_back(y);
    }

    return sol;
}

/**
 * @brief Ejemplo 1: y' = y, y(0) = 1
 * Solución exacta: y = e^x
 */
void ejemplo1_exponencial() {
    cout << "\n" << string(75, '=') << endl;
    cout << "EJEMPLO 1: y' = y, y(0) = 1" << endl;
    cout << "Solución exacta: y = e^x" << endl;
    cout << string(75, '=') << endl;

    auto f = [](double x, double y) { return y; };

    double x0 = 0.0;
    double y0 = 1.0;
    double x_final = 1.0;
    double h = 0.1;
    int n_pasos = (int)((x_final - x0) / h);

    SolucionEDO sol_euler = euler(f, x0, y0, h, n_pasos);
    SolucionEDO sol_rk2 = rk2(f, x0, y0, h, n_pasos);
    SolucionEDO sol_rk4 = rk4(f, x0, y0, h, n_pasos);

    cout << "\n┌────────┬─────────────┬─────────────┬─────────────┬─────────────┐" << endl;
    cout << "│   x    │    Exacta   │    Euler    │     RK2     │     RK4     │" << endl;
    cout << "├────────┼─────────────┼─────────────┼─────────────┼─────────────┤" << endl;

    for (size_t i = 0; i <= n_pasos; i++) {
        double x = sol_euler.x[i];
        double exacta = exp(x);
        double y_euler = sol_euler.y[i];
        double y_rk2 = sol_rk2.y[i];
        double y_rk4 = sol_rk4.y[i];

        cout << "│ " << fixed << setprecision(1) << setw(6) << x
             << " │ " << setprecision(8) << setw(11) << exacta
             << " │ " << setw(11) << y_euler
             << " │ " << setw(11) << y_rk2
             << " │ " << setw(11) << y_rk4
             << " │" << endl;
    }

    cout << "└────────┴─────────────┴─────────────┴─────────────┴─────────────┘" << endl;

    // Análisis de errores
    cout << "\nERRORES EN x = " << x_final << ":" << endl;
    double exacta = exp(x_final);
    double error_euler = abs(sol_euler.y.back() - exacta);
    double error_rk2 = abs(sol_rk2.y.back() - exacta);
    double error_rk4 = abs(sol_rk4.y.back() - exacta);

    cout << fixed << setprecision(8);
    cout << "Euler:  " << scientific << error_euler << " (" << fixed
         << (error_euler/exacta)*100 << "%)" << endl;
    cout << "RK2:    " << scientific << error_rk2 << " (" << fixed
         << (error_rk2/exacta)*100 << "%)" << endl;
    cout << "RK4:    " << scientific << error_rk4 << " (" << fixed
         << (error_rk4/exacta)*100 << "%)" << endl;
}

/**
 * @brief Ejemplo 2: Crecimiento logístico
 * y' = r*y*(1 - y/K), donde r es tasa de crecimiento y K es capacidad de carga
 */
void ejemplo2_logistico() {
    cout << "\n" << string(75, '=') << endl;
    cout << "EJEMPLO 2: CRECIMIENTO LOGÍSTICO" << endl;
    cout << "y' = r*y*(1 - y/K)" << endl;
    cout << "r = 0.5 (tasa de crecimiento)" << endl;
    cout << "K = 100 (capacidad de carga)" << endl;
    cout << string(75, '=') << endl;

    double r = 0.5;
    double K = 100.0;
    auto f = [r, K](double x, double y) {
        return r * y * (1.0 - y / K);
    };

    double x0 = 0.0;
    double y0 = 10.0;  // Población inicial
    double x_final = 20.0;
    double h = 0.5;
    int n_pasos = (int)((x_final - x0) / h);

    SolucionEDO sol = rk4(f, x0, y0, h, n_pasos);

    cout << "\n┌────────┬─────────────┬─────────────┐" << endl;
    cout << "│ Tiempo │  Población  │  Tasa crec. │" << endl;
    cout << "├────────┼─────────────┼─────────────┤" << endl;

    for (size_t i = 0; i < sol.x.size(); i += 2) {  // Mostrar cada 2 pasos
        double x = sol.x[i];
        double y = sol.y[i];
        double dy_dx = f(x, y);

        cout << "│ " << fixed << setprecision(1) << setw(6) << x
             << " │ " << setprecision(4) << setw(11) << y
             << " │ " << setw(11) << dy_dx
             << " │" << endl;
    }

    cout << "└────────┴─────────────┴─────────────┘" << endl;

    cout << "\nObservación: La población se estabiliza cerca de K = " << K << endl;
    cout << "Población final: " << fixed << setprecision(2) << sol.y.back() << endl;
}

/**
 * @brief Ejemplo 3: Oscilador armónico simple
 * y'' + ω²y = 0
 * Convertido a sistema: y₁' = y₂, y₂' = -ω²y₁
 */
void ejemplo3_oscilador() {
    cout << "\n" << string(75, '=') << endl;
    cout << "EJEMPLO 3: OSCILADOR ARMÓNICO SIMPLE" << endl;
    cout << "y'' + ω²y = 0" << endl;
    cout << "Condiciones: y(0) = 1, y'(0) = 0" << endl;
    cout << "ω = 2π (frecuencia angular)" << endl;
    cout << string(75, '=') << endl;

    double omega = 2.0 * M_PI;  // frecuencia angular

    // Sistema: y₁' = y₂, y₂' = -ω²y₁
    auto f = [omega](double t, const vector<double>& y) {
        vector<double> dydt(2);
        dydt[0] = y[1];              // y₁' = y₂
        dydt[1] = -omega*omega*y[0]; // y₂' = -ω²y₁
        return dydt;
    };

    double t0 = 0.0;
    vector<double> y0 = {1.0, 0.0};  // y(0) = 1, y'(0) = 0
    double t_final = 2.0;
    double h = 0.01;
    int n_pasos = (int)((t_final - t0) / h);

    SolucionSistema sol = rk4_sistema(f, t0, y0, h, n_pasos);

    cout << "\n┌────────┬─────────────┬─────────────┬─────────────┐" << endl;
    cout << "│ Tiempo │  Posición   │  Velocidad  │   Energía   │" << endl;
    cout << "├────────┼─────────────┼─────────────┼─────────────┤" << endl;

    for (size_t i = 0; i < sol.x.size(); i += 20) {  // Mostrar cada 20 pasos
        double t = sol.x[i];
        double pos = sol.y[i][0];
        double vel = sol.y[i][1];
        // Energía = (1/2)mv² + (1/2)kx² (asumiendo m=1, k=ω²)
        double energia = 0.5 * vel*vel + 0.5 * omega*omega * pos*pos;

        cout << "│ " << fixed << setprecision(2) << setw(6) << t
             << " │ " << setprecision(6) << setw(11) << pos
             << " │ " << setw(11) << vel
             << " │ " << setw(11) << energia
             << " │" << endl;
    }

    cout << "└────────┴─────────────┴─────────────┴─────────────┘" << endl;

    // Solución exacta: y = cos(ωt)
    double pos_final_exacta = cos(omega * t_final);
    double pos_final_numerica = sol.y.back()[0];

    cout << "\nEn t = " << t_final << ":" << endl;
    cout << "Posición exacta:    " << fixed << setprecision(10) << pos_final_exacta << endl;
    cout << "Posición numérica:  " << pos_final_numerica << endl;
    cout << "Error:              " << scientific << setprecision(4)
         << abs(pos_final_numerica - pos_final_exacta) << endl;

    cout << "\nNota: La energía debería conservarse (≈ 19.7392)" << endl;
}

/**
 * @brief Ejemplo 4: Modelo depredador-presa (Lotka-Volterra)
 */
void ejemplo4_lotka_volterra() {
    cout << "\n" << string(75, '=') << endl;
    cout << "EJEMPLO 4: MODELO DEPREDADOR-PRESA (LOTKA-VOLTERRA)" << endl;
    cout << "dx/dt = αx - βxy  (presas)" << endl;
    cout << "dy/dt = δxy - γy  (depredadores)" << endl;
    cout << string(75, '=') << endl;

    // Parámetros del modelo
    double alpha = 1.0;  // Tasa de crecimiento de presas
    double beta = 0.1;   // Tasa de depredación
    double delta = 0.075; // Eficiencia de conversión
    double gamma = 1.5;  // Tasa de muerte de depredadores

    auto f = [alpha, beta, delta, gamma](double t, const vector<double>& y) {
        double x = y[0];  // Presas
        double p = y[1];  // Depredadores

        vector<double> dydt(2);
        dydt[0] = alpha * x - beta * x * p;
        dydt[1] = delta * x * p - gamma * p;
        return dydt;
    };

    double t0 = 0.0;
    vector<double> y0 = {40.0, 9.0};  // Poblaciones iniciales
    double t_final = 50.0;
    double h = 0.1;
    int n_pasos = (int)((t_final - t0) / h);

    SolucionSistema sol = rk4_sistema(f, t0, y0, h, n_pasos);

    cout << "\n┌────────┬─────────────┬─────────────┐" << endl;
    cout << "│ Tiempo │    Presas   │ Depredadores│" << endl;
    cout << "├────────┼─────────────┼─────────────┤" << endl;

    for (size_t i = 0; i < sol.x.size(); i += 50) {  // Mostrar cada 50 pasos
        double t = sol.x[i];
        double presas = sol.y[i][0];
        double depredadores = sol.y[i][1];

        cout << "│ " << fixed << setprecision(1) << setw(6) << t
             << " │ " << setprecision(4) << setw(11) << presas
             << " │ " << setw(11) << depredadores
             << " │" << endl;
    }

    cout << "└────────┴─────────────┴─────────────┘" << endl;

    cout << "\nEste modelo muestra oscilaciones periódicas en las poblaciones." << endl;
    cout << "Cuando hay muchas presas, los depredadores aumentan." << endl;
    cout << "Cuando hay muchos depredadores, las presas disminuyen." << endl;
}

/**
 * @brief Guardar datos para graficar
 */
void guardar_datos(const string& filename, const SolucionEDO& sol) {
    ofstream file(filename);
    for (size_t i = 0; i < sol.x.size(); i++) {
        file << sol.x[i] << " " << sol.y[i] << "\n";
    }
    file.close();
    cout << "Datos guardados en " << filename << endl;
}

/**
 * @brief Función principal
 */
int main() {
    cout << "╔═══════════════════════════════════════════════════════════════════════╗" << endl;
    cout << "║        ECUACIONES DIFERENCIALES ORDINARIAS - ANÁLISIS NUMÉRICO        ║" << endl;
    cout << "╚═══════════════════════════════════════════════════════════════════════╝" << endl;

    ejemplo1_exponencial();
    ejemplo2_logistico();
    ejemplo3_oscilador();
    ejemplo4_lotka_volterra();

    cout << "\n╔═══════════════════════════════════════════════════════════════════════╗" << endl;
    cout << "║ PRINCIPIOS CLAVE DE MÉTODOS NUMÉRICOS PARA EDOs:                     ║" << endl;
    cout << "╠═══════════════════════════════════════════════════════════════════════╣" << endl;
    cout << "║ 1. Euler: Simple, error O(h), útil solo para prototipado             ║" << endl;
    cout << "║ 2. RK4: Método estándar, error O(h⁴), excelente precisión            ║" << endl;
    cout << "║ 3. Paso h más pequeño → mayor precisión pero más costo               ║" << endl;
    cout << "║ 4. EDOs de orden superior → sistema de primer orden                  ║" << endl;
    cout << "║ 5. Verificar conservación (energía, masa, etc.) cuando aplique       ║" << endl;
    cout << "║ 6. RK4 es el mejor balance entre precisión y eficiencia               ║" << endl;
    cout << "╚═══════════════════════════════════════════════════════════════════════╝" << endl;

    return 0;
}
