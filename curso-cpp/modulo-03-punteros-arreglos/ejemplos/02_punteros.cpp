/*
 * MÓDULO 3: ARREGLOS, PUNTEROS Y REFERENCIAS
 * Ejemplo 2: Punteros
 *
 * Aprenderás:
 * - Qué son los punteros
 * - Operadores & (dirección) y * (desreferencia)
 * - Aritmética de punteros
 * - Punteros y arreglos
 * - Punteros nulos
 */

#include <iostream>

int main() {
    std::cout << "=== PUNTEROS EN C++ ===" << std::endl << std::endl;

    // VARIABLES NORMALES
    std::cout << "--- VARIABLES NORMALES ---" << std::endl;
    int numero = 42;

    std::cout << "Valor de numero: " << numero << std::endl;
    std::cout << "Dirección de numero: " << &numero << std::endl;
    // & es el operador de dirección ("address-of")
    std::cout << std::endl;

    // DECLARACIÓN DE PUNTEROS
    std::cout << "--- PUNTEROS BÁSICOS ---" << std::endl;
    int* ptr;  // Declara un puntero a int (todavía no apunta a nada)

    // Asignar la dirección de una variable al puntero
    ptr = &numero;  // ptr ahora apunta a numero

    std::cout << "Valor de ptr (dirección que almacena): " << ptr << std::endl;
    std::cout << "Valor apuntado por ptr (*ptr): " << *ptr << std::endl;
    // * es el operador de desreferencia ("dereference")
    std::cout << "Dirección del puntero mismo: " << &ptr << std::endl;
    std::cout << std::endl;

    // MODIFICAR A TRAVÉS DE PUNTEROS
    std::cout << "--- MODIFICAR CON PUNTEROS ---" << std::endl;
    std::cout << "Antes: numero = " << numero << std::endl;

    *ptr = 100;  // Modificamos el valor de numero a través del puntero

    std::cout << "Después de *ptr = 100:" << std::endl;
    std::cout << "numero = " << numero << std::endl;
    std::cout << "*ptr = " << *ptr << std::endl;
    std::cout << std::endl;

    // MÚLTIPLES PUNTEROS A LA MISMA VARIABLE
    std::cout << "--- MÚLTIPLES PUNTEROS ---" << std::endl;
    int valor = 50;
    int* ptr1 = &valor;
    int* ptr2 = &valor;

    std::cout << "valor = " << valor << std::endl;
    std::cout << "*ptr1 = " << *ptr1 << std::endl;
    std::cout << "*ptr2 = " << *ptr2 << std::endl;

    *ptr1 = 75;  // Modificamos a través de ptr1

    std::cout << "Después de *ptr1 = 75:" << std::endl;
    std::cout << "valor = " << valor << std::endl;
    std::cout << "*ptr2 = " << *ptr2 << std::endl;  // También cambió
    std::cout << std::endl;

    // PUNTEROS Y ARREGLOS
    std::cout << "--- PUNTEROS Y ARREGLOS ---" << std::endl;
    int arr[5] = {10, 20, 30, 40, 50};
    int* pArr = arr;  // El nombre del arreglo es un puntero al primer elemento

    std::cout << "arr[0] = " << arr[0] << std::endl;
    std::cout << "*pArr = " << *pArr << std::endl;  // Mismo valor

    std::cout << "arr[1] = " << arr[1] << std::endl;
    std::cout << "*(pArr + 1) = " << *(pArr + 1) << std::endl;  // Mismo valor
    std::cout << std::endl;

    // ARITMÉTICA DE PUNTEROS
    std::cout << "--- ARITMÉTICA DE PUNTEROS ---" << std::endl;

    std::cout << "Recorriendo arreglo con puntero:" << std::endl;
    for (int i = 0; i < 5; i++) {
        std::cout << "Elemento " << i << ": " << *(pArr + i) << std::endl;
    }
    std::cout << std::endl;

    // Otra forma: incrementar el puntero
    std::cout << "Con puntero incrementado:" << std::endl;
    int* p = arr;
    for (int i = 0; i < 5; i++) {
        std::cout << *p << " ";
        p++;  // Avanza al siguiente elemento
    }
    std::cout << std::endl << std::endl;

    // PUNTERO NULO
    std::cout << "--- PUNTEROS NULOS ---" << std::endl;
    int* ptrNulo = nullptr;  // C++11: forma moderna

    if (ptrNulo == nullptr) {
        std::cout << "El puntero es nulo (no apunta a nada)" << std::endl;
    }

    // ¡PELIGRO! Desreferenciar un puntero nulo causa crash
    // std::cout << *ptrNulo;  // ¡NO HAGAS ESTO!

    // Siempre verifica antes de desreferenciar
    if (ptrNulo != nullptr) {
        std::cout << *ptrNulo << std::endl;
    } else {
        std::cout << "No puedo desreferenciar: puntero nulo" << std::endl;
    }
    std::cout << std::endl;

    // PUNTEROS COMO PARÁMETROS DE FUNCIONES
    std::cout << "--- EJEMPLO PRÁCTICO ---" << std::endl;

    int a = 10, b = 20;
    std::cout << "Antes del intercambio: a = " << a << ", b = " << b << std::endl;

    // Función inline para intercambiar (usando punteros)
    auto intercambiar = [](int* x, int* y) {
        int temp = *x;
        *x = *y;
        *y = temp;
    };

    intercambiar(&a, &b);

    std::cout << "Después del intercambio: a = " << a << ", b = " << b << std::endl;
    std::cout << std::endl;

    // DIFERENCIA ENTRE TIPOS DE PUNTEROS
    std::cout << "--- TAMAÑO DE PUNTEROS ---" << std::endl;
    int* pInt;
    double* pDouble;
    char* pChar;

    // Todos los punteros tienen el mismo tamaño (dirección de memoria)
    std::cout << "sizeof(int*): " << sizeof(pInt) << " bytes" << std::endl;
    std::cout << "sizeof(double*): " << sizeof(pDouble) << " bytes" << std::endl;
    std::cout << "sizeof(char*): " << sizeof(pChar) << " bytes" << std::endl;
    std::cout << std::endl;

    // PUNTERO A PUNTERO
    std::cout << "--- PUNTERO A PUNTERO ---" << std::endl;
    int num = 100;
    int* p1 = &num;      // Puntero a int
    int** p2 = &p1;      // Puntero a puntero a int

    std::cout << "num = " << num << std::endl;
    std::cout << "*p1 = " << *p1 << std::endl;
    std::cout << "**p2 = " << **p2 << std::endl;  // Doble desreferencia

    return 0;
}

/*
 * CÓMO COMPILAR Y EJECUTAR:
 * g++ 02_punteros.cpp -std=c++11 -o punteros
 * ./punteros
 *
 * CONCEPTOS FUNDAMENTALES:
 *
 * 1. ¿QUÉ ES UN PUNTERO?
 *    - Una variable que almacena una DIRECCIÓN DE MEMORIA
 *    - Apunta a otra variable
 *    - Permite manipulación indirecta de datos
 *
 * 2. OPERADORES:
 *    & (address-of): Obtiene la dirección de una variable
 *       int x = 5;
 *       &x es la dirección donde se almacena x
 *
 *    * (dereference): Accede al valor en la dirección
 *       int* p = &x;
 *       *p es el valor almacenado en la dirección (5)
 *
 * 3. DECLARACIÓN:
 *    int* ptr;    // Puntero a int (recomendado)
 *    int *ptr;    // También válido
 *    int * ptr;   // También válido
 *
 * 4. ARITMÉTICA DE PUNTEROS:
 *    Si ptr apunta a arr[0]:
 *    ptr + 1 apunta a arr[1]
 *    ptr + 2 apunta a arr[2]
 *    etc.
 *
 *    El compilador automáticamente multiplica por sizeof(tipo)
 *
 * 5. ARREGLOS SON PUNTEROS:
 *    int arr[5];
 *    arr es equivalente a &arr[0]
 *    arr[i] es equivalente a *(arr + i)
 *
 * 6. NULLPTR (C++11):
 *    Forma moderna de representar puntero nulo
 *    Reemplaza a NULL (C style)
 *
 * ⚠️ PELIGROS COMUNES:
 *
 * 1. PUNTEROS NO INICIALIZADOS:
 *    int* p;        // Apunta a cualquier lado (peligroso)
 *    *p = 10;       // ¡CRASH!
 *
 *    SOLUCIÓN: Inicializa siempre
 *    int* p = nullptr;
 *
 * 2. DANGLING POINTERS (punteros colgantes):
 *    int* p = new int(5);
 *    delete p;
 *    *p = 10;       // ¡PELIGRO! p apunta a memoria liberada
 *
 * 3. MEMORY LEAKS (fugas de memoria):
 *    int* p = new int(5);
 *    p = new int(10);  // ¡Perdimos el primer int!
 *
 * 4. DESREFERENCIAR nullptr:
 *    int* p = nullptr;
 *    *p = 5;        // ¡CRASH!
 *
 * CUÁNDO USAR PUNTEROS:
 * ✓ Funciones que necesitan modificar variables
 * ✓ Trabajar con memoria dinámica
 * ✓ Estructuras de datos (listas, árboles)
 * ✓ Optimización (evitar copias de objetos grandes)
 *
 * ALTERNATIVAS MODERNAS:
 * - Referencias (&) para parámetros de función
 * - std::unique_ptr, std::shared_ptr para memoria dinámica
 * - std::vector en lugar de arreglos dinámicos
 */
