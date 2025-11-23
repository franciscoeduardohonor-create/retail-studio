/*
 * MÓDULO 8: TRIE (Árbol de Prefijos)
 *
 * Estructura de datos para almacenar strings
 * - Cada nodo representa un carácter
 * - Búsqueda, inserción: O(m) donde m = longitud de palabra
 * - Ideal para autocompletar, diccionarios, búsqueda de prefijos
 */

#include <iostream>
#include <string>
#include <vector>
using namespace std;

// ============================================
// NODO DEL TRIE
// ============================================

const int ALFABETO = 26;  // a-z

struct NodoTrie {
    NodoTrie* hijos[ALFABETO];  // Array de punteros a hijos
    bool esFinal;               // Marca fin de palabra

    NodoTrie() {
        esFinal = false;
        for(int i = 0; i < ALFABETO; i++) {
            hijos[i] = nullptr;
        }
    }
};

// ============================================
// CLASE TRIE
// ============================================

class Trie {
private:
    NodoTrie* raiz;

    // Convertir carácter a índice (a=0, b=1, ..., z=25)
    int charAIndice(char c) {
        return c - 'a';
    }

    // ========================================
    // ELIMINAR RECURSIVO (helper)
    // ========================================
    bool eliminarHelper(NodoTrie* nodo, const string& palabra, int profundidad) {
        if(nodo == nullptr) return false;

        // Caso base: llegamos al final de la palabra
        if(profundidad == palabra.length()) {
            if(!nodo->esFinal) {
                return false;  // La palabra no existe
            }

            nodo->esFinal = false;  // Desmarcar como final

            // Si el nodo no tiene hijos, puede ser eliminado
            for(int i = 0; i < ALFABETO; i++) {
                if(nodo->hijos[i] != nullptr) {
                    return false;  // Tiene hijos, no eliminar
                }
            }
            return true;  // Puede ser eliminado
        }

        // Recursión
        int indice = charAIndice(palabra[profundidad]);
        if(eliminarHelper(nodo->hijos[indice], palabra, profundidad + 1)) {
            delete nodo->hijos[indice];
            nodo->hijos[indice] = nullptr;

            // Si no es final y no tiene otros hijos, puede eliminarse
            if(!nodo->esFinal) {
                for(int i = 0; i < ALFABETO; i++) {
                    if(nodo->hijos[i] != nullptr) {
                        return false;
                    }
                }
                return true;
            }
        }

        return false;
    }

    // ========================================
    // SUGERENCIAS RECURSIVO (helper)
    // ========================================
    void obtenerSugerenciasHelper(NodoTrie* nodo, string prefijo, vector<string>& sugerencias) {
        if(nodo == nullptr) return;

        // Si es fin de palabra, agregar a sugerencias
        if(nodo->esFinal) {
            sugerencias.push_back(prefijo);
        }

        // Recorrer todos los hijos
        for(int i = 0; i < ALFABETO; i++) {
            if(nodo->hijos[i] != nullptr) {
                char c = 'a' + i;
                obtenerSugerenciasHelper(nodo->hijos[i], prefijo + c, sugerencias);
            }
        }
    }

public:
    Trie() {
        raiz = new NodoTrie();
    }

    // ========================================
    // INSERTAR PALABRA
    // Complejidad: O(m) donde m = longitud de palabra
    // ========================================
    void insertar(const string& palabra) {
        NodoTrie* actual = raiz;

        // Recorrer cada carácter
        for(char c : palabra) {
            int indice = charAIndice(c);

            // Si no existe el hijo, crearlo
            if(actual->hijos[indice] == nullptr) {
                actual->hijos[indice] = new NodoTrie();
            }

            // Avanzar al siguiente nodo
            actual = actual->hijos[indice];
        }

        // Marcar el último nodo como fin de palabra
        actual->esFinal = true;
        cout << "Insertada: " << palabra << endl;
    }

    // ========================================
    // BUSCAR PALABRA COMPLETA
    // Complejidad: O(m)
    // ========================================
    bool buscar(const string& palabra) {
        NodoTrie* actual = raiz;

        for(char c : palabra) {
            int indice = charAIndice(c);

            // Si no existe el camino, la palabra no está
            if(actual->hijos[indice] == nullptr) {
                return false;
            }

            actual = actual->hijos[indice];
        }

        // Verificar que sea fin de palabra
        return actual->esFinal;
    }

    // ========================================
    // BUSCAR SI EXISTE PREFIJO
    // Complejidad: O(m)
    // ========================================
    bool existePrefijo(const string& prefijo) {
        NodoTrie* actual = raiz;

        for(char c : prefijo) {
            int indice = charAIndice(c);

            if(actual->hijos[indice] == nullptr) {
                return false;
            }

            actual = actual->hijos[indice];
        }

        return true;  // El prefijo existe
    }

    // ========================================
    // ELIMINAR PALABRA
    // Complejidad: O(m)
    // ========================================
    void eliminar(const string& palabra) {
        if(eliminarHelper(raiz, palabra, 0)) {
            cout << "Eliminada: " << palabra << endl;
        } else {
            cout << "No se pudo eliminar: " << palabra << endl;
        }
    }

    // ========================================
    // AUTOCOMPLETAR (Sugerencias)
    // Retorna todas las palabras con el prefijo dado
    // ========================================
    vector<string> autocompletar(const string& prefijo) {
        vector<string> sugerencias;
        NodoTrie* actual = raiz;

        // Navegar hasta el final del prefijo
        for(char c : prefijo) {
            int indice = charAIndice(c);

            if(actual->hijos[indice] == nullptr) {
                return sugerencias;  // Prefijo no existe
            }

            actual = actual->hijos[indice];
        }

        // Obtener todas las palabras desde este nodo
        obtenerSugerenciasHelper(actual, prefijo, sugerencias);

        return sugerencias;
    }

    // ========================================
    // CONTAR PALABRAS
    // ========================================
    int contarPalabras(NodoTrie* nodo = nullptr) {
        if(nodo == nullptr) nodo = raiz;

        int contador = nodo->esFinal ? 1 : 0;

        for(int i = 0; i < ALFABETO; i++) {
            if(nodo->hijos[i] != nullptr) {
                contador += contarPalabras(nodo->hijos[i]);
            }
        }

        return contador;
    }
};

// ============================================
// FUNCIÓN PRINCIPAL
// ============================================

int main() {
    cout << "=== TRIE (ÁRBOL DE PREFIJOS) ===" << endl << endl;

    Trie trie;

    // ========================================
    // INSERTAR PALABRAS
    // ========================================
    cout << "--- INSERTANDO PALABRAS ---" << endl;
    trie.insertar("hola");
    trie.insertar("holo");
    trie.insertar("hoja");
    trie.insertar("casa");
    trie.insertar("casamiento");
    trie.insertar("carro");
    trie.insertar("caro");
    cout << endl;

    /*
     * Estructura del Trie:
     *
     *          root
     *         /    \
     *        h      c
     *        |      |
     *        o      a
     *       / \     |
     *      l   j   s,r
     *     /|   |   | |
     *    a o   a   a r
     *    *  *  *   |   |
     *            m,* o,*
     *            |
     *            i
     *            |
     *            e
     *            |
     *            n
     *            |
     *            t
     *            |
     *            o
     *            *
     *
     * * = fin de palabra
     */

    // ========================================
    // BUSCAR PALABRAS
    // ========================================
    cout << "--- BUSCAR PALABRAS ---" << endl;
    string palabrasBuscar[] = {"hola", "hol", "casa", "casamiento", "perro"};

    for(const string& palabra : palabrasBuscar) {
        if(trie.buscar(palabra)) {
            cout << "✓ '" << palabra << "' ENCONTRADA" << endl;
        } else {
            cout << "✗ '" << palabra << "' NO encontrada" << endl;
        }
    }
    cout << endl;

    // ========================================
    // BUSCAR PREFIJOS
    // ========================================
    cout << "--- VERIFICAR PREFIJOS ---" << endl;
    string prefijos[] = {"ho", "cas", "carr", "per"};

    for(const string& prefijo : prefijos) {
        if(trie.existePrefijo(prefijo)) {
            cout << "✓ Prefijo '" << prefijo << "' EXISTE" << endl;
        } else {
            cout << "✗ Prefijo '" << prefijo << "' NO existe" << endl;
        }
    }
    cout << endl;

    // ========================================
    // AUTOCOMPLETAR
    // ========================================
    cout << "--- AUTOCOMPLETAR ---" << endl;
    string prefijoAuto[] = {"ho", "casa", "car"};

    for(const string& pref : prefijoAuto) {
        cout << "Sugerencias para '" << pref << "': ";
        vector<string> sugerencias = trie.autocompletar(pref);

        if(sugerencias.empty()) {
            cout << "(ninguna)";
        } else {
            for(const string& sug : sugerencias) {
                cout << sug << " ";
            }
        }
        cout << endl;
    }
    cout << endl;

    // ========================================
    // ESTADÍSTICAS
    // ========================================
    cout << "--- ESTADÍSTICAS ---" << endl;
    cout << "Total de palabras: " << trie.contarPalabras() << endl;
    cout << endl;

    // ========================================
    // ELIMINAR PALABRA
    // ========================================
    cout << "--- ELIMINAR PALABRA ---" << endl;
    trie.eliminar("hola");

    cout << "\nDespués de eliminar 'hola':" << endl;
    cout << "¿Existe 'hola'? " << (trie.buscar("hola") ? "Sí" : "No") << endl;
    cout << "¿Existe 'holo'? " << (trie.buscar("holo") ? "Sí" : "No") << endl;
    cout << "Total de palabras: " << trie.contarPalabras() << endl;

    return 0;
}

/*
 * CONCEPTOS CLAVE:
 * ================
 *
 * 1. TRIE (Prefix Tree):
 *    - Árbol donde cada nodo representa un carácter
 *    - Caminos desde raíz forman palabras
 *    - Nodos comparten prefijos comunes
 *
 * 2. ESTRUCTURA:
 *    - Raíz vacía
 *    - Cada nodo tiene array de hijos (26 para a-z)
 *    - Flag "esFinal" marca fin de palabra
 *
 * 3. COMPLEJIDAD:
 *    - Insertar: O(m) donde m = longitud de palabra
 *    - Buscar: O(m)
 *    - Eliminar: O(m)
 *    - Autocompletar: O(m + k) donde k = resultados
 *    - Espacio: O(ALFABETO * N * M)
 *      * N = número de palabras
 *      * M = longitud promedio
 *
 * 4. VENTAJAS:
 *    - Búsqueda de prefijos muy rápida
 *    - Autocompletar eficiente
 *    - No hay colisiones (como en hash)
 *    - Ordenamiento implícito
 *
 * 5. DESVENTAJAS:
 *    - Uso de memoria (muchos punteros)
 *    - Desperdicio si pocas palabras
 *    - Más complejo que hash table
 *
 * 6. OPTIMIZACIONES:
 *    - Compressed Trie (Patricia Tree)
 *    - Radix Tree
 *    - Usar hash map en lugar de array
 *
 * 7. APLICACIONES:
 *    - Autocompletar (Google, IDE)
 *    - Correctores ortográficos
 *    - Diccionarios
 *    - Enrutamiento IP
 *    - Búsqueda de palabras en texto
 *    - T9 (teclados de teléfono)
 *    - Sistemas de sugerencias
 *
 * 8. OPERACIONES COMUNES:
 *    - insertar(palabra)
 *    - buscar(palabra)
 *    - existePrefijo(prefijo)
 *    - autocompletar(prefijo)
 *    - eliminar(palabra)
 *
 * 9. VARIANTES:
 *    - Trie estándar (este ejemplo)
 *    - Compressed Trie (Patricia)
 *    - Suffix Trie/Tree
 *    - Radix Tree
 */
