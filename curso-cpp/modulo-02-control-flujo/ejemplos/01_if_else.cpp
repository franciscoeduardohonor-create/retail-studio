/*
 * MÓDULO 2: CONTROL DE FLUJO
 * Ejemplo 1: Estructuras Condicionales (if, else, else if)
 *
 * Aprenderás:
 * - Cómo tomar decisiones en tu programa
 * - Usar if, else, else if
 * - Anidar condicionales
 * - Operador ternario
 */

#include <iostream>
#include <string>

int main() {
    std::cout << "=== ESTRUCTURAS CONDICIONALES ===" << std::endl << std::endl;

    // IF SIMPLE
    std::cout << "--- IF SIMPLE ---" << std::endl;
    int edad = 18;

    if (edad >= 18) {
        std::cout << "Eres mayor de edad" << std::endl;
    }
    std::cout << std::endl;

    // IF-ELSE
    std::cout << "--- IF-ELSE ---" << std::endl;
    int numero = -5;

    if (numero > 0) {
        std::cout << "El número es positivo" << std::endl;
    } else {
        std::cout << "El número es negativo o cero" << std::endl;
    }
    std::cout << std::endl;

    // IF-ELSE IF-ELSE (CADENA DE CONDICIONES)
    std::cout << "--- IF-ELSE IF-ELSE ---" << std::endl;
    int calificacion = 85;

    std::cout << "Calificación: " << calificacion << std::endl;

    if (calificacion >= 90) {
        std::cout << "Excelente (A)" << std::endl;
    } else if (calificacion >= 80) {
        std::cout << "Muy bien (B)" << std::endl;
    } else if (calificacion >= 70) {
        std::cout << "Bien (C)" << std::endl;
    } else if (calificacion >= 60) {
        std::cout << "Suficiente (D)" << std::endl;
    } else {
        std::cout << "Insuficiente (F)" << std::endl;
    }
    std::cout << std::endl;

    // CONDICIONES MÚLTIPLES (AND, OR)
    std::cout << "--- CONDICIONES MÚLTIPLES ---" << std::endl;
    int edadUsuario = 20;
    bool tieneLicencia = true;

    // Operador AND (&&) - Ambas condiciones deben ser verdaderas
    if (edadUsuario >= 18 && tieneLicencia) {
        std::cout << "Puede conducir" << std::endl;
    } else {
        std::cout << "No puede conducir" << std::endl;
    }

    // Operador OR (||) - Al menos una condición debe ser verdadera
    bool esFinde = true;
    bool esVacaciones = false;

    if (esFinde || esVacaciones) {
        std::cout << "¡Día de descanso!" << std::endl;
    }
    std::cout << std::endl;

    // IF ANIDADO
    std::cout << "--- IF ANIDADO ---" << std::endl;
    int temperatura = 25;
    bool estaLloviendo = false;

    if (temperatura > 20) {
        if (estaLloviendo) {
            std::cout << "Hace calor pero está lloviendo - Lleva paraguas" << std::endl;
        } else {
            std::cout << "Hace buen clima - Disfruta el día" << std::endl;
        }
    } else {
        if (estaLloviendo) {
            std::cout << "Hace frío y llueve - Quédate en casa" << std::endl;
        } else {
            std::cout << "Hace frío - Lleva abrigo" << std::endl;
        }
    }
    std::cout << std::endl;

    // OPERADOR TERNARIO (condición ? si_verdadero : si_falso)
    std::cout << "--- OPERADOR TERNARIO ---" << std::endl;
    int a = 10, b = 20;

    // Forma larga con if-else
    int mayor1;
    if (a > b) {
        mayor1 = a;
    } else {
        mayor1 = b;
    }

    // Forma corta con operador ternario (más elegante)
    int mayor2 = (a > b) ? a : b;

    std::cout << "El mayor entre " << a << " y " << b << " es: " << mayor2 << std::endl;

    // Otro ejemplo
    std::string mensaje = (edad >= 18) ? "Adulto" : "Menor";
    std::cout << "Categoría: " << mensaje << std::endl;
    std::cout << std::endl;

    // EJEMPLO PRÁCTICO: VALIDACIÓN DE LOGIN
    std::cout << "--- EJEMPLO PRÁCTICO: LOGIN ---" << std::endl;
    std::string usuario, password;

    std::cout << "Usuario: ";
    std::cin >> usuario;

    std::cout << "Password: ";
    std::cin >> password;

    // Usuario y password correctos
    const std::string USUARIO_CORRECTO = "admin";
    const std::string PASSWORD_CORRECTO = "12345";

    if (usuario == USUARIO_CORRECTO && password == PASSWORD_CORRECTO) {
        std::cout << "✓ Login exitoso. Bienvenido!" << std::endl;
    } else if (usuario != USUARIO_CORRECTO) {
        std::cout << "✗ Usuario incorrecto" << std::endl;
    } else {
        std::cout << "✗ Password incorrecto" << std::endl;
    }

    return 0;
}

/*
 * CÓMO COMPILAR Y EJECUTAR:
 * g++ 01_if_else.cpp -o condicionales
 * ./condicionales
 *
 * CONCEPTOS CLAVE:
 *
 * 1. IF ejecuta código solo si la condición es verdadera
 * 2. ELSE ejecuta código si la condición es falsa
 * 3. ELSE IF permite evaluar múltiples condiciones en secuencia
 * 4. && (AND) requiere que TODAS las condiciones sean verdaderas
 * 5. || (OR) requiere que AL MENOS UNA condición sea verdadera
 * 6. El operador ternario es útil para asignaciones simples
 *
 * BUENAS PRÁCTICAS:
 * - Usa paréntesis para hacer las condiciones más claras
 * - Evita anidar demasiados if (más de 3 niveles)
 * - Considera usar switch para muchas condiciones sobre una variable
 */
