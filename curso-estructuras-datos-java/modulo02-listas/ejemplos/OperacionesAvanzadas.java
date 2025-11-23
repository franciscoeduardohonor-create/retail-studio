/**
 * MÓDULO 2: LISTAS ENLAZADAS
 * Ejemplo 2: Operaciones Avanzadas y Problemas Comunes
 *
 * Este archivo demuestra técnicas avanzadas con listas enlazadas:
 * - Detectar ciclos (Floyd's Algorithm)
 * - Encontrar el medio (dos punteros)
 * - Fusionar listas ordenadas
 * - Eliminar duplicados
 * - Verificar si es palíndromo
 */

public class OperacionesAvanzadas {

    public static void main(String[] args) {
        System.out.println("=== OPERACIONES AVANZADAS CON LISTAS ENLAZADAS ===\n");

        // ==========================================
        // 1. ENCONTRAR EL MEDIO (Dos Punteros)
        // ==========================================
        System.out.println("=== 1. ENCONTRAR EL MEDIO ===");

        ListaEnlazada lista1 = new ListaEnlazada();
        lista1.agregar(1);
        lista1.agregar(2);
        lista1.agregar(3);
        lista1.agregar(4);
        lista1.agregar(5);

        System.out.println("Lista:");
        lista1.imprimir();
        NodoSimple medio = encontrarMedio(lista1.cabeza);
        System.out.println("Elemento del medio: " + medio.dato);

        // ==========================================
        // 2. DETECTAR CICLO (Floyd's Algorithm)
        // ==========================================
        System.out.println("\n=== 2. DETECTAR CICLO ===");

        ListaEnlazada lista2 = new ListaEnlazada();
        lista2.agregar(1);
        lista2.agregar(2);
        lista2.agregar(3);
        lista2.agregar(4);

        System.out.println("Lista sin ciclo:");
        lista2.imprimir();
        System.out.println("¿Tiene ciclo? " + tieneCiclo(lista2.cabeza));

        // Crear un ciclo manualmente para demostración
        // 1 -> 2 -> 3 -> 4 -┐
        //      ↑____________|
        lista2.cabeza.siguiente.siguiente.siguiente.siguiente = lista2.cabeza.siguiente;
        System.out.println("\nDespués de crear ciclo artificial:");
        System.out.println("¿Tiene ciclo? " + tieneCiclo(lista2.cabeza));

        // ==========================================
        // 3. FUSIONAR LISTAS ORDENADAS
        // ==========================================
        System.out.println("\n=== 3. FUSIONAR LISTAS ORDENADAS ===");

        ListaEnlazada ordenada1 = new ListaEnlazada();
        ordenada1.agregar(1);
        ordenada1.agregar(3);
        ordenada1.agregar(5);

        ListaEnlazada ordenada2 = new ListaEnlazada();
        ordenada2.agregar(2);
        ordenada2.agregar(4);
        ordenada2.agregar(6);

        System.out.println("Lista 1:");
        ordenada1.imprimir();
        System.out.println("Lista 2:");
        ordenada2.imprimir();

        NodoSimple fusionada = fusionarOrdenadas(ordenada1.cabeza, ordenada2.cabeza);
        System.out.println("Lista fusionada:");
        imprimirLista(fusionada);

        // ==========================================
        // 4. INVERTIR LISTA (Recursiva)
        // ==========================================
        System.out.println("\n=== 4. INVERTIR LISTA (RECURSIVA) ===");

        ListaEnlazada lista3 = new ListaEnlazada();
        lista3.agregar(1);
        lista3.agregar(2);
        lista3.agregar(3);
        lista3.agregar(4);
        lista3.agregar(5);

        System.out.println("Lista original:");
        lista3.imprimir();

        lista3.cabeza = invertirRecursiva(lista3.cabeza);
        System.out.println("Lista invertida:");
        lista3.imprimir();

        // ==========================================
        // 5. ELIMINAR DUPLICADOS
        // ==========================================
        System.out.println("\n=== 5. ELIMINAR DUPLICADOS ===");

        ListaEnlazada lista4 = new ListaEnlazada();
        lista4.agregar(1);
        lista4.agregar(2);
        lista4.agregar(2);
        lista4.agregar(3);
        lista4.agregar(3);
        lista4.agregar(3);
        lista4.agregar(4);

        System.out.println("Lista con duplicados:");
        lista4.imprimir();

        eliminarDuplicadosOrdenada(lista4.cabeza);
        System.out.println("Sin duplicados:");
        lista4.imprimir();

        // ==========================================
        // 6. VERIFICAR PALÍNDROMO
        // ==========================================
        System.out.println("\n=== 6. VERIFICAR PALÍNDROMO ===");

        ListaEnlazada palindromo = new ListaEnlazada();
        palindromo.agregar(1);
        palindromo.agregar(2);
        palindromo.agregar(3);
        palindromo.agregar(2);
        palindromo.agregar(1);

        System.out.println("Lista:");
        palindromo.imprimir();
        System.out.println("¿Es palíndromo? " + esPalindromo(palindromo.cabeza));

        ListaEnlazada noPalindromo = new ListaEnlazada();
        noPalindromo.agregar(1);
        noPalindromo.agregar(2);
        noPalindromo.agregar(3);

        System.out.println("\nLista:");
        noPalindromo.imprimir();
        System.out.println("¿Es palíndromo? " + esPalindromo(noPalindromo.cabeza));

        // ==========================================
        // 7. N-ÉSIMO DESDE EL FINAL
        // ==========================================
        System.out.println("\n=== 7. N-ÉSIMO DESDE EL FINAL ===");

        ListaEnlazada lista5 = new ListaEnlazada();
        for (int i = 1; i <= 10; i++) {
            lista5.agregar(i);
        }

        System.out.println("Lista:");
        lista5.imprimir();

        int n = 3;
        NodoSimple nEsimo = encontrarNEsimoDesdeElFinal(lista5.cabeza, n);
        if (nEsimo != null) {
            System.out.println(n + "-ésimo desde el final: " + nEsimo.dato);
        }
    }

    /**
     * PROBLEMA 1: ENCONTRAR EL MEDIO
     * Técnica: Dos punteros (lento y rápido)
     *
     * Algoritmo:
     * - Puntero lento avanza 1 paso
     * - Puntero rápido avanza 2 pasos
     * - Cuando rápido llega al final, lento está en el medio
     *
     * Complejidad: O(n) tiempo, O(1) espacio
     */
    public static NodoSimple encontrarMedio(NodoSimple cabeza) {
        if (cabeza == null) return null;

        NodoSimple lento = cabeza;
        NodoSimple rapido = cabeza;

        while (rapido != null && rapido.siguiente != null) {
            lento = lento.siguiente;           // Avanza 1
            rapido = rapido.siguiente.siguiente; // Avanza 2
        }

        return lento;  // Lento está en el medio
    }

    /**
     * PROBLEMA 2: DETECTAR CICLO (Floyd's Cycle Detection)
     * Algoritmo de la tortuga y la liebre
     *
     * Si hay ciclo, los punteros se encontrarán
     * Si no hay ciclo, el rápido llegará a null
     *
     * Complejidad: O(n) tiempo, O(1) espacio
     */
    public static boolean tieneCiclo(NodoSimple cabeza) {
        if (cabeza == null) return false;

        NodoSimple lento = cabeza;
        NodoSimple rapido = cabeza;

        while (rapido != null && rapido.siguiente != null) {
            lento = lento.siguiente;
            rapido = rapido.siguiente.siguiente;

            if (lento == rapido) {
                return true;  // ¡Se encontraron! Hay ciclo
            }
        }

        return false;  // No hay ciclo
    }

    /**
     * PROBLEMA 3: FUSIONAR LISTAS ORDENADAS
     * Combina dos listas ordenadas en una sola lista ordenada
     *
     * Técnica: Usar nodo dummy para simplificar
     *
     * Complejidad: O(n + m) donde n y m son las longitudes
     */
    public static NodoSimple fusionarOrdenadas(NodoSimple l1, NodoSimple l2) {
        // Nodo dummy para simplificar el código
        NodoSimple dummy = new NodoSimple(0);
        NodoSimple actual = dummy;

        // Mientras ambas listas tengan elementos
        while (l1 != null && l2 != null) {
            if (l1.dato <= l2.dato) {
                actual.siguiente = l1;
                l1 = l1.siguiente;
            } else {
                actual.siguiente = l2;
                l2 = l2.siguiente;
            }
            actual = actual.siguiente;
        }

        // Agregar elementos restantes
        if (l1 != null) {
            actual.siguiente = l1;
        }
        if (l2 != null) {
            actual.siguiente = l2;
        }

        return dummy.siguiente;
    }

    /**
     * PROBLEMA 4: INVERTIR LISTA (Versión Recursiva)
     * Más elegante pero usa O(n) espacio en la pila
     *
     * Complejidad: O(n) tiempo, O(n) espacio (recursión)
     */
    public static NodoSimple invertirRecursiva(NodoSimple cabeza) {
        // Casos base
        if (cabeza == null || cabeza.siguiente == null) {
            return cabeza;
        }

        // Invertir el resto de la lista
        NodoSimple nuevaCabeza = invertirRecursiva(cabeza.siguiente);

        // Invertir el enlace actual
        cabeza.siguiente.siguiente = cabeza;
        cabeza.siguiente = null;

        return nuevaCabeza;
    }

    /**
     * PROBLEMA 5: ELIMINAR DUPLICADOS (Lista Ordenada)
     * Solo mantiene una ocurrencia de cada valor
     *
     * Complejidad: O(n) tiempo, O(1) espacio
     */
    public static void eliminarDuplicadosOrdenada(NodoSimple cabeza) {
        NodoSimple actual = cabeza;

        while (actual != null && actual.siguiente != null) {
            if (actual.dato == actual.siguiente.dato) {
                // Saltar el duplicado
                actual.siguiente = actual.siguiente.siguiente;
            } else {
                actual = actual.siguiente;
            }
        }
    }

    /**
     * PROBLEMA 6: VERIFICAR SI ES PALÍNDROMO
     * Una lista es palíndromo si se lee igual en ambos sentidos
     *
     * Algoritmo:
     * 1. Encontrar el medio
     * 2. Invertir la segunda mitad
     * 3. Comparar primera y segunda mitad
     *
     * Complejidad: O(n) tiempo, O(1) espacio
     */
    public static boolean esPalindromo(NodoSimple cabeza) {
        if (cabeza == null || cabeza.siguiente == null) return true;

        // 1. Encontrar el medio
        NodoSimple lento = cabeza;
        NodoSimple rapido = cabeza;

        while (rapido != null && rapido.siguiente != null) {
            lento = lento.siguiente;
            rapido = rapido.siguiente.siguiente;
        }

        // 2. Invertir segunda mitad
        NodoSimple segundaMitad = invertirIterativa(lento);

        // 3. Comparar ambas mitades
        NodoSimple p1 = cabeza;
        NodoSimple p2 = segundaMitad;

        while (p2 != null) {
            if (p1.dato != p2.dato) {
                return false;
            }
            p1 = p1.siguiente;
            p2 = p2.siguiente;
        }

        return true;
    }

    /**
     * PROBLEMA 7: N-ÉSIMO DESDE EL FINAL
     * Encuentra el n-ésimo nodo contando desde el final
     *
     * Técnica: Dos punteros con separación de n
     *
     * Complejidad: O(n) tiempo, O(1) espacio
     */
    public static NodoSimple encontrarNEsimoDesdeElFinal(NodoSimple cabeza, int n) {
        NodoSimple primero = cabeza;
        NodoSimple segundo = cabeza;

        // Mover el primero n pasos adelante
        for (int i = 0; i < n; i++) {
            if (primero == null) return null;
            primero = primero.siguiente;
        }

        // Mover ambos hasta que primero llegue al final
        while (primero != null) {
            primero = primero.siguiente;
            segundo = segundo.siguiente;
        }

        return segundo;
    }

    // ========================================
    // MÉTODOS AUXILIARES
    // ========================================

    private static NodoSimple invertirIterativa(NodoSimple cabeza) {
        NodoSimple anterior = null;
        NodoSimple actual = cabeza;

        while (actual != null) {
            NodoSimple siguiente = actual.siguiente;
            actual.siguiente = anterior;
            anterior = actual;
            actual = siguiente;
        }

        return anterior;
    }

    private static void imprimirLista(NodoSimple cabeza) {
        NodoSimple actual = cabeza;
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

/**
 * Nodo simple para demostración
 */
class NodoSimple {
    int dato;
    NodoSimple siguiente;

    NodoSimple(int dato) {
        this.dato = dato;
        this.siguiente = null;
    }
}

/**
 * Lista enlazada simple para demostración
 */
class ListaEnlazada {
    NodoSimple cabeza;

    void agregar(int dato) {
        NodoSimple nuevo = new NodoSimple(dato);
        if (cabeza == null) {
            cabeza = nuevo;
        } else {
            NodoSimple actual = cabeza;
            while (actual.siguiente != null) {
                actual = actual.siguiente;
            }
            actual.siguiente = nuevo;
        }
    }

    void imprimir() {
        NodoSimple actual = cabeza;
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
 * TÉCNICAS CLAVE APRENDIDAS:
 * ===========================
 *
 * 1. DOS PUNTEROS (Fast & Slow):
 *    - Encontrar medio: O(n) tiempo, O(1) espacio
 *    - Detectar ciclo: Floyd's Algorithm
 *    - N-ésimo desde el final
 *
 * 2. NODO DUMMY:
 *    - Simplifica código al fusionar
 *    - Evita casos especiales con cabeza
 *
 * 3. RECURSIÓN:
 *    - Invertir lista recursivamente
 *    - Más elegante pero usa stack
 *
 * 4. PALÍNDROMO:
 *    - Combinación de encontrar medio + invertir
 *    - Solución en O(n) tiempo y O(1) espacio
 *
 * PROBLEMAS COMUNES EN ENTREVISTAS:
 * ==================================
 *
 * ✓ Encontrar el medio
 * ✓ Detectar ciclo (Floyd's)
 * ✓ Fusionar listas ordenadas
 * ✓ Invertir lista (iterativa y recursiva)
 * ✓ Eliminar duplicados
 * ✓ Verificar palíndromo
 * ✓ N-ésimo desde el final
 * - Eliminar n-ésimo desde el final
 * - Intersección de dos listas
 * - Copiar lista con punteros aleatorios
 */
