// ============================================================================
// EJEMPLO 03: MATERIALES Y TEXTURAS
// ============================================================================
// En este ejemplo aprenderás a crear diferentes tipos de materiales y acabados
// para hacer que tus objetos se vean realistas.
//
// CONCEPTOS QUE APRENDERÁS:
// - Pigmentos (colores sólidos)
// - Acabados (finish): mate, brillante, metálico
// - Propiedades de reflexión
// - Propiedades de refracción (transparencia)
// - Materiales predefinidos
//
// CÓMO RENDERIZAR:
// povray 03-materiales-texturas.pov +W800 +H600 +A
// ============================================================================

#version 3.7;

#include "colors.inc"    // Incluye colores predefinidos
#include "textures.inc"  // Incluye texturas predefinidas

global_settings {
  assumed_gamma 1.0
}

// ----------------------------------------------------------------------------
// CÁMARA Y LUCES
// ----------------------------------------------------------------------------

camera {
  location <0, 3, -8>
  look_at <0, 1, 0>
  angle 50
}

// Luz principal
light_source {
  <5, 10, -5>
  color White
}

// Luz de relleno
light_source {
  <-3, 5, -3>
  color White * 0.3
  shadowless
}

// ----------------------------------------------------------------------------
// EJEMPLO 1: MATERIAL MATE (DIFFUSE)
// ----------------------------------------------------------------------------
// Un material que no refleja la luz de forma especular (sin brillo)

sphere {
  <-3, 1, 2>, 0.8

  pigment {
    color rgb <0.8, 0.2, 0.2>  // Rojo mate
  }

  finish {
    ambient 0.1      // Luz ambiente mínima
    diffuse 0.9      // ALTA reflexión difusa = mate
    phong 0          // SIN brillo especular
    specular 0       // SIN highlights
  }
}

// Texto flotante (para identificar)
text {
  ttf "timrom.ttf" "MATE" 0.1, 0
  scale 0.3
  translate <-3.5, 2.2, 2>
  pigment { color White }
  finish { ambient 0.5 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// EJEMPLO 2: MATERIAL BRILLANTE (PHONG)
// ----------------------------------------------------------------------------
// Un material con reflejos especulares brillantes (como plástico pulido)

sphere {
  <-1, 1, 2>, 0.8

  pigment {
    color rgb <0.2, 0.8, 0.2>  // Verde brillante
  }

  finish {
    ambient 0.1
    diffuse 0.6
    phong 1.0        // MÁXIMO brillo especular
    phong_size 80    // Brillo muy concentrado (superficie lisa)
    reflection 0.05  // Ligera reflexión (5%)
  }
}

text {
  ttf "timrom.ttf" "BRILLANTE" 0.1, 0
  scale 0.25
  translate <-1.8, 2.2, 2>
  pigment { color White }
  finish { ambient 0.5 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// EJEMPLO 3: MATERIAL METÁLICO
// ----------------------------------------------------------------------------
// Los metales tienen alta reflexión y comportamiento especular único

sphere {
  <1, 1, 2>, 0.8

  pigment {
    color rgb <0.8, 0.7, 0.3>  // Color dorado
  }

  finish {
    ambient 0.0      // Los metales no tienen luz ambiente
    diffuse 0.3      // Baja difusión
    specular 0.8     // Alto especular
    roughness 0.01   // Muy suave
    metallic         // Comportamiento metálico
    reflection {
      0.5            // 50% de reflexión
      metallic       // Reflexión metálica (afecta el color)
    }
  }
}

text {
  ttf "timrom.ttf" "METAL" 0.1, 0
  scale 0.3
  translate <0.4, 2.2, 2>
  pigment { color White }
  finish { ambient 0.5 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// EJEMPLO 4: MATERIAL TRANSPARENTE (VIDRIO)
// ----------------------------------------------------------------------------
// Material con refracción para simular vidrio o agua

sphere {
  <3, 1, 2>, 0.8

  pigment {
    color rgbf <0.9, 0.9, 1.0, 0.9>  // rgbf: el 'f' es filter (transparencia)
                                      // 0.9 de transparencia = casi transparente
  }

  finish {
    ambient 0.0
    diffuse 0.1
    specular 0.8
    roughness 0.001  // Muy suave
    reflection {
      0.1, 0.3       // Reflexión variable (Fresnel)
      fresnel on     // Reflexión tipo Fresnel (más realista)
    }
  }

  interior {
    ior 1.5          // Índice de refracción
                     // 1.0 = aire
                     // 1.33 = agua
                     // 1.5 = vidrio
                     // 2.4 = diamante
  }
}

text {
  ttf "timrom.ttf" "VIDRIO" 0.1, 0
  scale 0.3
  translate <2.3, 2.2, 2>
  pigment { color White }
  finish { ambient 0.5 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// FILA INFERIOR: MATERIALES ESPECIALES
// ----------------------------------------------------------------------------

// EJEMPLO 5: ESPEJO PERFECTO
sphere {
  <-2, 1, -1>, 0.8

  pigment {
    color rgb <0.9, 0.9, 0.9>
  }

  finish {
    ambient 0.0
    diffuse 0.1
    reflection 1.0   // 100% de reflexión = espejo perfecto
    specular 1
  }
}

text {
  ttf "timrom.ttf" "ESPEJO" 0.1, 0
  scale 0.25
  translate <-2.5, 2.2, -1>
  pigment { color White }
  finish { ambient 0.5 diffuse 0.5 }
}

// EJEMPLO 6: MATERIAL CON BRILLO VARIABLE (SPECULAR vs PHONG)
sphere {
  <0, 1, -1>, 0.8

  pigment {
    color rgb <0.8, 0.3, 0.8>  // Púrpura
  }

  // SPECULAR: Alternativa a phong (modelo diferente de brillo)
  finish {
    ambient 0.1
    diffuse 0.6
    specular 0.8     // Intensidad del brillo especular
    roughness 0.05   // Rugosidad (valores bajos = más brillante)
                     // roughness es lo opuesto a phong_size
  }
}

text {
  ttf "timrom.ttf" "SPECULAR" 0.1, 0
  scale 0.25
  translate <-0.8, 2.2, -1>
  pigment { color White }
  finish { ambient 0.5 diffuse 0.5 }
}

// EJEMPLO 7: MATERIAL TRANSLÚCIDO
sphere {
  <2, 1, -1>, 0.8

  pigment {
    color rgbt <1, 0.5, 0.3, 0.7>  // rgbt: 't' es transmit (transmisión)
                                    // Naranja translúcido
  }

  finish {
    ambient 0.0
    diffuse 0.4
    phong 0.6
    phong_size 40
  }

  interior {
    ior 1.3
  }
}

text {
  ttf "timrom.ttf" "TRANSLUCIDO" 0.1, 0
  scale 0.22
  translate <1.1, 2.2, -1>
  pigment { color White }
  finish { ambient 0.5 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// PLANO DE SUELO CON REFLEXIÓN
// ----------------------------------------------------------------------------

plane {
  <0, 1, 0>, 0

  pigment {
    checker
    color rgb <1, 1, 1>
    color rgb <0.3, 0.3, 0.3>
    scale 0.5
  }

  finish {
    ambient 0.2
    diffuse 0.6
    reflection 0.15  // El suelo refleja un 15% (ligeramente reflectante)
    phong 0.4
    phong_size 20
  }
}

// ----------------------------------------------------------------------------
// FONDO
// ----------------------------------------------------------------------------

background {
  color rgb <0.4, 0.6, 0.9>  // Azul cielo
}

// ============================================================================
// EJERCICIOS PARA PRACTICAR:
// ============================================================================
// 1. EXPERIMENTAR CON ACABADOS:
//    - Cambia phong de 0 a 1 gradualmente en la esfera mate
//    - Ajusta phong_size entre 10 y 100 en la esfera brillante
//    - Modifica la reflexión de la esfera metálica (0 a 1)
//
// 2. CREAR NUEVOS MATERIALES:
//    - Crea una esfera de mármol blanco (alta reflexión, difusión media)
//    - Crea una esfera de goma (sin brillo, alta difusión)
//    - Crea una esfera de cristal (alta transparencia, IOR 1.5)
//
// 3. TRANSPARENCIA:
//    - Cambia el valor 'f' (filter) en la esfera de vidrio
//    - Prueba diferentes valores de IOR: 1.33 (agua), 2.4 (diamante)
//    - Experimenta con 't' (transmit) vs 'f' (filter)
//
// 4. REFLEXIONES:
//    - Añade reflection a todas las esferas y observa el resultado
//    - Prueba reflection { 0.2, 0.8 } para reflexión variable
//    - Combina reflection con fresnel para realismo
//
// 5. MATERIALES PREDEFINIDOS:
//    - Descomenta el #include "textures.inc" arriba
//    - Prueba: texture { Chrome_Metal }
//    - Prueba: texture { Glass3 }
//    - Prueba: texture { Polished_Chrome }
// ============================================================================

// ============================================================================
// CONCEPTOS IMPORTANTES:
// ============================================================================
//
// PIGMENT (Color):
// - color rgb <R, G, B>: Color opaco
// - color rgbf <R, G, B, F>: Con filtrado (transparencia que permite color)
// - color rgbt <R, G, B, T>: Con transmisión (transparencia pura)
// - rgbft: Combinación de ambos
//
// FINISH (Acabado):
// - ambient: Luz ambiente (iluminación constante)
// - diffuse: Reflexión difusa (superficie mate)
// - phong: Modelo de brillo especular Phong
// - phong_size: Tamaño del brillo (10=disperso, 100=concentrado)
// - specular: Modelo alternativo de brillo especular
// - roughness: Rugosidad (usado con specular)
// - reflection: Cantidad de reflexión (0=nada, 1=espejo)
// - metallic: Comportamiento metálico
//
// INTERIOR (Para transparentes):
// - ior: Índice de refracción
//   * 1.0 = vacío/aire
//   * 1.33 = agua
//   * 1.5 = vidrio común
//   * 1.9 = cristal
//   * 2.4 = diamante
//
// DIFERENCIAS IMPORTANTES:
// - PHONG vs SPECULAR: Dos modelos diferentes de brillo
//   * phong usa phong_size (valores altos = más brillante)
//   * specular usa roughness (valores bajos = más brillante)
// - FILTER vs TRANSMIT:
//   * filter: Transparencia que deja pasar el color del objeto
//   * transmit: Transparencia pura sin afectar color
//
// REFLEXIÓN FRESNEL:
// - Simula cómo los objetos reflejan más en ángulos rasantes
// - Más realista que reflexión constante
// - Común en vidrio, agua, plástico brillante
// ============================================================================
