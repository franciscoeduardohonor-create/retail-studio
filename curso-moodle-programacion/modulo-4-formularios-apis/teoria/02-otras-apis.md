# 4.2 Otras APIs Importantes de Moodle

## File API - Manejo de Archivos

### Introducción

La **File API** de Moodle gestiona archivos de forma segura y eficiente:
- ✅ **Almacenamiento eficiente** (deduplicación por hash)
- ✅ **Control de acceso** por contexto
- ✅ **Versionamiento** automático
- ✅ **Integración** con repositorios externos

### Conceptos Clave

```
Archivo en Moodle
├── Contexto (dónde se usa)
├── Component (quién lo usa)
├── Filearea (tipo de archivo)
├── Item ID (identificador del elemento)
└── Filepath (ruta dentro del área)
```

### Subir Archivos con Filepicker

```php
// En el formulario
$mform->addElement('filepicker', 'userfile', 'Archivo',
    null,
    array(
        'maxbytes' => 2048000,           // 2MB
        'accepted_types' => array('.pdf', '.doc', '.docx')
    )
);

// Procesar el archivo
if ($data = $mform->get_data()) {
    $draftitemid = $data->userfile;

    // Guardar el archivo
    $context = context_system::instance();

    file_save_draft_area_files(
        $draftitemid,                    // ID del draft
        $context->id,                    // Contexto
        'local_miplugin',                // Component
        'attachments',                   // Filearea
        $itemid,                         // Item ID
        array(
            'subdirs' => 0,
            'maxbytes' => 2048000,
            'maxfiles' => 1
        )
    );
}
```

### Obtener y Mostrar Archivos

```php
// Obtener file storage
$fs = get_file_storage();

// Obtener archivos de un área
$files = $fs->get_area_files(
    $context->id,                        // Contexto
    'local_miplugin',                    // Component
    'attachments',                       // Filearea
    $itemid,                             // Item ID
    'filename',                          // Orden
    false                                // Excluir directorios
);

foreach ($files as $file) {
    $filename = $file->get_filename();
    $filesize = $file->get_filesize();
    $mimetype = $file->get_mimetype();

    // URL para descargar
    $url = moodle_url::make_pluginfile_url(
        $file->get_contextid(),
        $file->get_component(),
        $file->get_filearea(),
        $file->get_itemid(),
        $file->get_filepath(),
        $file->get_filename()
    );

    echo html_writer::link($url, $filename);
}
```

### Crear Archivo Programáticamente

```php
$fs = get_file_storage();

$filerecord = array(
    'contextid' => $context->id,
    'component' => 'local_miplugin',
    'filearea'  => 'generated',
    'itemid'    => 0,
    'filepath'  => '/',
    'filename'  => 'reporte.txt'
);

$content = "Contenido del archivo generado\n";
$content .= "Línea 2\n";
$content .= "Línea 3\n";

// Crear archivo desde string
$file = $fs->create_file_from_string($filerecord, $content);

// Crear archivo desde pathname (archivo existente)
// $file = $fs->create_file_from_pathname($filerecord, '/tmp/archivo.txt');

// Crear archivo desde storedfile (copiar)
// $file = $fs->create_file_from_storedfile($filerecord, $sourcefile);
```

### Eliminar Archivos

```php
$fs = get_file_storage();

// Eliminar un archivo específico
$file = $fs->get_file(
    $contextid,
    $component,
    $filearea,
    $itemid,
    $filepath,
    $filename
);

if ($file) {
    $file->delete();
}

// Eliminar todos los archivos de un área
$fs->delete_area_files($contextid, $component, $filearea, $itemid);

// Eliminar archivos de un contexto completo
$fs->delete_component_files($component, $contextid);
```

---

## Events API - Sistema de Eventos

### Introducción

Los **eventos** en Moodle permiten:
- ✅ **Logging** automático de acciones
- ✅ **Triggers** para acciones personalizadas
- ✅ **Observers** que escuchan eventos
- ✅ **Auditoría** completa del sistema

### Disparar un Evento

```php
// Crear clase de evento en /classes/event/

namespace local_miplugin\event;

class item_created extends \core\event\base {

    protected function init() {
        $this->data['crud'] = 'c';              // c=create, r=read, u=update, d=delete
        $this->data['edulevel'] = self::LEVEL_PARTICIPATING;
        $this->data['objecttable'] = 'local_miplugin_items';
    }

    public static function get_name() {
        return get_string('eventitemcreated', 'local_miplugin');
    }

    public function get_description() {
        return "El usuario {$this->userid} creó el item {$this->objectid}";
    }

    public function get_url() {
        return new \moodle_url('/local/miplugin/view.php', array('id' => $this->objectid));
    }
}

// Disparar el evento
$event = \local_miplugin\event\item_created::create(array(
    'context' => $context,
    'objectid' => $itemid,
    'other' => array('name' => $itemname)
));
$event->trigger();
```

### Escuchar Eventos (Observers)

```php
// En db/events.php

$observers = array(
    array(
        'eventname' => '\core\event\user_created',
        'callback'  => 'local_miplugin_observer::user_created',
    ),
    array(
        'eventname' => '\core\event\course_completed',
        'callback'  => 'local_miplugin_observer::course_completed',
    ),
);

// En classes/observer.php

namespace local_miplugin;

class observer {

    public static function user_created(\core\event\user_created $event) {
        // Obtener datos del evento
        $userid = $event->objectid;
        $context = $event->get_context();
        $data = $event->get_data();

        // Realizar acción personalizada
        // Por ejemplo: enviar email de bienvenida
        // O asignar rol por defecto
        // O crear preferencias iniciales

        global $DB;
        // Tu lógica aquí...
    }

    public static function course_completed(\core\event\course_completed $event) {
        $userid = $event->relateduserid;
        $courseid = $event->courseid;

        // Acción cuando usuario completa curso
        // Por ejemplo: generar certificado, enviar notificación, etc.
    }
}
```

### Eventos Comunes de Moodle

```php
// Eventos de usuario
\core\event\user_created
\core\event\user_updated
\core\event\user_deleted
\core\event\user_loggedin
\core\event\user_loggedout

// Eventos de curso
\core\event\course_created
\core\event\course_updated
\core\event\course_deleted
\core\event\course_viewed
\core\event\course_completed

// Eventos de módulo
\core\event\course_module_created
\core\event\course_module_viewed
\core\event\course_module_deleted

// Eventos de calificaciones
\core\event\user_graded
\core\event\grade_deleted

// Eventos de inscripción
\core\event\user_enrolment_created
\core\event\user_enrolment_deleted
```

---

## Capabilities - Sistema de Permisos

### Introducción

Las **capabilities** (capacidades) controlan:
- ✅ Qué puede hacer cada rol
- ✅ Permisos por contexto
- ✅ Herencia de permisos
- ✅ Overrides personalizados

### Definir Capabilities

```php
// En db/access.php

$capabilities = array(

    'local/miplugin:view' => array(
        'captype' => 'read',
        'contextlevel' => CONTEXT_SYSTEM,
        'archetypes' => array(
            'guest' => CAP_ALLOW,
            'user' => CAP_ALLOW,
            'student' => CAP_ALLOW,
            'teacher' => CAP_ALLOW,
            'editingteacher' => CAP_ALLOW,
            'manager' => CAP_ALLOW
        )
    ),

    'local/miplugin:edit' => array(
        'riskbitmask' => RISK_SPAM | RISK_XSS,
        'captype' => 'write',
        'contextlevel' => CONTEXT_SYSTEM,
        'archetypes' => array(
            'editingteacher' => CAP_ALLOW,
            'manager' => CAP_ALLOW
        ),
        'clonepermissionsfrom' => 'moodle/course:update'
    ),

    'local/miplugin:delete' => array(
        'riskbitmask' => RISK_DATALOSS,
        'captype' => 'write',
        'contextlevel' => CONTEXT_SYSTEM,
        'archetypes' => array(
            'manager' => CAP_ALLOW
        )
    ),

);
```

### Verificar Capabilities

```php
// Verificar si el usuario tiene una capability
$context = context_system::instance();

if (has_capability('local/miplugin:view', $context)) {
    // El usuario puede ver
}

if (has_capability('local/miplugin:edit', $context)) {
    // El usuario puede editar
}

// Requerir capability (lanza excepción si no la tiene)
require_capability('local/miplugin:delete', $context);

// Verificar si es admin del sitio
if (is_siteadmin()) {
    // Es administrador
}

// Verificar múltiples capabilities (OR)
if (has_any_capability(
    array('local/miplugin:edit', 'local/miplugin:delete'),
    $context
)) {
    // Tiene al menos una de las capabilities
}

// Verificar múltiples capabilities (AND)
if (has_capability('local/miplugin:edit', $context) &&
    has_capability('local/miplugin:delete', $context)) {
    // Tiene ambas capabilities
}
```

### Contextos en Moodle

```php
// Contexto de sistema (todo el sitio)
$context = context_system::instance();

// Contexto de usuario
$context = context_user::instance($userid);

// Contexto de categoría de curso
$context = context_coursecat::instance($categoryid);

// Contexto de curso
$context = context_course::instance($courseid);

// Contexto de módulo (actividad)
$context = context_module::instance($cmid);

// Contexto de bloque
$context = context_block::instance($blockinstanceid);
```

### Asignar Roles

```php
// Asignar rol a usuario en un contexto
$roleid = 5; // Student
$userid = $USER->id;
$context = context_course::instance($courseid);

role_assign($roleid, $userid, $context->id);

// Remover asignación de rol
role_unassign($roleid, $userid, $context->id);

// Obtener usuarios con un rol específico
$users = get_role_users($roleid, $context);

// Verificar si usuario tiene un rol
if (user_has_role_assignment($userid, $roleid, $context->id)) {
    // El usuario tiene este rol
}
```

---

## Notifications API - Notificaciones

### Enviar Notificación

```php
// Notificación simple
\core\notification::success('Operación exitosa');
\core\notification::error('Ocurrió un error');
\core\notification::warning('Advertencia importante');
\core\notification::info('Información relevante');

// Con redirect
redirect(
    new moodle_url('/'),
    'Datos guardados exitosamente',
    null,
    \core\output\notification::NOTIFY_SUCCESS
);
```

### Mensajes entre Usuarios

```php
// Enviar mensaje a usuario
$message = new \core\message\message();
$message->component = 'local_miplugin';
$message->name = 'notification';
$message->userfrom = $USER;
$message->userto = $recipientid;
$message->subject = 'Asunto del mensaje';
$message->fullmessage = 'Mensaje completo en texto plano';
$message->fullmessageformat = FORMAT_PLAIN;
$message->fullmessagehtml = '<p>Mensaje en <strong>HTML</strong></p>';
$message->smallmessage = 'Versión corta';
$message->notification = 1; // 1 = notificación, 0 = mensaje personal

message_send($message);
```

---

## Output API - Renderizadores

### Renderizar Contenido

```php
// Obtener renderer
$renderer = $PAGE->get_renderer('local_miplugin');

// O para componentes core
$renderer = $PAGE->get_renderer('core');

// Usar el renderer
echo $renderer->render_my_component($data);

// Elementos comunes de $OUTPUT
echo $OUTPUT->heading('Título');
echo $OUTPUT->heading('Subtítulo', 3);

echo $OUTPUT->box('Contenido en caja');
echo $OUTPUT->box_start();
echo "Contenido";
echo $OUTPUT->box_end();

echo $OUTPUT->notification('Mensaje', 'notifysuccess');

echo $OUTPUT->single_button($url, 'Texto del botón', 'get');

echo $OUTPUT->pix_icon('t/edit', 'Editar', 'core');

echo $OUTPUT->user_picture($user, array('size' => 35));

echo $OUTPUT->confirm('¿Estás seguro?', $continueurl, $cancelurl);
```

---

## String API - Multiidioma

### Definir Strings

```php
// En lang/en/local_miplugin.php

$string['pluginname'] = 'My Plugin';
$string['eventitemcreated'] = 'Item created';
$string['view'] = 'View';
$string['edit'] = 'Edit';
$string['delete'] = 'Delete';
$string['confirmdelete'] = 'Are you sure you want to delete this item?';
```

### Usar Strings

```php
// Obtener string
$text = get_string('pluginname', 'local_miplugin');

// String con placeholder
$string['welcome'] = 'Welcome, {$a}';
echo get_string('welcome', 'local_miplugin', $username);

// String con múltiples placeholders
$string['userinfo'] = 'User {$a->name} has {$a->points} points';
$a = new stdClass();
$a->name = 'John';
$a->points = 150;
echo get_string('userinfo', 'local_miplugin', $a);

// Verificar si string existe
if (get_string_manager()->string_exists('mystring', 'local_miplugin')) {
    // Existe
}
```

---

## URL API - Construcción de URLs

### Crear URLs

```php
// URL simple
$url = new moodle_url('/local/miplugin/view.php');

// URL con parámetros
$url = new moodle_url('/local/miplugin/view.php', array(
    'id' => 5,
    'action' => 'edit'
));

// URL completa
echo $url->out();
// Output: http://moodle.example.com/local/miplugin/view.php?id=5&action=edit

// URL relativa
echo $url->out(false);
// Output: /local/miplugin/view.php?id=5&action=edit

// Agregar parámetros
$url->param('extra', 'value');

// Obtener parámetro
$id = $url->get_param('id');

// Comparar URLs
if ($url->compare(new moodle_url('/local/miplugin/view.php'))) {
    // Son iguales
}
```

---

## Próximos Pasos

En los ejercicios verás:
- Formularios completos con file upload
- Sistema de eventos personalizado
- Verificación de permisos
- Integración de todas las APIs
