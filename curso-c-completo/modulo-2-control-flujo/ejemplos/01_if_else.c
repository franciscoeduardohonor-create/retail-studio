/*
 * ============================================================================
 * PROGRAMA: Estructuras Condicionales (if, else)
 * DESCRIPCIÓN: Aprende a tomar decisiones en tus programas
 * NIVEL: Principiante-Intermedio
 * ============================================================================
 */

#include <stdio.h>

int main() {

    // ========== IF SIMPLE ==========

    printf("========== IF SIMPLE ==========\n\n");

    int edad = 20;

    /*
     * Sintaxis:
     * if (condición) {
     *     // código a ejecutar si la condición es verdadera
     * }
     */

    if (edad >= 18) {
        printf("Eres mayor de edad\n");
    }

    printf("\n");

    // ========== IF-ELSE ==========

    printf("========== IF-ELSE ==========\n\n");

    int temperatura = 25;

    /*
     * if-else ejecuta un bloque u otro dependiendo de la condición
     */

    if (temperatura > 30) {
        printf("Hace calor\n");
    } else {
        printf("La temperatura es agradable\n");
    }

    printf("\n");

    // ========== IF-ELSE IF-ELSE ==========

    printf("========== IF-ELSE IF-ELSE ==========\n\n");

    int nota = 85;

    /*
     * Podemos encadenar múltiples condiciones
     * Se evalúan en orden y se ejecuta el primer bloque verdadero
     */

    if (nota >= 90) {
        printf("Calificación: A (Excelente)\n");
    } else if (nota >= 80) {
        printf("Calificación: B (Muy bien)\n");
    } else if (nota >= 70) {
        printf("Calificación: C (Bien)\n");
    } else if (nota >= 60) {
        printf("Calificación: D (Suficiente)\n");
    } else {
        printf("Calificación: F (Reprobado)\n");
    }

    printf("\n");

    // ========== IF ANIDADOS ==========

    printf("========== IF ANIDADOS ==========\n\n");

    int hora = 14;
    int es_fin_de_semana = 0;  // 0 = falso, 1 = verdadero

    if (hora < 20) {
        if (es_fin_de_semana) {
            printf("Es temprano y es fin de semana. ¡Disfruta!\n");
        } else {
            printf("Es temprano, pero es día laboral\n");
        }
    } else {
        printf("Es tarde\n");
    }

    printf("\n");

    // ========== CONDICIONES COMPUESTAS ==========

    printf("========== CONDICIONES COMPUESTAS ==========\n\n");

    int edad_usuario = 25;
    int tiene_licencia = 1;

    // AND (&&) - Ambas condiciones deben ser verdaderas
    if (edad_usuario >= 18 && tiene_licencia) {
        printf("Puede conducir\n");
    } else {
        printf("No puede conducir\n");
    }

    int es_estudiante = 1;
    int es_profesor = 0;

    // OR (||) - Al menos una condición debe ser verdadera
    if (es_estudiante || es_profesor) {
        printf("Tiene acceso a la biblioteca\n");
    }

    int edad_pelicula = 17;
    int con_adulto = 0;

    // Combinación de operadores lógicos
    if (edad_pelicula >= 18 || (edad_pelicula >= 13 && con_adulto)) {
        printf("Puede ver la película\n");
    } else {
        printf("No puede ver la película\n");
    }

    printf("\n");

    // ========== EJEMPLO PRÁCTICO: SISTEMA DE LOGIN ==========

    printf("========== SISTEMA DE LOGIN ==========\n\n");

    char usuario_correcto[] = "admin";
    char password_correcto[] = "1234";

    char usuario[50];
    char password[50];

    printf("Usuario: ");
    scanf("%s", usuario);

    printf("Contraseña: ");
    scanf("%s", password);

    // Nota: strcmp() compara strings (lo veremos mejor en el módulo 3)
    // Por ahora, asumimos comparación simple

    printf("\nValidando...\n");

    // Simulación simple (en realidad necesitamos strcmp())
    printf("En un programa real, aquí validaríamos las credenciales\n");

    printf("\n");

    // ========== EJEMPLO PRÁCTICO: CALCULADORA DE IMC ==========

    printf("========== CALCULADORA DE IMC MEJORADA ==========\n\n");

    float peso, altura_m, imc;

    printf("Ingresa tu peso (kg): ");
    scanf("%f", &peso);

    printf("Ingresa tu altura (m): ");
    scanf("%f", &altura_m);

    // Validación de entrada
    if (peso <= 0 || altura_m <= 0) {
        printf("\nERROR: Los valores deben ser positivos\n");
    } else {
        imc = peso / (altura_m * altura_m);

        printf("\nTu IMC es: %.2f\n", imc);

        // Clasificación del IMC
        if (imc < 18.5) {
            printf("Clasificación: Bajo peso\n");
            printf("Recomendación: Consulta a un nutricionista\n");
        } else if (imc >= 18.5 && imc < 25.0) {
            printf("Clasificación: Peso normal\n");
            printf("Recomendación: Mantén tu estilo de vida saludable\n");
        } else if (imc >= 25.0 && imc < 30.0) {
            printf("Clasificación: Sobrepeso\n");
            printf("Recomendación: Considera ejercicio regular\n");
        } else {
            printf("Clasificación: Obesidad\n");
            printf("Recomendación: Consulta a un médico\n");
        }
    }

    printf("\n");

    // ========== EJEMPLO: DETERMINADOR DE NÚMEROS ==========

    printf("========== ANALIZADOR DE NÚMEROS ==========\n\n");

    int numero;

    printf("Ingresa un número: ");
    scanf("%d", &numero);

    printf("\nAnálisis del número %d:\n", numero);

    // Positivo, negativo o cero
    if (numero > 0) {
        printf("  • Es positivo\n");
    } else if (numero < 0) {
        printf("  • Es negativo\n");
    } else {
        printf("  • Es cero\n");
    }

    // Par o impar (solo si no es cero)
    if (numero != 0) {
        if (numero % 2 == 0) {
            printf("  • Es par\n");
        } else {
            printf("  • Es impar\n");
        }
    }

    // Múltiplo de 5
    if (numero % 5 == 0) {
        printf("  • Es múltiplo de 5\n");
    }

    // Múltiplo de 10
    if (numero % 10 == 0) {
        printf("  • Es múltiplo de 10\n");
    }

    return 0;
}

/*
 * CONCEPTOS CLAVE:
 *
 * SINTAXIS DE IF:
 *   if (condición) {
 *       // código
 *   }
 *
 * SINTAXIS DE IF-ELSE:
 *   if (condición) {
 *       // código si verdadero
 *   } else {
 *       // código si falso
 *   }
 *
 * SINTAXIS DE IF-ELSE IF-ELSE:
 *   if (condición1) {
 *       // código si condición1 es verdadera
 *   } else if (condición2) {
 *       // código si condición2 es verdadera
 *   } else {
 *       // código si ninguna es verdadera
 *   }
 *
 * OPERADORES LÓGICOS:
 *   &&  AND (y)    - Ambas condiciones deben ser verdaderas
 *   ||  OR (o)     - Al menos una debe ser verdadera
 *   !   NOT (no)   - Invierte la condición
 *
 * BUENAS PRÁCTICAS:
 *
 * 1. Usa llaves {} incluso para una sola línea (más legible y seguro)
 * 2. Indenta correctamente tu código
 * 3. Agrupa condiciones relacionadas con paréntesis
 * 4. Valida entrada del usuario
 * 5. Ordena las condiciones de más específica a más general
 *
 * ERRORES COMUNES:
 *
 * 1. Usar = en lugar de ==:
 *    ✗ if (x = 5)    // Esto ASIGNA 5 a x
 *    ✓ if (x == 5)   // Esto COMPARA x con 5
 *
 * 2. Punto y coma después de if:
 *    ✗ if (x > 5);   // El ; termina el if
 *        printf("Mayor"); // Esto SIEMPRE se ejecuta
 *
 * 3. Confundir && con ||:
 *    - Usa && cuando TODAS las condiciones deben cumplirse
 *    - Usa || cuando CUALQUIERA puede cumplirse
 *
 * EJERCICIOS:
 *
 * 1. Programa que determine si un año es bisiesto:
 *    - Divisible entre 4 Y (no divisible entre 100 O divisible entre 400)
 *
 * 2. Calculadora de descuentos:
 *    - 0-10% si compra < $100
 *    - 10% si compra $100-$500
 *    - 20% si compra > $500
 *
 * 3. Clasificador de triángulos:
 *    - Lee 3 lados
 *    - Determina si es equilátero, isósceles o escaleno
 *    - Valida que los lados puedan formar un triángulo
 *
 * 4. Sistema de calificación con condiciones:
 *    - Si la nota es >= 90 y asistencia >= 80%: A
 *    - Si la nota es >= 80 o participación > 50: B
 *    - etc.
 *
 * 5. Determina si una persona puede:
 *    - Votar (>= 18)
 *    - Conducir (>= 16 con permiso, >= 18 sin permiso)
 *    - Jubilarse (>= 65)
 */
