/*
 * ============================================================================
 * PROGRAMA: Operadores en C
 * DESCRIPCIÓN: Todos los operadores: aritméticos, relacionales, lógicos, etc.
 * NIVEL: Principiante
 * ============================================================================
 */

#include <stdio.h>

int main() {

    // ========== OPERADORES ARITMÉTICOS ==========

    printf("========== OPERADORES ARITMÉTICOS ==========\n\n");

    int a = 10;
    int b = 3;

    printf("a = %d, b = %d\n\n", a, b);

    // Suma
    printf("a + b = %d\n", a + b);

    // Resta
    printf("a - b = %d\n", a - b);

    // Multiplicación
    printf("a * b = %d\n", a * b);

    // División (con enteros, el resultado es entero)
    printf("a / b = %d (división entera)\n", a / b);

    // División con decimales
    printf("a / b = %.2f (con decimales)\n", (float)a / b);

    // Módulo (residuo de la división)
    printf("a %% b = %d (residuo)\n", a % b);

    // ========== OPERADORES DE ASIGNACIÓN ==========

    printf("\n========== OPERADORES DE ASIGNACIÓN ==========\n\n");

    int x = 5;
    printf("x inicial = %d\n", x);

    // Suma y asigna
    x += 3;  // Equivalente a: x = x + 3
    printf("x += 3 → x = %d\n", x);

    // Resta y asigna
    x -= 2;  // Equivalente a: x = x - 2
    printf("x -= 2 → x = %d\n", x);

    // Multiplica y asigna
    x *= 2;  // Equivalente a: x = x * 2
    printf("x *= 2 → x = %d\n", x);

    // Divide y asigna
    x /= 3;  // Equivalente a: x = x / 3
    printf("x /= 3 → x = %d\n", x);

    // Módulo y asigna
    x %= 3;  // Equivalente a: x = x % 3
    printf("x %%= 3 → x = %d\n", x);

    // ========== OPERADORES DE INCREMENTO Y DECREMENTO ==========

    printf("\n========== INCREMENTO Y DECREMENTO ==========\n\n");

    int contador = 10;

    // Post-incremento (primero usa, luego incrementa)
    printf("contador = %d\n", contador);
    printf("contador++ = %d (usa el valor actual)\n", contador++);
    printf("contador ahora = %d\n", contador);

    printf("\n");

    // Pre-incremento (primero incrementa, luego usa)
    printf("contador = %d\n", contador);
    printf("++contador = %d (usa el valor incrementado)\n", ++contador);
    printf("contador ahora = %d\n", contador);

    printf("\n");

    // Post-decremento
    printf("contador-- = %d\n", contador--);
    printf("contador ahora = %d\n", contador);

    // Pre-decremento
    printf("--contador = %d\n", --contador);

    // ========== OPERADORES RELACIONALES ==========

    printf("\n========== OPERADORES RELACIONALES ==========\n\n");

    int num1 = 10;
    int num2 = 20;

    printf("num1 = %d, num2 = %d\n\n", num1, num2);

    // En C: 1 = verdadero, 0 = falso

    printf("num1 == num2 → %d (igual a)\n", num1 == num2);
    printf("num1 != num2 → %d (diferente de)\n", num1 != num2);
    printf("num1 > num2  → %d (mayor que)\n", num1 > num2);
    printf("num1 < num2  → %d (menor que)\n", num1 < num2);
    printf("num1 >= num2 → %d (mayor o igual)\n", num1 >= num2);
    printf("num1 <= num2 → %d (menor o igual)\n", num1 <= num2);

    // ========== OPERADORES LÓGICOS ==========

    printf("\n========== OPERADORES LÓGICOS ==========\n\n");

    int verdadero = 1;
    int falso = 0;

    printf("verdadero = %d, falso = %d\n\n", verdadero, falso);

    // AND lógico (&&) - Ambos deben ser verdaderos
    printf("verdadero && verdadero = %d\n", verdadero && verdadero);
    printf("verdadero && falso = %d\n", verdadero && falso);
    printf("falso && falso = %d\n", falso && falso);

    printf("\n");

    // OR lógico (||) - Al menos uno debe ser verdadero
    printf("verdadero || verdadero = %d\n", verdadero || verdadero);
    printf("verdadero || falso = %d\n", verdadero || falso);
    printf("falso || falso = %d\n", falso || falso);

    printf("\n");

    // NOT lógico (!) - Invierte el valor
    printf("!verdadero = %d\n", !verdadero);
    printf("!falso = %d\n", !falso);

    // ========== EJEMPLO PRÁCTICO: VALIDACIÓN ==========

    printf("\n========== EJEMPLO PRÁCTICO ==========\n\n");

    int edad = 25;
    int tiene_licencia = 1;

    printf("Edad: %d\n", edad);
    printf("Tiene licencia: %d\n\n", tiene_licencia);

    // Puede conducir si tiene 18 o más Y tiene licencia
    int puede_conducir = (edad >= 18) && tiene_licencia;
    printf("¿Puede conducir? %d\n", puede_conducir);

    // Es estudiante o trabajador
    int es_estudiante = 1;
    int es_trabajador = 0;
    int tiene_ocupacion = es_estudiante || es_trabajador;
    printf("¿Tiene ocupación? %d\n", tiene_ocupacion);

    // ========== OPERADOR TERNARIO ==========

    printf("\n========== OPERADOR TERNARIO ==========\n\n");

    /*
     * Sintaxis: condición ? valor_si_verdadero : valor_si_falso
     * Es una forma abreviada de if-else
     */

    int nota = 85;
    char *resultado = (nota >= 60) ? "Aprobado" : "Reprobado";

    printf("Nota: %d\n", nota);
    printf("Resultado: %s\n", resultado);

    // Otro ejemplo
    int numero = -5;
    int absoluto = (numero >= 0) ? numero : -numero;
    printf("\nValor absoluto de %d es %d\n", numero, absoluto);

    // ========== PRECEDENCIA DE OPERADORES ==========

    printf("\n========== PRECEDENCIA DE OPERADORES ==========\n\n");

    int resultado;

    // Los operadores tienen un orden de evaluación
    resultado = 5 + 3 * 2;
    printf("5 + 3 * 2 = %d (primero *, luego +)\n", resultado);

    resultado = (5 + 3) * 2;
    printf("(5 + 3) * 2 = %d (paréntesis primero)\n", resultado);

    resultado = 10 / 2 * 3;
    printf("10 / 2 * 3 = %d (izquierda a derecha)\n", resultado);

    resultado = 2 + 3 > 4;
    printf("2 + 3 > 4 = %d (aritmética antes que relacional)\n", resultado);

    // ========== CONVERSIÓN DE TIPOS ==========

    printf("\n========== CONVERSIÓN DE TIPOS ==========\n\n");

    int entero = 10;
    int divisor = 3;

    // División entera
    printf("10 / 3 = %d (enteros)\n", entero / divisor);

    // Conversión explícita (casting)
    printf("10 / 3 = %.2f (con cast a float)\n", (float)entero / divisor);

    // Conversión implícita
    float decimal = entero / 2.0;  // 2.0 es float, convierte todo
    printf("10 / 2.0 = %.2f\n", decimal);

    return 0;
}

/*
 * TABLA DE OPERADORES:
 *
 * ARITMÉTICOS:
 *   +    Suma
 *   -    Resta
 *   *    Multiplicación
 *   /    División
 *   %    Módulo (residuo)
 *
 * ASIGNACIÓN:
 *   =    Asigna
 *   +=   Suma y asigna
 *   -=   Resta y asigna
 *   *=   Multiplica y asigna
 *   /=   Divide y asigna
 *   %=   Módulo y asigna
 *
 * INCREMENTO/DECREMENTO:
 *   ++   Incrementa en 1
 *   --   Decrementa en 1
 *
 * RELACIONALES:
 *   ==   Igual a
 *   !=   Diferente de
 *   >    Mayor que
 *   <    Menor que
 *   >=   Mayor o igual
 *   <=   Menor o igual
 *
 * LÓGICOS:
 *   &&   AND (y)
 *   ||   OR (o)
 *   !    NOT (no)
 *
 * PRECEDENCIA (de mayor a menor):
 *   1. ()                    Paréntesis
 *   2. !, ++, --             Unarios
 *   3. *, /, %               Multiplicación, división, módulo
 *   4. +, -                  Suma, resta
 *   5. <, <=, >, >=          Relacionales
 *   6. ==, !=                Igualdad
 *   7. &&                    AND lógico
 *   8. ||                    OR lógico
 *   9. ?:                    Ternario
 *   10. =, +=, -=, etc.      Asignación
 *
 * TIPS:
 *
 * 1. Usa paréntesis cuando tengas dudas sobre precedencia
 * 2. && y || usan "evaluación de corto circuito"
 * 3. Ten cuidado con = (asignación) vs == (comparación)
 * 4. El módulo (%) solo funciona con enteros
 * 5. División de enteros siempre da entero (10/3 = 3, no 3.33)
 *
 * EJERCICIOS:
 *
 * 1. Escribe un programa que calcule:
 *    - El área de un triángulo (base * altura / 2)
 *    - El perímetro de un rectángulo (2 * largo + 2 * ancho)
 *
 * 2. Conversor de tiempo:
 *    - Lee segundos totales
 *    - Calcula horas, minutos y segundos
 *    - Pista: usa división (/) y módulo (%)
 *
 * 3. Determina si un número es par o impar usando el operador ternario
 *
 * 4. Calcula el promedio de 4 números y determina si es mayor a 70
 *
 * 5. Programa que determine si una persona puede votar:
 *    - Debe tener 18 o más años
 *    - Debe ser ciudadano
 *    - Usa operadores lógicos
 */
