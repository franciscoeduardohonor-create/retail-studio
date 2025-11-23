/*
 * MÓDULO 4: PROGRAMACIÓN ORIENTADA A OBJETOS
 * Ejemplo 1: Clases y Objetos
 *
 * Aprenderás:
 * - Qué son clases y objetos
 * - Atributos y métodos
 * - Constructores y destructores
 * - Encapsulamiento (public, private, protected)
 * - Getters y setters
 */

#include <iostream>
#include <string>

// DEFINICIÓN DE UNA CLASE
class Persona {
// SECCIÓN PRIVADA: Solo accesible dentro de la clase
private:
    std::string nombre;
    int edad;
    double altura;  // en metros

// SECCIÓN PÚBLICA: Accesible desde cualquier parte
public:
    // CONSTRUCTOR: Se ejecuta al crear un objeto
    Persona() {
        nombre = "Sin nombre";
        edad = 0;
        altura = 0.0;
        std::cout << "Constructor por defecto llamado" << std::endl;
    }

    // CONSTRUCTOR CON PARÁMETROS (sobrecarga)
    Persona(std::string nom, int ed, double alt) {
        nombre = nom;
        edad = ed;
        altura = alt;
        std::cout << "Constructor parametrizado llamado para " << nombre << std::endl;
    }

    // DESTRUCTOR: Se ejecuta al destruir el objeto
    ~Persona() {
        std::cout << "Destructor llamado para " << nombre << std::endl;
    }

    // MÉTODOS (funciones miembro)
    void presentarse() {
        std::cout << "Hola, soy " << nombre << ", tengo " << edad
                  << " años y mido " << altura << "m" << std::endl;
    }

    void cumplirAnios() {
        edad++;
        std::cout << nombre << " ahora tiene " << edad << " años. ¡Felicidades!" << std::endl;
    }

    bool esMayorDeEdad() {
        return edad >= 18;
    }

    // GETTERS (obtener valores)
    std::string getNombre() {
        return nombre;
    }

    int getEdad() {
        return edad;
    }

    double getAltura() {
        return altura;
    }

    // SETTERS (establecer valores con validación)
    void setNombre(std::string nom) {
        if (nom.length() > 0) {
            nombre = nom;
        }
    }

    void setEdad(int ed) {
        if (ed >= 0 && ed <= 150) {
            edad = ed;
        } else {
            std::cout << "Edad inválida" << std::endl;
        }
    }

    void setAltura(double alt) {
        if (alt > 0 && alt < 3.0) {
            altura = alt;
        } else {
            std::cout << "Altura inválida" << std::endl;
        }
    }
};

// CLASE CON MÉTODOS ESTÁTICOS
class Matematica {
public:
    // Método estático: se puede llamar sin crear un objeto
    static int sumar(int a, int b) {
        return a + b;
    }

    static double calcularCircunferencia(double radio) {
        return 2 * 3.14159 * radio;
    }

    // Atributo estático: compartido por todos los objetos
    static int contadorOperaciones;

    static void incrementarOperaciones() {
        contadorOperaciones++;
    }
};

// Inicializar variable estática (fuera de la clase)
int Matematica::contadorOperaciones = 0;

// CLASE CUENTA BANCARIA (ejemplo más completo)
class CuentaBancaria {
private:
    std::string titular;
    long numeroCuenta;
    double saldo;

public:
    // Constructor
    CuentaBancaria(std::string tit, long num, double saldoInicial = 0.0) {
        titular = tit;
        numeroCuenta = num;
        saldo = saldoInicial;
    }

    // Depositar dinero
    void depositar(double cantidad) {
        if (cantidad > 0) {
            saldo += cantidad;
            std::cout << "Depósito exitoso. Nuevo saldo: $" << saldo << std::endl;
        } else {
            std::cout << "Cantidad inválida" << std::endl;
        }
    }

    // Retirar dinero
    bool retirar(double cantidad) {
        if (cantidad <= 0) {
            std::cout << "Cantidad inválida" << std::endl;
            return false;
        }

        if (cantidad > saldo) {
            std::cout << "Saldo insuficiente" << std::endl;
            return false;
        }

        saldo -= cantidad;
        std::cout << "Retiro exitoso. Nuevo saldo: $" << saldo << std::endl;
        return true;
    }

    // Consultar saldo
    void consultarSaldo() {
        std::cout << "Cuenta: " << numeroCuenta << std::endl;
        std::cout << "Titular: " << titular << std::endl;
        std::cout << "Saldo: $" << saldo << std::endl;
    }

    // Transferir a otra cuenta
    bool transferir(CuentaBancaria &destino, double cantidad) {
        if (retirar(cantidad)) {
            destino.depositar(cantidad);
            return true;
        }
        return false;
    }
};

int main() {
    std::cout << "=== PROGRAMACIÓN ORIENTADA A OBJETOS ===" << std::endl << std::endl;

    // CREAR OBJETOS
    std::cout << "--- CREAR OBJETOS ---" << std::endl;

    Persona persona1;  // Usa constructor por defecto
    persona1.presentarse();
    std::cout << std::endl;

    Persona persona2("Francisco", 25, 1.75);  // Usa constructor parametrizado
    persona2.presentarse();
    std::cout << std::endl;

    // USAR MÉTODOS
    std::cout << "--- USAR MÉTODOS ---" << std::endl;

    persona2.cumplirAnios();

    if (persona2.esMayorDeEdad()) {
        std::cout << persona2.getNombre() << " es mayor de edad" << std::endl;
    }
    std::cout << std::endl;

    // GETTERS Y SETTERS
    std::cout << "--- GETTERS Y SETTERS ---" << std::endl;

    std::cout << "Nombre actual: " << persona2.getNombre() << std::endl;
    persona2.setNombre("Francisco Hernández");
    std::cout << "Nombre actualizado: " << persona2.getNombre() << std::endl;

    persona2.setEdad(200);  // Inválido
    persona2.setEdad(30);   // Válido
    std::cout << "Edad: " << persona2.getEdad() << std::endl;
    std::cout << std::endl;

    // MÉTODOS ESTÁTICOS
    std::cout << "--- MÉTODOS ESTÁTICOS ---" << std::endl;

    // No necesitas crear un objeto
    int resultado = Matematica::sumar(5, 3);
    std::cout << "5 + 3 = " << resultado << std::endl;

    double circ = Matematica::calcularCircunferencia(5.0);
    std::cout << "Circunferencia (r=5): " << circ << std::endl;

    Matematica::incrementarOperaciones();
    Matematica::incrementarOperaciones();
    std::cout << "Operaciones realizadas: " << Matematica::contadorOperaciones << std::endl;
    std::cout << std::endl;

    // EJEMPLO PRÁCTICO: CUENTA BANCARIA
    std::cout << "--- SISTEMA BANCARIO ---" << std::endl;

    CuentaBancaria cuenta1("Juan Pérez", 123456, 1000.0);
    CuentaBancaria cuenta2("María García", 789012, 500.0);

    std::cout << "Estado inicial:" << std::endl;
    cuenta1.consultarSaldo();
    std::cout << std::endl;
    cuenta2.consultarSaldo();
    std::cout << std::endl;

    // Operaciones
    cuenta1.depositar(500.0);
    cuenta1.retirar(200.0);
    cuenta1.retirar(2000.0);  // Debe fallar

    std::cout << std::endl;
    std::cout << "Transferencia de cuenta1 a cuenta2:" << std::endl;
    cuenta1.transferir(cuenta2, 300.0);

    std::cout << std::endl << "Estado final:" << std::endl;
    cuenta1.consultarSaldo();
    std::cout << std::endl;
    cuenta2.consultarSaldo();

    std::cout << std::endl;
    std::cout << "--- FIN DEL PROGRAMA ---" << std::endl;
    std::cout << "Los destructores se llamarán automáticamente:" << std::endl;

    return 0;
}

/*
 * CÓMO COMPILAR Y EJECUTAR:
 * g++ 01_clases_objetos.cpp -o clases
 * ./clases
 *
 * CONCEPTOS FUNDAMENTALES:
 *
 * 1. CLASE vs OBJETO:
 *    - CLASE: Plantilla o molde (blueprint)
 *    - OBJETO: Instancia específica de una clase
 *
 *    Analogía:
 *    - Clase = plano de una casa
 *    - Objeto = casa construida usando ese plano
 *
 * 2. ATRIBUTOS (DATOS MIEMBRO):
 *    - Variables que pertenecen a la clase
 *    - Definen el ESTADO del objeto
 *    - Ejemplo: nombre, edad, saldo
 *
 * 3. MÉTODOS (FUNCIONES MIEMBRO):
 *    - Funciones que pertenecen a la clase
 *    - Definen el COMPORTAMIENTO del objeto
 *    - Ejemplo: presentarse(), depositar(), retirar()
 *
 * 4. CONSTRUCTORES:
 *    - Método especial que se ejecuta al crear un objeto
 *    - Mismo nombre que la clase
 *    - No tiene tipo de retorno
 *    - Puede haber múltiples (sobrecarga)
 *    - Inicializa los atributos
 *
 * 5. DESTRUCTORES:
 *    - Método especial que se ejecuta al destruir un objeto
 *    - Nombre: ~NombreClase()
 *    - Se llama automáticamente
 *    - Usado para liberar recursos
 *
 * 6. ENCAPSULAMIENTO:
 *
 *    PUBLIC:
 *    - Accesible desde cualquier parte
 *    - Métodos de interfaz pública
 *
 *    PRIVATE:
 *    - Solo accesible desde dentro de la clase
 *    - Protege los datos
 *    - Regla: atributos generalmente privados
 *
 *    PROTECTED:
 *    - Accesible en la clase y clases derivadas
 *    - Se verá en herencia
 *
 * 7. GETTERS Y SETTERS:
 *    - GETTER: Obtiene el valor de un atributo privado
 *    - SETTER: Establece el valor con validación
 *
 *    Ventajas:
 *    ✓ Control sobre cómo se accede a los datos
 *    ✓ Validación al establecer valores
 *    ✓ Posibilidad de cambiar implementación interna
 *
 * 8. MÉTODOS Y ATRIBUTOS ESTÁTICOS:
 *    - Pertenecen a la CLASE, no a los objetos
 *    - Se acceden con NombreClase::metodo()
 *    - Compartidos por todas las instancias
 *    - No pueden acceder a miembros no estáticos
 *
 * PRINCIPIOS DE POO:
 *
 * 1. ENCAPSULAMIENTO:
 *    - Ocultar detalles de implementación
 *    - Datos privados, métodos públicos
 *
 * 2. ABSTRACCIÓN:
 *    - Mostrar solo lo esencial
 *    - Ocultar complejidad
 *
 * 3. HERENCIA: (próximo ejemplo)
 *    - Crear clases basadas en otras
 *
 * 4. POLIMORFISMO: (próximo ejemplo)
 *    - Múltiples formas de un método
 *
 * BUENAS PRÁCTICAS:
 * ✓ Atributos privados, métodos públicos
 * ✓ Usa getters/setters con validación
 * ✓ Constructores deben inicializar todos los atributos
 * ✓ Usa const para métodos que no modifican el objeto
 * ✓ Una clase = una responsabilidad
 * ✓ Nombres de clases en PascalCase
 * ✓ Nombres de métodos en camelCase
 */
