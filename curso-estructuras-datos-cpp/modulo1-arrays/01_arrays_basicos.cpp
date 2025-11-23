/*
 * MÓDULO 1: ARRAYS BÁSICOS EN C++
 *
 * Este programa demuestra las operaciones básicas con arrays:
 * - Declaración e inicialización
 * - Acceso a elementos
 * - Modificación de elementos
 * - Recorrido de arrays
 */

#include <iostream>
using namespace std;

int main() {
    cout << "=== ARRAYS BÁSICOS EN C++ ===" << endl << endl;

    // ============================================
    // 1. DECLARACIÓN E INICIALIZACIÓN
    // ============================================

    // Array estático - tamaño fijo de 5 elementos
    int numeros[5];

    // Inicialización con valores
    int pares[5] = {2, 4, 6, 8, 10};

    // Inicialización parcial (resto se inicializa a 0)
    int valores[5] = {1, 2};  // {1, 2, 0, 0, 0}

    // El compilador calcula el tamaño automáticamente
    int dias[] = {1, 2, 3, 4, 5, 6, 7};  // tamaño = 7

    cout << "1. Arrays declarados correctamente" << endl << endl;

    // ============================================
    // 2. ACCESO A ELEMENTOS
    // ============================================

    // Los índices comienzan en 0
    cout << "2. ACCESO A ELEMENTOS:" << endl;
    cout << "Primer elemento de pares: " << pares[0] << endl;  // 2
    cout << "Último elemento de pares: " << pares[4] << endl;  // 10
    cout << "Elemento del medio: " << pares[2] << endl;        // 6
    cout << endl;

    // ============================================
    // 3. MODIFICACIÓN DE ELEMENTOS
    // ============================================

    cout << "3. MODIFICACIÓN DE ELEMENTOS:" << endl;
    numeros[0] = 100;
    numeros[1] = 200;
    numeros[2] = 300;
    numeros[3] = 400;
    numeros[4] = 500;

    cout << "Array numeros después de modificar: ";
    for(int i = 0; i < 5; i++) {
        cout << numeros[i] << " ";
    }
    cout << endl << endl;

    // ============================================
    // 4. RECORRIDO DE ARRAYS
    // ============================================

    cout << "4. RECORRIDO CON FOR TRADICIONAL:" << endl;
    for(int i = 0; i < 5; i++) {
        cout << "pares[" << i << "] = " << pares[i] << endl;
    }
    cout << endl;

    // Recorrido con range-based for (C++11)
    cout << "5. RECORRIDO CON RANGE-BASED FOR:" << endl;
    cout << "Elementos: ";
    for(int num : pares) {
        cout << num << " ";
    }
    cout << endl << endl;

    // ============================================
    // 6. TAMAÑO DEL ARRAY
    // ============================================

    cout << "6. CALCULAR TAMAÑO DEL ARRAY:" << endl;

    // sizeof(array) da el tamaño total en bytes
    // sizeof(array[0]) da el tamaño de un elemento
    int tamanio = sizeof(pares) / sizeof(pares[0]);
    cout << "Tamaño del array 'pares': " << tamanio << " elementos" << endl;
    cout << endl;

    // ============================================
    // 7. ARRAYS MULTIDIMENSIONALES (MATRICES)
    // ============================================

    cout << "7. ARRAYS MULTIDIMENSIONALES:" << endl;

    // Matriz 3x3
    int matriz[3][3] = {
        {1, 2, 3},
        {4, 5, 6},
        {7, 8, 9}
    };

    cout << "Matriz 3x3:" << endl;
    for(int i = 0; i < 3; i++) {
        for(int j = 0; j < 3; j++) {
            cout << matriz[i][j] << "\t";
        }
        cout << endl;
    }
    cout << endl;

    // ============================================
    // 8. EJEMPLO PRÁCTICO: CALCULAR PROMEDIO
    // ============================================

    cout << "8. EJEMPLO PRÁCTICO - CALCULAR PROMEDIO:" << endl;

    int calificaciones[5] = {85, 90, 78, 92, 88};
    int suma = 0;

    // Sumar todas las calificaciones
    for(int i = 0; i < 5; i++) {
        suma += calificaciones[i];
    }

    // Calcular promedio
    double promedio = suma / 5.0;

    cout << "Calificaciones: ";
    for(int cal : calificaciones) {
        cout << cal << " ";
    }
    cout << endl;
    cout << "Promedio: " << promedio << endl;
    cout << endl;

    // ============================================
    // 9. BUSCAR ELEMENTO MÁXIMO Y MÍNIMO
    // ============================================

    cout << "9. ENCONTRAR MÁXIMO Y MÍNIMO:" << endl;

    int maximo = calificaciones[0];
    int minimo = calificaciones[0];

    for(int i = 1; i < 5; i++) {
        if(calificaciones[i] > maximo) {
            maximo = calificaciones[i];
        }
        if(calificaciones[i] < minimo) {
            minimo = calificaciones[i];
        }
    }

    cout << "Calificación máxima: " << maximo << endl;
    cout << "Calificación mínima: " << minimo << endl;

    return 0;
}

/*
 * SALIDA ESPERADA:
 * =================
 * === ARRAYS BÁSICOS EN C++ ===
 *
 * 1. Arrays declarados correctamente
 *
 * 2. ACCESO A ELEMENTOS:
 * Primer elemento de pares: 2
 * Último elemento de pares: 10
 * Elemento del medio: 6
 *
 * 3. MODIFICACIÓN DE ELEMENTOS:
 * Array numeros después de modificar: 100 200 300 400 500
 *
 * 4. RECORRIDO CON FOR TRADICIONAL:
 * pares[0] = 2
 * pares[1] = 4
 * pares[2] = 6
 * pares[3] = 8
 * pares[4] = 10
 *
 * 5. RECORRIDO CON RANGE-BASED FOR:
 * Elementos: 2 4 6 8 10
 *
 * 6. CALCULAR TAMAÑO DEL ARRAY:
 * Tamaño del array 'pares': 5 elementos
 *
 * 7. ARRAYS MULTIDIMENSIONALES:
 * Matriz 3x3:
 * 1    2    3
 * 4    5    6
 * 7    8    9
 *
 * 8. EJEMPLO PRÁCTICO - CALCULAR PROMEDIO:
 * Calificaciones: 85 90 78 92 88
 * Promedio: 86.6
 *
 * 9. ENCONTRAR MÁXIMO Y MÍNIMO:
 * Calificación máxima: 92
 * Calificación mínima: 78
 */
