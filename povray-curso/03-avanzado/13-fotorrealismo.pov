// ============================================================================
// EJEMPLO 13: FOTORREALISMO - Técnicas Avanzadas de Realismo
// ============================================================================
// Aprende a crear renders fotorealistas combinando todas las técnicas
// avanzadas: materiales precisos, iluminación realista, y post-procesado.
//
// CONCEPTOS QUE APRENDERÁS:
// - Materiales físicamente correctos
// - Subsurface scattering (SSS)
// - Caustics y photons
// - Depth of field (profundidad de campo)
// - Motion blur
// - Ambient occlusion
//
// CÓMO RENDERIZAR (alta calidad):
// povray 13-fotorrealismo.pov +W1920 +H1080 +A0.3 +R3 +Q11
// ============================================================================

#version 3.7;

#include "colors.inc"
#include "textures.inc"
#include "metals.inc"
#include "glass.inc"
#include "woods.inc"

global_settings {
  assumed_gamma 1.0
  max_trace_level 15

  // Photons para caustics (efectos de luz a través de transparentes)
  photons {
    spacing 0.01
    autostop 0
    jitter 0.4
  }

  // Radiosity para iluminación global (ver ejemplo 14 para detalles)
  radiosity {
    pretrace_start 0.08
    pretrace_end 0.01
    count 150
    nearest_count 10
    error_bound 0.3
    recursion_limit 2
    low_error_factor 0.5
    gray_threshold 0.0
    minimum_reuse 0.005
    maximum_reuse 0.2
    brightness 1.0
    adc_bailout 0.005
  }
}

// ----------------------------------------------------------------------------
// CÁMARA CON DEPTH OF FIELD (Profundidad de campo)
// ----------------------------------------------------------------------------

camera {
  location <4, 6, -10>
  look_at <0, 1.5, 0>
  angle 45

  // DEPTH OF FIELD (desenfoque realista)
  aperture 0.3        // Tamaño de apertura (mayor = más desenfoque)
  blur_samples 20     // Número de samples (más = mejor calidad, más lento)
  focal_point <0, 1.5, 0>  // Punto enfocado
  confidence 0.9
  variance 1/128
}

// ----------------------------------------------------------------------------
// ILUMINACIÓN FOTOGRÁFICA
// ----------------------------------------------------------------------------

// Luz principal (Key) - Simula luz de ventana
light_source {
  <-5, 8, -5>
  color rgb <1, 0.98, 0.95> * 1.5  // Luz diurna ligeramente cálida

  area_light <2, 0, 0>, <0, 2, 0>, 7, 7
  adaptive 2
  jitter

  fade_distance 10
  fade_power 1

  // Caustics para esta luz
  photons {
    reflection on
    refraction on
  }
}

// Luz de relleno (Fill) - Luz rebotada suave
light_source {
  <3, 4, -3>
  color rgb <0.7, 0.8, 1> * 0.4  // Luz fría (simulando cielo)
  shadowless
}

// Luz de contorno (Rim)
light_source {
  <2, 3, 3>
  color rgb <1, 0.95, 0.9> * 0.6

  spotlight
  point_at <0, 1.5, 0>
  radius 25
  falloff 35
}

// Luz ambiental global (muy sutil)
light_source {
  <0, 100, 0>
  color rgb <0.8, 0.85, 1> * 0.2
  shadowless
}

// ----------------------------------------------------------------------------
// 1. VIDRIO FOTOREALISTA
// ----------------------------------------------------------------------------

#declare VidrioPerfecto = material {
  texture {
    pigment { color rgbf <0.98, 0.98, 1.0, 0.95> }

    finish {
      ambient 0
      diffuse 0.05
      specular 1
      roughness 0.001

      reflection {
        0.02, 0.98  // Mínimo y máximo
        fresnel on
        metallic 0
      }
    }
  }

  interior {
    ior 1.52  // Vidrio crown
    fade_distance 0.5
    fade_power 1001
    fade_color <0.8, 0.9, 0.8>
  }
}

// Copa de vidrio con caustics
merge {
  // Cuerpo
  difference {
    cone {
      <0, 0, 0>, 0.7
      <0, 2, 0>, 0.8
    }

    cone {
      <0, 0.1, 0>, 0.62
      <0, 2.1, 0>, 0.72
    }
  }

  // Base
  difference {
    cylinder { <0, -0.3, 0>, <0, 0, 0>, 0.8 }
    cylinder { <0, -0.35, 0>, <0, -0.05, 0>, 0.7 }
  }

  // Tallo
  cone {
    <0, -0.3, 0>, 0.15
    <0, 0, 0>, 0.2
  }

  material { VidrioPerfecto }
  hollow

  // Activar photons
  photons {
    target
    refraction on
    reflection on
    collect off
  }

  translate <-2.5, 0, 0>
}

// ----------------------------------------------------------------------------
// 2. METAL PULIDO (Oro)
// ----------------------------------------------------------------------------

#declare OroReal = material {
  texture {
    pigment { color rgb <1, 0.843, 0> }

    finish {
      ambient 0
      diffuse 0.2
      specular 0.8
      roughness 0.01
      metallic

      reflection {
        0.7
        metallic
      }
    }
  }
}

// Esfera de oro
sphere {
  <0, 1.5, 0>, 0.8

  material { OroReal }

  photons {
    target
    reflection on
  }
}

// ----------------------------------------------------------------------------
// 3. MÁRMOL REALISTA
// ----------------------------------------------------------------------------

#declare MarmoREalista = material {
  texture {
    pigment {
      marble
      turbulence 0.5

      color_map {
        [0.0 color rgb <0.95, 0.95, 0.93>]
        [0.3 color rgb <0.90, 0.88, 0.85>]
        [0.6 color rgb <0.85, 0.85, 0.82>]
        [1.0 color rgb <0.92, 0.90, 0.88>]
      }

      scale 0.3
    }

    normal {
      marble 0.3
      turbulence 0.5
      scale 0.3
    }

    finish {
      ambient 0
      diffuse 0.6
      specular 0.4
      roughness 0.02

      reflection {
        0.15
        fresnel on
      }
    }
  }
}

// Pedestal de mármol
cylinder {
  <0, 0, 0>, <0, 0.8, 0>, 1

  material { MarmoRealista }

  photons {
    target
    reflection on
  }

  translate <0, 0, 0>
}

// ----------------------------------------------------------------------------
// 4. MADERA REALISTA
// ----------------------------------------------------------------------------

#declare MaderaRoble = material {
  texture {
    pigment {
      wood
      turbulence 0.04

      color_map {
        [0.0 color rgb <0.42, 0.26, 0.15>]
        [0.3 color rgb <0.48, 0.30, 0.18>]
        [0.6 color rgb <0.52, 0.37, 0.26>]
        [1.0 color rgb <0.40, 0.28, 0.20>]
      }

      scale <0.3, 0.3, 1>
      rotate <0, 0, 90>
    }

    normal {
      wood 0.4
      turbulence 0.02
      scale <0.3, 0.3, 1>
      rotate <0, 0, 90>
    }

    finish {
      ambient 0
      diffuse 0.7
      specular 0.2
      roughness 0.1

      reflection {
        0.05
      }
    }
  }
}

// Mesa de madera
box {
  <-4, 0, -2>, <4, 0.3, 2>

  material { MaderaRoble }

  photons {
    target
    reflection on
  }

  translate <0, -0.3, 0>
}

// ----------------------------------------------------------------------------
// 5. TELA/FABRIC (Subsurface Scattering simulado)
// ----------------------------------------------------------------------------

#declare TelaSuave = material {
  texture {
    pigment {
      color rgb <0.8, 0.2, 0.2>
    }

    normal {
      wrinkles 0.3
      scale 0.1
    }

    finish {
      ambient 0
      diffuse 0.9
      brilliance 1.5  // Simula SSS
      specular 0.1
      roughness 0.5

      // Reflección muy sutil
      reflection {
        0.01
      }
    }
  }
}

// Tela drapeada (simulada con esfera deformada)
sphere {
  <0, 0, 0>, 1

  material { TelaSuave }

  scale <1.5, 0.3, 1.5>
  translate <2.5, 0.3, 0>
}

// ----------------------------------------------------------------------------
// 6. PIEL/SKIN (Subsurface Scattering)
// ----------------------------------------------------------------------------

#declare Piel = material {
  texture {
    pigment {
      color rgb <0.95, 0.76, 0.65>
    }

    normal {
      bumps 0.015
      scale 0.01
    }

    finish {
      ambient 0
      diffuse 0.6
      brilliance 2.5  // Alto para simular SSS
      specular 0.15
      roughness 0.15

      // Reflexión mínima
      reflection {
        0.008
        fresnel on
      }
    }
  }

  interior {
    // Simular dispersión interna
    media {
      scattering { 3, rgb <1, 0.8, 0.7> * 0.01 }
      samples 10
    }
  }
}

// Mano simplificada
sphere {
  <0, 1, 0>, 0.6
  material { Piel }
  hollow
  translate <-5, 0, -1>
}

// ----------------------------------------------------------------------------
// 7. AGUA REALISTA
// ----------------------------------------------------------------------------

#declare AguaReal = material {
  texture {
    pigment {
      color rgbf <0.85, 0.92, 0.95, 0.9>
    }

    normal {
      ripples 0.3
      frequency 10
      scale 0.3
    }

    finish {
      ambient 0
      diffuse 0.1
      specular 1
      roughness 0.001

      reflection {
        0.02, 1.0
        fresnel on
      }
    }
  }

  interior {
    ior 1.33
    fade_distance 2
    fade_power 1001
    fade_color <0.2, 0.3, 0.25>

    // Caustics
    media {
      absorption rgb <0.1, 0.05, 0.03>
    }
  }
}

// Gota de agua o charco
blob {
  threshold 0.6

  sphere { <0, 0, 0>, 0.8, 1 }
  sphere { <-0.4, 0, 0>, 0.6, 1 }
  sphere { <0.4, 0, 0>, 0.6, 1 }

  material { AguaReal }
  hollow

  photons {
    target
    refraction on
    reflection on
  }

  scale <1.2, 0.3, 1.2>
  translate <-5, 0.3, 2>
}

// ----------------------------------------------------------------------------
// 8. ESPEJO PERFECTO
// ----------------------------------------------------------------------------

plane {
  <1, 0, 0>, -6

  pigment { color rgb <0.95, 0.95, 0.95> }

  finish {
    ambient 0
    diffuse 0.05
    specular 1
    reflection {
      0.95
      metallic 0.5
    }
  }

  photons {
    target
    reflection on
  }
}

// ----------------------------------------------------------------------------
// 9. PLÁSTICO BRILLANTE
// ----------------------------------------------------------------------------

#declare PlasticoBrillante = material {
  texture {
    pigment { color rgb <0.2, 0.7, 0.9> }

    finish {
      ambient 0
      diffuse 0.6
      specular 0.8
      roughness 0.005

      reflection {
        0.3
        fresnel on
      }
    }
  }
}

torus {
  0.6, 0.2

  material { PlasticoBrillante }

  rotate <90, 0, 0>
  translate <3, 1.5, -1.5>
}

// ----------------------------------------------------------------------------
// PLANO DE SUELO REALISTA
// ----------------------------------------------------------------------------

plane {
  <0, 1, 0>, 0

  texture {
    pigment {
      checker
      color rgb <0.95, 0.95, 0.93>
      color rgb <0.88, 0.88, 0.85>
      scale 1
    }

    normal {
      bumps 0.01
      scale 0.05
    }

    finish {
      ambient 0
      diffuse 0.7
      specular 0.2
      roughness 0.05

      reflection {
        0.15, 0.3
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
// PARED DE FONDO (Yeso)
// ----------------------------------------------------------------------------

plane {
  <0, 0, 1>, 8

  texture {
    pigment {
      bozo
      turbulence 0.3

      color_map {
        [0.0 color rgb <0.92, 0.90, 0.85>]
        [0.5 color rgb <0.95, 0.93, 0.88>]
        [1.0 color rgb <0.90, 0.88, 0.83>]
      }

      scale 2
    }

    normal {
      bumps 0.3
      scale 0.5
    }

    finish {
      ambient 0
      diffuse 0.8
      specular 0
    }
  }
}

// ----------------------------------------------------------------------------
// FONDO (Cielo/Ambiente)
// ----------------------------------------------------------------------------

background {
  color rgb <0.85, 0.90, 0.95>
}

// Niebla atmosférica sutil
fog {
  fog_type 1
  distance 25
  color rgb <0.88, 0.92, 0.96>
}

// ============================================================================
// EJERCICIOS PARA PRACTICAR:
// ============================================================================
// 1. MATERIALES:
//    - Crea diamante (IOR 2.417, alta dispersión)
//    - Crea acero inoxidable (reflection 0.8, metallic)
//    - Crea piel de naranja (bumps + color naranja)
//
// 2. ILUMINACIÓN:
//    - Implementa HDRI lighting (usando sky_sphere con image_map)
//    - Crea setup de estudio fotográfico (4-5 luces)
//    - Simula luz de atardecer (color cálido, ángulo bajo)
//
// 3. DEPTH OF FIELD:
//    - Ajusta aperture para diferentes profundidades
//    - Enfoca diferentes objetos
//    - Crea efecto bokeh
//
// 4. CAUSTICS:
//    - Copa de vidrio con agua proyectando caustics
//    - Prisma descomponiendo luz
//    - Diamante con dispersión
//
// 5. PROYECTO: BODEGÓN FOTOREALISTA
//    - Frutas con SSS (uvas, manzanas)
//    - Copa de vidrio con líquido
//    - Superficie reflectante
//    - Iluminación de estudio
//    - Depth of field
//
// 6. PROYECTO: JOYERÍA
//    - Anillo de oro con diamante
//    - Base de terciopelo
//    - Iluminación para resaltar brillo
//    - Caustics y reflexiones
// ============================================================================

// ============================================================================
// REFERENCIA DE FOTORREALISMO:
// ============================================================================
//
// DEPTH OF FIELD (Cámara):
// camera {
//   aperture N          // Tamaño de apertura (0.1-1.0 típico)
//   blur_samples N      // Samples (15-100)
//   focal_point <x,y,z> // Punto enfocado
//   confidence 0.9      // Precisión
//   variance 1/128      // Varianza
// }
//
// PHOTONS (Caustics):
// global_settings {
//   photons {
//     spacing 0.01      // Densidad de photons
//     autostop 0        // Detención automática
//     jitter 0.4        // Aleatorización
//   }
// }
//
// En luz:
// photons {
//   reflection on
//   refraction on
// }
//
// En objeto:
// photons {
//   target            // Este objeto recibe caustics
//   refraction on
//   reflection on
//   collect off       // No almacena photons
// }
//
// MATERIALES FÍSICOS:
//
// IOR (Índice de Refracción):
// - Vacío: 1.0
// - Aire: 1.000293
// - Agua: 1.33
// - Vidrio: 1.5-1.9
// - Diamante: 2.417
// - Cristal: 1.5
//
// METALES:
// finish {
//   ambient 0
//   diffuse 0.1-0.3
//   specular 0.8-1.0
//   roughness 0.001-0.01
//   metallic
//   reflection { 0.7-0.95 metallic }
// }
//
// VIDRIO:
// pigment { color rgbf <R,G,B,0.9-0.98> }
// finish {
//   ambient 0
//   diffuse 0.05
//   specular 1
//   roughness 0.001
//   reflection { 0.02, 0.98 fresnel on }
// }
// interior { ior 1.5 }
//
// AGUA:
// Similar a vidrio pero:
// - ior 1.33
// - normal { ripples/waves }
// - fade_color para color del agua
//
// MADERA:
// - pigment { wood }
// - normal { wood }
// - finish { specular bajo, reflection mínima }
//
// SUBSURFACE SCATTERING (Simulado):
// finish {
//   brilliance 2-5    // Mayor = más SSS
//   diffuse 0.6-0.9
// }
//
// PARÁMETROS DE CALIDAD:
//
// Línea de comandos:
// +W1920 +H1080      // Resolución Full HD
// +A0.3              // Antialiasing threshold
// +R3                // Recursión de reflexión
// +Q11               // Máxima calidad
// +AM2               // Antialiasing mode 2
// +J                 // Jitter antialiasing
//
// OPTIMIZACIÓN:
//
// - Photons: spacing 0.01-0.005 (menor = mejor pero más lento)
// - Area lights: 5x5 a 10x10 samples
// - Radiosity: count 100-200
// - Depth of field: blur_samples 20-50
// - max_trace_level: 10-20 (para múltiples reflexiones/refracciones)
//
// ILUMINACIÓN FOTOGRÁFICA:
//
// Setup de 3 puntos (ver ejemplo 09):
// - Key: area_light, brillante
// - Fill: más suave, shadowless
// - Rim: desde atrás, spotlight
//
// Setup de estudio:
// - 2-4 area lights grandes
// - Softboxes simulados (area_light rectangular)
// - Reflectores (planos con reflection)
//
// TÉCNICAS AVANZADAS:
//
// 1. HDRI Lighting:
//    sky_sphere {
//      pigment {
//        image_map {
//          hdr "imagen.hdr"
//          map_type 1  // Esférico
//        }
//      }
//    }
//
// 2. Global Illumination:
//    - Radiosity (ver ejemplo 14)
//    - Photon mapping
//
// 3. Motion Blur:
//    Animar objeto y usar +MB en render
//
// 4. Chromatic Aberration:
//    Dispersión de colores en vidrio
//
// WORKFLOW RECOMENDADO:
//
// 1. Modelar escena básica
// 2. Iluminación básica (sin area lights ni photons)
// 3. Materiales básicos
// 4. Renders de prueba (baja resolución, sin AA)
// 5. Refinar iluminación (añadir area lights)
// 6. Refinar materiales
// 7. Añadir photons si es necesario
// 8. Añadir depth of field
// 9. Render final (alta resolución, AA, radiosity)
// ============================================================================
