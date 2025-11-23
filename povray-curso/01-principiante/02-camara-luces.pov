// ============================================================================
// EJEMPLO 02: CÁMARA Y LUCES - Configuración de la Escena
// ============================================================================
// En este ejemplo aprenderás a controlar la cámara y la iluminación de manera
// más avanzada. Verás cómo diferentes tipos de luces afectan la escena.
//
// CONCEPTOS QUE APRENDERÁS:
// - Tipos de cámara y sus propiedades
// - Múltiples fuentes de luz
// - Tipos de luces (puntual, área, spotlight)
// - Cómo las luces afectan las sombras y el ambiente
// - Control del ángulo de visión (field of view)
//
// CÓMO RENDERIZAR:
// povray 02-camara-luces.pov +W800 +H600 +A
// ============================================================================

#version 3.7;

global_settings {
  assumed_gamma 1.0
}

// ----------------------------------------------------------------------------
// CÁMARA AVANZADA
// ----------------------------------------------------------------------------
// Exploraremos más propiedades de la cámara

camera {
  location <3, 3, -5>    // Posición de la cámara (ligeramente a la derecha y arriba)
  look_at <0, 0.5, 0>    // Mirando hacia un punto ligeramente elevado

  angle 50               // Ángulo de visión (field of view)
                         // 50 grados es un ángulo normal
                         // Valores comunes:
                         //   30-40 = teleobjetivo (zoom)
                         //   50-60 = visión normal
                         //   70-90 = gran angular
                         //   >90 = ojo de pez

  // TIPOS DE CÁMARA (descomenta para probar):
  // perspective          // Cámara con perspectiva (default)
  // orthographic         // Proyección ortográfica (sin perspectiva)
  // fisheye              // Efecto ojo de pez
}

// ----------------------------------------------------------------------------
// LUZ PRINCIPAL (Key Light)
// ----------------------------------------------------------------------------
// La luz principal es la más brillante y define la dirección principal de iluminación

light_source {
  <2, 5, -3>             // Posición: arriba y a la derecha
  color rgb <1, 1, 0.9>  // Blanco ligeramente cálido (amarillento)
                         // Simula luz de sol o luz cálida

  // INTENSIDAD: Puedes multiplicar el color para más brillo
  // color rgb <1, 1, 0.9> * 1.5  // 50% más brillante
}

// ----------------------------------------------------------------------------
// LUZ DE RELLENO (Fill Light)
// ----------------------------------------------------------------------------
// Una luz secundaria más suave que ilumina las sombras

light_source {
  <-3, 2, -2>            // Posición: al lado opuesto de la luz principal
  color rgb <0.5, 0.5, 0.6>  // Luz azulada más tenue
                              // La mitad de intensidad (valores 0.5)
                              // Simula luz reflejada del cielo

  shadowless             // Esta luz NO genera sombras
                         // Útil para suavizar las sombras sin duplicarlas
}

// ----------------------------------------------------------------------------
// LUZ DE CONTRA (Rim Light / Back Light)
// ----------------------------------------------------------------------------
// Luz desde atrás para crear un borde iluminado

light_source {
  <0, 3, 2>              // Detrás y arriba de los objetos
  color rgb <1, 0.9, 0.8> * 0.7  // Luz cálida a 70% de intensidad

  // Esta luz crea un efecto de "halo" o borde brillante
}

// ----------------------------------------------------------------------------
// SPOTLIGHT (Foco Direccional)
// ----------------------------------------------------------------------------
// Un foco que ilumina en una dirección específica, como un reflector

light_source {
  <0, 8, 0>              // Posición: directamente arriba
  color rgb <1, 1, 1>    // Luz blanca

  spotlight              // Define que es un spotlight
  point_at <0, 0, 0>     // Apunta hacia el centro de la escena

  radius 15              // Ángulo del cono de luz (grados)
                         // Zona completamente iluminada

  falloff 25             // Ángulo donde la luz se desvanece
                         // Zona de transición gradual
                         // falloff debe ser >= radius

  tightness 0            // Concentración del haz (0-100)
                         // 0 = disperso, 100 = muy concentrado
}

// ----------------------------------------------------------------------------
// OBJETOS PARA DEMOSTRACIÓN
// ----------------------------------------------------------------------------

// Esfera central - muestra todas las luces
sphere {
  <0, 1, 0>, 0.8         // Centro y radio

  pigment {
    color rgb <0.9, 0.9, 0.9>  // Blanco grisáceo
  }

  finish {
    ambient 0.1          // Poca luz ambiente para ver mejor las sombras
    diffuse 0.7          // Buena reflexión difusa
    phong 0.8            // Brillo especular alto
    phong_size 60        // Brillo concentrado (superficie lisa)
    reflection 0.2       // 20% de reflexión (ligeramente reflectante)
  }
}

// Esfera izquierda - roja
sphere {
  <-2, 0.5, 1>, 0.5

  pigment { color rgb <1, 0.2, 0.2> }  // Rojo

  finish {
    ambient 0.1
    diffuse 0.6
    phong 0.6
    phong_size 40
  }
}

// Esfera derecha - azul
sphere {
  <2, 0.5, 1>, 0.5

  pigment { color rgb <0.2, 0.4, 1> }  // Azul

  finish {
    ambient 0.1
    diffuse 0.6
    phong 0.6
    phong_size 40
  }
}

// ----------------------------------------------------------------------------
// PLANO DE SUELO
// ----------------------------------------------------------------------------
// Un plano infinito que sirve como suelo

plane {
  <0, 1, 0>, 0           // Normal (apunta hacia arriba) y distancia del origen
                         // <0, 1, 0> = perpendicular al eje Y
                         // 0 = pasa por el origen (y=0)

  pigment {
    checker              // Patrón de tablero de ajedrez
    color rgb <0.8, 0.8, 0.8>  // Blanco
    color rgb <0.4, 0.4, 0.4>  // Gris
    scale 0.5            // Tamaño de los cuadros
  }

  finish {
    ambient 0.2
    diffuse 0.7
    phong 0.1            // Poco brillo (superficie mate)
  }
}

// ----------------------------------------------------------------------------
// FONDO
// ----------------------------------------------------------------------------

background { color rgb <0.1, 0.1, 0.15> }  // Azul muy oscuro (casi negro)

// ============================================================================
// EJERCICIOS PARA PRACTICAR:
// ============================================================================
// 1. CÁMARA:
//    - Cambia el angle a 30 (zoom) y luego a 80 (gran angular)
//    - Mueve la cámara a diferentes posiciones
//    - Cambia look_at para enfocar diferentes esferas
//
// 2. LUCES:
//    - Comenta todas las luces excepto la principal (para ver su efecto)
//    - Cambia los colores de las luces (prueba con rgb <1, 0, 0> en alguna)
//    - Ajusta la intensidad multiplicando (color rgb <1,1,1> * 2)
//
// 3. SPOTLIGHT:
//    - Cambia radius a 5 (haz más estrecho)
//    - Cambia tightness a 50 (más concentrado)
//    - Mueve point_at a una esfera específica
//
// 4. SOMBRAS:
//    - Añade shadowless a diferentes luces y observa el cambio
//    - Camenta la luz de relleno para ver sombras más duras
//
// 5. ILUMINACIÓN DE 3 PUNTOS CLÁSICA:
//    - Intenta recrear el esquema clásico de fotografía con solo 3 luces
//    - Key light: principal y brillante
//    - Fill light: suave y desde el lado opuesto
//    - Back light: desde atrás para separar del fondo
// ============================================================================

// ============================================================================
// CONCEPTOS DE ILUMINACIÓN:
// ============================================================================
//
// ESQUEMA DE ILUMINACIÓN DE 3 PUNTOS:
// - Key Light: Luz principal, 45° del sujeto, más brillante
// - Fill Light: Luz de relleno, lado opuesto, 50% de intensidad
// - Back Light: Desde atrás, crea separación del fondo
//
// TIPOS DE LUCES EN POV-RAY:
// 1. Punto (default): Luz omnidireccional desde un punto
// 2. Spotlight: Luz direccional en forma de cono
// 3. Área (area_light): Luz suave de un área (más realista, más lento)
//
// PROPIEDADES IMPORTANTES:
// - shadowless: La luz no crea sombras
// - fade_distance: Distancia a la que la luz tiene intensidad completa
// - fade_power: Cómo decae la luz con la distancia (2 = realista)
//
// COLORES DE LUZ:
// - <1, 1, 1>: Blanco puro (neutro)
// - <1, 0.9, 0.7>: Luz cálida (atardecer, tungsteno)
// - <0.8, 0.9, 1>: Luz fría (día nublado, sombra)
// - <1, 0.8, 0.6>: Luz de vela
// ============================================================================
