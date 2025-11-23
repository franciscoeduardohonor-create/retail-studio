/**
 * EJERCICIO 3: Invertir Arrays
 * Dificultad: ⭐⭐ Intermedio
 *
 * OBJETIVO:
 * Aprender a invertir arrays usando diferentes técnicas
 *
 * INSTRUCCIONES:
 * 1. Completa los métodos marcados con TODO
 * 2. Ejecuta el main() para verificar tus soluciones
 * 3. Todos los tests deben pasar (✓)
 *
 * CONCEPTOS A PRACTICAR:
 * - Técnica de dos punteros
 * - Intercambio de elementos
 * - Inversión in-place vs con array nuevo
 * - Inversión de rangos
 */

public class Ejercicio03_InvertirArray {

    public static void main(String[] args) {
        System.out.println("=== EJERCICIO 3: INVERTIR ARRAYS ===\n");

        // Test 1: Invertir con nuevo array
        System.out.println("Test 1: Invertir creando nuevo array");
        int[] arr1 = {1, 2, 3, 4, 5};
        System.out.println("Original: " + arrayAString(arr1));
        int[] invertido1 = invertirNuevoArray(arr1);
        System.out.println("Invertido: " + arrayAString(invertido1));
        verificarArray(invertido1, new int[]{5, 4, 3, 2, 1}, "invertir nuevo array");

        // Test 2: Invertir in-place (modificando el original)
        System.out.println("\nTest 2: Invertir in-place (dos punteros)");
        int[] arr2 = {1, 2, 3, 4, 5};
        System.out.println("Antes: " + arrayAString(arr2));
        invertirInPlace(arr2);
        System.out.println("Después: " + arrayAString(arr2));
        verificarArray(arr2, new int[]{5, 4, 3, 2, 1}, "invertir in-place");

        // Test 3: Invertir con número impar de elementos
        System.out.println("\nTest 3: Array con número impar de elementos");
        int[] arr3 = {10, 20, 30, 40, 50, 60, 70};
        System.out.println("Antes: " + arrayAString(arr3));
        invertirInPlace(arr3);
        System.out.println("Después: " + arrayAString(arr3));
        verificarArray(arr3, new int[]{70, 60, 50, 40, 30, 20, 10}, "array impar");

        // Test 4: Invertir un rango
        System.out.println("\nTest 4: Invertir solo un rango");
        int[] arr4 = {1, 2, 3, 4, 5, 6, 7};
        System.out.println("Original: " + arrayAString(arr4));
        invertirRango(arr4, 2, 5);  // Invertir posiciones 2 a 5
        System.out.println("Invertido rango [2-5]: " + arrayAString(arr4));
        verificarArray(arr4, new int[]{1, 2, 6, 5, 4, 3, 7}, "invertir rango");

        // Test 5: Rotar usando inversiones
        System.out.println("\nTest 5: Rotar array usando 3 inversiones");
        int[] arr5 = {1, 2, 3, 4, 5, 6, 7};
        System.out.println("Original: " + arrayAString(arr5));
        rotarUsandoInversiones(arr5, 3);  // Rotar 3 posiciones
        System.out.println("Rotado 3 posiciones: " + arrayAString(arr5));
        verificarArray(arr5, new int[]{5, 6, 7, 1, 2, 3, 4}, "rotar con inversiones");

        // Test 6: Verificar si es palíndromo
        System.out.println("\nTest 6: Verificar palíndromo");
        int[] palindromo = {1, 2, 3, 2, 1};
        int[] noPalindromo = {1, 2, 3, 4, 5};
        System.out.println(arrayAString(palindromo) + " ¿es palíndromo? " +
                          esPalindromo(palindromo));
        System.out.println(arrayAString(noPalindromo) + " ¿es palíndromo? " +
                          esPalindromo(noPalindromo));
        verificar(esPalindromo(palindromo), "palíndromo true");
        verificar(!esPalindromo(noPalindromo), "palíndromo false");

        // Resumen
        System.out.println("\n" + "=".repeat(40));
        System.out.println("¡EJERCICIO COMPLETADO!");
        System.out.println("=".repeat(40));
    }

    /**
     * TODO: Implementa este método
     * Invierte el array creando un NUEVO array
     * (No modifica el original)
     *
     * Ejemplo: [1,2,3,4,5] -> [5,4,3,2,1]
     *
     * @param arr Array original
     * @return Nuevo array invertido
     */
    public static int[] invertirNuevoArray(int[] arr) {
        // TU CÓDIGO AQUÍ
        int[] invertido = new int[arr.length];

        for (int i = 0; i < arr.length; i++) {
            invertido[i] = arr[arr.length - 1 - i];
        }

        return invertido;
        // Elimina esta línea y escribe tu solución arriba
    }

    /**
     * TODO: Implementa este método
     * Invierte el array IN-PLACE (modificando el original)
     * Usa la técnica de DOS PUNTEROS
     *
     * Algoritmo:
     * 1. Un puntero al inicio, otro al final
     * 2. Intercambiar elementos
     * 3. Mover punteros hacia el centro
     * 4. Repetir hasta que se crucen
     *
     * Ejemplo paso a paso para [1,2,3,4,5]:
     * - Intercambiar 1↔5: [5,2,3,4,1]
     * - Intercambiar 2↔4: [5,4,3,2,1]
     * - 3 queda en el centro
     *
     * @param arr Array a invertir (se modifica)
     */
    public static void invertirInPlace(int[] arr) {
        // TU CÓDIGO AQUÍ
        int izq = 0;
        int der = arr.length - 1;

        while (izq < der) {
            // Intercambiar elementos
            int temp = arr[izq];
            arr[izq] = arr[der];
            arr[der] = temp;

            // Mover punteros hacia el centro
            izq++;
            der--;
        }
        // Elimina esta línea y escribe tu solución arriba
    }

    /**
     * TODO: Implementa este método
     * Invierte solo un RANGO del array
     *
     * Ejemplo: arr=[1,2,3,4,5,6,7], inicio=2, fin=5
     * Resultado: [1,2,6,5,4,3,7]
     *           (solo invertimos elementos de índice 2 a 5)
     *
     * @param arr Array a modificar
     * @param inicio Índice inicial del rango (inclusive)
     * @param fin Índice final del rango (inclusive)
     */
    public static void invertirRango(int[] arr, int inicio, int fin) {
        // TU CÓDIGO AQUÍ
        while (inicio < fin) {
            int temp = arr[inicio];
            arr[inicio] = arr[fin];
            arr[fin] = temp;

            inicio++;
            fin--;
        }
        // Elimina esta línea y escribe tu solución arriba
    }

    /**
     * TODO: Implementa este método (DESAFÍO)
     * Rota el array k posiciones a la DERECHA usando 3 inversiones
     *
     * Truco ingenioso:
     * Para rotar [1,2,3,4,5,6,7] tres posiciones:
     * 1. Invertir todo: [7,6,5,4,3,2,1]
     * 2. Invertir primeros k: [5,6,7,4,3,2,1]
     * 3. Invertir resto: [5,6,7,1,2,3,4] ✓
     *
     * @param arr Array a rotar
     * @param k Número de posiciones a rotar
     */
    public static void rotarUsandoInversiones(int[] arr, int k) {
        // TU CÓDIGO AQUÍ
        int n = arr.length;
        k = k % n;  // Por si k > n

        // 1. Invertir todo el array
        invertirRango(arr, 0, n - 1);

        // 2. Invertir primeros k elementos
        invertirRango(arr, 0, k - 1);

        // 3. Invertir elementos restantes
        invertirRango(arr, k, n - 1);
        // Elimina esta línea y escribe tu solución arriba
    }

    /**
     * TODO: Implementa este método
     * Verifica si un array es un palíndromo
     * (se lee igual de izquierda a derecha que de derecha a izquierda)
     *
     * Ejemplos:
     * [1,2,3,2,1] -> true
     * [1,2,2,1] -> true
     * [1,2,3,4,5] -> false
     *
     * Pista: usa dos punteros
     *
     * @param arr Array a verificar
     * @return true si es palíndromo, false si no
     */
    public static boolean esPalindromo(int[] arr) {
        // TU CÓDIGO AQUÍ
        int izq = 0;
        int der = arr.length - 1;

        while (izq < der) {
            if (arr[izq] != arr[der]) {
                return false;  // No es palíndromo
            }
            izq++;
            der--;
        }

        return true;  // Es palíndromo
        // Elimina esta línea y escribe tu solución arriba
    }

    // ========================================
    // MÉTODOS AUXILIARES (No modificar)
    // ========================================
    private static void verificar(boolean condicion, String nombreTest) {
        if (condicion) {
            System.out.println("✓ Test pasado: " + nombreTest);
        } else {
            System.out.println("✗ Test fallido: " + nombreTest);
        }
    }

    private static void verificarArray(int[] resultado, int[] esperado, String nombreTest) {
        boolean igual = true;
        if (resultado.length != esperado.length) {
            igual = false;
        } else {
            for (int i = 0; i < resultado.length; i++) {
                if (resultado[i] != esperado[i]) {
                    igual = false;
                    break;
                }
            }
        }

        if (igual) {
            System.out.println("✓ Test pasado: " + nombreTest);
        } else {
            System.out.println("✗ Test fallido: " + nombreTest);
            System.out.println("  Esperado: " + arrayAString(esperado));
            System.out.println("  Obtenido: " + arrayAString(resultado));
        }
    }

    private static String arrayAString(int[] arr) {
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < arr.length; i++) {
            sb.append(arr[i]);
            if (i < arr.length - 1) sb.append(", ");
        }
        sb.append("]");
        return sb.toString();
    }
}

/*
 * CONCEPTOS CLAVE:
 * ================
 *
 * 1. TÉCNICA DE DOS PUNTEROS:
 *    - Muy útil para operaciones simétricas
 *    - Un puntero al inicio, otro al final
 *    - Se mueven hacia el centro
 *    - Eficiente: O(n/2) = O(n)
 *
 * 2. INVERSIÓN IN-PLACE:
 *    - No usa memoria extra
 *    - Complejidad espacial: O(1)
 *    - Complejidad temporal: O(n)
 *
 * 3. TRUCO DE 3 INVERSIONES:
 *    - Rotación elegante sin array auxiliar
 *    - Reutiliza la inversión 3 veces
 *    - Muy eficiente en memoria
 *
 * DESAFÍOS ADICIONALES:
 * =====================
 *
 * 1. Implementa rotarIzquierda(arr, k) para rotar a la izquierda
 * 2. Implementa invertirPorBloques(arr, tamañoBloque) que invierte
 *    bloques del tamaño dado
 *    Ejemplo: [1,2,3,4,5,6], bloques de 2 -> [2,1,4,3,6,5]
 * 3. Implementa esPalindromoIgnorandoValor(arr, ignorar) que verifica
 *    palíndromo ignorando cierto valor
 */
