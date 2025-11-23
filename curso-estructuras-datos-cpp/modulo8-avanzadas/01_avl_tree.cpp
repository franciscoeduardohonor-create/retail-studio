/*
 * MÓDULO 8: ÁRBOL AVL (Adelson-Velsky y Landis)
 *
 * Árbol de búsqueda binaria AUTO-BALANCEADO
 * - Mantiene balance: |altura(izq) - altura(der)| ≤ 1
 * - Garantiza O(log n) para buscar, insertar, eliminar
 * - Usa rotaciones para mantener balance
 */

#include <iostream>
#include <algorithm>
using namespace std;

// ============================================
// NODO AVL
// ============================================

struct NodoAVL {
    int dato;
    NodoAVL* izquierdo;
    NodoAVL* derecho;
    int altura;

    NodoAVL(int valor)
        : dato(valor), izquierdo(nullptr), derecho(nullptr), altura(1) {}
};

// ============================================
// CLASE ÁRBOL AVL
// ============================================

class ArbolAVL {
private:
    NodoAVL* raiz;

    // ========================================
    // OBTENER ALTURA
    // ========================================
    int obtenerAltura(NodoAVL* nodo) {
        return nodo ? nodo->altura : 0;
    }

    // ========================================
    // CALCULAR FACTOR DE BALANCE
    // Balance = altura(izq) - altura(der)
    // ========================================
    int obtenerBalance(NodoAVL* nodo) {
        return nodo ? obtenerAltura(nodo->izquierdo) - obtenerAltura(nodo->derecho) : 0;
    }

    // ========================================
    // ACTUALIZAR ALTURA
    // ========================================
    void actualizarAltura(NodoAVL* nodo) {
        if(nodo) {
            nodo->altura = 1 + max(obtenerAltura(nodo->izquierdo),
                                   obtenerAltura(nodo->derecho));
        }
    }

    // ========================================
    // ROTACIÓN DERECHA
    //
    //       y                x
    //      / \              / \
    //     x   C    -->     A   y
    //    / \                  / \
    //   A   B                B   C
    // ========================================
    NodoAVL* rotacionDerecha(NodoAVL* y) {
        NodoAVL* x = y->izquierdo;
        NodoAVL* B = x->derecho;

        // Realizar rotación
        x->derecho = y;
        y->izquierdo = B;

        // Actualizar alturas
        actualizarAltura(y);
        actualizarAltura(x);

        cout << "Rotación derecha en " << y->dato << endl;
        return x;  // Nueva raíz
    }

    // ========================================
    // ROTACIÓN IZQUIERDA
    //
    //     x                    y
    //    / \                  / \
    //   A   y      -->       x   C
    //      / \              / \
    //     B   C            A   B
    // ========================================
    NodoAVL* rotacionIzquierda(NodoAVL* x) {
        NodoAVL* y = x->derecho;
        NodoAVL* B = y->izquierdo;

        // Realizar rotación
        y->izquierdo = x;
        x->derecho = B;

        // Actualizar alturas
        actualizarAltura(x);
        actualizarAltura(y);

        cout << "Rotación izquierda en " << x->dato << endl;
        return y;  // Nueva raíz
    }

    // ========================================
    // INSERTAR Y BALANCEAR
    // ========================================
    NodoAVL* insertar(NodoAVL* nodo, int valor) {
        // 1. Inserción normal BST
        if(nodo == nullptr) {
            cout << "Insertando " << valor << endl;
            return new NodoAVL(valor);
        }

        if(valor < nodo->dato) {
            nodo->izquierdo = insertar(nodo->izquierdo, valor);
        } else if(valor > nodo->dato) {
            nodo->derecho = insertar(nodo->derecho, valor);
        } else {
            cout << "Valor " << valor << " ya existe" << endl;
            return nodo;  // No duplicados
        }

        // 2. Actualizar altura
        actualizarAltura(nodo);

        // 3. Obtener factor de balance
        int balance = obtenerBalance(nodo);

        // 4. Balancear si es necesario (4 casos)

        // Caso 1: Desbalance Izquierda-Izquierda
        if(balance > 1 && valor < nodo->izquierdo->dato) {
            return rotacionDerecha(nodo);
        }

        // Caso 2: Desbalance Derecha-Derecha
        if(balance < -1 && valor > nodo->derecho->dato) {
            return rotacionIzquierda(nodo);
        }

        // Caso 3: Desbalance Izquierda-Derecha
        if(balance > 1 && valor > nodo->izquierdo->dato) {
            nodo->izquierdo = rotacionIzquierda(nodo->izquierdo);
            return rotacionDerecha(nodo);
        }

        // Caso 4: Desbalance Derecha-Izquierda
        if(balance < -1 && valor < nodo->derecho->dato) {
            nodo->derecho = rotacionDerecha(nodo->derecho);
            return rotacionIzquierda(nodo);
        }

        return nodo;
    }

    // ========================================
    // RECORRIDO INORDER
    // ========================================
    void inorder(NodoAVL* nodo) {
        if(nodo) {
            inorder(nodo->izquierdo);
            cout << nodo->dato << " ";
            inorder(nodo->derecho);
        }
    }

    // ========================================
    // BUSCAR
    // ========================================
    bool buscar(NodoAVL* nodo, int valor) {
        if(nodo == nullptr) return false;
        if(nodo->dato == valor) return true;
        if(valor < nodo->dato)
            return buscar(nodo->izquierdo, valor);
        else
            return buscar(nodo->derecho, valor);
    }

    // ========================================
    // MOSTRAR CON INDENTACIÓN
    // ========================================
    void mostrarArbol(NodoAVL* nodo, int nivel = 0) {
        if(nodo != nullptr) {
            mostrarArbol(nodo->derecho, nivel + 1);

            for(int i = 0; i < nivel; i++) {
                cout << "    ";
            }
            cout << nodo->dato << " (h=" << nodo->altura
                 << ", b=" << obtenerBalance(nodo) << ")" << endl;

            mostrarArbol(nodo->izquierdo, nivel + 1);
        }
    }

public:
    ArbolAVL() : raiz(nullptr) {}

    void insertar(int valor) {
        raiz = insertar(raiz, valor);
    }

    bool buscar(int valor) {
        return buscar(raiz, valor);
    }

    void inorder() {
        cout << "Inorder: ";
        inorder(raiz);
        cout << endl;
    }

    void mostrar() {
        cout << "\nEstructura del árbol AVL:" << endl;
        mostrarArbol(raiz);
        cout << endl;
    }

    int altura() {
        return obtenerAltura(raiz);
    }
};

// ============================================
// FUNCIÓN PRINCIPAL
// ============================================

int main() {
    cout << "=== ÁRBOL AVL (AUTO-BALANCEADO) ===" << endl << endl;

    ArbolAVL avl;

    // ========================================
    // INSERTAR ELEMENTOS
    // ========================================
    cout << "--- INSERTANDO ELEMENTOS ---" << endl;

    // Caso que requiere rotaciones
    int valores[] = {10, 20, 30, 40, 50, 25};

    for(int val : valores) {
        cout << "\nInsertando " << val << ":" << endl;
        avl.insertar(val);
        avl.mostrar();
    }

    // ========================================
    // RECORRIDO
    // ========================================
    cout << "--- RECORRIDO ---" << endl;
    avl.inorder();
    cout << "Altura del árbol: " << avl.altura() << endl;
    cout << endl;

    // ========================================
    // BUSCAR ELEMENTOS
    // ========================================
    cout << "--- BUSCAR ELEMENTOS ---" << endl;
    int buscar[] = {25, 100, 30};

    for(int val : buscar) {
        if(avl.buscar(val)) {
            cout << "✓ " << val << " ENCONTRADO" << endl;
        } else {
            cout << "✗ " << val << " NO encontrado" << endl;
        }
    }

    return 0;
}

/*
 * CONCEPTOS CLAVE:
 * ================
 *
 * 1. ÁRBOL AVL:
 *    - Árbol BST balanceado
 *    - Propiedad: |altura(izq) - altura(der)| ≤ 1
 *    - Inventado en 1962 por Adelson-Velsky y Landis
 *
 * 2. FACTOR DE BALANCE:
 *    - Balance = altura(izq) - altura(der)
 *    - Valores válidos: -1, 0, 1
 *    - Si |balance| > 1, requiere rotación
 *
 * 3. ROTACIONES (4 casos):
 *
 *    A) ROTACIÓN DERECHA (LL):
 *       - Desbalance: balance > 1 y nuevo en izq-izq
 *
 *    B) ROTACIÓN IZQUIERDA (RR):
 *       - Desbalance: balance < -1 y nuevo en der-der
 *
 *    C) ROTACIÓN IZQUIERDA-DERECHA (LR):
 *       - Desbalance: balance > 1 y nuevo en izq-der
 *       - Primero rotar izq en hijo izquierdo
 *       - Luego rotar derecha en nodo
 *
 *    D) ROTACIÓN DERECHA-IZQUIERDA (RL):
 *       - Desbalance: balance < -1 y nuevo en der-izq
 *       - Primero rotar derecha en hijo derecho
 *       - Luego rotar izquierda en nodo
 *
 * 4. COMPLEJIDAD GARANTIZADA:
 *    - Búsqueda: O(log n)
 *    - Inserción: O(log n)
 *    - Eliminación: O(log n)
 *    - Espacio: O(n)
 *
 * 5. VENTAJAS:
 *    - Balance estricto
 *    - Búsqueda más rápida que BST normal
 *    - Altura máxima: 1.44 * log(n)
 *
 * 6. DESVENTAJAS:
 *    - Más complejo de implementar
 *    - Más rotaciones que Red-Black Trees
 *    - Overhead de almacenar altura
 *
 * 7. COMPARACIÓN:
 *    - AVL vs BST: AVL más balanceado, búsqueda más rápida
 *    - AVL vs Red-Black: AVL más estricto, RB menos rotaciones
 *
 * 8. APLICACIONES:
 *    - Bases de datos (índices)
 *    - Sistemas que requieren búsqueda rápida
 *    - Cuando hay más búsquedas que inserciones
 */
