/*
 * MÓDULO 3: COLA (QUEUE)
 *
 * Estructura de datos FIFO (First In, First Out)
 * - El primero en entrar es el primero en salir
 * - Operaciones principales: enqueue, dequeue, front
 * - Aplicaciones: sistemas de espera, BFS, scheduling
 */

#include <iostream>
#include <queue>  // Para comparar con STL
using namespace std;

// ============================================
// IMPLEMENTACIÓN CON ARRAY CIRCULAR
// ============================================

class ColaArray {
private:
    static const int MAX = 100;
    int arr[MAX];
    int frente;   // Índice del primer elemento
    int final;    // Índice después del último elemento
    int contador; // Cantidad de elementos

public:
    // Constructor
    ColaArray() : frente(0), final(0), contador(0) {}

    // ========================================
    // Verificar si está vacía
    // Complejidad: O(1)
    // ========================================
    bool estaVacia() const {
        return contador == 0;
    }

    // ========================================
    // Verificar si está llena
    // Complejidad: O(1)
    // ========================================
    bool estaLlena() const {
        return contador == MAX;
    }

    // ========================================
    // OPERACIÓN: Enqueue (Insertar al final)
    // Complejidad: O(1)
    // ========================================
    bool enqueue(int valor) {
        if(estaLlena()) {
            cout << "Error: Cola llena" << endl;
            return false;
        }

        arr[final] = valor;
        final = (final + 1) % MAX;  // Array circular
        contador++;

        cout << "Enqueue: " << valor << endl;
        return true;
    }

    // ========================================
    // OPERACIÓN: Dequeue (Eliminar del frente)
    // Complejidad: O(1)
    // ========================================
    int dequeue() {
        if(estaVacia()) {
            cout << "Error: Cola vacía" << endl;
            return -1;
        }

        int valor = arr[frente];
        frente = (frente + 1) % MAX;  // Array circular
        contador--;

        cout << "Dequeue: " << valor << endl;
        return valor;
    }

    // ========================================
    // OPERACIÓN: Front (Ver primero sin eliminar)
    // Complejidad: O(1)
    // ========================================
    int front() const {
        if(estaVacia()) {
            cout << "Error: Cola vacía" << endl;
            return -1;
        }
        return arr[frente];
    }

    // ========================================
    // Obtener tamaño
    // Complejidad: O(1)
    // ========================================
    int tamanio() const {
        return contador;
    }

    // ========================================
    // Mostrar cola
    // Complejidad: O(n)
    // ========================================
    void mostrar() const {
        if(estaVacia()) {
            cout << "Cola vacía" << endl;
            return;
        }

        cout << "Cola (frente -> final): ";
        int indice = frente;
        for(int i = 0; i < contador; i++) {
            cout << arr[indice];
            if(i < contador - 1) cout << " <- ";
            indice = (indice + 1) % MAX;
        }
        cout << endl;
    }
};

// ============================================
// IMPLEMENTACIÓN CON LISTA ENLAZADA
// ============================================

struct Nodo {
    int dato;
    Nodo* siguiente;
    Nodo(int val) : dato(val), siguiente(nullptr) {}
};

class ColaLista {
private:
    Nodo* frente;  // Primer elemento (sale primero)
    Nodo* final;   // Último elemento (entra último)
    int contador;

public:
    // Constructor
    ColaLista() : frente(nullptr), final(nullptr), contador(0) {}

    // Destructor
    ~ColaLista() {
        while(!estaVacia()) {
            dequeue();
        }
    }

    bool estaVacia() const {
        return frente == nullptr;
    }

    // ========================================
    // Enqueue - Insertar al final
    // Complejidad: O(1)
    // ========================================
    void enqueue(int valor) {
        Nodo* nuevoNodo = new Nodo(valor);

        if(estaVacia()) {
            // Si está vacía, frente y final apuntan al nuevo nodo
            frente = final = nuevoNodo;
        } else {
            // Agregar al final
            final->siguiente = nuevoNodo;
            final = nuevoNodo;
        }

        contador++;
        cout << "Enqueue: " << valor << endl;
    }

    // ========================================
    // Dequeue - Eliminar del frente
    // Complejidad: O(1)
    // ========================================
    int dequeue() {
        if(estaVacia()) {
            cout << "Error: Cola vacía" << endl;
            return -1;
        }

        Nodo* nodoAEliminar = frente;
        int valor = frente->dato;

        frente = frente->siguiente;

        // Si la cola queda vacía, actualizar final
        if(frente == nullptr) {
            final = nullptr;
        }

        delete nodoAEliminar;
        contador--;

        cout << "Dequeue: " << valor << endl;
        return valor;
    }

    int front() const {
        if(estaVacia()) {
            cout << "Error: Cola vacía" << endl;
            return -1;
        }
        return frente->dato;
    }

    int tamanio() const {
        return contador;
    }

    void mostrar() const {
        if(estaVacia()) {
            cout << "Cola vacía" << endl;
            return;
        }

        cout << "Cola (frente -> final): ";
        Nodo* actual = frente;
        while(actual != nullptr) {
            cout << actual->dato;
            if(actual->siguiente != nullptr) cout << " <- ";
            actual = actual->siguiente;
        }
        cout << endl;
    }
};

// ============================================
// COLA DE PRIORIDAD SIMPLE (MIN HEAP)
// ============================================

class ColaPrioridad {
private:
    static const int MAX = 100;
    int arr[MAX];
    int tamanio;

    // Ordenar insertando en posición correcta
    void insertarOrdenado(int valor) {
        int i = tamanio - 1;
        // Mover elementos mayores una posición a la derecha
        while(i >= 0 && arr[i] > valor) {
            arr[i + 1] = arr[i];
            i--;
        }
        arr[i + 1] = valor;
    }

public:
    ColaPrioridad() : tamanio(0) {}

    bool estaVacia() const {
        return tamanio == 0;
    }

    // Insertar con prioridad (menor valor = mayor prioridad)
    // Complejidad: O(n)
    void enqueue(int valor) {
        if(tamanio >= MAX) {
            cout << "Error: Cola llena" << endl;
            return;
        }

        arr[tamanio++] = valor;
        insertarOrdenado(valor);
        cout << "Enqueue con prioridad: " << valor << endl;
    }

    // Dequeue - Eliminar elemento de mayor prioridad (menor valor)
    // Complejidad: O(1)
    int dequeue() {
        if(estaVacia()) {
            cout << "Error: Cola vacía" << endl;
            return -1;
        }

        int valor = arr[0];
        // Mover todos los elementos una posición a la izquierda
        for(int i = 0; i < tamanio - 1; i++) {
            arr[i] = arr[i + 1];
        }
        tamanio--;

        cout << "Dequeue prioritario: " << valor << endl;
        return valor;
    }

    void mostrar() const {
        if(estaVacia()) {
            cout << "Cola vacía" << endl;
            return;
        }

        cout << "Cola de prioridad: ";
        for(int i = 0; i < tamanio; i++) {
            cout << arr[i] << " ";
        }
        cout << endl;
    }
};

// ============================================
// APLICACIONES PRÁCTICAS
// ============================================

/**
 * EJEMPLO: Sistema de turnos en banco
 */
void sistemaDeAtencion() {
    cout << "\n=== SIMULACIÓN: SISTEMA DE ATENCIÓN ===\n" << endl;

    ColaLista banco;

    cout << "Llegada de clientes:" << endl;
    banco.enqueue(101);  // Cliente 101
    banco.enqueue(102);  // Cliente 102
    banco.enqueue(103);  // Cliente 103
    banco.enqueue(104);  // Cliente 104

    banco.mostrar();
    cout << "Próximo cliente a atender: " << banco.front() << endl << endl;

    cout << "Atendiendo clientes:" << endl;
    banco.dequeue();  // Atender cliente 101
    banco.dequeue();  // Atender cliente 102

    banco.mostrar();

    cout << "\nLlega un nuevo cliente:" << endl;
    banco.enqueue(105);

    banco.mostrar();
}

// ============================================
// FUNCIÓN PRINCIPAL
// ============================================

int main() {
    cout << "=== ESTRUCTURA DE DATOS: COLA (QUEUE) ===" << endl << endl;

    // ========================================
    // DEMOSTRACIÓN CON ARRAY CIRCULAR
    // ========================================
    cout << "--- COLA CON ARRAY CIRCULAR ---" << endl;
    ColaArray cola1;

    cola1.enqueue(10);
    cola1.enqueue(20);
    cola1.enqueue(30);
    cola1.enqueue(40);
    cola1.mostrar();

    cout << "Primer elemento: " << cola1.front() << endl;
    cout << "Tamaño: " << cola1.tamanio() << endl;

    cola1.dequeue();
    cola1.dequeue();
    cola1.mostrar();
    cout << endl;

    // ========================================
    // DEMOSTRACIÓN CON LISTA ENLAZADA
    // ========================================
    cout << "--- COLA CON LISTA ENLAZADA ---" << endl;
    ColaLista cola2;

    cola2.enqueue(5);
    cola2.enqueue(15);
    cola2.enqueue(25);
    cola2.enqueue(35);
    cola2.mostrar();

    cout << "Frente: " << cola2.front() << endl;
    cola2.dequeue();
    cola2.mostrar();
    cout << endl;

    // ========================================
    // COLA DE PRIORIDAD
    // ========================================
    cout << "--- COLA DE PRIORIDAD ---" << endl;
    ColaPrioridad colaPrio;

    cout << "Insertando con prioridades:" << endl;
    colaPrio.enqueue(30);  // Prioridad 30
    colaPrio.enqueue(10);  // Prioridad 10 (mayor prioridad)
    colaPrio.enqueue(50);  // Prioridad 50
    colaPrio.enqueue(20);  // Prioridad 20

    colaPrio.mostrar();

    cout << "\nAtendiendo por prioridad (menor número = mayor prioridad):" << endl;
    colaPrio.dequeue();  // Deberá sacar el 10
    colaPrio.dequeue();  // Deberá sacar el 20
    colaPrio.mostrar();
    cout << endl;

    // ========================================
    // APLICACIÓN PRÁCTICA
    // ========================================
    sistemaDeAtencion();

    return 0;
}

/*
 * CONCEPTOS CLAVE:
 * ================
 *
 * 1. FIFO (First In, First Out)
 *    - El primero en entrar es el primero en salir
 *    - Como una fila de personas
 *
 * 2. Operaciones principales (todas O(1)):
 *    - enqueue(): Agregar al final
 *    - dequeue(): Eliminar del frente
 *    - front(): Ver el frente
 *    - isEmpty(): Verificar si vacía
 *
 * 3. Tipos de implementación:
 *    - Array circular: Evita desperdicio de espacio
 *    - Lista enlazada: Tamaño dinámico
 *
 * 4. Variantes:
 *    - Cola simple (FIFO)
 *    - Cola de prioridad
 *    - Cola doble (Deque)
 *    - Cola circular
 *
 * 5. Aplicaciones comunes:
 *    - Sistemas de impresión (print queue)
 *    - Atención al cliente (turnos)
 *    - Algoritmos BFS (Breadth-First Search)
 *    - Scheduling de procesos
 *    - Buffers de comunicación
 *    - Procesamiento asíncrono
 *
 * 6. Diferencias con Pila:
 *    - Pila: LIFO (último entra, primero sale)
 *    - Cola: FIFO (primero entra, primero sale)
 */
