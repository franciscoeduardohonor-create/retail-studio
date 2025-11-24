# Ejercicios Prácticos - Módulo 4: Formularios y APIs

## Ejercicio 1: Formulario de Registro Completo
**Nivel: Intermedio**

### Objetivo
Crear un formulario de registro con todos los tipos de campos.

### Requisitos
1. Campos a incluir:
   - Nombre, apellido, email
   - Fecha de nacimiento (date_selector)
   - País (select)
   - Género (radio)
   - Intereses (checkboxes múltiples)
   - Bio (editor HTML)
   - Foto de perfil (filepicker)
   - Acepto términos (checkbox)

2. Validaciones:
   - Todos los campos requeridos excepto bio y foto
   - Email único (no duplicado)
   - Edad mínima 13 años
   - Foto máximo 2MB, solo imágenes
   - Bio máximo 500 caracteres

3. Procesamiento:
   - Guardar en BD
   - Guardar archivo de foto
   - Enviar email de confirmación
   - Mostrar resumen de datos

### Código Base
```php
// registro_form.php
class user_registration_form extends moodleform {
    public function definition() {
        $mform = $this->_form;

        // Sección: Datos Personales
        $mform->addElement('header', 'personal', 'Datos Personales');

        // TODO: Agregar campos

        // Sección: Foto
        $mform->addElement('header', 'photo', 'Foto de Perfil');

        $mform->addElement('filepicker', 'userphoto', 'Foto',
            null,
            array(
                'maxbytes' => 2097152, // 2MB
                'accepted_types' => array('image')
            )
        );

        // TODO: Continuar...
    }

    public function validation($data, $files) {
        $errors = parent::validation($data, $files);

        // TODO: Validaciones personalizadas

        return $errors;
    }
}
```

---

## Ejercicio 2: Sistema de Upload de Documentos
**Nivel: Intermedio**

### Objetivo
Crear un sistema para subir y gestionar documentos.

### Requisitos
1. Formulario con:
   - Título del documento
   - Descripción
   - Categoría (select)
   - File manager (múltiples archivos)
   - Tags (texto separado por comas)

2. Funcionalidades:
   - Listar todos los documentos
   - Ver detalles de documento
   - Descargar archivos
   - Eliminar documentos
   - Buscar por título/tags

3. Validaciones:
   - Máximo 5 archivos por documento
   - Total máximo 10MB
   - Solo PDF, DOC, DOCX, XLS, XLSX

### Archivos a Crear
```
/local/documents/
├── index.php (listar)
├── upload.php (subir)
├── upload_form.php (formulario)
├── view.php (ver documento)
├── download.php (descargar archivo)
├── delete.php (eliminar)
└── lib.php (funciones auxiliares)
```

### Funciones Helper
```php
function documents_save_files($draftitemid, $documentid) {
    $context = context_system::instance();

    file_save_draft_area_files(
        $draftitemid,
        $context->id,
        'local_documents',
        'attachments',
        $documentid,
        array(
            'subdirs' => 0,
            'maxbytes' => 10485760,
            'maxfiles' => 5
        )
    );
}

function documents_get_files($documentid) {
    $fs = get_file_storage();
    $context = context_system::instance();

    return $fs->get_area_files(
        $context->id,
        'local_documents',
        'attachments',
        $documentid,
        'filename',
        false
    );
}
```

---

## Ejercicio 3: Sistema de Eventos Personalizado
**Nivel: Intermedio-Avanzado**

### Objetivo
Implementar eventos personalizados y observers.

### Requisitos
1. Crear eventos para:
   - documento_created
   - documento_viewed
   - documento_downloaded
   - documento_deleted

2. Implementar observers para:
   - Registrar en log personalizado
   - Enviar notificación al creador
   - Actualizar estadísticas
   - Generar reporte de actividad

3. Crear página de logs que muestre:
   - Todos los eventos del sistema
   - Filtros por tipo, usuario, fecha
   - Estadísticas (eventos por día, más vistos, etc.)

### Estructura de Clase de Evento
```php
// classes/event/document_created.php
namespace local_documents\event;

class document_created extends \core\event\base {

    protected function init() {
        $this->data['crud'] = 'c';
        $this->data['edulevel'] = self::LEVEL_PARTICIPATING;
        $this->data['objecttable'] = 'local_documents';
    }

    public static function get_name() {
        return get_string('eventdocumentcreated', 'local_documents');
    }

    public function get_description() {
        return "El usuario {$this->userid} creó el documento {$this->objectid}";
    }

    public function get_url() {
        return new \moodle_url('/local/documents/view.php',
            array('id' => $this->objectid));
    }
}

// Disparar el evento
$event = \local_documents\event\document_created::create(array(
    'context' => $context,
    'objectid' => $documentid,
    'other' => array(
        'title' => $title
    )
));
$event->trigger();
```

### Observer
```php
// classes/observer.php
namespace local_documents;

class observer {

    public static function document_created($event) {
        global $DB;

        // Registrar en log
        $log = new \stdClass();
        $log->eventtype = 'document_created';
        $log->userid = $event->userid;
        $log->objectid = $event->objectid;
        $log->timecreated = time();

        $DB->insert_record('local_documents_log', $log);

        // Enviar notificación
        // ...
    }
}
```

---

## Ejercicio 4: Sistema de Permisos Granular
**Nivel: Avanzado**

### Objetivo
Implementar un sistema completo de permisos para el sistema de documentos.

### Capabilities a Definir
```php
// db/access.php
$capabilities = array(

    'local/documents:view' => array(
        'captype' => 'read',
        'contextlevel' => CONTEXT_SYSTEM,
        'archetypes' => array(
            'user' => CAP_ALLOW,
            'student' => CAP_ALLOW,
            'teacher' => CAP_ALLOW,
            'editingteacher' => CAP_ALLOW,
            'manager' => CAP_ALLOW
        )
    ),

    'local/documents:upload' => array(
        'riskbitmask' => RISK_SPAM,
        'captype' => 'write',
        'contextlevel' => CONTEXT_SYSTEM,
        'archetypes' => array(
            'teacher' => CAP_ALLOW,
            'editingteacher' => CAP_ALLOW,
            'manager' => CAP_ALLOW
        )
    ),

    'local/documents:edit' => array(
        'riskbitmask' => RISK_SPAM | RISK_XSS,
        'captype' => 'write',
        'contextlevel' => CONTEXT_SYSTEM,
        'archetypes' => array(
            'editingteacher' => CAP_ALLOW,
            'manager' => CAP_ALLOW
        )
    ),

    'local/documents:delete' => array(
        'riskbitmask' => RISK_DATALOSS,
        'captype' => 'write',
        'contextlevel' => CONTEXT_SYSTEM,
        'archetypes' => array(
            'manager' => CAP_ALLOW
        )
    ),

    'local/documents:viewall' => array(
        'captype' => 'read',
        'contextlevel' => CONTEXT_SYSTEM,
        'archetypes' => array(
            'manager' => CAP_ALLOW
        )
    ),

);
```

### Implementación
```php
// En cada página, verificar permisos apropiados

// index.php
require_capability('local/documents:view', $context);

// upload.php
require_capability('local/documents:upload', $context);

// edit.php
require_capability('local/documents:edit', $context);

// También verificar ownership
$document = $DB->get_record('local_documents', array('id' => $id));

if ($document->userid != $USER->id &&
    !has_capability('local/documents:viewall', $context)) {
    print_error('nopermissions');
}

// Mostrar botones condicionalmente
if (has_capability('local/documents:edit', $context)) {
    echo $OUTPUT->single_button($editurl, 'Editar', 'get');
}

if (has_capability('local/documents:delete', $context)) {
    echo $OUTPUT->single_button($deleteurl, 'Eliminar', 'get');
}
```

---

## Ejercicio 5: Formulario con Elementos Dinámicos
**Nivel: Avanzado**

### Objetivo
Crear un formulario que cambie según las selecciones del usuario.

### Requisitos
1. Tipo de evento (select):
   - Conferencia
   - Taller
   - Webinar
   - Curso

2. Campos condicionales:
   - Si es "Conferencia": mostrar campo de ubicación física
   - Si es "Webinar": mostrar URL de zoom
   - Si es "Taller": mostrar capacidad y materiales requeridos
   - Si es "Curso": mostrar duración en semanas y costo

3. Usar hideIf() para mostrar/ocultar campos

### Código
```php
public function definition() {
    $mform = $this->_form;

    // Tipo de evento
    $tipos = array(
        'conferencia' => 'Conferencia',
        'taller' => 'Taller',
        'webinar' => 'Webinar',
        'curso' => 'Curso'
    );
    $mform->addElement('select', 'tipo', 'Tipo de Evento', $tipos);

    // Campos para Conferencia
    $mform->addElement('text', 'ubicacion', 'Ubicación Física');
    $mform->setType('ubicacion', PARAM_TEXT);
    $mform->hideIf('ubicacion', 'tipo', 'neq', 'conferencia');

    // Campos para Webinar
    $mform->addElement('text', 'zoom_url', 'URL de Zoom');
    $mform->setType('zoom_url', PARAM_URL);
    $mform->hideIf('zoom_url', 'tipo', 'neq', 'webinar');

    // Campos para Taller
    $mform->addElement('text', 'capacidad', 'Capacidad Máxima');
    $mform->setType('capacidad', PARAM_INT);
    $mform->hideIf('capacidad', 'tipo', 'neq', 'taller');

    $mform->addElement('textarea', 'materiales', 'Materiales Requeridos');
    $mform->setType('materiales', PARAM_TEXT);
    $mform->hideIf('materiales', 'tipo', 'neq', 'taller');

    // Campos para Curso
    $mform->addElement('text', 'duracion_semanas', 'Duración (semanas)');
    $mform->setType('duracion_semanas', PARAM_INT);
    $mform->hideIf('duracion_semanas', 'tipo', 'neq', 'curso');

    $mform->addElement('text', 'costo', 'Costo (USD)');
    $mform->setType('costo', PARAM_FLOAT);
    $mform->hideIf('costo', 'tipo', 'neq', 'curso');

    $this->add_action_buttons();
}

public function validation($data, $files) {
    $errors = parent::validation($data, $files);

    // Validar campos según tipo
    switch ($data['tipo']) {
        case 'conferencia':
            if (empty($data['ubicacion'])) {
                $errors['ubicacion'] = 'Ubicación requerida para conferencias';
            }
            break;

        case 'webinar':
            if (empty($data['zoom_url'])) {
                $errors['zoom_url'] = 'URL requerida para webinars';
            }
            break;

        case 'taller':
            if (empty($data['capacidad']) || $data['capacidad'] < 1) {
                $errors['capacidad'] = 'Capacidad inválida';
            }
            break;

        case 'curso':
            if (empty($data['duracion_semanas']) || $data['duracion_semanas'] < 1) {
                $errors['duracion_semanas'] = 'Duración inválida';
            }
            if (empty($data['costo']) || $data['costo'] < 0) {
                $errors['costo'] = 'Costo inválido';
            }
            break;
    }

    return $errors;
}
```

---

## Ejercicio 6: Notificaciones y Mensajes
**Nivel: Intermedio**

### Objetivo
Implementar sistema de notificaciones entre usuarios.

### Requisitos
1. Definir providers en db/messages.php:
```php
$messageproviders = array(
    'document_notification' => array(
        'capability' => 'local/documents:view',
        'defaults' => array(
            'popup' => MESSAGE_PERMITTED + MESSAGE_DEFAULT_LOGGEDIN,
            'email' => MESSAGE_PERMITTED
        )
    ),
);
```

2. Enviar notificación cuando:
   - Se comparte un documento contigo
   - Alguien comenta tu documento
   - Tu documento es aprobado/rechazado

3. Crear página de configuración de notificaciones

### Código para Enviar Mensaje
```php
function send_document_notification($fromuserid, $touserid, $documentid, $action) {
    global $DB;

    $document = $DB->get_record('local_documents', array('id' => $documentid));
    $fromuser = $DB->get_record('user', array('id' => $fromuserid));

    $message = new \core\message\message();
    $message->component = 'local_documents';
    $message->name = 'document_notification';
    $message->userfrom = $fromuser;
    $message->userto = $touserid;
    $message->subject = "Documento: {$document->title}";
    $message->fullmessage = "{$fromuser->firstname} {$action} el documento '{$document->title}'";
    $message->fullmessageformat = FORMAT_PLAIN;
    $message->fullmessagehtml = "<p><strong>{$fromuser->firstname}</strong> {$action} el documento <em>{$document->title}</em></p>";
    $message->smallmessage = "{$fromuser->firstname} {$action} un documento";
    $message->notification = 1;

    $message->contexturl = new \moodle_url('/local/documents/view.php', array('id' => $documentid));
    $message->contexturlname = 'Ver documento';

    message_send($message);
}
```

---

## Proyecto Integrador: Sistema de Gestión de Proyectos
**Nivel: Avanzado**

### Objetivo
Crear un sistema completo que integre todas las APIs aprendidas.

### Funcionalidades
1. **Gestión de Proyectos:**
   - Crear/editar/eliminar proyectos
   - Asignar miembros
   - Definir fechas y milestones
   - Subir archivos relacionados

2. **Tareas:**
   - Crear tareas dentro de proyectos
   - Asignar responsables
   - Estados (pendiente, en progreso, completada)
   - Comentarios en tareas

3. **Permisos:**
   - Project Manager (crear proyectos, asignar miembros)
   - Team Member (ver proyectos, crear tareas)
   - Viewer (solo lectura)

4. **Eventos:**
   - project_created, task_created, task_completed
   - Notificar a miembros del equipo
   - Log de actividad del proyecto

5. **Reportes:**
   - Dashboard de proyectos
   - Tareas por estado
   - Progreso por proyecto
   - Actividad por usuario

### Estructura de Archivos
```
/local/projectmgmt/
├── version.php
├── db/
│   ├── access.php (capabilities)
│   ├── messages.php (notifications)
│   ├── events.php (observers)
│   └── install.xml (tablas)
├── classes/
│   ├── event/ (clases de eventos)
│   └── observer.php
├── projects/
│   ├── index.php
│   ├── edit.php
│   ├── edit_form.php
│   └── view.php
├── tasks/
│   ├── index.php
│   ├── edit.php
│   └── edit_form.php
├── lib.php
└── lang/en/local_projectmgmt.php
```

---

## Checklist de Aprendizaje

Después de completar estos ejercicios, deberías poder:

- [ ] Crear formularios complejos con moodleform
- [ ] Implementar validación cliente y servidor
- [ ] Subir y gestionar archivos con File API
- [ ] Crear eventos personalizados
- [ ] Implementar observers para eventos
- [ ] Definir y verificar capabilities
- [ ] Trabajar con contextos
- [ ] Enviar notificaciones y mensajes
- [ ] Integrar múltiples APIs en un sistema completo

¡Éxito con los ejercicios!
