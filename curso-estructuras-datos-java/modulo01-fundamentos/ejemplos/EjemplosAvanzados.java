/**
 * MÓDULO 1: FUNDAMENTOS Y ARRAYS
 * Ejemplo 5: Técnicas Avanzadas con Arrays
 *
 * Este programa demuestra técnicas más sofisticadas:
 * - Rotación de arrays
 * - Inversión
 * - Dos punteros (two pointers)
 * - Ventana deslizante (sliding window)
 * - Problemas comunes de entrevistas
 */

public class EjemplosAvanzados {

    public static void main(String[] args) {
        System.out.println("=== TÉCNICAS AVANZADAS CON ARRAYS ===\n");

        // ==========================================
        // 1. ROTACIÓN DE ARRAYS
        // ==========================================
        System.out.println("=== 1. ROTACIÓN DE ARRAYS ===");

        int[] arr1 = {1, 2, 3, 4, 5, 6, 7};
        System.out.println("Array original:");
        imprimirArray(arr1);

        int[] rotado = rotarDerecha(arr1, 3);
        System.out.println("\nRotado 3 posiciones a la derecha:");
        imprimirArray(rotado);

        int[] arr2 = {1, 2, 3, 4, 5, 6, 7};
        rotarDerechaEnSitio(arr2, 3);
        System.out.println("\nRotación en sitio (sin array extra):");
        imprimirArray(arr2);

        // ==========================================
        // 2. INVERSIÓN DE ARRAY
        // ==========================================
        System.out.println("\n\n=== 2. INVERSIÓN DE ARRAY ===");

        int[] arr3 = {1, 2, 3, 4, 5};
        System.out.println("Original:");
        imprimirArray(arr3);

        invertir(arr3);
        System.out.println("Invertido:");
        imprimirArray(arr3);

        // ==========================================
        // 3. TÉCNICA DE DOS PUNTEROS
        // ==========================================
        System.out.println("\n\n=== 3. DOS PUNTEROS (Two Pointers) ===");

        int[] arrOrdenado = {1, 2, 3, 4, 5, 6, 7, 8, 9};
        int objetivo = 10;

        System.out.println("Array ordenado:");
        imprimirArray(arrOrdenado);
        System.out.println("\nBuscando dos números que sumen: " + objetivo);

        int[] par = encontrarParQueSuma(arrOrdenado, objetivo);
        if (par != null) {
            System.out.println("✓ Encontrado: " + par[0] + " + " + par[1] + " = " + objetivo);
        } else {
            System.out.println("✗ No se encontró ningún par");
        }

        // ==========================================
        // 4. MOVER CEROS AL FINAL
        // ==========================================
        System.out.println("\n\n=== 4. MOVER CEROS AL FINAL ===");

        int[] arrConCeros = {0, 1, 0, 3, 12, 0, 5};
        System.out.println("Original:");
        imprimirArray(arrConCeros);

        moverCerosAlFinal(arrConCeros);
        System.out.println("Ceros movidos al final:");
        imprimirArray(arrConCeros);

        // ==========================================
        // 5. ELIMINAR DUPLICADOS (Array ordenado)
        // ==========================================
        System.out.println("\n\n=== 5. ELIMINAR DUPLICADOS ===");

        int[] arrDuplicados = {1, 1, 2, 2, 2, 3, 4, 4, 5};
        System.out.println("Original (con duplicados):");
        imprimirArray(arrDuplicados);

        int nuevaLongitud = eliminarDuplicados(arrDuplicados);
        System.out.println("\nSin duplicados (primeros " + nuevaLongitud + " elementos):");
        imprimirArrayHasta(arrDuplicados, nuevaLongitud);

        // ==========================================
        // 6. VENTANA DESLIZANTE (Sliding Window)
        // ==========================================
        System.out.println("\n\n=== 6. VENTANA DESLIZANTE (Sliding Window) ===");

        int[] arrVentana = {2, 1, 5, 1, 3, 2};
        int k = 3;

        System.out.println("Array:");
        imprimirArray(arrVentana);
        System.out.println("\nTamaño de ventana: " + k);

        double maxPromedio = maximoPromedioSubarray(arrVentana, k);
        System.out.println("Máximo promedio de " + k + " elementos consecutivos: " + maxPromedio);

        // ==========================================
        // 7. ENCONTRAR ELEMENTO FALTANTE
        // ==========================================
        System.out.println("\n\n=== 7. ENCONTRAR NÚMERO FALTANTE ===");

        int[] arrIncompleto = {1, 2, 3, 5, 6, 7, 8, 9, 10};  // Falta el 4
        System.out.println("Array (del 1 al 10, falta uno):");
        imprimirArray(arrIncompleto);

        int faltante = encontrarNumeroFaltante(arrIncompleto, 10);
        System.out.println("Número faltante: " + faltante);

        // ==========================================
        // 8. PRODUCTO DE ARRAY EXCEPTO SÍ MISMO
        // ==========================================
        System.out.println("\n\n=== 8. PRODUCTO EXCEPTO SÍ MISMO ===");

        int[] nums = {1, 2, 3, 4};
        System.out.println("Array original:");
        imprimirArray(nums);

        int[] productos = productoExceptoSiMismo(nums);
        System.out.println("\nProducto de todos excepto sí mismo:");
        imprimirArray(productos);
        System.out.println("(Posición 0: 2*3*4=24, Posición 1: 1*3*4=12, etc.)");

        // ==========================================
        // 9. SUBARREGLO DE SUMA MÁXIMA (Kadane)
        // ==========================================
        System.out.println("\n\n=== 9. SUMA MÁXIMA DE SUBARREGLO (Kadane) ===");

        int[] arrKadane = {-2, 1, -3, 4, -1, 2, 1, -5, 4};
        System.out.println("Array:");
        imprimirArray(arrKadane);

        int sumaMax = sumaMaximaSubarray(arrKadane);
        System.out.println("\nSuma máxima de subarreglo continuo: " + sumaMax);
        System.out.println("(Subarreglo [4, -1, 2, 1] suma 6)");

        // ==========================================
        // 10. FUSIONAR DOS ARRAYS ORDENADOS
        // ==========================================
        System.out.println("\n\n=== 10. FUSIONAR ARRAYS ORDENADOS ===");

        int[] arr4 = {1, 3, 5, 7};
        int[] arr5 = {2, 4, 6, 8};

        System.out.println("Array 1:");
        imprimirArray(arr4);
        System.out.println("Array 2:");
        imprimirArray(arr5);

        int[] fusionado = fusionarOrdenados(arr4, arr5);
        System.out.println("\nArray fusionado (ordenado):");
        imprimirArray(fusionado);
    }

    /**
     * ROTACIÓN A LA DERECHA
     * Mueve elementos k posiciones a la derecha (circular)
     * Ejemplo: [1,2,3,4,5] rotado 2 -> [4,5,1,2,3]
     * Complejidad: O(n) tiempo, O(n) espacio
     */
    public static int[] rotarDerecha(int[] arr, int k) {
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
    }

    /**
     * ROTACIÓN EN SITIO (sin array auxiliar)
     * Usa el truco de 3 inversiones
     * Complejidad: O(n) tiempo, O(1) espacio
     */
    public static void rotarDerechaEnSitio(int[] arr, int k) {
        int n = arr.length;
        k = k % n;

        // 1. Invertir todo el array
        invertirRango(arr, 0, n - 1);
        // 2. Invertir primeros k elementos
        invertirRango(arr, 0, k - 1);
        // 3. Invertir elementos restantes
        invertirRango(arr, k, n - 1);
    }

    /**
     * INVERTIR ARRAY completo
     * Usa técnica de dos punteros
     * Complejidad: O(n)
     */
    public static void invertir(int[] arr) {
        invertirRango(arr, 0, arr.length - 1);
    }

    /**
     * Invertir un rango del array
     * Auxiliar para rotación
     */
    private static void invertirRango(int[] arr, int inicio, int fin) {
        while (inicio < fin) {
            // Intercambiar elementos
            int temp = arr[inicio];
            arr[inicio] = arr[fin];
            arr[fin] = temp;

            inicio++;
            fin--;
        }
    }

    /**
     * DOS PUNTEROS: Encontrar par que suma objetivo
     * Funciona solo si el array está ORDENADO
     * Complejidad: O(n) - mucho mejor que O(n²) con bucles anidados
     */
    public static int[] encontrarParQueSuma(int[] arr, int objetivo) {
        int izq = 0;
        int der = arr.length - 1;

        while (izq < der) {
            int suma = arr[izq] + arr[der];

            if (suma == objetivo) {
                return new int[]{arr[izq], arr[der]};  // ¡Encontrado!
            }
            else if (suma < objetivo) {
                izq++;  // Necesitamos una suma mayor
            }
            else {
                der--;  // Necesitamos una suma menor
            }
        }

        return null;  // No encontrado
    }

    /**
     * MOVER CEROS AL FINAL
     * Mantiene el orden relativo de los no-ceros
     * Complejidad: O(n) tiempo, O(1) espacio
     */
    public static void moverCerosAlFinal(int[] arr) {
        int posicionNoZero = 0;  // Posición donde colocar próximo no-cero

        // Primera pasada: mover todos los no-ceros al frente
        for (int i = 0; i < arr.length; i++) {
            if (arr[i] != 0) {
                arr[posicionNoZero] = arr[i];
                posicionNoZero++;
            }
        }

        // Segunda pasada: llenar el resto con ceros
        for (int i = posicionNoZero; i < arr.length; i++) {
            arr[i] = 0;
        }
    }

    /**
     * ELIMINAR DUPLICADOS (Array ordenado)
     * Modifica el array in-place, retorna nueva longitud
     * Complejidad: O(n)
     */
    public static int eliminarDuplicados(int[] arr) {
        if (arr.length == 0) return 0;

        int posicionUnica = 0;  // Índice del próximo elemento único

        for (int i = 1; i < arr.length; i++) {
            if (arr[i] != arr[posicionUnica]) {
                posicionUnica++;
                arr[posicionUnica] = arr[i];
            }
        }

        return posicionUnica + 1;  // Longitud del array sin duplicados
    }

    /**
     * VENTANA DESLIZANTE: Máximo promedio de k elementos consecutivos
     * Técnica eficiente para problemas de subarrays
     * Complejidad: O(n) - solo una pasada
     */
    public static double maximoPromedioSubarray(int[] arr, int k) {
        // Calcular suma de la primera ventana
        int sumaVentana = 0;
        for (int i = 0; i < k; i++) {
            sumaVentana += arr[i];
        }

        int sumaMaxima = sumaVentana;

        // Deslizar la ventana
        for (int i = k; i < arr.length; i++) {
            sumaVentana += arr[i] - arr[i - k];  // Agregar nuevo, quitar viejo
            sumaMaxima = Math.max(sumaMaxima, sumaVentana);
        }

        return (double) sumaMaxima / k;
    }

    /**
     * ENCONTRAR NÚMERO FALTANTE (1 a n)
     * Usa la fórmula de suma de Gauss: n(n+1)/2
     * Complejidad: O(n) tiempo, O(1) espacio
     */
    public static int encontrarNumeroFaltante(int[] arr, int n) {
        int sumaEsperada = n * (n + 1) / 2;
        int sumaActual = 0;

        for (int num : arr) {
            sumaActual += num;
        }

        return sumaEsperada - sumaActual;
    }

    /**
     * PRODUCTO EXCEPTO SÍ MISMO
     * Calcula producto de todos los elementos excepto el actual
     * Sin usar división (desafío común en entrevistas)
     * Complejidad: O(n) tiempo, O(n) espacio
     */
    public static int[] productoExceptoSiMismo(int[] nums) {
        int n = nums.length;
        int[] resultado = new int[n];

        // Primera pasada: productos de izquierda
        resultado[0] = 1;
        for (int i = 1; i < n; i++) {
            resultado[i] = resultado[i - 1] * nums[i - 1];
        }

        // Segunda pasada: multiplicar por productos de derecha
        int productoDerecha = 1;
        for (int i = n - 1; i >= 0; i--) {
            resultado[i] *= productoDerecha;
            productoDerecha *= nums[i];
        }

        return resultado;
    }

    /**
     * ALGORITMO DE KADANE
     * Encuentra la suma máxima de un subarreglo continuo
     * Complejidad: O(n) - muy eficiente
     */
    public static int sumaMaximaSubarray(int[] arr) {
        int sumaMaxima = arr[0];
        int sumaActual = arr[0];

        for (int i = 1; i < arr.length; i++) {
            // Decidir: ¿continuar subarreglo o empezar nuevo?
            sumaActual = Math.max(arr[i], sumaActual + arr[i]);
            sumaMaxima = Math.max(sumaMaxima, sumaActual);
        }

        return sumaMaxima;
    }

    /**
     * FUSIONAR DOS ARRAYS ORDENADOS
     * Técnica usada en Merge Sort
     * Complejidad: O(n + m)
     */
    public static int[] fusionarOrdenados(int[] arr1, int[] arr2) {
        int n1 = arr1.length;
        int n2 = arr2.length;
        int[] resultado = new int[n1 + n2];

        int i = 0, j = 0, k = 0;

        // Fusionar mientras ambos arrays tienen elementos
        while (i < n1 && j < n2) {
            if (arr1[i] <= arr2[j]) {
                resultado[k++] = arr1[i++];
            } else {
                resultado[k++] = arr2[j++];
            }
        }

        // Copiar elementos restantes de arr1
        while (i < n1) {
            resultado[k++] = arr1[i++];
        }

        // Copiar elementos restantes de arr2
        while (j < n2) {
            resultado[k++] = arr2[j++];
        }

        return resultado;
    }

    /**
     * Imprime un array completo
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

    /**
     * Imprime solo los primeros n elementos
     */
    public static void imprimirArrayHasta(int[] arr, int n) {
        System.out.print("[");
        for (int i = 0; i < n; i++) {
            System.out.print(arr[i]);
            if (i < n - 1) {
                System.out.print(", ");
            }
        }
        System.out.println("]");
    }
}

/*
 * TÉCNICAS CLAVE APRENDIDAS:
 * ===========================
 *
 * 1. DOS PUNTEROS (Two Pointers):
 *    - Un puntero al inicio, otro al final
 *    - Mueven hacia el centro según condiciones
 *    - Eficiente para arrays ordenados: O(n) vs O(n²)
 *
 * 2. VENTANA DESLIZANTE (Sliding Window):
 *    - Para problemas de subarrays de tamaño fijo
 *    - Mantener suma/producto/etc. en ventana
 *    - Agregar nuevo elemento, quitar el viejo
 *    - O(n) vs O(n*k) con enfoque naive
 *
 * 3. ALGORITMO DE KADANE:
 *    - Programación dinámica para suma máxima
 *    - Decidir: continuar o empezar nuevo subarreglo
 *    - Una sola pasada: O(n)
 *
 * 4. MANIPULACIÓN IN-PLACE:
 *    - Modificar array sin usar espacio extra
 *    - Rotaciones, inversiones, reordenamientos
 *    - Espacio O(1) - muy eficiente en memoria
 *
 * ESTAS TÉCNICAS SON FUNDAMENTALES PARA ENTREVISTAS TÉCNICAS!
 */
