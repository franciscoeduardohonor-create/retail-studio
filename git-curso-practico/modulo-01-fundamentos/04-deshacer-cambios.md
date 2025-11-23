# Módulo 1: Fundamentos de Git - Deshacer Cambios

## 📚 Nivel: Principiante a Intermedio

---

## 🎯 Objetivos de esta lección

- Entender los diferentes tipos de "deshacer"
- Usar `git restore` para descartar cambios
- Modificar el último commit con `--amend`
- Entender `git reset` y sus modos
- Saber cuándo usar cada comando

---

## 🤔 Tipos de "Deshacer"

Hay diferentes escenarios donde quieres deshacer algo:

```
1. Modificaste un archivo y quieres DESCARTAR los cambios
   → git restore archivo.txt

2. Añadiste un archivo al staging y quieres SACARLO
   → git restore --staged archivo.txt

3. Hiciste un commit y quieres MODIFICARLO
   → git commit --amend

4. Hiciste commits y quieres VOLVER ATRÁS
   → git reset

5. Quieres DESHACER un commit pero mantener el historial
   → git revert
```

---

## 1️⃣ Descartar cambios en archivos (Working Directory)

### Escenario: Modificaste un archivo y quieres volver a como estaba

```bash
# Modificar un archivo
echo "Cambio que no quiero" >> archivo.txt

# Ver el estado
git status
# Salida: Changes not staged for commit: modified: archivo.txt

# Ver los cambios
git diff archivo.txt

# DESCARTAR los cambios (CUIDADO: esto es irreversible!)
git restore archivo.txt

# Verificar
cat archivo.txt
# El archivo vuelve al estado del último commit
```

### Descartar TODOS los cambios

```bash
# Descartar cambios en TODOS los archivos
git restore .

# ADVERTENCIA: Esto elimina TODOS los cambios no commiteados
```

---

## 2️⃣ Quitar archivos del Staging Area

### Escenario: Añadiste un archivo por error con `git add`

```bash
# Añadir archivo al staging
echo "Contenido" > archivo.txt
git add archivo.txt

# Ver estado
git status
# Salida: Changes to be committed: new file: archivo.txt

# QUITAR del staging (pero mantener los cambios en el archivo)
git restore --staged archivo.txt

# Verificar
git status
# Salida: Untracked files: archivo.txt

# El archivo SIGUE existiendo con sus cambios
cat archivo.txt
# Contenido
```

### Ejemplo con archivo modificado

```bash
# Modificar archivo rastreado
echo "Nueva línea" >> README.md
git add README.md

# Ver estado
git status
# Changes to be committed: modified: README.md

# Quitar del staging
git restore --staged README.md

# Ver estado
git status
# Changes not staged for commit: modified: README.md

# Los cambios SIGUEN en el archivo, solo se quitó del staging
```

---

## 3️⃣ Modificar el Último Commit

### Escenario 1: Olvidaste añadir un archivo

```bash
# Hacer un commit
git add archivo1.txt
git commit -m "feat: Añadir funcionalidad"

# ¡Ups! Olvidaste archivo2.txt

# Añadir el archivo olvidado
git add archivo2.txt

# ENMENDAR el último commit (añade archivo2.txt al commit anterior)
git commit --amend --no-edit
# --no-edit: mantiene el mismo mensaje

# El commit anterior ahora incluye AMBOS archivos
```

### Escenario 2: Corregir el mensaje del commit

```bash
# Commit con typo
git commit -m "feat: Añadir funcionlaidad"
#                              ↑ typo!

# Corregir el mensaje
git commit --amend -m "feat: Añadir funcionalidad"

# El commit se reescribe con el nuevo mensaje
```

### Escenario 3: Modificar archivos Y mensaje

```bash
# Hacer cambios adicionales
echo "Más contenido" >> archivo.txt
git add archivo.txt

# Enmendar con nuevo mensaje
git commit --amend -m "feat: Añadir funcionalidad completa"

# Abre el editor para mensaje más largo
git commit --amend
```

**⚠️ ADVERTENCIA con `--amend`:**
- SOLO usa `--amend` si NO has pusheado el commit
- Si ya hiciste push, `--amend` reescribe el historial y causará problemas

---

## 4️⃣ Git Reset - Volver a Commits Anteriores

`git reset` tiene 3 modos:

```
┌─────────────────┬──────────────┬─────────────┬──────────────────┐
│     Modo        │  Commits     │   Staging   │ Working Directory│
├─────────────────┼──────────────┼─────────────┼──────────────────┤
│ --soft          │  Mueve HEAD  │  Mantiene   │    Mantiene      │
│ --mixed (default)│ Mueve HEAD  │  Descarta   │    Mantiene      │
│ --hard          │  Mueve HEAD  │  Descarta   │    Descarta      │
└─────────────────┴──────────────┴─────────────┴──────────────────┘
```

### Ejemplo Práctico: Crear escenario

```bash
# Crear repositorio de prueba
mkdir test-reset
cd test-reset
git init

# Crear 3 commits
echo "Versión 1" > archivo.txt
git add archivo.txt
git commit -m "Commit 1"

echo "Versión 2" >> archivo.txt
git add archivo.txt
git commit -m "Commit 2"

echo "Versión 3" >> archivo.txt
git add archivo.txt
git commit -m "Commit 3"

# Ver historial
git log --oneline
# a1b2c3d Commit 3  ← HEAD
# d4e5f6g Commit 2
# h7i8j9k Commit 1
```

### Reset --soft (más suave)

```bash
# Volver al Commit 2, manteniendo cambios staged
git reset --soft HEAD~1
# HEAD~1 significa "un commit antes del actual"

# Ver estado
git status
# Changes to be committed: modified: archivo.txt

# Ver historial
git log --oneline
# d4e5f6g Commit 2  ← HEAD (movido aquí)
# h7i8j9k Commit 1

# Los cambios del Commit 3 SIGUEN en staging
# Puedes hacer commit nuevamente o modificarlos
```

**Uso típico**: Deshacer el commit pero mantener los cambios para re-commitear.

### Reset --mixed (por defecto)

```bash
# Volver a crear Commit 3
git commit -m "Commit 3"

# Reset con --mixed
git reset HEAD~1
# Equivalente a: git reset --mixed HEAD~1

# Ver estado
git status
# Changes not staged for commit: modified: archivo.txt

# Los cambios están en working directory, NO en staging
# Debes hacer git add nuevamente si quieres commitear
```

**Uso típico**: Deshacer commit y staging, pero mantener cambios en archivos.

### Reset --hard (PELIGROSO!)

```bash
# Volver a crear Commit 3
git add archivo.txt
git commit -m "Commit 3"

# Reset --hard (ELIMINA TODO)
git reset --hard HEAD~1

# Ver estado
git status
# Working tree clean

# Ver archivo
cat archivo.txt
# Versión 2
# (¡La "Versión 3" desapareció!)

# Ver historial
git log --oneline
# d4e5f6g Commit 2  ← HEAD
# h7i8j9k Commit 1
```

**⚠️ PELIGRO**: `git reset --hard` ELIMINA cambios PERMANENTEMENTE.

**Uso típico**: Cuando quieres descartar completamente commits y cambios.

### Sintaxis de referencias

```bash
# Volver 1 commit atrás
git reset HEAD~1

# Volver 3 commits atrás
git reset HEAD~3

# Volver a un commit específico (por hash)
git reset a1b2c3d

# Volver a un commit específico (hard)
git reset --hard a1b2c3d
```

---

## 5️⃣ Git Revert - Deshacer SIN reescribir historial

`git revert` crea un NUEVO commit que deshace un commit anterior.

### Diferencia con reset

```
git reset:  Borra commits del historial (reescribe historia)
git revert: Crea nuevo commit que revierte cambios (historia intacta)
```

### Ejemplo Práctico

```bash
# Crear commits
echo "Línea 1" > archivo.txt
git add archivo.txt
git commit -m "Commit 1"

echo "Línea 2" >> archivo.txt
git add archivo.txt
git commit -m "Commit 2 - BUG introducido"

echo "Línea 3" >> archivo.txt
git add archivo.txt
git commit -m "Commit 3"

# Ver historial
git log --oneline
# c3c3c3c Commit 3
# b2b2b2b Commit 2 - BUG introducido  ← Queremos revertir este
# a1a1a1a Commit 1

# Revertir Commit 2
git revert b2b2b2b

# Esto abre un editor para el mensaje del nuevo commit
# Por defecto: "Revert 'Commit 2 - BUG introducido'"

# Ver historial
git log --oneline
# d4d4d4d Revert "Commit 2 - BUG introducido"  ← Nuevo commit
# c3c3c3c Commit 3
# b2b2b2b Commit 2 - BUG introducido
# a1a1a1a Commit 1

# Ver archivo
cat archivo.txt
# Línea 1
# Línea 3
# (Línea 2 fue eliminada por el revert)
```

### Cuándo usar revert vs reset

**Usa `git revert` cuando:**
- ✅ Ya hiciste push de los commits
- ✅ Trabajas en equipo
- ✅ Quieres mantener el historial completo

**Usa `git reset` cuando:**
- ✅ NO has hecho push
- ✅ Trabajas solo en tu rama
- ✅ Quieres "limpiar" el historial

---

## 🎯 Ejercicio Práctico 4: Deshacer en diferentes escenarios

### Ejercicio A: Restaurar archivos

```bash
# 1. Crear repositorio
mkdir practica-restore
cd practica-restore
git init

# 2. Crear archivo y commitear
echo "Contenido original" > datos.txt
git add datos.txt
git commit -m "Commit inicial"

# 3. Modificar el archivo
echo "Cambio accidental" >> datos.txt

# 4. Ver el cambio
git diff datos.txt

# 5. Descartar el cambio
git restore datos.txt

# 6. Verificar que volvió al original
cat datos.txt
# Debe mostrar solo "Contenido original"
```

### Ejercicio B: Quitar del staging

```bash
# 1. Crear varios archivos
echo "Importante" > importante.txt
echo "Temporal" > temp.txt

# 2. Añadir ambos por error
git add .

# 3. Ver estado
git status

# 4. Quitar temp.txt del staging
git restore --staged temp.txt

# 5. Commitear solo importante.txt
git commit -m "Añadir archivo importante"

# 6. Añadir temp.txt a .gitignore
echo "temp.txt" > .gitignore
git add .gitignore
git commit -m "Ignorar archivos temporales"
```

### Ejercicio C: Modificar último commit

```bash
# 1. Crear commit incompleto
echo "Función A" > funciones.js
git add funciones.js
git commit -m "Añadir funciones"

# 2. Darte cuenta que falta algo
echo "Función B" >> funciones.js

# 3. Añadir al commit anterior
git add funciones.js
git commit --amend --no-edit

# 4. Verificar que el commit incluye todo
git show
```

### Ejercicio D: Reset en práctica

```bash
# 1. Crear serie de commits
for i in {1..5}; do
  echo "Cambio $i" >> historial.txt
  git add historial.txt
  git commit -m "Commit $i"
done

# 2. Ver historial
git log --oneline

# 3. Probar reset --soft (volver 2 commits, mantener cambios)
git reset --soft HEAD~2
git status  # Cambios en staging

# 4. Rehacer commits
git commit -m "Commits 4 y 5 combinados"

# 5. Volver a crear commits individuales
echo "Cambio 6" >> historial.txt
git add historial.txt
git commit -m "Commit 6"

# 6. Probar reset --hard (CUIDADO!)
git reset --hard HEAD~1
git log --oneline  # Commit 6 desapareció
```

### Ejercicio E: Revert

```bash
# 1. Crear archivo
echo "Version 1.0" > version.txt
git add version.txt
git commit -m "Release 1.0"

# 2. Introducir un bug
echo "BUG: código problemático" >> version.txt
git add version.txt
git commit -m "Añadir feature (con bug)"

# 3. Más cambios
echo "Version 1.1" >> version.txt
git add version.txt
git commit -m "Release 1.1"

# 4. Revertir el commit con bug
git log --oneline  # Identificar hash del commit con bug
git revert <hash-del-commit-con-bug>

# 5. Verificar que se eliminó el bug pero se mantuvo versión 1.1
cat version.txt
```

---

## 🆘 Recuperar commits "perdidos"

Si hiciste `git reset --hard` y perdiste commits:

```bash
# Ver el historial de TODOS los movimientos de HEAD
git reflog

# Salida:
# a1b2c3d HEAD@{0}: reset: moving to HEAD~1
# d4e5f6g HEAD@{1}: commit: Commit que "perdí"
# h7i8j9k HEAD@{2}: commit: Commit anterior

# Recuperar el commit "perdido"
git reset --hard d4e5f6g

# ¡El commit vuelve!
```

**Nota**: reflog guarda historial por ~90 días por defecto.

---

## 📊 Tabla Comparativa de Comandos

| Comando | Afecta Working Dir | Afecta Staging | Afecta Commits | Reescribe Historia |
|---------|-------------------|----------------|----------------|-------------------|
| `git restore <file>` | ✅ Sí | ❌ No | ❌ No | ❌ No |
| `git restore --staged` | ❌ No | ✅ Sí | ❌ No | ❌ No |
| `git commit --amend` | ❌ No | ❌ No | ✅ Sí | ✅ Sí |
| `git reset --soft` | ❌ No | ❌ No | ✅ Sí | ✅ Sí |
| `git reset --mixed` | ❌ No | ✅ Sí | ✅ Sí | ✅ Sí |
| `git reset --hard` | ✅ Sí | ✅ Sí | ✅ Sí | ✅ Sí |
| `git revert` | ✅ Sí | ✅ Sí | ✅ Sí | ❌ No |

---

## 💡 Mejores Prácticas

### ✅ HACER

1. Usa `git status` ANTES de deshacer para entender qué vas a cambiar
2. Usa `git diff` para ver exactamente qué cambios perderás
3. Usa `--soft` o `--mixed` cuando tengas dudas
4. Usa `revert` cuando trabajes en equipo o después de push
5. Haz commits frecuentes (es más fácil deshacer commits pequeños)

### ❌ EVITAR

1. `git reset --hard` sin estar seguro
2. `git commit --amend` después de hacer push
3. Deshacer cambios sin verificar primero con `git diff`
4. Usar `reset` en ramas públicas compartidas

---

## ✅ Checklist

Antes de continuar, asegúrate de poder:

- [ ] Descartar cambios en archivos con `git restore`
- [ ] Quitar archivos del staging con `git restore --staged`
- [ ] Modificar el último commit con `git commit --amend`
- [ ] Entender las diferencias entre `--soft`, `--mixed`, `--hard`
- [ ] Saber cuándo usar `reset` vs `revert`
- [ ] Recuperar commits con `git reflog`

---

## 📌 Resumen de Comandos

| Comando | Uso |
|---------|-----|
| `git restore <file>` | Descartar cambios en archivo |
| `git restore .` | Descartar todos los cambios |
| `git restore --staged <file>` | Quitar archivo del staging |
| `git commit --amend` | Modificar último commit |
| `git reset --soft HEAD~1` | Deshacer commit, mantener staging |
| `git reset HEAD~1` | Deshacer commit y staging |
| `git reset --hard HEAD~1` | Deshacer todo (PELIGROSO) |
| `git revert <hash>` | Crear commit que revierte otro |
| `git reflog` | Ver historial de movimientos |

---

## ➡️ Siguiente Paso

¡Felicidades! Completaste el Módulo 1: Fundamentos de Git.

En el próximo módulo aprenderás:
- Trabajar con ramas (branches)
- Fusionar ramas (merge)
- Resolver conflictos
- Estrategias de branching

¡Continúa con el **Módulo 2**: `../modulo-02-ramas/01-crear-y-cambiar-ramas.md`!
