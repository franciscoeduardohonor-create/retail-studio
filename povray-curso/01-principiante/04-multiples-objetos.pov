// ============================================================================
// EJEMPLO 04: MÚLTIPLES OBJETOS - Composición de Escenas
// ============================================================================
// Aprenderás a combinar múltiples objetos para crear escenas completas
// y a organizarlos usando transformaciones básicas.
//
// CONCEPTOS QUE APRENDERÁS:
// - Transformaciones: translate (mover), rotate (rotar), scale (escalar)
// - Combinar múltiples objetos
// - Composición de escenas
// - Agrupación de objetos
// - Creación de estructuras simples
//
// CÓMO RENDERIZAR:
// povray 04-multiples-objetos.pov +W800 +H600 +A
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
  location <5, 4, -7>
  look_at <0, 1, 0>
  angle 55
}

light_source {
  <10, 15, -10>
  color White * 1.2
}

light_source {
  <-5, 8, -5>
  color White * 0.4
  shadowless
}

// ----------------------------------------------------------------------------
// TRANSFORMACIONES BÁSICAS
// ----------------------------------------------------------------------------

// TRANSLATE: Mover objetos en el espacio
// Sintaxis: translate <x, y, z>

sphere {
  <0, 0, 0>, 0.5     // Esfera en el origen

  pigment { color Red }

  finish {
    ambient 0.2
    diffuse 0.6
    phong 0.8
  }

  translate <-3, 1, 0>  // MOVER la esfera 3 unidades a la izquierda
                        // y 1 unidad hacia arriba
}

// SCALE: Cambiar el tamaño de objetos
// Sintaxis: scale <x, y, z> o scale N (uniforme)

sphere {
  <0, 0, 0>, 0.5     // Esfera de radio 0.5

  pigment { color Green }

  finish {
    ambient 0.2
    diffuse 0.6
    phong 0.8
  }

  scale 1.5          // ESCALAR 1.5 veces (radio ahora es 0.75)
  translate <-1, 1, 0>
}

// SCALE NO UNIFORME: Escalar diferente en cada eje

sphere {
  <0, 0, 0>, 0.5

  pigment { color Blue }

  finish {
    ambient 0.2
    diffuse 0.6
    phong 0.8
  }

  scale <1, 2, 1>    // Estirar 2x en el eje Y (crea un elipsoide)
  translate <1, 1, 0>
}

// ROTATE: Rotar objetos
// Sintaxis: rotate <x_grados, y_grados, z_grados>

box {
  <-0.5, -0.5, -0.5>,  // Esquina inferior
  <0.5, 0.5, 0.5>      // Esquina superior

  pigment { color Yellow }

  finish {
    ambient 0.2
    diffuse 0.6
    phong 0.6
  }

  rotate <0, 45, 0>    // Rotar 45 grados alrededor del eje Y
  translate <3, 1, 0>
}

// ----------------------------------------------------------------------------
// ORDEN DE TRANSFORMACIONES (¡IMPORTANTE!)
// ----------------------------------------------------------------------------
// Las transformaciones se aplican en el orden en que aparecen
// El orden importa: rotate -> scale -> translate (generalmente)

cylinder {
  <0, 0, 0>,         // Punto base
  <0, 2, 0>,         // Punto superior
  0.3                // Radio

  pigment { color Orange }

  finish {
    ambient 0.2
    diffuse 0.6
    phong 0.6
  }

  // Observa el ORDEN de las transformaciones:
  rotate <0, 0, 30>        // 1. Primero rotar
  scale <1, 0.8, 1>        // 2. Luego escalar
  translate <0, 0.5, 2>    // 3. Finalmente mover

  // Si cambias el orden, el resultado será DIFERENTE
}

// ----------------------------------------------------------------------------
// AGRUPACIÓN DE OBJETOS
// ----------------------------------------------------------------------------
// Puedes agrupar objetos con 'union' para transformarlos juntos

union {
  // Cabeza
  sphere {
    <0, 1.5, 0>, 0.4
    pigment { color rgb <1, 0.9, 0.7> }
  }

  // Cuerpo
  cylinder {
    <0, 0.5, 0>, <0, 1.1, 0>, 0.3
    pigment { color rgb <0.3, 0.5, 0.8> }
  }

  // Brazo izquierdo
  cylinder {
    <0, 0, 0>, <-0.8, -0.2, 0>, 0.1
    pigment { color rgb <1, 0.9, 0.7> }
    translate <0, 1, 0>
  }

  // Brazo derecho
  cylinder {
    <0, 0, 0>, <0.8, -0.2, 0>, 0.1
    pigment { color rgb <1, 0.9, 0.7> }
    translate <0, 1, 0>
  }

  // Pierna izquierda
  cylinder {
    <-0.15, 0, 0>, <-0.15, -0.5, 0>, 0.12
    pigment { color rgb <0.2, 0.2, 0.6> }
    translate <0, 0.5, 0>
  }

  // Pierna derecha
  cylinder {
    <0.15, 0, 0>, <0.15, -0.5, 0>, 0.12
    pigment { color rgb <0.2, 0.2, 0.6> }
    translate <0, 0.5, 0>
  }

  finish {
    ambient 0.2
    diffuse 0.7
    phong 0.4
  }

  // Transformar TODO el grupo
  scale 1.5
  translate <-3, 0, -3>
}

// ----------------------------------------------------------------------------
// CONSTRUCCIÓN DE UNA TORRE
// ----------------------------------------------------------------------------

// Base de la torre
box {
  <-0.8, 0, -0.8>, <0.8, 0.3, 0.8>
  pigment { color rgb <0.6, 0.6, 0.7> }
  finish { ambient 0.2 diffuse 0.7 }
  translate <3, 0, -3>
}

// Cuerpo de la torre
cylinder {
  <0, 0.3, 0>, <0, 3, 0>, 0.5
  pigment { color rgb <0.7, 0.7, 0.8> }
  finish { ambient 0.2 diffuse 0.7 phong 0.3 }
  translate <3, 0, -3>
}

// Techo cónico
cone {
  <0, 3, 0>, 0.7       // Base del cono
  <0, 4, 0>, 0         // Punta del cono
  pigment { color rgb <0.8, 0.3, 0.3> }
  finish { ambient 0.2 diffuse 0.7 }
  translate <3, 0, -3>
}

// Ventanas de la torre (usando diferencia se verá en CSG)
// Por ahora solo esferas oscuras simulando ventanas
sphere {
  <0, 2, 0.51>, 0.15
  pigment { color rgb <0.2, 0.2, 0.1> }
  finish { ambient 0.1 diffuse 0.3 }
  translate <3, 0, -3>
}

sphere {
  <0, 1.5, 0.51>, 0.15
  pigment { color rgb <0.2, 0.2, 0.1> }
  finish { ambient 0.1 diffuse 0.3 }
  translate <3, 0, -3>
}

// ----------------------------------------------------------------------------
// ARRAY/PATRÓN DE OBJETOS (Manual)
// ----------------------------------------------------------------------------
// Crear múltiples objetos en un patrón

// Fila de esferas pequeñas
sphere {
  <0, 0.3, 0>, 0.2
  pigment { color rgb <1, 0.5, 0.5> }
  finish { ambient 0.2 diffuse 0.6 phong 0.8 }
  translate <-2, 0, 5>
}

sphere {
  <0, 0.3, 0>, 0.2
  pigment { color rgb <0.5, 1, 0.5> }
  finish { ambient 0.2 diffuse 0.6 phong 0.8 }
  translate <-1, 0, 5>
}

sphere {
  <0, 0.3, 0>, 0.2
  pigment { color rgb <0.5, 0.5, 1> }
  finish { ambient 0.2 diffuse 0.6 phong 0.8 }
  translate <0, 0, 5>
}

sphere {
  <0, 0.3, 0>, 0.2
  pigment { color rgb <1, 1, 0.5> }
  finish { ambient 0.2 diffuse 0.6 phong 0.8 }
  translate <1, 0, 5>
}

sphere {
  <0, 0.3, 0>, 0.2
  pigment { color rgb <1, 0.5, 1> }
  finish { ambient 0.2 diffuse 0.6 phong 0.8 }
  translate <2, 0, 5>
}

// ----------------------------------------------------------------------------
// PLANO DE SUELO
// ----------------------------------------------------------------------------

plane {
  <0, 1, 0>, 0

  pigment {
    checker
    color rgb <0.9, 0.9, 0.9>
    color rgb <0.5, 0.5, 0.5>
    scale 0.8
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

background { color rgb <0.5, 0.7, 0.9> }

// ============================================================================
// EJERCICIOS PARA PRACTICAR:
// ============================================================================
// 1. TRANSFORMACIONES:
//    - Mueve algunas esferas a diferentes posiciones
//    - Rota el cubo en diferentes ángulos (prueba rotate <45, 45, 45>)
//    - Escala el muñeco de palo a diferentes tamaños
//
// 2. CREAR TU PROPIA ESTRUCTURA:
//    - Crea una casa simple con un box (cuerpo) y un cone o box (techo)
//    - Añade ventanas y una puerta usando cajas pequeñas
//    - Crea un árbol con un cilindro (tronco) y esferas/conos (hojas)
//
// 3. ORDEN DE TRANSFORMACIONES:
//    - Cambia el orden de rotate, scale y translate en el cilindro
//    - Observa cómo cambia el resultado
//    - Experimenta hasta entender por qué el orden importa
//
// 4. AGRUPACIÓN:
//    - Agrupa la torre completa en un union { }
//    - Rota y mueve toda la torre como un conjunto
//    - Crea múltiples copias de la torre en diferentes posiciones
//
// 5. CREAR UN PATRÓN:
//    - Crea una fila de 10 cubos de diferentes colores
//    - Crea una pirámide de esferas apiladas
//    - Crea una cerca usando cilindros repetidos
//
// 6. PROYECTO: ROBOT SIMPLE
//    - Usando union, cylinders, spheres y boxes
//    - Crea un robot con cabeza, cuerpo, brazos y piernas
//    - Añade detalles como antenas, ojos, etc.
// ============================================================================

// ============================================================================
// CONCEPTOS IMPORTANTES:
// ============================================================================
//
// TRANSFORMACIONES:
// 1. translate <x, y, z>
//    - Mueve el objeto en el espacio
//    - <2, 0, 0> = 2 unidades a la derecha
//    - <0, 3, 0> = 3 unidades arriba
//    - <0, 0, -1> = 1 unidad alejándose
//
// 2. rotate <x, y, z>
//    - Rota en grados alrededor de cada eje
//    - rotate <90, 0, 0> = 90° alrededor de X
//    - rotate <0, 45, 0> = 45° alrededor de Y
//    - rotate <0, 0, 30> = 30° alrededor de Z
//    - Rotación se hace alrededor del origen
//
// 3. scale <x, y, z> o scale N
//    - scale 2 = duplica el tamaño
//    - scale 0.5 = reduce a la mitad
//    - scale <2, 1, 1> = estira en X
//    - scale <1, 0.5, 1> = aplasta en Y
//
// ORDEN DE TRANSFORMACIONES:
// - Las transformaciones se aplican de arriba hacia abajo
// - Orden común: rotate -> scale -> translate
// - Primero forma, luego posición
//
// Ejemplo:
//   rotate <0, 45, 0>    // Rotar primero
//   translate <5, 0, 0>  // Luego mover
//
//   vs
//
//   translate <5, 0, 0>  // Mover primero
//   rotate <0, 45, 0>    // Luego rotar (¡diferente resultado!)
//
// AGRUPACIÓN:
// - union { ... }: Agrupa objetos
// - Puedes aplicar transformaciones al grupo completo
// - Útil para crear objetos complejos
// - También existe: merge, intersection, difference (CSG)
// ============================================================================
