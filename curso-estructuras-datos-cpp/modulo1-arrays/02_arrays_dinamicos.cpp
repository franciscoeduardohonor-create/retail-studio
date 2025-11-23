/*
 * MÓDULO 1: ARRAYS DINÁMICOS EN C++
 *
 * Este programa demuestra:
 * - Asignación dinámica de memoria
 * - Operaciones con arrays dinámicos
 * - Gestión de memoria (new/delete)
 * - Ejemplo con std::vector (alternativa moderna)
 */

#include <iostream>
#include <vector>  // Para usar std::vector
using namespace std;

// ============================================
// FUNCIONES AUXILIARES
// ============================================

/**
 * Imprime un array dinámico
 * @param arr: puntero al array
 * @param tamanio: cantidad de elementos
 */
void imprimirArray(int* arr, int tamanio) {
    cout << "[ ";
    for(int i = 0; i < tamanio; i++) {
        cout << arr[i];
        if(i < tamanio - 1) cout << ", ";
    }
    cout << " ]" << endl;
}

/**
 * Inserta un elemento en una posición específica
 * Crea un nuevo array con espacio adicional
 * @param arr: array original
 * @param tamanio: tamaño actual
 * @param posicion: donde insertar
 * @param valor: valor a insertar
 * @return: nuevo array con el elemento insertado
 */
int* insertarElemento(int* arr, int& tamanio, int posicion, int valor) {
    // Validar posición
    if(posicion < 0 || posicion > tamanio) {
        cout << "Posición inválida!" << endl;
        return arr;
    }

    // Crear nuevo array con espacio adicional
    int* nuevoArr = new int[tamanio + 1];

    // Copiar elementos antes de la posición
    for(int i = 0; i < posicion; i++) {
        nuevoArr[i] = arr[i];
    }

    // Insertar nuevo elemento
    nuevoArr[posicion] = valor;

    // Copiar elementos después de la posición
    for(int i = posicion; i < tamanio; i++) {
        nuevoArr[i + 1] = arr[i];
    }

    // Liberar memoria del array anterior
    delete[] arr;

    // Actualizar tamaño
    tamanio++;

    return nuevoArr;
}

/**
 * Elimina un elemento de una posición específica
 * @param arr: array original
 * @param tamanio: tamaño actual
 * @param posicion: donde eliminar
 * @return: nuevo array sin el elemento
 */
int* eliminarElemento(int* arr, int& tamanio, int posicion) {
    // Validar posición
    if(posicion < 0 || posicion >= tamanio) {
        cout << "Posición inválida!" << endl;
        return arr;
    }

    // Crear nuevo array más pequeño
    int* nuevoArr = new int[tamanio - 1];

    // Copiar elementos antes de la posición
    for(int i = 0; i < posicion; i++) {
        nuevoArr[i] = arr[i];
    }

    // Copiar elementos después de la posición
    for(int i = posicion + 1; i < tamanio; i++) {
        nuevoArr[i - 1] = arr[i];
    }

    // Liberar memoria del array anterior
    delete[] arr;

    // Actualizar tamaño
    tamanio--;

    return nuevoArr;
}

/**
 * Busca un elemento en el array
 * @param arr: array donde buscar
 * @param tamanio: tamaño del array
 * @param valor: valor a buscar
 * @return: índice del elemento o -1 si no existe
 */
int buscarElemento(int* arr, int tamanio, int valor) {
    for(int i = 0; i < tamanio; i++) {
        if(arr[i] == valor) {
            return i;
        }
    }
    return -1;  // No encontrado
}

// ============================================
// FUNCIÓN PRINCIPAL
// ============================================

int main() {
    cout << "=== ARRAYS DINÁMICOS EN C++ ===" << endl << endl;

    // ============================================
    // 1. CREACIÓN DE ARRAY DINÁMICO
    // ============================================

    int tamanio = 5;

    // Asignar memoria dinámicamente usando 'new'
    int* numeros = new int[tamanio];

    // Inicializar valores
    for(int i = 0; i < tamanio; i++) {
        numeros[i] = (i + 1) * 10;
    }

    cout << "1. ARRAY DINÁMICO CREADO:" << endl;
    cout << "Array inicial: ";
    imprimirArray(numeros, tamanio);
    cout << "Tamaño: " << tamanio << " elementos" << endl;
    cout << endl;

    // ============================================
    // 2. ACCESO Y MODIFICACIÓN
    // ============================================

    cout << "2. ACCESO Y MODIFICACIÓN:" << endl;
    cout << "Elemento en posición 2: " << numeros[2] << endl;

    numeros[2] = 999;
    cout << "Después de modificar posición 2: ";
    imprimirArray(numeros, tamanio);
    cout << endl;

    // ============================================
    // 3. INSERTAR ELEMENTO
    // ============================================

    cout << "3. INSERTAR ELEMENTO:" << endl;
    cout << "Insertando 77 en posición 3..." << endl;

    numeros = insertarElemento(numeros, tamanio, 3, 77);

    cout << "Array después de inserción: ";
    imprimirArray(numeros, tamanio);
    cout << "Nuevo tamaño: " << tamanio << endl;
    cout << endl;

    // ============================================
    // 4. ELIMINAR ELEMENTO
    // ============================================

    cout << "4. ELIMINAR ELEMENTO:" << endl;
    cout << "Eliminando elemento en posición 1..." << endl;

    numeros = eliminarElemento(numeros, tamanio, 1);

    cout << "Array después de eliminación: ";
    imprimirArray(numeros, tamanio);
    cout << "Nuevo tamaño: " << tamanio << endl;
    cout << endl;

    // ============================================
    // 5. BUSCAR ELEMENTO
    // ============================================

    cout << "5. BUSCAR ELEMENTO:" << endl;

    int valorBuscado = 77;
    int indice = buscarElemento(numeros, tamanio, valorBuscado);

    if(indice != -1) {
        cout << "Valor " << valorBuscado << " encontrado en posición: " << indice << endl;
    } else {
        cout << "Valor " << valorBuscado << " no encontrado" << endl;
    }
    cout << endl;

    // ============================================
    // 6. REDIMENSIONAR ARRAY
    // ============================================

    cout << "6. REDIMENSIONAR ARRAY:" << endl;
    cout << "Expandiendo array a 10 elementos..." << endl;

    int nuevoTamanio = 10;
    int* arrayExpandido = new int[nuevoTamanio];

    // Copiar elementos existentes
    for(int i = 0; i < tamanio; i++) {
        arrayExpandido[i] = numeros[i];
    }

    // Inicializar nuevos elementos
    for(int i = tamanio; i < nuevoTamanio; i++) {
        arrayExpandido[i] = 0;
    }

    // Liberar array anterior
    delete[] numeros;
    numeros = arrayExpandido;
    tamanio = nuevoTamanio;

    cout << "Array expandido: ";
    imprimirArray(numeros, tamanio);
    cout << endl;

    // ============================================
    // 7. LIBERAR MEMORIA
    // ============================================

    // MUY IMPORTANTE: Siempre liberar memoria dinámica
    delete[] numeros;
    cout << "7. Memoria liberada correctamente" << endl;
    cout << endl;

    // ============================================
    // 8. ALTERNATIVA MODERNA: std::vector
    // ============================================

    cout << "8. ALTERNATIVA CON std::vector:" << endl;
    cout << "(Gestión automática de memoria)" << endl << endl;

    // Crear vector (array dinámico moderno)
    vector<int> miVector;

    // Agregar elementos (crece automáticamente)
    miVector.push_back(10);
    miVector.push_back(20);
    miVector.push_back(30);
    miVector.push_back(40);

    cout << "Vector después de push_back: ";
    for(int val : miVector) {
        cout << val << " ";
    }
    cout << endl;

    // Insertar en posición específica
    miVector.insert(miVector.begin() + 2, 25);
    cout << "Después de insertar 25 en posición 2: ";
    for(int val : miVector) {
        cout << val << " ";
    }
    cout << endl;

    // Eliminar elemento
    miVector.erase(miVector.begin() + 1);
    cout << "Después de eliminar posición 1: ";
    for(int val : miVector) {
        cout << val << " ";
    }
    cout << endl;

    // Tamaño y capacidad
    cout << "Tamaño: " << miVector.size() << endl;
    cout << "Capacidad: " << miVector.capacity() << endl;

    cout << endl;
    cout << "NOTA: std::vector maneja la memoria automáticamente" << endl;
    cout << "      No necesitas usar new/delete manualmente" << endl;

    return 0;
}

/*
 * CONCEPTOS IMPORTANTES:
 * ======================
 *
 * 1. new vs delete:
 *    - new: asigna memoria dinámica
 *    - delete[]: libera memoria de arrays
 *    - Siempre liberar lo que asignas!
 *
 * 2. Complejidad de operaciones:
 *    - Acceso: O(1)
 *    - Inserción: O(n) - requiere copiar elementos
 *    - Eliminación: O(n) - requiere copiar elementos
 *    - Búsqueda: O(n) - debe revisar todos
 *
 * 3. Ventajas de std::vector:
 *    - Gestión automática de memoria
 *    - Redimensionamiento dinámico
 *    - Métodos útiles incorporados
 *    - Más seguro y fácil de usar
 *
 * 4. Cuándo usar arrays dinámicos manuales:
 *    - Ejercicios de aprendizaje
 *    - Situaciones de muy bajo nivel
 *    - Cuando necesitas control total
 *
 * 5. Cuándo usar std::vector:
 *    - En la mayoría de casos prácticos
 *    - Proyectos modernos de C++
 *    - Cuando quieres código más seguro
 */
