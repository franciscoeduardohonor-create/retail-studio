# 📚 Guía de Referencia Rápida - POV-Ray

Esta guía proporciona una referencia concisa de los elementos más importantes de POV-Ray para consulta rápida.

## 📑 Índice

- [Estructura Básica](#estructura-básica)
- [Primitivas Geométricas](#primitivas-geométricas)
- [Transformaciones](#transformaciones)
- [Cámara](#cámara)
- [Iluminación](#iluminación)
- [Materiales](#materiales)
- [CSG](#csg-geometría-constructiva)
- [Texturas Procedurales](#texturas-procedurales)
- [Programación](#programación)
- [Animación](#animación)
- [Parámetros de Render](#parámetros-de-render)

---

## Estructura Básica

```povray
#version 3.7;
#include "colors.inc"

global_settings {
  assumed_gamma 1.0
}

camera {
  location <0, 2, -5>
  look_at <0, 0, 0>
  angle 50
}

light_source {
  <2, 4, -3>
  color White
}

// Tus objetos aquí
sphere {
  <0, 0, 0>, 1
  pigment { color Red }
  finish { ambient 0.2 diffuse 0.7 }
}
```

---

## Primitivas Geométricas

### Esfera
```povray
sphere {
  <centro_x, centro_y, centro_z>, radio
}
```

### Cubo/Caja
```povray
box {
  <x1, y1, z1>,  // Esquina inferior
  <x2, y2, z2>   // Esquina superior
}
```

### Cilindro
```povray
cylinder {
  <base_x, base_y, base_z>,
  <tope_x, tope_y, tope_z>,
  radio
}
```

### Cono
```povray
cone {
  <base_x, base_y, base_z>, radio_base,
  <punta_x, punta_y, punta_z>, radio_punta
}
```

### Plano
```povray
plane {
  <normal_x, normal_y, normal_z>, distancia
}
```

### Torus (Dona)
```povray
torus {
  radio_mayor,
  radio_menor
}
```

---

## Transformaciones

```povray
// Mover
translate <x, y, z>

// Rotar (grados)
rotate <x_grados, y_grados, z_grados>

// Escalar
scale <x, y, z>      // No uniforme
scale N              // Uniforme

// Orden típico:
rotate <...>
scale <...>
translate <...>
```

---

## Cámara

### Cámara Básica
```povray
camera {
  location <x, y, z>    // Posición
  look_at <x, y, z>     // Punto de enfoque
  angle 45              // Campo de visión
}
```

### Con Depth of Field
```povray
camera {
  location <x, y, z>
  look_at <x, y, z>
  angle 45

  aperture 0.3          // Desenfoque
  blur_samples 20       // Calidad
  focal_point <x, y, z> // Punto enfocado
}
```

---

## Iluminación

### Luz Puntual
```povray
light_source {
  <x, y, z>
  color White
}
```

### Luz de Área (sombras suaves)
```povray
light_source {
  <x, y, z>
  color White

  area_light <ancho, 0, 0>, <0, alto, 0>, 5, 5
  adaptive 1
  jitter
}
```

### Spotlight
```povray
light_source {
  <x, y, z>
  color White

  spotlight
  point_at <target_x, target_y, target_z>
  radius 15       // Ángulo interno
  falloff 25      // Ángulo externo
  tightness 10    // Concentración
}
```

### Luz con Atenuación
```povray
light_source {
  <x, y, z>
  color White * 2

  fade_distance 5  // Distancia de intensidad completa
  fade_power 2     // Tipo de decay (2 = realista)
}
```

---

## Materiales

### Pigmento (Color)
```povray
pigment {
  color rgb <red, green, blue>
  color rgbf <r, g, b, filter>  // Con transparencia
}
```

### Finish (Acabado)
```povray
finish {
  ambient 0.2      // Luz ambiente
  diffuse 0.7      // Reflexión difusa (mate)
  specular 0.5     // Brillo especular
  roughness 0.05   // Rugosidad (con specular)
  phong 0.8        // Brillo Phong (alternativa a specular)
  phong_size 60    // Tamaño del brillo
  reflection 0.3   // Reflexión (0-1)
  metallic         // Comportamiento metálico
}
```

### Vidrio
```povray
pigment { color rgbf <1, 1, 1, 0.95> }

finish {
  ambient 0
  diffuse 0.05
  specular 1
  roughness 0.001
  reflection { 0.02, 0.98 fresnel on }
}

interior {
  ior 1.5  // Índice de refracción
}
```

### Metal
```povray
pigment { color rgb <1, 0.85, 0.2> }  // Oro

finish {
  ambient 0
  diffuse 0.2
  specular 0.9
  roughness 0.01
  metallic
  reflection { 0.8 metallic }
}
```

---

## CSG (Geometría Constructiva)

### Union (Combinar)
```povray
union {
  sphere { <0, 0, 0>, 1 }
  box { <-1, -1, -1>, <1, 1, 1> }
  pigment { color Red }
}
```

### Difference (Restar)
```povray
difference {
  sphere { <0, 0, 0>, 1 }     // Base
  cylinder { <0, -2, 0>, <0, 2, 0>, 0.5 }  // Restar
  pigment { color Green }
}
```

### Intersection (Intersección)
```povray
intersection {
  sphere { <0, 0, 0>, 1 }
  box { <-0.7, -0.7, -0.7>, <0.7, 0.7, 0.7> }
  pigment { color Blue }
}
```

### Merge (Union sin superficies internas)
```povray
merge {
  sphere { <-0.5, 0, 0>, 0.7 }
  sphere { <0.5, 0, 0>, 0.7 }
  pigment { color rgbf <1, 1, 1, 0.9> }
  interior { ior 1.5 }
}
```

---

## Texturas Procedurales

### Patrones Comunes
```povray
pigment {
  checker               // Tablero de ajedrez
  color Color1
  color Color2
  scale 0.5
}

pigment {
  wood                  // Madera
  turbulence 0.05
  color_map { ... }
  scale 0.3
}

pigment {
  marble                // Mármol
  turbulence 0.6
  color_map { ... }
}

pigment {
  granite               // Granito
  turbulence 0.5
  color_map { ... }
}

pigment {
  bozo                  // Nubes
  turbulence 0.8
  color_map { ... }
}
```

### Color Map
```povray
pigment {
  gradient y

  color_map {
    [0.0 color Blue]
    [0.5 color Green]
    [1.0 color Red]
  }
}
```

---

## Programación

### Variables
```povray
#declare MiRadio = 1.5;
#declare MiColor = rgb <1, 0, 0>;

sphere {
  <0, 0, 0>, MiRadio
  pigment { color MiColor }
}
```

### Bucles
```povray
#declare I = 0;
#while (I < 10)
  sphere {
    <I, 0, 0>, 0.5
    pigment { color rgb <I/10, 0, 1-I/10> }
  }
  #declare I = I + 1;
#end
```

### Condicionales
```povray
#if (Condicion)
  // código si verdadero
#else
  // código si falso
#end
```

### Macros
```povray
#macro MiEsfera(Posicion, Radio, ColorObj)
  sphere {
    Posicion, Radio
    pigment { color ColorObj }
  }
#end

// Usar macro
MiEsfera(<0, 1, 0>, 0.5, Red)
```

### Arrays
```povray
#declare MisColores = array[3] {
  Red, Green, Blue
}

sphere {
  <0, 0, 0>, 1
  pigment { color MisColores[0] }
}
```

---

## Animación

### Usar Clock
```povray
// clock va de 0.0 a 1.0 durante la animación

// Rotación
rotate <0, clock * 360, 0>

// Movimiento
translate <clock * 10, 0, 0>

// Interpolación
#declare Inicio = <0, 0, 0>;
#declare Fin = <5, 2, 0>;
#declare Posicion = Inicio + (Fin - Inicio) * clock;
```

### Renderizar Animación
```bash
# 30 frames
povray archivo.pov +KFF30 +W640 +H480 +A

# 100 frames, alta calidad
povray archivo.pov +KFF100 +W1920 +H1080 +A0.3
```

---

## Parámetros de Render

### Resolución
```bash
+W640 +H480      # 640x480
+W800 +H600      # 800x600
+W1920 +H1080    # Full HD
+W3840 +H2160    # 4K
```

### Antialiasing
```bash
+A               # Antialiasing básico
+A0.3            # Threshold 0.3 (menor = mejor)
+AM2             # Modo 2
+R3              # Recursión 3
```

### Calidad
```bash
+Q0              # Muy baja (wireframe)
+Q5              # Media
+Q9              # Alta
+Q11             # Máxima
```

### Otros
```bash
-D               # Sin display durante render
+P               # Pausar al terminar
+V               # Verbose (información detallada)
+O"archivo.png"  # Nombre de salida
```

### Ejemplo Completo
```bash
povray escena.pov +W1920 +H1080 +A0.3 +AM2 +R5 +Q11 +O"render_final.png"
```

---

## 🎯 Valores de Referencia Rápida

### Índices de Refracción (IOR)
- Vacío: 1.0
- Aire: 1.000293
- Agua: 1.33
- Vidrio: 1.5 - 1.9
- Cristal: 1.5
- Diamante: 2.417

### Temperaturas de Color
- Sol directo: `rgb <1, 1, 0.95>`
- Cielo nublado: `rgb <0.8, 0.9, 1>`
- Tungsteno: `rgb <1, 0.8, 0.6>`
- Vela: `rgb <1, 0.7, 0.4>`
- Atardecer: `rgb <1, 0.6, 0.3>`
- Luna: `rgb <0.7, 0.8, 1>`

### Sistema de Coordenadas
```
     +Y (arriba)
      |
      |
      +------- +X (derecha)
     /
    /
  +Z (hacia ti)
```

---

## 💡 Consejos Rápidos

1. **Ambient con Radiosity**: Si usas radiosity, `ambient` debe ser 0
2. **Orden de transformaciones**: `rotate` → `scale` → `translate`
3. **Objetos transparentes**: Usa `merge` en lugar de `union`
4. **Hollow**: Necesario para `interior` con `media`
5. **Renderizado rápido**: Empieza con baja resolución (+W320 +H240)
6. **Photons**: Solo para caustics, añade tiempo de render
7. **Area lights**: Mejoran sombras pero aumentan tiempo de render

---

## 🔗 Recursos

- **Documentación oficial**: [wiki.povray.org](http://wiki.povray.org)
- **Galería**: [povray.org/showcase](http://www.povray.org/showcase/)
- **Include files**: En tu instalación de POV-Ray
- **Ejemplos de este curso**: Carpetas `01-principiante`, `02-intermedio`, `03-avanzado`

---

**Última actualización**: 2024
