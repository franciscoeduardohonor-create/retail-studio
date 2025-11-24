# Módulo 4: Formularios y APIs de Moodle

## 4.1 Forms API - Formularios en Moodle

### Introducción

La **Forms API** de Moodle (basada en `moodleform`) proporciona:
- ✅ **Validación automática** del lado del servidor y cliente
- ✅ **Protección CSRF** (Cross-Site Request Forgery)
- ✅ **Elementos de formulario** estandarizados
- ✅ **Sanitización** automática de datos
- ✅ **Compatibilidad** con temas de Moodle
- ✅ **Accesibilidad** (WCAG compliant)

### Estructura Básica de un Formulario

```php
<?php
// Archivo: edit_form.php

require_once($CFG->libdir . '/formslib.php');

class my_edit_form extends moodleform {

    /**
     * Definir elementos del formulario
     */
    public function definition() {
        $mform = $this->_form; // Objeto del formulario

        // Agregar elementos aquí

        // Botones de acción
        $this->add_action_buttons();
    }

    /**
     * Validación personalizada
     */
    public function validation($data, $files) {
        $errors = parent::validation($data, $files);

        // Agregar validaciones personalizadas

        return $errors;
    }
}
```

### Usando el Formulario

```php
<?php
// Archivo: edit.php

require_once('../../config.php');
require_once('edit_form.php');

require_login();

$PAGE->set_url(new moodle_url('/local/miplugin/edit.php'));
$PAGE->set_context(context_system::instance());

// Crear instancia del formulario
$mform = new my_edit_form();

// ¿El formulario fue cancelado?
if ($mform->is_cancelled()) {
    redirect(new moodle_url('/'));

// ¿El formulario fue enviado?
} else if ($data = $mform->get_data()) {

    // Procesar datos validados
    // $data contiene todos los valores del formulario

    redirect(new moodle_url('/'), 'Datos guardados exitosamente');

} else {
    // Mostrar el formulario
    echo $OUTPUT->header();
    $mform->display();
    echo $OUTPUT->footer();
}
```

## Elementos de Formulario Disponibles

### 1. Campos de Texto

```php
// Texto simple
$mform->addElement('text', 'nombre', get_string('nombre', 'local_miplugin'));
$mform->setType('nombre', PARAM_TEXT);
$mform->addRule('nombre', 'Campo requerido', 'required', null, 'client');

// Texto largo (textarea)
$mform->addElement('textarea', 'descripcion', 'Descripción',
    'wrap="virtual" rows="5" cols="50"');
$mform->setType('descripcion', PARAM_TEXT);

// Email
$mform->addElement('text', 'email', 'Email');
$mform->setType('email', PARAM_EMAIL);
$mform->addRule('email', 'Email inválido', 'email', null, 'client');

// URL
$mform->addElement('text', 'website', 'Sitio Web');
$mform->setType('website', PARAM_URL);

// Contraseña
$mform->addElement('password', 'password', 'Contraseña');
$mform->setType('password', PARAM_RAW);

// Número
$mform->addElement('text', 'edad', 'Edad');
$mform->setType('edad', PARAM_INT);
```

### 2. Selectores y Opciones

```php
// Select (dropdown)
$opciones = array(
    'opcion1' => 'Primera Opción',
    'opcion2' => 'Segunda Opción',
    'opcion3' => 'Tercera Opción'
);
$mform->addElement('select', 'mi_select', 'Selecciona una opción', $opciones);

// Select múltiple
$mform->addElement('select', 'opciones_multiples', 'Selecciona varios',
    $opciones, array('multiple' => 'multiple', 'size' => 5));

// Radio buttons
$radioarray = array();
$radioarray[] = $mform->createElement('radio', 'genero', '', 'Masculino', 'M');
$radioarray[] = $mform->createElement('radio', 'genero', '', 'Femenino', 'F');
$radioarray[] = $mform->createElement('radio', 'genero', '', 'Otro', 'O');
$mform->addGroup($radioarray, 'radioar', 'Género', array(' '), false);

// Checkboxes
$mform->addElement('checkbox', 'acepto_terminos', '', 'Acepto los términos y condiciones');

// Advcheckbox (checkbox avanzado con valor on/off)
$mform->addElement('advcheckbox', 'notificar', 'Notificaciones',
    'Recibir notificaciones por email', array('group' => 1), array(0, 1));
```

### 3. Editor HTML (Editor de Texto Rico)

```php
// Editor HTML completo
$mform->addElement('editor', 'contenido_editor', 'Contenido',
    null,
    array(
        'maxfiles' => EDITOR_UNLIMITED_FILES,
        'noclean' => true,
        'context' => $context,
        'subdirs' => true
    )
);
$mform->setType('contenido_editor', PARAM_RAW);
```

### 4. Fechas y Horas

```php
// Selector de fecha
$mform->addElement('date_selector', 'fecha_nacimiento', 'Fecha de Nacimiento');

// Selector de fecha y hora
$mform->addElement('date_time_selector', 'fecha_evento', 'Fecha del Evento',
    array('optional' => true));

// Duración
$mform->addElement('duration', 'duracion', 'Duración',
    array('optional' => false, 'defaultunit' => 60)); // Segundos
```

### 5. Archivos

```php
// File picker (selector de archivos)
$mform->addElement('filepicker', 'archivo', 'Subir Archivo',
    null,
    array('maxbytes' => 2048000, 'accepted_types' => array('.pdf', '.doc', '.docx'))
);

// File manager (gestor de múltiples archivos)
$mform->addElement('filemanager', 'archivos', 'Archivos Adjuntos',
    null,
    array(
        'subdirs' => 0,
        'maxbytes' => 10485760, // 10MB
        'maxfiles' => 5,
        'accepted_types' => array('document', 'image')
    )
);
```

### 6. Elementos Avanzados

```php
// HTML estático (para mostrar información)
$mform->addElement('static', 'info', 'Información',
    'Este es un texto informativo que no se puede editar');

// Header (separador de secciones)
$mform->addElement('header', 'seccion1', 'Datos Personales');

// Hidden (campo oculto)
$mform->addElement('hidden', 'id', 0);
$mform->setType('id', PARAM_INT);

// HTML personalizado
$mform->addElement('html', '<div class="alert alert-info">Mensaje personalizado</div>');

// Autocomplete (con búsqueda)
$mform->addElement('autocomplete', 'usuarios', 'Seleccionar Usuario',
    $opciones_usuarios,
    array('multiple' => true, 'noselectionstring' => 'Seleccione...'));
```

## Validación de Formularios

### Reglas de Validación

```php
public function definition() {
    $mform = $this->_form;

    // Campo requerido
    $mform->addRule('nombre', 'El nombre es requerido', 'required', null, 'client');

    // Longitud mínima
    $mform->addRule('username', 'Mínimo 5 caracteres', 'minlength', 5, 'client');

    // Longitud máxima
    $mform->addRule('nombre', 'Máximo 50 caracteres', 'maxlength', 50, 'client');

    // Email válido
    $mform->addRule('email', 'Email inválido', 'email', null, 'client');

    // Numérico
    $mform->addRule('edad', 'Debe ser numérico', 'numeric', null, 'client');

    // Rango numérico
    $mform->addRule('calificacion', 'Entre 0 y 100', 'rangevalue', array(0, 100), 'client');

    // Expresión regular
    $mform->addRule('codigo', 'Formato: XX-9999', 'regex', '/^[A-Z]{2}-\d{4}$/', 'client');
}
```

### Validación Personalizada

```php
public function validation($data, $files) {
    $errors = parent::validation($data, $files);

    // Verificar que email no exista
    if (!empty($data['email'])) {
        if ($DB->record_exists('user', array('email' => $data['email']))) {
            $errors['email'] = 'Este email ya está registrado';
        }
    }

    // Verificar que dos campos coincidan
    if ($data['password'] !== $data['password_confirm']) {
        $errors['password_confirm'] = 'Las contraseñas no coinciden';
    }

    // Validación de rango de fechas
    if ($data['fecha_inicio'] > $data['fecha_fin']) {
        $errors['fecha_fin'] = 'La fecha de fin debe ser posterior a la fecha de inicio';
    }

    // Validación condicional
    if ($data['tipo'] == 'premium' && empty($data['tarjeta'])) {
        $errors['tarjeta'] = 'Tarjeta requerida para tipo premium';
    }

    return $errors;
}
```

## Valores por Defecto

```php
// Establecer valores por defecto
public function definition() {
    $mform = $this->_form;

    // ... definir elementos ...

    // Valores por defecto
    $mform->setDefault('pais', 'MX');
    $mform->setDefault('notificar', 1);
    $mform->setDefault('fecha', time());
}

// O al crear el formulario
$defaultdata = new stdClass();
$defaultdata->nombre = 'Juan';
$defaultdata->email = 'juan@example.com';

$mform = new my_edit_form(null, null, 'post', '', null, true, $defaultdata);

// O con set_data()
$mform->set_data($defaultdata);
```

## Agrupación de Elementos

```php
// Agrupar elementos en una línea
$group = array();
$group[] = $mform->createElement('text', 'dia', '', array('size' => 2));
$group[] = $mform->createElement('text', 'mes', '', array('size' => 2));
$group[] = $mform->createElement('text', 'año', '', array('size' => 4));

$mform->addGroup($group, 'fecha_grupo', 'Fecha (DD/MM/AAAA)', array(' / '), false);
$mform->setType('fecha_grupo[dia]', PARAM_INT);
$mform->setType('fecha_grupo[mes]', PARAM_INT);
$mform->setType('fecha_grupo[año]', PARAM_INT);
```

## Elementos Condicionales (Mostrar/Ocultar)

```php
// Mostrar elemento solo si otro tiene cierto valor
$mform->addElement('select', 'tipo_usuario', 'Tipo', array(
    'estudiante' => 'Estudiante',
    'profesor' => 'Profesor',
    'admin' => 'Administrador'
));

$mform->addElement('text', 'codigo_profesor', 'Código de Profesor');
$mform->setType('codigo_profesor', PARAM_TEXT);

// Mostrar 'codigo_profesor' solo si 'tipo_usuario' es 'profesor'
$mform->hideIf('codigo_profesor', 'tipo_usuario', 'neq', 'profesor');

// Otras opciones:
// hideIf('campo', 'otro_campo', 'eq', 'valor')   // Ocultar si es igual
// hideIf('campo', 'otro_campo', 'neq', 'valor')  // Ocultar si NO es igual
// hideIf('campo', 'otro_campo', 'checked')       // Ocultar si está marcado
// hideIf('campo', 'otro_campo', 'notchecked')    // Ocultar si NO está marcado
```

## Tipos de Datos (PARAM_*)

```php
// Tipos más comunes
PARAM_INT        // Entero
PARAM_TEXT       // Texto sin HTML
PARAM_RAW        // Sin procesamiento (usar con cuidado)
PARAM_CLEAN      // HTML limpio
PARAM_EMAIL      // Email
PARAM_URL        // URL
PARAM_BOOL       // Boolean
PARAM_FLOAT      // Decimal
PARAM_ALPHANUMEXT // Alfanumérico extendido
PARAM_FILE       // Nombre de archivo
PARAM_PATH       // Path de archivo
PARAM_HOST       // Hostname
PARAM_SAFEDIR    // Directorio seguro
```

## Procesar Datos del Formulario

```php
if ($data = $mform->get_data()) {

    // Datos de texto simple
    $nombre = $data->nombre;
    $email = $data->email;

    // Editor HTML
    $contenido = $data->contenido_editor;
    $texto = $contenido['text'];
    $formato = $contenido['format'];

    // Archivos (file picker)
    if (isset($data->archivo)) {
        $draftitemid = $data->archivo;
        // Procesar archivo...
    }

    // File manager
    if (isset($data->archivos)) {
        $draftitemid = $data->archivos;
        // Guardar archivos...
    }

    // Checkboxes
    $notificar = isset($data->notificar) ? 1 : 0;

    // Select múltiple
    $opciones_seleccionadas = $data->opciones_multiples; // Array

    // Grupos
    $dia = $data->fecha_grupo['dia'];
    $mes = $data->fecha_grupo['mes'];
    $año = $data->fecha_grupo['año'];
}
```

## Ejemplo Completo

```php
<?php
// edit_form.php

class curso_edit_form extends moodleform {

    public function definition() {
        global $DB;

        $mform = $this->_form;

        // ID (oculto para edición)
        $mform->addElement('hidden', 'id');
        $mform->setType('id', PARAM_INT);

        // Datos básicos
        $mform->addElement('header', 'general', 'Información General');

        $mform->addElement('text', 'nombre', 'Nombre del Curso', 'maxlength="255" size="50"');
        $mform->setType('nombre', PARAM_TEXT);
        $mform->addRule('nombre', 'Nombre requerido', 'required', null, 'client');

        $mform->addElement('text', 'codigo', 'Código', 'maxlength="20"');
        $mform->setType('codigo', PARAM_ALPHANUMEXT);
        $mform->addRule('codigo', 'Código requerido', 'required', null, 'client');

        // Categoría
        $categorias = $DB->get_records_menu('course_categories', null, 'name', 'id, name');
        $mform->addElement('select', 'categoria', 'Categoría', $categorias);
        $mform->addRule('categoria', 'Categoría requerida', 'required', null, 'client');

        // Descripción
        $mform->addElement('editor', 'descripcion', 'Descripción', null, array(
            'maxfiles' => EDITOR_UNLIMITED_FILES,
            'noclean' => true,
            'context' => context_system::instance()
        ));
        $mform->setType('descripcion', PARAM_RAW);

        // Fechas
        $mform->addElement('header', 'fechas', 'Fechas del Curso');

        $mform->addElement('date_time_selector', 'fecha_inicio', 'Fecha de Inicio');
        $mform->addElement('date_time_selector', 'fecha_fin', 'Fecha de Fin');

        // Configuración
        $mform->addElement('header', 'config', 'Configuración');

        $mform->addElement('text', 'capacidad', 'Capacidad Máxima');
        $mform->setType('capacidad', PARAM_INT);
        $mform->setDefault('capacidad', 30);

        $mform->addElement('advcheckbox', 'visible', 'Visible', 'Mostrar en listado');
        $mform->setDefault('visible', 1);

        $this->add_action_buttons();
    }

    public function validation($data, $files) {
        $errors = parent::validation($data, $files);

        // Verificar que código sea único
        global $DB;
        $params = array('codigo' => $data['codigo']);
        if (!empty($data['id'])) {
            $params['id'] = $data['id'];
            $sql = "codigo = :codigo AND id != :id";
        } else {
            $sql = "codigo = :codigo";
        }

        if ($DB->record_exists_select('mi_tabla_cursos', $sql, $params)) {
            $errors['codigo'] = 'Este código ya existe';
        }

        // Validar fechas
        if ($data['fecha_inicio'] >= $data['fecha_fin']) {
            $errors['fecha_fin'] = 'Debe ser posterior a la fecha de inicio';
        }

        // Validar capacidad
        if ($data['capacidad'] < 1 || $data['capacidad'] > 100) {
            $errors['capacidad'] = 'Debe estar entre 1 y 100';
        }

        return $errors;
    }
}
```

## Próximos Temas

En las siguientes secciones verás:
- File API (manejo de archivos)
- Events API (sistema de eventos)
- Capabilities (permisos y roles)
- Web Services API
