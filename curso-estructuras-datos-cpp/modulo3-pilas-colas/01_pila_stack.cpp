/*
 * MÓDULO 3: PILA (STACK)
 *
 * Estructura de datos LIFO (Last In, First Out)
 * - El último elemento en entrar es el primero en salir
 * - Operaciones principales: push, pop, peek/top
 * - Aplicaciones: evaluación de expresiones, backtracking, historial
 */

#include <iostream>
#include <stack>  // Para comparar con STL
using namespace std;

// ============================================
// IMPLEMENTACIÓN CON ARRAY
// ============================================

class PilaArray {
private:
    static const int MAX = 100;  // Capacidad máxima
    int arr[MAX];
    int tope;  // Índice del elemento en el tope

public:
    // Constructor
    PilaArray() : tope(-1) {}

    // ========================================
    // OPERACIÓN: Verificar si está vacía
    // Complejidad: O(1)
    // ========================================
    bool estaVacia() const {
        return tope == -1;
    }

    // ========================================
    // OPERACIÓN: Verificar si está llena
    // Complejidad: O(1)
    // ========================================
    bool estaLlena() const {
        return tope == MAX - 1;
    }

    // ========================================
    // OPERACIÓN: Push (Insertar en el tope)
    // Complejidad: O(1)
    // ========================================
    bool push(int valor) {
        if(estaLlena()) {
            cout << "Error: Pila llena, no se puede insertar " << valor << endl;
            return false;
        }

        arr[++tope] = valor;
        cout << "Push: " << valor << endl;
        return true;
    }

    // ========================================
    // OPERACIÓN: Pop (Eliminar del tope)
    // Complejidad: O(1)
    // ========================================
    int pop() {
        if(estaVacia()) {
            cout << "Error: Pila vacía" << endl;
            return -1;
        }

        int valor = arr[tope--];
        cout << "Pop: " << valor << endl;
        return valor;
    }

    // ========================================
    // OPERACIÓN: Peek/Top (Ver tope sin eliminar)
    // Complejidad: O(1)
    // ========================================
    int peek() const {
        if(estaVacia()) {
            cout << "Error: Pila vacía" << endl;
            return -1;
        }

        return arr[tope];
    }

    // ========================================
    // OPERACIÓN: Obtener tamaño
    // Complejidad: O(1)
    // ========================================
    int tamanio() const {
        return tope + 1;
    }

    // ========================================
    // OPERACIÓN: Mostrar pila
    // Complejidad: O(n)
    // ========================================
    void mostrar() const {
        if(estaVacia()) {
            cout << "Pila vacía" << endl;
            return;
        }

        cout << "Pila (tope -> fondo): ";
        for(int i = tope; i >= 0; i--) {
            cout << arr[i];
            if(i > 0) cout << " | ";
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

class PilaLista {
private:
    Nodo* tope;
    int tamanioActual;

public:
    // Constructor
    PilaLista() : tope(nullptr), tamanioActual(0) {}

    // Destructor
    ~PilaLista() {
        while(!estaVacia()) {
            pop();
        }
    }

    bool estaVacia() const {
        return tope == nullptr;
    }

    // Push - Insertar al inicio de la lista
    // Complejidad: O(1)
    void push(int valor) {
        Nodo* nuevoNodo = new Nodo(valor);
        nuevoNodo->siguiente = tope;
        tope = nuevoNodo;
        tamanioActual++;
        cout << "Push: " << valor << endl;
    }

    // Pop - Eliminar del inicio de la lista
    // Complejidad: O(1)
    int pop() {
        if(estaVacia()) {
            cout << "Error: Pila vacía" << endl;
            return -1;
        }

        Nodo* nodoAEliminar = tope;
        int valor = tope->dato;
        tope = tope->siguiente;
        delete nodoAEliminar;
        tamanioActual--;

        cout << "Pop: " << valor << endl;
        return valor;
    }

    int peek() const {
        if(estaVacia()) {
            cout << "Error: Pila vacía" << endl;
            return -1;
        }
        return tope->dato;
    }

    int tamanio() const {
        return tamanioActual;
    }

    void mostrar() const {
        if(estaVacia()) {
            cout << "Pila vacía" << endl;
            return;
        }

        cout << "Pila (tope -> fondo): ";
        Nodo* actual = tope;
        while(actual != nullptr) {
            cout << actual->dato;
            if(actual->siguiente != nullptr) cout << " | ";
            actual = actual->siguiente;
        }
        cout << endl;
    }
};

// ============================================
// APLICACIONES PRÁCTICAS
// ============================================

/**
 * EJEMPLO 1: Verificar paréntesis balanceados
 * Complejidad: O(n)
 */
bool verificarParentesis(string expresion) {
    PilaArray pila;

    for(char c : expresion) {
        if(c == '(' || c == '[' || c == '{') {
            // Apertura - agregar a pila
            pila.push(c);
        }
        else if(c == ')' || c == ']' || c == '}') {
            // Cierre - verificar con tope
            if(pila.estaVacia()) {
                return false;  // Cierre sin apertura
            }

            char tope = pila.pop();

            // Verificar que coincidan
            if((c == ')' && tope != '(') ||
               (c == ']' && tope != '[') ||
               (c == '}' && tope != '{')) {
                return false;
            }
        }
    }

    // Al final, la pila debe estar vacía
    return pila.estaVacia();
}

/**
 * EJEMPLO 2: Invertir una cadena
 * Complejidad: O(n)
 */
string invertirCadena(string str) {
    PilaArray pila;

    // Push de todos los caracteres
    for(char c : str) {
        pila.push(c);
    }

    // Pop para construir cadena invertida
    string resultado = "";
    while(!pila.estaVacia()) {
        resultado += (char)pila.pop();
    }

    return resultado;
}

/**
 * EJEMPLO 3: Evaluar expresión postfija (RPN)
 * Ejemplo: "2 3 + 5 *" = (2 + 3) * 5 = 25
 * Complejidad: O(n)
 */
int evaluarPostfija(string expresion) {
    PilaArray pila;

    for(int i = 0; i < expresion.length(); i++) {
        char c = expresion[i];

        // Si es dígito, agregarlo a la pila
        if(isdigit(c)) {
            pila.push(c - '0');  // Convertir char a int
        }
        // Si es operador, operar con los dos últimos
        else if(c == '+' || c == '-' || c == '*' || c == '/') {
            if(pila.tamanio() < 2) {
                cout << "Error: Expresión inválida" << endl;
                return -1;
            }

            int operando2 = pila.pop();
            int operando1 = pila.pop();
            int resultado = 0;

            switch(c) {
                case '+': resultado = operando1 + operando2; break;
                case '-': resultado = operando1 - operando2; break;
                case '*': resultado = operando1 * operando2; break;
                case '/': resultado = operando1 / operando2; break;
            }

            pila.push(resultado);
        }
        // Ignorar espacios
    }

    return pila.pop();
}

// ============================================
// FUNCIÓN PRINCIPAL
// ============================================

int main() {
    cout << "=== ESTRUCTURA DE DATOS: PILA (STACK) ===" << endl << endl;

    // ========================================
    // DEMOSTRACIÓN BÁSICA CON ARRAY
    // ========================================
    cout << "--- PILA CON ARRAY ---" << endl;
    PilaArray pila1;

    pila1.push(10);
    pila1.push(20);
    pila1.push(30);
    pila1.push(40);
    pila1.mostrar();

    cout << "Tope actual: " << pila1.peek() << endl;
    cout << "Tamaño: " << pila1.tamanio() << endl;

    pila1.pop();
    pila1.pop();
    pila1.mostrar();
    cout << endl;

    // ========================================
    // DEMOSTRACIÓN CON LISTA ENLAZADA
    // ========================================
    cout << "--- PILA CON LISTA ENLAZADA ---" << endl;
    PilaLista pila2;

    pila2.push(5);
    pila2.push(15);
    pila2.push(25);
    pila2.mostrar();

    cout << "Tope: " << pila2.peek() << endl;
    pila2.pop();
    pila2.mostrar();
    cout << endl;

    // ========================================
    // APLICACIÓN 1: PARÉNTESIS BALANCEADOS
    // ========================================
    cout << "--- APLICACIÓN: VERIFICAR PARÉNTESIS BALANCEADOS ---" << endl;

    string expr1 = "{[()]}";
    string expr2 = "{[(])}";
    string expr3 = "((()))";
    string expr4 = "((())";

    cout << expr1 << " -> " << (verificarParentesis(expr1) ? "Balanceado" : "NO Balanceado") << endl;
    cout << expr2 << " -> " << (verificarParentesis(expr2) ? "Balanceado" : "NO Balanceado") << endl;
    cout << expr3 << " -> " << (verificarParentesis(expr3) ? "Balanceado" : "NO Balanceado") << endl;
    cout << expr4 << " -> " << (verificarParentesis(expr4) ? "Balanceado" : "NO Balanceado") << endl;
    cout << endl;

    // ========================================
    // APLICACIÓN 2: INVERTIR CADENA
    // ========================================
    cout << "--- APLICACIÓN: INVERTIR CADENA ---" << endl;
    string texto = "HOLA MUNDO";
    cout << "Original: " << texto << endl;
    cout << "Invertido: " << invertirCadena(texto) << endl;
    cout << endl;

    // ========================================
    // APLICACIÓN 3: NOTACIÓN POSTFIJA
    // ========================================
    cout << "--- APLICACIÓN: EVALUAR EXPRESIÓN POSTFIJA (RPN) ---" << endl;
    string postfija = "23+5*";  // (2+3)*5 = 25
    cout << "Expresión: " << postfija << endl;
    cout << "Resultado: " << evaluarPostfija(postfija) << endl;

    return 0;
}

/*
 * CONCEPTOS CLAVE:
 * ================
 *
 * 1. LIFO (Last In, First Out)
 *    - El último en entrar es el primero en salir
 *    - Como una pila de platos
 *
 * 2. Operaciones principales (todas O(1)):
 *    - push(): Agregar al tope
 *    - pop(): Eliminar del tope
 *    - peek()/top(): Ver el tope
 *    - isEmpty(): Verificar si vacía
 *
 * 3. Implementaciones:
 *    - Array: Rápida, tamaño fijo
 *    - Lista enlazada: Dinámica, sin límite
 *
 * 4. Aplicaciones comunes:
 *    - Evaluación de expresiones
 *    - Verificación de sintaxis (paréntesis)
 *    - Backtracking (retroceso)
 *    - Historial de navegador (back button)
 *    - Deshacer/Rehacer (undo/redo)
 *    - Recursión (call stack)
 *
 * 5. Ventajas:
 *    - Operaciones muy rápidas: O(1)
 *    - Fácil de implementar
 *    - Ideal para procesamiento secuencial inverso
 */
