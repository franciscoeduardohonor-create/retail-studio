#!/usr/bin/awk -f
# Script: calcular_estadisticas.awk
# Descripción: Calcula estadísticas de una columna de números
# Uso: awk -f calcular_estadisticas.awk archivo_numeros.txt

BEGIN {
    suma = 0
    contador = 0
    min = 999999999
    max = -999999999

    print "Calculando estadísticas...\n"
}

# Procesar cada número
{
    numero = $1

    # Guardar en array para calcular mediana y desviación
    datos[++contador] = numero

    # Acumular suma
    suma += numero

    # Encontrar mínimo
    if (numero < min) {
        min = numero
    }

    # Encontrar máximo
    if (numero > max) {
        max = numero
    }
}

END {
    # Calcular promedio
    if (contador > 0) {
        promedio = suma / contador
    } else {
        print "No hay datos para procesar"
        exit
    }

    # Calcular desviación estándar
    suma_cuadrados = 0
    for (i = 1; i <= contador; i++) {
        diferencia = datos[i] - promedio
        suma_cuadrados += diferencia * diferencia
    }
    desviacion = sqrt(suma_cuadrados / contador)

    # Ordenar datos para calcular mediana (bubble sort simple)
    for (i = 1; i <= contador; i++) {
        for (j = i + 1; j <= contador; j++) {
            if (datos[i] > datos[j]) {
                temp = datos[i]
                datos[i] = datos[j]
                datos[j] = temp
            }
        }
    }

    # Calcular mediana
    if (contador % 2 == 1) {
        # Impar: elemento del medio
        mediana = datos[int(contador / 2) + 1]
    } else {
        # Par: promedio de los dos del medio
        pos1 = contador / 2
        pos2 = pos1 + 1
        mediana = (datos[pos1] + datos[pos2]) / 2
    }

    # Mostrar resultados
    print "═══════════════════════════════════════════════════════"
    print "              ESTADÍSTICAS DESCRIPTIVAS"
    print "═══════════════════════════════════════════════════════"
    printf "Cantidad de datos:      %d\n", contador
    printf "Suma total:             %.2f\n", suma
    printf "Promedio (media):       %.2f\n", promedio
    printf "Mediana:                %.2f\n", mediana
    printf "Mínimo:                 %.2f\n", min
    printf "Máximo:                 %.2f\n", max
    printf "Rango:                  %.2f\n", max - min
    printf "Desviación estándar:    %.2f\n", desviacion
    print "═══════════════════════════════════════════════════════"

    # Visualización simple de distribución
    print "\nVISUALIZACIÓN DE DATOS:"
    for (i = 1; i <= contador; i++) {
        printf "%3d: %6.2f ", i, datos[i]

        # Crear barra visual
        barras = int((datos[i] / max) * 30)
        for (j = 1; j <= barras; j++) {
            printf "█"
        }
        print ""
    }
}
