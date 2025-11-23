! ============================================================================
! Programa: Formato de Salida
! Descripción: Aprende a formatear la salida de datos para mejor presentación
! ============================================================================

program formato_salida
    implicit none

    ! Declaración de variables
    integer :: numero_entero, edad
    real :: numero_real, pi, precio
    character(len=30) :: nombre
    double precision :: numero_preciso

    ! Asignación de valores
    numero_entero = 42
    numero_real = 3.14159265
    pi = 3.141592653589793
    nombre = 'Carlos García'
    edad = 28
    precio = 1234.56
    numero_preciso = 1.23456789012345d0

    ! ========================================================================
    ! SALIDA SIN FORMATO (formato libre con *)
    ! ========================================================================

    print *, '======================================='
    print *, 'SALIDA SIN FORMATO (con *)'
    print *, '======================================='
    print *, 'Número entero:', numero_entero
    print *, 'Número real:', numero_real
    print *, 'Nombre:', nombre
    print *

    ! ========================================================================
    ! SALIDA CON FORMATO PERSONALIZADO
    ! ========================================================================

    print *, '======================================='
    print *, 'SALIDA CON FORMATO PERSONALIZADO'
    print *, '======================================='
    print *

    ! Formato para enteros: In (donde n es el ancho del campo)
    print '(A, I5)', 'Número entero (I5):', numero_entero
    print '(A, I10)', 'Número entero (I10):', numero_entero
    print *

    ! Formato para reales: Fn.m (n=ancho total, m=decimales)
    print '(A, F10.2)', 'Precio con 2 decimales:', precio
    print '(A, F10.4)', 'Pi con 4 decimales:', pi
    print '(A, F15.10)', 'Pi con 10 decimales:', pi
    print *

    ! Formato exponencial: En.m
    print '(A, E15.6)', 'Notación científica:', numero_preciso
    print *

    ! Formato para cadenas: A o An
    print '(A)', 'Nombre completo: ' // trim(nombre)
    print '(A30)', nombre
    print *

    ! ========================================================================
    ! FORMATOS COMBINADOS
    ! ========================================================================

    print *, 'FORMATOS COMBINADOS:'
    print *

    ! Combinando múltiples formatos en una línea
    print '(A, A, A, I3, A)', 'Mi nombre es ', trim(nombre), &
          ' y tengo ', edad, ' años'

    print '(A, F8.2, A)', 'El precio es: $', precio, ' pesos'
    print *

    ! ========================================================================
    ! CREANDO TABLAS FORMATEADAS
    ! ========================================================================

    print *, '======================================='
    print *, 'TABLA FORMATEADA'
    print *, '======================================='
    print *

    ! Encabezado de tabla
    print '(A10, A15, A15)', 'Nombre', 'Edad', 'Salario'
    print '(A10, A15, A15)', '----------', '----------', '----------'

    ! Datos de tabla
    print '(A10, I15, F15.2)', 'Juan', 25, 15000.50
    print '(A10, I15, F15.2)', 'María', 30, 18500.75
    print '(A10, I15, F15.2)', 'Pedro', 28, 16200.00
    print '(A10, I15, F15.2)', 'Ana', 32, 20100.25
    print *

    ! ========================================================================
    ! TABLA DE MULTIPLICAR (ejemplo práctico)
    ! ========================================================================

    print *, '======================================='
    print *, 'TABLA DE MULTIPLICAR DEL 7'
    print *, '======================================='
    print *

    integer :: i, resultado

    do i = 1, 10
        resultado = 7 * i
        print '(I2, A, I2, A, I3)', 7, ' x ', i, ' = ', resultado
    end do
    print *

    ! ========================================================================
    ! FORMATO CON ALINEACIÓN
    ! ========================================================================

    print *, 'EJEMPLOS DE ALINEACIÓN:'
    print *

    ! Números alineados a la derecha
    print '(A, I5)', 'Número:     ', 1
    print '(A, I5)', 'Número:     ', 10
    print '(A, I5)', 'Número:     ', 100
    print '(A, I5)', 'Número:     ', 1000
    print *

    ! Números con ceros a la izquierda
    print '(A, I5.5)', 'Con ceros: ', 42
    print '(A, I5.5)', 'Con ceros: ', 7
    print *

    ! ========================================================================
    ! CÁLCULO DE ÁREAS CON FORMATO
    ! ========================================================================

    print *, '======================================='
    print *, 'CÁLCULO DE ÁREAS DE CÍRCULOS'
    print *, '======================================='
    print *

    real :: radio, area

    print '(A10, A15)', 'Radio (cm)', 'Área (cm²)'
    print '(A10, A15)', '----------', '------------'

    do i = 1, 5
        radio = real(i)
        area = pi * radio**2
        print '(F10.2, F15.2)', radio, area
    end do
    print *

    print *, '======================================='

end program formato_salida

! ============================================================================
! CÓDIGOS DE FORMATO MÁS COMUNES:
!
! ENTEROS:
!   In      - Entero con ancho n
!   In.m    - Entero con ancho n y mínimo m dígitos (rellena con ceros)
!
! REALES:
!   Fn.m    - Punto fijo con ancho n y m decimales
!   En.m    - Notación científica con ancho n y m decimales
!   ESn.m   - Notación científica (ingeniería)
!   Gn.m    - Formato general (elige F o E según el valor)
!
! CADENAS:
!   A       - Cadena con longitud automática
!   An      - Cadena con ancho n
!
! ESPACIADO:
!   nX      - n espacios en blanco
!   /       - Nueva línea
!   T       - Tabulación a columna n
!
! LITERALES:
!   'texto' - Texto literal
!
! EJEMPLOS DE USO:
!   print '(I5)', numero              ! Entero ancho 5
!   print '(F10.2)', precio           ! Real: 10 de ancho, 2 decimales
!   print '(A)', 'Hola'               ! Cadena
!   print '(I5, 2X, F8.2)', n, x      ! Entero, 2 espacios, real
!   print '(A, I3, A)', 'Edad: ', e, ' años'  ! Formato mixto
!
! COMPILAR Y EJECUTAR:
!   gfortran -o formato 06_formato_salida.f90
!   ./formato
! ============================================================================

! EJERCICIOS:
! 1. Crea una tabla de conversión de Celsius a Fahrenheit (0-100°C)
! 2. Haz una tabla con potencias de 2 (2¹, 2², 2³, ..., 2¹⁰)
! 3. Crea un programa que muestre un recibo de compra formateado
! 4. Genera la tabla de multiplicar del 1 al 10 en formato de matriz
! 5. Crea una tabla de senos y cosenos para ángulos de 0 a 90 grados
