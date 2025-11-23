/**
 * EJERCICIO 2: Encontrar Números Mayor y Menor
 * Dificultad: ⭐ Principiante
 *
 * OBJETIVO:
 * Implementar búsquedas de valores máximos y mínimos en arrays
 *
 * INSTRUCCIONES:
 * 1. Completa los métodos marcados con TODO
 * 2. Ejecuta el main() para verificar tus soluciones
 * 3. Todos los tests deben pasar (✓)
 *
 * CONCEPTOS A PRACTICAR:
 * - Búsqueda de máximos/mínimos
 * - Comparaciones
 * - Seguimiento de índices
 * - Validación de datos
 */

public class Ejercicio02_NumeroMayor {

    public static void main(String[] args) {
        System.out.println("=== EJERCICIO 2: ENCONTRAR MAYOR Y MENOR ===\n");

        // Arrays de prueba
        int[] numeros = {45, 12, 78, 23, 89, 34, 67};
        int[] negativos = {-5, -12, -3, -45, -8};

        // Test 1: Encontrar máximo
        System.out.println("Test 1: Encontrar número máximo");
        int max = encontrarMaximo(numeros);
        System.out.println("Máximo de " + arrayAString(numeros) + " = " + max);
        verificar(max == 89, "máximo");

        // Test 2: Encontrar mínimo
        System.out.println("\nTest 2: Encontrar número mínimo");
        int min = encontrarMinimo(numeros);
        System.out.println("Mínimo de " + arrayAString(numeros) + " = " + min);
        verificar(min == 12, "mínimo");

        // Test 3: Encontrar posición del máximo
        System.out.println("\nTest 3: Posición del máximo");
        int posMax = posicionMaximo(numeros);
        System.out.println("Posición del máximo (89) = " + posMax);
        verificar(posMax == 4, "posición máximo");

        // Test 4: Encontrar posición del mínimo
        System.out.println("\nTest 4: Posición del mínimo");
        int posMin = posicionMinimo(numeros);
        System.out.println("Posición del mínimo (12) = " + posMin);
        verificar(posMin == 1, "posición mínimo");

        // Test 5: Diferencia entre máximo y mínimo
        System.out.println("\nTest 5: Diferencia máx-mín");
        int diferencia = diferenciaMaxMin(numeros);
        System.out.println("Diferencia (89 - 12) = " + diferencia);
        verificar(diferencia == 77, "diferencia");

        // Test 6: Segundo número más grande
        System.out.println("\nTest 6: Segundo máximo");
        int segundoMax = segundoMaximo(numeros);
        System.out.println("Segundo máximo = " + segundoMax);
        verificar(segundoMax == 78, "segundo máximo");

        // Test 7: Array con negativos
        System.out.println("\nTest 7: Máximo con números negativos");
        int maxNeg = encontrarMaximo(negativos);
        System.out.println("Máximo de " + arrayAString(negativos) + " = " + maxNeg);
        verificar(maxNeg == -3, "máximo negativos");

        // Resumen
        System.out.println("\n" + "=".repeat(40));
        System.out.println("¡EJERCICIO COMPLETADO!");
        System.out.println("=".repeat(40));
    }

    /**
     * TODO: Implementa este método
     * Encuentra el valor máximo en el array
     *
     * Algoritmo:
     * 1. Asumir que el primer elemento es el máximo
     * 2. Recorrer el resto del array
     * 3. Si encuentras un número mayor, actualizar máximo
     *
     * @param arr Array de enteros
     * @return El valor máximo
     */
    public static int encontrarMaximo(int[] arr) {
        // TU CÓDIGO AQUÍ
        if (arr.length == 0) {
            throw new IllegalArgumentException("Array vacío");
        }

        int maximo = arr[0];  // Asumimos que el primero es el máximo
        for (int i = 1; i < arr.length; i++) {
            if (arr[i] > maximo) {
                maximo = arr[i];  // Actualizamos si encontramos uno mayor
            }
        }
        return maximo;
        // Elimina esta línea y escribe tu solución arriba
    }

    /**
     * TODO: Implementa este método
     * Encuentra el valor mínimo en el array
     *
     * @param arr Array de enteros
     * @return El valor mínimo
     */
    public static int encontrarMinimo(int[] arr) {
        // TU CÓDIGO AQUÍ
        if (arr.length == 0) {
            throw new IllegalArgumentException("Array vacío");
        }

        int minimo = arr[0];
        for (int i = 1; i < arr.length; i++) {
            if (arr[i] < minimo) {
                minimo = arr[i];
            }
        }
        return minimo;
        // Elimina esta línea y escribe tu solución arriba
    }

    /**
     * TODO: Implementa este método
     * Encuentra el ÍNDICE (posición) del valor máximo
     *
     * @param arr Array de enteros
     * @return Índice del máximo
     */
    public static int posicionMaximo(int[] arr) {
        // TU CÓDIGO AQUÍ
        if (arr.length == 0) {
            throw new IllegalArgumentException("Array vacío");
        }

        int posicionMax = 0;
        for (int i = 1; i < arr.length; i++) {
            if (arr[i] > arr[posicionMax]) {
                posicionMax = i;  // Guardamos el ÍNDICE, no el valor
            }
        }
        return posicionMax;
        // Elimina esta línea y escribe tu solución arriba
    }

    /**
     * TODO: Implementa este método
     * Encuentra el ÍNDICE del valor mínimo
     *
     * @param arr Array de enteros
     * @return Índice del mínimo
     */
    public static int posicionMinimo(int[] arr) {
        // TU CÓDIGO AQUÍ
        if (arr.length == 0) {
            throw new IllegalArgumentException("Array vacío");
        }

        int posicionMin = 0;
        for (int i = 1; i < arr.length; i++) {
            if (arr[i] < arr[posicionMin]) {
                posicionMin = i;
            }
        }
        return posicionMin;
        // Elimina esta línea y escribe tu solución arriba
    }

    /**
     * TODO: Implementa este método
     * Calcula la diferencia entre el máximo y el mínimo
     * (También conocido como "rango" del array)
     *
     * @param arr Array de enteros
     * @return Diferencia máximo - mínimo
     */
    public static int diferenciaMaxMin(int[] arr) {
        // TU CÓDIGO AQUÍ
        // Pista: puedes reutilizar los métodos que ya creaste
        int maximo = encontrarMaximo(arr);
        int minimo = encontrarMinimo(arr);
        return maximo - minimo;
        // Elimina esta línea y escribe tu solución arriba
    }

    /**
     * TODO: Implementa este método (DESAFÍO)
     * Encuentra el segundo número más grande
     *
     * Pista: mantén dos variables: max y segundoMax
     *
     * @param arr Array de enteros
     * @return Segundo valor máximo
     */
    public static int segundoMaximo(int[] arr) {
        // TU CÓDIGO AQUÍ
        if (arr.length < 2) {
            throw new IllegalArgumentException("Se necesitan al menos 2 elementos");
        }

        int max = Integer.MIN_VALUE;
        int segundoMax = Integer.MIN_VALUE;

        for (int num : arr) {
            if (num > max) {
                segundoMax = max;  // El viejo máximo es ahora el segundo
                max = num;         // Nuevo máximo
            }
            else if (num > segundoMax && num != max) {
                segundoMax = num;
            }
        }

        return segundoMax;
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
 * DESAFÍOS ADICIONALES:
 * =====================
 *
 * 1. Implementa encontrarKMayores(arr, k) que retorna los k números más grandes
 *    Ejemplo: arr=[5,1,8,3,9], k=3 -> [9,8,5]
 *
 * 2. Implementa segundoMinimo(arr) para encontrar el segundo número más pequeño
 *
 * 3. Implementa encontrarPicos(arr) que encuentra números mayores que sus vecinos
 *    Ejemplo: [1,3,2,5,4] -> [3,5] (3>1 y 3>2, 5>2 y 5>4)
 *
 * 4. Implementa esMinimoLocal(arr, indice) que verifica si un elemento es menor
 *    que sus vecinos
 *
 * ERRORES COMUNES A EVITAR:
 * - No validar array vacío (puede causar errores)
 * - No inicializar max/min correctamente (usar arr[0], no 0)
 * - Confundir valor con índice (posición)
 * - En segundoMaximo, olvidar el caso num == max
 */
