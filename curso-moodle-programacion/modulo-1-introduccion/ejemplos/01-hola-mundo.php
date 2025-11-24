<?php
/**
 * EJEMPLO 1: Hola Mundo en Moodle
 *
 * Este es un ejemplo básico que muestra cómo crear una página simple en Moodle.
 * Aprenderás sobre:
 * - Estructura básica de un archivo PHP en Moodle
 * - Configuración inicial (require config.php)
 * - Contexto de página
 * - Output (salida HTML)
 *
 * UBICACIÓN: Guarda este archivo en /moodle/local/holamundo/index.php
 */

// 1. SIEMPRE incluir config.php primero
// Este archivo inicializa Moodle y carga todas las librerías necesarias
require_once('../../config.php');

// 2. Verificar que el usuario esté autenticado
// Esta función redirige al login si el usuario no ha iniciado sesión
require_login();

// 3. Configurar el contexto de la página
// El contexto define dónde está ubicada esta página en Moodle
$context = context_system::instance(); // Contexto del sistema (nivel más alto)

// 4. Configurar la URL de la página
// Esto es importante para que Moodle sepa en qué página estamos
$PAGE->set_context($context);
$PAGE->set_url(new moodle_url('/local/holamundo/index.php'));

// 5. Configurar la presentación de la página
$PAGE->set_pagelayout('standard'); // Layout estándar de Moodle
$PAGE->set_title('Mi Primera Página'); // Título de la pestaña del navegador
$PAGE->set_heading('¡Hola Mundo!'); // Encabezado principal

// 6. Iniciar el output (salida HTML)
// Esto imprime el header de Moodle (menú, navegación, etc.)
echo $OUTPUT->header();

// 7. Contenido personalizado
echo html_writer::start_tag('div', array('class' => 'alert alert-info'));
echo html_writer::tag('h2', '¡Bienvenido a tu primera página en Moodle!');
echo html_writer::tag('p', 'Este es un ejemplo básico de cómo crear una página personalizada.');
echo html_writer::end_tag('div');

// 8. Mostrar información del usuario actual
echo html_writer::start_tag('div', array('class' => 'card mt-3'));
echo html_writer::start_tag('div', array('class' => 'card-body'));
echo html_writer::tag('h3', 'Información del usuario:');

// Acceder a la variable global $USER
global $USER;

echo html_writer::tag('ul',
    html_writer::tag('li', 'Nombre completo: ' . fullname($USER)) .
    html_writer::tag('li', 'Usuario: ' . $USER->username) .
    html_writer::tag('li', 'Email: ' . $USER->email) .
    html_writer::tag('li', 'ID: ' . $USER->id)
);

echo html_writer::end_tag('div');
echo html_writer::end_tag('div');

// 9. Botón de ejemplo
$button_url = new moodle_url('/');
echo html_writer::start_tag('div', array('class' => 'mt-3'));
echo $OUTPUT->single_button($button_url, 'Volver al inicio', 'get', array('class' => 'btn-primary'));
echo html_writer::end_tag('div');

// 10. Finalizar el output
// Esto imprime el footer de Moodle
echo $OUTPUT->footer();

/**
 * NOTAS IMPORTANTES:
 *
 * 1. require_once('../../config.php') SIEMPRE debe ser la primera línea
 * 2. Usar require_login() para proteger páginas
 * 3. $PAGE es el objeto principal para configurar páginas
 * 4. $OUTPUT es el objeto para generar HTML de Moodle
 * 5. html_writer es una clase helper para crear HTML seguro
 * 6. NUNCA escribir HTML directamente, usar las funciones de Moodle
 *
 * EJERCICIO:
 * - Crea este archivo en tu instalación de Moodle
 * - Accede a http://tudominio/moodle/local/holamundo/index.php
 * - Experimenta cambiando el título y el contenido
 */
