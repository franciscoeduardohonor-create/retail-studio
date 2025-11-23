! ============================================================================
! Programa Principal: Uso de Módulos
! Descripción: Ejemplo de cómo usar módulos en FORTRAN
! ============================================================================

program programa_principal
    use matematicas  ! Importar el módulo matematicas
    implicit none

    real :: radio, area, perimetro, volumen
    integer :: n
    real :: a, b, c, x1, x2
    logical :: tiene_sol
    integer :: i

    print *, '======================================='
    print *, 'PROGRAMA CON MÓDULOS'
    print *, '======================================='
    print *

    ! ========================================================================
    ! USAR CONSTANTES DEL MÓDULO
    ! ========================================================================

    print *, 'Constantes del módulo matemáticas:'
    print '(A, F15.12)', 'PI = ', PI
    print '(A, F15.12)', 'E = ', E
    print '(A, F15.12)', 'PHI = ', PHI
    print *

    ! ========================================================================
    ! USAR FUNCIONES DEL MÓDULO
    ! ========================================================================

    print *, 'CÁLCULOS CON CÍRCULO:'
    radio = 5.0

    ! Llamar a funciones del módulo
    area = area_circulo(radio)
    perimetro = perimetro_circulo(radio)
    volumen = volumen_esfera(radio)

    print '(A, F6.2)', 'Radio: ', radio
    print '(A, F10.2)', 'Área: ', area
    print '(A, F10.2)', 'Perímetro: ', perimetro
    print '(A, F10.2)', 'Volumen esfera: ', volumen
    print *

    ! ========================================================================
    ! FACTORIALES
    ! ========================================================================

    print *, 'FACTORIALES:'
    do i = 1, 10
        print '(I2, A, I10)', i, '! = ', factorial(i)
    end do
    print *

    ! ========================================================================
    ! NÚMEROS PRIMOS
    ! ========================================================================

    print *, 'NÚMEROS PRIMOS DEL 1 AL 50:'
    do i = 1, 50
        if (es_primo(i)) then
            print '(I4)', i
        end if
    end do
    print *

    ! ========================================================================
    ! ECUACIÓN CUADRÁTICA
    ! ========================================================================

    print *, 'RESOLVER ECUACIÓN CUADRÁTICA:'
    print *, 'x² - 5x + 6 = 0'

    a = 1.0
    b = -5.0
    c = 6.0

    call ecuacion_cuadratica(a, b, c, x1, x2, tiene_sol)

    if (tiene_sol) then
        print '(A, F8.2)', 'x1 = ', x1
        print '(A, F8.2)', 'x2 = ', x2
    else
        print *, 'No tiene soluciones reales'
    end if
    print *

    ! ========================================================================
    ! USAR VARIABLE DEL MÓDULO
    ! ========================================================================

    print '(A, I5)', 'Total de operaciones realizadas: ', &
                      contador_operaciones
    print *

    print *, '======================================='

end program programa_principal

! ============================================================================
! COMPILACIÓN DE PROGRAMAS CON MÓDULOS:
!
! Opción 1 - Compilar todo junto:
!   gfortran -o programa matematicas_mod.f90 programa_principal.f90
!
! Opción 2 - Compilar por separado:
!   gfortran -c matematicas_mod.f90     # Crea matematicas.mod y .o
!   gfortran -c programa_principal.f90  # Crea .o
!   gfortran -o programa matematicas_mod.o programa_principal.o
!
! Ejecutar:
!   ./programa
!
! VENTAJAS DE LOS MÓDULOS:
! - Reutilización de código
! - Mejor organización
! - Evita duplicación
! - Facilita mantenimiento
! - Permite ocultar implementación
! - Namespace separado
! ============================================================================
