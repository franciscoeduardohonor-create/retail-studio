/*
 * MÓDULO 1: FUNDAMENTOS BÁSICOS
 * Ejemplo 2: Variables y Tipos de Datos
 *
 * Aprenderás:
 * - Tipos de datos básicos en C++
 * - Cómo declarar e inicializar variables
 * - Mostrar valores de variables
 */

#include <iostream>
#include <string>  // Para usar el tipo string

int main() {
    std::cout << "=== TIPOS DE DATOS EN C++ ===" << std::endl << std::endl;

    // ENTEROS (números sin decimales)
    int edad = 25;                    // Entero estándar (generalmente 4 bytes)
    short temperatura = -5;           // Entero corto (2 bytes)
    long poblacion = 8000000000;      // Entero largo (4 u 8 bytes)
    long long distancia = 9460730472580800;  // Entero muy largo (8 bytes)

    std::cout << "--- ENTEROS ---" << std::endl;
    std::cout << "Edad: " << edad << " años" << std::endl;
    std::cout << "Temperatura: " << temperatura << "°C" << std::endl;
    std::cout << "Población mundial: " << poblacion << std::endl;
    std::cout << "Distancia (año luz en km): " << distancia << std::endl << std::endl;

    // NÚMEROS DECIMALES (punto flotante)
    float precio = 19.99f;            // Precisión simple (4 bytes) - nota la 'f'
    double pi = 3.141592653589793;    // Precisión doble (8 bytes)

    std::cout << "--- DECIMALES ---" << std::endl;
    std::cout << "Precio: $" << precio << std::endl;
    std::cout << "Valor de PI: " << pi << std::endl << std::endl;

    // CARACTERES
    char inicial = 'F';               // Un solo caracter (1 byte)
    char letra = 65;                  // También puedes usar código ASCII

    std::cout << "--- CARACTERES ---" << std::endl;
    std::cout << "Inicial: " << inicial << std::endl;
    std::cout << "Letra (código 65): " << letra << std::endl << std::endl;

    // BOOLEANOS (verdadero o falso)
    bool esMayorDeEdad = true;
    bool estaDormido = false;

    std::cout << "--- BOOLEANOS ---" << std::endl;
    std::cout << "¿Es mayor de edad?: " << esMayorDeEdad << std::endl;  // 1 = true
    std::cout << "¿Está dormido?: " << estaDormido << std::endl;        // 0 = false

    // Para mostrar true/false en lugar de 1/0:
    std::cout << std::boolalpha;  // Activa formato booleano
    std::cout << "¿Es mayor de edad?: " << esMayorDeEdad << std::endl;
    std::cout << std::endl;

    // CADENAS DE TEXTO (strings)
    std::string nombre = "Francisco";
    std::string apellido = "Hernández";
    std::string nombreCompleto = nombre + " " + apellido;  // Concatenación

    std::cout << "--- CADENAS DE TEXTO ---" << std::endl;
    std::cout << "Nombre completo: " << nombreCompleto << std::endl;
    std::cout << "Longitud del nombre: " << nombreCompleto.length() << " caracteres" << std::endl << std::endl;

    // CONSTANTES (valores que no cambian)
    const double GRAVEDAD = 9.81;     // Por convención, constantes en MAYÚSCULAS
    const int DIAS_SEMANA = 7;

    std::cout << "--- CONSTANTES ---" << std::endl;
    std::cout << "Gravedad: " << GRAVEDAD << " m/s²" << std::endl;
    std::cout << "Días de la semana: " << DIAS_SEMANA << std::endl << std::endl;

    // TAMAÑO DE LOS TIPOS DE DATOS
    std::cout << "--- TAMAÑO EN MEMORIA ---" << std::endl;
    std::cout << "int: " << sizeof(int) << " bytes" << std::endl;
    std::cout << "float: " << sizeof(float) << " bytes" << std::endl;
    std::cout << "double: " << sizeof(double) << " bytes" << std::endl;
    std::cout << "char: " << sizeof(char) << " byte" << std::endl;
    std::cout << "bool: " << sizeof(bool) << " byte" << std::endl;

    return 0;
}

/*
 * CÓMO COMPILAR Y EJECUTAR:
 * g++ 02_variables_tipos.cpp -o variables
 * ./variables
 *
 * NOTAS IMPORTANTES:
 * - Siempre inicializa las variables cuando las declares
 * - Usa 'f' después de números flotantes (19.99f)
 * - Los nombres de variables no pueden empezar con números
 * - C++ es case-sensitive (edad != Edad)
 */
