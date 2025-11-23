/*
 * ============================================================================
 * PROGRAMA: Bucle For
 * DESCRIPCIÓN: La estructura de bucle más común y compacta
 * NIVEL: Principiante-Intermedio
 * ============================================================================
 */

#include <stdio.h>

int main() {

    // ========== FOR BÁSICO ==========

    printf("========== FOR BÁSICO ==========\n\n");

    /*
     * Sintaxis:
     * for (inicialización; condición; actualización) {
     *     // código a ejecutar
     * }
     *
     * Todo en una línea: inicio, condición y actualización
     */

    for (int i = 1; i <= 5; i++) {
        printf("Iteración %d\n", i);
    }

    printf("\n");

    // ========== DESGLOSE DEL FOR ==========

    printf("========== CÓMO FUNCIONA FOR ==========\n\n");

    /*
     * for (int i = 0; i < 5; i++)
     *      ─┬─  ────┬────  ─┬─
     *       │       │       └─ 3. Después de cada iteración
     *       │       └───────── 2. Antes de cada iteración
     *       └───────────────── 1. Una sola vez al inicio
     */

    printf("Ejecución paso a paso:\n");

    for (int i = 0; i < 3; i++) {
        printf("  i = %d: Ejecutando iteración\n", i);
    }
    printf("  Bucle terminado\n\n");

    // ========== CONTADOR DESCENDENTE ==========

    printf("========== CUENTA REGRESIVA ==========\n\n");

    for (int i = 10; i >= 1; i--) {
        printf("%d... ", i);
    }
    printf("¡Despegue! 🚀\n\n");

    // ========== INCREMENTOS DIFERENTES ==========

    printf("========== INCREMENTOS PERSONALIZADOS ==========\n\n");

    // De 2 en 2
    printf("Números pares del 0 al 10:\n");
    for (int i = 0; i <= 10; i += 2) {
        printf("%d ", i);
    }
    printf("\n\n");

    // De 5 en 5
    printf("Múltiplos de 5 hasta 50:\n");
    for (int i = 0; i <= 50; i += 5) {
        printf("%d ", i);
    }
    printf("\n\n");

    // ========== TABLA DE MULTIPLICAR ==========

    printf("========== TABLA DE MULTIPLICAR ==========\n\n");

    int tabla = 7;

    printf("Tabla del %d:\n", tabla);
    printf("───────────────\n");

    for (int i = 1; i <= 10; i++) {
        printf("%d × %d = %d\n", tabla, i, tabla * i);
    }

    printf("\n");

    // ========== SUMA DE NÚMEROS ==========

    printf("========== SUMA DE NÚMEROS ==========\n\n");

    int suma = 0;

    for (int i = 1; i <= 100; i++) {
        suma += i;
    }

    printf("Suma de 1 a 100: %d\n\n", suma);

    // ========== FACTORIAL ==========

    printf("========== FACTORIAL ==========\n\n");

    int n = 5;
    long long factorial = 1;

    for (int i = 1; i <= n; i++) {
        factorial *= i;
    }

    printf("%d! = %lld\n\n", n, factorial);

    // ========== POTENCIA ==========

    printf("========== POTENCIA ==========\n\n");

    int base = 2;
    int exponente = 8;
    long long resultado = 1;

    for (int i = 0; i < exponente; i++) {
        resultado *= base;
    }

    printf("%d^%d = %lld\n\n", base, exponente, resultado);

    // ========== BUCLES ANIDADOS ==========

    printf("========== BUCLES ANIDADOS ==========\n\n");

    printf("Patrón de asteriscos:\n");

    for (int fila = 1; fila <= 5; fila++) {
        for (int columna = 1; columna <= fila; columna++) {
            printf("* ");
        }
        printf("\n");
    }

    printf("\n");

    // ========== TABLA PITAGÓRICA ==========

    printf("========== TABLA PITAGÓRICA (5×5) ==========\n\n");

    printf("    ");
    for (int i = 1; i <= 5; i++) {
        printf("%4d", i);
    }
    printf("\n");
    printf("   ────────────────────\n");

    for (int i = 1; i <= 5; i++) {
        printf("%2d │", i);
        for (int j = 1; j <= 5; j++) {
            printf("%4d", i * j);
        }
        printf("\n");
    }

    printf("\n");

    // ========== RECTÁNGULO DE ASTERISCOS ==========

    printf("========== RECTÁNGULO ==========\n\n");

    int filas = 4;
    int columnas = 8;

    for (int i = 0; i < filas; i++) {
        for (int j = 0; j < columnas; j++) {
            // Primera y última fila, o primera y última columna
            if (i == 0 || i == filas - 1 || j == 0 || j == columnas - 1) {
                printf("* ");
            } else {
                printf("  ");
            }
        }
        printf("\n");
    }

    printf("\n");

    // ========== TRIÁNGULO DE NÚMEROS ==========

    printf("========== TRIÁNGULO DE NÚMEROS ==========\n\n");

    for (int i = 1; i <= 5; i++) {
        for (int j = 1; j <= i; j++) {
            printf("%d ", j);
        }
        printf("\n");
    }

    printf("\n");

    // ========== NÚMEROS PRIMOS ==========

    printf("========== NÚMEROS PRIMOS HASTA 50 ==========\n\n");

    for (int num = 2; num <= 50; num++) {
        int es_primo = 1;  // Asumimos que es primo

        // Verificamos si tiene divisores
        for (int i = 2; i * i <= num; i++) {
            if (num % i == 0) {
                es_primo = 0;  // No es primo
                break;  // No necesitamos seguir verificando
            }
        }

        if (es_primo) {
            printf("%d ", num);
        }
    }

    printf("\n\n");

    // ========== SERIE FIBONACCI ==========

    printf("========== SERIE FIBONACCI ==========\n\n");

    int terminos = 10;
    int a = 0, b = 1, siguiente;

    printf("Primeros %d términos de Fibonacci:\n", terminos);
    printf("%d %d ", a, b);

    for (int i = 2; i < terminos; i++) {
        siguiente = a + b;
        printf("%d ", siguiente);
        a = b;
        b = siguiente;
    }

    printf("\n\n");

    // ========== FOR SIN ALGUNAS PARTES ==========

    printf("========== FOR FLEXIBLE ==========\n\n");

    // Inicialización fuera del for
    int contador = 0;
    for (; contador < 3; contador++) {
        printf("Contador: %d\n", contador);
    }

    printf("\n");

    // Actualización dentro del for
    int x = 0;
    for (; x < 3;) {
        printf("x = %d\n", x);
        x++;
    }

    printf("\n");

    // ========== MÚLTIPLES VARIABLES EN FOR ==========

    printf("========== MÚLTIPLES VARIABLES ==========\n\n");

    for (int i = 0, j = 10; i < j; i++, j--) {
        printf("i = %d, j = %d\n", i, j);
    }

    printf("\n");

    // ========== PATRONES AVANZADOS ==========

    printf("========== PIRÁMIDE DE ASTERISCOS ==========\n\n");

    int altura = 5;

    for (int i = 1; i <= altura; i++) {
        // Espacios
        for (int j = 1; j <= altura - i; j++) {
            printf(" ");
        }
        // Asteriscos
        for (int j = 1; j <= 2 * i - 1; j++) {
            printf("*");
        }
        printf("\n");
    }

    printf("\n");

    // ========== DIAMANTE ==========

    printf("========== DIAMANTE ==========\n\n");

    int tamano = 4;

    // Parte superior
    for (int i = 1; i <= tamano; i++) {
        for (int j = 1; j <= tamano - i; j++) printf(" ");
        for (int j = 1; j <= 2 * i - 1; j++) printf("*");
        printf("\n");
    }

    // Parte inferior
    for (int i = tamano - 1; i >= 1; i--) {
        for (int j = 1; j <= tamano - i; j++) printf(" ");
        for (int j = 1; j <= 2 * i - 1; j++) printf("*");
        printf("\n");
    }

    return 0;
}

/*
 * CONCEPTOS CLAVE:
 *
 * SINTAXIS COMPLETA:
 *   for (inicialización; condición; actualización) {
 *       // código
 *   }
 *
 * COMPONENTES:
 *   1. INICIALIZACIÓN: se ejecuta UNA vez al inicio
 *   2. CONDICIÓN: se evalúa ANTES de cada iteración
 *   3. ACTUALIZACIÓN: se ejecuta DESPUÉS de cada iteración
 *
 * FLUJO DE EJECUCIÓN:
 *   1. Ejecuta inicialización (una sola vez)
 *   2. Evalúa condición
 *   3. Si es falsa, termina
 *   4. Si es verdadera, ejecuta el cuerpo del bucle
 *   5. Ejecuta actualización
 *   6. Vuelve al paso 2
 *
 * CUÁNDO USAR FOR:
 *
 * ✓ Sabes cuántas iteraciones necesitas
 * ✓ Iterar sobre un rango (1 a 100)
 * ✓ Recorrer arrays (lo veremos en módulo 3)
 * ✓ Patrones y repeticiones predecibles
 * ✓ Tablas de multiplicar
 * ✓ Dibujar patrones
 *
 * FOR VS WHILE:
 *
 * FOR es mejor cuando:
 *   - Sabes el número de iteraciones
 *   - Usas un contador simple
 *   - Quieres código más compacto
 *
 * WHILE es mejor cuando:
 *   - No sabes cuántas iteraciones
 *   - La condición es compleja
 *   - Depende de entrada de usuario
 *
 * TODO FOR SE PUEDE ESCRIBIR COMO WHILE:
 *
 *   for (int i = 0; i < 10; i++) {
 *       printf("%d\n", i);
 *   }
 *
 *   Es equivalente a:
 *
 *   int i = 0;              // inicialización
 *   while (i < 10) {        // condición
 *       printf("%d\n", i);
 *       i++;                // actualización
 *   }
 *
 * BUCLES ANIDADOS:
 *
 * Un bucle dentro de otro:
 *
 *   for (int i = 0; i < 3; i++) {
 *       for (int j = 0; j < 4; j++) {
 *           printf("(%d,%d) ", i, j);
 *       }
 *       printf("\n");
 *   }
 *
 * El bucle interno se ejecuta COMPLETAMENTE por cada
 * iteración del bucle externo.
 *
 * COMPLEJIDAD DE BUCLES ANIDADOS:
 *   - 1 bucle de N iteraciones: O(N)
 *   - 2 bucles anidados de N: O(N²)
 *   - 3 bucles anidados de N: O(N³)
 *
 * VARIACIONES DEL FOR:
 *
 * 1. FOR INFINITO:
 *    for (;;) {  // Sin inicialización, condición ni actualización
 *        // Bucle infinito
 *        if (condición) break;
 *    }
 *
 * 2. MÚLTIPLES VARIABLES:
 *    for (int i = 0, j = 10; i < j; i++, j--) {
 *        // i sube, j baja
 *    }
 *
 * 3. ACTUALIZACIÓN COMPLEJA:
 *    for (int i = 1; i <= 100; i *= 2) {
 *        // 1, 2, 4, 8, 16, 32, 64
 *    }
 *
 * PATRONES COMUNES:
 *
 * 1. CONTADOR ASCENDENTE:
 *    for (int i = 0; i < N; i++)
 *
 * 2. CONTADOR DESCENDENTE:
 *    for (int i = N; i > 0; i--)
 *
 * 3. SALTOS:
 *    for (int i = 0; i < N; i += 2)  // De 2 en 2
 *
 * 4. POTENCIAS:
 *    for (int i = 1; i < 1000; i *= 2)  // 1, 2, 4, 8, ...
 *
 * ERRORES COMUNES:
 *
 * 1. ERROR DE OFF-BY-ONE:
 *    for (int i = 1; i <= 10; i++)  // 10 iteraciones
 *    for (int i = 0; i < 10; i++)   // 10 iteraciones
 *    for (int i = 0; i <= 10; i++)  // 11 iteraciones ⚠️
 *
 * 2. MODIFICAR VARIABLE DE CONTROL:
 *    for (int i = 0; i < 10; i++) {
 *        // ...
 *        i++;  // ¡NO HAGAS ESTO!
 *    }
 *
 * 3. PUNTO Y COMA DESPUÉS DE FOR:
 *    for (int i = 0; i < 10; i++);  // ¡El ; termina el bucle!
 *    {
 *        printf("Esto solo se ejecuta una vez\n");
 *    }
 *
 * 4. CONDICIÓN INCORRECTA:
 *    for (int i = 0; i != 10; i += 2)  // Bucle infinito si i salta 10
 *    for (int i = 0; i < 10; i += 2)   // Correcto
 *
 * BUENAS PRÁCTICAS:
 *
 * 1. Usa i, j, k para contadores simples
 * 2. Usa nombres descriptivos para bucles importantes
 * 3. Evita modificar la variable de control dentro del bucle
 * 4. Usa < en lugar de <= cuando sea posible (más claro)
 * 5. Mantén bucles anidados simples (máximo 2-3 niveles)
 * 6. Comenta bucles complejos
 *
 * EJERCICIOS:
 *
 * 1. Suma de números pares e impares por separado (1-100)
 *
 * 2. Tabla de multiplicar completa (1-10 × 1-10)
 *
 * 3. Números perfectos hasta 1000
 *    (número = suma de sus divisores, ej: 6 = 1+2+3)
 *
 * 4. Triángulo de Pascal:
 *         1
 *        1 1
 *       1 2 1
 *      1 3 3 1
 *     1 4 6 4 1
 *
 * 5. Patrón de letras:
 *    A
 *    BB
 *    CCC
 *    DDDD
 *
 * 6. Tabla de potencias:
 *    n  | n² | n³
 *    ---|----|-----
 *    1  | 1  | 1
 *    2  | 4  | 8
 *    ...
 *
 * 7. Números Armstrong (narcisistas):
 *    153 = 1³ + 5³ + 3³
 *
 * 8. Calculadora de suma de dígitos:
 *    1234 → 1+2+3+4 = 10
 */
