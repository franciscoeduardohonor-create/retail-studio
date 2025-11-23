# Módulo 4: Técnicas Avanzadas - Git Rebase

## 📚 Nivel: Avanzado

---

## 🎯 Objetivos de esta lección

- Entender qué es rebase y cuándo usarlo
- Diferencia entre merge y rebase
- Rebase interactivo para limpiar historial
- Resolver conflictos en rebase
- Reglas de oro del rebase

---

## 🔄 ¿Qué es Rebase?

**Rebase** mueve o "re-aplica" commits de una rama sobre otra, reescribiendo el historial.

### Merge vs Rebase

```
ANTES:
         A---B---C  (main)
              \
               D---E  (feature)

DESPUÉS DE MERGE:
         A---B---C-------F  (main)
              \         /
               D-------E

DESPUÉS DE REBASE:
         A---B---C  (main)
                  \
                   D'---E'  (feature)

Los commits D y E se "re-aplican" después de C
D' y E' son nuevos commits (diferente hash)
```

---

## 🎬 Rebase Básico

### Ejemplo Práctico

```bash
# 1. Crear repositorio
mkdir test-rebase
cd test-rebase
git init

# 2. Commits en main
echo "Linea 1" > archivo.txt
git add archivo.txt
git commit -m "Commit A"

echo "Linea 2" >> archivo.txt
git add archivo.txt
git commit -m "Commit B"

echo "Linea 3" >> archivo.txt
git add archivo.txt
git commit -m "Commit C"

# 3. Crear feature desde B
git switch -c feature HEAD~1

echo "Feature linea 1" >> feature.txt
git add feature.txt
git commit -m "Commit D"

echo "Feature linea 2" >> feature.txt
git add feature.txt
git commit -m "Commit E"

# 4. Ver el historial
git log --oneline --graph --all
# * e5e5e5e (HEAD -> feature) Commit E
# * d4d4d4d Commit D
# | * c3c3c3c (main) Commit C
# |/
# * b2b2b2b Commit B
# * a1a1a1a Commit A

# 5. REBASE: Mover feature encima de main
git rebase main

# Salida:
# Successfully rebased and updated refs/heads/feature.

# 6. Ver historial después del rebase
git log --oneline --graph --all
# * e5'e5'e5' (HEAD -> feature) Commit E
# * d4'd4'd4' Commit D
# * c3c3c3c (main) Commit C
# * b2b2b2b Commit B
# * a1a1a1a Commit A

# ¡Historial lineal!
```

---

## ⚖️ Merge vs Rebase: ¿Cuándo usar cada uno?

### Usa MERGE cuando:

```
✅ Trabajas en ramas públicas/compartidas
✅ Quieres preservar el historial exacto
✅ Trabajas en equipo grande
✅ Necesitas ver cuándo se integraron features

Ejemplo:
git switch main
git merge feature/nueva-funcionalidad
```

### Usa REBASE cuando:

```
✅ Limpiar historial antes de mergear
✅ Trabajas en rama personal/privada
✅ Quieres historial lineal y limpio
✅ Actualizas tu rama con cambios de main

Ejemplo:
git switch feature/mi-trabajo
git rebase main
```

---

## 🛠️ Rebase Interactivo

El **rebase interactivo** permite editar, combinar, reordenar o eliminar commits.

### Comandos Disponibles

```
pick   = usar el commit tal cual
reword = usar el commit, pero editar el mensaje
edit   = usar el commit, pero pausar para modificarlo
squash = combinar con el commit anterior
fixup  = como squash, pero descarta el mensaje
drop   = eliminar el commit
```

### Ejemplo: Limpiar historial

```bash
# 1. Crear commits "sucios"
mkdir proyecto-limpio
cd proyecto-limpio
git init

echo "Función v1" > app.js
git add app.js
git commit -m "Añadir función"

echo "Función v2" > app.js
git add app.js
git commit -m "fix typo"

echo "Función v3" > app.js
git add app.js
git commit -m "arreglar otro error"

echo "Función v4" > app.js
git add app.js
git commit -m "actualizar funcion"

# Ver historial sucio
git log --oneline
# d4d4d4d actualizar funcion
# c3c3c3c arreglar otro error
# b2b2b2b fix typo
# a1a1a1a Añadir función

# 2. Rebase interactivo para limpiar
git rebase -i HEAD~4
# HEAD~4 = últimos 4 commits
```

**Se abrirá un editor con:**
```
pick a1a1a1a Añadir función
pick b2b2b2b fix typo
pick c3c3c3c arreglar otro error
pick d4d4d4d actualizar funcion

# Commands:
# p, pick = use commit
# r, reword = use commit, but edit the commit message
# e, edit = use commit, but stop for amending
# s, squash = use commit, but meld into previous commit
# f, fixup = like "squash", but discard this commit's log message
```

**Cambiar a:**
```
pick a1a1a1a Añadir función
fixup b2b2b2b fix typo
fixup c3c3c3c arreglar otro error
fixup d4d4d4d actualizar funcion
```

Guardar y cerrar el editor.

**Resultado:**
```bash
git log --oneline
# a1'a1'a1' Añadir función
# ¡Todos los commits se combinaron en uno!
```

---

## 🎯 Ejercicio Práctico 11: Rebase Interactivo

```bash
# === CREAR HISTORIAL DESORDENADO ===
mkdir practica-rebase-interactivo
cd practica-rebase-interactivo
git init

# Commits simulando desarrollo real
echo "console.log('App');" > app.js
git add app.js
git commit -m "Initial commit"

echo "// TODO: fix" >> app.js
git add app.js
git commit -m "WIP"

echo "const name = 'App';" >> app.js
git add app.js
git commit -m "añadir variable"

echo "console.log(name);" >> app.js
git add app.js
git commit -m "typo fix"

echo "// v1.0" >> app.js
git add app.js
git commit -m "add comment"

# Ver historial sucio
git log --oneline

# === LIMPIAR CON REBASE INTERACTIVO ===
git rebase -i HEAD~4
```

En el editor, cambiar a:
```
pick <hash1> Initial commit
reword <hash2> WIP
squash <hash3> añadir variable
squash <hash4> typo fix
fixup <hash5> add comment
```

Después del rebase:
```bash
git log --oneline
# Solo 2 commits limpios y con buenos mensajes
```

---

## 🔧 Operaciones Comunes con Rebase

### 1. Actualizar tu rama con main

```bash
# Tienes feature branch desactualizada
git switch feature/mi-trabajo

# Traer cambios de main
git fetch origin
git rebase origin/main

# Si hay conflictos:
# 1. Resolver conflictos
# 2. git add archivos-resueltos
# 3. git rebase --continue
```

### 2. Cambiar mensajes de commits

```bash
# Cambiar mensaje de último commit
git commit --amend -m "Nuevo mensaje"

# Cambiar mensajes de múltiples commits
git rebase -i HEAD~3

# En el editor, cambiar "pick" a "reword" en los que quieras
```

### 3. Combinar commits (Squash)

```bash
# Combinar últimos 3 commits en 1
git rebase -i HEAD~3

# En el editor:
# pick  a1a1a1a Primer commit
# squash b2b2b2b Segundo commit
# squash c3c3c3c Tercer commit

# Git pedirá un nuevo mensaje para el commit combinado
```

### 4. Reordenar commits

```bash
git rebase -i HEAD~5

# En el editor, simplemente cambia el orden de las líneas:
pick d4d4d4d Este va primero ahora
pick a1a1a1a Este va segundo
pick b2b2b2b Este va tercero
```

### 5. Eliminar commits

```bash
git rebase -i HEAD~4

# En el editor, elimina la línea del commit
# O cámbiala a "drop":
drop c3c3c3c Este commit se elimina
```

---

## ⚠️ Resolver Conflictos en Rebase

```bash
# Iniciar rebase
git rebase main

# Si hay conflictos:
# Auto-merging archivo.js
# CONFLICT (content): Merge conflict in archivo.js
# error: could not apply a1b2c3d... Commit X

# 1. Ver archivos con conflicto
git status

# 2. Resolver conflictos manualmente
# Editar archivo.js, eliminar marcadores <<<<, ====, >>>>

# 3. Marcar como resuelto
git add archivo.js

# 4. Continuar el rebase
git rebase --continue

# Si quieres abortar:
git rebase --abort

# Si quieres saltar este commit:
git rebase --skip
```

---

## 🚨 REGLAS DE ORO DEL REBASE

### ⛔ NUNCA hagas rebase de:

```bash
# 1. Commits que ya pusheaste a un repositorio compartido
# ❌ NO
git push origin feature
git rebase main  # ¡MAL!
git push --force origin feature  # ¡Romperás el repo para otros!

# 2. Ramas públicas (main, develop)
# ❌ NO
git switch main
git rebase otra-rama  # ¡Nunca!

# 3. Commits en los que otros están basando su trabajo
```

### ✅ SÍ puedes hacer rebase de:

```
✅ Commits locales que NO has pusheado
✅ Tu rama personal que nadie más usa
✅ Rama feature antes de crear PR
✅ Actualizar tu rama con main
```

---

## 📊 Workflow Recomendado con Rebase

```bash
# 1. Crear feature branch
git switch -c feature/nueva-funcionalidad

# 2. Hacer varios commits durante desarrollo
git commit -m "WIP: parte 1"
git commit -m "WIP: parte 2"
git commit -m "fix typo"
git commit -m "parte 3"

# 3. Antes de crear PR, limpiar historial
git rebase -i HEAD~4
# Combinar WIP commits, arreglar mensajes

# 4. Actualizar con main
git fetch origin
git rebase origin/main

# 5. Ahora sí, push
git push -u origin feature/nueva-funcionalidad

# 6. Crear Pull Request
```

---

## 🎯 Ejercicio Práctico 12: Workflow Completo con Rebase

```bash
# === SIMULAR DESARROLLO REAL ===
mkdir proyecto-real
cd proyecto-real
git init

# Main branch
echo "# Proyecto Real" > README.md
git add README.md
git commit -m "Initial commit"

cat > app.js << 'EOF'
console.log('App v1');
EOF
git add app.js
git commit -m "feat: App inicial"

# === TRABAJAR EN FEATURE ===
git switch -c feature/authentication

# Día 1: Commits de trabajo
cat >> app.js << 'EOF'
// Login
EOF
git add app.js
git commit -m "WIP login"

cat > login.js << 'EOF'
function login() {}
EOF
git add login.js
git commit -m "add login file"

# Día 2: Más trabajo
cat >> login.js << 'EOF'
function validate() {}
EOF
git add login.js
git commit -m "wip"

# Typo fix
sed -i 's/function/const/g' login.js 2>/dev/null || sed -i '' 's/function/const/g' login.js
git add login.js
git commit -m "fix typo"

# === MIENTRAS TANTO, MAIN AVANZA ===
git switch main
echo "console.log('Update');" >> app.js
git add app.js
git commit -m "feat: Actualización importante"

# === PREPARAR FEATURE PARA PR ===
git switch feature/authentication

# Paso 1: Limpiar historial con rebase interactivo
git rebase -i HEAD~4
# Combinar todos los WIP en un commit limpio

# Paso 2: Actualizar con main
git rebase main

# Paso 3: Verificar historial limpio
git log --oneline --graph --all

# ¡Listo para PR!
```

---

## 💡 Tips Avanzados

### Rebase automático en pull

```bash
# Configurar para que pull haga rebase en vez de merge
git config --global pull.rebase true

# Ahora:
git pull  # Hace fetch + rebase en vez de fetch + merge
```

### Autosquash

```bash
# Hacer commit con intención de squash
git commit --fixup a1b2c3d
# Crea commit con mensaje "fixup! <mensaje de a1b2c3d>"

# Al hacer rebase interactivo con --autosquash
git rebase -i --autosquash HEAD~5
# Automáticamente coloca fixup commits en el lugar correcto
```

### Preserve merge commits

```bash
# Si quieres mantener commits de merge durante rebase
git rebase --preserve-merges main
```

---

## ✅ Checklist

Antes de continuar, asegúrate de poder:

- [ ] Entender la diferencia entre merge y rebase
- [ ] Hacer rebase básico (`git rebase main`)
- [ ] Usar rebase interactivo (`git rebase -i`)
- [ ] Combinar commits con squash/fixup
- [ ] Resolver conflictos durante rebase
- [ ] Saber cuándo NO usar rebase (commits públicos)
- [ ] Limpiar historial antes de crear PR

---

## 📌 Resumen de Comandos

| Comando | Descripción |
|---------|-------------|
| `git rebase main` | Rebasar rama actual sobre main |
| `git rebase -i HEAD~N` | Rebase interactivo de N commits |
| `git rebase --continue` | Continuar después de resolver conflicto |
| `git rebase --abort` | Cancelar rebase |
| `git rebase --skip` | Saltar commit actual |
| `git commit --fixup <hash>` | Crear commit de fixup |
| `git rebase -i --autosquash` | Rebase con autosquash |

---

## ⚠️ Recuerda

```
REGLA DE ORO:
Nunca hagas rebase de commits que ya pusheaste a un repositorio compartido.

Si ya pusheaste, usa merge en vez de rebase.
```

---

## ➡️ Siguiente Paso

En la próxima lección aprenderás:
- Git stash: Guardar cambios temporalmente
- Cherry-pick: Aplicar commits específicos
- Git bisect: Encontrar bugs con búsqueda binaria

¡Continúa con `02-stash-cherry-pick-bisect.md`!
