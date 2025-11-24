<?php
/**
 * EJEMPLO 2: Insertar, Actualizar y Eliminar Registros
 *
 * Este ejemplo muestra las operaciones de escritura en la BD:
 * - INSERT (insert_record, insert_records)
 * - UPDATE (update_record, set_field)
 * - DELETE (delete_records)
 *
 * IMPORTANTE: Este archivo es solo demostrativo.
 * En producción, NUNCA modifiques tablas core sin un buen motivo.
 *
 * UBICACIÓN: /local/holamundo/db_escritura.php
 */

require_once('../../config.php');
require_login();
require_capability('moodle/site:config', context_system::instance());

$context = context_system::instance();
$PAGE->set_context($context);
$PAGE->set_url(new moodle_url('/local/holamundo/db_escritura.php'));
$PAGE->set_pagelayout('standard');
$PAGE->set_title('Operaciones de Escritura - $DB');
$PAGE->set_heading('INSERT, UPDATE, DELETE');

echo $OUTPUT->header();

global $DB;

// Para este ejemplo, vamos a crear una tabla temporal de demostración
// En la práctica, esto se haría con XMLDB (lo veremos más adelante)

echo html_writer::tag('div',
    '<strong>NOTA:</strong> Este ejemplo usa una tabla personalizada de demostración. ' .
    'En producción, siempre usa las APIs de Moodle para modificar datos del core.',
    array('class' => 'alert alert-warning')
);

// ============================================
// 1. insert_record() - INSERTAR UN REGISTRO
// ============================================
echo html_writer::tag('h2', '1. insert_record() - Insertar un registro');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

echo html_writer::tag('h4', 'Ejemplo de estructura para insertar:');

// Crear objeto con los datos
$new_record = new stdClass();
$new_record->name = 'Ejemplo de registro';
$new_record->description = 'Este es un registro de ejemplo';
$new_record->timecreated = time();
$new_record->timemodified = time();

// Mostrar estructura
echo html_writer::tag('pre',
    "stdClass Object\n" .
    "(\n" .
    "    [name] => {$new_record->name}\n" .
    "    [description] => {$new_record->description}\n" .
    "    [timecreated] => {$new_record->timecreated}\n" .
    "    [timemodified] => {$new_record->timemodified}\n" .
    ")"
);

// NOTA: En este ejemplo NO ejecutaremos el INSERT real
// porque requeriría una tabla personalizada

echo html_writer::tag('div',
    "<strong>Código para insertar:</strong><br>" .
    "<code>\$id = \$DB->insert_record('mi_tabla', \$new_record);</code><br><br>" .
    "Esto retornaría el ID del nuevo registro.",
    array('class' => 'alert alert-info')
);

// Ejemplo práctico: Insertar preferencia de usuario
echo html_writer::tag('h4', 'Ejemplo real: Guardar preferencia de usuario', array('class' => 'mt-4'));

$preference = new stdClass();
$preference->userid = $USER->id;
$preference->name = 'demo_preference';
$preference->value = 'valor_ejemplo';

// En la práctica, usa set_user_preference() en lugar de insert directo
set_user_preference('demo_preference', 'Mi valor personalizado');

echo html_writer::tag('p',
    "✓ Preferencia guardada usando <code>set_user_preference()</code>"
);

// Leer la preferencia
$saved_value = get_user_preference('demo_preference', 'valor por defecto');
echo html_writer::tag('p', "Valor guardado: <strong>{$saved_value}</strong>");

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 2. insert_records() - INSERTAR MÚLTIPLES
// ============================================
echo html_writer::tag('h2', '2. insert_records() - Insertar múltiples registros');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

echo html_writer::tag('h4', 'Inserción masiva (más eficiente):');

// Crear array de registros
$records = array();

for ($i = 1; $i <= 5; $i++) {
    $record = new stdClass();
    $record->name = "Item {$i}";
    $record->value = $i * 10;
    $record->timecreated = time();

    $records[] = $record;
}

// Mostrar lo que se insertaría
echo html_writer::tag('p', 'Registros a insertar:');
echo html_writer::start_tag('table', array('class' => 'table table-sm'));
echo html_writer::start_tag('thead');
echo html_writer::tag('tr',
    html_writer::tag('th', '#') .
    html_writer::tag('th', 'Name') .
    html_writer::tag('th', 'Value')
);
echo html_writer::end_tag('thead');
echo html_writer::start_tag('tbody');

foreach ($records as $index => $record) {
    echo html_writer::start_tag('tr');
    echo html_writer::tag('td', $index + 1);
    echo html_writer::tag('td', $record->name);
    echo html_writer::tag('td', $record->value);
    echo html_writer::end_tag('tr');
}

echo html_writer::end_tag('tbody');
echo html_writer::end_tag('table');

echo html_writer::tag('div',
    "<strong>Código:</strong><br>" .
    "<code>\$DB->insert_records('mi_tabla', \$records);</code><br><br>" .
    "Esto insertan todos los registros en una sola operación (más eficiente).",
    array('class' => 'alert alert-info')
);

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 3. update_record() - ACTUALIZAR REGISTRO
// ============================================
echo html_writer::tag('h2', '3. update_record() - Actualizar un registro');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

echo html_writer::tag('h4', 'Actualizar información del usuario:');

// Obtener usuario actual
$user = $DB->get_record('user', array('id' => $USER->id), '*', MUST_EXIST);

echo html_writer::tag('p', "Ciudad actual: <strong>" . ($user->city ?: 'No especificada') . "</strong>");

// Modificar datos
$updated_user = new stdClass();
$updated_user->id = $user->id; // IMPORTANTE: Debe incluir el ID
$updated_user->city = 'Ciudad de México'; // Nuevo valor
$updated_user->country = 'MX';
$updated_user->timemodified = time();

echo html_writer::tag('div',
    "<strong>Código para actualizar:</strong><br>" .
    "<code>\$DB->update_record('user', \$updated_user);</code><br><br>" .
    "IMPORTANTE: El objeto debe tener el campo 'id'<br>" .
    "Solo se actualizarán los campos incluidos en el objeto.",
    array('class' => 'alert alert-info')
);

// Ejemplo de actualización completa
echo html_writer::tag('h4', 'Patrón completo Get-Modify-Update:', array('class' => 'mt-4'));

echo html_writer::tag('pre',
    "// 1. Obtener el registro\n" .
    "\$record = \$DB->get_record('tabla', array('id' => \$id), '*', MUST_EXIST);\n\n" .
    "// 2. Modificar\n" .
    "\$record->campo1 = 'nuevo valor';\n" .
    "\$record->campo2 = 123;\n" .
    "\$record->timemodified = time();\n\n" .
    "// 3. Guardar\n" .
    "\$DB->update_record('tabla', \$record);"
);

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 4. set_field() - ACTUALIZAR UN CAMPO
// ============================================
echo html_writer::tag('h2', '4. set_field() - Actualizar un solo campo');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

echo html_writer::tag('h4', 'Actualizar un campo específico (más eficiente):');

echo html_writer::tag('p',
    "Si solo necesitas actualizar UN campo, <code>set_field()</code> es más eficiente " .
    "que <code>update_record()</code>."
);

// Ejemplos de uso
echo html_writer::tag('h5', 'Ejemplos:');
echo html_writer::tag('pre',
    "// Suspender un usuario\n" .
    "\$DB->set_field('user', 'suspended', 1, array('id' => \$userid));\n\n" .
    "// Hacer curso invisible\n" .
    "\$DB->set_field('course', 'visible', 0, array('id' => \$courseid));\n\n" .
    "// Actualizar descripción de categoría\n" .
    "\$DB->set_field('course_categories', 'description', 'Nueva desc', array('id' => \$catid));\n\n" .
    "// Con múltiples condiciones\n" .
    "\$DB->set_field('course', 'visible', 0, array('category' => 5, 'visible' => 1));"
);

echo html_writer::tag('div',
    "<strong>Ventajas de set_field():</strong><br>" .
    "• Más rápido para un solo campo<br>" .
    "• Menos memoria usada<br>" .
    "• Código más limpio<br>" .
    "• No necesita obtener el registro completo primero",
    array('class' => 'alert alert-success')
);

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 5. delete_records() - ELIMINAR REGISTROS
// ============================================
echo html_writer::tag('h2', '5. delete_records() - Eliminar registros');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

echo html_writer::tag('h4', 'Eliminar con condiciones:');

echo html_writer::tag('div',
    "⚠️ <strong>PELIGRO:</strong> delete_records() es permanente. " .
    "No hay confirmación ni papelera de reciclaje.",
    array('class' => 'alert alert-danger')
);

echo html_writer::tag('h5', 'Ejemplos de uso:');
echo html_writer::tag('pre',
    "// Eliminar un registro específico\n" .
    "\$DB->delete_records('my_table', array('id' => 123));\n\n" .
    "// Eliminar todas las preferencias de un usuario\n" .
    "\$DB->delete_records('user_preferences', array('userid' => \$userid));\n\n" .
    "// PELIGRO: Sin condiciones elimina TODA la tabla\n" .
    "// \$DB->delete_records('tabla'); // ¡NO HACER!\n\n" .
    "// Eliminar con múltiples condiciones\n" .
    "\$DB->delete_records('course_modules', array(\n" .
    "    'course' => \$courseid,\n" .
    "    'module' => \$moduleid\n" .
    "));"
);

// Ejemplo práctico: Limpiar preferencias antiguas
echo html_writer::tag('h5', 'Ejemplo práctico:', array('class' => 'mt-4'));
echo html_writer::tag('p', 'Eliminar una preferencia específica del usuario actual:');

// Primero verificar si existe
$pref_exists = $DB->record_exists('user_preferences', array(
    'userid' => $USER->id,
    'name' => 'demo_preference'
));

echo html_writer::tag('p',
    "¿Existe la preferencia 'demo_preference'? " . ($pref_exists ? '✓ Sí' : '✗ No')
);

if ($pref_exists) {
    echo html_writer::tag('div',
        "Código para eliminarla:<br>" .
        "<code>unset_user_preference('demo_preference');</code><br>" .
        "O directamente:<br>" .
        "<code>\$DB->delete_records('user_preferences', array('userid' => \$USER->id, 'name' => 'demo_preference'));</code>",
        array('class' => 'alert alert-info')
    );
}

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 6. delete_records_select() - ELIMINAR CON SQL
// ============================================
echo html_writer::tag('h2', '6. delete_records_select() - Eliminar con condiciones SQL');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

echo html_writer::tag('h4', 'Eliminar con condiciones complejas:');

echo html_writer::tag('pre',
    "// Eliminar registros antiguos\n" .
    "\$old_time = time() - (365 * 24 * 60 * 60); // Hace 1 año\n" .
    "\$DB->delete_records_select('log', 'time < ?', array(\$old_time));\n\n" .
    "// Eliminar con múltiples condiciones\n" .
    "\$DB->delete_records_select(\n" .
    "    'user_preferences',\n" .
    "    'name = ? AND value = ?',\n" .
    "    array('theme', 'old_theme')\n" .
    ");\n\n" .
    "// Eliminar con JOIN conceptual\n" .
    "\$DB->delete_records_select(\n" .
    "    'course_modules',\n" .
    "    'course IN (SELECT id FROM {course} WHERE visible = 0)'\n" .
    ");"
);

echo html_writer::tag('div',
    "<strong>Cuándo usar delete_records_select:</strong><br>" .
    "• Condiciones con operadores (&lt;, &gt;, LIKE, IN)<br>" .
    "• Eliminar basado en fechas<br>" .
    "• Limpieza de datos antiguos<br>" .
    "• Mantenimiento de base de datos",
    array('class' => 'alert alert-info')
);

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 7. TRANSACCIONES
// ============================================
echo html_writer::tag('h2', '7. Transacciones - Operaciones Atómicas');

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

echo html_writer::tag('h4', 'Usar transacciones para operaciones relacionadas:');

echo html_writer::tag('p',
    "Una transacción asegura que TODAS las operaciones se completen o NINGUNA. " .
    "Si algo falla, todo se revierte automáticamente."
);

echo html_writer::tag('pre',
    "// Iniciar transacción\n" .
    "\$transaction = \$DB->start_delegated_transaction();\n\n" .
    "try {\n" .
    "    // Operación 1: Crear curso\n" .
    "    \$course = new stdClass();\n" .
    "    \$course->fullname = 'Nuevo Curso';\n" .
    "    \$course->shortname = 'NC001';\n" .
    "    \$course->timecreated = time();\n" .
    "    \$courseid = \$DB->insert_record('course', \$course);\n\n" .
    "    // Operación 2: Crear contexto\n" .
    "    \$context = context_course::instance(\$courseid);\n\n" .
    "    // Operación 3: Asignar rol al creador\n" .
    "    role_assign(3, \$USER->id, \$context->id); // Role 3 = editingteacher\n\n" .
    "    // Si todo salió bien, confirmar\n" .
    "    \$transaction->allow_commit();\n\n" .
    "    echo 'Curso creado exitosamente';\n\n" .
    "} catch (Exception \$e) {\n" .
    "    // Si hay error, se revierte automáticamente\n" .
    "    // No necesitas hacer rollback manual\n" .
    "    echo 'Error: ' . \$e->getMessage();\n" .
    "}"
);

echo html_writer::tag('div',
    "<strong>Cuándo usar transacciones:</strong><br>" .
    "• Operaciones que deben completarse juntas<br>" .
    "• Crear registros en múltiples tablas relacionadas<br>" .
    "• Importar/exportar datos<br>" .
    "• Operaciones financieras o críticas<br>" .
    "• Cualquier operación que no puede quedar a medias",
    array('class' => 'alert alert-success')
);

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// BUENAS PRÁCTICAS
// ============================================
echo html_writer::start_tag('div', array('class' => 'alert alert-warning'));
echo html_writer::tag('h4', 'Buenas Prácticas de Escritura:');
echo html_writer::start_tag('ol');
echo html_writer::tag('li', '<strong>Siempre incluir timemodified:</strong> Al actualizar, actualiza timemodified');
echo html_writer::tag('li', '<strong>Verificar antes de eliminar:</strong> record_exists() antes de delete');
echo html_writer::tag('li', '<strong>Usar transacciones:</strong> Para operaciones relacionadas');
echo html_writer::tag('li', '<strong>Preferir APIs de alto nivel:</strong> No modificar tablas core directamente');
echo html_writer::tag('li', '<strong>set_field() para un campo:</strong> Más eficiente que update_record()');
echo html_writer::tag('li', '<strong>insert_records() para múltiples:</strong> Más rápido que bucles');
echo html_writer::tag('li', '<strong>Validar datos ANTES de insertar:</strong> Prevenir datos corruptos');
echo html_writer::tag('li', '<strong>Log cambios importantes:</strong> Usar events API para auditoría');
echo html_writer::end_tag('ol');
echo html_writer::end_tag('div');

echo html_writer::start_tag('div', array('class' => 'alert alert-danger'));
echo html_writer::tag('h4', 'Qué NO Hacer:');
echo html_writer::start_tag('ul');
echo html_writer::tag('li', '❌ Modificar tablas core sin usar APIs oficiales');
echo html_writer::tag('li', '❌ Eliminar sin verificar dependencias');
echo html_writer::tag('li', '❌ Olvidar actualizar timemodified');
echo html_writer::tag('li', '❌ Insertar datos sin validar');
echo html_writer::tag('li', '❌ Usar delete_records() sin condiciones');
echo html_writer::tag('li', '❌ Múltiples operaciones sin transacción');
echo html_writer::tag('li', '❌ Modificar el ID de un registro');
echo html_writer::end_tag('ul');
echo html_writer::end_tag('div');

echo $OUTPUT->footer();

/**
 * RESUMEN DE FUNCIONES DE ESCRITURA:
 *
 * INSERT:
 * - insert_record(\$table, \$dataobject, \$returnid=true)
 * - insert_records(\$table, \$dataobjects)
 *
 * UPDATE:
 * - update_record(\$table, \$dataobject)
 * - set_field(\$table, \$field, \$value, \$conditions)
 *
 * DELETE:
 * - delete_records(\$table, \$conditions)
 * - delete_records_select(\$table, \$select, \$params)
 *
 * TRANSACCIONES:
 * - start_delegated_transaction()
 * - allow_commit()
 * - rollback automático en excepciones
 *
 * EJERCICIOS:
 *
 * 1. Crea una función que inserte un registro de log personalizado
 * 2. Actualiza la descripción de tu usuario (campo 'description')
 * 3. Implementa una transacción que cree un curso y su categoría
 * 4. Crea una función que limpie preferencias antiguas de usuarios
 * 5. Implementa un sistema de "soft delete" (marcar como eliminado en lugar de borrar)
 */
