/*
 * MÓDULO 2: CONTROL DE FLUJO
 * Ejemplo 3: Bucles (Loops)
 *
 * Aprenderás:
 * - Bucle for
 * - Bucle while
 * - Bucle do-while
 * - break y continue
 * - Bucles anidados
 */

#include <iostream>

int main() {
    std::cout << "=== BUCLES EN C++ ===" << std::endl << std::endl;

    // BUCLE FOR
    // Úsalo cuando SABES cuántas veces quieres repetir algo
    std::cout << "--- BUCLE FOR ---" << std::endl;

    // Sintaxis: for (inicialización; condición; incremento)
    std::cout << "Números del 1 al 5: ";
    for (int i = 1; i <= 5; i++) {
        std::cout << i << " ";
    }
    std::cout << std::endl << std::endl;

    // FOR en orden inverso
    std::cout << "Cuenta regresiva: ";
    for (int i = 10; i >= 0; i--) {
        std::cout << i << " ";
    }
    std::cout << "¡Despegue!" << std::endl << std::endl;

    // FOR con incrementos diferentes
    std::cout << "Números pares del 0 al 10: ";
    for (int i = 0; i <= 10; i += 2) {  // i += 2 incrementa de 2 en 2
        std::cout << i << " ";
    }
    std::cout << std::endl << std::endl;

    // BUCLE WHILE
    // Úsalo cuando NO SABES cuántas veces se repetirá
    std::cout << "--- BUCLE WHILE ---" << std::endl;

    int contador = 1;
    std::cout << "Contando hasta 5 con while: ";

    while (contador <= 5) {
        std::cout << contador << " ";
        contador++;  // ¡No olvides incrementar o será infinito!
    }
    std::cout << std::endl << std::endl;

    // Ejemplo práctico: adivinar número
    std::cout << "--- JUEGO DE ADIVINANZA ---" << std::endl;
    int numeroSecreto = 7;
    int intento;
    int intentos = 0;

    std::cout << "Adivina el número (1-10): ";

    while (true) {  // Bucle infinito hasta que adivine
        std::cin >> intento;
        intentos++;

        if (intento == numeroSecreto) {
            std::cout << "¡Correcto! Lo adivinaste en " << intentos << " intentos" << std::endl;
            break;  // BREAK sale del bucle
        } else if (intento < numeroSecreto) {
            std::cout << "Muy bajo. Intenta de nuevo: ";
        } else {
            std::cout << "Muy alto. Intenta de nuevo: ";
        }
    }
    std::cout << std::endl;

    // BUCLE DO-WHILE
    // Se ejecuta AL MENOS UNA VEZ, luego verifica la condición
    std::cout << "--- BUCLE DO-WHILE ---" << std::endl;

    int numero;
    do {
        std::cout << "Ingresa un número positivo: ";
        std::cin >> numero;

        if (numero <= 0) {
            std::cout << "¡Debe ser positivo!" << std::endl;
        }
    } while (numero <= 0);  // Repite mientras sea inválido

    std::cout << "Gracias. Ingresaste: " << numero << std::endl << std::endl;

    // BREAK Y CONTINUE
    std::cout << "--- BREAK Y CONTINUE ---" << std::endl;

    // BREAK: Sale completamente del bucle
    std::cout << "Usando BREAK (sale al encontrar 5): ";
    for (int i = 1; i <= 10; i++) {
        if (i == 5) {
            break;  // Sale del bucle
        }
        std::cout << i << " ";
    }
    std::cout << std::endl;

    // CONTINUE: Salta a la siguiente iteración
    std::cout << "Usando CONTINUE (salta el 5): ";
    for (int i = 1; i <= 10; i++) {
        if (i == 5) {
            continue;  // Salta esta iteración, va a la siguiente
        }
        std::cout << i << " ";
    }
    std::cout << std::endl << std::endl;

    // BUCLES ANIDADOS
    std::cout << "--- BUCLES ANIDADOS ---" << std::endl;

    // Tabla de multiplicar
    std::cout << "Tabla de multiplicar (3x3):" << std::endl;
    for (int i = 1; i <= 3; i++) {
        for (int j = 1; j <= 3; j++) {
            std::cout << i * j << "\t";  // \t es tabulación
        }
        std::cout << std::endl;  // Nueva línea después de cada fila
    }
    std::cout << std::endl;

    // Patrón de asteriscos
    std::cout << "Patrón triangular:" << std::endl;
    for (int i = 1; i <= 5; i++) {
        for (int j = 1; j <= i; j++) {
            std::cout << "* ";
        }
        std::cout << std::endl;
    }
    std::cout << std::endl;

    // SUMA DE NÚMEROS
    std::cout << "--- SUMA ACUMULATIVA ---" << std::endl;
    int suma = 0;

    std::cout << "Sumando números del 1 al 100: ";
    for (int i = 1; i <= 100; i++) {
        suma += i;  // suma = suma + i
    }
    std::cout << suma << std::endl << std::endl;

    // FACTORIAL
    std::cout << "--- CÁLCULO DE FACTORIAL ---" << std::endl;
    int n = 5;
    long long factorial = 1;  // long long para números grandes

    for (int i = 1; i <= n; i++) {
        factorial *= i;  // factorial = factorial * i
    }

    std::cout << n << "! = " << factorial << std::endl;

    return 0;
}

/*
 * CÓMO COMPILAR Y EJECUTAR:
 * g++ 03_loops.cpp -o loops
 * ./loops
 *
 * DIFERENCIAS ENTRE BUCLES:
 *
 * FOR:
 * - Uso: Cuando SABES cuántas iteraciones necesitas
 * - Ejemplo: Repetir 10 veces, recorrer un array
 *
 * WHILE:
 * - Uso: Cuando NO SABES cuántas iteraciones necesitas
 * - Ejemplo: Hasta que el usuario ingrese "salir"
 * - Se verifica la condición ANTES de ejecutar
 *
 * DO-WHILE:
 * - Uso: Similar a while, pero garantiza AL MENOS UNA ejecución
 * - Ejemplo: Menús, validación de entrada
 * - Se verifica la condición DESPUÉS de ejecutar
 *
 * BREAK vs CONTINUE:
 *
 * BREAK:
 * - Sale COMPLETAMENTE del bucle
 * - Útil para terminar búsquedas o cuando se cumple una condición especial
 *
 * CONTINUE:
 * - Salta el resto de la iteración ACTUAL
 * - Va directamente a la siguiente iteración
 * - Útil para saltar elementos no deseados
 *
 * ⚠️ CUIDADO CON BUCLES INFINITOS:
 * - Siempre asegúrate que la condición eventualmente sea falsa
 * - Verifica que las variables se actualicen correctamente
 * - Si tu programa se congela, probablemente es un bucle infinito (Ctrl+C para detener)
 */
