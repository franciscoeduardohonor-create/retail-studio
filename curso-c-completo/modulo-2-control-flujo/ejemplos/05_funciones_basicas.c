/*
 * ============================================================================
 * PROGRAMA: Funciones Básicas
 * DESCRIPCIÓN: Aprende a crear y usar funciones
 * NIVEL: Intermedio
 * ============================================================================
 */

#include <stdio.h>

// ========== PROTOTIPOS DE FUNCIONES ==========

/*
 * Los prototipos declaran funciones antes de main()
 * Esto permite que main() las use antes de su definición
 * Formato: tipo_retorno nombre_funcion(parámetros);
 */

void saludar();
void saludar_nombre(char nombre[]);
int sumar(int a, int b);
float calcular_promedio(float n1, float n2, float n3);
int es_par(int numero);
void imprimir_linea(char caracter, int longitud);

// ========== FUNCIÓN PRINCIPAL ==========

int main() {

    printf("========== FUNCIONES EN C ==========\n\n");

    // ========== FUNCIÓN SIN PARÁMETROS NI RETORNO ==========

    printf("--- Función simple ---\n");
    saludar();  // Llamada a la función
    saludar();  // Podemos llamarla múltiples veces
    printf("\n");

    // ========== FUNCIÓN CON PARÁMETROS ==========

    printf("--- Función con parámetros ---\n");
    saludar_nombre("Carlos");
    saludar_nombre("María");
    saludar_nombre("Pedro");
    printf("\n");

    // ========== FUNCIÓN QUE RETORNA VALOR ==========

    printf("--- Función con retorno ---\n");

    int resultado = sumar(5, 3);
    printf("5 + 3 = %d\n", resultado);

    // Podemos usar el retorno directamente
    printf("10 + 20 = %d\n", sumar(10, 20));

    // En expresiones
    int total = sumar(5, 7) + sumar(3, 2);
    printf("(5+7) + (3+2) = %d\n", total);

    printf("\n");

    // ========== FUNCIÓN CON MÚLTIPLES PARÁMETROS ==========

    printf("--- Función con múltiples parámetros ---\n");

    float promedio = calcular_promedio(8.5, 9.0, 7.5);
    printf("Promedio de 8.5, 9.0 y 7.5 es: %.2f\n", promedio);

    printf("\n");

    // ========== FUNCIÓN QUE RETORNA BOOLEANO ==========

    printf("--- Función booleana ---\n");

    int num = 42;
    if (es_par(num)) {
        printf("%d es par\n", num);
    } else {
        printf("%d es impar\n", num);
    }

    printf("\n");

    // ========== FUNCIÓN PARA PRESENTACIÓN ==========

    printf("--- Función de utilidad ---\n");

    imprimir_linea('=', 40);
    printf("TÍTULO IMPORTANTE\n");
    imprimir_linea('=', 40);

    printf("\n");

    imprimir_linea('-', 30);
    printf("Subtítulo\n");
    imprimir_linea('-', 30);

    return 0;
}

// ========== DEFINICIONES DE FUNCIONES ==========

/*
 * FUNCIÓN SIN PARÁMETROS NI RETORNO
 * void = no retorna nada
 * () = no recibe parámetros
 */
void saludar() {
    printf("¡Hola, mundo!\n");
}

/*
 * FUNCIÓN CON PARÁMETROS
 * Recibe un string (array de char) como parámetro
 */
void saludar_nombre(char nombre[]) {
    printf("¡Hola, %s!\n", nombre);
}

/*
 * FUNCIÓN QUE RETORNA VALOR
 * int = retorna un entero
 * (int a, int b) = recibe dos enteros
 */
int sumar(int a, int b) {
    int resultado = a + b;
    return resultado;  // Devuelve el resultado

    // También se puede escribir directamente:
    // return a + b;
}

/*
 * FUNCIÓN CON MÚLTIPLES PARÁMETROS
 * Calcula el promedio de 3 números
 */
float calcular_promedio(float n1, float n2, float n3) {
    float suma = n1 + n2 + n3;
    float promedio = suma / 3.0;
    return promedio;
}

/*
 * FUNCIÓN BOOLEANA
 * Retorna 1 (verdadero) o 0 (falso)
 */
int es_par(int numero) {
    if (numero % 2 == 0) {
        return 1;  // Es par
    } else {
        return 0;  // Es impar
    }

    // Forma más corta:
    // return (numero % 2 == 0);
}

/*
 * FUNCIÓN DE UTILIDAD
 * Imprime una línea del carácter especificado
 */
void imprimir_linea(char caracter, int longitud) {
    for (int i = 0; i < longitud; i++) {
        printf("%c", caracter);
    }
    printf("\n");
}

/*
 * CONCEPTOS CLAVE:
 *
 * ¿QUÉ ES UNA FUNCIÓN?
 *   - Bloque de código reutilizable
 *   - Realiza una tarea específica
 *   - Puede recibir datos (parámetros)
 *   - Puede devolver un resultado (return)
 *
 * ANATOMÍA DE UNA FUNCIÓN:
 *
 *   tipo_retorno nombre_funcion(tipo param1, tipo param2) {
 *   ───┬───────  ──────┬──────  ──────────┬──────────
 *      │                │                   └─ Parámetros
 *      │                └───────────────────── Nombre
 *      └────────────────────────────────────── Tipo de retorno
 *
 *       // Cuerpo de la función
 *       return valor;
 *   }
 *
 * TIPOS DE FUNCIONES:
 *
 * 1. Sin parámetros, sin retorno:
 *    void saludar() {
 *        printf("Hola\n");
 *    }
 *
 * 2. Con parámetros, sin retorno:
 *    void imprimir_numero(int n) {
 *        printf("Número: %d\n", n);
 *    }
 *
 * 3. Sin parámetros, con retorno:
 *    int obtener_edad() {
 *        return 25;
 *    }
 *
 * 4. Con parámetros y retorno:
 *    int sumar(int a, int b) {
 *        return a + b;
 *    }
 *
 * PROTOTIPOS VS DEFINICIONES:
 *
 * PROTOTIPO (declaración):
 *   - Va antes de main()
 *   - Termina en ;
 *   - Anuncia que la función existe
 *   Ejemplo: int sumar(int a, int b);
 *
 * DEFINICIÓN (implementación):
 *   - Va después de main()
 *   - Contiene el código
 *   - Implementa la función
 *   Ejemplo: int sumar(int a, int b) {
 *                return a + b;
 *            }
 *
 * RETURN:
 *
 * 1. Devuelve un valor al llamador
 * 2. Termina la función inmediatamente
 * 3. Puede haber múltiples returns en una función
 * 4. void no necesita return (pero puede usar "return;")
 *
 * PARÁMETROS:
 *
 * - Son variables locales a la función
 * - Reciben COPIAS de los valores (paso por valor)
 * - Modificar parámetros NO afecta variables originales
 *
 * Ejemplo:
 *   void modificar(int x) {
 *       x = 100;  // Solo modifica la copia
 *   }
 *
 *   int main() {
 *       int a = 5;
 *       modificar(a);
 *       printf("%d", a);  // Imprime 5, no 100
 *   }
 *
 * VENTAJAS DE USAR FUNCIONES:
 *
 * 1. REUTILIZACIÓN:
 *    - Escribe código una vez, úsalo muchas veces
 *
 * 2. ORGANIZACIÓN:
 *    - Divide programas grandes en partes pequeñas
 *
 * 3. MANTENIMIENTO:
 *    - Más fácil encontrar y arreglar errores
 *
 * 4. LEGIBILIDAD:
 *    - Código más claro y entendible
 *
 * 5. ABSTRACCIÓN:
 *    - Oculta complejidad
 *
 * BUENAS PRÁCTICAS:
 *
 * 1. NOMBRES DESCRIPTIVOS:
 *    ✓ calcular_area()
 *    ✗ func1()
 *
 * 2. UNA TAREA POR FUNCIÓN:
 *    - Cada función debe hacer UNA cosa bien
 *
 * 3. FUNCIONES CORTAS:
 *    - Preferiblemente < 30 líneas
 *
 * 4. EVITA EFECTOS SECUNDARIOS:
 *    - Funciones deben ser predecibles
 *
 * 5. USA RETURN DE FORMA CLARA:
 *    - Un solo return al final (cuando sea posible)
 *
 * 6. COMENTA FUNCIONES COMPLEJAS:
 *    - Explica qué hace, parámetros, y retorno
 *
 * ERRORES COMUNES:
 *
 * 1. OLVIDAR PROTOTIPO:
 *    Si defines la función DESPUÉS de main(), necesitas prototipo
 *
 * 2. TIPO DE RETORNO INCORRECTO:
 *    ✗ void sumar(int a, int b) { return a + b; }
 *    ✓ int sumar(int a, int b) { return a + b; }
 *
 * 3. NO USAR EL VALOR DE RETORNO:
 *    sumar(5, 3);  // ¿Para qué sumar si no usas el resultado?
 *
 * 4. OLVIDAR RETURN:
 *    int obtener_numero() {
 *        int x = 5;
 *        // ¡FALTA return x;!
 *    }
 *
 * 5. USAR VARIABLES LOCALES FUERA DE LA FUNCIÓN:
 *    Las variables declaradas dentro de una función
 *    solo existen dentro de ella
 *
 * EJERCICIOS:
 *
 * 1. Crea funciones para:
 *    - Calcular área de círculo (recibe radio)
 *    - Calcular área de rectángulo (recibe largo y ancho)
 *    - Calcular perímetro de círculo
 *
 * 2. Función que determine si un número es primo
 *
 * 3. Función que convierta Celsius a Fahrenheit
 *
 * 4. Función que encuentre el mayor de 3 números
 *
 * 5. Función que calcule factorial
 *
 * 6. Función que imprima un menú y retorne la opción elegida
 *
 * 7. Función que valide si una edad es válida (1-120)
 *
 * 8. Función que cuente dígitos de un número
 */
