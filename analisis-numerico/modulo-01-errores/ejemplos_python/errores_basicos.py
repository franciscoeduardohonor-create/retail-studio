"""
Errores Absolutos y Relativos en Python
========================================

Este script demuestra cómo calcular y analizar diferentes tipos de errores
en análisis numérico usando Python y NumPy.

Conceptos clave:
- Error absoluto
- Error relativo
- Error porcentual
- Propagación de errores
- Visualización de errores
"""

import numpy as np
import matplotlib.pyplot as plt
from typing import Tuple

class CalculadorError:
    """Clase para calcular diferentes tipos de errores"""

    def __init__(self, valor_exacto: float, valor_aproximado: float):
        """
        Inicializa el calculador de errores

        Args:
            valor_exacto: Valor de referencia o exacto
            valor_aproximado: Valor calculado o aproximado
        """
        self.valor_exacto = valor_exacto
        self.valor_aproximado = valor_aproximado

    def error_absoluto(self) -> float:
        """
        Calcula el error absoluto

        Returns:
            Error absoluto = |valor_exacto - valor_aproximado|
        """
        return abs(self.valor_exacto - self.valor_aproximado)

    def error_relativo(self) -> float:
        """
        Calcula el error relativo

        Returns:
            Error relativo = error_absoluto / |valor_exacto|
        """
        if abs(self.valor_exacto) < 1e-15:
            return float('inf')
        return self.error_absoluto() / abs(self.valor_exacto)

    def error_porcentual(self) -> float:
        """
        Calcula el error porcentual

        Returns:
            Error porcentual = error_relativo × 100%
        """
        return self.error_relativo() * 100.0

    def cifras_significativas(self) -> int:
        """
        Estima el número de cifras significativas correctas

        Returns:
            Número de cifras significativas
        """
        err_rel = self.error_relativo()
        if err_rel == 0.0:
            return 15  # Precisión máxima de float64
        if err_rel >= 1.0:
            return 0
        return int(-np.log10(err_rel))

    def mostrar_reporte(self):
        """Muestra un reporte completo de errores"""
        print(f"\nValor exacto:      {self.valor_exacto:.15f}")
        print(f"Valor aproximado:  {self.valor_aproximado:.15f}")
        print(f"\nError absoluto:    {self.error_absoluto():.6e}")
        print(f"Error relativo:    {self.error_relativo():.6e}")
        print(f"Error porcentual:  {self.error_porcentual():.8f} %")
        print(f"Cifras significativas correctas: {self.cifras_significativas()}")


def ejemplo1_aproximaciones_pi():
    """Ejemplo 1: Diferentes aproximaciones históricas de π"""
    print("\n" + "="*70)
    print("EJEMPLO 1: APROXIMACIONES DE π")
    print("="*70)

    PI_EXACTO = np.pi

    # Aproximaciones históricas
    aproximaciones = {
        "Antigua (22/7)": 22/7,
        "Arquímedes": 3.1418,
        "Ptolemeo": 3.14166,
        "Zu Chongzhi (355/113)": 355/113,
        "Al-Kashi": 3.14159265358979,
        "Moderna": 3.14159265
    }

    resultados = []
    for nombre, valor in aproximaciones.items():
        print(f"\nAproximación: {nombre}")
        calc = CalculadorError(PI_EXACTO, valor)
        calc.mostrar_reporte()
        resultados.append({
            'nombre': nombre,
            'error_abs': calc.error_absoluto(),
            'error_rel': calc.error_relativo()
        })

    return resultados


def ejemplo2_serie_e():
    """Ejemplo 2: Aproximación de e mediante serie de Taylor"""
    print("\n" + "="*70)
    print("EJEMPLO 2: APROXIMACIÓN DE e MEDIANTE SERIE")
    print("="*70)

    E_EXACTO = np.e
    print(f"\nCalculando e mediante serie: e = 1 + 1/1! + 1/2! + 1/3! + ...")

    print("\n┌──────────┬─────────────────┬─────────────┬─────────────┬──────────┐")
    print("│ Términos │ Aproximación    │ Error Abs   │ Error Rel   │  Cifras  │")
    print("├──────────┼─────────────────┼─────────────┼─────────────┼──────────┤")

    suma = 0.0
    factorial = 1.0
    errores_abs = []
    terminos = []

    for n in range(21):
        if n > 0:
            factorial *= n
        suma += 1.0 / factorial

        if n % 2 == 0 or n > 10:
            calc = CalculadorError(E_EXACTO, suma)
            print(f"│ {n:8d} │ {suma:15.12f} │ {calc.error_absoluto():11.2e} │ "
                  f"{calc.error_relativo():11.2e} │ {calc.cifras_significativas():8d} │")

        terminos.append(n)
        errores_abs.append(abs(E_EXACTO - suma))

    print("└──────────┴─────────────────┴─────────────┴─────────────┴──────────┘")

    return terminos, errores_abs


def ejemplo3_raiz_cuadrada_heron():
    """Ejemplo 3: Método de Herón para raíces cuadradas"""
    print("\n" + "="*70)
    print("EJEMPLO 3: APROXIMACIÓN DE RAÍCES CUADRADAS")
    print("Método de Herón (Método Babilónico)")
    print("="*70)

    numero = 2.0
    exacto = np.sqrt(numero)

    print(f"\nCalculando √{numero} usando el método de Herón:")
    print(f"Fórmula: x_(n+1) = (x_n + S/x_n) / 2")

    print("\n┌────────┬─────────────────┬─────────────┬─────────────┐")
    print("│  Iter  │  Aproximación   │  Error Abs  │  Error Rel  │")
    print("├────────┼─────────────────┼─────────────┼─────────────┤")

    x = 1.0  # Estimación inicial
    iteraciones = []
    aproximaciones = []
    errores = []

    for i in range(11):
        calc = CalculadorError(exacto, x)
        print(f"│ {i:6d} │ {x:15.12f} │ {calc.error_absoluto():11.2e} │ "
              f"{calc.error_relativo():11.2e} │")

        iteraciones.append(i)
        aproximaciones.append(x)
        errores.append(calc.error_absoluto())

        # Siguiente iteración
        x = (x + numero / x) / 2.0

    print("└────────┴─────────────────┴─────────────┴─────────────┘")
    print(f"\nValor de referencia (np.sqrt): {exacto:.15f}")

    return iteraciones, aproximaciones, errores


def ejemplo4_propagacion_errores():
    """Ejemplo 4: Propagación de errores en operaciones"""
    print("\n" + "="*70)
    print("EJEMPLO 4: PROPAGACIÓN DE ERRORES EN OPERACIONES")
    print("="*70)

    # Valores con pequeño error
    a_exacto = 10.0
    b_exacto = 3.0

    a_aprox = 10.01  # 0.1% de error
    b_aprox = 3.003  # 0.1% de error

    print(f"\nValores de entrada:")
    print(f"a exacto = {a_exacto:.6f}, a aproximado = {a_aprox:.6f}")
    print(f"b exacto = {b_exacto:.6f}, b aproximado = {b_aprox:.6f}")

    err_a = CalculadorError(a_exacto, a_aprox)
    err_b = CalculadorError(b_exacto, b_aprox)

    print(f"\nErrores de entrada:")
    print(f"Error en a: {err_a.error_porcentual():.6f}%")
    print(f"Error en b: {err_b.error_porcentual():.6f}%")

    print("\n┌─────────────────┬───────────┬───────────┬─────────────┐")
    print("│   Operación     │  Exacto   │  Aprox    │  Error %    │")
    print("├─────────────────┼───────────┼───────────┼─────────────┤")

    operaciones = {
        "a + b": (a_exacto + b_exacto, a_aprox + b_aprox),
        "a - b": (a_exacto - b_exacto, a_aprox - b_aprox),
        "a × b": (a_exacto * b_exacto, a_aprox * b_aprox),
        "a ÷ b": (a_exacto / b_exacto, a_aprox / b_aprox),
    }

    for nombre, (exacto, aprox) in operaciones.items():
        calc = CalculadorError(exacto, aprox)
        print(f"│ {nombre:15s} │ {exacto:9.6f} │ {aprox:9.6f} │ "
              f"{calc.error_porcentual():11.6f} │")

    print("└─────────────────┴───────────┴───────────┴─────────────┘")

    print("\nObservación: Los errores se propagan de forma diferente")
    print("según la operación. En general:")
    print("  - Suma/Resta: Los errores absolutos se suman")
    print("  - Multiplicación/División: Los errores relativos se suman")


def visualizar_convergencia():
    """Crea visualizaciones de la convergencia de errores"""
    print("\n" + "="*70)
    print("GENERANDO VISUALIZACIONES...")
    print("="*70)

    fig, axes = plt.subplots(2, 2, figsize=(14, 10))
    fig.suptitle('Análisis de Errores Numéricos', fontsize=16, fontweight='bold')

    # Gráfica 1: Serie de e
    terminos, errores_e = ejemplo2_serie_e()
    ax1 = axes[0, 0]
    ax1.semilogy(terminos, errores_e, 'b-o', linewidth=2, markersize=5)
    ax1.set_xlabel('Número de términos', fontsize=10)
    ax1.set_ylabel('Error absoluto', fontsize=10)
    ax1.set_title('Convergencia de la Serie para e', fontweight='bold')
    ax1.grid(True, alpha=0.3)

    # Gráfica 2: Método de Herón
    iters, aprox, errores_heron = ejemplo3_raiz_cuadrada_heron()
    ax2 = axes[0, 1]
    ax2.semilogy(iters, errores_heron, 'r-s', linewidth=2, markersize=5)
    ax2.set_xlabel('Iteración', fontsize=10)
    ax2.set_ylabel('Error absoluto', fontsize=10)
    ax2.set_title('Método de Herón para √2', fontweight='bold')
    ax2.grid(True, alpha=0.3)

    # Gráfica 3: Comparación de aproximaciones de π
    aproximaciones = {
        "22/7": 22/7,
        "Arq": 3.1418,
        "355/113": 355/113,
        "Al-Kashi": 3.14159265358979,
    }
    nombres = list(aproximaciones.keys())
    errores = [abs(np.pi - v) for v in aproximaciones.values()]

    ax3 = axes[1, 0]
    bars = ax3.bar(nombres, errores, color=['red', 'orange', 'yellow', 'green'])
    ax3.set_ylabel('Error absoluto', fontsize=10)
    ax3.set_title('Aproximaciones Históricas de π', fontweight='bold')
    ax3.set_yscale('log')
    ax3.grid(True, alpha=0.3, axis='y')

    # Añadir valores en las barras
    for bar, err in zip(bars, errores):
        height = bar.get_height()
        ax3.text(bar.get_x() + bar.get_width()/2., height,
                f'{err:.2e}', ha='center', va='bottom', fontsize=8)

    # Gráfica 4: Propagación de errores
    error_inicial = np.array([0.001, 0.005, 0.01, 0.05, 0.1])
    error_suma = error_inicial * 2  # Los errores se suman
    error_multiplicacion = error_inicial * 2  # Aproximadamente

    ax4 = axes[1, 1]
    x_pos = np.arange(len(error_inicial))
    width = 0.35

    ax4.bar(x_pos - width/2, error_inicial, width, label='Error inicial',
            color='blue', alpha=0.7)
    ax4.bar(x_pos + width/2, error_multiplicacion, width,
            label='Error propagado', color='red', alpha=0.7)

    ax4.set_xlabel('Caso', fontsize=10)
    ax4.set_ylabel('Error relativo', fontsize=10)
    ax4.set_title('Propagación de Errores', fontweight='bold')
    ax4.set_xticks(x_pos)
    ax4.set_xticklabels([f'{e:.1%}' for e in error_inicial])
    ax4.legend()
    ax4.grid(True, alpha=0.3, axis='y')

    plt.tight_layout()

    # Guardar la figura
    filename = 'errores_numericos.png'
    plt.savefig(filename, dpi=300, bbox_inches='tight')
    print(f"\n✓ Gráficas guardadas en: {filename}")

    # Mostrar
    plt.show()


def main():
    """Función principal que ejecuta todos los ejemplos"""
    print("╔══════════════════════════════════════════════════════════════════╗")
    print("║        ERRORES ABSOLUTOS Y RELATIVOS - ANÁLISIS NUMÉRICO         ║")
    print("╚══════════════════════════════════════════════════════════════════╝")

    ejemplo1_aproximaciones_pi()
    ejemplo2_serie_e()
    ejemplo3_raiz_cuadrada_heron()
    ejemplo4_propagacion_errores()

    # Visualizaciones
    respuesta = input("\n¿Deseas generar las visualizaciones? (s/n): ")
    if respuesta.lower() == 's':
        visualizar_convergencia()

    print("\n╔══════════════════════════════════════════════════════════════════╗")
    print("║ LECCIONES CLAVE:                                                 ║")
    print("╠══════════════════════════════════════════════════════════════════╣")
    print("║ 1. Error absoluto mide la magnitud de la diferencia             ║")
    print("║ 2. Error relativo es independiente de la escala                 ║")
    print("║ 3. Los errores se propagan en cálculos sucesivos                ║")
    print("║ 4. Más iteraciones generalmente → menor error                   ║")
    print("║ 5. Cifras significativas indican la confiabilidad del resultado ║")
    print("╚══════════════════════════════════════════════════════════════════╝")


if __name__ == "__main__":
    main()
