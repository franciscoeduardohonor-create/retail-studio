/**
 * MÓDULO 1: FUNDAMENTOS Y ARRAYS
 * Ejemplo 2: Algoritmos de Búsqueda en Arrays
 *
 * Este programa implementa y compara diferentes algoritmos de búsqueda:
 * - Búsqueda Lineal (Secuencial)
 * - Búsqueda Binaria (en arrays ordenados)
 * - Comparación de eficiencia
 */

public class BusquedaEnArrays {

    public static void main(String[] args) {
        System.out.println("=== ALGORITMOS DE BÚSQUEDA EN ARRAYS ===\n");

        // Arrays de prueba
        int[] numerosDesordenados = {64, 34, 25, 12, 22, 11, 90, 88};
        int[] numerosOrdenados = {11, 12, 22, 25, 34, 64, 88, 90};

        System.out.println("Array desordenado:");
        imprimirArray(numerosDesordenados);
        System.out.println("\nArray ordenado:");
        imprimirArray(numerosOrdenados);

        // ==========================================
        // 1. BÚSQUEDA LINEAL (Secuencial)
        // ==========================================
        System.out.println("\n=== BÚSQUEDA LINEAL ===");
        System.out.println("Funciona con arrays ordenados y desordenados");
        System.out.println("Complejidad: O(n) - peor caso revisa todos los elementos");

        int buscar = 22;
        int posicion = busquedaLineal(numerosDesordenados, buscar);

        if (posicion != -1) {
            System.out.println("\n✓ Número " + buscar + " encontrado en posición: " + posicion);
        } else {
            System.out.println("\n✗ Número " + buscar + " NO encontrado");
        }

        // Buscar elemento inexistente
        buscar = 100;
        posicion = busquedaLineal(numerosDesordenados, buscar);
        if (posicion != -1) {
            System.out.println("✓ Número " + buscar + " encontrado en posición: " + posicion);
        } else {
            System.out.println("✗ Número " + buscar + " NO encontrado");
        }

        // ==========================================
        // 2. BÚSQUEDA BINARIA (Divide y Vencerás)
        // ==========================================
        System.out.println("\n=== BÚSQUEDA BINARIA ===");
        System.out.println("REQUIERE array ORDENADO");
        System.out.println("Complejidad: O(log n) - mucho más rápida");
        System.out.println("Divide el espacio de búsqueda a la mitad en cada paso\n");

        buscar = 34;
        posicion = busquedaBinariaIterativa(numerosOrdenados, buscar);

        if (posicion != -1) {
            System.out.println("✓ Número " + buscar + " encontrado en posición: " + posicion);
        } else {
            System.out.println("✗ Número " + buscar + " NO encontrado");
        }

        // Versión recursiva
        buscar = 88;
        posicion = busquedaBinariaRecursiva(numerosOrdenados, buscar, 0,
                                             numerosOrdenados.length - 1);

        if (posicion != -1) {
            System.out.println("✓ Número " + buscar + " encontrado en posición: "
                              + posicion + " (búsqueda recursiva)");
        }

        // ==========================================
        // 3. COMPARACIÓN DE EFICIENCIA
        // ==========================================
        System.out.println("\n=== COMPARACIÓN DE EFICIENCIA ===");
        compararAlgoritmos();

        // ==========================================
        // 4. BÚSQUEDAS ADICIONALES
        // ==========================================
        System.out.println("\n=== BÚSQUEDAS ESPECIALES ===");

        // Encontrar todas las ocurrencias
        int[] conDuplicados = {5, 2, 8, 2, 9, 2, 3, 2};
        System.out.println("\nArray con duplicados:");
        imprimirArray(conDuplicados);

        int[] posiciones = encontrarTodasOcurrencias(conDuplicados, 2);
        System.out.print("Número 2 encontrado en posiciones: ");
        imprimirArray(posiciones);

        // Verificar si existe (retorna boolean)
        boolean existe = existeElemento(numerosOrdenados, 64);
        System.out.println("\n¿Existe el 64 en el array? " + existe);

        existe = existeElemento(numerosOrdenados, 100);
        System.out.println("¿Existe el 100 en el array? " + existe);
    }

    /**
     * BÚSQUEDA LINEAL (Secuencial)
     * Recorre el array elemento por elemento hasta encontrar el valor
     *
     * Ventajas:
     * - Funciona con arrays ordenados y desordenados
     * - Simple de implementar
     *
     * Desventajas:
     * - Lenta para arrays grandes
     * - Complejidad: O(n)
     *
     * @param arr Array donde buscar
     * @param objetivo Valor a buscar
     * @return Índice del elemento o -1 si no se encuentra
     */
    public static int busquedaLineal(int[] arr, int objetivo) {
        // Recorremos cada elemento del array
        for (int i = 0; i < arr.length; i++) {
            if (arr[i] == objetivo) {
                return i;  // Encontrado! Retornamos la posición
            }
        }
        return -1;  // No encontrado
    }

    /**
     * BÚSQUEDA BINARIA (Versión Iterativa)
     * Busca eficientemente en un array ORDENADO dividiendo el espacio a la mitad
     *
     * Algoritmo:
     * 1. Comenzar con inicio=0 y fin=tamaño-1
     * 2. Calcular medio = (inicio + fin) / 2
     * 3. Si arr[medio] == objetivo: ¡encontrado!
     * 4. Si arr[medio] < objetivo: buscar en mitad derecha (inicio = medio+1)
     * 5. Si arr[medio] > objetivo: buscar en mitad izquierda (fin = medio-1)
     * 6. Repetir hasta encontrar o hasta que inicio > fin
     *
     * Complejidad: O(log n)
     * Para un array de 1,000,000 elementos, solo necesita ~20 comparaciones
     *
     * @param arr Array ORDENADO donde buscar
     * @param objetivo Valor a buscar
     * @return Índice del elemento o -1 si no se encuentra
     */
    public static int busquedaBinariaIterativa(int[] arr, int objetivo) {
        int inicio = 0;
        int fin = arr.length - 1;

        while (inicio <= fin) {
            // Calculamos el índice medio
            int medio = inicio + (fin - inicio) / 2;  // Evita overflow

            System.out.println("  Buscando entre índices " + inicio + " y " + fin +
                             " (medio: " + medio + ", valor: " + arr[medio] + ")");

            // Verificamos si encontramos el objetivo
            if (arr[medio] == objetivo) {
                return medio;  // ¡Encontrado!
            }

            // Si el objetivo es mayor, ignoramos la mitad izquierda
            if (arr[medio] < objetivo) {
                inicio = medio + 1;
            }
            // Si el objetivo es menor, ignoramos la mitad derecha
            else {
                fin = medio - 1;
            }
        }

        return -1;  // No encontrado
    }

    /**
     * BÚSQUEDA BINARIA (Versión Recursiva)
     * Misma lógica que la iterativa pero usando recursión
     *
     * @param arr Array ORDENADO donde buscar
     * @param objetivo Valor a buscar
     * @param inicio Índice inicial del rango de búsqueda
     * @param fin Índice final del rango de búsqueda
     * @return Índice del elemento o -1 si no se encuentra
     */
    public static int busquedaBinariaRecursiva(int[] arr, int objetivo,
                                                int inicio, int fin) {
        // Caso base: rango inválido, no encontrado
        if (inicio > fin) {
            return -1;
        }

        // Calcular índice medio
        int medio = inicio + (fin - inicio) / 2;

        // Caso base: encontrado
        if (arr[medio] == objetivo) {
            return medio;
        }

        // Caso recursivo: buscar en mitad derecha
        if (arr[medio] < objetivo) {
            return busquedaBinariaRecursiva(arr, objetivo, medio + 1, fin);
        }

        // Caso recursivo: buscar en mitad izquierda
        return busquedaBinariaRecursiva(arr, objetivo, inicio, medio - 1);
    }

    /**
     * Encuentra todas las ocurrencias de un valor en el array
     * Útil cuando hay duplicados
     *
     * @param arr Array donde buscar
     * @param objetivo Valor a buscar
     * @return Array con los índices de todas las ocurrencias
     */
    public static int[] encontrarTodasOcurrencias(int[] arr, int objetivo) {
        // Primera pasada: contar ocurrencias
        int contador = 0;
        for (int num : arr) {
            if (num == objetivo) {
                contador++;
            }
        }

        // Crear array del tamaño necesario
        int[] posiciones = new int[contador];

        // Segunda pasada: guardar posiciones
        int indice = 0;
        for (int i = 0; i < arr.length; i++) {
            if (arr[i] == objetivo) {
                posiciones[indice++] = i;
            }
        }

        return posiciones;
    }

    /**
     * Verifica si un elemento existe en el array
     * Más limpio semánticamente cuando solo necesitas saber si existe
     *
     * @param arr Array donde buscar
     * @param objetivo Valor a buscar
     * @return true si existe, false si no
     */
    public static boolean existeElemento(int[] arr, int objetivo) {
        return busquedaLineal(arr, objetivo) != -1;
    }

    /**
     * Compara la eficiencia de búsqueda lineal vs binaria
     */
    public static void compararAlgoritmos() {
        // Crear un array grande ordenado
        int tamanio = 100000;
        int[] arrayGrande = new int[tamanio];
        for (int i = 0; i < tamanio; i++) {
            arrayGrande[i] = i * 2;  // 0, 2, 4, 6, 8, ...
        }

        int buscar = 99998;  // Casi al final

        // Búsqueda Lineal
        long inicioLineal = System.nanoTime();
        int resultadoLineal = busquedaLineal(arrayGrande, buscar);
        long finLineal = System.nanoTime();
        long tiempoLineal = finLineal - inicioLineal;

        // Búsqueda Binaria
        long inicioBinaria = System.nanoTime();
        int resultadoBinaria = busquedaBinariaIterativa(arrayGrande, buscar);
        long finBinaria = System.nanoTime();
        long tiempoBinaria = finBinaria - inicioBinaria;

        System.out.println("Array de " + tamanio + " elementos");
        System.out.println("Buscando el valor: " + buscar);
        System.out.println("\nBúsqueda Lineal:");
        System.out.println("  Resultado: posición " + resultadoLineal);
        System.out.println("  Tiempo: " + tiempoLineal + " nanosegundos");

        System.out.println("\nBúsqueda Binaria:");
        System.out.println("  Resultado: posición " + resultadoBinaria);
        System.out.println("  Tiempo: " + tiempoBinaria + " nanosegundos");

        System.out.println("\n¡Búsqueda binaria es " +
                          (tiempoLineal / tiempoBinaria) + "x más rápida!");
    }

    /**
     * Imprime un array
     */
    public static void imprimirArray(int[] arr) {
        System.out.print("[");
        for (int i = 0; i < arr.length; i++) {
            System.out.print(arr[i]);
            if (i < arr.length - 1) {
                System.out.print(", ");
            }
        }
        System.out.println("]");
    }
}

/*
 * PUNTOS CLAVE PARA RECORDAR:
 * ============================
 *
 * 1. BÚSQUEDA LINEAL:
 *    - Complejidad: O(n)
 *    - Funciona con cualquier array
 *    - Simple pero lenta para arrays grandes
 *
 * 2. BÚSQUEDA BINARIA:
 *    - Complejidad: O(log n)
 *    - REQUIERE array ordenado
 *    - Mucho más rápida (divide y vencerás)
 *    - Para 1 millón de elementos: ~20 comparaciones vs 1 millón
 *
 * 3. CUÁNDO USAR CADA UNA:
 *    - Lineal: arrays pequeños o desordenados
 *    - Binaria: arrays grandes y ordenados
 */
