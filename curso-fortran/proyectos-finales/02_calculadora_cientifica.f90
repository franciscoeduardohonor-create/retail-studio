! ============================================================================
! PROYECTO FINAL: Calculadora Científica Completa
! Descripción: Calculadora con funciones matemáticas, científicas y estadísticas
! ============================================================================

program calculadora_cientifica
    implicit none

    real, parameter :: PI = 3.141592653589793
    real, parameter :: E = 2.718281828459045
    integer :: opcion, subopcion
    real :: x, y, resultado
    logical :: continuar

    continuar = .true.

    do while (continuar)
        call menu_principal()
        read(*,*) opcion

        select case (opcion)
            case (1)
                call operaciones_basicas()
            case (2)
                call funciones_potencia()
            case (3)
                call funciones_trigonometricas()
            case (4)
                call funciones_logaritmicas()
            case (5)
                call estadisticas()
            case (6)
                call conversiones()
            case (7)
                call constantes()
            case (8)
                call ecuaciones()
            case (9)
                continuar = .false.
                print *, '¡Gracias por usar la calculadora!'
            case default
                print *, 'Opción inválida'
        end select

        if (continuar) then
            print *
            print *, 'Presiona Enter para continuar...'
            read(*,*)
        end if
    end do

contains

    ! ========================================================================
    ! MENÚ PRINCIPAL
    ! ========================================================================

    subroutine menu_principal()
        print *
        print *, '╔═══════════════════════════════════════╗'
        print *, '║   CALCULADORA CIENTÍFICA - FORTRAN    ║'
        print *, '╚═══════════════════════════════════════╝'
        print *
        print *, '1. Operaciones básicas (+, -, ×, ÷)'
        print *, '2. Potencias y raíces'
        print *, '3. Funciones trigonométricas'
        print *, '4. Logaritmos y exponenciales'
        print *, '5. Estadísticas'
        print *, '6. Conversiones de unidades'
        print *, '7. Constantes matemáticas'
        print *, '8. Resolución de ecuaciones'
        print *, '9. Salir'
        print *
        print *, 'Selecciona una opción:'
    end subroutine menu_principal

    ! ========================================================================
    ! OPERACIONES BÁSICAS
    ! ========================================================================

    subroutine operaciones_basicas()
        real :: num1, num2

        print *
        print *, 'OPERACIONES BÁSICAS'
        print *, '-------------------'
        print *, 'Ingresa el primer número:'
        read(*,*) num1

        print *, 'Ingresa el segundo número:'
        read(*,*) num2

        print *
        print '(A, F12.4)', 'Suma:            ', num1 + num2
        print '(A, F12.4)', 'Resta:           ', num1 - num2
        print '(A, F12.4)', 'Multiplicación:  ', num1 * num2

        if (num2 /= 0.0) then
            print '(A, F12.4)', 'División:        ', num1 / num2
        else
            print *, 'División:        Error (división por cero)'
        end if

        print '(A, F12.4)', 'Módulo:          ', mod(num1, num2)
    end subroutine operaciones_basicas

    ! ========================================================================
    ! POTENCIAS Y RAÍCES
    ! ========================================================================

    subroutine funciones_potencia()
        real :: numero, exponente

        print *
        print *, 'POTENCIAS Y RAÍCES'
        print *, '------------------'
        print *, '1. Potencia (x^y)'
        print *, '2. Raíz cuadrada'
        print *, '3. Raíz cúbica'
        print *, '4. Raíz n-ésima'
        print *, 'Opción:'
        read(*,*) subopcion

        select case (subopcion)
            case (1)
                print *, 'Base:'
                read(*,*) numero
                print *, 'Exponente:'
                read(*,*) exponente
                print '(A, F12.4)', 'Resultado: ', numero**exponente

            case (2)
                print *, 'Número:'
                read(*,*) numero
                if (numero >= 0) then
                    print '(A, F12.4)', 'Raíz cuadrada: ', sqrt(numero)
                else
                    print *, 'Error: no se puede calcular raíz de negativo'
                end if

            case (3)
                print *, 'Número:'
                read(*,*) numero
                print '(A, F12.4)', 'Raíz cúbica: ', sign(abs(numero)**(1.0/3.0), numero)

            case (4)
                print *, 'Número:'
                read(*,*) numero
                print *, 'Índice de la raíz:'
                read(*,*) exponente
                if (numero >= 0 .or. mod(exponente, 2.0) /= 0) then
                    print '(A, F12.4)', 'Resultado: ', &
                          sign(abs(numero)**(1.0/exponente), numero)
                else
                    print *, 'Error: raíz par de número negativo'
                end if
        end select
    end subroutine funciones_potencia

    ! ========================================================================
    ! FUNCIONES TRIGONOMÉTRICAS
    ! ========================================================================

    subroutine funciones_trigonometricas()
        real :: angulo, angulo_rad
        integer :: unidad

        print *
        print *, 'FUNCIONES TRIGONOMÉTRICAS'
        print *, '-------------------------'
        print *, 'Ingresa el ángulo:'
        read(*,*) angulo

        print *, '¿En qué unidad? (1=Grados, 2=Radianes)'
        read(*,*) unidad

        if (unidad == 1) then
            angulo_rad = angulo * PI / 180.0
        else
            angulo_rad = angulo
        end if

        print *
        print '(A, F12.6)', 'Seno:       ', sin(angulo_rad)
        print '(A, F12.6)', 'Coseno:     ', cos(angulo_rad)
        print '(A, F12.6)', 'Tangente:   ', tan(angulo_rad)
        print *
        print '(A, F12.6)', 'Arcoseno:   ', asin(sin(angulo_rad)) * 180/PI, ' grados'
        print '(A, F12.6)', 'Arcocoseno: ', acos(cos(angulo_rad)) * 180/PI, ' grados'
        print '(A, F12.6)', 'Arcotangente:', atan(tan(angulo_rad)) * 180/PI, ' grados'
    end subroutine funciones_trigonometricas

    ! ========================================================================
    ! LOGARITMOS
    ! ========================================================================

    subroutine funciones_logaritmicas()
        real :: numero

        print *
        print *, 'LOGARITMOS Y EXPONENCIALES'
        print *, '--------------------------'
        print *, 'Ingresa el número:'
        read(*,*) numero

        if (numero > 0) then
            print *
            print '(A, F12.6)', 'Logaritmo natural (ln):  ', log(numero)
            print '(A, F12.6)', 'Logaritmo base 10:       ', log10(numero)
            print '(A, F12.6)', 'Exponencial (e^x):       ', exp(numero)
        else
            print *, 'Error: el logaritmo requiere un número positivo'
        end if
    end subroutine funciones_logaritmicas

    ! ========================================================================
    ! ESTADÍSTICAS
    ! ========================================================================

    subroutine estadisticas()
        integer :: n, i
        real, allocatable :: datos(:)
        real :: suma, media, varianza, desviacion

        print *
        print *, 'ESTADÍSTICAS'
        print *, '------------'
        print *, '¿Cuántos datos vas a ingresar?'
        read(*,*) n

        allocate(datos(n))

        print *, 'Ingresa los datos:'
        do i = 1, n
            print '(A, I3, A)', 'Dato ', i, ':'
            read(*,*) datos(i)
        end do

        ! Calcular estadísticas
        suma = sum(datos)
        media = suma / real(n)

        varianza = 0.0
        do i = 1, n
            varianza = varianza + (datos(i) - media)**2
        end do
        varianza = varianza / real(n)
        desviacion = sqrt(varianza)

        print *
        print *, 'RESULTADOS:'
        print '(A, F12.4)', 'Suma:                 ', suma
        print '(A, F12.4)', 'Media:                ', media
        print '(A, F12.4)', 'Varianza:             ', varianza
        print '(A, F12.4)', 'Desviación estándar:  ', desviacion
        print '(A, F12.4)', 'Valor máximo:         ', maxval(datos)
        print '(A, F12.4)', 'Valor mínimo:         ', minval(datos)

        deallocate(datos)
    end subroutine estadisticas

    ! ========================================================================
    ! CONVERSIONES
    ! ========================================================================

    subroutine conversiones()
        real :: valor

        print *
        print *, 'CONVERSIONES DE UNIDADES'
        print *, '------------------------'
        print *, '1. Temperatura (°C ↔ °F)'
        print *, '2. Longitud (km ↔ mi)'
        print *, '3. Peso (kg ↔ lb)'
        print *, '4. Volumen (L ↔ gal)'
        print *, 'Opción:'
        read(*,*) subopcion

        print *, 'Ingresa el valor:'
        read(*,*) valor

        select case (subopcion)
            case (1)
                print '(A, F10.2, A)', valor, '°C = ', (valor * 9.0/5.0 + 32.0), '°F'
                print '(A, F10.2, A)', valor, '°F = ', (valor - 32.0) * 5.0/9.0, '°C'

            case (2)
                print '(A, F10.2, A)', valor, ' km = ', valor * 0.621371, ' mi'
                print '(A, F10.2, A)', valor, ' mi = ', valor / 0.621371, ' km'

            case (3)
                print '(A, F10.2, A)', valor, ' kg = ', valor * 2.20462, ' lb'
                print '(A, F10.2, A)', valor, ' lb = ', valor / 2.20462, ' kg'

            case (4)
                print '(A, F10.2, A)', valor, ' L = ', valor * 0.264172, ' gal'
                print '(A, F10.2, A)', valor, ' gal = ', valor / 0.264172, ' L'
        end select
    end subroutine conversiones

    ! ========================================================================
    ! CONSTANTES
    ! ========================================================================

    subroutine constantes()
        print *
        print *, 'CONSTANTES MATEMÁTICAS Y FÍSICAS'
        print *, '--------------------------------'
        print '(A, F20.15)', 'π (Pi):                  ', PI
        print '(A, F20.15)', 'e (Euler):               ', E
        print '(A, F20.15)', 'φ (Phi - Áureo):         ', 1.618033988749895
        print '(A, F20.15)', 'Gravedad (m/s²):         ', 9.80665
        print '(A, F20.15)', 'Velocidad luz (m/s):     ', 299792458.0
        print '(A, F20.15)', 'Constante Planck (J·s):  ', 6.62607015e-34
        print '(A, F20.15)', 'Avogadro (1/mol):        ', 6.02214076e23
    end subroutine constantes

    ! ========================================================================
    ! ECUACIONES
    ! ========================================================================

    subroutine ecuaciones()
        real :: a, b, c, discriminante, x1, x2

        print *
        print *, 'RESOLUCIÓN DE ECUACIONES'
        print *, '------------------------'
        print *, 'Ecuación cuadrática: ax² + bx + c = 0'
        print *

        print *, 'Coeficiente a:'
        read(*,*) a

        print *, 'Coeficiente b:'
        read(*,*) b

        print *, 'Coeficiente c:'
        read(*,*) c

        discriminante = b**2 - 4*a*c

        print *
        print '(A, F12.4)', 'Discriminante: ', discriminante

        if (discriminante > 0) then
            x1 = (-b + sqrt(discriminante)) / (2*a)
            x2 = (-b - sqrt(discriminante)) / (2*a)
            print *, 'Dos soluciones reales:'
            print '(A, F12.6)', 'x1 = ', x1
            print '(A, F12.6)', 'x2 = ', x2
        else if (discriminante == 0) then
            x1 = -b / (2*a)
            print *, 'Una solución real (doble):'
            print '(A, F12.6)', 'x = ', x1
        else
            print *, 'Dos soluciones complejas:'
            print '(A, F12.6, A, F12.6, A)', 'x1 = ', -b/(2*a), ' + ', &
                  sqrt(-discriminante)/(2*a), 'i'
            print '(A, F12.6, A, F12.6, A)', 'x2 = ', -b/(2*a), ' - ', &
                  sqrt(-discriminante)/(2*a), 'i'
        end if
    end subroutine ecuaciones

end program calculadora_cientifica

! ============================================================================
! COMPILAR Y EJECUTAR:
!   gfortran -o calc 02_calculadora_cientifica.f90
!   ./calc
!
! CARACTERÍSTICAS:
! - Operaciones básicas completas
! - Funciones trigonométricas (grados/radianes)
! - Logaritmos y exponenciales
! - Estadísticas básicas
! - Conversiones de unidades
! - Constantes físicas y matemáticas
! - Resolución de ecuaciones cuadráticas
!
! FUNCIONALIDADES ADICIONALES POSIBLES:
! - Derivadas numéricas
! - Integrales numéricas
! - Matrices y vectores
! - Números complejos
! - Historial de cálculos
! - Guardar resultados en archivo
! ============================================================================
