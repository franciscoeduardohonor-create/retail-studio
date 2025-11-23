/*
 * MÓDULO 5: TABLA HASH (HASH TABLE)
 *
 * Estructura de datos que mapea claves a valores
 * - Búsqueda, inserción y eliminación en O(1) promedio
 * - Usa función hash para calcular índice
 * - Manejo de colisiones: encadenamiento y direccionamiento abierto
 */

#include <iostream>
#include <list>
#include <string>
using namespace std;

// ============================================
// IMPLEMENTACIÓN CON ENCADENAMIENTO
// ============================================

class HashTable {
private:
    static const int TAMANIO_TABLA = 10;

    // Estructura para par clave-valor
    struct Entrada {
        int clave;
        string valor;

        Entrada(int k, string v) : clave(k), valor(v) {}
    };

    // Array de listas (encadenamiento)
    list<Entrada>* tabla;

    // ========================================
    // FUNCIÓN HASH
    // Convierte clave en índice de tabla
    // ========================================
    int funcionHash(int clave) const {
        return clave % TAMANIO_TABLA;
    }

public:
    // Constructor
    HashTable() {
        tabla = new list<Entrada>[TAMANIO_TABLA];
    }

    // Destructor
    ~HashTable() {
        delete[] tabla;
    }

    // ========================================
    // INSERTAR
    // Complejidad promedio: O(1)
    // Complejidad peor caso: O(n) si todas las claves colisionan
    // ========================================
    void insertar(int clave, string valor) {
        int indice = funcionHash(clave);

        // Verificar si la clave ya existe
        for(auto& entrada : tabla[indice]) {
            if(entrada.clave == clave) {
                entrada.valor = valor;  // Actualizar valor
                cout << "Actualizada clave " << clave << " con valor: " << valor << endl;
                return;
            }
        }

        // Insertar nueva entrada
        tabla[indice].push_back(Entrada(clave, valor));
        cout << "Insertada clave " << clave << " en índice " << indice
             << " con valor: " << valor << endl;
    }

    // ========================================
    // BUSCAR
    // Complejidad promedio: O(1)
    // ========================================
    string buscar(int clave) const {
        int indice = funcionHash(clave);

        // Buscar en la lista del índice
        for(const auto& entrada : tabla[indice]) {
            if(entrada.clave == clave) {
                return entrada.valor;
            }
        }

        return "NO_ENCONTRADO";
    }

    // ========================================
    // ELIMINAR
    // Complejidad promedio: O(1)
    // ========================================
    bool eliminar(int clave) {
        int indice = funcionHash(clave);

        // Buscar y eliminar
        for(auto it = tabla[indice].begin(); it != tabla[indice].end(); ++it) {
            if(it->clave == clave) {
                cout << "Eliminada clave " << clave << endl;
                tabla[indice].erase(it);
                return true;
            }
        }

        cout << "Clave " << clave << " no encontrada" << endl;
        return false;
    }

    // ========================================
    // MOSTRAR TABLA
    // ========================================
    void mostrar() const {
        cout << "\n=== CONTENIDO DE LA TABLA HASH ===" << endl;
        for(int i = 0; i < TAMANIO_TABLA; i++) {
            cout << "Índice " << i << ": ";

            if(tabla[i].empty()) {
                cout << "(vacío)";
            } else {
                for(const auto& entrada : tabla[i]) {
                    cout << "[" << entrada.clave << ":" << entrada.valor << "] ";
                }
            }
            cout << endl;
        }
        cout << endl;
    }
};

// ============================================
// IMPLEMENTACIÓN CON DIRECCIONAMIENTO ABIERTO
// (Linear Probing)
// ============================================

class HashTableLinearProbing {
private:
    static const int TAMANIO = 10;
    static const int VACIO = -1;
    static const int ELIMINADO = -2;

    int claves[TAMANIO];
    string valores[TAMANIO];

    int funcionHash(int clave) const {
        return clave % TAMANIO;
    }

public:
    HashTableLinearProbing() {
        for(int i = 0; i < TAMANIO; i++) {
            claves[i] = VACIO;
            valores[i] = "";
        }
    }

    // ========================================
    // INSERTAR con Linear Probing
    // Si hay colisión, buscar siguiente posición libre
    // ========================================
    bool insertar(int clave, string valor) {
        int indice = funcionHash(clave);
        int intentos = 0;

        while(intentos < TAMANIO) {
            // Posición vacía o eliminada
            if(claves[indice] == VACIO || claves[indice] == ELIMINADO) {
                claves[indice] = clave;
                valores[indice] = valor;
                cout << "Insertada clave " << clave << " en índice " << indice << endl;
                return true;
            }

            // Actualizar si la clave ya existe
            if(claves[indice] == clave) {
                valores[indice] = valor;
                cout << "Actualizada clave " << clave << endl;
                return true;
            }

            // Linear probing: siguiente posición
            indice = (indice + 1) % TAMANIO;
            intentos++;
        }

        cout << "Tabla llena, no se puede insertar" << endl;
        return false;
    }

    // ========================================
    // BUSCAR con Linear Probing
    // ========================================
    string buscar(int clave) const {
        int indice = funcionHash(clave);
        int intentos = 0;

        while(intentos < TAMANIO) {
            if(claves[indice] == VACIO) {
                return "NO_ENCONTRADO";
            }

            if(claves[indice] == clave) {
                return valores[indice];
            }

            indice = (indice + 1) % TAMANIO;
            intentos++;
        }

        return "NO_ENCONTRADO";
    }

    // ========================================
    // ELIMINAR
    // ========================================
    bool eliminar(int clave) {
        int indice = funcionHash(clave);
        int intentos = 0;

        while(intentos < TAMANIO) {
            if(claves[indice] == VACIO) {
                return false;
            }

            if(claves[indice] == clave) {
                claves[indice] = ELIMINADO;
                valores[indice] = "";
                cout << "Eliminada clave " << clave << endl;
                return true;
            }

            indice = (indice + 1) % TAMANIO;
            intentos++;
        }

        return false;
    }

    void mostrar() const {
        cout << "\n=== TABLA HASH (Linear Probing) ===" << endl;
        for(int i = 0; i < TAMANIO; i++) {
            cout << "Índice " << i << ": ";
            if(claves[i] == VACIO) {
                cout << "(vacío)";
            } else if(claves[i] == ELIMINADO) {
                cout << "(eliminado)";
            } else {
                cout << "[" << claves[i] << ":" << valores[i] << "]";
            }
            cout << endl;
        }
        cout << endl;
    }
};

// ============================================
// FUNCIÓN PRINCIPAL
// ============================================

int main() {
    cout << "=== TABLA HASH (HASH TABLE) ===" << endl << endl;

    // ========================================
    // ENCADENAMIENTO (CHAINING)
    // ========================================
    cout << "--- MÉTODO 1: ENCADENAMIENTO ---" << endl;
    HashTable ht1;

    ht1.insertar(1, "Uno");
    ht1.insertar(2, "Dos");
    ht1.insertar(11, "Once");     // Colisión con 1 (1 % 10 = 1, 11 % 10 = 1)
    ht1.insertar(21, "Veintiuno"); // Colisión con 1
    ht1.insertar(3, "Tres");

    ht1.mostrar();

    cout << "Buscar clave 11: " << ht1.buscar(11) << endl;
    cout << "Buscar clave 99: " << ht1.buscar(99) << endl;
    cout << endl;

    ht1.eliminar(11);
    ht1.mostrar();

    // ========================================
    // LINEAR PROBING
    // ========================================
    cout << "\n--- MÉTODO 2: LINEAR PROBING ---" << endl;
    HashTableLinearProbing ht2;

    ht2.insertar(5, "Cinco");
    ht2.insertar(15, "Quince");   // Colisión: 15 % 10 = 5
    ht2.insertar(25, "Veinticinco"); // Colisión: 25 % 10 = 5
    ht2.insertar(7, "Siete");

    ht2.mostrar();

    cout << "Buscar clave 15: " << ht2.buscar(15) << endl;
    cout << "Buscar clave 25: " << ht2.buscar(25) << endl;
    cout << endl;

    ht2.eliminar(15);
    ht2.mostrar();

    return 0;
}

/*
 * CONCEPTOS CLAVE:
 * ================
 *
 * 1. FUNCIÓN HASH:
 *    - Convierte clave en índice
 *    - Debe ser determinística
 *    - Debe distribuir uniformemente
 *    - Ejemplo simple: clave % tamaño
 *
 * 2. COLISIONES:
 *    - Cuando dos claves dan el mismo hash
 *    - Inevitable por principio del palomar
 *
 * 3. MANEJO DE COLISIONES:
 *
 *    A) ENCADENAMIENTO (Chaining):
 *       - Cada índice tiene una lista
 *       - Múltiples elementos en mismo índice
 *       - Ventaja: Fácil implementar, tabla nunca llena
 *       - Desventaja: Memoria extra para listas
 *
 *    B) DIRECCIONAMIENTO ABIERTO:
 *       - Linear Probing: Buscar siguiente libre
 *       - Quadratic Probing: Saltos cuadráticos
 *       - Double Hashing: Segunda función hash
 *       - Ventaja: Sin memoria extra
 *       - Desventaja: Tabla puede llenarse
 *
 * 4. COMPLEJIDAD:
 *    - Promedio: O(1) para buscar, insertar, eliminar
 *    - Peor caso: O(n) si todas las claves colisionan
 *
 * 5. FACTOR DE CARGA (Load Factor):
 *    - α = n / tamaño_tabla
 *    - n = número de elementos
 *    - Mantener α < 0.7 para buen rendimiento
 *    - Si α muy alto: rehashing (aumentar tamaño)
 *
 * 6. APLICACIONES:
 *    - Diccionarios (mapas)
 *    - Cachés
 *    - Conjuntos (sets)
 *    - Índices de bases de datos
 *    - Contadores de frecuencia
 *
 * 7. VENTAJAS:
 *    - Acceso muy rápido: O(1) promedio
 *    - Flexible con tipos de claves
 *
 * 8. DESVENTAJAS:
 *    - No mantiene orden
 *    - Requiere buena función hash
 *    - Colisiones degradan rendimiento
 */
