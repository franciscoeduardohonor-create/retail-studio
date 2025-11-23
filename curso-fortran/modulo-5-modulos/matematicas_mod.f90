! ============================================================================
! Módulo: Matemáticas
! Descripción: Módulo con funciones matemáticas reutilizables
! ============================================================================

module matematicas
    implicit none

    ! Constantes del módulo
    real, parameter :: PI = 3.141592653589793
    real, parameter :: E = 2.718281828459045
    real, parameter :: PHI = 1.618033988749895  ! Número áureo

    ! Variables públicas del módulo
    integer :: contador_operaciones = 0

contains

    ! Función para calcular área de círculo
    real function area_circulo(radio)
        real, intent(in) :: radio
        area_circulo = PI * radio**2
        contador_operaciones = contador_operaciones + 1
    end function area_circulo

    ! Función para calcular perímetro de círculo
    real function perimetro_circulo(radio)
        real, intent(in) :: radio
        perimetro_circulo = 2.0 * PI * radio
        contador_operaciones = contador_operaciones + 1
    end function perimetro_circulo

    ! Función para calcular volumen de esfera
    real function volumen_esfera(radio)
        real, intent(in) :: radio
        volumen_esfera = (4.0/3.0) * PI * radio**3
        contador_operaciones = contador_operaciones + 1
    end function volumen_esfera

    ! Función factorial
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

        contador_operaciones = contador_operaciones + 1
    end function factorial

    ! Función para verificar si es primo
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

        do i = 2, int(sqrt(real(n))) + 1
            if (mod(n, i) == 0) then
                es_primo = .false.
                return
            end if
        end do

        es_primo = .true.
        contador_operaciones = contador_operaciones + 1
    end function es_primo

    ! Función para calcular potencia
    real function potencia(base, exponente)
        real, intent(in) :: base
        integer, intent(in) :: exponente
        integer :: i

        potencia = 1.0
        do i = 1, exponente
            potencia = potencia * base
        end do

        contador_operaciones = contador_operaciones + 1
    end function potencia

    ! Subrutina para resolver ecuación cuadrática
    subroutine ecuacion_cuadratica(a, b, c, x1, x2, tiene_solucion)
        real, intent(in) :: a, b, c
        real, intent(out) :: x1, x2
        logical, intent(out) :: tiene_solucion
        real :: discriminante

        discriminante = b**2 - 4*a*c

        if (discriminante < 0.0) then
            tiene_solucion = .false.
            x1 = 0.0
            x2 = 0.0
        else
            tiene_solucion = .true.
            x1 = (-b + sqrt(discriminante)) / (2*a)
            x2 = (-b - sqrt(discriminante)) / (2*a)
        end if

        contador_operaciones = contador_operaciones + 1
    end subroutine ecuacion_cuadratica

end module matematicas
