#!/usr/bin/env julia
# ============================================================================
# MÓDULO 10 - PROYECTO: ANÁLISIS DE DATOS COMPLETO
# ============================================================================

println("📊 PROYECTO: ANÁLISIS DE DATOS CON JULIA\n")

# ============================================================================
# 1. GENERAR DATOS DE EJEMPLO
# ============================================================================

println("1️⃣  Generando datos de ventas...\n")

# Simulamos datos de ventas de una tienda
using Random
Random.seed!(42)

n_registros = 100

# Datos sintéticos
productos = ["Laptop", "Mouse", "Teclado", "Monitor", "Audífonos"]
categorias = ["Electrónica", "Electrónica", "Electrónica", "Electrónica", "Accesorios"]
regiones = ["Norte", "Sur", "Este", "Oeste"]

datos_ventas = [
    (
        producto = rand(productos),
        precio = round(rand(20:500), digits=2),
        cantidad = rand(1:10),
        region = rand(regiones),
        mes = rand(1:12)
    )
    for _ in 1:n_registros
]

println("✅ $n_registros registros generados")
println("Ejemplo: $(datos_ventas[1])\n")

# ============================================================================
# 2. ANÁLISIS BÁSICO
# ============================================================================

println("2️⃣  Análisis básico...\n")

# Calcular totales
totales = [d.precio * d.cantidad for d in datos_ventas]

println("Estadísticas de Ventas:")
println("  Total ventas: \$$(round(sum(totales), digits=2))")
println("  Promedio: \$$(round(sum(totales)/length(totales), digits=2))")
println("  Venta máxima: \$$(round(maximum(totales), digits=2))")
println("  Venta mínima: \$$(round(minimum(totales), digits=2))")
println()

# ============================================================================
# 3. ANÁLISIS POR PRODUCTO
# ============================================================================

println("3️⃣  Análisis por producto...\n")

# Agrupar por producto
ventas_por_producto = Dict{String, Vector{Float64}}()

for (i, venta) in enumerate(datos_ventas)
    producto = venta.producto
    total = venta.precio * venta.cantidad

    if haskey(ventas_por_producto, producto)
        push!(ventas_por_producto[producto], total)
    else
        ventas_por_producto[producto] = [total]
    end
end

println("Ventas por Producto:")
for (producto, ventas) in sort(collect(ventas_por_producto), by=x->sum(x[2]), rev=true)
    total = sum(ventas)
    promedio = total / length(ventas)
    println("  $producto:")
    println("    Total: \$$(round(total, digits=2))")
    println("    Promedio: \$$(round(promedio, digits=2))")
    println("    Cantidad de ventas: $(length(ventas))")
end

println()

# ============================================================================
# 4. ANÁLISIS POR REGIÓN
# ============================================================================

println("4️⃣  Análisis por región...\n")

# Agrupar por región
ventas_por_region = Dict{String, Float64}()

for venta in datos_ventas
    region = venta.region
    total = venta.precio * venta.cantidad

    if haskey(ventas_por_region, region)
        ventas_por_region[region] += total
    else
        ventas_por_region[region] = total
    end
end

println("Ventas por Región:")
for (region, total) in sort(collect(ventas_por_region), by=x->x[2], rev=true)
    porcentaje = (total / sum(values(ventas_por_region))) * 100
    println("  $region: \$$(round(total, digits=2)) ($(round(porcentaje, digits=1))%)")
end

println()

# ============================================================================
# 5. ANÁLISIS TEMPORAL (por mes)
# ============================================================================

println("5️⃣  Análisis temporal...\n")

# Ventas por mes
ventas_por_mes = Dict{Int, Float64}()

for venta in datos_ventas
    mes = venta.mes
    total = venta.precio * venta.cantidad

    if haskey(ventas_por_mes, mes)
        ventas_por_mes[mes] += total
    else
        ventas_por_mes[mes] = total
    end
end

meses_nombres = ["Ene", "Feb", "Mar", "Abr", "May", "Jun",
                 "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"]

println("Ventas Mensuales:")
for mes in sort(collect(keys(ventas_por_mes)))
    total = ventas_por_mes[mes]
    println("  $(meses_nombres[mes]): \$$(round(total, digits=2))")
end

println()

# ============================================================================
# 6. TOP PRODUCTOS
# ============================================================================

println("6️⃣  Top 3 Productos más vendidos...\n")

top_productos = sort(collect(ventas_por_producto), by=x->sum(x[2]), rev=true)[1:min(3, length(ventas_por_producto))]

for (i, (producto, ventas)) in enumerate(top_productos)
    println("  $i. $producto - \$$(round(sum(ventas), digits=2))")
end

println()

# ============================================================================
# 7. REPORTE VISUAL ASCII
# ============================================================================

println("7️⃣  Gráfico de ventas por región (ASCII)...\n")

function grafico_barras_ascii(datos::Dict, titulo::String)
    println(titulo)
    println("-" ^ 50)

    max_valor = maximum(values(datos))

    for (nombre, valor) in sort(collect(datos), by=x->x[2], rev=true)
        # Calcular longitud de la barra (máximo 30 caracteres)
        longitud = Int(round((valor / max_valor) * 30))
        barra = "█" ^ longitud

        println("$(rpad(nombre, 10)) $barra \$$(round(valor, digits=2))")
    end
    println()
end

grafico_barras_ascii(ventas_por_region, "VENTAS POR REGIÓN")

# ============================================================================
# 8. RESUMEN EJECUTIVO
# ============================================================================

println("8️⃣  Resumen Ejecutivo\n")

println("=" ^ 70)
println("RESUMEN DE VENTAS - ANÁLISIS COMPLETO")
println("=" ^ 70)
println()

mejor_region = argmax(ventas_por_region)
peor_region = argmin(ventas_por_region)
mejor_producto = argmax(Dict(p => sum(v) for (p, v) in ventas_por_producto))

println("📈 Indicadores Clave:")
println("  • Total de transacciones: $n_registros")
println("  • Ingresos totales: \$$(round(sum(totales), digits=2))")
println("  • Ticket promedio: \$$(round(sum(totales)/n_registros, digits=2))")
println()

println("🏆 Mejores Desempeños:")
println("  • Mejor región: $mejor_region (\$$(round(ventas_por_region[mejor_region], digits=2)))")
println("  • Producto estrella: $mejor_producto")
println()

println("⚠️  Áreas de Oportunidad:")
println("  • Región con menor venta: $peor_region (\$$(round(ventas_por_region[peor_region], digits=2)))")
println()

println("💡 Recomendaciones:")
println("  1. Incrementar inventario de $mejor_producto")
println("  2. Revisar estrategia de marketing en $peor_region")
println("  3. Analizar tendencias mensuales para ajustar stock")
println()

println("=" ^ 70)
println("✅ Análisis completado exitosamente!")
println("=" ^ 70)

# ============================================================================
# EJERCICIOS ADICIONALES
# ============================================================================

println("\n🎯 Ejercicios para extender este proyecto:")
println("  1. Agregar categorías y analizar por categoría")
println("  2. Calcular tendencias (crecimiento mes a mes)")
println("  3. Identificar productos con bajo rendimiento")
println("  4. Exportar resultados a CSV")
println("  5. Crear pronósticos simples para el próximo mes")
println("  6. Agregar análisis de correlaciones")
println("  7. Implementar alertas para ventas bajas")
