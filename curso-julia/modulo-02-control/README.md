# Módulo 2: Estructuras de Control 🔄

## Objetivos del Módulo

Al finalizar este módulo serás capaz de:
- ✅ Usar condicionales (if, elseif, else)
- ✅ Implementar bucles (for, while)
- ✅ Trabajar con rangos e iteradores
- ✅ Controlar el flujo (break, continue)
- ✅ Usar comprensiones y expresiones ternarias

## 📚 Contenido

1. Condicionales
2. Bucles For
3. Bucles While
4. Rangos e Iteradores
5. Control de Flujo
6. Comprensiones

## Archivos de Práctica

- `01_condicionales.jl` - If, elseif, else
- `02_bucles_for.jl` - Bucles for y rangos
- `03_bucles_while.jl` - Bucles while
- `04_control_flujo.jl` - Break, continue, return
- `05_comprensiones.jl` - List comprehensions
- `proyecto_juego_adivinanza.jl` - Proyecto práctico
- `ejercicios.jl` - Ejercicios del módulo

## Conceptos Clave

### Condicionales

```julia
# If simple
if edad >= 18
    println("Mayor de edad")
end

# If-else
if temperatura > 30
    println("Hace calor")
else
    println("Temperatura agradable")
end

# If-elseif-else
if nota >= 90
    println("A")
elseif nota >= 80
    println("B")
elseif nota >= 70
    println("C")
else
    println("F")
end
```

### Bucles For

```julia
# For básico
for i in 1:5
    println(i)
end

# For con arrays
frutas = ["manzana", "naranja", "plátano"]
for fruta in frutas
    println(fruta)
end

# For con enumerate
for (i, fruta) in enumerate(frutas)
    println("$i: $fruta")
end

# For anidado
for i in 1:3
    for j in 1:3
        println("($i, $j)")
    end
end
```

### Bucles While

```julia
# While básico
contador = 1
while contador <= 5
    println(contador)
    contador += 1
end

# While con condición compleja
numero = 100
while numero > 1
    numero = numero ÷ 2
    println(numero)
end
```

### Control de Flujo

```julia
# Break - sale del bucle
for i in 1:10
    if i > 5
        break
    end
    println(i)
end

# Continue - salta a la siguiente iteración
for i in 1:10
    if i % 2 == 0
        continue
    end
    println(i)  # Solo imprime impares
end
```

### Comprensiones

```julia
# List comprehension
cuadrados = [x^2 for x in 1:10]

# Con condición
pares = [x for x in 1:20 if x % 2 == 0]

# Comprehension multidimensional
matriz = [i+j for i in 1:3, j in 1:3]
```

---

➡️ **Siguiente:** [Módulo 3: Funciones](../modulo-03-funciones/README.md)
