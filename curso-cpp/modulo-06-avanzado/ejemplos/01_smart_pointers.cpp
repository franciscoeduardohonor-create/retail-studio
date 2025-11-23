/*
 * MÓDULO 6: TEMAS AVANZADOS
 * Ejemplo 1: Smart Pointers (C++11)
 *
 * Aprenderás:
 * - unique_ptr
 * - shared_ptr
 * - weak_ptr
 * - Ventajas sobre punteros raw
 * - RAII (Resource Acquisition Is Initialization)
 */

#include <iostream>
#include <memory>  // Para smart pointers
#include <string>
#include <vector>

class Recurso {
private:
    std::string nombre;

public:
    Recurso(std::string nom) : nombre(nom) {
        std::cout << "Recurso '" << nombre << "' creado" << std::endl;
    }

    ~Recurso() {
        std::cout << "Recurso '" << nombre << "' destruido" << std::endl;
    }

    void usar() {
        std::cout << "Usando recurso: " << nombre << std::endl;
    }

    std::string getNombre() {
        return nombre;
    }
};

int main() {
    std::cout << "=== SMART POINTERS ===" << std::endl << std::endl;

    // UNIQUE_PTR: Propiedad exclusiva
    std::cout << "--- UNIQUE_PTR ---" << std::endl;
    {
        // Crear unique_ptr (forma moderna C++14)
        auto ptr1 = std::make_unique<Recurso>("Recurso1");
        ptr1->usar();

        // No se puede copiar
        // auto ptr2 = ptr1;  // ERROR: unique_ptr no se puede copiar

        // Pero se puede mover
        auto ptr2 = std::move(ptr1);
        // Ahora ptr1 es nullptr y ptr2 tiene la propiedad

        if (ptr1 == nullptr) {
            std::cout << "ptr1 es nullptr después del move" << std::endl;
        }

        ptr2->usar();

        // Se destruye automáticamente al salir del scope
        std::cout << "Fin del scope de unique_ptr" << std::endl;
    }
    std::cout << "Recurso liberado automáticamente" << std::endl << std::endl;

    // SHARED_PTR: Propiedad compartida
    std::cout << "--- SHARED_PTR ---" << std::endl;
    {
        // Crear shared_ptr
        auto sptr1 = std::make_shared<Recurso>("RecursoCompartido");

        std::cout << "Conteo de referencias: " << sptr1.use_count() << std::endl;

        {
            // Compartir propiedad
            auto sptr2 = sptr1;  // Se puede copiar
            std::cout << "Conteo después de copiar: " << sptr1.use_count() << std::endl;

            auto sptr3 = sptr1;
            std::cout << "Conteo con 3 punteros: " << sptr1.use_count() << std::endl;

            sptr2->usar();
            sptr3->usar();

            std::cout << "Fin del scope interno" << std::endl;
        }

        std::cout << "Conteo después del scope: " << sptr1.use_count() << std::endl;
        std::cout << "Fin del scope externo" << std::endl;
    }
    std::cout << "Recurso liberado cuando el último shared_ptr salió del scope" << std::endl << std::endl;

    // WEAK_PTR: Observador sin propiedad
    std::cout << "--- WEAK_PTR ---" << std::endl;
    {
        std::weak_ptr<Recurso> wptr;

        {
            auto sptr = std::make_shared<Recurso>("RecursoObservado");
            wptr = sptr;  // weak_ptr no incrementa el contador

            std::cout << "Conteo de shared_ptr: " << sptr.use_count() << std::endl;

            // Para usar weak_ptr, convertir a shared_ptr
            if (auto temp = wptr.lock()) {
                temp->usar();
            }

            std::cout << "Fin del scope de shared_ptr" << std::endl;
        }

        // El recurso ya fue destruido
        if (wptr.expired()) {
            std::cout << "El recurso ya no existe (weak_ptr expirado)" << std::endl;
        }
    }
    std::cout << std::endl;

    // COMPARACIÓN: RAW POINTER vs UNIQUE_PTR
    std::cout << "--- COMPARACIÓN ---" << std::endl;

    std::cout << "Con raw pointer:" << std::endl;
    {
        Recurso* raw = new Recurso("Raw");
        raw->usar();
        delete raw;  // Debes recordar liberar
    }
    std::cout << std::endl;

    std::cout << "Con unique_ptr:" << std::endl;
    {
        auto smart = std::make_unique<Recurso>("Smart");
        smart->usar();
        // Se libera automáticamente
    }
    std::cout << std::endl;

    // SMART POINTERS EN CONTENEDORES
    std::cout << "--- SMART POINTERS EN VECTORES ---" << std::endl;
    {
        std::vector<std::unique_ptr<Recurso>> recursos;

        recursos.push_back(std::make_unique<Recurso>("R1"));
        recursos.push_back(std::make_unique<Recurso>("R2"));
        recursos.push_back(std::make_unique<Recurso>("R3"));

        std::cout << "Usando recursos en el vector:" << std::endl;
        for (auto& r : recursos) {
            r->usar();
        }

        std::cout << "Fin del scope - todos se liberan automáticamente" << std::endl;
    }
    std::cout << std::endl;

    // EJEMPLO PRÁCTICO: Prevenir memory leaks con excepciones
    std::cout << "--- PREVENCIÓN DE MEMORY LEAKS ---" << std::endl;

    std::cout << "Con raw pointer (puede causar leak si hay excepción):" << std::endl;
    try {
        Recurso* r = new Recurso("Peligroso");
        // Si aquí lanza una excepción, r nunca se libera
        // throw std::runtime_error("Error!");
        delete r;
    } catch (...) {
        std::cout << "Excepción capturada - posible memory leak" << std::endl;
    }
    std::cout << std::endl;

    std::cout << "Con unique_ptr (seguro ante excepciones):" << std::endl;
    try {
        auto r = std::make_unique<Recurso>("Seguro");
        // Aunque lance excepción, el destructor se llama automáticamente
        // throw std::runtime_error("Error!");
    } catch (...) {
        std::cout << "Excepción capturada - no hay memory leak" << std::endl;
    }

    return 0;
}

/*
 * CÓMO COMPILAR Y EJECUTAR:
 * g++ 01_smart_pointers.cpp -std=c++14 -o smart
 * ./smart
 *
 * SMART POINTERS:
 *
 * 1. UNIQUE_PTR:
 *    - Propiedad exclusiva (un solo dueño)
 *    - No se puede copiar, solo mover
 *    - Overhead casi cero
 *    - Usa make_unique (C++14)
 *
 *    Cuándo usar:
 *    ✓ Propiedad clara y única
 *    ✓ Reemplazo directo de new/delete
 *    ✓ Por defecto para memoria dinámica
 *
 * 2. SHARED_PTR:
 *    - Propiedad compartida (múltiples dueños)
 *    - Usa conteo de referencias
 *    - Un poco más overhead que unique_ptr
 *    - Se destruye cuando el último shared_ptr muere
 *
 *    Cuándo usar:
 *    ✓ Múltiples propietarios
 *    ✓ Ciclo de vida complejo
 *    ✓ Cachés y recursos compartidos
 *
 * 3. WEAK_PTR:
 *    - Observador sin propiedad
 *    - No incrementa contador de referencias
 *    - Previene ciclos en shared_ptr
 *    - Debe convertirse a shared_ptr para usar
 *
 *    Cuándo usar:
 *    ✓ Romper ciclos de shared_ptr
 *    ✓ Cachés que no deben mantener objetos vivos
 *    ✓ Observer pattern
 *
 * VENTAJAS DE SMART POINTERS:
 * ✓ No memory leaks
 * ✓ Exception safe (RAII)
 * ✓ Claridad de propiedad
 * ✓ Menos código
 * ✓ Más seguro
 *
 * RAII (Resource Acquisition Is Initialization):
 * - Adquirir recurso = inicializar objeto
 * - Liberar recurso = destruir objeto
 * - Garantiza liberación correcta
 * - Funciona con excepciones
 *
 * REGLAS:
 * 1. Prefiere unique_ptr por defecto
 * 2. Usa shared_ptr solo si necesitas propiedad compartida
 * 3. Usa weak_ptr para romper ciclos
 * 4. Evita raw pointers para ownership
 * 5. Usa make_unique y make_shared
 *
 * ANTI-PATRONES (NO HACER):
 * ✗ delete en shared_ptr
 * ✗ Mezclar raw y smart pointers para ownership
 * ✗ shared_ptr cuando unique_ptr es suficiente
 * ✗ Crear shared_ptr con new directamente
 *
 * MIGRACIÓN DE CÓDIGO LEGACY:
 * new T()          =>  make_unique<T>()
 * delete ptr       =>  (automático)
 * T* ptr           =>  unique_ptr<T> ptr
 */
