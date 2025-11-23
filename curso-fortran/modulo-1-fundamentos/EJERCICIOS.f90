! ============================================================================
! EJERCICIOS PRÁCTICOS - MÓDULO 1: FUNDAMENTOS DE FORTRAN
! ============================================================================
! Instrucciones:
! 1. Lee cada ejercicio cuidadosamente
! 2. Intenta resolver cada uno por tu cuenta
! 3. Compila y prueba tu código
! 4. Compara con las soluciones al final (¡no hagas trampa!)
! ============================================================================

! ============================================================================
! EJERCICIO 1: INFORMACIÓN PERSONAL
! Dificultad: ⭐ (Fácil)
!
! Crea un programa que:
! 1. Pida al usuario su nombre completo
! 2. Pida su edad
! 3. Pida su ciudad
! 4. Muestre un mensaje de bienvenida personalizado
!
! Ejemplo de salida:
! ¡Bienvenido Juan Pérez de Guadalajara! Tienes 25 años.
! ============================================================================

! TU CÓDIGO AQUÍ:
! program ejercicio_1
!     implicit none
!     ! Tu código...
! end program ejercicio_1

! ============================================================================
! EJERCICIO 2: CALCULADORA BÁSICA
! Dificultad: ⭐ (Fácil)
!
! Crea un programa que:
! 1. Pida dos números al usuario
! 2. Calcule y muestre: suma, resta, multiplicación, división
! 3. Use formato para mostrar los resultados con 2 decimales
!
! Ejemplo:
! Número 1: 10
! Número 2: 3
! Suma: 13.00
! Resta: 7.00
! Multiplicación: 30.00
! División: 3.33
! ============================================================================

! TU CÓDIGO AQUÍ:
! program ejercicio_2
!     implicit none
!     ! Tu código...
! end program ejercicio_2

! ============================================================================
! EJERCICIO 3: CONVERSOR DE TEMPERATURA
! Dificultad: ⭐⭐ (Medio)
!
! Crea un programa que:
! 1. Pida una temperatura en Celsius
! 2. Convierta a Fahrenheit: F = (C × 9/5) + 32
! 3. Convierta a Kelvin: K = C + 273.15
! 4. Muestre los resultados formateados
!
! Usa constantes para las fórmulas de conversión
! ============================================================================

! TU CÓDIGO AQUÍ:
! program ejercicio_3
!     implicit none
!     ! Tu código...
! end program ejercicio_3

! ============================================================================
! EJERCICIO 4: CALCULADORA DE GEOMETRÍA
! Dificultad: ⭐⭐ (Medio)
!
! Crea un programa que pida el radio de un círculo y calcule:
! 1. Área del círculo: A = πr²
! 2. Perímetro del círculo: P = 2πr
! 3. Volumen de una esfera: V = (4/3)πr³
! 4. Área de la esfera: A = 4πr²
!
! Usa PI como constante
! Formatea la salida con 2 decimales
! ============================================================================

! TU CÓDIGO AQUÍ:
! program ejercicio_4
!     implicit none
!     ! Tu código...
! end program ejercicio_4

! ============================================================================
! EJERCICIO 5: CONVERSOR DE UNIDADES
! Dificultad: ⭐⭐ (Medio)
!
! Crea un programa que convierta:
! 1. Kilómetros a millas (1 km = 0.621371 mi)
! 2. Kilogramos a libras (1 kg = 2.20462 lb)
! 3. Litros a galones (1 L = 0.264172 gal)
!
! El programa debe pedir el valor y la unidad origen,
! y mostrar la conversión correspondiente.
! ============================================================================

! TU CÓDIGO AQUÍ:
! program ejercicio_5
!     implicit none
!     ! Tu código...
! end program ejercicio_5

! ============================================================================
! EJERCICIO 6: CALCULADORA DE INTERÉS SIMPLE
! Dificultad: ⭐⭐ (Medio)
!
! Crea un programa que calcule el interés simple:
! Fórmula: I = Capital × Tasa × Tiempo
! Monto final = Capital + Interés
!
! El programa debe:
! 1. Pedir el capital inicial
! 2. Pedir la tasa de interés anual (%)
! 3. Pedir el tiempo en años
! 4. Calcular el interés ganado
! 5. Calcular el monto final
! 6. Mostrar resultados formateados como dinero
! ============================================================================

! TU CÓDIGO AQUÍ:
! program ejercicio_6
!     implicit none
!     ! Tu código...
! end program ejercicio_6

! ============================================================================
! EJERCICIO 7: CALCULADORA DE IMC CON INTERPRETACIÓN
! Dificultad: ⭐⭐⭐ (Difícil)
!
! Crea un programa que:
! 1. Pida peso (kg) y altura (m)
! 2. Calcule el IMC: IMC = peso / altura²
! 3. Clasifique el resultado:
!    - Menos de 18.5: Bajo peso
!    - 18.5 - 24.9: Normal
!    - 25.0 - 29.9: Sobrepeso
!    - 30.0 o más: Obesidad
! 4. Muestre el IMC con 1 decimal y la clasificación
! 5. Calcule cuántos kg debe ganar/perder para peso normal (IMC 22)
! ============================================================================

! TU CÓDIGO AQUÍ:
! program ejercicio_7
!     implicit none
!     ! Tu código...
! end program ejercicio_7

! ============================================================================
! EJERCICIO 8: ECUACIÓN CUADRÁTICA
! Dificultad: ⭐⭐⭐ (Difícil)
!
! Crea un programa que resuelva ecuaciones cuadráticas: ax² + bx + c = 0
! Fórmula: x = (-b ± √(b²-4ac)) / 2a
!
! El programa debe:
! 1. Pedir los coeficientes a, b, c
! 2. Calcular el discriminante: D = b² - 4ac
! 3. Determinar el tipo de soluciones:
!    - D > 0: Dos soluciones reales diferentes
!    - D = 0: Una solución real doble
!    - D < 0: Dos soluciones complejas
! 4. Mostrar las soluciones con 4 decimales
! ============================================================================

! TU CÓDIGO AQUÍ:
! program ejercicio_8
!     implicit none
!     ! Tu código...
! end program ejercicio_8

! ============================================================================
! EJERCICIO 9: TABLA DE CONVERSIÓN
! Dificultad: ⭐⭐⭐ (Difícil)
!
! Crea una tabla que muestre conversiones de temperatura de 0 a 100°C
! en incrementos de 10 grados.
!
! Formato de la tabla:
! Celsius    Fahrenheit    Kelvin
! 0.00       32.00         273.15
! 10.00      50.00         283.15
! ...
!
! Usa bucles y formato personalizado para crear la tabla
! ============================================================================

! TU CÓDIGO AQUÍ:
! program ejercicio_9
!     implicit none
!     ! Tu código...
! end program ejercicio_9

! ============================================================================
! EJERCICIO 10: PROYECTO INTEGRADOR - CALCULADORA CIENTÍFICA
! Dificultad: ⭐⭐⭐⭐ (Muy difícil)
!
! Crea un programa que ofrezca un menú con opciones:
! 1. Operaciones básicas (+, -, ×, ÷)
! 2. Potencias y raíces
! 3. Funciones trigonométricas (sen, cos, tan)
! 4. Logaritmos (natural y base 10)
! 5. Conversión de grados a radianes
! 6. Salir
!
! El programa debe:
! - Mostrar el menú
! - Pedir al usuario su opción
! - Realizar el cálculo correspondiente
! - Mostrar el resultado formateado
! - Permitir realizar múltiples cálculos (bucle)
! ============================================================================

! TU CÓDIGO AQUÍ:
! program ejercicio_10
!     implicit none
!     ! Tu código...
! end program ejercicio_10

! ============================================================================
! ¡FELICIDADES!
! Si completaste todos los ejercicios, has dominado los fundamentos de FORTRAN
! Ahora estás listo para el Módulo 2: Estructuras de Control y Arreglos
! ============================================================================
