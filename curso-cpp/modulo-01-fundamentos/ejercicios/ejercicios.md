# EJERCICIOS - MÓDULO 1: FUNDAMENTOS BÁSICOS

## Ejercicio 1: Datos Personales
**Dificultad:** Fácil

Crea un programa que:
1. Pida al usuario su nombre completo
2. Pida su edad
3. Pida su ciudad
4. Muestre toda la información en un formato bonito

**Ejemplo de salida:**
```
=== INFORMACIÓN PERSONAL ===
Nombre: Francisco Hernández
Edad: 25 años
Ciudad: Ciudad de México
```

---

## Ejercicio 2: Conversor de Temperatura
**Dificultad:** Fácil

Crea un programa que convierta grados Celsius a Fahrenheit.

**Fórmula:** F = (C × 9/5) + 32

El programa debe:
1. Pedir una temperatura en Celsius
2. Calcular su equivalente en Fahrenheit
3. Mostrar ambos valores

**Ejemplo:**
```
Ingresa temperatura en Celsius: 25
25°C = 77°F
```

---

## Ejercicio 3: Calculadora de Área
**Dificultad:** Media

Crea un programa que calcule el área de diferentes figuras geométricas:
- Círculo: π × r²
- Rectángulo: base × altura
- Triángulo: (base × altura) / 2

El programa debe:
1. Mostrar un menú con las opciones
2. Pedir los datos necesarios según la figura
3. Mostrar el resultado

**Ejemplo:**
```
=== CALCULADORA DE ÁREAS ===
1. Círculo
2. Rectángulo
3. Triángulo

Selecciona una opción: 1
Ingresa el radio: 5
El área del círculo es: 78.54
```

---

## Ejercicio 4: Intercambio de Variables
**Dificultad:** Fácil

Crea un programa que:
1. Pida dos números al usuario
2. Los muestre antes del intercambio
3. Intercambie sus valores
4. Los muestre después del intercambio

**RETO:** Hazlo de dos formas:
- Usando una variable temporal
- Sin usar variables adicionales (usando operaciones aritméticas)

**Ejemplo:**
```
Ingresa el primer número: 10
Ingresa el segundo número: 20

Antes del intercambio:
a = 10
b = 20

Después del intercambio:
a = 20
b = 10
```

---

## Ejercicio 5: Calculadora de IMC
**Dificultad:** Media

Crea un programa que calcule el Índice de Masa Corporal (IMC).

**Fórmula:** IMC = peso / (altura × altura)

El programa debe:
1. Pedir el peso en kilogramos
2. Pedir la altura en metros
3. Calcular el IMC
4. Mostrar el resultado con interpretación

**Clasificación:**
- Bajo peso: IMC < 18.5
- Normal: 18.5 ≤ IMC < 25
- Sobrepeso: 25 ≤ IMC < 30
- Obesidad: IMC ≥ 30

**Ejemplo:**
```
Ingresa tu peso (kg): 70
Ingresa tu altura (m): 1.75

Tu IMC es: 22.86
Clasificación: Peso normal
```

---

## Ejercicio 6: Calculadora de Propina
**Dificultad:** Media

Crea un programa que calcule la propina en un restaurante.

El programa debe:
1. Pedir el total de la cuenta
2. Pedir el porcentaje de propina deseado
3. Calcular la propina
4. Calcular el total a pagar
5. Si son varias personas, dividir el total entre ellas

**Ejemplo:**
```
Total de la cuenta: $500
Porcentaje de propina: 15
Número de personas: 4

Cuenta: $500.00
Propina (15%): $75.00
Total: $575.00
Por persona: $143.75
```

---

## Ejercicio 7: Conversor de Tiempo
**Dificultad:** Media

Crea un programa que convierta segundos a formato horas:minutos:segundos.

El programa debe:
1. Pedir una cantidad de segundos
2. Calcular las horas, minutos y segundos
3. Mostrar el resultado en formato HH:MM:SS

**Ejemplo:**
```
Ingresa segundos: 3661

Tiempo: 01:01:01
(1 horas, 1 minutos, 1 segundos)
```

**Pista:** Usa el operador % (módulo) y división entera

---

## Ejercicio 8: Precio con Descuento
**Dificultad:** Fácil-Media

Crea un programa que calcule el precio final de un producto con descuento e impuestos.

El programa debe:
1. Pedir el precio original
2. Pedir el porcentaje de descuento
3. Aplicar el descuento
4. Aplicar el IVA (16%) al precio con descuento
5. Mostrar todos los detalles

**Ejemplo:**
```
Precio original: $1000
Descuento (%): 20

Precio original: $1000.00
Descuento (20%): -$200.00
Subtotal: $800.00
IVA (16%): +$128.00
TOTAL A PAGAR: $928.00
```

---

## CONSEJOS PARA LOS EJERCICIOS

1. **Compila frecuentemente:** No esperes a terminar todo el código
2. **Prueba con diferentes valores:** Casos normales, cero, negativos
3. **Comenta tu código:** Explica qué hace cada parte
4. **Usa nombres descriptivos:** `temperatura` es mejor que `t`
5. **Formatea la salida:** Usa espacios y saltos de línea para que se vea bien

## COMANDOS PARA COMPILAR

```bash
# Compilar un ejercicio
g++ ejercicio1.cpp -o ejercicio1

# Ejecutar
./ejercicio1
```

Las soluciones están en la carpeta `../soluciones/`
