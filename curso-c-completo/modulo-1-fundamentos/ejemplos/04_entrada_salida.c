/*
 * ============================================================================
 * PROGRAMA: Entrada y Salida en C
 * DESCRIPCIÓN: Aprende a leer datos del usuario con scanf()
 * NIVEL: Principiante
 * ============================================================================
 */

#include <stdio.h>

int main() {

    // ========== LECTURA DE UN ENTERO ==========

    printf("========== LECTURA DE DATOS ==========\n\n");

    int edad;

    printf("¿Cuál es tu edad? ");

    /*
     * scanf() lee datos del teclado
     * &edad es la "dirección de memoria" de la variable edad
     * El & (ampersand) es OBLIGATORIO con scanf
     * %d indica que esperamos un número entero
     */
    scanf("%d", &edad);

    printf("Tienes %d años.\n\n", edad);

    // ========== LECTURA DE UN DECIMAL ==========

    float altura;

    printf("¿Cuál es tu altura en metros? ");
    scanf("%f", &altura);

    printf("Mides %.2f metros.\n\n", altura);

    // ========== LECTURA DE UN CARÁCTER ==========

    char inicial;

    printf("¿Cuál es la inicial de tu nombre? ");

    /*
     * IMPORTANTE: scanf deja un 'Enter' en el buffer
     * Usamos un espacio antes de %c para ignorar espacios en blanco
     */
    scanf(" %c", &inicial);

    printf("Tu inicial es: %c\n\n", inicial);

    // ========== LECTURA MÚLTIPLE ==========

    int dia, mes, anio;

    printf("Ingresa tu fecha de nacimiento (dd mm aaaa): ");
    // Podemos leer múltiples valores en un solo scanf
    scanf("%d %d %d", &dia, &mes, &anio);

    printf("Naciste el %d/%d/%d\n\n", dia, mes, anio);

    // ========== EJEMPLO PRÁCTICO: CALCULADORA DE IMC ==========

    printf("========== CALCULADORA DE IMC ==========\n\n");

    float peso, altura_m, imc;

    printf("Ingresa tu peso en kg: ");
    scanf("%f", &peso);

    printf("Ingresa tu altura en metros: ");
    scanf("%f", &altura_m);

    // IMC = peso / (altura * altura)
    imc = peso / (altura_m * altura_m);

    printf("\n--- RESULTADOS ---\n");
    printf("Peso: %.2f kg\n", peso);
    printf("Altura: %.2f m\n", altura_m);
    printf("Tu IMC es: %.2f\n", imc);

    // Interpretación del IMC
    printf("\nInterpretación:\n");
    printf("  Bajo peso: < 18.5\n");
    printf("  Normal: 18.5 - 24.9\n");
    printf("  Sobrepeso: 25.0 - 29.9\n");
    printf("  Obesidad: >= 30.0\n");

    // ========== FORMATO DE SALIDA AVANZADO ==========

    printf("\n========== FORMATO DE SALIDA ==========\n\n");

    int numero = 42;
    float pi = 3.14159;

    // Ancho de campo
    printf("Número con ancho 10: [%10d]\n", numero);
    printf("Número con ancho 5:  [%5d]\n", numero);

    // Alineación a la izquierda (con -)
    printf("Alineado izq:        [%-10d]\n", numero);

    // Rellenar con ceros
    printf("Rellenado con 0:     [%010d]\n", numero);

    // Decimales
    printf("\nPi con diferentes decimales:\n");
    printf("  2 decimales: %.2f\n", pi);
    printf("  4 decimales: %.4f\n", pi);
    printf("  8 decimales: %.8f\n", pi);

    // Notación científica
    printf("\nNotación científica: %e\n", pi);

    return 0;
}

/*
 * CONCEPTOS CLAVE:
 *
 * printf() - SALIDA:
 *   - Imprime datos en la pantalla
 *   - Usa especificadores de formato (%d, %f, %c, etc.)
 *   - No necesita & antes de las variables
 *
 * scanf() - ENTRADA:
 *   - Lee datos del teclado
 *   - Usa los mismos especificadores de formato
 *   - REQUIERE & antes de las variables (excepto con arrays/strings)
 *   - Espera a que el usuario presione Enter
 *
 * ESPECIFICADORES DE FORMATO COMUNES:
 *   %d o %i  - int
 *   %u       - unsigned int
 *   %ld      - long
 *   %f       - float o double (entrada)
 *   %lf      - double (entrada, recomendado)
 *   %c       - char
 *   %s       - string (cadena de texto)
 *
 * MODIFICADORES DE FORMATO:
 *   %10d     - Ancho mínimo de 10 caracteres
 *   %-10d    - Alineado a la izquierda
 *   %010d    - Rellena con ceros
 *   %.2f     - 2 decimales
 *   %10.2f   - Ancho 10, 2 decimales
 *
 * CARACTERES ESPECIALES:
 *   \n       - Nueva línea
 *   \t       - Tabulación
 *   \\       - Barra invertida
 *   \"       - Comillas dobles
 *
 * ERRORES COMUNES:
 *
 * 1. Olvidar el & en scanf:
 *    ✗ scanf("%d", edad);      // ERROR
 *    ✓ scanf("%d", &edad);     // CORRECTO
 *
 * 2. Usar %f para double en scanf:
 *    ✗ scanf("%f", &mi_double);   // Puede causar problemas
 *    ✓ scanf("%lf", &mi_double);  // CORRECTO
 *
 * 3. No limpiar el buffer antes de leer char:
 *    ✗ scanf("%c", &letra);    // Puede leer el Enter anterior
 *    ✓ scanf(" %c", &letra);   // El espacio limpia el buffer
 *
 * EJERCICIOS:
 *
 * 1. Programa que pida dos números y muestre:
 *    - Suma
 *    - Resta
 *    - Multiplicación
 *    - División
 *
 * 2. Conversor de temperaturas:
 *    - Lee temperatura en Celsius
 *    - Muestra equivalente en Fahrenheit
 *    - Fórmula: F = C * 9/5 + 32
 *
 * 3. Calculadora de área de círculo:
 *    - Lee el radio
 *    - Calcula área (π * radio²)
 *    - Calcula perímetro (2 * π * radio)
 *
 * 4. Programa que lea 3 notas y calcule el promedio
 *
 * 5. Conversor de monedas:
 *    - Lee cantidad en dólares
 *    - Lee tasa de cambio
 *    - Muestra equivalente en otra moneda
 */
