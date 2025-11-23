# ============================================================================
# SOLUCIONES - MÓDULO 1: FUNDAMENTOS DE R
# ============================================================================

# ============================================================================
# EJERCICIO 1: OPERACIONES BÁSICAS
# ============================================================================

# a) La suma de 456 + 789
456 + 789  # 1245

# b) El producto de 23 * 45
23 * 45  # 1035

# c) 2 elevado a la 10
2^10  # 1024

# d) La raíz cuadrada de 144
sqrt(144)  # 12

# e) El residuo de dividir 100 entre 7
100 %% 7  # 2

# ============================================================================
# EJERCICIO 2: VARIABLES Y CÁLCULOS
# ============================================================================

# Datos
precio_a <- 50
unidades_a <- 120
precio_b <- 75
unidades_b <- 80
precio_c <- 100
unidades_c <- 50

# a) El ingreso total por cada producto
ingreso_a <- precio_a * unidades_a  # 6000
ingreso_b <- precio_b * unidades_b  # 6000
ingreso_c <- precio_c * unidades_c  # 5000

# b) El ingreso total de la tienda
ingreso_total <- ingreso_a + ingreso_b + ingreso_c  # 17000

# c) El porcentaje de ingresos de cada producto
porcentaje_a <- (ingreso_a / ingreso_total) * 100  # 35.29%
porcentaje_b <- (ingreso_b / ingreso_total) * 100  # 35.29%
porcentaje_c <- (ingreso_c / ingreso_total) * 100  # 29.41%

print(paste("Producto A:", round(porcentaje_a, 2), "%"))
print(paste("Producto B:", round(porcentaje_b, 2), "%"))
print(paste("Producto C:", round(porcentaje_c, 2), "%"))

# ============================================================================
# EJERCICIO 3: VECTORES
# ============================================================================

# Crear vector de temperaturas
temperaturas <- c(22, 24, 21, 23, 25, 27, 26)
dias <- c("Lun", "Mar", "Mié", "Jue", "Vie", "Sáb", "Dom")

# a) La temperatura promedio
promedio_temp <- mean(temperaturas)  # 24

# b) La temperatura máxima y mínima
temp_max <- max(temperaturas)  # 27
temp_min <- min(temperaturas)  # 21

# c) Cuántos días la temperatura fue mayor a 23 grados
dias_calidos <- sum(temperaturas > 23)  # 4

# d) Nuevo vector sumando 3 grados
temperaturas_aumentadas <- temperaturas + 3

print(paste("Temperatura promedio:", promedio_temp))
print(paste("Máxima:", temp_max, "- Mínima:", temp_min))
print(paste("Días con más de 23°:", dias_calidos))
print("Temperaturas aumentadas:")
print(temperaturas_aumentadas)

# ============================================================================
# EJERCICIO 4: ESTADÍSTICAS BÁSICAS
# ============================================================================

ventas_mes <- c(1200, 1500, 1800, 1400, 1600, 2000, 2200,
                1900, 1700, 1550, 1650, 1800, 2100, 2300,
                1950, 1750, 1600, 1500, 1900, 2000, 2150,
                1850, 1700, 1800, 1950, 2200, 2400, 2100, 1900, 1800)

# a) El promedio de ventas
promedio_ventas <- mean(ventas_mes)  # 1853.33

# b) La mediana
mediana_ventas <- median(ventas_mes)  # 1850

# c) La desviación estándar
desviacion <- sd(ventas_mes)  # 289.77

# d) El total vendido en el mes
total_mes <- sum(ventas_mes)  # 55600

# e) El día con mayores ventas
dia_mejor <- which.max(ventas_mes)  # 27

# f) Cuántos días se vendió más de 2000
dias_sobre_2000 <- sum(ventas_mes > 2000)  # 7

print(paste("Promedio:", round(promedio_ventas, 2)))
print(paste("Mediana:", mediana_ventas))
print(paste("Desviación estándar:", round(desviacion, 2)))
print(paste("Total del mes:", total_mes))
print(paste("Mejor día:", dia_mejor, "con ventas de", ventas_mes[dia_mejor]))
print(paste("Días con ventas > 2000:", dias_sobre_2000))

# ============================================================================
# EJERCICIO 5: TEXTO
# ============================================================================

nombre <- "Juan"
apellido <- "Pérez"
edad <- 25

mensaje <- paste("Hola, mi nombre es", nombre, apellido, "y tengo", edad, "años")
print(mensaje)

# Alternativa con paste0
mensaje2 <- paste0("Hola, mi nombre es ", nombre, " ", apellido, " y tengo ", edad, " años")
print(mensaje2)

# ============================================================================
# EJERCICIO 6: LÓGICA Y COMPARACIONES
# ============================================================================

empleado1_ventas <- 15000
empleado2_ventas <- 22000
empleado3_ventas <- 18000
meta_ventas <- 20000

# a) ¿Qué empleados superaron la meta?
empleado1_supera <- empleado1_ventas > meta_ventas  # FALSE
empleado2_supera <- empleado2_ventas > meta_ventas  # TRUE
empleado3_supera <- empleado3_ventas > meta_ventas  # FALSE

# b) ¿Cuántos empleados superaron la meta?
total_superan <- sum(c(empleado1_supera, empleado2_supera, empleado3_supera))  # 1

# c) Vector con las 3 ventas y encontrar quién vendió más
ventas_empleados <- c(empleado1_ventas, empleado2_ventas, empleado3_ventas)
mejor_vendedor <- which.max(ventas_empleados)  # 2

print(paste("Empleados que superaron meta:", total_superan))
print(paste("Mejor vendedor: Empleado", mejor_vendedor))

# ============================================================================
# EJERCICIO 7: CONVERSIÓN DE UNIDADES
# ============================================================================

distancias_km <- c(5, 10, 21.1, 42.2, 100)
factor_conversion <- 0.621371

# a) Las distancias en millas
distancias_millas <- distancias_km * factor_conversion

# b) El promedio de distancias en millas
promedio_millas <- mean(distancias_millas)  # 36.48

# c) ¿Cuántas distancias son mayores a 50 millas?
mayores_50 <- sum(distancias_millas > 50)  # 1

print("Distancias en millas:")
print(round(distancias_millas, 2))
print(paste("Promedio:", round(promedio_millas, 2), "millas"))
print(paste("Distancias > 50 millas:", mayores_50))

# ============================================================================
# EJERCICIO 8: PRESUPUESTO PERSONAL
# ============================================================================

ingreso_mensual <- 3000

# Regla 50/30/20
necesidades <- ingreso_mensual * 0.50  # 1500
gustos <- ingreso_mensual * 0.30  # 900
ahorros <- ingreso_mensual * 0.20  # 600

print("=== PRESUPUESTO MENSUAL ===")
print(paste("Necesidades (50%):", necesidades))
print(paste("Gustos (30%):", gustos))
print(paste("Ahorros (20%):", ahorros))
print(paste("Total:", necesidades + gustos + ahorros))

# ============================================================================
# EJERCICIO 9: ANÁLISIS DE DATOS FALTANTES
# ============================================================================

horas_estudio <- c(2, 3, NA, 4, 2, NA, 5, 3, 4, 2)

# a) ¿Cuántos días NO registraste horas de estudio?
dias_sin_registro <- sum(is.na(horas_estudio))  # 2

# b) El promedio de horas (sin contar los NA)
promedio_con_na <- mean(horas_estudio, na.rm = TRUE)  # 3.125

# c) Reemplaza los NA por 0 y vuelve a calcular
horas_sin_na <- horas_estudio
horas_sin_na[is.na(horas_sin_na)] <- 0
promedio_sin_na <- mean(horas_sin_na)  # 2.5

print(paste("Días sin registro:", dias_sin_registro))
print(paste("Promedio (sin NA):", promedio_con_na))
print(paste("Promedio (NA=0):", promedio_sin_na))

# ============================================================================
# EJERCICIO 10: PROYECTO INTEGRADOR
# ============================================================================

# Unidades vendidas por día
cafe <- c(50, 55, 48, 62, 70, 75, 60)
te <- c(30, 32, 28, 35, 40, 42, 38)
jugo <- c(20, 22, 25, 28, 30, 35, 32)
agua <- c(40, 38, 42, 45, 50, 48, 46)

# Precios
precio_cafe <- 3.50
precio_te <- 2.50
precio_jugo <- 4.00
precio_agua <- 1.50

# a) Ventas totales por producto
ventas_cafe <- sum(cafe) * precio_cafe  # 1,470
ventas_te <- sum(te) * precio_te  # 612.5
ventas_jugo <- sum(jugo) * precio_jugo  # 768
ventas_agua <- sum(agua) * precio_agua  # 463.5

# b) Ingreso total de la semana
ingreso_total_semana <- ventas_cafe + ventas_te + ventas_jugo + ventas_agua  # 3,314

# c) El producto que genera más ingresos
ventas_por_producto <- c(ventas_cafe, ventas_te, ventas_jugo, ventas_agua)
nombres_productos <- c("Café", "Té", "Jugo", "Agua")
producto_top <- nombres_productos[which.max(ventas_por_producto)]  # Café

# d) El promedio de unidades vendidas por día de cada producto
promedio_cafe <- mean(cafe)  # 60
promedio_te <- mean(te)  # 35
promedio_jugo <- mean(jugo)  # 27.43
promedio_agua <- mean(agua)  # 44.14

# e) El día de la semana con mayores ingresos totales
ingresos_diarios <- (cafe * precio_cafe) + (te * precio_te) +
                    (jugo * precio_jugo) + (agua * precio_agua)
dia_mejor_ingreso <- which.max(ingresos_diarios)  # 6 (Sábado)
dias_semana <- c("Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo")

print("=== ANÁLISIS DE LA CAFETERÍA ===")
print(paste("Ventas Café: $", ventas_cafe))
print(paste("Ventas Té: $", ventas_te))
print(paste("Ventas Jugo: $", ventas_jugo))
print(paste("Ventas Agua: $", ventas_agua))
print(paste("\nIngreso total semanal: $", ingreso_total_semana))
print(paste("Producto top:", producto_top))
print(paste("\nPromedio unidades/día - Café:", round(promedio_cafe, 1)))
print(paste("Promedio unidades/día - Té:", round(promedio_te, 1)))
print(paste("Promedio unidades/día - Jugo:", round(promedio_jugo, 1)))
print(paste("Promedio unidades/día - Agua:", round(promedio_agua, 1)))
print(paste("\nMejor día:", dias_semana[dia_mejor_ingreso],
            "con $", round(ingresos_diarios[dia_mejor_ingreso], 2)))

print("\n¡Excelente trabajo completando todos los ejercicios!")
