/*
 * SOLUCIONES - MÓDULO 1: ARRAYS
 *
 * Este archivo contiene las soluciones comentadas de todos los ejercicios
 * del Módulo 1. Estudia cada solución y compárala con tu implementación.
 */

#include <iostream>
#include <string>
#include <climits>  // Para INT_MIN
using namespace std;

// ============================================
// EJERCICIO 1: Invertir un Array
// ============================================
/**
 * Invierte los elementos de un array in-place
 * Complejidad: O(n)
 * Espacio: O(1)
 */
void invertirArray(int arr[], int tamanio) {
    int inicio = 0;
    int fin = tamanio - 1;

    // Intercambiar elementos desde los extremos hacia el centro
    while(inicio < fin) {
        // Swap usando variable temporal
        int temp = arr[inicio];
        arr[inicio] = arr[fin];
        arr[fin] = temp;

        inicio++;
        fin--;
    }
}

// ============================================
// EJERCICIO 2: Sumar Elementos
// ============================================
/**
 * Suma todos los elementos de un array
 * Complejidad: O(n)
 * Espacio: O(1)
 */
int sumarElementos(int arr[], int tamanio) {
    int suma = 0;

    // Recorrer array y acumular suma
    for(int i = 0; i < tamanio; i++) {
        suma += arr[i];
    }

    return suma;
}

// ============================================
// EJERCICIO 3: Contar Ocurrencias
// ============================================
/**
 * Cuenta cuántas veces aparece un número en el array
 * Complejidad: O(n)
 * Espacio: O(1)
 */
int contarOcurrencias(int arr[], int tamanio, int numero) {
    int contador = 0;

    // Recorrer y contar coincidencias
    for(int i = 0; i < tamanio; i++) {
        if(arr[i] == numero) {
            contador++;
        }
    }

    return contador;
}

// ============================================
// EJERCICIO 4: Rotar Array
// ============================================
/**
 * Rota un array k posiciones a la derecha
 * Complejidad: O(n)
 * Espacio: O(1) usando reversión triple
 */
void reversa(int arr[], int inicio, int fin) {
    while(inicio < fin) {
        int temp = arr[inicio];
        arr[inicio] = arr[fin];
        arr[fin] = temp;
        inicio++;
        fin--;
    }
}

void rotarArray(int arr[], int tamanio, int k) {
    // Normalizar k (por si es mayor que tamanio)
    k = k % tamanio;

    // Algoritmo de reversión triple:
    // 1. Revertir todo el array
    reversa(arr, 0, tamanio - 1);

    // 2. Revertir los primeros k elementos
    reversa(arr, 0, k - 1);

    // 3. Revertir los elementos restantes
    reversa(arr, k, tamanio - 1);
}

// ============================================
// EJERCICIO 5: Eliminar Duplicados
// ============================================
/**
 * Elimina duplicados de un array ORDENADO
 * Complejidad: O(n)
 * Espacio: O(1)
 */
int eliminarDuplicados(int arr[], int tamanio) {
    if(tamanio == 0) return 0;

    int indiceUnico = 0;  // Índice para elementos únicos

    // Recorrer el array
    for(int i = 1; i < tamanio; i++) {
        // Si encontramos un elemento diferente
        if(arr[i] != arr[indiceUnico]) {
            indiceUnico++;
            arr[indiceUnico] = arr[i];
        }
    }

    // Retornar nuevo tamaño (índice + 1)
    return indiceUnico + 1;
}

// ============================================
// EJERCICIO 6: Fusionar Arrays Ordenados
// ============================================
/**
 * Fusiona dos arrays ordenados en uno solo ordenado
 * Complejidad: O(n + m)
 * Espacio: O(n + m)
 */
int* fusionarArrays(int arr1[], int tam1, int arr2[], int tam2) {
    // Crear array resultado
    int* resultado = new int[tam1 + tam2];

    int i = 0;  // Índice para arr1
    int j = 0;  // Índice para arr2
    int k = 0;  // Índice para resultado

    // Mientras haya elementos en ambos arrays
    while(i < tam1 && j < tam2) {
        if(arr1[i] <= arr2[j]) {
            resultado[k++] = arr1[i++];
        } else {
            resultado[k++] = arr2[j++];
        }
    }

    // Copiar elementos restantes de arr1 (si hay)
    while(i < tam1) {
        resultado[k++] = arr1[i++];
    }

    // Copiar elementos restantes de arr2 (si hay)
    while(j < tam2) {
        resultado[k++] = arr2[j++];
    }

    return resultado;
}

// ============================================
// EJERCICIO 7: Suma Máxima de Subarreglo (Kadane)
// ============================================
/**
 * Encuentra la suma máxima de un subarreglo contiguo
 * Algoritmo de Kadane
 * Complejidad: O(n)
 * Espacio: O(1)
 */
int sumaMaximaSubarreglo(int arr[], int tamanio) {
    if(tamanio == 0) return 0;

    int maxActual = arr[0];    // Máximo que termina en posición actual
    int maxGlobal = arr[0];    // Máximo encontrado hasta ahora

    // Recorrer desde el segundo elemento
    for(int i = 1; i < tamanio; i++) {
        // Decidir: ¿extender subarreglo actual o empezar uno nuevo?
        maxActual = max(arr[i], maxActual + arr[i]);

        // Actualizar máximo global si es necesario
        maxGlobal = max(maxGlobal, maxActual);
    }

    return maxGlobal;
}

// ============================================
// EJERCICIO 8: Producto Excepto Sí Mismo
// ============================================
/**
 * Calcula el producto de todos los elementos excepto el actual
 * Sin usar división
 * Complejidad: O(n)
 * Espacio: O(n) para el resultado
 */
int* productoExceptoSiMismo(int arr[], int tamanio) {
    int* resultado = new int[tamanio];

    // Paso 1: Calcular productos de la izquierda
    resultado[0] = 1;
    for(int i = 1; i < tamanio; i++) {
        resultado[i] = resultado[i-1] * arr[i-1];
    }

    // Paso 2: Multiplicar por productos de la derecha
    int productoDerecha = 1;
    for(int i = tamanio - 1; i >= 0; i--) {
        resultado[i] *= productoDerecha;
        productoDerecha *= arr[i];
    }

    return resultado;
}

// ============================================
// EJERCICIO 9: Matriz Espiral
// ============================================
/**
 * Imprime una matriz en orden espiral
 * Complejidad: O(n * m)
 * Espacio: O(1)
 */
void imprimirEspiral(int matriz[][100], int filas, int columnas) {
    int arriba = 0;
    int abajo = filas - 1;
    int izquierda = 0;
    int derecha = columnas - 1;

    while(arriba <= abajo && izquierda <= derecha) {
        // Recorrer fila superior de izquierda a derecha
        for(int i = izquierda; i <= derecha; i++) {
            cout << matriz[arriba][i] << " ";
        }
        arriba++;

        // Recorrer columna derecha de arriba a abajo
        for(int i = arriba; i <= abajo; i++) {
            cout << matriz[i][derecha] << " ";
        }
        derecha--;

        // Recorrer fila inferior de derecha a izquierda (si existe)
        if(arriba <= abajo) {
            for(int i = derecha; i >= izquierda; i--) {
                cout << matriz[abajo][i] << " ";
            }
            abajo--;
        }

        // Recorrer columna izquierda de abajo a arriba (si existe)
        if(izquierda <= derecha) {
            for(int i = abajo; i >= arriba; i--) {
                cout << matriz[i][izquierda] << " ";
            }
            izquierda++;
        }
    }
    cout << endl;
}

// ============================================
// EJERCICIO 10: Encontrar Pares con Suma K
// ============================================
/**
 * Encuentra todos los pares que suman k
 * Complejidad: O(n²) - versión simple
 * Espacio: O(1)
 */
void encontrarPares(int arr[], int tamanio, int k) {
    cout << "Pares que suman " << k << ":" << endl;

    bool encontrado = false;

    // Revisar todos los pares posibles
    for(int i = 0; i < tamanio; i++) {
        for(int j = i + 1; j < tamanio; j++) {
            if(arr[i] + arr[j] == k) {
                cout << "(" << arr[i] << ", " << arr[j] << ")" << endl;
                encontrado = true;
            }
        }
    }

    if(!encontrado) {
        cout << "No se encontraron pares" << endl;
    }
}

// ============================================
// FUNCIONES DE PRUEBA
// ============================================

void probarEjercicio1() {
    cout << "\n=== EJERCICIO 1: Invertir Array ===" << endl;
    int arr[] = {1, 2, 3, 4, 5};
    int tam = 5;

    cout << "Array original: ";
    for(int i = 0; i < tam; i++) cout << arr[i] << " ";
    cout << endl;

    invertirArray(arr, tam);

    cout << "Array invertido: ";
    for(int i = 0; i < tam; i++) cout << arr[i] << " ";
    cout << endl;
}

void probarEjercicio2() {
    cout << "\n=== EJERCICIO 2: Sumar Elementos ===" << endl;
    int arr[] = {10, 20, 30, 40};
    int tam = 4;

    cout << "Array: ";
    for(int i = 0; i < tam; i++) cout << arr[i] << " ";
    cout << endl;

    int suma = sumarElementos(arr, tam);
    cout << "Suma total: " << suma << endl;
}

void probarEjercicio3() {
    cout << "\n=== EJERCICIO 3: Contar Ocurrencias ===" << endl;
    int arr[] = {1, 2, 3, 2, 4, 2, 5};
    int tam = 7;
    int numero = 2;

    cout << "Array: ";
    for(int i = 0; i < tam; i++) cout << arr[i] << " ";
    cout << endl;

    int ocurrencias = contarOcurrencias(arr, tam, numero);
    cout << "El número " << numero << " aparece " << ocurrencias << " veces" << endl;
}

void probarEjercicio4() {
    cout << "\n=== EJERCICIO 4: Rotar Array ===" << endl;
    int arr[] = {1, 2, 3, 4, 5};
    int tam = 5;
    int k = 2;

    cout << "Array original: ";
    for(int i = 0; i < tam; i++) cout << arr[i] << " ";
    cout << endl;

    rotarArray(arr, tam, k);

    cout << "Array rotado " << k << " posiciones: ";
    for(int i = 0; i < tam; i++) cout << arr[i] << " ";
    cout << endl;
}

void probarEjercicio7() {
    cout << "\n=== EJERCICIO 7: Suma Máxima Subarreglo (Kadane) ===" << endl;
    int arr[] = {-2, 1, -3, 4, -1, 2, 1, -5, 4};
    int tam = 9;

    cout << "Array: ";
    for(int i = 0; i < tam; i++) cout << arr[i] << " ";
    cout << endl;

    int maxSuma = sumaMaximaSubarreglo(arr, tam);
    cout << "Suma máxima de subarreglo: " << maxSuma << endl;
}

// ============================================
// FUNCIÓN PRINCIPAL
// ============================================

int main() {
    cout << "======================================" << endl;
    cout << "   SOLUCIONES - MÓDULO 1: ARRAYS     " << endl;
    cout << "======================================" << endl;

    probarEjercicio1();
    probarEjercicio2();
    probarEjercicio3();
    probarEjercicio4();
    probarEjercicio7();

    cout << "\n======================================" << endl;
    cout << "¡Todas las pruebas completadas!" << endl;
    cout << "======================================" << endl;

    return 0;
}

/*
 * ANÁLISIS DE COMPLEJIDAD
 * ========================
 *
 * Ejercicio 1 (Invertir): O(n) tiempo, O(1) espacio
 * Ejercicio 2 (Sumar): O(n) tiempo, O(1) espacio
 * Ejercicio 3 (Contar): O(n) tiempo, O(1) espacio
 * Ejercicio 4 (Rotar): O(n) tiempo, O(1) espacio
 * Ejercicio 5 (Eliminar Duplicados): O(n) tiempo, O(1) espacio
 * Ejercicio 6 (Fusionar): O(n+m) tiempo, O(n+m) espacio
 * Ejercicio 7 (Kadane): O(n) tiempo, O(1) espacio
 * Ejercicio 8 (Producto): O(n) tiempo, O(n) espacio
 * Ejercicio 9 (Espiral): O(n*m) tiempo, O(1) espacio
 * Ejercicio 10 (Pares): O(n²) tiempo, O(1) espacio
 */
