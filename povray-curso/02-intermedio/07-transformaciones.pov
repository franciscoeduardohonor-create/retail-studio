// ============================================================================
// EJEMPLO 07: TRANSFORMACIONES AVANZADAS
// ============================================================================
// Domina las transformaciones para crear geometría compleja y animaciones.
//
// CONCEPTOS QUE APRENDERÁS:
// - Transformaciones compuestas
// - Matrices de transformación
// - Centros de rotación personalizados
// - Transformaciones no uniformes
// - Inversión de objetos
//
// CÓMO RENDERIZAR:
// povray 07-transformaciones.pov +W800 +H600 +A
// ============================================================================

#version 3.7;

#include "colors.inc"

global_settings {
  assumed_gamma 1.0
}

// ----------------------------------------------------------------------------
// CÁMARA Y LUCES
// ----------------------------------------------------------------------------

camera {
  location <6, 8, -12>
  look_at <0, 1, 0>
  angle 50
}

light_source {
  <15, 25, -20>
  color White * 1.2
}

light_source {
  <-10, 10, -10>
  color White * 0.4
  shadowless
}

// ----------------------------------------------------------------------------
// EJEMPLO 1: ROTACIÓN ALREDEDOR DE UN PUNTO ARBITRARIO
// ----------------------------------------------------------------------------
// Para rotar alrededor de un punto que NO es el origen

#declare MiColor = rgb <1, 0.3, 0.3>;

// Centro de rotación
sphere {
  <-4, 1, 3>, 0.15
  pigment { color Yellow }
  finish { ambient 0.8 }
}

// Objeto que rotará
box {
  <-0.3, -0.3, -0.3>, <0.3, 0.3, 0.3>

  pigment { color MiColor }
  finish { ambient 0.2 diffuse 0.7 phong 0.6 }

  // Método para rotar alrededor de un punto <-4, 1, 3>:
  translate <1, 0, 0>          // 1. Alejar del punto de rotación
  rotate <0, 45, 0>            // 2. Rotar
  translate <-4, 1, 3>         // 3. Mover al punto de rotación
}

text {
  ttf "timrom.ttf" "Rotacion sobre punto" 0.05, 0
  scale 0.25
  translate <-5.5, 2.5, 3>
  pigment { color White }
  finish { ambient 0.5 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// EJEMPLO 2: TRANSFORMACIONES EN CADENA (ÓRDEN IMPORTA)
// ----------------------------------------------------------------------------

// Primera versión: Rotar -> Escalar -> Trasladar
union {
  sphere { <0, 0, 0>, 0.3 pigment { color Red } }
  cylinder { <0, 0, 0>, <1, 0, 0>, 0.1 pigment { color Green } }
  cylinder { <0, 0, 0>, <0, 1, 0>, 0.1 pigment { color Blue } }

  finish { ambient 0.2 diffuse 0.7 }

  rotate <0, 0, 30>      // 1. Rotar
  scale <1, 2, 1>        // 2. Escalar
  translate <-1, 1, 0>   // 3. Trasladar
}

// Segunda versión: Trasladar -> Escalar -> Rotar (resultado diferente)
union {
  sphere { <0, 0, 0>, 0.3 pigment { color Red } }
  cylinder { <0, 0, 0>, <1, 0, 0>, 0.1 pigment { color Green } }
  cylinder { <0, 0, 0>, <0, 1, 0>, 0.1 pigment { color Blue } }

  finish { ambient 0.2 diffuse 0.7 }

  translate <1, 0, 0>    // 1. Trasladar
  scale <1, 2, 1>        // 2. Escalar
  rotate <0, 0, 30>      // 3. Rotar (rota alrededor del origen)
  translate <0, 1, 0>    // 4. Posición final
}

text {
  ttf "timrom.ttf" "Orden de transformaciones" 0.05, 0
  scale 0.25
  translate <-2, 3.5, 0>
  pigment { color White }
  finish { ambient 0.5 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// EJEMPLO 3: SHEAR (CIZALLAMIENTO/DEFORMACIÓN)
// ----------------------------------------------------------------------------
// Deformar objetos usando matrices

box {
  <-0.4, -0.4, -0.4>, <0.4, 0.4, 0.4>

  pigment { color Green }
  finish { ambient 0.2 diffuse 0.7 phong 0.5 }

  // Matriz de cizallamiento en Y basado en X
  matrix <
    1, 0, 0,     // Fila 1: Transformación X
    0.5, 1, 0,   // Fila 2: Transformación Y (0.5 = factor de shear)
    0, 0, 1,     // Fila 3: Transformación Z
    0, 0, 0      // Fila 4: Traslación
  >

  translate <2, 1, 0>
}

// Cubo normal para comparación
box {
  <-0.4, -0.4, -0.4>, <0.4, 0.4, 0.4>

  pigment { color rgb <0.3, 0.7, 0.3> }
  finish { ambient 0.2 diffuse 0.7 phong 0.5 }

  translate <3.5, 1, 0>
}

text {
  ttf "timrom.ttf" "Shear (matrix)" 0.05, 0
  scale 0.25
  translate <2, 2.5, 0>
  pigment { color White }
  finish { ambient 0.5 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// EJEMPLO 4: INVERSE - INVERTIR INTERIOR/EXTERIOR
// ----------------------------------------------------------------------------
// Hace que el interior sea exterior y viceversa

difference {
  // Esfera exterior
  sphere {
    <5, 1.5, 3>, 1
    pigment { color rgb <0.8, 0.8, 1> }
  }

  // Esfera interior invertida (crea un hueco)
  sphere {
    <5, 1.5, 3>, 0.7
    inverse  // Invierte el objeto
  }

  finish { ambient 0.2 diffuse 0.7 phong 0.6 }
}

text {
  ttf "timrom.ttf" "INVERSE" 0.05, 0
  scale 0.25
  translate <4.5, 3, 3>
  pigment { color White }
  finish { ambient 0.5 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// EJEMPLO 5: SCALE NO UNIFORME - DEFORMACIONES CONTROLADAS
// ----------------------------------------------------------------------------

// Esfera convertida en elipsoide
sphere {
  <-4, 1, -2>, 0.6

  pigment { color Orange }
  finish { ambient 0.2 diffuse 0.7 phong 0.7 }

  scale <1, 2, 0.5>  // Estirar en Y, comprimir en Z
}

// Cilindro deformado
cylinder {
  <0, 0, 0>, <0, 1, 0>, 0.4

  pigment { color Cyan }
  finish { ambient 0.2 diffuse 0.7 phong 0.6 }

  scale <2, 1, 0.5>  // Ensanchar en X, comprimir en Z
  translate <-2, 0.5, -2>
}

text {
  ttf "timrom.ttf" "Scale no uniforme" 0.05, 0
  scale 0.25
  translate <-4.5, 2.5, -2>
  pigment { color White }
  finish { ambient 0.5 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// EJEMPLO 6: TRANSFORMACIÓN CON #declare
// ----------------------------------------------------------------------------
// Guardar transformaciones para reutilizar

#declare MiTransformacion = transform {
  rotate <0, 45, 0>
  scale <1.2, 1.5, 1.2>
  translate <0, 0.5, 0>
}

// Usar la transformación en múltiples objetos
box {
  <-0.3, -0.3, -0.3>, <0.3, 0.3, 0.3>
  pigment { color Magenta }
  finish { ambient 0.2 diffuse 0.7 phong 0.6 }

  transform { MiTransformacion }
  translate <0, 0, -2>
}

cone {
  <0, 0, 0>, 0.4
  <0, 0.8, 0>, 0
  pigment { color Yellow }
  finish { ambient 0.2 diffuse 0.7 phong 0.6 }

  transform { MiTransformacion }
  translate <1.5, 0, -2>
}

text {
  ttf "timrom.ttf" "Transform reutilizable" 0.05, 0
  scale 0.23
  translate <-0.8, 2.5, -2>
  pigment { color White }
  finish { ambient 0.5 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// EJEMPLO 7: CREAR UN ESPIRAL CON TRANSFORMACIONES
// ----------------------------------------------------------------------------

#declare I = 0;
#while (I < 20)
  sphere {
    <0, 0, 0>, 0.15

    pigment {
      color rgb <1, I/20, 1-I/20>  // Gradiente de color
    }

    finish { ambient 0.2 diffuse 0.7 phong 0.8 }

    // Transformaciones para crear espiral
    translate <2, 0, 0>              // Alejar del centro
    rotate <0, I*360/20, 0>          // Rotar alrededor del eje Y
    translate <0, I*0.15, 0>         // Elevar progresivamente
    translate <3, 0, -5>             // Posición final del espiral
  }

  #declare I = I + 1;
#end

text {
  ttf "timrom.ttf" "Espiral" 0.05, 0
  scale 0.3
  translate <2.5, 4, -5>
  pigment { color White }
  finish { ambient 0.5 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// EJEMPLO 8: ROTACIÓN MÚLTIPLE EN EJES
// ----------------------------------------------------------------------------

box {
  <-0.5, -0.2, -0.2>, <0.5, 0.2, 0.2>

  pigment {
    gradient x
    color_map {
      [0.0 color Red]
      [1.0 color Blue]
    }
  }

  finish { ambient 0.2 diffuse 0.7 phong 0.6 }

  // Rotar en múltiples ejes
  rotate <30, 45, 15>  // X, Y, Z simultáneamente
  translate <-4, 2, -5>
}

text {
  ttf "timrom.ttf" "Rotacion 3D" 0.05, 0
  scale 0.25
  translate <-4.8, 3.5, -5>
  pigment { color White }
  finish { ambient 0.5 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// PLANO DE SUELO
// ----------------------------------------------------------------------------

plane {
  <0, 1, 0>, 0

  pigment {
    checker
    color rgb <0.9, 0.9, 0.9>
    color rgb <0.6, 0.6, 0.6>
    scale 0.5
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

background { color rgb <0.4, 0.5, 0.7> }

// ============================================================================
// EJERCICIOS PARA PRACTICAR:
// ============================================================================
// 1. ROTACIÓN PERSONALIZADA:
//    - Crea un objeto que rote alrededor de un punto <2, 3, -1>
//    - Usa el método: translate -> rotate -> translate
//
// 2. EXPERIMENTA CON ORDEN:
//    - Toma cualquier objeto con 3 transformaciones
//    - Cambia el orden y observa los resultados
//    - Documenta qué pasa en cada caso
//
// 3. MATRICES:
//    - Investiga diferentes matrices de transformación
//    - Crea un efecto de espejo con scale <-1, 1, 1>
//    - Experimenta con shear en diferentes direcciones
//
// 4. BUCLES Y PATRONES:
//    - Crea un círculo de esferas usando #while y rotate
//    - Crea una escalera usando #while y translate
//    - Crea una hélice de ADN usando dos espirales
//
// 5. ANIMACIÓN BÁSICA:
//    - Usa el 'clock' para animaciones
//    - Ejemplo: rotate <0, clock*360, 0>
//    - Renderiza múltiples frames
//
// 6. PROYECTO: SISTEMA SOLAR
//    - Sol en el centro
//    - Planetas que orbitan (rotate alrededor del sol)
//    - Lunas que orbitan planetas (rotación anidada)
//    - Usa #declare para los radios de órbita
// ============================================================================

// ============================================================================
// REFERENCIA DE TRANSFORMACIONES:
// ============================================================================
//
// TRANSFORMACIONES BÁSICAS:
// - translate <x, y, z>: Mover el objeto
// - rotate <x, y, z>: Rotar en grados alrededor de cada eje
// - scale <x, y, z> o scale N: Escalar el objeto
//
// ORDEN ESTÁNDAR RECOMENDADO:
// 1. rotate (forma)
// 2. scale (tamaño)
// 3. translate (posición)
//
// ROTACIÓN ALREDEDOR DE PUNTO ARBITRARIO:
// translate -<Punto>    // Mover al origen
// rotate <...>          // Rotar
// translate <Punto>     // Mover de vuelta
//
// MATRICES DE TRANSFORMACIÓN:
// matrix <
//   xx, xy, xz,   // Primera fila
//   yx, yy, yz,   // Segunda fila
//   zx, zy, zz,   // Tercera fila
//   tx, ty, tz    // Traslación
// >
//
// MATRIZ IDENTIDAD (sin cambios):
// matrix < 1,0,0, 0,1,0, 0,0,1, 0,0,0 >
//
// SHEAR EN Y BASADO EN X:
// matrix < 1,0,0, S,1,0, 0,0,1, 0,0,0 >  // S = factor de shear
//
// ESPEJO EN X:
// scale <-1, 1, 1>
//
// ESPEJO EN Y:
// scale <1, -1, 1>
//
// OTRAS TRANSFORMACIONES:
// - inverse: Invierte el interior/exterior del objeto
// - transform { ... }: Agrupa transformaciones para reutilizar
//
// VARIABLES ÚTILES:
// - clock: Variable de animación (0 a 1 por defecto)
//   Usa en línea de comandos: +KFF30 para 30 frames
//
// BUCLES PARA REPETICIÓN:
// #declare I = 0;
// #while (I < N)
//   // Objeto con transformaciones que usan I
//   #declare I = I + 1;
// #end
// ============================================================================
