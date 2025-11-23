// ============================================================================
// EJEMPLO 01: TU PRIMERA ESFERA
// ============================================================================
// Este es tu primer programa en POV-Ray. Aprenderás los elementos básicos
// que toda escena necesita: cámara, luz y un objeto.
//
// CONCEPTOS QUE APRENDERÁS:
// - Estructura básica de un archivo POV-Ray
// - Cómo definir una cámara
// - Cómo añadir iluminación
// - Cómo crear tu primer objeto 3D (esfera)
// - Cómo aplicar color a un objeto
//
// CÓMO RENDERIZAR:
// povray 01-primera-esfera.pov +W800 +H600 +A
// ============================================================================

// ----------------------------------------------------------------------------
// VERSIÓN DE POV-RAY
// ----------------------------------------------------------------------------
// Especificamos la versión de POV-Ray para garantizar compatibilidad
#version 3.7;

// ----------------------------------------------------------------------------
// CONFIGURACIÓN GLOBAL
// ----------------------------------------------------------------------------
// 'global_settings' controla configuraciones que afectan toda la escena

global_settings {
  assumed_gamma 1.0  // Corrección de gamma para colores precisos
                     // 1.0 es el estándar para monitores modernos
}

// ----------------------------------------------------------------------------
// CÁMARA
// ----------------------------------------------------------------------------
// La cámara define DESDE DÓNDE y HACIA DÓNDE miramos la escena
// Piensa en ella como tus ojos o una cámara de fotos

camera {
  location <0, 2, -5>   // POSICIÓN de la cámara en el espacio 3D
                        // <x, y, z> donde:
                        //   x: izquierda(-) / derecha(+)
                        //   y: abajo(-) / arriba(+)
                        //   z: alejado(-) / cercano(+)
                        // Esta cámara está ligeramente elevada y alejada

  look_at <0, 0, 0>     // PUNTO al que mira la cámara
                        // <0, 0, 0> es el origen (centro) del mundo

  // OPCIONAL: Puedes descomentar estas líneas para experimentar
  // angle 45           // Ángulo de visión (como el zoom de una cámara)
                        // Valores mayores = visión más amplia
}

// ----------------------------------------------------------------------------
// ILUMINACIÓN
// ----------------------------------------------------------------------------
// Las luces iluminan la escena. Sin luz, todo sería negro.
// 'light_source' crea una fuente de luz puntual (como una bombilla)

light_source {
  <2, 4, -3>           // POSICIÓN de la luz
                       // Está arriba y a la derecha de la escena

  color rgb <1, 1, 1>  // COLOR de la luz
                       // rgb significa Red, Green, Blue (Rojo, Verde, Azul)
                       // <1, 1, 1> = luz blanca pura
                       // Valores de 0 a 1 para cada componente
                       // Ejemplos:
                       //   <1, 0, 0> = rojo puro
                       //   <0, 1, 0> = verde puro
                       //   <0, 0, 1> = azul puro
                       //   <1, 1, 0> = amarillo
}

// ----------------------------------------------------------------------------
// OBJETO: ESFERA
// ----------------------------------------------------------------------------
// ¡Aquí está tu primer objeto 3D!
// Una esfera es uno de los objetos más simples en POV-Ray

sphere {
  <0, 0, 0>,           // CENTRO de la esfera (posición)
                       // Está en el origen del mundo

  1                    // RADIO de la esfera
                       // Una esfera de radio 1 (2 unidades de diámetro)

  // MATERIAL (pigmento y acabado)
  // El 'pigment' define el color base del objeto
  pigment {
    color rgb <1, 0, 0>  // Color rojo brillante
                         // <1, 0, 0> = rojo al 100%
  }

  // El 'finish' define cómo refleja la luz
  finish {
    ambient 0.2        // Iluminación ambiental (luz indirecta)
                       // 0.2 = 20% de luz ambiente
                       // Sin esto, las sombras serían completamente negras

    diffuse 0.6        // Reflexión difusa (dispersa)
                       // 0.6 = 60% de reflexión difusa
                       // Esto hace que el objeto se vea mate

    phong 0.5          // Brillo especular (puntos brillantes)
                       // 0.5 = brillo moderado
                       // Simula superficies ligeramente brillantes

    phong_size 40      // Tamaño del brillo especular
                       // Valores más altos = brillo más concentrado
                       // Valores más bajos = brillo más disperso
  }
}

// ----------------------------------------------------------------------------
// PLANO DE FONDO (OPCIONAL)
// ----------------------------------------------------------------------------
// Un color de fondo para la escena (como el cielo)

background {
  color rgb <0.5, 0.7, 1.0>  // Azul cielo claro
                             // Mezcla de azul con un poco de blanco
}

// ============================================================================
// EJERCICIOS PARA PRACTICAR:
// ============================================================================
// 1. Cambia el color de la esfera a verde <0, 1, 0>
// 2. Mueve la esfera hacia arriba cambiando su posición a <0, 1, 0>
// 3. Aumenta el radio de la esfera a 1.5
// 4. Cambia la posición de la cámara a <0, 0, -8> (más lejos)
// 5. Añade una segunda luz en posición <-2, 4, -3> con color azulado
// 6. Cambia el color de fondo a un atardecer <1, 0.5, 0.2>
// 7. Experimenta con los valores de phong y phong_size
// 8. Intenta valores de diffuse más altos (0.8) o más bajos (0.3)
//
// TIP: Renderiza después de cada cambio para ver el efecto
// ============================================================================

// ============================================================================
// NOTAS IMPORTANTES:
// ============================================================================
// - POV-Ray usa un sistema de coordenadas <x, y, z>
// - Los valores de color van de 0 (negro) a 1 (máximo)
// - Los comentarios de una línea empiezan con //
// - Los comentarios de múltiples líneas van entre /* y */
// - Las llaves { } agrupan elementos
// - Cada declaración importante termina (generalmente) con }
// - Es sensible a mayúsculas/minúsculas
// ============================================================================
