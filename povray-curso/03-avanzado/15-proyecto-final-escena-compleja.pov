// ============================================================================
// EJEMPLO 15: PROYECTO FINAL - Escena Compleja Fotorealista
// ============================================================================
// Este ejemplo integra TODAS las técnicas aprendidas en el curso para crear
// una escena compleja y fotorealista.
//
// TÉCNICAS UTILIZADAS:
// ✓ Materiales avanzados (vidrio, metal, madera, tela)
// ✓ CSG (geometría constructiva)
// ✓ Iluminación fotográfica (3-point lighting)
// ✓ Area lights para sombras suaves
// ✓ Radiosity para iluminación global
// ✓ Photons para caustics
// ✓ Depth of field
// ✓ Texturas procedurales
// ✓ Macros para objetos complejos
// ✓ Transformaciones avanzadas
//
// ESCENA: Bodegón de estudio con objetos diversos
//
// CÓMO RENDERIZAR:
// Prueba rápida: povray 15-proyecto-final-escena-compleja.pov +W640 +H480
// Alta calidad:   povray 15-proyecto-final-escena-compleja.pov +W1920 +H1080 +A0.2 +R5 +Q11
// ============================================================================

#version 3.7;

#include "colors.inc"
#include "textures.inc"
#include "metals.inc"
#include "glass.inc"
#include "woods.inc"
#include "shapes.inc"

// ----------------------------------------------------------------------------
// CONFIGURACIÓN GLOBAL
// ----------------------------------------------------------------------------

global_settings {
  assumed_gamma 1.0
  max_trace_level 15

  // Radiosity para iluminación global
  radiosity {
    pretrace_start 0.08
    pretrace_end 0.01
    count 120
    nearest_count 8
    error_bound 0.25
    recursion_limit 2
    low_error_factor 0.4
    gray_threshold 0.0
    minimum_reuse 0.008
    maximum_reuse 0.15
    brightness 1.0
    adc_bailout 0.01
  }

  // Photons para caustics
  photons {
    spacing 0.008
    autostop 0
    jitter 0.5
  }
}

// ----------------------------------------------------------------------------
// CÁMARA CON DEPTH OF FIELD
// ----------------------------------------------------------------------------

camera {
  location <5, 6, -12>
  look_at <0, 1.8, 0>
  angle 42

  // Depth of field
  aperture 0.25
  blur_samples 20
  focal_point <0, 1.8, 0>
  confidence 0.9
  variance 1/150
}

// ----------------------------------------------------------------------------
// ILUMINACIÓN PROFESIONAL (3-Point Setup)
// ----------------------------------------------------------------------------

// KEY LIGHT (Luz principal) - Simula softbox de estudio
light_source {
  <-6, 8, -6>
  color rgb <1, 0.97, 0.94> * 2.2

  area_light <2.5, 0, 0>, <0, 2.5, 0>, 7, 7
  adaptive 2
  jitter

  fade_distance 8
  fade_power 1.5

  photons {
    reflection on
    refraction on
  }
}

// FILL LIGHT (Luz de relleno) - Suave, desde el lado opuesto
light_source {
  <5, 5, -4>
  color rgb <0.7, 0.78, 1> * 0.65
  shadowless
}

// RIM/BACK LIGHT (Luz de contorno) - Desde atrás para separar del fondo
light_source {
  <0, 4, 6>
  color rgb <1, 0.95, 0.9> * 1.2

  spotlight
  point_at <0, 2, 0>
  radius 28
  falloff 40
  tightness 4

  fade_distance 6
  fade_power 1
}

// Luz ambiental muy sutil
light_source {
  <0, 50, 0>
  color rgb <0.75, 0.8, 0.95> * 0.18
  shadowless
}

// ============================================================================
// MACROS PARA OBJETOS COMPLEJOS
// ============================================================================

// ----------------------------------------------------------------------------
// MACRO: Copa de Vidrio
// ----------------------------------------------------------------------------

#macro CopaVidrio(Posicion, Escala)
  merge {
    // Cuerpo de la copa
    difference {
      cone {
        <0, 0, 0>, 0.65
        <0, 2.2, 0>, 0.75
      }

      cone {
        <0, 0.12, 0>, 0.57
        <0, 2.3, 0>, 0.67
      }
    }

    // Borde redondeado
    torus {
      0.74, 0.04
      translate <0, 2.2, 0>
    }

    // Tallo
    cone {
      <0, -1, 0>, 0.12
      <0, 0, 0>, 0.18
    }

    // Base
    difference {
      cylinder { <0, -1.3, 0>, <0, -1, 0>, 0.7 }
      cylinder { <0, -1.35, 0>, <0, -0.95, 0>, 0.62 }
    }

    // Material de vidrio fotorealista
    material {
      texture {
        pigment { color rgbf <0.98, 0.98, 1.0, 0.96> }

        finish {
          ambient 0
          diffuse 0.03
          specular 1.2
          roughness 0.0008

          reflection {
            0.02, 0.99
            fresnel on
            metallic 0
          }
        }
      }

      interior {
        ior 1.517
        fade_distance 1.2
        fade_power 1001
        fade_color <0.85, 0.92, 0.88>
      }
    }

    hollow

    photons {
      target
      refraction on
      reflection on
      collect off
    }

    scale Escala
    translate Posicion
  }
#end

// ----------------------------------------------------------------------------
// MACRO: Vela con llama
// ----------------------------------------------------------------------------

#macro Vela(Posicion)
  union {
    // Cuerpo de la vela (cera)
    cylinder {
      <0, 0, 0>, <0, 1.5, 0>, 0.35

      texture {
        pigment {
          bozo
          turbulence 0.3

          color_map {
            [0.0 color rgb <0.95, 0.92, 0.85>]
            [0.5 color rgb <0.98, 0.95, 0.88>]
            [1.0 color rgb <0.93, 0.90, 0.83>]
          }

          scale 0.2
        }

        normal {
          bumps 0.15
          scale 0.05
        }

        finish {
          ambient 0
          diffuse 0.85
          specular 0.15
          roughness 0.08
        }
      }
    }

    // Mecha
    cylinder {
      <0, 1.45, 0>, <0, 1.65, 0>, 0.02

      pigment { color rgb <0.2, 0.18, 0.15> }
      finish { ambient 0 diffuse 0.8 }
    }

    // Llama (usando media)
    sphere {
      <0, 1.75, 0>, 0.15

      pigment { rgbf 1 }

      interior {
        media {
          emission rgb <1.2, 0.7, 0.2> * 4
          scattering { 1, rgb <1, 0.4, 0.1> * 0.8 }

          density {
            spherical
            density_map {
              [0.0 rgb 0]
              [0.3 rgb 0.6]
              [0.7 rgb 0.95]
              [1.0 rgb 1]
            }
            scale <0.8, 1.2, 0.8>
          }

          samples 15
          method 3
        }
      }

      hollow
      scale <0.6, 1.1, 0.6>
    }

    translate Posicion
  }
#end

// ----------------------------------------------------------------------------
// MACRO: Libro
// ----------------------------------------------------------------------------

#macro Libro(Posicion, Grosor, Ancho, Alto, ColorCubierta)
  union {
    // Páginas
    box {
      <0, 0, 0>, <Grosor * 0.95, Ancho * 0.98, Alto * 0.97>

      texture {
        pigment {
          gradient y
          turbulence 0.01

          color_map {
            [0.0 color rgb <0.98, 0.97, 0.92>]
            [0.5 color rgb <0.99, 0.98, 0.94>]
            [1.0 color rgb <0.97, 0.96, 0.91>]
          }

          scale Alto
        }

        finish { ambient 0 diffuse 0.85 specular 0.02 }
      }

      translate <Grosor * 0.025, Ancho * 0.01, Alto * 0.015>
    }

    // Cubierta
    box {
      <0, 0, 0>, <Grosor, Ancho, Alto>

      texture {
        pigment {
          ColorCubierta
        }

        normal {
          leather 0.3
          scale 0.02
        }

        finish {
          ambient 0
          diffuse 0.7
          specular 0.25
          roughness 0.06
        }
      }
    }

    translate Posicion
  }
#end

// ============================================================================
// ESCENA PRINCIPAL
// ============================================================================

// ----------------------------------------------------------------------------
// MESA (Madera de roble)
// ----------------------------------------------------------------------------

box {
  <-8, -0.4, -5>, <8, 0, 5>

  texture {
    pigment {
      wood
      turbulence 0.05

      color_map {
        [0.0 color rgb <0.45, 0.28, 0.18>]
        [0.3 color rgb <0.52, 0.35, 0.23>]
        [0.6 color rgb <0.56, 0.40, 0.28>]
        [1.0 color rgb <0.48, 0.32, 0.22>]
      }

      scale <0.4, 0.4, 1.2>
      rotate <0, 0, 88>
    }

    normal {
      wood 0.5
      turbulence 0.02
      scale <0.4, 0.4, 1.2>
      rotate <0, 0, 88>
    }

    finish {
      ambient 0
      diffuse 0.65
      specular 0.35
      roughness 0.025

      reflection {
        0.08, 0.18
        fresnel on
      }
    }
  }

  photons {
    target
    reflection on
  }
}

// ----------------------------------------------------------------------------
// COPAS DE VIDRIO (usando macro)
// ----------------------------------------------------------------------------

CopaVidrio(<-2.5, 0, 1>, 0.8)
CopaVidrio(<-1, 0, 0.5>, 0.75)

// Copa con "vino" (líquido rojo)
union {
  CopaVidrio(<1, 0, 0.8>, 0.8)

  // Líquido dentro
  merge {
    cone {
      <0, 0.12, 0>, 0.54
      <0, 1.4, 0>, 0.6
    }

    texture {
      pigment { color rgbf <0.6, 0.05, 0.08, 0.3> }

      finish {
        ambient 0
        diffuse 0.4
        specular 0.6
        roughness 0.01

        reflection {
          0.02, 0.15
          fresnel on
        }
      }
    }

    interior {
      ior 1.35
      fade_distance 0.8
      fade_power 1001
      fade_color <0.5, 0.02, 0.05>
    }

    hollow

    photons {
      target
      refraction on
      reflection on
    }

    scale 0.8
    translate <1, 0, 0.8>
  }
}

// ----------------------------------------------------------------------------
// VELA (usando macro)
// ----------------------------------------------------------------------------

Vela(<3, 0, 1>)

// ----------------------------------------------------------------------------
// LIBROS APILADOS (usando macro)
// ----------------------------------------------------------------------------

Libro(<-4, 0, -2>, 0.5, 3, 4, rgb <0.6, 0.15, 0.15>)

union {
  Libro(<0, 0, 0>, 0.6, 3.2, 4.2, rgb <0.15, 0.3, 0.6>)
  rotate <0, 0, 4>
  translate <-4, 0.5, -2>
}

union {
  Libro(<0, 0, 0>, 0.45, 2.8, 3.8, rgb <0.2, 0.5, 0.25>)
  rotate <0, 0, -3>
  translate <-3.8, 1.1, -1.9>
}

// ----------------------------------------------------------------------------
// ESFERA DORADA
// ----------------------------------------------------------------------------

sphere {
  <0, 1.2, -1.5>, 0.6

  texture {
    pigment { color rgb <1, 0.85, 0.2> }

    normal {
      bumps 0.01
      scale 0.001
    }

    finish {
      ambient 0
      diffuse 0.18
      specular 0.95
      roughness 0.006
      metallic

      reflection {
        0.78
        metallic
      }
    }
  }

  photons {
    target
    reflection on
  }
}

// ----------------------------------------------------------------------------
// BOL DE CERÁMICA
// ----------------------------------------------------------------------------

difference {
  sphere {
    <0, 0, 0>, 0.8
  }

  sphere {
    <0, 0, 0>, 0.72
  }

  plane {
    <0, 1, 0>, 0.2
  }

  texture {
    pigment {
      gradient y
      turbulence 0.1

      color_map {
        [0.0 color rgb <0.2, 0.35, 0.5>]
        [0.5 color rgb <0.25, 0.42, 0.58>]
        [1.0 color rgb <0.18, 0.32, 0.48>]
      }

      scale 1.6
    }

    normal {
      bumps 0.02
      scale 0.01
    }

    finish {
      ambient 0
      diffuse 0.7
      specular 0.5
      roughness 0.02

      reflection {
        0.08
      }
    }
  }

  translate <2.5, 0.5, -2>
}

// ----------------------------------------------------------------------------
// FRUTAS (Manzanas)
// ----------------------------------------------------------------------------

// Manzana 1
sphere {
  <-1.5, 0.4, -1>, 0.35

  texture {
    pigment {
      gradient y
      turbulence 0.3

      color_map {
        [0.0 color rgb <0.7, 0.15, 0.12>]
        [0.5 color rgb <0.85, 0.22, 0.15>]
        [1.0 color rgb <0.75, 0.18, 0.13>]
      }

      scale 0.7
    }

    normal {
      bumps 0.1
      scale 0.02
    }

    finish {
      ambient 0
      diffuse 0.75
      brilliance 2.5  // SSS simulado
      specular 0.25
      roughness 0.04

      reflection {
        0.02
      }
    }
  }

  scale <1, 0.95, 1>
}

// Manzana 2
sphere {
  <-0.8, 0.4, -1.3>, 0.35

  texture {
    pigment {
      gradient y
      turbulence 0.3

      color_map {
        [0.0 color rgb <0.3, 0.6, 0.25>]
        [0.5 color rgb <0.45, 0.75, 0.35>]
        [1.0 color rgb <0.35, 0.65, 0.28>]
      }

      scale 0.7
    }

    normal {
      bumps 0.1
      scale 0.02
    }

    finish {
      ambient 0
      diffuse 0.75
      brilliance 2.5
      specular 0.25
      roughness 0.04

      reflection {
        0.02
      }
    }
  }

  scale <1, 0.95, 1>
}

// ----------------------------------------------------------------------------
// TELA / MANTEL
// ----------------------------------------------------------------------------

plane {
  <0, 1, 0>, -0.39

  texture {
    pigment {
      checker
      color rgb <0.85, 0.82, 0.78>
      color rgb <0.88, 0.85, 0.81>
      scale 0.15
    }

    normal {
      wrinkles 0.15
      scale 0.3
    }

    finish {
      ambient 0
      diffuse 0.88
      brilliance 1.2
      specular 0.08
      roughness 0.6

      reflection {
        0.01
      }
    }
  }

  // Límite del mantel
  clipped_by {
    box { <-7.5, -1, -4.5>, <7.5, 0, 4.5> }
  }
}

// ----------------------------------------------------------------------------
// PARED DE FONDO (Textura de yeso/estuco)
// ----------------------------------------------------------------------------

plane {
  <0, 0, 1>, 10

  texture {
    pigment {
      bozo
      turbulence 0.4

      color_map {
        [0.0 color rgb <0.88, 0.86, 0.82>]
        [0.4 color rgb <0.92, 0.90, 0.86>]
        [0.7 color rgb <0.90, 0.88, 0.84>]
        [1.0 color rgb <0.86, 0.84, 0.80>]
      }

      scale 2.5
    }

    normal {
      bumps 0.35
      scale 0.8
    }

    finish {
      ambient 0
      diffuse 0.82
      specular 0
    }
  }
}

// ----------------------------------------------------------------------------
// SUELO (fuera de la mesa)
// ----------------------------------------------------------------------------

plane {
  <0, 1, 0>, -0.4

  texture {
    pigment {
      wood
      turbulence 0.03

      color_map {
        [0.0 color rgb <0.35, 0.22, 0.15>]
        [0.5 color rgb <0.42, 0.28, 0.19>]
        [1.0 color rgb <0.38, 0.24, 0.16>]
      }

      scale <0.5, 0.5, 3>
      rotate <0, 90, 0>
    }

    normal {
      wood 0.3
      scale <0.5, 0.5, 3>
      rotate <0, 90, 0>
    }

    finish {
      ambient 0
      diffuse 0.7
      specular 0.15
      roughness 0.08

      reflection {
        0.04
      }
    }
  }
}

// ----------------------------------------------------------------------------
// FONDO (Ambiente general)
// ----------------------------------------------------------------------------

background { color rgb <0.15, 0.16, 0.18> }

// Niebla atmosférica muy sutil
fog {
  fog_type 1
  distance 35
  color rgb <0.18, 0.19, 0.21>
}

// ============================================================================
// NOTAS FINALES
// ============================================================================
// Esta escena demuestra:
// - Iluminación profesional de estudio
// - Múltiples materiales realistas
// - Depth of field para enfocar objetos principales
// - Radiosity para luz indirecta suave
// - Photons para caustics en el vidrio
// - Macros para reutilización de objetos
// - Texturas procedurales complejas
// - CSG para crear formas compuestas
//
// TIEMPO DE RENDER:
// - Baja calidad: 1-3 minutos
// - Media calidad: 5-10 minutos
// - Alta calidad: 15-30 minutos (o más según hardware)
//
// MEJORAS POSIBLES:
// - Añadir más objetos decorativos
// - Incluir reflejos en el vidrio del vino
// - Añadir sombras de contacto más suaves
// - Usar HDRI para iluminación ambiental
// - Añadir motion blur si se anima
// - Más detalles en texturas (mapas de imagen)
// ============================================================================
