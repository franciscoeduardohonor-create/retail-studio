# 🔍 HC File Tester - Documentación

## 📋 Descripción

Scripts optimizados para verificar la lectura y validación de archivos Excel de HC (HeadCount). Disponibles en R y Python con funcionalidad equivalente.

## 📁 Archivos

- **`hc_file_tester_optimized.R`** - Versión optimizada en R
- **`hc_file_tester.py`** - Versión equivalente en Python

## 🚀 Mejoras Implementadas

### Comparación con Código Original

| Aspecto | Código Original | Código Optimizado |
|---------|----------------|-------------------|
| Estructura | Script lineal monolítico | Modular con funciones reutilizables |
| Manejo de errores | Básico | Robusto con validaciones |
| Salida | Texto sin formato | Estructurada con secciones claras |
| Documentación | Comentarios mínimos | Documentación completa |
| Reutilización | Difícil | Funciones independientes |
| Mantenimiento | Complejo | Simplificado |

### Optimizaciones Específicas

#### 1️⃣ **Modularización**

**Antes (Original):**
```r
# Código todo junto
if (file.exists(archivo_w26)) {
  cat("✓ Archivo encontrado\n")
} else {
  cat("✗ Archivo NO encontrado\n")
  stop("No se puede continuar")
}
```

**Después (Optimizado):**
```r
verificar_archivo <- function(ruta) {
  if (file.exists(ruta)) {
    cat(sprintf("✓ Archivo encontrado: %s\n", basename(ruta)))
    return(TRUE)
  } else {
    cat("✗ ERROR: Archivo NO encontrado\n")
    stop("No se puede continuar sin el archivo", call. = FALSE)
  }
}
```

**Beneficios:**
- ✅ Reutilizable en otros scripts
- ✅ Más fácil de probar
- ✅ Código más limpio

#### 2️⃣ **Salida Estructurada**

**Antes:**
```r
cat("=== TEST SIMPLE DE LECTURA ===\n\n")
```

**Después:**
```r
imprimir_seccion("🔍 TEST DE LECTURA DE ARCHIVOS HC")
imprimir_subseccion(1, "Verificando existencia del archivo")
```

**Beneficios:**
- ✅ Formato consistente
- ✅ Fácil de seguir
- ✅ Más profesional

#### 3️⃣ **Parámetros Configurables**

**Antes:**
```r
# Valores hardcodeados en el código
print(datos_raw[1:5, 1:5])
```

**Después:**
```r
NUM_PREVIEW <- 5  # Configurable al inicio
mostrar_preview(datos_raw, NUM_PREVIEW, NUM_PREVIEW)
```

**Beneficios:**
- ✅ Fácil de ajustar
- ✅ Sin modificar código
- ✅ Configuración centralizada

#### 4️⃣ **Mejor Análisis de Datos**

**Antes:**
```r
ids_no_vacios <- sum(!is.na(datos_con_headers$ID) &
                     datos_con_headers$ID != "", na.rm = TRUE)
cat(sprintf("\n7. Filas con ID no vacío: %d\n", ids_no_vacios))
```

**Después:**
```r
analizar_columna_id <- function(datos) {
  ids_validos <- !is.na(datos$ID) & datos$ID != ""
  n_validos <- sum(ids_validos, na.rm = TRUE)

  cat(sprintf("   📊 Registros con ID válido: %d / %d (%.1f%%)\n",
              n_validos, nrow(datos),
              100 * n_validos / nrow(datos)))

  # Muestra detallada...
}
```

**Beneficios:**
- ✅ Más información (porcentaje)
- ✅ Mejor presentación
- ✅ Muestra de datos

## 📊 Uso

### R

```r
# Ejecutar el script completo
source("hc_file_tester_optimized.R")

# O ejecutar desde línea de comandos
Rscript hc_file_tester_optimized.R

# Modo interactivo
resultado <- ejecutar_test()
```

### Python

```bash
# Ejecutar el script
python hc_file_tester.py

# O hacer ejecutable
chmod +x hc_file_tester.py
./hc_file_tester.py
```

```python
# Importar como módulo
from hc_file_tester import ejecutar_test

resultado = ejecutar_test()
```

## ⚙️ Configuración

Ambos scripts tienen parámetros configurables al inicio del archivo:

```r
# R
RUTA_BASE <- "ruta/a/tus/archivos/"
ARCHIVO_W26 <- paste0(RUTA_BASE, "HC_W26.xlsx")
NOMBRE_HOJA <- "FF"
NUM_PREVIEW <- 5
```

```python
# Python
RUTA_BASE = Path(r"ruta/a/tus/archivos")
ARCHIVO_W26 = RUTA_BASE / "HC_W26.xlsx"
NOMBRE_HOJA = "FF"
NUM_PREVIEW = 5
```

## 📋 Funcionalidades

Ambas versiones realizan las siguientes operaciones:

1. **Verificación de archivo** - Confirma que el archivo existe
2. **Lectura preliminar** - Lee primeras 10 filas sin procesar
3. **Búsqueda de headers** - Identifica automáticamente la fila de encabezados
4. **Lectura con headers** - Procesa datos con columnas correctas
5. **Vista previa** - Muestra muestra de los datos
6. **Análisis de columna ID** - Estadísticas sobre IDs válidos

## 🎯 Diferencias entre R y Python

| Característica | R | Python |
|----------------|---|--------|
| Lectura Excel | `readxl::read_excel()` | `pd.read_excel()` |
| DataFrames | tibble/data.frame | pandas.DataFrame |
| Columnas | `$columna` o `[["columna"]]` | `.loc[:, 'columna']` |
| Índices | Base 1 | Base 0 |
| Strings | Vectorizado | `.str` accessor |
| Type hints | No nativo | Sí (`typing`) |

## 💡 Ventajas de Cada Versión

### R
- ✅ Mejor integración con ecosistema tidyverse
- ✅ Excelente para análisis estadístico
- ✅ Más expresivo para transformaciones de datos
- ✅ Mejor para reportes RMarkdown

### Python
- ✅ Mejor para producción
- ✅ Más rápido para grandes datasets
- ✅ Más opciones de integración
- ✅ Type hints para mejor IDE support
- ✅ Mejor para automatización

## 🔄 Equivalencias de Código

### Lectura de Excel

```r
# R
datos <- read_excel(archivo, sheet = "FF", skip = 1)
```

```python
# Python
datos = pd.read_excel(archivo, sheet_name="FF", skiprows=1)
```

### Búsqueda de Patrones

```r
# R
grepl("Customer", fila, ignore.case = TRUE)
```

```python
# Python
fila.str.contains("Customer", case=False, na=False)
```

### Contar Valores Válidos

```r
# R
sum(!is.na(datos$ID) & datos$ID != "", na.rm = TRUE)
```

```python
# Python
(datos['ID'].notna() & (datos['ID'] != '')).sum()
```

## 📈 Mejores Prácticas Aplicadas

1. **✅ DRY (Don't Repeat Yourself)** - Funciones reutilizables
2. **✅ Separación de Responsabilidades** - Cada función hace una cosa
3. **✅ Configuración Externa** - Parámetros al inicio
4. **✅ Manejo de Errores** - Validaciones y mensajes claros
5. **✅ Documentación** - Comentarios y docstrings
6. **✅ Formato Consistente** - Salida estructurada
7. **✅ Código Limpio** - Nombres descriptivos y estructura clara

## 🐛 Troubleshooting

### Error: Archivo no encontrado

```
✗ ERROR: Archivo NO encontrado
   Ruta buscada: C:/Users/.../HC_W26.xlsx
```

**Solución:** Verificar y actualizar `RUTA_BASE` y `ARCHIVO_W26`

### Error: Hoja no encontrada

```
Error: Hoja 'FF' no encontrada
```

**Solución:** Verificar nombre de hoja con:
```r
# R
excel_sheets(archivo)
```
```python
# Python
pd.ExcelFile(archivo).sheet_names
```

### Columna ID no encontrada

```
⚠️  Columna 'ID' NO encontrada
```

**Solución:** El script mostrará columnas similares. Ajustar búsqueda según sea necesario.

## 📝 Notas

- Los scripts están diseñados para archivos HC estándar de la estructura de HonorBI
- Ambas versiones producen salida equivalente
- El código R usa `suppressPackageStartupMessages` para salida limpia
- El código Python usa `pathlib.Path` para manejo robusto de rutas
- Ambos scripts pueden ejecutarse de forma independiente o importarse como módulos

## 🎓 Para Aprender Más

### R
- [readxl documentation](https://readxl.tidyverse.org/)
- [R for Data Science](https://r4ds.had.co.nz/)

### Python
- [pandas documentation](https://pandas.pydata.org/docs/)
- [Python Data Science Handbook](https://jakevdp.github.io/PythonDataScienceHandbook/)

---

**Creado:** 2025-11-23
**Versión:** 1.0
**Mantenedor:** Retail Studio Team
