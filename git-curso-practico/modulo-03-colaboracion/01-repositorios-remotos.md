# Módulo 3: Colaboración y Trabajo Remoto - Repositorios Remotos

## 📚 Nivel: Intermedio-Avanzado

---

## 🎯 Objetivos de esta lección

- Entender qué son los repositorios remotos
- Conectar un repositorio local con GitHub/GitLab
- Clonar repositorios existentes
- Ver y gestionar remotos
- Push y pull de cambios

---

## 🌐 ¿Qué es un Repositorio Remoto?

Un **repositorio remoto** es una versión de tu proyecto alojada en Internet o en una red. Permite:

- 👥 **Colaboración**: Múltiples personas trabajando en el mismo proyecto
- 💾 **Backup**: Tu código está seguro en la nube
- 🌍 **Acceso**: Trabajar desde cualquier computadora
- 🔄 **Sincronización**: Mantener versiones actualizadas

### Servicios Populares

```
GitHub      → https://github.com       (más popular)
GitLab      → https://gitlab.com       (open source)
Bitbucket   → https://bitbucket.org    (integración con Atlassian)
Azure Repos → https://azure.microsoft.com
```

---

## 📋 Conceptos Clave

### Remote vs Local

```
┌─────────────────────────────────────────┐
│  Repositorio LOCAL                      │
│  (Tu computadora)                       │
│  ┌─────────────┐                        │
│  │   main      │                        │
│  │ feature/x   │                        │
│  └─────────────┘                        │
└─────────────────────────────────────────┘
           ↕ push/pull
┌─────────────────────────────────────────┐
│  Repositorio REMOTO                     │
│  (GitHub/GitLab/etc)                    │
│  ┌─────────────┐                        │
│  │   main      │                        │
│  │ feature/x   │                        │
│  └─────────────┘                        │
└─────────────────────────────────────────┘
```

### Origin

`origin` es el nombre por defecto del repositorio remoto principal.

```bash
# "origin" es solo un alias para la URL del repositorio remoto
origin → https://github.com/usuario/proyecto.git
```

---

## 🆕 Escenario 1: Crear Repositorio Local y Subirlo

### Paso 1: Crear cuenta en GitHub

1. Ve a https://github.com
2. Crea una cuenta (si no tienes una)
3. Verifica tu email

### Paso 2: Crear repositorio en GitHub

1. Click en "+" → "New repository"
2. Nombre: `mi-primer-repo`
3. Descripción: "Mi primer repositorio Git"
4. **NO** inicialices con README (ya tienes commits locales)
5. Click "Create repository"

### Paso 3: Conectar repositorio local existente

```bash
# Crear proyecto local
mkdir mi-primer-repo
cd mi-primer-repo
git init

# Crear algunos commits
echo "# Mi Primer Repo" > README.md
git add README.md
git commit -m "Initial commit"

echo "console.log('Hola');" > app.js
git add app.js
git commit -m "feat: Añadir app.js"

# Ver estado actual
git log --oneline
# b2b2b2b feat: Añadir app.js
# a1a1a1a Initial commit

# Añadir el remoto (copia la URL de tu repositorio en GitHub)
git remote add origin https://github.com/TU-USUARIO/mi-primer-repo.git

# Verificar que se añadió
git remote -v
# origin  https://github.com/TU-USUARIO/mi-primer-repo.git (fetch)
# origin  https://github.com/TU-USUARIO/mi-primer-repo.git (push)

# Subir tus commits al remoto
git push -u origin main
# -u: establece "upstream" (relación entre rama local y remota)
# origin: nombre del remoto
# main: nombre de la rama

# ¡Ahora tu código está en GitHub!
```

### Paso 4: Verificar en GitHub

1. Refresca la página de tu repositorio en GitHub
2. Deberías ver tus archivos README.md y app.js
3. Ver commits en la pestaña "Commits"

---

## 📥 Escenario 2: Clonar un Repositorio Existente

### Qué es clonar

**Clonar** es copiar un repositorio completo (con todo su historial) a tu computadora.

```bash
# Sintaxis básica
git clone <url-del-repositorio>

# Ejemplo: Clonar un proyecto de GitHub
git clone https://github.com/usuario/proyecto.git

# Clonar con un nombre diferente
git clone https://github.com/usuario/proyecto.git mi-carpeta

# Clonar solo la rama principal (más rápido)
git clone --depth 1 https://github.com/usuario/proyecto.git
```

### Práctica: Clonar un repositorio público

```bash
# Ir a tu carpeta de proyectos
cd ~/proyectos

# Clonar un repositorio de ejemplo
git clone https://github.com/github/gitignore.git

# Entrar al repositorio clonado
cd gitignore

# Ver el historial
git log --oneline

# Ver el remoto configurado automáticamente
git remote -v
# origin  https://github.com/github/gitignore.git (fetch)
# origin  https://github.com/github/gitignore.git (push)

# Ver ramas
git branch -a
# * main
#   remotes/origin/HEAD -> origin/main
#   remotes/origin/main
```

**Nota**: Al clonar, Git automáticamente:
1. Crea la carpeta del proyecto
2. Inicializa Git
3. Configura el remoto como "origin"
4. Descarga todos los commits e historial
5. Hace checkout de la rama principal

---

## 🔄 Push: Subir Cambios

### Push Básico

```bash
# Hacer cambios locales
echo "Nuevo contenido" >> archivo.txt
git add archivo.txt
git commit -m "Actualizar archivo"

# Subir a remoto
git push origin main
```

### Primera vez en una rama nueva

```bash
# Crear rama local
git switch -c feature/nueva-funcionalidad

# Hacer commits
echo "Nueva función" > funcion.js
git add funcion.js
git commit -m "feat: Nueva funcionalidad"

# Push con -u (establece upstream)
git push -u origin feature/nueva-funcionalidad

# De ahora en adelante, solo necesitas:
git push
# Git sabe que debe push a origin/feature/nueva-funcionalidad
```

### Push todas las ramas

```bash
# Subir TODAS las ramas locales al remoto
git push --all origin
```

### Push tags

```bash
# Crear un tag
git tag v1.0.0

# Push del tag
git push origin v1.0.0

# Push todos los tags
git push --tags
```

---

## 📥 Pull: Descargar Cambios

### Pull Básico

```bash
# Descargar y fusionar cambios del remoto
git pull origin main

# Si ya configuraste upstream con -u:
git pull
```

### ¿Qué hace pull?

`git pull` es equivalente a:
```bash
git fetch origin      # Descargar cambios
git merge origin/main # Fusionar cambios
```

### Pull con rebase

```bash
# En vez de merge, hace rebase
git pull --rebase origin main

# Ventaja: Historial más lineal
# Veremos más sobre rebase en módulo avanzado
```

---

## 📋 Gestionar Remotos

### Ver remotos

```bash
# Listar remotos
git remote

# Listar remotos con URLs
git remote -v

# Ver detalles de un remoto
git remote show origin
```

### Añadir remotos

```bash
# Añadir un remoto nuevo
git remote add nombre-remoto https://github.com/user/repo.git

# Ejemplo: Añadir remoto de colaborador
git remote add colaborador https://github.com/colaborador/proyecto.git

# Ver todos los remotos
git remote -v
# origin       https://github.com/tu-usuario/proyecto.git (fetch)
# origin       https://github.com/tu-usuario/proyecto.git (push)
# colaborador  https://github.com/colaborador/proyecto.git (fetch)
# colaborador  https://github.com/colaborador/proyecto.git (push)
```

### Renombrar remotos

```bash
# Renombrar un remoto
git remote rename origin principal

# Verificar
git remote -v
# principal  https://github.com/usuario/proyecto.git (fetch)
# principal  https://github.com/usuario/proyecto.git (push)
```

### Eliminar remotos

```bash
# Eliminar un remoto
git remote remove colaborador

# Verificar
git remote -v
```

### Cambiar URL del remoto

```bash
# Cambiar URL (útil cuando mueves el repo a otra cuenta)
git remote set-url origin https://github.com/nueva-cuenta/proyecto.git

# Verificar
git remote -v
```

---

## 🌿 Ramas Remotas

### Ver ramas remotas

```bash
# Ver solo ramas locales
git branch

# Ver todas las ramas (locales y remotas)
git branch -a

# Ver solo ramas remotas
git branch -r

# Salida ejemplo:
# remotes/origin/main
# remotes/origin/feature/login
# remotes/origin/bugfix/error-handler
```

### Tracking branches (ramas rastreadas)

```bash
# Ver relación entre ramas locales y remotas
git branch -vv

# Salida ejemplo:
# * main    a1b2c3d [origin/main] Último commit
#   feature b2c3d4e [origin/feature: ahead 2] Commits ahead
```

**Significado:**
- `[origin/main]`: Esta rama local rastrea origin/main
- `ahead 2`: Tienes 2 commits que no has pusheado
- `behind 3`: El remoto tiene 3 commits que no has traído

### Crear rama local desde remota

```bash
# Descargar información de ramas remotas
git fetch origin

# Crear rama local que rastree remota
git switch feature/login
# Git automáticamente crea la rama local y la conecta con origin/feature/login

# Forma explícita:
git switch -c feature/login origin/feature/login
```

### Eliminar rama remota

```bash
# Eliminar rama del remoto
git push origin --delete nombre-rama

# Verificar
git branch -r
# La rama ya no aparece en origin
```

---

## 🎯 Ejercicio Práctico 9: Flujo Completo con Remoto

### Parte 1: Configuración Inicial

```bash
# 1. Crear repositorio en GitHub
# - Ve a GitHub → New repository
# - Nombre: "practica-remoto"
# - Público o Privado
# - NO inicialices con README
# - Copia la URL

# 2. Crear proyecto local
mkdir practica-remoto
cd practica-remoto
git init

# 3. Crear contenido inicial
cat > README.md << 'EOF'
# Práctica de Repositorio Remoto

Este proyecto practica:
- Push y pull
- Ramas remotas
- Colaboración
EOF

cat > app.js << 'EOF'
console.log('Aplicación iniciada');
EOF

# 4. Primer commit
git add .
git commit -m "Initial commit"

# 5. Conectar con GitHub
git remote add origin https://github.com/TU-USUARIO/practica-remoto.git

# 6. Push inicial
git push -u origin main
```

### Parte 2: Trabajar con Ramas Remotas

```bash
# 7. Crear rama feature
git switch -c feature/usuarios

cat > usuarios.js << 'EOF'
const usuarios = [];

function añadirUsuario(nombre) {
    usuarios.push(nombre);
}

module.exports = { añadirUsuario };
EOF

git add usuarios.js
git commit -m "feat: Añadir módulo de usuarios"

# 8. Push de la rama feature
git push -u origin feature/usuarios

# 9. Verificar en GitHub que la rama existe

# 10. Crear otra rama
git switch main
git switch -c feature/productos

cat > productos.js << 'EOF'
const productos = [];

function añadirProducto(nombre, precio) {
    productos.push({ nombre, precio });
}

module.exports = { añadirProducto };
EOF

git add productos.js
git commit -m "feat: Añadir módulo de productos"

# 11. Push
git push -u origin feature/productos

# 12. Ver todas las ramas (locales y remotas)
git branch -a
```

### Parte 3: Simular Colaboración

```bash
# 13. Ir a GitHub y editar README.md directamente
# - Añade una línea: "## Instalación"
# - Commit en GitHub: "docs: Añadir sección de instalación"

# 14. En tu máquina local, pull de los cambios
git switch main
git pull origin main

# 15. Ver el cambio
cat README.md

# 16. Fusionar features en main
git merge feature/usuarios
git merge feature/productos

# 17. Push de main actualizado
git push origin main

# 18. Eliminar ramas locales fusionadas
git branch -d feature/usuarios
git branch -d feature/productos

# 19. Eliminar ramas remotas
git push origin --delete feature/usuarios
git push origin --delete feature/productos

# 20. Verificar en GitHub que solo queda main
```

---

## 🔐 Autenticación con GitHub

### HTTPS vs SSH

```
HTTPS:
✅ Fácil de configurar
✅ Funciona en redes restrictivas
❌ Requiere usuario/contraseña cada vez (o token)

SSH:
✅ No requiere contraseña después de configurar
✅ Más seguro
❌ Requiere configuración inicial
```

### Configurar SSH (Recomendado)

```bash
# 1. Generar llave SSH
ssh-keygen -t ed25519 -C "tu.email@ejemplo.com"
# Presiona Enter para ubicación por defecto
# Opcionalmente, añade una contraseña

# 2. Iniciar el agente SSH
eval "$(ssh-agent -s)"

# 3. Añadir la llave al agente
ssh-add ~/.ssh/id_ed25519

# 4. Copiar la llave pública
cat ~/.ssh/id_ed25519.pub
# Copia todo el contenido

# 5. Añadir en GitHub
# - GitHub → Settings → SSH and GPG keys
# - New SSH key
# - Pega la llave pública
# - Save

# 6. Verificar conexión
ssh -T git@github.com
# Salida: "Hi tu-usuario! You've successfully authenticated..."

# 7. Cambiar remoto a SSH
git remote set-url origin git@github.com:TU-USUARIO/proyecto.git

# 8. Verificar
git remote -v
# origin  git@github.com:TU-USUARIO/proyecto.git (fetch)
# origin  git@github.com:TU-USUARIO/proyecto.git (push)
```

### Personal Access Token (si usas HTTPS)

```bash
# 1. Ir a GitHub → Settings → Developer settings → Personal access tokens
# 2. Generate new token (classic)
# 3. Seleccionar scopes: repo (todos)
# 4. Generate token
# 5. COPIAR el token (no podrás verlo de nuevo)

# 6. Usar el token como contraseña al hacer push
git push origin main
# Username: tu-usuario
# Password: [pega el token aquí]

# 7. Guardar credenciales (opcional)
git config --global credential.helper store
# La próxima vez se guardarán automáticamente
```

---

## 📊 Fetch vs Pull

### git fetch

```bash
# Solo DESCARGA cambios, NO los fusiona
git fetch origin

# Ver qué descargó
git log origin/main

# Decidir si fusionar
git merge origin/main
```

### git pull

```bash
# DESCARGA Y FUSIONA en un solo paso
git pull origin main

# Equivalente a:
# git fetch origin
# git merge origin/main
```

### Cuándo usar cada uno

**Usa `fetch` cuando:**
- Quieres ver cambios antes de fusionar
- Quieres revisar qué hicieron otros
- Trabajas en una rama sensible

**Usa `pull` cuando:**
- Confías en los cambios remotos
- Quieres actualizar rápidamente
- Trabajas solo en tu rama

---

## ✅ Checklist

Antes de continuar, asegúrate de poder:

- [ ] Crear un repositorio en GitHub/GitLab
- [ ] Conectar repositorio local con remoto (`git remote add`)
- [ ] Clonar un repositorio (`git clone`)
- [ ] Subir cambios con `git push`
- [ ] Descargar cambios con `git pull`
- [ ] Ver y gestionar remotos (`git remote -v`)
- [ ] Trabajar con ramas remotas
- [ ] Configurar autenticación SSH

---

## 📌 Resumen de Comandos

| Comando | Descripción |
|---------|-------------|
| `git clone <url>` | Clonar repositorio |
| `git remote add origin <url>` | Añadir remoto |
| `git remote -v` | Ver remotos |
| `git push -u origin main` | Push con upstream |
| `git push` | Push a rama upstream |
| `git pull` | Pull y merge |
| `git fetch` | Solo descargar cambios |
| `git branch -r` | Ver ramas remotas |
| `git push origin --delete rama` | Eliminar rama remota |
| `git remote show origin` | Ver detalles del remoto |

---

## ➡️ Siguiente Paso

En la próxima lección aprenderás a:
- Colaborar en equipo
- Fork y pull requests
- Code review
- Estrategias de branching en equipo

¡Continúa con `02-colaboracion-en-equipo.md`!
