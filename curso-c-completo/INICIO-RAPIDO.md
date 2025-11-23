# 🚀 Guía de Inicio Rápido

¡Felicidades por decidir aprender C! Esta guía te ayudará a comenzar en 5 minutos.

## ⚡ Inicio en 5 Pasos

### 1. Verifica que tengas un compilador

Abre tu terminal y escribe:

```bash
gcc --version
```

Si ves la versión de GCC, ¡estás listo! Si no:
- **Linux:** `sudo apt-get install gcc`
- **Mac:** `xcode-select --install`
- **Windows:** Instala MinGW o usa WSL

### 2. Navega a tu primer ejemplo

```bash
cd curso-c-completo/modulo-1-fundamentos/ejemplos
```

### 3. Abre el primer archivo

```bash
cat 01_hola_mundo.c
```

O ábrelo con tu editor favorito:
- VS Code: `code 01_hola_mundo.c`
- Vim: `vim 01_hola_mundo.c`
- Nano: `nano 01_hola_mundo.c`

### 4. Compila el programa

```bash
gcc 01_hola_mundo.c -o hola_mundo
```

Esto crea un archivo ejecutable llamado `hola_mundo`.

### 5. Ejecuta tu primer programa

```bash
./hola_mundo
```

¡Deberías ver "¡Hola, Mundo!" en tu pantalla! 🎉

## 📝 Tu Primer Día de Aprendizaje

### Mañana (2 horas)

1. Lee el archivo `01_hola_mundo.c` completo
2. Lee el archivo `02_variables.c` completo
3. Compila y ejecuta ambos programas
4. Modifica los valores y vuelve a ejecutar

### Tarde (2 horas)

1. Lee `03_tipos_datos.c`
2. Lee `04_entrada_salida.c`
3. Crea tu primer programa desde cero:

```c
#include <stdio.h>

int main() {
    char nombre[50];
    int edad;

    printf("¿Cómo te llamas? ");
    scanf("%s", nombre);

    printf("¿Cuántos años tienes? ");
    scanf("%d", &edad);

    printf("\nHola %s, tienes %d años.\n", nombre, edad);

    return 0;
}
```

Guárdalo como `mi_primer_programa.c`, compílalo y ejecútalo.

## 🎯 Tu Primera Semana

### Día 1-2: Fundamentos
- Completa todos los ejemplos del Módulo 1
- Intenta 3 ejercicios de la carpeta ejercicios

### Día 3-4: Más Fundamentos
- Lee `05_operadores.c`
- Lee `06_calculadora_simple.c`
- Intenta 3 ejercicios más

### Día 5-7: Práctica y Revisión
- Repasa lo que no entendiste
- Crea 2 programas propios
- Empieza el Módulo 2

## 💡 Comandos que Usarás Constantemente

**Compilar:**
```bash
gcc archivo.c -o programa
```

**Compilar con warnings (recomendado):**
```bash
gcc -Wall archivo.c -o programa
```

**Ejecutar:**
```bash
./programa
```

**Compilar y ejecutar en una línea:**
```bash
gcc archivo.c -o programa && ./programa
```

## 🆘 Solución de Problemas Comunes

### Error: "gcc: command not found"
**Solución:** Instala GCC (ver paso 1)

### Error: "Permission denied"
**Solución:**
```bash
chmod +x programa
./programa
```

### El programa no hace nada
**Solución:** Revisa que tengas `return 0;` al final de main()

### Errores de compilación
**Solución:**
1. Lee el mensaje de error
2. Verifica punto y comas
3. Verifica llaves {}
4. Verifica paréntesis ()

## 📚 Recursos para el Primer Día

**Si algo no te queda claro:**
1. Lee los comentarios del código nuevamente
2. Busca en Google: "C programming [tu duda]"
3. Pregunta en:
   - [Stack Overflow](https://stackoverflow.com/questions/tagged/c)
   - [Reddit r/C_Programming](https://reddit.com/r/C_Programming)

## ✅ Checklist del Primer Día

- [ ] GCC instalado y funcionando
- [ ] Compilé mi primer programa
- [ ] Ejecuté "Hola Mundo"
- [ ] Entiendo qué es una variable
- [ ] Sé usar printf()
- [ ] Sé usar scanf()
- [ ] Creé mi primer programa desde cero

## 🎓 Siguiente Paso

Una vez completes el checklist, estás listo para:

→ Continuar con el [Módulo 1 completo](./modulo-1-fundamentos/README.md)

## 💪 Mentalidad de Aprendizaje

**Recuerda:**
- ❌ Los errores son NORMALES y BUENOS
- ✅ Cada error es una oportunidad de aprender
- ✅ No hay preguntas tontas
- ✅ La práctica hace al maestro
- ✅ Todos empezamos desde cero

## 🏃 ¡A Programar!

¡Ya tienes todo lo que necesitas para empezar! No leas más, abre tu editor y empieza a programar.

**La mejor forma de aprender es haciendo. ¡Buena suerte! 🚀**

---

¿Problemas? Revisa el [README principal](./README.md) para más detalles.
