#!/usr/bin/awk -f
# Script: procesar_logs.awk
# Descripción: Procesa archivos de log y cuenta errores, warnings e info
# Uso: awk -f procesar_logs.awk logs.txt

BEGIN {
    errores = 0
    warnings = 0
    info = 0

    print "═══════════════════════════════════════════════════════"
    print "           ANÁLISIS DE LOGS DEL SISTEMA"
    print "═══════════════════════════════════════════════════════\n"
}

# Procesar líneas de ERROR
/ERROR/ {
    errores++
    print "❌ ERROR [" NR "]:", $0
    # Guardar errores para resumen
    lista_errores[errores] = $0
}

# Procesar líneas de WARNING
/WARNING/ {
    warnings++
    print "⚠️  WARNING [" NR "]:", $0
}

# Procesar líneas de INFO
/INFO/ {
    info++
}

END {
    print "\n═══════════════════════════════════════════════════════"
    print "                    RESUMEN"
    print "═══════════════════════════════════════════════════════"
    printf "Total de líneas procesadas: %d\n", NR
    printf "❌ Errores:   %d\n", errores
    printf "⚠️  Warnings:  %d\n", warnings
    printf "ℹ️  Info:      %d\n", info
    print "═══════════════════════════════════════════════════════"

    # Calcular porcentajes
    if (NR > 0) {
        error_pct = (errores / NR) * 100
        warning_pct = (warnings / NR) * 100
        info_pct = (info / NR) * 100

        print "\nDISTRIBUCIÓN PORCENTUAL:"
        printf "  Errores:   %5.1f%%\n", error_pct
        printf "  Warnings:  %5.1f%%\n", warning_pct
        printf "  Info:      %5.1f%%\n", info_pct
    }

    # Estado del sistema
    print "\nESTADO DEL SISTEMA:"
    if (errores == 0) {
        print "  ✅ Sistema funcionando correctamente (sin errores)"
    } else if (errores <= 2) {
        print "  ⚠️  Sistema con errores menores"
    } else {
        print "  ❌ Sistema con múltiples errores - requiere atención"
    }
}
