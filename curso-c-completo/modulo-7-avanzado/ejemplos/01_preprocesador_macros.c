/*
 * ============================================================================
 * PROGRAMA: Preprocesador y Macros
 * DESCRIPCIÓN: Directivas del preprocesador y macros
 * NIVEL: Avanzado
 * ============================================================================
 */

#include <stdio.h>

// ========== CONSTANTES CON #define ==========

#define PI 3.14159
#define MAX_BUFFER 1024
#define NOMBRE_PROGRAMA "MiPrograma"
#define VERSION "1.0.0"

// ========== MACROS SIMPLES ==========

#define CUADRADO(x) ((x) * (x))
#define MAX(a, b) ((a) > (b) ? (a) : (b))
#define MIN(a, b) ((a) < (b) ? (a) : (b))
#define ABS(x) ((x) < 0 ? -(x) : (x))

// ========== MACROS DE UTILIDAD ==========

#define IMPRIMIR_VAR(var) printf(#var " = %d\n", var)
#define DEBUG_MSG(msg) printf("[DEBUG] %s:%d - %s\n", __FILE__, __LINE__, msg)

// ========== COMPILACIÓN CONDICIONAL ==========

#define DEBUG_MODE 1
#define USAR_COLOR 1

#if DEBUG_MODE
    #define LOG(msg) printf("[LOG] %s\n", msg)
#else
    #define LOG(msg)  // No hace nada en modo release
#endif

// ========== INFORMACIÓN DEL SISTEMA ==========

int main() {

    printf("========== PREPROCESADOR Y MACROS ==========\n\n");

    // ========== CONSTANTES ==========

    printf("--- Constantes definidas ---\n");
    printf("PI = %.5f\n", PI);
    printf("MAX_BUFFER = %d\n", MAX_BUFFER);
    printf("Programa: %s v%s\n\n", NOMBRE_PROGRAMA, VERSION);

    // ========== MACROS DE CÁLCULO ==========

    printf("--- Macros de cálculo ---\n");

    int num = 5;
    printf("CUADRADO(%d) = %d\n", num, CUADRADO(num));

    int a = 10, b = 20;
    printf("MAX(%d, %d) = %d\n", a, b, MAX(a, b));
    printf("MIN(%d, %d) = %d\n", a, b, MIN(a, b));

    int negativo = -15;
    printf("ABS(%d) = %d\n\n", negativo, ABS(negativo));

    // ========== MACRO PARA DEBUGGING ==========

    printf("--- Debugging ---\n");

    int edad = 25;
    IMPRIMIR_VAR(edad);  // Imprime: edad = 25

    DEBUG_MSG("Iniciando proceso");

    printf("\n");

    // ========== COMPILACIÓN CONDICIONAL ==========

    printf("--- Compilación condicional ---\n");

    LOG("Este mensaje solo aparece en DEBUG_MODE");

    #if USAR_COLOR
        printf("Modo color ACTIVADO\n");
    #else
        printf("Modo color DESACTIVADO\n");
    #endif

    printf("\n");

    // ========== INFORMACIÓN DE COMPILACIÓN ==========

    printf("--- Información del sistema ---\n");

    printf("Archivo: %s\n", __FILE__);
    printf("Línea: %d\n", __LINE__);
    printf("Fecha de compilación: %s\n", __DATE__);
    printf("Hora de compilación: %s\n", __TIME__);

    #ifdef __unix__
        printf("Sistema: Unix/Linux\n");
    #elif defined(_WIN32) || defined(_WIN64)
        printf("Sistema: Windows\n");
    #elif defined(__APPLE__)
        printf("Sistema: macOS\n");
    #else
        printf("Sistema: Desconocido\n");
    #endif

    printf("\n");

    // ========== GUARDS DE INCLUSIÓN (EJEMPLO) ==========

    printf("--- Guards de inclusión ---\n");
    printf("Los guards evitan inclusión múltiple:\n\n");

    printf("#ifndef MI_HEADER_H\n");
    printf("#define MI_HEADER_H\n");
    printf("// Contenido del header\n");
    printf("#endif\n\n");

    // ========== MACROS ÚTILES ==========

    printf("--- Macros útiles comunes ---\n\n");

    printf("CELSIUS_A_FAHRENHEIT:\n");
    #define CELSIUS_A_FAHRENHEIT(c) ((c) * 9.0 / 5.0 + 32)
    printf("25°C = %.2f°F\n\n", CELSIUS_A_FAHRENHEIT(25));

    printf("ES_PAR:\n");
    #define ES_PAR(n) ((n) % 2 == 0)
    printf("¿10 es par? %s\n\n", ES_PAR(10) ? "Sí" : "No");

    printf("ENTRE:\n");
    #define ENTRE(x, min, max) ((x) >= (min) && (x) <= (max))
    printf("¿15 está entre 10 y 20? %s\n\n", ENTRE(15, 10, 20) ? "Sí" : "No");

    return 0;
}

/*
 * CONCEPTOS CLAVE:
 *
 * #define:
 *   - Define constantes y macros
 *   - Se reemplazan antes de compilar
 *   - No ocupan memoria (son reemplazos de texto)
 *
 * MACROS vs FUNCIONES:
 *
 * MACROS:
 *   ✓ Más rápidas (no hay llamada a función)
 *   ✓ Funcionan con cualquier tipo
 *   ✗ Pueden tener efectos secundarios
 *   ✗ Código más grande (se expande)
 *
 * FUNCIONES:
 *   ✓ Seguras (type-checking)
 *   ✓ Debugging más fácil
 *   ✗ Más lentas (overhead de llamada)
 *   ✗ Tipo específico
 *
 * DIRECTIVAS DEL PREPROCESADOR:
 *
 *   #define    - Define constante/macro
 *   #undef     - Elimina definición
 *   #include   - Incluye archivo
 *   #if        - Compilación condicional
 *   #ifdef     - Si está definido
 *   #ifndef    - Si NO está definido
 *   #else      - Alternativa
 *   #elif      - Else if
 *   #endif     - Fin de condicional
 *
 * MACROS PREDEFINIDAS:
 *
 *   __FILE__   - Nombre del archivo
 *   __LINE__   - Número de línea
 *   __DATE__   - Fecha de compilación
 *   __TIME__   - Hora de compilación
 *   __func__   - Nombre de la función actual
 *
 * BUENAS PRÁCTICAS:
 *
 * 1. Usa MAYÚSCULAS para macros
 * 2. Paréntesis en TODOS los parámetros
 * 3. Paréntesis alrededor de toda la expresión
 * 4. Prefiere const o enum sobre #define cuando sea posible
 * 5. Documenta macros complejas
 *
 * ERRORES COMUNES:
 *
 * 1. SIN PARÉNTESIS:
 *    #define CUADRADO(x) x * x
 *    CUADRADO(2 + 3)  // Expande a 2 + 3 * 2 + 3 = 11 (¡ERROR!)
 *
 *    CORRECTO:
 *    #define CUADRADO(x) ((x) * (x))
 *    CUADRADO(2 + 3)  // Expande a ((2 + 3) * (2 + 3)) = 25
 *
 * 2. EFECTOS SECUNDARIOS:
 *    #define MAX(a, b) ((a) > (b) ? (a) : (b))
 *    MAX(i++, j++)  // ¡i o j se incrementa DOS veces!
 *
 * 3. PUNTO Y COMA:
 *    #define IMPRIMIR(x) printf("%d\n", x);
 *    if (condicion)
 *        IMPRIMIR(x);  // El ; extra causa problemas
 *
 * EJERCICIOS:
 *
 * 1. Crea macros para:
 *    - Convertir km a millas
 *    - Calcular área de círculo
 *    - Verificar si año es bisiesto
 *
 * 2. Usa compilación condicional para:
 *    - Activar/desactivar debugging
 *    - Cambiar comportamiento según OS
 *    - Versiones de producto (FREE/PRO)
 *
 * 3. Crea guards de inclusión para headers
 *
 * 4. Implementa sistema de logging con niveles:
 *    - DEBUG, INFO, WARNING, ERROR
 */
