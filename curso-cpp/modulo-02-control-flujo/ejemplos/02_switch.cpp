/*
 * MÓDULO 2: CONTROL DE FLUJO
 * Ejemplo 2: Switch-Case
 *
 * Aprenderás:
 * - Cuándo usar switch en lugar de if-else
 * - Sintaxis de switch-case
 * - Importancia de break
 * - Default case
 */

#include <iostream>

int main() {
    std::cout << "=== SWITCH-CASE ===" << std::endl << std::endl;

    // SWITCH BÁSICO
    std::cout << "--- SWITCH BÁSICO ---" << std::endl;
    int dia = 3;

    std::cout << "Día " << dia << ": ";

    switch (dia) {
        case 1:
            std::cout << "Lunes" << std::endl;
            break;  // IMPORTANTE: break sale del switch
        case 2:
            std::cout << "Martes" << std::endl;
            break;
        case 3:
            std::cout << "Miércoles" << std::endl;
            break;
        case 4:
            std::cout << "Jueves" << std::endl;
            break;
        case 5:
            std::cout << "Viernes" << std::endl;
            break;
        case 6:
            std::cout << "Sábado" << std::endl;
            break;
        case 7:
            std::cout << "Domingo" << std::endl;
            break;
        default:  // Se ejecuta si ningún case coincide
            std::cout << "Día inválido" << std::endl;
    }
    std::cout << std::endl;

    // MÚLTIPLES CASOS CON LA MISMA ACCIÓN
    std::cout << "--- AGRUPACIÓN DE CASOS ---" << std::endl;
    char vocal;

    std::cout << "Ingresa una letra: ";
    std::cin >> vocal;

    switch (vocal) {
        case 'a':
        case 'e':
        case 'i':
        case 'o':
        case 'u':
        case 'A':
        case 'E':
        case 'I':
        case 'O':
        case 'U':
            std::cout << "Es una vocal" << std::endl;
            break;
        default:
            std::cout << "No es una vocal" << std::endl;
    }
    std::cout << std::endl;

    // CALCULADORA CON SWITCH
    std::cout << "--- CALCULADORA CON SWITCH ---" << std::endl;
    double num1, num2;
    char operador;

    std::cout << "Ingresa el primer número: ";
    std::cin >> num1;

    std::cout << "Ingresa el operador (+, -, *, /): ";
    std::cin >> operador;

    std::cout << "Ingresa el segundo número: ";
    std::cin >> num2;

    std::cout << std::endl << "Resultado: ";

    switch (operador) {
        case '+':
            std::cout << num1 << " + " << num2 << " = " << (num1 + num2) << std::endl;
            break;
        case '-':
            std::cout << num1 << " - " << num2 << " = " << (num1 - num2) << std::endl;
            break;
        case '*':
            std::cout << num1 << " * " << num2 << " = " << (num1 * num2) << std::endl;
            break;
        case '/':
            if (num2 != 0) {
                std::cout << num1 << " / " << num2 << " = " << (num1 / num2) << std::endl;
            } else {
                std::cout << "Error: División entre cero" << std::endl;
            }
            break;
        default:
            std::cout << "Operador inválido" << std::endl;
    }
    std::cout << std::endl;

    // MENÚ INTERACTIVO
    std::cout << "--- MENÚ INTERACTIVO ---" << std::endl;
    int opcion;

    std::cout << "=== MENÚ PRINCIPAL ===" << std::endl;
    std::cout << "1. Nueva partida" << std::endl;
    std::cout << "2. Cargar partida" << std::endl;
    std::cout << "3. Opciones" << std::endl;
    std::cout << "4. Salir" << std::endl;
    std::cout << std::endl;
    std::cout << "Selecciona una opción: ";
    std::cin >> opcion;

    switch (opcion) {
        case 1:
            std::cout << "Iniciando nueva partida..." << std::endl;
            break;
        case 2:
            std::cout << "Cargando partida guardada..." << std::endl;
            break;
        case 3:
            std::cout << "Abriendo opciones..." << std::endl;
            break;
        case 4:
            std::cout << "Saliendo del juego. ¡Hasta pronto!" << std::endl;
            break;
        default:
            std::cout << "Opción no válida. Intenta de nuevo." << std::endl;
    }
    std::cout << std::endl;

    // EJEMPLO SIN BREAK (¡FALL THROUGH!)
    std::cout << "--- PELIGRO: SIN BREAK ---" << std::endl;
    int mes = 3;

    std::cout << "Mes " << mes << " tiene ";

    switch (mes) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            std::cout << "31 días" << std::endl;
            break;
        case 4: case 6: case 9: case 11:
            std::cout << "30 días" << std::endl;
            break;
        case 2:
            std::cout << "28 o 29 días" << std::endl;
            break;
        default:
            std::cout << "mes inválido" << std::endl;
    }

    return 0;
}

/*
 * CÓMO COMPILAR Y EJECUTAR:
 * g++ 02_switch.cpp -o switch_ejemplo
 * ./switch_ejemplo
 *
 * CUÁNDO USAR SWITCH VS IF-ELSE:
 *
 * Usa SWITCH cuando:
 * ✓ Comparas UNA variable contra múltiples valores constantes
 * ✓ Los valores son enteros, caracteres o enumeraciones
 * ✓ Tienes 3 o más condiciones que verificar
 * ✓ El código es más legible que múltiples if-else
 *
 * Usa IF-ELSE cuando:
 * ✓ Necesitas rangos (edad > 18)
 * ✓ Condiciones complejas (edad > 18 && tieneLicencia)
 * ✓ Comparas diferentes variables
 * ✓ Usas tipos float o double
 *
 * IMPORTANTE SOBRE BREAK:
 * - Sin break, el código "cae" al siguiente case (fall through)
 * - Esto puede ser útil, pero generalmente es un bug
 * - Siempre usa break a menos que quieras fall through intencional
 *
 * LIMITACIONES DE SWITCH:
 * - Solo funciona con valores constantes (no variables)
 * - No puedes usar rangos directamente
 * - No soporta strings en C++ antiguo (C++11 y anteriores)
 */
