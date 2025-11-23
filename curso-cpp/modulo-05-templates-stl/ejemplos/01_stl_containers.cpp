/*
 * MÓDULO 5: TEMPLATES Y STL
 * Ejemplo 1: Contenedores de la STL
 *
 * Aprenderás:
 * - std::vector (arreglo dinámico)
 * - std::string (cadenas)
 * - std::map (diccionarios)
 * - std::set (conjuntos)
 * - Iteradores
 */

#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <set>
#include <algorithm>

int main() {
    std::cout << "=== CONTENEDORES DE LA STL ===" << std::endl << std::endl;

    // VECTOR: Arreglo dinámico
    std::cout << "--- STD::VECTOR ---" << std::endl;

    std::vector<int> numeros;  // Vector vacío

    // Agregar elementos
    numeros.push_back(10);
    numeros.push_back(20);
    numeros.push_back(30);
    numeros.push_back(40);

    std::cout << "Tamaño: " << numeros.size() << std::endl;
    std::cout << "Elementos: ";
    for (int num : numeros) {
        std::cout << num << " ";
    }
    std::cout << std::endl;

    // Acceso por índice
    std::cout << "Primer elemento: " << numeros[0] << std::endl;
    std::cout << "Último elemento: " << numeros.back() << std::endl;

    // Modificar
    numeros[1] = 25;
    std::cout << "Después de modificar: ";
    for (int num : numeros) {
        std::cout << num << " ";
    }
    std::cout << std::endl;

    // Eliminar último elemento
    numeros.pop_back();
    std::cout << "Después de pop_back: tamaño = " << numeros.size() << std::endl;

    // Vector con tamaño inicial
    std::vector<double> calificaciones(5, 0.0);  // 5 elementos, todos en 0.0
    calificaciones[0] = 8.5;
    calificaciones[1] = 9.0;
    calificaciones[2] = 7.5;
    calificaciones[3] = 9.5;
    calificaciones[4] = 8.0;

    // Calcular promedio
    double suma = 0;
    for (double cal : calificaciones) {
        suma += cal;
    }
    std::cout << "Promedio: " << suma / calificaciones.size() << std::endl;
    std::cout << std::endl;

    // MAP: Diccionario (clave-valor)
    std::cout << "--- STD::MAP ---" << std::endl;

    std::map<std::string, int> edades;

    // Insertar elementos
    edades["Francisco"] = 25;
    edades["María"] = 30;
    edades["Carlos"] = 28;
    edades["Ana"] = 22;

    // Acceder a valores
    std::cout << "Edad de Francisco: " << edades["Francisco"] << std::endl;

    // Verificar si existe una clave
    if (edades.find("Pedro") == edades.end()) {
        std::cout << "Pedro no está en el mapa" << std::endl;
    }

    // Recorrer map
    std::cout << "Todas las edades:" << std::endl;
    for (auto par : edades) {  // par es std::pair<string, int>
        std::cout << par.first << ": " << par.second << " años" << std::endl;
    }

    // Tamaño
    std::cout << "Total de personas: " << edades.size() << std::endl;
    std::cout << std::endl;

    // MAP con tipos diferentes
    std::map<int, std::string> productos;
    productos[101] = "Laptop";
    productos[102] = "Mouse";
    productos[103] = "Teclado";

    std::cout << "Producto 102: " << productos[102] << std::endl;
    std::cout << std::endl;

    // SET: Conjunto (sin duplicados, ordenado)
    std::cout << "--- STD::SET ---" << std::endl;

    std::set<int> conjunto;

    // Insertar elementos
    conjunto.insert(5);
    conjunto.insert(2);
    conjunto.insert(8);
    conjunto.insert(2);  // Duplicado, no se insertará
    conjunto.insert(1);

    std::cout << "Elementos del set (ordenados): ";
    for (int elem : conjunto) {
        std::cout << elem << " ";
    }
    std::cout << std::endl;

    // Verificar si existe
    if (conjunto.find(8) != conjunto.end()) {
        std::cout << "8 está en el conjunto" << std::endl;
    }

    // Eliminar elemento
    conjunto.erase(2);
    std::cout << "Después de eliminar 2: ";
    for (int elem : conjunto) {
        std::cout << elem << " ";
    }
    std::cout << std::endl << std::endl;

    // ALGORITMOS STL
    std::cout << "--- ALGORITMOS STL ---" << std::endl;

    std::vector<int> nums = {5, 2, 8, 1, 9, 3};

    std::cout << "Original: ";
    for (int n : nums) std::cout << n << " ";
    std::cout << std::endl;

    // Ordenar
    std::sort(nums.begin(), nums.end());
    std::cout << "Ordenado: ";
    for (int n : nums) std::cout << n << " ";
    std::cout << std::endl;

    // Ordenar descendente
    std::sort(nums.begin(), nums.end(), std::greater<int>());
    std::cout << "Descendente: ";
    for (int n : nums) std::cout << n << " ";
    std::cout << std::endl;

    // Encontrar elemento
    auto it = std::find(nums.begin(), nums.end(), 8);
    if (it != nums.end()) {
        std::cout << "Encontrado 8 en posición: " << (it - nums.begin()) << std::endl;
    }

    // Máximo y mínimo
    auto max_it = std::max_element(nums.begin(), nums.end());
    auto min_it = std::min_element(nums.begin(), nums.end());
    std::cout << "Máximo: " << *max_it << std::endl;
    std::cout << "Mínimo: " << *min_it << std::endl;
    std::cout << std::endl;

    // EJEMPLO PRÁCTICO: SISTEMA DE NOTAS
    std::cout << "--- SISTEMA DE NOTAS ---" << std::endl;

    std::map<std::string, std::vector<double>> estudiantes;

    // Agregar estudiantes con sus calificaciones
    estudiantes["Juan"] = {8.5, 9.0, 7.5};
    estudiantes["María"] = {9.5, 9.0, 10.0};
    estudiantes["Pedro"] = {7.0, 8.0, 7.5};

    // Calcular y mostrar promedios
    for (auto &estudiante : estudiantes) {
        std::string nombre = estudiante.first;
        std::vector<double> notas = estudiante.second;

        double suma = 0;
        for (double nota : notas) {
            suma += nota;
        }
        double promedio = suma / notas.size();

        std::cout << nombre << ": ";
        for (double nota : notas) {
            std::cout << nota << " ";
        }
        std::cout << "=> Promedio: " << promedio << std::endl;
    }

    return 0;
}

/*
 * CÓMO COMPILAR Y EJECUTAR:
 * g++ 01_stl_containers.cpp -o stl
 * ./stl
 *
 * CONTENEDORES STL:
 *
 * 1. VECTOR:
 *    - Arreglo dinámico
 *    - Acceso rápido por índice O(1)
 *    - Inserción/eliminación al final O(1)
 *    - Inserción/eliminación en medio O(n)
 *    - Redimensionable automáticamente
 *
 * 2. MAP:
 *    - Diccionario clave-valor
 *    - Claves únicas y ordenadas
 *    - Búsqueda rápida O(log n)
 *    - Implementado como árbol rojo-negro
 *
 * 3. SET:
 *    - Conjunto de elementos únicos
 *    - Elementos ordenados
 *    - Búsqueda rápida O(log n)
 *    - No permite duplicados
 *
 * OTROS CONTENEDORES:
 * - list: Lista doblemente enlazada
 * - deque: Cola de doble extremo
 * - stack: Pila (LIFO)
 * - queue: Cola (FIFO)
 * - unordered_map: Hash map (más rápido que map)
 * - unordered_set: Hash set
 *
 * VENTAJAS DE LA STL:
 * ✓ Probada y optimizada
 * ✓ Manejo automático de memoria
 * ✓ Código más limpio
 * ✓ Menos propenso a errores
 * ✓ Portátil
 */
