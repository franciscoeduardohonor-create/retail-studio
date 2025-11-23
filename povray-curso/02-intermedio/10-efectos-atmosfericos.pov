// ============================================================================
// EJEMPLO 10: EFECTOS ATMOSFÉRICOS - Niebla y Medios
// ============================================================================
// Aprende a crear efectos atmosféricos realistas como niebla, humo, rayos
// de luz volumétrica y otros efectos de medios participantes.
//
// CONCEPTOS QUE APRENDERÁS:
// - Fog (niebla básica)
// - Media (medios participantes)
// - Scattering (dispersión de luz)
// - Rayos de luz volumétricos (god rays)
// - Humo y nubes
//
// CÓMO RENDERIZAR:
// povray 10-efectos-atmosfericos.pov +W800 +H600 +A
// ============================================================================

#version 3.7;

#include "colors.inc"

global_settings {
  assumed_gamma 1.0
  max_trace_level 10

  // Radiosity para iluminación más realista (opcional pero recomendado)
  radiosity {
    pretrace_start 0.08
    pretrace_end 0.01
    count 50
    error_bound 0.5
    recursion_limit 1
  }
}

// ----------------------------------------------------------------------------
// CÁMARA
// ----------------------------------------------------------------------------

camera {
  location <0, 3, -12>
  look_at <0, 2, 0>
  angle 55
}

// ----------------------------------------------------------------------------
// LUCES
// ----------------------------------------------------------------------------

light_source {
  <5, 10, -8>
  color White * 1.5
}

light_source {
  <-3, 6, -5>
  color rgb <0.9, 0.95, 1> * 0.6
  shadowless
}

// Luz volumétrica para rayos de dios
light_source {
  <-5, 8, 2>
  color White * 0.8

  spotlight
  point_at <0, 0, 2>
  radius 15
  falloff 20

  // Esta luz interactuará con el media
}

// ----------------------------------------------------------------------------
// 1. FOG BÁSICO (Niebla de distancia)
// ----------------------------------------------------------------------------
// La niebla más simple, basada en la distancia desde la cámara

fog {
  fog_type 1         // Tipo 1: niebla de distancia (ground fog)
                     // Tipo 2: niebla de altura (layered fog)

  distance 20        // Distancia a la que la niebla es al 36.8%
  color rgb <0.7, 0.8, 0.9>  // Color de la niebla

  // A mayor distancia, más niebla
  // Los objetos lejanos se mezclan con este color
}

// ----------------------------------------------------------------------------
// 2. FOG DE ALTURA (Ground fog)
// ----------------------------------------------------------------------------
// Niebla que se concentra cerca del suelo

fog {
  fog_type 2         // Tipo 2: basado en altura Y

  distance 15
  color rgb <0.9, 0.95, 1>

  fog_offset 0       // Altura donde empieza la niebla
  fog_alt 3          // Altura a la que la densidad cae a 36.8%

  // La niebla es más densa cerca del suelo
}

// ----------------------------------------------------------------------------
// 3. CONTENEDOR CON MEDIA (Para efectos volumétricos)
// ----------------------------------------------------------------------------
// Los efectos de media necesitan estar dentro de un contenedor

// Esfera con humo/niebla interna
sphere {
  <-4, 2, 3>, 1.5

  pigment { rgbf 1 }  // Completamente transparente (solo media visible)

  interior {
    media {
      scattering { 1, rgb <0.8, 0.8, 0.9> * 0.5 }  // Tipo 1 = isotropic
                                                     // Color y densidad

      samples 10     // Número de samples (10-100)
                     // Más = mejor calidad, más lento

      intervals 1    // Número de intervalos
      // method 3    // Método de cálculo (1, 2, 3)
    }
  }

  hollow  // IMPORTANTE: necesario para media
}

text {
  ttf "timrom.ttf" "Media basico" 0.05, 0
  scale 0.25
  translate <-5, 4.5, 3>
  pigment { color White }
  finish { ambient 0.6 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// 4. MEDIA CON PATRÓN (Humo no uniforme)
// ----------------------------------------------------------------------------

sphere {
  <0, 2, 3>, 1.5

  pigment { rgbf 1 }

  interior {
    media {
      scattering { 1, rgb <0.6, 0.6, 0.7> * 0.3 }

      density {
        bozo         // Patrón procedural para variación
        turbulence 0.6

        density_map {
          [0.0 rgb 0]      // Sin densidad
          [0.3 rgb 0.2]    // Baja densidad
          [0.7 rgb 0.8]    // Alta densidad
          [1.0 rgb 1]      // Máxima densidad
        }

        scale 0.5
      }

      samples 20
      intervals 1
    }
  }

  hollow
}

text {
  ttf "timrom.ttf" "Humo" 0.05, 0
  scale 0.25
  translate <-0.5, 4.5, 3>
  pigment { color White }
  finish { ambient 0.6 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// 5. RAYOS VOLUMÉTRICOS (God rays)
// ----------------------------------------------------------------------------

box {
  <-2, 0, 0>, <2, 4, 4>

  pigment { rgbf 1 }

  interior {
    media {
      scattering { 1, rgb <1, 0.98, 0.95> * 0.08 }

      samples 30, 50  // Mínimo y máximo de samples
      intervals 1
      method 3        // Método adaptativo
    }
  }

  hollow

  translate <4, 0, 1>
}

text {
  ttf "timrom.ttf" "Volumetric light" 0.05, 0
  scale 0.22
  translate <3, 4.5, 1>
  pigment { color White }
  finish { ambient 0.6 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// 6. MEDIA EMISIVO (Objeto que emite luz)
// ----------------------------------------------------------------------------

sphere {
  <-4, 1.5, -1>, 0.8

  pigment { rgbf 1 }

  interior {
    media {
      emission rgb <1, 0.5, 0.2> * 2  // Emite luz naranja

      density {
        spherical    // Más denso en el centro
        scale 0.8
      }

      samples 15
    }
  }

  hollow
}

text {
  ttf "timrom.ttf" "Emisivo" 0.05, 0
  scale 0.25
  translate <-4.6, 3, -1>
  pigment { color White }
  finish { ambient 0.6 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// 7. LLAMA/FUEGO
// ----------------------------------------------------------------------------

sphere {
  <0, 1.5, -1>, 0.7

  pigment { rgbf 1 }

  interior {
    media {
      emission rgb <1, 0.6, 0.1> * 3
      scattering { 1, rgb <1, 0.3, 0.1> * 0.5 }

      density {
        wrinkles
        turbulence 0.8

        density_map {
          [0.0 rgb 0]
          [0.3 rgb <0.3, 0.15, 0>]
          [0.6 rgb <0.8, 0.4, 0>]
          [1.0 rgb <1, 0.8, 0.2>]
        }

        scale 0.4
      }

      samples 25
      method 3
    }
  }

  hollow
  scale <0.8, 1.2, 0.8>  // Estirar verticalmente
}

text {
  ttf "timrom.ttf" "Fuego" 0.05, 0
  scale 0.25
  translate <-0.5, 3, -1>
  pigment { color White }
  finish { ambient 0.6 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// 8. AGUA TURBIA/NEBULOSA
// ----------------------------------------------------------------------------

cylinder {
  <4, 0, -1>, <4, 2, -1>, 0.8

  pigment { rgbf <0.2, 0.4, 0.6, 0.7> }  // Azul semi-transparente

  interior {
    media {
      scattering { 1, rgb <0.3, 0.5, 0.7> * 0.2 }

      density {
        granite
        turbulence 0.3
        scale 0.2
      }

      samples 15
    }

    ior 1.33  // Índice de refracción del agua
  }

  finish {
    phong 0.6
    reflection { 0.1, 0.3 fresnel on }
  }

  hollow
}

text {
  ttf "timrom.ttf" "Agua turbia" 0.05, 0
  scale 0.22
  translate <3.2, 3, -1>
  pigment { color White }
  finish { ambient 0.6 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// 9. NUBE VOLUMÉTRICA
// ----------------------------------------------------------------------------

sphere {
  <-2, 5, 0>, 1.2

  pigment { rgbf 1 }

  interior {
    media {
      scattering { 1, rgb <1, 1, 1> * 1.5 }

      density {
        bozo
        turbulence 1

        density_map {
          [0.0 rgb 0]
          [0.2 rgb 0.1]
          [0.5 rgb 0.5]
          [0.8 rgb 0.9]
          [1.0 rgb 1]
        }

        scale 0.6
      }

      samples 30
      method 3
    }
  }

  hollow
  scale <1.5, 1, 1.5>  // Aplanar un poco
}

text {
  ttf "timrom.ttf" "Nube" 0.05, 0
  scale 0.25
  translate <-2.4, 6.8, 0>
  pigment { color White }
  finish { ambient 0.6 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// OBJETOS DE DEMOSTRACIÓN
// ----------------------------------------------------------------------------

// Esferas para ver los efectos de niebla y sombras

sphere {
  <-3, 1, 0>, 0.8
  pigment { color Red }
  finish { ambient 0.1 diffuse 0.7 phong 0.8 }
}

sphere {
  <0, 1, 5>, 0.8
  pigment { color Green }
  finish { ambient 0.1 diffuse 0.7 phong 0.8 }
}

sphere {
  <3, 1, 10>, 0.8
  pigment { color Blue }
  finish { ambient 0.1 diffuse 0.7 phong 0.8 }
}

// ----------------------------------------------------------------------------
// PLANO DE SUELO
// ----------------------------------------------------------------------------

plane {
  <0, 1, 0>, 0

  pigment {
    checker
    color rgb <0.6, 0.6, 0.6>
    color rgb <0.4, 0.4, 0.4>
    scale 1
  }

  finish {
    ambient 0.1
    diffuse 0.6
  }
}

// ----------------------------------------------------------------------------
// PARED DE FONDO
// ----------------------------------------------------------------------------

plane {
  <0, 0, 1>, 15

  pigment {
    gradient y
    color_map {
      [0.0 color rgb <0.3, 0.3, 0.4>]
      [0.5 color rgb <0.5, 0.6, 0.7>]
      [1.0 color rgb <0.6, 0.7, 0.9>]
    }
    scale 20
  }

  finish {
    ambient 0.2
    diffuse 0.5
  }
}

// ----------------------------------------------------------------------------
// FONDO
// ----------------------------------------------------------------------------

background { color rgb <0.5, 0.6, 0.8> }

// ============================================================================
// EJERCICIOS PARA PRACTICAR:
// ============================================================================
// 1. FOG:
//    - Ajusta 'distance' (5, 10, 20, 50)
//    - Cambia el color de la niebla
//    - Prueba fog_type 1 vs fog_type 2
//    - Para fog tipo 2, ajusta fog_offset y fog_alt
//
// 2. MEDIA BÁSICO:
//    - Cambia el número de 'samples' (10, 20, 50)
//    - Ajusta la densidad del scattering
//    - Prueba diferentes colores
//
// 3. PATRONES DE DENSIDAD:
//    - Experimenta con: bozo, wrinkles, granite, marble
//    - Ajusta turbulence (0.1 a 2.0)
//    - Modifica el density_map
//
// 4. TIPOS DE SCATTERING:
//    - scattering { 1, ... } - Isotropic
//    - scattering { 2, ... } - Mie (humo)
//    - scattering { 3, ... } - Rayleigh (cielo)
//    - scattering { 4, ... } - Henyey-Greenstein
//    - scattering { 5, ... } - Mezcla
//
// 5. CREAR EFECTOS:
//    - Vapor saliendo de una taza
//    - Rayo de luz entrando por una ventana
//    - Nebulosa espacial
//    - Lámpara con halo de luz
//    - Explosión
//
// 6. PROYECTO: ESCENA DE BOSQUE
//    - Usa fog tipo 2 para niebla matutina
//    - Añade rayos de luz entre árboles
//    - Media con patrón para variación
//
// 7. PROYECTO: BAJO EL AGUA
//    - Media azul con scattering
//    - Fog para limitar visibilidad
//    - Rayos de luz desde la superficie
//    - Partículas flotantes con density pattern
// ============================================================================

// ============================================================================
// REFERENCIA DE EFECTOS ATMOSFÉRICOS:
// ============================================================================
//
// FOG (Niebla):
//
// fog {
//   fog_type N        // 1 = distancia, 2 = altura
//   distance N        // Distancia característica
//   color Color       // Color de la niebla
//
//   // Solo para fog_type 2:
//   fog_offset N      // Altura de inicio
//   fog_alt N         // Altura de transición
//
//   turbulence N      // Turbulencia (opcional)
//   turb_depth N      // Profundidad de turbulencia
// }
//
// MEDIA (Medios participantes):
//
// El objeto DEBE ser:
// - hollow
// - pigment { rgbf 1 } (transparente)
//
// interior {
//   media {
//     // TIPO DE INTERACCIÓN:
//     absorption Color       // Absorbe luz
//     emission Color         // Emite luz
//     scattering { Tipo, Color [, extinction] }
//
//     // TIPOS DE SCATTERING:
//     // 1 = Isotropic (uniforme)
//     // 2 = Mie (humo, niebla)
//     // 3 = Rayleigh (atmosfera)
//     // 4 = Henyey-Greenstein (configurable)
//     // 5 = Mezcla de varios
//
//     // DENSIDAD:
//     density {
//       PatternType
//       turbulence N
//       density_map { ... }
//       color_map { ... }
//       scale N
//     }
//
//     // CALIDAD:
//     samples Min [, Max]   // Número de samples
//     intervals N           // Subdivisiones
//     method N              // 1, 2, 3 (3 = adaptativo)
//
//     // OTROS:
//     confidence N          // Precisión (default 0.9)
//     variance N            // Varianza (default 1/128)
//     ratio N               // Proporción de samples
//   }
// }
//
// DENSIDAD PATTERNS:
//
// Patterns útiles para media:
// - bozo: Nubes, humo
// - wrinkles: Llamas, turbulencia
// - granite: Textura granulada
// - marble: Vetas
// - spherical: Degradado esférico
// - cylindrical: Degradado cilíndrico
// - planar: Capas planas
//
// DENSITY_MAP:
//
// density_map {
//   [0.0 rgb 0]      // Transparente
//   [0.5 rgb 0.5]    // Semi-denso
//   [1.0 rgb 1]      // Totalmente denso
// }
//
// EFECTOS COMUNES:
//
// 1. HUMO:
//    scattering { 2, rgb 0.5 }
//    density { bozo turbulence 0.6 }
//
// 2. FUEGO:
//    emission rgb <1, 0.5, 0> * 3
//    density { wrinkles turbulence 0.8 }
//
// 3. RAYOS DE LUZ:
//    scattering { 1, rgb 0.1 }
//    samples 30
//    + spotlight con radius y falloff
//
// 4. AGUA TURBIA:
//    scattering { 1, rgb <0.3, 0.5, 0.7> * 0.3 }
//    ior 1.33
//
// 5. NUBES:
//    scattering { 1, rgb 1.5 }
//    density { bozo turbulence 1 }
//
// OPTIMIZACIÓN:
//
// - samples: empezar bajo (10-20), subir si es necesario
// - method 3 es más eficiente
// - intervals: 1 para la mayoría de casos
// - Evitar media en objetos grandes cuando sea posible
// - aa_threshold y aa_level para calidad
//
// COMBINACIONES:
//
// - Fog + Media: niebla global + efectos locales
// - Múltiples media: combinar emission + scattering
// - Media + Photons: caustics en medios
// ============================================================================
