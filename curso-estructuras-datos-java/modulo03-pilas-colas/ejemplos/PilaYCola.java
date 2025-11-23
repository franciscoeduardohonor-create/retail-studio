/**
 * MÓDULO 3: PILAS Y COLAS
 * Implementación completa de Stack (LIFO) y Queue (FIFO)
 */

public class PilaYCola {

    public static void main(String[] args) {
        // ==========================================
        // DEMOSTRACIÓN DE PILA (Stack)
        // ==========================================
        System.out.println("=== PILA (STACK - LIFO) ===\n");

        Pila pila = new Pila();

        // Push - agregar elementos
        System.out.println("Push 10, 20, 30:");
        pila.push(10);
        pila.push(20);
        pila.push(30);
        pila.mostrar();

        // Peek - ver el tope
        System.out.println("\nPeek (ver tope): " + pila.peek());

        // Pop - quitar del tope
        System.out.println("Pop: " + pila.pop());
        System.out.println("Pop: " + pila.pop());
        pila.mostrar();

        // Aplicación: Validar paréntesis
        System.out.println("\n=== APLICACIÓN: VALIDAR PARÉNTESIS ===");
        System.out.println("(([])) válido? " + validarParentesis("(([]))"));
        System.out.println("([)] válido? " + validarParentesis("([)]"));

        // ==========================================
        // DEMOSTRACIÓN DE COLA (Queue)
        // ==========================================
        System.out.println("\n\n=== COLA (QUEUE - FIFO) ===\n");

        Cola cola = new Cola();

        // Enqueue - agregar elementos
        System.out.println("Enqueue 10, 20, 30:");
        cola.enqueue(10);
        cola.enqueue(20);
        cola.enqueue(30);
        cola.mostrar();

        // Dequeue - quitar del frente
        System.out.println("\nDequeue: " + cola.dequeue());
        System.out.println("Dequeue: " + cola.dequeue());
        cola.mostrar();
    }

    /**
     * APLICACIÓN: Validar paréntesis balanceados
     * Ejemplo: "(([]){[]})" es válido
     * Ejemplo: "([)]" NO es válido
     */
    public static boolean validarParentesis(String s) {
        Pila pila = new Pila();

        for (char c : s.toCharArray()) {
            // Si es apertura, push
            if (c == '(' || c == '[' || c == '{') {
                pila.push(c);
            }
            // Si es cierre, verificar
            else if (c == ')' || c == ']' || c == '}') {
                if (pila.estaVacia()) return false;

                char tope = (char) pila.pop();
                if (!coincide(tope, c)) return false;
            }
        }

        return pila.estaVacia();
    }

    private static boolean coincide(char apertura, char cierre) {
        return (apertura == '(' && cierre == ')') ||
               (apertura == '[' && cierre == ']') ||
               (apertura == '{' && cierre == '}');
    }
}

/**
 * PILA (Stack) - LIFO
 * Implementación con array dinámico
 */
class Pila {
    private int[] datos;
    private int tope;
    private static final int CAPACIDAD = 10;

    public Pila() {
        datos = new int[CAPACIDAD];
        tope = -1;
    }

    /** Agregar elemento al tope - O(1) */
    public void push(int elemento) {
        if (tope == datos.length - 1) {
            redimensionar();
        }
        datos[++tope] = elemento;
    }

    /** Quitar elemento del tope - O(1) */
    public int pop() {
        if (estaVacia()) {
            throw new RuntimeException("Pila vacía");
        }
        return datos[tope--];
    }

    /** Ver el tope sin quitar - O(1) */
    public int peek() {
        if (estaVacia()) {
            throw new RuntimeException("Pila vacía");
        }
        return datos[tope];
    }

    /** Verificar si está vacía - O(1) */
    public boolean estaVacia() {
        return tope == -1;
    }

    /** Redimensionar el array */
    private void redimensionar() {
        int[] nuevo = new int[datos.length * 2];
        System.arraycopy(datos, 0, nuevo, 0, datos.length);
        datos = nuevo;
    }

    public void mostrar() {
        System.out.print("Pila (tope -> base): ");
        for (int i = tope; i >= 0; i--) {
            System.out.print(datos[i] + " ");
        }
        System.out.println();
    }
}

/**
 * COLA (Queue) - FIFO
 * Implementación con lista enlazada
 */
class Cola {
    private class NodoCola {
        int dato;
        NodoCola siguiente;

        NodoCola(int dato) {
            this.dato = dato;
        }
    }

    private NodoCola frente;
    private NodoCola fin;
    private int tamanio;

    public Cola() {
        frente = null;
        fin = null;
        tamanio = 0;
    }

    /** Agregar al final - O(1) */
    public void enqueue(int elemento) {
        NodoCola nuevo = new NodoCola(elemento);

        if (estaVacia()) {
            frente = nuevo;
            fin = nuevo;
        } else {
            fin.siguiente = nuevo;
            fin = nuevo;
        }
        tamanio++;
    }

    /** Quitar del frente - O(1) */
    public int dequeue() {
        if (estaVacia()) {
            throw new RuntimeException("Cola vacía");
        }

        int dato = frente.dato;
        frente = frente.siguiente;

        if (frente == null) {
            fin = null;
        }

        tamanio--;
        return dato;
    }

    /** Ver el frente sin quitar - O(1) */
    public int peek() {
        if (estaVacia()) {
            throw new RuntimeException("Cola vacía");
        }
        return frente.dato;
    }

    /** Verificar si está vacía - O(1) */
    public boolean estaVacia() {
        return frente == null;
    }

    public void mostrar() {
        System.out.print("Cola (frente -> fin): ");
        NodoCola actual = frente;
        while (actual != null) {
            System.out.print(actual.dato + " ");
            actual = actual.siguiente;
        }
        System.out.println();
    }
}

/*
 * RESUMEN:
 * ========
 *
 * PILA (Stack):
 * - LIFO: Last In, First Out
 * - Push/Pop/Peek: O(1)
 * - Usos: deshacer, backtracking, validación
 *
 * COLA (Queue):
 * - FIFO: First In, First Out
 * - Enqueue/Dequeue/Peek: O(1)
 * - Usos: BFS, gestión de tareas, buffers
 */
