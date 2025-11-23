# Módulo 5: Control de Flujo y Funciones Personalizadas

## Estructuras de Control de Flujo

AWK soporta las estructuras de control típicas de lenguajes de programación:

- `if-else` - Condicionales
- `while` - Bucle mientras condición sea verdadera
- `for` - Bucle con contador
- `do-while` - Bucle que ejecuta al menos una vez
- `break` - Salir de un bucle
- `continue` - Saltar a la siguiente iteración
- `next` - Saltar al siguiente registro
- `exit` - Terminar el programa

---

## EJEMPLO 1: Condicional if-else

```bash
awk 'BEGIN {
    edad = 25

    if (edad >= 18) {
        print "Es mayor de edad"
    } else {
        print "Es menor de edad"
    }
}'
```

**Código comentado:**
```awk
if (condición) {
    # Código si la condición es verdadera
} else {
    # Código si la condición es falsa
}
```

---

## EJEMPLO 2: if-else if-else

Archivo `notas.txt`:
```
Juan 85
María 92
Pedro 65
Ana 78
Luis 58
Carmen 95
```

```bash
awk '{
    nombre = $1
    nota = $2

    if (nota >= 90) {
        calificacion = "A - Excelente"
    } else if (nota >= 80) {
        calificacion = "B - Muy Bien"
    } else if (nota >= 70) {
        calificacion = "C - Bien"
    } else if (nota >= 60) {
        calificacion = "D - Suficiente"
    } else {
        calificacion = "F - Reprobado"
    }

    printf "%-10s %3d - %s\n", nombre, nota, calificacion
}' notas.txt
```

**Salida:**
```
Juan        85 - B - Muy Bien
María       92 - A - Excelente
Pedro       65 - D - Suficiente
Ana         78 - C - Bien
Luis        58 - F - Reprobado
Carmen      95 - A - Excelente
```

**Código comentado:**
```awk
{
    nombre = $1
    nota = $2

    # Estructura if-else if-else
    # Evalúa condiciones en orden hasta encontrar una verdadera
    if (nota >= 90) {
        calificacion = "A - Excelente"
    } else if (nota >= 80) {
        calificacion = "B - Muy Bien"
    } else if (nota >= 70) {
        calificacion = "C - Bien"
    } else if (nota >= 60) {
        calificacion = "D - Suficiente"
    } else {
        # Si ninguna condición anterior fue verdadera
        calificacion = "F - Reprobado"
    }

    printf "%-10s %3d - %s\n", nombre, nota, calificacion
}
```

---

## EJEMPLO 3: Operador Ternario (Condicional Compacto)

```bash
awk '{
    nombre = $1
    nota = $2

    # Operador ternario: condición ? valor_si_true : valor_si_false
    estado = (nota >= 60) ? "APROBADO" : "REPROBADO"
    emoji = (nota >= 60) ? "✓" : "✗"

    printf "%s %-10s %3d - %s %s\n", emoji, nombre, nota, estado, emoji
}' notas.txt
```

**Salida:**
```
✓ Juan        85 - APROBADO ✓
✓ María       92 - APROBADO ✓
✓ Pedro       65 - APROBADO ✓
✓ Ana         78 - APROBADO ✓
✗ Luis        58 - REPROBADO ✗
✓ Carmen      95 - APROBADO ✓
```

**Código comentado:**
```awk
{
    # Operador ternario: condición ? si_true : si_false
    # Es una forma compacta de if-else
    estado = (nota >= 60) ? "APROBADO" : "REPROBADO"

    # Equivalente a:
    # if (nota >= 60) {
    #     estado = "APROBADO"
    # } else {
    #     estado = "REPROBADO"
    # }
}
```

---

## EJEMPLO 4: Bucle while

```bash
awk 'BEGIN {
    # Imprimir números del 1 al 5
    i = 1
    while (i <= 5) {
        print "Número:", i
        i++
    }
}'
```

**Salida:**
```
Número: 1
Número: 2
Número: 3
Número: 4
Número: 5
```

**Código comentado:**
```awk
BEGIN {
    i = 1  # Inicializar contador

    # while (condición) { código }
    # Se ejecuta mientras la condición sea verdadera
    while (i <= 5) {
        print "Número:", i
        i++  # Incrementar (IMPORTANTE: evitar bucles infinitos)
    }
}
```

---

## EJEMPLO 5: Bucle for

```bash
awk 'BEGIN {
    # Bucle for tradicional
    for (i = 1; i <= 5; i++) {
        print "Iteración:", i
    }

    print ""

    # Bucle for con incremento de 2
    for (i = 0; i <= 10; i += 2) {
        print "Número par:", i
    }
}'
```

**Salida:**
```
Iteración: 1
Iteración: 2
Iteración: 3
Iteración: 4
Iteración: 5

Número par: 0
Número par: 2
Número par: 4
Número par: 6
Número par: 8
Número par: 10
```

**Código comentado:**
```awk
# for (inicialización; condición; incremento) { código }

for (i = 1; i <= 5; i++) {
    # i = 1: inicialización (se ejecuta una vez)
    # i <= 5: condición (se evalúa antes de cada iteración)
    # i++: incremento (se ejecuta después de cada iteración)
    print "Iteración:", i
}

# Incremento personalizado
for (i = 0; i <= 10; i += 2) {
    # i += 2: incrementa de 2 en 2
    print "Número par:", i
}
```

---

## EJEMPLO 6: Bucle do-while

```bash
awk 'BEGIN {
    # do-while: se ejecuta al menos una vez
    i = 10

    do {
        print "Valor de i:", i
        i--
    } while (i > 0 && i < 5)

    # Aunque i=10 no cumple la condición (i < 5),
    # se ejecuta una vez porque es do-while
}'
```

**Salida:**
```
Valor de i: 10
```

**Código comentado:**
```awk
BEGIN {
    i = 10

    # do { código } while (condición)
    # El código se ejecuta PRIMERO, luego se evalúa la condición
    # Se garantiza al menos una ejecución
    do {
        print "Valor de i:", i
        i--
    } while (i > 0 && i < 5)
}
```

---

## EJEMPLO 7: break - Salir de un Bucle

```bash
awk 'BEGIN {
    print "Buscando el número 5...\n"

    for (i = 1; i <= 10; i++) {
        print "Revisando:", i

        if (i == 5) {
            print "¡Encontrado!"
            break  # Salir del bucle
        }
    }

    print "\nFuera del bucle"
}'
```

**Salida:**
```
Buscando el número 5...

Revisando: 1
Revisando: 2
Revisando: 3
Revisando: 4
Revisando: 5
¡Encontrado!

Fuera del bucle
```

**Código comentado:**
```awk
for (i = 1; i <= 10; i++) {
    print "Revisando:", i

    if (i == 5) {
        # break: sale INMEDIATAMENTE del bucle
        # No se ejecutan más iteraciones
        break
    }
}
# Continúa aquí después del break
```

---

## EJEMPLO 8: continue - Saltar a la Siguiente Iteración

```bash
awk 'BEGIN {
    print "Números del 1 al 10 (excepto múltiplos de 3):\n"

    for (i = 1; i <= 10; i++) {
        # Si es múltiplo de 3, saltar
        if (i % 3 == 0) {
            continue
        }

        print i
    }
}'
```

**Salida:**
```
Números del 1 al 10 (excepto múltiplos de 3):

1
2
4
5
7
8
10
```

**Código comentado:**
```awk
for (i = 1; i <= 10; i++) {
    # Si i es divisible por 3
    if (i % 3 == 0) {
        # continue: salta el resto del código en esta iteración
        # y continúa con la siguiente iteración
        continue
    }

    # Este código no se ejecuta cuando i es múltiplo de 3
    print i
}
```

---

## EJEMPLO 9: next - Saltar al Siguiente Registro

Archivo `numeros_next.txt`:
```
10
20
-5
30
-10
40
```

```bash
awk '{
    # Si el número es negativo, saltar este registro
    if ($1 < 0) {
        print "Ignorando número negativo:", $1
        next
    }

    # Este código solo se ejecuta para números positivos
    print "Procesando:", $1
    suma += $1
}
END {
    print "\nSuma total:", suma
}' numeros_next.txt
```

**Salida:**
```
Procesando: 10
Procesando: 20
Ignorando número negativo: -5
Procesando: 30
Ignorando número negativo: -10
Procesando: 40

Suma total: 100
```

**Código comentado:**
```awk
{
    if ($1 < 0) {
        print "Ignorando número negativo:", $1
        # next: salta al siguiente REGISTRO (línea)
        # No ejecuta el resto del código para esta línea
        # Pero continúa con la siguiente línea del archivo
        next
    }

    # Este código no se ejecuta para números negativos
    print "Procesando:", $1
    suma += $1
}
```

---

## EJEMPLO 10: exit - Terminar el Programa

```bash
awk '{
    print "Línea", NR ":", $0

    # Si encontramos "ERROR", terminar el programa
    if (/ERROR/) {
        print "\n¡ERROR ENCONTRADO! Terminando..."
        exit 1  # exit con código de salida
    }
}
END {
    # END se ejecuta incluso después de exit
    print "Líneas procesadas:", NR
}' log.txt
```

**Código comentado:**
```awk
{
    if (/ERROR/) {
        # exit [código]: termina TODO el programa
        # El código es opcional (0 = éxito, >0 = error)
        # El bloque END aún se ejecuta
        exit 1
    }
}

END {
    # Este bloque SE EJECUTA incluso si se llamó a exit
    print "Líneas procesadas:", NR
}
```

---

## FUNCIONES DEFINIDAS POR EL USUARIO

AWK permite definir funciones personalizadas:

```awk
function nombre_funcion(parametros) {
    # código
    return valor
}
```

---

## EJEMPLO 11: Función Simple

```bash
awk '
# Definir función
function cuadrado(n) {
    return n * n
}

BEGIN {
    for (i = 1; i <= 5; i++) {
        resultado = cuadrado(i)
        print i, "al cuadrado =", resultado
    }
}'
```

**Salida:**
```
1 al cuadrado = 1
2 al cuadrado = 4
3 al cuadrado = 9
4 al cuadrado = 16
5 al cuadrado = 25
```

**Código comentado:**
```awk
# Definir función ANTES de usarla (generalmente al inicio)
function cuadrado(n) {
    # n es un parámetro (variable local)
    # return: devuelve un valor
    return n * n
}

BEGIN {
    # Llamar a la función
    resultado = cuadrado(i)
}
```

---

## EJEMPLO 12: Función con Múltiples Parámetros

```bash
awk '
function area_rectangulo(largo, ancho) {
    return largo * ancho
}

function perimetro_rectangulo(largo, ancho) {
    return 2 * (largo + ancho)
}

BEGIN {
    l = 5
    a = 3

    print "Rectángulo de", l, "x", a
    print "  Área:", area_rectangulo(l, a)
    print "  Perímetro:", perimetro_rectangulo(l, a)
}'
```

**Salida:**
```
Rectángulo de 5 x 3
  Área: 15
  Perímetro: 16
```

**Código comentado:**
```awk
# Función con 2 parámetros
function area_rectangulo(largo, ancho) {
    # Parámetros separados por comas
    # Variables largo y ancho son LOCALES a la función
    return largo * ancho
}

BEGIN {
    # Llamar con argumentos
    area = area_rectangulo(5, 3)
}
```

---

## EJEMPLO 13: Función sin Retorno (Procedimiento)

```bash
awk '
function imprimir_encabezado(titulo) {
    print "================================"
    print "  " titulo
    print "================================"
}

function imprimir_linea(etiqueta, valor) {
    printf "%-15s: %s\n", etiqueta, valor
}

BEGIN {
    imprimir_encabezado("DATOS DEL USUARIO")
    imprimir_linea("Nombre", "Juan Pérez")
    imprimir_linea("Edad", "30 años")
    imprimir_linea("Ciudad", "Madrid")
}'
```

**Salida:**
```
================================
  DATOS DEL USUARIO
================================
Nombre         : Juan Pérez
Edad           : 30 años
Ciudad         : Madrid
```

**Código comentado:**
```awk
# Función sin return (procedimiento)
# Útil para código reutilizable que solo imprime o modifica variables
function imprimir_encabezado(titulo) {
    print "================================"
    print "  " titulo
    print "================================"
    # No necesita return si solo imprime
}
```

---

## EJEMPLO 14: Variables Locales vs Globales

```bash
awk '
function prueba_variables(param, local1, local2) {
    # param, local1, local2 son LOCALES
    # Para crear variables locales adicionales,
    # se agregan como parámetros extra (convención)

    local1 = "Variable local 1"
    local2 = "Variable local 2"
    global_var = "Esta es GLOBAL"

    print "  Dentro de función:"
    print "    param:", param
    print "    local1:", local1
    print "    global_var:", global_var
}

BEGIN {
    global_var = "Valor inicial global"

    print "Antes de llamar función:"
    print "  global_var:", global_var

    prueba_variables("Parámetro 1")

    print "\nDespués de llamar función:"
    print "  global_var:", global_var
    print "  local1:", local1, "(vacía, era local)"
}'
```

**Salida:**
```
Antes de llamar función:
  global_var: Valor inicial global
  Dentro de función:
    param: Parámetro 1
    local1: Variable local 1
    global_var: Esta es GLOBAL

Después de llamar función:
  global_var: Esta es GLOBAL
  local1:  (vacía, era local)
```

**Código comentado:**
```awk
# Convención para variables locales:
# Se agregan como parámetros extras después de los parámetros reales
function prueba_variables(param,    local1, local2) {
    #                       ^^^^    ^^^^^^^^^^^^^^
    #                       real    locales (espacios extras para claridad)

    # Variables no listadas en parámetros son GLOBALES
    global_var = "Esta es GLOBAL"

    # Variables en lista de parámetros son LOCALES
    local1 = "Variable local 1"
}
```

---

## EJEMPLO 15: Función Recursiva - Factorial

```bash
awk '
function factorial(n) {
    # Caso base: factorial de 0 o 1 es 1
    if (n <= 1) {
        return 1
    }

    # Caso recursivo: n! = n * (n-1)!
    return n * factorial(n - 1)
}

BEGIN {
    for (i = 0; i <= 10; i++) {
        print i "! =", factorial(i)
    }
}'
```

**Salida:**
```
0! = 1
1! = 1
2! = 2
3! = 6
4! = 24
5! = 120
6! = 720
7! = 5040
8! = 40320
9! = 362880
10! = 3628800
```

**Código comentado:**
```awk
function factorial(n) {
    # Recursión: una función que se llama a sí misma

    # SIEMPRE necesitas un caso base (condición de parada)
    if (n <= 1) {
        return 1
    }

    # Caso recursivo: llamar a la función con un valor menor
    # factorial(5) = 5 * factorial(4)
    # factorial(4) = 4 * factorial(3)
    # ... hasta llegar al caso base
    return n * factorial(n - 1)
}
```

---

## EJEMPLO 16: Función Recursiva - Fibonacci

```bash
awk '
function fibonacci(n) {
    # Casos base
    if (n <= 0) return 0
    if (n == 1) return 1

    # Caso recursivo: F(n) = F(n-1) + F(n-2)
    return fibonacci(n - 1) + fibonacci(n - 2)
}

BEGIN {
    print "Serie de Fibonacci:"
    for (i = 0; i <= 15; i++) {
        printf "F(%2d) = %5d\n", i, fibonacci(i)
    }
}'
```

**Salida:**
```
Serie de Fibonacci:
F( 0) =     0
F( 1) =     1
F( 2) =     1
F( 3) =     2
F( 4) =     3
F( 5) =     5
F( 6) =     8
F( 7) =    13
F( 8) =    21
F( 9) =    34
F(10) =    55
F(11) =    89
F(12) =   144
F(13) =   233
F(14) =   377
F(15) =   610
```

---

## EJEMPLO 17: Función para Validación de Email

```bash
awk '
function es_email_valido(email) {
    # Verificar que tenga @
    if (index(email, "@") == 0) {
        return 0
    }

    # Verificar que tenga punto después de @
    split(email, partes, "@")
    if (length(partes) != 2) {
        return 0
    }

    dominio = partes[2]
    if (index(dominio, ".") == 0) {
        return 0
    }

    # Email válido
    return 1
}

{
    email = $1
    if (es_email_valido(email)) {
        print "✓ Válido:", email
    } else {
        print "✗ Inválido:", email
    }
}' emails.txt
```

**Código comentado:**
```awk
function es_email_valido(email) {
    # Función de validación
    # Retorna 1 (true) si es válido, 0 (false) si no

    # Verificar presencia de @
    if (index(email, "@") == 0) {
        return 0  # No válido
    }

    # Dividir por @ y verificar dominio
    split(email, partes, "@")
    dominio = partes[2]

    # Verificar que el dominio tenga punto
    if (index(dominio, ".") == 0) {
        return 0
    }

    return 1  # Válido
}
```

---

## EJEMPLO 18: Función para Formatear Moneda

```bash
awk '
function formato_moneda(cantidad) {
    # Agregar separadores de miles
    cantidad = sprintf("%.2f", cantidad)

    # Si es mayor a 1000, agregar comas
    while (match(cantidad, /[0-9][0-9][0-9][0-9]+/)) {
        cantidad = substr(cantidad, 1, RSTART) "," substr(cantidad, RSTART + 1)
    }

    return "$" cantidad
}

BEGIN {
    numeros[1] = 1234.56
    numeros[2] = 9876543.21
    numeros[3] = 500.5
    numeros[4] = 12.75

    for (i in numeros) {
        num = numeros[i]
        formateado = formato_moneda(num)
        printf "%12.2f -> %15s\n", num, formateado
    }
}'
```

---

## EJEMPLO 19: Proyecto Completo - Sistema de Calificaciones

```bash
awk '
function calcular_promedio(suma, cantidad) {
    if (cantidad == 0) return 0
    return suma / cantidad
}

function obtener_letra(promedio) {
    if (promedio >= 90) return "A"
    if (promedio >= 80) return "B"
    if (promedio >= 70) return "C"
    if (promedio >= 60) return "D"
    return "F"
}

function es_aprobado(promedio) {
    return promedio >= 60
}

function imprimir_reporte(nombre, promedio, letra, estado) {
    printf "%-15s | Promedio: %5.1f | Letra: %s | Estado: %-10s\n",
           nombre, promedio, letra, estado
}

# Procesar datos
NR == 1 { next }  # Saltar encabezado

{
    nombre = $1
    nota = $2

    # Acumular por estudiante
    suma[nombre] += nota
    cantidad[nombre]++
    total_general += nota
    contador_general++
}

END {
    print "╔══════════════════════════════════════════════════════════╗"
    print "║              REPORTE DE CALIFICACIONES                   ║"
    print "╠══════════════════════════════════════════════════════════╣"

    # Procesar cada estudiante
    for (est in suma) {
        prom = calcular_promedio(suma[est], cantidad[est])
        letra = obtener_letra(prom)
        estado = es_aprobado(prom) ? "APROBADO" : "REPROBADO"

        imprimir_reporte(est, prom, letra, estado)

        if (es_aprobado(prom)) {
            aprobados++
        } else {
            reprobados++
        }
    }

    print "╠══════════════════════════════════════════════════════════╣"

    prom_general = calcular_promedio(total_general, contador_general)
    printf "║ Promedio General: %-38.1f ║\n", prom_general
    printf "║ Aprobados: %-46d ║\n", aprobados
    printf "║ Reprobados: %-45d ║\n", reprobados
    print "╚══════════════════════════════════════════════════════════╝"
}
' calificaciones.txt
```

---

## EJERCICIOS PRÁCTICOS - NIVEL AVANZADO

### Ejercicio 1: Calculadora de IMC (Índice de Masa Corporal)

Crea `personas_imc.txt`:
```
Nombre Peso Altura
Juan 75 1.75
María 62 1.65
Pedro 90 1.80
Ana 55 1.60
```

Tareas:
- a) Crear función calcular_imc(peso, altura) que retorne el IMC
- b) Crear función clasificar_imc(imc) que retorne categoría:
  - Bajo peso: < 18.5
  - Normal: 18.5 - 24.9
  - Sobrepeso: 25 - 29.9
  - Obesidad: >= 30
- c) Generar reporte con nombre, IMC y clasificación

### Ejercicio 2: Validador de Contraseñas

Crea `contraseñas.txt`:
```
Pass123
MiContraseña2024!
abc
SecureP@ssw0rd
12345678
```

Tareas:
- a) Crear función validar_longitud(pass) - mínimo 8 caracteres
- b) Crear función tiene_mayuscula(pass)
- c) Crear función tiene_numero(pass)
- d) Crear función tiene_especial(pass)
- e) Crear función es_segura(pass) que use todas las anteriores
- f) Generar reporte de seguridad de cada contraseña

### Ejercicio 3: Análisis Recursivo

Tareas:
- a) Implementar función recursiva suma_digitos(n) que sume los dígitos de un número
  - Ejemplo: suma_digitos(123) = 1 + 2 + 3 = 6
- b) Implementar función potencia(base, exp) recursiva
- c) Implementar función mcd(a, b) para máximo común divisor (Algoritmo de Euclides)

### Ejercicio 4: Sistema de Inventario

Crea `inventario.txt`:
```
Laptop 10 1200
Mouse 50 25
Teclado 30 75
Monitor 15 350
```

Tareas:
- a) Crear función valor_total(cantidad, precio)
- b) Crear función necesita_reabastecimiento(cantidad, minimo)
- c) Crear función aplicar_descuento(precio, porcentaje)
- d) Generar reporte con alertas de reabastecimiento
- e) Calcular valor total del inventario

---

## SOLUCIONES

Las soluciones están en `../soluciones/05-soluciones-control-flujo.md`

---

## RESUMEN DEL MÓDULO 5

Has aprendido:
- ✅ Condicionales: if, else, else if
- ✅ Operador ternario
- ✅ Bucles: while, for, do-while
- ✅ Control de flujo: break, continue
- ✅ Comandos: next, exit
- ✅ Definir funciones personalizadas
- ✅ Parámetros y valores de retorno
- ✅ Variables locales vs globales
- ✅ Recursividad
- ✅ Funciones de validación y utilidad

## Próximo Módulo

En el **Módulo 6** aprenderás sobre:
- Técnicas avanzadas de procesamiento
- getline para lectura avanzada
- Procesamiento de múltiples archivos
- Generación de reportes complejos
- Casos de uso reales
- Best practices
- Optimización de código AWK
