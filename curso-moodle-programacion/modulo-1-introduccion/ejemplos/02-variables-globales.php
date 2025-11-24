<?php
/**
 * EJEMPLO 2: Variables Globales en Moodle
 *
 * Moodle utiliza varias variables globales importantes que debes conocer.
 * Este ejemplo muestra las más comunes y cómo usarlas.
 *
 * UBICACIÓN: /moodle/local/holamundo/variables.php
 */

require_once('../../config.php');
require_login();

$context = context_system::instance();
$PAGE->set_context($context);
$PAGE->set_url(new moodle_url('/local/holamundo/variables.php'));
$PAGE->set_pagelayout('standard');
$PAGE->set_title('Variables Globales de Moodle');
$PAGE->set_heading('Conociendo las Variables Globales');

echo $OUTPUT->header();

// ============================================
// 1. $CFG - Configuración Global
// ============================================
echo html_writer::tag('h2', '1. Variable $CFG (Configuración)');
echo html_writer::tag('p', 'Contiene toda la configuración de Moodle.');

global $CFG; // Declarar como global para usarla

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));
echo html_writer::tag('pre',
    "URL del sitio: {$CFG->wwwroot}\n" .
    "Directorio de datos: {$CFG->dataroot}\n" .
    "Versión de Moodle: {$CFG->version}\n" .
    "Base de datos: {$CFG->dbtype}\n" .
    "Prefijo de tablas: {$CFG->prefix}"
);
echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 2. $USER - Usuario Actual
// ============================================
echo html_writer::tag('h2', '2. Variable $USER (Usuario Actual)');
echo html_writer::tag('p', 'Contiene información del usuario que está navegando.');

global $USER;

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));
echo html_writer::tag('pre',
    "ID: {$USER->id}\n" .
    "Usuario: {$USER->username}\n" .
    "Nombre: {$USER->firstname} {$USER->lastname}\n" .
    "Email: {$USER->email}\n" .
    "Idioma: {$USER->lang}\n" .
    "Última conexión: " . date('Y-m-d H:i:s', $USER->lastlogin)
);
echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 3. $DB - Objeto de Base de Datos
// ============================================
echo html_writer::tag('h2', '3. Variable $DB (Base de Datos)');
echo html_writer::tag('p', 'Objeto para interactuar con la base de datos.');

global $DB;

// Contar usuarios
$user_count = $DB->count_records('user', array('deleted' => 0));

// Contar cursos
$course_count = $DB->count_records('course');

// Obtener nombre de la base de datos
$db_name = $CFG->dbname;

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));
echo html_writer::tag('pre',
    "Base de datos: {$db_name}\n" .
    "Total de usuarios: {$user_count}\n" .
    "Total de cursos: {$course_count}"
);
echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 4. $PAGE - Configuración de Página
// ============================================
echo html_writer::tag('h2', '4. Variable $PAGE (Página Actual)');
echo html_writer::tag('p', 'Controla la configuración de la página actual.');

global $PAGE;

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));
echo html_writer::tag('pre',
    "URL: {$PAGE->url}\n" .
    "Título: {$PAGE->title}\n" .
    "Layout: {$PAGE->pagelayout}\n" .
    "Contexto: " . get_class($PAGE->context)
);
echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 5. $OUTPUT - Generador de HTML
// ============================================
echo html_writer::tag('h2', '5. Variable $OUTPUT (Renderizador)');
echo html_writer::tag('p', 'Genera HTML consistente con el tema actual.');

global $OUTPUT;

// Ejemplos de uso de $OUTPUT
echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

// Icono de ayuda
echo html_writer::tag('p', 'Icono de ayuda: ' . $OUTPUT->help_icon('moodledocs'));

// Icono de información
echo html_writer::tag('p', 'Icono: ' . $OUTPUT->pix_icon('i/info', 'Información'));

// Botón
$url = new moodle_url('/');
echo $OUTPUT->single_button($url, 'Botón de ejemplo', 'get');

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// 6. $COURSE - Curso Actual
// ============================================
echo html_writer::tag('h2', '6. Variable $COURSE (Curso Actual)');
echo html_writer::tag('p', 'Contiene información del curso actual (si estás en uno).');

global $COURSE;

echo html_writer::start_tag('div', array('class' => 'card mb-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));

if ($COURSE->id == SITEID) {
    echo html_writer::tag('p', 'No estás en un curso específico (estás en la página principal).');
    echo html_writer::tag('pre', "ID del sitio: " . SITEID);
} else {
    echo html_writer::tag('pre',
        "ID del curso: {$COURSE->id}\n" .
        "Nombre: {$COURSE->fullname}\n" .
        "Nombre corto: {$COURSE->shortname}\n" .
        "Categoría: {$COURSE->category}"
    );
}

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// ============================================
// EJEMPLO PRÁCTICO: Usar variables juntas
// ============================================
echo html_writer::tag('h2', 'Ejemplo Práctico Completo');

echo html_writer::start_tag('div', array('class' => 'alert alert-success'));

// Crear un mensaje personalizado usando varias variables globales
$mensaje = "Hola {$USER->firstname}, bienvenido a Moodle {$CFG->version}. ";
$mensaje .= "Actualmente hay {$user_count} usuarios y {$course_count} cursos en el sitio.";

echo html_writer::tag('p', $mensaje);

// Mostrar avatar del usuario usando $OUTPUT
echo html_writer::tag('div', $OUTPUT->user_picture($USER, array('size' => 50)));

echo html_writer::end_tag('div');

echo $OUTPUT->footer();

/**
 * RESUMEN DE VARIABLES GLOBALES:
 *
 * $CFG    - Configuración del sitio (config.php)
 * $USER   - Usuario actual autenticado
 * $DB     - Objeto para consultas de base de datos
 * $PAGE   - Configuración de la página actual
 * $OUTPUT - Renderizador de HTML/temas
 * $COURSE - Curso actual (si aplica)
 * $SESSION - Datos de sesión del usuario
 *
 * IMPORTANTE:
 * - SIEMPRE declarar como 'global' antes de usar dentro de funciones
 * - NO modificar $CFG directamente, usar set_config()
 * - NO modificar $USER directamente, excepto en casos muy específicos
 *
 * EJERCICIO:
 * 1. Crea este archivo y visualiza todas las variables
 * 2. Agrega más campos de $USER que quieras mostrar
 * 3. Investiga qué otras propiedades tiene $CFG
 * 4. Intenta mostrar información de tus cursos
 */
