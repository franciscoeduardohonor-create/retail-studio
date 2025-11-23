/*
 * ============================================================================
 * PROGRAMA: Arrays Básicos
 * DESCRIPCIÓN: Aprende a trabajar con arrays (arreglos)
 * NIVEL: Intermedio
 * ============================================================================
 */

#include <stdio.h>

int main() {

    // ========== DECLARACIÓN E INICIALIZACIÓN ==========

    printf("========== ARRAYS EN C ==========\n\n");

    // Declaración con tamaño fijo
    int numeros[5];  // Array de 5 enteros

    // Asignación individual
    numeros[0] = 10;  // Primer elemento (índice 0)
    numeros[1] = 20;
    numeros[2] = 30;
    numeros[3] = 40;
    numeros[4] = 50;  // Último elemento (índice 4)

    // Declaración e inicialización en una línea
    int valores[] = {1, 2, 3, 4, 5};  // Tamaño automático = 5

    // Inicialización parcial
    int datos[10] = {1, 2, 3};  // Resto se inicializa a 0

    // Inicialización a cero
    int ceros[5] = {0};  // Todos los elementos a 0

    // ========== ACCESO A ELEMENTOS ==========

    printf("--- Acceso a elementos ---\n");

    printf("numeros[0] = %d\n", numeros[0]);
    printf("numeros[4] = %d\n", numeros[4]);

    // IMPORTANTE: Los índices van de 0 a (tamaño-1)
    // numeros[5] sería un error (fuera de rango)

    printf("\n");

    // ========== RECORRER UN ARRAY ==========

    printf("--- Recorrer array con for ---\n");

    for (int i = 0; i < 5; i++) {
        printf("numeros[%d] = %d\n", i, numeros[i]);
    }

    printf("\n");

    // ========== SUMA DE ELEMENTOS ==========

    printf("--- Suma de elementos ---\n");

    int suma = 0;
    for (int i = 0; i < 5; i++) {
        suma += numeros[i];
    }

    printf("Suma total: %d\n", suma);
    printf("Promedio: %.2f\n", (float)suma / 5);

    printf("\n");

    // ========== ENCONTRAR MÁXIMO Y MÍNIMO ==========

    printf("--- Máximo y mínimo ---\n");

    int arr[] = {45, 23, 67, 12, 89, 34};
    int tamanio = 6;

    int maximo = arr[0];
    int minimo = arr[0];

    for (int i = 1; i < tamanio; i++) {
        if (arr[i] > maximo) {
            maximo = arr[i];
        }
        if (arr[i] < minimo) {
            minimo = arr[i];
        }
    }

    printf("Máximo: %d\n", maximo);
    printf("Mínimo: %d\n", minimo);

    printf("\n");

    // ========== BÚSQUEDA LINEAL ==========

    printf("--- Búsqueda lineal ---\n");

    int buscar = 67;
    int encontrado = 0;
    int posicion = -1;

    for (int i = 0; i < tamanio; i++) {
        if (arr[i] == buscar) {
            encontrado = 1;
            posicion = i;
            break;
        }
    }

    if (encontrado) {
        printf("Número %d encontrado en posición %d\n", buscar, posicion);
    } else {
        printf("Número %d no encontrado\n", buscar);
    }

    printf("\n");

    // ========== ORDENAMIENTO BURBUJA ==========

    printf("--- Ordenamiento burbuja ---\n");

    int desordenado[] = {64, 34, 25, 12, 22, 11, 90};
    int n = 7;

    printf("Array original: ");
    for (int i = 0; i < n; i++) {
        printf("%d ", desordenado[i]);
    }
    printf("\n");

    // Algoritmo de ordenamiento burbuja
    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            if (desordenado[j] > desordenado[j + 1]) {
                // Intercambiar
                int temp = desordenado[j];
                desordenado[j] = desordenado[j + 1];
                desordenado[j + 1] = temp;
            }
        }
    }

    printf("Array ordenado: ");
    for (int i = 0; i < n; i++) {
        printf("%d ", desordenado[i]);
    }
    printf("\n\n");

    // ========== INVERTIR UN ARRAY ==========

    printf("--- Invertir array ---\n");

    int original[] = {1, 2, 3, 4, 5};
    int tam = 5;

    printf("Original: ");
    for (int i = 0; i < tam; i++) {
        printf("%d ", original[i]);
    }
    printf("\n");

    // Invertir
    for (int i = 0; i < tam / 2; i++) {
        int temp = original[i];
        original[i] = original[tam - 1 - i];
        original[tam - 1 - i] = temp;
    }

    printf("Invertido: ");
    for (int i = 0; i < tam; i++) {
        printf("%d ", original[i]);
    }
    printf("\n\n");

    // ========== COPIAR UN ARRAY ==========

    printf("--- Copiar array ---\n");

    int fuente[] = {10, 20, 30, 40, 50};
    int destino[5];

    for (int i = 0; i < 5; i++) {
        destino[i] = fuente[i];
    }

    printf("Array copiado: ");
    for (int i = 0; i < 5; i++) {
        printf("%d ", destino[i]);
    }
    printf("\n");

    return 0;
}

/*
 * CONCEPTOS CLAVE:
 *
 * DECLARACIÓN:
 *   tipo nombre[tamaño];
 *   int numeros[10];
 *
 * ÍNDICES:
 *   - Empiezan en 0
 *   - Último elemento: tamaño - 1
 *   - Array de 5: índices 0, 1, 2, 3, 4
 *
 * TAMAÑO:
 *   - DEBE ser constante (no variable)
 *   - Se determina en compilación
 *   - sizeof(arr) / sizeof(arr[0]) da el tamaño
 *
 * IMPORTANTE:
 *   - C NO verifica límites de arrays
 *   - Acceder fuera de rango = comportamiento indefinido
 *   - Arrays se pasan por referencia a funciones
 *
 * EJERCICIOS:
 * 1. Programa que calcule el promedio de calificaciones
 * 2. Contador de números pares e impares en un array
 * 3. Encontrar el segundo número más grande
 * 4. Eliminar duplicados de un array
 * 5. Rotar un array n posiciones a la izquierda/derecha
 */
