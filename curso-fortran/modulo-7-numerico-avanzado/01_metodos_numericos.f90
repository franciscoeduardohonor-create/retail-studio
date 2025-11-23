! ============================================================================
! Programa: Métodos Numéricos en FORTRAN
! Descripción: Implementación de algoritmos numéricos comunes
! ============================================================================

program metodos_numericos
    implicit none

    real :: a, b, resultado, tolerancia
    integer :: max_iter, i
    real, dimension(100) :: x_data, y_data
    integer :: n_datos

    print *, '======================================='
    print *, 'MÉTODOS NUMÉRICOS'
    print *, '======================================='
    print *

    ! ========================================================================
    ! MÉTODO DE BISECCIÓN (Encontrar raíces)
    ! ========================================================================

    print *, 'MÉTODO DE BISECCIÓN:'
    print *, 'Encontrar raíz de f(x) = x² - 2'
    print *, '(Raíz es sqrt(2) ≈ 1.414)'
    print *

    a = 0.0
    b = 2.0
    tolerancia = 0.0001
    max_iter = 100

    call biseccion(f1, a, b, tolerancia, max_iter, resultado)

    print '(A, F10.6)', 'Raíz encontrada: ', resultado
    print '(A, F10.6)', 'f(raíz) = ', f1(resultado)
    print *

    ! ========================================================================
    ! MÉTODO DE NEWTON-RAPHSON
    ! ========================================================================

    print *, 'MÉTODO DE NEWTON-RAPHSON:'
    print *, 'Encontrar raíz de f(x) = x³ - x - 2'
    print *

    real :: x0, raiz

    x0 = 1.5  ! Valor inicial
    tolerancia = 0.00001
    max_iter = 50

    call newton_raphson(f2, df2, x0, tolerancia, max_iter, raiz)

    print '(A, F10.6)', 'Raíz encontrada: ', raiz
    print '(A, F10.6)', 'f(raíz) = ', f2(raiz)
    print *

    ! ========================================================================
    ! INTEGRACIÓN NUMÉRICA - MÉTODO DEL TRAPECIO
    ! ========================================================================

    print *, 'INTEGRACIÓN NUMÉRICA (TRAPECIO):'
    print *, 'Integral de f(x) = x² de 0 a 1'
    print *, 'Resultado exacto: 1/3 = 0.333333'
    print *

    a = 0.0
    b = 1.0
    n_datos = 1000

    resultado = integral_trapecio(f3, a, b, n_datos)

    print '(A, F10.6)', 'Resultado numérico: ', resultado
    print '(A, F10.6)', 'Error: ', abs(resultado - 1.0/3.0)
    print *

    ! ========================================================================
    ! INTEGRACIÓN POR SIMPSON
    ! ========================================================================

    print *, 'INTEGRACIÓN NUMÉRICA (SIMPSON):'
    resultado = integral_simpson(f3, a, b, n_datos)

    print '(A, F10.6)', 'Resultado numérico: ', resultado
    print '(A, F10.6)', 'Error: ', abs(resultado - 1.0/3.0)
    print *

    ! ========================================================================
    ! DERIVADA NUMÉRICA
    ! ========================================================================

    print *, 'DERIVADA NUMÉRICA:'
    print *, 'f(x) = x³ en x = 2'
    print *, "f'(2) = 3x² = 12 (exacto)"
    print *

    real :: x, derivada

    x = 2.0
    derivada = derivada_numerica(f4, x, 0.0001)

    print '(A, F10.6)', 'Derivada numérica: ', derivada
    print '(A, F10.6)', 'Error: ', abs(derivada - 12.0)
    print *

    ! ========================================================================
    ! INTERPOLACIÓN LINEAL
    ! ========================================================================

    print *, 'INTERPOLACIÓN LINEAL:'
    print *

    ! Datos de ejemplo
    x_data(1:5) = [0.0, 1.0, 2.0, 3.0, 4.0]
    y_data(1:5) = [0.0, 1.0, 4.0, 9.0, 16.0]  ! y = x²

    ! Interpolar en x = 2.5
    x = 2.5
    resultado = interpolar_lineal(x_data, y_data, 5, x)

    print '(A, F6.2)', 'Valor interpolado en x = ', x
    print '(A, F10.4)', 'y = ', resultado
    print '(A, F10.4)', 'Valor real (x²): ', x**2
    print *

    ! ========================================================================
    ! RESOLUCIÓN DE SISTEMAS LINEALES - MÉTODO DE GAUSS
    ! ========================================================================

    print *, 'SISTEMA DE ECUACIONES LINEALES:'
    print *, '2x + y = 5'
    print *, 'x + 3y = 5'
    print *

    real, dimension(2,2) :: A
    real, dimension(2) :: b_vec, solucion

    A(1,:) = [2.0, 1.0]
    A(2,:) = [1.0, 3.0]
    b_vec = [5.0, 5.0]

    call gauss_eliminacion(A, b_vec, 2, solucion)

    print '(A, F8.4)', 'x = ', solucion(1)
    print '(A, F8.4)', 'y = ', solucion(2)
    print *

    print *, '======================================='

contains

    ! ========================================================================
    ! FUNCIONES DE PRUEBA
    ! ========================================================================

    real function f1(x)
        real, intent(in) :: x
        f1 = x**2 - 2.0
    end function f1

    real function f2(x)
        real, intent(in) :: x
        f2 = x**3 - x - 2.0
    end function f2

    real function df2(x)  ! Derivada de f2
        real, intent(in) :: x
        df2 = 3.0*x**2 - 1.0
    end function df2

    real function f3(x)
        real, intent(in) :: x
        f3 = x**2
    end function f3

    real function f4(x)
        real, intent(in) :: x
        f4 = x**3
    end function f4

    ! ========================================================================
    ! MÉTODO DE BISECCIÓN
    ! ========================================================================

    subroutine biseccion(func, a, b, tol, max_it, raiz)
        interface
            real function func(x)
                real, intent(in) :: x
            end function func
        end interface
        real, intent(in) :: a, b, tol
        integer, intent(in) :: max_it
        real, intent(out) :: raiz

        real :: a_local, b_local, c
        integer :: iter

        a_local = a
        b_local = b

        do iter = 1, max_it
            c = (a_local + b_local) / 2.0

            if (abs(func(c)) < tol) then
                raiz = c
                return
            end if

            if (func(a_local) * func(c) < 0) then
                b_local = c
            else
                a_local = c
            end if
        end do

        raiz = c
    end subroutine biseccion

    ! ========================================================================
    ! MÉTODO DE NEWTON-RAPHSON
    ! ========================================================================

    subroutine newton_raphson(func, dfunc, x0, tol, max_it, raiz)
        interface
            real function func(x)
                real, intent(in) :: x
            end function func
            real function dfunc(x)
                real, intent(in) :: x
            end function dfunc
        end interface
        real, intent(in) :: x0, tol
        integer, intent(in) :: max_it
        real, intent(out) :: raiz

        real :: x, x_new
        integer :: iter

        x = x0

        do iter = 1, max_it
            x_new = x - func(x) / dfunc(x)

            if (abs(x_new - x) < tol) then
                raiz = x_new
                return
            end if

            x = x_new
        end do

        raiz = x_new
    end subroutine newton_raphson

    ! ========================================================================
    ! INTEGRACIÓN POR TRAPECIO
    ! ========================================================================

    real function integral_trapecio(func, a, b, n)
        interface
            real function func(x)
                real, intent(in) :: x
            end function func
        end interface
        real, intent(in) :: a, b
        integer, intent(in) :: n

        real :: h, suma, x
        integer :: i

        h = (b - a) / real(n)
        suma = 0.5 * (func(a) + func(b))

        do i = 1, n-1
            x = a + real(i) * h
            suma = suma + func(x)
        end do

        integral_trapecio = h * suma
    end function integral_trapecio

    ! ========================================================================
    ! INTEGRACIÓN POR SIMPSON
    ! ========================================================================

    real function integral_simpson(func, a, b, n)
        interface
            real function func(x)
                real, intent(in) :: x
            end function func
        end interface
        real, intent(in) :: a, b
        integer, intent(in) :: n

        real :: h, suma, x
        integer :: i

        h = (b - a) / real(n)
        suma = func(a) + func(b)

        do i = 1, n-1, 2
            x = a + real(i) * h
            suma = suma + 4.0 * func(x)
        end do

        do i = 2, n-2, 2
            x = a + real(i) * h
            suma = suma + 2.0 * func(x)
        end do

        integral_simpson = (h / 3.0) * suma
    end function integral_simpson

    ! ========================================================================
    ! DERIVADA NUMÉRICA
    ! ========================================================================

    real function derivada_numerica(func, x, h)
        interface
            real function func(x)
                real, intent(in) :: x
            end function func
        end interface
        real, intent(in) :: x, h

        derivada_numerica = (func(x + h) - func(x - h)) / (2.0 * h)
    end function derivada_numerica

    ! ========================================================================
    ! INTERPOLACIÓN LINEAL
    ! ========================================================================

    real function interpolar_lineal(x_arr, y_arr, n, x)
        integer, intent(in) :: n
        real, dimension(n), intent(in) :: x_arr, y_arr
        real, intent(in) :: x
        integer :: i

        ! Encontrar intervalo
        do i = 1, n-1
            if (x >= x_arr(i) .and. x <= x_arr(i+1)) then
                interpolar_lineal = y_arr(i) + &
                    (y_arr(i+1) - y_arr(i)) / (x_arr(i+1) - x_arr(i)) * &
                    (x - x_arr(i))
                return
            end if
        end do

        interpolar_lineal = 0.0
    end function interpolar_lineal

    ! ========================================================================
    ! ELIMINACIÓN GAUSSIANA
    ! ========================================================================

    subroutine gauss_eliminacion(A, b, n, x)
        integer, intent(in) :: n
        real, dimension(n,n), intent(inout) :: A
        real, dimension(n), intent(inout) :: b
        real, dimension(n), intent(out) :: x

        real :: factor
        integer :: i, j, k

        ! Eliminación hacia adelante
        do k = 1, n-1
            do i = k+1, n
                factor = A(i,k) / A(k,k)
                A(i,k:n) = A(i,k:n) - factor * A(k,k:n)
                b(i) = b(i) - factor * b(k)
            end do
        end do

        ! Sustitución hacia atrás
        x(n) = b(n) / A(n,n)
        do i = n-1, 1, -1
            x(i) = (b(i) - sum(A(i,i+1:n) * x(i+1:n))) / A(i,i)
        end do
    end subroutine gauss_eliminacion

end program metodos_numericos

! ============================================================================
! MÉTODOS NUMÉRICOS IMPLEMENTADOS:
!
! - Bisección: Encontrar raíces de ecuaciones
! - Newton-Raphson: Encontrar raíces (más rápido)
! - Integración por Trapecio
! - Integración por Simpson
! - Derivada numérica
! - Interpolación lineal
! - Eliminación Gaussiana (sistemas lineales)
!
! COMPILAR Y EJECUTAR:
!   gfortran -o numericos 01_metodos_numericos.f90
!   ./numericos
! ============================================================================
