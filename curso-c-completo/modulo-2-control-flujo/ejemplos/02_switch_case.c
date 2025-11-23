/*
 * ============================================================================
 * PROGRAMA: Switch Case
 * DESCRIPCIÓN: Alternativa elegante a múltiples if-else
 * NIVEL: Principiante-Intermedio
 * ============================================================================
 */

#include <stdio.h>

int main() {

    // ========== SWITCH BÁSICO ==========

    printf("========== SWITCH BÁSICO ==========\n\n");

    int dia = 3;

    /*
     * switch evalúa una expresión y ejecuta el caso que coincida
     * Es más limpio que múltiples if-else cuando comparas una variable
     * contra múltiples valores constantes
     */

    switch (dia) {
        case 1:
            printf("Lunes\n");
            break;  // break sale del switch
        case 2:
            printf("Martes\n");
            break;
        case 3:
            printf("Miércoles\n");
            break;
        case 4:
            printf("Jueves\n");
            break;
        case 5:
            printf("Viernes\n");
            break;
        case 6:
            printf("Sábado\n");
            break;
        case 7:
            printf("Domingo\n");
            break;
        default:  // Se ejecuta si ningún caso coincide
            printf("Día inválido\n");
    }

    printf("\n");

    // ========== SWITCH CON CARACTERES ==========

    printf("========== SWITCH CON CARACTERES ==========\n\n");

    char calificacion = 'B';

    switch (calificacion) {
        case 'A':
            printf("Excelente (90-100)\n");
            break;
        case 'B':
            printf("Muy bien (80-89)\n");
            break;
        case 'C':
            printf("Bien (70-79)\n");
            break;
        case 'D':
            printf("Suficiente (60-69)\n");
            break;
        case 'F':
            printf("Reprobado (< 60)\n");
            break;
        default:
            printf("Calificación no válida\n");
    }

    printf("\n");

    // ========== SWITCH SIN BREAK (FALL-THROUGH) ==========

    printf("========== FALL-THROUGH ==========\n\n");

    int mes = 2;

    printf("Mes %d tiene ", mes);

    /*
     * Si omites break, la ejecución "cae" al siguiente caso
     * Esto se llama "fall-through" y a veces es útil
     */

    switch (mes) {
        case 1:  // Enero
        case 3:  // Marzo
        case 5:  // Mayo
        case 7:  // Julio
        case 8:  // Agosto
        case 10: // Octubre
        case 12: // Diciembre
            printf("31 días\n");
            break;
        case 4:  // Abril
        case 6:  // Junio
        case 9:  // Septiembre
        case 11: // Noviembre
            printf("30 días\n");
            break;
        case 2:  // Febrero
            printf("28 o 29 días\n");
            break;
        default:
            printf("Mes inválido\n");
    }

    printf("\n");

    // ========== EJEMPLO PRÁCTICO: CALCULADORA ==========

    printf("========== CALCULADORA CON SWITCH ==========\n\n");

    float num1, num2, resultado;
    char operador;

    printf("Ingresa primer número: ");
    scanf("%f", &num1);

    printf("Ingresa operador (+, -, *, /): ");
    scanf(" %c", &operador);

    printf("Ingresa segundo número: ");
    scanf("%f", &num2);

    switch (operador) {
        case '+':
            resultado = num1 + num2;
            printf("\n%.2f + %.2f = %.2f\n", num1, num2, resultado);
            break;

        case '-':
            resultado = num1 - num2;
            printf("\n%.2f - %.2f = %.2f\n", num1, num2, resultado);
            break;

        case '*':
            resultado = num1 * num2;
            printf("\n%.2f × %.2f = %.2f\n", num1, num2, resultado);
            break;

        case '/':
            if (num2 != 0) {
                resultado = num1 / num2;
                printf("\n%.2f ÷ %.2f = %.2f\n", num1, num2, resultado);
            } else {
                printf("\nERROR: División entre cero\n");
            }
            break;

        default:
            printf("\nOperador no válido\n");
    }

    printf("\n");

    // ========== EJEMPLO: MENÚ DE OPCIONES ==========

    printf("========== MENÚ DE OPCIONES ==========\n\n");

    int opcion;

    printf("╔═══════════════════════════════╗\n");
    printf("║      MENÚ PRINCIPAL           ║\n");
    printf("╠═══════════════════════════════╣\n");
    printf("║ 1. Nueva partida              ║\n");
    printf("║ 2. Cargar partida             ║\n");
    printf("║ 3. Opciones                   ║\n");
    printf("║ 4. Créditos                   ║\n");
    printf("║ 5. Salir                      ║\n");
    printf("╚═══════════════════════════════╝\n");
    printf("\nSelecciona una opción: ");
    scanf("%d", &opcion);

    printf("\n");

    switch (opcion) {
        case 1:
            printf("Iniciando nueva partida...\n");
            printf("¡Buena suerte!\n");
            break;

        case 2:
            printf("Cargando partida guardada...\n");
            printf("Partida restaurada correctamente\n");
            break;

        case 3:
            printf("--- OPCIONES ---\n");
            printf("Volumen: 80%%\n");
            printf("Dificultad: Normal\n");
            printf("Idioma: Español\n");
            break;

        case 4:
            printf("--- CRÉDITOS ---\n");
            printf("Desarrollado por: Tu Nombre\n");
            printf("Versión: 1.0\n");
            printf("Gracias por jugar\n");
            break;

        case 5:
            printf("Cerrando el juego...\n");
            printf("¡Hasta luego!\n");
            break;

        default:
            printf("Opción no válida\n");
            printf("Por favor selecciona 1-5\n");
    }

    printf("\n");

    // ========== EJEMPLO: CLASIFICACIÓN DE CARACTERES ==========

    printf("========== CLASIFICADOR DE CARACTERES ==========\n\n");

    char caracter;

    printf("Ingresa un carácter: ");
    scanf(" %c", &caracter);

    printf("El carácter '%c' es: ", caracter);

    switch (caracter) {
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
            printf("una vocal\n");
            break;

        case '0':
        case '1':
        case '2':
        case '3':
        case '4':
        case '5':
        case '6':
        case '7':
        case '8':
        case '9':
            printf("un dígito\n");
            break;

        case '+':
        case '-':
        case '*':
        case '/':
            printf("un operador matemático\n");
            break;

        case ' ':
            printf("un espacio\n");
            break;

        default:
            printf("una consonante u otro carácter\n");
    }

    return 0;
}

/*
 * CONCEPTOS CLAVE:
 *
 * SINTAXIS DE SWITCH:
 *   switch (expresión) {
 *       case valor1:
 *           // código
 *           break;
 *       case valor2:
 *           // código
 *           break;
 *       default:
 *           // código si ningún caso coincide
 *   }
 *
 * COMPONENTES:
 *   - switch: palabra clave que inicia la estructura
 *   - case: define cada opción posible
 *   - break: sale del switch (IMPORTANTE)
 *   - default: caso por defecto (opcional pero recomendado)
 *
 * CUÁNDO USAR SWITCH VS IF:
 *
 * USA SWITCH cuando:
 *   ✓ Comparas UNA variable contra múltiples valores CONSTANTES
 *   ✓ Los valores son enteros o caracteres
 *   ✓ Tienes muchas opciones (> 3)
 *   ✓ El código es más legible así
 *
 * USA IF cuando:
 *   ✓ Necesitas rangos (if edad >= 18 && edad < 65)
 *   ✓ Comparas con variables (no constantes)
 *   ✓ Usas operadores lógicos complejos
 *   ✓ Comparas diferentes variables
 *
 * EJEMPLO - SWITCH ES MEJOR:
 *   Menús con opciones 1, 2, 3, 4
 *   Días de la semana
 *   Calificaciones (A, B, C, D, F)
 *
 * EJEMPLO - IF ES MEJOR:
 *   if (edad >= 18 && tiene_licencia)
 *   if (precio > 100.0)
 *   if (nombre == "admin" && password == "1234")
 *
 * LIMITACIONES DE SWITCH:
 *
 * 1. Solo funciona con:
 *    - int
 *    - char
 *    - enum (enumeraciones)
 *    NO funciona con: float, double, strings
 *
 * 2. Los valores case DEBEN ser constantes:
 *    ✓ case 5:
 *    ✓ case 'A':
 *    ✗ case x:      // x debe ser constante
 *    ✗ case edad:   // no puede ser variable
 *
 * 3. No se pueden usar rangos directamente:
 *    ✗ case 1-10:   // ERROR
 *    Se debe hacer con múltiples cases o usar if
 *
 * FALL-THROUGH (caída):
 *
 * Sin break, la ejecución continúa al siguiente caso:
 *
 *   switch (x) {
 *       case 1:
 *           printf("Uno\n");
 *           // NO HAY BREAK - cae al siguiente caso
 *       case 2:
 *           printf("Dos o continuación de uno\n");
 *           break;
 *   }
 *
 * Esto es útil cuando múltiples casos comparten código.
 *
 * BUENAS PRÁCTICAS:
 *
 * 1. SIEMPRE usa break (excepto fall-through intencional)
 * 2. SIEMPRE incluye default (aunque no esperes usarlo)
 * 3. Comenta los fall-through intencionales
 * 4. Ordena los casos lógicamente (numérico o alfabético)
 * 5. Mantén cada caso simple (si es complejo, usa función)
 *
 * ERRORES COMUNES:
 *
 * 1. Olvidar break:
 *    switch (x) {
 *        case 1:
 *            printf("Uno\n");
 *            // ¡OLVIDO BREAK! Ejecutará case 2 también
 *        case 2:
 *            printf("Dos\n");
 *            break;
 *    }
 *
 * 2. Usar variables en case:
 *    ✗ case variable:  // ERROR
 *    ✓ case 5:        // CORRECTO
 *
 * 3. Intentar usar condiciones:
 *    ✗ case x > 5:    // ERROR
 *    Usa if para esto
 *
 * EJERCICIOS:
 *
 * 1. Conversor de números a texto:
 *    - Lee un número 1-10
 *    - Imprime el número en palabras
 *
 * 2. Menú de restaurante:
 *    - Muestra platillos con precios
 *    - Lee selección del usuario
 *    - Muestra nombre y precio del platillo
 *
 * 3. Clasificador de edades:
 *    - Bebé: 0-2
 *    - Niño: 3-12
 *    - Adolescente: 13-17
 *    - Adulto: 18-64
 *    - Adulto mayor: 65+
 *    Pista: usa división o múltiples cases
 *
 * 4. Sistema de conversión de unidades:
 *    - Menú con opciones: km->millas, kg->libras, °C->°F, etc.
 *    - Usa switch para el menú
 *    - Realiza la conversión seleccionada
 *
 * 5. Juego de piedra, papel o tijera:
 *    - Lee elección del jugador (1=piedra, 2=papel, 3=tijera)
 *    - Genera elección aleatoria de computadora
 *    - Determina ganador con switch
 */
