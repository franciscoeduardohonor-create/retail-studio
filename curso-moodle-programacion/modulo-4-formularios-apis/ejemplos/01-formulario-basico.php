<?php
/**
 * EJEMPLO 1: Formulario Básico en Moodle
 *
 * Este ejemplo muestra cómo crear un formulario simple con:
 * - Campos de texto
 * - Validación
 * - Procesamiento de datos
 *
 * ESTRUCTURA:
 * - Este archivo (formulario_basico.php) - Muestra y procesa el formulario
 * - formulario_basico_form.php - Define la estructura del formulario
 *
 * UBICACIÓN: /local/holamundo/formulario_basico.php
 */

require_once('../../config.php');
require_once('formulario_basico_form.php');

// Autenticación requerida
require_login();

// Configurar página
$context = context_system::instance();
$PAGE->set_context($context);
$PAGE->set_url(new moodle_url('/local/holamundo/formulario_basico.php'));
$PAGE->set_pagelayout('standard');
$PAGE->set_title('Formulario Básico');
$PAGE->set_heading('Ejemplo de Formulario en Moodle');

// Crear instancia del formulario
$mform = new formulario_basico_form();

// ============================================
// PROCESAR EL FORMULARIO
// ============================================

// ¿El usuario canceló?
if ($mform->is_cancelled()) {
    // Redirigir a página principal
    redirect(new moodle_url('/'), 'Formulario cancelado');

// ¿El formulario fue enviado y validado?
} else if ($data = $mform->get_data()) {

    // En este punto, $data contiene todos los valores validados
    // Ya está sanitizado y seguro para usar

    // Acceder a los datos
    $nombre = $data->nombre;
    $email = $data->email;
    $edad = $data->edad;
    $genero = $data->genero;
    $pais = $data->pais;
    $comentarios = $data->comentarios;

    // Guardar en base de datos (ejemplo)
    global $DB;

    $record = new stdClass();
    $record->nombre = $nombre;
    $record->email = $email;
    $record->edad = $edad;
    $record->genero = $genero;
    $record->pais = $pais;
    $record->comentarios = $comentarios;
    $record->userid = $USER->id;
    $record->timecreated = time();

    // Insertar en tabla (asumiendo que existe)
    // $id = $DB->insert_record('local_formulario_registros', $record);

    // Mostrar página de éxito
    echo $OUTPUT->header();

    echo html_writer::tag('div',
        '<h3>✓ Formulario enviado exitosamente</h3>',
        array('class' => 'alert alert-success')
    );

    echo html_writer::tag('h4', 'Datos recibidos:');

    echo html_writer::start_tag('table', array('class' => 'table table-bordered'));

    echo html_writer::start_tag('tr');
    echo html_writer::tag('th', 'Campo');
    echo html_writer::tag('th', 'Valor');
    echo html_writer::end_tag('tr');

    echo html_writer::start_tag('tr');
    echo html_writer::tag('td', 'Nombre');
    echo html_writer::tag('td', $nombre);
    echo html_writer::end_tag('tr');

    echo html_writer::start_tag('tr');
    echo html_writer::tag('td', 'Email');
    echo html_writer::tag('td', $email);
    echo html_writer::end_tag('tr');

    echo html_writer::start_tag('tr');
    echo html_writer::tag('td', 'Edad');
    echo html_writer::tag('td', $edad);
    echo html_writer::end_tag('tr');

    echo html_writer::start_tag('tr');
    echo html_writer::tag('td', 'Género');
    echo html_writer::tag('td', $genero);
    echo html_writer::end_tag('tr');

    echo html_writer::start_tag('tr');
    echo html_writer::tag('td', 'País');
    echo html_writer::tag('td', $pais);
    echo html_writer::end_tag('tr');

    echo html_writer::start_tag('tr');
    echo html_writer::tag('td', 'Comentarios');
    echo html_writer::tag('td', nl2br($comentarios));
    echo html_writer::end_tag('tr');

    echo html_writer::end_tag('table');

    // Botón para volver
    $url_volver = new moodle_url('/local/holamundo/formulario_basico.php');
    echo $OUTPUT->single_button($url_volver, 'Enviar otro formulario', 'get');

    echo $OUTPUT->footer();
    die();
}

// ============================================
// MOSTRAR EL FORMULARIO
// ============================================

echo $OUTPUT->header();

// Información sobre el formulario
echo html_writer::tag('div',
    '<strong>Ejemplo de Formulario Básico</strong><br>' .
    'Este formulario demuestra elementos básicos, validación y procesamiento de datos.',
    array('class' => 'alert alert-info')
);

// Mostrar el formulario
$mform->display();

// Nota explicativa
echo html_writer::tag('div',
    '<h4>Características de este formulario:</h4>' .
    '<ul>' .
    '<li>Campos de texto con validación</li>' .
    '<li>Validación en cliente y servidor</li>' .
    '<li>Protección CSRF automática</li>' .
    '<li>Sanitización de datos</li>' .
    '<li>Mensajes de error personalizados</li>' .
    '</ul>',
    array('class' => 'well mt-3')
);

echo $OUTPUT->footer();

/**
 * NOTAS IMPORTANTES:
 *
 * 1. SIEMPRE usar moodleform para formularios
 * 2. NUNCA confiar en datos de $_POST directamente
 * 3. Validar en servidor aunque valides en cliente
 * 4. Usar setType() para cada campo
 * 5. La protección CSRF es automática
 *
 * FLUJO DEL FORMULARIO:
 * 1. Usuario ve el formulario
 * 2. Usuario llena y envía
 * 3. Validación automática
 * 4. Si hay errores, muestra formulario con errores
 * 5. Si es válido, ejecuta $data = $mform->get_data()
 * 6. Procesar datos y redirigir
 */
