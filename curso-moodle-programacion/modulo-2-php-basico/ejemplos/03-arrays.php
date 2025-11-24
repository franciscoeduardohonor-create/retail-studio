<?php
/**
 * EJEMPLO 3: Arrays en Moodle
 *
 * Los arrays son fundamentales en Moodle. Este ejemplo muestra
 * cómo trabajar con arrays simples y asociativos.
 *
 * UBICACIÓN: /local/holamundo/arrays_ejemplo.php
 */

require_once('../../config.php');
require_login();

$context = context_system::instance();
$PAGE->set_context($context);
$PAGE->set_url(new moodle_url('/local/holamundo/arrays_ejemplo.php'));
$PAGE->set_pagelayout('standard');
$PAGE->set_title('Trabajando con Arrays');
$PAGE->set_heading('Arrays en Moodle - Ejemplos Prácticos');

echo $OUTPUT->header();

global $DB, $USER;

// ============================================
// 1. ARRAYS SIMPLES (INDEXADOS)
// ============================================
echo html_writer::tag('h2', '1. Arrays Simples (Indexados)');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

// Crear array simple
$roles = array('Estudiante', 'Profesor', 'Manager', 'Administrador');

// Sintaxis corta (PHP 5.4+)
$colores = ['rojo', 'verde', 'azul', 'amarillo'];

echo html_writer::tag('h4', 'Roles en Moodle:');
echo html_writer::start_tag('ul');
foreach ($roles as $index => $rol) {
    echo html_writer::tag('li', "Índice {$index}: {$rol}");
}
echo html_writer::end_tag('ul');

// Acceder a elementos
echo html_writer::tag('p', "Primer rol: <strong>{$roles[0]}</strong>");
echo html_writer::tag('p', "Último rol: <strong>{$roles[3]}</strong>");

// Agregar elementos
$roles[] = 'Editor';  // Agrega al final
array_push($roles, 'Diseñador');

echo html_writer::tag('p', "Total de roles: <strong>" . count($roles) . "</strong>");

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 2. ARRAYS ASOCIATIVOS (CLAVE => VALOR)
// ============================================
echo html_writer::tag('h2', '2. Arrays Asociativos');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

// Array asociativo con configuración
$config = array(
    'sitename' => 'Mi Moodle',
    'maxusers' => 1000,
    'defaultlanguage' => 'es',
    'timezone' => 'America/Mexico_City',
    'enableanalytics' => true
);

echo html_writer::tag('h4', 'Configuración del sitio:');
echo html_writer::start_tag('table', array('class' => 'table table-sm'));

foreach ($config as $key => $value) {
    // Convertir booleanos a texto
    $display_value = is_bool($value) ? ($value ? 'Sí' : 'No') : $value;

    echo html_writer::start_tag('tr');
    echo html_writer::tag('th', ucfirst($key));
    echo html_writer::tag('td', $display_value);
    echo html_writer::end_tag('tr');
}

echo html_writer::end_tag('table');

// Acceder a elementos específicos
echo html_writer::tag('p',
    "Nombre del sitio: <strong>{$config['sitename']}</strong>"
);

// Verificar si existe una clave
if (array_key_exists('timezone', $config)) {
    echo html_writer::tag('p',
        "Zona horaria configurada: <strong>{$config['timezone']}</strong>"
    );
}

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 3. ARRAYS MULTIDIMENSIONALES
// ============================================
echo html_writer::tag('h2', '3. Arrays Multidimensionales');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

// Array de usuarios con información detallada
$usuarios = array(
    array(
        'id' => 1,
        'nombre' => 'Juan Pérez',
        'email' => 'juan@example.com',
        'rol' => 'Estudiante',
        'cursos' => 3
    ),
    array(
        'id' => 2,
        'nombre' => 'María García',
        'email' => 'maria@example.com',
        'rol' => 'Profesor',
        'cursos' => 5
    ),
    array(
        'id' => 3,
        'nombre' => 'Carlos López',
        'email' => 'carlos@example.com',
        'rol' => 'Administrador',
        'cursos' => 0
    )
);

echo html_writer::tag('h4', 'Lista de usuarios:');
echo html_writer::start_tag('table', array('class' => 'table table-striped'));
echo html_writer::start_tag('thead');
echo html_writer::tag('tr',
    html_writer::tag('th', 'ID') .
    html_writer::tag('th', 'Nombre') .
    html_writer::tag('th', 'Email') .
    html_writer::tag('th', 'Rol') .
    html_writer::tag('th', 'Cursos')
);
echo html_writer::end_tag('thead');

echo html_writer::start_tag('tbody');
foreach ($usuarios as $usuario) {
    echo html_writer::start_tag('tr');
    echo html_writer::tag('td', $usuario['id']);
    echo html_writer::tag('td', $usuario['nombre']);
    echo html_writer::tag('td', $usuario['email']);
    echo html_writer::tag('td', $usuario['rol']);
    echo html_writer::tag('td', $usuario['cursos']);
    echo html_writer::end_tag('tr');
}
echo html_writer::end_tag('tbody');
echo html_writer::end_tag('table');

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 4. FUNCIONES DE ARRAYS EN MOODLE
// ============================================
echo html_writer::tag('h2', '4. Funciones Útiles de Arrays');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

// Obtener usuarios de la BD para ejemplos reales
$users = $DB->get_records('user', array('deleted' => 0), 'id ASC', 'id, username, firstname, lastname', 0, 10);

// Convertir objetos a array (común en Moodle)
$users_array = array_values($users);

echo html_writer::tag('h4', 'count() - Contar elementos');
echo html_writer::tag('p', "Total de usuarios: <strong>" . count($users_array) . "</strong>");

// in_array() - Verificar si existe un valor
$numeros = [1, 2, 3, 4, 5];
$existe = in_array(3, $numeros);
echo html_writer::tag('h4', 'in_array() - Verificar existencia');
echo html_writer::tag('p', "¿Existe el 3 en [1,2,3,4,5]? " . ($existe ? 'Sí' : 'No'));

// array_keys() - Obtener claves
$curso = array('id' => 1, 'nombre' => 'PHP', 'duracion' => '40h');
$claves = array_keys($curso);
echo html_writer::tag('h4', 'array_keys() - Obtener claves');
echo html_writer::tag('p', "Claves: " . implode(', ', $claves));

// array_values() - Obtener valores
$valores = array_values($curso);
echo html_writer::tag('h4', 'array_values() - Obtener valores');
echo html_writer::tag('p', "Valores: " . implode(', ', $valores));

// array_merge() - Unir arrays
$array1 = ['a', 'b', 'c'];
$array2 = ['d', 'e', 'f'];
$merged = array_merge($array1, $array2);
echo html_writer::tag('h4', 'array_merge() - Unir arrays');
echo html_writer::tag('p', "Resultado: [" . implode(', ', $merged) . "]");

// array_slice() - Extraer porción
$extracto = array_slice($numeros, 1, 3);
echo html_writer::tag('h4', 'array_slice() - Extraer porción');
echo html_writer::tag('p', "De [1,2,3,4,5], posición 1, tomar 3: [" . implode(', ', $extracto) . "]");

// array_reverse() - Invertir
$invertido = array_reverse($numeros);
echo html_writer::tag('h4', 'array_reverse() - Invertir');
echo html_writer::tag('p', "Invertido: [" . implode(', ', $invertido) . "]");

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 5. ARRAY_FILTER() Y ARRAY_MAP()
// ============================================
echo html_writer::tag('h2', '5. Filtrar y Transformar Arrays');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

// Ejemplo con datos reales de Moodle
$all_users = $DB->get_records('user', array('deleted' => 0), '', 'id, username, email, suspended', 0, 20);

// ARRAY_FILTER - Filtrar usuarios activos (no suspendidos)
$active_users = array_filter($all_users, function($user) {
    return $user->suspended == 0;
});

echo html_writer::tag('h4', 'array_filter() - Usuarios activos');
echo html_writer::tag('p', "Total de usuarios: <strong>" . count($all_users) . "</strong>");
echo html_writer::tag('p', "Usuarios activos: <strong>" . count($active_users) . "</strong>");
echo html_writer::tag('p', "Usuarios suspendidos: <strong>" . (count($all_users) - count($active_users)) . "</strong>");

// ARRAY_MAP - Transformar datos
$edades = [18, 22, 25, 30, 35];

$edades_en_meses = array_map(function($edad) {
    return $edad * 12;
}, $edades);

echo html_writer::tag('h4', 'array_map() - Transformar datos');
echo html_writer::tag('p', "Edades en años: [" . implode(', ', $edades) . "]");
echo html_writer::tag('p', "Edades en meses: [" . implode(', ', $edades_en_meses) . "]");

// Ejemplo práctico: Extraer solo los emails de usuarios
$emails = array_map(function($user) {
    return $user->email;
}, $all_users);

echo html_writer::tag('h5', 'Emails extraídos (primeros 5):');
echo html_writer::start_tag('ul');
$count = 0;
foreach ($emails as $email) {
    if ($count++ >= 5) break;
    echo html_writer::tag('li', $email);
}
echo html_writer::end_tag('ul');

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 6. ARRAY_REDUCE() - REDUCIR A UN VALOR
// ============================================
echo html_writer::tag('h2', '6. Reducir Arrays');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

$calificaciones = [85, 90, 78, 92, 88];

// Sumar todas las calificaciones
$suma = array_reduce($calificaciones, function($carry, $item) {
    return $carry + $item;
}, 0);

$promedio = $suma / count($calificaciones);

echo html_writer::tag('h4', 'array_reduce() - Calcular promedio');
echo html_writer::tag('p', "Calificaciones: [" . implode(', ', $calificaciones) . "]");
echo html_writer::tag('p', "Suma total: <strong>{$suma}</strong>");
echo html_writer::tag('p', "Promedio: <strong>" . round($promedio, 2) . "</strong>");

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 7. ORDENAR ARRAYS
// ============================================
echo html_writer::tag('h2', '7. Ordenar Arrays');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

$nombres = ['Zoe', 'Ana', 'María', 'Carlos', 'Beatriz'];

// sort() - Ordenar ascendente (modifica el array original)
$nombres_asc = $nombres;
sort($nombres_asc);
echo html_writer::tag('h4', 'sort() - Ascendente');
echo html_writer::tag('p', "[" . implode(', ', $nombres_asc) . "]");

// rsort() - Ordenar descendente
$nombres_desc = $nombres;
rsort($nombres_desc);
echo html_writer::tag('h4', 'rsort() - Descendente');
echo html_writer::tag('p', "[" . implode(', ', $nombres_desc) . "]");

// asort() - Ordenar manteniendo índices
$edades_asociativo = array('Juan' => 25, 'Ana' => 22, 'Carlos' => 30);
asort($edades_asociativo);
echo html_writer::tag('h4', 'asort() - Por valor, manteniendo claves');
foreach ($edades_asociativo as $nombre => $edad) {
    echo html_writer::tag('p', "{$nombre}: {$edad} años");
}

// ksort() - Ordenar por clave
$edades_por_nombre = array('Juan' => 25, 'Ana' => 22, 'Carlos' => 30);
ksort($edades_por_nombre);
echo html_writer::tag('h4', 'ksort() - Por clave alfabéticamente');
foreach ($edades_por_nombre as $nombre => $edad) {
    echo html_writer::tag('p', "{$nombre}: {$edad} años");
}

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 8. ARRAYS EN MOODLE - EJEMPLO PRÁCTICO
// ============================================
echo html_writer::tag('h2', '8. Caso Práctico: Procesar Cursos');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

// Obtener cursos de la BD
$courses = $DB->get_records('course', null, 'fullname ASC', '*', 0, 10);

// Procesar y transformar datos
$courses_data = array();

foreach ($courses as $course) {
    if ($course->id == SITEID) continue; // Saltar sitio principal

    $courses_data[] = array(
        'id' => $course->id,
        'nombre' => $course->fullname,
        'codigo' => $course->shortname,
        'visible' => $course->visible ? 'Sí' : 'No'
    );
}

echo html_writer::tag('h4', 'Cursos procesados:');

if (!empty($courses_data)) {
    echo html_writer::start_tag('table', array('class' => 'table table-sm'));
    echo html_writer::start_tag('thead', array('class' => 'thead-light'));
    echo html_writer::tag('tr',
        html_writer::tag('th', 'ID') .
        html_writer::tag('th', 'Nombre') .
        html_writer::tag('th', 'Código') .
        html_writer::tag('th', 'Visible')
    );
    echo html_writer::end_tag('thead');

    echo html_writer::start_tag('tbody');
    foreach ($courses_data as $course) {
        echo html_writer::start_tag('tr');
        echo html_writer::tag('td', $course['id']);
        echo html_writer::tag('td', $course['nombre']);
        echo html_writer::tag('td', $course['codigo']);
        echo html_writer::tag('td', $course['visible']);
        echo html_writer::end_tag('tr');
    }
    echo html_writer::end_tag('tbody');
    echo html_writer::end_tag('table');

    // Estadísticas
    $total_courses = count($courses_data);
    $visible_courses = array_filter($courses_data, function($c) {
        return $c['visible'] === 'Sí';
    });
    $total_visible = count($visible_courses);

    echo html_writer::tag('p', "Total de cursos: <strong>{$total_courses}</strong>");
    echo html_writer::tag('p', "Cursos visibles: <strong>{$total_visible}</strong>");
}

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// BUENAS PRÁCTICAS
// ============================================
echo html_writer::start_tag('div', array('class' => 'alert alert-success'));
echo html_writer::tag('h4', 'Buenas Prácticas con Arrays en Moodle:');
echo html_writer::start_tag('ol');
echo html_writer::tag('li', '<strong>Usar sintaxis corta []</strong> en PHP 5.4+');
echo html_writer::tag('li', '<strong>Verificar con empty()</strong> antes de iterar');
echo html_writer::tag('li', '<strong>Usar foreach</strong> para recorrer resultados de BD');
echo html_writer::tag('li', '<strong>array_filter/array_map</strong> para código más limpio');
echo html_writer::tag('li', '<strong>count()</strong> en lugar de sizeof()');
echo html_writer::tag('li', '<strong>isset()</strong> antes de acceder a índices');
echo html_writer::tag('li', '<strong>Documentar arrays complejos</strong> con PHPDoc');
echo html_writer::end_tag('ol');
echo html_writer::end_tag('div');

echo $OUTPUT->footer();

/**
 * EJERCICIOS:
 *
 * 1. Crea un array con los últimos 10 usuarios y filtra solo los activos
 * 2. Usa array_map para extraer solo los IDs de los cursos
 * 3. Ordena un array de cursos por nombre usando usort()
 * 4. Crea un array multidimensional con categorías y sus cursos
 * 5. Usa array_reduce para calcular el total de estudiantes inscritos
 */
