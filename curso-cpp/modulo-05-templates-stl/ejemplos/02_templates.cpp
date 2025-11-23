/*
 * MÓDULO 5: TEMPLATES Y STL
 * Ejemplo 2: Templates (Plantillas)
 *
 * Aprenderás:
 * - Templates de funciones
 * - Templates de clases
 * - Especialización de templates
 * - Ventajas de los templates
 */

#include <iostream>
#include <string>

// TEMPLATE DE FUNCIÓN SIMPLE
template <typename T>
T maximo(T a, T b) {
    return (a > b) ? a : b;
}

// TEMPLATE CON MÚLTIPLES TIPOS
template <typename T1, typename T2>
void mostrarPar(T1 primero, T2 segundo) {
    std::cout << "(" << primero << ", " << segundo << ")" << std::endl;
}

// TEMPLATE DE FUNCIÓN PARA IMPRIMIR ARREGLO
template <typename T>
void imprimirArreglo(T arr[], int tamanio) {
    for (int i = 0; i < tamanio; i++) {
        std::cout << arr[i] << " ";
    }
    std::cout << std::endl;
}

// TEMPLATE DE CLASE: Par genérico
template <typename T1, typename T2>
class Par {
private:
    T1 primero;
    T2 segundo;

public:
    Par(T1 p, T2 s) : primero(p), segundo(s) {}

    T1 getPrimero() { return primero; }
    T2 getSegundo() { return segundo; }

    void setPrimero(T1 p) { primero = p; }
    void setSegundo(T2 s) { segundo = s; }

    void mostrar() {
        std::cout << "(" << primero << ", " << segundo << ")" << std::endl;
    }
};

// TEMPLATE DE CLASE: Caja genérica
template <typename T>
class Caja {
private:
    T contenido;

public:
    Caja(T cont) : contenido(cont) {}

    T getContenido() {
        return contenido;
    }

    void setContenido(T cont) {
        contenido = cont;
    }

    void mostrar() {
        std::cout << "Caja contiene: " << contenido << std::endl;
    }
};

// TEMPLATE DE CLASE: Pila genérica
template <typename T>
class Pila {
private:
    static const int MAX = 100;
    T elementos[MAX];
    int tope;

public:
    Pila() : tope(-1) {}

    bool estaVacia() {
        return tope == -1;
    }

    bool estaLlena() {
        return tope == MAX - 1;
    }

    void push(T elemento) {
        if (estaLlena()) {
            std::cout << "Pila llena" << std::endl;
            return;
        }
        elementos[++tope] = elemento;
    }

    T pop() {
        if (estaVacia()) {
            std::cout << "Pila vacía" << std::endl;
            return T();  // Valor por defecto
        }
        return elementos[tope--];
    }

    T peek() {
        if (estaVacia()) {
            std::cout << "Pila vacía" << std::endl;
            return T();
        }
        return elementos[tope];
    }

    int tamanio() {
        return tope + 1;
    }
};

int main() {
    std::cout << "=== TEMPLATES EN C++ ===" << std::endl << std::endl;

    // TEMPLATES DE FUNCIONES
    std::cout << "--- TEMPLATES DE FUNCIONES ---" << std::endl;

    // Funciona con int
    std::cout << "Máximo entre 5 y 10: " << maximo(5, 10) << std::endl;

    // Funciona con double
    std::cout << "Máximo entre 3.14 y 2.71: " << maximo(3.14, 2.71) << std::endl;

    // Funciona con string
    std::cout << "Máximo entre 'abc' y 'xyz': " << maximo(std::string("abc"), std::string("xyz")) << std::endl;

    std::cout << std::endl;

    // TEMPLATE CON MÚLTIPLES TIPOS
    std::cout << "--- MÚLTIPLES TIPOS ---" << std::endl;
    mostrarPar(1, "uno");
    mostrarPar(3.14, 100);
    mostrarPar("nombre", 25);
    std::cout << std::endl;

    // TEMPLATE PARA ARREGLOS
    std::cout << "--- IMPRIMIR ARREGLOS ---" << std::endl;

    int enteros[] = {1, 2, 3, 4, 5};
    imprimirArreglo(enteros, 5);

    double decimales[] = {1.1, 2.2, 3.3};
    imprimirArreglo(decimales, 3);

    std::string palabras[] = {"hola", "mundo", "C++"};
    imprimirArreglo(palabras, 3);

    std::cout << std::endl;

    // TEMPLATES DE CLASES
    std::cout << "--- TEMPLATES DE CLASES ---" << std::endl;

    Par<int, int> coordenadas(10, 20);
    coordenadas.mostrar();

    Par<std::string, int> persona("Francisco", 25);
    persona.mostrar();

    Par<double, std::string> precio(19.99, "USD");
    precio.mostrar();

    std::cout << std::endl;

    // CAJA GENÉRICA
    std::cout << "--- CAJA GENÉRICA ---" << std::endl;

    Caja<int> cajaEnteros(42);
    cajaEnteros.mostrar();

    Caja<std::string> cajaTexto("¡Hola Mundo!");
    cajaTexto.mostrar();

    Caja<double> cajaDecimal(3.14159);
    cajaDecimal.mostrar();

    std::cout << std::endl;

    // PILA GENÉRICA
    std::cout << "--- PILA GENÉRICA ---" << std::endl;

    Pila<int> pilaEnteros;
    pilaEnteros.push(10);
    pilaEnteros.push(20);
    pilaEnteros.push(30);

    std::cout << "Tamaño de la pila: " << pilaEnteros.tamanio() << std::endl;
    std::cout << "Tope: " << pilaEnteros.peek() << std::endl;

    std::cout << "Desapilando: ";
    while (!pilaEnteros.estaVacia()) {
        std::cout << pilaEnteros.pop() << " ";
    }
    std::cout << std::endl << std::endl;

    // Pila de strings
    Pila<std::string> pilaStrings;
    pilaStrings.push("primero");
    pilaStrings.push("segundo");
    pilaStrings.push("tercero");

    std::cout << "Pila de strings: ";
    while (!pilaStrings.estaVacia()) {
        std::cout << pilaStrings.pop() << " ";
    }
    std::cout << std::endl;

    return 0;
}

/*
 * CÓMO COMPILAR Y EJECUTAR:
 * g++ 02_templates.cpp -o templates
 * ./templates
 *
 * ¿QUÉ SON LOS TEMPLATES?
 *
 * - Plantillas para crear código genérico
 * - Funcionan con cualquier tipo de dato
 * - El código se genera en tiempo de compilación
 * - No hay overhead en tiempo de ejecución
 *
 * VENTAJAS:
 * ✓ Reutilización de código
 * ✓ Type-safe (seguridad de tipos)
 * ✓ No overhead de rendimiento
 * ✓ Código más limpio y mantenible
 *
 * SINTAXIS:
 *
 * FUNCIÓN:
 * template <typename T>
 * T funcion(T param) { ... }
 *
 * CLASE:
 * template <typename T>
 * class MiClase { ... };
 *
 * TYPENAME vs CLASS:
 * - typename T y class T son equivalentes
 * - typename es más moderno y descriptivo
 *
 * MÚLTIPLES PARÁMETROS:
 * template <typename T1, typename T2, typename T3>
 *
 * CÓMO FUNCIONA:
 * 1. El compilador ve el uso del template
 * 2. Genera código específico para ese tipo
 * 3. Compila el código generado
 *
 * Ejemplo:
 * maximo(5, 10);           // Genera maximo<int>
 * maximo(3.14, 2.71);      // Genera maximo<double>
 *
 * LIMITACIONES:
 * - Todo el código debe estar en headers
 * - Los errores pueden ser difíciles de entender
 * - Puede aumentar el tamaño del ejecutable
 * - El tipo T debe soportar las operaciones usadas
 *
 * LA STL USA TEMPLATES:
 * std::vector<int>         // Template de vector con int
 * std::map<string, int>    // Template de map
 * std::set<double>         // Template de set
 *
 * BUENAS PRÁCTICAS:
 * ✓ Usa templates para código genérico
 * ✓ Documenta qué operaciones requiere T
 * ✓ Considera concepts (C++20) para restricciones
 * ✓ Usa auto cuando sea apropiado
 */
