#!/usr/bin/awk -f
# Script: analizar_ventas.awk
# Descripción: Analiza un archivo CSV de ventas y genera estadísticas
# Uso: awk -f analizar_ventas.awk ventas.csv

BEGIN {
    FS = ","  # Separador de campos: coma
    OFS = " | "  # Separador de salida

    print "═══════════════════════════════════════════════════════"
    print "           ANÁLISIS DE VENTAS - REPORTE"
    print "═══════════════════════════════════════════════════════"
}

# Saltar encabezado
NR == 1 {
    next
}

# Procesar cada venta
{
    fecha = $1
    producto = $2
    cantidad = $3
    precio = $4
    region = $5

    # Calcular total de la línea
    total = cantidad * precio

    # Acumular por producto
    ventas_producto[producto] += total
    unidades_producto[producto] += cantidad

    # Acumular por región
    ventas_region[region] += total

    # Total general
    total_general += total
    total_unidades += cantidad
}

END {
    print "\n📊 RESUMEN POR PRODUCTO:"
    print "───────────────────────────────────────────────────────"
    for (prod in ventas_producto) {
        printf "  %-15s: %4d unidades = $%10.2f\n",
               prod, unidades_producto[prod], ventas_producto[prod]
    }

    print "\n🌍 RESUMEN POR REGIÓN:"
    print "───────────────────────────────────────────────────────"
    for (reg in ventas_region) {
        porcentaje = (ventas_region[reg] / total_general) * 100
        printf "  %-15s: $%10.2f (%5.1f%%)\n",
               reg, ventas_region[reg], porcentaje
    }

    print "\n═══════════════════════════════════════════════════════"
    printf "💰 TOTAL GENERAL: $%.2f\n", total_general
    printf "📦 UNIDADES VENDIDAS: %d\n", total_unidades
    printf "📈 VENTA PROMEDIO: $%.2f\n", total_general / (NR - 1)
    print "═══════════════════════════════════════════════════════"
}
