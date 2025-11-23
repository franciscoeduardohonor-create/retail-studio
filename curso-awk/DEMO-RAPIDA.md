# Demo Rápida - Prueba AWK Ahora Mismo

¡Bienvenido! Aquí tienes algunos comandos para probar AWK inmediatamente.

## 🚀 Prueba 1: Analizar Ventas

```bash
cd curso-awk
awk -f ejemplos/analizar_ventas.awk datos-ejemplo/ventas.csv
```

**Resultado esperado:** Verás un análisis completo de ventas por producto y región.

---

## 📊 Prueba 2: Analizar Logs

```bash
cd curso-awk
awk -f ejemplos/procesar_logs.awk datos-ejemplo/logs.txt
```

**Resultado esperado:** Análisis de logs mostrando errores, warnings e info con estadísticas.

---

## 📈 Prueba 3: Ejemplos Rápidos en Línea de Comandos

### Ver solo nombres de empleados
```bash
cd curso-awk
awk '{ print $1 }' datos-ejemplo/empleados.txt
```

### Calcular salario total
```bash
cd curso-awk
awk '{ suma += $2 } END { print "Total:", suma }' datos-ejemplo/empleados.txt
```

### Empleados de IT
```bash
cd curso-awk
awk '$3 == "IT"' datos-ejemplo/empleados.txt
```

### Empleados con salario > 2800
```bash
cd curso-awk
awk '$2 > 2800 { print $1, "gana", "$" $2 }' datos-ejemplo/empleados.txt
```

### Contar empleados por departamento
```bash
cd curso-awk
awk '{ dept[$3]++ } END { for (d in dept) print d ":", dept[d] }' datos-ejemplo/empleados.txt
```

---

## 🎯 Prueba 4: Tu Primer Script AWK

Crea un archivo `mi_primer_script.awk`:

```bash
cat > curso-awk/mi_primer_script.awk << 'EOF'
#!/usr/bin/awk -f
BEGIN {
    print "=== MI PRIMER SCRIPT AWK ==="
}

{
    print "Línea", NR ":", $0
}

END {
    print "==========================="
    print "Total de líneas:", NR
}
EOF
```

Ejecuta:
```bash
chmod +x curso-awk/mi_primer_script.awk
./curso-awk/mi_primer_script.awk curso-awk/datos-ejemplo/empleados.txt
```

---

## 📖 Siguiente Paso

¡Ahora que viste AWK en acción, comienza el curso!

```bash
cat curso-awk/README.md
```

O ve directamente al primer módulo:

```bash
cat curso-awk/modulos/01-introduccion-basicos.md
```

---

## 💡 Tips Rápidos

1. **Para ver cualquier módulo:**
   ```bash
   cat curso-awk/modulos/01-introduccion-basicos.md | less
   ```

2. **Para practicar:**
   - Usa los archivos en `datos-ejemplo/`
   - Modifica los scripts en `ejemplos/`
   - Intenta los ejercicios en `ejercicios/EJERCICIOS-PRACTICOS.md`

3. **Guía rápida siempre a mano:**
   ```bash
   cat curso-awk/GUIA-RAPIDA.md
   ```

---

¡Feliz aprendizaje de AWK! 🎉
