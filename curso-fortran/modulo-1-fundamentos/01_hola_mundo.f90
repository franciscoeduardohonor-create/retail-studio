! ============================================================================
! Programa: Hola Mundo en FORTRAN
! Descripción: Este es tu primer programa en FORTRAN. Muestra un mensaje
!              en la pantalla.
! Autor: Curso de FORTRAN
! ============================================================================

program hola_mundo
    ! 'implicit none' es una buena práctica que obliga a declarar todas
    ! las variables explícitamente, evitando errores
    implicit none

    ! FORTRAN usa 'print' o 'write' para mostrar información en pantalla
    ! El asterisco (*) significa formato libre (sin formato específico)
    print *, '¡Hola Mundo desde FORTRAN!'

    ! También puedes usar write para la salida estándar
    ! El primer * es la unidad (salida estándar)
    ! El segundo * es el formato
    write(*,*) 'Este es mi primer programa en FORTRAN'

    ! Puedes imprimir varias líneas
    print *, '=================================='
    print *, 'FORTRAN es un lenguaje poderoso'
    print *, 'para cálculo científico y numérico'
    print *, '=================================='

end program hola_mundo

! ============================================================================
! CÓMO COMPILAR Y EJECUTAR:
!
! En la terminal, escribe:
!   gfortran -o hola 01_hola_mundo.f90
!   ./hola
!
! SALIDA ESPERADA:
! ¡Hola Mundo desde FORTRAN!
! Este es mi primer programa en FORTRAN
! ==================================
! FORTRAN es un lenguaje poderoso
! para cálculo científico y numérico
! ==================================
! ============================================================================

! EJERCICIO PARA TI:
! 1. Modifica el programa para que imprima tu nombre
! 2. Agrega más líneas que describan por qué quieres aprender FORTRAN
! 3. Experimenta usando solo 'print' o solo 'write' para ver la diferencia
