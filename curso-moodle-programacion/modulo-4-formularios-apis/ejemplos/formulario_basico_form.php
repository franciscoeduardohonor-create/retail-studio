<?php
/**
 * DEFINICIÓN DEL FORMULARIO BÁSICO
 *
 * Este archivo define la estructura del formulario.
 * Extiende moodleform y define los elementos y validación.
 *
 * UBICACIÓN: /local/holamundo/formulario_basico_form.php
 */

// Cargar la librería de formularios
require_once($CFG->libdir . '/formslib.php');

/**
 * Clase del formulario básico
 */
class formulario_basico_form extends moodleform {

    /**
     * Definir los elementos del formulario
     */
    public function definition() {
        global $USER;

        // Obtener objeto del formulario
        $mform = $this->_form;

        // ============================================
        // SECCIÓN: DATOS PERSONALES
        // ============================================
        $mform->addElement('header', 'datos_personales', 'Datos Personales');

        // Campo: Nombre completo
        $mform->addElement('text', 'nombre', 'Nombre Completo',
            array('size' => '50', 'maxlength' => '100'));

        // Tipo de dato (IMPORTANTE para sanitización)
        $mform->setType('nombre', PARAM_TEXT);

        // Regla de validación: campo requerido
        $mform->addRule('nombre', 'El nombre es requerido', 'required', null, 'client');

        // Regla de validación: longitud mínima
        $mform->addRule('nombre', 'Mínimo 3 caracteres', 'minlength', 3, 'client');

        // Texto de ayuda
        $mform->addHelpButton('nombre', 'nombre', 'local_holamundo');
        // O sin help button, usar setAdvanced:
        // $mform->setAdvanced('nombre');

        // Campo: Email
        $mform->addElement('text', 'email', 'Correo Electrónico',
            array('size' => '50', 'maxlength' => '100'));
        $mform->setType('email', PARAM_EMAIL);
        $mform->addRule('email', 'Email requerido', 'required', null, 'client');
        $mform->addRule('email', 'Email inválido', 'email', null, 'client');

        // Valor por defecto (email del usuario actual)
        $mform->setDefault('email', $USER->email);

        // Campo: Edad (número)
        $mform->addElement('text', 'edad', 'Edad',
            array('size' => '5', 'maxlength' => '3'));
        $mform->setType('edad', PARAM_INT);
        $mform->addRule('edad', 'Edad requerida', 'required', null, 'client');
        $mform->addRule('edad', 'Debe ser numérico', 'numeric', null, 'client');

        // Validación de rango (entre 18 y 100)
        // Nota: Esta validación solo funciona del lado del servidor
        // Para cliente, se hace en validation()

        // ============================================
        // SECCIÓN: INFORMACIÓN ADICIONAL
        // ============================================
        $mform->addElement('header', 'info_adicional', 'Información Adicional');

        // Radio buttons para género
        $radioarray = array();
        $radioarray[] = $mform->createElement('radio', 'genero', '', 'Masculino', 'M');
        $radioarray[] = $mform->createElement('radio', 'genero', '', 'Femenino', 'F');
        $radioarray[] = $mform->createElement('radio', 'genero', '', 'Prefiero no decir', 'X');

        $mform->addGroup($radioarray, 'radioar', 'Género', array(' &nbsp; '), false);
        $mform->addRule('radioar', 'Selecciona una opción', 'required', null, 'client');

        // Select (dropdown) para país
        $paises = array(
            '' => 'Selecciona un país...',
            'MX' => 'México',
            'ES' => 'España',
            'AR' => 'Argentina',
            'CO' => 'Colombia',
            'CL' => 'Chile',
            'PE' => 'Perú',
            'US' => 'Estados Unidos',
            'CA' => 'Canadá',
            'BR' => 'Brasil'
        );
        $mform->addElement('select', 'pais', 'País', $paises);
        $mform->addRule('pais', 'Selecciona un país', 'required', null, 'client');

        // Textarea para comentarios
        $mform->addElement('textarea', 'comentarios', 'Comentarios',
            'wrap="virtual" rows="5" cols="50"');
        $mform->setType('comentarios', PARAM_TEXT);

        // ============================================
        // BOTONES DE ACCIÓN
        // ============================================
        // Esto agrega automáticamente:
        // - Botón "Guardar" (submit)
        // - Botón "Cancelar"
        $this->add_action_buttons(
            true,           // Mostrar botón cancelar
            'Enviar'        // Texto del botón de envío
        );

        // Alternativamente, puedes crear botones personalizados:
        /*
        $buttonarray = array();
        $buttonarray[] = $mform->createElement('submit', 'submitbutton', 'Enviar');
        $buttonarray[] = $mform->createElement('reset', 'resetbutton', 'Limpiar');
        $buttonarray[] = $mform->createElement('cancel');
        $mform->addGroup($buttonarray, 'buttonar', '', ' ', false);
        */
    }

    /**
     * Validación personalizada del lado del servidor
     *
     * @param array $data Datos del formulario
     * @param array $files Archivos subidos
     * @return array Errores encontrados
     */
    public function validation($data, $files) {
        global $DB;

        // Llamar a validación padre (siempre hacer esto)
        $errors = parent::validation($data, $files);

        // ============================================
        // VALIDACIONES PERSONALIZADAS
        // ============================================

        // Validar edad (entre 18 y 100)
        if (!empty($data['edad'])) {
            if ($data['edad'] < 18) {
                $errors['edad'] = 'Debes ser mayor de 18 años';
            }
            if ($data['edad'] > 100) {
                $errors['edad'] = 'Edad no válida';
            }
        }

        // Validar que el email no esté ya registrado
        // (ejemplo - descomentar si tienes la tabla)
        /*
        if (!empty($data['email'])) {
            if ($DB->record_exists('local_formulario_registros', array('email' => $data['email']))) {
                $errors['email'] = 'Este email ya está registrado';
            }
        }
        */

        // Validar formato de nombre (solo letras y espacios)
        if (!empty($data['nombre'])) {
            if (!preg_match('/^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$/', $data['nombre'])) {
                $errors['nombre'] = 'El nombre solo puede contener letras y espacios';
            }
        }

        // Validar longitud de comentarios
        if (!empty($data['comentarios'])) {
            if (strlen($data['comentarios']) > 500) {
                $errors['comentarios'] = 'Máximo 500 caracteres';
            }
        }

        // Retornar array de errores
        // Si está vacío, la validación pasó
        return $errors;
    }

    /**
     * Establecer datos por defecto (opcional)
     *
     * Esta función se puede usar para cargar datos de edición
     */
    public function set_data($defaultvalues) {
        // Puedes modificar los valores antes de establecerlos

        // Por ejemplo, convertir fechas, formatear datos, etc.

        // Llamar al método padre
        parent::set_data($defaultvalues);
    }
}

/**
 * NOTAS SOBRE LA CLASE:
 *
 * 1. SIEMPRE extender moodleform
 * 2. SIEMPRE implementar definition()
 * 3. Implementar validation() para validación custom
 * 4. Usar setType() para CADA campo
 * 5. addRule() para validación del lado del cliente
 * 6. validation() para validación del lado del servidor
 *
 * TIPOS DE DATOS (PARAM_*):
 * - PARAM_TEXT: Texto sin HTML
 * - PARAM_INT: Entero
 * - PARAM_EMAIL: Email
 * - PARAM_URL: URL
 * - PARAM_RAW: Sin procesar (¡cuidado!)
 * - PARAM_CLEAN: HTML limpio
 * - PARAM_BOOL: Boolean
 * - PARAM_FLOAT: Decimal
 *
 * REGLAS DE VALIDACIÓN:
 * - required: Campo requerido
 * - email: Email válido
 * - numeric: Numérico
 * - minlength: Longitud mínima
 * - maxlength: Longitud máxima
 * - rangevalue: Rango numérico
 * - regex: Expresión regular
 *
 * ELEMENTOS COMUNES:
 * - text: Campo de texto
 * - textarea: Texto largo
 * - select: Dropdown
 * - radio: Radio buttons
 * - checkbox: Checkboxes
 * - date_selector: Selector de fecha
 * - editor: Editor HTML
 * - filepicker: Selector de archivo
 * - hidden: Campo oculto
 * - static: Texto estático
 * - header: Separador de secciones
 */
