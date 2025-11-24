<?php
/**
 * EJEMPLO 3: Consultas SQL Avanzadas
 *
 * Este ejemplo muestra consultas SQL complejas usando:
 * - get_records_sql() / get_record_sql()
 * - JOINs
 * - Agregaciones (COUNT, SUM, AVG, etc.)
 * - Subqueries
 * - GROUP BY, HAVING
 *
 * UBICACIÓN: /local/holamundo/db_sql_avanzado.php
 */

require_once('../../config.php');
require_login();

$context = context_system::instance();
$PAGE->set_context($context);
$PAGE->set_url(new moodle_url('/local/holamundo/db_sql_avanzado.php'));
$PAGE->set_pagelayout('standard');
$PAGE->set_title('SQL Avanzado');
$PAGE->set_heading('Consultas SQL Complejas');

echo $OUTPUT->header();

global $DB, $USER;

// ============================================
// 1. JOINs - UNIR TABLAS
// ============================================
echo html_writer::tag('h2', '1. JOINs - Unir múltiples tablas');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

echo html_writer::tag('h4', 'Usuarios con sus roles:');

// SQL con JOIN
$sql = "SELECT u.id, u.username, u.firstname, u.lastname, r.shortname as role_name
        FROM {user} u
        JOIN {role_assignments} ra ON ra.userid = u.id
        JOIN {role} r ON r.id = ra.roleid
        JOIN {context} ctx ON ctx.id = ra.contextid
        WHERE u.deleted = 0
        AND ctx.contextlevel = :contextlevel
        GROUP BY u.id, u.username, u.firstname, u.lastname, r.shortname
        ORDER BY u.lastname ASC
        LIMIT 10";

$params = array('contextlevel' => CONTEXT_SYSTEM);
$users_with_roles = $DB->get_records_sql($sql, $params);

if (!empty($users_with_roles)) {
    echo html_writer::start_tag('table', array('class' => 'table table-sm table-striped'));
    echo html_writer::start_tag('thead');
    echo html_writer::tag('tr',
        html_writer::tag('th', 'ID') .
        html_writer::tag('th', 'Usuario') .
        html_writer::tag('th', 'Nombre') .
        html_writer::tag('th', 'Rol')
    );
    echo html_writer::end_tag('thead');
    echo html_writer::start_tag('tbody');

    foreach ($users_with_roles as $user) {
        echo html_writer::start_tag('tr');
        echo html_writer::tag('td', $user->id);
        echo html_writer::tag('td', $user->username);
        echo html_writer::tag('td', "{$user->firstname} {$user->lastname}");
        echo html_writer::tag('td', $user->role_name);
        echo html_writer::end_tag('tr');
    }

    echo html_writer::end_tag('tbody');
    echo html_writer::end_tag('table');
}

echo html_writer::tag('div',
    "<strong>Explicación del JOIN:</strong><br>" .
    "• <code>{user}</code> - Tabla de usuarios<br>" .
    "• <code>{role_assignments}</code> - Asignaciones de roles<br>" .
    "• <code>{role}</code> - Definición de roles<br>" .
    "• <code>{context}</code> - Contextos donde se asignan roles<br>" .
    "Se unen todas para obtener usuario + rol asignado",
    array('class' => 'alert alert-info mt-3')
);

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 2. AGREGACIONES - COUNT, SUM, AVG, MAX, MIN
// ============================================
echo html_writer::tag('h2', '2. Agregaciones - COUNT, SUM, AVG, etc.');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

echo html_writer::tag('h4', 'Estadísticas generales:');

// Múltiples agregaciones en una consulta
$sql = "SELECT
            COUNT(*) as total_users,
            COUNT(CASE WHEN suspended = 0 THEN 1 END) as active_users,
            COUNT(CASE WHEN suspended = 1 THEN 1 END) as suspended_users,
            MAX(timecreated) as newest_user_time,
            MIN(timecreated) as oldest_user_time
        FROM {user}
        WHERE deleted = 0";

$stats = $DB->get_record_sql($sql);

echo html_writer::start_tag('table', array('class' => 'table table-bordered'));

echo html_writer::start_tag('tr');
echo html_writer::tag('th', 'Total de usuarios');
echo html_writer::tag('td', "<strong>{$stats->total_users}</strong>");
echo html_writer::end_tag('tr');

echo html_writer::start_tag('tr');
echo html_writer::tag('th', 'Usuarios activos');
echo html_writer::tag('td', "<strong>{$stats->active_users}</strong>");
echo html_writer::end_tag('tr');

echo html_writer::start_tag('tr');
echo html_writer::tag('th', 'Usuarios suspendidos');
echo html_writer::tag('td', "<strong>{$stats->suspended_users}</strong>");
echo html_writer::end_tag('tr');

echo html_writer::start_tag('tr');
echo html_writer::tag('th', 'Usuario más reciente');
echo html_writer::tag('td', userdate($stats->newest_user_time));
echo html_writer::end_tag('tr');

echo html_writer::start_tag('tr');
echo html_writer::tag('th', 'Usuario más antiguo');
echo html_writer::tag('td', userdate($stats->oldest_user_time));
echo html_writer::end_tag('tr');

echo html_writer::end_tag('table');

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 3. GROUP BY - AGRUPAR DATOS
// ============================================
echo html_writer::tag('h2', '3. GROUP BY - Agrupar y contar');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

echo html_writer::tag('h4', 'Cursos por categoría:');

// Agrupar cursos por categoría
$sql = "SELECT cat.id, cat.name, COUNT(c.id) as course_count
        FROM {course_categories} cat
        LEFT JOIN {course} c ON c.category = cat.id
        GROUP BY cat.id, cat.name
        HAVING COUNT(c.id) > 0
        ORDER BY course_count DESC, cat.name ASC
        LIMIT 10";

$category_stats = $DB->get_records_sql($sql);

if (!empty($category_stats)) {
    echo html_writer::start_tag('table', array('class' => 'table table-sm'));
    echo html_writer::start_tag('thead', array('class' => 'thead-light'));
    echo html_writer::tag('tr',
        html_writer::tag('th', 'Categoría') .
        html_writer::tag('th', 'Cantidad de Cursos') .
        html_writer::tag('th', 'Gráfico')
    );
    echo html_writer::end_tag('thead');
    echo html_writer::start_tag('tbody');

    $max_count = reset($category_stats)->course_count;

    foreach ($category_stats as $cat) {
        $percentage = ($cat->course_count / $max_count) * 100;
        $bar_width = max(10, $percentage); // Mínimo 10%

        echo html_writer::start_tag('tr');
        echo html_writer::tag('td', $cat->name);
        echo html_writer::tag('td', "<strong>{$cat->course_count}</strong>");
        echo html_writer::tag('td',
            "<div class='progress' style='width: {$bar_width}%;'>" .
            "<div class='progress-bar bg-primary' style='width: 100%;'></div>" .
            "</div>"
        );
        echo html_writer::end_tag('tr');
    }

    echo html_writer::end_tag('tbody');
    echo html_writer::end_tag('table');
} else {
    echo html_writer::tag('p', 'No hay cursos en categorías.', array('class' => 'text-muted'));
}

echo html_writer::tag('div',
    "<strong>GROUP BY con HAVING:</strong><br>" .
    "• <code>GROUP BY</code> agrupa registros<br>" .
    "• <code>HAVING</code> filtra grupos (como WHERE pero para grupos)<br>" .
    "• <code>LEFT JOIN</code> incluye categorías sin cursos (luego filtradas con HAVING)",
    array('class' => 'alert alert-info mt-3')
);

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 4. SUBQUERIES - CONSULTAS ANIDADAS
// ============================================
echo html_writer::tag('h2', '4. Subqueries - Consultas anidadas');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

echo html_writer::tag('h4', 'Usuarios más activos (con más de X accesos):');

// Subquery para encontrar usuarios con muchos logs
$sql = "SELECT u.id, u.username, u.firstname, u.lastname, u.lastlogin,
               (SELECT COUNT(*) FROM {logstore_standard_log} WHERE userid = u.id) as log_count
        FROM {user} u
        WHERE u.deleted = 0
        AND u.lastlogin > 0
        ORDER BY u.lastlogin DESC
        LIMIT 10";

$active_users = $DB->get_records_sql($sql);

if (!empty($active_users)) {
    echo html_writer::start_tag('table', array('class' => 'table table-sm'));
    echo html_writer::start_tag('thead');
    echo html_writer::tag('tr',
        html_writer::tag('th', 'Usuario') .
        html_writer::tag('th', 'Nombre') .
        html_writer::tag('th', 'Último acceso') .
        html_writer::tag('th', 'Eventos registrados')
    );
    echo html_writer::end_tag('thead');
    echo html_writer::start_tag('tbody');

    foreach ($active_users as $user) {
        $dias_desde = floor((time() - $user->lastlogin) / 86400);
        $tiempo_texto = $dias_desde == 0 ? 'Hoy' : "Hace {$dias_desde} día(s)";

        echo html_writer::start_tag('tr');
        echo html_writer::tag('td', $user->username);
        echo html_writer::tag('td', "{$user->firstname} {$user->lastname}");
        echo html_writer::tag('td', $tiempo_texto);
        echo html_writer::tag('td', number_format($user->log_count));
        echo html_writer::end_tag('tr');
    }

    echo html_writer::end_tag('tbody');
    echo html_writer::end_tag('table');
}

echo html_writer::tag('div',
    "<strong>Subquery en SELECT:</strong><br>" .
    "La subconsulta <code>(SELECT COUNT(*) FROM {logstore_standard_log} WHERE userid = u.id)</code> " .
    "se ejecuta para cada fila, calculando el total de logs por usuario.",
    array('class' => 'alert alert-info mt-3')
);

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 5. CASE WHEN - LÓGICA CONDICIONAL EN SQL
// ============================================
echo html_writer::tag('h2', '5. CASE WHEN - Lógica condicional');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

echo html_writer::tag('h4', 'Clasificar usuarios por actividad:');

// Clasificación con CASE WHEN
$sql = "SELECT id, username, firstname, lastname, lastlogin,
            CASE
                WHEN lastlogin > :very_recent THEN 'Muy Activo'
                WHEN lastlogin > :recent THEN 'Activo'
                WHEN lastlogin > :old THEN 'Poco Activo'
                ELSE 'Inactivo'
            END as activity_level
        FROM {user}
        WHERE deleted = 0 AND lastlogin > 0
        ORDER BY lastlogin DESC
        LIMIT 15";

$params = array(
    'very_recent' => time() - (24 * 60 * 60),      // 1 día
    'recent' => time() - (7 * 24 * 60 * 60),       // 7 días
    'old' => time() - (30 * 24 * 60 * 60)          // 30 días
);

$classified_users = $DB->get_records_sql($sql, $params);

if (!empty($classified_users)) {
    echo html_writer::start_tag('table', array('class' => 'table table-sm'));
    echo html_writer::start_tag('thead');
    echo html_writer::tag('tr',
        html_writer::tag('th', 'Usuario') .
        html_writer::tag('th', 'Nombre') .
        html_writer::tag('th', 'Nivel de Actividad')
    );
    echo html_writer::end_tag('thead');
    echo html_writer::start_tag('tbody');

    foreach ($classified_users as $user) {
        // Color según nivel
        $colors = array(
            'Muy Activo' => 'success',
            'Activo' => 'primary',
            'Poco Activo' => 'warning',
            'Inactivo' => 'danger'
        );

        $badge_color = $colors[$user->activity_level] ?? 'secondary';

        echo html_writer::start_tag('tr');
        echo html_writer::tag('td', $user->username);
        echo html_writer::tag('td', "{$user->firstname} {$user->lastname}");
        echo html_writer::tag('td',
            "<span class='badge badge-{$badge_color}'>{$user->activity_level}</span>"
        );
        echo html_writer::end_tag('tr');
    }

    echo html_writer::end_tag('tbody');
    echo html_writer::end_tag('table');
}

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 6. UNION - COMBINAR RESULTADOS
// ============================================
echo html_writer::tag('h2', '6. UNION - Combinar consultas');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

echo html_writer::tag('h4', 'Timeline de actividad (usuarios y cursos):');

// UNION de dos consultas
$sql = "SELECT id, username as name, 'Usuario' as type, timecreated
        FROM {user}
        WHERE deleted = 0
        UNION
        SELECT id, fullname as name, 'Curso' as type, timecreated
        FROM {course}
        WHERE id != :siteid
        ORDER BY timecreated DESC
        LIMIT 10";

$timeline = $DB->get_records_sql($sql, array('siteid' => SITEID));

if (!empty($timeline)) {
    echo html_writer::start_tag('div', array('class' => 'list-group'));

    foreach ($timeline as $item) {
        $icon = $item->type == 'Usuario' ? '👤' : '📚';
        $badge_class = $item->type == 'Usuario' ? 'badge-primary' : 'badge-success';

        echo html_writer::start_tag('div', array('class' => 'list-group-item'));
        echo html_writer::tag('div',
            "{$icon} <strong>{$item->name}</strong> " .
            "<span class='badge {$badge_class}'>{$item->type}</span>",
            array('class' => 'mb-1')
        );
        echo html_writer::tag('small',
            'Creado: ' . userdate($item->timecreated),
            array('class' => 'text-muted')
        );
        echo html_writer::end_tag('div');
    }

    echo html_writer::end_tag('div');
}

echo html_writer::tag('div',
    "<strong>UNION vs UNION ALL:</strong><br>" .
    "• <code>UNION</code> - Elimina duplicados (más lento)<br>" .
    "• <code>UNION ALL</code> - Mantiene todos los resultados (más rápido)<br>" .
    "Las columnas deben coincidir en número y tipo",
    array('class' => 'alert alert-info mt-3')
);

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 7. WITH (CTE) - Common Table Expressions
// ============================================
echo html_writer::tag('h2', '7. WITH (CTE) - Consultas temporales');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

echo html_writer::tag('h4', 'Usando Common Table Expressions (PostgreSQL/MySQL 8.0+):');

// WITH CTE (no todos los motores lo soportan)
echo html_writer::tag('pre',
    "-- Ejemplo de WITH (CTE)\n" .
    "WITH active_users AS (\n" .
    "    SELECT id, username, lastlogin\n" .
    "    FROM {user}\n" .
    "    WHERE lastlogin > " . (time() - 7*24*60*60) . "\n" .
    "    AND deleted = 0\n" .
    "),\n" .
    "user_courses AS (\n" .
    "    SELECT ue.userid, COUNT(*) as course_count\n" .
    "    FROM {user_enrolments} ue\n" .
    "    GROUP BY ue.userid\n" .
    ")\n" .
    "SELECT au.username, uc.course_count\n" .
    "FROM active_users au\n" .
    "LEFT JOIN user_courses uc ON uc.userid = au.id\n" .
    "ORDER BY uc.course_count DESC;"
);

echo html_writer::tag('div',
    "⚠️ <strong>Nota:</strong> CTEs no están disponibles en todas las versiones de MySQL. " .
    "Requiere MySQL 8.0+ o PostgreSQL. Verifica tu versión antes de usar.",
    array('class' => 'alert alert-warning')
);

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 8. OPTIMIZACIÓN DE CONSULTAS
// ============================================
echo html_writer::tag('h2', '8. Optimización y Debugging');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

echo html_writer::tag('h4', 'Tips de Optimización:');

echo html_writer::tag('div',
    "<strong>1. Usar EXPLAIN para analizar consultas:</strong><br>" .
    "<code>EXPLAIN SELECT * FROM {user} WHERE username = 'admin';</code><br><br>" .
    "<strong>2. Seleccionar solo campos necesarios:</strong><br>" .
    "✓ <code>SELECT id, username FROM {user}</code><br>" .
    "✗ <code>SELECT * FROM {user}</code><br><br>" .
    "<strong>3. Usar índices correctamente:</strong><br>" .
    "• Filtrar por campos indexados (id, username, email)<br>" .
    "• Evitar funciones en WHERE (degrada índices)<br><br>" .
    "<strong>4. Limitar resultados:</strong><br>" .
    "Siempre usar LIMIT cuando sea posible<br><br>" .
    "<strong>5. Evitar N+1 queries:</strong><br>" .
    "Usar JOIN en lugar de bucles con queries",
    array('class' => 'alert alert-success')
);

// Activar debugging (solo para desarrollo)
echo html_writer::tag('h5', 'Debugging de consultas:', array('class' => 'mt-3'));

echo html_writer::tag('pre',
    "// Activar debug\n" .
    "\$DB->set_debug(true);\n\n" .
    "// Tu consulta\n" .
    "\$users = \$DB->get_records('user', array('deleted' => 0));\n\n" .
    "// Desactivar debug\n" .
    "\$DB->set_debug(false);\n\n" .
    "// Esto imprimirá el SQL real ejecutado"
);

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// BUENAS PRÁCTICAS
// ============================================
echo html_writer::start_tag('div', array('class' => 'alert alert-primary'));
echo html_writer::tag('h4', 'Buenas Prácticas SQL Avanzado:');
echo html_writer::start_tag('ol');
echo html_writer::tag('li', '<strong>Usar placeholders:</strong> Siempre :named o ? para parámetros');
echo html_writer::tag('li', '<strong>Prefijos de tabla:</strong> Usar {table_name} en lugar de mdl_table_name');
echo html_writer::tag('li', '<strong>JOINs apropiados:</strong> LEFT JOIN cuando puede no haber match, INNER JOIN cuando debe');
echo html_writer::tag('li', '<strong>Ordenar en SQL:</strong> ORDER BY en SQL es más eficiente que ordenar en PHP');
echo html_writer::tag('li', '<strong>Limitar en SQL:</strong> LIMIT en SQL es más eficiente que array_slice() en PHP');
echo html_writer::tag('li', '<strong>Testear queries:</strong> Probar SQL en phpMyAdmin/Adminer primero');
echo html_writer::tag('li', '<strong>Comentar queries complejos:</strong> Explicar qué hace cada parte');
echo html_writer::end_tag('ol');
echo html_writer::end_tag('div');

echo $OUTPUT->footer();

/**
 * RESUMEN DE SQL AVANZADO:
 *
 * JOINS:
 * - INNER JOIN - Solo coincidencias
 * - LEFT JOIN - Todas de la izquierda + coincidencias
 * - RIGHT JOIN - Todas de la derecha + coincidencias
 *
 * AGREGACIONES:
 * - COUNT, SUM, AVG, MAX, MIN
 * - GROUP BY para agrupar
 * - HAVING para filtrar grupos
 *
 * SUBQUERIES:
 * - En SELECT (columna calculada)
 * - En WHERE (filtro dinámico)
 * - En FROM (tabla temporal)
 *
 * AVANZADO:
 * - CASE WHEN (lógica condicional)
 * - UNION/UNION ALL (combinar resultados)
 * - WITH (CTE) - Solo en MySQL 8.0+/PostgreSQL
 *
 * EJERCICIOS:
 *
 * 1. Crea una consulta que muestre usuarios con sus cursos inscritos (JOIN)
 * 2. Obtén el promedio de calificaciones por curso (AVG + GROUP BY)
 * 3. Encuentra cursos sin estudiantes inscritos (subquery o LEFT JOIN)
 * 4. Clasifica cursos por tamaño (0-10, 11-50, 51+) usando CASE WHEN
 * 5. Crea un reporte combinando datos de múltiples tablas
 */
