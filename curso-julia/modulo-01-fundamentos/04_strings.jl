#!/usr/bin/env julia
# ============================================================================
# MÓDULO 1 - EJEMPLO 4: Strings y Manipulación de Texto
# ============================================================================
# En este archivo aprenderás:
# - Crear y manipular strings
# - Interpolación y formateo
# - Funciones de strings
# - Búsqueda y reemplazo
# - Unicode y expresiones regulares básicas

println("=" ^ 70)
println("📝 STRINGS Y MANIPULACIÓN DE TEXTO EN JULIA")
println("=" ^ 70)
println()

# ============================================================================
# 1. CREACIÓN DE STRINGS
# ============================================================================

println("--- 1. Creación de Strings ---")
println()

# Strings con comillas dobles
saludo = "¡Hola, Mundo!"
nombre = "Julia"
println("String simple: $saludo")
println("Lenguaje: $nombre")
println()

# Strings multilínea (heredoc)
poema = """
    En un lugar de la Mancha,
    de cuyo nombre no quiero acordarme,
    no ha mucho tiempo que vivía
    un hidalgo de los de lanza en astillero.
    """
println("String multilínea:")
println(poema)
println()

# Strings con caracteres especiales
ruta = "C:\\Users\\Usuario\\Documents"  # Doble backslash
println("Ruta Windows: $ruta")
println()

# Raw strings (ignoran caracteres de escape)
ruta_raw = raw"C:\Users\Usuario\Documents"  # Sin doble backslash
println("Raw string: $ruta_raw")
println()

# ============================================================================
# 2. INTERPOLACIÓN DE STRINGS
# ============================================================================

println("--- 2. Interpolación de Strings ---")
println()

# Interpolación simple con $
nombre = "Ana"
edad = 25
println("Hola, me llamo $nombre y tengo $edad años.")
println()

# Interpolación con expresiones usando $()
x = 10
y = 20
println("La suma de $x y $y es $(x + y)")
println("El doble de $x es $(2 * x)")
println()

# Interpolación compleja
precio = 49.99
cantidad = 3
total = precio * cantidad
println("Precio unitario: \$$precio")
println("Cantidad: $cantidad")
println("Total: \$$(round(total, digits=2))")
println()

# ============================================================================
# 3. CONCATENACIÓN DE STRINGS
# ============================================================================

println("--- 3. Concatenación de Strings ---")
println()

# Usando el operador *
nombre = "Julia"
apellido = "Programming"
nombre_completo = nombre * " " * apellido
println("Con *: $nombre_completo")

# Usando string()
texto = string("El", " ", "lenguaje", " ", "Julia")
println("Con string(): $texto")

# Usando join()
palabras = ["Hola", "desde", "Julia"]
frase = join(palabras, " ")
println("Con join(): $frase")

# Con separador personalizado
numeros = ["1", "2", "3", "4", "5"]
lista = join(numeros, ", ")
println("Lista: $lista")
println()

# ============================================================================
# 4. REPETICIÓN DE STRINGS
# ============================================================================

println("--- 4. Repetición de Strings ---")
println()

# Usando el operador ^
linea = "-" ^ 50
println(linea)

risa = "Ja" ^ 5
println("Risa: $risa")

patron = "█▒" ^ 10
println("Patrón: $patron")
println()

# ============================================================================
# 5. LONGITUD Y ACCESO A CARACTERES
# ============================================================================

println("--- 5. Longitud y Acceso a Caracteres ---")
println()

texto = "Julia"

# Longitud del string
println("Texto: \"$texto\"")
println("Longitud: $(length(texto)) caracteres")
println()

# Acceder a caracteres individuales (índice comienza en 1)
println("Primer carácter: $(texto[1])")
println("Tercer carácter: $(texto[3])")
println("Último carácter: $(texto[end])")
println("Penúltimo carácter: $(texto[end-1])")
println()

# Slicing (subcadenas)
println("Primeros 3 caracteres: $(texto[1:3])")
println("Caracteres del 2 al 4: $(texto[2:4])")
println("Desde el 3 hasta el final: $(texto[3:end])")
println()

# ============================================================================
# 6. TRANSFORMACIONES DE TEXTO
# ============================================================================

println("--- 6. Transformaciones de Texto ---")
println()

texto_original = "Hola Mundo desde Julia"

# Mayúsculas y minúsculas
println("Original:      \"$texto_original\"")
println("Mayúsculas:    \"$(uppercase(texto_original))\"")
println("Minúsculas:    \"$(lowercase(texto_original))\"")
println("Título:        \"$(titlecase(texto_original))\"")
println()

# Primera letra mayúscula
texto_minuscula = "julia programming"
texto_capitalizado = uppercase(texto_minuscula[1]) * texto_minuscula[2:end]
println("Capitalizado:  \"$texto_capitalizado\"")
println()

# ============================================================================
# 7. LIMPIEZA DE STRINGS
# ============================================================================

println("--- 7. Limpieza de Strings ---")
println()

texto_espacios = "   Texto con espacios   "
println("Original:      |$texto_espacios|")
println("strip():       |$(strip(texto_espacios))|")
println("lstrip():      |$(lstrip(texto_espacios))|")  # Solo izquierda
println("rstrip():      |$(rstrip(texto_espacios))|")  # Solo derecha
println()

# Eliminar caracteres específicos
texto = "...Hola..."
println("Original:      \"$texto\"")
println("Sin puntos:    \"$(strip(texto, '.'))\"")
println()

# ============================================================================
# 8. BÚSQUEDA EN STRINGS
# ============================================================================

println("--- 8. Búsqueda en Strings ---")
println()

frase = "Julia es un lenguaje de programación rápido"

# Buscar subcadena
println("Frase: \"$frase\"")
println()

# contains() - verifica si contiene una subcadena
println("¿Contiene 'Julia'? $(contains(frase, "Julia"))")
println("¿Contiene 'Python'? $(contains(frase, "Python"))")
println()

# startswith() y endswith()
println("¿Empieza con 'Julia'? $(startswith(frase, "Julia"))")
println("¿Termina con 'rápido'? $(endswith(frase, "rápido"))")
println()

# findfirst() - encuentra la primera ocurrencia
posicion = findfirst("Julia", frase)
println("Posición de 'Julia': $posicion")

posicion = findfirst('e', frase)
println("Posición de 'e': $posicion")
println()

# findlast() - encuentra la última ocurrencia
frase2 = "La programación en Julia es Julia puro"
posicion = findlast("Julia", frase2)
println("Última posición de 'Julia' en \"$frase2\": $posicion")
println()

# ============================================================================
# 9. DIVISIÓN Y UNIÓN DE STRINGS
# ============================================================================

println("--- 9. División y Unión de Strings ---")
println()

# split() - dividir string
texto = "manzana,naranja,plátano,uva"
frutas = split(texto, ",")
println("Texto: \"$texto\"")
println("Dividido: $frutas")
println()

# split() con espacios
frase = "Julia es un lenguaje moderno"
palabras = split(frase)  # Por defecto divide por espacios
println("Frase: \"$frase\"")
println("Palabras: $palabras")
println("Número de palabras: $(length(palabras))")
println()

# join() - unir array de strings
animales = ["perro", "gato", "pájaro"]
lista = join(animales, ", ")
println("Array: $animales")
println("Unido: $lista")
println()

# join() con último separador diferente
lista_final = join(animales, ", ", " y ")
println("Con 'y' final: $lista_final")
println()

# ============================================================================
# 10. REEMPLAZO DE TEXTO
# ============================================================================

println("--- 10. Reemplazo de Texto ---")
println()

texto = "Me gusta Python. Python es genial."

# replace() - reemplazar subcadenas
nuevo_texto = replace(texto, "Python" => "Julia")
println("Original: \"$texto\"")
println("Modificado: \"$nuevo_texto\"")
println()

# Reemplazar solo la primera ocurrencia
texto2 = "uno dos uno tres uno"
nuevo_texto2 = replace(texto2, "uno" => "1", count=1)
println("Original: \"$texto2\"")
println("Reemplazar 1 vez: \"$nuevo_texto2\"")
println()

# Múltiples reemplazos
codigo = "x + y - z"
codigo_modificado = replace(codigo, "x" => "a", "y" => "b", "z" => "c")
println("Original: \"$codigo\"")
println("Modificado: \"$codigo_modificado\"")
println()

# ============================================================================
# 11. VERIFICACIONES DE CONTENIDO
# ============================================================================

println("--- 11. Verificaciones de Contenido ---")
println()

# isempty() - verificar si está vacío
println("¿\"\" está vacío? $(isempty(""))")
println("¿\"Hola\" está vacío? $(isempty("Hola"))")
println()

# all() y any() con predicados
texto = "12345"
println("\"$texto\":")
println("  ¿Todos son dígitos? $(all(isdigit, texto))")
println()

texto2 = "abc123"
println("\"$texto2\":")
println("  ¿Todos son dígitos? $(all(isdigit, texto2))")
println("  ¿Alguno es dígito? $(any(isdigit, texto2))")
println()

# ============================================================================
# 12. FORMATO DE STRINGS
# ============================================================================

println("--- 12. Formato de Strings ---")
println()

# Formateo básico con interpolación
nombre = "Julia"
version = 1.10
println("Lenguaje: $nombre, Versión: $version")
println()

# Formateo numérico
pi_valor = π
println("π sin formato: $pi_valor")
println("π con 2 decimales: $(round(pi_valor, digits=2))")
println("π con 5 decimales: $(round(pi_valor, digits=5))")
println()

# Padding con espacios
numero = 42
println("Sin padding: |$numero|")
println("Con padding:  |$(lpad(numero, 5))|")   # Padding izquierdo
println("Con padding:  |$(rpad(numero, 5))|")   # Padding derecho
println()

# Padding con ceros
println("Número con ceros: $(lpad(numero, 6, '0'))")
println("Código: $(lpad(7, 4, '0'))")  # 0007
println()

# ============================================================================
# 13. UNICODE Y CARACTERES ESPECIALES
# ============================================================================

println("--- 13. Unicode y Caracteres Especiales ---")
println()

# Julia tiene soporte completo de Unicode
texto_unicode = "Café con ñ y emojis 😊🚀"
println("Texto Unicode: $texto_unicode")
println("Longitud: $(length(texto_unicode)) caracteres")
println()

# Caracteres de escape
println("Nueva línea: Línea 1\\nLínea 2")
println("Nueva línea: Línea 1\nLínea 2")
println("Tabulación: Col1\\tCol2")
println("Tabulación: Col1\tCol2")
println("Comillas: \"Texto entre comillas\"")
println("Backslash: C:\\\\Users\\\\Usuario")
println()

# ============================================================================
# 14. EJEMPLOS PRÁCTICOS
# ============================================================================

println("--- 14. Ejemplos Prácticos ---")
println()

# Ejemplo 1: Validar email simple
function validar_email_simple(email)
    return contains(email, "@") && contains(email, ".")
end

email1 = "usuario@ejemplo.com"
email2 = "invalido.com"
println("📧 Validación de emails:")
println("  $email1 → $(validar_email_simple(email1) ? "Válido" : "Inválido")")
println("  $email2 → $(validar_email_simple(email2) ? "Válido" : "Inválido")")
println()

# Ejemplo 2: Contar palabras
function contar_palabras(texto)
    palabras = split(strip(texto))
    return length(palabras)
end

texto = "  Julia es un lenguaje de programación moderno  "
println("📊 Contar palabras:")
println("  Texto: \"$texto\"")
println("  Número de palabras: $(contar_palabras(texto))")
println()

# Ejemplo 3: Extraer iniciales
function extraer_iniciales(nombre_completo)
    palabras = split(nombre_completo)
    iniciales = [uppercase(palabra[1]) for palabra in palabras]
    return join(iniciales, "")
end

nombre = "Juan Carlos Pérez"
println("👤 Extraer iniciales:")
println("  Nombre: $nombre")
println("  Iniciales: $(extraer_iniciales(nombre))")
println()

# Ejemplo 4: Censurar palabras
function censurar(texto, palabra)
    asteriscos = "*" ^ length(palabra)
    return replace(texto, palabra => asteriscos)
end

mensaje = "Esta es una mala palabra que debe censurarse"
println("🔒 Censurar palabras:")
println("  Original: \"$mensaje\"")
println("  Censurado: \"$(censurar(mensaje, "mala"))\"")
println()

# Ejemplo 5: Formatear número de teléfono
function formatear_telefono(numero)
    # Eliminar caracteres no numéricos
    solo_numeros = filter(isdigit, numero)

    if length(solo_numeros) == 10
        return "(" * solo_numeros[1:3] * ") " *
               solo_numeros[4:6] * "-" * solo_numeros[7:10]
    else
        return "Formato inválido"
    end
end

tel1 = "5551234567"
tel2 = "555-123-4567"
println("📞 Formatear teléfonos:")
println("  $tel1 → $(formatear_telefono(tel1))")
println("  $tel2 → $(formatear_telefono(tel2))")
println()

# ============================================================================
# 15. EJERCICIOS PRÁCTICOS
# ============================================================================

println("=" ^ 70)
println("🎯 EJERCICIOS PARA PRACTICAR:")
println("=" ^ 70)
println()
println("1. Manipulación básica:")
println("   - Crea una variable con tu nombre completo")
println("   - Convierte a mayúsculas y minúsculas")
println("   - Cuenta cuántas letras tiene (sin espacios)")
println()
println("2. Búsqueda y reemplazo:")
println("   - Crea una frase con la palabra 'programar' 3 veces")
println("   - Reemplaza 'programar' por 'codificar'")
println("   - Encuentra la posición de la primera 'a'")
println()
println("3. División y unión:")
println("   - Crea un string: \"rojo,verde,azul,amarillo\"")
println("   - Divide por comas")
println("   - Une de nuevo con ' - ' como separador")
println()
println("4. Función personalizada:")
println("   - Crea una función que revierta un string")
println("   - Ejemplo: \"Hola\" → \"aloH\"")
println()
println("5. Validación:")
println("   - Crea una función que verifique si un string es un palíndromo")
println("   - Ejemplo: \"anilina\" → true, \"casa\" → false")
println()

# ============================================================================
# TU CÓDIGO AQUÍ:
# ============================================================================

println("--- TUS SOLUCIONES ---")
println()

# Ejercicio 1:


# Ejercicio 2:


# Ejercicio 3:


# Ejercicio 4:


# Ejercicio 5:


# ============================================================================

println()
println("=" ^ 70)
println("✅ ¡Programa completado!")
println("=" ^ 70)
println()
println("💡 Conceptos clave aprendidos:")
println("   ✓ Creación e interpolación de strings")
println("   ✓ Concatenación y repetición")
println("   ✓ Transformaciones (uppercase, lowercase, etc.)")
println("   ✓ Búsqueda (contains, findfirst, etc.)")
println("   ✓ División y unión (split, join)")
println("   ✓ Reemplazo (replace)")
println("   ✓ Formato y padding")
println()
println("📚 Próximo paso: 05_entrada_salida.jl")
println("=" ^ 70)
