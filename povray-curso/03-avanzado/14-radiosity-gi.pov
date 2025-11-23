// ============================================================================
// EJEMPLO 14: RADIOSITY - ILUMINACIÓN GLOBAL (Global Illumination)
// ============================================================================
// Radiosity simula cómo la luz rebota entre superficies, creando iluminación
// indirecta realista sin necesidad de múltiples luces artificiales.
//
// CONCEPTOS QUE APRENDERÁS:
// - Qué es radiosity y cómo funciona
// - Configuración de radiosity
// - Parámetros y su impacto
// - Color bleeding (transferencia de color)
// - Optimización de radiosity
//
// CÓMO RENDERIZAR:
// povray 14-radiosity-gi.pov +W800 +H600 +A0.3
//
// ADVERTENCIA: Radiosity puede ser lento. Prueba primero en baja resolución.
// ============================================================================

#version 3.7;

#include "colors.inc"
#include "textures.inc"

global_settings {
  assumed_gamma 1.0
  max_trace_level 10

  // ========================================================================
  // RADIOSITY - Configuración de Iluminación Global
  // ========================================================================

  radiosity {
    // ------------------------------------------------------------------
    // CALIDAD BÁSICA (rápido, para pruebas)
    // ------------------------------------------------------------------
    // pretrace_start 0.08
    // pretrace_end 0.02
    // count 50
    // error_bound 0.5
    // recursion_limit 1

    // ------------------------------------------------------------------
    // CALIDAD MEDIA (balance velocidad/calidad)
    // ------------------------------------------------------------------
    pretrace_start 0.08  // Tamaño inicial de pretrace (8%)
    pretrace_end 0.01    // Tamaño final de pretrace (1%)
    count 100            // Rayos por muestra (más = mejor, más lento)
    error_bound 0.3      // Error permitido (menor = mejor, más lento)
    recursion_limit 2    // Rebotes de luz indirecta

    // ------------------------------------------------------------------
    // CALIDAD ALTA (lento, render final)
    // ------------------------------------------------------------------
    // pretrace_start 0.08
    // pretrace_end 0.005
    // count 200
    // nearest_count 10
    // error_bound 0.15
    // recursion_limit 3
    // low_error_factor 0.3

    // ------------------------------------------------------------------
    // PARÁMETROS ADICIONALES
    // ------------------------------------------------------------------

    nearest_count 6      // Muestras cercanas a considerar
    low_error_factor 0.5 // Factor de error bajo

    gray_threshold 0.0   // Umbral de escala de grises (0 = color completo)
    minimum_reuse 0.005  // Mínima distancia de reutilización
    maximum_reuse 0.2    // Máxima distancia de reutilización

    brightness 1.0       // Multiplicador de brillo
    adc_bailout 0.01     // Bailout de contribución mínima

    normal on            // Considerar normales
    media off            // No calcular para media (más rápido)

    // Opcional: guardar/cargar radiosity pre-calculado
    // save_file "radiosity.dat"
    // load_file "radiosity.dat"
    // always_sample off  // Usar solo datos cargados
  }
}

// ----------------------------------------------------------------------------
// CÁMARA
// ----------------------------------------------------------------------------

camera {
  location <6, 5, -10>
  look_at <0, 2, 0>
  angle 50
}

// ----------------------------------------------------------------------------
// ILUMINACIÓN
// ----------------------------------------------------------------------------

// CON RADIOSITY, necesitamos menos luces artificiales
// La luz rebota naturalmente entre superficies

// Luz principal (sol entrando por ventana)
light_source {
  <-5, 10, -5>
  color rgb <1, 0.98, 0.95> * 1.5  // Luz diurna cálida

  area_light <1.5, 0, 0>, <0, 1.5, 0>, 5, 5
  adaptive 2
  jitter
}

// Luz ambiental suave (simula cielo)
light_source {
  <0, 100, 0>
  color rgb <0.7, 0.8, 1> * 0.3
  shadowless
}

// ============================================================================
// DEMOSTRACIÓN: CORNELL BOX
// ============================================================================
// El Cornell Box es perfecto para demostrar radiosity porque muestra
// claramente el color bleeding (transferencia de color entre superficies)

// Materiales base para el Cornell Box
#declare FinishDifuso = finish {
  ambient 0         // IMPORTANTE: ambient debe ser 0 con radiosity
  diffuse 0.8       // Alta difusión para radiosity
  specular 0
}

// ----------------------------------------------------------------------------
// PARED IZQUIERDA (ROJA) - Transferirá color rojo a objetos cercanos
// ----------------------------------------------------------------------------

box {
  <-5, 0, -5>, <-4.9, 10, 5>

  pigment { color rgb <0.9, 0.1, 0.1> }  // Rojo brillante
  finish { FinishDifuso }
}

text {
  ttf "timrom.ttf" "Pared Roja" 0.05, 0
  scale 0.3
  rotate <0, 90, 0>
  translate <-4.85, 6, 0>
  pigment { color White }
  finish { ambient 0.5 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// PARED DERECHA (VERDE) - Transferirá color verde
// ----------------------------------------------------------------------------

box {
  <4.9, 0, -5>, <5, 10, 5>

  pigment { color rgb <0.1, 0.9, 0.1> }  // Verde brillante
  finish { FinishDifuso }
}

text {
  ttf "timrom.ttf" "Pared Verde" 0.05, 0
  scale 0.3
  rotate <0, -90, 0>
  translate <4.85, 6, 0>
  pigment { color White }
  finish { ambient 0.5 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// PARED TRASERA (BLANCA)
// ----------------------------------------------------------------------------

box {
  <-5, 0, 4.9>, <5, 10, 5>

  pigment { color rgb <0.9, 0.9, 0.9> }
  finish { FinishDifuso }
}

// ----------------------------------------------------------------------------
// SUELO (BLANCO)
// ----------------------------------------------------------------------------

box {
  <-5, 0, -5>, <5, 0.1, 5>

  pigment {
    checker
    color rgb <0.95, 0.95, 0.95>
    color rgb <0.85, 0.85, 0.85>
    scale 0.5
  }

  finish { FinishDifuso }
}

// ----------------------------------------------------------------------------
// TECHO (BLANCO)
// ----------------------------------------------------------------------------

box {
  <-5, 9.9, -5>, <5, 10, 5>

  pigment { color rgb <0.9, 0.9, 0.9> }
  finish { FinishDifuso }
}

// ----------------------------------------------------------------------------
// OBJETOS EN LA ESCENA
// ----------------------------------------------------------------------------
// Estos objetos mostrarán color bleeding de las paredes

// Caja grande (izquierda) - Mostrará tinte rojo
box {
  <-2.5, 0, 0>, <-0.5, 3, 2>

  pigment { color rgb <0.95, 0.95, 0.95> }  // Blanco (recibirá color)
  finish { FinishDifuso }

  rotate <0, -20, 0>
  translate <-1, 0.1, 1>
}

// Caja pequeña (derecha) - Mostrará tinte verde
box {
  <0, 0, 0>, <1.8, 1.5, 1.8>

  pigment { color rgb <0.95, 0.95, 0.95> }  // Blanco (recibirá color)
  finish { FinishDifuso }

  rotate <0, 18, 0>
  translate <1.5, 0.1, -1>
}

// Esfera central - Mostrará mezcla de colores
sphere {
  <0, 1.5, 0>, 1

  pigment { color rgb <0.95, 0.95, 0.95> }  // Blanco
  finish {
    ambient 0
    diffuse 0.8
    specular 0.3
    roughness 0.05
  }
}

// Esfera reflectante - Mostrará el environment en reflexiones
sphere {
  <2, 0.7, 2>, 0.6

  pigment { color rgb <0.9, 0.9, 0.9> }

  finish {
    ambient 0
    diffuse 0.2
    specular 0.9
    roughness 0.001
    reflection { 0.9 }
  }
}

// ============================================================================
// COMPARACIÓN: Área con y sin radiosity visible
// ============================================================================

#declare MostrarComparacion = no;  // Cambiar a 'yes' para ver comparación

#if (MostrarComparacion)
  // Esfera sin radiosity (usando ambient alto)
  sphere {
    <-3, 1, -3>, 0.5

    pigment { color rgb <0.8, 0.8, 0.8> }

    finish {
      ambient 0.6    // Alto ambient (como renderizar sin radiosity)
      diffuse 0.4
    }
  }

  text {
    ttf "timrom.ttf" "Sin Radiosity" 0.05, 0
    scale 0.2
    translate <-3.8, 2, -3>
    pigment { color White }
    finish { ambient 0.7 }
  }

  // Esfera con radiosity (ambient = 0)
  sphere {
    <3, 1, -3>, 0.5

    pigment { color rgb <0.8, 0.8, 0.8> }

    finish {
      ambient 0      // Ambient = 0 para radiosity
      diffuse 0.8
    }
  }

  text {
    ttf "timrom.ttf" "Con Radiosity" 0.05, 0
    scale 0.2
    translate <2.2, 2, -3>
    pigment { color White }
    finish { ambient 0.7 }
  }
#end

// ============================================================================
// DIFERENTES SUPERFICIES Y RADIOSITY
// ============================================================================

// Superficie muy difusa (recibe mucha luz indirecta)
box {
  <-4, 0.1, -4>, <-3, 0.8, -3>

  pigment { color rgb <0.6, 0.4, 0.2> }

  finish {
    ambient 0
    diffuse 0.95   // Muy difuso
    specular 0
  }
}

// Superficie con specular (combina directa e indirecta)
box {
  <3, 0.1, -4>, <4, 0.8, -3>

  pigment { color rgb <0.2, 0.4, 0.8> }

  finish {
    ambient 0
    diffuse 0.7
    specular 0.6
    roughness 0.02
  }
}

// ============================================================================
// EJEMPLO DE INTERIOR ILUMINADO POR RADIOSITY
// ============================================================================

// Habitación pequeña adicional (opcional, comentada para simplicidad)
/*
union {
  // Paredes
  difference {
    box { <0, 0, 0>, <3, 2.5, 3> }
    box { <0.1, 0, 0.1>, <2.9, 2.6, 2.9> }
  }

  pigment { color rgb <0.8, 0.7, 0.6> }
  finish {
    ambient 0
    diffuse 0.8
  }

  translate <6, 0, -3>
}

// Ventana (fuente de luz)
box {
  <6.1, 1.5, -1>, <6.05, 2.3, 0>
  pigment { color rgb <0.9, 0.95, 1> }
  finish { ambient 1 diffuse 0 }  // Emisiva
}
*/

// ----------------------------------------------------------------------------
// FONDO
// ----------------------------------------------------------------------------

background { color rgb <0.1, 0.1, 0.15> }

// ============================================================================
// EJERCICIOS PARA PRACTICAR:
// ============================================================================
// 1. PARÁMETROS DE RADIOSITY:
//    - Cambia error_bound (0.1, 0.5, 1.0) y observa calidad/velocidad
//    - Ajusta count (50, 100, 200) para ver diferencia
//    - Experimenta con recursion_limit (1, 2, 3)
//
// 2. COLOR BLEEDING:
//    - Cambia los colores de las paredes
//    - Añade más paredes de colores
//    - Observa cómo afecta a los objetos blancos
//
// 3. AMBIENT vs RADIOSITY:
//    - Renderiza con radiosity (ambient 0)
//    - Renderiza sin radiosity (ambient 0.2-0.5)
//    - Compara resultados
//
// 4. OPTIMIZACIÓN:
//    - Usa save_file para guardar cálculos
//    - Renderiza con load_file para reutilizar
//    - Compara tiempos de render
//
// 5. PROYECTO: INTERIOR REALISTA
//    - Crea una habitación completa
//    - Una ventana como fuente principal de luz
//    - Muebles que reciban luz indirecta
//    - Paredes de colores para color bleeding
//
// 6. PROYECTO: GALERÍA DE ARTE
//    - Habitación con cuadros iluminados
//    - Luz indirecta en paredes
//    - Suelo reflectante mostrando radiosity
//
// COMANDOS DE RENDERIZADO:
// Prueba rápida:
// povray 14-radiosity-gi.pov +W320 +H240
//
// Calidad media:
// povray 14-radiosity-gi.pov +W800 +H600 +A0.3
//
// Alta calidad:
// povray 14-radiosity-gi.pov +W1920 +H1080 +A0.1 +AM2 +R4
// ============================================================================

// ============================================================================
// REFERENCIA DE RADIOSITY:
// ============================================================================
//
// ¿QUÉ ES RADIOSITY?
// - Simula iluminación global (Global Illumination)
// - Calcula cómo la luz rebota entre superficies
// - Produce iluminación indirecta realista
// - Muestra color bleeding (transferencia de color)
//
// CONFIGURACIÓN BÁSICA:
//
// global_settings {
//   radiosity {
//     pretrace_start N    // Inicio de pretrace (0.08 típico)
//     pretrace_end N      // Fin de pretrace (0.01-0.005)
//     count N             // Rayos por muestra (50-200)
//     error_bound N       // Error permitido (0.1-1.0)
//     recursion_limit N   // Rebotes (1-3)
//   }
// }
//
// PARÁMETROS PRINCIPALES:
//
// 1. pretrace_start / pretrace_end:
//    - Tamaño de muestreo inicial y final
//    - Valores típicos: 0.08 a 0.005
//    - Menor = más preciso pero más lento
//
// 2. count:
//    - Número de rayos por muestra
//    - Valores: 50 (rápido) a 200+ (calidad)
//    - Mayor = menos ruido pero más lento
//
// 3. error_bound:
//    - Error máximo permitido
//    - 0.1 = alta calidad
//    - 0.5 = media calidad
//    - 1.0 = baja calidad (rápido)
//
// 4. recursion_limit:
//    - Número de rebotes de luz
//    - 1 = un rebote (rápido)
//    - 2 = dos rebotes (balance)
//    - 3+ = múltiples rebotes (lento)
//
// 5. nearest_count:
//    - Muestras cercanas a promediar
//    - Típico: 4-10
//    - Mayor = más suave pero puede difuminar detalles
//
// PARÁMETROS AVANZADOS:
//
// gray_threshold N:
//    - 0.0 = color completo
//    - 1.0 = escala de grises (más rápido)
//
// low_error_factor N:
//    - Factor de error bajo (0.1-1.0)
//    - Menor = mejor en áreas oscuras
//
// minimum_reuse N:
//    - Distancia mínima de reutilización
//    - Típico: 0.005-0.015
//
// maximum_reuse N:
//    - Distancia máxima de reutilización
//    - Típico: 0.1-0.2
//
// brightness N:
//    - Multiplicador de brillo
//    - Típico: 0.8-1.2
//
// adc_bailout N:
//    - Umbral de contribución mínima
//    - Típico: 0.001-0.01
//
// GUARDAR/CARGAR:
//
// save_file "radiosity.rad":
//    - Guarda cálculos de radiosity
//
// load_file "radiosity.rad":
//    - Carga cálculos pre-calculados
//
// always_sample on/off:
//    - off: usa solo datos cargados
//    - on: calcula y usa archivo (default)
//
// IMPORTANTE CON RADIOSITY:
//
// 1. ambient DEBE SER 0:
//    finish {
//      ambient 0      // CRÍTICO
//      diffuse 0.8
//    }
//
// 2. Usar area_light cuando sea posible:
//    - Produce sombras más suaves
//    - Mejor interacción con radiosity
//
// 3. max_trace_level alto:
//    - Mínimo 10 para buenos resultados
//    - 15-20 para escenas complejas
//
// 4. assumed_gamma 1.0:
//    - Importante para color correcto
//
// PERFILES DE CALIDAD:
//
// CALIDAD BAJA (Pruebas rápidas):
// radiosity {
//   pretrace_start 0.08
//   pretrace_end 0.02
//   count 50
//   error_bound 0.5
//   recursion_limit 1
// }
//
// CALIDAD MEDIA (Trabajo general):
// radiosity {
//   pretrace_start 0.08
//   pretrace_end 0.01
//   count 100
//   nearest_count 6
//   error_bound 0.3
//   recursion_limit 2
//   low_error_factor 0.5
// }
//
// CALIDAD ALTA (Render final):
// radiosity {
//   pretrace_start 0.08
//   pretrace_end 0.005
//   count 200
//   nearest_count 10
//   error_bound 0.15
//   recursion_limit 3
//   low_error_factor 0.3
//   brightness 1.0
// }
//
// CALIDAD ULTRA (Producción):
// radiosity {
//   pretrace_start 0.08
//   pretrace_end 0.002
//   count 300
//   nearest_count 15
//   error_bound 0.1
//   recursion_limit 3
//   low_error_factor 0.2
//   minimum_reuse 0.003
//   maximum_reuse 0.1
// }
//
// TROUBLESHOOTING:
//
// Manchas oscuras/claras:
//    - Aumentar count
//    - Reducir error_bound
//    - Ajustar minimum_reuse
//
// Render muy lento:
//    - Aumentar error_bound
//    - Reducir count
//    - Reducir recursion_limit
//    - Usar save_file/load_file
//
// Color bleeding excesivo:
//    - Reducir brightness
//    - Ajustar diffuse en superficies
//
// Sombras demasiado oscuras:
//    - Verificar ambient = 0
//    - Aumentar recursion_limit
//    - Añadir luz de relleno suave
//
// WORKFLOW RECOMENDADO:
//
// 1. Crear escena básica
// 2. Render con radiosity baja (error_bound 0.5)
// 3. Ajustar iluminación
// 4. Render con radiosity media
// 5. Afinar materiales
// 6. save_file de radiosity media
// 7. Render final con radiosity alta usando load_file
// 8. Ajustes finales si es necesario
// ============================================================================
