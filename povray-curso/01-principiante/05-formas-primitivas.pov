// ============================================================================
// EJEMPLO 05: FORMAS PRIMITIVAS - Geometría Básica
// ============================================================================
// POV-Ray incluye muchas formas geométricas primitivas que puedes usar.
// En este ejemplo verás todas las formas básicas disponibles.
//
// CONCEPTOS QUE APRENDERÁS:
// - Todas las primitivas de POV-Ray
// - Parámetros de cada forma
// - Cuándo usar cada primitiva
// - Combinación de primitivas
//
// CÓMO RENDERIZAR:
// povray 05-formas-primitivas.pov +W1000 +H800 +A
// ============================================================================

#version 3.7;

#include "colors.inc"

global_settings {
  assumed_gamma 1.0
}

// ----------------------------------------------------------------------------
// CÁMARA Y LUCES
// ----------------------------------------------------------------------------

camera {
  location <0, 8, -15>
  look_at <0, 2, 0>
  angle 60
}

light_source {
  <10, 20, -15>
  color White * 1.2
}

light_source {
  <-10, 15, -10>
  color White * 0.5
  shadowless
}

// ----------------------------------------------------------------------------
// 1. SPHERE (Esfera)
// ----------------------------------------------------------------------------
// La forma más simple y común
// Sintaxis: sphere { <centro>, radio }

sphere {
  <-6, 1, 3>, 0.8

  pigment { color Red }
  finish { ambient 0.2 diffuse 0.7 phong 0.9 phong_size 60 }
}

text {
  ttf "timrom.ttf" "SPHERE" 0.05, 0
  scale 0.35
  translate <-6.8, 2.2, 3>
  pigment { color White }
  finish { ambient 0.5 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// 2. BOX (Caja/Cubo)
// ----------------------------------------------------------------------------
// Define una caja rectangular alineada con los ejes
// Sintaxis: box { <esquina1>, <esquina2> }

box {
  <-0.6, 0, -0.6>,    // Esquina inferior izquierda trasera
  <0.6, 1.2, 0.6>     // Esquina superior derecha frontal

  pigment { color Green }
  finish { ambient 0.2 diffuse 0.7 phong 0.6 }
  translate <-4, 0, 3>
}

text {
  ttf "timrom.ttf" "BOX" 0.05, 0
  scale 0.35
  translate <-4.5, 2.2, 3>
  pigment { color White }
  finish { ambient 0.5 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// 3. CYLINDER (Cilindro)
// ----------------------------------------------------------------------------
// Cilindro entre dos puntos
// Sintaxis: cylinder { <punto1>, <punto2>, radio }

cylinder {
  <0, 0, 0>,         // Punto base
  <0, 1.5, 0>,       // Punto superior
  0.5                // Radio

  pigment { color Blue }
  finish { ambient 0.2 diffuse 0.7 phong 0.6 }
  translate <-2, 0, 3>
}

text {
  ttf "timrom.ttf" "CYLINDER" 0.05, 0
  scale 0.3
  translate <-2.8, 2.2, 3>
  pigment { color White }
  finish { ambient 0.5 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// 4. CONE (Cono)
// ----------------------------------------------------------------------------
// Cono entre dos puntos con dos radios
// Sintaxis: cone { <punto1>, radio1, <punto2>, radio2 }

cone {
  <0, 0, 0>, 0.7     // Base: centro y radio
  <0, 1.8, 0>, 0     // Punta: centro y radio (0 = punta)

  pigment { color Yellow }
  finish { ambient 0.2 diffuse 0.7 phong 0.6 }
  translate <0, 0, 3>
}

text {
  ttf "timrom.ttf" "CONE" 0.05, 0
  scale 0.35
  translate <-0.5, 2.2, 3>
  pigment { color White }
  finish { ambient 0.5 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// 5. PLANE (Plano)
// ----------------------------------------------------------------------------
// Plano infinito definido por una normal y distancia
// Sintaxis: plane { <normal>, distancia }
// (El plano de suelo se muestra al final)

// ----------------------------------------------------------------------------
// 6. TORUS (Toroide/Dona)
// ----------------------------------------------------------------------------
// Forma de dona
// Sintaxis: torus { radio_mayor, radio_menor }

torus {
  0.6,               // Radio mayor (del centro al tubo)
  0.25               // Radio menor (grosor del tubo)

  pigment { color Orange }
  finish { ambient 0.2 diffuse 0.7 phong 0.8 }
  rotate <90, 0, 0>  // Rotarlo para que sea horizontal
  translate <2, 0.8, 3>
}

text {
  ttf "timrom.ttf" "TORUS" 0.05, 0
  scale 0.35
  translate <1.5, 2.2, 3>
  pigment { color White }
  finish { ambient 0.5 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// 7. PRISM (Prisma)
// ----------------------------------------------------------------------------
// Forma extruida desde un perfil 2D
// Sintaxis: prism { altura1, altura2, num_puntos, <puntos...> }

prism {
  linear_sweep       // Tipo de extrusión
  linear_spline      // Tipo de interpolación
  0,                 // Altura inferior
  1.5,               // Altura superior
  5,                 // Número de puntos (incluyendo cierre)

  // Puntos del perfil (triángulo)
  <0, 0>, <1, 0>, <0.5, 1>, <0, 0>, <0, 0>

  pigment { color Cyan }
  finish { ambient 0.2 diffuse 0.7 phong 0.5 }
  rotate <0, 0, -90>
  scale <0.8, 0.8, 0.8>
  translate <4, 0, 3>
}

text {
  ttf "timrom.ttf" "PRISM" 0.05, 0
  scale 0.35
  translate <3.4, 2.2, 3>
  pigment { color White }
  finish { ambient 0.5 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// FILA INFERIOR: FORMAS AVANZADAS
// ----------------------------------------------------------------------------

// 8. LATHE (Torno)
// ----------------------------------------------------------------------------
// Forma creada rotando un perfil alrededor del eje Y
// Sintaxis: lathe { tipo_spline, num_puntos, <puntos...> }

lathe {
  linear_spline
  5,                 // Número de puntos

  // Puntos del perfil (forma de jarrón)
  <0, 0>, <0.3, 0>, <0.4, 0.5>, <0.3, 1>, <0.2, 1.2>

  pigment { color Magenta }
  finish { ambient 0.2 diffuse 0.7 phong 0.8 }
  scale 0.8
  translate <6, 0, 3>
}

text {
  ttf "timrom.ttf" "LATHE" 0.05, 0
  scale 0.35
  translate <5.5, 2.2, 3>
  pigment { color White }
  finish { ambient 0.5 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// 9. BLOB (Metabola)
// ----------------------------------------------------------------------------
// Formas orgánicas que se mezclan suavemente
// Sintaxis: blob { threshold N, sphere { ... } }

blob {
  threshold 0.6      // Umbral de la superficie

  sphere { <-0.3, 0, 0>, 0.6, 1 }   // strength = 1
  sphere { <0.3, 0, 0>, 0.6, 1 }
  sphere { <0, 0.5, 0>, 0.5, 1 }

  pigment { color rgb <1, 0.5, 0.8> }
  finish { ambient 0.2 diffuse 0.7 phong 0.9 }
  scale 0.9
  translate <-6, 1, 0>
}

text {
  ttf "timrom.ttf" "BLOB" 0.05, 0
  scale 0.35
  translate <-6.5, 2.2, 0>
  pigment { color White }
  finish { ambient 0.5 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// 10. TEXT (Texto 3D)
// ----------------------------------------------------------------------------
// Texto tridimensional extruido
// Sintaxis: text { ttf "fuente.ttf" "texto" profundidad, offset }

text {
  ttf "timrom.ttf"   // Fuente TrueType
  "3D"               // Texto a renderizar
  0.3,               // Profundidad de extrusión
  0                  // Offset (espaciado de vectores)

  pigment { color rgb <0.8, 0.2, 0.8> }
  finish { ambient 0.2 diffuse 0.7 phong 0.6 }
  scale 0.8
  translate <-4.5, 0.5, 0>
}

text {
  ttf "timrom.ttf" "TEXT" 0.05, 0
  scale 0.35
  translate <-4.5, 2.2, 0>
  pigment { color White }
  finish { ambient 0.5 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// 11. SOR (Surface of Revolution)
// ----------------------------------------------------------------------------
// Similar a lathe pero con sintaxis diferente
// Sintaxis: sor { num_puntos, <puntos...> }

sor {
  7,  // Número de puntos

  // Pares <radio, altura>
  <0.0, 0.0>,
  <0.3, 0.2>,
  <0.5, 0.4>,
  <0.4, 0.7>,
  <0.5, 1.0>,
  <0.3, 1.2>,
  <0.0, 1.3>

  pigment { color rgb <0.3, 0.8, 0.5> }
  finish { ambient 0.2 diffuse 0.7 phong 0.7 }
  scale 0.7
  translate <-2, 0, 0>
}

text {
  ttf "timrom.ttf" "SOR" 0.05, 0
  scale 0.35
  translate <-2.3, 2.2, 0>
  pigment { color White }
  finish { ambient 0.5 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// 12. SUPERELLIPSOID (Superelipsoide)
// ----------------------------------------------------------------------------
// Forma entre esfera y cubo controlada por parámetros
// Sintaxis: superellipsoid { <e, n> }

superellipsoid {
  <0.2, 0.2>         // Valores entre 0 y 1
                     // <1, 1> = esfera
                     // <0.1, 0.1> = cubo con bordes redondeados
                     // Valores diferentes = formas intermedias

  pigment { color rgb <0.8, 0.8, 0.3> }
  finish { ambient 0.2 diffuse 0.7 phong 0.8 }
  scale 0.8
  translate <0, 0.8, 0>
}

text {
  ttf "timrom.ttf" "SUPERELLIPSOID" 0.05, 0
  scale 0.25
  translate <-1.2, 2.2, 0>
  pigment { color White }
  finish { ambient 0.5 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// 13. DISC (Disco)
// ----------------------------------------------------------------------------
// Disco plano (círculo con grosor opcional)
// Sintaxis: disc { <centro>, <normal>, radio }

disc {
  <0, 1, 0>,         // Centro
  <0, 1, 0>,         // Normal (apunta hacia arriba)
  0.8                // Radio exterior

  pigment { color rgb <0.3, 0.6, 0.9> }
  finish { ambient 0.2 diffuse 0.7 phong 0.5 }
  translate <2, 0, 0>
}

text {
  ttf "timrom.ttf" "DISC" 0.05, 0
  scale 0.35
  translate <1.6, 2.2, 0>
  pigment { color White }
  finish { ambient 0.5 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// 14. OVUS (Ovoide)
// ----------------------------------------------------------------------------
// Forma de huevo
// Sintaxis: ovus { radio_inferior, radio_superior }

ovus {
  0.8,               // Radio de la esfera inferior
  0.5                // Radio de la esfera superior

  pigment { color rgb <0.95, 0.9, 0.85> }
  finish { ambient 0.2 diffuse 0.7 phong 0.6 }
  scale 0.9
  translate <4, 0.8, 0>
}

text {
  ttf "timrom.ttf" "OVUS" 0.05, 0
  scale 0.35
  translate <3.5, 2.2, 0>
  pigment { color White }
  finish { ambient 0.5 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// 15. PARAMETRIC (Superficie Paramétrica)
// ----------------------------------------------------------------------------
// Superficies definidas por ecuaciones paramétricas

parametric {
  function { sin(u) * cos(v) }
  function { sin(u) * sin(v) }
  function { cos(u) }

  <0, 0>, <2*pi, 2*pi>
  contained_by { sphere { 0, 2 } }
  max_gradient 2

  pigment { color rgb <0.7, 0.3, 0.9> }
  finish { ambient 0.2 diffuse 0.7 phong 0.7 }
  scale 0.5
  translate <6, 1, 0>
}

text {
  ttf "timrom.ttf" "PARAMETRIC" 0.05, 0
  scale 0.25
  translate <5.2, 2.2, 0>
  pigment { color White }
  finish { ambient 0.5 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// PLANO DE SUELO
// ----------------------------------------------------------------------------

plane {
  <0, 1, 0>, 0       // Normal hacia arriba, en y=0

  pigment {
    checker
    color rgb <0.95, 0.95, 0.95>
    color rgb <0.6, 0.6, 0.6>
    scale 0.5
  }

  finish {
    ambient 0.2
    diffuse 0.7
    reflection 0.1
  }
}

// ----------------------------------------------------------------------------
// FONDO
// ----------------------------------------------------------------------------

background { color rgb <0.4, 0.5, 0.7> }

// ============================================================================
// EJERCICIOS PARA PRACTICAR:
// ============================================================================
// 1. MODIFICAR PRIMITIVAS:
//    - Cambia el radio de la esfera
//    - Haz el cilindro más alto o más delgado
//    - Cambia el tamaño del torus (radio mayor y menor)
//
// 2. CREAR OBJETOS COMPLEJOS:
//    - Combina primitivas para crear una botella (cylinder + sphere)
//    - Crea una copa (cone + sphere + torus)
//    - Crea un reloj de arena (dos conos unidos)
//
// 3. EXPERIMENTAR CON PARÁMETROS:
//    - Cambia los valores del superellipsoid (<0.5, 0.5>, <0.1, 1>, etc.)
//    - Modifica el perfil del lathe para diferentes formas
//    - Cambia el threshold del blob (0.3, 0.6, 0.9)
//
// 4. TEXTO 3D:
//    - Cambia el texto y la fuente
//    - Ajusta la profundidad de extrusión
//    - Crea un letrero con tu nombre
//
// 5. FORMAS ORGÁNICAS:
//    - Añade más esferas al blob
//    - Experimenta con diferentes strengths
//    - Crea una forma de nube o roca con blob
//
// 6. PROYECTO: AJEDREZ
//    - Peón: sphere + cone
//    - Torre: cylinder + box
//    - Alfil: cylinder + cone + sphere
//    - Caballo: blob o mesh complejo
//    - Reina: cylinder + sphere + cone
//    - Rey: cylinder + sphere + cone + box (cruz)
// ============================================================================

// ============================================================================
// REFERENCIA RÁPIDA DE PRIMITIVAS:
// ============================================================================
//
// FORMAS BÁSICAS:
// - sphere { <centro>, radio }
// - box { <esquina1>, <esquina2> }
// - cylinder { <base>, <tope>, radio }
// - cone { <base>, radio1, <tope>, radio2 }
// - plane { <normal>, distancia }
//
// FORMAS CURVAS:
// - torus { radio_mayor, radio_menor }
// - disc { <centro>, <normal>, radio [, radio_interior] }
// - ovus { radio_inferior, radio_superior }
//
// FORMAS EXTRUIDAS:
// - prism { ... }
// - lathe { ... }
// - sor { ... }
//
// FORMAS ESPECIALES:
// - blob { threshold N, sphere {...}, ... }
// - text { ttf "fuente" "texto" profundidad, offset }
// - superellipsoid { <e, n> }
// - parametric { function, function, function, ... }
//
// MODIFICADORES COMUNES:
// - open: Cilindros y conos sin tapas
// - sturm: Mayor precisión (más lento)
// - inverse: Invierte el interior/exterior
//
// EJEMPLO DE CILINDRO ABIERTO:
// cylinder { <0,0,0>, <0,2,0>, 0.5 open }
// ============================================================================
