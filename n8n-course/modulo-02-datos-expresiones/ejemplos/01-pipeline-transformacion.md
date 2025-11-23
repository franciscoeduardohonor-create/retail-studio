# Ejemplo 1: Pipeline de Transformación de Datos

## Objetivo
Crear un pipeline completo que obtenga, filtre, transforme y formatee datos de manera profesional.

## Caso de Uso
Sistema que procesa datos de empleados, calcula salarios con bonos, y genera un reporte.

## Arquitectura

```
[Manual] → [Set: Data] → [Filter] → [Enrich] → [Format] → [Report]
```

## Paso 1: Datos de Entrada

### Set Node: "Employee Data"

Simulamos datos de empleados:

```javascript
// En el Set node, usa mode "JSON" y pega esto:
```

```json
[
  {
    "id": 1,
    "nombre": "Ana García",
    "departamento": "Ventas",
    "salario_base": 25000,
    "ventas_mes": 150000,
    "antiguedad_anios": 3,
    "activo": true
  },
  {
    "id": 2,
    "nombre": "Carlos López",
    "departamento": "IT",
    "salario_base": 35000,
    "ventas_mes": 0,
    "antiguedad_anios": 5,
    "activo": true
  },
  {
    "id": 3,
    "nombre": "María Rodríguez",
    "departamento": "Ventas",
    "salario_base": 22000,
    "ventas_mes": 95000,
    "antiguedad_anios": 1,
    "activo": false
  },
  {
    "id": 4,
    "nombre": "Juan Martínez",
    "departamento": "Recursos Humanos",
    "salario_base": 28000,
    "ventas_mes": 0,
    "antiguedad_anios": 7,
    "activo": true
  },
  {
    "id": 5,
    "nombre": "Laura Sánchez",
    "departamento": "Ventas",
    "salario_base": 30000,
    "ventas_mes": 200000,
    "antiguedad_anios": 4,
    "activo": true
  }
]
```

💡 **Importante:** En el Set node, cambia a modo "Expression" y pega el JSON directamente.

## Paso 2: Filtrar Empleados Activos

### Code Node: "Filter Active"

```javascript
// Filtrar solo empleados activos
const empleadosActivos = items.filter(item => item.json.activo === true);

// Validar que hay datos
if (empleadosActivos.length === 0) {
  throw new Error('No hay empleados activos');
}

console.log(`✅ ${empleadosActivos.length} empleados activos encontrados`);

return empleadosActivos;
```

### Alternativa: Usar nodo IF

También podrías usar un nodo IF:
- **Condition:** `{{ $json.activo }}` equals `true`
- Conecta solo la rama TRUE al siguiente nodo

## Paso 3: Enriquecer Datos (Calcular Bonos y Totales)

### Code Node: "Calculate Bonuses"

```javascript
const empleadosProcesados = items.map(item => {
  const emp = item.json;

  // 1. Bono por antigüedad (2% por año)
  const bonoAntiguedad = emp.salario_base * (emp.antiguedad_anios * 0.02);

  // 2. Bono por ventas (solo para depto de Ventas)
  let bonoVentas = 0;
  if (emp.departamento === 'Ventas') {
    // 3% de comisión sobre ventas
    bonoVentas = emp.ventas_mes * 0.03;
  }

  // 3. Bono por alto rendimiento (ventas > 150k)
  const bonoRendimiento = emp.ventas_mes > 150000 ? 5000 : 0;

  // 4. Calcular salario total
  const totalBonos = bonoAntiguedad + bonoVentas + bonoRendimiento;
  const salarioTotal = emp.salario_base + totalBonos;

  // 5. Calcular deducciones (impuestos simulados - 16%)
  const deducciones = salarioTotal * 0.16;
  const salarioNeto = salarioTotal - deducciones;

  // 6. Categorizar empleado
  let categoria;
  if (salarioTotal >= 40000) {
    categoria = 'Senior';
  } else if (salarioTotal >= 30000) {
    categoria = 'Mid-Level';
  } else {
    categoria = 'Junior';
  }

  // 7. Nivel de rendimiento
  let nivelRendimiento;
  if (emp.departamento === 'Ventas') {
    if (emp.ventas_mes >= 150000) {
      nivelRendimiento = '🌟 Excelente';
    } else if (emp.ventas_mes >= 100000) {
      nivelRendimiento = '⭐ Bueno';
    } else {
      nivelRendimiento = '📊 Regular';
    }
  } else {
    // Para departamentos sin ventas
    nivelRendimiento = antiguedad_anios >= 5 ? '🌟 Excelente' : '⭐ Bueno';
  }

  // Retornar datos enriquecidos
  return {
    json: {
      // Datos originales
      ...emp,

      // Bonos calculados
      bonos: {
        antiguedad: parseFloat(bonoAntiguedad.toFixed(2)),
        ventas: parseFloat(bonoVentas.toFixed(2)),
        rendimiento: bonoRendimiento,
        total_bonos: parseFloat(totalBonos.toFixed(2))
      },

      // Salarios calculados
      compensacion: {
        salario_base: emp.salario_base,
        total_bonos: parseFloat(totalBonos.toFixed(2)),
        salario_bruto: parseFloat(salarioTotal.toFixed(2)),
        deducciones: parseFloat(deducciones.toFixed(2)),
        salario_neto: parseFloat(salarioNeto.toFixed(2))
      },

      // Clasificación
      clasificacion: {
        categoria: categoria,
        nivel_rendimiento: nivelRendimiento,
        es_top_performer: emp.ventas_mes > 150000 || emp.antiguedad_anios >= 5
      }
    }
  };
});

console.log('💰 Bonos y salarios calculados');
console.log(`Procesados: ${empleadosProcesados.length} empleados`);

return empleadosProcesados;
```

## Paso 4: Formatear para Reporte

### Code Node: "Format Report"

```javascript
const empleados = items;

// Ordenar por salario neto (mayor a menor)
const empleadosOrdenados = empleados.sort((a, b) =>
  b.json.compensacion.salario_neto - a.json.compensacion.salario_neto
);

// Crear resumen por empleado
const detalleEmpleados = empleadosOrdenados.map((item, index) => {
  const emp = item.json;
  const comp = emp.compensacion;
  const clas = emp.clasificacion;

  return {
    posicion: index + 1,
    empleado: {
      id: emp.id,
      nombre: emp.nombre,
      departamento: emp.departamento,
      antiguedad: `${emp.antiguedad_anios} años`
    },
    compensacion_mensual: {
      base: `$${comp.salario_base.toLocaleString()}`,
      bonos: `$${comp.total_bonos.toLocaleString()}`,
      bruto: `$${comp.salario_bruto.toLocaleString()}`,
      deducciones: `-$${comp.deducciones.toLocaleString()}`,
      neto: `$${comp.salario_neto.toLocaleString()}`
    },
    clasificacion: {
      categoria: clas.categoria,
      rendimiento: clas.nivel_rendimiento,
      top_performer: clas.es_top_performer ? '⭐ Sí' : 'No'
    }
  };
});

// Calcular estadísticas globales
const totalSalariosBruto = empleados.reduce(
  (sum, item) => sum + item.json.compensacion.salario_bruto, 0
);

const totalSalariosNeto = empleados.reduce(
  (sum, item) => sum + item.json.compensacion.salario_neto, 0
);

const totalBonos = empleados.reduce(
  (sum, item) => sum + item.json.compensacion.total_bonos, 0
);

const promedioSalario = totalSalariosNeto / empleados.length;

// Agrupar por departamento
const porDepartamento = empleados.reduce((acc, item) => {
  const depto = item.json.departamento;
  if (!acc[depto]) {
    acc[depto] = {
      empleados: 0,
      salario_total: 0,
      salario_promedio: 0,
      bonos_totales: 0
    };
  }

  acc[depto].empleados++;
  acc[depto].salario_total += item.json.compensacion.salario_neto;
  acc[depto].bonos_totales += item.json.compensacion.total_bonos;

  return acc;
}, {});

// Calcular promedios por departamento
Object.keys(porDepartamento).forEach(depto => {
  const datos = porDepartamento[depto];
  datos.salario_promedio = datos.salario_total / datos.empleados;

  // Formatear números
  datos.salario_total = parseFloat(datos.salario_total.toFixed(2));
  datos.salario_promedio = parseFloat(datos.salario_promedio.toFixed(2));
  datos.bonos_totales = parseFloat(datos.bonos_totales.toFixed(2));
});

// Top 3 empleados
const top3 = detalleEmpleados.slice(0, 3);

// Empleados que necesitan atención (salario bajo y poca antigüedad)
const necesitanAtencion = empleados
  .filter(item =>
    item.json.compensacion.salario_neto < 25000 &&
    item.json.antiguedad_anios < 2
  )
  .map(item => ({
    nombre: item.json.nombre,
    salario: item.json.compensacion.salario_neto,
    motivo: 'Salario bajo y poca retención'
  }));

// Generar reporte final
const reporte = {
  metadata: {
    titulo: '📊 REPORTE DE COMPENSACIÓN MENSUAL',
    fecha_generacion: new Date().toLocaleDateString('es-ES', {
      weekday: 'long',
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    }),
    periodo: 'Noviembre 2025',
    total_empleados: empleados.length
  },

  resumen_ejecutivo: {
    nomina_total_bruta: `$${totalSalariosBruto.toLocaleString()}`,
    nomina_total_neta: `$${totalSalariosNeto.toLocaleString()}`,
    total_bonos_pagados: `$${totalBonos.toLocaleString()}`,
    salario_promedio: `$${promedioSalario.toFixed(2).toLocaleString()}`,
    top_performers: empleados.filter(e => e.json.clasificacion.es_top_performer).length
  },

  por_departamento: porDepartamento,

  top_3_empleados: top3,

  empleados_atencion_requerida: necesitanAtencion,

  detalle_completo: detalleEmpleados
};

// Log del reporte
console.log('═══════════════════════════════════════════');
console.log(reporte.metadata.titulo);
console.log('═══════════════════════════════════════════');
console.log('Total Empleados:', reporte.metadata.total_empleados);
console.log('Nómina Total (Neta):', reporte.resumen_ejecutivo.nomina_total_neta);
console.log('Top Performers:', reporte.resumen_ejecutivo.top_performers);
console.log('═══════════════════════════════════════════');

return [{ json: reporte }];
```

## Output Esperado

```json
{
  "metadata": {
    "titulo": "📊 REPORTE DE COMPENSACIÓN MENSUAL",
    "fecha_generacion": "sábado, 23 de noviembre de 2025",
    "periodo": "Noviembre 2025",
    "total_empleados": 4
  },
  "resumen_ejecutivo": {
    "nomina_total_bruta": "$142,180",
    "nomina_total_neta": "$119,431.20",
    "total_bonos_pagados": "$24,180",
    "salario_promedio": "$29,857.80",
    "top_performers": 2
  },
  "por_departamento": {
    "Ventas": {
      "empleados": 2,
      "salario_total": 60816,
      "salario_promedio": 30408,
      "bonos_totales": 13680
    },
    "IT": {
      "empleados": 1,
      "salario_total": 32760,
      "salario_promedio": 32760,
      "bonos_totales": 3500
    },
    "Recursos Humanos": {
      "empleados": 1,
      "salario_total": 25855.20,
      "salario_promedio": 25855.20,
      "bonos_totales": 3920
    }
  },
  "top_3_empleados": [
    /* ... */
  ]
}
```

## Variaciones y Mejoras

### 1. Agregar Validación de Datos

```javascript
// Al inicio del primer Code node
items.forEach((item, index) => {
  const emp = item.json;

  // Validar campos requeridos
  if (!emp.nombre || !emp.salario_base) {
    throw new Error(`Item ${index}: falta nombre o salario_base`);
  }

  // Validar tipos
  if (typeof emp.salario_base !== 'number') {
    throw new Error(`Item ${index}: salario_base debe ser número`);
  }

  // Validar rangos
  if (emp.salario_base < 0) {
    throw new Error(`Item ${index}: salario_base no puede ser negativo`);
  }
});
```

### 2. Exportar a CSV

Agrega un Code node al final:

```javascript
const reporte = items[0].json;

// Convertir detalle a CSV
const headers = ['Posición', 'Nombre', 'Departamento', 'Salario Neto', 'Categoría'];
const csv = [headers.join(',')];

reporte.detalle_completo.forEach(emp => {
  const row = [
    emp.posicion,
    `"${emp.empleado.nombre}"`,
    emp.empleado.departamento,
    emp.compensacion_mensual.neto.replace('$', ''),
    emp.clasificacion.categoria
  ];
  csv.push(row.join(','));
});

return [{
  json: {
    csv_content: csv.join('\n'),
    filename: `reporte_compensacion_${new Date().toISOString().split('T')[0]}.csv`
  }
}];
```

## Puntos Clave Aprendidos

- ✅ Filtrar datos con `filter()`
- ✅ Transformar datos con `map()`
- ✅ Calcular agregaciones con `reduce()`
- ✅ Mantener datos originales con spread operator `...`
- ✅ Formatear números con `toLocaleString()` y `toFixed()`
- ✅ Ordenar con `sort()`
- ✅ Crear reportes estructurados
- ✅ Agrupar datos por categorías

## Ejercicio de Práctica

Modifica el workflow para:
1. Agregar un bono adicional del 10% si el empleado tiene > 5 años
2. Crear una nueva categoría "Executive" para salarios > 50k
3. Calcular el costo total de la empresa (salarios + beneficios adicionales del 30%)
4. Identificar departamentos que están por encima/debajo del promedio

## Siguiente Paso

Continúa con **Ejemplo 2: Control de Flujo** para aprender a usar nodos IF y Switch.
