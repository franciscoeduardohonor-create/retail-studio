<?php
/**
 * EJEMPLO 4: Funciones en Moodle
 *
 * Este ejemplo muestra cómo crear y usar funciones en Moodle,
 * incluyendo las convenciones y mejores prácticas.
 *
 * UBICACIÓN: /local/holamundo/funciones_ejemplo.php
 */

require_once('../../config.php');
require_login();

// Incluir archivo con nuestras funciones personalizadas
require_once(__DIR__ . '/lib_funciones.php');

$context = context_system::instance();
$PAGE->set_context($context);
$PAGE->set_url(new moodle_url('/local/holamundo/funciones_ejemplo.php'));
$PAGE->set_pagelayout('standard');
$PAGE->set_title('Funciones en PHP');
$PAGE->set_heading('Creando y Usando Funciones');

echo $OUTPUT->header();

global $DB, $USER;

// ============================================
// 1. FUNCIONES SIMPLES
// ============================================
echo html_writer::tag('h2', '1. Funciones Simples');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

/**
 * Función simple que saluda al usuario
 */
function saludar_usuario() {
    global $USER;
    return "¡Hola, {$USER->firstname}!";
}

echo html_writer::tag('p', saludar_usuario());

/**
 * Función con parámetros
 *
 * @param string $nombre El nombre de la persona
 * @return string El saludo formateado
 */
function saludar_con_nombre($nombre) {
    return "Bienvenido, {$nombre}";
}

echo html_writer::tag('p', saludar_con_nombre('Carlos'));
echo html_writer::tag('p', saludar_con_nombre($USER->firstname));

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 2. FUNCIONES CON VALORES POR DEFECTO
// ============================================
echo html_writer::tag('h2', '2. Parámetros con Valores por Defecto');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

/**
 * Obtiene el saludo según la hora del día
 *
 * @param int $hora La hora (0-23), si no se proporciona usa la actual
 * @return string El saludo apropiado
 */
function obtener_saludo_hora($hora = null) {
    if ($hora === null) {
        $hora = date('H');
    }

    if ($hora >= 0 && $hora < 12) {
        return "Buenos días";
    } elseif ($hora >= 12 && $hora < 20) {
        return "Buenas tardes";
    } else {
        return "Buenas noches";
    }
}

// Usar con y sin parámetro
echo html_writer::tag('p', obtener_saludo_hora() . " (hora actual)");
echo html_writer::tag('p', obtener_saludo_hora(8) . " (8 AM)");
echo html_writer::tag('p', obtener_saludo_hora(15) . " (3 PM)");
echo html_writer::tag('p', obtener_saludo_hora(22) . " (10 PM)");

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 3. FUNCIONES CON TYPE HINTING (PHP 7+)
// ============================================
echo html_writer::tag('h2', '3. Type Hinting - Tipos de Datos');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

/**
 * Calcula el promedio de calificaciones
 *
 * @param array $calificaciones Array de calificaciones numéricas
 * @return float El promedio calculado
 */
function calcular_promedio(array $calificaciones): float {
    if (empty($calificaciones)) {
        return 0.0;
    }

    $suma = array_sum($calificaciones);
    return $suma / count($calificaciones);
}

$mis_calificaciones = [85, 90, 78, 92, 88];
$promedio = calcular_promedio($mis_calificaciones);

echo html_writer::tag('p',
    "Calificaciones: [" . implode(', ', $mis_calificaciones) . "]"
);
echo html_writer::tag('p',
    "Promedio: <strong>" . round($promedio, 2) . "</strong>"
);

/**
 * Formatea un número con decimales
 *
 * @param float $numero El número a formatear
 * @param int $decimales Cantidad de decimales (por defecto 2)
 * @return string Número formateado
 */
function formatear_numero(float $numero, int $decimales = 2): string {
    return number_format($numero, $decimales, '.', ',');
}

echo html_writer::tag('p',
    "Promedio formateado: <strong>" . formatear_numero($promedio) . "</strong>"
);

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 4. FUNCIONES QUE RETORNAN MÚLTIPLES VALORES
// ============================================
echo html_writer::tag('h2', '4. Retornar Múltiples Valores');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

/**
 * Obtiene estadísticas de un array de números
 *
 * @param array $numeros Array de números
 * @return array Array asociativo con min, max, promedio, suma
 */
function obtener_estadisticas(array $numeros): array {
    if (empty($numeros)) {
        return array(
            'min' => 0,
            'max' => 0,
            'promedio' => 0,
            'suma' => 0
        );
    }

    return array(
        'min' => min($numeros),
        'max' => max($numeros),
        'promedio' => array_sum($numeros) / count($numeros),
        'suma' => array_sum($numeros)
    );
}

$numeros = [15, 28, 42, 8, 33, 19];
$stats = obtener_estadisticas($numeros);

echo html_writer::tag('h5', 'Estadísticas de [' . implode(', ', $numeros) . ']:');
echo html_writer::start_tag('ul');
echo html_writer::tag('li', "Mínimo: {$stats['min']}");
echo html_writer::tag('li', "Máximo: {$stats['max']}");
echo html_writer::tag('li', "Promedio: " . round($stats['promedio'], 2));
echo html_writer::tag('li', "Suma: {$stats['suma']}");
echo html_writer::end_tag('ul');

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 5. FUNCIONES CON ACCESO A BASE DE DATOS
// ============================================
echo html_writer::tag('h2', '5. Funciones con Acceso a Base de Datos');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

/**
 * Obtiene información de un usuario por su ID
 *
 * @param int $userid ID del usuario
 * @return object|false Objeto con datos del usuario o false si no existe
 */
function obtener_info_usuario(int $userid) {
    global $DB;

    try {
        $user = $DB->get_record('user',
            array('id' => $userid, 'deleted' => 0),
            'id, username, firstname, lastname, email',
            MUST_EXIST
        );
        return $user;
    } catch (Exception $e) {
        return false;
    }
}

$usuario_info = obtener_info_usuario($USER->id);

if ($usuario_info) {
    echo html_writer::tag('h5', 'Información del usuario actual:');
    echo html_writer::tag('p', "<strong>ID:</strong> {$usuario_info->id}");
    echo html_writer::tag('p', "<strong>Usuario:</strong> {$usuario_info->username}");
    echo html_writer::tag('p', "<strong>Nombre:</strong> {$usuario_info->firstname} {$usuario_info->lastname}");
    echo html_writer::tag('p', "<strong>Email:</strong> {$usuario_info->email}");
}

/**
 * Cuenta cursos por categoría
 *
 * @param int $categoryid ID de la categoría
 * @return int Número de cursos en la categoría
 */
function contar_cursos_categoria(int $categoryid): int {
    global $DB;
    return $DB->count_records('course', array('category' => $categoryid));
}

// Obtener primera categoría para ejemplo
$categorias = $DB->get_records('course_categories', null, 'id ASC', '*', 0, 1);
if (!empty($categorias)) {
    $categoria = reset($categorias);
    $total_cursos = contar_cursos_categoria($categoria->id);

    echo html_writer::tag('h5', 'Ejemplo de conteo:');
    echo html_writer::tag('p',
        "La categoría '<strong>{$categoria->name}</strong>' tiene <strong>{$total_cursos}</strong> curso(s)"
    );
}

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 6. FUNCIONES RECURSIVAS
// ============================================
echo html_writer::tag('h2', '6. Funciones Recursivas');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

/**
 * Calcula el factorial de un número (recursivo)
 *
 * @param int $n El número
 * @return int El factorial
 */
function factorial(int $n): int {
    // Caso base
    if ($n <= 1) {
        return 1;
    }

    // Caso recursivo
    return $n * factorial($n - 1);
}

echo html_writer::tag('h5', 'Factoriales:');
for ($i = 1; $i <= 6; $i++) {
    echo html_writer::tag('p', "{$i}! = " . factorial($i));
}

/**
 * Genera una jerarquía de categorías (recursivo)
 * Útil para mostrar menús en árbol
 *
 * @param int $parent_id ID de la categoría padre
 * @param int $level Nivel de profundidad
 * @return string HTML de la jerarquía
 */
function generar_jerarquia_categorias(int $parent_id = 0, int $level = 0): string {
    global $DB;

    $categories = $DB->get_records('course_categories',
        array('parent' => $parent_id),
        'sortorder ASC',
        '*',
        0,
        5  // Limitar para el ejemplo
    );

    if (empty($categories)) {
        return '';
    }

    $html = '<ul>';

    foreach ($categories as $category) {
        $indent = str_repeat('&nbsp;&nbsp;', $level);
        $html .= "<li>{$indent}{$category->name}";

        // Llamada recursiva para subcategorías
        $html .= generar_jerarquia_categorias($category->id, $level + 1);

        $html .= '</li>';
    }

    $html .= '</ul>';

    return $html;
}

echo html_writer::tag('h5', 'Jerarquía de categorías:');
echo generar_jerarquia_categorias();

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 7. FUNCIONES ANÓNIMAS (CLOSURES)
// ============================================
echo html_writer::tag('h2', '7. Funciones Anónimas');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

// Función anónima asignada a una variable
$multiplicar_por_dos = function($n) {
    return $n * 2;
};

echo html_writer::tag('p', "5 × 2 = " . $multiplicar_por_dos(5));

// Uso con array_map
$numeros = [1, 2, 3, 4, 5];
$cuadrados = array_map(function($n) {
    return $n * $n;
}, $numeros);

echo html_writer::tag('p',
    "Números: [" . implode(', ', $numeros) . "]"
);
echo html_writer::tag('p',
    "Cuadrados: [" . implode(', ', $cuadrados) . "]"
);

// Closure con 'use' para acceder a variables externas
$factor = 10;
$multiplicar_por_factor = function($n) use ($factor) {
    return $n * $factor;
};

echo html_writer::tag('p', "5 × {$factor} = " . $multiplicar_por_factor(5));

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 8. FUNCIONES HELPER DE MOODLE
// ============================================
echo html_writer::tag('h2', '8. Funciones Helper Comunes en Moodle');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

echo html_writer::tag('h5', 'fullname() - Nombre completo del usuario');
echo html_writer::tag('p', fullname($USER));

echo html_writer::tag('h5', 'format_string() - Formatear texto');
$texto_crudo = "Texto con <script>alert('xss')</script> tags";
echo html_writer::tag('p', "Original: {$texto_crudo}");
echo html_writer::tag('p', "Limpio: " . format_string($texto_crudo));

echo html_writer::tag('h5', 'userdate() - Formatear fechas');
$timestamp = time();
echo html_writer::tag('p', "Fecha actual: " . userdate($timestamp));
echo html_writer::tag('p', "Fecha corta: " . userdate($timestamp, get_string('strftimedateshort')));

echo html_writer::tag('h5', 'get_string() - Obtener texto de idioma');
echo html_writer::tag('p', "Idioma actual: " . get_string('thislanguage', 'langconfig'));

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// BUENAS PRÁCTICAS
// ============================================
echo html_writer::start_tag('div', array('class' => 'alert alert-info'));
echo html_writer::tag('h4', 'Buenas Prácticas con Funciones:');
echo html_writer::start_tag('ol');
echo html_writer::tag('li', '<strong>Nombres descriptivos:</strong> usar snake_case');
echo html_writer::tag('li', '<strong>Documentar con PHPDoc:</strong> @param, @return, @throws');
echo html_writer::tag('li', '<strong>Una función, una responsabilidad:</strong> SOLID principles');
echo html_writer::tag('li', '<strong>Usar type hinting:</strong> PHP 7+');
echo html_writer::tag('li', '<strong>Validar parámetros:</strong> al inicio de la función');
echo html_writer::tag('li', '<strong>Retornar temprano:</strong> para condiciones de error');
echo html_writer::tag('li', '<strong>Evitar efectos secundarios:</strong> funciones puras cuando sea posible');
echo html_writer::tag('li', '<strong>Limitar parámetros:</strong> máximo 3-4 parámetros');
echo html_writer::end_tag('ol');
echo html_writer::end_tag('div');

echo $OUTPUT->footer();

/**
 * EJERCICIOS:
 *
 * 1. Crea una función que valide si un email es válido
 * 2. Crea una función que obtenga todos los cursos de un usuario
 * 3. Implementa una función recursiva para calcular Fibonacci
 * 4. Crea una función que formatee bytes a KB, MB, GB
 * 5. Usa closures para crear un filtro personalizado de usuarios
 */
