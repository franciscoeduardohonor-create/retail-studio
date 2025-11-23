! ============================================================================
! Programa: Operaciones Matemáticas
! Descripción: Aprende a realizar cálculos matemáticos en FORTRAN
! ============================================================================

program operaciones_matematicas
    implicit none

    ! Declaración de variables
    integer :: a, b, resultado_entero
    real :: x, y, resultado_real
    real :: radio, area_circulo, volumen_esfera
    double precision :: angulo, seno, coseno, tangente
    real :: pi

    ! Constante pi
    pi = 3.141592653589793

    ! ========================================================================
    ! OPERACIONES ARITMÉTICAS BÁSICAS
    ! ========================================================================

    print *, '======================================='
    print *, 'OPERACIONES ARITMÉTICAS BÁSICAS'
    print *, '======================================='
    print *

    a = 10
    b = 3

    ! Suma (+)
    resultado_entero = a + b
    print *, 'Suma:', a, '+', b, '=', resultado_entero

    ! Resta (-)
    resultado_entero = a - b
    print *, 'Resta:', a, '-', b, '=', resultado_entero

    ! Multiplicación (*)
    resultado_entero = a * b
    print *, 'Multiplicación:', a, '*', b, '=', resultado_entero

    ! División entera (/)
    ! ¡CUIDADO! División entre enteros da resultado entero
    resultado_entero = a / b
    print *, 'División entera:', a, '/', b, '=', resultado_entero

    ! Exponenciación (**)
    resultado_entero = a ** 2
    print *, 'Potencia:', a, '**2 =', resultado_entero

    print *

    ! ========================================================================
    ! DIVISIÓN CON DECIMALES
    ! ========================================================================

    print *, 'DIVISIÓN CON NÚMEROS REALES:'
    x = 10.0
    y = 3.0
    resultado_real = x / y
    print *, x, '/', y, '=', resultado_real
    print *

    ! Conversión de tipos para división exacta
    resultado_real = real(a) / real(b)
    print *, 'División exacta de enteros convertidos:', resultado_real
    print *

    ! ========================================================================
    ! FUNCIONES MATEMÁTICAS INTRÍNSECAS
    ! ========================================================================

    print *, 'FUNCIONES MATEMÁTICAS:'
    print *

    ! Raíz cuadrada
    x = 16.0
    print *, 'Raíz cuadrada de', x, '=', sqrt(x)

    ! Valor absoluto
    x = -25.5
    print *, 'Valor absoluto de', x, '=', abs(x)

    ! Exponencial (e^x)
    x = 1.0
    print *, 'e^1 =', exp(x)

    ! Logaritmo natural
    x = 2.718281828
    print *, 'ln(e) =', log(x)

    ! Logaritmo base 10
    x = 100.0
    print *, 'log10(100) =', log10(x)

    ! Seno, coseno, tangente (en radianes)
    angulo = pi / 4.0d0  ! 45 grados
    seno = sin(angulo)
    coseno = cos(angulo)
    tangente = tan(angulo)
    print *
    print *, 'Ángulo:', angulo, 'radianes (45 grados)'
    print *, 'Seno:', seno
    print *, 'Coseno:', coseno
    print *, 'Tangente:', tangente
    print *

    ! Máximo y mínimo
    a = 15
    b = 23
    print *, 'Máximo entre', a, 'y', b, '=', max(a, b)
    print *, 'Mínimo entre', a, 'y', b, '=', min(a, b)
    print *

    ! Redondeo
    x = 3.7
    print *, 'Redondeo de', x, '=', nint(x)  ! Redondeo al entero más cercano
    print *, 'Parte entera de', x, '=', int(x)   ! Truncamiento
    print *, 'Techo de', x, '=', ceiling(x)      ! Redondeo hacia arriba
    print *, 'Piso de', x, '=', floor(x)         ! Redondeo hacia abajo
    print *

    ! ========================================================================
    ! APLICACIONES PRÁCTICAS
    ! ========================================================================

    print *, '======================================='
    print *, 'APLICACIONES PRÁCTICAS'
    print *, '======================================='
    print *

    ! Calcular el área de un círculo
    radio = 5.0
    area_circulo = pi * radio**2
    print *, 'Radio del círculo:', radio, 'cm'
    print *, 'Área del círculo:', area_circulo, 'cm²'
    print *

    ! Calcular el volumen de una esfera
    volumen_esfera = (4.0/3.0) * pi * radio**3
    print *, 'Radio de la esfera:', radio, 'cm'
    print *, 'Volumen de la esfera:', volumen_esfera, 'cm³'
    print *

    ! Calcular la hipotenusa de un triángulo rectángulo
    x = 3.0  ! cateto 1
    y = 4.0  ! cateto 2
    resultado_real = sqrt(x**2 + y**2)
    print *, 'Catetos:', x, 'y', y
    print *, 'Hipotenusa:', resultado_real
    print *

    ! Convertir grados a radianes
    x = 90.0  ! grados
    resultado_real = x * pi / 180.0
    print *, x, 'grados =', resultado_real, 'radianes'
    print *

    ! Ecuación cuadrática: x = (-b ± sqrt(b²-4ac)) / 2a
    ! Ejemplo: x² - 5x + 6 = 0
    real :: a_ec, b_ec, c_ec, discriminante, x1, x2
    a_ec = 1.0
    b_ec = -5.0
    c_ec = 6.0
    discriminante = b_ec**2 - 4*a_ec*c_ec

    if (discriminante >= 0) then
        x1 = (-b_ec + sqrt(discriminante)) / (2*a_ec)
        x2 = (-b_ec - sqrt(discriminante)) / (2*a_ec)
        print *, 'Soluciones de x² - 5x + 6 = 0:'
        print *, 'x1 =', x1
        print *, 'x2 =', x2
    end if
    print *

    print *, '======================================='

end program operaciones_matematicas

! ============================================================================
! FUNCIONES MATEMÁTICAS ÚTILES EN FORTRAN:
!
! sqrt(x)      - Raíz cuadrada
! abs(x)       - Valor absoluto
! exp(x)       - Exponencial (e^x)
! log(x)       - Logaritmo natural (ln)
! log10(x)     - Logaritmo base 10
! sin(x)       - Seno (x en radianes)
! cos(x)       - Coseno (x en radianes)
! tan(x)       - Tangente (x en radianes)
! asin(x)      - Arcoseno
! acos(x)      - Arcocoseno
! atan(x)      - Arcotangente
! max(x,y)     - Máximo de dos valores
! min(x,y)     - Mínimo de dos valores
! nint(x)      - Redondeo al entero más cercano
! int(x)       - Conversión a entero (trunca)
! ceiling(x)   - Redondeo hacia arriba
! floor(x)     - Redondeo hacia abajo
! mod(x,y)     - Módulo (resto de división)
!
! COMPILAR Y EJECUTAR:
!   gfortran -o operaciones 03_operaciones_matematicas.f90
!   ./operaciones
! ============================================================================

! EJERCICIOS:
! 1. Calcula el perímetro y área de un rectángulo
! 2. Resuelve una ecuación cuadrática con valores diferentes
! 3. Convierte tu altura de centímetros a metros y calcula tu IMC
! 4. Calcula el volumen de un cilindro (V = πr²h)
! 5. Encuentra el seno, coseno y tangente de 30, 60 y 90 grados
