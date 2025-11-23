# 🎯 Ejercicios Prácticos - POV-Ray

Esta carpeta contiene ejercicios prácticos para que puedas aplicar lo aprendido en el curso. Los ejercicios están organizados por nivel de dificultad.

## 📋 Instrucciones Generales

1. **Lee el enunciado** del ejercicio completamente
2. **Intenta resolverlo** por tu cuenta primero
3. **Consulta los ejemplos** del curso si necesitas ayuda
4. **Compara** tu solución con la solución propuesta
5. **Experimenta** modificando y mejorando tu código

## 🎓 Niveles

### Nivel 1: Principiante
Ejercicios básicos para familiarizarte con POV-Ray.

### Nivel 2: Intermedio
Ejercicios que combinan múltiples técnicas.

### Nivel 3: Avanzado
Proyectos completos que integran conceptos avanzados.

---

## 📝 Ejercicio 1: Primera Escena (Principiante)

**Objetivo**: Crear tu primera escena completa con múltiples objetos.

**Requisitos**:
- Una cámara posicionada para ver la escena completa
- Al menos 2 luces (una principal, una de relleno)
- Un plano de suelo con patrón checker
- 3 esferas de diferentes colores y tamaños
- 2 cubos con diferentes acabados (uno mate, uno brillante)
- Un fondo de color

**Conceptos a practicar**:
- Configuración básica de cámara
- Iluminación simple
- Primitivas geométricas
- Pigmentos y finish
- Transformaciones básicas

**Archivo**: `ejercicio-01-primera-escena.pov`

---

## 📝 Ejercicio 2: Robot Simple (Principiante)

**Objetivo**: Crear un robot usando primitivas básicas.

**Requisitos**:
- Cabeza: esfera o cubo
- Cuerpo: cilindro o cubo
- Brazos: cilindros (2)
- Piernas: cilindros (2)
- Antenas o detalles adicionales
- Usa `union` para agrupar las partes
- Colores y acabados apropiados

**Conceptos a practicar**:
- Primitivas geométricas
- Union para agrupar objetos
- Transformaciones (translate, rotate, scale)
- Composición de figuras complejas

**Archivo**: `ejercicio-02-robot.pov`

---

## 📝 Ejercicio 3: Casa Simple (Principiante)

**Objetivo**: Modelar una casa simple con ventanas y puerta.

**Requisitos**:
- Paredes: box
- Techo: prisma, cono o box rotado
- Puerta: box con color diferente (usando difference para tallar)
- Ventanas: boxes pequeños tallados en las paredes (difference)
- Chimenea: cilindro en el techo
- Suelo de césped (plano verde)

**Conceptos a practicar**:
- CSG (difference para ventanas y puerta)
- Transformaciones
- Composición de escenas

**Archivo**: `ejercicio-03-casa.pov`

---

## 📝 Ejercicio 4: Sistema Solar Básico (Intermedio)

**Objetivo**: Crear un sistema solar simple con planetas orbitando.

**Requisitos**:
- Sol en el centro (esfera grande, emisiva o muy brillante)
- 4-5 planetas de diferentes tamaños y colores
- Los planetas deben estar a diferentes distancias del sol
- Usa `#declare` para definir variables (radios, distancias)
- BONUS: Anima los planetas usando `clock` para que orbiten

**Conceptos a practicar**:
- Variables y declaraciones
- Transformaciones (translate para órbitas)
- Rotaciones complejas
- Animación (opcional)

**Archivo**: `ejercicio-04-sistema-solar.pov`

---

## 📝 Ejercicio 5: Ajedrez (Intermedio)

**Objetivo**: Crear varias piezas de ajedrez usando CSG.

**Requisitos**:
- Peón: esfera + cilindro + cono
- Torre: cilindro con almenas (usando difference)
- Alfil: cilindro + cono + esfera en la punta
- Rey: cilindro + esfera + cruz (boxes)
- Reina: similar al rey pero con corona diferente
- Tablero: plano con patrón checker
- Colores blanco y negro apropiados

**Conceptos a practicar**:
- CSG (union, difference, intersection)
- Composición compleja
- Macros para reutilizar piezas

**Archivo**: `ejercicio-05-ajedrez.pov`

---

## 📝 Ejercicio 6: Texturas Naturales (Intermedio)

**Objetivo**: Crear una escena natural usando texturas procedurales.

**Requisitos**:
- Suelo de tierra (granite o bozo con tonos marrones)
- Tronco de árbol (wood con escala apropiada)
- Hojas/copa del árbol (esferas verdes con textura)
- Piedras (granite o granite con bumps)
- Agua o charco (plano con ripples y reflexión)
- Cielo (background con gradiente)

**Conceptos a practicar**:
- Texturas procedurales (wood, granite, bozo, marble)
- color_map
- turbulence
- normal maps

**Archivo**: `ejercicio-06-texturas-naturales.pov`

---

## 📝 Ejercicio 7: Habitación Interior (Intermedio)

**Objetivo**: Crear una habitación vista desde dentro con muebles simples.

**Requisitos**:
- 4 paredes, suelo y techo
- Ventana (box tallado con vidrio transparente)
- Puerta (box tallado)
- Mesa (box o cilindro con patas)
- Silla simple (boxes)
- Iluminación desde la ventana (area_light)
- Uso de radiosity (opcional pero recomendado)

**Conceptos a practicar**:
- CSG para arquitectura
- Materiales (vidrio, madera, metal)
- Iluminación interior
- Radiosity

**Archivo**: `ejercicio-07-habitacion.pov`

---

## 📝 Ejercicio 8: Macro de Ciudad (Avanzado)

**Objetivo**: Crear una macro que genere edificios y usarla para crear una mini-ciudad.

**Requisitos**:
- Macro `Edificio(Posicion, Altura, Ancho, Profundidad, Color)`
- El edificio debe tener:
  - Base
  - Cuerpo principal
  - Ventanas (usando bucles)
  - Techo
- Crear una cuadrícula de 4x4 edificios con alturas y tamaños variables
- Calles entre los edificios (plano con líneas)

**Conceptos a practicar**:
- Macros
- Bucles (#while)
- Parámetros variables
- Generación procedural

**Archivo**: `ejercicio-08-ciudad-procedural.pov`

---

## 📝 Ejercicio 9: Bodegón Fotorealista (Avanzado)

**Objetivo**: Crear un bodegón con objetos diversos y materiales realistas.

**Requisitos mínimos**:
- Copa de vidrio (merge con material de vidrio)
- Fruta (manzana o naranja con SSS simulado)
- Objeto metálico (esfera dorada o plateada)
- Tela (plano con wrinkles normal)
- Mesa de madera (wood texture)
- Iluminación de 3 puntos (key, fill, rim)
- Depth of field
- Photons para caustics (opcional)

**Conceptos a practicar**:
- Materiales fotorealistas
- Iluminación profesional
- Depth of field
- Photons
- Composición artística

**Archivo**: `ejercicio-09-bodegon.pov`

---

## 📝 Ejercicio 10: Animación Completa (Avanzado)

**Objetivo**: Crear una animación corta (3-5 segundos a 30fps).

**Ideas de animación**:
1. **Órbita planetaria**: Planetas orbitando alrededor del sol
2. **Reloj**: Manecillas girando
3. **Engranajes**: Sistema de engranajes sincronizados
4. **Cámara orbital**: Cámara girando alrededor de un objeto estático
5. **Transformación**: Objeto que cambia de forma (morph)

**Requisitos**:
- Usar variable `clock` para animar
- Mínimo 90 frames (3 segundos a 30fps)
- Movimiento suave (considerar easing)
- Al menos 2 objetos animados
- Iluminación apropiada

**Conceptos a practicar**:
- Animación con clock
- Easing functions
- Sincronización
- Interpolación de movimiento

**Archivo**: `ejercicio-10-animacion.pov`

**Renderizar**:
```bash
povray ejercicio-10-animacion.pov +KFF90 +W640 +H480 +A
```

---

## 📝 Ejercicio 11: Árbol Fractal (Avanzado)

**Objetivo**: Crear un árbol fractal usando recursión.

**Requisitos**:
- Macro recursiva `Rama(Profundidad, Largo, Grosor, Angulo)`
- Cada rama debe generar 2-3 ramas más pequeñas
- Profundidad mínima de 4-5 niveles
- Color del tronco más oscuro, ramas más claras
- Opcional: añadir hojas en las ramas finales

**Conceptos a practicar**:
- Recursión
- Macros avanzadas
- Transformaciones complejas
- Generación procedural

**Archivo**: `ejercicio-11-arbol-fractal.pov`

---

## 📝 Ejercicio 12: Proyecto Libre (Avanzado)

**Objetivo**: Crear tu propio proyecto integrando lo aprendido.

**Ideas sugeridas**:
1. **Joyería**: Anillo con diamante, caustics
2. **Vehículo**: Auto, avión o nave espacial
3. **Personaje**: Robot o personaje estilizado completo
4. **Arquitectura**: Edificio completo con interiores
5. **Naturaleza**: Paisaje con árboles, montañas, agua
6. **Espacio**: Nebulosa, galaxia, planetas detallados
7. **Objeto técnico**: Reloj mecánico, instrumento musical

**Requisitos mínimos**:
- Usar al menos 5 técnicas diferentes del curso
- Mínimo 10 objetos en la escena
- Iluminación profesional
- Materiales realistas
- Composición bien pensada
- BONUS: Renderizar en alta calidad (1920x1080)

**Archivo**: `ejercicio-12-proyecto-libre.pov`

---

## 🏆 Desafíos Adicionales

### Desafío 1: Recrear una Foto
Toma una foto de un objeto simple y trata de recrearlo en POV-Ray lo más fielmente posible.

### Desafío 2: Cornell Box
Crea un Cornell Box perfecto con color bleeding visible.

### Desafío 3: Glasss Showcase
Crea una vitrina de vidrio con objetos dentro, enfocándote en caustics perfectos.

### Desafío 4: Naturaleza
Crea una escena de bosque con múltiples árboles, rocas y vegetación.

### Desafío 5: Sci-Fi
Crea una escena de ciencia ficción (nave espacial, ciudad futurista, etc.)

---

## 📤 Compartir tus Ejercicios

Una vez completes los ejercicios:

1. **Guarda tus archivos** en esta carpeta
2. **Renderiza** en buena calidad
3. **Documenta** tu código con comentarios
4. **Experimenta** creando variaciones
5. **Comparte** tus renders en la comunidad de POV-Ray

---

## 💡 Consejos para los Ejercicios

1. **Empieza simple**: No intentes hacerlo perfecto en el primer intento
2. **Itera**: Renderiza frecuentemente en baja calidad para ver el progreso
3. **Comenta tu código**: Te ayudará a entender qué hace cada parte
4. **Experimenta**: Cambia valores y observa qué pasa
5. **Consulta los ejemplos**: Los ejemplos del curso son tu mejor referencia
6. **No te frustres**: POV-Ray tiene una curva de aprendizaje, es normal tener errores
7. **Usa la documentación**: [wiki.povray.org](http://wiki.povray.org) es muy completa

---

## 🎯 Progreso Sugerido

```
Semana 1: Ejercicios 1-3 (Principiante)
Semana 2: Ejercicios 4-5 (Intermedio básico)
Semana 3: Ejercicios 6-7 (Intermedio avanzado)
Semana 4: Ejercicios 8-9 (Avanzado)
Semana 5+: Ejercicios 10-12 (Proyectos)
```

---

## ✅ Checklist de Aprendizaje

Al completar los ejercicios, deberías poder:

- [ ] Crear escenas básicas con primitivas
- [ ] Usar transformaciones correctamente
- [ ] Configurar cámara e iluminación
- [ ] Aplicar materiales y texturas
- [ ] Usar CSG para formas complejas
- [ ] Escribir macros reutilizables
- [ ] Crear animaciones básicas
- [ ] Aplicar técnicas de fotorrealismo
- [ ] Optimizar tiempos de render
- [ ] Depurar errores en el código

---

**¡Buena suerte con los ejercicios! 🚀**

Recuerda: la práctica hace al maestro. Cuanto más practiques, más natural será trabajar con POV-Ray.
