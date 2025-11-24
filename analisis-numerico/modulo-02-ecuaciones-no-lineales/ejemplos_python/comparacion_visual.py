"""
Comparación Visual de Métodos para Ecuaciones No Lineales
==========================================================

Este script compara los métodos de Bisección, Newton-Raphson y Secante
de manera visual, mostrando cómo convergen a la raíz.

Incluye:
- Implementación de los tres métodos
- Visualización gráfica de la convergencia
- Comparación de velocidad de convergencia
- Análisis de errores
"""

import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation
from typing import Callable, Tuple, List
import warnings
warnings.filterwarnings('ignore')


class SolucionadorRaices:
    """Clase que implementa diferentes métodos para encontrar raíces"""

    @staticmethod
    def biseccion(f: Callable, a: float, b: float, tol: float = 1e-6,
                  max_iter: int = 100) -> Tuple[float, List[float], bool]:
        """
        Método de Bisección

        Args:
            f: Función cuya raíz se busca
            a: Extremo izquierdo del intervalo
            b: Extremo derecho del intervalo
            tol: Tolerancia
            max_iter: Máximo número de iteraciones

        Returns:
            Tupla (raíz, historial, convergió)
        """
        if f(a) * f(b) > 0:
            print(f"Error: No hay cambio de signo en [{a}, {b}]")
            return None, [], False

        historial = []
        for _ in range(max_iter):
            c = (a + b) / 2.0
            historial.append(c)

            if abs(f(c)) < tol or abs(b - a) < tol:
                return c, historial, True

            if f(a) * f(c) < 0:
                b = c
            else:
                a = c

        return c, historial, False

    @staticmethod
    def newton_raphson(f: Callable, df: Callable, x0: float,
                      tol: float = 1e-6, max_iter: int = 100) -> Tuple[float, List[float], bool]:
        """
        Método de Newton-Raphson

        Args:
            f: Función cuya raíz se busca
            df: Derivada de f
            x0: Aproximación inicial
            tol: Tolerancia
            max_iter: Máximo número de iteraciones

        Returns:
            Tupla (raíz, historial, convergió)
        """
        x = x0
        historial = [x]

        for _ in range(max_iter):
            fx = f(x)
            dfx = df(x)

            if abs(dfx) < 1e-15:
                return x, historial, False

            x_nuevo = x - fx / dfx
            historial.append(x_nuevo)

            if abs(f(x_nuevo)) < tol or abs(x_nuevo - x) < tol:
                return x_nuevo, historial, True

            x = x_nuevo

        return x, historial, False

    @staticmethod
    def secante(f: Callable, x0: float, x1: float,
                tol: float = 1e-6, max_iter: int = 100) -> Tuple[float, List[float], bool]:
        """
        Método de la Secante

        Args:
            f: Función cuya raíz se busca
            x0, x1: Dos aproximaciones iniciales
            tol: Tolerancia
            max_iter: Máximo número de iteraciones

        Returns:
            Tupla (raíz, historial, convergió)
        """
        historial = [x0, x1]

        for _ in range(max_iter):
            fx0 = f(x0)
            fx1 = f(x1)

            if abs(fx1 - fx0) < 1e-15:
                return x1, historial, False

            # Fórmula de la secante
            x_nuevo = x1 - fx1 * (x1 - x0) / (fx1 - fx0)
            historial.append(x_nuevo)

            if abs(f(x_nuevo)) < tol or abs(x_nuevo - x1) < tol:
                return x_nuevo, historial, True

            x0, x1 = x1, x_nuevo

        return x1, historial, False


def ejemplo1_comparacion_convergencia():
    """Compara la velocidad de convergencia de los tres métodos"""
    print("="*75)
    print("EJEMPLO 1: COMPARACIÓN DE CONVERGENCIA")
    print("Ecuación: x² - 2 = 0 (encontrar √2)")
    print("="*75)

    # Definir función y derivada
    f = lambda x: x**2 - 2
    df = lambda x: 2*x

    valor_exacto = np.sqrt(2)

    # Aplicar los tres métodos
    raiz_bis, hist_bis, conv_bis = SolucionadorRaices.biseccion(f, 1, 2, 1e-10)
    raiz_newton, hist_newton, conv_newton = SolucionadorRaices.newton_raphson(
        f, df, 1.5, 1e-10)
    raiz_sec, hist_sec, conv_sec = SolucionadorRaices.secante(f, 1, 2, 1e-10)

    # Crear figura con subplots
    fig, axes = plt.subplots(2, 2, figsize=(14, 10))
    fig.suptitle('Comparación de Métodos para Encontrar √2', fontsize=16, fontweight='bold')

    # Subplot 1: La función
    ax1 = axes[0, 0]
    x = np.linspace(0.5, 2.5, 1000)
    ax1.plot(x, f(x), 'b-', linewidth=2, label='f(x) = x² - 2')
    ax1.axhline(y=0, color='k', linestyle='--', alpha=0.3)
    ax1.axvline(x=valor_exacto, color='r', linestyle='--', alpha=0.5, label=f'√2 = {valor_exacto:.6f}')
    ax1.grid(True, alpha=0.3)
    ax1.set_xlabel('x')
    ax1.set_ylabel('f(x)')
    ax1.set_title('Función f(x) = x² - 2')
    ax1.legend()

    # Subplot 2: Convergencia de aproximaciones
    ax2 = axes[0, 1]
    ax2.plot(range(len(hist_bis)), hist_bis, 'o-', label='Bisección', linewidth=2, markersize=6)
    ax2.plot(range(len(hist_newton)), hist_newton, 's-', label='Newton-Raphson', linewidth=2, markersize=6)
    ax2.plot(range(len(hist_sec)), hist_sec, '^-', label='Secante', linewidth=2, markersize=6)
    ax2.axhline(y=valor_exacto, color='r', linestyle='--', alpha=0.5, label='Valor exacto')
    ax2.set_xlabel('Iteración')
    ax2.set_ylabel('Aproximación')
    ax2.set_title('Convergencia de las Aproximaciones')
    ax2.legend()
    ax2.grid(True, alpha=0.3)

    # Subplot 3: Error en escala logarítmica
    ax3 = axes[1, 0]
    errores_bis = [abs(x - valor_exacto) for x in hist_bis]
    errores_newton = [abs(x - valor_exacto) for x in hist_newton]
    errores_sec = [abs(x - valor_exacto) for x in hist_sec]

    ax3.semilogy(range(len(errores_bis)), errores_bis, 'o-', label='Bisección', linewidth=2, markersize=6)
    ax3.semilogy(range(len(errores_newton)), errores_newton, 's-', label='Newton-Raphson', linewidth=2, markersize=6)
    ax3.semilogy(range(len(errores_sec)), errores_sec, '^-', label='Secante', linewidth=2, markersize=6)
    ax3.set_xlabel('Iteración')
    ax3.set_ylabel('Error Absoluto (escala log)')
    ax3.set_title('Convergencia del Error')
    ax3.legend()
    ax3.grid(True, alpha=0.3)

    # Subplot 4: Comparación de iteraciones necesarias
    ax4 = axes[1, 1]
    metodos = ['Bisección', 'Newton-Raphson', 'Secante']
    iteraciones = [len(hist_bis), len(hist_newton), len(hist_sec)]
    colores = ['blue', 'green', 'orange']

    bars = ax4.bar(metodos, iteraciones, color=colores, alpha=0.7)
    ax4.set_ylabel('Número de Iteraciones')
    ax4.set_title('Iteraciones Necesarias (tol = 1e-10)')
    ax4.grid(True, alpha=0.3, axis='y')

    # Añadir valores en las barras
    for bar, iter_count in zip(bars, iteraciones):
        height = bar.get_height()
        ax4.text(bar.get_x() + bar.get_width()/2., height,
                f'{iter_count}', ha='center', va='bottom', fontsize=12, fontweight='bold')

    plt.tight_layout()
    plt.savefig('comparacion_metodos.png', dpi=300, bbox_inches='tight')
    print("\n✓ Gráfica guardada como 'comparacion_metodos.png'")

    # Imprimir resultados
    print("\nRESULTADOS:")
    print(f"\nValor exacto: √2 = {valor_exacto:.15f}")
    print("\n┌──────────────────┬──────────────────┬──────────────┬──────────────┐")
    print("│     Método       │       Raíz       │  Iteraciones │  Error Final │")
    print("├──────────────────┼──────────────────┼──────────────┼──────────────┤")
    print(f"│ Bisección        │ {raiz_bis:16.15f} │ {len(hist_bis):12d} │ {abs(raiz_bis-valor_exacto):12.2e} │")
    print(f"│ Newton-Raphson   │ {raiz_newton:16.15f} │ {len(hist_newton):12d} │ {abs(raiz_newton-valor_exacto):12.2e} │")
    print(f"│ Secante          │ {raiz_sec:16.15f} │ {len(hist_sec):12d} │ {abs(raiz_sec-valor_exacto):12.2e} │")
    print("└──────────────────┴──────────────────┴──────────────┴──────────────┘")

    return fig


def ejemplo2_visualizar_newton():
    """Visualiza el proceso iterativo de Newton-Raphson"""
    print("\n" + "="*75)
    print("EJEMPLO 2: VISUALIZACIÓN DEL MÉTODO DE NEWTON-RAPHSON")
    print("Ecuación: x³ - x - 2 = 0")
    print("="*75)

    # Función y derivada
    f = lambda x: x**3 - x - 2
    df = lambda x: 3*x**2 - 1

    # Aplicar Newton-Raphson
    x0 = 1.5
    raiz, historial, convergencia = SolucionadorRaices.newton_raphson(f, df, x0, 1e-8)

    # Crear figura
    fig, ax = plt.subplots(figsize=(12, 8))

    # Graficar la función
    x = np.linspace(0.5, 2.5, 1000)
    ax.plot(x, f(x), 'b-', linewidth=2, label='f(x) = x³ - x - 2')
    ax.axhline(y=0, color='k', linestyle='--', alpha=0.3)
    ax.grid(True, alpha=0.3)

    # Colores para cada iteración
    colores = plt.cm.rainbow(np.linspace(0, 1, len(historial)))

    # Dibujar las tangentes
    for i in range(len(historial) - 1):
        xi = historial[i]
        xi_next = historial[i + 1]
        fxi = f(xi)
        dfxi = df(xi)

        # Punto en la curva
        ax.plot(xi, fxi, 'o', color=colores[i], markersize=10, zorder=5)

        # Línea tangente
        x_tangent = np.array([xi - 0.5, xi + 0.5])
        y_tangent = fxi + dfxi * (x_tangent - xi)
        ax.plot(x_tangent, y_tangent, '--', color=colores[i], linewidth=1.5,
                alpha=0.6, label=f'Iter {i}: x={xi:.4f}')

        # Línea vertical al eje x
        ax.plot([xi_next, xi_next], [0, f(xi_next)], ':', color=colores[i],
                alpha=0.4, linewidth=1)

    # Última aproximación
    ax.plot(historial[-1], f(historial[-1]), 'r*', markersize=20,
            label=f'Raíz: {historial[-1]:.6f}', zorder=10)

    ax.set_xlabel('x', fontsize=12)
    ax.set_ylabel('f(x)', fontsize=12)
    ax.set_title('Visualización del Método de Newton-Raphson', fontsize=14, fontweight='bold')
    ax.legend(loc='best', fontsize=9)

    plt.tight_layout()
    plt.savefig('newton_raphson_visual.png', dpi=300, bbox_inches='tight')
    print("\n✓ Gráfica guardada como 'newton_raphson_visual.png'")

    print(f"\n✓ Raíz encontrada: x = {raiz:.15f}")
    print(f"Iteraciones: {len(historial)}")
    print(f"Verificación: f({raiz:.6f}) = {f(raiz):.6e}")

    return fig


def ejemplo3_orden_convergencia():
    """Analiza el orden de convergencia de cada método"""
    print("\n" + "="*75)
    print("EJEMPLO 3: ANÁLISIS DEL ORDEN DE CONVERGENCIA")
    print("="*75)

    # Función simple
    f = lambda x: x**2 - 2
    df = lambda x: 2*x
    valor_exacto = np.sqrt(2)

    # Aplicar métodos
    _, hist_bis, _ = SolucionadorRaices.biseccion(f, 1, 2, 1e-15)
    _, hist_newton, _ = SolucionadorRaices.newton_raphson(f, df, 1.5, 1e-15)
    _, hist_sec, _ = SolucionadorRaices.secante(f, 1, 2, 1e-15)

    # Calcular errores
    errores_bis = np.array([abs(x - valor_exacto) for x in hist_bis])
    errores_newton = np.array([abs(x - valor_exacto) for x in hist_newton])
    errores_sec = np.array([abs(x - valor_exacto) for x in hist_sec])

    # Crear figura
    fig, axes = plt.subplots(1, 3, figsize=(16, 5))
    fig.suptitle('Análisis del Orden de Convergencia', fontsize=16, fontweight='bold')

    # Función auxiliar para calcular ratios
    def calcular_ratios(errores, potencia=1):
        ratios = []
        for i in range(len(errores) - 1):
            if errores[i] > 1e-15:
                ratio = errores[i+1] / (errores[i]**potencia)
                ratios.append(ratio)
        return ratios

    # Bisección: convergencia lineal (e_n+1 / e_n ≈ constante ≈ 0.5)
    ax1 = axes[0]
    ratios_bis = calcular_ratios(errores_bis[:-1], potencia=1)
    ax1.plot(ratios_bis, 'o-', linewidth=2, markersize=8)
    ax1.axhline(y=0.5, color='r', linestyle='--', label='Ratio teórico = 0.5')
    ax1.set_xlabel('Iteración')
    ax1.set_ylabel('e_(n+1) / e_n')
    ax1.set_title('Bisección: Convergencia Lineal')
    ax1.legend()
    ax1.grid(True, alpha=0.3)

    # Newton-Raphson: convergencia cuadrática (e_n+1 / e_n² ≈ constante)
    ax2 = axes[1]
    ratios_newton = calcular_ratios(errores_newton[:-1], potencia=2)
    ax2.plot(ratios_newton, 's-', linewidth=2, markersize=8, color='green')
    ax2.set_xlabel('Iteración')
    ax2.set_ylabel('e_(n+1) / e_n²')
    ax2.set_title('Newton-Raphson: Convergencia Cuadrática')
    ax2.grid(True, alpha=0.3)

    # Secante: convergencia superlineal (e_n+1 / e_n^1.618 ≈ constante)
    ax3 = axes[2]
    phi = (1 + np.sqrt(5)) / 2  # Razón áurea ≈ 1.618
    ratios_sec = calcular_ratios(errores_sec[:-1], potencia=phi)
    ax3.plot(ratios_sec, '^-', linewidth=2, markersize=8, color='orange')
    ax3.set_xlabel('Iteración')
    ax3.set_ylabel(f'e_(n+1) / e_n^{phi:.3f}')
    ax3.set_title('Secante: Convergencia Superlineal')
    ax3.grid(True, alpha=0.3)

    plt.tight_layout()
    plt.savefig('orden_convergencia.png', dpi=300, bbox_inches='tight')
    print("\n✓ Gráfica guardada como 'orden_convergencia.png'")

    print("\nORDEN DE CONVERGENCIA:")
    print("  • Bisección:      Lineal      (e_n+1 ≈ 0.5 × e_n)")
    print("  • Newton-Raphson: Cuadrático  (e_n+1 ≈ C × e_n²)")
    print("  • Secante:        Superlineal (e_n+1 ≈ C × e_n^1.618)")


def main():
    """Función principal"""
    print("╔═══════════════════════════════════════════════════════════════════════╗")
    print("║       COMPARACIÓN VISUAL DE MÉTODOS - ECUACIONES NO LINEALES          ║")
    print("╚═══════════════════════════════════════════════════════════════════════╝")

    # Ejecutar ejemplos
    ejemplo1_comparacion_convergencia()
    ejemplo2_visualizar_newton()
    ejemplo3_orden_convergencia()

    print("\n" + "="*75)
    print("CONCLUSIONES:")
    print("="*75)
    print("\n1. BISECCIÓN:")
    print("   ✓ Más robusto (siempre converge con cambio de signo)")
    print("   ✗ Más lento (convergencia lineal)")
    print("   → Usar para localizar raíces o cuando robustez es crítica")

    print("\n2. NEWTON-RAPHSON:")
    print("   ✓ Más rápido (convergencia cuadrática)")
    print("   ✗ Requiere derivada")
    print("   ✗ Sensible a x₀")
    print("   → Usar cuando tienes buena aproximación y puedes calcular f'")

    print("\n3. SECANTE:")
    print("   ✓ Rápido (convergencia superlineal)")
    print("   ✓ No requiere derivada")
    print("   ✗ Menos robusto que bisección")
    print("   → Compromiso entre bisección y Newton-Raphson")

    print("\n" + "="*75)
    print("Todas las gráficas han sido guardadas.")
    print("="*75)

    plt.show()


if __name__ == "__main__":
    main()
