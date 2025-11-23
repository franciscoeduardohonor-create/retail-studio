# 🎓 Proyecto Final: Aplicación de Gestión de Tareas

## 📋 Descripción del Proyecto

Vamos a simular el desarrollo completo de una aplicación de gestión de tareas usando **todos los conceptos** aprendidos en el curso:

- ✅ Commits y branches
- ✅ Merge y resolución de conflictos
- ✅ Repositorios remotos
- ✅ Colaboración en equipo
- ✅ Rebase y limpieza de historial
- ✅ Técnicas avanzadas (stash, cherry-pick)

---

## 🎯 Objetivos del Proyecto

Al completar este proyecto, habrás:

1. Creado un repositorio desde cero
2. Trabajado con múltiples ramas
3. Resuelto conflictos
4. Usado técnicas avanzadas de Git
5. Simulado colaboración en equipo
6. Aplicado mejores prácticas profesionales

---

## 🚀 Fase 1: Configuración Inicial

### Paso 1.1: Crear el Proyecto

```bash
# Crear directorio del proyecto
mkdir todo-app
cd todo-app

# Inicializar Git
git init

# Crear estructura básica
mkdir -p src tests docs
touch README.md .gitignore

# Configurar .gitignore
cat > .gitignore << 'EOF'
# Dependencias
node_modules/
.venv/
venv/

# Logs
*.log
logs/

# Configuración local
.env
config.local.js

# Sistema operativo
.DS_Store
Thumbs.db

# IDE
.vscode/
.idea/
*.swp

# Build
dist/
build/
*.min.js
EOF
```

### Paso 1.2: README inicial

```bash
cat > README.md << 'EOF'
# 📝 Todo App

Una aplicación de gestión de tareas simple y eficiente.

## 📋 Características

- [ ] Añadir tareas
- [ ] Listar tareas
- [ ] Marcar como completada
- [ ] Eliminar tareas
- [ ] Filtrar tareas

## 🚀 Instalación

```bash
# Instrucciones próximamente
```

## 👥 Contribuidores

- Tu Nombre

## 📄 Licencia

MIT
EOF

git add .
git commit -m "chore: Configuración inicial del proyecto"
```

### Paso 1.3: Crear estructura de código base

```bash
# Archivo principal
cat > src/app.js << 'EOF'
// Todo App - Versión 1.0

const todos = [];

function mostrarBienvenida() {
    console.log('=== Todo App ===');
    console.log('Bienvenido a tu gestor de tareas');
}

mostrarBienvenida();

module.exports = { todos };
EOF

git add src/app.js
git commit -m "feat: Añadir estructura básica de la aplicación"
```

### Paso 1.4: Conectar con GitHub (Simulado)

```bash
# En la vida real, crearías un repo en GitHub y harías:
# git remote add origin https://github.com/tu-usuario/todo-app.git
# git push -u origin main

# Para este ejercicio, simulamos tener un remoto configurado
```

---

## 🌿 Fase 2: Desarrollo de Features (Branches)

### Paso 2.1: Feature - Añadir Tareas

```bash
# Crear rama feature
git switch -c feature/add-task

# Implementar funcionalidad
cat >> src/app.js << 'EOF'

function addTask(title, priority = 'normal') {
    const task = {
        id: Date.now(),
        title,
        priority,
        completed: false,
        createdAt: new Date().toISOString()
    };

    todos.push(task);
    console.log(`✅ Tarea añadida: ${title}`);
    return task;
}

module.exports = { todos, addTask };
EOF

# Crear test básico
cat > tests/test-add-task.js << 'EOF'
// Test simple para addTask
const { addTask, todos } = require('../src/app.js');

console.log('🧪 Test: Añadir tarea');
addTask('Comprar leche', 'alta');
console.log('Tareas:', todos);
console.log(todos.length === 1 ? '✅ PASS' : '❌ FAIL');
EOF

# Commits granulares
git add src/app.js
git commit -m "feat: Implementar función addTask"

git add tests/test-add-task.js
git commit -m "test: Añadir test para addTask"

# Actualizar README
cat >> README.md << 'EOF'

## 📖 Uso

```javascript
const { addTask } = require('./src/app.js');

addTask('Mi primera tarea', 'alta');
```
EOF

git add README.md
git commit -m "docs: Añadir ejemplo de uso de addTask"
```

### Paso 2.2: Feature - Listar Tareas

```bash
# Volver a main y crear nueva rama
git switch main
git switch -c feature/list-tasks

# Implementar
cat >> src/app.js << 'EOF'

function listTasks(filter = 'all') {
    console.log('\n📋 Lista de Tareas:\n');

    let filteredTasks = todos;

    if (filter === 'completed') {
        filteredTasks = todos.filter(t => t.completed);
    } else if (filter === 'pending') {
        filteredTasks = todos.filter(t => !t.completed);
    }

    if (filteredTasks.length === 0) {
        console.log('  No hay tareas');
        return;
    }

    filteredTasks.forEach((task, index) => {
        const status = task.completed ? '✅' : '⬜';
        const priority = task.priority === 'alta' ? '🔴' :
                        task.priority === 'media' ? '🟡' : '🟢';
        console.log(`  ${index + 1}. ${status} ${priority} ${task.title}`);
    });
}

module.exports = { todos, addTask, listTasks };
EOF

git add src/app.js
git commit -m "feat: Implementar función listTasks con filtros"

# Test
cat > tests/test-list-tasks.js << 'EOF'
const { addTask, listTasks, todos } = require('../src/app.js');

console.log('🧪 Test: Listar tareas');
addTask('Tarea 1', 'alta');
addTask('Tarea 2', 'baja');
listTasks();
console.log('✅ Test completado');
EOF

git add tests/test-list-tasks.js
git commit -m "test: Añadir test para listTasks"
```

### Paso 2.3: Feature - Completar Tareas

```bash
# Nueva feature branch
git switch main
git switch -c feature/complete-task

# Implementar
cat >> src/app.js << 'EOF'

function completeTask(taskId) {
    const task = todos.find(t => t.id === taskId);

    if (!task) {
        console.log('❌ Tarea no encontrada');
        return false;
    }

    task.completed = true;
    task.completedAt = new Date().toISOString();
    console.log(`✅ Tarea completada: ${task.title}`);
    return true;
}

module.exports = { todos, addTask, listTasks, completeTask };
EOF

git add src/app.js
git commit -m "feat: Implementar función completeTask"
```

---

## 🔀 Fase 3: Integración y Merge

### Paso 3.1: Merge de Features

```bash
# Ver todas las ramas
git branch
# * feature/complete-task
#   feature/add-task
#   feature/list-tasks
#   main

# Volver a main
git switch main

# Merge primera feature (Fast-forward)
git merge feature/add-task
# Debería ser fast-forward

# Merge segunda feature (3-way merge)
git merge feature/list-tasks
# Se crea commit de merge

# Merge tercera feature
git merge feature/complete-task

# Ver historial
git log --oneline --graph --all

# Limpiar ramas fusionadas
git branch -d feature/add-task
git branch -d feature/list-tasks
git branch -d feature/complete-task
```

---

## ⚔️ Fase 4: Conflictos Intencionados

### Paso 4.1: Crear conflicto

```bash
# Branch 1: Cambiar mensaje de bienvenida
git switch -c feature/new-welcome-message

sed -i "s/Bienvenido a tu gestor de tareas/¡Organiza tu vida con Todo App!/" src/app.js 2>/dev/null || \
sed -i '' "s/Bienvenido a tu gestor de tareas/¡Organiza tu vida con Todo App!/" src/app.js

git add src/app.js
git commit -m "feat: Mejorar mensaje de bienvenida"

# Branch 2: DIFERENTE cambio al mismo mensaje
git switch main
git switch -c feature/spanish-welcome

sed -i "s/Bienvenido a tu gestor de tareas/Bienvenido al mejor gestor de tareas/" src/app.js 2>/dev/null || \
sed -i '' "s/Bienvenido a tu gestor de tareas/Bienvenido al mejor gestor de tareas/" src/app.js

git add src/app.js
git commit -m "feat: Actualizar mensaje de bienvenida en español"
```

### Paso 4.2: Resolver conflicto

```bash
# Merge primer branch
git switch main
git merge feature/new-welcome-message
# Fast-forward, OK

# Merge segundo branch (¡CONFLICTO!)
git merge feature/spanish-welcome

# Salida:
# Auto-merging src/app.js
# CONFLICT (content): Merge conflict in src/app.js
# Automatic merge failed; fix conflicts and then commit the result.

# Ver el conflicto
cat src/app.js
# Verás marcadores <<<<<<<, =======, >>>>>>>

# Resolver el conflicto (elegir una versión o combinar)
# Editar src/app.js manualmente y combinar lo mejor de ambos:
# "¡Bienvenido al mejor gestor de tareas del mundo!"

# Marcar como resuelto
git add src/app.js

# Finalizar merge
git commit -m "Merge feature/spanish-welcome: Combinar mensajes de bienvenida"

# Limpiar
git branch -d feature/new-welcome-message
git branch -d feature/spanish-welcome
```

---

## 🎨 Fase 5: Rebase y Limpieza de Historial

### Paso 5.1: Crear commits "sucios"

```bash
# Nueva feature con commits desordenados
git switch -c feature/delete-task

# Implementación iterativa (commits WIP)
cat >> src/app.js << 'EOF'

function deleteTask(taskId) {
    // TODO: implementar
}

module.exports = { todos, addTask, listTasks, completeTask, deleteTask };
EOF

git add src/app.js
git commit -m "WIP delete task"

# Corrección
cat > src/app.js << 'EOF'
// Todo App - Versión 1.0

const todos = [];

function mostrarBienvenida() {
    console.log('=== Todo App ===');
    console.log('¡Bienvenido al mejor gestor de tareas del mundo!');
}

function addTask(title, priority = 'normal') {
    const task = {
        id: Date.now(),
        title,
        priority,
        completed: false,
        createdAt: new Date().toISOString()
    };

    todos.push(task);
    console.log(`✅ Tarea añadida: ${title}`);
    return task;
}

function listTasks(filter = 'all') {
    console.log('\n📋 Lista de Tareas:\n');

    let filteredTasks = todos;

    if (filter === 'completed') {
        filteredTasks = todos.filter(t => t.completed);
    } else if (filter === 'pending') {
        filteredTasks = todos.filter(t => !t.completed);
    }

    if (filteredTasks.length === 0) {
        console.log('  No hay tareas');
        return;
    }

    filteredTasks.forEach((task, index) => {
        const status = task.completed ? '✅' : '⬜';
        const priority = task.priority === 'alta' ? '🔴' :
                        task.priority === 'media' ? '🟡' : '🟢';
        console.log(`  ${index + 1}. ${status} ${priority} ${task.title}`);
    });
}

function completeTask(taskId) {
    const task = todos.find(t => t.id === taskId);

    if (!task) {
        console.log('❌ Tarea no encontrada');
        return false;
    }

    task.completed = true;
    task.completedAt = new Date().toISOString();
    console.log(`✅ Tarea completada: ${task.title}`);
    return true;
}

function deleteTask(taskId) {
    const index = todos.findIndex(t => t.id === taskId);

    if (index === -1) {
        console.log('❌ Tarea no encontrada');
        return false;
    }

    const task = todos.splice(index, 1)[0];
    console.log(`🗑️  Tarea eliminada: ${task.title}`);
    return true;
}

mostrarBienvenida();

module.exports = { todos, addTask, listTasks, completeTask, deleteTask };
EOF

git add src/app.js
git commit -m "implement delete"

# Más correcciones
git commit --allow-empty -m "fix typo"
git commit --allow-empty -m "another fix"
```

### Paso 5.2: Limpiar con rebase interactivo

```bash
# Ver commits sucios
git log --oneline
# a1a1a1a another fix
# b2b2b2b fix typo
# c3c3c3c implement delete
# d4d4d4d WIP delete task

# Rebase interactivo para limpiar
git rebase -i HEAD~4

# En el editor, cambiar a:
# pick d4d4d4d WIP delete task
# fixup c3c3c3c implement delete
# fixup b2b2b2b fix typo
# fixup d4d4d4d another fix
# reword (cambiar mensaje a: "feat: Implementar función deleteTask")

# Guardar y cerrar

# Ver historial limpio
git log --oneline
# Solo debería haber 1 commit con buen mensaje
```

### Paso 5.3: Actualizar con main (Rebase)

```bash
# Simular que main avanzó
git switch main
echo "## Changelog" >> README.md
git add README.md
git commit -m "docs: Añadir sección de changelog"

# Actualizar feature con rebase
git switch feature/delete-task
git rebase main

# Ver historial lineal
git log --oneline --graph --all

# Merge a main
git switch main
git merge feature/delete-task
git branch -d feature/delete-task
```

---

## 💼 Fase 6: Técnicas Avanzadas

### Paso 6.1: Usar Stash

```bash
# Empezar a trabajar en algo
git switch -c feature/priority-colors

echo "// TODO: implementar colores" >> src/app.js

# ¡Urgencia! Bug en main
git status  # Cambios sin commitear

# Guardar temporalmente
git stash save "WIP: Colores de prioridad"

# Arreglar bug
git switch main
git switch -c hotfix/console-error

# Simular fix
echo "// Fixed console error" >> src/app.js
git add src/app.js
git commit -m "hotfix: Corregir error en consola"

git switch main
git merge hotfix/console-error
git branch -d hotfix/console-error

# Volver al trabajo anterior
git switch feature/priority-colors
git stash list
git stash pop

# Continuar trabajando...
git restore src/app.js  # Descartar cambios de ejemplo
git switch main
git branch -D feature/priority-colors
```

### Paso 6.2: Cherry-Pick

```bash
# Crear feature con varios commits
git switch -c feature/experimental

# Commit 1: Útil
cat > src/utils.js << 'EOF'
function formatDate(date) {
    return new Date(date).toLocaleDateString('es-ES');
}

module.exports = { formatDate };
EOF

git add src/utils.js
git commit -m "feat: Añadir utilidad formatDate"

# Commit 2: Experimental (no queremos en main)
cat >> src/utils.js << 'EOF'

function experimentalFeature() {
    // Código experimental no probado
    return 'experimental';
}

module.exports = { formatDate, experimentalFeature };
EOF

git add src/utils.js
git commit -m "exp: Función experimental"

# Commit 3: Otra función útil
cat >> src/utils.js << 'EOF'

function validateTaskTitle(title) {
    return title && title.trim().length > 0;
}

module.exports = { formatDate, experimentalFeature, validateTaskTitle };
EOF

git add src/utils.js
git commit -m "feat: Añadir validación de título"

# Cherry-pick solo los commits útiles a main
git switch main

# Identificar hashes (reemplaza con los reales)
# git log --oneline feature/experimental

# Cherry-pick commit 1 y 3 (saltar el experimental)
git cherry-pick <hash-commit-1>
git cherry-pick <hash-commit-3>

# Verificar que solo tenemos las funciones útiles
cat src/utils.js
# Debe tener formatDate y validateTaskTitle, pero NO experimentalFeature
```

---

## 📊 Fase 7: Documentación y Tests

### Paso 7.1: Documentación completa

```bash
git switch -c docs/complete-readme

# Actualizar README
cat > README.md << 'EOF'
# 📝 Todo App

Una aplicación de gestión de tareas simple, eficiente y completa.

## ✨ Características

- ✅ Añadir tareas con diferentes prioridades
- ✅ Listar tareas con filtros (todas, completadas, pendientes)
- ✅ Marcar tareas como completadas
- ✅ Eliminar tareas
- ✅ Validación de datos
- ✅ Utilidades de formato

## 🚀 Instalación

```bash
git clone https://github.com/tu-usuario/todo-app.git
cd todo-app
node src/app.js
```

## 📖 Uso

```javascript
const { addTask, listTasks, completeTask, deleteTask } = require('./src/app.js');

// Añadir tareas
const task1 = addTask('Comprar leche', 'alta');
const task2 = addTask('Llamar al médico', 'media');
const task3 = addTask('Leer libro', 'baja');

// Listar todas las tareas
listTasks();

// Completar tarea
completeTask(task1.id);

// Listar solo pendientes
listTasks('pending');

// Eliminar tarea
deleteTask(task3.id);
```

## 🧪 Tests

```bash
# Ejecutar tests
node tests/test-add-task.js
node tests/test-list-tasks.js
```

## 📁 Estructura del Proyecto

```
todo-app/
├── src/
│   ├── app.js         # Aplicación principal
│   └── utils.js       # Utilidades
├── tests/
│   ├── test-add-task.js
│   └── test-list-tasks.js
├── docs/
├── README.md
└── .gitignore
```

## 👥 Contribuidores

- Tu Nombre - Desarrollo inicial

## 🤝 Contribuir

1. Fork del proyecto
2. Crear feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit de cambios (`git commit -m 'feat: Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abrir Pull Request

## 📋 Changelog

### [1.0.0] - 2024-11-23

#### Añadido
- Función para añadir tareas
- Función para listar tareas con filtros
- Función para completar tareas
- Función para eliminar tareas
- Validación de títulos
- Utilidades de formato de fechas

## 📄 Licencia

MIT License - ve LICENSE para más detalles

## 🙏 Agradecimientos

- Curso Práctico de Git
- Comunidad de desarrolladores

---

⭐ Si este proyecto te ayudó, considera darle una estrella en GitHub
EOF

git add README.md
git commit -m "docs: Documentación completa del proyecto"

git switch main
git merge docs/complete-readme
git branch -d docs/complete-readme
```

---

## 🎉 Fase 8: Release y Finalización

### Paso 8.1: Preparar Release

```bash
# Crear tag para la versión 1.0.0
git tag -a v1.0.0 -m "Release versión 1.0.0

Características principales:
- Gestión completa de tareas
- Filtros y validaciones
- Documentación completa
- Tests implementados"

# Ver tags
git tag
git show v1.0.0

# En la vida real, harías push del tag:
# git push origin v1.0.0
# git push --tags
```

### Paso 8.2: Ver todo el trabajo realizado

```bash
# Ver historial completo
git log --oneline --graph --all --decorate

# Ver estadísticas
git shortlog -sn

# Ver archivos del proyecto
ls -R

# Ejecutar la aplicación
node src/app.js
```

---

## 📝 Checklist del Proyecto

### Conceptos Aplicados

- [x] Configuración inicial de Git
- [x] Commits con mensajes claros (Conventional Commits)
- [x] Múltiples branches para features
- [x] Merge (fast-forward y 3-way)
- [x] Resolución de conflictos
- [x] Rebase interactivo para limpiar historial
- [x] Stash para guardar trabajo temporal
- [x] Cherry-pick para aplicar commits específicos
- [x] Tags para versiones
- [x] .gitignore configurado
- [x] README completo
- [x] Tests básicos
- [x] Estructura de proyecto profesional

---

## 🎯 Desafíos Adicionales

Si quieres ir más allá:

### Desafío 1: Implementar Tests Completos
```bash
# Crear suite de tests completa
# Usar git bisect para encontrar un bug que introduzcas intencionalmente
```

### Desafío 2: Simular Colaboración
```bash
# Crea un segundo repositorio (simulando otro desarrollador)
# Practica pull requests entre repositorios
# Practica merge conflicts y resolución en equipo
```

### Desafío 3: Workflow GitFlow Completo
```bash
# Implementa GitFlow workflow:
# - rama develop
# - ramas feature
# - ramas release
# - hotfixes
```

### Desafío 4: Conectar con GitHub Real
```bash
# Sube este proyecto a GitHub
# Haz issues reales
# Crea pull requests
# Invita a un amigo a colaborar
```

---

## 📊 Evaluación del Proyecto

### Has completado exitosamente si:

- ✅ El proyecto tiene un historial limpio y legible
- ✅ Todos los merges se realizaron correctamente
- ✅ Los conflictos se resolvieron apropiadamente
- ✅ Usaste rebase para limpiar commits
- ✅ El README documenta todo el proyecto
- ✅ El código funciona y está organizado
- ✅ Aplicaste convenciones de commits
- ✅ El proyecto tiene estructura profesional

---

## 🎓 ¡Felicidades!

Has completado el proyecto final del curso de Git. Has aplicado:

- 🎯 Fundamentos de Git
- 🌿 Trabajo con ramas
- 🔀 Merge y conflictos
- 🌐 Colaboración (simulada)
- 🚀 Técnicas avanzadas

Ahora estás listo para:
- Trabajar en proyectos reales
- Colaborar en equipos
- Contribuir a open source
- Usar Git profesionalmente

---

## 📚 Próximos Pasos

1. **Aplica estos conocimientos** en tus proyectos personales
2. **Contribuye a proyectos open source** en GitHub
3. **Enseña a otros** lo que aprendiste
4. **Explora temas avanzados**: Git Hooks, Submodules, Git LFS
5. **Practica continuamente** - Git mejora con la práctica

---

**¡Gracias por completar el curso!** 🎉

_Si este proyecto te ayudó, considera compartirlo con otros desarrolladores._
