# Módulo 1: Fundamentos de Git - Ignorar Archivos (.gitignore)

## 📚 Nivel: Principiante

---

## 🎯 Objetivos de esta lección

- Entender por qué necesitas ignorar archivos
- Crear y configurar archivos `.gitignore`
- Conocer patrones comunes de ignorado
- Aplicar .gitignore en proyectos reales

---

## ❓ ¿Por qué ignorar archivos?

Hay archivos que NO quieres en tu repositorio:

- 🔐 **Archivos con información sensible**: contraseñas, API keys, tokens
- 📦 **Dependencias**: `node_modules/`, `vendor/`, `.venv/`
- 🔨 **Archivos compilados**: `*.class`, `*.o`, `dist/`, `build/`
- ⚙️ **Archivos de configuración local**: `.env`, `config.local.js`
- 🗑️ **Archivos temporales**: `*.log`, `*.tmp`, `.DS_Store`
- 💻 **Archivos del IDE**: `.vscode/`, `.idea/`, `*.swp`

---

## 📝 Crear un archivo .gitignore

### Paso 1: Crear el archivo

```bash
# En la raíz de tu repositorio
touch .gitignore

# O crear con contenido inicial
cat > .gitignore << 'EOF'
# Archivos temporales
*.log
*.tmp

# Dependencias
node_modules/
EOF
```

### Paso 2: Añadir al repositorio

```bash
git add .gitignore
git commit -m "chore: Añadir .gitignore"
```

**IMPORTANTE**: El archivo `.gitignore` SÍ debe estar en tu repositorio para que todos los colaboradores lo usen.

---

## 🎨 Sintaxis de .gitignore

### Patrones Básicos

```bash
# Comentarios (líneas que empiezan con #)
# Esto es un comentario

# Ignorar un archivo específico
secreto.txt
config.local.js

# Ignorar todos los archivos con una extensión
*.log
*.tmp
*.class

# Ignorar una carpeta completa
node_modules/
temp/
build/

# Ignorar carpetas en cualquier nivel
**/logs/
**/temp/

# Ignorar archivos en una ubicación específica
/config.local.js  # Solo en la raíz
src/test.js       # Solo en src/

# NO ignorar un archivo (excepción)
*.log
!important.log  # Este SÍ se incluye

# Ignorar todos los .txt excepto readme.txt
*.txt
!readme.txt
```

### Ejemplos Comentados

```bash
# ==========================================
# .gitignore para proyecto JavaScript/Node.js
# ==========================================

# Dependencias de Node.js
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Archivos de entorno (contienen secretos)
.env
.env.local
.env.*.local

# Archivos de construcción
dist/
build/
*.bundle.js

# Archivos del sistema operativo
.DS_Store      # macOS
Thumbs.db      # Windows
desktop.ini    # Windows

# Archivos del IDE
.vscode/
.idea/
*.swp          # Vim
*.swo          # Vim
*~             # Editores de texto

# Logs
logs/
*.log

# Caché
.cache/
.parcel-cache/
```

---

## 🔨 Ejemplo Práctico: Proyecto Node.js

### Paso 1: Crear un proyecto de ejemplo

```bash
# Crear carpeta del proyecto
mkdir proyecto-node
cd proyecto-node

# Inicializar Git
git init

# Inicializar npm (Node.js)
npm init -y
```

### Paso 2: Instalar una dependencia

```bash
# Esto crea la carpeta node_modules/ con miles de archivos
npm install express
```

### Paso 3: Ver el problema

```bash
git status
```

**Verás algo así:**
```
Untracked files:
  node_modules/     <- Miles de archivos!
  package.json
  package-lock.json
```

**Problema**: `node_modules/` puede tener miles de archivos. NO quieres esto en Git.

### Paso 4: Crear .gitignore

```bash
cat > .gitignore << 'EOF'
# Dependencias (no se deben commitear)
node_modules/

# Logs
npm-debug.log*

# Variables de entorno
.env
EOF
```

### Paso 5: Verificar

```bash
git status
```

**Ahora verás:**
```
Untracked files:
  .gitignore
  package.json
  package-lock.json
```

¡`node_modules/` ya no aparece! ✅

### Paso 6: Commitear

```bash
# Añadir archivos importantes
git add .
git commit -m "feat: Inicializar proyecto Node.js con Express"
```

---

## 🐍 Ejemplo: Proyecto Python

```bash
# .gitignore para Python
# =====================

# Entorno virtual
venv/
env/
.venv/
ENV/

# Archivos compilados de Python
__pycache__/
*.py[cod]
*$py.class
*.so

# Distribución / empaquetado
dist/
build/
*.egg-info/

# Jupyter Notebook
.ipynb_checkpoints/

# Archivos de entorno
.env

# PyCharm
.idea/

# VS Code
.vscode/

# Pytest
.pytest_cache/
.coverage
htmlcov/

# mypy
.mypy_cache/
```

---

## ☕ Ejemplo: Proyecto Java

```bash
# .gitignore para Java
# ====================

# Archivos compilados
*.class
*.jar
*.war
*.ear

# Logs
*.log

# Maven
target/
pom.xml.tag
pom.xml.releaseBackup
pom.xml.versionsBackup

# Gradle
.gradle/
build/

# IntelliJ IDEA
.idea/
*.iml
*.iws
out/

# Eclipse
.classpath
.project
.settings/

# NetBeans
nbproject/
nbbuild/
nbdist/
```

---

## 🌐 Plantillas .gitignore

GitHub proporciona plantillas para diferentes lenguajes:

### Obtener plantillas desde GitHub

```bash
# Descargar .gitignore para Node.js
curl https://raw.githubusercontent.com/github/gitignore/main/Node.gitignore > .gitignore

# Para Python
curl https://raw.githubusercontent.com/github/gitignore/main/Python.gitignore > .gitignore

# Para Java
curl https://raw.githubusercontent.com/github/gitignore/main/Java.gitignore > .gitignore
```

### Recurso útil

Visita: https://www.toptal.com/developers/gitignore

Genera .gitignore personalizados para múltiples tecnologías a la vez.

---

## 🚨 Problema Común: Archivo ya rastreado

### El Problema

```bash
# Ya commiteaste un archivo
git add secreto.txt
git commit -m "Añadir archivo secreto"

# Ahora lo añades a .gitignore
echo "secreto.txt" >> .gitignore

# Pero git status TODAVÍA lo muestra como rastreado
```

**¿Por qué?** Git ya está rastreando el archivo. `.gitignore` solo afecta archivos NO rastreados.

### La Solución

```bash
# 1. Eliminar del índice de Git (pero NO del disco)
git rm --cached secreto.txt

# 2. Commitear la eliminación
git commit -m "chore: Dejar de rastrear secreto.txt"

# 3. Ahora .gitignore funcionará
```

**Para una carpeta:**
```bash
git rm -r --cached node_modules/
git commit -m "chore: Dejar de rastrear node_modules"
```

---

## 🎯 Ejercicio Práctico 3: Proyecto Full-Stack

Crea un proyecto con archivos que debes ignorar:

```bash
# 1. Crear proyecto
mkdir fullstack-app
cd fullstack-app
git init

# 2. Crear estructura de carpetas
mkdir -p backend frontend

# 3. Simular archivos de backend (Node.js)
cd backend
npm init -y
npm install express
cd ..

# 4. Simular archivos de frontend
cd frontend
echo "console.log('App');" > app.js
mkdir node_modules  # Simular
touch node_modules/package1.js
cd ..

# 5. Crear archivo de configuración con secretos
echo "API_KEY=123456789" > .env
echo "DATABASE_PASSWORD=secreto" >> .env

# 6. Crear logs
mkdir logs
echo "Error en línea 42" > logs/app.log

# 7. Ver el desastre
git status
# Verás TODOS estos archivos...

# 8. Crear .gitignore apropiado
cat > .gitignore << 'EOF'
# Dependencias
**/node_modules/
package-lock.json

# Archivos de entorno
.env
.env.local

# Logs
logs/
*.log

# Archivos de construcción
dist/
build/
EOF

# 9. Verificar
git status
# Ahora solo verás archivos importantes

# 10. Crear archivos necesarios y commitear
echo "# Full Stack App" > README.md
git add .
git commit -m "feat: Inicializar proyecto full-stack"

# 11. Verificar que .gitignore funcionó
git log --name-only
# No deberías ver node_modules/, .env, o logs/
```

---

## 🔍 Ver archivos ignorados

```bash
# Ver archivos ignorados en el directorio actual
git status --ignored

# Verificar si un archivo está siendo ignorado
git check-ignore -v archivo.txt

# Ejemplo de salida:
# .gitignore:3:*.txt    archivo.txt
# ↑ archivo  ↑ línea  ↑ patrón  ↑ archivo checkeado
```

---

## 📁 .gitignore global

Puedes crear un .gitignore global para tu sistema:

```bash
# Crear archivo global
cat > ~/.gitignore_global << 'EOF'
# macOS
.DS_Store
.AppleDouble
.LSOverride

# Windows
Thumbs.db
Desktop.ini

# Linux
*~

# IDEs
.vscode/
.idea/
*.swp
*.swo
EOF

# Configurar Git para usarlo
git config --global core.excludesfile ~/.gitignore_global
```

**Esto ignorará estos archivos en TODOS tus proyectos.**

---

## 💡 Mejores Prácticas

### ✅ HACER

1. **Commitear .gitignore desde el inicio** del proyecto
2. **Usar plantillas** según tu stack tecnológico
3. **Añadir comentarios** para explicar secciones
4. **Ignorar archivos sensibles** (.env, credentials, etc.)
5. **Ignorar dependencias** que se pueden reinstalar

### ❌ NO HACER

1. **NO ignorar archivos importantes** para el proyecto
2. **NO commitear .env o secretos** primero y luego ignorarlos
3. **NO ignorar archivos de configuración** necesarios para el equipo
4. **NO abusar** de excepciones (`!`)

---

## 🧪 Ejercicio Final: Debugging .gitignore

Dado este escenario:

```bash
# Tienes este .gitignore
*.log
temp/
!important.log

# Y estos archivos
app.log          # ¿Ignorado?
debug.log        # ¿Ignorado?
important.log    # ¿Ignorado?
temp/cache.txt   # ¿Ignorado?
logs/error.log   # ¿Ignorado?
```

**Respuestas:**
- `app.log` → ✅ Ignorado (coincide con `*.log`)
- `debug.log` → ✅ Ignorado (coincide con `*.log`)
- `important.log` → ❌ NO ignorado (excepción con `!`)
- `temp/cache.txt` → ✅ Ignorado (carpeta temp/)
- `logs/error.log` → ✅ Ignorado (coincide con `*.log`)

---

## ✅ Checklist

Antes de continuar, asegúrate de:

- [ ] Entender qué archivos se deben ignorar
- [ ] Saber crear un archivo .gitignore
- [ ] Conocer patrones básicos (*.ext, carpeta/, etc.)
- [ ] Poder eliminar archivos ya rastreados con `git rm --cached`
- [ ] Saber obtener plantillas para tu tecnología
- [ ] Entender la diferencia entre .gitignore local y global

---

## 📌 Resumen de Comandos

| Comando | Descripción |
|---------|-------------|
| `touch .gitignore` | Crear archivo .gitignore |
| `git rm --cached archivo` | Dejar de rastrear archivo |
| `git rm -r --cached carpeta/` | Dejar de rastrear carpeta |
| `git status --ignored` | Ver archivos ignorados |
| `git check-ignore -v archivo` | Verificar si un archivo está ignorado |

---

## 📚 Recursos Adicionales

- 📖 [GitHub .gitignore templates](https://github.com/github/gitignore)
- 🔧 [gitignore.io](https://www.toptal.com/developers/gitignore) - Generador
- 📘 [Documentación oficial](https://git-scm.com/docs/gitignore)

---

## ➡️ Siguiente Paso

En la próxima lección aprenderás a:
- Deshacer cambios en archivos
- Modificar commits
- Volver a versiones anteriores
- Usar `git reset`, `git restore`, `git revert`

¡Continúa con `04-deshacer-cambios.md`!
