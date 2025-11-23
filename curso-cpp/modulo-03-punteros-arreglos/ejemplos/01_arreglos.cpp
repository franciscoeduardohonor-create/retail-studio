/*
 * MÓDULO 3: ARREGLOS, PUNTEROS Y REFERENCIAS
 * Ejemplo 1: Arreglos (Arrays)
 *
 * Aprenderás:
 * - Qué son los arreglos
 * - Declaración e inicialización
 * - Acceso a elementos
 * - Recorrer arreglos
 * - Arreglos multidimensionales
 */

#include <iostream>

int main() {
    std::cout << "=== ARREGLOS EN C++ ===" << std::endl << std::endl;

    // DECLARACIÓN E INICIALIZACIÓN
    std::cout << "--- DECLARACIÓN E INICIALIZACIÓN ---" << std::endl;

    // Forma 1: Declarar y luego asignar
    int numeros[5];  // Arreglo de 5 enteros
    numeros[0] = 10;
    numeros[1] = 20;
    numeros[2] = 30;
    numeros[3] = 40;
    numeros[4] = 50;

    // Forma 2: Declarar e inicializar al mismo tiempo
    int edades[4] = {18, 25, 30, 42};

    // Forma 3: Dejar que el compilador calcule el tamaño
    int calificaciones[] = {85, 90, 78, 92, 88};  // Tamaño: 5

    // Forma 4: Inicialización parcial (resto se llena con 0)
    int valores[10] = {1, 2, 3};  // [1, 2, 3, 0, 0, 0, 0, 0, 0, 0]

    // Forma 5: Inicializar todo en 0
    int ceros[5] = {};  // [0, 0, 0, 0, 0]

    std::cout << "Arreglo de números creado" << std::endl << std::endl;

    // ACCESO A ELEMENTOS
    std::cout << "--- ACCESO A ELEMENTOS ---" << std::endl;
    std::cout << "Primer elemento: numeros[0] = " << numeros[0] << std::endl;
    std::cout << "Último elemento: numeros[4] = " << numeros[4] << std::endl;

    // Modificar un elemento
    numeros[2] = 99;
    std::cout << "Después de modificar: numeros[2] = " << numeros[2] << std::endl << std::endl;

    // RECORRER ARREGLOS CON FOR
    std::cout << "--- RECORRER CON FOR TRADICIONAL ---" << std::endl;
    std::cout << "Calificaciones: ";

    for (int i = 0; i < 5; i++) {
        std::cout << calificaciones[i] << " ";
    }
    std::cout << std::endl << std::endl;

    // RECORRER CON RANGE-BASED FOR (C++11)
    std::cout << "--- RECORRER CON RANGE-BASED FOR ---" << std::endl;
    std::cout << "Edades: ";

    for (int edad : edades) {  // Más simple y seguro
        std::cout << edad << " ";
    }
    std::cout << std::endl << std::endl;

    // CALCULAR TAMAÑO DEL ARREGLO
    std::cout << "--- TAMAÑO DEL ARREGLO ---" << std::endl;
    int tamanio = sizeof(calificaciones) / sizeof(calificaciones[0]);
    std::cout << "Tamaño del arreglo calificaciones: " << tamanio << std::endl << std::endl;

    // OPERACIONES COMUNES
    std::cout << "--- OPERACIONES COMUNES ---" << std::endl;

    // 1. Suma de elementos
    int suma = 0;
    for (int cal : calificaciones) {
        suma += cal;
    }
    std::cout << "Suma de calificaciones: " << suma << std::endl;

    // 2. Promedio
    double promedio = (double)suma / 5;
    std::cout << "Promedio: " << promedio << std::endl;

    // 3. Encontrar el máximo
    int maximo = calificaciones[0];
    for (int i = 1; i < 5; i++) {
        if (calificaciones[i] > maximo) {
            maximo = calificaciones[i];
        }
    }
    std::cout << "Calificación máxima: " << maximo << std::endl;

    // 4. Encontrar el mínimo
    int minimo = calificaciones[0];
    for (int i = 1; i < 5; i++) {
        if (calificaciones[i] < minimo) {
            minimo = calificaciones[i];
        }
    }
    std::cout << "Calificación mínima: " << minimo << std::endl << std::endl;

    // ARREGLOS MULTIDIMENSIONALES (MATRICES)
    std::cout << "--- ARREGLOS BIDIMENSIONALES ---" << std::endl;

    // Matriz 3x3 (3 filas, 3 columnas)
    int matriz[3][3] = {
        {1, 2, 3},
        {4, 5, 6},
        {7, 8, 9}
    };

    std::cout << "Matriz 3x3:" << std::endl;
    for (int i = 0; i < 3; i++) {        // Filas
        for (int j = 0; j < 3; j++) {    // Columnas
            std::cout << matriz[i][j] << "\t";
        }
        std::cout << std::endl;
    }
    std::cout << std::endl;

    // BÚSQUEDA EN ARREGLO
    std::cout << "--- BÚSQUEDA LINEAL ---" << std::endl;
    int buscar = 92;
    bool encontrado = false;
    int posicion = -1;

    for (int i = 0; i < 5; i++) {
        if (calificaciones[i] == buscar) {
            encontrado = true;
            posicion = i;
            break;
        }
    }

    if (encontrado) {
        std::cout << "Valor " << buscar << " encontrado en posición " << posicion << std::endl;
    } else {
        std::cout << "Valor " << buscar << " no encontrado" << std::endl;
    }
    std::cout << std::endl;

    // COPIAR ARREGLOS (elemento por elemento)
    std::cout << "--- COPIAR ARREGLOS ---" << std::endl;
    int original[3] = {10, 20, 30};
    int copia[3];

    // NO puedes hacer: copia = original;  // ¡ERROR!
    // Debes copiar elemento por elemento:
    for (int i = 0; i < 3; i++) {
        copia[i] = original[i];
    }

    std::cout << "Arreglo copiado correctamente" << std::endl;

    // ARREGLO DE CARACTERES (STRINGS ESTILO C)
    std::cout << "--- ARREGLO DE CARACTERES ---" << std::endl;
    char nombre[20] = "Francisco";
    std::cout << "Nombre: " << nombre << std::endl;

    return 0;
}

/*
 * CÓMO COMPILAR Y EJECUTAR:
 * g++ 01_arreglos.cpp -o arreglos
 * ./arreglos
 *
 * CONCEPTOS IMPORTANTES:
 *
 * 1. ÍNDICES EMPIEZAN EN 0:
 *    arreglo[0] es el primer elemento
 *    arreglo[n-1] es el último elemento de un arreglo de tamaño n
 *
 * 2. TAMAÑO FIJO:
 *    El tamaño del arreglo debe ser conocido en tiempo de compilación
 *    No puedes hacer: int arr[n]; donde n es una variable (en C++ estándar)
 *
 * 3. ACCESO FUERA DE LÍMITES:
 *    Acceder a arr[10] en un arreglo de tamaño 5 causa comportamiento indefinido
 *    C++ NO verifica los límites automáticamente (¡cuidado!)
 *
 * 4. NO SE PUEDE COMPARAR DIRECTAMENTE:
 *    No puedes hacer: if (arr1 == arr2)
 *    Debes comparar elemento por elemento
 *
 * 5. NO SE PUEDE ASIGNAR DIRECTAMENTE:
 *    No puedes hacer: arr1 = arr2;
 *    Debes copiar elemento por elemento o usar std::copy
 *
 * 6. ARREGLOS Y FUNCIONES:
 *    Al pasar un arreglo a una función, se pasa como puntero
 *    Pierdes la información del tamaño (por eso se suele pasar también)
 *
 * VENTAJAS:
 * ✓ Acceso rápido a elementos (O(1))
 * ✓ Eficiente en memoria
 * ✓ Simple de usar para colecciones de tamaño fijo
 *
 * DESVENTAJAS:
 * ✗ Tamaño fijo
 * ✗ No se verifica el acceso fuera de límites
 * ✗ No se puede redimensionar
 * ✗ Difícil de pasar a funciones con toda la información
 *
 * ALTERNATIVA MODERNA:
 * Para código moderno, considera usar std::vector en lugar de arreglos
 * (lo verás en el módulo de STL)
 */
