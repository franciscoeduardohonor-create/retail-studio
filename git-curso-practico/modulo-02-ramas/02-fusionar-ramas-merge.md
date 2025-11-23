# Módulo 2: Trabajo con Ramas - Fusionar Ramas (Merge)

## 📚 Nivel: Intermedio

---

## 🎯 Objetivos de esta lección

- Entender qué es un merge
- Realizar merges fast-forward
- Realizar merges de tres vías (3-way merge)
- Ver el historial después de merges
- Entender estrategias de merge

---

## 🔀 ¿Qué es un Merge?

**Merge** es el proceso de integrar cambios de una rama en otra.

```
ANTES del merge:
         A---B---C  (main)
              \
               D---E  (feature)

DESPUÉS del merge:
         A---B---C---F  (main)
              \     /
               D---E    (feature)

F = commit de merge que une ambas ramas
```

---

## 📝 Sintaxis Básica

```bash
# 1. Cambiar a la rama DESTINO (donde quieres traer los cambios)
git switch main

# 2. Fusionar la rama origen
git merge nombre-rama-origen

# Ejemplo: Traer cambios de feature/login a main
git switch main
git merge feature/login
```

**Regla mental**: "Estoy en X y quiero traer cambios de Y" → `git merge Y`

---

## ⚡ Tipo 1: Fast-Forward Merge

Ocurre cuando **no hay commits nuevos** en la rama destino.

### Escenario

```
Tienes:
         A---B  (main)
              \
               C---D  (feature)

Git puede simplemente "mover" el puntero de main:
         A---B---C---D  (main, feature)
```

### Ejemplo Práctico

```bash
# 1. Crear repositorio
mkdir test-ff-merge
cd test-ff-merge
git init

# 2. Commit inicial en main
echo "Versión 1" > archivo.txt
git add archivo.txt
git commit -m "Commit A"

echo "Versión 2" >> archivo.txt
git add archivo.txt
git commit -m "Commit B"

# 3. Crear rama feature
git switch -c feature/nueva-funcion

# 4. Hacer commits en feature
echo "Versión 3" >> archivo.txt
git add archivo.txt
git commit -m "Commit C"

echo "Versión 4" >> archivo.txt
git add archivo.txt
git commit -m "Commit D"

# 5. Ver el historial
git log --oneline --graph --all
# * d4d4d4d (HEAD -> feature/nueva-funcion) Commit D
# * c3c3c3c Commit C
# * b2b2b2b (main) Commit B
# * a1a1a1a Commit A

# 6. Volver a main y hacer merge
git switch main
git merge feature/nueva-funcion

# Salida:
# Updating b2b2b2b..d4d4d4d
# Fast-forward
#  archivo.txt | 2 ++
#  1 file changed, 2 insertions(+)

# 7. Ver el resultado
git log --oneline --graph --all
# * d4d4d4d (HEAD -> main, feature/nueva-funcion) Commit D
# * c3c3c3c Commit C
# * b2b2b2b Commit B
# * a1a1a1a Commit A

# ¡main ahora apunta al mismo commit que feature/nueva-funcion!
```

**Características del Fast-Forward:**
- ✅ Historial lineal (fácil de leer)
- ✅ No crea commit de merge adicional
- ✅ Rápido y simple
- ❌ No queda evidencia clara de que hubo una rama

---

## 🔀 Tipo 2: Three-Way Merge (Merge de Tres Vías)

Ocurre cuando **hay commits nuevos** en AMBAS ramas.

### Escenario

```
Tienes:
         A---B---C  (main)
              \
               D---E  (feature)

Git crea un commit de merge:
         A---B---C-------F  (main)
              \         /
               D-------E    (feature)

F = commit de merge (tiene 2 padres: C y E)
```

### Ejemplo Práctico

```bash
# 1. Crear repositorio
mkdir test-3way-merge
cd test-3way-merge
git init

# 2. Commit inicial
echo "# Proyecto" > README.md
git add README.md
git commit -m "Initial commit"

# 3. Crear rama feature
git switch -c feature/footer

# 4. Trabajar en feature
echo "Footer content" > footer.html
git add footer.html
git commit -m "Añadir footer"

# 5. Volver a main y hacer cambios DIFERENTES
git switch main
echo "Header content" > header.html
git add header.html
git commit -m "Añadir header"

# 6. Ver el estado actual
git log --oneline --graph --all
# * c3c3c3c (HEAD -> main) Añadir header
# | * b2b2b2b (feature/footer) Añadir footer
# |/
# * a1a1a1a Initial commit

# 7. Hacer merge (3-way)
git merge feature/footer

# Se abrirá un editor para el mensaje del commit de merge
# Por defecto: "Merge branch 'feature/footer'"
# Guarda y cierra el editor

# Salida:
# Merge made by the 'recursive' strategy.
#  footer.html | 1 +
#  1 file changed, 1 insertion(+)
#  create mode 100644 footer.html

# 8. Ver el resultado
git log --oneline --graph --all
# *   d4d4d4d (HEAD -> main) Merge branch 'feature/footer'
# |\
# | * b2b2b2b (feature/footer) Añadir footer
# * | c3c3c3c Añadir header
# |/
# * a1a1a1a Initial commit

# 9. Verificar archivos
ls
# README.md  header.html  footer.html  ← Ambos archivos presentes
```

**Características del Three-Way Merge:**
- ✅ Preserva el historial completo
- ✅ Muestra claramente que hubo una rama
- ✅ Seguro para trabajo en equipo
- ❌ Historial más complejo
- ❌ Crea un commit adicional de merge

---

## 🎬 Ejemplo Completo: Flujo de Desarrollo Real

Simula un desarrollo real con múltiples features:

```bash
# === CONFIGURACIÓN INICIAL ===
mkdir proyecto-web
cd proyecto-web
git init

# Crear proyecto base
cat > index.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Mi Sitio</title>
</head>
<body>
    <h1>Bienvenido</h1>
</body>
</html>
EOF

git add index.html
git commit -m "Initial commit: Página base"

# === FEATURE 1: Añadir navegación ===
git switch -c feature/navbar

cat >> index.html << 'EOF'
    <nav>
        <a href="#home">Home</a>
        <a href="#about">About</a>
    </nav>
EOF

git add index.html
git commit -m "feat: Añadir barra de navegación"

# === FEATURE 2: Añadir footer (en paralelo) ===
git switch main
git switch -c feature/footer

cat >> index.html << 'EOF'
    <footer>
        <p>&copy; 2024 Mi Sitio</p>
    </footer>
EOF

git add index.html
git commit -m "feat: Añadir footer"

# === FEATURE 3: Añadir estilos (en paralelo) ===
git switch main
git switch -c feature/styles

cat > styles.css << 'EOF'
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 20px;
}

h1 {
    color: #333;
}
EOF

git add styles.css
git commit -m "feat: Añadir estilos CSS"

# === VER TODAS LAS RAMAS ===
git log --oneline --graph --all
# * e5e5e5e (HEAD -> feature/styles) feat: Añadir estilos CSS
# | * d4d4d4d (feature/footer) feat: Añadir footer
# |/
# | * c3c3c3c (feature/navbar) feat: Añadir barra de navegación
# |/
# * a1a1a1a (main) Initial commit: Página base

# === INTEGRAR TODO EN MAIN ===

# 1. Merge navbar (será fast-forward)
git switch main
git merge feature/navbar
# Fast-forward (porque main no ha cambiado)

# 2. Merge footer (será 3-way)
git merge feature/footer
# 3-way merge (porque main avanzó con navbar)

# 3. Merge styles (será 3-way)
git merge feature/styles
# 3-way merge

# === VER RESULTADO FINAL ===
git log --oneline --graph --all
# *   g7g7g7g (HEAD -> main) Merge branch 'feature/styles'
# |\
# | * e5e5e5e (feature/styles) feat: Añadir estilos CSS
# * |   f6f6f6f Merge branch 'feature/footer'
# |\ \
# | * | d4d4d4d (feature/footer) feat: Añadir footer
# | |/
# * | c3c3c3c (feature/navbar) feat: Añadir barra de navegación
# |/
# * a1a1a1a Initial commit: Página base

# === LIMPIAR RAMAS YA FUSIONADAS ===
git branch -d feature/navbar
git branch -d feature/footer
git branch -d feature/styles

# Ver ramas restantes
git branch
# * main
```

---

## 🚫 Evitar Commits de Merge: --no-ff y --ff-only

### --no-ff: Forzar commit de merge

Aunque sea posible fast-forward, crea un commit de merge:

```bash
git merge --no-ff feature/rama

# Siempre crea un commit de merge, incluso si es posible fast-forward
```

**Ventaja**: El historial muestra claramente que hubo una rama.

```
Sin --no-ff (fast-forward):
A---B---C---D  (main)

Con --no-ff:
A---B-------E  (main)
     \     /
      C---D    (feature)
```

### --ff-only: Solo permitir fast-forward

```bash
git merge --ff-only feature/rama

# Si no es posible fast-forward, el merge falla
# error: Not possible to fast-forward, aborting.
```

**Uso**: Cuando quieres mantener un historial completamente lineal.

---

## 🎯 Ejercicio Práctico 6: Merges Múltiples

```bash
# 1. Crear proyecto de ejemplo
mkdir app-tienda
cd app-tienda
git init

# 2. Base del proyecto
cat > app.js << 'EOF'
// Tienda Online
const productos = [];
EOF

git add app.js
git commit -m "Initial commit"

# 3. Feature: Añadir productos
git switch -c feature/añadir-producto

cat >> app.js << 'EOF'

function añadirProducto(nombre, precio) {
    productos.push({ nombre, precio });
}
EOF

git add app.js
git commit -m "feat: Función para añadir productos"

# 4. Volver a main y crear otra feature
git switch main
git switch -c feature/listar-productos

cat >> app.js << 'EOF'

function listarProductos() {
    productos.forEach(p => {
        console.log(`${p.nombre}: $${p.precio}`);
    });
}
EOF

git add app.js
git commit -m "feat: Función para listar productos"

# 5. Otra feature desde main
git switch main
git switch -c feature/buscar-producto

cat >> app.js << 'EOF'

function buscarProducto(nombre) {
    return productos.find(p => p.nombre === nombre);
}
EOF

git add app.js
git commit -m "feat: Función para buscar productos"

# 6. Ver todas las ramas
git log --oneline --graph --all

# 7. Merge en orden
git switch main
git merge feature/añadir-producto
# Fast-forward

git merge feature/listar-productos
# 3-way merge (ahora main tiene commits nuevos)

git merge feature/buscar-producto
# 3-way merge

# 8. Ver historial final
git log --oneline --graph --all

# 9. Verificar que todo se integró
cat app.js
# Debe tener todas las funciones

# 10. Limpiar
git branch -d feature/añadir-producto
git branch -d feature/listar-productos
git branch -d feature/buscar-producto
```

---

## 📊 Ver Información de Merges

### Ver commits de merge

```bash
# Ver solo commits de merge
git log --merges

# Ver commits que NO son merges
git log --no-merges
```

### Ver detalles de un merge

```bash
# Ver archivos cambiados en un merge
git show <hash-del-merge>

# Ver commits incluidos en un merge
git log <commit-previo>..<commit-merge>
```

### Ver ramas fusionadas

```bash
# Ver ramas ya fusionadas en la rama actual
git branch --merged

# Ver ramas aún no fusionadas
git branch --no-merged
```

---

## ⚙️ Estrategias de Merge

Git usa diferentes estrategias según el caso:

### 1. Fast-Forward
```bash
# Cuando es posible, solo mueve el puntero
# No crea commit de merge
```

### 2. Recursive (por defecto para 3-way)
```bash
# Estrategia más común para 3-way merge
# Maneja la mayoría de los casos automáticamente
```

### 3. Ours
```bash
# En conflictos, siempre usa la versión de "nuestra" rama
git merge -s ours rama-otra
```

### 4. Octopus
```bash
# Para fusionar más de 2 ramas a la vez
git merge rama1 rama2 rama3
```

---

## 💡 Mejores Prácticas

### ✅ HACER

1. **Fusiona frecuentemente** para evitar conflictos grandes
2. **Prueba antes de fusionar** (tests, build, etc.)
3. **Fusiona a main solo código que funciona**
4. **Elimina ramas después de fusionar** (git branch -d)
5. **Usa nombres descriptivos** en commits de merge
6. **Revisa el código** antes de fusionar (pull requests)

### ❌ EVITAR

1. Fusionar sin probar el código
2. Dejar muchas ramas sin fusionar (acumulación)
3. Hacer merge directamente a main sin revisión
4. Fusionar código incompleto o roto

---

## 🔄 Flujo de Trabajo Recomendado

```bash
# 1. Asegúrate de estar actualizado
git switch main
git pull  # (si trabajas con remoto)

# 2. Crea rama para tu feature
git switch -c feature/mi-feature

# 3. Trabaja y haz commits
# ... código ...
git add .
git commit -m "feat: Implementar feature"

# 4. Actualiza main (por si hay cambios nuevos)
git switch main
git pull  # Si trabajas con remoto

# 5. Fusiona tu feature
git merge feature/mi-feature

# 6. Prueba que todo funciona
# ... ejecutar tests ...

# 7. Push a remoto (si aplica)
git push

# 8. Elimina la rama local
git branch -d feature/mi-feature
```

---

## ✅ Checklist

Antes de continuar, asegúrate de poder:

- [ ] Entender la diferencia entre fast-forward y 3-way merge
- [ ] Hacer merge de una rama a otra
- [ ] Ver ramas fusionadas con `git branch --merged`
- [ ] Ver el historial de merges con `git log --graph`
- [ ] Eliminar ramas después de fusionar
- [ ] Usar `--no-ff` cuando necesites
- [ ] Entender cuándo ocurre cada tipo de merge

---

## 📌 Resumen de Comandos

| Comando | Descripción |
|---------|-------------|
| `git merge rama` | Fusionar rama en la actual |
| `git merge --no-ff rama` | Forzar commit de merge |
| `git merge --ff-only rama` | Solo fast-forward |
| `git log --merges` | Ver commits de merge |
| `git log --graph` | Ver historial con gráfico |
| `git branch --merged` | Ver ramas fusionadas |
| `git branch --no-merged` | Ver ramas sin fusionar |

---

## ➡️ Siguiente Paso

En la próxima lección aprenderás a:
- Resolver conflictos de merge
- Entender por qué ocurren conflictos
- Herramientas para resolver conflictos
- Prevenir conflictos

¡Continúa con `03-resolver-conflictos.md`!
