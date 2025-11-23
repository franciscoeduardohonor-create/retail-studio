! ============================================================================
! Programa: Arreglos Bidimensionales (Matrices)
! Descripción: Trabaja con matrices y operaciones matriciales
! ============================================================================

program arreglos_2d
    implicit none

    ! Declaración de matrices
    real, dimension(3,3) :: matriz_a, matriz_b, matriz_suma, matriz_producto
    real, dimension(3,3) :: matriz_identidad, matriz_transpuesta
    integer, dimension(4,5) :: matriz_entera
    integer :: i, j, k
    real :: suma, determinante

    ! ========================================================================
    ! INICIALIZACIÓN DE MATRICES
    ! ========================================================================

    print *, '======================================='
    print *, 'MATRICES EN FORTRAN'
    print *, '======================================='
    print *

    ! Inicializar matriz elemento por elemento
    matriz_a(1,1) = 1.0;  matriz_a(1,2) = 2.0;  matriz_a(1,3) = 3.0
    matriz_a(2,1) = 4.0;  matriz_a(2,2) = 5.0;  matriz_a(2,3) = 6.0
    matriz_a(3,1) = 7.0;  matriz_a(3,2) = 8.0;  matriz_a(3,3) = 9.0

    ! Inicializar con reshape
    matriz_b = reshape([1.0, 0.0, 0.0, &
                        0.0, 2.0, 0.0, &
                        0.0, 0.0, 3.0], [3,3])

    ! Mostrar matrices
    print *, 'Matriz A:'
    call mostrar_matriz(matriz_a, 3, 3)
    print *

    print *, 'Matriz B:'
    call mostrar_matriz(matriz_b, 3, 3)
    print *

    ! ========================================================================
    ! OPERACIONES CON MATRICES
    ! ========================================================================

    print *, '======================================='
    print *, 'OPERACIONES MATRICIALES'
    print *, '======================================='
    print *

    ! Suma de matrices
    matriz_suma = matriz_a + matriz_b
    print *, 'A + B ='
    call mostrar_matriz(matriz_suma, 3, 3)
    print *

    ! Multiplicación por escalar
    matriz_a = matriz_a * 2.0
    print *, 'A * 2 ='
    call mostrar_matriz(matriz_a, 3, 3)
    print *

    ! Restaurar matriz_a
    matriz_a = matriz_a / 2.0

    ! Multiplicación de matrices (A × B)
    matriz_producto = 0.0
    do i = 1, 3
        do j = 1, 3
            do k = 1, 3
                matriz_producto(i,j) = matriz_producto(i,j) + &
                                       matriz_a(i,k) * matriz_b(k,j)
            end do
        end do
    end do

    print *, 'A × B ='
    call mostrar_matriz(matriz_producto, 3, 3)
    print *

    ! Producto usando matmul (función intrínseca)
    matriz_producto = matmul(matriz_a, matriz_b)
    print *, 'A × B (usando matmul) ='
    call mostrar_matriz(matriz_producto, 3, 3)
    print *

    ! ========================================================================
    ! MATRIZ IDENTIDAD
    ! ========================================================================

    print *, 'MATRIZ IDENTIDAD 3×3:'
    matriz_identidad = 0.0
    do i = 1, 3
        matriz_identidad(i,i) = 1.0
    end do
    call mostrar_matriz(matriz_identidad, 3, 3)
    print *

    ! ========================================================================
    ! TRANSPUESTA DE UNA MATRIZ
    ! ========================================================================

    print *, 'TRANSPUESTA DE A:'

    ! Método manual
    do i = 1, 3
        do j = 1, 3
            matriz_transpuesta(i,j) = matriz_a(j,i)
        end do
    end do
    call mostrar_matriz(matriz_transpuesta, 3, 3)
    print *

    ! Usando función transpose
    matriz_transpuesta = transpose(matriz_a)
    print *, 'Transpuesta (usando transpose):'
    call mostrar_matriz(matriz_transpuesta, 3, 3)
    print *

    ! ========================================================================
    ! SUMA DE FILAS Y COLUMNAS
    ! ========================================================================

    print *, '======================================='
    print *, 'ESTADÍSTICAS DE MATRIZ'
    print *, '======================================='
    print *

    print *, 'Matriz A:'
    call mostrar_matriz(matriz_a, 3, 3)
    print *

    ! Suma de cada fila
    print *, 'Suma por fila:'
    do i = 1, 3
        suma = 0.0
        do j = 1, 3
            suma = suma + matriz_a(i,j)
        end do
        print '(A, I1, A, F8.2)', 'Fila ', i, ': ', suma
    end do
    print *

    ! Suma de cada columna
    print *, 'Suma por columna:'
    do j = 1, 3
        suma = 0.0
        do i = 1, 3
            suma = suma + matriz_a(i,j)
        end do
        print '(A, I1, A, F8.2)', 'Columna ', j, ': ', suma
    end do
    print *

    ! Usando sum con dim
    print *, 'Suma por filas (usando sum):'
    do i = 1, 3
        print *, sum(matriz_a(i,:))
    end do
    print *

    ! ========================================================================
    ! TABLA DE MULTIPLICAR (MATRIZ)
    ! ========================================================================

    print *, '======================================='
    print *, 'TABLA DE MULTIPLICAR 10×10'
    print *, '======================================='
    print *

    integer, dimension(10,10) :: tabla_multiplicar

    ! Generar tabla
    do i = 1, 10
        do j = 1, 10
            tabla_multiplicar(i,j) = i * j
        end do
    end do

    ! Mostrar encabezado
    print '(4X, 10I5)', (i, i=1,10)
    print '(4X, 50A)', repeat('-', 50)

    ! Mostrar filas
    do i = 1, 10
        print '(I2, A, 10I5)', i, ' |', (tabla_multiplicar(i,j), j=1,10)
    end do
    print *

    ! ========================================================================
    ! APLICACIÓN: SISTEMA DE CALIFICACIONES
    ! ========================================================================

    print *, '======================================='
    print *, 'SISTEMA DE CALIFICACIONES'
    print *, '======================================='
    print *

    real, dimension(4,3) :: calificaciones  ! 4 estudiantes, 3 materias
    real, dimension(4) :: promedios
    character(len=15), dimension(4) :: estudiantes
    character(len=15), dimension(3) :: materias

    ! Datos de ejemplo
    estudiantes = ['Juan   ', 'María  ', 'Pedro  ', 'Ana    ']
    materias = ['Matemáticas', 'Física     ', 'Química    ']

    calificaciones(1,:) = [8.5, 7.5, 9.0]
    calificaciones(2,:) = [9.2, 8.8, 9.5]
    calificaciones(3,:) = [7.0, 7.5, 6.8]
    calificaciones(4,:) = [9.5, 9.0, 9.8]

    ! Mostrar tabla
    print '(A15, 3A12)', 'Estudiante', (trim(materias(j)), j=1,3), 'Promedio'
    print *, repeat('-', 70)

    do i = 1, 4
        promedios(i) = sum(calificaciones(i,:)) / 3.0
        print '(A15, 3F12.2, F12.2)', trim(estudiantes(i)), &
              (calificaciones(i,j), j=1,3), promedios(i)
    end do

    print *
    print *, 'Promedio por materia:'
    do j = 1, 3
        print '(A15, F8.2)', trim(materias(j)), sum(calificaciones(:,j))/4.0
    end do
    print *

    ! ========================================================================
    ! BÚSQUEDA EN MATRIZ
    ! ========================================================================

    print *, '======================================='
    print *, 'BÚSQUEDA DE MÁXIMO EN MATRIZ'
    print *, '======================================='
    print *

    real :: maximo
    integer :: fila_max, col_max

    maximo = matriz_a(1,1)
    fila_max = 1
    col_max = 1

    do i = 1, 3
        do j = 1, 3
            if (matriz_a(i,j) > maximo) then
                maximo = matriz_a(i,j)
                fila_max = i
                col_max = j
            end if
        end do
    end do

    print '(A, F8.2)', 'Valor máximo: ', maximo
    print '(A, I1, A, I1, A)', 'Posición: (', fila_max, ',', col_max, ')'
    print *

    print *, '======================================='

contains

    ! Subrutina para mostrar matrices
    subroutine mostrar_matriz(matriz, filas, columnas)
        real, dimension(filas, columnas), intent(in) :: matriz
        integer, intent(in) :: filas, columnas
        integer :: i, j

        do i = 1, filas
            print '(10F8.2)', (matriz(i,j), j=1,columnas)
        end do
    end subroutine mostrar_matriz

end program arreglos_2d

! ============================================================================
! FUNCIONES INTRÍNSECAS PARA MATRICES:
!
! matmul(A,B)      - Multiplicación de matrices
! transpose(A)     - Transpuesta de A
! sum(A)           - Suma de todos los elementos
! sum(A, dim=1)    - Suma por columnas
! sum(A, dim=2)    - Suma por filas
! maxval(A)        - Valor máximo
! minval(A)        - Valor mínimo
! reshape(array, shape) - Cambia forma del arreglo
!
! NOTACIÓN DE SUBÍNDICES:
!   A(i,j)          - Elemento en fila i, columna j
!   A(i,:)          - Toda la fila i
!   A(:,j)          - Toda la columna j
!   A(:,:)          - Toda la matriz
!
! COMPILAR Y EJECUTAR:
!   gfortran -o arreglos_2d 08_arreglos_2d.f90
!   ./arreglos_2d
! ============================================================================

! EJERCICIOS:
! 1. Crea un programa que sume dos matrices 4×4
! 2. Calcula el determinante de una matriz 3×3
! 3. Verifica si una matriz es simétrica
! 4. Encuentra la traza de una matriz (suma de la diagonal)
! 5. Implementa el algoritmo de eliminación gaussiana
! 6. Crea un juego de tres en raya (tic-tac-toe) usando una matriz
