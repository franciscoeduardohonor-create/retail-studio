! ============================================================================
! Programa: Constantes en FORTRAN
! Descripción: Aprende a declarar y usar constantes
! ============================================================================

program constantes
    implicit none

    ! ========================================================================
    ! DECLARACIÓN DE CONSTANTES
    ! ========================================================================
    ! Las constantes se declaran con el atributo PARAMETER
    ! Su valor NO puede cambiar durante la ejecución del programa

    ! Constantes numéricas
    real, parameter :: PI = 3.141592653589793
    real, parameter :: E = 2.718281828459045
    real, parameter :: GRAVEDAD = 9.81  ! m/s²
    real, parameter :: VELOCIDAD_LUZ = 299792458.0  ! m/s

    ! Constantes enteras
    integer, parameter :: DIAS_SEMANA = 7
    integer, parameter :: MESES_AÑO = 12
    integer, parameter :: HORAS_DIA = 24

    ! Constantes de texto
    character(len=*), parameter :: NOMBRE_PROGRAMA = 'Sistema de Cálculos'
    character(len=*), parameter :: VERSION = 'v1.0'
    character(len=*), parameter :: AUTOR = 'Estudiante de FORTRAN'

    ! Constantes lógicas
    logical, parameter :: DEBUG_MODE = .true.

    ! Variables para cálculos
    real :: radio, area, circunferencia
    real :: altura_objeto, tiempo_caida
    real :: distancia, tiempo, velocidad
    integer :: dias_total

    ! ========================================================================
    ! USO DE CONSTANTES EN CÁLCULOS
    ! ========================================================================

    print *, '======================================='
    print *, trim(NOMBRE_PROGRAMA), ' ', trim(VERSION)
    print *, 'Autor:', trim(AUTOR)
    print *, '======================================='
    print *

    ! Ejemplo 1: Cálculos con PI
    print *, 'CÁLCULOS CON LA CONSTANTE PI:'
    radio = 5.0
    area = PI * radio**2
    circunferencia = 2.0 * PI * radio

    print *, 'Radio del círculo:', radio, 'cm'
    print *, 'Área del círculo:', area, 'cm²'
    print *, 'Circunferencia:', circunferencia, 'cm'
    print *

    ! Ejemplo 2: Cálculos con la constante de gravedad
    print *, 'CÁLCULOS CON GRAVEDAD:'
    altura_objeto = 20.0  ! metros

    ! Tiempo de caída libre: t = sqrt(2h/g)
    tiempo_caida = sqrt(2.0 * altura_objeto / GRAVEDAD)

    print *, 'Altura del objeto:', altura_objeto, 'm'
    print *, 'Gravedad:', GRAVEDAD, 'm/s²'
    print *, 'Tiempo de caída:', tiempo_caida, 's'
    print *

    ! Ejemplo 3: Cálculo con velocidad de la luz
    print *, 'CÁLCULOS CON VELOCIDAD DE LA LUZ:'
    tiempo = 1.0  ! segundo
    distancia = VELOCIDAD_LUZ * tiempo

    print *, 'Tiempo:', tiempo, 's'
    print *, 'Distancia recorrida por la luz:', distancia, 'm'
    print *, 'Equivalente a:', distancia / 1000.0, 'km'
    print *

    ! Ejemplo 4: Uso de constantes enteras
    print *, 'CÁLCULOS CON CONSTANTES DE TIEMPO:'
    dias_total = 2 * DIAS_SEMANA  ! dos semanas

    print *, 'Días en una semana:', DIAS_SEMANA
    print *, 'Meses en un año:', MESES_AÑO
    print *, 'Horas en un día:', HORAS_DIA
    print *, 'Días en dos semanas:', dias_total
    print *, 'Horas en dos semanas:', dias_total * HORAS_DIA
    print *

    ! Ejemplo 5: Constante de Euler (e)
    print *, 'CÁLCULOS CON LA CONSTANTE E:'
    print *, 'e =', E
    print *, 'e² =', E**2
    print *, 'ln(e) =', log(E)
    print *

    ! ========================================================================
    ! VENTAJAS DE USAR CONSTANTES
    ! ========================================================================

    print *, '======================================='
    print *, 'VENTAJAS DE USAR CONSTANTES:'
    print *, '======================================='
    print *, '1. El código es más legible'
    print *, '2. Fácil mantenimiento'
    print *, '3. Evita errores de tipeo'
    print *, '4. El compilador puede optimizar'
    print *, '5. Documentación integrada'
    print *, '======================================='
    print *

    ! Modo debug
    if (DEBUG_MODE) then
        print *, '[DEBUG] Programa ejecutado correctamente'
    end if

end program constantes

! ============================================================================
! NOTAS IMPORTANTES SOBRE CONSTANTES:
!
! 1. PARAMETER hace que una variable sea de solo lectura (constante)
! 2. El valor debe asignarse en la declaración
! 3. character(len=*) permite que el compilador determine la longitud
! 4. Las constantes mejoran la legibilidad del código
! 5. Es convención usar MAYÚSCULAS para nombres de constantes
!
! DIFERENCIA ENTRE VARIABLE Y CONSTANTE:
!
!   Variable:
!   real :: temperatura
!   temperatura = 20.0
!   temperatura = 25.0  ! Se puede cambiar
!
!   Constante:
!   real, parameter :: PUNTO_CONGELACION = 0.0
!   ! PUNTO_CONGELACION = 5.0  ! ¡ERROR! No se puede cambiar
!
! COMPILAR Y EJECUTAR:
!   gfortran -o constantes 05_constantes.f90
!   ./constantes
! ============================================================================

! EJERCICIOS:
! 1. Crea constantes para convertir unidades:
!    - Pulgadas a centímetros (1 in = 2.54 cm)
!    - Millas a kilómetros (1 mi = 1.60934 km)
!    - Libras a kilogramos (1 lb = 0.453592 kg)
!
! 2. Usa estas constantes para hacer conversiones
!
! 3. Crea un programa con constantes físicas:
!    - Constante de Planck
!    - Constante de Boltzmann
!    - Número de Avogadro
!
! 4. Haz un programa que calcule interés compuesto usando
!    una tasa de interés constante
