! ============================================================================
! Programa: Manejo de Archivos de Texto
! Descripción: Aprende a leer y escribir archivos en FORTRAN
! ============================================================================

program archivos_texto
    implicit none

    integer :: unit_number, iostat, i
    character(len=100) :: linea, nombre_archivo
    real :: numero
    integer, parameter :: MAX_DATOS = 100
    real, dimension(MAX_DATOS) :: datos
    integer :: n_datos

    ! ========================================================================
    ! ESCRIBIR EN UN ARCHIVO
    ! ========================================================================

    print *, '======================================='
    print *, 'ESCRITURA DE ARCHIVOS'
    print *, '======================================='
    print *

    ! Abrir archivo para escribir
    open(unit=10, file='salida.txt', status='replace', action='write')

    ! Escribir datos
    write(10,*) 'Este es un archivo de prueba'
    write(10,*) 'Creado con FORTRAN'
    write(10,*) 'Números del 1 al 10:'

    do i = 1, 10
        write(10,*) i, i**2, i**3
    end do

    ! Cerrar archivo
    close(10)

    print *, 'Archivo "salida.txt" creado exitosamente'
    print *

    ! ========================================================================
    ! LEER DE UN ARCHIVO
    ! ========================================================================

    print *, 'LECTURA DE ARCHIVOS:'
    print *

    ! Abrir archivo para leer
    open(unit=10, file='salida.txt', status='old', action='read', &
         iostat=iostat)

    if (iostat /= 0) then
        print *, 'Error al abrir el archivo'
        stop
    end if

    ! Leer línea por línea
    print *, 'Contenido del archivo:'
    print *, repeat('-', 40)

    do
        read(10, '(A)', iostat=iostat) linea
        if (iostat /= 0) exit  ! Salir al final del archivo
        print *, trim(linea)
    end do

    close(10)
    print *, repeat('-', 40)
    print *

    ! ========================================================================
    ! ESCRIBIR DATOS NUMÉRICOS FORMATEADOS
    ! ========================================================================

    print *, 'ARCHIVO CON FORMATO:'
    print *

    open(unit=15, file='datos.dat', status='replace')

    ! Escribir encabezado
    write(15, '(A)') 'X      Y      Z'
    write(15, '(A)') '----  ----  ----'

    ! Escribir datos formateados
    do i = 1, 10
        write(15, '(I4, 2X, F6.2, 2X, F6.2)') i, real(i)*1.5, real(i)**2*0.5
    end do

    close(15)

    print *, 'Archivo "datos.dat" creado'
    print *

    ! ========================================================================
    ! LEER DATOS NUMÉRICOS
    ! ========================================================================

    print *, 'LECTURA DE DATOS NUMÉRICOS:'
    print *

    ! Crear archivo con números
    open(unit=20, file='numeros.txt', status='replace')
    write(20,*) 10.5
    write(20,*) 20.3
    write(20,*) 15.7
    write(20,*) 8.9
    write(20,*) 12.4
    close(20)

    ! Leer números
    open(unit=20, file='numeros.txt', status='old')

    n_datos = 0
    do
        read(20, *, iostat=iostat) numero
        if (iostat /= 0) exit
        n_datos = n_datos + 1
        datos(n_datos) = numero
    end do

    close(20)

    print *, 'Datos leídos del archivo:'
    do i = 1, n_datos
        print '(I2, A, F8.2)', i, ': ', datos(i)
    end do
    print *

    print '(A, F8.2)', 'Promedio: ', sum(datos(1:n_datos))/real(n_datos)
    print *

    ! ========================================================================
    ! ARCHIVO DE REGISTRO (LOG)
    ! ========================================================================

    print *, 'CREANDO ARCHIVO DE LOG:'
    print *

    open(unit=30, file='registro.log', status='replace')

    call escribir_log(30, 'Programa iniciado')
    call escribir_log(30, 'Leyendo datos de entrada...')
    call escribir_log(30, 'Procesando información...')
    call escribir_log(30, 'Cálculos completados exitosamente')
    call escribir_log(30, 'Programa finalizado')

    close(30)

    print *, 'Archivo de registro creado'
    print *

    print *, '======================================='

contains

    ! Subrutina para escribir en log con timestamp
    subroutine escribir_log(unit, mensaje)
        integer, intent(in) :: unit
        character(len=*), intent(in) :: mensaje
        integer :: fecha(8)

        call date_and_time(values=fecha)

        write(unit, '(I4.4, A, I2.2, A, I2.2, A, I2.2, A, I2.2, A, I2.2, A, A)') &
              fecha(1), '-', fecha(2), '-', fecha(3), ' ', &
              fecha(5), ':', fecha(6), ':', fecha(7), ' - ', trim(mensaje)
    end subroutine escribir_log

end program archivos_texto

! ============================================================================
! COMANDOS PARA ARCHIVOS:
!
! OPEN - Abrir archivo:
!   open(unit=número, file='nombre.txt', status=..., action=...)
!
!   unit   - Número de unidad (10-99 típicamente)
!   file   - Nombre del archivo
!   status - 'old' (existente), 'new', 'replace', 'scratch'
!   action - 'read', 'write', 'readwrite'
!   iostat - Variable para capturar errores
!
! READ/WRITE - Leer/Escribir:
!   read(unit, formato, iostat=...) variables
!   write(unit, formato) variables
!
! CLOSE - Cerrar archivo:
!   close(unit)
!
! REWIND - Volver al inicio:
!   rewind(unit)
!
! BACKSPACE - Retroceder una línea:
!   backspace(unit)
!
! COMPILAR Y EJECUTAR:
!   gfortran -o archivos 01_archivos_texto.f90
!   ./archivos
! ============================================================================

! EJERCICIOS:
! 1. Programa que lea un archivo CSV y calcule estadísticas
! 2. Programa que copie un archivo línea por línea
! 3. Programa que busque una palabra en un archivo
! 4. Programa que combine dos archivos en uno
! 5. Programa que cuente líneas, palabras y caracteres de un archivo
