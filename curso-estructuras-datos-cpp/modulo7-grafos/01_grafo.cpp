/*
 * MÓDULO 7: GRAFOS (GRAPHS)
 *
 * Estructura no lineal de nodos (vértices) conectados por aristas
 * - Tipos: Dirigido/No dirigido, Ponderado/No ponderado
 * - Representación: Matriz de adyacencia, Lista de adyacencia
 * - Algoritmos: BFS, DFS, Dijkstra
 */

#include <iostream>
#include <vector>
#include <queue>
#include <stack>
#include <list>
#include <climits>
using namespace std;

// ============================================
// GRAFO CON LISTA DE ADYACENCIA
// ============================================

class Grafo {
private:
    int numVertices;
    vector<list<int>> listaAdyacencia;  // Lista de adyacencia
    bool esDirigido;

public:
    // Constructor
    Grafo(int vertices, bool dirigido = false)
        : numVertices(vertices), esDirigido(dirigido) {
        listaAdyacencia.resize(vertices);
    }

    // ========================================
    // AGREGAR ARISTA
    // Complejidad: O(1)
    // ========================================
    void agregarArista(int origen, int destino) {
        listaAdyacencia[origen].push_back(destino);

        // Si no es dirigido, agregar arista inversa
        if(!esDirigido) {
            listaAdyacencia[destino].push_back(origen);
        }

        cout << "Arista agregada: " << origen << " -> " << destino << endl;
    }

    // ========================================
    // MOSTRAR GRAFO
    // ========================================
    void mostrar() const {
        cout << "\n=== LISTA DE ADYACENCIA ===" << endl;
        for(int i = 0; i < numVertices; i++) {
            cout << "Vértice " << i << ": ";
            for(int vecino : listaAdyacencia[i]) {
                cout << vecino << " ";
            }
            cout << endl;
        }
        cout << endl;
    }

    // ========================================
    // BFS (Breadth-First Search)
    // Búsqueda en anchura - Usa COLA
    // Complejidad: O(V + E)
    // ========================================
    void BFS(int inicio) {
        vector<bool> visitado(numVertices, false);
        queue<int> cola;

        visitado[inicio] = true;
        cola.push(inicio);

        cout << "BFS desde " << inicio << ": ";

        while(!cola.empty()) {
            int vertice = cola.front();
            cola.pop();
            cout << vertice << " ";

            // Visitar vecinos no visitados
            for(int vecino : listaAdyacencia[vertice]) {
                if(!visitado[vecino]) {
                    visitado[vecino] = true;
                    cola.push(vecino);
                }
            }
        }

        cout << endl;
    }

    // ========================================
    // DFS (Depth-First Search) - Iterativo
    // Búsqueda en profundidad - Usa PILA
    // Complejidad: O(V + E)
    // ========================================
    void DFS(int inicio) {
        vector<bool> visitado(numVertices, false);
        stack<int> pila;

        pila.push(inicio);

        cout << "DFS desde " << inicio << ": ";

        while(!pila.empty()) {
            int vertice = pila.top();
            pila.pop();

            if(!visitado[vertice]) {
                cout << vertice << " ";
                visitado[vertice] = true;

                // Agregar vecinos no visitados a la pila
                for(int vecino : listaAdyacencia[vertice]) {
                    if(!visitado[vecino]) {
                        pila.push(vecino);
                    }
                }
            }
        }

        cout << endl;
    }

    // ========================================
    // DFS RECURSIVO
    // ========================================
private:
    void DFSRecursivoUtil(int vertice, vector<bool>& visitado) {
        visitado[vertice] = true;
        cout << vertice << " ";

        // Visitar vecinos
        for(int vecino : listaAdyacencia[vertice]) {
            if(!visitado[vecino]) {
                DFSRecursivoUtil(vecino, visitado);
            }
        }
    }

public:
    void DFSRecursivo(int inicio) {
        vector<bool> visitado(numVertices, false);
        cout << "DFS Recursivo desde " << inicio << ": ";
        DFSRecursivoUtil(inicio, visitado);
        cout << endl;
    }

    // ========================================
    // DETECTAR CICLO (en grafo no dirigido)
    // ========================================
private:
    bool tieneCicloUtil(int vertice, vector<bool>& visitado, int padre) {
        visitado[vertice] = true;

        for(int vecino : listaAdyacencia[vertice]) {
            if(!visitado[vecino]) {
                if(tieneCicloUtil(vecino, visitado, vertice)) {
                    return true;
                }
            }
            // Si el vecino está visitado y no es el padre, hay ciclo
            else if(vecino != padre) {
                return true;
            }
        }

        return false;
    }

public:
    bool tieneCiclo() {
        vector<bool> visitado(numVertices, false);

        // Verificar todos los componentes
        for(int i = 0; i < numVertices; i++) {
            if(!visitado[i]) {
                if(tieneCicloUtil(i, visitado, -1)) {
                    return true;
                }
            }
        }

        return false;
    }

    // ========================================
    // VERIFICAR SI ES CONEXO
    // ========================================
    bool esConexo() {
        vector<bool> visitado(numVertices, false);
        queue<int> cola;

        // BFS desde vértice 0
        cola.push(0);
        visitado[0] = true;
        int contadorVisitados = 1;

        while(!cola.empty()) {
            int v = cola.front();
            cola.pop();

            for(int vecino : listaAdyacencia[v]) {
                if(!visitado[vecino]) {
                    visitado[vecino] = true;
                    cola.push(vecino);
                    contadorVisitados++;
                }
            }
        }

        return contadorVisitados == numVertices;
    }
};

// ============================================
// GRAFO PONDERADO (con pesos en aristas)
// Para algoritmos como Dijkstra
// ============================================

class GrafoPonderado {
private:
    int numVertices;
    vector<list<pair<int, int>>> listaAdyacencia;  // {destino, peso}

public:
    GrafoPonderado(int vertices) : numVertices(vertices) {
        listaAdyacencia.resize(vertices);
    }

    void agregarArista(int origen, int destino, int peso) {
        listaAdyacencia[origen].push_back({destino, peso});
        cout << "Arista: " << origen << " -> " << destino
             << " (peso: " << peso << ")" << endl;
    }

    // ========================================
    // ALGORITMO DE DIJKSTRA
    // Encuentra camino más corto desde origen
    // Complejidad: O((V + E) log V) con priority queue
    // ========================================
    void dijkstra(int origen) {
        vector<int> distancia(numVertices, INT_MAX);
        vector<int> padre(numVertices, -1);

        // Min heap: {distancia, vértice}
        priority_queue<pair<int, int>,
                       vector<pair<int, int>>,
                       greater<pair<int, int>>> pq;

        distancia[origen] = 0;
        pq.push({0, origen});

        while(!pq.empty()) {
            int u = pq.top().second;
            int dist_u = pq.top().first;
            pq.pop();

            // Si ya encontramos mejor camino, saltar
            if(dist_u > distancia[u]) continue;

            // Explorar vecinos
            for(auto& [v, peso] : listaAdyacencia[u]) {
                int nuevaDistancia = distancia[u] + peso;

                // Relajación de arista
                if(nuevaDistancia < distancia[v]) {
                    distancia[v] = nuevaDistancia;
                    padre[v] = u;
                    pq.push({nuevaDistancia, v});
                }
            }
        }

        // Mostrar resultados
        cout << "\n=== DIJKSTRA desde vértice " << origen << " ===" << endl;
        for(int i = 0; i < numVertices; i++) {
            cout << "Vértice " << i << ": ";
            if(distancia[i] == INT_MAX) {
                cout << "No alcanzable";
            } else {
                cout << "distancia = " << distancia[i];
            }
            cout << endl;
        }
    }
};

// ============================================
// FUNCIÓN PRINCIPAL
// ============================================

int main() {
    cout << "=== GRAFOS (GRAPHS) ===" << endl << endl;

    // ========================================
    // GRAFO NO DIRIGIDO
    // ========================================
    cout << "--- GRAFO NO DIRIGIDO ---" << endl;
    Grafo g1(5, false);

    g1.agregarArista(0, 1);
    g1.agregarArista(0, 4);
    g1.agregarArista(1, 2);
    g1.agregarArista(1, 3);
    g1.agregarArista(1, 4);
    g1.agregarArista(2, 3);
    g1.agregarArista(3, 4);

    g1.mostrar();

    /*
     * Grafo:
     *     0 --- 1 --- 2
     *     |   / |  \  |
     *     | /   |   \ |
     *     4 ----3----
     */

    // ========================================
    // RECORRIDOS
    // ========================================
    cout << "--- RECORRIDOS ---" << endl;
    g1.BFS(0);
    g1.DFS(0);
    g1.DFSRecursivo(0);
    cout << endl;

    // ========================================
    // PROPIEDADES
    // ========================================
    cout << "--- PROPIEDADES ---" << endl;
    cout << "¿Es conexo? " << (g1.esConexo() ? "Sí" : "No") << endl;
    cout << "¿Tiene ciclo? " << (g1.tieneCiclo() ? "Sí" : "No") << endl;
    cout << endl;

    // ========================================
    // GRAFO DIRIGIDO
    // ========================================
    cout << "--- GRAFO DIRIGIDO ---" << endl;
    Grafo g2(4, true);

    g2.agregarArista(0, 1);
    g2.agregarArista(0, 2);
    g2.agregarArista(1, 2);
    g2.agregarArista(2, 0);
    g2.agregarArista(2, 3);
    g2.agregarArista(3, 3);

    g2.mostrar();
    g2.BFS(2);
    cout << endl;

    // ========================================
    // GRAFO PONDERADO - DIJKSTRA
    // ========================================
    cout << "--- GRAFO PONDERADO (Dijkstra) ---" << endl;
    GrafoPonderado gp(5);

    gp.agregarArista(0, 1, 4);
    gp.agregarArista(0, 2, 1);
    gp.agregarArista(2, 1, 2);
    gp.agregarArista(1, 3, 1);
    gp.agregarArista(2, 3, 5);
    gp.agregarArista(3, 4, 3);

    gp.dijkstra(0);

    return 0;
}

/*
 * CONCEPTOS CLAVE:
 * ================
 *
 * 1. GRAFO:
 *    - G = (V, E)
 *    - V = conjunto de vértices (nodos)
 *    - E = conjunto de aristas (edges)
 *
 * 2. TIPOS DE GRAFOS:
 *    - Dirigido vs No dirigido
 *    - Ponderado vs No ponderado
 *    - Conexo vs Desconexo
 *    - Cíclico vs Acíclico (DAG)
 *
 * 3. REPRESENTACIONES:
 *
 *    A) MATRIZ DE ADYACENCIA:
 *       - Array 2D [V][V]
 *       - mat[i][j] = 1 si hay arista
 *       - Espacio: O(V²)
 *       - Verificar arista: O(1)
 *       - Listar vecinos: O(V)
 *
 *    B) LISTA DE ADYACENCIA:
 *       - Array de listas
 *       - Espacio: O(V + E)
 *       - Verificar arista: O(grado)
 *       - Listar vecinos: O(grado)
 *       - Mejor para grafos dispersos
 *
 * 4. ALGORITMOS DE RECORRIDO:
 *
 *    A) BFS (Breadth-First Search):
 *       - Usa Cola (FIFO)
 *       - Nivel por nivel
 *       - Encuentra camino más corto (sin pesos)
 *       - O(V + E)
 *
 *    B) DFS (Depth-First Search):
 *       - Usa Pila (recursión o explícita)
 *       - Profundidad primero
 *       - Detectar ciclos
 *       - O(V + E)
 *
 * 5. ALGORITMOS DE CAMINO MÁS CORTO:
 *
 *    A) DIJKSTRA:
 *       - Desde un origen a todos
 *       - Solo pesos positivos
 *       - O((V + E) log V) con heap
 *
 *    B) BELLMAN-FORD:
 *       - Acepta pesos negativos
 *       - O(VE)
 *
 *    C) FLOYD-WARSHALL:
 *       - Todos los pares
 *       - O(V³)
 *
 * 6. APLICACIONES:
 *    - Redes sociales (amistades)
 *    - Mapas y navegación (GPS)
 *    - Internet (routers)
 *    - Dependencias (build systems)
 *    - Recomendaciones
 *    - Análisis de redes
 *
 * 7. PROBLEMAS CLÁSICOS:
 *    - Camino más corto
 *    - Detectar ciclos
 *    - Componentes conexas
 *    - Árbol de expansión mínima (MST)
 *    - Ordenamiento topológico
 *    - Coloración de grafos
 */
