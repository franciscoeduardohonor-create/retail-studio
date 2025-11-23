! ============================================================================
! Programa: Funciones en FORTRAN
! Descripción: Aprende a crear y usar funciones personalizadas
! ============================================================================

program funciones_basicas
    implicit none

    real :: a, b, resultado
    integer :: n
    real :: radio, area, volumen

    ! ========================================================================
    ! USANDO FUNCIONES SIMPLES
    ! ========================================================================

    print *, '======================================='
    print *, 'FUNCIONES BÁSICAS'
    print *, '======================================='
    print *

    a = 10.0
    b = 5.0

    ! Llamar a función suma
    resultado = suma(a, b)
    print '(F6.2, A, F6.2, A, F6.2)', a, ' + ', b, ' = ', resultado

    ! Llamar a función resta
    resultado = resta(a, b)
    print '(F6.2, A, F6.2, A, F6.2)', a, ' - ', b, ' = ', resultado

    ! Llamar a función multiplicación
    resultado = multiplica(a, b)
    print '(F6.2, A, F6.2, A, F6.2)', a, ' × ', b, ' = ', resultado

    ! Llamar a función división
    resultado = divide(a, b)
    print '(F6.2, A, F6.2, A, F6.2)', a, ' ÷ ', b, ' = ', resultado

    print *

    ! ========================================================================
    ! FUNCIONES MATEMÁTICAS
    ! ========================================================================

    print *, 'FUNCIONES MATEMÁTICAS:'
    print *

    ! Calcular área de círculo
    radio = 5.0
    area = area_circulo(radio)
    print '(A, F6.2, A, F10.2, A)', 'Área del círculo (r=', radio, '): ', &
          area, ' cm²'

    ! Calcular volumen de esfera
    volumen = volumen_esfera(radio)
    print '(A, F6.2, A, F10.2, A)', 'Volumen de esfera (r=', radio, '): ', &
          volumen, ' cm³'

    print *

    ! Calcular factorial
    n = 5
    print '(I2, A, I10)', n, '! = ', factorial(n)

    print *

    ! ========================================================================
    ! FUNCIONES DE VALIDACIÓN
    ! ========================================================================

    print *, 'FUNCIONES DE VALIDACIÓN:'
    print *

    n = 17
    if (es_primo(n)) then
        print *, n, 'es primo'
    else
        print *, n, 'no es primo'
    end if

    n = 12
    if (es_par(n)) then
        print *, n, 'es par'
    else
        print *, n, 'es impar'
    end if

    print *

    ! ========================================================================
    ! COMPOSICIÓN DE FUNCIONES
    ! ========================================================================

    print *, 'COMPOSICIÓN DE FUNCIONES:'
    print *

    ! Usar resultado de una función como argumento de otra
    resultado = divide(suma(10.0, 5.0), resta(8.0, 3.0))
    print *, '(10 + 5) / (8 - 3) = ', resultado

    ! Calcular promedio usando funciones
    resultado = promedio_tres(8.5, 9.0, 7.5)
    print *, 'Promedio de 8.5, 9.0, 7.5 = ', resultado

    print *

    ! ========================================================================
    ! APLICACIÓN PRÁCTICA
    ! ========================================================================

    print *, '======================================='
    print *, 'CALCULADORA DE GEOMETRÍA'
    print *, '======================================='
    print *

    real :: base, altura

    base = 10.0
    altura = 5.0

    print '(A)', 'Triángulo:'
    print '(A, F6.2, A, F6.2)', '  Base: ', base, ' cm, Altura: ', altura, ' cm'
    print '(A, F10.2, A)', '  Área: ', area_triangulo(base, altura), ' cm²'
    print '(A, F10.2, A)', '  Perímetro (equilátero): ', &
          perimetro_triangulo_equilatero(base), ' cm'

    print *
    print *, '======================================='

contains

    ! ========================================================================
    ! DEFINICIONES DE FUNCIONES
    ! ========================================================================

    ! Función suma
    real function suma(x, y)
        real, intent(in) :: x, y
        suma = x + y
    end function suma

    ! Función resta
    real function resta(x, y)
        real, intent(in) :: x, y
        resta = x - y
    end function resta

    ! Función multiplicación
    real function multiplica(x, y)
        real, intent(in) :: x, y
        multiplica = x * y
    end function multiplica

    ! Función división
    real function divide(x, y)
        real, intent(in) :: x, y
        if (y /= 0.0) then
            divide = x / y
        else
            print *, 'Error: División por cero'
            divide = 0.0
        end if
    end function divide

    ! Área de círculo
    real function area_circulo(r)
        real, intent(in) :: r
        real, parameter :: PI = 3.141592653589793
        area_circulo = PI * r**2
    end function area_circulo

    ! Volumen de esfera
    real function volumen_esfera(r)
        real, intent(in) :: r
        real, parameter :: PI = 3.141592653589793
        volumen_esfera = (4.0/3.0) * PI * r**3
    end function volumen_esfera

    ! Factorial
    integer function factorial(n)
        integer, intent(in) :: n
        integer :: i

        if (n < 0) then
            factorial = 0
            return
        end if

        factorial = 1
        do i = 1, n
            factorial = factorial * i
        end do
    end function factorial

    ! Verificar si es primo
    logical function es_primo(n)
        integer, intent(in) :: n
        integer :: i

        if (n <= 1) then
            es_primo = .false.
            return
        end if

        if (n == 2) then
            es_primo = .true.
            return
        end if

        do i = 2, n-1
            if (mod(n, i) == 0) then
                es_primo = .false.
                return
            end if
        end do

        es_primo = .true.
    end function es_primo

    ! Verificar si es par
    logical function es_par(n)
        integer, intent(in) :: n
        es_par = (mod(n, 2) == 0)
    end function es_par

    ! Promedio de tres números
    real function promedio_tres(a, b, c)
        real, intent(in) :: a, b, c
        promedio_tres = (a + b + c) / 3.0
    end function promedio_tres

    ! Área de triángulo
    real function area_triangulo(base, altura)
        real, intent(in) :: base, altura
        area_triangulo = (base * altura) / 2.0
    end function area_triangulo

    ! Perímetro de triángulo equilátero
    real function perimetro_triangulo_equilatero(lado)
        real, intent(in) :: lado
        perimetro_triangulo_equilatero = 3.0 * lado
    end function perimetro_triangulo_equilatero

end program funciones_basicas

! ============================================================================
! SINTAXIS DE FUNCIONES:
!
! tipo_retorno function nombre(argumentos)
!     [declaración de argumentos con intent]
!     [variables locales]
!     [cuerpo de la función]
!     nombre = valor_retorno
! end function nombre
!
! INTENT:
!   intent(in)    - Argumento de entrada (solo lectura)
!   intent(out)   - Argumento de salida
!   intent(inout) - Argumento de entrada/salida
!
! RETURN:
!   La palabra clave 'return' sale inmediatamente de la función
!
! CONTAINS:
!   Las funciones internas se definen después de 'contains'
!
! COMPILAR Y EJECUTAR:
!   gfortran -o funciones 01_funciones_basicas.f90
!   ./funciones
! ============================================================================

! EJERCICIOS:
! 1. Crea una función que calcule el máximo de tres números
! 2. Función que convierta grados Celsius a Fahrenheit
! 3. Función que calcule el n-ésimo término de Fibonacci
! 4. Función que determine si un año es bisiesto
! 5. Función que calcule la distancia entre dos puntos (x1,y1) y (x2,y2)
