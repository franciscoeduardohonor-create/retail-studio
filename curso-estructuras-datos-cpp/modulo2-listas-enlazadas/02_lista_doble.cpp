/*
 * MÓDULO 2: LISTA DOBLEMENTE ENLAZADA
 *
 * Implementación de lista con punteros bidireccionales:
 * - Cada nodo apunta al siguiente Y al anterior
 * - Permite recorrido en ambas direcciones
 * - Facilita eliminación de nodos
 */

#include <iostream>
using namespace std;

// ============================================
// ESTRUCTURA DEL NODO DOBLE
// ============================================

struct NodoDoble {
    int dato;
    NodoDoble* siguiente;  // Puntero al siguiente nodo
    NodoDoble* anterior;   // Puntero al nodo anterior

    // Constructor
    NodoDoble(int valor) : dato(valor), siguiente(nullptr), anterior(nullptr) {}
};

// ============================================
// CLASE LISTA DOBLEMENTE ENLAZADA
// ============================================

class ListaDoble {
private:
    NodoDoble* cabeza;   // Primer nodo
    NodoDoble* cola;     // Último nodo (ventaja de lista doble)
    int tamanio;

public:
    // Constructor
    ListaDoble() : cabeza(nullptr), cola(nullptr), tamanio(0) {}

    // Destructor
    ~ListaDoble() {
        limpiar();
    }

    bool estaVacia() const {
        return cabeza == nullptr;
    }

    int obtenerTamanio() const {
        return tamanio;
    }

    // ========================================
    // INSERTAR AL INICIO
    // Complejidad: O(1)
    // ========================================
    void insertarAlInicio(int valor) {
        NodoDoble* nuevoNodo = new NodoDoble(valor);

        if(estaVacia()) {
            // Si está vacía, el nuevo nodo es cabeza y cola
            cabeza = cola = nuevoNodo;
        } else {
            // Conectar el nuevo nodo con la cabeza actual
            nuevoNodo->siguiente = cabeza;
            cabeza->anterior = nuevoNodo;
            cabeza = nuevoNodo;
        }

        tamanio++;
        cout << "Insertado " << valor << " al inicio" << endl;
    }

    // ========================================
    // INSERTAR AL FINAL
    // Complejidad: O(1) - Ventaja de lista doble con puntero cola
    // ========================================
    void insertarAlFinal(int valor) {
        NodoDoble* nuevoNodo = new NodoDoble(valor);

        if(estaVacia()) {
            cabeza = cola = nuevoNodo;
        } else {
            // Conectar con la cola actual
            nuevoNodo->anterior = cola;
            cola->siguiente = nuevoNodo;
            cola = nuevoNodo;
        }

        tamanio++;
        cout << "Insertado " << valor << " al final" << endl;
    }

    // ========================================
    // ELIMINAR AL INICIO
    // Complejidad: O(1)
    // ========================================
    bool eliminarAlInicio() {
        if(estaVacia()) {
            cout << "Lista vacía" << endl;
            return false;
        }

        NodoDoble* nodoAEliminar = cabeza;
        int valorEliminado = cabeza->dato;

        if(cabeza == cola) {
            // Solo hay un nodo
            cabeza = cola = nullptr;
        } else {
            cabeza = cabeza->siguiente;
            cabeza->anterior = nullptr;
        }

        delete nodoAEliminar;
        tamanio--;
        cout << "Eliminado " << valorEliminado << " del inicio" << endl;
        return true;
    }

    // ========================================
    // ELIMINAR AL FINAL
    // Complejidad: O(1) - Ventaja de lista doble
    // ========================================
    bool eliminarAlFinal() {
        if(estaVacia()) {
            cout << "Lista vacía" << endl;
            return false;
        }

        NodoDoble* nodoAEliminar = cola;
        int valorEliminado = cola->dato;

        if(cabeza == cola) {
            cabeza = cola = nullptr;
        } else {
            cola = cola->anterior;
            cola->siguiente = nullptr;
        }

        delete nodoAEliminar;
        tamanio--;
        cout << "Eliminado " << valorEliminado << " del final" << endl;
        return true;
    }

    // ========================================
    // IMPRIMIR HACIA ADELANTE
    // Complejidad: O(n)
    // ========================================
    void imprimirAdelante() const {
        if(estaVacia()) {
            cout << "Lista vacía" << endl;
            return;
        }

        cout << "Lista (adelante): NULL <-> ";
        NodoDoble* actual = cabeza;

        while(actual != nullptr) {
            cout << actual->dato;
            if(actual->siguiente != nullptr) {
                cout << " <-> ";
            }
            actual = actual->siguiente;
        }

        cout << " <-> NULL" << endl;
    }

    // ========================================
    // IMPRIMIR HACIA ATRÁS
    // Complejidad: O(n)
    // Ventaja única de lista doble
    // ========================================
    void imprimirAtras() const {
        if(estaVacia()) {
            cout << "Lista vacía" << endl;
            return;
        }

        cout << "Lista (atrás): NULL <-> ";
        NodoDoble* actual = cola;

        while(actual != nullptr) {
            cout << actual->dato;
            if(actual->anterior != nullptr) {
                cout << " <-> ";
            }
            actual = actual->anterior;
        }

        cout << " <-> NULL" << endl;
    }

    // ========================================
    // BUSCAR ELEMENTO
    // Complejidad: O(n)
    // ========================================
    int buscar(int valor) const {
        NodoDoble* actual = cabeza;
        int posicion = 0;

        while(actual != nullptr) {
            if(actual->dato == valor) {
                return posicion;
            }
            actual = actual->siguiente;
            posicion++;
        }

        return -1;
    }

    // ========================================
    // ELIMINAR POR VALOR
    // Complejidad: O(n)
    // Más eficiente que lista simple
    // ========================================
    bool eliminarPorValor(int valor) {
        if(estaVacia()) {
            cout << "Lista vacía" << endl;
            return false;
        }

        NodoDoble* actual = cabeza;

        // Buscar el nodo
        while(actual != nullptr && actual->dato != valor) {
            actual = actual->siguiente;
        }

        if(actual == nullptr) {
            cout << "Valor " << valor << " no encontrado" << endl;
            return false;
        }

        // Caso 1: Es el único nodo
        if(actual == cabeza && actual == cola) {
            cabeza = cola = nullptr;
        }
        // Caso 2: Es la cabeza
        else if(actual == cabeza) {
            cabeza = cabeza->siguiente;
            cabeza->anterior = nullptr;
        }
        // Caso 3: Es la cola
        else if(actual == cola) {
            cola = cola->anterior;
            cola->siguiente = nullptr;
        }
        // Caso 4: Está en el medio
        else {
            actual->anterior->siguiente = actual->siguiente;
            actual->siguiente->anterior = actual->anterior;
        }

        delete actual;
        tamanio--;
        cout << "Eliminado nodo con valor " << valor << endl;
        return true;
    }

    // ========================================
    // LIMPIAR LISTA
    // Complejidad: O(n)
    // ========================================
    void limpiar() {
        while(!estaVacia()) {
            eliminarAlInicio();
        }
    }
};

// ============================================
// FUNCIÓN PRINCIPAL
// ============================================

int main() {
    cout << "=== LISTA DOBLEMENTE ENLAZADA ===" << endl << endl;

    ListaDoble lista;

    // Insertar elementos
    cout << "--- INSERTAR ELEMENTOS ---" << endl;
    lista.insertarAlFinal(10);
    lista.insertarAlFinal(20);
    lista.insertarAlFinal(30);
    lista.insertarAlInicio(5);
    lista.insertarAlInicio(1);
    cout << endl;

    // Imprimir en ambas direcciones
    cout << "--- IMPRIMIR EN AMBAS DIRECCIONES ---" << endl;
    lista.imprimirAdelante();
    lista.imprimirAtras();
    cout << "Tamaño: " << lista.obtenerTamanio() << endl;
    cout << endl;

    // Buscar elemento
    cout << "--- BUSCAR ELEMENTO ---" << endl;
    int valorBuscado = 20;
    int pos = lista.buscar(valorBuscado);
    if(pos != -1) {
        cout << "Valor " << valorBuscado << " encontrado en posición " << pos << endl;
    }
    cout << endl;

    // Eliminar elementos
    cout << "--- ELIMINAR ELEMENTOS ---" << endl;
    lista.eliminarAlInicio();
    lista.imprimirAdelante();

    lista.eliminarAlFinal();
    lista.imprimirAdelante();

    lista.eliminarPorValor(10);
    lista.imprimirAdelante();
    cout << endl;

    // Verificar recorrido inverso
    cout << "--- RECORRIDO INVERSO ---" << endl;
    lista.imprimirAtras();

    return 0;
}

/*
 * VENTAJAS DE LISTA DOBLE vs SIMPLE:
 * ===================================
 *
 * 1. Inserción al final: O(1) vs O(n)
 * 2. Eliminación al final: O(1) vs O(n)
 * 3. Recorrido bidireccional
 * 4. Eliminación más eficiente (sin buscar nodo anterior)
 * 5. Mejor para implementar deques
 *
 * DESVENTAJAS:
 * ============
 * 1. Más memoria por nodo (puntero extra)
 * 2. Más compleja de implementar
 * 3. Más punteros que actualizar
 */
