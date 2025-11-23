! ============================================================================
! Programa: Condicionales Simples (IF)
! Descripción: Aprende a usar estructuras IF para tomar decisiones
! ============================================================================

program if_simple
    implicit none

    integer :: edad, numero
    real :: temperatura, calificacion
    character(len=1) :: respuesta

    ! ========================================================================
    ! IF SIMPLE (una sola condición)
    ! ========================================================================

    print *, '======================================='
    print *, 'ESTRUCTURA IF SIMPLE'
    print *, '======================================='
    print *

    print *, '¿Cuál es tu edad?'
    read(*,*) edad

    ! IF simple: solo ejecuta si la condición es verdadera
    if (edad >= 18) then
        print *, '¡Eres mayor de edad!'
    end if

    print *

    ! ========================================================================
    ! IF-ELSE (dos alternativas)
    ! ========================================================================

    print *, 'ESTRUCTURA IF-ELSE'
    print *

    print *, 'Ingresa un número:'
    read(*,*) numero

    ! IF-ELSE: ejecuta una u otra alternativa
    if (numero > 0) then
        print *, 'El número es POSITIVO'
    else
        print *, 'El número es NEGATIVO o CERO'
    end if

    print *

    ! ========================================================================
    ! IF-ELSE IF-ELSE (múltiples alternativas)
    ! ========================================================================

    print *, 'ESTRUCTURA IF-ELSE IF-ELSE'
    print *

    print *, 'Ingresa la temperatura en °C:'
    read(*,*) temperatura

    ! Cadena de IF-ELSE IF-ELSE
    if (temperatura < 0.0) then
        print *, 'Hace mucho FRÍO (bajo cero)'
    else if (temperatura >= 0.0 .and. temperatura < 15.0) then
        print *, 'Hace FRÍO'
    else if (temperatura >= 15.0 .and. temperatura < 25.0) then
        print *, 'Temperatura AGRADABLE'
    else if (temperatura >= 25.0 .and. temperatura < 35.0) then
        print *, 'Hace CALOR'
    else
        print *, 'Hace MUCHO CALOR (¡cuidado!)'
    end if

    print *

    ! ========================================================================
    ! OPERADORES DE COMPARACIÓN
    ! ========================================================================

    print *, '======================================='
    print *, 'OPERADORES DE COMPARACIÓN'
    print *, '======================================='
    print *

    numero = 10

    ! Igual a (==)
    if (numero == 10) then
        print *, numero, 'es igual a 10'
    end if

    ! Diferente de (/=)
    if (numero /= 5) then
        print *, numero, 'es diferente de 5'
    end if

    ! Mayor que (>)
    if (numero > 5) then
        print *, numero, 'es mayor que 5'
    end if

    ! Menor que (<)
    if (numero < 20) then
        print *, numero, 'es menor que 20'
    end if

    ! Mayor o igual (>=)
    if (numero >= 10) then
        print *, numero, 'es mayor o igual a 10'
    end if

    ! Menor o igual (<=)
    if (numero <= 15) then
        print *, numero, 'es menor o igual a 15'
    end if

    print *

    ! ========================================================================
    ! OPERADORES LÓGICOS
    ! ========================================================================

    print *, 'OPERADORES LÓGICOS'
    print *

    edad = 25
    calificacion = 8.5

    ! AND (.and.) - Ambas condiciones deben ser verdaderas
    if (edad >= 18 .and. calificacion >= 8.0) then
        print *, 'Eres mayor de edad Y tienes buen promedio'
    end if

    ! OR (.or.) - Al menos una condición debe ser verdadera
    if (edad < 18 .or. edad > 65) then
        print *, 'Tienes descuento (menor de 18 o mayor de 65)'
    else
        print *, 'No tienes descuento por edad'
    end if

    ! NOT (.not.) - Invierte el valor de la condición
    if (.not. (numero < 0)) then
        print *, 'El número NO es negativo'
    end if

    print *

    ! ========================================================================
    ! EJEMPLO PRÁCTICO: SISTEMA DE CALIFICACIONES
    ! ========================================================================

    print *, '======================================='
    print *, 'SISTEMA DE CALIFICACIONES'
    print *, '======================================='
    print *

    print *, 'Ingresa tu calificación (0-10):'
    read(*,*) calificacion

    ! Validar entrada
    if (calificacion < 0.0 .or. calificacion > 10.0) then
        print *, 'Error: La calificación debe estar entre 0 y 10'
    else
        ! Asignar letra según calificación
        if (calificacion >= 9.0) then
            print *, 'Calificación: A (Excelente)'
        else if (calificacion >= 8.0) then
            print *, 'Calificación: B (Muy Bien)'
        else if (calificacion >= 7.0) then
            print *, 'Calificación: C (Bien)'
        else if (calificacion >= 6.0) then
            print *, 'Calificación: D (Suficiente)'
        else
            print *, 'Calificación: F (Reprobado)'
        end if

        ! Mensaje de aprobación
        if (calificacion >= 6.0) then
            print *, '¡Felicidades, aprobaste!'
        else
            print *, 'Lo siento, necesitas estudiar más'
        end if
    end if

    print *

    ! ========================================================================
    ! EJEMPLO PRÁCTICO: CALCULADORA DE DESCUENTOS
    ! ========================================================================

    print *, '======================================='
    print *, 'CALCULADORA DE DESCUENTOS'
    print *, '======================================='
    print *

    real :: precio_original, descuento, precio_final
    integer :: cantidad

    print *, 'Ingresa el precio del producto:'
    read(*,*) precio_original

    print *, 'Ingresa la cantidad a comprar:'
    read(*,*) cantidad

    ! Determinar descuento según cantidad
    if (cantidad >= 10) then
        descuento = 0.20  ! 20% de descuento
        print *, 'Descuento: 20%'
    else if (cantidad >= 5) then
        descuento = 0.10  ! 10% de descuento
        print *, 'Descuento: 10%'
    else
        descuento = 0.0   ! Sin descuento
        print *, 'Sin descuento'
    end if

    ! Calcular precio final
    precio_final = precio_original * cantidad * (1.0 - descuento)

    print '(A, F10.2)', 'Precio total: $', precio_final
    print *

    print *, '======================================='

end program if_simple

! ============================================================================
! OPERADORES EN FORTRAN:
!
! COMPARACIÓN:
!   ==    igual a
!   /=    diferente de
!   >     mayor que
!   <     menor que
!   >=    mayor o igual
!   <=    menor o igual
!
! LÓGICOS:
!   .and.   Y lógico (ambas condiciones verdaderas)
!   .or.    O lógico (al menos una verdadera)
!   .not.   Negación lógica (invierte el valor)
!
! SINTAXIS ALTERNATIVA (FORTRAN 77):
!   .eq.    igual a (equivalente a ==)
!   .ne.    no igual (equivalente a /=)
!   .gt.    mayor que (equivalente a >)
!   .lt.    menor que (equivalente a <)
!   .ge.    mayor o igual (equivalente a >=)
!   .le.    menor o igual (equivalente a <=)
!
! COMPILAR Y EJECUTAR:
!   gfortran -o if_simple 01_if_simple.f90
!   ./if_simple
! ============================================================================

! EJERCICIOS:
! 1. Programa que determine si un año es bisiesto
! 2. Calculadora de IMC con clasificación detallada
! 3. Programa que determine si un número es par o impar
! 4. Sistema que calcule impuestos según ingreso anual
! 5. Programa que valide si un triángulo es válido (suma de 2 lados > tercer lado)
