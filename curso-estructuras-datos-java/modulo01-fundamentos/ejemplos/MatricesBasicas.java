/**
 * MÓDULO 1: FUNDAMENTOS Y ARRAYS
 * Ejemplo 4: Matrices (Arrays Bidimensionales)
 *
 * Este programa explora matrices en Java:
 * - Declaración e inicialización
 * - Recorrido (filas y columnas)
 * - Operaciones comunes
 * - Aplicaciones prácticas
 */

public class MatricesBasicas {

    public static void main(String[] args) {
        System.out.println("=== MATRICES EN JAVA (ARRAYS 2D) ===\n");

        // ==========================================
        // 1. DECLARACIÓN E INICIALIZACIÓN
        // ==========================================
        System.out.println("=== CREACIÓN DE MATRICES ===\n");

        // Forma 1: Declarar dimensiones y llenar después
        int[][] matriz1 = new int[3][4];  // 3 filas, 4 columnas
        System.out.println("Matriz 3x4 creada (inicializada en 0):");
        imprimirMatriz(matriz1);

        // Forma 2: Inicializar con valores
        int[][] matriz2 = {
            {1, 2, 3},
            {4, 5, 6},
            {7, 8, 9}
        };
        System.out.println("\nMatriz 3x3 con valores iniciales:");
        imprimirMatriz(matriz2);

        // Forma 3: Matriz irregular (jagged array)
        int[][] irregular = {
            {1, 2},
            {3, 4, 5, 6},
            {7}
        };
        System.out.println("\nMatriz irregular:");
        imprimirMatriz(irregular);

        // ==========================================
        // 2. ACCESO Y MODIFICACIÓN
        // ==========================================
        System.out.println("\n=== ACCESO Y MODIFICACIÓN ===");

        // Acceder a elementos
        System.out.println("Elemento en posición [1][2]: " + matriz2[1][2]);
        System.out.println("Elemento en posición [0][0]: " + matriz2[0][0]);
        System.out.println("Elemento en posición [2][1]: " + matriz2[2][1]);

        // Modificar elementos
        matriz2[1][1] = 99;
        System.out.println("\nDespués de cambiar [1][1] a 99:");
        imprimirMatriz(matriz2);

        // ==========================================
        // 3. LLENAR MATRIZ CON PATRÓN
        // ==========================================
        System.out.println("\n=== LLENAR MATRIZ CON PATRÓN ===");

        int[][] matrizPatron = new int[5][5];

        // Patrón 1: Números consecutivos
        int valor = 1;
        for (int i = 0; i < matrizPatron.length; i++) {
            for (int j = 0; j < matrizPatron[i].length; j++) {
                matrizPatron[i][j] = valor++;
            }
        }
        System.out.println("\nNúmeros consecutivos:");
        imprimirMatriz(matrizPatron);

        // Patrón 2: Tabla de multiplicar
        int[][] tablaMultiplicar = new int[10][10];
        for (int i = 0; i < 10; i++) {
            for (int j = 0; j < 10; j++) {
                tablaMultiplicar[i][j] = (i + 1) * (j + 1);
            }
        }
        System.out.println("\nTabla de multiplicar del 1 al 10:");
        imprimirMatrizFormateada(tablaMultiplicar);

        // ==========================================
        // 4. OPERACIONES CON MATRICES
        // ==========================================
        System.out.println("\n=== OPERACIONES CON MATRICES ===");

        int[][] a = {
            {1, 2, 3},
            {4, 5, 6},
            {7, 8, 9}
        };

        int[][] b = {
            {9, 8, 7},
            {6, 5, 4},
            {3, 2, 1}
        };

        System.out.println("Matriz A:");
        imprimirMatriz(a);

        System.out.println("\nMatriz B:");
        imprimirMatriz(b);

        // Suma de matrices
        int[][] suma = sumarMatrices(a, b);
        System.out.println("\nA + B =");
        imprimirMatriz(suma);

        // Matriz transpuesta
        int[][] transpuesta = transponer(a);
        System.out.println("\nTranspuesta de A:");
        imprimirMatriz(transpuesta);

        // ==========================================
        // 5. BÚSQUEDA EN MATRICES
        // ==========================================
        System.out.println("\n=== BÚSQUEDA EN MATRICES ===");

        int buscar = 5;
        int[] posicion = buscarEnMatriz(a, buscar);

        if (posicion != null) {
            System.out.println("Valor " + buscar + " encontrado en posición [" +
                             posicion[0] + "][" + posicion[1] + "]");
        } else {
            System.out.println("Valor " + buscar + " NO encontrado");
        }

        // ==========================================
        // 6. ESTADÍSTICAS DE MATRIZ
        // ==========================================
        System.out.println("\n=== ESTADÍSTICAS ===");

        System.out.println("Suma total de elementos: " + sumaTotal(a));
        System.out.println("Promedio: " + promedio(a));
        System.out.println("Valor máximo: " + encontrarMaximo(a));
        System.out.println("Valor mínimo: " + encontrarMinimo(a));

        // ==========================================
        // 7. APLICACIÓN PRÁCTICA: TABLERO DE JUEGO
        // ==========================================
        System.out.println("\n=== APLICACIÓN: TABLERO DE JUEGO ===");

        char[][] tablero = {
            {' ', ' ', 'X'},
            {' ', 'O', ' '},
            {'X', ' ', 'O'}
        };

        System.out.println("\nTablero de Tres en Raya:");
        imprimirTablero(tablero);

        // ==========================================
        // 8. MATRIZ IDENTIDAD
        // ==========================================
        System.out.println("\n=== MATRIZ IDENTIDAD ===");
        int[][] identidad = crearMatrizIdentidad(5);
        imprimirMatriz(identidad);

        // ==========================================
        // 9. DIAGONAL PRINCIPAL
        // ==========================================
        System.out.println("\n=== DIAGONAL PRINCIPAL ===");
        int[] diagonal = obtenerDiagonalPrincipal(a);
        System.out.print("Diagonal de A: ");
        for (int num : diagonal) {
            System.out.print(num + " ");
        }
        System.out.println();
    }

    /**
     * Imprime una matriz en formato legible
     */
    public static void imprimirMatriz(int[][] matriz) {
        for (int i = 0; i < matriz.length; i++) {
            System.out.print("[");
            for (int j = 0; j < matriz[i].length; j++) {
                System.out.print(matriz[i][j]);
                if (j < matriz[i].length - 1) {
                    System.out.print(", ");
                }
            }
            System.out.println("]");
        }
    }

    /**
     * Imprime matriz con formato alineado (para tablas)
     */
    public static void imprimirMatrizFormateada(int[][] matriz) {
        for (int i = 0; i < matriz.length; i++) {
            for (int j = 0; j < matriz[i].length; j++) {
                System.out.printf("%4d", matriz[i][j]);
            }
            System.out.println();
        }
    }

    /**
     * Suma dos matrices
     * Precondición: matrices deben tener las mismas dimensiones
     * Complejidad: O(filas * columnas)
     */
    public static int[][] sumarMatrices(int[][] a, int[][] b) {
        int filas = a.length;
        int columnas = a[0].length;

        int[][] resultado = new int[filas][columnas];

        for (int i = 0; i < filas; i++) {
            for (int j = 0; j < columnas; j++) {
                resultado[i][j] = a[i][j] + b[i][j];
            }
        }

        return resultado;
    }

    /**
     * Transpone una matriz (intercambia filas por columnas)
     * Complejidad: O(filas * columnas)
     */
    public static int[][] transponer(int[][] matriz) {
        int filas = matriz.length;
        int columnas = matriz[0].length;

        int[][] transpuesta = new int[columnas][filas];

        for (int i = 0; i < filas; i++) {
            for (int j = 0; j < columnas; j++) {
                transpuesta[j][i] = matriz[i][j];
            }
        }

        return transpuesta;
    }

    /**
     * Busca un valor en la matriz
     * Retorna la posición [fila, columna] o null si no se encuentra
     * Complejidad: O(filas * columnas)
     */
    public static int[] buscarEnMatriz(int[][] matriz, int valor) {
        for (int i = 0; i < matriz.length; i++) {
            for (int j = 0; j < matriz[i].length; j++) {
                if (matriz[i][j] == valor) {
                    return new int[]{i, j};  // Retornar posición
                }
            }
        }
        return null;  // No encontrado
    }

    /**
     * Calcula la suma de todos los elementos
     * Complejidad: O(filas * columnas)
     */
    public static int sumaTotal(int[][] matriz) {
        int suma = 0;
        for (int i = 0; i < matriz.length; i++) {
            for (int j = 0; j < matriz[i].length; j++) {
                suma += matriz[i][j];
            }
        }
        return suma;
    }

    /**
     * Calcula el promedio de todos los elementos
     */
    public static double promedio(int[][] matriz) {
        int suma = sumaTotal(matriz);
        int totalElementos = matriz.length * matriz[0].length;
        return (double) suma / totalElementos;
    }

    /**
     * Encuentra el valor máximo en la matriz
     */
    public static int encontrarMaximo(int[][] matriz) {
        int maximo = matriz[0][0];
        for (int i = 0; i < matriz.length; i++) {
            for (int j = 0; j < matriz[i].length; j++) {
                if (matriz[i][j] > maximo) {
                    maximo = matriz[i][j];
                }
            }
        }
        return maximo;
    }

    /**
     * Encuentra el valor mínimo en la matriz
     */
    public static int encontrarMinimo(int[][] matriz) {
        int minimo = matriz[0][0];
        for (int i = 0; i < matriz.length; i++) {
            for (int j = 0; j < matriz[i].length; j++) {
                if (matriz[i][j] < minimo) {
                    minimo = matriz[i][j];
                }
            }
        }
        return minimo;
    }

    /**
     * Crea una matriz identidad (1 en diagonal, 0 en resto)
     */
    public static int[][] crearMatrizIdentidad(int tamanio) {
        int[][] identidad = new int[tamanio][tamanio];
        for (int i = 0; i < tamanio; i++) {
            identidad[i][i] = 1;  // Solo la diagonal principal
        }
        return identidad;
    }

    /**
     * Obtiene los elementos de la diagonal principal
     */
    public static int[] obtenerDiagonalPrincipal(int[][] matriz) {
        int tamanio = Math.min(matriz.length, matriz[0].length);
        int[] diagonal = new int[tamanio];

        for (int i = 0; i < tamanio; i++) {
            diagonal[i] = matriz[i][i];
        }

        return diagonal;
    }

    /**
     * Imprime un tablero de juego (con caracteres)
     */
    public static void imprimirTablero(char[][] tablero) {
        System.out.println("-------------");
        for (int i = 0; i < tablero.length; i++) {
            System.out.print("| ");
            for (int j = 0; j < tablero[i].length; j++) {
                System.out.print(tablero[i][j] + " | ");
            }
            System.out.println("\n-------------");
        }
    }
}

/*
 * CONCEPTOS CLAVE SOBRE MATRICES:
 * ================================
 *
 * 1. ESTRUCTURA:
 *    - matriz[fila][columna]
 *    - Primer índice = fila
 *    - Segundo índice = columna
 *
 * 2. DIMENSIONES:
 *    - matriz.length = número de filas
 *    - matriz[0].length = número de columnas (primera fila)
 *
 * 3. RECORRIDO:
 *    - Bucle externo para filas
 *    - Bucle interno para columnas
 *    - Orden: izquierda->derecha, arriba->abajo
 *
 * 4. COMPLEJIDAD:
 *    - Acceso directo: O(1)
 *    - Búsqueda: O(filas * columnas)
 *    - Operaciones completas: O(filas * columnas)
 *
 * 5. APLICACIONES:
 *    - Tableros de juego (ajedrez, tres en raya)
 *    - Procesamiento de imágenes
 *    - Gráficas (matriz de adyacencia)
 *    - Hojas de cálculo
 *    - Algoritmos de programación dinámica
 */
