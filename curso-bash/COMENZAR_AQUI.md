# 🎓 ¡Bienvenido al Curso Completo de BASH!

## 🚀 Inicio Rápido

### 1. Lee el README principal
```bash
cat README.md
```

### 2. Ejecuta tu primer ejemplo
```bash
cd ejemplos/principiante
chmod +x 01_hola_mundo.sh
./01_hola_mundo.sh
```

### 3. Sigue el orden del curso

#### 📗 Nivel Principiante (Ejemplos 01-10)
```bash
cd ejemplos/principiante
ls -1 *.sh
```

Ejecuta cada ejemplo en orden:
- `01_hola_mundo.sh` - Tu primer script
- `02_variables.sh` - Variables y tipos
- `03_entrada_usuario.sh` - Input del usuario
- `04_condicionales.sh` - If/else/case
- `05_bucles.sh` - For/while/until
- `06_funciones.sh` - Crear y usar funciones
- `07_arrays.sh` - Arrays y arrays asociativos
- `08_operaciones_strings.sh` - Manipular texto
- `09_archivos_directorios.sh` - Trabajar con archivos
- `10_entrada_salida.sh` - Redirecciones y pipes

#### 📘 Nivel Intermedio (Ejemplos 11-20)
```bash
cd ejemplos/intermedio
ls -1 *.sh
```

- `11_expresiones_regulares.sh` - Regex en BASH
- `12_grep_sed_awk.sh` - Herramientas de texto
- `13_manejo_errores.sh` - Errores y robustez
- `14_procesos_trabajos.sh` - Procesos y background
- `15_debugging.sh` - Depurar scripts
- `16_fechas_tiempo.sh` - Trabajar con fechas
- `17_opciones_parametros.sh` - Parsear argumentos
- `18_signals_traps.sh` - Señales del sistema
- `19_networking.sh` - Operaciones de red
- `20_utilidades_sistema.sh` - Comandos del sistema

#### 📕 Nivel Avanzado (Ejemplos 21-30)
```bash
cd ejemplos/avanzado
ls -1 *.sh
```

- `21_modulos_sourcing.sh` - Código modular
- `22_coprocessos_pipes.sh` - Comunicación avanzada
- `23_seguridad.sh` - Seguridad en scripts
- `24_testing.sh` - Testing de código
- `25_performance.sh` - Optimización
- `26_automatizacion.sh` - Automatización avanzada
- `27_apis_json.sh` - APIs y JSON
- `28_devops.sh` - Scripts DevOps
- `29_bases_datos.sh` - Interactuar con DBs
- `30_proyecto_completo.sh` - Proyecto integrador

### 4. Practica con ejercicios
```bash
cd ejercicios
cat EJERCICIOS.md
```

## 💡 Consejos de Estudio

### Para principiantes:
1. **Lee y ejecuta** cada ejemplo
2. **Modifica** los scripts para experimentar
3. **No te saltes** ejemplos - cada uno construye sobre el anterior
4. **Practica** escribiendo tus propios scripts

### Para intermedios:
1. **Enfócate** en ejemplos 11-20
2. **Combina** conceptos de diferentes ejemplos
3. **Optimiza** los scripts que escribas
4. **Automatiza** una tarea real de tu trabajo

### Para avanzados:
1. **Estudia** la estructura de los proyectos
2. **Integra** múltiples conceptos
3. **Crea** tus propios proyectos
4. **Contribuye** mejorando los ejemplos

## 📚 Estructura del Curso

```
curso-bash/
├── README.md                 # Tutorial teórico completo
├── COMENZAR_AQUI.md         # Esta guía
├── ejemplos/
│   ├── principiante/        # Ejemplos 01-10
│   ├── intermedio/          # Ejemplos 11-20
│   └── avanzado/            # Ejemplos 21-30
└── ejercicios/
    ├── EJERCICIOS.md        # Lista de ejercicios
    └── *.sh                 # Plantillas de ejercicios
```

## 🎯 Objetivos de Aprendizaje

Al completar este curso, podrás:

✅ Escribir scripts BASH desde cero
✅ Automatizar tareas repetitivas
✅ Procesar y analizar datos
✅ Crear herramientas de línea de comandos
✅ Implementar pipelines de CI/CD
✅ Administrar sistemas Linux
✅ Depurar y optimizar scripts
✅ Seguir mejores prácticas de seguridad

## 🔧 Requisitos

- Linux o MacOS (o WSL en Windows)
- BASH 4.0 o superior
- Comandos básicos: grep, sed, awk, find
- Editor de texto (vim, nano, vscode, etc.)

Verificar versión de BASH:
```bash
bash --version
```

## 📖 Cómo Estudiar

### Método Recomendado:

1. **Día 1-3**: Principiante (01-10)
   - 3-4 ejemplos por día
   - Practica modificando los scripts

2. **Día 4-7**: Intermedio (11-20)
   - 2-3 ejemplos por día
   - Más complejos, tómate tu tiempo

3. **Día 8-12**: Avanzado (21-30)
   - 2 ejemplos por día
   - Estudia en profundidad

4. **Día 13-15**: Ejercicios
   - Resuelve ejercicios prácticos
   - Crea tus propios proyectos

## 🤔 ¿Atascado?

1. **Lee los comentarios** en el código
2. **Ejecuta paso a paso** con `bash -x script.sh`
3. **Consulta el README** para teoría
4. **Experimenta** modificando el código
5. **Google** es tu amigo
6. **Man pages**: `man bash`, `man grep`, etc.

## 🏆 Proyecto Final

Cuando completes todos los ejemplos:

1. Elige un proyecto que te interese
2. Planifica su estructura
3. Implementa usando lo aprendido
4. Agrega tests y documentación
5. ¡Comparte tu creación!

Ideas de proyectos:
- Sistema de backups automáticos
- Monitor de recursos
- Gestor de tareas/proyectos
- Deployment automation
- Log analyzer
- API client
- Sistema de alertas

## 🌟 Siguientes Pasos

Después de este curso:

1. **Practica diariamente** - escribe scripts reales
2. **Lee código** de otros - GitHub, GitLab
3. **Contribuye** a proyectos open source
4. **Automatiza** todo lo que puedas
5. **Enseña** a otros - la mejor forma de aprender

## 📝 Recursos Adicionales

- Manual oficial: `man bash`
- ShellCheck: Linter para scripts
- Explain Shell: https://explainshell.com
- Advanced Bash Scripting Guide
- Greg's Wiki: https://mywiki.wooledge.org/BashGuide

## 💪 ¡Manos a la Obra!

Estás listo para comenzar. Recuerda:

> "La mejor forma de aprender a programar es programando"

No tengas miedo de:
- ❌ Cometer errores - así se aprende
- ❌ Romper cosas - por eso usamos git
- ❌ Hacer preguntas - todos empezamos desde cero

¡Disfruta el viaje y conviértete en un maestro de BASH! 🚀

---

**Creado por:** Francisco Eduardo Honor
**Versión:** 1.0.0
**Fecha:** 2025-01-23

¿Preguntas o sugerencias? ¡Siempre hay espacio para mejorar! 📧
