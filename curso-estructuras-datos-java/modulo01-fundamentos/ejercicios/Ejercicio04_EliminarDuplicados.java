/**
 * EJERCICIO 4: Eliminar Duplicados
 * Dificultad: ⭐⭐ Intermedio
 *
 * OBJETIVO:
 * Aprender diferentes técnicas para eliminar elementos duplicados
 *
 * INSTRUCCIONES:
 * 1. Completa los métodos marcados con TODO
 * 2. Ejecuta el main() para verificar tus soluciones
 * 3. Todos los tests deben pasar (✓)
 *
 * CONCEPTOS A PRACTICAR:
 * - Eliminar duplicados en arrays ordenados
 * - Eliminar duplicados en arrays desordenados
 * - Uso eficiente de memoria
 * - Conteo de elementos únicos
 */

public class Ejercicio04_EliminarDuplicados {

    public static void main(String[] args) {
        System.out.println("=== EJERCICIO 4: ELIMINAR DUPLICADOS ===\n");

        // Test 1: Array ordenado con duplicados
        System.out.println("Test 1: Eliminar duplicados en array ORDENADO");
        int[] ordenado = {1, 1, 2, 2, 2, 3, 4, 4, 5};
        System.out.println("Original: " + arrayAString(ordenado));
        int nuevaLongitud = eliminarDuplicadosOrdenado(ordenado);
        System.out.println("Sin duplicados (primeros " + nuevaLongitud + " elementos):");
        System.out.println(arrayAString(ordenado, nuevaLongitud));
        verificar(nuevaLongitud == 5, "longitud correcta (1,2,3,4,5)");

        // Test 2: Array desordenado
        System.out.println("\nTest 2: Eliminar duplicados en array DESORDENADO");
        int[] desordenado = {4, 2, 5, 2, 1, 4, 3, 1, 5};
        System.out.println("Original: " + arrayAString(desordenado));
        int[] sinDuplicados = eliminarDuplicadosDesordenado(desordenado);
        System.out.println("Sin duplicados: " + arrayAString(sinDuplicados));
        verificar(sinDuplicados.length == 5, "elementos únicos (1,2,3,4,5)");

        // Test 3: Contar elementos únicos
        System.out.println("\nTest 3: Contar elementos únicos");
        int[] arr3 = {5, 2, 8, 2, 9, 2, 3, 5};
        System.out.println("Array: " + arrayAString(arr3));
        int unicos = contarUnicos(arr3);
        System.out.println("Elementos únicos: " + unicos);
        verificar(unicos == 5, "contar únicos (2,3,5,8,9)");

        // Test 4: Verificar si tiene duplicados
        System.out.println("\nTest 4: Verificar si tiene duplicados");
        int[] conDup = {1, 2, 3, 4, 5, 2};
        int[] sinDup = {1, 2, 3, 4, 5};
        System.out.println(arrayAString(conDup) + " ¿tiene duplicados? " +
                          tieneDuplicados(conDup));
        System.out.println(arrayAString(sinDup) + " ¿tiene duplicados? " +
                          tieneDuplicados(sinDup));
        verificar(tieneDuplicados(conDup), "tiene duplicados true");
        verificar(!tieneDuplicados(sinDup), "tiene duplicados false");

        // Test 5: Encontrar primer duplicado
        System.out.println("\nTest 5: Encontrar primer duplicado");
        int[] arr5 = {1, 2, 3, 4, 2, 5, 3};
        System.out.println("Array: " + arrayAString(arr5));
        int primerDup = encontrarPrimerDuplicado(arr5);
        System.out.println("Primer duplicado: " + primerDup);
        verificar(primerDup == 2, "primer duplicado es 2");

        // Test 6: Eliminar duplicados manteniendo primera ocurrencia
        System.out.println("\nTest 6: Mantener solo primera ocurrencia de cada elemento");
        int[] arr6 = {1, 2, 3, 2, 4, 1, 5, 3};
        System.out.println("Original: " + arrayAString(arr6));
        int[] resultado = mantenerPrimeraOcurrencia(arr6);
        System.out.println("Primera ocurrencia: " + arrayAString(resultado));
        // Debe ser [1,2,3,4,5] en ese orden

        // Resumen
        System.out.println("\n" + "=".repeat(40));
        System.out.println("¡EJERCICIO COMPLETADO!");
        System.out.println("=".repeat(40));
    }

    /**
     * TODO: Implementa este método
     * Elimina duplicados de un array ORDENADO (in-place)
     *
     * Técnica: Dos punteros
     * - Un puntero (i) recorre el array
     * - Otro puntero (posUnicos) marca dónde poner el próximo único
     *
     * Ejemplo paso a paso: [1,1,2,2,3,3,3,4]
     * posUnicos=0, arr[0]=1
     * i=1: arr[1]=1 (igual a arr[0]), saltar
     * i=2: arr[2]=2 (diferente), posUnicos++, arr[1]=2
     * i=3: arr[3]=2 (igual a arr[1]), saltar
     * ...
     * Resultado: [1,2,3,4,3,3,3,4] (solo primeros 4 son válidos)
     *
     * @param arr Array ORDENADO con posibles duplicados
     * @return Nueva longitud (cantidad de elementos únicos)
     */
    public static int eliminarDuplicadosOrdenado(int[] arr) {
        // TU CÓDIGO AQUÍ
        if (arr.length == 0) return 0;

        int posUnicos = 0;  // Posición del próximo elemento único

        for (int i = 1; i < arr.length; i++) {
            // Si encontramos un elemento diferente
            if (arr[i] != arr[posUnicos]) {
                posUnicos++;
                arr[posUnicos] = arr[i];
            }
        }

        return posUnicos + 1;  // +1 porque posUnicos es índice
        // Elimina esta línea y escribe tu solución arriba
    }

    /**
     * TODO: Implementa este método
     * Elimina duplicados de un array DESORDENADO
     * Retorna un NUEVO array con solo elementos únicos
     *
     * Algoritmo simple (O(n²)):
     * 1. Contar cuántos elementos son únicos
     * 2. Crear array de ese tamaño
     * 3. Copiar solo elementos únicos
     *
     * Pista: usa el método auxiliar yaExiste() proporcionado
     *
     * @param arr Array desordenado
     * @return Nuevo array con elementos únicos
     */
    public static int[] eliminarDuplicadosDesordenado(int[] arr) {
        // TU CÓDIGO AQUÍ
        if (arr.length == 0) return new int[0];

        // Crear array temporal (tamaño máximo posible)
        int[] temp = new int[arr.length];
        int contador = 0;

        // Copiar solo elementos únicos
        for (int i = 0; i < arr.length; i++) {
            if (!yaExiste(temp, contador, arr[i])) {
                temp[contador] = arr[i];
                contador++;
            }
        }

        // Crear array del tamaño exacto
        int[] resultado = new int[contador];
        for (int i = 0; i < contador; i++) {
            resultado[i] = temp[i];
        }

        return resultado;
        // Elimina esta línea y escribe tu solución arriba
    }

    /**
     * TODO: Implementa este método
     * Cuenta cuántos elementos únicos hay en el array
     *
     * @param arr Array a analizar
     * @return Cantidad de elementos únicos
     */
    public static int contarUnicos(int[] arr) {
        // TU CÓDIGO AQUÍ
        if (arr.length == 0) return 0;

        int[] temp = new int[arr.length];
        int contador = 0;

        for (int num : arr) {
            if (!yaExiste(temp, contador, num)) {
                temp[contador] = num;
                contador++;
            }
        }

        return contador;
        // Elimina esta línea y escribe tu solución arriba
    }

    /**
     * TODO: Implementa este método
     * Verifica si el array tiene elementos duplicados
     *
     * Retorna true en cuanto encuentra el primer duplicado
     * (no necesita revisar todo el array)
     *
     * @param arr Array a verificar
     * @return true si tiene duplicados, false si no
     */
    public static boolean tieneDuplicados(int[] arr) {
        // TU CÓDIGO AQUÍ
        // Comparar cada elemento con los siguientes
        for (int i = 0; i < arr.length - 1; i++) {
            for (int j = i + 1; j < arr.length; j++) {
                if (arr[i] == arr[j]) {
                    return true;  // Encontramos un duplicado
                }
            }
        }
        return false;  // No hay duplicados
        // Elimina esta línea y escribe tu solución arriba
    }

    /**
     * TODO: Implementa este método
     * Encuentra el primer elemento que está duplicado
     *
     * Ejemplo: [1,2,3,4,2,5,3] -> retorna 2
     * (porque 2 aparece en índices 1 y 4, antes que 3 que aparece en 2 y 6)
     *
     * @param arr Array a analizar
     * @return Primer elemento duplicado, o -1 si no hay duplicados
     */
    public static int encontrarPrimerDuplicado(int[] arr) {
        // TU CÓDIGO AQUÍ
        for (int i = 0; i < arr.length - 1; i++) {
            for (int j = i + 1; j < arr.length; j++) {
                if (arr[i] == arr[j]) {
                    return arr[i];  // Primer duplicado encontrado
                }
            }
        }
        return -1;  // No hay duplicados
        // Elimina esta línea y escribe tu solución arriba
    }

    /**
     * TODO: Implementa este método
     * Mantiene solo la PRIMERA ocurrencia de cada elemento
     * (preservando el orden original)
     *
     * Ejemplo: [1,2,3,2,4,1,5,3] -> [1,2,3,4,5]
     *
     * @param arr Array original
     * @return Nuevo array con primera ocurrencia de cada elemento
     */
    public static int[] mantenerPrimeraOcurrencia(int[] arr) {
        // TU CÓDIGO AQUÍ
        // Similar a eliminarDuplicadosDesordenado
        int[] temp = new int[arr.length];
        int contador = 0;

        for (int num : arr) {
            if (!yaExiste(temp, contador, num)) {
                temp[contador] = num;
                contador++;
            }
        }

        // Copiar al array final
        int[] resultado = new int[contador];
        for (int i = 0; i < contador; i++) {
            resultado[i] = temp[i];
        }

        return resultado;
        // Elimina esta línea y escribe tu solución arriba
    }

    // ========================================
    // MÉTODO AUXILIAR
    // ========================================

    /**
     * Verifica si un valor ya existe en los primeros 'longitud' elementos del array
     * Útil para buscar duplicados
     */
    private static boolean yaExiste(int[] arr, int longitud, int valor) {
        for (int i = 0; i < longitud; i++) {
            if (arr[i] == valor) {
                return true;
            }
        }
        return false;
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
        return arrayAString(arr, arr.length);
    }

    private static String arrayAString(int[] arr, int longitud) {
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < longitud; i++) {
            sb.append(arr[i]);
            if (i < longitud - 1) sb.append(", ");
        }
        sb.append("]");
        return sb.toString();
    }
}

/*
 * ANÁLISIS DE COMPLEJIDAD:
 * =========================
 *
 * 1. eliminarDuplicadosOrdenado():
 *    - Tiempo: O(n) - una sola pasada
 *    - Espacio: O(1) - in-place
 *    - ¡Muy eficiente!
 *
 * 2. eliminarDuplicadosDesordenado():
 *    - Tiempo: O(n²) - por el bucle anidado en yaExiste
 *    - Espacio: O(n) - array nuevo
 *    - Menos eficiente, pero funciona
 *
 * 3. tieneDuplicados():
 *    - Tiempo: O(n²) peor caso, O(1) mejor caso
 *    - Se detiene al encontrar el primer duplicado
 *
 * OPTIMIZACIONES POSIBLES:
 * ========================
 *
 * Para arrays desordenados, se puede mejorar usando:
 * - HashSet (estructuras avanzadas): O(n) tiempo
 * - Ordenar primero + eliminar: O(n log n) tiempo
 *
 * Estas técnicas las veremos en módulos posteriores!
 *
 * DESAFÍOS ADICIONALES:
 * =====================
 *
 * 1. Implementa eliminarDuplicadosOrdenandoPrimero(arr) que:
 *    - Ordena el array primero
 *    - Luego elimina duplicados
 *    - ¿Cuál es la complejidad?
 *
 * 2. Implementa encontrarTodosDuplicados(arr) que retorna
 *    un array con todos los valores que están duplicados
 *
 * 3. Implementa frecuencias(arr) que cuenta cuántas veces
 *    aparece cada elemento
 */
