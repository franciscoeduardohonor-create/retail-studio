/*
 * ============================================================================
 * PROGRAMA: Bucle While
 * DESCRIPCIÓN: Repite código mientras una condición sea verdadera
 * NIVEL: Principiante-Intermedio
 * ============================================================================
 */

#include <stdio.h>

int main() {

    // ========== WHILE BÁSICO ==========

    printf("========== WHILE BÁSICO ==========\n\n");

    /*
     * Sintaxis:
     * while (condición) {
     *     // código a repetir
     * }
     *
     * Se evalúa la condición ANTES de cada iteración
     * Si es falsa desde el inicio, el bucle nunca se ejecuta
     */

    int contador = 1;

    while (contador <= 5) {
        printf("Iteración %d\n", contador);
        contador++;  // IMPORTANTE: actualizar la variable
    }

    printf("\n");

    // ========== CONTADOR DESCENDENTE ==========

    printf("========== CUENTA REGRESIVA ==========\n\n");

    int cuenta = 10;

    while (cuenta > 0) {
        printf("%d...\n", cuenta);
        cuenta--;
    }
    printf("¡Despegue! 🚀\n\n");

    // ========== SUMA ACUMULATIVA ==========

    printf("========== SUMA DE NÚMEROS ==========\n\n");

    int numero = 1;
    int suma = 0;

    // Suma números del 1 al 10
    while (numero <= 10) {
        suma += numero;  // suma = suma + numero
        numero++;
    }

    printf("La suma de 1 a 10 es: %d\n\n", suma);

    // ========== ENTRADA CONTROLADA POR USUARIO ==========

    printf("========== VALIDACIÓN DE ENTRADA ==========\n\n");

    int edad;

    // Solicita edad hasta que sea válida
    printf("Ingresa tu edad (1-120): ");
    scanf("%d", &edad);

    while (edad < 1 || edad > 120) {
        printf("Edad inválida. Intenta de nuevo (1-120): ");
        scanf("%d", &edad);
    }

    printf("Edad registrada: %d años\n\n", edad);

    // ========== TABLA DE MULTIPLICAR ==========

    printf("========== TABLA DE MULTIPLICAR ==========\n\n");

    int tabla, i;

    printf("¿Qué tabla quieres? ");
    scanf("%d", &tabla);

    printf("\nTabla del %d:\n", tabla);
    printf("─────────────\n");

    i = 1;
    while (i <= 10) {
        printf("%d × %d = %d\n", tabla, i, tabla * i);
        i++;
    }

    printf("\n");

    // ========== SUMA DE NÚMEROS INGRESADOS ==========

    printf("========== SUMA DE NÚMEROS ==========\n\n");

    int num, total = 0;

    printf("Ingresa números (0 para terminar):\n");

    scanf("%d", &num);

    while (num != 0) {
        total += num;
        printf("Suma parcial: %d\n", total);
        printf("Siguiente número: ");
        scanf("%d", &num);
    }

    printf("\nSuma total: %d\n\n", total);

    // ========== FACTORIAL ==========

    printf("========== FACTORIAL ==========\n\n");

    int n, factorial_num;
    long long factorial = 1;

    printf("Calcula el factorial de: ");
    scanf("%d", &n);

    factorial_num = n;

    while (factorial_num > 0) {
        factorial *= factorial_num;
        factorial_num--;
    }

    printf("%d! = %lld\n\n", n, factorial);

    // ========== NÚMERO MÁGICO (JUEGO) ==========

    printf("========== ADIVINA EL NÚMERO ==========\n\n");

    int numero_secreto = 42;
    int intento;

    printf("Adivina el número (1-100): ");
    scanf("%d", &intento);

    while (intento != numero_secreto) {
        if (intento < numero_secreto) {
            printf("Muy bajo. Intenta de nuevo: ");
        } else {
            printf("Muy alto. Intenta de nuevo: ");
        }
        scanf("%d", &intento);
    }

    printf("¡Correcto! El número era %d\n\n", numero_secreto);

    // ========== POTENCIA ==========

    printf("========== CÁLCULO DE POTENCIA ==========\n\n");

    int base, exponente, exp_temp;
    long long resultado = 1;

    printf("Base: ");
    scanf("%d", &base);

    printf("Exponente: ");
    scanf("%d", &exponente);

    exp_temp = exponente;

    while (exp_temp > 0) {
        resultado *= base;
        exp_temp--;
    }

    printf("%d^%d = %lld\n\n", base, exponente, resultado);

    // ========== DÍGITOS DE UN NÚMERO ==========

    printf("========== CONTAR DÍGITOS ==========\n\n");

    int numero_analizar, digitos = 0;

    printf("Ingresa un número: ");
    scanf("%d", &numero_analizar);

    int temp = numero_analizar;

    // Contar dígitos
    while (temp != 0) {
        temp /= 10;  // Elimina el último dígito
        digitos++;
    }

    printf("El número %d tiene %d dígito(s)\n\n", numero_analizar, digitos);

    // ========== INVERSIÓN DE DÍGITOS ==========

    printf("========== INVERTIR NÚMERO ==========\n\n");

    int original, invertido = 0, digito;

    printf("Ingresa un número: ");
    scanf("%d", &original);

    int copia = original;

    while (copia != 0) {
        digito = copia % 10;           // Obtiene último dígito
        invertido = invertido * 10 + digito;  // Lo agrega al inicio
        copia /= 10;                   // Elimina último dígito
    }

    printf("Número original: %d\n", original);
    printf("Número invertido: %d\n", invertido);

    return 0;
}

/*
 * CONCEPTOS CLAVE:
 *
 * SINTAXIS DE WHILE:
 *   while (condición) {
 *       // código a ejecutar
 *       // IMPORTANTE: actualizar variable de control
 *   }
 *
 * CÓMO FUNCIONA:
 *   1. Evalúa la condición
 *   2. Si es verdadera, ejecuta el bloque
 *   3. Vuelve al paso 1
 *   4. Si es falsa, continúa después del while
 *
 * COMPONENTES DE UN BUCLE:
 *
 * 1. INICIALIZACIÓN (antes del while):
 *    int i = 0;
 *
 * 2. CONDICIÓN (en el while):
 *    while (i < 10)
 *
 * 3. ACTUALIZACIÓN (dentro del while):
 *    i++;
 *
 * CUÁNDO USAR WHILE:
 *
 * ✓ No sabes cuántas iteraciones necesitas
 * ✓ Depende de entrada del usuario
 * ✓ Depende de una condición que puede cambiar
 * ✓ Validación de entrada
 * ✓ Menús interactivos
 * ✓ Lectura de archivos
 *
 * PATRONES COMUNES:
 *
 * 1. CONTADOR:
 *    int i = 1;
 *    while (i <= 10) {
 *        // hacer algo
 *        i++;
 *    }
 *
 * 2. CENTINELA (valor especial para terminar):
 *    int num;
 *    scanf("%d", &num);
 *    while (num != -1) {
 *        // procesar num
 *        scanf("%d", &num);
 *    }
 *
 * 3. BANDERA (flag):
 *    int continuar = 1;
 *    while (continuar) {
 *        // hacer algo
 *        if (condición) {
 *            continuar = 0;  // termina bucle
 *        }
 *    }
 *
 * 4. VALIDACIÓN:
 *    printf("Ingresa opción (1-5): ");
 *    scanf("%d", &opcion);
 *    while (opcion < 1 || opcion > 5) {
 *        printf("Inválido. Intenta de nuevo: ");
 *        scanf("%d", &opcion);
 *    }
 *
 * BUCLE INFINITO:
 *
 * Un bucle que nunca termina:
 *
 *   while (1) {  // 1 siempre es verdadero
 *       // código
 *       // Necesitas break o return para salir
 *   }
 *
 * Útil para menús principales que solo terminan cuando
 * el usuario selecciona "Salir"
 *
 * DIFERENCIA CON FOR:
 *
 * WHILE:
 *   - Mejor cuando no sabes cuántas iteraciones
 *   - Más flexible
 *   - Condición al principio
 *
 * FOR:
 *   - Mejor cuando sabes cuántas iteraciones
 *   - Más compacto
 *   - Todo en una línea
 *
 * ERRORES COMUNES:
 *
 * 1. BUCLE INFINITO (no actualizar variable):
 *    int i = 0;
 *    while (i < 10) {
 *        printf("%d\n", i);
 *        // ¡OLVIDO i++! Bucle infinito
 *    }
 *
 * 2. CONDICIÓN INCORRECTA:
 *    while (x = 5)  // ASIGNA 5, siempre verdadero
 *    while (x == 5) // COMPARA, correcto
 *
 * 3. PUNTO Y COMA DESPUÉS DE WHILE:
 *    while (i < 10);  // El ; termina el while
 *    {
 *        // Esto no es parte del while
 *    }
 *
 * 4. NO LEER ANTES DEL BUCLE (patrón centinela):
 *    while (num != 0) {  // num no tiene valor
 *        scanf("%d", &num);
 *    }
 *    // Correcto:
 *    scanf("%d", &num);  // Leer ANTES
 *    while (num != 0) {
 *        // procesar
 *        scanf("%d", &num);
 *    }
 *
 * BUENAS PRÁCTICAS:
 *
 * 1. Asegúrate de que el bucle pueda terminar
 * 2. Inicializa variables antes del bucle
 * 3. Actualiza la variable de control
 * 4. Usa nombres descriptivos para contadores
 * 5. Comenta bucles complejos
 * 6. Evita modificar variable de control en varios lugares
 *
 * EJERCICIOS:
 *
 * 1. Suma de números pares:
 *    - Suma todos los números pares del 1 al 100
 *
 * 2. Fibonacci:
 *    - Genera los primeros N números de Fibonacci
 *    - 0, 1, 1, 2, 3, 5, 8, 13, 21...
 *
 * 3. Menú de calculadora:
 *    - Muestra menú de opciones
 *    - Realiza operación
 *    - Repite hasta que usuario seleccione "Salir"
 *
 * 4. Validador de contraseña:
 *    - Pide contraseña
 *    - Da 3 intentos
 *    - Bloquea después de 3 fallos
 *
 * 5. Máximo Común Divisor (Algoritmo de Euclides):
 *    - Lee dos números
 *    - Calcula MCD usando while
 *
 * 6. Números primos:
 *    - Lee un número
 *    - Determina si es primo usando while
 *
 * 7. Palíndromo:
 *    - Lee un número
 *    - Determina si es palíndromo (igual al revés)
 */
