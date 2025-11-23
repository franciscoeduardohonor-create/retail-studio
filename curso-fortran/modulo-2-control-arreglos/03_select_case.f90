! ============================================================================
! Programa: SELECT CASE (Switch/Case)
! Descripción: Selección múltiple basada en el valor de una variable
! ============================================================================

program select_case_ejemplo
    implicit none

    integer :: opcion, dia_semana, mes
    character(len=1) :: calificacion_letra
    real :: numero1, numero2, resultado

    ! ========================================================================
    ! SELECT CASE BÁSICO
    ! ========================================================================

    print *, '======================================='
    print *, 'ESTRUCTURA SELECT CASE'
    print *, '======================================='
    print *

    print *, 'Ingresa un día de la semana (1-7):'
    read(*,*) dia_semana

    ! SELECT CASE permite seleccionar entre múltiples opciones
    select case (dia_semana)
        case (1)
            print *, 'Lunes - Inicio de semana'
        case (2)
            print *, 'Martes'
        case (3)
            print *, 'Miércoles - Mitad de semana'
        case (4)
            print *, 'Jueves'
        case (5)
            print *, 'Viernes - ¡Casi fin de semana!'
        case (6)
            print *, 'Sábado - Fin de semana'
        case (7)
            print *, 'Domingo - Fin de semana'
        case default
            print *, 'Error: Día inválido (debe ser 1-7)'
    end select

    print *

    ! ========================================================================
    ! SELECT CASE CON RANGOS
    ! ========================================================================

    print *, 'CASE CON RANGOS'
    print *

    print *, 'Ingresa un mes (1-12):'
    read(*,*) mes

    select case (mes)
        case (1, 2, 12)  ! Múltiples valores
            print *, 'Estación: INVIERNO'
        case (3:5)       ! Rango de valores (3 al 5)
            print *, 'Estación: PRIMAVERA'
        case (6:8)
            print *, 'Estación: VERANO'
        case (9:11)
            print *, 'Estación: OTOÑO'
        case default
            print *, 'Mes inválido'
    end select

    print *

    ! ========================================================================
    ! EJEMPLO PRÁCTICO: MENÚ DE CALCULADORA
    ! ========================================================================

    print *, '======================================='
    print *, 'CALCULADORA CON MENÚ'
    print *, '======================================='
    print *

    print *, 'Ingresa el primer número:'
    read(*,*) numero1

    print *, 'Ingresa el segundo número:'
    read(*,*) numero2

    print *
    print *, 'Selecciona una operación:'
    print *, '1. Suma'
    print *, '2. Resta'
    print *, '3. Multiplicación'
    print *, '4. División'
    print *, '5. Potencia'
    print *, 'Opción:'
    read(*,*) opcion

    select case (opcion)
        case (1)
            resultado = numero1 + numero2
            print '(A, F10.2)', 'Resultado: ', resultado

        case (2)
            resultado = numero1 - numero2
            print '(A, F10.2)', 'Resultado: ', resultado

        case (3)
            resultado = numero1 * numero2
            print '(A, F10.2)', 'Resultado: ', resultado

        case (4)
            if (numero2 /= 0.0) then
                resultado = numero1 / numero2
                print '(A, F10.2)', 'Resultado: ', resultado
            else
                print *, 'Error: División por cero'
            end if

        case (5)
            resultado = numero1 ** numero2
            print '(A, F10.2)', 'Resultado: ', resultado

        case default
            print *, 'Opción inválida'
    end select

    print *

    ! ========================================================================
    ! EJEMPLO: CLASIFICACIÓN DE EDADES
    ! ========================================================================

    print *, '======================================='
    print *, 'CLASIFICACIÓN POR EDAD'
    print *, '======================================='
    print *

    integer :: edad

    print *, 'Ingresa tu edad:'
    read(*,*) edad

    select case (edad)
        case (:12)              ! Menor o igual a 12
            print *, 'Categoría: NIÑO'
        case (13:17)            ! Entre 13 y 17
            print *, 'Categoría: ADOLESCENTE'
        case (18:64)            ! Entre 18 y 64
            print *, 'Categoría: ADULTO'
        case (65:)              ! 65 o más
            print *, 'Categoría: ADULTO MAYOR'
        case default
            print *, 'Edad inválida'
    end select

    print *

    ! ========================================================================
    ! EJEMPLO: CONVERSOR DE UNIDADES
    ! ========================================================================

    print *, '======================================='
    print *, 'CONVERSOR DE TEMPERATURA'
    print *, '======================================='
    print *

    real :: temperatura, convertida

    print *, 'Selecciona conversión:'
    print *, '1. Celsius a Fahrenheit'
    print *, '2. Fahrenheit a Celsius'
    print *, '3. Celsius a Kelvin'
    print *, '4. Kelvin a Celsius'
    print *, 'Opción:'
    read(*,*) opcion

    print *, 'Ingresa la temperatura:'
    read(*,*) temperatura

    select case (opcion)
        case (1)
            convertida = (temperatura * 9.0/5.0) + 32.0
            print '(F8.2, A, F8.2, A)', temperatura, '°C = ', convertida, '°F'

        case (2)
            convertida = (temperatura - 32.0) * 5.0/9.0
            print '(F8.2, A, F8.2, A)', temperatura, '°F = ', convertida, '°C'

        case (3)
            convertida = temperatura + 273.15
            print '(F8.2, A, F8.2, A)', temperatura, '°C = ', convertida, 'K'

        case (4)
            convertida = temperatura - 273.15
            print '(F8.2, A, F8.2, A)', temperatura, 'K = ', convertida, '°C'

        case default
            print *, 'Opción no válida'
    end select

    print *

    ! ========================================================================
    ! EJEMPLO: SISTEMA DE CALIFICACIONES CON LETRAS
    ! ========================================================================

    print *, '======================================='
    print *, 'INTERPRETACIÓN DE CALIFICACIONES'
    print *, '======================================='
    print *

    print *, 'Ingresa tu calificación (A, B, C, D, F):'
    read(*,*) calificacion_letra

    select case (calificacion_letra)
        case ('A', 'a')
            print *, 'Excelente (9-10)'
            print *, '¡Magnífico trabajo!'

        case ('B', 'b')
            print *, 'Muy Bien (8-8.9)'
            print *, 'Buen desempeño'

        case ('C', 'c')
            print *, 'Bien (7-7.9)'
            print *, 'Satisfactorio'

        case ('D', 'd')
            print *, 'Suficiente (6-6.9)'
            print *, 'Apenas aprobado'

        case ('F', 'f')
            print *, 'Reprobado (0-5.9)'
            print *, 'Necesitas mejorar'

        case default
            print *, 'Calificación no reconocida'
    end select

    print *
    print *, '======================================='

end program select_case_ejemplo

! ============================================================================
! SINTAXIS DE SELECT CASE:
!
! select case (variable)
!     case (valor1)
!         ! código para valor1
!     case (valor2, valor3)
!         ! código para valor2 o valor3
!     case (inicio:fin)
!         ! código para rango
!     case (:limite)
!         ! código para valores <= limite
!     case (limite:)
!         ! código para valores >= limite
!     case default
!         ! código si no coincide ningún caso
! end select
!
! VENTAJAS DE SELECT CASE:
! - Más legible que múltiples IF-ELSE IF
! - Más eficiente para muchas opciones
! - Permite rangos y múltiples valores fácilmente
!
! LIMITACIONES:
! - Solo funciona con tipos integer, character y logical
! - No se pueden usar expresiones complejas
!
! COMPILAR Y EJECUTAR:
!   gfortran -o select_case 03_select_case.f90
!   ./select_case
! ============================================================================

! EJERCICIOS:
! 1. Menú de restaurante que muestre platillos según categoría
! 2. Conversor de unidades completo (longitud, peso, volumen)
! 3. Sistema que determine el número de días según el mes
! 4. Calculadora de figuras geométricas (área y perímetro)
! 5. Sistema de descuentos según membresía (bronce, plata, oro, platino)
