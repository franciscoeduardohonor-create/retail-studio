! ============================================================================
! Programa: Bucles DO
! Descripción: Aprende a usar bucles para repetir código
! ============================================================================

program bucle_do
    implicit none

    integer :: i, n, suma, factorial
    real :: promedio, numero
    integer :: contador_positivos, contador_negativos

    ! ========================================================================
    ! BUCLE DO BÁSICO
    ! ========================================================================

    print *, '======================================='
    print *, 'BUCLE DO BÁSICO'
    print *, '======================================='
    print *

    ! Bucle simple del 1 al 10
    print *, 'Números del 1 al 10:'
    do i = 1, 10
        print *, i
    end do

    print *

    ! Bucle con incremento personalizado
    print *, 'Números pares del 2 al 20:'
    do i = 2, 20, 2  ! inicio, fin, incremento
        print *, i
    end do

    print *

    ! Bucle hacia atrás
    print *, 'Cuenta regresiva del 10 al 1:'
    do i = 10, 1, -1  ! incremento negativo
        print *, i
    end do
    print *, '¡Despegue!'

    print *

    ! ========================================================================
    ! BUCLES CON ACUMULADORES
    ! ========================================================================

    print *, '======================================='
    print *, 'SUMA DE NÚMEROS'
    print *, '======================================='
    print *

    print *, '¿Cuántos números deseas sumar?'
    read(*,*) n

    suma = 0  ! Inicializar acumulador

    do i = 1, n
        print *, 'Ingresa el número', i, ':'
        read(*,*) numero
        suma = suma + numero
    end do

    promedio = real(suma) / real(n)

    print *
    print '(A, I10)', 'Suma total: ', suma
    print '(A, F10.2)', 'Promedio: ', promedio
    print *

    ! ========================================================================
    ! TABLAS DE MULTIPLICAR
    ! ========================================================================

    print *, '======================================='
    print *, 'TABLA DE MULTIPLICAR'
    print *, '======================================='
    print *

    print *, '¿De qué número quieres la tabla?'
    read(*,*) n

    print *
    print '(A, I2)', 'Tabla del ', n
    print *, '-------------------'

    do i = 1, 10
        print '(I2, A, I2, A, I4)', n, ' x ', i, ' = ', n*i
    end do

    print *

    ! ========================================================================
    ! CÁLCULO DE FACTORIAL
    ! ========================================================================

    print *, '======================================='
    print *, 'FACTORIAL DE UN NÚMERO'
    print *, '======================================='
    print *

    print *, 'Ingresa un número para calcular su factorial:'
    read(*,*) n

    if (n < 0) then
        print *, 'El factorial no está definido para números negativos'
    else
        factorial = 1

        do i = 1, n
            factorial = factorial * i
        end do

        print '(I2, A, I15)', n, '! = ', factorial
    end if

    print *

    ! ========================================================================
    ! SERIE FIBONACCI
    ! ========================================================================

    print *, '======================================='
    print *, 'SERIE DE FIBONACCI'
    print *, '======================================='
    print *

    integer :: a, b, siguiente

    print *, '¿Cuántos términos de Fibonacci quieres?'
    read(*,*) n

    a = 0
    b = 1

    print *, 'Serie de Fibonacci:'

    do i = 1, n
        if (i == 1) then
            print *, a
        else if (i == 2) then
            print *, b
        else
            siguiente = a + b
            print *, siguiente
            a = b
            b = siguiente
        end if
    end do

    print *

    ! ========================================================================
    ! CONTADOR DE NÚMEROS POSITIVOS Y NEGATIVOS
    ! ========================================================================

    print *, '======================================='
    print *, 'CLASIFICADOR DE NÚMEROS'
    print *, '======================================='
    print *

    print *, '¿Cuántos números vas a ingresar?'
    read(*,*) n

    contador_positivos = 0
    contador_negativos = 0
    suma = 0

    do i = 1, n
        print *, 'Número', i, ':'
        read(*,*) numero

        if (numero > 0) then
            contador_positivos = contador_positivos + 1
        else if (numero < 0) then
            contador_negativos = contador_negativos + 1
        end if

        suma = suma + numero
    end do

    print *
    print *, 'RESULTADOS:'
    print '(A, I5)', 'Números positivos: ', contador_positivos
    print '(A, I5)', 'Números negativos: ', contador_negativos
    print '(A, I5)', 'Ceros: ', n - contador_positivos - contador_negativos
    print '(A, F10.2)', 'Suma total: ', real(suma)
    print *

    ! ========================================================================
    ! SUMA DE PARES E IMPARES
    ! ========================================================================

    print *, '======================================='
    print *, 'SUMA DE PARES E IMPARES (1-100)'
    print *, '======================================='
    print *

    integer :: suma_pares, suma_impares

    suma_pares = 0
    suma_impares = 0

    do i = 1, 100
        if (mod(i, 2) == 0) then
            suma_pares = suma_pares + i
        else
            suma_impares = suma_impares + i
        end if
    end do

    print '(A, I6)', 'Suma de números pares (1-100): ', suma_pares
    print '(A, I6)', 'Suma de números impares (1-100): ', suma_impares
    print *

    ! ========================================================================
    ! NÚMEROS PRIMOS
    ! ========================================================================

    print *, '======================================='
    print *, 'NÚMEROS PRIMOS'
    print *, '======================================='
    print *

    print *, 'Números primos del 2 al 50:'
    print *

    integer :: j, es_primo

    do i = 2, 50
        es_primo = 1  ! Asumimos que es primo

        ! Verificar si tiene divisores
        do j = 2, i-1
            if (mod(i, j) == 0) then
                es_primo = 0  ! No es primo
                exit  ! Salir del bucle interno
            end if
        end do

        if (es_primo == 1) then
            print *, i
        end if
    end do

    print *
    print *, '======================================='

end program bucle_do

! ============================================================================
! SINTAXIS DEL BUCLE DO:
!
! Forma básica:
!   do variable = inicio, fin
!       ! código que se repite
!   end do
!
! Con incremento:
!   do variable = inicio, fin, incremento
!       ! código que se repite
!   end do
!
! Ejemplos:
!   do i = 1, 10          ! 1, 2, 3, ..., 10
!   do i = 0, 20, 2       ! 0, 2, 4, ..., 20
!   do i = 10, 1, -1      ! 10, 9, 8, ..., 1
!
! COMANDOS ÚTILES EN BUCLES:
!   exit     - Sale del bucle inmediatamente
!   cycle    - Salta a la siguiente iteración
!
! FUNCIONES ÚTILES:
!   mod(a,b) - Resto de dividir a entre b
!
! COMPILAR Y EJECUTAR:
!   gfortran -o bucle_do 04_bucle_do.f90
!   ./bucle_do
! ============================================================================

! EJERCICIOS:
! 1. Programa que calcule la suma de los cuadrados del 1 al n
! 2. Encuentra todos los números divisibles por 3 y 5 entre 1 y 100
! 3. Calcula el promedio de n calificaciones ingresadas por el usuario
! 4. Genera la tabla de multiplicar del 1 al 10 (todas)
! 5. Encuentra el número mayor y menor de una serie de n números
! 6. Calcula n términos de la serie: 1/1 + 1/2 + 1/3 + ... + 1/n
