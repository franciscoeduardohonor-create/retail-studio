/**
 * EJERCICIO 5: Rotar Arrays
 * Dificultad: ⭐⭐⭐ Avanzado
 *
 * OBJETIVO:
 * Dominar diferentes técnicas de rotación de arrays
 *
 * INSTRUCCIONES:
 * 1. Completa los métodos marcados con TODO
 * 2. Ejecuta el main() para verificar tus soluciones
 * 3. Todos los tests deben pasar (✓)
 *
 * CONCEPTOS A PRACTICAR:
 * - Rotación a la derecha e izquierda
 * - Uso eficiente de memoria (con y sin array auxiliar)
 * - Técnica de inversiones
 * - Rotación circular
 */

public class Ejercicio05_RotarArray {

    public static void main(String[] args) {
        System.out.println("=== EJERCICIO 5: ROTAR ARRAYS ===\n");

        // Test 1: Rotación derecha (con array auxiliar)
        System.out.println("Test 1: Rotar a la DERECHA (con array auxiliar)");
        int[] arr1 = {1, 2, 3, 4, 5, 6, 7};
        System.out.println("Original: " + arrayAString(arr1));
        int[] rotado1 = rotarDerechaConArray(arr1, 3);
        System.out.println("Rotado 3 posiciones: " + arrayAString(rotado1));
        verificarArray(rotado1, new int[]{5, 6, 7, 1, 2, 3, 4}, "rotar derecha");

        // Test 2: Rotación derecha in-place
        System.out.println("\nTest 2: Rotar a la DERECHA (in-place)");
        int[] arr2 = {1, 2, 3, 4, 5, 6, 7};
        System.out.println("Antes: " + arrayAString(arr2));
        rotarDerechaInPlace(arr2, 3);
        System.out.println("Después: " + arrayAString(arr2));
        verificarArray(arr2, new int[]{5, 6, 7, 1, 2, 3, 4}, "rotar derecha in-place");

        // Test 3: Rotación izquierda
        System.out.println("\nTest 3: Rotar a la IZQUIERDA");
        int[] arr3 = {1, 2, 3, 4, 5, 6, 7};
        System.out.println("Antes: " + arrayAString(arr3));
        rotarIzquierda(arr3, 2);
        System.out.println("Después: " + arrayAString(arr3));
        verificarArray(arr3, new int[]{3, 4, 5, 6, 7, 1, 2}, "rotar izquierda");

        // Test 4: Rotación mayor que longitud
        System.out.println("\nTest 4: Rotar k > longitud del array");
        int[] arr4 = {1, 2, 3, 4, 5};
        System.out.println("Array de longitud 5, rotar 12 posiciones (= 2 posiciones)");
        System.out.println("Antes: " + arrayAString(arr4));
        rotarDerechaInPlace(arr4, 12);  // 12 % 5 = 2
        System.out.println("Después: " + arrayAString(arr4));
        verificarArray(arr4, new int[]{4, 5, 1, 2, 3}, "rotar k > n");

        // Test 5: Rotación de una posición
        System.out.println("\nTest 5: Rotación simple (1 posición)");
        int[] arr5 = {10, 20, 30, 40, 50};
        System.out.println("Antes: " + arrayAString(arr5));
        rotarDerechaUno(arr5);
        System.out.println("Después: " + arrayAString(arr5));
        verificarArray(arr5, new int[]{50, 10, 20, 30, 40}, "rotar uno");

        // Test 6: Búsqueda en array rotado
        System.out.println("\nTest 6: Buscar en array rotado");
        int[] arrRotado = {4, 5, 6, 7, 0, 1, 2};  // [0,1,2,3,4,5,6,7] rotado
        System.out.println("Array rotado: " + arrayAString(arrRotado));
        int indice = buscarEnArrayRotado(arrRotado, 0);
        System.out.println("Índice del 0: " + indice);
        verificar(indice == 4, "buscar en rotado");

        // Test 7: Determinar número de rotaciones
        System.out.println("\nTest 7: Contar rotaciones realizadas");
        int[] arrRotado2 = {5, 6, 7, 1, 2, 3, 4};  // rotado 3 veces
        System.out.println("Array: " + arrayAString(arrRotado2));
        int numRotaciones = contarRotaciones(arrRotado2);
        System.out.println("Número de rotaciones: " + numRotaciones);
        verificar(numRotaciones == 3, "contar rotaciones");

        // Resumen
        System.out.println("\n" + "=".repeat(40));
        System.out.println("¡EJERCICIO COMPLETADO!");
        System.out.println("Has dominado las rotaciones de arrays!");
        System.out.println("=".repeat(40));
    }

    /**
     * TODO: Implementa este método
     * Rota el array k posiciones a la DERECHA usando un array auxiliar
     *
     * Ejemplo: [1,2,3,4,5] rotado 2 -> [4,5,1,2,3]
     * Los últimos 2 elementos van al principio
     *
     * Algoritmo:
     * 1. Crear nuevo array del mismo tamaño
     * 2. Copiar últimos k elementos al inicio del nuevo array
     * 3. Copiar primeros n-k elementos después
     *
     * @param arr Array original
     * @param k Número de posiciones a rotar
     * @return Nuevo array rotado
     */
    public static int[] rotarDerechaConArray(int[] arr, int k) {
        // TU CÓDIGO AQUÍ
        int n = arr.length;
        k = k % n;  // Por si k > n

        int[] rotado = new int[n];

        // Copiar últimos k elementos al principio
        for (int i = 0; i < k; i++) {
            rotado[i] = arr[n - k + i];
        }

        // Copiar primeros n-k elementos después
        for (int i = 0; i < n - k; i++) {
            rotado[k + i] = arr[i];
        }

        return rotado;
        // Elimina esta línea y escribe tu solución arriba
    }

    /**
     * TODO: Implementa este método
     * Rota in-place usando la técnica de 3 INVERSIONES
     *
     * Truco ingenioso para [1,2,3,4,5,6,7] rotado 3:
     * 1. Invertir todo: [7,6,5,4,3,2,1]
     * 2. Invertir primeros k: [5,6,7,4,3,2,1]
     * 3. Invertir resto: [5,6,7,1,2,3,4] ✓
     *
     * Pista: usa el método auxiliar invertirRango() proporcionado
     *
     * @param arr Array a rotar (se modifica)
     * @param k Número de posiciones
     */
    public static void rotarDerechaInPlace(int[] arr, int k) {
        // TU CÓDIGO AQUÍ
        int n = arr.length;
        k = k % n;

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
     * Rota k posiciones a la IZQUIERDA
     *
     * Ejemplo: [1,2,3,4,5] rotado 2 -> [3,4,5,1,2]
     * Los primeros 2 elementos van al final
     *
     * Pista: rotar izquierda k = rotar derecha n-k
     * O usa el truco de inversiones adaptado
     *
     * @param arr Array a rotar
     * @param k Número de posiciones
     */
    public static void rotarIzquierda(int[] arr, int k) {
        // TU CÓDIGO AQUÍ
        int n = arr.length;
        k = k % n;

        // Método 1: Usar rotación derecha
        // rotarDerechaInPlace(arr, n - k);

        // Método 2: Inversiones (similar pero orden diferente)
        invertirRango(arr, 0, k - 1);      // Invertir primeros k
        invertirRango(arr, k, n - 1);      // Invertir resto
        invertirRango(arr, 0, n - 1);      // Invertir todo

        // Elimina esta línea y escribe tu solución arriba
    }

    /**
     * TODO: Implementa este método
     * Rota el array UNA posición a la derecha
     * (Forma simple, sin usar inversiones)
     *
     * Ejemplo: [1,2,3,4,5] -> [5,1,2,3,4]
     *
     * Algoritmo:
     * 1. Guardar el último elemento
     * 2. Mover todos los elementos una posición a la derecha
     * 3. Poner el último en la primera posición
     *
     * @param arr Array a rotar
     */
    public static void rotarDerechaUno(int[] arr) {
        // TU CÓDIGO AQUÍ
        if (arr.length <= 1) return;

        int ultimo = arr[arr.length - 1];  // Guardar último

        // Mover todos una posición a la derecha
        for (int i = arr.length - 1; i > 0; i--) {
            arr[i] = arr[i - 1];
        }

        arr[0] = ultimo;  // Poner último al principio
        // Elimina esta línea y escribe tu solución arriba
    }

    /**
     * TODO: Implementa este método (DESAFÍO)
     * Busca un elemento en un array ORDENADO que fue ROTADO
     *
     * Ejemplo: [4,5,6,7,0,1,2] es [0,1,2,3,4,5,6,7] rotado
     *
     * Puedes hacerlo en O(n) con búsqueda lineal simple
     * DESAFÍO EXTRA: ¿Puedes hacerlo en O(log n)?
     *
     * @param arr Array ordenado rotado
     * @param objetivo Valor a buscar
     * @return Índice del elemento, o -1 si no existe
     */
    public static int buscarEnArrayRotado(int[] arr, int objetivo) {
        // TU CÓDIGO AQUÍ (solución simple O(n))
        for (int i = 0; i < arr.length; i++) {
            if (arr[i] == objetivo) {
                return i;
            }
        }
        return -1;

        /* DESAFÍO: Solución O(log n) con búsqueda binaria modificada
        int izq = 0, der = arr.length - 1;

        while (izq <= der) {
            int mid = izq + (der - izq) / 2;

            if (arr[mid] == objetivo) return mid;

            // Determinar qué mitad está ordenada
            if (arr[izq] <= arr[mid]) {  // Mitad izquierda ordenada
                if (objetivo >= arr[izq] && objetivo < arr[mid]) {
                    der = mid - 1;
                } else {
                    izq = mid + 1;
                }
            } else {  // Mitad derecha ordenada
                if (objetivo > arr[mid] && objetivo <= arr[der]) {
                    izq = mid + 1;
                } else {
                    der = mid - 1;
                }
            }
        }
        return -1;
        */
    }

    /**
     * TODO: Implementa este método (DESAFÍO)
     * Determina cuántas veces fue rotado un array ordenado
     *
     * Pista: El número de rotaciones = índice del elemento mínimo
     * [4,5,6,7,0,1,2] -> el mínimo (0) está en índice 4 = 4 rotaciones
     *
     * @param arr Array ordenado rotado
     * @return Número de rotaciones
     */
    public static int contarRotaciones(int[] arr) {
        // TU CÓDIGO AQUÍ
        int minimo = arr[0];
        int indiceMinimo = 0;

        for (int i = 1; i < arr.length; i++) {
            if (arr[i] < minimo) {
                minimo = arr[i];
                indiceMinimo = i;
            }
        }

        return indiceMinimo;
        // Elimina esta línea y escribe tu solución arriba
    }

    // ========================================
    // MÉTODO AUXILIAR
    // ========================================

    /**
     * Invierte un rango del array
     * Útil para rotaciones
     */
    private static void invertirRango(int[] arr, int inicio, int fin) {
        while (inicio < fin) {
            int temp = arr[inicio];
            arr[inicio] = arr[fin];
            arr[fin] = temp;
            inicio++;
            fin--;
        }
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
 * 1. ROTACIÓN DERECHA vs IZQUIERDA:
 *    - Derecha k = Izquierda (n-k)
 *    - Son operaciones equivalentes
 *
 * 2. TÉCNICA DE 3 INVERSIONES:
 *    - Método elegante y eficiente
 *    - Tiempo: O(n), Espacio: O(1)
 *    - Evita usar array auxiliar
 *
 * 3. MANEJO DE k > n:
 *    - SIEMPRE hacer k = k % n
 *    - Rotar 12 posiciones en array de 5 = rotar 2
 *
 * 4. ARRAYS ROTADOS ORDENADOS:
 *    - Problema común en entrevistas
 *    - Búsqueda binaria modificada: O(log n)
 *
 * DESAFÍOS ADICIONALES:
 * =====================
 *
 * 1. Implementa esRotacion(arr1, arr2) que verifica si arr2 es
 *    una rotación de arr1
 *    Ejemplo: [1,2,3,4,5] y [3,4,5,1,2] -> true
 *
 * 2. Implementa rotarPorBloques(arr, tamañoBloque) que rota
 *    bloques del array
 *    Ejemplo: [1,2,3,4,5,6], bloques=2 -> [5,6,1,2,3,4]
 *
 * 3. Optimiza buscarEnArrayRotado() para que sea O(log n)
 *    usando búsqueda binaria modificada
 */
