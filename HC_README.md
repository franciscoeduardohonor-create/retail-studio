# HC Analysis - Guía Rápida de Uso

## 🚀 Inicio Rápido

### Opción 1: Usar R (Recomendado si ya usas R)

```r
# 1. Instalar dependencias
install.packages(c("readxlsb", "reshape2", "openxlsx", "lubridate", "dplyr"))

# 2. Configurar ruta en el archivo hc_analysis_optimized.R
# Editar línea: root = "TU_RUTA_AQUI"

# 3. Ejecutar
source("hc_analysis_optimized.R")
```

### Opción 2: Usar Python (Recomendado para nuevos usuarios)

```bash
# 1. Instalar dependencias
pip install -r requirements.txt

# 2. Ejecutar (la ruta se puede configurar en el archivo)
python hc_analysis.py
```

---

## ⚙️ Configuración

### Cambiar Directorio de Archivos HC

**R:**
```r
# En hc_analysis_optimized.R, modificar:
CONFIG <- list(
  root = "C:/TU/RUTA/AQUI",  # ← Cambiar esta línea
  # ...
)
```

**Python:**
```python
# En hc_analysis.py, modificar:
@dataclass
class HCConfig:
    root: str = "C:/TU/RUTA/AQUI"  # ← Cambiar esta línea
    # ...
```

### Cambiar Directorio de Salida

**R:**
```r
CONFIG <- list(
  # ...
  output = "MiCarpetaSalida/",  # ← Cambiar esta línea
)
```

**Python:**
```python
@dataclass
class HCConfig:
    # ...
    output: str = "MiCarpetaSalida/"  # ← Cambiar esta línea
```

---

## 📂 Estructura de Archivos

```
HC/
├── archivo1.xlsb  (Semana 6)
├── archivo2.xlsb  (Semana 7)
├── archivo3.xlsb  (Semana 8)
└── ...

Tablas_de_Tiempo/  (se crea automáticamente)
├── TS_Vacantes_V[SEMANA].xlsx
└── SemanasYFecha.csv
```

---

## 📊 Salidas Generadas

### 1. TS_Vacantes_V[SEMANA].xlsx
Archivo Excel con 7 hojas:
- AuthorizedPromoters
- AuthorizedManagement
- HiredPromoters
- HiredManagement
- VacancyPromoters
- VacancyManagement
- StandbyPromoters

**Formato de cada hoja:**
| Region | Variable | WK06 | WK07 | WK08 | ... |
|--------|----------|------|------|------|-----|
| Norte  | Var1     | 100  | 105  | 110  | ... |
| Sur    | Var1     | 80   | 85   | 90   | ... |

### 2. SemanasYFecha.csv
Mapeo de semanas a fechas:
| Semana | Fecha_i    |
|--------|------------|
| WK06   | 2024-02-05 |
| WK07   | 2024-02-12 |
| WK08   | 2024-02-19 |

---

## 🔧 Solución de Problemas Comunes

### ❌ "No se encontraron archivos .xlsb"
**Solución**: Verificar que:
1. Los archivos estén en formato `.xlsb` (no `.xlsx`)
2. La ruta en `CONFIG$root` sea correcta
3. Tengas permisos de lectura en la carpeta

### ❌ "Error al leer hoja SUMMARY"
**Solución**: Verificar que:
1. El archivo tenga una hoja llamada "SUMMARY"
2. El archivo no esté corrupto
3. El archivo no esté abierto en Excel

### ❌ "Error: package 'readxlsb' is not available" (R)
**Solución**:
```r
install.packages("readxlsb")
```

### ❌ "ModuleNotFoundError: No module named 'pyxlsb'" (Python)
**Solución**:
```bash
pip install pyxlsb
```

---

## 📋 Checklist Pre-Ejecución

- [ ] Los archivos HC están en formato `.xlsb`
- [ ] La ruta en `CONFIG$root` apunta a la carpeta correcta
- [ ] Todas las dependencias están instaladas
- [ ] Los archivos HC tienen la hoja "SUMMARY"
- [ ] Tienes permisos de escritura en la carpeta de salida

---

## 🎯 Casos de Uso Especiales

### Solo procesar semanas específicas

**Python:**
```python
from hc_analysis import HCAnalyzer, HCConfig

config = HCConfig(week_start=10)  # Empezar desde semana 10
analyzer = HCAnalyzer(config)
analyzer.run()
```

### Usar rutas personalizadas sin modificar el archivo

**Python:**
```python
from hc_analysis import HCAnalyzer, HCConfig

config = HCConfig(
    root="C:/MisArchivos/HC",
    output="C:/MisResultados/"
)
analyzer = HCAnalyzer(config)
analyzer.run()
```

---

## 📞 Ayuda

Para más información, consultar:
- **Documentación completa**: `HC_OPTIMIZACIONES.md`
- **Código fuente**: `hc_analysis_optimized.R` o `hc_analysis.py`

---

**Nota**: Este README es una guía rápida. Para detalles técnicos completos, consultar `HC_OPTIMIZACIONES.md`.
