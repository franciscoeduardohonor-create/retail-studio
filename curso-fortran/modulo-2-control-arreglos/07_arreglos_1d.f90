! ============================================================================
! Programa: Arreglos Unidimensionales (Vectores)
! Descripción: Aprende a declarar, usar y manipular arreglos 1D
! ============================================================================

program arreglos_1d
    implicit none

    ! ========================================================================
    ! DECLARACIÓN DE ARREGLOS
    ! ========================================================================

    ! Arreglo de 10 enteros
    integer, dimension(10) :: numeros

    ! Sintaxis alternativa (equivalente)
    integer :: edades(5)

    ! Arreglo de reales
    real, dimension(100) :: temperaturas

    ! Arreglo de caracteres
    character(len=20), dimension(3) :: nombres

    ! Variables auxiliares
    integer :: i, n, suma, maximo, minimo, posicion_max
    real :: promedio

    ! ========================================================================
    ! ASIGNACIÓN DE VALORES
    ! ========================================================================

    print *, '======================================='
    print *, 'ASIGNACIÓN DE VALORES EN ARREGLOS'
    print *, '======================================='
    print *

    ! Asignación elemento por elemento
    numeros(1) = 10
    numeros(2) = 20
    numeros(3) = 30
    numeros(4) = 40
    numeros(5) = 50

    ! Mostrar valores
    print *, 'Arreglo numeros:'
    do i = 1, 5
        print *, 'numeros(', i, ') =', numeros(i)
    end do

    print *

    ! Asignación de todo el arreglo a un valor
    edades = 0  ! Todos los elementos = 0

    print *, 'Arreglo edades inicializado a 0:'
    print *, edades

    print *

    ! ========================================================================
    ! LEER ARREGLO DEL USUARIO
    ! ========================================================================

    print *, '======================================='
    print *, 'ENTRADA DE DATOS'
    print *, '======================================='
    print *

    n = 5  ! Número de elementos

    print *, 'Ingresa', n, 'números enteros:'

    do i = 1, n
        print *, 'Número', i, ':'
        read(*,*) numeros(i)
    end do

    ! Mostrar lo que ingresó
    print *
    print *, 'Los números que ingresaste son:'
    do i = 1, n
        print *, numeros(i)
    end do

    print *

    ! ========================================================================
    ! OPERACIONES CON ARREGLOS
    ! ========================================================================

    print *, '======================================='
    print *, 'OPERACIONES CON ARREGLOS'
    print *, '======================================='
    print *

    ! Calcular suma
    suma = 0
    do i = 1, n
        suma = suma + numeros(i)
    end do

    ! Calcular promedio
    promedio = real(suma) / real(n)

    print '(A, I10)', 'Suma: ', suma
    print '(A, F10.2)', 'Promedio: ', promedio
    print *

    ! Encontrar máximo y mínimo
    maximo = numeros(1)
    minimo = numeros(1)
    posicion_max = 1

    do i = 2, n
        if (numeros(i) > maximo) then
            maximo = numeros(i)
            posicion_max = i
        end if

        if (numeros(i) < minimo) then
            minimo = numeros(i)
        end if
    end do

    print '(A, I10, A, I2)', 'Máximo: ', maximo, ' (posición ', posicion_max, ')'
    print '(A, I10)', 'Mínimo: ', minimo
    print *

    ! ========================================================================
    ! OPERACIONES VECTORIALES
    ! ========================================================================

    print *, '======================================='
    print *, 'OPERACIONES VECTORIALES'
    print *, '======================================='
    print *

    integer, dimension(5) :: vector_a, vector_b, vector_suma
    real, dimension(5) :: vector_real
    real :: escalar

    ! Inicializar vectores
    vector_a = [1, 2, 3, 4, 5]
    vector_b = [10, 20, 30, 40, 50]

    print *, 'Vector A:', vector_a
    print *, 'Vector B:', vector_b
    print *

    ! Suma de vectores
    vector_suma = vector_a + vector_b
    print *, 'A + B =', vector_suma
    print *

    ! Multiplicación por escalar
    escalar = 2.0
    vector_real = real(vector_a) * escalar
    print *, 'A * 2.0 =', vector_real
    print *

    ! ========================================================================
    ! BÚSQUEDA EN ARREGLOS
    ! ========================================================================

    print *, '======================================='
    print *, 'BÚSQUEDA EN ARREGLOS'
    print *, '======================================='
    print *

    integer :: valor_buscar, encontrado, posicion
    integer, dimension(10) :: datos

    ! Llenar arreglo
    datos = [5, 12, 7, 23, 9, 15, 3, 18, 11, 6]

    print *, 'Datos:', datos
    print *

    print *, 'Ingresa un valor a buscar:'
    read(*,*) valor_buscar

    encontrado = 0
    posicion = 0

    do i = 1, 10
        if (datos(i) == valor_buscar) then
            encontrado = 1
            posicion = i
            exit  ! Salir del bucle cuando lo encuentra
        end if
    end do

    if (encontrado == 1) then
        print *, 'Valor encontrado en la posición:', posicion
    else
        print *, 'Valor no encontrado'
    end if

    print *

    ! ========================================================================
    ! ORDENAMIENTO BURBUJA (BUBBLE SORT)
    ! ========================================================================

    print *, '======================================='
    print *, 'ORDENAMIENTO DE ARREGLOS'
    print *, '======================================='
    print *

    integer :: temp, j
    integer, dimension(8) :: desordenado

    desordenado = [64, 34, 25, 12, 22, 11, 90, 88]

    print *, 'Arreglo original:', desordenado
    print *

    ! Algoritmo de ordenamiento burbuja
    do i = 1, 7
        do j = 1, 8-i
            if (desordenado(j) > desordenado(j+1)) then
                ! Intercambiar elementos
                temp = desordenado(j)
                desordenado(j) = desordenado(j+1)
                desordenado(j+1) = temp
            end if
        end do
    end do

    print *, 'Arreglo ordenado:', desordenado
    print *

    ! ========================================================================
    ! ESTADÍSTICAS DE UN ARREGLO
    ! ========================================================================

    print *, '======================================='
    print *, 'ESTADÍSTICAS'
    print *, '======================================='
    print *

    real, dimension(10) :: calificaciones
    real :: suma_cal, promedio_cal, varianza, desviacion

    ! Datos de ejemplo
    calificaciones = [7.5, 8.0, 9.2, 6.8, 8.5, 7.9, 9.0, 8.3, 7.2, 8.8]

    print *, 'Calificaciones:', calificaciones
    print *

    ! Promedio
    suma_cal = sum(calificaciones)  ! Función intrínseca sum()
    promedio_cal = suma_cal / 10.0

    ! Varianza
    varianza = 0.0
    do i = 1, 10
        varianza = varianza + (calificaciones(i) - promedio_cal)**2
    end do
    varianza = varianza / 10.0

    ! Desviación estándar
    desviacion = sqrt(varianza)

    print '(A, F6.2)', 'Promedio: ', promedio_cal
    print '(A, F6.2)', 'Máximo: ', maxval(calificaciones)  ! Función maxval()
    print '(A, F6.2)', 'Mínimo: ', minval(calificaciones)  ! Función minval()
    print '(A, F6.2)', 'Varianza: ', varianza
    print '(A, F6.2)', 'Desviación estándar: ', desviacion
    print *

    ! ========================================================================
    ! HISTOGRAMA DE DATOS
    ! ========================================================================

    print *, '======================================='
    print *, 'HISTOGRAMA DE CALIFICACIONES'
    print *, '======================================='
    print *

    integer :: rangos(5)
    character(len=50) :: barra

    ! Inicializar contadores
    rangos = 0

    ! Contar calificaciones por rango
    do i = 1, 10
        if (calificaciones(i) >= 9.0) then
            rangos(1) = rangos(1) + 1  ! 9.0-10.0
        else if (calificaciones(i) >= 8.0) then
            rangos(2) = rangos(2) + 1  ! 8.0-8.9
        else if (calificaciones(i) >= 7.0) then
            rangos(3) = rangos(3) + 1  ! 7.0-7.9
        else if (calificaciones(i) >= 6.0) then
            rangos(4) = rangos(4) + 1  ! 6.0-6.9
        else
            rangos(5) = rangos(5) + 1  ! 0.0-5.9
        end if
    end do

    ! Mostrar histograma
    print *, '9.0-10.0: ', repeat('*', rangos(1))
    print *, '8.0-8.9:  ', repeat('*', rangos(2))
    print *, '7.0-7.9:  ', repeat('*', rangos(3))
    print *, '6.0-6.9:  ', repeat('*', rangos(4))
    print *, '0.0-5.9:  ', repeat('*', rangos(5))
    print *

    print *, '======================================='

end program arreglos_1d

! ============================================================================
! FUNCIONES INTRÍNSECAS ÚTILES PARA ARREGLOS:
!
! sum(array)       - Suma de todos los elementos
! maxval(array)    - Valor máximo
! minval(array)    - Valor mínimo
! maxloc(array)    - Posición del máximo
! minloc(array)    - Posición del mínimo
! size(array)      - Tamaño del arreglo
! product(array)   - Producto de todos los elementos
!
! SINTAXIS DE ARREGLOS:
!   integer, dimension(n) :: array
!   integer :: array(n)
!
! INICIALIZACIÓN:
!   array = [1, 2, 3, 4, 5]
!   array = 0
!   array = (/ 1, 2, 3 /)  ! Sintaxis antigua
!
! COMPILAR Y EJECUTAR:
!   gfortran -o arreglos_1d 07_arreglos_1d.f90
!   ./arreglos_1d
! ============================================================================

! EJERCICIOS:
! 1. Programa que invierta un arreglo (primer elemento con último, etc.)
! 2. Encuentra números duplicados en un arreglo
! 3. Calcula el producto punto de dos vectores
! 4. Encuentra la mediana de un conjunto de datos
! 5. Elimina elementos duplicados de un arreglo
! 6. Rota un arreglo n posiciones a la izquierda o derecha
