! ============================================================================
! Programa: Subrutinas en FORTRAN
! Descripción: Aprende a crear y usar subrutinas
! ============================================================================

program subrutinas_ejemplo
    implicit none

    real :: a, b, suma_r, resta_r, mult_r, div_r
    integer, dimension(5) :: arreglo, ordenado
    real :: x1, y1, x2, y2, distancia, angulo
    integer :: n, i

    ! ========================================================================
    ! SUBRUTINAS CON MÚLTIPLES SALIDAS
    ! ========================================================================

    print *, '======================================='
    print *, 'SUBRUTINAS BÁSICAS'
    print *, '======================================='
    print *

    a = 10.0
    b = 3.0

    ! Llamar subrutina que realiza 4 operaciones
    call operaciones_basicas(a, b, suma_r, resta_r, mult_r, div_r)

    print '(A, F6.2, A, F6.2)', 'Números: ', a, ' y ', b
    print '(A, F8.2)', 'Suma: ', suma_r
    print '(A, F8.2)', 'Resta: ', resta_r
    print '(A, F8.2)', 'Multiplicación: ', mult_r
    print '(A, F8.2)', 'División: ', div_r
    print *

    ! ========================================================================
    ! SUBRUTINAS CON ARREGLOS
    ! ========================================================================

    print *, 'ORDENAMIENTO DE ARREGLOS:'
    print *

    arreglo = [5, 2, 8, 1, 9]
    print *, 'Arreglo original:', arreglo

    call ordenar_burbuja(arreglo, 5)
    print *, 'Arreglo ordenado:', arreglo
    print *

    ! ========================================================================
    ! SUBRUTINAS DE GEOMETRÍA
    ! ========================================================================

    print *, 'GEOMETRÍA - DISTANCIA Y ÁNGULO:'
    print *

    x1 = 0.0
    y1 = 0.0
    x2 = 3.0
    y2 = 4.0

    call calcular_distancia_angulo(x1, y1, x2, y2, distancia, angulo)

    print '(A, F6.2, A, F6.2, A)', 'Punto 1: (', x1, ',', y1, ')'
    print '(A, F6.2, A, F6.2, A)', 'Punto 2: (', x2, ',', y2, ')'
    print '(A, F8.4)', 'Distancia: ', distancia
    print '(A, F8.4, A)', 'Ángulo: ', angulo, ' radianes'
    print *

    ! ========================================================================
    ! SUBRUTINAS DE ESTADÍSTICA
    ! ========================================================================

    print *, 'ESTADÍSTICAS DE ARREGLO:'
    print *

    real, dimension(10) :: datos
    real :: promedio, desv_std, maximo, minimo

    datos = [7.5, 8.2, 6.8, 9.1, 7.9, 8.5, 7.2, 8.8, 9.5, 7.0]

    call estadisticas(datos, 10, promedio, desv_std, maximo, minimo)

    print *, 'Datos:', datos
    print '(A, F6.2)', 'Promedio: ', promedio
    print '(A, F6.2)', 'Desviación estándar: ', desv_std
    print '(A, F6.2)', 'Máximo: ', maximo
    print '(A, F6.2)', 'Mínimo: ', minimo
    print *

    ! ========================================================================
    ! SUBRUTINA DE IMPRESIÓN FORMATEADA
    ! ========================================================================

    print *, '======================================='
    print *, 'TABLA DE MULTIPLICAR'
    print *, '======================================='
    print *

    call imprimir_tabla_multiplicar(7)
    print *

    ! ========================================================================
    ! SUBRUTINA CON ARREGLOS 2D
    ! ========================================================================

    print *, '======================================='
    print *, 'MATRIZ IDENTIDAD 4×4'
    print *, '======================================='
    print *

    real, dimension(4,4) :: matriz

    call crear_identidad(matriz, 4)
    call mostrar_matriz(matriz, 4, 4)
    print *

    print *, '======================================='

contains

    ! ========================================================================
    ! DEFINICIONES DE SUBRUTINAS
    ! ========================================================================

    ! Subrutina para 4 operaciones básicas
    subroutine operaciones_basicas(x, y, suma, resta, multi, divi)
        real, intent(in) :: x, y
        real, intent(out) :: suma, resta, multi, divi

        suma = x + y
        resta = x - y
        multi = x * y

        if (y /= 0.0) then
            divi = x / y
        else
            divi = 0.0
        end if
    end subroutine operaciones_basicas

    ! Subrutina para ordenar un arreglo (burbuja)
    subroutine ordenar_burbuja(arr, n)
        integer, intent(in) :: n
        integer, dimension(n), intent(inout) :: arr
        integer :: i, j, temp

        do i = 1, n-1
            do j = 1, n-i
                if (arr(j) > arr(j+1)) then
                    temp = arr(j)
                    arr(j) = arr(j+1)
                    arr(j+1) = temp
                end if
            end do
        end do
    end subroutine ordenar_burbuja

    ! Calcular distancia y ángulo entre dos puntos
    subroutine calcular_distancia_angulo(x1, y1, x2, y2, dist, ang)
        real, intent(in) :: x1, y1, x2, y2
        real, intent(out) :: dist, ang

        dist = sqrt((x2-x1)**2 + (y2-y1)**2)
        ang = atan2(y2-y1, x2-x1)
    end subroutine calcular_distancia_angulo

    ! Calcular estadísticas de un arreglo
    subroutine estadisticas(arr, n, prom, desv, max_val, min_val)
        integer, intent(in) :: n
        real, dimension(n), intent(in) :: arr
        real, intent(out) :: prom, desv, max_val, min_val
        integer :: i
        real :: varianza

        ! Promedio
        prom = sum(arr) / real(n)

        ! Máximo y mínimo
        max_val = maxval(arr)
        min_val = minval(arr)

        ! Desviación estándar
        varianza = 0.0
        do i = 1, n
            varianza = varianza + (arr(i) - prom)**2
        end do
        varianza = varianza / real(n)
        desv = sqrt(varianza)
    end subroutine estadisticas

    ! Imprimir tabla de multiplicar
    subroutine imprimir_tabla_multiplicar(numero)
        integer, intent(in) :: numero
        integer :: i

        print '(A, I2)', 'Tabla del ', numero
        print *, repeat('-', 20)

        do i = 1, 10
            print '(I2, A, I2, A, I4)', numero, ' × ', i, ' = ', numero*i
        end do
    end subroutine imprimir_tabla_multiplicar

    ! Crear matriz identidad
    subroutine crear_identidad(mat, n)
        integer, intent(in) :: n
        real, dimension(n,n), intent(out) :: mat
        integer :: i, j

        mat = 0.0
        do i = 1, n
            mat(i,i) = 1.0
        end do
    end subroutine crear_identidad

    ! Mostrar matriz
    subroutine mostrar_matriz(mat, filas, cols)
        integer, intent(in) :: filas, cols
        real, dimension(filas, cols), intent(in) :: mat
        integer :: i, j

        do i = 1, filas
            print '(10F8.2)', (mat(i,j), j=1,cols)
        end do
    end subroutine mostrar_matriz

end program subrutinas_ejemplo

! ============================================================================
! SINTAXIS DE SUBRUTINAS:
!
! subroutine nombre(argumentos)
!     [declaración de argumentos con intent]
!     [variables locales]
!     [cuerpo de la subrutina]
! end subroutine nombre
!
! LLAMAR A UNA SUBRUTINA:
!   call nombre(argumentos)
!
! DIFERENCIAS ENTRE FUNCIONES Y SUBRUTINAS:
!
! FUNCIONES:
!   - Retornan un solo valor
!   - Se usan en expresiones
!   - resultado = funcion(x)
!
! SUBRUTINAS:
!   - Pueden modificar múltiples argumentos
!   - Se llaman con 'call'
!   - call subrutina(in, out1, out2)
!   - Útiles para operaciones complejas
!
! INTENT:
!   intent(in)    - Solo lectura
!   intent(out)   - Solo escritura (se limpia al entrar)
!   intent(inout) - Lectura y escritura
!
! COMPILAR Y EJECUTAR:
!   gfortran -o subrutinas 02_subrutinas.f90
!   ./subrutinas
! ============================================================================

! EJERCICIOS:
! 1. Subrutina que intercambie dos valores
! 2. Subrutina que resuelva ecuación cuadrática (retorne ambas raíces)
! 3. Subrutina que encuentre máximo y mínimo de un arreglo
! 4. Subrutina que multiplique dos matrices
! 5. Subrutina que calcule estadísticas completas (media, mediana, moda)
