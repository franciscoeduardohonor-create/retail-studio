/*
 * MÓDULO 3: ARREGLOS, PUNTEROS Y REFERENCIAS
 * Ejemplo 3: Memoria Dinámica
 *
 * Aprenderás:
 * - Diferencia entre stack y heap
 * - Operadores new y delete
 * - Arreglos dinámicos
 * - Memory leaks y cómo evitarlos
 */

#include <iostream>

int main() {
    std::cout << "=== MEMORIA DINÁMICA ===" << std::endl << std::endl;

    // MEMORIA ESTÁTICA (STACK)
    std::cout << "--- MEMORIA ESTÁTICA ---" << std::endl;
    int x = 10;  // Se almacena en el stack
    std::cout << "Variable en stack: " << x << std::endl;
    // Se libera automáticamente al salir del scope
    std::cout << std::endl;

    // MEMORIA DINÁMICA (HEAP) - NEW
    std::cout << "--- MEMORIA DINÁMICA (new) ---" << std::endl;

    int* ptr = new int;  // Reserva memoria en el heap
    *ptr = 42;

    std::cout << "Valor en heap: " << *ptr << std::endl;
    std::cout << "Dirección: " << ptr << std::endl;

    delete ptr;  // ¡IMPORTANTE! Liberar la memoria
    ptr = nullptr;  // Buena práctica: evita dangling pointers
    std::cout << "Memoria liberada" << std::endl << std::endl;

    // NEW CON INICIALIZACIÓN
    std::cout << "--- NEW CON INICIALIZACIÓN ---" << std::endl;

    int* num1 = new int(100);      // Inicializa con 100
    double* pi = new double(3.14); // Inicializa con 3.14

    std::cout << "*num1 = " << *num1 << std::endl;
    std::cout << "*pi = " << *pi << std::endl;

    delete num1;
    delete pi;
    std::cout << std::endl;

    // ARREGLOS DINÁMICOS
    std::cout << "--- ARREGLOS DINÁMICOS ---" << std::endl;

    int tamanio;
    std::cout << "¿Cuántos números quieres almacenar?: ";
    std::cin >> tamanio;

    // Crear arreglo dinámico
    int* numeros = new int[tamanio];  // Nota: new[] no new

    // Llenar el arreglo
    std::cout << "Ingresa " << tamanio << " números:" << std::endl;
    for (int i = 0; i < tamanio; i++) {
        std::cout << "Número " << (i + 1) << ": ";
        std::cin >> numeros[i];
    }

    // Mostrar el arreglo
    std::cout << "Números ingresados: ";
    for (int i = 0; i < tamanio; i++) {
        std::cout << numeros[i] << " ";
    }
    std::cout << std::endl;

    // Calcular suma
    int suma = 0;
    for (int i = 0; i < tamanio; i++) {
        suma += numeros[i];
    }
    std::cout << "Suma: " << suma << std::endl;

    delete[] numeros;  // ¡IMPORTANTE! Use delete[] para arreglos
    numeros = nullptr;
    std::cout << std::endl;

    // MATRIZ DINÁMICA (2D)
    std::cout << "--- MATRIZ DINÁMICA ---" << std::endl;

    int filas = 3, columnas = 4;

    // Crear matriz (arreglo de punteros)
    int** matriz = new int*[filas];
    for (int i = 0; i < filas; i++) {
        matriz[i] = new int[columnas];
    }

    // Llenar la matriz
    int contador = 1;
    for (int i = 0; i < filas; i++) {
        for (int j = 0; j < columnas; j++) {
            matriz[i][j] = contador++;
        }
    }

    // Mostrar la matriz
    std::cout << "Matriz " << filas << "x" << columnas << ":" << std::endl;
    for (int i = 0; i < filas; i++) {
        for (int j = 0; j < columnas; j++) {
            std::cout << matriz[i][j] << "\t";
        }
        std::cout << std::endl;
    }

    // Liberar la matriz (en orden inverso a la creación)
    for (int i = 0; i < filas; i++) {
        delete[] matriz[i];  // Primero las filas
    }
    delete[] matriz;  // Luego el arreglo de punteros
    std::cout << "Matriz liberada" << std::endl << std::endl;

    // EJEMPLO: REDIMENSIONAR ARREGLO
    std::cout << "--- REDIMENSIONAR ARREGLO ---" << std::endl;

    int tamOriginal = 3;
    int* arr = new int[tamOriginal];
    arr[0] = 10;
    arr[1] = 20;
    arr[2] = 30;

    std::cout << "Arreglo original: ";
    for (int i = 0; i < tamOriginal; i++) {
        std::cout << arr[i] << " ";
    }
    std::cout << std::endl;

    // Crear nuevo arreglo más grande
    int tamNuevo = 5;
    int* arrNuevo = new int[tamNuevo];

    // Copiar elementos del arreglo original
    for (int i = 0; i < tamOriginal; i++) {
        arrNuevo[i] = arr[i];
    }

    // Inicializar nuevos elementos
    arrNuevo[3] = 40;
    arrNuevo[4] = 50;

    // Liberar arreglo original
    delete[] arr;

    // Apuntar al nuevo arreglo
    arr = arrNuevo;

    std::cout << "Arreglo redimensionado: ";
    for (int i = 0; i < tamNuevo; i++) {
        std::cout << arr[i] << " ";
    }
    std::cout << std::endl;

    delete[] arr;
    std::cout << std::endl;

    // DEMOSTRACIÓN DE MEMORY LEAK (¡NO HACER ESTO!)
    std::cout << "--- EJEMPLO DE MEMORY LEAK ---" << std::endl;
    std::cout << "Ejemplo de código que causa memory leak:" << std::endl;
    std::cout << "int* p = new int(10);" << std::endl;
    std::cout << "p = new int(20);  // ¡LEAK! Se perdió el primer int" << std::endl;
    std::cout << std::endl;

    std::cout << "Forma correcta:" << std::endl;
    std::cout << "int* p = new int(10);" << std::endl;
    std::cout << "delete p;  // Liberar primero" << std::endl;
    std::cout << "p = new int(20);  // Ahora es seguro" << std::endl;

    return 0;
}

/*
 * CÓMO COMPILAR Y EJECUTAR:
 * g++ 03_memoria_dinamica.cpp -o memoria
 * ./memoria
 *
 * CONCEPTOS IMPORTANTES:
 *
 * 1. STACK vs HEAP:
 *
 *    STACK (Pila):
 *    - Variables locales
 *    - Tamaño fijo conocido en tiempo de compilación
 *    - Gestión automática (se libera al salir del scope)
 *    - Rápido
 *    - Tamaño limitado (generalmente ~8MB)
 *
 *    HEAP (Montón):
 *    - Memoria dinámica (new/delete)
 *    - Tamaño puede determinarse en tiempo de ejecución
 *    - Gestión manual (debes liberar explícitamente)
 *    - Más lento que stack
 *    - Mucho más grande (limitado por RAM)
 *
 * 2. OPERADORES NEW Y DELETE:
 *
 *    NEW:
 *    - Reserva memoria en el heap
 *    - Retorna un puntero a la memoria
 *    - Puede lanzar excepción si no hay memoria
 *
 *    DELETE:
 *    - Libera la memoria reservada
 *    - Solo para memoria reservada con new
 *    - Usar delete[] para arreglos
 *
 * 3. REGLAS IMPORTANTES:
 *
 *    ✓ Cada new debe tener su delete correspondiente
 *    ✓ Usa delete[] para arreglos creados con new[]
 *    ✓ Nunca hagas delete dos veces al mismo puntero
 *    ✓ Asigna nullptr después de delete
 *    ✓ No uses delete en punteros no creados con new
 *
 * 4. MEMORY LEAKS (Fugas de memoria):
 *
 *    Ocurren cuando:
 *    - Reservas memoria con new pero no usas delete
 *    - Pierdes el puntero antes de liberar
 *    - Una excepción interrumpe antes de delete
 *
 *    Consecuencias:
 *    - El programa consume cada vez más memoria
 *    - Eventualmente se queda sin memoria
 *    - Afecta el rendimiento del sistema
 *
 * 5. ERRORES COMUNES:
 *
 *    a) Usar delete en lugar de delete[]:
 *       int* arr = new int[10];
 *       delete arr;  // ¡MAL! Debería ser delete[]
 *
 *    b) Delete doble:
 *       int* p = new int(5);
 *       delete p;
 *       delete p;  // ¡ERROR! Ya fue liberado
 *
 *    c) Dangling pointer:
 *       int* p = new int(5);
 *       delete p;
 *       *p = 10;  // ¡PELIGRO! Memoria ya liberada
 *
 *    d) Memory leak:
 *       int* p = new int(5);
 *       p = nullptr;  // ¡LEAK! Se perdió la memoria
 *
 * 6. BUENAS PRÁCTICAS:
 *
 *    ✓ Usa RAII (Resource Acquisition Is Initialization)
 *    ✓ Prefiere std::vector sobre arreglos dinámicos
 *    ✓ Usa smart pointers (std::unique_ptr, std::shared_ptr)
 *    ✓ Asigna nullptr después de delete
 *    ✓ Verifica si un puntero es nullptr antes de desreferenciar
 *
 * 7. ALTERNATIVAS MODERNAS (C++11+):
 *
 *    En lugar de:
 *    int* arr = new int[100];
 *    delete[] arr;
 *
 *    Usa:
 *    std::vector<int> arr(100);
 *    // Se libera automáticamente
 *
 *    En lugar de:
 *    int* p = new int(42);
 *    delete p;
 *
 *    Usa:
 *    std::unique_ptr<int> p = std::make_unique<int>(42);
 *    // Se libera automáticamente
 *
 * CUÁNDO USAR MEMORIA DINÁMICA:
 * ✓ El tamaño no se conoce hasta tiempo de ejecución
 * ✓ Necesitas mucha memoria (más que el stack)
 * ✓ Estructuras de datos dinámicas (listas, árboles)
 * ✓ El objeto debe sobrevivir fuera de su scope
 *
 * HERRAMIENTAS ÚTILES:
 * - Valgrind: detecta memory leaks en Linux
 * - AddressSanitizer: detector de errores de memoria
 * - Visual Studio Memory Profiler
 */
