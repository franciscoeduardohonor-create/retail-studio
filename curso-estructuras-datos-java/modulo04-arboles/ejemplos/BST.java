/**
 * MÓDULO 4: ÁRBOLES
 * Árbol Binario de Búsqueda (BST)
 *
 * Propiedad BST: Izquierda < Raíz < Derecha
 */

public class BST {

    public static void main(String[] args) {
        System.out.println("=== ÁRBOL BINARIO DE BÚSQUEDA ===\n");

        ArbolBST arbol = new ArbolBST();

        // Insertar elementos
        System.out.println("Insertando: 50, 30, 70, 20, 40, 60, 80");
        arbol.insertar(50);
        arbol.insertar(30);
        arbol.insertar(70);
        arbol.insertar(20);
        arbol.insertar(40);
        arbol.insertar(60);
        arbol.insertar(80);

        /*
         * Árbol resultante:
         *        50
         *       /  \
         *      30   70
         *     / \   / \
         *    20 40 60 80
         */

        // Recorridos
        System.out.println("\nRecorrido In-orden (ordenado):");
        arbol.inorden();

        System.out.println("\nRecorrido Pre-orden:");
        arbol.preorden();

        System.out.println("\nRecorrido Post-orden:");
        arbol.postorden();

        // Búsqueda
        System.out.println("\n¿Contiene 40? " + arbol.buscar(40));
        System.out.println("¿Contiene 100? " + arbol.buscar(100));

        // Información
        System.out.println("\nAltura del árbol: " + arbol.altura());
        System.out.println("Mínimo valor: " + arbol.minimo());
        System.out.println("Máximo valor: " + arbol.maximo());

        // Eliminar
        System.out.println("\nEliminar 30:");
        arbol.eliminar(30);
        arbol.inorden();
    }
}

/** Nodo del árbol */
class NodoArbol {
    int dato;
    NodoArbol izq, der;

    NodoArbol(int dato) {
        this.dato = dato;
        izq = der = null;
    }
}

/** Árbol Binario de Búsqueda */
class ArbolBST {
    private NodoArbol raiz;

    public ArbolBST() {
        raiz = null;
    }

    /** INSERTAR - O(h) donde h = altura */
    public void insertar(int dato) {
        raiz = insertarRec(raiz, dato);
    }

    private NodoArbol insertarRec(NodoArbol nodo, int dato) {
        if (nodo == null) {
            return new NodoArbol(dato);
        }

        if (dato < nodo.dato) {
            nodo.izq = insertarRec(nodo.izq, dato);
        } else if (dato > nodo.dato) {
            nodo.der = insertarRec(nodo.der, dato);
        }

        return nodo;
    }

    /** BUSCAR - O(h) */
    public boolean buscar(int dato) {
        return buscarRec(raiz, dato);
    }

    private boolean buscarRec(NodoArbol nodo, int dato) {
        if (nodo == null) return false;
        if (nodo.dato == dato) return true;

        return dato < nodo.dato
            ? buscarRec(nodo.izq, dato)
            : buscarRec(nodo.der, dato);
    }

    /** ELIMINAR - O(h) */
    public void eliminar(int dato) {
        raiz = eliminarRec(raiz, dato);
    }

    private NodoArbol eliminarRec(NodoArbol nodo, int dato) {
        if (nodo == null) return null;

        if (dato < nodo.dato) {
            nodo.izq = eliminarRec(nodo.izq, dato);
        } else if (dato > nodo.dato) {
            nodo.der = eliminarRec(nodo.der, dato);
        } else {
            // Caso 1: Sin hijos o un hijo
            if (nodo.izq == null) return nodo.der;
            if (nodo.der == null) return nodo.izq;

            // Caso 2: Dos hijos - reemplazar con sucesor
            nodo.dato = minValor(nodo.der);
            nodo.der = eliminarRec(nodo.der, nodo.dato);
        }
        return nodo;
    }

    /** RECORRIDOS - O(n) */
    public void inorden() {
        inordenRec(raiz);
        System.out.println();
    }

    private void inordenRec(NodoArbol nodo) {
        if (nodo != null) {
            inordenRec(nodo.izq);      // Izquierda
            System.out.print(nodo.dato + " ");  // Raíz
            inordenRec(nodo.der);      // Derecha
        }
    }

    public void preorden() {
        preordenRec(raiz);
        System.out.println();
    }

    private void preordenRec(NodoArbol nodo) {
        if (nodo != null) {
            System.out.print(nodo.dato + " ");
            preordenRec(nodo.izq);
            preordenRec(nodo.der);
        }
    }

    public void postorden() {
        postordenRec(raiz);
        System.out.println();
    }

    private void postordenRec(NodoArbol nodo) {
        if (nodo != null) {
            postordenRec(nodo.izq);
            postordenRec(nodo.der);
            System.out.print(nodo.dato + " ");
        }
    }

    /** ALTURA - O(n) */
    public int altura() {
        return alturaRec(raiz);
    }

    private int alturaRec(NodoArbol nodo) {
        if (nodo == null) return 0;
        return 1 + Math.max(alturaRec(nodo.izq), alturaRec(nodo.der));
    }

    /** MÍNIMO - O(h) */
    public int minimo() {
        return minValor(raiz);
    }

    private int minValor(NodoArbol nodo) {
        while (nodo.izq != null) {
            nodo = nodo.izq;
        }
        return nodo.dato;
    }

    /** MÁXIMO - O(h) */
    public int maximo() {
        NodoArbol actual = raiz;
        while (actual.der != null) {
            actual = actual.der;
        }
        return actual.dato;
    }
}

/*
 * BST COMPLEJIDADES:
 * ==================
 *
 * Operación     | Promedio | Peor Caso
 * --------------|----------|----------
 * Búsqueda      | O(log n) | O(n)*
 * Inserción     | O(log n) | O(n)*
 * Eliminación   | O(log n) | O(n)*
 * Recorrido     | O(n)     | O(n)
 *
 * * Cuando el árbol está desbalanceado (como lista)
 *
 * VENTAJAS BST:
 * - Búsqueda eficiente: O(log n) promedio
 * - Inserción/eliminación eficientes
 * - Mantiene elementos ordenados
 * - Recorrido in-orden da elementos ordenados
 *
 * CUÁNDO USAR:
 * - Datos que necesitan estar ordenados
 * - Búsquedas frecuentes
 * - Rangos de valores (encontrar entre x y y)
 */
