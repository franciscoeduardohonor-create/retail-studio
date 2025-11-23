/*
 * MÓDULO 6: HEAP (MONTÍCULO)
 *
 * Árbol binario completo con propiedad de heap:
 * - MIN HEAP: Padre ≤ Hijos
 * - MAX HEAP: Padre ≥ Hijos
 * - Implementado con array
 * - Operaciones: insert O(log n), extractMin/Max O(log n)
 * - Aplicaciones: Cola de prioridad, Heap Sort
 */

#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

// ============================================
// MIN HEAP
// ============================================

class MinHeap {
private:
    vector<int> heap;

    // ========================================
    // OBTENER ÍNDICES
    // ========================================
    int padre(int i) { return (i - 1) / 2; }
    int hijoIzq(int i) { return 2 * i + 1; }
    int hijoDer(int i) { return 2 * i + 2; }

    // ========================================
    // HEAPIFY UP
    // Restaurar propiedad de heap después de inserción
    // ========================================
    void heapifyUp(int indice) {
        // Mientras no sea raíz y sea menor que padre
        while(indice > 0 && heap[indice] < heap[padre(indice)]) {
            // Intercambiar con padre
            swap(heap[indice], heap[padre(indice)]);
            indice = padre(indice);
        }
    }

    // ========================================
    // HEAPIFY DOWN
    // Restaurar propiedad de heap después de extracción
    // ========================================
    void heapifyDown(int indice) {
        int tamanio = heap.size();
        int menor = indice;

        while(true) {
            int izq = hijoIzq(indice);
            int der = hijoDer(indice);

            // Encontrar el menor entre nodo actual e hijos
            if(izq < tamanio && heap[izq] < heap[menor]) {
                menor = izq;
            }
            if(der < tamanio && heap[der] < heap[menor]) {
                menor = der;
            }

            // Si el nodo actual ya es el menor, terminar
            if(menor == indice) {
                break;
            }

            // Intercambiar y continuar
            swap(heap[indice], heap[menor]);
            indice = menor;
        }
    }

public:
    // ========================================
    // INSERTAR
    // Complejidad: O(log n)
    // ========================================
    void insertar(int valor) {
        heap.push_back(valor);
        heapifyUp(heap.size() - 1);
        cout << "Insertado: " << valor << endl;
    }

    // ========================================
    // EXTRAER MÍNIMO
    // Complejidad: O(log n)
    // ========================================
    int extraerMin() {
        if(heap.empty()) {
            cout << "Heap vacío" << endl;
            return -1;
        }

        int minimo = heap[0];

        // Mover último elemento a la raíz
        heap[0] = heap.back();
        heap.pop_back();

        // Restaurar propiedad de heap
        if(!heap.empty()) {
            heapifyDown(0);
        }

        cout << "Extraído mínimo: " << minimo << endl;
        return minimo;
    }

    // ========================================
    // VER MÍNIMO SIN EXTRAER
    // Complejidad: O(1)
    // ========================================
    int verMin() const {
        if(heap.empty()) {
            cout << "Heap vacío" << endl;
            return -1;
        }
        return heap[0];
    }

    bool estaVacio() const {
        return heap.empty();
    }

    int tamanio() const {
        return heap.size();
    }

    void mostrar() const {
        cout << "Min Heap: ";
        for(int val : heap) {
            cout << val << " ";
        }
        cout << endl;
    }
};

// ============================================
// MAX HEAP
// ============================================

class MaxHeap {
private:
    vector<int> heap;

    int padre(int i) { return (i - 1) / 2; }
    int hijoIzq(int i) { return 2 * i + 1; }
    int hijoDer(int i) { return 2 * i + 2; }

    void heapifyUp(int indice) {
        // Mientras no sea raíz y sea MAYOR que padre
        while(indice > 0 && heap[indice] > heap[padre(indice)]) {
            swap(heap[indice], heap[padre(indice)]);
            indice = padre(indice);
        }
    }

    void heapifyDown(int indice) {
        int tamanio = heap.size();
        int mayor = indice;

        while(true) {
            int izq = hijoIzq(indice);
            int der = hijoDer(indice);

            // Encontrar el MAYOR entre nodo actual e hijos
            if(izq < tamanio && heap[izq] > heap[mayor]) {
                mayor = izq;
            }
            if(der < tamanio && heap[der] > heap[mayor]) {
                mayor = der;
            }

            if(mayor == indice) {
                break;
            }

            swap(heap[indice], heap[mayor]);
            indice = mayor;
        }
    }

public:
    void insertar(int valor) {
        heap.push_back(valor);
        heapifyUp(heap.size() - 1);
        cout << "Insertado: " << valor << endl;
    }

    int extraerMax() {
        if(heap.empty()) {
            cout << "Heap vacío" << endl;
            return -1;
        }

        int maximo = heap[0];
        heap[0] = heap.back();
        heap.pop_back();

        if(!heap.empty()) {
            heapifyDown(0);
        }

        cout << "Extraído máximo: " << maximo << endl;
        return maximo;
    }

    int verMax() const {
        if(heap.empty()) return -1;
        return heap[0];
    }

    bool estaVacio() const {
        return heap.empty();
    }

    void mostrar() const {
        cout << "Max Heap: ";
        for(int val : heap) {
            cout << val << " ";
        }
        cout << endl;
    }
};

// ============================================
// HEAP SORT
// ============================================

void heapSort(vector<int>& arr) {
    int n = arr.size();

    // Construir Max Heap
    for(int i = n / 2 - 1; i >= 0; i--) {
        // Heapify down desde cada nodo no-hoja
        int indice = i;
        while(true) {
            int mayor = indice;
            int izq = 2 * indice + 1;
            int der = 2 * indice + 2;

            if(izq < n && arr[izq] > arr[mayor])
                mayor = izq;
            if(der < n && arr[der] > arr[mayor])
                mayor = der;

            if(mayor == indice)
                break;

            swap(arr[indice], arr[mayor]);
            indice = mayor;
        }
    }

    // Extraer elementos uno por uno
    for(int i = n - 1; i > 0; i--) {
        swap(arr[0], arr[i]);  // Mover raíz al final

        // Heapify down en heap reducido
        int tamanio = i;
        int indice = 0;
        while(true) {
            int mayor = indice;
            int izq = 2 * indice + 1;
            int der = 2 * indice + 2;

            if(izq < tamanio && arr[izq] > arr[mayor])
                mayor = izq;
            if(der < tamanio && arr[der] > arr[mayor])
                mayor = der;

            if(mayor == indice)
                break;

            swap(arr[indice], arr[mayor]);
            indice = mayor;
        }
    }
}

// ============================================
// FUNCIÓN PRINCIPAL
// ============================================

int main() {
    cout << "=== HEAP (MONTÍCULO) ===" << endl << endl;

    // ========================================
    // MIN HEAP
    // ========================================
    cout << "--- MIN HEAP ---" << endl;
    MinHeap minHeap;

    minHeap.insertar(10);
    minHeap.insertar(5);
    minHeap.insertar(20);
    minHeap.insertar(1);
    minHeap.insertar(15);

    minHeap.mostrar();
    cout << "Mínimo actual: " << minHeap.verMin() << endl;
    cout << endl;

    minHeap.extraerMin();
    minHeap.extraerMin();
    minHeap.mostrar();
    cout << endl;

    // ========================================
    // MAX HEAP
    // ========================================
    cout << "--- MAX HEAP ---" << endl;
    MaxHeap maxHeap;

    maxHeap.insertar(10);
    maxHeap.insertar(5);
    maxHeap.insertar(20);
    maxHeap.insertar(30);
    maxHeap.insertar(15);

    maxHeap.mostrar();
    cout << "Máximo actual: " << maxHeap.verMax() << endl;
    cout << endl;

    maxHeap.extraerMax();
    maxHeap.extraerMax();
    maxHeap.mostrar();
    cout << endl;

    // ========================================
    // HEAP SORT
    // ========================================
    cout << "--- HEAP SORT ---" << endl;
    vector<int> arr = {64, 34, 25, 12, 22, 11, 90};

    cout << "Array original: ";
    for(int val : arr) cout << val << " ";
    cout << endl;

    heapSort(arr);

    cout << "Array ordenado: ";
    for(int val : arr) cout << val << " ";
    cout << endl;

    return 0;
}

/*
 * CONCEPTOS CLAVE:
 * ================
 *
 * 1. HEAP (MONTÍCULO):
 *    - Árbol binario COMPLETO
 *    - Se implementa con array
 *    - Índices: padre(i) = (i-1)/2
 *              hijo_izq(i) = 2i+1
 *              hijo_der(i) = 2i+2
 *
 * 2. TIPOS:
 *    - MIN HEAP: Padre ≤ Hijos
 *      * Raíz = elemento mínimo
 *    - MAX HEAP: Padre ≥ Hijos
 *      * Raíz = elemento máximo
 *
 * 3. OPERACIONES:
 *    - Insertar: O(log n)
 *      1. Agregar al final
 *      2. Heapify up
 *    - Extraer min/max: O(log n)
 *      1. Guardar raíz
 *      2. Mover último a raíz
 *      3. Heapify down
 *    - Ver min/max: O(1)
 *
 * 4. HEAPIFY:
 *    - Heapify Up: Subir elemento si viola propiedad
 *    - Heapify Down: Bajar elemento si viola propiedad
 *
 * 5. HEAP SORT:
 *    - Complejidad: O(n log n)
 *    - Espacio: O(1) in-place
 *    - Pasos:
 *      1. Construir max heap: O(n)
 *      2. Extraer elementos: O(n log n)
 *
 * 6. COLA DE PRIORIDAD:
 *    - Min Heap: Menor valor = mayor prioridad
 *    - Max Heap: Mayor valor = mayor prioridad
 *    - Insertar y extraer en O(log n)
 *
 * 7. APLICACIONES:
 *    - Cola de prioridad
 *    - Heap Sort
 *    - Algoritmo de Dijkstra
 *    - K elementos más grandes/pequeños
 *    - Mediana dinámica (dos heaps)
 *    - Merge K sorted arrays
 *
 * 8. VENTAJAS:
 *    - Acceso rápido a min/max: O(1)
 *    - Inserción/eliminación eficiente: O(log n)
 *    - Implementación simple con array
 *    - Usa memoria eficientemente
 */
