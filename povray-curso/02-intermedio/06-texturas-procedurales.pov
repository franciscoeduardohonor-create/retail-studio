// ============================================================================
// EJEMPLO 06: TEXTURAS PROCEDURALES - Patrones Complejos
// ============================================================================
// Las texturas procedurales son patrones generados matemáticamente que crean
// efectos visuales complejos sin necesidad de imágenes.
//
// CONCEPTOS QUE APRENDERÁS:
// - Patrones procedurales básicos
// - Color_maps para gradientes
// - Turbulencia y perturbación
// - Escalado y transformación de patrones
// - Combinación de múltiples patrones
//
// CÓMO RENDERIZAR:
// povray 06-texturas-procedurales.pov +W1000 +H800 +A
// ============================================================================

#version 3.7;

#include "colors.inc"
#include "textures.inc"

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
  color White * 1.3
}

light_source {
  <-10, 15, -10>
  color rgb <0.5, 0.5, 0.6> * 0.6
  shadowless
}

// ----------------------------------------------------------------------------
// 1. CHECKER (Tablero de Ajedrez)
// ----------------------------------------------------------------------------
// Patrón alternado de dos colores/texturas

sphere {
  <-6, 1.5, 4>, 1

  pigment {
    checker
    color Red
    color Yellow
    scale 0.3       // Tamaño de los cuadros
  }

  finish {
    ambient 0.2
    diffuse 0.7
    phong 0.6
  }
}

text {
  ttf "timrom.ttf" "CHECKER" 0.05, 0
  scale 0.3
  translate <-6.8, 3, 4>
  pigment { color White }
  finish { ambient 0.6 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// 2. GRADIENT (Gradiente)
// ----------------------------------------------------------------------------
// Gradiente lineal con color_map

sphere {
  <-3.5, 1.5, 4>, 1

  pigment {
    gradient y       // Gradiente en dirección Y (vertical)

    color_map {
      [0.0 color Blue]      // Abajo: azul
      [0.5 color Green]     // Medio: verde
      [1.0 color Red]       // Arriba: rojo
    }

    scale 2          // Escalar el patrón
    translate -y     // Centrar el gradiente
  }

  finish {
    ambient 0.2
    diffuse 0.7
    phong 0.6
  }
}

text {
  ttf "timrom.ttf" "GRADIENT" 0.05, 0
  scale 0.28
  translate <-4.2, 3, 4>
  pigment { color White }
  finish { ambient 0.6 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// 3. WOOD (Madera)
// ----------------------------------------------------------------------------
// Patrón de anillos como la madera

sphere {
  <-1, 1.5, 4>, 1

  pigment {
    wood
    turbulence 0.05  // Perturbación para hacer más realista

    color_map {
      [0.0 color rgb <0.4, 0.2, 0.1>]   // Marrón oscuro
      [0.5 color rgb <0.6, 0.4, 0.2>]   // Marrón medio
      [1.0 color rgb <0.5, 0.3, 0.15>]  // Marrón claro
    }

    scale 0.5
    rotate <90, 0, 0>  // Rotar para ver los anillos
  }

  finish {
    ambient 0.2
    diffuse 0.7
    phong 0.3
  }
}

text {
  ttf "timrom.ttf" "WOOD" 0.05, 0
  scale 0.3
  translate <-1.5, 3, 4>
  pigment { color White }
  finish { ambient 0.6 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// 4. MARBLE (Mármol)
// ----------------------------------------------------------------------------
// Patrón de mármol con vetas

sphere {
  <1.5, 1.5, 4>, 1

  pigment {
    marble
    turbulence 0.6   // Alta turbulencia para vetas

    color_map {
      [0.0 color rgb <0.9, 0.9, 0.9>]   // Blanco
      [0.3 color rgb <0.7, 0.7, 0.8>]   // Gris azulado
      [0.6 color rgb <0.8, 0.8, 0.85>]  // Gris claro
      [1.0 color rgb <0.95, 0.95, 0.95>] // Casi blanco
    }

    scale 0.4
  }

  finish {
    ambient 0.2
    diffuse 0.7
    phong 0.8
    reflection 0.1
  }
}

text {
  ttf "timrom.ttf" "MARBLE" 0.05, 0
  scale 0.3
  translate <0.9, 3, 4>
  pigment { color White }
  finish { ambient 0.6 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// 5. GRANITE (Granito)
// ----------------------------------------------------------------------------
// Patrón moteado como piedra

sphere {
  <4, 1.5, 4>, 1

  pigment {
    granite
    turbulence 0.5

    color_map {
      [0.0 color rgb <0.3, 0.3, 0.3>]   // Gris oscuro
      [0.3 color rgb <0.5, 0.5, 0.5>]   // Gris medio
      [0.6 color rgb <0.4, 0.4, 0.4>]   // Gris
      [1.0 color rgb <0.6, 0.6, 0.6>]   // Gris claro
    }

    scale 0.3
  }

  finish {
    ambient 0.2
    diffuse 0.8
    phong 0.2
  }
}

text {
  ttf "timrom.ttf" "GRANITE" 0.05, 0
  scale 0.28
  translate <3.3, 3, 4>
  pigment { color White }
  finish { ambient 0.6 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// 6. SPOTTED (Manchado)
// ----------------------------------------------------------------------------
// Patrón de manchas aleatorias

sphere {
  <6.5, 1.5, 4>, 1

  pigment {
    spotted
    turbulence 0.3

    color_map {
      [0.0 color Orange]
      [0.5 color Yellow]
      [1.0 color White]
    }

    scale 0.4
  }

  finish {
    ambient 0.2
    diffuse 0.7
    phong 0.5
  }
}

text {
  ttf "timrom.ttf" "SPOTTED" 0.05, 0
  scale 0.28
  translate <5.9, 3, 4>
  pigment { color White }
  finish { ambient 0.6 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// FILA INFERIOR: PATRONES AVANZADOS
// ----------------------------------------------------------------------------

// 7. BOZO (Nubes)
sphere {
  <-6, 1.5, 0>, 1

  pigment {
    bozo
    turbulence 0.8   // Alta turbulencia para efecto de nubes

    color_map {
      [0.0 color rgb <0.3, 0.4, 0.8>]   // Azul oscuro
      [0.3 color rgb <0.6, 0.7, 0.9>]   // Azul claro
      [0.7 color rgb <0.9, 0.9, 1>]     // Casi blanco
      [1.0 color White]                  // Blanco
    }

    scale 0.5
  }

  finish {
    ambient 0.2
    diffuse 0.7
    phong 0.4
  }
}

text {
  ttf "timrom.ttf" "BOZO" 0.05, 0
  scale 0.3
  translate <-6.4, 3, 0>
  pigment { color White }
  finish { ambient 0.6 diffuse 0.5 }
}

// 8. CELLS (Células)
sphere {
  <-3.5, 1.5, 0>, 1

  pigment {
    cells
    turbulence 0.2

    color_map {
      [0.0 color rgb <0.8, 0.3, 0.3>]
      [0.5 color rgb <0.9, 0.6, 0.3>]
      [1.0 color rgb <0.95, 0.8, 0.4>]
    }

    scale 0.3
  }

  finish {
    ambient 0.2
    diffuse 0.7
    phong 0.6
  }
}

text {
  ttf "timrom.ttf" "CELLS" 0.05, 0
  scale 0.3
  translate <-4, 3, 0>
  pigment { color White }
  finish { ambient 0.6 diffuse 0.5 }
}

// 9. AGATE (Ágata)
sphere {
  <-1, 1.5, 0>, 1

  pigment {
    agate
    agate_turb 0.5   // Turbulencia específica para agate

    color_map {
      [0.0 color rgb <0.5, 0.3, 0.2>]
      [0.3 color rgb <0.8, 0.6, 0.4>]
      [0.6 color rgb <0.9, 0.8, 0.6>]
      [1.0 color rgb <0.95, 0.9, 0.8>]
    }

    scale 0.4
  }

  finish {
    ambient 0.2
    diffuse 0.7
    phong 0.7
  }
}

text {
  ttf "timrom.ttf" "AGATE" 0.05, 0
  scale 0.3
  translate <-1.5, 3, 0>
  pigment { color White }
  finish { ambient 0.6 diffuse 0.5 }
}

// 10. WRINKLES (Arrugas)
sphere {
  <1.5, 1.5, 0>, 1

  pigment {
    wrinkles
    scale 0.3
    turbulence 0.4

    color_map {
      [0.0 color rgb <0.2, 0.5, 0.3>]
      [0.5 color rgb <0.4, 0.7, 0.5>]
      [1.0 color rgb <0.6, 0.9, 0.7>]
    }
  }

  finish {
    ambient 0.2
    diffuse 0.7
    phong 0.4
  }
}

text {
  ttf "timrom.ttf" "WRINKLES" 0.05, 0
  scale 0.27
  translate <0.8, 3, 0>
  pigment { color White }
  finish { ambient 0.6 diffuse 0.5 }
}

// 11. RIPPLES (Ondas)
sphere {
  <4, 1.5, 0>, 1

  pigment {
    ripples
    turbulence 0.1
    frequency 10     // Frecuencia de las ondas

    color_map {
      [0.0 color rgb <0.1, 0.3, 0.6>]
      [0.5 color rgb <0.3, 0.6, 0.9>]
      [1.0 color rgb <0.6, 0.8, 1>]
    }

    scale 0.2
  }

  finish {
    ambient 0.2
    diffuse 0.7
    phong 0.8
  }
}

text {
  ttf "timrom.ttf" "RIPPLES" 0.05, 0
  scale 0.28
  translate <3.3, 3, 0>
  pigment { color White }
  finish { ambient 0.6 diffuse 0.5 }
}

// 12. LEOPARD (Leopardo)
sphere {
  <6.5, 1.5, 0>, 1

  pigment {
    leopard
    turbulence 0.2

    color_map {
      [0.0 color rgb <0.9, 0.7, 0.3>]   // Amarillo
      [0.5 color rgb <0.6, 0.4, 0.2>]   // Marrón claro
      [0.8 color rgb <0.3, 0.2, 0.1>]   // Marrón oscuro
      [1.0 color Black]                  // Negro
    }

    scale 0.3
  }

  finish {
    ambient 0.2
    diffuse 0.7
    phong 0.5
  }
}

text {
  ttf "timrom.ttf" "LEOPARD" 0.05, 0
  scale 0.27
  translate <5.9, 3, 0>
  pigment { color White }
  finish { ambient 0.6 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// PLANO DE SUELO CON PATRÓN
// ----------------------------------------------------------------------------

plane {
  <0, 1, 0>, 0

  pigment {
    hexagon
    color rgb <0.9, 0.9, 0.9>
    color rgb <0.7, 0.7, 0.7>
    color rgb <0.5, 0.5, 0.5>
    scale 0.5
  }

  finish {
    ambient 0.2
    diffuse 0.7
    reflection 0.15
  }
}

// ----------------------------------------------------------------------------
// FONDO
// ----------------------------------------------------------------------------

background { color rgb <0.3, 0.4, 0.6> }

// ============================================================================
// EJERCICIOS PARA PRACTICAR:
// ============================================================================
// 1. TURBULENCIA:
//    - Cambia turbulence de 0 a 1 en diferentes patrones
//    - Observa cómo afecta la complejidad del patrón
//    - Intenta valores extremos (0.01, 2.0)
//
// 2. COLOR_MAPS:
//    - Añade más colores intermedios a los gradientes
//    - Cambia las posiciones [0.0 a 1.0]
//    - Crea tus propias paletas de colores
//
// 3. ESCALADO Y TRANSFORMACIÓN:
//    - Cambia scale a diferentes valores
//    - Rota los patrones con rotate
//    - Usa translate para mover el patrón
//
// 4. FRECUENCIA:
//    - En patrones como ripples, ajusta frequency
//    - Prueba valores entre 1 y 50
//    - Observa cómo afecta la densidad del patrón
//
// 5. COMBINACIÓN:
//    - Mezcla dos patrones usando average
//    - Ejemplo en la sección siguiente
//
// 6. CREAR MATERIALES NATURALES:
//    - Piedra: granite con grises
//    - Tierra: bozo con marrones
//    - Agua: ripples con azules
//    - Lava: marble con rojos y naranjas
// ============================================================================

// EJEMPLO DE COMBINACIÓN DE PATRONES:
// sphere {
//   <0, 1.5, -3>, 1
//
//   pigment {
//     average
//     pigment_map {
//       [1 marble turbulence 0.5]
//       [1 granite turbulence 0.3]
//     }
//     color_map {
//       [0.0 color Red]
//       [1.0 color Yellow]
//     }
//   }
// }

// ============================================================================
// REFERENCIA DE PATRONES PROCEDURALES:
// ============================================================================
//
// PATRONES BÁSICOS:
// - checker: Tablero de ajedrez
// - hexagon: Patrón hexagonal (3 colores)
// - square: Cuadrados
// - triangular: Triángulos
//
// PATRONES DE GRADIENTE:
// - gradient x/y/z: Gradiente lineal
// - radial: Gradiente radial
// - spherical: Gradiente esférico
// - cylindrical: Gradiente cilíndrico
//
// PATRONES ORGÁNICOS:
// - bozo: Nubes
// - marble: Mármol
// - wood: Madera
// - granite: Granito
// - agate: Ágata
//
// PATRONES DE SUPERFICIE:
// - wrinkles: Arrugas
// - ripples: Ondas concéntricas
// - waves: Ondas
// - bumps: Baches
//
// PATRONES ANIMALES:
// - leopard: Manchas de leopardo
// - spotted: Manchado
// - cells: Células (panal)
//
// MODIFICADORES:
// - turbulence N: Perturbación (0-1+)
// - omega N: Cantidad de turbulencia
// - lambda N: Tamaño de turbulencia
// - octaves N: Detalle de turbulencia (1-10)
// - frequency N: Frecuencia del patrón
// - phase N: Fase del patrón
// - scale <x,y,z> o N: Escala
// - rotate <x,y,z>: Rotación
// - translate <x,y,z>: Traslación
//
// COLOR_MAP:
// Define gradientes de color entre valores 0.0 y 1.0
// [posición color Color]
// Ejemplo:
//   color_map {
//     [0.0 color Red]
//     [0.5 color Green]
//     [1.0 color Blue]
//   }
// ============================================================================
