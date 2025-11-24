<?php
/**
 * EJEMPLO 1: Consultas Básicas a la Base de Datos
 *
 * Este ejemplo muestra las funciones más comunes de $DB para leer datos.
 * Incluye get_record, get_records, get_field, count_records, etc.
 *
 * UBICACIÓN: /local/holamundo/db_basicas.php
 */

require_once('../../config.php');
require_login();

$context = context_system::instance();
$PAGE->set_context($context);
$PAGE->set_url(new moodle_url('/local/holamundo/db_basicas.php'));
$PAGE->set_pagelayout('standard');
$PAGE->set_title('Consultas Básicas - $DB');
$PAGE->set_heading('API de Base de Datos: Consultas de Lectura');

echo $OUTPUT->header();

global $DB, $USER;

// ============================================
// 1. get_record() - OBTENER UN REGISTRO
// ============================================
echo html_writer::tag('h2', '1. get_record() - Obtener un registro');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

echo html_writer::tag('h4', 'Obtener usuario actual:');

// Obtener registro completo
$user = $DB->get_record('user', array('id' => $USER->id), '*', MUST_EXIST);

echo html_writer::tag('pre',
    "ID: {$user->id}\n" .
    "Usuario: {$user->username}\n" .
    "Nombre: {$user->firstname} {$user->lastname}\n" .
    "Email: {$user->email}\n" .
    "Creado: " . userdate($user->timecreated)
);

// Obtener solo campos específicos (más eficiente)
$user_minimal = $DB->get_record('user',
    array('id' => $USER->id),
    'id, username, email' // Solo estos campos
);

echo html_writer::tag('h4', 'Solo campos específicos:');
echo html_writer::tag('pre',
    "ID: {$user_minimal->id}\n" .
    "Usuario: {$user_minimal->username}\n" .
    "Email: {$user_minimal->email}"
);

// Con múltiples condiciones
echo html_writer::tag('h4', 'Con múltiples condiciones:');

$admin_user = $DB->get_record('user',
    array(
        'username' => 'admin',
        'deleted' => 0
    )
);

if ($admin_user) {
    echo html_writer::tag('p', "✓ Usuario admin encontrado: {$admin_user->email}");
} else {
    echo html_writer::tag('p', "✗ Usuario admin no encontrado");
}

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 2. get_records() - OBTENER MÚLTIPLES REGISTROS
// ============================================
echo html_writer::tag('h2', '2. get_records() - Obtener múltiples registros');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

echo html_writer::tag('h4', 'Primeros 5 usuarios del sistema:');

// Obtener con límite y ordenamiento
$users = $DB->get_records('user',
    array('deleted' => 0),     // Condiciones
    'id ASC',                   // Ordenamiento
    'id, username, email',      // Campos
    0,                          // Offset (desde dónde)
    5                           // Limit (cuántos)
);

echo html_writer::start_tag('table', array('class' => 'table table-sm table-striped'));
echo html_writer::start_tag('thead');
echo html_writer::tag('tr',
    html_writer::tag('th', 'ID') .
    html_writer::tag('th', 'Usuario') .
    html_writer::tag('th', 'Email')
);
echo html_writer::end_tag('thead');
echo html_writer::start_tag('tbody');

foreach ($users as $u) {
    echo html_writer::start_tag('tr');
    echo html_writer::tag('td', $u->id);
    echo html_writer::tag('td', $u->username);
    echo html_writer::tag('td', $u->email);
    echo html_writer::end_tag('tr');
}

echo html_writer::end_tag('tbody');
echo html_writer::end_tag('table');

// Obtener todos los cursos (sin límite)
echo html_writer::tag('h4', 'Todos los cursos (ordenados por nombre):');

$courses = $DB->get_records('course', null, 'fullname ASC');

echo html_writer::start_tag('ol');
foreach ($courses as $course) {
    if ($course->id == SITEID) continue; // Saltar sitio principal

    $icon = $course->visible ? '👁️' : '🔒';
    echo html_writer::tag('li',
        "{$icon} {$course->fullname} ({$course->shortname})"
    );
}
echo html_writer::end_tag('ol');

echo html_writer::tag('p',
    "Total de cursos: <strong>" . (count($courses) - 1) . "</strong>"
);

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 3. get_records_select() - CON SQL PERSONALIZADO
// ============================================
echo html_writer::tag('h2', '3. get_records_select() - Condiciones personalizadas');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

echo html_writer::tag('h4', 'Usuarios activos en los últimos 7 días:');

// Calcular timestamp de hace 7 días
$seven_days_ago = time() - (7 * 24 * 60 * 60);

// Consulta con placeholder posicional (?)
$active_users = $DB->get_records_select('user',
    'lastlogin > ? AND deleted = 0',     // Condición SQL
    array($seven_days_ago),               // Parámetros
    'lastlogin DESC',                     // Ordenamiento
    'id, username, firstname, lastname, lastlogin', // Campos
    0,                                     // Offset
    10                                     // Limit
);

if (!empty($active_users)) {
    echo html_writer::start_tag('table', array('class' => 'table table-sm'));
    echo html_writer::start_tag('thead', array('class' => 'thead-light'));
    echo html_writer::tag('tr',
        html_writer::tag('th', 'Usuario') .
        html_writer::tag('th', 'Nombre') .
        html_writer::tag('th', 'Último acceso')
    );
    echo html_writer::end_tag('thead');
    echo html_writer::start_tag('tbody');

    foreach ($active_users as $u) {
        $dias_desde = floor((time() - $u->lastlogin) / 86400);
        $tiempo = $dias_desde == 0 ? 'Hoy' : "Hace {$dias_desde} día(s)";

        echo html_writer::start_tag('tr');
        echo html_writer::tag('td', $u->username);
        echo html_writer::tag('td', "{$u->firstname} {$u->lastname}");
        echo html_writer::tag('td', $tiempo);
        echo html_writer::end_tag('tr');
    }

    echo html_writer::end_tag('tbody');
    echo html_writer::end_tag('table');
} else {
    echo html_writer::tag('p', 'No hay usuarios activos recientes.', array('class' => 'text-muted'));
}

// Ejemplo con LIKE (búsqueda de texto)
echo html_writer::tag('h4', 'Cursos que contienen "curso" en el nombre:', array('class' => 'mt-4'));

$search_courses = $DB->get_records_select('course',
    $DB->sql_like('fullname', ':searchterm', false), // Case insensitive
    array('searchterm' => '%curso%'),
    'fullname ASC'
);

echo html_writer::start_tag('ul');
foreach ($search_courses as $course) {
    if ($course->id == SITEID) continue;
    echo html_writer::tag('li', $course->fullname);
}
echo html_writer::end_tag('ul');

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 4. get_field() - OBTENER UN SOLO CAMPO
// ============================================
echo html_writer::tag('h2', '4. get_field() - Obtener valor de un campo');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

// Obtener email del usuario
$user_email = $DB->get_field('user', 'email', array('id' => $USER->id));

echo html_writer::tag('p', "Email del usuario actual: <strong>{$user_email}</strong>");

// Obtener nombre de un curso
$courses_list = $DB->get_records('course', null, 'id ASC', 'id', 0, 1);
if (!empty($courses_list)) {
    $first_course = reset($courses_list);
    $course_name = $DB->get_field('course', 'fullname', array('id' => $first_course->id));

    echo html_writer::tag('p',
        "Nombre del primer curso (ID {$first_course->id}): <strong>{$course_name}</strong>"
    );
}

// Con MUST_EXIST
try {
    $username = $DB->get_field('user', 'username', array('id' => $USER->id), MUST_EXIST);
    echo html_writer::tag('p', "Tu username: <strong>{$username}</strong>");
} catch (dml_missing_record_exception $e) {
    echo html_writer::tag('p', 'Usuario no encontrado', array('class' => 'text-danger'));
}

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 5. get_fieldset_select() - ARRAY DE VALORES
// ============================================
echo html_writer::tag('h2', '5. get_fieldset_select() - Obtener array de valores');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

// Obtener todos los emails de usuarios activos
$all_emails = $DB->get_fieldset_select('user', 'email', 'deleted = 0');

echo html_writer::tag('h4', 'Primeros 10 emails del sistema:');
echo html_writer::start_tag('ul');

$count = 0;
foreach ($all_emails as $email) {
    if ($count++ >= 10) break;
    echo html_writer::tag('li', $email);
}
echo html_writer::end_tag('ul');

echo html_writer::tag('p', "Total de emails en el sistema: <strong>" . count($all_emails) . "</strong>");

// Obtener IDs de cursos visibles
$visible_course_ids = $DB->get_fieldset_select('course', 'id', 'visible = 1');

echo html_writer::tag('h4', 'IDs de cursos visibles:', array('class' => 'mt-3'));
echo html_writer::tag('p', '[' . implode(', ', $visible_course_ids) . ']');

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 6. count_records() - CONTAR REGISTROS
// ============================================
echo html_writer::tag('h2', '6. count_records() - Contar registros');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

// Contar usuarios
$total_users = $DB->count_records('user', array('deleted' => 0));
$suspended_users = $DB->count_records('user', array('suspended' => 1, 'deleted' => 0));

// Contar cursos
$total_courses = $DB->count_records('course');
$visible_courses = $DB->count_records('course', array('visible' => 1));

// Contar categorías
$total_categories = $DB->count_records('course_categories');

echo html_writer::tag('h4', 'Estadísticas del Sistema:');
echo html_writer::start_tag('table', array('class' => 'table table-bordered'));

echo html_writer::start_tag('tr');
echo html_writer::tag('th', 'Total de usuarios');
echo html_writer::tag('td', "<strong>{$total_users}</strong>");
echo html_writer::end_tag('tr');

echo html_writer::start_tag('tr');
echo html_writer::tag('th', 'Usuarios suspendidos');
echo html_writer::tag('td', "<strong>{$suspended_users}</strong>");
echo html_writer::end_tag('tr');

echo html_writer::start_tag('tr');
echo html_writer::tag('th', 'Total de cursos');
echo html_writer::tag('td', "<strong>{$total_courses}</strong>");
echo html_writer::end_tag('tr');

echo html_writer::start_tag('tr');
echo html_writer::tag('th', 'Cursos visibles');
echo html_writer::tag('td', "<strong>{$visible_courses}</strong>");
echo html_writer::end_tag('tr');

echo html_writer::start_tag('tr');
echo html_writer::tag('th', 'Categorías de cursos');
echo html_writer::tag('td', "<strong>{$total_categories}</strong>");
echo html_writer::end_tag('tr');

echo html_writer::end_tag('table');

// count_records_select con condiciones
$new_users_count = $DB->count_records_select('user',
    'timecreated > ? AND deleted = 0',
    array(time() - (30 * 24 * 60 * 60))
);

echo html_writer::tag('p',
    "Usuarios nuevos (últimos 30 días): <strong>{$new_users_count}</strong>"
);

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 7. record_exists() - VERIFICAR EXISTENCIA
// ============================================
echo html_writer::tag('h2', '7. record_exists() - Verificar existencia');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

// Verificar si existe usuario admin
$admin_exists = $DB->record_exists('user', array('username' => 'admin', 'deleted' => 0));

echo html_writer::tag('p',
    "¿Existe usuario 'admin'? " . ($admin_exists ? '✓ Sí' : '✗ No')
);

// Verificar si existe un curso específico
$course_exists = $DB->record_exists('course', array('id' => 1));

echo html_writer::tag('p',
    "¿Existe curso con ID 1? " . ($course_exists ? '✓ Sí' : '✗ No')
);

// Ejemplo práctico: Verificar antes de insertar
$new_username = 'testuser123';
$username_exists = $DB->record_exists('user', array('username' => $new_username));

if ($username_exists) {
    echo html_writer::tag('div',
        "⚠️ El usuario '{$new_username}' ya existe. No se puede crear.",
        array('class' => 'alert alert-warning')
    );
} else {
    echo html_writer::tag('div',
        "✓ El usuario '{$new_username}' está disponible.",
        array('class' => 'alert alert-success')
    );
}

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 8. get_records_list() - IN CLAUSE
// ============================================
echo html_writer::tag('h2', '8. get_records_list() - Consulta con IN');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

echo html_writer::tag('h4', 'Obtener múltiples usuarios por IDs:');

// IDs específicos
$user_ids = array(1, 2, $USER->id);

// Obtener usuarios cuyo ID esté en el array
$specific_users = $DB->get_records_list('user', 'id', $user_ids, 'id ASC', 'id, username, email');

echo html_writer::start_tag('table', array('class' => 'table table-sm'));
foreach ($specific_users as $u) {
    echo html_writer::start_tag('tr');
    echo html_writer::tag('td', $u->id);
    echo html_writer::tag('td', $u->username);
    echo html_writer::tag('td', $u->email);
    echo html_writer::end_tag('tr');
}
echo html_writer::end_tag('table');

// Equivalente SQL:
// SELECT id, username, email FROM mdl_user WHERE id IN (1, 2, X) ORDER BY id ASC

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// BUENAS PRÁCTICAS
// ============================================
echo html_writer::start_tag('div', array('class' => 'alert alert-info'));
echo html_writer::tag('h4', 'Buenas Prácticas de Consultas:');
echo html_writer::start_tag('ol');
echo html_writer::tag('li', '<strong>Siempre usar placeholders:</strong> Nunca concatenar valores en SQL');
echo html_writer::tag('li', '<strong>Seleccionar solo campos necesarios:</strong> No usar * si no es necesario');
echo html_writer::tag('li', '<strong>Usar índices:</strong> Filtrar por campos indexados (id, etc.)');
echo html_writer::tag('li', '<strong>Limitar resultados:</strong> Usar LIMIT para evitar sobrecarga');
echo html_writer::tag('li', '<strong>Verificar antes de operar:</strong> record_exists() antes de insertar');
echo html_writer::tag('li', '<strong>Usar funciones específicas:</strong> get_field() es más rápido que get_record()');
echo html_writer::tag('li', '<strong>Evitar queries en bucles:</strong> Problema N+1');
echo html_writer::end_tag('ol');
echo html_writer::end_tag('div');

echo $OUTPUT->footer();

/**
 * RESUMEN DE FUNCIONES:
 *
 * LECTURA (SELECT):
 * - get_record()          - Un registro
 * - get_records()         - Múltiples registros
 * - get_records_select()  - Con SQL personalizado
 * - get_field()           - Un campo
 * - get_fieldset_select() - Array de valores
 * - count_records()       - Contar
 * - record_exists()       - Verificar existencia
 * - get_records_list()    - Con IN clause
 *
 * EJERCICIOS:
 *
 * 1. Obtén los 5 cursos más recientes (ordena por timecreated DESC)
 * 2. Cuenta cuántos usuarios se registraron hoy
 * 3. Obtén un array con todos los nombres de categorías
 * 4. Verifica si existe un curso con shortname 'INTRO101'
 * 5. Obtén usuarios cuyo firstname empiece con 'A'
 */
