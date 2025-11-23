/*
 * MÓDULO 2: LISTA SIMPLEMENTE ENLAZADA
 *
 * Implementación completa de una lista enlazada simple con:
 * - Estructura de nodo
 * - Operaciones básicas (insertar, eliminar, buscar)
 * - Recorrido e impresión
 * - Gestión de memoria
 */

#include <iostream>
using namespace std;

// ============================================
// ESTRUCTURA DEL NODO
// ============================================

/**
 * Nodo de la lista enlazada
 * Contiene un dato y un puntero al siguiente nodo
 */
struct Nodo {
    int dato;           // Valor almacenado
    Nodo* siguiente;    // Puntero al siguiente nodo

    // Constructor para facilitar creación de nodos
    Nodo(int valor) : dato(valor), siguiente(nullptr) {}
};

// ============================================
// CLASE LISTA ENLAZADA
// ============================================

class ListaEnlazada {
private:
    Nodo* cabeza;      // Primer nodo de la lista
    int tamanio;       // Número de elementos

public:
    // Constructor
    ListaEnlazada() : cabeza(nullptr), tamanio(0) {}

    // Destructor - Libera toda la memoria
    ~ListaEnlazada() {
        limpiar();
    }

    // ========================================
    // OPERACIÓN: Verificar si está vacía
    // ========================================
    /**
     * Complejidad: O(1)
     */
    bool estaVacia() const {
        return cabeza == nullptr;
    }

    // ========================================
    // OPERACIÓN: Obtener tamaño
    // ========================================
    /**
     * Complejidad: O(1)
     */
    int obtenerTamanio() const {
        return tamanio;
    }

    // ========================================
    // OPERACIÓN: Insertar al inicio
    // ========================================
    /**
     * Inserta un nuevo nodo al inicio de la lista
     * Complejidad: O(1)
     */
    void insertarAlInicio(int valor) {
        // Crear nuevo nodo
        Nodo* nuevoNodo = new Nodo(valor);

        // El siguiente del nuevo nodo es la antigua cabeza
        nuevoNodo->siguiente = cabeza;

        // El nuevo nodo se convierte en la nueva cabeza
        cabeza = nuevoNodo;

        // Incrementar tamaño
        tamanio++;

        cout << "Insertado " << valor << " al inicio" << endl;
    }

    // ========================================
    // OPERACIÓN: Insertar al final
    // ========================================
    /**
     * Inserta un nuevo nodo al final de la lista
     * Complejidad: O(n) - debe recorrer hasta el final
     */
    void insertarAlFinal(int valor) {
        // Crear nuevo nodo
        Nodo* nuevoNodo = new Nodo(valor);

        // Si la lista está vacía, el nuevo nodo es la cabeza
        if(estaVacia()) {
            cabeza = nuevoNodo;
        } else {
            // Encontrar el último nodo
            Nodo* actual = cabeza;
            while(actual->siguiente != nullptr) {
                actual = actual->siguiente;
            }

            // Conectar el último nodo con el nuevo
            actual->siguiente = nuevoNodo;
        }

        tamanio++;
        cout << "Insertado " << valor << " al final" << endl;
    }

    // ========================================
    // OPERACIÓN: Insertar en posición
    // ========================================
    /**
     * Inserta un elemento en una posición específica
     * Complejidad: O(n)
     */
    void insertarEnPosicion(int valor, int posicion) {
        // Validar posición
        if(posicion < 0 || posicion > tamanio) {
            cout << "Posición inválida!" << endl;
            return;
        }

        // Si la posición es 0, insertar al inicio
        if(posicion == 0) {
            insertarAlInicio(valor);
            return;
        }

        // Crear nuevo nodo
        Nodo* nuevoNodo = new Nodo(valor);

        // Encontrar el nodo en la posición anterior
        Nodo* actual = cabeza;
        for(int i = 0; i < posicion - 1; i++) {
            actual = actual->siguiente;
        }

        // Insertar el nuevo nodo
        nuevoNodo->siguiente = actual->siguiente;
        actual->siguiente = nuevoNodo;

        tamanio++;
        cout << "Insertado " << valor << " en posición " << posicion << endl;
    }

    // ========================================
    // OPERACIÓN: Eliminar al inicio
    // ========================================
    /**
     * Elimina el primer nodo de la lista
     * Complejidad: O(1)
     */
    bool eliminarAlInicio() {
        // Verificar si la lista está vacía
        if(estaVacia()) {
            cout << "La lista está vacía, no se puede eliminar" << endl;
            return false;
        }

        // Guardar referencia al nodo a eliminar
        Nodo* nodoAEliminar = cabeza;
        int valorEliminado = cabeza->dato;

        // Mover la cabeza al siguiente nodo
        cabeza = cabeza->siguiente;

        // Liberar memoria del nodo eliminado
        delete nodoAEliminar;

        tamanio--;
        cout << "Eliminado " << valorEliminado << " del inicio" << endl;
        return true;
    }

    // ========================================
    // OPERACIÓN: Eliminar al final
    // ========================================
    /**
     * Elimina el último nodo de la lista
     * Complejidad: O(n)
     */
    bool eliminarAlFinal() {
        // Verificar si la lista está vacía
        if(estaVacia()) {
            cout << "La lista está vacía" << endl;
            return false;
        }

        // Si solo hay un nodo
        if(cabeza->siguiente == nullptr) {
            int valorEliminado = cabeza->dato;
            delete cabeza;
            cabeza = nullptr;
            tamanio--;
            cout << "Eliminado " << valorEliminado << " del final" << endl;
            return true;
        }

        // Encontrar el penúltimo nodo
        Nodo* actual = cabeza;
        while(actual->siguiente->siguiente != nullptr) {
            actual = actual->siguiente;
        }

        // Eliminar el último nodo
        int valorEliminado = actual->siguiente->dato;
        delete actual->siguiente;
        actual->siguiente = nullptr;

        tamanio--;
        cout << "Eliminado " << valorEliminado << " del final" << endl;
        return true;
    }

    // ========================================
    // OPERACIÓN: Eliminar por valor
    // ========================================
    /**
     * Elimina el primer nodo con el valor especificado
     * Complejidad: O(n)
     */
    bool eliminarPorValor(int valor) {
        if(estaVacia()) {
            cout << "La lista está vacía" << endl;
            return false;
        }

        // Si el valor está en la cabeza
        if(cabeza->dato == valor) {
            return eliminarAlInicio();
        }

        // Buscar el nodo anterior al que contiene el valor
        Nodo* actual = cabeza;
        while(actual->siguiente != nullptr && actual->siguiente->dato != valor) {
            actual = actual->siguiente;
        }

        // Si no se encontró el valor
        if(actual->siguiente == nullptr) {
            cout << "Valor " << valor << " no encontrado" << endl;
            return false;
        }

        // Eliminar el nodo
        Nodo* nodoAEliminar = actual->siguiente;
        actual->siguiente = nodoAEliminar->siguiente;
        delete nodoAEliminar;

        tamanio--;
        cout << "Eliminado nodo con valor " << valor << endl;
        return true;
    }

    // ========================================
    // OPERACIÓN: Buscar elemento
    // ========================================
    /**
     * Busca un valor en la lista
     * Complejidad: O(n)
     * Retorna: Posición del elemento o -1 si no existe
     */
    int buscar(int valor) const {
        Nodo* actual = cabeza;
        int posicion = 0;

        while(actual != nullptr) {
            if(actual->dato == valor) {
                return posicion;
            }
            actual = actual->siguiente;
            posicion++;
        }

        return -1;  // No encontrado
    }

    // ========================================
    // OPERACIÓN: Obtener elemento en posición
    // ========================================
    /**
     * Obtiene el valor en una posición específica
     * Complejidad: O(n)
     */
    int obtenerEnPosicion(int posicion) const {
        if(posicion < 0 || posicion >= tamanio) {
            cout << "Posición inválida!" << endl;
            return -1;
        }

        Nodo* actual = cabeza;
        for(int i = 0; i < posicion; i++) {
            actual = actual->siguiente;
        }

        return actual->dato;
    }

    // ========================================
    // OPERACIÓN: Imprimir lista
    // ========================================
    /**
     * Imprime todos los elementos de la lista
     * Complejidad: O(n)
     */
    void imprimir() const {
        if(estaVacia()) {
            cout << "Lista vacía" << endl;
            return;
        }

        Nodo* actual = cabeza;
        cout << "Lista: ";

        while(actual != nullptr) {
            cout << actual->dato;
            if(actual->siguiente != nullptr) {
                cout << " -> ";
            }
            actual = actual->siguiente;
        }

        cout << " -> NULL" << endl;
    }

    // ========================================
    // OPERACIÓN: Limpiar lista
    // ========================================
    /**
     * Elimina todos los nodos y libera memoria
     * Complejidad: O(n)
     */
    void limpiar() {
        while(!estaVacia()) {
            eliminarAlInicio();
        }
        cout << "Lista limpiada" << endl;
    }

    // ========================================
    // OPERACIÓN: Invertir lista
    // ========================================
    /**
     * Invierte el orden de la lista
     * Complejidad: O(n)
     */
    void invertir() {
        Nodo* anterior = nullptr;
        Nodo* actual = cabeza;
        Nodo* siguiente = nullptr;

        while(actual != nullptr) {
            // Guardar el siguiente nodo
            siguiente = actual->siguiente;

            // Invertir el puntero
            actual->siguiente = anterior;

            // Avanzar
            anterior = actual;
            actual = siguiente;
        }

        // Actualizar cabeza
        cabeza = anterior;
        cout << "Lista invertida" << endl;
    }
};

// ============================================
// FUNCIÓN PRINCIPAL - EJEMPLOS
// ============================================

int main() {
    cout << "=== LISTA ENLAZADA SIMPLE ===" << endl << endl;

    // Crear lista
    ListaEnlazada lista;

    // Verificar si está vacía
    cout << "¿Lista vacía? " << (lista.estaVacia() ? "Sí" : "No") << endl;
    cout << endl;

    // Insertar elementos al final
    cout << "--- INSERTAR AL FINAL ---" << endl;
    lista.insertarAlFinal(10);
    lista.insertarAlFinal(20);
    lista.insertarAlFinal(30);
    lista.imprimir();
    cout << endl;

    // Insertar elementos al inicio
    cout << "--- INSERTAR AL INICIO ---" << endl;
    lista.insertarAlInicio(5);
    lista.insertarAlInicio(1);
    lista.imprimir();
    cout << endl;

    // Insertar en posición específica
    cout << "--- INSERTAR EN POSICIÓN ---" << endl;
    lista.insertarEnPosicion(15, 3);
    lista.imprimir();
    cout << "Tamaño: " << lista.obtenerTamanio() << endl;
    cout << endl;

    // Buscar elementos
    cout << "--- BUSCAR ELEMENTOS ---" << endl;
    int valorBuscado = 20;
    int posicion = lista.buscar(valorBuscado);
    if(posicion != -1) {
        cout << "Valor " << valorBuscado << " encontrado en posición " << posicion << endl;
    } else {
        cout << "Valor " << valorBuscado << " no encontrado" << endl;
    }
    cout << endl;

    // Obtener elemento en posición
    cout << "--- OBTENER ELEMENTO ---" << endl;
    cout << "Elemento en posición 2: " << lista.obtenerEnPosicion(2) << endl;
    cout << endl;

    // Eliminar elementos
    cout << "--- ELIMINAR ELEMENTOS ---" << endl;
    lista.eliminarAlInicio();
    lista.imprimir();

    lista.eliminarAlFinal();
    lista.imprimir();

    lista.eliminarPorValor(15);
    lista.imprimir();
    cout << endl;

    // Invertir lista
    cout << "--- INVERTIR LISTA ---" << endl;
    lista.invertir();
    lista.imprimir();
    cout << endl;

    // Limpiar lista
    cout << "--- LIMPIAR LISTA ---" << endl;
    lista.limpiar();
    cout << "¿Lista vacía? " << (lista.estaVacia() ? "Sí" : "No") << endl;

    return 0;
}

/*
 * SALIDA ESPERADA:
 * ================
 * === LISTA ENLAZADA SIMPLE ===
 *
 * ¿Lista vacía? Sí
 *
 * --- INSERTAR AL FINAL ---
 * Insertado 10 al final
 * Insertado 20 al final
 * Insertado 30 al final
 * Lista: 10 -> 20 -> 30 -> NULL
 *
 * --- INSERTAR AL INICIO ---
 * Insertado 5 al inicio
 * Insertado 1 al inicio
 * Lista: 1 -> 5 -> 10 -> 20 -> 30 -> NULL
 *
 * --- INSERTAR EN POSICIÓN ---
 * Insertado 15 en posición 3
 * Lista: 1 -> 5 -> 10 -> 15 -> 20 -> 30 -> NULL
 * Tamaño: 6
 *
 * --- BUSCAR ELEMENTOS ---
 * Valor 20 encontrado en posición 4
 *
 * --- OBTENER ELEMENTO ---
 * Elemento en posición 2: 10
 *
 * --- ELIMINAR ELEMENTOS ---
 * Eliminado 1 del inicio
 * Lista: 5 -> 10 -> 15 -> 20 -> 30 -> NULL
 * Eliminado 30 del final
 * Lista: 5 -> 10 -> 15 -> 20 -> NULL
 * Eliminado nodo con valor 15
 * Lista: 5 -> 10 -> 20 -> NULL
 *
 * --- INVERTIR LISTA ---
 * Lista invertida
 * Lista: 20 -> 10 -> 5 -> NULL
 *
 * --- LIMPIAR LISTA ---
 * Eliminado 20 del inicio
 * Eliminado 10 del inicio
 * Eliminado 5 del inicio
 * Lista limpiada
 * ¿Lista vacía? Sí
 */
