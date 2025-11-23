/**
 * MÓDULO 2: LISTAS ENLAZADAS
 * Ejemplo 1: Implementación Completa de Lista Simplemente Enlazada
 *
 * Una lista enlazada es una estructura de datos donde cada elemento (nodo)
 * contiene un dato y una referencia al siguiente nodo.
 *
 * Estructura:
 * HEAD -> [dato|→] -> [dato|→] -> [dato|→] -> null
 */

public class ListaSimple {

    public static void main(String[] args) {
        System.out.println("=== LISTA SIMPLEMENTE ENLAZADA ===\n");

        // Crear una nueva lista
        MiListaEnlazada lista = new MiListaEnlazada();

        // ==========================================
        // 1. AGREGAR ELEMENTOS
        // ==========================================
        System.out.println("=== INSERCIÓN DE ELEMENTOS ===");

        // Agregar al final
        System.out.println("\nAgregar al final:");
        lista.agregarAlFinal(10);
        lista.agregarAlFinal(20);
        lista.agregarAlFinal(30);
        lista.imprimir();  // 10 -> 20 -> 30 -> null

        // Agregar al inicio
        System.out.println("\nAgregar al inicio:");
        lista.agregarAlInicio(5);
        lista.imprimir();  // 5 -> 10 -> 20 -> 30 -> null

        // Insertar en posición específica
        System.out.println("\nInsertar 15 en posición 2:");
        lista.insertarEnPosicion(15, 2);
        lista.imprimir();  // 5 -> 10 -> 15 -> 20 -> 30 -> null

        // ==========================================
        // 2. ACCESO Y BÚSQUEDA
        // ==========================================
        System.out.println("\n=== ACCESO Y BÚSQUEDA ===");

        // Obtener por índice
        System.out.println("\nElemento en posición 2: " + lista.obtener(2));
        System.out.println("Elemento en posición 4: " + lista.obtener(4));

        // Buscar elemento
        int buscar = 20;
        int posicion = lista.buscar(buscar);
        if (posicion != -1) {
            System.out.println("Elemento " + buscar + " encontrado en posición: " + posicion);
        }

        // Verificar si contiene
        System.out.println("¿Contiene 15? " + lista.contiene(15));
        System.out.println("¿Contiene 100? " + lista.contiene(100));

        // ==========================================
        // 3. ELIMINACIÓN
        // ==========================================
        System.out.println("\n=== ELIMINACIÓN DE ELEMENTOS ===");

        // Eliminar primero
        System.out.println("\nEliminar primer elemento:");
        int eliminado = lista.eliminarPrimero();
        System.out.println("Elemento eliminado: " + eliminado);
        lista.imprimir();

        // Eliminar último
        System.out.println("\nEliminar último elemento:");
        eliminado = lista.eliminarUltimo();
        System.out.println("Elemento eliminado: " + eliminado);
        lista.imprimir();

        // Eliminar por valor
        System.out.println("\nEliminar elemento 15:");
        boolean exito = lista.eliminarPorValor(15);
        System.out.println("¿Se eliminó? " + exito);
        lista.imprimir();

        // Eliminar por posición
        System.out.println("\nEliminar elemento en posición 0:");
        lista.eliminarEnPosicion(0);
        lista.imprimir();

        // ==========================================
        // 4. INFORMACIÓN DE LA LISTA
        // ==========================================
        System.out.println("\n=== INFORMACIÓN ===");
        System.out.println("Tamaño de la lista: " + lista.tamanio());
        System.out.println("¿Está vacía? " + lista.estaVacia());
        System.out.println("Primer elemento: " + lista.obtenerPrimero());
        System.out.println("Último elemento: " + lista.obtenerUltimo());

        // ==========================================
        // 5. OPERACIONES ADICIONALES
        // ==========================================
        System.out.println("\n=== OPERACIONES ADICIONALES ===");

        // Crear otra lista para demostración
        MiListaEnlazada lista2 = new MiListaEnlazada();
        lista2.agregarAlFinal(1);
        lista2.agregarAlFinal(2);
        lista2.agregarAlFinal(3);
        lista2.agregarAlFinal(4);
        lista2.agregarAlFinal(5);

        System.out.println("\nLista original:");
        lista2.imprimir();

        // Invertir lista
        System.out.println("\nLista invertida:");
        lista2.invertir();
        lista2.imprimir();

        // Limpiar lista
        lista2.limpiar();
        System.out.println("\nDespués de limpiar:");
        lista2.imprimir();
        System.out.println("¿Está vacía? " + lista2.estaVacia());
    }
}

/**
 * CLASE NODO
 * Representa un nodo individual de la lista
 */
class Nodo {
    int dato;           // Valor almacenado
    Nodo siguiente;     // Referencia al siguiente nodo

    /**
     * Constructor del nodo
     */
    Nodo(int dato) {
        this.dato = dato;
        this.siguiente = null;
    }
}

/**
 * CLASE MiListaEnlazada
 * Implementación completa de una lista simplemente enlazada
 */
class MiListaEnlazada {
    private Nodo cabeza;  // Primer nodo de la lista (head)
    private int tamanio;  // Cantidad de elementos

    /**
     * Constructor: crea una lista vacía
     */
    public MiListaEnlazada() {
        this.cabeza = null;
        this.tamanio = 0;
    }

    // ==========================================
    // MÉTODOS DE INSERCIÓN
    // ==========================================

    /**
     * Agrega un elemento al FINAL de la lista
     * Complejidad: O(n) - debe recorrer hasta el final
     */
    public void agregarAlFinal(int dato) {
        Nodo nuevoNodo = new Nodo(dato);

        // Caso especial: lista vacía
        if (cabeza == null) {
            cabeza = nuevoNodo;
        } else {
            // Recorrer hasta el último nodo
            Nodo actual = cabeza;
            while (actual.siguiente != null) {
                actual = actual.siguiente;
            }
            // Enlazar el nuevo nodo
            actual.siguiente = nuevoNodo;
        }
        tamanio++;
    }

    /**
     * Agrega un elemento al INICIO de la lista
     * Complejidad: O(1) - muy eficiente!
     */
    public void agregarAlInicio(int dato) {
        Nodo nuevoNodo = new Nodo(dato);
        nuevoNodo.siguiente = cabeza;  // El nuevo apunta al actual primero
        cabeza = nuevoNodo;             // El nuevo se convierte en cabeza
        tamanio++;
    }

    /**
     * Inserta un elemento en una posición específica
     * Complejidad: O(n)
     */
    public void insertarEnPosicion(int dato, int indice) {
        // Validar índice
        if (indice < 0 || indice > tamanio) {
            throw new IndexOutOfBoundsException("Índice fuera de rango: " + indice);
        }

        // Caso especial: insertar al inicio
        if (indice == 0) {
            agregarAlInicio(dato);
            return;
        }

        Nodo nuevoNodo = new Nodo(dato);

        // Avanzar hasta el nodo anterior a la posición
        Nodo actual = cabeza;
        for (int i = 0; i < indice - 1; i++) {
            actual = actual.siguiente;
        }

        // Insertar el nuevo nodo
        nuevoNodo.siguiente = actual.siguiente;
        actual.siguiente = nuevoNodo;
        tamanio++;
    }

    // ==========================================
    // MÉTODOS DE ELIMINACIÓN
    // ==========================================

    /**
     * Elimina y retorna el PRIMER elemento
     * Complejidad: O(1)
     */
    public int eliminarPrimero() {
        if (cabeza == null) {
            throw new RuntimeException("Lista vacía");
        }

        int dato = cabeza.dato;
        cabeza = cabeza.siguiente;  // La cabeza ahora es el segundo nodo
        tamanio--;
        return dato;
    }

    /**
     * Elimina y retorna el ÚLTIMO elemento
     * Complejidad: O(n) - debe recorrer hasta el penúltimo
     */
    public int eliminarUltimo() {
        if (cabeza == null) {
            throw new RuntimeException("Lista vacía");
        }

        // Caso especial: solo un elemento
        if (cabeza.siguiente == null) {
            int dato = cabeza.dato;
            cabeza = null;
            tamanio--;
            return dato;
        }

        // Avanzar hasta el penúltimo nodo
        Nodo actual = cabeza;
        while (actual.siguiente.siguiente != null) {
            actual = actual.siguiente;
        }

        int dato = actual.siguiente.dato;
        actual.siguiente = null;  // Eliminar el último
        tamanio--;
        return dato;
    }

    /**
     * Elimina la primera ocurrencia de un valor
     * Complejidad: O(n)
     */
    public boolean eliminarPorValor(int valor) {
        // Caso especial: lista vacía
        if (cabeza == null) {
            return false;
        }

        // Caso especial: el primero es el que buscamos
        if (cabeza.dato == valor) {
            cabeza = cabeza.siguiente;
            tamanio--;
            return true;
        }

        // Buscar el nodo anterior al que queremos eliminar
        Nodo actual = cabeza;
        while (actual.siguiente != null) {
            if (actual.siguiente.dato == valor) {
                // Saltar el nodo a eliminar
                actual.siguiente = actual.siguiente.siguiente;
                tamanio--;
                return true;
            }
            actual = actual.siguiente;
        }

        return false;  // No encontrado
    }

    /**
     * Elimina el elemento en una posición específica
     * Complejidad: O(n)
     */
    public void eliminarEnPosicion(int indice) {
        if (indice < 0 || indice >= tamanio) {
            throw new IndexOutOfBoundsException("Índice fuera de rango: " + indice);
        }

        // Caso especial: eliminar el primero
        if (indice == 0) {
            eliminarPrimero();
            return;
        }

        // Avanzar hasta el nodo anterior
        Nodo actual = cabeza;
        for (int i = 0; i < indice - 1; i++) {
            actual = actual.siguiente;
        }

        // Saltar el nodo a eliminar
        actual.siguiente = actual.siguiente.siguiente;
        tamanio--;
    }

    // ==========================================
    // MÉTODOS DE BÚSQUEDA Y ACCESO
    // ==========================================

    /**
     * Obtiene el elemento en una posición específica
     * Complejidad: O(n)
     */
    public int obtener(int indice) {
        if (indice < 0 || indice >= tamanio) {
            throw new IndexOutOfBoundsException("Índice fuera de rango: " + indice);
        }

        Nodo actual = cabeza;
        for (int i = 0; i < indice; i++) {
            actual = actual.siguiente;
        }
        return actual.dato;
    }

    /**
     * Busca un valor y retorna su posición
     * Complejidad: O(n)
     */
    public int buscar(int valor) {
        Nodo actual = cabeza;
        int indice = 0;

        while (actual != null) {
            if (actual.dato == valor) {
                return indice;
            }
            actual = actual.siguiente;
            indice++;
        }

        return -1;  // No encontrado
    }

    /**
     * Verifica si la lista contiene un valor
     * Complejidad: O(n)
     */
    public boolean contiene(int valor) {
        return buscar(valor) != -1;
    }

    // ==========================================
    // MÉTODOS DE INFORMACIÓN
    // ==========================================

    /**
     * Retorna el tamaño de la lista
     * Complejidad: O(1)
     */
    public int tamanio() {
        return tamanio;
    }

    /**
     * Verifica si la lista está vacía
     * Complejidad: O(1)
     */
    public boolean estaVacia() {
        return cabeza == null;
    }

    /**
     * Obtiene el primer elemento (sin eliminarlo)
     * Complejidad: O(1)
     */
    public int obtenerPrimero() {
        if (cabeza == null) {
            throw new RuntimeException("Lista vacía");
        }
        return cabeza.dato;
    }

    /**
     * Obtiene el último elemento (sin eliminarlo)
     * Complejidad: O(n)
     */
    public int obtenerUltimo() {
        if (cabeza == null) {
            throw new RuntimeException("Lista vacía");
        }

        Nodo actual = cabeza;
        while (actual.siguiente != null) {
            actual = actual.siguiente;
        }
        return actual.dato;
    }

    // ==========================================
    // OPERACIONES ADICIONALES
    // ==========================================

    /**
     * Invierte la lista
     * Complejidad: O(n)
     */
    public void invertir() {
        Nodo anterior = null;
        Nodo actual = cabeza;
        Nodo siguiente = null;

        while (actual != null) {
            siguiente = actual.siguiente;  // Guardar siguiente
            actual.siguiente = anterior;   // Invertir enlace
            anterior = actual;             // Avanzar anterior
            actual = siguiente;            // Avanzar actual
        }

        cabeza = anterior;  // La nueva cabeza es el último nodo
    }

    /**
     * Limpia toda la lista
     * Complejidad: O(1) - Java garbage collector limpia los nodos
     */
    public void limpiar() {
        cabeza = null;
        tamanio = 0;
    }

    /**
     * Imprime la lista
     * Complejidad: O(n)
     */
    public void imprimir() {
        if (cabeza == null) {
            System.out.println("Lista vacía");
            return;
        }

        Nodo actual = cabeza;
        while (actual != null) {
            System.out.print(actual.dato);
            if (actual.siguiente != null) {
                System.out.print(" -> ");
            }
            actual = actual.siguiente;
        }
        System.out.println(" -> null");
    }
}

/*
 * PUNTOS CLAVE SOBRE LISTAS ENLAZADAS:
 * =====================================
 *
 * 1. VENTAJAS:
 *    - Inserción/eliminación al inicio: O(1)
 *    - Tamaño dinámico
 *    - No desperdicia memoria
 *
 * 2. DESVENTAJAS:
 *    - No hay acceso directo por índice: O(n)
 *    - Memoria extra para punteros
 *    - Caché unfriendly (nodos dispersos)
 *
 * 3. CUÁNDO USAR:
 *    - Frecuentes inserciones/eliminaciones al inicio
 *    - Tamaño desconocido o muy variable
 *    - No necesitas acceso aleatorio
 *
 * 4. CUÁNDO NO USAR:
 *    - Necesitas acceso frecuente por índice
 *    - Búsqueda frecuente (considera HashSet)
 *    - Memoria es crítica (punteros ocupan espacio)
 */
