/*
 * ============================================================================
 * PROYECTO: Calculadora con Menú Interactivo
 * DESCRIPCIÓN: Integra todo lo aprendido en el módulo 2
 * NIVEL: Intermedio
 * ============================================================================
 */

#include <stdio.h>

// ========== PROTOTIPOS ==========

void mostrar_menu();
float sumar(float a, float b);
float restar(float a, float b);
float multiplicar(float a, float b);
float dividir(float a, float b);
float potencia(float base, int exp);
int factorial(int n);
void limpiar_pantalla();
void pausar();

// ========== FUNCIÓN PRINCIPAL ==========

int main() {
    int opcion;
    float num1, num2, resultado;
    int continuar = 1;

    printf("\n");
    printf("╔════════════════════════════════════════╗\n");
    printf("║   CALCULADORA AVANZADA EN C            ║\n");
    printf("║   Módulo 2 - Proyecto Final            ║\n");
    printf("╚════════════════════════════════════════╝\n");
    printf("\n");

    // Bucle principal del programa
    while (continuar) {
        mostrar_menu();

        printf("Selecciona una opción: ");
        scanf("%d", &opcion);

        // Validar opción
        if (opcion < 1 || opcion > 7) {
            printf("\n❌ Opción inválida. Intenta de nuevo.\n");
            pausar();
            continue;
        }

        // Opción de salida
        if (opcion == 7) {
            printf("\n¡Gracias por usar la calculadora!\n");
            printf("¡Hasta luego! 👋\n\n");
            continuar = 0;
            continue;
        }

        // Leer números (para todas las opciones excepto factorial)
        if (opcion != 6) {
            printf("\nIngresa el primer número: ");
            scanf("%f", &num1);

            if (opcion != 5) {  // Potencia usa int para exponente
                printf("Ingresa el segundo número: ");
                scanf("%f", &num2);
            }
        } else {
            // Factorial necesita un número entero
            int n;
            printf("\nIngresa un número entero: ");
            scanf("%d", &n);

            if (n < 0) {
                printf("❌ El factorial no existe para números negativos\n");
                pausar();
                continue;
            }

            resultado = factorial(n);
            printf("\n%d! = %.0f\n", n, resultado);
            pausar();
            continue;
        }

        // Realizar operación según opción seleccionada
        switch (opcion) {
            case 1:  // Suma
                resultado = sumar(num1, num2);
                printf("\n%.2f + %.2f = %.2f\n", num1, num2, resultado);
                break;

            case 2:  // Resta
                resultado = restar(num1, num2);
                printf("\n%.2f - %.2f = %.2f\n", num1, num2, resultado);
                break;

            case 3:  // Multiplicación
                resultado = multiplicar(num1, num2);
                printf("\n%.2f × %.2f = %.2f\n", num1, num2, resultado);
                break;

            case 4:  // División
                if (num2 == 0) {
                    printf("\n❌ Error: División entre cero\n");
                } else {
                    resultado = dividir(num1, num2);
                    printf("\n%.2f ÷ %.2f = %.2f\n", num1, num2, resultado);
                }
                break;

            case 5:  // Potencia
                {
                    int exp;
                    printf("Ingresa el exponente (entero): ");
                    scanf("%d", &exp);

                    resultado = potencia(num1, exp);
                    printf("\n%.2f^%d = %.2f\n", num1, exp, resultado);
                }
                break;
        }

        pausar();
    }

    return 0;
}

// ========== IMPLEMENTACIÓN DE FUNCIONES ==========

/*
 * Muestra el menú principal
 */
void mostrar_menu() {
    printf("\n");
    printf("┌────────────────────────────────────────┐\n");
    printf("│          MENÚ PRINCIPAL                │\n");
    printf("├────────────────────────────────────────┤\n");
    printf("│  1. ➕ Suma                            │\n");
    printf("│  2. ➖ Resta                           │\n");
    printf("│  3. ✖️  Multiplicación                  │\n");
    printf("│  4. ➗ División                         │\n");
    printf("│  5. 🔢 Potencia                        │\n");
    printf("│  6. 📊 Factorial                       │\n");
    printf("│  7. 🚪 Salir                           │\n");
    printf("└────────────────────────────────────────┘\n");
    printf("\n");
}

/*
 * Suma dos números
 */
float sumar(float a, float b) {
    return a + b;
}

/*
 * Resta dos números
 */
float restar(float a, float b) {
    return a - b;
}

/*
 * Multiplica dos números
 */
float multiplicar(float a, float b) {
    return a * b;
}

/*
 * Divide dos números
 */
float dividir(float a, float b) {
    return a / b;
}

/*
 * Calcula la potencia de un número
 * base^exponente
 */
float potencia(float base, int exp) {
    float resultado = 1;

    if (exp >= 0) {
        for (int i = 0; i < exp; i++) {
            resultado *= base;
        }
    } else {
        // Exponente negativo
        for (int i = 0; i < -exp; i++) {
            resultado /= base;
        }
    }

    return resultado;
}

/*
 * Calcula el factorial de un número
 * n! = n × (n-1) × (n-2) × ... × 1
 */
int factorial(int n) {
    int resultado = 1;

    for (int i = 2; i <= n; i++) {
        resultado *= i;
    }

    return resultado;
}

/*
 * Pausa la ejecución hasta que usuario presione Enter
 */
void pausar() {
    printf("\nPresiona Enter para continuar...");
    getchar();  // Consume el \n anterior
    getchar();  // Espera Enter del usuario
}

/*
 * CONCEPTOS INTEGRADOS EN ESTE PROYECTO:
 *
 * 1. FUNCIONES:
 *    - Prototipos
 *    - Parámetros
 *    - Valores de retorno
 *    - Funciones de utilidad
 *
 * 2. CONTROL DE FLUJO:
 *    - if/else
 *    - switch/case
 *    - while loop
 *    - for loop
 *
 * 3. VARIABLES:
 *    - Variables locales
 *    - Parámetros
 *    - Tipos diferentes (int, float)
 *
 * 4. ENTRADA/SALIDA:
 *    - printf con formato
 *    - scanf
 *    - Validación de entrada
 *
 * 5. OPERADORES:
 *    - Aritméticos
 *    - Relacionales
 *    - Lógicos
 *
 * MEJORAS POSIBLES:
 *
 * 1. Agregar más operaciones:
 *    - Raíz cuadrada
 *    - Logaritmo
 *    - Seno, coseno, tangente
 *
 * 2. Historial de operaciones:
 *    - Guardar las últimas 10 operaciones
 *    - Mostrar historial
 *
 * 3. Memoria:
 *    - Guardar resultado en memoria
 *    - Recuperar valor de memoria
 *
 * 4. Modo científico:
 *    - Notación científica
 *    - Constantes (π, e)
 *
 * 5. Validación mejorada:
 *    - Verificar overflow
 *    - Manejar entradas inválidas
 *
 * EJERCICIOS DE EXTENSIÓN:
 *
 * 1. Agrega una función para calcular raíz cuadrada
 *
 * 2. Implementa un menú de conversiones:
 *    - Temperatura
 *    - Distancia
 *    - Peso
 *
 * 3. Crea un sistema de login simple:
 *    - Usuario y contraseña
 *    - 3 intentos máximo
 *
 * 4. Implementa calculadora de estadística básica:
 *    - Media
 *    - Mediana
 *    - Moda
 *
 * 5. Agrega operaciones con matrices 2x2:
 *    - Suma de matrices
 *    - Multiplicación
 *    - Determinante
 */
