<?php
/**
 * EJEMPLO 1: Variables y Operadores en Moodle
 *
 * Este ejemplo muestra cómo usar variables y operadores
 * en el contexto de Moodle con casos prácticos.
 *
 * UBICACIÓN: /local/holamundo/variables_ejemplo.php
 */

require_once('../../config.php');
require_login();

$context = context_system::instance();
$PAGE->set_context($context);
$PAGE->set_url(new moodle_url('/local/holamundo/variables_ejemplo.php'));
$PAGE->set_pagelayout('standard');
$PAGE->set_title('Variables y Operadores');
$PAGE->set_heading('Ejemplos Prácticos de PHP en Moodle');

echo $OUTPUT->header();

// ============================================
// 1. VARIABLES Y TIPOS DE DATOS
// ============================================
echo html_writer::tag('h2', '1. Variables y Tipos de Datos');

// Información del usuario actual
global $USER;
$user_id = $USER->id;              // Integer
$user_name = $USER->firstname;     // String
$user_email = $USER->email;        // String
$user_lastlogin = $USER->lastlogin; // Integer (timestamp)

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));
echo html_writer::tag('h4', 'Información del Usuario');

// Concatenación de strings
$mensaje = "ID: " . $user_id . ", Nombre: " . $user_name;
echo html_writer::tag('p', $mensaje);

// Interpolación de strings (solo con comillas dobles)
$mensaje2 = "Email: {$user_email}";
echo html_writer::tag('p', $mensaje2);

// Mostrar tipos de datos
echo html_writer::tag('pre',
    "Tipo de \$user_id: " . gettype($user_id) . "\n" .
    "Tipo de \$user_name: " . gettype($user_name) . "\n" .
    "Tipo de \$user_lastlogin: " . gettype($user_lastlogin)
);

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 2. OPERADORES ARITMÉTICOS
// ============================================
echo html_writer::tag('h2', '2. Operadores Aritméticos - Ejemplo Práctico');

global $DB;

// Obtener estadísticas del sitio
$total_users = $DB->count_records('user', array('deleted' => 0));
$total_courses = $DB->count_records('course');
$total_categories = $DB->count_records('course_categories');

// Cálculos
$cursos_sin_sitio = $total_courses - 1;  // Restamos el sitio principal
$promedio_cursos_por_categoria = $total_categories > 0
    ? round($total_courses / $total_categories, 2)
    : 0;

// Calcular porcentaje de cursos por usuario
$porcentaje = $total_users > 0
    ? round(($total_courses / $total_users) * 100, 2)
    : 0;

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));
echo html_writer::tag('h4', 'Estadísticas Calculadas');

echo html_writer::start_tag('ul');
echo html_writer::tag('li', "Total de usuarios: <strong>{$total_users}</strong>");
echo html_writer::tag('li', "Total de cursos: <strong>{$total_courses}</strong>");
echo html_writer::tag('li', "Cursos (sin sitio): <strong>{$cursos_sin_sitio}</strong>");
echo html_writer::tag('li', "Categorías: <strong>{$total_categories}</strong>");
echo html_writer::tag('li',
    "Promedio cursos/categoría: <strong>{$promedio_cursos_por_categoria}</strong>"
);
echo html_writer::tag('li', "Ratio cursos/usuario: <strong>{$porcentaje}%</strong>");
echo html_writer::end_tag('ul');

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 3. OPERADORES DE COMPARACIÓN
// ============================================
echo html_writer::tag('h2', '3. Operadores de Comparación');

// Verificar última conexión del usuario
$ahora = time();
$hace_una_semana = $ahora - (7 * 24 * 60 * 60);

$usuario_activo = $user_lastlogin > $hace_una_semana;
$usuario_nuevo = $user_id > ($total_users - 10);  // Uno de los últimos 10

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));
echo html_writer::tag('h4', 'Análisis del Usuario');

// Comparación de fechas
if ($user_lastlogin > $hace_una_semana) {
    $estado = '<span class="badge badge-success">Usuario Activo</span>';
    $mensaje = "Has accedido en los últimos 7 días";
} else {
    $estado = '<span class="badge badge-warning">Usuario Inactivo</span>';
    $dias_sin_acceso = floor(($ahora - $user_lastlogin) / 86400);
    $mensaje = "No has accedido en {$dias_sin_acceso} días";
}

echo html_writer::tag('p', $estado);
echo html_writer::tag('p', $mensaje);

// Comparación estricta vs no estricta
$string_numero = "42";
$entero = 42;

echo html_writer::tag('h5', 'Comparación == vs ===');
echo html_writer::tag('pre',
    "\"42\" == 42: " . ($string_numero == $entero ? 'true' : 'false') . "\n" .
    "\"42\" === 42: " . ($string_numero === $entero ? 'true' : 'false')
);

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 4. OPERADORES LÓGICOS
// ============================================
echo html_writer::tag('h2', '4. Operadores Lógicos');

// Verificar permisos
$is_admin = is_siteadmin();
$is_teacher = user_has_role_assignment($USER->id, 3); // Role ID 3 = teacher
$can_edit_courses = has_capability('moodle/course:create', $context);

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));
echo html_writer::tag('h4', 'Permisos del Usuario');

echo html_writer::start_tag('table', array('class' => 'table'));
echo html_writer::start_tag('tbody');

// Operador AND
$puede_administrar = $is_admin && $can_edit_courses;
echo html_writer::start_tag('tr');
echo html_writer::tag('td', 'Es admin Y puede editar cursos:');
echo html_writer::tag('td', $puede_administrar ? '✓ Sí' : '✗ No');
echo html_writer::end_tag('tr');

// Operador OR
$tiene_privilegios = $is_admin || $is_teacher;
echo html_writer::start_tag('tr');
echo html_writer::tag('td', 'Es admin O profesor:');
echo html_writer::tag('td', $tiene_privilegios ? '✓ Sí' : '✗ No');
echo html_writer::end_tag('tr');

// Operador NOT
$es_estudiante = !$is_admin && !$is_teacher;
echo html_writer::start_tag('tr');
echo html_writer::tag('td', 'Es estudiante (NO admin ni profesor):');
echo html_writer::tag('td', $es_estudiante ? '✓ Sí' : '✗ No');
echo html_writer::end_tag('tr');

echo html_writer::end_tag('tbody');
echo html_writer::end_tag('table');

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 5. OPERADOR TERNARIO Y FUSIÓN NULL
// ============================================
echo html_writer::tag('h2', '5. Operador Ternario y Fusión Null');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));
echo html_writer::tag('h4', 'Ejemplos Prácticos');

// Operador ternario
$saludo = ($ahora < strtotime('12:00')) ? 'Buenos días' : 'Buenas tardes';
echo html_writer::tag('p', "<strong>Saludo:</strong> {$saludo}");

// Determinar nivel según ID
$nivel = ($user_id < 10) ? 'Pionero' : (($user_id < 100) ? 'Veterano' : 'Nuevo');
echo html_writer::tag('p', "<strong>Nivel:</strong> {$nivel}");

// Operador de fusión null (??) - PHP 7+
// Útil para valores por defecto
$idioma = $USER->lang ?? 'es';  // Si no tiene idioma, usar 'es'
$ciudad = $USER->city ?? 'No especificada';
$pais = $USER->country ?? 'No especificado';

echo html_writer::tag('p', "<strong>Idioma:</strong> {$idioma}");
echo html_writer::tag('p', "<strong>Ciudad:</strong> {$ciudad}");
echo html_writer::tag('p', "<strong>País:</strong> {$pais}");

// Ejemplo avanzado: encadenamiento
$nombre_mostrar = $USER->firstname ?? $USER->username ?? 'Invitado';
echo html_writer::tag('p', "<strong>Nombre a mostrar:</strong> {$nombre_mostrar}");

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 6. OPERADORES DE INCREMENTO
// ============================================
echo html_writer::tag('h2', '6. Operadores de Incremento/Decremento');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

// Simular contador de visitas
$visitas = 100;

echo html_writer::tag('pre',
    "Visitas iniciales: {$visitas}\n" .
    "Pre-incremento (++\$visitas): " . (++$visitas) . "\n" .
    "Valor ahora: {$visitas}\n"
);

$visitas = 100; // Resetear

echo html_writer::tag('pre',
    "Visitas iniciales: {$visitas}\n" .
    "Post-incremento (\$visitas++): " . ($visitas++) . "\n" .
    "Valor ahora: {$visitas}\n"
);

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// RESUMEN Y BUENAS PRÁCTICAS
// ============================================
echo html_writer::start_tag('div', array('class' => 'alert alert-info'));
echo html_writer::tag('h4', 'Buenas Prácticas en Moodle:');
echo html_writer::start_tag('ol');
echo html_writer::tag('li', 'Usar === en lugar de == para comparaciones estrictas');
echo html_writer::tag('li', 'Usar el operador ?? para valores por defecto (PHP 7+)');
echo html_writer::tag('li', 'Preferir operadores lógicos claros (&& y ||) sobre and/or');
echo html_writer::tag('li', 'Usar operador ternario para asignaciones simples');
echo html_writer::tag('li', 'Evitar operadores ternarios anidados complejos');
echo html_writer::tag('li', 'Siempre validar datos antes de operaciones matemáticas');
echo html_writer::end_tag('ol');
echo html_writer::end_tag('div');

echo $OUTPUT->footer();

/**
 * EJERCICIOS PROPUESTOS:
 *
 * 1. Crea una variable que calcule cuántos días han pasado desde que
 *    el usuario se registró (usar $USER->timecreated)
 *
 * 2. Usa operadores lógicos para determinar si un usuario puede
 *    ver contenido "premium" (ej: admin O usuario con más de 30 días)
 *
 * 3. Usa el operador ternario para mostrar un mensaje diferente
 *    según la hora del día (mañana, tarde, noche)
 *
 * 4. Calcula el porcentaje de cursos completados por el usuario
 *    (necesitarás consultas a la BD que verás en el siguiente módulo)
 */
