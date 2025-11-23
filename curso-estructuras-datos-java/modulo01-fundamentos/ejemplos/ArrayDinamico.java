/**
 * MÓDULO 1: FUNDAMENTOS Y ARRAYS
 * Ejemplo 3: Implementación de un Array Dinámico (como ArrayList)
 *
 * Este programa implementa nuestra propia versión simplificada de ArrayList
 * para entender cómo funcionan los arrays dinámicos internamente.
 *
 * Problema con arrays normales: tamaño FIJO
 * Solución: crear un array más grande cuando se llena
 */

public class ArrayDinamico {

    public static void main(String[] args) {
        System.out.println("=== IMPLEMENTACIÓN DE ARRAY DINÁMICO ===\n");

        // Crear nuestro array dinámico
        MiArrayList lista = new MiArrayList();

        System.out.println("Array dinámico creado (capacidad inicial: 10)");
        System.out.println("Tamaño actual: " + lista.tamanio());
        System.out.println("Capacidad: " + lista.capacidad());

        // ==========================================
        // 1. AGREGAR ELEMENTOS
        // ==========================================
        System.out.println("\n=== AGREGANDO ELEMENTOS ===");

        for (int i = 1; i <= 5; i++) {
            lista.agregar(i * 10);
            System.out.println("Agregado: " + (i * 10) +
                             " | Tamaño: " + lista.tamanio() +
                             " | Capacidad: " + lista.capacidad());
        }

        System.out.println("\nContenido actual:");
        lista.imprimir();

        // ==========================================
        // 2. ACCEDER A ELEMENTOS
        // ==========================================
        System.out.println("\n=== ACCESO A ELEMENTOS ===");
        System.out.println("Elemento en posición 0: " + lista.obtener(0));
        System.out.println("Elemento en posición 2: " + lista.obtener(2));
        System.out.println("Elemento en posición 4: " + lista.obtener(4));

        // ==========================================
        // 3. MODIFICAR ELEMENTOS
        // ==========================================
        System.out.println("\n=== MODIFICAR ELEMENTOS ===");
        System.out.println("Antes: " + lista.obtener(2));
        lista.actualizar(2, 999);
        System.out.println("Después: " + lista.obtener(2));
        lista.imprimir();

        // ==========================================
        // 4. CRECIMIENTO AUTOMÁTICO
        // ==========================================
        System.out.println("\n=== PROBANDO CRECIMIENTO AUTOMÁTICO ===");
        System.out.println("Agregando más elementos para forzar el crecimiento...\n");

        // Agregar elementos hasta superar la capacidad inicial
        for (int i = 6; i <= 12; i++) {
            lista.agregar(i * 10);
            System.out.println("Agregado: " + (i * 10) +
                             " | Tamaño: " + lista.tamanio() +
                             " | Capacidad: " + lista.capacidad());
        }

        System.out.println("\n¡El array creció automáticamente!");
        lista.imprimir();

        // ==========================================
        // 5. ELIMINAR ELEMENTOS
        // ==========================================
        System.out.println("\n=== ELIMINAR ELEMENTOS ===");
        System.out.println("Eliminando elemento en posición 5...");
        int eliminado = lista.eliminar(5);
        System.out.println("Elemento eliminado: " + eliminado);
        System.out.println("Nuevo tamaño: " + lista.tamanio());
        lista.imprimir();

        // ==========================================
        // 6. BUSCAR ELEMENTOS
        // ==========================================
        System.out.println("\n=== BUSCAR ELEMENTOS ===");
        int buscar = 40;
        int posicion = lista.buscar(buscar);
        if (posicion != -1) {
            System.out.println("Elemento " + buscar + " encontrado en posición: " + posicion);
        } else {
            System.out.println("Elemento " + buscar + " NO encontrado");
        }

        // ==========================================
        // 7. OTRAS OPERACIONES
        // ==========================================
        System.out.println("\n=== OTRAS OPERACIONES ===");
        System.out.println("¿Contiene 70? " + lista.contiene(70));
        System.out.println("¿Contiene 999? " + lista.contiene(999));
        System.out.println("¿Está vacío? " + lista.estaVacio());

        // Limpiar todo
        lista.limpiar();
        System.out.println("\nDespués de limpiar:");
        System.out.println("Tamaño: " + lista.tamanio());
        System.out.println("¿Está vacío? " + lista.estaVacio());
        lista.imprimir();
    }
}

/**
 * CLASE MiArrayList
 * Implementación simplificada de un array dinámico (como ArrayList de Java)
 *
 * Características principales:
 * - Tamaño dinámico (crece automáticamente)
 * - Acceso rápido por índice: O(1)
 * - Agregar al final (amortizado): O(1)
 * - Insertar/eliminar en medio: O(n)
 */
class MiArrayList {
    private int[] datos;           // Array interno que almacena los elementos
    private int tamanio;           // Cantidad de elementos actuales
    private static final int CAPACIDAD_INICIAL = 10;  // Capacidad por defecto

    /**
     * Constructor: crea un array dinámico vacío
     */
    public MiArrayList() {
        datos = new int[CAPACIDAD_INICIAL];
        tamanio = 0;
    }

    /**
     * Agrega un elemento al final del array
     * Complejidad: O(1) amortizada
     * (A veces O(n) cuando necesita crecer, pero raro)
     */
    public void agregar(int elemento) {
        // Si el array está lleno, necesitamos hacerlo crecer
        if (tamanio == datos.length) {
            crecer();
        }

        // Agregar el elemento al final
        datos[tamanio] = elemento;
        tamanio++;
    }

    /**
     * Obtiene el elemento en una posición específica
     * Complejidad: O(1)
     */
    public int obtener(int indice) {
        // Validar que el índice sea válido
        if (indice < 0 || indice >= tamanio) {
            throw new IndexOutOfBoundsException("Índice fuera de rango: " + indice);
        }
        return datos[indice];
    }

    /**
     * Actualiza el valor en una posición específica
     * Complejidad: O(1)
     */
    public void actualizar(int indice, int nuevoValor) {
        if (indice < 0 || indice >= tamanio) {
            throw new IndexOutOfBoundsException("Índice fuera de rango: " + indice);
        }
        datos[indice] = nuevoValor;
    }

    /**
     * Elimina el elemento en una posición específica
     * Complejidad: O(n) - necesita mover elementos
     */
    public int eliminar(int indice) {
        if (indice < 0 || indice >= tamanio) {
            throw new IndexOutOfBoundsException("Índice fuera de rango: " + indice);
        }

        int eliminado = datos[indice];

        // Mover todos los elementos posteriores una posición atrás
        for (int i = indice; i < tamanio - 1; i++) {
            datos[i] = datos[i + 1];
        }

        tamanio--;  // Reducir el tamaño
        return eliminado;
    }

    /**
     * Busca un elemento y retorna su posición
     * Complejidad: O(n) - búsqueda lineal
     */
    public int buscar(int elemento) {
        for (int i = 0; i < tamanio; i++) {
            if (datos[i] == elemento) {
                return i;
            }
        }
        return -1;  // No encontrado
    }

    /**
     * Verifica si el array contiene un elemento
     * Complejidad: O(n)
     */
    public boolean contiene(int elemento) {
        return buscar(elemento) != -1;
    }

    /**
     * Retorna el tamaño actual (cantidad de elementos)
     * Complejidad: O(1)
     */
    public int tamanio() {
        return tamanio;
    }

    /**
     * Retorna la capacidad actual del array interno
     * Complejidad: O(1)
     */
    public int capacidad() {
        return datos.length;
    }

    /**
     * Verifica si el array está vacío
     * Complejidad: O(1)
     */
    public boolean estaVacio() {
        return tamanio == 0;
    }

    /**
     * Limpia todos los elementos
     * Complejidad: O(1) - solo resetea el tamaño
     */
    public void limpiar() {
        tamanio = 0;
        // No necesitamos limpiar el array, solo ignorar los valores viejos
    }

    /**
     * MÉTODO CLAVE: Hace crecer el array cuando se llena
     * Estrategia: duplicar la capacidad
     * Complejidad: O(n) - debe copiar todos los elementos
     */
    private void crecer() {
        // Crear un nuevo array con el doble de capacidad
        int nuevaCapacidad = datos.length * 2;
        int[] nuevoArray = new int[nuevaCapacidad];

        System.out.println("  [CRECIMIENTO] Capacidad " + datos.length +
                          " -> " + nuevaCapacidad);

        // Copiar todos los elementos al nuevo array
        for (int i = 0; i < datos.length; i++) {
            nuevoArray[i] = datos[i];
        }

        // Reemplazar el array viejo con el nuevo
        datos = nuevoArray;
    }

    /**
     * Imprime el contenido del array
     */
    public void imprimir() {
        System.out.print("[");
        for (int i = 0; i < tamanio; i++) {
            System.out.print(datos[i]);
            if (i < tamanio - 1) {
                System.out.print(", ");
            }
        }
        System.out.println("]");
    }
}

/*
 * PUNTOS CLAVE SOBRE ARRAYS DINÁMICOS:
 * =====================================
 *
 * 1. VENTAJAS:
 *    - Tamaño flexible (crece según necesidad)
 *    - Acceso rápido por índice: O(1)
 *    - Agregar al final es eficiente: O(1) amortizado
 *
 * 2. DESVENTAJAS:
 *    - Insertar/eliminar en medio es costoso: O(n)
 *    - Crecimiento ocasional requiere copiar todo: O(n)
 *    - Usa más memoria que un array normal (espacio extra)
 *
 * 3. ESTRATEGIA DE CRECIMIENTO:
 *    - Duplicar capacidad es común (factor 2)
 *    - Alternativa: factor 1.5 (usa menos memoria)
 *    - Complejidad amortizada: O(1) para agregar
 *
 * 4. USO EN JAVA:
 *    - ArrayList usa esta misma estrategia
 *    - Preferir ArrayList sobre arrays cuando:
 *      * No sabes el tamaño de antemano
 *      * Necesitas agregar/quitar elementos frecuentemente
 *    - Usar arrays cuando:
 *      * Tamaño es fijo y conocido
 *      * Necesitas máxima eficiencia de memoria
 */
