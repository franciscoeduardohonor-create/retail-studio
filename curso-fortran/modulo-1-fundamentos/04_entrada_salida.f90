! ============================================================================
! Programa: Entrada y Salida de Datos
! Descripción: Aprende a leer datos del usuario y mostrar resultados
! ============================================================================

program entrada_salida
    implicit none

    ! Declaración de variables
    character(len=50) :: nombre
    integer :: edad, año_nacimiento
    real :: altura, peso, imc
    character(len=30) :: ciudad
    real :: celsius, fahrenheit

    ! ========================================================================
    ! ENTRADA BÁSICA DE DATOS
    ! ========================================================================

    print *, '======================================='
    print *, 'PROGRAMA DE ENTRADA Y SALIDA'
    print *, '======================================='
    print *

    ! Solicitar el nombre
    print *, 'Por favor, ingresa tu nombre:'
    read(*,*) nombre  ! Lee una línea del teclado

    ! Solicitar la edad
    print *, 'Ingresa tu edad:'
    read(*,*) edad

    ! Solicitar la altura
    print *, 'Ingresa tu altura en metros (ej: 1.75):'
    read(*,*) altura

    ! Solicitar el peso
    print *, 'Ingresa tu peso en kilogramos:'
    read(*,*) peso

    ! Solicitar la ciudad
    print *, 'Ingresa tu ciudad:'
    read(*,*) ciudad

    ! ========================================================================
    ! PROCESAMIENTO DE DATOS
    ! ========================================================================

    ! Calcular año de nacimiento (aproximado)
    año_nacimiento = 2025 - edad

    ! Calcular IMC (Índice de Masa Corporal)
    imc = peso / (altura * altura)

    ! ========================================================================
    ! SALIDA FORMATEADA DE DATOS
    ! ========================================================================

    print *
    print *, '======================================='
    print *, 'RESUMEN DE TU INFORMACIÓN'
    print *, '======================================='
    print *
    print *, 'Nombre:', trim(nombre)  ! trim() elimina espacios en blanco
    print *, 'Edad:', edad, 'años'
    print *, 'Año de nacimiento (aprox):', año_nacimiento
    print *, 'Altura:', altura, 'm'
    print *, 'Peso:', peso, 'kg'
    print *, 'Ciudad:', trim(ciudad)
    print *, 'IMC:', imc
    print *

    ! Interpretación del IMC
    if (imc < 18.5) then
        print *, 'Tu IMC indica: Bajo peso'
    else if (imc >= 18.5 .and. imc < 25.0) then
        print *, 'Tu IMC indica: Peso normal'
    else if (imc >= 25.0 .and. imc < 30.0) then
        print *, 'Tu IMC indica: Sobrepeso'
    else
        print *, 'Tu IMC indica: Obesidad'
    end if

    print *
    print *, '======================================='

end program entrada_salida

! ============================================================================
! CÓMO FUNCIONA LA ENTRADA/SALIDA:
!
! SALIDA (mostrar datos):
!   print *, 'mensaje'           - Salida con formato libre
!   write(*,*) 'mensaje'         - Equivalente a print
!
! ENTRADA (leer datos):
!   read(*,*) variable           - Lee del teclado
!
! El primer * en read/write se refiere a la unidad de E/S:
!   * = entrada/salida estándar (teclado/pantalla)
!   5 = entrada estándar
!   6 = salida estándar
!
! El segundo * se refiere al formato:
!   * = formato libre
!   También puedes especificar formatos personalizados
!
! COMPILAR Y EJECUTAR:
!   gfortran -o entrada_salida 04_entrada_salida.f90
!   ./entrada_salida
! ============================================================================

! EJERCICIOS:
! 1. Crea un programa que pida dos números y muestre su suma, resta,
!    multiplicación y división
! 2. Haz un programa que convierta temperaturas de Celsius a Fahrenheit
!    Fórmula: F = (C × 9/5) + 32
! 3. Programa que calcule el área de un triángulo pidiendo base y altura
! 4. Programa que pida el radio de un círculo y calcule área y perímetro
