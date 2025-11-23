! ============================================================================
! Programa: Variables y Tipos de Datos
! Descripción: Aprende a declarar y usar diferentes tipos de variables
! ============================================================================

program variables_tipos
    implicit none

    ! ========================================================================
    ! TIPOS DE DATOS BÁSICOS EN FORTRAN
    ! ========================================================================

    ! INTEGER: Para números enteros (sin decimales)
    integer :: edad, año_actual, cantidad_estudiantes
    integer :: numero_negativo

    ! REAL: Para números decimales (precisión simple)
    real :: altura, peso, temperatura
    real :: precio_producto

    ! DOUBLE PRECISION: Para decimales con mayor precisión
    double precision :: pi_preciso, constante_gravitacional
    double precision :: resultado_cientifico

    ! CHARACTER: Para texto y cadenas de caracteres
    character(len=50) :: nombre_completo
    character(len=20) :: ciudad
    character(len=1)  :: inicial

    ! LOGICAL: Para valores verdadero/falso
    logical :: es_mayor_edad, esta_lloviendo
    logical :: aprobado

    ! COMPLEX: Para números complejos (parte real e imaginaria)
    complex :: numero_complejo

    ! ========================================================================
    ! ASIGNACIÓN DE VALORES
    ! ========================================================================

    ! Asignando valores a enteros
    edad = 25
    año_actual = 2025
    cantidad_estudiantes = 150
    numero_negativo = -42

    ! Asignando valores a números reales
    altura = 1.75          ! metros
    peso = 70.5            ! kilogramos
    temperatura = 23.8     ! grados Celsius
    precio_producto = 99.99 ! pesos

    ! Asignando valores con doble precisión
    pi_preciso = 3.141592653589793d0  ! La 'd0' indica doble precisión
    constante_gravitacional = 9.81d0
    resultado_cientifico = 1.23456789012345d0

    ! Asignando texto
    nombre_completo = 'Juan Pérez García'
    ciudad = 'Ciudad de México'
    inicial = 'J'

    ! Asignando valores lógicos
    es_mayor_edad = .true.      ! .true. significa verdadero
    esta_lloviendo = .false.    ! .false. significa falso
    aprobado = edad >= 18       ! El resultado de una comparación

    ! Asignando números complejos
    numero_complejo = (3.0, 4.0)  ! 3 + 4i

    ! ========================================================================
    ! MOSTRANDO LOS VALORES
    ! ========================================================================

    print *, '======================================='
    print *, 'DEMOSTRACIÓN DE TIPOS DE DATOS'
    print *, '======================================='
    print *

    ! Mostrando enteros
    print *, 'NÚMEROS ENTEROS (INTEGER):'
    print *, 'Edad:', edad
    print *, 'Año actual:', año_actual
    print *, 'Cantidad de estudiantes:', cantidad_estudiantes
    print *, 'Número negativo:', numero_negativo
    print *

    ! Mostrando números reales
    print *, 'NÚMEROS DECIMALES (REAL):'
    print *, 'Altura (m):', altura
    print *, 'Peso (kg):', peso
    print *, 'Temperatura (°C):', temperatura
    print *, 'Precio del producto: $', precio_producto
    print *

    ! Mostrando doble precisión
    print *, 'NÚMEROS DE DOBLE PRECISIÓN:'
    print *, 'Pi preciso:', pi_preciso
    print *, 'Gravedad (m/s²):', constante_gravitacional
    print *, 'Resultado científico:', resultado_cientifico
    print *

    ! Mostrando texto
    print *, 'CADENAS DE TEXTO (CHARACTER):'
    print *, 'Nombre completo:', nombre_completo
    print *, 'Ciudad:', ciudad
    print *, 'Inicial:', inicial
    print *

    ! Mostrando valores lógicos
    print *, 'VALORES LÓGICOS (LOGICAL):'
    print *, 'Es mayor de edad:', es_mayor_edad
    print *, 'Está lloviendo:', esta_lloviendo
    print *, 'Aprobado:', aprobado
    print *

    ! Mostrando números complejos
    print *, 'NÚMEROS COMPLEJOS (COMPLEX):'
    print *, 'Número complejo:', numero_complejo
    print *, 'Parte real:', real(numero_complejo)
    print *, 'Parte imaginaria:', aimag(numero_complejo)
    print *

    ! ========================================================================
    ! OPERACIONES BÁSICAS CON VARIABLES
    ! ========================================================================

    print *, 'OPERACIONES BÁSICAS:'
    print *, 'Años vividos:', año_actual - (año_actual - edad)
    print *, 'IMC aproximado:', peso / (altura * altura)
    print *

    print *, '======================================='

end program variables_tipos

! ============================================================================
! NOTAS IMPORTANTES:
!
! 1. 'implicit none' SIEMPRE debe usarse para evitar errores
! 2. Las variables deben declararse antes de usarse
! 3. FORTRAN no distingue entre mayúsculas y minúsculas
! 4. Los comentarios empiezan con !
! 5. El operador :: se usa para declarar variables (en FORTRAN moderno)
!
! COMPILAR Y EJECUTAR:
!   gfortran -o variables 02_variables_tipos.f90
!   ./variables
! ============================================================================

! EJERCICIOS:
! 1. Crea variables para almacenar tu información personal (nombre, edad, etc.)
! 2. Declara variables para un triángulo (base, altura, área)
! 3. Experimenta con diferentes tipos de datos
! 4. Calcula tu IMC usando variables (peso / altura²)
