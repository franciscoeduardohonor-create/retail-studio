/*
 * MÓDULO 4: PROGRAMACIÓN ORIENTADA A OBJETOS
 * Ejemplo 2: Herencia y Polimorfismo
 *
 * Aprenderás:
 * - Herencia de clases
 * - Constructores en herencia
 * - Sobrescritura de métodos
 * - Funciones virtuales
 * - Polimorfismo
 */

#include <iostream>
#include <string>
#include <vector>

// CLASE BASE (PADRE/SUPERCLASE)
class Animal {
protected:  // Accesible en clases derivadas
    std::string nombre;
    int edad;

public:
    Animal(std::string nom, int ed) : nombre(nom), edad(ed) {
        std::cout << "Constructor de Animal: " << nombre << std::endl;
    }

    // Función virtual: puede ser sobrescrita
    virtual void hacerSonido() {
        std::cout << nombre << " hace un sonido genérico" << std::endl;
    }

    virtual void moverse() {
        std::cout << nombre << " se mueve" << std::endl;
    }

    void dormir() {
        std::cout << nombre << " está durmiendo... Zzz" << std::endl;
    }

    // Función virtual pura = clase abstracta
    // virtual void comer() = 0;  // Descomenta para hacer Animal abstracto

    virtual ~Animal() {
        std::cout << "Destructor de Animal: " << nombre << std::endl;
    }
};

// CLASES DERIVADAS (HIJAS/SUBCLASES)
class Perro : public Animal {  // Hereda públicamente de Animal
private:
    std::string raza;

public:
    // Constructor: llama al constructor de la clase base
    Perro(std::string nom, int ed, std::string rz)
        : Animal(nom, ed), raza(rz) {  // Inicializa clase base
        std::cout << "Constructor de Perro: " << nombre << std::endl;
    }

    // Sobrescribir método de la clase base
    void hacerSonido() override {  // override es opcional pero recomendado
        std::cout << nombre << " dice: ¡Guau guau!" << std::endl;
    }

    void moverse() override {
        std::cout << nombre << " corre en cuatro patas" << std::endl;
    }

    // Método específico de Perro
    void traerPelota() {
        std::cout << nombre << " trae la pelota" << std::endl;
    }

    std::string getRaza() {
        return raza;
    }

    ~Perro() {
        std::cout << "Destructor de Perro: " << nombre << std::endl;
    }
};

class Gato : public Animal {
public:
    Gato(std::string nom, int ed) : Animal(nom, ed) {
        std::cout << "Constructor de Gato: " << nombre << std::endl;
    }

    void hacerSonido() override {
        std::cout << nombre << " dice: ¡Miau miau!" << std::endl;
    }

    void moverse() override {
        std::cout << nombre << " camina sigilosamente" << std::endl;
    }

    // Método específico de Gato
    void trepar() {
        std::cout << nombre << " trepa al árbol" << std::endl;
    }

    ~Gato() {
        std::cout << "Destructor de Gato: " << nombre << std::endl;
    }
};

class Pajaro : public Animal {
private:
    double envergadura;  // en metros

public:
    Pajaro(std::string nom, int ed, double env)
        : Animal(nom, ed), envergadura(env) {
        std::cout << "Constructor de Pajaro: " << nombre << std::endl;
    }

    void hacerSonido() override {
        std::cout << nombre << " dice: ¡Pío pío!" << std::endl;
    }

    void moverse() override {
        std::cout << nombre << " vuela con una envergadura de "
                  << envergadura << "m" << std::endl;
    }

    ~Pajaro() {
        std::cout << "Destructor de Pajaro: " << nombre << std::endl;
    }
};

// EJEMPLO CON FIGURAS GEOMÉTRICAS
class Figura {
protected:
    std::string nombre;

public:
    Figura(std::string nom) : nombre(nom) {}

    // Función virtual pura: hace que Figura sea abstracta
    virtual double calcularArea() = 0;
    virtual double calcularPerimetro() = 0;

    virtual void mostrarInfo() {
        std::cout << "Figura: " << nombre << std::endl;
        std::cout << "Área: " << calcularArea() << std::endl;
        std::cout << "Perímetro: " << calcularPerimetro() << std::endl;
    }

    virtual ~Figura() {}
};

class Circulo : public Figura {
private:
    double radio;

public:
    Circulo(double r) : Figura("Círculo"), radio(r) {}

    double calcularArea() override {
        return 3.14159 * radio * radio;
    }

    double calcularPerimetro() override {
        return 2 * 3.14159 * radio;
    }
};

class Rectangulo : public Figura {
private:
    double base, altura;

public:
    Rectangulo(double b, double h)
        : Figura("Rectángulo"), base(b), altura(h) {}

    double calcularArea() override {
        return base * altura;
    }

    double calcularPerimetro() override {
        return 2 * (base + altura);
    }
};

int main() {
    std::cout << "=== HERENCIA Y POLIMORFISMO ===" << std::endl << std::endl;

    // CREAR OBJETOS DE CLASES DERIVADAS
    std::cout << "--- CREACIÓN DE OBJETOS ---" << std::endl;
    Perro perro1("Max", 3, "Labrador");
    Gato gato1("Michi", 2);
    Pajaro pajaro1("Tweety", 1, 0.3);
    std::cout << std::endl;

    // USAR MÉTODOS HEREDADOS Y SOBRESCRITOS
    std::cout << "--- MÉTODOS SOBRESCRITOS ---" << std::endl;
    perro1.hacerSonido();  // Usa versión de Perro
    gato1.hacerSonido();   // Usa versión de Gato
    pajaro1.hacerSonido(); // Usa versión de Pajaro
    std::cout << std::endl;

    perro1.moverse();
    gato1.moverse();
    pajaro1.moverse();
    std::cout << std::endl;

    // MÉTODOS ESPECÍFICOS DE CADA CLASE
    std::cout << "--- MÉTODOS ESPECÍFICOS ---" << std::endl;
    perro1.traerPelota();  // Solo Perro tiene este método
    gato1.trepar();        // Solo Gato tiene este método
    std::cout << std::endl;

    // MÉTODOS HEREDADOS NO SOBRESCRITOS
    std::cout << "--- MÉTODOS HEREDADOS ---" << std::endl;
    perro1.dormir();  // Usa versión de Animal
    gato1.dormir();   // Usa versión de Animal
    std::cout << std::endl;

    // POLIMORFISMO CON PUNTEROS
    std::cout << "--- POLIMORFISMO ---" << std::endl;

    // Puntero de tipo base apunta a objetos derivados
    Animal* ptrAnimal;

    ptrAnimal = &perro1;
    ptrAnimal->hacerSonido();  // Llama a la versión de Perro

    ptrAnimal = &gato1;
    ptrAnimal->hacerSonido();  // Llama a la versión de Gato

    ptrAnimal = &pajaro1;
    ptrAnimal->hacerSonido();  // Llama a la versión de Pajaro
    std::cout << std::endl;

    // ARREGLO POLIMÓRFICO
    std::cout << "--- ARREGLO POLIMÓRFICO ---" << std::endl;

    // Vector de punteros a Animal (polimorfismo)
    std::vector<Animal*> animales;
    animales.push_back(&perro1);
    animales.push_back(&gato1);
    animales.push_back(&pajaro1);

    std::cout << "Todos los animales hacen sonido:" << std::endl;
    for (Animal* animal : animales) {
        animal->hacerSonido();  // Polimorfismo en acción
    }
    std::cout << std::endl;

    std::cout << "Todos los animales se mueven:" << std::endl;
    for (Animal* animal : animales) {
        animal->moverse();
    }
    std::cout << std::endl;

    // CLASES ABSTRACTAS
    std::cout << "--- CLASES ABSTRACTAS (FIGURAS) ---" << std::endl;

    // No puedes crear: Figura f;  // ERROR: clase abstracta
    // Pero sí punteros:
    Figura* figura1 = new Circulo(5.0);
    Figura* figura2 = new Rectangulo(4.0, 6.0);

    figura1->mostrarInfo();
    std::cout << std::endl;
    figura2->mostrarInfo();

    delete figura1;
    delete figura2;

    std::cout << std::endl << "--- FIN ---" << std::endl;

    return 0;
}

/*
 * CÓMO COMPILAR Y EJECUTAR:
 * g++ 02_herencia_polimorfismo.cpp -o herencia
 * ./herencia
 *
 * CONCEPTOS IMPORTANTES:
 *
 * 1. HERENCIA:
 *    - Permite crear clases basadas en otras
 *    - Reutilización de código
 *    - Relación "es-un" (Perro ES-UN Animal)
 *
 *    Sintaxis:
 *    class Derivada : public Base { ... };
 *
 * 2. TIPOS DE HERENCIA:
 *
 *    PUBLIC:
 *    - Miembros públicos de Base siguen siendo públicos
 *    - Miembros protected de Base siguen siendo protected
 *
 *    PROTECTED:
 *    - Miembros públicos de Base se vuelven protected
 *
 *    PRIVATE:
 *    - Todos los miembros de Base se vuelven private
 *
 * 3. PROTECTED:
 *    - Accesible en la clase y clases derivadas
 *    - No accesible desde fuera
 *    - Útil para atributos que las derivadas necesitan
 *
 * 4. CONSTRUCTORES EN HERENCIA:
 *
 *    class Derivada : public Base {
 *    public:
 *        Derivada(params) : Base(params_base) {
 *            // Constructor de Derivada
 *        }
 *    };
 *
 *    Orden de ejecución:
 *    1. Constructor de Base
 *    2. Constructor de Derivada
 *
 *    Orden de destrucción:
 *    1. Destructor de Derivada
 *    2. Destructor de Base
 *
 * 5. VIRTUAL:
 *    - Permite sobrescritura de métodos
 *    - Habilita el polimorfismo
 *    - virtual en la clase base
 *    - override en la clase derivada (opcional pero recomendado)
 *
 * 6. POLIMORFISMO:
 *    - "Muchas formas"
 *    - Mismo método, diferente comportamiento
 *    - Requiere herencia y funciones virtuales
 *
 *    Animal* ptr = new Perro("Max", 3, "Labrador");
 *    ptr->hacerSonido();  // Llama a la versión de Perro
 *
 * 7. FUNCIONES VIRTUALES PURAS:
 *
 *    virtual void metodo() = 0;
 *
 *    - Hace que la clase sea abstracta
 *    - No se puede instanciar la clase base
 *    - Las derivadas DEBEN implementar el método
 *    - Útil para interfaces
 *
 * 8. CLASE ABSTRACTA:
 *    - Tiene al menos una función virtual pura
 *    - No se puede crear objetos de ella
 *    - Solo sirve como clase base
 *    - Define una interfaz que las derivadas deben cumplir
 *
 * 9. OVERRIDE (C++11):
 *    - Palabra clave opcional
 *    - Indica explícitamente que sobrescribes un método virtual
 *    - El compilador verifica que exista en la base
 *    - Previene errores
 *
 * VENTAJAS DE LA HERENCIA:
 * ✓ Reutilización de código
 * ✓ Organización jerárquica
 * ✓ Polimorfismo
 * ✓ Extensibilidad
 *
 * CUÁNDO USAR HERENCIA:
 * ✓ Relación "es-un" verdadera
 * ✓ Comportamiento compartido
 * ✓ Especialización de una clase general
 *
 * CUÁNDO NO USAR HERENCIA:
 * ✗ Relación "tiene-un" (usa composición)
 * ✗ Solo para reutilizar código (usa composición)
 * ✗ Jerarquías muy profundas (máximo 3-4 niveles)
 *
 * BUENAS PRÁCTICAS:
 * ✓ Usa override para claridad
 * ✓ Destructores virtuales en clases base
 * ✓ Prefiere composición sobre herencia cuando sea apropiado
 * ✓ Funciones virtuales puras para interfaces
 * ✓ Protected para lo que derivadas necesitan, private para lo demás
 */
