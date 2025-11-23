# Módulo 1: Fundamentos de Git - Tu Primer Repositorio

## 📚 Nivel: Principiante

---

## 🎯 Objetivos de esta lección

- Crear tu primer repositorio Git
- Entender el área de staging
- Hacer tu primer commit
- Ver el historial de cambios

---

## 📦 Crear un Repositorio Nuevo

### Método 1: Inicializar un repositorio desde cero

```bash
# 1. Crear una carpeta para tu proyecto
mkdir mi-primer-proyecto
cd mi-primer-proyecto

# 2. Inicializar Git en esta carpeta
git init

# Salida esperada:
# Initialized empty Git repository in /ruta/mi-primer-proyecto/.git/
```

**¿Qué pasó?** Git creó una carpeta oculta `.git` que contiene toda la información del repositorio.

```bash
# Ver la carpeta .git (contiene toda la magia de Git)
ls -la
# Verás una carpeta .git/

# NUNCA edites manualmente el contenido de .git/
```

---

## 📄 Ciclo de Vida de los Archivos en Git

Los archivos en Git pueden estar en 4 estados:

```
┌─────────────┐    git add    ┌─────────────┐   git commit   ┌─────────────┐
│  Untracked  │──────────────>│   Staged    │───────────────>│  Committed  │
│ (Sin rastrear)              │ (Preparado) │                │ (Guardado)  │
└─────────────┘               └─────────────┘                └─────────────┘
       │                            │                               │
       │                            │ git restore --staged          │
       │                            │<──────────────────────────────│
       │                            │                               │
       └────────────────────────────┴───────────────────────────────┘
                              Modified
                           (Modificado)
```

### Estados:

1. **Untracked (Sin rastrear)**: Archivos nuevos que Git aún no conoce
2. **Modified (Modificado)**: Archivos rastreados que han cambiado
3. **Staged (Preparado)**: Archivos listos para ser incluidos en el próximo commit
4. **Committed (Guardado)**: Archivos guardados en el historial de Git

---

## 🎬 Práctica: Tu Primer Commit

### Paso 1: Crear un archivo

```bash
# Crear un archivo de texto
echo "# Mi Primer Proyecto" > README.md
echo "Este es mi primer repositorio Git" >> README.md

# Ver el contenido
cat README.md
```

### Paso 2: Verificar el estado

```bash
git status
```

**Salida:**
```
On branch main

No commits yet

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        README.md

nothing added to commit but untracked files present (use "git add" to track)
```

**Análisis de la salida:**
- `On branch main`: Estás en la rama principal
- `Untracked files`: README.md es un archivo nuevo que Git no está rastreando
- Git te sugiere usar `git add` para rastrearlo

### Paso 3: Añadir el archivo al staging area

```bash
# Añadir un archivo específico
git add README.md

# Verificar el estado nuevamente
git status
```

**Salida:**
```
On branch main

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
        new file:   README.md
```

**Ahora el archivo está "staged"** (preparado para ser commiteado).

### Paso 4: Hacer tu primer commit

```bash
# Crear un commit con un mensaje descriptivo
git commit -m "feat: Añadir README inicial"

# -m: permite escribir el mensaje del commit en la misma línea
```

**Salida:**
```
[main (root-commit) a1b2c3d] feat: Añadir README inicial
 1 file changed, 2 insertions(+)
 create mode 100644 README.md
```

**¡Felicidades! Acabas de hacer tu primer commit.**

### Paso 5: Ver el historial

```bash
# Ver el historial de commits
git log
```

**Salida:**
```
commit a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6q7r8s9t0 (HEAD -> main)
Author: Tu Nombre <tu.email@ejemplo.com>
Date:   Sat Nov 23 10:30:00 2024 -0500

    feat: Añadir README inicial
```

**Partes del commit:**
- **Hash del commit**: `a1b2c3d...` (identificador único)
- **Author**: Tu nombre y email
- **Date**: Fecha y hora del commit
- **Mensaje**: Descripción del cambio

---

## 🔄 Flujo de Trabajo Básico

```bash
# 1. Modificar archivos
echo "## Instalación" >> README.md
echo "npm install" >> README.md

# 2. Ver qué cambió
git status

# Salida:
# On branch main
# Changes not staged for commit:
#   modified:   README.md

# 3. Ver los cambios específicos
git diff

# Salida muestra las líneas añadidas con +

# 4. Añadir al staging area
git add README.md

# 5. Verificar antes de commitear
git status

# 6. Hacer el commit
git commit -m "docs: Añadir sección de instalación"

# 7. Ver el historial
git log --oneline
# a1b2c3d feat: Añadir README inicial
# b2c3d4e docs: Añadir sección de instalación
```

---

## 📊 Comandos Útiles de Estado

### `git status` - Ver estado actual

```bash
# Forma completa
git status

# Forma resumida
git status -s
# M  README.md     # M = Modified (modificado)
# ?? archivo.txt   # ?? = Untracked (sin rastrear)
# A  nuevo.md      # A = Added (añadido al staging)
```

### `git diff` - Ver diferencias

```bash
# Ver cambios NO staged (working directory vs staging)
git diff

# Ver cambios staged (staging vs último commit)
git diff --staged
# o
git diff --cached

# Ver cambios entre commits
git diff a1b2c3d b2c3d4e
```

### `git log` - Ver historial

```bash
# Formato completo
git log

# Una línea por commit
git log --oneline

# Con gráfico de ramas
git log --oneline --graph --all

# Últimos 3 commits
git log -3

# Con estadísticas de archivos cambiados
git log --stat

# Filtrar por autor
git log --author="Tu Nombre"

# Filtrar por fecha
git log --since="2024-01-01" --until="2024-12-31"
```

---

## 🎯 Ejercicio Práctico 2: Flujo Completo

Realiza estos pasos en tu terminal:

```bash
# 1. Crear y entrar en una carpeta nueva
mkdir practica-git
cd practica-git

# 2. Inicializar Git
git init

# 3. Crear un archivo HTML simple
cat > index.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Mi Página</title>
</head>
<body>
    <h1>Hola Mundo</h1>
</body>
</html>
EOF

# 4. Ver el estado
git status

# 5. Añadir al staging
git add index.html

# 6. Hacer commit
git commit -m "feat: Crear página HTML inicial"

# 7. Modificar el archivo (añadir un párrafo)
cat >> index.html << 'EOF'
    <p>Bienvenido a mi sitio web</p>
EOF

# 8. Ver qué cambió
git diff

# 9. Añadir y commitear
git add index.html
git commit -m "feat: Añadir párrafo de bienvenida"

# 10. Crear un archivo CSS
cat > styles.css << 'EOF'
body {
    font-family: Arial, sans-serif;
    margin: 20px;
}

h1 {
    color: #333;
}
EOF

# 11. Añadir AMBOS archivos modificados
git add .  # El punto (.) añade TODOS los archivos modificados

# 12. Hacer commit
git commit -m "style: Añadir estilos CSS"

# 13. Ver el historial bonito
git log --oneline --graph
```

---

## 💡 Consejos de Buenas Prácticas

### Mensajes de Commit

**❌ Mal:**
```bash
git commit -m "cambios"
git commit -m "fix"
git commit -m "asdf"
```

**✅ Bien:**
```bash
git commit -m "feat: Añadir formulario de contacto"
git commit -m "fix: Corregir error en validación de email"
git commit -m "docs: Actualizar instrucciones de instalación"
```

### Convenciones de Mensajes (Conventional Commits)

```bash
feat:     # Nueva funcionalidad
fix:      # Corrección de bug
docs:     # Cambios en documentación
style:    # Formato, punto y coma faltante, etc (no cambia código)
refactor: # Refactorización de código
test:     # Añadir tests
chore:    # Tareas de mantenimiento
```

**Ejemplo:**
```bash
git commit -m "feat: Añadir botón de logout"
git commit -m "fix: Corregir cálculo de totales en carrito"
git commit -m "docs: Actualizar README con nuevas instrucciones"
```

---

## 🔧 Comandos Adicionales Útiles

### Añadir múltiples archivos

```bash
# Añadir todos los archivos modificados
git add .

# Añadir todos los archivos .js
git add *.js

# Añadir todos los archivos en una carpeta
git add src/

# Añadir múltiples archivos específicos
git add archivo1.txt archivo2.txt archivo3.txt

# Modo interactivo (te pregunta archivo por archivo)
git add -i
```

### Commit rápido de archivos ya rastreados

```bash
# Añadir y commitear archivos YA rastreados en un solo paso
git commit -am "fix: Corregir typo en documentación"

# -a = añade automáticamente archivos modificados (NO funciona con archivos nuevos)
# -m = mensaje del commit
```

### Ver un commit específico

```bash
# Ver detalles de un commit
git show a1b2c3d

# Ver solo los archivos cambiados
git show --name-only a1b2c3d
```

---

## 🚫 Archivos que NO debes commitear

Algunos archivos nunca deben estar en Git:

- Contraseñas o credenciales
- Archivos de configuración con datos sensibles
- Archivos muy grandes (bases de datos, videos)
- Archivos generados automáticamente (node_modules, .pyc, etc)

(En la próxima lección veremos cómo usar `.gitignore` para esto)

---

## ✅ Checklist

Antes de continuar, asegúrate de poder:

- [ ] Crear un repositorio con `git init`
- [ ] Ver el estado con `git status`
- [ ] Añadir archivos al staging con `git add`
- [ ] Hacer commits con `git commit -m "mensaje"`
- [ ] Ver el historial con `git log`
- [ ] Ver diferencias con `git diff`
- [ ] Entender los 4 estados de los archivos en Git

---

## 📌 Resumen de Comandos

| Comando | Descripción |
|---------|-------------|
| `git init` | Crear un repositorio nuevo |
| `git status` | Ver estado de archivos |
| `git add <archivo>` | Añadir archivo al staging |
| `git add .` | Añadir todos los archivos modificados |
| `git commit -m "mensaje"` | Crear un commit |
| `git log` | Ver historial de commits |
| `git log --oneline` | Ver historial resumido |
| `git diff` | Ver cambios no staged |
| `git diff --staged` | Ver cambios staged |

---

## ➡️ Siguiente Paso

En la próxima lección aprenderás a:
- Ignorar archivos con `.gitignore`
- Deshacer cambios
- Modificar el último commit
- Volver a versiones anteriores

¡Continúa con `03-ignorar-archivos-gitignore.md`!
