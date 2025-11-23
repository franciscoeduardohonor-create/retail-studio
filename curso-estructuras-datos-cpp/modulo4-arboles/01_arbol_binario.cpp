/*
 * MÓDULO 4: ÁRBOL BINARIO Y ÁRBOL DE BÚSQUEDA BINARIA (BST)
 *
 * Estructura de datos jerárquica donde:
 * - Cada nodo tiene máximo 2 hijos (izquierdo y derecho)
 * - En BST: hijo izquierdo < padre < hijo derecho
 * - Operaciones de búsqueda, inserción y eliminación
 * - Recorridos: Inorder, Preorder, Postorder
 */

#include <iostream>
#include <queue>
using namespace std;

// ============================================
// ESTRUCTURA DEL NODO
// ============================================

struct NodoArbol {
    int dato;
    NodoArbol* izquierdo;
    NodoArbol* derecho;

    // Constructor
    NodoArbol(int valor) : dato(valor), izquierdo(nullptr), derecho(nullptr) {}
};

// ============================================
// CLASE ÁRBOL DE BÚSQUEDA BINARIA
// ============================================

class ArbolBST {
private:
    NodoArbol* raiz;

    // ========================================
    // FUNCIÓN AUXILIAR: Insertar recursivo
    // ========================================
    NodoArbol* insertarRecursivo(NodoArbol* nodo, int valor) {
        // Caso base: posición encontrada
        if(nodo == nullptr) {
            cout << "Insertando " << valor << endl;
            return new NodoArbol(valor);
        }

        // Recursión: navegar por el árbol
        if(valor < nodo->dato) {
            nodo->izquierdo = insertarRecursivo(nodo->izquierdo, valor);
        } else if(valor > nodo->dato) {
            nodo->derecho = insertarRecursivo(nodo->derecho, valor);
        } else {
            cout << "Valor " << valor << " ya existe" << endl;
        }

        return nodo;
    }

    // ========================================
    // FUNCIÓN AUXILIAR: Buscar recursivo
    // ========================================
    bool buscarRecursivo(NodoArbol* nodo, int valor) const {
        // Caso base: no encontrado
        if(nodo == nullptr) {
            return false;
        }

        // Caso base: encontrado
        if(nodo->dato == valor) {
            return true;
        }

        // Recursión
        if(valor < nodo->dato) {
            return buscarRecursivo(nodo->izquierdo, valor);
        } else {
            return buscarRecursivo(nodo->derecho, valor);
        }
    }

    // ========================================
    // FUNCIÓN AUXILIAR: Encontrar mínimo
    // ========================================
    NodoArbol* encontrarMinimo(NodoArbol* nodo) {
        while(nodo->izquierdo != nullptr) {
            nodo = nodo->izquierdo;
        }
        return nodo;
    }

    // ========================================
    // FUNCIÓN AUXILIAR: Eliminar recursivo
    // ========================================
    NodoArbol* eliminarRecursivo(NodoArbol* nodo, int valor) {
        if(nodo == nullptr) {
            return nullptr;
        }

        // Buscar el nodo a eliminar
        if(valor < nodo->dato) {
            nodo->izquierdo = eliminarRecursivo(nodo->izquierdo, valor);
        } else if(valor > nodo->dato) {
            nodo->derecho = eliminarRecursivo(nodo->derecho, valor);
        } else {
            // Nodo encontrado - 3 casos:

            // Caso 1: Sin hijos (nodo hoja)
            if(nodo->izquierdo == nullptr && nodo->derecho == nullptr) {
                delete nodo;
                return nullptr;
            }

            // Caso 2: Un solo hijo
            if(nodo->izquierdo == nullptr) {
                NodoArbol* temp = nodo->derecho;
                delete nodo;
                return temp;
            }
            if(nodo->derecho == nullptr) {
                NodoArbol* temp = nodo->izquierdo;
                delete nodo;
                return temp;
            }

            // Caso 3: Dos hijos
            // Encontrar sucesor (mínimo del subárbol derecho)
            NodoArbol* sucesor = encontrarMinimo(nodo->derecho);
            nodo->dato = sucesor->dato;
            nodo->derecho = eliminarRecursivo(nodo->derecho, sucesor->dato);
        }

        return nodo;
    }

    // ========================================
    // RECORRIDO INORDER (Izquierda - Raíz - Derecha)
    // Resultado: Orden ascendente en BST
    // ========================================
    void inorderRecursivo(NodoArbol* nodo) const {
        if(nodo != nullptr) {
            inorderRecursivo(nodo->izquierdo);
            cout << nodo->dato << " ";
            inorderRecursivo(nodo->derecho);
        }
    }

    // ========================================
    // RECORRIDO PREORDER (Raíz - Izquierda - Derecha)
    // Útil para copiar el árbol
    // ========================================
    void preorderRecursivo(NodoArbol* nodo) const {
        if(nodo != nullptr) {
            cout << nodo->dato << " ";
            preorderRecursivo(nodo->izquierdo);
            preorderRecursivo(nodo->derecho);
        }
    }

    // ========================================
    // RECORRIDO POSTORDER (Izquierda - Derecha - Raíz)
    // Útil para eliminar el árbol
    // ========================================
    void postorderRecursivo(NodoArbol* nodo) const {
        if(nodo != nullptr) {
            postorderRecursivo(nodo->izquierdo);
            postorderRecursivo(nodo->derecho);
            cout << nodo->dato << " ";
        }
    }

    // ========================================
    // CALCULAR ALTURA
    // ========================================
    int calcularAltura(NodoArbol* nodo) const {
        if(nodo == nullptr) {
            return 0;
        }

        int alturaIzq = calcularAltura(nodo->izquierdo);
        int alturaDer = calcularAltura(nodo->derecho);

        return 1 + max(alturaIzq, alturaDer);
    }

    // ========================================
    // CONTAR NODOS
    // ========================================
    int contarNodos(NodoArbol* nodo) const {
        if(nodo == nullptr) {
            return 0;
        }
        return 1 + contarNodos(nodo->izquierdo) + contarNodos(nodo->derecho);
    }

    // ========================================
    // LIBERAR MEMORIA
    // ========================================
    void liberarMemoria(NodoArbol* nodo) {
        if(nodo != nullptr) {
            liberarMemoria(nodo->izquierdo);
            liberarMemoria(nodo->derecho);
            delete nodo;
        }
    }

public:
    // Constructor
    ArbolBST() : raiz(nullptr) {}

    // Destructor
    ~ArbolBST() {
        liberarMemoria(raiz);
    }

    // ========================================
    // OPERACIONES PÚBLICAS
    // ========================================

    /**
     * Insertar elemento
     * Complejidad: O(h) donde h es la altura
     * Mejor caso: O(log n), Peor caso: O(n)
     */
    void insertar(int valor) {
        raiz = insertarRecursivo(raiz, valor);
    }

    /**
     * Buscar elemento
     * Complejidad: O(h)
     */
    bool buscar(int valor) const {
        return buscarRecursivo(raiz, valor);
    }

    /**
     * Eliminar elemento
     * Complejidad: O(h)
     */
    void eliminar(int valor) {
        raiz = eliminarRecursivo(raiz, valor);
        cout << "Eliminado " << valor << endl;
    }

    /**
     * Recorrido Inorder
     */
    void inorder() const {
        cout << "Inorder (Izq-Raíz-Der): ";
        inorderRecursivo(raiz);
        cout << endl;
    }

    /**
     * Recorrido Preorder
     */
    void preorder() const {
        cout << "Preorder (Raíz-Izq-Der): ";
        preorderRecursivo(raiz);
        cout << endl;
    }

    /**
     * Recorrido Postorder
     */
    void postorder() const {
        cout << "Postorder (Izq-Der-Raíz): ";
        postorderRecursivo(raiz);
        cout << endl;
    }

    /**
     * Recorrido por niveles (BFS)
     * Complejidad: O(n)
     */
    void recorridoPorNiveles() const {
        if(raiz == nullptr) {
            cout << "Árbol vacío" << endl;
            return;
        }

        queue<NodoArbol*> cola;
        cola.push(raiz);

        cout << "Recorrido por niveles: ";

        while(!cola.empty()) {
            NodoArbol* actual = cola.front();
            cola.pop();

            cout << actual->dato << " ";

            if(actual->izquierdo != nullptr) {
                cola.push(actual->izquierdo);
            }
            if(actual->derecho != nullptr) {
                cola.push(actual->derecho);
            }
        }

        cout << endl;
    }

    /**
     * Obtener altura del árbol
     */
    int altura() const {
        return calcularAltura(raiz);
    }

    /**
     * Contar nodos totales
     */
    int tamanio() const {
        return contarNodos(raiz);
    }

    /**
     * Verificar si está vacío
     */
    bool estaVacio() const {
        return raiz == nullptr;
    }

    /**
     * Encontrar valor mínimo
     */
    int encontrarMinimo() const {
        if(raiz == nullptr) {
            cout << "Árbol vacío" << endl;
            return -1;
        }
        NodoArbol* minimo = encontrarMinimo(raiz);
        return minimo->dato;
    }

    /**
     * Encontrar valor máximo
     */
    int encontrarMaximo() const {
        if(raiz == nullptr) {
            cout << "Árbol vacío" << endl;
            return -1;
        }

        NodoArbol* actual = raiz;
        while(actual->derecho != nullptr) {
            actual = actual->derecho;
        }
        return actual->dato;
    }
};

// ============================================
// FUNCIÓN PRINCIPAL
// ============================================

int main() {
    cout << "=== ÁRBOL DE BÚSQUEDA BINARIA (BST) ===" << endl << endl;

    // Crear árbol
    ArbolBST arbol;

    // ========================================
    // INSERTAR ELEMENTOS
    // ========================================
    cout << "--- INSERTAR ELEMENTOS ---" << endl;
    arbol.insertar(50);
    arbol.insertar(30);
    arbol.insertar(70);
    arbol.insertar(20);
    arbol.insertar(40);
    arbol.insertar(60);
    arbol.insertar(80);
    cout << endl;

    /*
     * Estructura del árbol:
     *         50
     *        /  \
     *      30    70
     *     / \   / \
     *   20  40 60  80
     */

    // ========================================
    // RECORRIDOS
    // ========================================
    cout << "--- RECORRIDOS DEL ÁRBOL ---" << endl;
    arbol.inorder();              // 20 30 40 50 60 70 80
    arbol.preorder();             // 50 30 20 40 70 60 80
    arbol.postorder();            // 20 40 30 60 80 70 50
    arbol.recorridoPorNiveles();  // 50 30 70 20 40 60 80
    cout << endl;

    // ========================================
    // PROPIEDADES DEL ÁRBOL
    // ========================================
    cout << "--- PROPIEDADES ---" << endl;
    cout << "Altura del árbol: " << arbol.altura() << endl;
    cout << "Número de nodos: " << arbol.tamanio() << endl;
    cout << "Valor mínimo: " << arbol.encontrarMinimo() << endl;
    cout << "Valor máximo: " << arbol.encontrarMaximo() << endl;
    cout << endl;

    // ========================================
    // BUSCAR ELEMENTOS
    // ========================================
    cout << "--- BUSCAR ELEMENTOS ---" << endl;
    int valoresBuscar[] = {40, 100, 70, 25};

    for(int valor : valoresBuscar) {
        if(arbol.buscar(valor)) {
            cout << "✓ Valor " << valor << " ENCONTRADO" << endl;
        } else {
            cout << "✗ Valor " << valor << " NO encontrado" << endl;
        }
    }
    cout << endl;

    // ========================================
    // ELIMINAR ELEMENTOS
    // ========================================
    cout << "--- ELIMINAR ELEMENTOS ---" << endl;

    // Eliminar hoja
    cout << "Eliminando 20 (nodo hoja):" << endl;
    arbol.eliminar(20);
    arbol.inorder();

    // Eliminar nodo con un hijo
    cout << "\nEliminando 30 (un hijo):" << endl;
    arbol.eliminar(30);
    arbol.inorder();

    // Eliminar nodo con dos hijos
    cout << "\nEliminando 50 (raíz con dos hijos):" << endl;
    arbol.eliminar(50);
    arbol.inorder();
    cout << endl;

    // ========================================
    // ESTADO FINAL
    // ========================================
    cout << "--- ESTADO FINAL DEL ÁRBOL ---" << endl;
    arbol.recorridoPorNiveles();
    cout << "Altura: " << arbol.altura() << endl;
    cout << "Tamaño: " << arbol.tamanio() << endl;

    return 0;
}

/*
 * CONCEPTOS CLAVE:
 * ================
 *
 * 1. ÁRBOL BINARIO:
 *    - Cada nodo tiene máximo 2 hijos
 *    - Estructura jerárquica
 *
 * 2. BST (Binary Search Tree):
 *    - Propiedad: izquierdo < raíz < derecho
 *    - Búsqueda eficiente: O(log n) en promedio
 *
 * 3. RECORRIDOS:
 *    - Inorder (DFS): Izq → Raíz → Der
 *      * En BST produce orden ascendente
 *    - Preorder (DFS): Raíz → Izq → Der
 *      * Útil para copiar árbol
 *    - Postorder (DFS): Izq → Der → Raíz
 *      * Útil para eliminar árbol
 *    - Level Order (BFS): Por niveles
 *      * Usa cola
 *
 * 4. COMPLEJIDAD:
 *    - Árbol balanceado: O(log n)
 *    - Árbol degenerado: O(n)
 *
 * 5. OPERACIONES:
 *    - Insertar: O(h)
 *    - Buscar: O(h)
 *    - Eliminar: O(h)
 *    donde h = altura
 *
 * 6. CASOS DE ELIMINACIÓN:
 *    - Nodo hoja: Eliminar directo
 *    - Un hijo: Reemplazar con hijo
 *    - Dos hijos: Reemplazar con sucesor inorder
 *
 * 7. APLICACIONES:
 *    - Búsqueda rápida
 *    - Diccionarios
 *    - Implementar conjuntos
 *    - Sistemas de archivos
 */
