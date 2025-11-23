! ============================================================================
! Programa: Tipos Derivados (Estructuras)
! Descripción: Aprende a crear y usar tipos de datos personalizados
! ============================================================================

program tipos_derivados
    implicit none

    ! ========================================================================
    ! DEFINICIÓN DE TIPOS DERIVADOS
    ! ========================================================================

    ! Tipo para representar un punto en 2D
    type :: Punto2D
        real :: x
        real :: y
    end type Punto2D

    ! Tipo para representar una persona
    type :: Persona
        character(len=50) :: nombre
        integer :: edad
        real :: altura
        real :: peso
    end type Persona

    ! Tipo para representar un estudiante
    type :: Estudiante
        character(len=50) :: nombre
        integer :: matricula
        real, dimension(5) :: calificaciones
        real :: promedio
    end type Estudiante

    ! Tipo para representar un círculo
    type :: Circulo
        real :: radio
        real :: centro_x
        real :: centro_y
    end type Circulo

    ! Tipo para representar un rectángulo
    type :: Rectangulo
        real :: ancho
        real :: alto
        type(Punto2D) :: esquina_sup_izq  ! Tipo anidado
    end type Rectangulo

    ! ========================================================================
    ! DECLARACIÓN DE VARIABLES DE TIPOS DERIVADOS
    ! ========================================================================

    type(Punto2D) :: p1, p2
    type(Persona) :: persona1, persona2
    type(Estudiante) :: estudiante1
    type(Circulo) :: circulo1
    type(Rectangulo) :: rect1

    real :: distancia
    integer :: i

    ! ========================================================================
    ! USO DE TIPOS DERIVADOS
    ! ========================================================================

    print *, '======================================='
    print *, 'TIPOS DERIVADOS EN FORTRAN'
    print *, '======================================='
    print *

    ! Asignar valores a un punto
    p1%x = 3.0
    p1%y = 4.0

    p2%x = 6.0
    p2%y = 8.0

    print *, 'PUNTOS:'
    print '(A, F6.2, A, F6.2, A)', 'P1: (', p1%x, ',', p1%y, ')'
    print '(A, F6.2, A, F6.2, A)', 'P2: (', p2%x, ',', p2%y, ')'
    print *

    ! Calcular distancia entre puntos
    distancia = sqrt((p2%x - p1%x)**2 + (p2%y - p1%y)**2)
    print '(A, F8.4)', 'Distancia entre P1 y P2: ', distancia
    print *

    ! ========================================================================
    ! TIPO PERSONA
    ! ========================================================================

    print *, 'DATOS DE PERSONAS:'
    print *

    ! Persona 1
    persona1%nombre = 'Juan Pérez'
    persona1%edad = 30
    persona1%altura = 1.75
    persona1%peso = 70.5

    ! Persona 2
    persona2%nombre = 'María García'
    persona2%edad = 28
    persona2%altura = 1.65
    persona2%peso = 60.0

    call mostrar_persona(persona1)
    call mostrar_persona(persona2)
    print *

    ! ========================================================================
    ! TIPO ESTUDIANTE
    ! ========================================================================

    print *, 'DATOS DE ESTUDIANTE:'
    print *

    estudiante1%nombre = 'Carlos López'
    estudiante1%matricula = 12345
    estudiante1%calificaciones = [9.5, 8.7, 9.0, 8.5, 9.2]

    ! Calcular promedio
    estudiante1%promedio = sum(estudiante1%calificaciones) / 5.0

    print *, 'Nombre:', trim(estudiante1%nombre)
    print *, 'Matrícula:', estudiante1%matricula
    print *, 'Calificaciones:', estudiante1%calificaciones
    print '(A, F5.2)', 'Promedio: ', estudiante1%promedio
    print *

    ! ========================================================================
    ! ARREGLO DE TIPOS DERIVADOS
    ! ========================================================================

    print *, 'ARREGLO DE ESTUDIANTES:'
    print *

    type(Estudiante), dimension(3) :: clase

    ! Estudiante 1
    clase(1)%nombre = 'Ana Martínez'
    clase(1)%matricula = 1001
    clase(1)%calificaciones = [8.5, 9.0, 8.0, 8.5, 9.2]
    clase(1)%promedio = sum(clase(1)%calificaciones) / 5.0

    ! Estudiante 2
    clase(2)%nombre = 'Pedro Sánchez'
    clase(2)%matricula = 1002
    clase(2)%calificaciones = [7.5, 8.0, 7.0, 8.5, 7.8]
    clase(2)%promedio = sum(clase(2)%calificaciones) / 5.0

    ! Estudiante 3
    clase(3)%nombre = 'Laura Torres'
    clase(3)%matricula = 1003
    clase(3)%calificaciones = [9.5, 10.0, 9.8, 9.5, 9.7]
    clase(3)%promedio = sum(clase(3)%calificaciones) / 5.0

    ! Mostrar todos los estudiantes
    print '(A15, A12, A10)', 'Nombre', 'Matrícula', 'Promedio'
    print *, repeat('-', 40)

    do i = 1, 3
        print '(A15, I12, F10.2)', trim(clase(i)%nombre), &
              clase(i)%matricula, clase(i)%promedio
    end do
    print *

    ! ========================================================================
    ! TIPO CÍRCULO
    ! ========================================================================

    print *, 'CÁLCULOS CON CÍRCULO:'
    print *

    circulo1%radio = 5.0
    circulo1%centro_x = 0.0
    circulo1%centro_y = 0.0

    call mostrar_circulo(circulo1)
    print *

    ! ========================================================================
    ! TIPO ANIDADO - RECTÁNGULO
    ! ========================================================================

    print *, 'RECTÁNGULO CON TIPO ANIDADO:'
    print *

    rect1%ancho = 10.0
    rect1%alto = 5.0
    rect1%esquina_sup_izq%x = 2.0
    rect1%esquina_sup_izq%y = 3.0

    print '(A, F6.2)', 'Ancho: ', rect1%ancho
    print '(A, F6.2)', 'Alto: ', rect1%alto
    print '(A, F6.2, A, F6.2, A)', 'Esquina superior izquierda: (', &
          rect1%esquina_sup_izq%x, ',', rect1%esquina_sup_izq%y, ')'
    print '(A, F8.2)', 'Área: ', rect1%ancho * rect1%alto
    print *

    print *, '======================================='

contains

    ! Subrutina para mostrar información de una persona
    subroutine mostrar_persona(p)
        type(Persona), intent(in) :: p
        real :: imc

        imc = p%peso / (p%altura**2)

        print *, 'Nombre:', trim(p%nombre)
        print *, 'Edad:', p%edad, 'años'
        print '(A, F5.2, A)', 'Altura: ', p%altura, ' m'
        print '(A, F5.2, A)', 'Peso: ', p%peso, ' kg'
        print '(A, F5.2)', 'IMC: ', imc
        print *
    end subroutine mostrar_persona

    ! Subrutina para mostrar información de un círculo
    subroutine mostrar_circulo(c)
        type(Circulo), intent(in) :: c
        real, parameter :: PI = 3.141592653589793
        real :: area, perimetro

        area = PI * c%radio**2
        perimetro = 2.0 * PI * c%radio

        print '(A, F6.2)', 'Radio: ', c%radio
        print '(A, F6.2, A, F6.2, A)', 'Centro: (', c%centro_x, ',', &
              c%centro_y, ')'
        print '(A, F10.2)', 'Área: ', area
        print '(A, F10.2)', 'Perímetro: ', perimetro
    end subroutine mostrar_circulo

end program tipos_derivados

! ============================================================================
! TIPOS DERIVADOS (ESTRUCTURAS):
!
! DEFINICIÓN:
!   type :: NombreTipo
!       tipo :: campo1
!       tipo :: campo2
!   end type NombreTipo
!
! DECLARACIÓN:
!   type(NombreTipo) :: variable
!
! ACCESO A CAMPOS:
!   variable%campo1
!   variable%campo2
!
! VENTAJAS:
! - Agrupar datos relacionados
! - Código más organizado y legible
! - Facilita manejo de datos complejos
! - Permite crear tipos anidados
! - Base para POO en FORTRAN
!
! COMPILAR Y EJECUTAR:
!   gfortran -o tipos 01_tipos_derivados.f90
!   ./tipos
! ============================================================================

! EJERCICIOS:
! 1. Crea un tipo 'Libro' con título, autor, año, páginas
! 2. Crea un tipo 'Fecha' y uno 'Evento' que lo use
! 3. Crea un tipo 'Vehiculo' con marca, modelo, año, precio
! 4. Implementa un sistema de biblioteca con arreglo de libros
! 5. Crea un tipo 'Matrix' que encapsule una matriz con sus operaciones
