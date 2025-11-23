/*
 * ============================================================================
 * PROGRAMA: Calculadora Simple
 * DESCRIPCIÓN: Proyecto práctico que integra todo lo aprendido en el módulo 1
 * NIVEL: Principiante
 * ============================================================================
 */

#include <stdio.h>

int main() {

    // Variables para almacenar los números y el resultado
    float numero1, numero2;
    char operador;
    float resultado;

    // ========== BANNER DE BIENVENIDA ==========

    printf("\n");
    printf("╔════════════════════════════════════╗\n");
    printf("║    CALCULADORA SIMPLE EN C         ║\n");
    printf("║    Versión 1.0                     ║\n");
    printf("╚════════════════════════════════════╝\n");
    printf("\n");

    // ========== INSTRUCCIONES ==========

    printf("Operadores disponibles:\n");
    printf("  + : Suma\n");
    printf("  - : Resta\n");
    printf("  * : Multiplicación\n");
    printf("  / : División\n");
    printf("  %% : Módulo (residuo)\n");
    printf("\n");

    // ========== ENTRADA DE DATOS ==========

    printf("Ingresa el primer número: ");
    scanf("%f", &numero1);

    printf("Ingresa el operador (+, -, *, /, %%): ");
    scanf(" %c", &operador);  // Espacio antes de %c para limpiar buffer

    printf("Ingresa el segundo número: ");
    scanf("%f", &numero2);

    // ========== PROCESAMIENTO ==========

    printf("\n");
    printf("═══════════════════════════════════════\n");

    /*
     * Usamos una serie de if para determinar qué operación realizar
     * Nota: En el módulo 2 aprenderemos switch, que es más elegante
     */

    if (operador == '+') {
        resultado = numero1 + numero2;
        printf("%.2f + %.2f = %.2f\n", numero1, numero2, resultado);

    } else if (operador == '-') {
        resultado = numero1 - numero2;
        printf("%.2f - %.2f = %.2f\n", numero1, numero2, resultado);

    } else if (operador == '*') {
        resultado = numero1 * numero2;
        printf("%.2f × %.2f = %.2f\n", numero1, numero2, resultado);

    } else if (operador == '/') {
        // Validación: no se puede dividir entre cero
        if (numero2 != 0) {
            resultado = numero1 / numero2;
            printf("%.2f ÷ %.2f = %.2f\n", numero1, numero2, resultado);
        } else {
            printf("ERROR: No se puede dividir entre cero\n");
        }

    } else if (operador == '%') {
        // El módulo solo funciona con enteros
        // Convertimos a int para la operación
        int num1_int = (int)numero1;
        int num2_int = (int)numero2;

        if (num2_int != 0) {
            int resultado_int = num1_int % num2_int;
            printf("%d %% %d = %d\n", num1_int, num2_int, resultado_int);
        } else {
            printf("ERROR: No se puede calcular módulo con divisor cero\n");
        }

    } else {
        // Operador no válido
        printf("ERROR: Operador '%c' no reconocido\n", operador);
    }

    printf("═══════════════════════════════════════\n");

    // ========== INFORMACIÓN ADICIONAL ==========

    printf("\nInformación adicional:\n");

    // Determinar cuál número es mayor
    if (numero1 > numero2) {
        printf("  • %.2f es mayor que %.2f\n", numero1, numero2);
    } else if (numero1 < numero2) {
        printf("  • %.2f es menor que %.2f\n", numero1, numero2);
    } else {
        printf("  • Los números son iguales\n");
    }

    // Calcular promedio
    float promedio = (numero1 + numero2) / 2;
    printf("  • Promedio: %.2f\n", promedio);

    // Determinar si los números son positivos o negativos
    printf("  • Primer número: %s\n",
           (numero1 > 0) ? "positivo" : (numero1 < 0) ? "negativo" : "cero");
    printf("  • Segundo número: %s\n",
           (numero2 > 0) ? "positivo" : (numero2 < 0) ? "negativo" : "cero");

    printf("\n");
    printf("¡Gracias por usar la calculadora!\n\n");

    return 0;
}

/*
 * CONCEPTOS UTILIZADOS EN ESTE PROGRAMA:
 *
 * 1. VARIABLES:
 *    - float para números decimales
 *    - char para el operador
 *
 * 2. ENTRADA/SALIDA:
 *    - printf() para mostrar información
 *    - scanf() para leer datos del usuario
 *
 * 3. OPERADORES:
 *    - Aritméticos: +, -, *, /, %
 *    - Relacionales: ==, !=, >, <
 *    - Lógicos: && (implícito en validaciones)
 *    - Ternario: ?: para mensajes condicionales
 *
 * 4. ESTRUCTURAS DE CONTROL:
 *    - if / else if / else
 *    - Validación de entrada
 *
 * 5. CONVERSIÓN DE TIPOS:
 *    - (int) para convertir float a int en el módulo
 *
 * MEJORAS QUE APRENDERÁS EN MÓDULOS FUTUROS:
 *
 * 1. Usar switch en lugar de múltiples if
 * 2. Crear funciones para cada operación
 * 3. Agregar un bucle para hacer múltiples cálculos
 * 4. Validar entrada más robustamente
 * 5. Crear un historial de operaciones
 *
 * EJERCICIOS PARA EXPANDIR ESTE PROGRAMA:
 *
 * 1. Agrega más operaciones:
 *    - Potencia (numero1 ^ numero2)
 *    - Raíz cuadrada (necesitarás #include <math.h>)
 *
 * 2. Agrega validación:
 *    - Verifica que el operador sea válido
 *    - Muestra un mensaje de error específico
 *
 * 3. Estadísticas:
 *    - Calcula la diferencia absoluta entre los números
 *    - Determina si ambos números son pares o impares
 *
 * 4. Mejora la presentación:
 *    - Agrega más caracteres decorativos
 *    - Usa colores (búsca códigos ANSI)
 *
 * 5. Operaciones múltiples:
 *    - Calcula suma, resta, multiplicación y división en una sola ejecución
 *    - Muestra una tabla con todos los resultados
 *
 * DESAFÍO AVANZADO:
 * Modifica el programa para que funcione como una calculadora científica
 * que incluya: seno, coseno, tangente, logaritmo, exponencial, etc.
 * (Pista: necesitarás #include <math.h> y las funciones sin(), cos(), etc.)
 */
