// ============================================================================
// EJEMPLO 09: ILUMINACIÓN AVANZADA
// ============================================================================
// Domina técnicas avanzadas de iluminación para crear escenas más realistas
// y dramáticas.
//
// CONCEPTOS QUE APRENDERÁS:
// - Area lights (luces de área)
// - Luces con decay (atenuación)
// - Proyectores de imágenes
// - Iluminación volumétrica (light_group)
// - Técnicas de fotografía profesional
//
// CÓMO RENDERIZAR:
// povray 09-iluminacion-avanzada.pov +W800 +H600 +A
// ============================================================================

#version 3.7;

#include "colors.inc"

global_settings {
  assumed_gamma 1.0
  max_trace_level 10
}

// ----------------------------------------------------------------------------
// CÁMARA
// ----------------------------------------------------------------------------

camera {
  location <5, 6, -10>
  look_at <0, 1.5, 0>
  angle 50
}

// ----------------------------------------------------------------------------
// 1. LUZ PUNTUAL ESTÁNDAR (para comparación)
// ----------------------------------------------------------------------------

light_source {
  <-5, 8, -5>
  color White * 0.5
}

sphere {
  <-5, 8, -5>, 0.2
  pigment { color Yellow }
  finish { ambient 1 }
}

text {
  ttf "timrom.ttf" "Puntual" 0.05, 0
  scale 0.25
  translate <-5.8, 9, -5>
  pigment { color White }
  finish { ambient 0.6 diffuse 0.4 }
}

// ----------------------------------------------------------------------------
// 2. AREA LIGHT - LUZ DE ÁREA (Sombras suaves)
// ----------------------------------------------------------------------------
// Simula una fuente de luz extendida, crea sombras suaves y realistas

light_source {
  <0, 8, -3>     // Posición central
  color White * 1.2

  area_light
  <2, 0, 0>,     // Vector horizontal (ancho de la luz)
  <0, 0, 2>,     // Vector vertical (profundidad de la luz)
  5, 5           // Número de luces en cada dirección (5x5 = 25 samples)
                 // Más samples = sombras más suaves pero render más lento

  adaptive 1     // Optimización adaptativa
  jitter         // Aleatorización para suavizar
}

// Visualización del área de luz
box {
  <-1, -0.05, -1>, <1, 0.05, 1>
  pigment { color rgbf <1, 1, 0.8, 0.7> }
  finish { ambient 0.8 }
  translate <0, 8, -3>
}

text {
  ttf "timrom.ttf" "Area Light" 0.05, 0
  scale 0.25
  translate <-0.8, 9, -3>
  pigment { color White }
  finish { ambient 0.6 diffuse 0.4 }
}

// Objetos para ver las sombras
sphere {
  <0, 1, 0>, 0.8

  pigment { color rgb <0.9, 0.3, 0.3> }

  finish {
    ambient 0.1
    diffuse 0.7
    phong 0.8
  }
}

box {
  <-0.5, 0, -0.5>, <0.5, 0.3, 0.5>

  pigment { color rgb <0.3, 0.7, 0.9> }

  finish {
    ambient 0.1
    diffuse 0.7
    phong 0.5
  }

  translate <2, 0, 1>
}

// ----------------------------------------------------------------------------
// 3. LUZ CON DECAY (Atenuación con la distancia)
// ----------------------------------------------------------------------------
// La luz se atenúa de forma realista con la distancia

light_source {
  <5, 3, -5>
  color White * 3  // Intensidad alta porque se atenuará

  fade_distance 4  // Distancia a la que tiene intensidad completa
  fade_power 2     // Tipo de atenuación (2 = realista, inverso del cuadrado)
                   // 1 = lineal, 2 = cuadrático (físicamente correcto)
}

sphere {
  <5, 3, -5>, 0.15
  pigment { color rgb <1, 0.8, 0.5> }
  finish { ambient 1 }
}

text {
  ttf "timrom.ttf" "Fade" 0.05, 0
  scale 0.25
  translate <4.7, 3.8, -5>
  pigment { color White }
  finish { ambient 0.6 diffuse 0.4 }
}

// Esferas a diferentes distancias para ver el fade
sphere {
  <4, 1, -3.5>, 0.3
  pigment { color White }
  finish { ambient 0.05 diffuse 0.8 }
}

sphere {
  <5, 1, -4.5>, 0.3
  pigment { color White }
  finish { ambient 0.05 diffuse 0.8 }
}

sphere {
  <6, 1, -5.5>, 0.3
  pigment { color White }
  finish { ambient 0.05 diffuse 0.8 }
}

// ----------------------------------------------------------------------------
// 4. SPOTLIGHT CON PARÁMETROS AVANZADOS
// ----------------------------------------------------------------------------

light_source {
  <-3, 5, 2>
  color rgb <1, 0.9, 0.7> * 2

  spotlight
  point_at <-3, 0, 3>

  radius 10          // Ángulo interno (luz completa)
  falloff 15         // Ángulo externo (transición)
  tightness 5        // Concentración del haz (0-100)

  fade_distance 5
  fade_power 1
}

// Visualizar la dirección del spotlight
cone {
  <0, 0, 0>, 0.1
  <0, -1, 0>, 0
  pigment { color Yellow }
  finish { ambient 0.8 }
  scale 0.5
  translate <-3, 5, 2>
}

text {
  ttf "timrom.ttf" "Spot" 0.05, 0
  scale 0.25
  translate <-3.5, 5.7, 2>
  pigment { color White }
  finish { ambient 0.6 diffuse 0.4 }
}

// Objeto iluminado por el spotlight
torus {
  0.5, 0.15
  pigment { color rgb <0.9, 0.7, 0.2> }
  finish { ambient 0.05 diffuse 0.8 phong 0.8 metallic }
  rotate <90, 0, 0>
  translate <-3, 0.15, 3>
}

// ----------------------------------------------------------------------------
// 5. ILUMINACIÓN FOTOGRÁFICA DE 3 PUNTOS
// ----------------------------------------------------------------------------

// Setup de 3 puntos clásico en el lado derecho de la escena

#declare ObjetoFoto = sphere {
  <0, 0, 0>, 0.6
  pigment { color rgb <0.8, 0.8, 0.9> }
  finish {
    ambient 0.05
    diffuse 0.7
    phong 0.9
    phong_size 60
  }
}

// Objeto principal
object {
  ObjetoFoto
  translate <3, 1.5, 3>
}

// KEY LIGHT (Luz principal) - Más brillante, 45° del sujeto
light_source {
  <5, 4, 1>
  color White * 1.5

  area_light <0.5, 0, 0>, <0, 0.5, 0>, 3, 3
  adaptive 1
  jitter
}

// FILL LIGHT (Luz de relleno) - Opuesta, más suave
light_source {
  <1, 3, 4>
  color White * 0.6
  shadowless  // No añade sombras adicionales
}

// BACK/RIM LIGHT (Luz de contorno) - Desde atrás
light_source {
  <3, 3, 6>
  color rgb <1, 0.95, 0.9> * 0.8

  spotlight
  point_at <3, 1.5, 3>
  radius 20
  falloff 30
}

text {
  ttf "timrom.ttf" "3-Point Lighting" 0.05, 0
  scale 0.22
  translate <2, 3, 3>
  pigment { color White }
  finish { ambient 0.6 diffuse 0.4 }
}

// ----------------------------------------------------------------------------
// 6. LUZ CILÍNDRICA (Efecto de neón)
// ----------------------------------------------------------------------------

light_source {
  <-6, 2, 0>
  color rgb <0, 0.8, 1> * 0.8

  cylinder
  point_at <-6, 2, 2>
  radius 0.3
  falloff 0.5
  tightness 0
}

// Visualización del cilindro de luz
cylinder {
  <-6, 2, 0>, <-6, 2, 2>, 0.1
  pigment { color rgbf <0, 0.8, 1, 0.5> }
  finish { ambient 0.9 }
}

text {
  ttf "timrom.ttf" "Cilindro" 0.05, 0
  scale 0.22
  translate <-6.8, 3, 1>
  pigment { color White }
  finish { ambient 0.6 diffuse 0.4 }
}

// ----------------------------------------------------------------------------
// 7. PARALLEL LIGHT (Luz paralela - como el sol)
// ----------------------------------------------------------------------------

light_source {
  <100, 150, -100>  // Muy lejos
  color rgb <1, 1, 0.95> * 0.7

  parallel          // Rayos paralelos
  point_at <0, 0, 0>
}

text {
  ttf "timrom.ttf" "Sol (parallel)" 0.05, 0
  scale 0.22
  translate <-2, 8.5, 0>
  pigment { color Yellow }
  finish { ambient 0.8 diffuse 0.3 }
}

// ----------------------------------------------------------------------------
// PLANO DE SUELO
// ----------------------------------------------------------------------------

plane {
  <0, 1, 0>, 0

  pigment {
    checker
    color rgb <0.95, 0.95, 0.95>
    color rgb <0.7, 0.7, 0.7>
    scale 0.5
  }

  finish {
    ambient 0.1
    diffuse 0.7
    reflection 0.05
  }
}

// ----------------------------------------------------------------------------
// PARED DE FONDO
// ----------------------------------------------------------------------------

plane {
  <0, 0, 1>, 7

  pigment {
    gradient y
    color_map {
      [0.0 color rgb <0.4, 0.4, 0.5>]
      [1.0 color rgb <0.6, 0.6, 0.7>]
    }
    scale 10
  }

  finish {
    ambient 0.2
    diffuse 0.6
  }
}

// ----------------------------------------------------------------------------
// FONDO
// ----------------------------------------------------------------------------

background { color rgb <0.2, 0.2, 0.3> }

// ============================================================================
// EJERCICIOS PARA PRACTICAR:
// ============================================================================
// 1. AREA LIGHT:
//    - Cambia el número de samples (3,3 vs 10,10)
//    - Observa el tiempo de render y calidad de sombras
//    - Prueba sin 'adaptive' y sin 'jitter'
//
// 2. FADE/ATENUACIÓN:
//    - Experimenta con fade_power (1, 2, 3)
//    - Ajusta fade_distance
//    - Combina fade con spotlight
//
// 3. SPOTLIGHT:
//    - Ajusta radius y falloff
//    - Cambia tightness de 0 a 100
//    - Crea un efecto de linterna
//
// 4. ESQUEMA DE 3 PUNTOS:
//    - Recrea el setup en tu propia escena
//    - Experimenta con las intensidades relativas
//    - Prueba diferentes colores para cada luz
//
// 5. COLORES DE LUZ:
//    - Luz cálida: rgb <1, 0.9, 0.7>
//    - Luz fría: rgb <0.7, 0.8, 1>
//    - Combina luces de diferentes temperaturas
//
// 6. PROYECTO: BODEGÓN
//    - Crea una escena de objetos (frutas, jarrones)
//    - Usa area light principal
//    - Añade luces de relleno y contorno
//    - Experimenta con la atenuación
//
// 7. PROYECTO: ESCENA NOCTURNA
//    - Usa luces con fade_power
//    - Simula farolas con spotlights
//    - Añade luz de luna (parallel light azulada)
//    - Usa ambient bajo (0.05 o menos)
// ============================================================================

// ============================================================================
// REFERENCIA DE ILUMINACIÓN:
// ============================================================================
//
// TIPOS DE LUCES:
//
// 1. POINT LIGHT (Puntual - default):
//    light_source { <x,y,z> color Color }
//
// 2. SPOTLIGHT (Foco):
//    light_source {
//      <pos> color Color
//      spotlight
//      point_at <target>
//      radius N      // Ángulo interno
//      falloff N     // Ángulo externo
//      tightness N   // Concentración (0-100)
//    }
//
// 3. AREA LIGHT (Luz de área):
//    light_source {
//      <pos> color Color
//      area_light <v1>, <v2>, nx, ny
//      adaptive N
//      jitter
//    }
//    - Sombras suaves
//    - Más realista
//    - Más lento
//
// 4. CYLINDRICAL LIGHT (Cilíndrica):
//    light_source {
//      <pos> color Color
//      cylinder
//      point_at <target>
//      radius N
//      falloff N
//    }
//
// 5. PARALLEL LIGHT (Paralela):
//    light_source {
//      <pos-lejana> color Color
//      parallel
//      point_at <centro-escena>
//    }
//    - Simula luz solar
//    - Rayos paralelos
//
// ATENUACIÓN:
//
// fade_distance N    // Distancia de intensidad completa
// fade_power N       // Tipo de decay
//                    // 1 = lineal
//                    // 2 = inverso del cuadrado (realista)
//                    // 3 = cúbico
//
// MODIFICADORES:
//
// shadowless         // No genera sombras
// looks_like { }     // Asociar geometría visible
// projected_through  // Proyectar a través de objetos
//
// ILUMINACIÓN CLÁSICA DE 3 PUNTOS:
//
// 1. KEY LIGHT:
//    - Principal y más brillante
//    - 45° del sujeto
//    - Intensidad: 100%
//
// 2. FILL LIGHT:
//    - Lado opuesto a la key
//    - Suaviza sombras
//    - Intensidad: 30-50%
//    - shadowless
//
// 3. BACK/RIM LIGHT:
//    - Detrás del sujeto
//    - Separa del fondo
//    - Intensidad: 50-80%
//    - Puede ser spotlight
//
// TEMPERATURAS DE COLOR:
//
// - Sol directo: rgb <1, 1, 0.95>
// - Cielo nublado: rgb <0.8, 0.9, 1>
// - Tungsteno/Incandescente: rgb <1, 0.8, 0.6>
// - Fluorescente: rgb <0.9, 1, 0.95>
// - Vela: rgb <1, 0.7, 0.4>
// - Atardecer: rgb <1, 0.6, 0.3>
// - Luna: rgb <0.7, 0.8, 1>
//
// OPTIMIZACIÓN:
//
// - Area lights: usar adaptive y valores bajos de nx,ny inicialmente
// - Usar shadowless en luces de relleno
// - fade_power aumenta el tiempo de render
// - Más luces = más tiempo de render
// ============================================================================
