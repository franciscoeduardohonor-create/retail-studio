# 📋 Git Cheat Sheet - Referencia Rápida

Una guía de referencia rápida con los comandos más usados de Git.

---

## 🚀 Configuración Inicial

```bash
# Configurar identidad
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"

# Ver configuración
git config --list
git config user.name

# Configurar editor
git config --global core.editor "code"

# Alias útiles
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.lg "log --oneline --graph --all"
```

---

## 📦 Crear Repositorios

```bash
# Crear nuevo repositorio
git init

# Clonar repositorio existente
git clone https://github.com/usuario/repo.git

# Clonar con nombre diferente
git clone https://github.com/usuario/repo.git mi-carpeta

# Clonar solo la última versión (más rápido)
git clone --depth 1 https://github.com/usuario/repo.git
```

---

## 📝 Cambios Básicos

```bash
# Ver estado de archivos
git status
git status -s  # Formato corto

# Añadir archivos al staging
git add archivo.txt
git add .               # Todos los archivos
git add *.js            # Todos los .js
git add carpeta/        # Toda una carpeta

# Hacer commit
git commit -m "Mensaje descriptivo"
git commit -am "Mensaje"  # Add + commit (solo archivos rastreados)

# Ver diferencias
git diff                  # Working dir vs staging
git diff --staged         # Staging vs último commit
git diff archivo.txt      # Archivo específico
```

---

## 📜 Historial

```bash
# Ver historial
git log
git log --oneline                    # Resumido
git log --oneline --graph --all      # Con gráfico
git log -5                           # Últimos 5 commits
git log --author="Nombre"            # Por autor
git log --since="2024-01-01"         # Por fecha
git log --grep="fix"                 # Buscar en mensajes

# Ver cambios de un commit
git show a1b2c3d
git show HEAD
git show HEAD~2  # 2 commits atrás

# Ver quién modificó cada línea
git blame archivo.txt

# Ver historial de un archivo
git log -p archivo.txt
```

---

## 🔄 Deshacer Cambios

```bash
# Descartar cambios en working directory
git restore archivo.txt
git restore .  # Todos los archivos

# Quitar archivos del staging
git restore --staged archivo.txt

# Modificar último commit
git commit --amend -m "Nuevo mensaje"
git commit --amend --no-edit  # Mantener mensaje

# Volver a commit anterior
git reset --soft HEAD~1   # Mantiene staging y working dir
git reset HEAD~1          # Mantiene working dir
git reset --hard HEAD~1   # ELIMINA TODO (PELIGROSO)

# Revertir commit (crea nuevo commit)
git revert a1b2c3d

# Recuperar commits "perdidos"
git reflog
git reset --hard a1b2c3d
```

---

## 🌿 Ramas (Branches)

```bash
# Ver ramas
git branch              # Locales
git branch -a           # Todas (locales + remotas)
git branch -r           # Solo remotas
git branch -v           # Con último commit

# Crear rama
git branch nombre-rama
git switch -c nombre-rama   # Crear y cambiar
git checkout -b nombre-rama # (método antiguo)

# Cambiar de rama
git switch nombre-rama
git switch -             # Volver a la anterior
git checkout nombre-rama # (método antiguo)

# Eliminar rama
git branch -d nombre-rama   # Seguro (si está fusionada)
git branch -D nombre-rama   # Forzado

# Renombrar rama
git branch -m nuevo-nombre
git branch -m viejo nuevo   # Renombrar otra rama

# Ver ramas fusionadas
git branch --merged
git branch --no-merged
```

---

## 🔀 Fusionar (Merge)

```bash
# Fusionar rama en la actual
git merge nombre-rama

# Fusionar sin fast-forward (siempre crea commit de merge)
git merge --no-ff nombre-rama

# Fusionar solo si es fast-forward
git merge --ff-only nombre-rama

# Abortar merge
git merge --abort

# Ver commits de merge
git log --merges
```

---

## ⚔️ Resolver Conflictos

```bash
# Ver archivos con conflicto
git status

# Ver diferencias
git diff

# Después de resolver manualmente
git add archivo-resuelto
git commit  # Finalizar merge

# Herramienta de merge
git mergetool

# Usar "nuestra" versión
git checkout --ours archivo.txt

# Usar "su" versión
git checkout --theirs archivo.txt
```

---

## 🌐 Remotos

```bash
# Ver remotos
git remote
git remote -v
git remote show origin

# Añadir remoto
git remote add origin https://github.com/usuario/repo.git

# Cambiar URL del remoto
git remote set-url origin https://github.com/usuario/nuevo-repo.git

# Renombrar remoto
git remote rename origin principal

# Eliminar remoto
git remote remove nombre-remoto
```

---

## ⬆️⬇️ Push y Pull

```bash
# Push (subir cambios)
git push origin main
git push -u origin rama      # Primera vez (establece upstream)
git push                     # Después de -u
git push --all origin        # Todas las ramas
git push --tags              # Subir tags
git push origin --delete rama # Eliminar rama remota

# Pull (descargar y fusionar)
git pull origin main
git pull                     # Con upstream configurado
git pull --rebase            # Pull con rebase

# Fetch (solo descargar, sin fusionar)
git fetch origin
git fetch --all              # Todos los remotos
```

---

## 🏷️ Tags

```bash
# Listar tags
git tag
git tag -l "v1.*"  # Filtrar

# Crear tag ligero
git tag v1.0.0

# Crear tag anotado (recomendado)
git tag -a v1.0.0 -m "Versión 1.0.0"

# Tag en commit específico
git tag -a v1.0.0 a1b2c3d -m "Mensaje"

# Ver información del tag
git show v1.0.0

# Push de tags
git push origin v1.0.0
git push --tags

# Eliminar tag
git tag -d v1.0.0              # Local
git push origin --delete v1.0.0 # Remoto

# Checkout de tag
git checkout v1.0.0
```

---

## 📦 Stash (Guardar temporalmente)

```bash
# Guardar cambios
git stash
git stash save "Mensaje descriptivo"
git stash -u  # Incluir archivos untracked

# Ver stashes
git stash list

# Aplicar stash
git stash pop        # Aplicar y eliminar
git stash pop stash@{2}  # Stash específico
git stash apply      # Aplicar sin eliminar

# Ver contenido
git stash show
git stash show -p    # Ver diff

# Eliminar stash
git stash drop stash@{0}
git stash clear      # Todos

# Crear rama desde stash
git stash branch nueva-rama
```

---

## 🔄 Rebase

```bash
# Rebase básico
git rebase main

# Rebase interactivo
git rebase -i HEAD~5
git rebase -i a1b2c3d

# Durante rebase
git rebase --continue  # Después de resolver conflictos
git rebase --skip      # Saltar commit
git rebase --abort     # Cancelar rebase

# Rebase automático en pull
git pull --rebase
git config --global pull.rebase true  # Por defecto

# Comandos en rebase interactivo
# pick    = usar commit
# reword  = editar mensaje
# edit    = pausar para modificar
# squash  = combinar con anterior (mantener mensaje)
# fixup   = combinar con anterior (descartar mensaje)
# drop    = eliminar commit
```

---

## 🍒 Cherry-Pick

```bash
# Aplicar commit específico
git cherry-pick a1b2c3d

# Múltiples commits
git cherry-pick a1b2c3d b2c3d4e

# Rango de commits
git cherry-pick a1b2c3d..c3d4e5f

# Sin hacer commit automáticamente
git cherry-pick --no-commit a1b2c3d

# Durante cherry-pick
git cherry-pick --continue
git cherry-pick --abort
```

---

## 🔍 Bisect (Encontrar bugs)

```bash
# Iniciar bisect
git bisect start
git bisect bad           # Commit actual es malo
git bisect good a1b2c3d  # Este commit era bueno

# Marcar commits
git bisect good  # El commit actual es bueno
git bisect bad   # El commit actual es malo
git bisect skip  # No se puede determinar

# Bisect automático
git bisect run ./test.sh

# Terminar bisect
git bisect reset
```

---

## 🛠️ Herramientas Útiles

```bash
# Ver cambios resumidos
git diff --stat

# Ver archivos cambiados
git diff --name-only

# Buscar en archivos
git grep "palabra"
git grep -n "palabra"  # Con número de línea

# Limpiar archivos no rastreados
git clean -n   # Preview
git clean -f   # Eliminar archivos
git clean -fd  # Eliminar archivos y carpetas

# Ver tamaño del repositorio
git count-objects -vH

# Optimizar repositorio
git gc
```

---

## 🔐 .gitignore

```bash
# Sintaxis básica
*.log           # Todos los .log
temp/           # Carpeta temp
/config.local   # Solo en raíz
**/*.tmp        # .tmp en cualquier nivel
!important.log  # Excepción (NO ignorar)

# Dejar de rastrear archivo ya commiteado
git rm --cached archivo.txt
git rm -r --cached carpeta/
```

---

## 🚨 Solución de Problemas Comunes

### Olvidé hacer branch antes de hacer cambios

```bash
# Opción 1: Stash y crear rama
git stash
git switch -c nueva-rama
git stash pop

# Opción 2: Crear rama directamente (si no hay commits)
git switch -c nueva-rama
```

### Hice commit en rama equivocada

```bash
# 1. Crear rama nueva desde aquí
git branch rama-correcta

# 2. Volver a rama anterior
git reset --hard HEAD~1

# 3. Cambiar a rama correcta
git switch rama-correcta
```

### Quiero deshacer push

```bash
# Si nadie ha bajado los cambios aún
git reset --hard HEAD~1
git push --force origin main  # PELIGROSO, coordina con el equipo

# Si otros ya bajaron los cambios
git revert a1b2c3d  # Más seguro
git push origin main
```

### Conflictos al hacer pull

```bash
# Opción 1: Resolver y commitear
git pull origin main
# ... resolver conflictos ...
git add .
git commit

# Opción 2: Abortar y usar rebase
git merge --abort
git pull --rebase origin main
```

### Cambié archivo sensible por error

```bash
# Si NO has hecho commit
git restore archivo-sensible

# Si ya hiciste commit pero NO push
git reset --soft HEAD~1
git restore --staged archivo-sensible
git restore archivo-sensible
git commit

# Si ya hiciste push (URGENTE)
# 1. Cambiar credenciales inmediatamente
# 2. Reescribir historial (complejo, busca "git filter-branch")
```

---

## 📊 Aliases Recomendados

```bash
# Añadir a ~/.gitconfig o usar git config --global alias.nombre "comando"

[alias]
    # Logs bonitos
    lg = log --oneline --graph --all --decorate
    ll = log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --numstat

    # Shortcuts comunes
    st = status -s
    co = checkout
    br = branch
    ci = commit
    unstage = restore --staged

    # Ver diferencias
    df = diff
    dc = diff --cached

    # Último commit
    last = log -1 HEAD --stat

    # Undo
    undo = reset --soft HEAD~1

    # Ver colaboradores
    contributors = shortlog --summary --numbered --email

    # Aliases para lazy people
    a = add
    c = commit
    p = push
    pl = pull

    # Ver ramas ordenadas por fecha
    recent = branch --sort=-committerdate
```

---

## 🎯 Workflows Comunes

### Feature Branch Workflow

```bash
# 1. Actualizar main
git switch main
git pull origin main

# 2. Crear feature branch
git switch -c feature/nueva-funcionalidad

# 3. Desarrollar
# ... código ...
git add .
git commit -m "feat: Implementar funcionalidad"

# 4. Push de feature
git push -u origin feature/nueva-funcionalidad

# 5. Crear Pull Request en GitHub/GitLab

# 6. Después de aprobación y merge
git switch main
git pull origin main
git branch -d feature/nueva-funcionalidad
```

### Hotfix Workflow

```bash
# 1. Crear rama desde main
git switch main
git pull origin main
git switch -c hotfix/critical-bug

# 2. Fix rápido
# ... código ...
git add .
git commit -m "hotfix: Corregir bug crítico"

# 3. Push y merge rápido
git push -u origin hotfix/critical-bug
# Merge inmediatamente en GitHub

# 4. Limpiar
git switch main
git pull origin main
git branch -d hotfix/critical-bug
```

---

## 💡 Tips Pro

```bash
# Commitear parte de un archivo
git add -p archivo.txt

# Ver quién modificó cada línea y cuándo
git blame archivo.txt

# Encontrar en qué commit se eliminó un archivo
git log --all --full-history -- ruta/archivo.txt

# Buscar commit que cambió una función
git log -S "nombreFuncion"

# Exportar repo a ZIP (sin .git)
git archive --format=zip HEAD > proyecto.zip

# Ver estadísticas del repo
git shortlog -sn

# Trabajar con submodulos
git submodule add https://github.com/user/repo.git
git submodule update --init --recursive

# Firmar commits con GPG
git commit -S -m "Mensaje"
git config --global commit.gpgsign true
```

---

## 📚 Recursos Adicionales

- **Documentación oficial**: https://git-scm.com/doc
- **Pro Git Book** (gratis): https://git-scm.com/book/es/v2
- **Git Visualizer**: https://git-school.github.io/visualizing-git/
- **Learn Git Branching**: https://learngitbranching.js.org/
- **Oh Shit, Git!**: https://ohshitgit.com/

---

## 🎓 Convenciones de Mensajes de Commit

### Conventional Commits

```
tipo(scope): mensaje corto

Descripción más detallada si es necesario

BREAKING CHANGE: Descripción de cambios incompatibles
```

**Tipos:**
- `feat`: Nueva funcionalidad
- `fix`: Corrección de bug
- `docs`: Documentación
- `style`: Formato, espacios (no cambia código)
- `refactor`: Refactorización
- `test`: Añadir o modificar tests
- `chore`: Tareas de mantenimiento
- `perf`: Mejora de performance

**Ejemplos:**
```
feat(auth): añadir login con Google
fix(api): corregir error en endpoint de usuarios
docs(readme): actualizar instrucciones de instalación
refactor(utils): simplificar función de validación
```

---

**¡Guarda este cheat sheet para referencia rápida!** 📌

_Última actualización: Noviembre 2024_
