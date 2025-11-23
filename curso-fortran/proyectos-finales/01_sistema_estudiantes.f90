! ============================================================================
! PROYECTO FINAL: Sistema de Gestión de Estudiantes
! Descripción: Sistema completo para administrar estudiantes y calificaciones
! Autor: Curso de FORTRAN
! ============================================================================

program sistema_estudiantes
    implicit none

    ! Definición del tipo Estudiante
    type :: Estudiante
        integer :: id
        character(len=50) :: nombre
        character(len=30) :: carrera
        integer :: semestre
        real, dimension(6) :: calificaciones  ! 6 materias
        real :: promedio
        logical :: activo
    end type Estudiante

    ! Variables del programa
    type(Estudiante), dimension(100) :: estudiantes
    integer :: num_estudiantes, opcion, i
    character(len=50) :: archivo_datos

    ! Inicializar
    num_estudiantes = 0
    archivo_datos = 'estudiantes.dat'

    ! Cargar datos existentes
    call cargar_datos(estudiantes, num_estudiantes, archivo_datos)

    ! ========================================================================
    ! MENÚ PRINCIPAL
    ! ========================================================================

    do
        call mostrar_menu()
        read(*,*) opcion

        select case (opcion)
            case (1)
                call agregar_estudiante(estudiantes, num_estudiantes)
            case (2)
                call mostrar_estudiantes(estudiantes, num_estudiantes)
            case (3)
                call buscar_estudiante(estudiantes, num_estudiantes)
            case (4)
                call modificar_estudiante(estudiantes, num_estudiantes)
            case (5)
                call eliminar_estudiante(estudiantes, num_estudiantes)
            case (6)
                call estadisticas_generales(estudiantes, num_estudiantes)
            case (7)
                call reporte_completo(estudiantes, num_estudiantes)
            case (8)
                call guardar_datos(estudiantes, num_estudiantes, archivo_datos)
            case (9)
                call guardar_datos(estudiantes, num_estudiantes, archivo_datos)
                print *, '¡Hasta luego!'
                exit
            case default
                print *, 'Opción inválida'
        end select

        print *
        print *, 'Presiona Enter para continuar...'
        read(*,*)
    end do

contains

    ! ========================================================================
    ! SUBRUTINAS DEL SISTEMA
    ! ========================================================================

    subroutine mostrar_menu()
        print *
        print *, '======================================='
        print *, '   SISTEMA DE GESTIÓN DE ESTUDIANTES'
        print *, '======================================='
        print *, '1. Agregar estudiante'
        print *, '2. Mostrar todos los estudiantes'
        print *, '3. Buscar estudiante'
        print *, '4. Modificar estudiante'
        print *, '5. Eliminar estudiante'
        print *, '6. Estadísticas generales'
        print *, '7. Generar reporte completo'
        print *, '8. Guardar datos'
        print *, '9. Salir'
        print *, '======================================='
        print *, 'Selecciona una opción:'
    end subroutine mostrar_menu

    subroutine agregar_estudiante(lista, n)
        type(Estudiante), dimension(:), intent(inout) :: lista
        integer, intent(inout) :: n
        integer :: i

        if (n >= 100) then
            print *, 'Error: Base de datos llena'
            return
        end if

        n = n + 1

        print *
        print *, 'AGREGAR NUEVO ESTUDIANTE'
        print *, '------------------------'

        lista(n)%id = n
        lista(n)%activo = .true.

        print *, 'Nombre completo:'
        read(*,'(A)') lista(n)%nombre

        print *, 'Carrera:'
        read(*,'(A)') lista(n)%carrera

        print *, 'Semestre:'
        read(*,*) lista(n)%semestre

        print *, 'Ingresa las 6 calificaciones:'
        do i = 1, 6
            print '(A, I1, A)', 'Materia ', i, ':'
            read(*,*) lista(n)%calificaciones(i)
        end do

        ! Calcular promedio
        lista(n)%promedio = sum(lista(n)%calificaciones) / 6.0

        print *
        print *, 'Estudiante agregado exitosamente'
        print '(A, F5.2)', 'Promedio: ', lista(n)%promedio
    end subroutine agregar_estudiante

    subroutine mostrar_estudiantes(lista, n)
        type(Estudiante), dimension(:), intent(in) :: lista
        integer, intent(in) :: n
        integer :: i

        if (n == 0) then
            print *, 'No hay estudiantes registrados'
            return
        end if

        print *
        print *, 'LISTA DE ESTUDIANTES'
        print *, '===================='
        print *
        print '(A3, A25, A20, A10, A10)', 'ID', 'Nombre', 'Carrera', &
              'Semestre', 'Promedio'
        print *, repeat('-', 70)

        do i = 1, n
            if (lista(i)%activo) then
                print '(I3, A25, A20, I10, F10.2)', lista(i)%id, &
                      trim(lista(i)%nombre), trim(lista(i)%carrera), &
                      lista(i)%semestre, lista(i)%promedio
            end if
        end do
    end subroutine mostrar_estudiantes

    subroutine buscar_estudiante(lista, n)
        type(Estudiante), dimension(:), intent(in) :: lista
        integer, intent(in) :: n
        integer :: id, i

        print *, 'Ingresa el ID del estudiante:'
        read(*,*) id

        do i = 1, n
            if (lista(i)%id == id .and. lista(i)%activo) then
                call mostrar_detalle_estudiante(lista(i))
                return
            end if
        end do

        print *, 'Estudiante no encontrado'
    end subroutine buscar_estudiante

    subroutine mostrar_detalle_estudiante(est)
        type(Estudiante), intent(in) :: est
        integer :: i

        print *
        print *, 'INFORMACIÓN DETALLADA'
        print *, '====================='
        print '(A, I4)', 'ID: ', est%id
        print '(A, A)', 'Nombre: ', trim(est%nombre)
        print '(A, A)', 'Carrera: ', trim(est%carrera)
        print '(A, I2)', 'Semestre: ', est%semestre
        print *
        print *, 'Calificaciones:'
        do i = 1, 6
            print '(A, I1, A, F5.2)', '  Materia ', i, ': ', &
                  est%calificaciones(i)
        end do
        print *
        print '(A, F5.2)', 'PROMEDIO: ', est%promedio
    end subroutine mostrar_detalle_estudiante

    subroutine modificar_estudiante(lista, n)
        type(Estudiante), dimension(:), intent(inout) :: lista
        integer, intent(in) :: n
        integer :: id, i, opcion

        print *, 'Ingresa el ID del estudiante a modificar:'
        read(*,*) id

        do i = 1, n
            if (lista(i)%id == id .and. lista(i)%activo) then
                print *, '¿Qué deseas modificar?'
                print *, '1. Nombre'
                print *, '2. Carrera'
                print *, '3. Semestre'
                print *, '4. Calificaciones'
                read(*,*) opcion

                select case (opcion)
                    case (1)
                        print *, 'Nuevo nombre:'
                        read(*,'(A)') lista(i)%nombre
                    case (2)
                        print *, 'Nueva carrera:'
                        read(*,'(A)') lista(i)%carrera
                    case (3)
                        print *, 'Nuevo semestre:'
                        read(*,*) lista(i)%semestre
                    case (4)
                        call modificar_calificaciones(lista(i))
                end select

                print *, 'Estudiante modificado exitosamente'
                return
            end if
        end do

        print *, 'Estudiante no encontrado'
    end subroutine modificar_estudiante

    subroutine modificar_calificaciones(est)
        type(Estudiante), intent(inout) :: est
        integer :: i

        print *, 'Ingresa las nuevas calificaciones:'
        do i = 1, 6
            print '(A, I1, A)', 'Materia ', i, ':'
            read(*,*) est%calificaciones(i)
        end do

        est%promedio = sum(est%calificaciones) / 6.0
    end subroutine modificar_calificaciones

    subroutine eliminar_estudiante(lista, n)
        type(Estudiante), dimension(:), intent(inout) :: lista
        integer, intent(in) :: n
        integer :: id, i
        character(len=1) :: confirmar

        print *, 'Ingresa el ID del estudiante a eliminar:'
        read(*,*) id

        do i = 1, n
            if (lista(i)%id == id .and. lista(i)%activo) then
                print *, '¿Estás seguro? (S/N)'
                read(*,*) confirmar

                if (confirmar == 'S' .or. confirmar == 's') then
                    lista(i)%activo = .false.
                    print *, 'Estudiante eliminado'
                end if
                return
            end if
        end do

        print *, 'Estudiante no encontrado'
    end subroutine eliminar_estudiante

    subroutine estadisticas_generales(lista, n)
        type(Estudiante), dimension(:), intent(in) :: lista
        integer, intent(in) :: n
        real :: promedio_general, mejor_promedio, peor_promedio
        integer :: i, activos

        if (n == 0) then
            print *, 'No hay datos'
            return
        end if

        promedio_general = 0.0
        mejor_promedio = 0.0
        peor_promedio = 10.0
        activos = 0

        do i = 1, n
            if (lista(i)%activo) then
                activos = activos + 1
                promedio_general = promedio_general + lista(i)%promedio

                if (lista(i)%promedio > mejor_promedio) then
                    mejor_promedio = lista(i)%promedio
                end if

                if (lista(i)%promedio < peor_promedio) then
                    peor_promedio = lista(i)%promedio
                end if
            end if
        end do

        if (activos > 0) then
            promedio_general = promedio_general / real(activos)
        end if

        print *
        print *, 'ESTADÍSTICAS GENERALES'
        print *, '======================'
        print '(A, I4)', 'Total de estudiantes: ', activos
        print '(A, F5.2)', 'Promedio general: ', promedio_general
        print '(A, F5.2)', 'Mejor promedio: ', mejor_promedio
        print '(A, F5.2)', 'Peor promedio: ', peor_promedio
    end subroutine estadisticas_generales

    subroutine reporte_completo(lista, n)
        type(Estudiante), dimension(:), intent(in) :: lista
        integer, intent(in) :: n
        integer :: i

        open(unit=10, file='reporte_estudiantes.txt', status='replace')

        write(10,*) '======================================='
        write(10,*) '   REPORTE COMPLETO DE ESTUDIANTES'
        write(10,*) '======================================='
        write(10,*)

        do i = 1, n
            if (lista(i)%activo) then
                write(10,*) 'ID:', lista(i)%id
                write(10,*) 'Nombre:', trim(lista(i)%nombre)
                write(10,*) 'Carrera:', trim(lista(i)%carrera)
                write(10,*) 'Semestre:', lista(i)%semestre
                write(10,*) 'Calificaciones:', lista(i)%calificaciones
                write(10,'(A, F5.2)') 'Promedio: ', lista(i)%promedio
                write(10,*) '---------------------------------------'
            end if
        end do

        close(10)

        print *, 'Reporte generado: reporte_estudiantes.txt'
    end subroutine reporte_completo

    subroutine guardar_datos(lista, n, archivo)
        type(Estudiante), dimension(:), intent(in) :: lista
        integer, intent(in) :: n
        character(len=*), intent(in) :: archivo
        integer :: i

        open(unit=20, file=archivo, status='replace', form='unformatted')

        write(20) n

        do i = 1, n
            write(20) lista(i)
        end do

        close(20)

        print *, 'Datos guardados exitosamente'
    end subroutine guardar_datos

    subroutine cargar_datos(lista, n, archivo)
        type(Estudiante), dimension(:), intent(out) :: lista
        integer, intent(out) :: n
        character(len=*), intent(in) :: archivo
        integer :: i, iostat

        open(unit=20, file=archivo, status='old', form='unformatted', &
             iostat=iostat)

        if (iostat /= 0) then
            n = 0
            return
        end if

        read(20) n

        do i = 1, n
            read(20) lista(i)
        end do

        close(20)

        print *, 'Datos cargados:', n, 'estudiantes'
    end subroutine cargar_datos

end program sistema_estudiantes

! ============================================================================
! COMPILAR Y EJECUTAR:
!   gfortran -o estudiantes 01_sistema_estudiantes.f90
!   ./estudiantes
!
! CARACTERÍSTICAS DEL SISTEMA:
! - Agregar, modificar, eliminar estudiantes
! - Buscar y mostrar información
! - Calcular promedios automáticamente
! - Generar estadísticas
! - Guardar/cargar datos en archivo binario
! - Generar reportes en texto
!
! MEJORAS POSIBLES:
! - Agregar más validaciones
! - Implementar búsqueda por nombre
! - Agregar más estadísticas
! - Exportar a CSV
! - Interfaz gráfica
! ============================================================================
