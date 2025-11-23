// ============================================================================
// EJEMPLO 12: ANIMACIONES - Movimiento y Tiempo
// ============================================================================
// Aprende a crear animaciones completas usando la variable 'clock' y
// técnicas avanzadas de timing.
//
// CONCEPTOS QUE APRENDERÁS:
// - Variable clock (tiempo de animación)
// - Ciclos y loops de animación
// - Interpolación de movimiento
// - Easing functions
// - Animación de cámara
// - Movimiento en trayectorias
//
// CÓMO RENDERIZAR ANIMACIÓN:
// povray 12-animaciones.pov +W640 +H480 +KFF30 +A
//
// Parámetros importantes:
// +KFF30    = 30 frames (frames del 0 al 29)
// +KFI0     = Frame inicial (default 0)
// +KFF100   = 100 frames para animación más suave
//
// La variable 'clock' va de 0.0 a 1.0 durante la animación
// ============================================================================

#version 3.7;

#include "colors.inc"
#include "math.inc"

global_settings {
  assumed_gamma 1.0
}

// ----------------------------------------------------------------------------
// CONFIGURACIÓN DE ANIMACIÓN
// ----------------------------------------------------------------------------

// IMPORTANTE: 'clock' es una variable automática que va de 0 a 1
// Si renderizas un solo frame, clock = 0
// Con animación (+KFF30), clock = frame_number / (total_frames - 1)

#declare AnimTime = clock;  // 0.0 a 1.0

// Debug: ver el valor de clock
#debug concat("Clock = ", str(clock, 5, 3), "\n")
#debug concat("Frame = ", str(frame_number, 5, 0), "\n")

// ----------------------------------------------------------------------------
// CÁMARA ANIMADA
// ----------------------------------------------------------------------------

// Cámara que orbita alrededor de la escena
#declare CamAngle = AnimTime * 360;  // Rotación completa en 360°

camera {
  location <10 * cos(radians(CamAngle)), 8, 10 * sin(radians(CamAngle))>
  look_at <0, 2, 0>
  angle 50
}

// ----------------------------------------------------------------------------
// LUCES
// ----------------------------------------------------------------------------

light_source {
  <10, 20, -15>
  color White * 1.3
}

light_source {
  <-10, 15, -10>
  color White * 0.5
  shadowless
}

// ----------------------------------------------------------------------------
// 1. ROTACIÓN SIMPLE
// ----------------------------------------------------------------------------
// Objeto que rota continuamente

box {
  <-0.8, -0.8, -0.8>, <0.8, 0.8, 0.8>

  pigment {
    checker
    color Red
    color Yellow
    scale 0.4
  }

  finish {
    ambient 0.2
    diffuse 0.7
    phong 0.8
  }

  // Rotar basado en clock
  rotate <0, AnimTime * 360, 0>
  translate <-6, 1.5, 5>
}

text {
  ttf "timrom.ttf" "Rotacion" 0.05, 0
  scale 0.25
  translate <-7, 3, 5>
  pigment { color White }
  finish { ambient 0.6 }
}

// ----------------------------------------------------------------------------
// 2. MOVIMIENTO LINEAL
// ----------------------------------------------------------------------------
// Esfera que se mueve de un punto a otro

#declare StartPos = <-6, 1, 0>;
#declare EndPos = <-2, 1, 0>;

sphere {
  StartPos + (EndPos - StartPos) * AnimTime, 0.5

  pigment { color Green }
  finish { ambient 0.2 diffuse 0.7 phong 0.9 }
}

// Marcadores de inicio y fin
sphere {
  StartPos, 0.15
  pigment { color rgb <0.5, 0.5, 0.5> }
  finish { ambient 0.4 }
}

sphere {
  EndPos, 0.15
  pigment { color rgb <0.5, 0.5, 0.5> }
  finish { ambient 0.4 }
}

text {
  ttf "timrom.ttf" "Lineal" 0.05, 0
  scale 0.25
  translate <-6, 2, 0>
  pigment { color White }
  finish { ambient 0.6 }
}

// ----------------------------------------------------------------------------
// 3. MOVIMIENTO CIRCULAR/ORBITAL
// ----------------------------------------------------------------------------

#declare OrbitRadius = 2;
#declare OrbitSpeed = 2;  // Número de vueltas completas

sphere {
  <0, 1, 0>, 0.4

  pigment { color Blue }
  finish { ambient 0.2 diffuse 0.7 phong 0.9 }

  // Orbitar alrededor de un punto
  translate <OrbitRadius, 0, 0>
  rotate <0, AnimTime * 360 * OrbitSpeed, 0>
  translate <0, 0, 0>
}

// Centro de órbita
cylinder {
  <0, 0, 0>, <0, 0.1, 0>, 0.1
  pigment { color rgb <0.8, 0.8, 0.8> }
}

text {
  ttf "timrom.ttf" "Orbital" 0.05, 0
  scale 0.25
  translate <-0.8, 3, 0>
  pigment { color White }
  finish { ambient 0.6 }
}

// ----------------------------------------------------------------------------
// 4. EASING - MOVIMIENTO SUAVE (Ease In/Out)
// ----------------------------------------------------------------------------
// Movimiento que acelera y desacelera suavemente

// Función de easing (smoothstep)
#declare EasedTime = AnimTime * AnimTime * (3 - 2 * AnimTime);

#declare Start4 = <2, 1, 0>;
#declare End4 = <6, 1, 0>;

sphere {
  Start4 + (End4 - Start4) * EasedTime, 0.5

  pigment { color Orange }
  finish { ambient 0.2 diffuse 0.7 phong 0.9 }
}

sphere { Start4, 0.15 pigment { color rgb <0.5, 0.5, 0.5> } finish { ambient 0.4 } }
sphere { End4, 0.15 pigment { color rgb <0.5, 0.5, 0.5> } finish { ambient 0.4 } }

text {
  ttf "timrom.ttf" "Easing" 0.05, 0
  scale 0.25
  translate <3, 2, 0>
  pigment { color White }
  finish { ambient 0.6 }
}

// ----------------------------------------------------------------------------
// 5. BOUNCE (Rebote)
// ----------------------------------------------------------------------------

#declare BounceTime = abs(sin(AnimTime * pi * 4));  // 4 rebotes
#declare BounceHeight = 3;

sphere {
  <0, BounceTime * BounceHeight + 0.5, 0>, 0.5

  pigment { color Magenta }
  finish { ambient 0.2 diffuse 0.7 phong 0.9 }

  translate <-6, 0, -4>
}

// Sombra simulada (disco que se expande/contrae)
disc {
  <0, 0.05, 0>, <0, 1, 0>, 0.5 + (1 - BounceTime) * 0.3

  pigment { color rgbt <0, 0, 0, 0.5> }
  finish { ambient 0 diffuse 0.8 }

  translate <-6, 0, -4>
}

text {
  ttf "timrom.ttf" "Bounce" 0.05, 0
  scale 0.25
  translate <-6.5, 4.5, -4>
  pigment { color White }
  finish { ambient 0.6 }
}

// ----------------------------------------------------------------------------
// 6. ESCALA ANIMADA (Pulsación)
// ----------------------------------------------------------------------------

#declare PulseScale = 1 + 0.5 * sin(AnimTime * pi * 6);  // 3 pulsos completos

sphere {
  <0, 1, 0>, 0.5

  pigment { color Cyan }
  finish { ambient 0.2 diffuse 0.7 phong 0.9 }

  scale PulseScale
  translate <-2, 0, -4>
}

text {
  ttf "timrom.ttf" "Pulse" 0.05, 0
  scale 0.25
  translate <-2.5, 3.5, -4>
  pigment { color White }
  finish { ambient 0.6 }
}

// ----------------------------------------------------------------------------
// 7. TRAYECTORIA CURVA (Spline simulado)
// ----------------------------------------------------------------------------

// Curva de Bézier cuadrática simple
#macro BezierQuad(P0, P1, P2, T)
  P0 * (1-T) * (1-T) + P1 * 2 * (1-T) * T + P2 * T * T
#end

#declare P0 = <2, 1, -4>;
#declare P1 = <4, 4, -3>;  // Punto de control (altura de la curva)
#declare P2 = <6, 1, -4>;

sphere {
  BezierQuad(P0, P1, P2, AnimTime), 0.4

  pigment { color Yellow }
  finish { ambient 0.2 diffuse 0.7 phong 0.9 }
}

// Visualizar trayectoria con puntos
#declare T = 0;
#while (T <= 1)
  sphere {
    BezierQuad(P0, P1, P2, T), 0.05
    pigment { color rgbt <1, 1, 1, 0.7> }
  }
  #declare T = T + 0.05;
#end

text {
  ttf "timrom.ttf" "Bezier" 0.05, 0
  scale 0.25
  translate <3.5, 2.5, -4>
  pigment { color White }
  finish { ambient 0.6 }
}

// ----------------------------------------------------------------------------
// 8. ANIMACIÓN COMPLEJA: PÉNDULO
// ----------------------------------------------------------------------------

#declare PendulumAngle = 45 * sin(AnimTime * pi * 2);  // Oscila ±45°
#declare PendulumLength = 2;

union {
  // Punto de anclaje
  sphere {
    <0, 3, 0>, 0.15
    pigment { color rgb <0.3, 0.3, 0.3> }
  }

  // Cuerda
  cylinder {
    <0, 0, 0>, <0, -PendulumLength, 0>, 0.05
    pigment { color rgb <0.5, 0.5, 0.5> }
  }

  // Peso
  sphere {
    <0, -PendulumLength, 0>, 0.4
    pigment { color rgb <0.8, 0.3, 0.3> }
    finish { ambient 0.2 diffuse 0.7 phong 0.8 }
  }

  rotate <0, 0, PendulumAngle>
  translate <0, 0, -8>
}

text {
  ttf "timrom.ttf" "Pendulo" 0.05, 0
  scale 0.25
  translate <-0.8, 5.5, -8>
  pigment { color White }
  finish { ambient 0.6 }
}

// ----------------------------------------------------------------------------
// 9. CICLO CONTINUO (Loop seamless)
// ----------------------------------------------------------------------------
// Usando sin y cos para crear loops perfectos

#declare LoopX = 2 * cos(AnimTime * 2 * pi);
#declare LoopZ = 2 * sin(AnimTime * 2 * pi);

sphere {
  <LoopX, 2, LoopZ>, 0.4

  pigment {
    color rgb <
      0.5 + 0.5 * cos(AnimTime * 2 * pi),
      0.5 + 0.5 * sin(AnimTime * 2 * pi),
      0.8
    >
  }

  finish { ambient 0.2 diffuse 0.7 phong 0.9 }

  translate <4, 0, -8>
}

// Trayectoria circular
torus {
  2, 0.05
  pigment { color rgbt <1, 1, 1, 0.7> }
  rotate <90, 0, 0>
  translate <4, 2, -8>
}

text {
  ttf "timrom.ttf" "Loop" 0.05, 0
  scale 0.25
  translate <3.5, 4.5, -8>
  pigment { color White }
  finish { ambient 0.6 }
}

// ----------------------------------------------------------------------------
// 10. MÚLTIPLES OBJETOS CON DELAYS
// ----------------------------------------------------------------------------
// Onda de esferas que se animan en secuencia

#declare NumEsferas = 10;
#declare I = 0;
#while (I < NumEsferas)
  #declare Delay = I / NumEsferas;  // Cada esfera empieza más tarde
  #declare LocalTime = max(0, (AnimTime - Delay) * 2);  // Acelerar 2x

  #if (LocalTime > 0 & LocalTime < 1)
    #declare Height = sin(LocalTime * pi) * 2;
  #else
    #declare Height = 0;
  #end

  sphere {
    <I - NumEsferas/2, Height + 0.4, 0>, 0.3

    pigment {
      color rgb <I/NumEsferas, 1 - I/NumEsferas, 0.5>
    }

    finish { ambient 0.2 diffuse 0.7 phong 0.9 }

    translate <0, 0, 5>
  }

  #declare I = I + 1;
#end

text {
  ttf "timrom.ttf" "Onda" 0.05, 0
  scale 0.25
  translate <-1, 3.5, 5>
  pigment { color White }
  finish { ambient 0.6 }
}

// ----------------------------------------------------------------------------
// 11. INDICADOR DE PROGRESO
// ----------------------------------------------------------------------------

// Barra de progreso animada
box {
  <-5, 0, 0>, <-5 + AnimTime * 10, 0.3, 0.5>

  pigment {
    gradient x
    color_map {
      [0.0 color rgb <0, 1, 0>]
      [0.5 color rgb <1, 1, 0>]
      [1.0 color rgb <1, 0, 0>]
    }
    scale 10
  }

  finish { ambient 0.4 diffuse 0.6 }

  translate <0, 7, 0>
}

// Marco de la barra
union {
  cylinder { <-5, 0, 0>, <5, 0, 0>, 0.08 translate <0, -0.15, 0> }
  cylinder { <-5, 0, 0>, <5, 0, 0>, 0.08 translate <0, 0.45, 0> }
  cylinder { <-5, -0.15, 0>, <-5, 0.45, 0>, 0.08 }
  cylinder { <5, -0.15, 0>, <5, 0.45, 0>, 0.08 }

  pigment { color rgb <0.3, 0.3, 0.3> }

  translate <0, 7, 0>
}

// Texto de porcentaje
text {
  ttf "timrom.ttf"
  concat(str(floor(AnimTime * 100), 0, 0), "%")
  0.05, 0

  scale 0.4
  translate <-0.5, 7.8, 0>
  pigment { color White }
  finish { ambient 0.8 }
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
    scale 1
  }

  finish {
    ambient 0.2
    diffuse 0.7
  }
}

// ----------------------------------------------------------------------------
// FONDO
// ----------------------------------------------------------------------------

background {
  color rgb <0.3, 0.4, 0.6>
}

// ============================================================================
// EJERCICIOS PARA PRACTICAR:
// ============================================================================
// 1. ANIMACIONES BÁSICAS:
//    - Crea una esfera que cambia de color gradualmente
//    - Anima la transparencia de un objeto (0 a 1)
//    - Rota un objeto en múltiples ejes simultáneamente
//
// 2. EASING FUNCTIONS:
//    - Implementa ease-in: AnimTime * AnimTime
//    - Implementa ease-out: 1 - (1-AnimTime) * (1-AnimTime)
//    - Crea un bounce realista con gravedad
//
// 3. TRAYECTORIAS:
//    - Crea una trayectoria en forma de 8
//    - Implementa una curva de Bézier cúbica
//    - Anima un objeto siguiendo un círculo en 3D
//
// 4. ANIMACIONES COMPLEJAS:
//    - Sistema solar con planetas orbitando
//    - Reloj con manecillas animadas
//    - Engranajes sincronizados
//    - Fuente de agua con partículas
//
// 5. CÁMARA ANIMADA:
//    - Cámara que sigue a un objeto
//    - Zoom in/out suave
//    - Movimiento de cámara en trayectoria curva
//
// 6. PROYECTO: ANIMACIÓN CORTA
//    - Escena de 300 frames (10 segundos a 30fps)
//    - Con inicio, desarrollo y final
//    - Múltiples objetos animados
//    - Iluminación animada
//
// COMANDOS PARA RENDERIZAR:
// povray 12-animaciones.pov +W640 +H480 +KFF30 +A
// povray 12-animaciones.pov +W1920 +H1080 +KFF300 +A  (alta calidad)
// ============================================================================

// ============================================================================
// REFERENCIA DE ANIMACIÓN:
// ============================================================================
//
// VARIABLE CLOCK:
// - Automática, va de 0.0 a 1.0
// - Se controla con parámetros de línea de comandos
// - +KFF<n>: número total de frames
// - +KFI<n>: frame inicial (default 0)
// - +KFF<n>: frame final
//
// COMANDOS DE RENDERIZADO:
// povray archivo.pov +KFF30        // 30 frames (0-29)
// povray archivo.pov +KFI10 +KFF40 // Frames 10-40
// povray archivo.pov +KFF100 +W800 +H600 +A  // 100 frames HD
//
// CÁLCULO DE CLOCK:
// clock = (frame_number - initial_frame) / (final_frame - initial_frame)
//
// OTRAS VARIABLES:
// frame_number     // Número del frame actual
// initial_frame    // Primer frame
// final_frame      // Último frame
//
// CONVERSIONES ÚTILES:
// Grados a radianes: radians(grados)
// Radianes a grados: degrees(radianes)
//
// FUNCIONES PARA ANIMACIÓN:
//
// 1. MOVIMIENTO LINEAL:
//    Pos = Start + (End - Start) * clock
//
// 2. ROTACIÓN:
//    rotate <0, clock * 360, 0>
//
// 3. EASE IN/OUT (Smoothstep):
//    t = clock * clock * (3 - 2 * clock)
//
// 4. EASE IN (Aceleración):
//    t = clock * clock
//
// 5. EASE OUT (Desaceleración):
//    t = 1 - (1 - clock) * (1 - clock)
//
// 6. BOUNCE:
//    y = abs(sin(clock * pi * n))  // n = número de rebotes
//
// 7. PULSO:
//    scale = 1 + amplitude * sin(clock * 2 * pi * freq)
//
// 8. PÉNDULO:
//    angle = amplitude * sin(clock * 2 * pi * freq)
//
// 9. LOOP CONTINUO:
//    x = radius * cos(clock * 2 * pi)
//    z = radius * sin(clock * 2 * pi)
//
// 10. DELAY/OFFSET:
//     local_time = max(0, (clock - delay) * speed)
//
// BÉZIER CUADRÁTICO:
// #macro Bezier(P0, P1, P2, t)
//   P0*(1-t)*(1-t) + P1*2*(1-t)*t + P2*t*t
// #end
//
// BÉZIER CÚBICO:
// #macro BezierCubic(P0, P1, P2, P3, t)
//   P0*(1-t)*(1-t)*(1-t) +
//   P1*3*(1-t)*(1-t)*t +
//   P2*3*(1-t)*t*t +
//   P3*t*t*t
// #end
//
// INTERPOLACIÓN LINEAL:
// #macro Lerp(A, B, t)
//   A + (B - A) * t
// #end
//
// CONSEJOS:
// - Usa sin() y cos() para loops perfectos
// - max() y min() para limitar valores
// - mod() para repetir animaciones
// - Renderiza primero en baja resolución para probar
// - 30 fps = KFF30 por segundo
// - Usa scripts para batch rendering
//
// SCRIPT DE BATCH (bash):
// for i in {0..29}; do
//   povray archivo.pov +KFI$i +KFF29 +W640 +H480 +O"frame_$i.png"
// done
//
// Luego combinar con ffmpeg:
// ffmpeg -framerate 30 -i frame_%d.png -c:v libx264 -pix_fmt yuv420p out.mp4
// ============================================================================
