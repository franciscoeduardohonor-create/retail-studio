<?php
/**
 * EJEMPLO 2: Estructuras de Control en Moodle
 *
 * Este ejemplo muestra if/else, switch, loops y su uso práctico en Moodle.
 *
 * UBICACIÓN: /local/holamundo/estructuras_control.php
 */

require_once('../../config.php');
require_login();

$context = context_system::instance();
$PAGE->set_context($context);
$PAGE->set_url(new moodle_url('/local/holamundo/estructuras_control.php'));
$PAGE->set_pagelayout('standard');
$PAGE->set_title('Estructuras de Control');
$PAGE->set_heading('if, switch, for, while, foreach');

echo $OUTPUT->header();

global $USER, $DB;

// ============================================
// 1. IF / ELSE / ELSEIF
// ============================================
echo html_writer::tag('h2', '1. Condicionales IF/ELSE');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

// Determinar rol del usuario
if (is_siteadmin()) {
    $rol = "Administrador del Sitio";
    $color = "danger";
    $icono = "fa-crown";
} elseif (user_has_role_assignment($USER->id, 3)) {
    $rol = "Profesor";
    $color = "warning";
    $icono = "fa-chalkboard-teacher";
} elseif (user_has_role_assignment($USER->id, 5)) {
    $rol = "Estudiante";
    $color = "info";
    $icono = "fa-user-graduate";
} else {
    $rol = "Usuario";
    $color = "secondary";
    $icono = "fa-user";
}

echo html_writer::tag('div',
    "<i class='fa {$icono}'></i> Tu rol principal: <strong>{$rol}</strong>",
    array('class' => "alert alert-{$color}")
);

// Verificar actividad reciente
$hace_un_dia = time() - 86400;
$hace_una_semana = time() - (7 * 86400);

if ($USER->lastlogin > $hace_un_dia) {
    $actividad = "Muy activo (último acceso hace menos de 24 horas)";
    $badge = "success";
} elseif ($USER->lastlogin > $hace_una_semana) {
    $actividad = "Activo (último acceso esta semana)";
    $badge = "primary";
} else {
    $dias_inactivo = floor((time() - $USER->lastlogin) / 86400);
    $actividad = "Inactivo (último acceso hace {$dias_inactivo} días)";
    $badge = "warning";
}

echo html_writer::tag('span', $actividad, array('class' => "badge badge-{$badge}"));

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 2. SWITCH
// ============================================
echo html_writer::tag('h2', '2. Switch - Selección Múltiple');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

// Mensaje según día de la semana
$dia_numero = date('N'); // 1 (lunes) a 7 (domingo)

switch ($dia_numero) {
    case 1:
        $dia_nombre = "Lunes";
        $mensaje = "¡Comienza la semana con energía!";
        break;

    case 2:
    case 3:
    case 4:
        $dia_nombre = date('l'); // Nombre del día en inglés
        $mensaje = "Mitad de semana, ¡sigue adelante!";
        break;

    case 5:
        $dia_nombre = "Viernes";
        $mensaje = "¡Ya casi es fin de semana!";
        break;

    case 6:
    case 7:
        $dia_nombre = "Fin de semana";
        $mensaje = "Tiempo de descansar y recargar energías";
        break;

    default:
        $dia_nombre = "Día desconocido";
        $mensaje = "";
        break;
}

echo html_writer::tag('h4', "Hoy es {$dia_nombre}");
echo html_writer::tag('p', $mensaje);

// Switch para determinar acción según parámetro
$action = optional_param('action', 'view', PARAM_ALPHA);

echo html_writer::tag('h5', 'Acciones disponibles:');

switch ($action) {
    case 'view':
        echo html_writer::tag('p', '👁️ Modo visualización');
        break;

    case 'edit':
        echo html_writer::tag('p', '✏️ Modo edición');
        break;

    case 'delete':
        echo html_writer::tag('p', '🗑️ Modo eliminación');
        break;

    default:
        echo html_writer::tag('p', 'ℹ️ Acción no reconocida');
        break;
}

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 3. BUCLE FOR
// ============================================
echo html_writer::tag('h2', '3. Bucle FOR');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

echo html_writer::tag('h4', 'Últimos 10 usuarios registrados:');

// Obtener total de usuarios
$total_users = $DB->count_records('user', array('deleted' => 0));

echo html_writer::start_tag('ol');

// Bucle FOR para mostrar últimos usuarios
for ($i = 0; $i < 10; $i++) {
    // Calcular ID del usuario (del más reciente al más antiguo)
    $offset = $i;

    // Obtener usuario
    $users = $DB->get_records('user',
        array('deleted' => 0),
        'id DESC',
        'id, firstname, lastname, email',
        $offset,
        1
    );

    if (!empty($users)) {
        $user = reset($users); // Primer elemento
        $fullname = "{$user->firstname} {$user->lastname}";

        echo html_writer::tag('li',
            "<strong>{$fullname}</strong> ({$user->email})"
        );
    }
}

echo html_writer::end_tag('ol');

// Ejemplo de FOR con salto de iteraciones
echo html_writer::tag('h5', 'Números pares del 1 al 20:');
$pares = "";
for ($num = 1; $num <= 20; $num++) {
    if ($num % 2 != 0) {
        continue; // Saltar números impares
    }
    $pares .= $num . " ";

    if ($num == 10) {
        $pares .= "| "; // Separador en el medio
    }
}
echo html_writer::tag('p', $pares);

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 4. BUCLE WHILE
// ============================================
echo html_writer::tag('h2', '4. Bucle WHILE');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

echo html_writer::tag('h4', 'Categorías de cursos:');

// Obtener categorías
$categories = $DB->get_records('course_categories', null, 'name ASC', '*', 0, 10);

if (!empty($categories)) {
    echo html_writer::start_tag('table', array('class' => 'table table-sm'));
    echo html_writer::start_tag('thead');
    echo html_writer::tag('tr',
        html_writer::tag('th', 'ID') .
        html_writer::tag('th', 'Nombre') .
        html_writer::tag('th', 'Descripción')
    );
    echo html_writer::end_tag('thead');
    echo html_writer::start_tag('tbody');

    // Convertir a array simple para usar con while
    $categories_array = array_values($categories);
    $index = 0;
    $total = count($categories_array);

    while ($index < $total) {
        $category = $categories_array[$index];

        echo html_writer::start_tag('tr');
        echo html_writer::tag('td', $category->id);
        echo html_writer::tag('td', $category->name);
        echo html_writer::tag('td', substr(strip_tags($category->description), 0, 50) . '...');
        echo html_writer::end_tag('tr');

        $index++;
    }

    echo html_writer::end_tag('tbody');
    echo html_writer::end_tag('table');
} else {
    echo html_writer::tag('p', 'No hay categorías para mostrar.', array('class' => 'text-muted'));
}

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 5. BUCLE FOREACH (el más usado en Moodle)
// ============================================
echo html_writer::tag('h2', '5. Bucle FOREACH');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

echo html_writer::tag('h4', 'Cursos disponibles:');

// Obtener cursos (excluyendo el sitio)
$courses = $DB->get_records('course', null, 'fullname ASC', '*', 0, 10);

if (!empty($courses)) {
    echo html_writer::start_tag('div', array('class' => 'list-group'));

    // FOREACH simple
    foreach ($courses as $course) {
        // Saltar el sitio principal
        if ($course->id == SITEID) {
            continue;
        }

        // Obtener cantidad de usuarios inscritos
        $context_course = context_course::instance($course->id);
        $enrolled = count_enrolled_users($context_course);

        echo html_writer::start_tag('div', array('class' => 'list-group-item'));

        echo html_writer::tag('h5', $course->fullname, array('class' => 'mb-1'));

        echo html_writer::tag('p',
            "<small>Código: {$course->shortname}</small>",
            array('class' => 'mb-1')
        );

        echo html_writer::tag('small',
            "👥 {$enrolled} estudiantes inscritos",
            array('class' => 'text-muted')
        );

        echo html_writer::end_tag('div');
    }

    echo html_writer::end_tag('div');
}

// FOREACH con clave => valor
echo html_writer::tag('h4', 'Propiedades del usuario actual:', array('class' => 'mt-4'));

$user_properties = array(
    'ID' => $USER->id,
    'Usuario' => $USER->username,
    'Nombre' => $USER->firstname,
    'Apellido' => $USER->lastname,
    'Email' => $USER->email,
    'Idioma' => $USER->lang,
    'País' => $USER->country
);

echo html_writer::start_tag('table', array('class' => 'table table-bordered'));

foreach ($user_properties as $key => $value) {
    echo html_writer::start_tag('tr');
    echo html_writer::tag('th', $key, array('class' => 'w-25'));
    echo html_writer::tag('td', $value);
    echo html_writer::end_tag('tr');
}

echo html_writer::end_tag('table');

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 6. ESTRUCTURAS ANIDADAS
// ============================================
echo html_writer::tag('h2', '6. Estructuras Anidadas');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

echo html_writer::tag('h4', 'Cursos por categoría:');

// Obtener primeras 3 categorías
$categories = $DB->get_records('course_categories', null, 'name ASC', '*', 0, 3);

foreach ($categories as $category) {
    echo html_writer::tag('h5', "📁 " . $category->name);

    // Obtener cursos de esta categoría
    $category_courses = $DB->get_records('course',
        array('category' => $category->id),
        'fullname ASC',
        '*',
        0,
        5
    );

    if (!empty($category_courses)) {
        echo html_writer::start_tag('ul');

        foreach ($category_courses as $course) {
            // Verificar si el usuario puede ver este curso
            $context_course = context_course::instance($course->id);
            $can_view = has_capability('moodle/course:view', $context_course);

            if ($can_view) {
                echo html_writer::tag('li',
                    "✓ {$course->fullname}",
                    array('class' => 'text-success')
                );
            } else {
                echo html_writer::tag('li',
                    "🔒 {$course->fullname} (No tienes acceso)",
                    array('class' => 'text-muted')
                );
            }
        }

        echo html_writer::end_tag('ul');
    } else {
        echo html_writer::tag('p',
            'No hay cursos en esta categoría.',
            array('class' => 'text-muted ml-3')
        );
    }

    echo html_writer::tag('hr', '');
}

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// BUENAS PRÁCTICAS
// ============================================
echo html_writer::start_tag('div', array('class' => 'alert alert-info'));
echo html_writer::tag('h4', 'Buenas Prácticas con Estructuras de Control:');
echo html_writer::start_tag('ol');
echo html_writer::tag('li', '<strong>FOREACH:</strong> Preferido para arrays y resultados de BD');
echo html_writer::tag('li', '<strong>FOR:</strong> Cuando necesitas un contador específico');
echo html_writer::tag('li', '<strong>WHILE:</strong> Para condiciones dinámicas');
echo html_writer::tag('li', '<strong>Switch:</strong> Para múltiples valores de una misma variable');
echo html_writer::tag('li', '<strong>Usar break/continue:</strong> Para controlar el flujo de bucles');
echo html_writer::tag('li', '<strong>Evitar anidaciones profundas:</strong> Máximo 3 niveles');
echo html_writer::end_tag('ol');
echo html_writer::end_tag('div');

echo $OUTPUT->footer();

/**
 * NOTAS IMPORTANTES:
 *
 * 1. FOREACH es el más usado en Moodle para recorrer resultados de BD
 * 2. Siempre validar que los arrays no estén vacíos antes de iterar
 * 3. Usar continue para saltar iteraciones
 * 4. Usar break para salir completamente del bucle
 * 5. Evitar bucles infinitos en WHILE
 *
 * EJERCICIOS:
 *
 * 1. Crea un bucle que muestre los últimos 5 login del usuario
 * 2. Usa switch para mostrar diferentes mensajes según el mes actual
 * 3. Crea una tabla con foreach que liste todos los roles del sistema
 * 4. Implementa un sistema de paginación simple con FOR
 */
