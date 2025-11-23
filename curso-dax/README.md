# 📊 Curso Completo de DAX: De Principiante a Avanzado

## 🎯 Bienvenido al Curso de DAX para Análisis de Retail

Este curso te llevará desde los conceptos más básicos de DAX hasta técnicas avanzadas para crear KPIs profesionales, todo con ejemplos prácticos del mundo retail.

---

## 📚 Estructura del Curso

### **Nivel Principiante** 🟢
1. [Módulo 1: Fundamentos de DAX](modulos/01_fundamentos_dax.md)
   - ¿Qué es DAX?
   - Tipos de cálculos: Medidas vs Columnas Calculadas
   - Funciones básicas de agregación
   - Tu primera medida DAX

### **Nivel Intermedio** 🟡
2. [Módulo 2: Funciones de Agregación y Contexto](modulos/02_agregacion_contexto.md)
   - Contexto de fila vs contexto de filtro
   - SUM, AVERAGE, COUNT, DISTINCTCOUNT
   - MIN, MAX, DIVIDE

3. [Módulo 3: CALCULATE y Filtros](modulos/03_calculate_filtros.md)
   - La función más importante: CALCULATE
   - Modificadores de filtro: FILTER, ALL, ALLEXCEPT
   - Filtros complejos

4. [Módulo 4: Time Intelligence](modulos/04_time_intelligence.md)
   - Tabla de calendarios
   - Funciones temporales: YTD, MTD, SAMEPERIODLASTYEAR
   - Comparaciones temporales

### **Nivel Avanzado** 🔴
5. [Módulo 5: KPIs Avanzados para Retail](modulos/05_kpis_avanzados.md)
   - Análisis de ventas (Sell-Out, Sell-In, Sell-Through)
   - Market Share
   - Stock y rotación
   - Análisis ABC/Pareto
   - Cohort Analysis

6. [Módulo 6: Optimización y Mejores Prácticas](modulos/06_optimizacion.md)
   - Variables en DAX
   - Storage Engine vs Formula Engine
   - Optimización de medidas
   - Patrones DAX comunes

---

## 🗂️ Archivos del Curso

```
curso-dax/
├── README.md                          # Este archivo
├── datos/                              # Datasets de ejemplo
│   ├── ventas_retail.csv              # Datos de ventas
│   ├── productos.csv                  # Catálogo de productos
│   ├── tiendas.csv                    # Información de tiendas
│   └── calendario.csv                 # Tabla calendario
├── modulos/                            # Teoría y ejemplos
│   ├── 01_fundamentos_dax.md
│   ├── 02_agregacion_contexto.md
│   ├── 03_calculate_filtros.md
│   ├── 04_time_intelligence.md
│   ├── 05_kpis_avanzados.md
│   └── 06_optimizacion.md
├── ejercicios/                         # Ejercicios para practicar
│   ├── ejercicios_modulo1.md
│   ├── ejercicios_modulo2.md
│   ├── ejercicios_modulo3.md
│   ├── ejercicios_modulo4.md
│   ├── ejercicios_modulo5.md
│   └── ejercicios_modulo6.md
├── soluciones/                         # Soluciones a ejercicios
│   ├── soluciones_modulo1.md
│   ├── soluciones_modulo2.md
│   ├── soluciones_modulo3.md
│   ├── soluciones_modulo4.md
│   ├── soluciones_modulo5.md
│   └── soluciones_modulo6.md
└── REFERENCIA_RAPIDA.md               # Cheat sheet de DAX
```

---

## 🚀 Cómo Usar Este Curso

### 1️⃣ **Preparación**
- Instala **Power BI Desktop** (gratuito): https://powerbi.microsoft.com/desktop/
- O usa **Excel con Power Pivot** (Excel 2016+)
- Descarga los datos de ejemplo de la carpeta `/datos/`

### 2️⃣ **Metodología de Aprendizaje**
1. Lee el módulo teórico
2. Practica los ejemplos en Power BI/Excel
3. Intenta los ejercicios sin ver las soluciones
4. Compara tus resultados con las soluciones
5. Experimenta modificando los ejemplos

### 3️⃣ **Progresión Recomendada**
- **Si eres principiante**: Sigue el orden de los módulos
- **Si tienes experiencia básica**: Empieza en Módulo 3
- **Si buscas optimización**: Ve directo al Módulo 6

---

## 💡 Convenciones Usadas en el Curso

### Formato de Código
```dax
-- Esto es un comentario en DAX
Nombre de la Medida =
    CALCULATE(
        SUM('Ventas'[Monto]),
        'Tiendas'[Region] = "Norte"
    )
```

### Símbolos
- ✅ **Buena práctica**: Código optimizado y recomendado
- ❌ **Mala práctica**: Código a evitar
- 💡 **Tip**: Consejo útil
- ⚠️ **Advertencia**: Punto importante a considerar
- 🎯 **Ejemplo práctico**: Caso de uso real

---

## 📊 Datos de Ejemplo

Los datos de ejemplo están basados en un escenario real de retail (ventas de electrónicos):

### Tablas Incluidas
1. **Ventas** (~50,000 registros)
   - Fecha, Tienda, Producto, Cantidad, Precio, Monto

2. **Productos** (~200 productos)
   - ProductoID, Nombre, Categoría, Marca, Familia, Precio Lista

3. **Tiendas** (~100 tiendas)
   - TiendaID, Nombre, Ciudad, Estado, Región

4. **Calendario** (2023-2025)
   - Fecha, Año, Trimestre, Mes, Semana, Día

---

## 🎓 Objetivos de Aprendizaje

Al completar este curso serás capaz de:

✅ Crear medidas DAX para cualquier tipo de análisis
✅ Entender y manipular contextos de evaluación
✅ Construir KPIs complejos para retail
✅ Realizar análisis temporales avanzados
✅ Optimizar modelos de datos para mejor rendimiento
✅ Aplicar mejores prácticas profesionales de DAX

---

## 🔗 Recursos Adicionales

### Documentación Oficial
- [Microsoft DAX Reference](https://docs.microsoft.com/en-us/dax/)
- [Power BI Documentation](https://docs.microsoft.com/en-us/power-bi/)

### Comunidad
- [SQLBI](https://www.sqlbi.com/) - Expertos en DAX
- [DAX.do](https://dax.do/) - Editor online de DAX
- [Power BI Community](https://community.powerbi.com/)

### Libros Recomendados
- "The Definitive Guide to DAX" - Marco Russo & Alberto Ferrari
- "DAX Patterns" - Marco Russo & Alberto Ferrari

---

## ⏱️ Tiempo Estimado

| Módulo | Nivel | Tiempo Estimado |
|--------|-------|-----------------|
| Módulo 1 | Principiante | 2-3 horas |
| Módulo 2 | Principiante | 2-3 horas |
| Módulo 3 | Intermedio | 3-4 horas |
| Módulo 4 | Intermedio | 3-4 horas |
| Módulo 5 | Avanzado | 4-5 horas |
| Módulo 6 | Avanzado | 3-4 horas |
| **TOTAL** | | **17-23 horas** |

*Tiempo incluye lectura, práctica y ejercicios*

---

## 📝 Notas Importantes

1. **Modelo de datos**: DAX trabaja sobre un modelo de datos relacional. Es fundamental entender las relaciones entre tablas.

2. **Power BI vs Excel**: Aunque DAX funciona en ambos, Power BI tiene funcionalidades más avanzadas.

3. **Versiones**: Este curso usa funciones compatibles con Power BI Desktop (versión actual) y Excel 2016+.

4. **Nomenclatura**:
   - `'Tabla'[Columna]` - Referencia a columna
   - `[Medida]` - Referencia a medida

---

## 🎯 ¿Por Qué Aprender DAX?

DAX es **esencial** si trabajas con:
- 📊 Power BI
- 📈 Excel Power Pivot
- 🔄 Analysis Services
- 💼 Análisis de negocio
- 🛍️ Retail Analytics

Es el lenguaje más demandado para **Business Intelligence** y **Data Analytics**.

---

## 🚀 ¡Comencemos!

Dirígete al [**Módulo 1: Fundamentos de DAX**](modulos/01_fundamentos_dax.md) para empezar tu viaje en el mundo de DAX.

---

**¿Listo para convertirte en un experto en DAX? ¡Adelante!** 💪

---

*Creado para el análisis de datos de retail | Última actualización: 2025*
