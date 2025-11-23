// ============================================================================
// SOLUCIÓN EJEMPLO: Ejercicio 01 - Primera Escena
// ============================================================================
// Esta es UNA solución posible. La tuya puede ser diferente y estar igual
// de bien. Lo importante es cumplir los requisitos.
// ============================================================================

#version 3.7;

#include "colors.inc"

global_settings {
  assumed_gamma 1.0
}

// ----------------------------------------------------------------------------
// CÁMARA
// ----------------------------------------------------------------------------

camera {
  location <4, 5, -8>
  look_at <0, 1, 0>
  angle 50
}

// ----------------------------------------------------------------------------
// ILUMINACIÓN
// ----------------------------------------------------------------------------

// Luz principal (key)
light_source {
  <5, 10, -5>
  color White * 1.3
}

// Luz de relleno (fill)
light_source {
  <-3, 6, -3>
  color rgb <0.7, 0.8, 1> * 0.5
  shadowless
}

// ----------------------------------------------------------------------------
// ESFERAS
// ----------------------------------------------------------------------------

// Esfera 1 - Roja, grande
sphere {
  <-2, 1.2, 1>, 1.2

  pigment { color Red }

  finish {
    ambient 0.2
    diffuse 0.7
    phong 0.8
    phong_size 60
  }
}

// Esfera 2 - Verde, mediana
sphere {
  <0, 0.8, -1>, 0.8

  pigment { color Green }

  finish {
    ambient 0.2
    diffuse 0.7
    phong 0.9
    phong_size 80
  }
}

// Esfera 3 - Azul, pequeña
sphere {
  <2.5, 0.5, 0>, 0.5

  pigment { color Blue }

  finish {
    ambient 0.2
    diffuse 0.7
    phong 0.7
    phong_size 40
  }
}

// ----------------------------------------------------------------------------
// CUBOS
// ----------------------------------------------------------------------------

// Cubo 1 - Mate (diffuse alto, sin brillo)
box {
  <-1, 0, -3>, <1, 1.5, -1.5>

  pigment { color Orange }

  finish {
    ambient 0.2
    diffuse 0.9    // Alto = mate
    phong 0        // Sin brillo
  }

  rotate <0, 20, 0>
}

// Cubo 2 - Brillante (phong alto)
box {
  <-0.6, 0, 0.6>, <0.6, 1.2, 1.8>

  pigment { color Yellow }

  finish {
    ambient 0.2
    diffuse 0.6
    phong 1.0      // Muy brillante
    phong_size 100
    reflection 0.2 // Un poco de reflexión
  }

  rotate <0, -15, 0>
  translate <3, 0, 2>
}

// ----------------------------------------------------------------------------
// SUELO CON PATRÓN CHECKER
// ----------------------------------------------------------------------------

plane {
  <0, 1, 0>, 0

  pigment {
    checker
    color rgb <0.95, 0.95, 0.95>
    color rgb <0.65, 0.65, 0.65>
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

background { color rgb <0.4, 0.6, 0.8> }

// ============================================================================
// NOTAS:
// ============================================================================
// Esta solución cumple todos los requisitos:
// ✓ Cámara bien posicionada
// ✓ 2 luces (key y fill)
// ✓ Plano checker
// ✓ 3 esferas (diferentes colores y tamaños)
// ✓ 2 cubos (uno mate, uno brillante)
// ✓ Fondo de color
//
// Compara tu solución con esta, pero recuerda que puede haber muchas
// soluciones válidas. Lo importante es que cumplas los requisitos.
// ============================================================================
