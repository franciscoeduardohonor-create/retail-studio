# Módulo 2: Trabajo con Ramas - Crear y Cambiar Ramas

## 📚 Nivel: Intermedio

---

## 🎯 Objetivos de esta lección

- Entender qué son las ramas y por qué son importantes
- Crear y eliminar ramas
- Cambiar entre ramas
- Ver y listar ramas
- Entender HEAD y el puntero de rama

---

## 🌿 ¿Qué es una Rama (Branch)?

Una rama es una **línea independiente de desarrollo**. Imagina que es una línea temporal alternativa donde puedes experimentar sin afectar el código principal.

### Analogía

```
Piensa en un libro con múltiples finales:

main (historia principal):  Capítulo 1 → Capítulo 2 → Capítulo 3
                                         ↓
feature-1 (final alternativo):    Capítulo 2a → Capítulo 2b
                                         ↓
feature-2 (otro final):           Capítulo 2x → Capítulo 2y
```

### Visualización

```
         A---B---C  (main)
              \
               D---E  (feature-nueva)
```

---

## 🤔 ¿Por qué usar ramas?

### Beneficios

1. **Desarrollo paralelo**: Múltiples personas trabajan en diferentes features simultáneamente
2. **Experimentación segura**: Prueba ideas sin romper el código que funciona
3. **Organización**: Cada feature/bugfix tiene su propia rama
4. **Aislamiento**: Los bugs en una rama no afectan a otras
5. **Revisión de código**: Facilita el code review antes de integrar cambios

### Casos de uso comunes

```
main          → Código estable en producción
develop       → Código en desarrollo
feature/login → Nueva funcionalidad de login
bugfix/typo   → Corrección de error tipográfico
hotfix/crash  → Corrección urgente en producción
```

---

## 📋 Ver ramas existentes

```bash
# Listar ramas locales
git branch

# Salida:
# * main    ← El asterisco (*) indica la rama actual
#   develop

# Listar ramas con último commit
git branch -v
# * main    a1b2c3d Último commit en main
#   develop d4e5f6g Último commit en develop

# Listar TODAS las ramas (locales y remotas)
git branch -a
```

---

## 🆕 Crear una rama

### Método 1: Crear rama (sin cambiar a ella)

```bash
# Crear rama nueva basada en la rama actual
git branch nombre-rama

# Verificar que se creó
git branch
# * main
#   nombre-rama
```

### Método 2: Crear y cambiar a la rama (RECOMENDADO)

```bash
# Crear y cambiar en un solo comando
git checkout -b nombre-rama

# O con el comando más moderno:
git switch -c nombre-rama

# -b = branch (crear nueva)
# -c = create (crear nueva)
```

### Método 3: Crear rama desde un commit específico

```bash
# Crear rama desde un commit anterior
git branch nueva-rama a1b2c3d

# Crear y cambiar desde un commit específico
git checkout -b nueva-rama a1b2c3d
```

---

## 🔄 Cambiar entre ramas

### Usando checkout (método tradicional)

```bash
# Cambiar a una rama existente
git checkout nombre-rama

# Verificar en qué rama estás
git branch
#   main
# * nombre-rama    ← Ahora estás aquí
```

### Usando switch (método moderno - Git 2.23+)

```bash
# Cambiar a una rama existente
git switch nombre-rama

# Volver a la rama anterior
git switch -

# Es como hacer "cd -" en bash
```

**Nota**: `git switch` es más intuitivo y seguro que `git checkout`.

### Diferencia entre checkout y switch

```bash
# checkout hace MUCHAS cosas:
git checkout rama        # Cambiar de rama
git checkout archivo     # Restaurar archivo
git checkout -b nueva    # Crear rama

# switch es más específico (solo para ramas):
git switch rama          # Cambiar de rama
git switch -c nueva      # Crear rama
```

---

## 🎬 Práctica Completa: Trabajar con ramas

### Paso 1: Crear un repositorio de ejemplo

```bash
# Crear proyecto
mkdir proyecto-ramas
cd proyecto-ramas
git init

# Crear commit inicial
echo "# Proyecto con Ramas" > README.md
git add README.md
git commit -m "Initial commit"

# Ver ramas
git branch
# * main
```

### Paso 2: Crear y trabajar en una rama de feature

```bash
# Crear rama para nueva funcionalidad
git switch -c feature/login
# O: git checkout -b feature/login

# Verificar rama actual
git branch
#   main
# * feature/login

# Crear archivo de login
cat > login.js << 'EOF'
function login(username, password) {
    console.log('Logging in...');
    // Implementación del login
    return true;
}
EOF

# Commitear en la rama
git add login.js
git commit -m "feat: Añadir función de login"

# Ver historial
git log --oneline
# b2c3d4e feat: Añadir función de login
# a1b2c3d Initial commit
```

### Paso 3: Volver a main y crear otra rama

```bash
# Volver a main
git switch main

# Verificar que login.js NO existe aquí
ls
# README.md    (login.js no está aquí)

# Crear otra rama para otro feature
git switch -c feature/register

# Crear archivo de registro
cat > register.js << 'EOF'
function register(username, email, password) {
    console.log('Registering user...');
    // Implementación del registro
    return true;
}
EOF

# Commitear
git add register.js
git commit -m "feat: Añadir función de registro"
```

### Paso 4: Visualizar el árbol de ramas

```bash
# Ver todas las ramas y sus commits
git log --oneline --graph --all

# Salida:
# * c3d4e5f (HEAD -> feature/register) feat: Añadir función de registro
# | * b2c3d4e (feature/login) feat: Añadir función de login
# |/
# * a1b2c3d (main) Initial commit
```

**Interpretación del gráfico:**
- Ambas ramas `feature/login` y `feature/register` se crearon desde `main`
- Cada una tiene su propio commit
- `HEAD` apunta a `feature/register` (rama actual)

---

## 🗑️ Eliminar ramas

### Eliminar rama local (seguro)

```bash
# Cambiar a otra rama primero (no puedes eliminar la rama actual)
git switch main

# Eliminar rama (solo si está fusionada)
git branch -d nombre-rama

# Si intentas eliminar una rama NO fusionada:
git branch -d feature/login
# error: The branch 'feature/login' is not fully merged.
```

### Eliminar rama forzadamente

```bash
# Forzar eliminación (CUIDADO: pierdes cambios no fusionados)
git branch -D nombre-rama

# -D es equivalente a --delete --force
```

### Ejemplo práctico

```bash
# Crear rama de prueba
git switch -c prueba-temporal
echo "Código de prueba" > test.txt
git add test.txt
git commit -m "Código temporal"

# Volver a main
git switch main

# Intentar eliminar (fallará porque no está fusionada)
git branch -d prueba-temporal
# error: The branch 'prueba-temporal' is not fully merged.

# Eliminar forzadamente
git branch -D prueba-temporal
# Deleted branch prueba-temporal

# Verificar
git branch
# * main
```

---

## 🎯 HEAD: ¿Dónde estás?

`HEAD` es un puntero que indica **dónde estás ahora** en el historial.

### Ver dónde está HEAD

```bash
# Ver en qué rama estás
git branch
# * main    ← HEAD está aquí

# Ver qué commit es HEAD
cat .git/HEAD
# ref: refs/heads/main

# Ver el commit específico
git log --oneline -1
# a1b2c3d (HEAD -> main) Initial commit
```

### HEAD en diferentes ramas

```bash
# En main
git switch main
git log --oneline -1
# a1b2c3d (HEAD -> main) Initial commit

# En feature/login
git switch feature/login
git log --oneline -1
# b2c3d4e (HEAD -> feature/login) feat: Añadir función de login

# HEAD se mueve al cambiar de rama
```

---

## 🎯 Ejercicio Práctico 5: Simulación de desarrollo real

Simula un flujo de trabajo real con múltiples ramas:

```bash
# 1. Crear proyecto
mkdir app-tareas
cd app-tareas
git init

# 2. Crear estructura inicial en main
cat > app.js << 'EOF'
// Aplicación de Tareas
const tareas = [];

console.log('App iniciada');
EOF

git add app.js
git commit -m "Initial commit: Estructura básica"

# 3. Crear rama para añadir tareas
git switch -c feature/añadir-tarea

cat >> app.js << 'EOF'

function añadirTarea(titulo) {
    tareas.push({ titulo, completada: false });
    console.log('Tarea añadida:', titulo);
}
EOF

git add app.js
git commit -m "feat: Implementar función añadir tarea"

# 4. Volver a main y crear rama para listar tareas
git switch main

git switch -c feature/listar-tareas

cat >> app.js << 'EOF'

function listarTareas() {
    console.log('Tareas:');
    tareas.forEach((tarea, index) => {
        console.log(`${index + 1}. ${tarea.titulo}`);
    });
}
EOF

git add app.js
git commit -m "feat: Implementar función listar tareas"

# 5. Crear rama para marcar como completada
git switch main
git switch -c feature/completar-tarea

cat >> app.js << 'EOF'

function completarTarea(index) {
    if (tareas[index]) {
        tareas[index].completada = true;
        console.log('Tarea completada');
    }
}
EOF

git add app.js
git commit -m "feat: Implementar función completar tarea"

# 6. Ver el árbol de ramas
git log --oneline --graph --all --decorate

# 7. Ver todas las ramas
git branch

# 8. Cambiar entre ramas y ver diferencias
git switch feature/añadir-tarea
cat app.js

git switch feature/listar-tareas
cat app.js

git switch feature/completar-tarea
cat app.js

# Nota: Cada rama tiene diferentes implementaciones
# En la próxima lección aprenderemos a fusionarlas
```

---

## 📊 Comandos Avanzados de Listado

### Ver ramas fusionadas

```bash
# Ver ramas ya fusionadas en la rama actual
git branch --merged

# Ver ramas NO fusionadas
git branch --no-merged
```

### Ver ramas con más detalles

```bash
# Ver último commit de cada rama
git branch -v

# Ver ramas y sus upstreams (remotos)
git branch -vv

# Listar ramas ordenadas por fecha del último commit
git branch --sort=-committerdate
```

### Filtrar ramas por patrón

```bash
# Ver solo ramas que empiezan con "feature/"
git branch --list "feature/*"

# Ejemplo de salida:
#   feature/login
#   feature/register
#   feature/logout
```

---

## 💡 Convenciones de Nombres de Ramas

### Estructura recomendada

```
tipo/descripción-corta

Ejemplos:
feature/user-authentication
feature/payment-integration
bugfix/login-error
bugfix/typo-in-homepage
hotfix/security-vulnerability
release/v1.2.0
docs/update-readme
```

### Tipos comunes

```
feature/   → Nueva funcionalidad
bugfix/    → Corrección de bug
hotfix/    → Corrección urgente
release/   → Preparación de release
docs/      → Documentación
refactor/  → Refactorización
test/      → Añadir/modificar tests
chore/     → Tareas de mantenimiento
```

### Buenas prácticas

```bash
# ✅ BIEN
git switch -c feature/user-profile
git switch -c bugfix/fix-login-validation
git switch -c hotfix/security-patch

# ❌ MAL
git switch -c rama1
git switch -c test
git switch -c mi-codigo
```

---

## ⚠️ Advertencias Importantes

### 1. No cambies de rama con cambios sin commitear

```bash
# Estás en feature/login con cambios
echo "Cambio sin commitear" > archivo.txt

# Intentas cambiar de rama
git switch main
# error: Your local changes would be overwritten by checkout.
# Please commit your changes or stash them.
```

**Soluciones:**
- Commitea los cambios: `git add . && git commit -m "mensaje"`
- Guárdalos temporalmente: `git stash` (veremos esto más adelante)
- Descarta los cambios: `git restore .` (si no los necesitas)

### 2. Asegúrate de estar en la rama correcta

```bash
# Siempre verifica antes de hacer commits
git branch

# O añade la rama al prompt de tu terminal
# (veremos configuración de prompt más adelante)
```

---

## ✅ Checklist

Antes de continuar, asegúrate de poder:

- [ ] Listar ramas con `git branch`
- [ ] Crear ramas con `git switch -c` o `git checkout -b`
- [ ] Cambiar entre ramas con `git switch` o `git checkout`
- [ ] Eliminar ramas con `git branch -d`
- [ ] Entender qué es HEAD
- [ ] Ver el árbol de commits con `git log --graph --all`
- [ ] Seguir convenciones de nombres de ramas

---

## 📌 Resumen de Comandos

| Comando | Descripción |
|---------|-------------|
| `git branch` | Listar ramas |
| `git branch nombre` | Crear rama |
| `git switch -c nombre` | Crear y cambiar a rama |
| `git switch nombre` | Cambiar a rama |
| `git switch -` | Volver a rama anterior |
| `git branch -d nombre` | Eliminar rama (seguro) |
| `git branch -D nombre` | Eliminar rama (forzado) |
| `git branch -v` | Listar con último commit |
| `git branch --merged` | Ramas fusionadas |
| `git log --graph --all` | Ver árbol de ramas |

---

## ➡️ Siguiente Paso

En la próxima lección aprenderás a:
- Fusionar ramas (merge)
- Diferentes tipos de merge
- Estrategias de fusión
- Fast-forward vs merge commits

¡Continúa con `02-fusionar-ramas-merge.md`!
