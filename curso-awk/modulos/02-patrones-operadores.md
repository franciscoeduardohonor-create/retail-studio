# Módulo 2: Patrones, Expresiones y Operadores

## Introducción a los Patrones

En AWK, un **patrón** determina qué líneas serán procesadas. La sintaxis completa es:

```awk
patrón { acción }
```

Si el patrón coincide, se ejecuta la acción. Si no hay patrón, se procesan TODAS las líneas.

---

## TIPOS DE PATRONES

### 1. Patrón Vacío (Sin Patrón)
```awk
{ print $0 }  # Procesa TODAS las líneas
```

### 2. Expresiones Regulares
```awk
/patrón/ { acción }
```

### 3. Expresiones Relacionales
```awk
$1 == "valor" { acción }
$2 > 100 { acción }
```

### 4. Rangos
```awk
/inicio/,/fin/ { acción }
```

### 5. BEGIN y END
```awk
BEGIN { acción }
END { acción }
```

---

## OPERADORES DE COMPARACIÓN

| Operador | Significado | Ejemplo |
|----------|-------------|---------|
| `==` | Igual a | `$1 == "Juan"` |
| `!=` | Diferente de | `$2 != 0` |
| `<` | Menor que | `$3 < 100` |
| `<=` | Menor o igual | `$3 <= 100` |
| `>` | Mayor que | `$3 > 100` |
| `>=` | Mayor o igual | `$3 >= 100` |
| `~` | Coincide con regex | `$1 ~ /^A/` |
| `!~` | NO coincide con regex | `$1 !~ /test/` |

---

## OPERADORES LÓGICOS

| Operador | Significado | Ejemplo |
|----------|-------------|---------|
| `&&` | AND (Y) | `$1 == "Ana" && $2 > 1000` |
| `\|\|` | OR (O) | `$1 == "Ana" \|\| $1 == "Luis"` |
| `!` | NOT (NO) | `!($2 > 1000)` |

---

## EJEMPLO 1: Filtrar por Coincidencia Exacta

Archivo `empleados.txt`:
```
Ana 2500 Ventas
Luis 3000 IT
Pedro 2800 Ventas
Carmen 3200 IT
Jorge 2200 Marketing
```

```bash
# Mostrar solo empleados de IT
awk '$3 == "IT"' empleados.txt
```

**Salida:**
```
Luis 3000 IT
Carmen 3200 IT
```

**Código comentado:**
```awk
# Patrón: $3 == "IT"
# Si el tercer campo es exactamente "IT", se ejecuta la acción
# Como no hay acción explícita, la acción por defecto es { print $0 }
$3 == "IT"
```

---

## EJEMPLO 2: Filtrar por Rango Numérico

```bash
# Mostrar empleados con salario mayor a 2500
awk '$2 > 2500' empleados.txt
```

**Salida:**
```
Luis 3000 IT
Pedro 2800 Ventas
Carmen 3200 IT
```

```bash
# Mostrar empleados con salario entre 2500 y 3000
awk '$2 >= 2500 && $2 <= 3000' empleados.txt
```

**Salida:**
```
Ana 2500 Ventas
Luis 3000 IT
Pedro 2800 Ventas
```

**Código comentado:**
```awk
# Patrón con operador lógico AND (&&)
# Ambas condiciones deben ser verdaderas
# $2 >= 2500: salario mayor o igual a 2500
# $2 <= 3000: salario menor o igual a 3000
$2 >= 2500 && $2 <= 3000
```

---

## EJEMPLO 3: Expresiones Regulares Básicas

```bash
# Mostrar líneas que contienen "IT"
awk '/IT/' empleados.txt
```

**Salida:**
```
Luis 3000 IT
Carmen 3200 IT
```

```bash
# Mostrar empleados cuyo nombre empieza con "A"
awk '$1 ~ /^A/' empleados.txt
```

**Salida:**
```
Ana 2500 Ventas
```

**Código comentado:**
```awk
# /IT/ - Busca el patrón "IT" en cualquier parte de la línea
# $1 ~ /^A/ - El primer campo coincide con una regex
#   ^ = inicio de línea/string
#   /^A/ = empieza con "A"
#   ~ = operador de coincidencia regex
```

---

## EJEMPLO 4: Expresiones Regulares - Metacaracteres Comunes

```
^     - Inicio de línea
$     - Fin de línea
.     - Cualquier carácter
*     - Cero o más repeticiones
+     - Una o más repeticiones
?     - Cero o una repetición
[]    - Conjunto de caracteres
[^]   - Negación de conjunto
|     - Alternancia (OR)
```

Archivo `emails.txt`:
```
juan@gmail.com
maria@hotmail.com
pedro@yahoo.es
ana.garcia@empresa.com
carlos123@outlook.com
```

```bash
# Emails que terminan en .com
awk '/\.com$/' emails.txt
```

**Salida:**
```
juan@gmail.com
maria@hotmail.com
ana.garcia@empresa.com
carlos123@outlook.com
```

**Código comentado:**
```awk
# \.com$
#   \. = punto literal (escapado porque . es metacarácter)
#   com = texto literal "com"
#   $ = final de línea
# Busca líneas que terminan con ".com"
/\.com$/
```

```bash
# Emails de Gmail o Hotmail
awk '/@(gmail|hotmail)\.com/' emails.txt
```

**Salida:**
```
juan@gmail.com
maria@hotmail.com
```

**Código comentado:**
```awk
# @ = arroba literal
# (gmail|hotmail) = "gmail" O "hotmail"
# \. = punto literal
# com = texto literal
/@(gmail|hotmail)\.com/
```

---

## EJEMPLO 5: Operador de NO Coincidencia (!~)

```bash
# Mostrar emails que NO son de gmail
awk '$0 !~ /gmail/' emails.txt
```

**Salida:**
```
maria@hotmail.com
pedro@yahoo.es
ana.garcia@empresa.com
carlos123@outlook.com
```

**Código comentado:**
```awk
# $0 = línea completa
# !~ = NO coincide con
# /gmail/ = patrón "gmail"
# Muestra líneas que NO contienen "gmail"
$0 !~ /gmail/
```

---

## EJEMPLO 6: Operadores Lógicos Combinados

```bash
# Empleados de Ventas O con salario mayor a 3000
awk '$3 == "Ventas" || $2 > 3000' empleados.txt
```

**Salida:**
```
Ana 2500 Ventas
Pedro 2800 Ventas
Carmen 3200 IT
```

```bash
# Empleados de IT Y con salario mayor a 2500
awk '$3 == "IT" && $2 > 2500' empleados.txt
```

**Salida:**
```
Luis 3000 IT
Carmen 3200 IT
```

**Código comentado:**
```awk
# OR (||): Si CUALQUIERA de las condiciones es verdadera
$3 == "Ventas" || $2 > 3000

# AND (&&): Solo si AMBAS condiciones son verdaderas
$3 == "IT" && $2 > 2500
```

---

## EJEMPLO 7: Negación con Operador NOT (!)

```bash
# Empleados que NO son de IT
awk '$3 != "IT"' empleados.txt
# O también:
awk '!($3 == "IT")' empleados.txt
```

**Salida:**
```
Ana 2500 Ventas
Pedro 2800 Ventas
Jorge 2200 Marketing
```

**Código comentado:**
```awk
# Forma 1: Usar operador de desigualdad
$3 != "IT"

# Forma 2: Negar una igualdad con !
# ! invierte el resultado booleano
!($3 == "IT")
```

---

## EJEMPLO 8: Rangos de Líneas

Archivo `log.txt`:
```
INFO: Sistema iniciado
DEBUG: Cargando módulo A
DEBUG: Cargando módulo B
ERROR: Fallo en módulo B
DEBUG: Reiniciando módulo B
INFO: Módulo B reiniciado
DEBUG: Cargando módulo C
INFO: Sistema listo
```

```bash
# Mostrar desde la primera línea ERROR hasta la primera línea INFO después
awk '/ERROR/,/INFO/' log.txt
```

**Salida:**
```
ERROR: Fallo en módulo B
DEBUG: Reiniciando módulo B
INFO: Módulo B reiniciado
```

**Código comentado:**
```awk
# Patrón de rango: /inicio/,/fin/
# Empieza a imprimir cuando encuentra ERROR
# Continúa imprimiendo hasta encontrar INFO (inclusive)
# Luego se reinicia el patrón
/ERROR/,/INFO/
```

---

## EJEMPLO 9: Rangos por Número de Línea

```bash
# Mostrar líneas 2 a 5
awk 'NR >= 2 && NR <= 5' log.txt
# O más simple:
awk 'NR == 2, NR == 5' log.txt
```

**Salida:**
```
DEBUG: Cargando módulo A
DEBUG: Cargando módulo B
ERROR: Fallo en módulo B
DEBUG: Reiniciando módulo B
```

**Código comentado:**
```awk
# Forma 1: Condición compuesta
NR >= 2 && NR <= 5

# Forma 2: Patrón de rango
# Desde que NR sea 2 hasta que NR sea 5
NR == 2, NR == 5
```

---

## EJEMPLO 10: Filtrar y Procesar

Archivo `ventas.txt`:
```
Laptop 5 850
Mouse 20 25
Teclado 10 45
Monitor 3 320
Impresora 2 280
```

```bash
# Mostrar productos con más de 5 unidades vendidas
awk '$2 > 5 {
    total = $2 * $3
    printf "%s: %d unidades = $%d\n", $1, $2, total
}' ventas.txt
```

**Salida:**
```
Mouse: 20 unidades = $500
Teclado: 10 unidades = $450
```

**Código comentado:**
```awk
# Patrón: $2 > 5 (cantidad mayor a 5)
$2 > 5 {
    # Acción: calcular total y mostrar información formateada
    total = $2 * $3  # cantidad * precio
    printf "%s: %d unidades = $%d\n", $1, $2, total
}
```

---

## EJEMPLO 11: Múltiples Patrones en el Mismo Programa

```bash
awk '
    /^ERROR/ { errores++; print "❌", $0 }
    /^INFO/  { info++; print "ℹ️ ", $0 }
    /^DEBUG/ { debug++ }
    END {
        print "\n=== RESUMEN ==="
        print "Errores:", errores
        print "Info:", info
        print "Debug:", debug
    }
' log.txt
```

**Salida:**
```
ℹ️  INFO: Sistema iniciado
❌ ERROR: Fallo en módulo B
ℹ️  INFO: Módulo B reiniciado
ℹ️  INFO: Sistema listo

=== RESUMEN ===
Errores: 1
Info: 3
Debug: 4
```

**Código comentado:**
```awk
# Primer patrón: líneas que empiezan con ERROR
/^ERROR/ {
    errores++           # Incrementar contador
    print "❌", $0     # Imprimir con emoji
}

# Segundo patrón: líneas que empiezan con INFO
/^INFO/ {
    info++
    print "ℹ️ ", $0
}

# Tercer patrón: líneas que empiezan con DEBUG
/^DEBUG/ {
    debug++            # Solo contar, no imprimir
}

# Bloque final: resumen
END {
    print "\n=== RESUMEN ==="
    print "Errores:", errores
    print "Info:", info
    print "Debug:", debug
}
```

---

## EJEMPLO 12: Expresiones Regulares Avanzadas

Archivo `productos.txt`:
```
PRD001 Laptop HP
PRD002 Mouse Logitech
SRV001 Soporte Técnico
PRD003 Teclado Mecánico
ACC001 Cable HDMI
PRD004 Monitor Samsung
```

```bash
# Mostrar solo productos (códigos que empiezan con PRD)
awk '/^PRD/' productos.txt
```

**Salida:**
```
PRD001 Laptop HP
PRD002 Mouse Logitech
PRD003 Teclado Mecánico
PRD004 Monitor Samsung
```

```bash
# Mostrar productos con número entre 001 y 003
awk '/^PRD00[1-3]/' productos.txt
```

**Salida:**
```
PRD001 Laptop HP
PRD002 Mouse Logitech
PRD003 Teclado Mecánico
```

**Código comentado:**
```awk
# ^PRD = empieza con "PRD"
# 00 = dos ceros literales
# [1-3] = un dígito entre 1 y 3
# Coincide: PRD001, PRD002, PRD003
/^PRD00[1-3]/
```

---

## EJEMPLO 13: Validación de Datos

Archivo `usuarios.csv`:
```
usuario,edad,email
juan,25,juan@email.com
maria,17,maria@email.com
pedro,30,pedro_email.com
ana,22,ana@domain.com
luis,15,luis@test.com
```

```bash
# Validar usuarios: edad >= 18 Y email válido
awk -F',' '
    NR == 1 { next }  # Saltar encabezado
    $2 >= 18 && $3 ~ /@.*\./ {
        print "✓ Usuario válido:", $1, "(" $2, "años)"
    }
    $2 < 18 {
        print "✗ Menor de edad:", $1
    }
    $3 !~ /@.*\./ {
        print "✗ Email inválido:", $1, "-", $3
    }
' usuarios.csv
```

**Salida:**
```
✓ Usuario válido: juan ( 25 años)
✗ Menor de edad: maria
✗ Email inválido: pedro - pedro_email.com
✓ Usuario válido: ana ( 22 años)
✗ Menor de edad: luis
```

**Código comentado:**
```awk
-F','  # Separador de campos: coma

NR == 1 { next }  # Si es la primera línea, saltar al siguiente registro

# Patrón 1: Usuario válido (edad >= 18 Y email con @ y .)
$2 >= 18 && $3 ~ /@.*\./ {
    # /@.*\./ significa:
    #   @ = arroba literal
    #   .* = cualquier carácter, cero o más veces
    #   \. = punto literal
    print "✓ Usuario válido:", $1, "(" $2, "años)"
}

# Patrón 2: Menor de edad
$2 < 18 {
    print "✗ Menor de edad:", $1
}

# Patrón 3: Email inválido (NO contiene @ seguido de . en algún lugar)
$3 !~ /@.*\./ {
    print "✗ Email inválido:", $1, "-", $3
}
```

---

## EJEMPLO 14: Combinación de Patrones Complejos

```bash
# Empleados de IT o Marketing con salario > 2500
awk '($3 == "IT" || $3 == "Marketing") && $2 > 2500' empleados.txt
```

**Salida:**
```
Luis 3000 IT
Carmen 3200 IT
```

**Código comentado:**
```awk
# Paréntesis para agrupar condiciones OR
# Primero evalúa: ($3 == "IT" || $3 == "Marketing")
# Luego evalúa: && $2 > 2500
# Resultado: departamento debe ser IT O Marketing, Y salario > 2500
($3 == "IT" || $3 == "Marketing") && $2 > 2500
```

---

## EJEMPLO 15: Patrón con Cálculos

```bash
# Productos cuyo valor total (cantidad * precio) supera $1000
awk '$2 * $3 > 1000 {
    printf "%s: %d × $%d = $%d\n", $1, $2, $3, $2*$3
}' ventas.txt
```

**Salida:**
```
Laptop: 5 × $850 = $4250
```

**Código comentado:**
```awk
# Patrón: $2 * $3 > 1000
# El patrón puede contener expresiones aritméticas
# $2 = cantidad, $3 = precio
# Si cantidad × precio > 1000, ejecutar acción
$2 * $3 > 1000 {
    # Calcular y mostrar el total
    printf "%s: %d × $%d = $%d\n", $1, $2, $3, $2*$3
}
```

---

## OPERADORES ARITMÉTICOS

| Operador | Operación | Ejemplo |
|----------|-----------|---------|
| `+` | Suma | `$1 + $2` |
| `-` | Resta | `$1 - $2` |
| `*` | Multiplicación | `$1 * $2` |
| `/` | División | `$1 / $2` |
| `%` | Módulo (resto) | `$1 % 2` |
| `^` o `**` | Exponenciación | `$1 ^ 2` |
| `++` | Incremento | `contador++` |
| `--` | Decremento | `contador--` |

---

## OPERADORES DE ASIGNACIÓN

| Operador | Significado | Equivalente a |
|----------|-------------|---------------|
| `=` | Asignación | `x = 5` |
| `+=` | Suma y asigna | `x = x + 5` |
| `-=` | Resta y asigna | `x = x - 5` |
| `*=` | Multiplica y asigna | `x = x * 5` |
| `/=` | Divide y asigna | `x = x / 5` |
| `%=` | Módulo y asigna | `x = x % 5` |

---

## EJERCICIOS PRÁCTICOS - NIVEL INTERMEDIO

### Ejercicio 1: Filtrado de Logs

Crea un archivo `sistema.log`:
```
2024-01-15 10:23:15 INFO Usuario admin conectado
2024-01-15 10:25:33 ERROR Fallo de autenticación para usuario test
2024-01-15 10:26:01 INFO Proceso batch iniciado
2024-01-15 10:30:45 WARNING Memoria al 85%
2024-01-15 10:35:12 ERROR Timeout en conexión a base de datos
2024-01-15 10:40:22 INFO Proceso batch completado
2024-01-15 10:45:00 WARNING Disco al 90%
```

Tareas:
- a) Extrae solo las líneas de ERROR
- b) Extrae líneas de WARNING y ERROR
- c) Cuenta cuántos errores, warnings e info hay
- d) Muestra líneas entre las 10:25 y 10:35
- e) Extrae líneas que NO son INFO

### Ejercicio 2: Validación de Datos

Crea `empleados_validar.txt`:
```
Juan 2500 Ventas juan@empresa.com
Maria 1500 IT maria.garcia
Pedro 3500 IT pedro@empresa.com
Ana 2800 Marketing ana@empresa.com
Luis 500 Ventas luis@test.com
```

Tareas:
- a) Valida que el salario sea >= 2000
- b) Valida que el email contenga @ y .
- c) Muestra empleados con salario válido Y email válido
- d) Cuenta cuántos registros son completamente válidos

### Ejercicio 3: Análisis de Ventas

Crea `ventas_mes.txt`:
```
Producto Cantidad PrecioUnitario
Laptop 5 850.00
Mouse 150 12.50
Teclado 45 35.00
Monitor 12 280.00
Cable 200 5.50
Impresora 8 220.00
```

Tareas:
- a) Calcula el valor total de cada producto (cantidad × precio)
- b) Muestra solo productos con valor total > $1000
- c) Calcula el valor total de todas las ventas
- d) Encuentra el producto más vendido (por cantidad)
- e) Encuentra el producto con mayor valor total

---

## SOLUCIONES

Las soluciones están en `../soluciones/02-soluciones-patrones.md`

---

## RESUMEN DEL MÓDULO 2

Has aprendido:
- ✅ Tipos de patrones en AWK
- ✅ Operadores de comparación (==, !=, <, >, <=, >=)
- ✅ Operadores lógicos (&&, ||, !)
- ✅ Expresiones regulares básicas y avanzadas
- ✅ Operadores de coincidencia (~, !~)
- ✅ Rangos de líneas
- ✅ Combinación de múltiples patrones
- ✅ Operadores aritméticos y de asignación
- ✅ Validación y filtrado de datos

## Próximo Módulo

En el **Módulo 3** aprenderás sobre:
- Variables integradas de AWK
- Funciones de string (length, substr, index, etc.)
- Funciones matemáticas
- Funciones de tiempo
- Formateo avanzado
