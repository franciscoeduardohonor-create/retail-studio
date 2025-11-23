/**
 * MÓDULO 1: FUNDAMENTOS Y ARRAYS
 * Ejemplo 1: Operaciones Básicas con Arrays
 *
 * Este programa demuestra las operaciones fundamentales con arrays en Java:
 * - Declaración e inicialización
 * - Acceso a elementos
 * - Modificación de elementos
 * - Recorrido (iteración)
 * - Longitud del array
 */

public class ArrayBasico {

    public static void main(String[] args) {
        System.out.println("=== ARRAYS EN JAVA: CONCEPTOS BÁSICOS ===\n");

        // ==========================================
        // 1. DECLARACIÓN E INICIALIZACIÓN
        // ==========================================

        // Forma 1: Declarar y asignar tamaño
        int[] numeros = new int[5];  // Array de 5 enteros (inicializados en 0)
        System.out.println("1. Array declarado con tamaño 5:");
        imprimirArray(numeros);

        // Forma 2: Declarar e inicializar con valores
        int[] edades = {25, 30, 18, 45, 22};  // Array con valores iniciales
        System.out.println("\n2. Array inicializado con valores:");
        imprimirArray(edades);

        // Forma 3: Declaración de String array
        String[] nombres = {"Ana", "Carlos", "María", "Pedro", "Luis"};
        System.out.println("\n3. Array de Strings:");
        imprimirArrayString(nombres);

        // ==========================================
        // 2. ACCESO A ELEMENTOS (Índices de 0 a n-1)
        // ==========================================
        System.out.println("\n=== ACCESO A ELEMENTOS ===");
        System.out.println("Primer elemento (índice 0): " + edades[0]);
        System.out.println("Último elemento (índice " + (edades.length-1) + "): "
                          + edades[edades.length - 1]);
        System.out.println("Elemento en posición 2: " + edades[2]);

        // ==========================================
        // 3. MODIFICACIÓN DE ELEMENTOS
        // ==========================================
        System.out.println("\n=== MODIFICACIÓN DE ELEMENTOS ===");
        System.out.println("Antes: " + nombres[1]);
        nombres[1] = "Roberto";  // Cambiamos "Carlos" por "Roberto"
        System.out.println("Después: " + nombres[1]);

        // Llenar el array 'numeros' con valores
        for (int i = 0; i < numeros.length; i++) {
            numeros[i] = (i + 1) * 10;  // 10, 20, 30, 40, 50
        }
        System.out.println("\nArray numeros después de llenar:");
        imprimirArray(numeros);

        // ==========================================
        // 4. RECORRIDO DE ARRAYS
        // ==========================================
        System.out.println("\n=== FORMAS DE RECORRER UN ARRAY ===");

        // Forma 1: For tradicional (tienes acceso al índice)
        System.out.println("\nFor tradicional:");
        for (int i = 0; i < edades.length; i++) {
            System.out.println("Posición " + i + ": " + edades[i] + " años");
        }

        // Forma 2: For-each (más simple, sin índice)
        System.out.println("\nFor-each:");
        for (int edad : edades) {
            System.out.println("Edad: " + edad);
        }

        // ==========================================
        // 5. OPERACIONES COMUNES
        // ==========================================
        System.out.println("\n=== OPERACIONES COMUNES ===");

        // Calcular suma de elementos
        int suma = calcularSuma(edades);
        System.out.println("Suma de edades: " + suma);

        // Calcular promedio
        double promedio = calcularPromedio(edades);
        System.out.println("Promedio de edades: " + promedio);

        // Encontrar el máximo
        int maximo = encontrarMaximo(edades);
        System.out.println("Edad máxima: " + maximo);

        // Encontrar el mínimo
        int minimo = encontrarMinimo(edades);
        System.out.println("Edad mínima: " + minimo);

        // ==========================================
        // 6. COPIAR ARRAYS
        // ==========================================
        System.out.println("\n=== COPIAR ARRAYS ===");

        // Forma 1: Manual (usando bucle)
        int[] copiaManual = new int[edades.length];
        for (int i = 0; i < edades.length; i++) {
            copiaManual[i] = edades[i];
        }

        // Forma 2: Usando System.arraycopy()
        int[] copiaSystem = new int[edades.length];
        System.arraycopy(edades, 0, copiaSystem, 0, edades.length);

        // Forma 3: Usando Arrays.copyOf()
        int[] copiaArrays = java.util.Arrays.copyOf(edades, edades.length);

        System.out.println("Array original:");
        imprimirArray(edades);
        System.out.println("Copia:");
        imprimirArray(copiaArrays);

        // ==========================================
        // 7. LIMITACIONES DE LOS ARRAYS
        // ==========================================
        System.out.println("\n=== IMPORTANTE: LIMITACIONES ===");
        System.out.println("- Tamaño FIJO: no se puede cambiar después de crear");
        System.out.println("- Insertar/eliminar elementos es costoso (requiere reorganización)");
        System.out.println("- Acceso rápido por índice: O(1) - ¡VENTAJA!");
        System.out.println("- Búsqueda secuencial: O(n) - tiempo lineal");
    }

    /**
     * Imprime todos los elementos de un array de enteros
     * Complejidad: O(n)
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
     * Imprime todos los elementos de un array de Strings
     * Complejidad: O(n)
     */
    public static void imprimirArrayString(String[] arr) {
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
     * Calcula la suma de todos los elementos del array
     * Complejidad: O(n) - debe recorrer todos los elementos
     */
    public static int calcularSuma(int[] arr) {
        int suma = 0;
        for (int num : arr) {
            suma += num;
        }
        return suma;
    }

    /**
     * Calcula el promedio de los elementos del array
     * Complejidad: O(n)
     */
    public static double calcularPromedio(int[] arr) {
        if (arr.length == 0) return 0;
        return (double) calcularSuma(arr) / arr.length;
    }

    /**
     * Encuentra el valor máximo en el array
     * Complejidad: O(n) - debe revisar todos los elementos
     */
    public static int encontrarMaximo(int[] arr) {
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
    }

    /**
     * Encuentra el valor mínimo en el array
     * Complejidad: O(n)
     */
    public static int encontrarMinimo(int[] arr) {
        if (arr.length == 0) {
            throw new IllegalArgumentException("Array vacío");
        }

        int minimo = arr[0];  // Asumimos que el primero es el mínimo
        for (int i = 1; i < arr.length; i++) {
            if (arr[i] < minimo) {
                minimo = arr[i];  // Actualizamos si encontramos uno menor
            }
        }
        return minimo;
    }
}

/*
 * SALIDA ESPERADA:
 * ================
 *
 * === ARRAYS EN JAVA: CONCEPTOS BÁSICOS ===
 *
 * 1. Array declarado con tamaño 5:
 * [0, 0, 0, 0, 0]
 *
 * 2. Array inicializado con valores:
 * [25, 30, 18, 45, 22]
 *
 * 3. Array de Strings:
 * [Ana, Carlos, María, Pedro, Luis]
 *
 * === ACCESO A ELEMENTOS ===
 * Primer elemento (índice 0): 25
 * Último elemento (índice 4): 22
 * Elemento en posición 2: 18
 *
 * ... (y así sucesivamente)
 */
