/**
 * EJERCICIO 1: Suma de Elementos
 * Dificultad: ⭐ Principiante
 *
 * OBJETIVO:
 * Implementar diferentes formas de sumar los elementos de un array
 *
 * INSTRUCCIONES:
 * 1. Completa los métodos marcados con TODO
 * 2. Ejecuta el main() para verificar tus soluciones
 * 3. Todos los tests deben pasar (✓)
 *
 * CONCEPTOS A PRACTICAR:
 * - Recorrido de arrays con for
 * - Recorrido con for-each
 * - Acumuladores
 * - Condiciones
 */

public class Ejercicio01_SumaElementos {

    public static void main(String[] args) {
        System.out.println("=== EJERCICIO 1: SUMA DE ELEMENTOS ===\n");

        // Array de prueba
        int[] numeros = {5, 10, 15, 20, 25};

        // Test 1: Suma simple
        System.out.println("Test 1: Suma Simple");
        int resultado1 = sumaSimple(numeros);
        System.out.println("Suma de [5, 10, 15, 20, 25] = " + resultado1);
        verificar(resultado1 == 75, "suma simple");

        // Test 2: Suma con for-each
        System.out.println("\nTest 2: Suma con For-Each");
        int resultado2 = sumaConForEach(numeros);
        System.out.println("Suma = " + resultado2);
        verificar(resultado2 == 75, "suma for-each");

        // Test 3: Suma de pares
        System.out.println("\nTest 3: Suma solo números pares");
        int resultado3 = sumaPares(numeros);
        System.out.println("Suma de pares [10, 20] = " + resultado3);
        verificar(resultado3 == 30, "suma pares");

        // Test 4: Suma de impares
        System.out.println("\nTest 4: Suma solo números impares");
        int resultado4 = sumaImpares(numeros);
        System.out.println("Suma de impares [5, 15, 25] = " + resultado4);
        verificar(resultado4 == 45, "suma impares");

        // Test 5: Suma de elementos en posiciones pares
        System.out.println("\nTest 5: Suma de elementos en posiciones pares (0, 2, 4...)");
        int resultado5 = sumaPosicionesPares(numeros);
        System.out.println("Suma [5, 15, 25] = " + resultado5);
        verificar(resultado5 == 45, "suma posiciones pares");

        // Test 6: Suma en rango
        System.out.println("\nTest 6: Suma desde índice 1 hasta 3");
        int resultado6 = sumaEnRango(numeros, 1, 3);
        System.out.println("Suma [10, 15, 20] = " + resultado6);
        verificar(resultado6 == 45, "suma en rango");

        // Resumen
        System.out.println("\n" + "=".repeat(40));
        System.out.println("¡EJERCICIO COMPLETADO!");
        System.out.println("=".repeat(40));
    }

    /**
     * TODO: Implementa este método
     * Calcula la suma de todos los elementos del array
     * usando un bucle for tradicional
     *
     * @param arr Array de enteros
     * @return Suma de todos los elementos
     */
    public static int sumaSimple(int[] arr) {
        // TU CÓDIGO AQUÍ
        int suma = 0;
        for (int i = 0; i < arr.length; i++) {
            suma += arr[i];
        }
        return suma;
        // Elimina esta línea y escribe tu solución arriba
    }

    /**
     * TODO: Implementa este método
     * Calcula la suma usando for-each
     *
     * @param arr Array de enteros
     * @return Suma de todos los elementos
     */
    public static int sumaConForEach(int[] arr) {
        // TU CÓDIGO AQUÍ
        int suma = 0;
        for (int numero : arr) {
            suma += numero;
        }
        return suma;
        // Elimina esta línea y escribe tu solución arriba
    }

    /**
     * TODO: Implementa este método
     * Calcula la suma solo de números pares
     * Pista: usa el operador módulo (%) para verificar si es par
     *
     * @param arr Array de enteros
     * @return Suma de números pares
     */
    public static int sumaPares(int[] arr) {
        // TU CÓDIGO AQUÍ
        int suma = 0;
        for (int numero : arr) {
            if (numero % 2 == 0) {  // Si es divisible por 2, es par
                suma += numero;
            }
        }
        return suma;
        // Elimina esta línea y escribe tu solución arriba
    }

    /**
     * TODO: Implementa este método
     * Calcula la suma solo de números impares
     *
     * @param arr Array de enteros
     * @return Suma de números impares
     */
    public static int sumaImpares(int[] arr) {
        // TU CÓDIGO AQUÍ
        int suma = 0;
        for (int numero : arr) {
            if (numero % 2 != 0) {  // Si NO es divisible por 2, es impar
                suma += numero;
            }
        }
        return suma;
        // Elimina esta línea y escribe tu solución arriba
    }

    /**
     * TODO: Implementa este método
     * Suma elementos en posiciones pares (índice 0, 2, 4, ...)
     * Nota: La posición (índice) debe ser par, no el valor
     *
     * @param arr Array de enteros
     * @return Suma de elementos en posiciones pares
     */
    public static int sumaPosicionesPares(int[] arr) {
        // TU CÓDIGO AQUÍ
        int suma = 0;
        for (int i = 0; i < arr.length; i += 2) {  // i += 2 salta de 2 en 2
            suma += arr[i];
        }
        return suma;
        // Elimina esta línea y escribe tu solución arriba
    }

    /**
     * TODO: Implementa este método
     * Suma elementos desde índice inicio hasta fin (inclusive)
     *
     * @param arr Array de enteros
     * @param inicio Índice inicial (inclusive)
     * @param fin Índice final (inclusive)
     * @return Suma de elementos en el rango
     */
    public static int sumaEnRango(int[] arr, int inicio, int fin) {
        // TU CÓDIGO AQUÍ
        int suma = 0;
        for (int i = inicio; i <= fin && i < arr.length; i++) {
            suma += arr[i];
        }
        return suma;
        // Elimina esta línea y escribe tu solución arriba
    }

    // ========================================
    // MÉTODO AUXILIAR (No modificar)
    // ========================================
    private static void verificar(boolean condicion, String nombreTest) {
        if (condicion) {
            System.out.println("✓ Test pasado: " + nombreTest);
        } else {
            System.out.println("✗ Test fallido: " + nombreTest);
        }
    }
}

/*
 * DESAFÍOS ADICIONALES:
 * =====================
 *
 * 1. Implementa sumaMayoresQue(arr, limite) que suma solo números > limite
 * 2. Implementa sumaMultiplosDe(arr, n) que suma múltiplos de n
 * 3. Implementa sumaAlternada(arr) que suma/resta elementos alternadamente
 *    Ejemplo: [1,2,3,4,5] -> 1 - 2 + 3 - 4 + 5 = 3
 * 4. Implementa sumaDigitos(numero) que suma los dígitos de un número
 *    Ejemplo: 12345 -> 1+2+3+4+5 = 15
 *
 * PISTAS:
 * - Para verificar pares: numero % 2 == 0
 * - Para verificar impares: numero % 2 != 0
 * - Para saltar de 2 en 2: for(int i = 0; i < n; i += 2)
 * - Para verificar múltiplo: numero % n == 0
 */
