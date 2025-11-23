# 🐧 Curso Completo de BASH Scripting - De Principiante a Avanzado

¡Bienvenido al curso más completo de BASH scripting en español! Este curso te llevará desde los conceptos básicos hasta técnicas avanzadas de programación en la terminal de Linux.

## 📚 Estructura del Curso

```
curso-bash/
├── README.md (Este archivo)
├── ejemplos/
│   ├── principiante/    (Ejemplos 01-10)
│   ├── intermedio/      (Ejemplos 11-20)
│   └── avanzado/        (Ejemplos 21-30)
└── ejercicios/          (Ejercicios para practicar)
```

## 🎯 Objetivos del Curso

- Dominar la sintaxis de BASH desde cero
- Aprender a automatizar tareas diarias
- Crear scripts robustos y mantenibles
- Entender las mejores prácticas de scripting

---

## 📖 NIVEL 1: PRINCIPIANTE

### 1. ¿Qué es BASH?

BASH (Bourne Again Shell) es:
- Un intérprete de comandos para Linux/Unix
- Un lenguaje de programación para scripts
- La shell por defecto en la mayoría de distribuciones Linux

### 2. Tu Primer Script

Todo script de BASH debe comenzar con el "shebang":
```bash
#!/bin/bash
```

Esto le dice al sistema que use BASH para ejecutar el script.

### 3. Conceptos Fundamentales

#### Variables
```bash
# Declaración (sin espacios alrededor del =)
nombre="Juan"
edad=25

# Uso (con $)
echo "Hola $nombre"
echo "Tienes $edad años"
```

#### Entrada del Usuario
```bash
read -p "¿Cómo te llamas? " nombre
echo "Hola $nombre"
```

#### Condicionales
```bash
if [ $edad -gt 18 ]; then
    echo "Eres mayor de edad"
else
    echo "Eres menor de edad"
fi
```

#### Operadores de Comparación
- `-eq` : igual (equal)
- `-ne` : diferente (not equal)
- `-gt` : mayor que (greater than)
- `-lt` : menor que (less than)
- `-ge` : mayor o igual (greater or equal)
- `-le` : menor o igual (less or equal)

Para strings:
- `=` : igual
- `!=` : diferente
- `-z` : string vacío
- `-n` : string no vacío

#### Bucles
```bash
# For loop
for i in 1 2 3 4 5; do
    echo "Número: $i"
done

# While loop
contador=0
while [ $contador -lt 5 ]; do
    echo "Contador: $contador"
    ((contador++))
done
```

---

## 📖 NIVEL 2: INTERMEDIO

### 4. Funciones

```bash
# Definir función
saludar() {
    local nombre=$1  # Primer parámetro
    echo "Hola, $nombre!"
}

# Llamar función
saludar "María"
```

### 5. Arrays (Arreglos)

```bash
# Declarar array
frutas=("manzana" "pera" "uva" "naranja")

# Acceder a elementos
echo ${frutas[0]}  # manzana
echo ${frutas[@]}  # todos los elementos
echo ${#frutas[@]} # cantidad de elementos
```

### 6. Manipulación de Strings

```bash
texto="Hola Mundo"
echo ${#texto}           # Longitud
echo ${texto:0:4}        # Subcadena (Hola)
echo ${texto/Mundo/Bash} # Reemplazo (Hola Bash)
echo ${texto^^}          # Mayúsculas (HOLA MUNDO)
echo ${texto,,}          # Minúsculas (hola mundo)
```

### 7. Redirecciones

```bash
# Redirigir salida a archivo
echo "texto" > archivo.txt      # Sobrescribe
echo "más texto" >> archivo.txt # Añade

# Redirigir errores
comando 2> errores.log          # Solo errores
comando &> todo.log             # Salida y errores
```

### 8. Pipes y Comandos

```bash
# Pipe: salida de un comando como entrada de otro
cat archivo.txt | grep "palabra" | wc -l

# Command substitution
fecha=$(date +%Y-%m-%d)
archivos=$(ls | wc -l)
```

---

## 📖 NIVEL 3: AVANZADO

### 9. Expresiones Regulares

```bash
# Usando grep
echo "correo@ejemplo.com" | grep -E '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'

# Usando regex en condicionales
if [[ $email =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
    echo "Email válido"
fi
```

### 10. Procesamiento de Archivos

```bash
# Leer archivo línea por línea
while IFS= read -r linea; do
    echo "Procesando: $linea"
done < archivo.txt

# Procesamiento con awk
awk '{print $1, $3}' archivo.txt

# Procesamiento con sed
sed 's/viejo/nuevo/g' archivo.txt
```

### 11. Manejo de Errores

```bash
# Verificar código de salida
if comando; then
    echo "Éxito"
else
    echo "Error: $?"
fi

# Set flags para seguridad
set -e  # Salir si hay error
set -u  # Error si variable no definida
set -o pipefail  # Error en pipes
```

### 12. Traps (Captura de Señales)

```bash
# Limpiar al salir
cleanup() {
    echo "Limpiando archivos temporales..."
    rm -f /tmp/temp_*
}

trap cleanup EXIT
```

### 13. Procesamiento Paralelo

```bash
# Ejecutar en background
comando &

# Esperar a que terminen todos
wait

# Usar xargs para paralelizar
cat lista.txt | xargs -P 4 -I {} comando {}
```

---

## 🛠️ Mejores Prácticas

1. **Siempre usar comillas**: `"$variable"` en lugar de `$variable`
2. **Verificar errores**: Usar `set -euo pipefail`
3. **Comentar el código**: Explicar qué hace cada sección
4. **Usar nombres descriptivos**: `usuario_nombre` mejor que `un`
5. **Validar entradas**: Verificar que las variables tienen valores esperados
6. **Hacer scripts modulares**: Usar funciones
7. **Testing**: Probar con diferentes inputs

---

## 📝 Comandos Útiles de Linux

```bash
# Información del sistema
uname -a        # Info del sistema
df -h           # Espacio en disco
free -h         # Memoria
top             # Procesos en ejecución
ps aux          # Lista de procesos

# Archivos
ls -lah         # Listar detallado
find . -name    # Buscar archivos
chmod +x        # Hacer ejecutable
chown           # Cambiar propietario

# Texto
grep            # Buscar en archivos
sed             # Editor de stream
awk             # Procesamiento de texto
cut             # Cortar columnas
sort            # Ordenar
uniq            # Únicos
wc              # Contar líneas/palabras

# Red
curl            # HTTP requests
wget            # Descargar archivos
ping            # Verificar conectividad
netstat         # Conexiones de red
```

---

## 🚀 Cómo Usar Este Curso

1. **Lee la teoría** en este README
2. **Ejecuta los ejemplos** en orden:
   ```bash
   cd ejemplos/principiante
   bash 01_hola_mundo.sh
   ```
3. **Modifica los scripts** para experimentar
4. **Completa los ejercicios** en la carpeta ejercicios/
5. **Crea tus propios scripts** para automatizar tareas

### Hacer un script ejecutable:
```bash
chmod +x script.sh
./script.sh
```

---

## 📚 Recursos Adicionales

- Manual de BASH: `man bash`
- Guía de comandos: `man comando`
- ShellCheck: Herramienta para verificar scripts
- Explain Shell: https://explainshell.com/

---

## 🎓 Certificación Personal

Cuando completes todos los ejemplos y ejercicios, habrás adquirido:
- ✅ Fundamentos sólidos de BASH
- ✅ Capacidad de automatizar tareas
- ✅ Habilidades de scripting profesional
- ✅ Conocimiento de mejores prácticas

¡Empecemos! 🚀
