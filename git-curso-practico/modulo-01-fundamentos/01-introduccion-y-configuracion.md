# Módulo 1: Fundamentos de Git - Introducción y Configuración

## 📚 Nivel: Principiante

---

## ¿Qué es Git?

Git es un **sistema de control de versiones distribuido** creado por Linus Torvalds en 2005. Te permite:

- 📝 Rastrear cambios en tu código
- 🔄 Volver a versiones anteriores
- 👥 Colaborar con otros desarrolladores
- 🌿 Experimentar con nuevas funcionalidades sin afectar el código principal

### Conceptos Clave

**Repository (Repositorio)**: Carpeta donde Git rastrea los cambios
**Commit**: Instantánea de tus archivos en un momento específico
**Branch (Rama)**: Línea de desarrollo independiente
**Remote (Remoto)**: Versión del repositorio alojada en un servidor

---

## 🔧 Instalación de Git

### Linux (Ubuntu/Debian)
```bash
sudo apt update
sudo apt install git
```

### macOS
```bash
# Con Homebrew
brew install git
```

### Windows
Descarga desde: https://git-scm.com/download/win

### Verificar instalación
```bash
# Verificar versión instalada
git --version
# Ejemplo de salida: git version 2.39.2
```

---

## ⚙️ Configuración Inicial (OBLIGATORIA)

Antes de usar Git, debes configurar tu identidad. Esta información aparecerá en todos tus commits.

### Configuración Global (para todos tus proyectos)

```bash
# Configurar tu nombre
git config --global user.name "Tu Nombre"

# Configurar tu email
git config --global user.email "tu.email@ejemplo.com"

# Configurar editor por defecto (opcional)
git config --global core.editor "code"  # VS Code
# git config --global core.editor "nano"  # Nano
# git config --global core.editor "vim"   # Vim
```

### Verificar tu configuración

```bash
# Ver todas las configuraciones
git config --list

# Ver configuración específica
git config user.name
git config user.email
```

### Configuración Local (solo para un proyecto específico)

```bash
# Dentro de un repositorio específico
git config user.name "Otro Nombre"
git config user.email "otro.email@ejemplo.com"

# Esto sobrescribe la configuración global solo en este proyecto
```

---

## 🎨 Configuraciones Adicionales Útiles

### Colores en la terminal

```bash
# Activar colores (hace más legible la salida de Git)
git config --global color.ui auto
```

### Configurar alias (atajos)

```bash
# Crear atajos para comandos frecuentes
git config --global alias.st status          # 'git st' en vez de 'git status'
git config --global alias.co checkout        # 'git co' en vez de 'git checkout'
git config --global alias.br branch          # 'git br' en vez de 'git branch'
git config --global alias.ci commit          # 'git ci' en vez de 'git commit'
git config --global alias.last 'log -1 HEAD' # Ver último commit
```

### Configurar comportamiento de line endings

```bash
# En Linux/macOS
git config --global core.autocrlf input

# En Windows
git config --global core.autocrlf true
```

---

## 📋 Archivos de Configuración

Git guarda las configuraciones en archivos:

- **Global**: `~/.gitconfig` (Linux/macOS) o `C:\Users\TuUsuario\.gitconfig` (Windows)
- **Local**: `.git/config` dentro de cada repositorio

### Ver el archivo de configuración global

```bash
cat ~/.gitconfig
```

Ejemplo de contenido:
```ini
[user]
    name = Juan Pérez
    email = juan.perez@ejemplo.com
[core]
    editor = code
[color]
    ui = auto
[alias]
    st = status
    co = checkout
    br = branch
```

---

## 🎯 Ejercicio Práctico 1: Configuración Inicial

### Paso 1: Verifica que Git esté instalado
```bash
git --version
```

### Paso 2: Configura tu identidad
```bash
git config --global user.name "TU NOMBRE AQUÍ"
git config --global user.email "TU EMAIL AQUÍ"
```

### Paso 3: Verifica la configuración
```bash
git config --list
# O específicamente:
git config user.name
git config user.email
```

### Paso 4: Crea algunos alias útiles
```bash
git config --global alias.st status
git config --global alias.lg "log --oneline --graph --all"
```

### Paso 5: Prueba tus alias (lo haremos en la siguiente lección)
```bash
# Esto lo probarás cuando creemos nuestro primer repositorio
```

---

## ✅ Checklist de Configuración

Antes de continuar al siguiente tema, asegúrate de haber:

- [ ] Instalado Git en tu sistema
- [ ] Configurado tu nombre con `git config --global user.name`
- [ ] Configurado tu email con `git config --global user.email`
- [ ] Verificado tu configuración con `git config --list`
- [ ] (Opcional) Configurado algunos alias útiles

---

## 🔍 Comandos de Ayuda

```bash
# Ayuda general de Git
git help

# Ayuda específica de un comando
git help config
git help commit
git help log

# Versión corta de ayuda
git status -h
git commit -h
```

---

## 📌 Resumen

En esta lección aprendiste:

✅ Qué es Git y para qué sirve
✅ Cómo instalar Git en diferentes sistemas operativos
✅ Cómo configurar tu identidad (nombre y email)
✅ Configuraciones adicionales útiles
✅ Cómo crear alias para comandos frecuentes
✅ Dónde se guardan las configuraciones

---

## ➡️ Siguiente Paso

En la próxima lección aprenderás a:
- Crear tu primer repositorio
- Hacer tu primer commit
- Ver el historial de cambios
- Entender el ciclo de vida de los archivos en Git

¡Continúa con `02-primer-repositorio.md`!
