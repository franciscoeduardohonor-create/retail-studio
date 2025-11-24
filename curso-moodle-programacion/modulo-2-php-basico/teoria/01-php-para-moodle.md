# Módulo 2: PHP Básico para Moodle

## 2.1 Introducción a PHP en el Contexto de Moodle

### ¿Por qué PHP?

Moodle está completamente escrito en PHP, por lo que es esencial dominar este lenguaje para:
- Desarrollar plugins personalizados
- Modificar funcionalidades existentes
- Crear integraciones con otros sistemas
- Automatizar tareas administrativas

### Versiones de PHP

Moodle 4.x requiere:
- **Mínimo**: PHP 7.4
- **Recomendado**: PHP 8.0 o superior
- **Futuro**: Compatibilidad con PHP 8.1+

### Características de PHP que Moodle utiliza

1. **Orientación a Objetos (OOP)**
2. **Namespaces** (espacios de nombres)
3. **Traits** (reutilización de código)
4. **Type hinting** (tipos de datos)
5. **Excepciones** (manejo de errores)

## Estructura Básica de PHP

### Sintaxis básica

```php
<?php
// Todo código PHP comienza con <?php

// Comentario de una línea

/*
 * Comentario de
 * múltiples líneas
 */

/**
 * Comentario de documentación (PHPDoc)
 * Se usa para documentar funciones, clases, etc.
 */

// No es necesario cerrar con ?> en archivos que solo contienen PHP
```

### Variables

```php
<?php

// Las variables empiezan con $
$nombre = "Juan";
$edad = 25;
$altura = 1.75;
$activo = true;

// PHP es de tipado dinámico
$variable = "texto";  // String
$variable = 123;      // Ahora es un entero
$variable = 45.67;    // Ahora es un float
```

### Tipos de Datos

```php
<?php

// String (cadena de texto)
$texto = "Hola Moodle";
$texto2 = 'También con comillas simples';

// Integer (entero)
$numero = 42;

// Float (decimal)
$decimal = 3.14;

// Boolean (verdadero/falso)
$verdadero = true;
$falso = false;

// Array (arreglo)
$frutas = array("manzana", "pera", "uva");
$numeros = [1, 2, 3, 4, 5];  // Sintaxis corta (PHP 5.4+)

// Array asociativo (como diccionario)
$persona = array(
    'nombre' => 'Juan',
    'edad' => 25,
    'ciudad' => 'Madrid'
);

// Null
$vacio = null;

// Object (objeto)
$obj = new stdClass();
$obj->propiedad = "valor";
```

### Constantes

```php
<?php

// Constantes globales
define('MI_CONSTANTE', 'valor');
define('VERSION', '1.0.0');

// Usar constantes
echo MI_CONSTANTE;  // Imprime: valor

// Constantes mágicas de PHP
echo __FILE__;      // Ruta del archivo actual
echo __DIR__;       // Directorio del archivo actual
echo __LINE__;      // Número de línea actual
echo __FUNCTION__;  // Nombre de la función actual

// Constantes predefinidas en Moodle
echo MOODLE_INTERNAL;  // Verifica que el archivo fue incluido correctamente
echo SITEID;           // ID del sitio principal (normalmente 1)
```

## Operadores

### Operadores Aritméticos

```php
<?php

$a = 10;
$b = 3;

echo $a + $b;   // 13 (suma)
echo $a - $b;   // 7  (resta)
echo $a * $b;   // 30 (multiplicación)
echo $a / $b;   // 3.333... (división)
echo $a % $b;   // 1  (módulo - resto de la división)
echo $a ** $b;  // 1000 (potencia - PHP 5.6+)
```

### Operadores de Comparación

```php
<?php

$x = 5;
$y = "5";

// Igualdad (compara valor)
$x == $y;   // true

// Identidad (compara valor Y tipo)
$x === $y;  // false (porque uno es int y otro string)

// Diferente
$x != $y;   // false
$x !== $y;  // true

// Mayor que, menor que
$x > 3;     // true
$x < 10;    // true
$x >= 5;    // true
$x <= 5;    // true
```

### Operadores Lógicos

```php
<?php

$a = true;
$b = false;

// AND (y)
$a && $b;    // false
$a and $b;   // false (mismo que &&, menor precedencia)

// OR (o)
$a || $b;    // true
$a or $b;    // true (mismo que ||, menor precedencia)

// NOT (negación)
!$a;         // false
!$b;         // true

// Operador ternario
$edad = 18;
$mensaje = ($edad >= 18) ? "Mayor de edad" : "Menor de edad";
```

### Operador de Fusión Null (PHP 7+)

```php
<?php

// Muy útil en Moodle para valores por defecto
$username = $USER->username ?? 'guest';

// Equivalente a:
$username = isset($USER->username) ? $USER->username : 'guest';

// Encadenamiento
$valor = $a ?? $b ?? $c ?? 'default';
```

## Estructuras de Control

### If / Else

```php
<?php

$edad = 20;

if ($edad < 18) {
    echo "Menor de edad";
} elseif ($edad >= 18 && $edad < 65) {
    echo "Adulto";
} else {
    echo "Adulto mayor";
}

// Sintaxis alternativa (útil en templates)
if ($condicion):
    echo "Verdadero";
else:
    echo "Falso";
endif;
```

### Switch

```php
<?php

$dia = "lunes";

switch ($dia) {
    case "lunes":
    case "martes":
    case "miércoles":
    case "jueves":
    case "viernes":
        echo "Día laboral";
        break;

    case "sábado":
    case "domingo":
        echo "Fin de semana";
        break;

    default:
        echo "Día no válido";
        break;
}
```

### Bucles

```php
<?php

// FOR
for ($i = 0; $i < 10; $i++) {
    echo $i . " ";
}

// WHILE
$contador = 0;
while ($contador < 5) {
    echo $contador;
    $contador++;
}

// DO-WHILE
$x = 0;
do {
    echo $x;
    $x++;
} while ($x < 5);

// FOREACH (para arrays)
$frutas = ["manzana", "pera", "uva"];

foreach ($frutas as $fruta) {
    echo $fruta . " ";
}

// FOREACH con clave y valor
$persona = ['nombre' => 'Juan', 'edad' => 25];

foreach ($persona as $clave => $valor) {
    echo "$clave: $valor\n";
}
```

## Funciones

### Definir funciones

```php
<?php

// Función simple
function saludar() {
    echo "Hola!";
}

// Función con parámetros
function saludar_persona($nombre) {
    echo "Hola, $nombre!";
}

// Función con valor de retorno
function sumar($a, $b) {
    return $a + $b;
}

// Función con parámetros por defecto
function saludar_con_titulo($nombre, $titulo = "Sr.") {
    return "$titulo $nombre";
}

// Función con tipo de datos (PHP 7+)
function multiplicar(int $a, int $b): int {
    return $a * $b;
}

// Usar funciones
saludar();                              // Hola!
saludar_persona("María");               // Hola, María!
$resultado = sumar(5, 3);               // 8
echo saludar_con_titulo("García");      // Sr. García
echo saludar_con_titulo("García", "Dr."); // Dr. García
```

### Ámbito de variables

```php
<?php

$global_var = "Soy global";

function prueba_scope() {
    // Esta variable es local a la función
    $local_var = "Soy local";

    // Para acceder a variables globales
    global $global_var;
    echo $global_var;
}

prueba_scope();
// echo $local_var;  // ERROR: no existe fuera de la función
```

## Arrays Avanzados

### Funciones útiles para arrays

```php
<?php

$numeros = [1, 2, 3, 4, 5];

// Agregar elementos
array_push($numeros, 6);        // Agrega al final
$numeros[] = 7;                 // Forma corta
array_unshift($numeros, 0);     // Agrega al inicio

// Eliminar elementos
array_pop($numeros);            // Elimina el último
array_shift($numeros);          // Elimina el primero

// Información del array
count($numeros);                // Cantidad de elementos
in_array(3, $numeros);          // ¿Existe el 3? true/false

// Ordenar
sort($numeros);                 // Ordena ascendente
rsort($numeros);                // Ordena descendente

// Filtrar y mapear
$pares = array_filter($numeros, function($n) {
    return $n % 2 == 0;
});

$dobles = array_map(function($n) {
    return $n * 2;
}, $numeros);

// Unir arrays
$array1 = [1, 2, 3];
$array2 = [4, 5, 6];
$combinado = array_merge($array1, $array2);

// Convertir a string
$texto = implode(", ", $numeros);  // "1, 2, 3, 4, 5"

// Convertir string a array
$partes = explode(",", "a,b,c");   // ['a', 'b', 'c']
```

## Convenciones de Código en Moodle

### Estilo de Código

```php
<?php

// Nombres de variables: snake_case
$user_name = "Juan";
$course_id = 123;

// Nombres de funciones: snake_case
function get_user_name($userid) {
    // código
}

// Nombres de clases: PascalCase
class CourseManager {
    // código
}

// Constantes: MAYÚSCULAS
define('MAX_USERS', 1000);

// Indentación: 4 espacios (NO tabs)
if ($condicion) {
    echo "Correctamente indentado";
}

// Llaves en nueva línea para funciones y clases
function mi_funcion()
{
    // código
}

// Llaves en la misma línea para estructuras de control
if ($condicion) {
    // código
} else {
    // código
}
```

### Documentación PHPDoc

```php
<?php

/**
 * Obtiene el nombre completo de un usuario.
 *
 * Esta función busca un usuario por su ID y retorna
 * su nombre completo formateado.
 *
 * @param int $userid El ID del usuario
 * @param bool $includetitle Si incluir el título (Sr./Sra.)
 * @return string El nombre completo del usuario
 * @throws moodle_exception Si el usuario no existe
 */
function get_user_fullname($userid, $includetitle = false) {
    global $DB;

    $user = $DB->get_record('user', array('id' => $userid), '*', MUST_EXIST);

    $fullname = fullname($user);

    if ($includetitle) {
        // Lógica para agregar título
    }

    return $fullname;
}
```

## Próximos Pasos

En el siguiente tema verás:
- Programación orientada a objetos en Moodle
- Manejo de errores y excepciones
- Trabajo con archivos y directorios
- Sesiones y cookies
