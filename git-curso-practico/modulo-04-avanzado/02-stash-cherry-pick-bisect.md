# Módulo 4: Técnicas Avanzadas - Stash, Cherry-Pick y Bisect

## 📚 Nivel: Avanzado

---

## 🎯 Objetivos de esta lección

- Guardar cambios temporalmente con stash
- Aplicar commits específicos con cherry-pick
- Encontrar bugs con git bisect
- Casos de uso prácticos de cada herramienta

---

## 📦 Git Stash: Guardar Cambios Temporalmente

### ¿Qué es Stash?

**Stash** guarda temporalmente cambios no commiteados para que puedas trabajar en otra cosa.

**Escenario común:**
```
Estás trabajando en feature-A...
De repente: "¡Bug crítico en producción! ¡Arréglalo ya!"
Pero tienes cambios sin commitear en feature-A
```

---

### Stash Básico

```bash
# 1. Estás trabajando en algo
git switch feature/nueva-funcionalidad
echo "Trabajo a medias" >> archivo.txt
echo "Más código incompleto" >> otro.txt

# Ver estado
git status
# Changes not staged for commit:
#   modified:   archivo.txt
#   modified:   otro.txt

# 2. ¡Necesitas cambiar de rama urgente!
git stash
# Saved working directory and index state WIP on feature/nueva-funcionalidad

# 3. Working directory ahora está limpio
git status
# On branch feature/nueva-funcionalidad
# nothing to commit, working tree clean

# 4. Puedes cambiar de rama
git switch main

# 5. Arreglar el bug urgente
# ... fix ...
git add .
git commit -m "hotfix: Corregir bug crítico"

# 6. Volver a tu trabajo
git switch feature/nueva-funcionalidad

# 7. Recuperar tus cambios guardados
git stash pop

# ¡Tus cambios vuelven!
cat archivo.txt
# ... incluye "Trabajo a medias"
```

---

### Comandos de Stash

#### Guardar stash

```bash
# Stash básico
git stash

# Stash con mensaje descriptivo
git stash save "WIP: Implementando login"

# Stash incluyendo archivos untracked
git stash -u

# Stash incluyendo archivos ignored
git stash -a
```

#### Ver stashes guardados

```bash
# Listar stashes
git stash list

# Salida:
# stash@{0}: WIP on feature: a1b2c3d Implementando login
# stash@{1}: WIP on main: d4e5f6g Fix typo
# stash@{2}: WIP on develop: g7h8i9j Update docs
```

#### Aplicar stash

```bash
# Aplicar el stash más reciente y eliminarlo
git stash pop

# Aplicar stash específico
git stash pop stash@{1}

# Aplicar stash pero NO eliminarlo
git stash apply

# Aplicar stash específico sin eliminarlo
git stash apply stash@{2}
```

#### Ver contenido de stash

```bash
# Ver cambios en el stash más reciente
git stash show

# Ver cambios detallados
git stash show -p

# Ver stash específico
git stash show stash@{1} -p
```

#### Eliminar stashes

```bash
# Eliminar stash más reciente
git stash drop

# Eliminar stash específico
git stash drop stash@{1}

# Eliminar TODOS los stashes
git stash clear
```

---

### 🎯 Ejercicio Práctico 13: Usar Stash

```bash
# === ESCENARIO: Trabajo interrumpido ===
mkdir practica-stash
cd practica-stash
git init

# Commit inicial
echo "# App" > README.md
git add README.md
git commit -m "Initial commit"

# Trabajar en feature
git switch -c feature/dashboard

cat > dashboard.js << 'EOF'
// Dashboard component
function renderDashboard() {
    // TODO: Implementar
}
EOF

cat > styles.css << 'EOF'
.dashboard {
    /* Estilos incompletos */
}
EOF

# Ver estado (cambios sin commitear)
git status

# === INTERRUPCIÓN: Bug urgente ===
# Necesitas cambiar a main AHORA

# Stash tus cambios
git stash save "WIP: Dashboard component y estilos"

# Verificar que está limpio
git status
# working tree clean

# Cambiar a main
git switch main

# === ARREGLAR BUG ===
echo "console.log('Bug fix');" > hotfix.js
git add hotfix.js
git commit -m "hotfix: Corregir bug crítico"

# === VOLVER AL TRABAJO ===
git switch feature/dashboard

# Ver stashes disponibles
git stash list
# stash@{0}: On feature/dashboard: WIP: Dashboard component y estilos

# Recuperar trabajo
git stash pop

# Verificar que tus archivos volvieron
cat dashboard.js
cat styles.css

# Continuar trabajando...
```

---

### Casos de Uso Avanzados de Stash

#### Crear rama desde stash

```bash
# Tienes cambios en stash
git stash

# Crear nueva rama con esos cambios
git stash branch nueva-rama-desde-stash

# Crea la rama y aplica el stash automáticamente
```

#### Stash parcial

```bash
# Stash interactivo (elige qué guardar)
git stash -p

# Git preguntará por cada cambio:
# Stash this hunk [y,n,q,a,d,e,?]?
# y = yes (guardar este cambio)
# n = no (no guardar este cambio)
# q = quit (terminar)
# a = all (guardar todos los restantes)
```

---

## 🍒 Git Cherry-Pick: Aplicar Commits Específicos

### ¿Qué es Cherry-Pick?

**Cherry-pick** aplica un commit específico de una rama a otra, sin fusionar toda la rama.

```
Tienes:
         A---B---C  (main)
              \
               D---E---F  (feature)

Cherry-pick E a main:
         A---B---C---E'  (main)
              \
               D---E---F  (feature)

Solo E se aplica en main (como E', un nuevo commit)
```

---

### Cherry-Pick Básico

```bash
# 1. Identificar el commit que quieres
git log --oneline feature/nueva-funcionalidad
# a1b2c3d feat: Función útil
# b2c3d4e WIP: Trabajo incompleto
# c3d4e5f fix: Bug fix importante

# 2. Cambiar a la rama destino
git switch main

# 3. Cherry-pick el commit específico
git cherry-pick c3d4e5f

# Salida:
# [main d4e5f6g] fix: Bug fix importante
# 1 file changed, 5 insertions(+)
```

---

### 🎯 Ejercicio Práctico 14: Cherry-Pick

```bash
# === CREAR ESCENARIO ===
mkdir practica-cherry-pick
cd practica-cherry-pick
git init

# Main branch
cat > app.js << 'EOF'
console.log('App v1.0');
EOF
git add app.js
git commit -m "Initial commit"

# === FEATURE BRANCH ===
git switch -c feature/experimental

# Commit 1: Útil
cat >> app.js << 'EOF'

function utilFunction() {
    return 'Muy útil';
}
EOF
git add app.js
git commit -m "feat: Añadir función útil"

# Commit 2: Experimental (no queremos en main)
cat >> app.js << 'EOF'

function experimental() {
    // Código experimental, no probado
}
EOF
git add app.js
git commit -m "exp: Código experimental"

# Commit 3: Bug fix importante
cat >> app.js << 'EOF'

function fixedBug() {
    // Este fix es importante
}
EOF
git add app.js
git commit -m "fix: Corregir bug importante"

# Ver commits
git log --oneline
# c3c3c3c fix: Corregir bug importante  ← Queremos este
# b2b2b2b exp: Código experimental      ← NO queremos
# a1a1a1a feat: Añadir función útil     ← Queremos este

# === CHERRY-PICK A MAIN ===
git switch main

# Cherry-pick solo los commits que queremos
git cherry-pick a1a1a1a  # Función útil
git cherry-pick c3c3c3c  # Bug fix

# Verificar en main
cat app.js
# Tiene: App v1.0, función útil, bug fix
# NO tiene: código experimental

# Ver historial
git log --oneline
# d4'd4'd4' fix: Corregir bug importante
# a1'a1'a1' feat: Añadir función útil
# inicial Initial commit
```

---

### Cherry-Pick Múltiples Commits

```bash
# Cherry-pick múltiples commits en orden
git cherry-pick a1b2c3d b2c3d4e c3d4e5f

# Cherry-pick rango de commits
git cherry-pick a1b2c3d..c3d4e5f

# Cherry-pick sin hacer commit automáticamente
git cherry-pick --no-commit a1b2c3d
# Permite revisar cambios antes de commitear
git commit -m "Mensaje personalizado"
```

---

### Resolver Conflictos en Cherry-Pick

```bash
# Si hay conflicto al hacer cherry-pick
git cherry-pick a1b2c3d
# CONFLICT (content): Merge conflict in archivo.js

# 1. Resolver conflicto
# Editar archivo.js

# 2. Añadir archivos resueltos
git add archivo.js

# 3. Continuar cherry-pick
git cherry-pick --continue

# O abortar si hay problemas
git cherry-pick --abort
```

---

## 🔍 Git Bisect: Encontrar Bugs con Búsqueda Binaria

### ¿Qué es Bisect?

**Bisect** usa búsqueda binaria para encontrar qué commit introdujo un bug.

```
Tienes 100 commits:
Commit 1: ✅ Funciona
Commit 100: ❌ Bug

Bisect hace búsqueda binaria:
1. Prueba commit 50 → ❌ Bug
2. Prueba commit 25 → ✅ Funciona
3. Prueba commit 37 → ❌ Bug
4. Prueba commit 31 → ✅ Funciona
5. Prueba commit 34 → ❌ Bug
6. Prueba commit 32 → ✅ Funciona
7. Prueba commit 33 → ❌ Bug encontrado!

En solo 7 pruebas encontraste el commit problemático
(vs 100 pruebas manualmente)
```

---

### Bisect Manual

```bash
# 1. Iniciar bisect
git bisect start

# 2. Marcar commit actual como malo
git bisect bad

# 3. Marcar un commit antiguo que funcionaba
git bisect good a1b2c3d

# Git hace checkout a un commit en el medio
# Bisecting: 50 revisions left to test

# 4. Probar si funciona
# ... ejecutar tests, probar app ...

# 5a. Si funciona:
git bisect good

# 5b. Si tiene el bug:
git bisect bad

# 6. Repetir hasta encontrar el commit culpable

# Git dirá:
# a1b2c3d is the first bad commit
# commit a1b2c3d
# Author: ...
# Date: ...
#     Mensaje del commit que introdujo el bug

# 7. Terminar bisect
git bisect reset
```

---

### Bisect Automático

```bash
# Si tienes un script que puede verificar automáticamente
git bisect start
git bisect bad
git bisect good a1b2c3d

# Ejecutar script automáticamente
git bisect run ./test.sh

# test.sh debe:
# - Exit 0 si el commit es bueno
# - Exit 1 si el commit es malo

# Git probará automáticamente hasta encontrar el bug
```

---

### 🎯 Ejercicio Práctico 15: Bisect

```bash
# === CREAR HISTORIAL CON BUG ===
mkdir practica-bisect
cd practica-bisect
git init

# Crear función que funciona
cat > calc.js << 'EOF'
function sumar(a, b) {
    return a + b;
}
module.exports = { sumar };
EOF
git add calc.js
git commit -m "Commit 1: Añadir función sumar"

# Más commits correctos
for i in {2..5}; do
    echo "// Versión $i" >> calc.js
    git add calc.js
    git commit -m "Commit $i: Actualización"
done

# Commit 6: Introducir bug
cat > calc.js << 'EOF'
function sumar(a, b) {
    return a - b;  // BUG! Debería ser +
}
module.exports = { sumar };
EOF
git add calc.js
git commit -m "Commit 6: Refactorizar"

# Más commits
for i in {7..10}; do
    echo "// Versión $i" >> calc.js
    git add calc.js
    git commit -m "Commit $i: Más cambios"
done

# Ver historial
git log --oneline

# === USAR BISECT PARA ENCONTRAR BUG ===

# Crear script de test
cat > test.sh << 'EOF'
#!/bin/bash
node -e "const calc = require('./calc.js'); process.exit(calc.sumar(2, 3) === 5 ? 0 : 1)"
EOF
chmod +x test.sh

# Iniciar bisect
git bisect start

# Marcar actual como malo
git bisect bad

# Marcar commit 1 como bueno (obtener hash)
GOOD_COMMIT=$(git log --oneline | tail -1 | awk '{print $1}')
git bisect good $GOOD_COMMIT

# Bisect automático
git bisect run ./test.sh

# Git encontrará: "Commit 6: Refactorizar is the first bad commit"

# Terminar bisect
git bisect reset

# Ver el commit problemático
git show <hash-del-commit-6>
```

---

## 📊 Casos de Uso Prácticos

### Stash

```
✅ Cambiar de contexto rápidamente
✅ Probar algo sin commitear
✅ Limpiar working directory temporalmente
✅ Guardar cambios antes de pull/rebase
```

### Cherry-Pick

```
✅ Aplicar hotfix de una rama a otra
✅ Portar feature específica entre branches
✅ Rescatar commit de rama que se va a eliminar
✅ Aplicar commit a múltiples ramas (release branches)
```

### Bisect

```
✅ Encontrar cuándo se introdujo un bug
✅ Identificar regresiones en tests
✅ Debugging de problemas de performance
✅ Encontrar cuándo cambió un comportamiento
```

---

## 💡 Tips y Trucos

### Stash como backup temporal

```bash
# Antes de operación arriesgada
git stash
# ... operación ...
git stash pop  # Si salió bien
# o
git stash clear  # Si no lo necesitas
```

### Cherry-pick desde otro repositorio

```bash
# Añadir otro repo como remoto
git remote add other-repo https://github.com/user/repo.git
git fetch other-repo

# Cherry-pick commit de otro repo
git cherry-pick other-repo/main~2
```

### Bisect con múltiples criterios

```bash
# Si no es solo "bueno/malo", puedes usar skip
git bisect skip  # Cuando no puedes determinar
```

---

## ✅ Checklist

Antes de continuar, asegúrate de poder:

- [ ] Guardar cambios temporalmente con `git stash`
- [ ] Recuperar cambios con `git stash pop`
- [ ] Ver y gestionar múltiples stashes
- [ ] Aplicar commits específicos con `git cherry-pick`
- [ ] Encontrar bugs con `git bisect`
- [ ] Usar bisect automático con scripts
- [ ] Saber cuándo usar cada herramienta

---

## 📌 Resumen de Comandos

### Stash
| Comando | Descripción |
|---------|-------------|
| `git stash` | Guardar cambios temporalmente |
| `git stash save "mensaje"` | Stash con mensaje |
| `git stash list` | Ver stashes guardados |
| `git stash pop` | Aplicar y eliminar último stash |
| `git stash apply` | Aplicar sin eliminar |
| `git stash drop` | Eliminar stash |
| `git stash clear` | Eliminar todos |

### Cherry-Pick
| Comando | Descripción |
|---------|-------------|
| `git cherry-pick <hash>` | Aplicar commit específico |
| `git cherry-pick <hash1> <hash2>` | Múltiples commits |
| `git cherry-pick --continue` | Continuar tras conflicto |
| `git cherry-pick --abort` | Cancelar cherry-pick |

### Bisect
| Comando | Descripción |
|---------|-------------|
| `git bisect start` | Iniciar bisect |
| `git bisect good <hash>` | Marcar como bueno |
| `git bisect bad` | Marcar como malo |
| `git bisect run <script>` | Bisect automático |
| `git bisect reset` | Terminar bisect |

---

## ➡️ Siguiente Paso

¡Felicidades! Completaste las lecciones avanzadas principales.

Explora también:
- Git hooks (automatización)
- Git aliases (comandos personalizados)
- Git submodules (proyectos anidados)
- Mejores prácticas y workflows

¡Revisa el índice principal del curso en `../README.md`!
