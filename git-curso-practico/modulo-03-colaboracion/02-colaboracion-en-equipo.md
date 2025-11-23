# Módulo 3: Colaboración y Trabajo Remoto - Colaboración en Equipo

## 📚 Nivel: Intermedio-Avanzado

---

## 🎯 Objetivos de esta lección

- Entender workflows de colaboración
- Fork y Pull Requests
- Code Review
- Trabajar en un proyecto open source
- Estrategias de branching en equipo

---

## 👥 Workflows de Colaboración

### Workflow 1: Centralized Workflow

**Equipo pequeño, todos con acceso al repositorio**

```
┌─────────────────────────┐
│  Repositorio Remoto     │
│  (origin/main)          │
└─────────────────────────┘
     ↕ push/pull
┌─────┐  ┌─────┐  ┌─────┐
│ Dev1│  │ Dev2│  │ Dev3│
└─────┘  └─────┘  └─────┘
```

**Flujo:**
```bash
# Developer 1
git pull origin main
# ... hacer cambios ...
git add .
git commit -m "feat: Nueva funcionalidad"
git push origin main

# Developer 2
git pull origin main
# ... hacer cambios ...
git add .
git commit -m "fix: Corregir bug"
git push origin main
```

**Ventajas:**
- ✅ Simple y directo
- ✅ Ideal para equipos pequeños

**Desventajas:**
- ❌ No hay revisión de código
- ❌ Fácil romper main

---

### Workflow 2: Feature Branch Workflow

**Cada feature en su propia rama**

```
main         A───────────B───────────C
              \         /           /
feature-1      D───E───F           /
                         \         /
feature-2                 G───H───I
```

**Flujo:**
```bash
# Developer 1: Nueva feature
git switch main
git pull origin main
git switch -c feature/login
# ... desarrollar ...
git add .
git commit -m "feat: Implementar login"
git push -u origin feature/login

# En GitHub/GitLab: Crear Pull Request
# Después de revisión y aprobación:
git switch main
git pull origin main  # Traer el merge del PR
git branch -d feature/login
```

**Ventajas:**
- ✅ main siempre estable
- ✅ Permite code review
- ✅ Desarrollo paralelo

**Desventajas:**
- ❌ Requiere disciplina

---

### Workflow 3: Gitflow (Equipos grandes)

```
main          ─────────────────●─────────  (Producción)
                               ↑
release       ──────────────●──┘
                            ↑
develop       ──●───────●──┘               (Desarrollo)
               ↑       ↑
feature-1     ─┴──●───┘
feature-2        ─┴──●───┘
```

**Ramas principales:**
- `main`: Código en producción
- `develop`: Código en desarrollo

**Ramas temporales:**
- `feature/*`: Nuevas funcionalidades
- `release/*`: Preparación de releases
- `hotfix/*`: Correcciones urgentes en producción

**Flujo:**
```bash
# Iniciar nueva feature
git switch develop
git pull origin develop
git switch -c feature/nueva-funcionalidad

# Desarrollar
git add .
git commit -m "feat: Parte 1 de funcionalidad"
git commit -m "feat: Parte 2 de funcionalidad"

# Finalizar feature
git switch develop
git merge feature/nueva-funcionalidad
git push origin develop
git branch -d feature/nueva-funcionalidad

# Crear release
git switch -c release/v1.2.0 develop
# ... ajustes finales, testing ...
git commit -m "chore: Preparar release v1.2.0"

# Finalizar release
git switch main
git merge release/v1.2.0
git tag v1.2.0
git push origin main --tags

git switch develop
git merge release/v1.2.0
git push origin develop
git branch -d release/v1.2.0
```

---

### Workflow 4: Fork Workflow (Open Source)

**Para contribuir a proyectos donde NO tienes acceso directo**

```
Repositorio Original (upstream)
     ↓ fork
Tu Fork (origin)
     ↓ clone
Tu Máquina Local
```

---

## 🍴 Fork y Pull Request

### Paso 1: Fork del Repositorio

```bash
# 1. Ir al repositorio original en GitHub
# 2. Click en "Fork" (arriba a la derecha)
# 3. Esto crea una copia en TU cuenta
```

### Paso 2: Clonar TU fork

```bash
# Clonar tu fork (no el original)
git clone https://github.com/TU-USUARIO/proyecto.git
cd proyecto

# Verificar remoto
git remote -v
# origin  https://github.com/TU-USUARIO/proyecto.git
```

### Paso 3: Añadir upstream (repositorio original)

```bash
# Añadir el repositorio original como "upstream"
git remote add upstream https://github.com/USUARIO-ORIGINAL/proyecto.git

# Verificar
git remote -v
# origin    https://github.com/TU-USUARIO/proyecto.git (fetch)
# origin    https://github.com/TU-USUARIO/proyecto.git (push)
# upstream  https://github.com/USUARIO-ORIGINAL/proyecto.git (fetch)
# upstream  https://github.com/USUARIO-ORIGINAL/proyecto.git (push)
```

### Paso 4: Crear rama y hacer cambios

```bash
# Actualizar desde upstream
git fetch upstream
git switch main
git merge upstream/main

# Crear rama para tu contribución
git switch -c fix/typo-in-readme

# Hacer cambios
echo "Corrección de typo" >> README.md
git add README.md
git commit -m "docs: Corregir typo en README"

# Push a TU fork
git push -u origin fix/typo-in-readme
```

### Paso 5: Crear Pull Request

```bash
# 1. Ir a GitHub, tu fork
# 2. Verás un mensaje: "fix/typo-in-readme had recent pushes"
# 3. Click en "Compare & pull request"
# 4. Llenar el formulario:
#    - Título: "docs: Corregir typo en README"
#    - Descripción: Explicar qué cambiaste y por qué
# 5. Click "Create pull request"
```

### Paso 6: Mantener tu fork actualizado

```bash
# Regularmente, sincroniza con upstream
git fetch upstream
git switch main
git merge upstream/main
git push origin main

# Tus ramas de feature también:
git switch mi-feature
git merge main  # Trae cambios de upstream
```

---

## 🔍 Code Review

### Qué revisar en un Pull Request

#### ✅ Checklist de Revisión

**Funcionalidad:**
- [ ] ¿El código hace lo que dice que hace?
- [ ] ¿Hay casos edge no considerados?
- [ ] ¿Los tests cubren la nueva funcionalidad?

**Calidad del código:**
- [ ] ¿El código es legible y está bien organizado?
- [ ] ¿Hay duplicación de código?
- [ ] ¿Los nombres de variables/funciones son descriptivos?

**Seguridad:**
- [ ] ¿Hay vulnerabilidades evidentes?
- [ ] ¿Se validan inputs de usuario?
- [ ] ¿Hay hardcoded credentials?

**Performance:**
- [ ] ¿Hay operaciones costosas innecesarias?
- [ ] ¿Se pueden optimizar queries/loops?

**Documentación:**
- [ ] ¿Hay comentarios donde son necesarios?
- [ ] ¿Se actualizó la documentación?
- [ ] ¿Los mensajes de commit son claros?

### Cómo dar feedback constructivo

#### ❌ MAL (Agresivo)
```
"Este código es terrible."
"¿Por qué lo hiciste así?"
"Esto está mal."
```

#### ✅ BIEN (Constructivo)
```
"Considera usar un Map aquí para mejor performance."
"¿Qué te parece extraer esto a una función? Sería más legible."
"Encontré un caso edge: ¿qué pasa si el array está vacío?"
```

### Responder a Code Review

```bash
# 1. Leer el feedback
# 2. Hacer cambios en tu rama local
git switch fix/typo-in-readme
# ... hacer cambios sugeridos ...
git add .
git commit -m "refactor: Aplicar sugerencias de code review"

# 3. Push (actualiza automáticamente el PR)
git push origin fix/typo-in-readme

# 4. Responder en GitHub
# - Agradecer el feedback
# - Explicar cambios realizados
# - Hacer preguntas si algo no está claro
```

---

## 🎯 Ejercicio Práctico 10: Flujo Completo de Colaboración

### Parte A: Contribuir a Proyecto Open Source (Simulado)

```bash
# === SIMULAR REPOSITORIO ORIGINAL ===
# (En la vida real, esto ya existe)

mkdir proyecto-original
cd proyecto-original
git init
git switch -c main

cat > README.md << 'EOF'
# Calculadora

Una calculadora simple en JavaScript.

## Funciones
- Suma
- Resta
EOF

cat > calculadora.js << 'EOF'
function sumar(a, b) {
    return a + b;
}

function restar(a, b) {
    return a - b;
}

module.exports = { sumar, restar };
EOF

git add .
git commit -m "Initial commit"

# === SIMULAR TU FORK ===
cd ..
mkdir mi-fork
cd mi-fork
git clone ../proyecto-original .

# Añadir upstream
cd ../mi-fork
git remote add upstream ../proyecto-original

# === TU CONTRIBUCIÓN ===

# 1. Crear rama para nueva funcionalidad
git switch -c feature/multiplicacion

# 2. Añadir funcionalidad
cat >> calculadora.js << 'EOF'

function multiplicar(a, b) {
    return a * b;
}

module.exports = { sumar, restar, multiplicar };
EOF

# Actualizar README
cat >> README.md << 'EOF'
- Multiplicación
EOF

# 3. Commit
git add .
git commit -m "feat: Añadir función de multiplicación"

# 4. "Push" (en la vida real sería a GitHub)
git push -u origin feature/multiplicacion

# === SIMULAR PULL REQUEST ===
# En GitHub:
# - Ir a tu fork
# - "New pull request"
# - Base: proyecto-original/main
# - Compare: mi-fork/feature/multiplicacion

# === DESPUÉS DE APROBACIÓN ===
# Mantén el PR actualizado si hay conflictos
git fetch upstream
git switch feature/multiplicacion
git merge upstream/main

# Resolver conflictos si hay
# git add .
# git commit
# git push origin feature/multiplicacion
```

### Parte B: Code Review (Simulado)

```bash
# === SIMULAR SER EL REVISOR ===

cd ../proyecto-original
git remote add colaborador ../mi-fork
git fetch colaborador

# Ver los cambios del PR
git diff main colaborador/feature/multiplicacion

# Ver commits
git log main..colaborador/feature/multiplicacion

# === SI APRUEBAS ===
git switch main
git merge colaborador/feature/multiplicacion
git commit -m "Merge pull request: Añadir multiplicación"

# === NOTIFICAR AL CONTRIBUIDOR ===
# En GitHub: "Approve" + "Merge pull request"
```

---

## 📋 Estrategias de Branching en Equipo

### Naming Conventions (Convenciones de Nombres)

```bash
# Estructura: tipo/descripcion-corta

# Features
feature/user-authentication
feature/payment-integration
feature/dark-mode

# Bugfixes
bugfix/fix-login-error
bugfix/correct-calculation
bugfix/handle-null-pointer

# Hotfixes
hotfix/security-patch
hotfix/critical-crash

# Releases
release/v1.2.0
release/v2.0.0-beta

# Docs
docs/update-readme
docs/api-documentation

# Refactor
refactor/simplify-auth
refactor/optimize-queries
```

### Protected Branches

En GitHub/GitLab, puedes proteger ramas:

```
Settings → Branches → Branch protection rules

Configuraciones recomendadas para main:
✅ Require pull request before merging
✅ Require approvals (1-2 reviewers)
✅ Require status checks to pass (CI/CD)
✅ Require branches to be up to date
✅ Do not allow force pushes
✅ Do not allow deletions
```

### Reglas del Equipo

**Ejemplo de reglas:**

```markdown
## Git Guidelines

### Commits
- Usar Conventional Commits (feat, fix, docs, etc.)
- Un commit = un cambio lógico
- Mensajes en inglés/español (decidir)

### Branches
- main: solo código que pasa CI y está revisado
- develop: código en desarrollo
- feature/*: nuevas funcionalidades
- bugfix/*: correcciones de bugs
- No push directo a main

### Pull Requests
- Al menos 1 aprobación requerida
- Tests deben pasar
- Code review obligatorio
- Resolver conflictos antes de merge
- Eliminar rama después de merge

### Code Review
- Ser constructivo y respetuoso
- Revisar en < 24 horas
- Hacer preguntas, no acusaciones
- Aprobar solo si todo está correcto
```

---

## 🔄 Sincronización en Equipo

### Escenario: Dos desarrolladores, misma rama

```bash
# Developer 1
git switch feature/nueva-ui
# ... hacer cambios ...
git add .
git commit -m "feat: Parte 1 de UI"
git push origin feature/nueva-ui

# Developer 2 (en la misma rama)
git switch feature/nueva-ui
git pull origin feature/nueva-ui  # Traer cambios de Dev1
# ... hacer más cambios ...
git add .
git commit -m "feat: Parte 2 de UI"
git push origin feature/nueva-ui

# Developer 1 (continuar trabajando)
git pull origin feature/nueva-ui  # Traer cambios de Dev2
# ... seguir trabajando ...
```

### Resolver conflictos en equipo

```bash
# Si hay conflictos al hacer pull
git pull origin feature/nueva-ui
# CONFLICT in archivo.js

# Resolver conflicto
# ... editar archivo.js ...
git add archivo.js
git commit -m "Merge: Resolver conflictos con cambios de Dev2"
git push origin feature/nueva-ui
```

---

## 💡 Mejores Prácticas de Colaboración

### ✅ HACER

1. **Pull antes de push**
   ```bash
   git pull origin main  # Siempre actualiza antes
   git push origin main
   ```

2. **Commits pequeños y frecuentes**
   ```bash
   # Mejor 5 commits pequeños que 1 gigante
   ```

3. **Comunicación clara**
   ```bash
   # En el mensaje del commit/PR, explica el "por qué"
   ```

4. **Tests antes de PR**
   ```bash
   npm test  # Asegura que todo funciona
   git push
   ```

5. **Revisar PRs rápidamente**
   ```bash
   # Objetivo: < 24 horas para no bloquear al equipo
   ```

### ❌ EVITAR

1. Force push a ramas compartidas
   ```bash
   # ❌ NUNCA hagas esto en ramas compartidas
   git push --force origin develop
   ```

2. Commits sin mensaje descriptivo
   ```bash
   # ❌ Mal
   git commit -m "fix"
   git commit -m "changes"

   # ✅ Bien
   git commit -m "fix: Corregir validación de email en registro"
   ```

3. PRs gigantes
   ```bash
   # ❌ PR con 50 archivos y 2000 líneas
   # ✅ PRs pequeños y enfocados
   ```

---

## ✅ Checklist

Antes de continuar, asegúrate de poder:

- [ ] Entender diferentes workflows (centralized, feature branch, gitflow)
- [ ] Hacer fork de un repositorio
- [ ] Crear y gestionar pull requests
- [ ] Hacer code review constructivo
- [ ] Mantener tu fork sincronizado con upstream
- [ ] Seguir convenciones de nombres de ramas
- [ ] Configurar y usar protected branches

---

## 📌 Resumen de Comandos

| Comando | Descripción |
|---------|-------------|
| `git remote add upstream <url>` | Añadir repositorio original |
| `git fetch upstream` | Descargar cambios de upstream |
| `git merge upstream/main` | Fusionar cambios de upstream |
| `git push origin rama` | Push a tu fork |
| `git diff main..feature` | Ver diferencias entre ramas |
| `git log main..feature` | Ver commits únicos en feature |

---

## ➡️ Siguiente Paso

¡Felicidades! Completaste el Módulo 3: Colaboración y Trabajo Remoto.

En el próximo módulo aprenderás técnicas avanzadas:
- Git rebase
- Cherry-pick
- Stash
- Hooks
- Aliases avanzados

¡Continúa con el **Módulo 4**: `../modulo-04-avanzado/01-rebase.md`!
