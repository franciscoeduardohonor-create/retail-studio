# Módulo 2: Trabajo con Ramas - Resolver Conflictos

## 📚 Nivel: Intermedio

---

## 🎯 Objetivos de esta lección

- Entender qué son los conflictos y por qué ocurren
- Identificar conflictos en archivos
- Resolver conflictos manualmente
- Usar herramientas de merge
- Prevenir conflictos
- Abortar un merge problemático

---

## ⚔️ ¿Qué es un Conflicto?

Un **conflicto** ocurre cuando Git no puede fusionar automáticamente los cambios porque dos ramas modificaron **las mismas líneas** de un archivo de formas diferentes.

### Ejemplo Visual

```
Commit Base (ancestro común):
archivo.txt: "Hola Mundo"

Rama A (main):
archivo.txt: "Hola Mundo Hermoso"
              ↑ cambió "Mundo" a "Mundo Hermoso"

Rama B (feature):
archivo.txt: "Hola Universo"
              ↑ cambió "Mundo" a "Universo"

Git dice: "¿Cuál versión quieres? ¡Tú decides!"
```

---

## 🔍 Cuándo OCURREN conflictos

### ✅ SIN conflicto (Git fusiona automáticamente)

```bash
# Archivo: app.js

# En main:
function login() {     # ← Sin cambios
    console.log('OK');
}
function logout() {    # ← Nueva función añadida
    console.log('Bye');
}

# En feature:
function login() {     # ← Sin cambios
    console.log('OK');
}
function register() {  # ← Nueva función añadida (diferente)
    console.log('Hi');
}

# Git puede combinar automáticamente:
function login() {
    console.log('OK');
}
function logout() {
    console.log('Bye');
}
function register() {
    console.log('Hi');
}
```

### ❌ CON conflicto (Git no puede decidir)

```bash
# Archivo: app.js

# En main:
function login() {
    return true;  # ← Cambiado
}

# En feature:
function login() {
    return false; # ← Cambiado DIFERENTE
}

# ¡CONFLICTO! Git no sabe cuál elegir.
```

---

## 🎬 Crear un Conflicto Intencionalmente

Vamos a crear un conflicto para aprender a resolverlo:

```bash
# 1. Crear repositorio de prueba
mkdir test-conflictos
cd test-conflictos
git init

# 2. Crear archivo base
cat > saludo.txt << 'EOF'
Hola
Este es un archivo
Adiós
EOF

git add saludo.txt
git commit -m "Versión inicial"

# 3. Crear rama y modificar PRIMERA línea
git switch -c feature/cambio

# Modificar primera línea
cat > saludo.txt << 'EOF'
Buenos días
Este es un archivo
Adiós
EOF

git add saludo.txt
git commit -m "Cambiar saludo a Buenos días"

# 4. Volver a main y modificar la MISMA línea DIFERENTE
git switch main

cat > saludo.txt << 'EOF'
Buenas tardes
Este es un archivo
Adiós
EOF

git add saludo.txt
git commit -m "Cambiar saludo a Buenas tardes"

# 5. Intentar fusionar (¡aquí viene el conflicto!)
git merge feature/cambio
```

**Salida del conflicto:**
```
Auto-merging saludo.txt
CONFLICT (content): Merge conflict in saludo.txt
Automatic merge failed; fix conflicts and then commit the result.
```

---

## 📝 Anatomía de un Conflicto

Cuando hay un conflicto, Git marca el archivo así:

```bash
# Ver el archivo con conflicto
cat saludo.txt
```

**Contenido:**
```
<<<<<<< HEAD
Buenas tardes
=======
Buenos días
>>>>>>> feature/cambio
Este es un archivo
Adiós
```

### Interpretación de los marcadores

```
<<<<<<< HEAD              ← Inicio del conflicto
Buenas tardes             ← Versión en la rama actual (main)
=======                   ← Separador
Buenos días               ← Versión en la rama que estás fusionando (feature)
>>>>>>> feature/cambio    ← Fin del conflicto (nombre de la rama origen)
```

---

## 🔧 Resolver el Conflicto Manualmente

### Opción 1: Elegir una versión

```bash
# Editar el archivo y dejar solo la versión que quieres

# Opción A: Quedarte con "Buenas tardes"
cat > saludo.txt << 'EOF'
Buenas tardes
Este es un archivo
Adiós
EOF

# Opción B: Quedarte con "Buenos días"
cat > saludo.txt << 'EOF'
Buenos días
Este es un archivo
Adiós
EOF

# Opción C: Combinar ambas
cat > saludo.txt << 'EOF'
Buenos días y buenas tardes
Este es un archivo
Adiós
EOF

# Opción D: Escribir algo completamente nuevo
cat > saludo.txt << 'EOF'
Saludos cordiales
Este es un archivo
Adiós
EOF
```

### Paso a paso: Resolución completa

```bash
# 1. Ver archivos con conflicto
git status

# Salida:
# You have unmerged paths.
#   (fix conflicts and run "git commit")
#
# Unmerged paths:
#   (use "git add <file>..." to mark resolution)
#         both modified:   saludo.txt

# 2. Abrir el archivo y editarlo
# (elimina los marcadores <<<<<<, =======, >>>>>> y elige qué conservar)

# Por ejemplo, decidimos usar "Buenos días":
cat > saludo.txt << 'EOF'
Buenos días
Este es un archivo
Adiós
EOF

# 3. Marcar como resuelto añadiéndolo al staging
git add saludo.txt

# 4. Verificar estado
git status
# All conflicts fixed but you are still merging.
#   (use "git commit" to conclude merge)

# 5. Finalizar el merge
git commit -m "Merge feature/cambio: Resolver conflicto en saludo.txt"

# Nota: Git crea un mensaje por defecto, pero puedes cambiarlo

# 6. Verificar que se completó
git log --oneline --graph
```

---

## 🎯 Ejercicio Práctico 7: Resolver Conflictos Complejos

```bash
# === CONFIGURACIÓN ===
mkdir proyecto-conflictos
cd proyecto-conflictos
git init

# Crear archivo de configuración
cat > config.js << 'EOF'
const config = {
    apiUrl: 'https://api.example.com',
    timeout: 3000,
    retries: 3,
    debug: false
};

module.exports = config;
EOF

git add config.js
git commit -m "Configuración inicial"

# === RAMA 1: Cambios para producción ===
git switch -c config/produccion

cat > config.js << 'EOF'
const config = {
    apiUrl: 'https://api.produccion.com',  // Cambio 1
    timeout: 5000,                          // Cambio 2
    retries: 3,
    debug: false
};

module.exports = config;
EOF

git add config.js
git commit -m "Configurar para producción"

# === RAMA 2: Cambios para desarrollo ===
git switch main
git switch -c config/desarrollo

cat > config.js << 'EOF'
const config = {
    apiUrl: 'https://api.dev.com',    // Cambio diferente
    timeout: 3000,
    retries: 5,                        // Cambio 3
    debug: true                        // Cambio 4
};

module.exports = config;
EOF

git add config.js
git commit -m "Configurar para desarrollo"

# === INTENTAR FUSIONAR ===
git switch main
git merge config/produccion
# OK - Fast-forward

git merge config/desarrollo
# ¡CONFLICTO!

# Ver el conflicto
cat config.js
```

**El archivo mostrará:**
```javascript
const config = {
<<<<<<< HEAD
    apiUrl: 'https://api.produccion.com',
    timeout: 5000,
=======
    apiUrl: 'https://api.dev.com',
    timeout: 3000,
    retries: 5,
>>>>>>> config/desarrollo
    retries: 3,
    debug: false
};

module.exports = config;
```

**Resolver tomando lo mejor de cada rama:**
```bash
cat > config.js << 'EOF'
const config = {
    apiUrl: process.env.NODE_ENV === 'production'
        ? 'https://api.produccion.com'
        : 'https://api.dev.com',
    timeout: 5000,
    retries: 5,
    debug: process.env.NODE_ENV !== 'production'
};

module.exports = config;
EOF

# Finalizar
git add config.js
git commit -m "Merge configs: Combinar configuraciones de prod y dev"
```

---

## 🛠️ Herramientas para Resolver Conflictos

### 1. Editor de Texto (VS Code)

VS Code detecta conflictos automáticamente y ofrece botones:
- **Accept Current Change**: Acepta la versión de HEAD
- **Accept Incoming Change**: Acepta la versión de la rama que fusionas
- **Accept Both Changes**: Acepta ambas versiones
- **Compare Changes**: Ver diferencias lado a lado

### 2. Herramienta de Merge de Git

```bash
# Abrir herramienta de merge configurada
git mergetool

# Configurar VS Code como herramienta de merge
git config --global merge.tool vscode
git config --global mergetool.vscode.cmd 'code --wait $MERGED'

# Configurar otras herramientas populares
git config --global merge.tool meld       # Meld
git config --global merge.tool kdiff3     # KDiff3
git config --global merge.tool p4merge    # P4Merge
```

### 3. Comandos para ver diferencias

```bash
# Ver conflictos pendientes
git diff

# Ver qué cambió en nuestra rama
git diff --ours

# Ver qué cambió en su rama
git diff --theirs

# Ver el ancestro común
git show :1:archivo.txt   # Base
git show :2:archivo.txt   # Ours (nuestra versión)
git show :3:archivo.txt   # Theirs (su versión)
```

---

## ❌ Abortar un Merge

Si el conflicto es muy complejo o cometiste un error:

```bash
# Cancelar el merge y volver al estado anterior
git merge --abort

# Verificar que volvió al estado pre-merge
git status
# On branch main
# nothing to commit, working tree clean
```

**Cuándo abortar:**
- Los conflictos son demasiado complejos
- Te das cuenta que no deberías haber fusionado
- Quieres replantear la estrategia

---

## 🎯 Ejercicio Práctico 8: Conflictos Múltiples

```bash
# Crear proyecto con múltiples archivos
mkdir app-completa
cd app-completa
git init

# Crear varios archivos
cat > usuarios.js << 'EOF'
function getUsuarios() {
    return fetch('/api/users');
}
EOF

cat > productos.js << 'EOF'
function getProductos() {
    return fetch('/api/products');
}
EOF

git add .
git commit -m "Versión inicial"

# === RAMA: Mejorar manejo de errores ===
git switch -c feature/error-handling

cat > usuarios.js << 'EOF'
function getUsuarios() {
    return fetch('/api/users')
        .catch(error => console.error('Error:', error));
}
EOF

cat > productos.js << 'EOF'
function getProductos() {
    return fetch('/api/products')
        .catch(error => console.error('Error:', error));
}
EOF

git add .
git commit -m "Añadir manejo de errores"

# === RAMA: Cambiar URLs ===
git switch main
git switch -c feature/new-api

cat > usuarios.js << 'EOF'
function getUsuarios() {
    return fetch('/api/v2/users');
}
EOF

cat > productos.js << 'EOF'
function getProductos() {
    return fetch('/api/v2/products');
}
EOF

git add .
git commit -m "Actualizar a API v2"

# === FUSIONAR ===
git switch main
git merge feature/error-handling
# OK

git merge feature/new-api
# ¡CONFLICTOS en AMBOS archivos!

# Ver archivos con conflicto
git status

# Resolver usuarios.js
cat > usuarios.js << 'EOF'
function getUsuarios() {
    return fetch('/api/v2/users')
        .catch(error => console.error('Error:', error));
}
EOF

# Resolver productos.js
cat > productos.js << 'EOF'
function getProductos() {
    return fetch('/api/v2/products')
        .catch(error => console.error('Error:', error));
}
EOF

# Marcar como resueltos
git add usuarios.js productos.js

# Verificar que todos los conflictos están resueltos
git status

# Finalizar merge
git commit -m "Merge: Combinar manejo de errores con API v2"
```

---

## 🚨 Casos Especiales de Conflictos

### Conflicto: Archivo eliminado vs modificado

```bash
# En rama A: Eliminas un archivo
git rm archivo.txt

# En rama B: Modificas el mismo archivo
echo "Cambios" >> archivo.txt

# Al fusionar:
# CONFLICT (modify/delete): archivo.txt deleted in rama-A and modified in rama-B

# Resolver:
# Opción 1: Mantener el archivo
git add archivo.txt

# Opción 2: Confirmar la eliminación
git rm archivo.txt
```

### Conflicto: Archivo renombrado

```bash
# En rama A: Renombras archivo.txt a nuevo.txt
git mv archivo.txt nuevo.txt

# En rama B: Modificas archivo.txt

# Git intentará detectar el renombrado y aplicar cambios
# Si falla, tendrás que resolver manualmente
```

---

## 🛡️ Prevenir Conflictos

### Mejores Prácticas

```bash
# 1. Fusiona frecuentemente desde main a tu rama
git switch mi-feature
git merge main  # Trae cambios de main regularmente

# 2. Mantén commits pequeños y enfocados
git commit -m "Cambio específico en función X"
# Mejor que un commit gigante con muchos cambios

# 3. Comunícate con tu equipo
# "Voy a trabajar en el archivo X"
# Evita que dos personas editen las mismas líneas

# 4. Divide el trabajo en archivos/módulos separados
# Menos probable que dos personas editen el mismo archivo

# 5. Usa feature flags para cambios grandes
# Permite integrar código parcialmente sin romper nada
```

---

## 📊 Estrategias de Resolución

### Estrategia 1: Siempre usar "ours" (nuestra versión)

```bash
# En caso de conflicto, siempre usa la versión de tu rama
git merge -X ours rama-otra

# Útil cuando sabes que tu versión es la correcta
```

### Estrategia 2: Siempre usar "theirs" (su versión)

```bash
# En caso de conflicto, siempre usa la versión de la rama que fusionas
git merge -X theirs rama-otra

# Útil cuando sabes que la otra rama tiene la razón
```

### Estrategia 3: Resolver manualmente (recomendado)

```bash
# Sin opciones automáticas, resuelves cada conflicto tú mismo
git merge rama-otra

# Permite combinar lo mejor de ambas versiones
```

---

## ✅ Checklist de Resolución de Conflictos

Al resolver un conflicto, verifica:

- [ ] Eliminaste TODOS los marcadores (`<<<<<<<`, `=======`, `>>>>>>>`)
- [ ] El código tiene sentido y es sintácticamente correcto
- [ ] Probaste que funciona (compila, tests pasan)
- [ ] Añadiste todos los archivos resueltos con `git add`
- [ ] Hiciste commit para finalizar el merge
- [ ] Documentaste decisiones importantes en el mensaje del commit

---

## 💡 Debugging de Conflictos

```bash
# Ver qué archivos están en conflicto
git status

# Ver diferencias detalladas
git diff

# Ver historial de cambios en archivo específico
git log -p archivo.txt

# Ver quién modificó qué línea (blame)
git blame archivo.txt

# Ver el merge en progreso
git log --merge

# Listar archivos con conflictos
git diff --name-only --diff-filter=U
```

---

## ✅ Checklist

Antes de continuar, asegúrate de poder:

- [ ] Entender por qué ocurren conflictos
- [ ] Identificar marcadores de conflicto en archivos
- [ ] Resolver conflictos manualmente
- [ ] Usar `git add` para marcar archivos resueltos
- [ ] Finalizar un merge con `git commit`
- [ ] Abortar un merge con `git merge --abort`
- [ ] Prevenir conflictos con buenas prácticas

---

## 📌 Resumen de Comandos

| Comando | Descripción |
|---------|-------------|
| `git status` | Ver archivos con conflicto |
| `git diff` | Ver detalles de conflictos |
| `git add <archivo>` | Marcar conflicto como resuelto |
| `git commit` | Finalizar merge |
| `git merge --abort` | Cancelar merge |
| `git mergetool` | Abrir herramienta de merge |
| `git merge -X ours` | Preferir nuestra versión |
| `git merge -X theirs` | Preferir su versión |

---

## ➡️ Siguiente Paso

¡Felicidades! Completaste el Módulo 2: Trabajo con Ramas.

En el próximo módulo aprenderás:
- Trabajar con repositorios remotos (GitHub, GitLab, etc.)
- Clonar, pull, push
- Colaboración en equipo
- Pull requests y code review

¡Continúa con el **Módulo 3**: `../modulo-03-colaboracion/01-repositorios-remotos.md`!
