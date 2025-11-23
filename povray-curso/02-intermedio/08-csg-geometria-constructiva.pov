// ============================================================================
// EJEMPLO 08: CSG - GEOMETRÍA SÓLIDA CONSTRUCTIVA
// ============================================================================
// CSG (Constructive Solid Geometry) permite crear formas complejas combinando
// formas simples usando operaciones booleanas.
//
// CONCEPTOS QUE APRENDERÁS:
// - Union: Combinar objetos
// - Difference: Restar objetos
// - Intersection: Intersección de objetos
// - Merge: Unión sin superficies internas
// - Aplicaciones prácticas de CSG
//
// CÓMO RENDERIZAR:
// povray 08-csg-geometria-constructiva.pov +W1000 +H800 +A
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
  location <0, 8, -15>
  look_at <0, 2, 0>
  angle 60
}

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
// 1. UNION - COMBINAR OBJETOS
// ----------------------------------------------------------------------------
// Une múltiples objetos en uno solo
// Las superficies internas SE mantienen (pueden verse si hay transparencia)

union {
  sphere {
    <-0.5, 0, 0>, 0.7
    pigment { color rgbf <1, 0.3, 0.3, 0.3> }  // Rojo semi-transparente
  }

  sphere {
    <0.5, 0, 0>, 0.7
    pigment { color rgbf <0.3, 0.3, 1, 0.3> }  // Azul semi-transparente
  }

  finish {
    ambient 0.2
    diffuse 0.7
    phong 0.8
  }

  translate <-6, 1.5, 4>
}

text {
  ttf "timrom.ttf" "UNION" 0.05, 0
  scale 0.35
  translate <-6.5, 3.2, 4>
  pigment { color White }
  finish { ambient 0.6 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// 2. MERGE - UNIÓN SIN SUPERFICIES INTERNAS
// ----------------------------------------------------------------------------
// Similar a union pero ELIMINA las superficies internas
// Mejor para objetos transparentes

merge {
  sphere {
    <-0.5, 0, 0>, 0.7
    pigment { color rgbf <1, 0.3, 0.3, 0.3> }
  }

  sphere {
    <0.5, 0, 0>, 0.7
    pigment { color rgbf <0.3, 0.3, 1, 0.3> }
  }

  finish {
    ambient 0.1
    diffuse 0.6
    phong 0.9
  }

  interior { ior 1.5 }  // Para transparencia realista

  translate <-3, 1.5, 4>
}

text {
  ttf "timrom.ttf" "MERGE" 0.05, 0
  scale 0.35
  translate <-3.5, 3.2, 4>
  pigment { color White }
  finish { ambient 0.6 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// 3. DIFFERENCE - SUSTRACCIÓN
// ----------------------------------------------------------------------------
// Resta el segundo objeto del primero (como tallar)

difference {
  // Objeto base
  sphere {
    <0, 0, 0>, 0.8
    pigment { color Green }
  }

  // Objetos a restar
  sphere {
    <-0.5, 0, 0>, 0.5
  }

  sphere {
    <0.5, 0, 0>, 0.5
  }

  finish {
    ambient 0.2
    diffuse 0.7
    phong 0.6
  }

  translate <0, 1.5, 4>
}

text {
  ttf "timrom.ttf" "DIFFERENCE" 0.05, 0
  scale 0.3
  translate <-0.9, 3.2, 4>
  pigment { color White }
  finish { ambient 0.6 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// 4. INTERSECTION - INTERSECCIÓN
// ----------------------------------------------------------------------------
// Solo mantiene la parte donde TODOS los objetos se superponen

intersection {
  sphere {
    <-0.4, 0, 0>, 0.7
    pigment { color Yellow }
  }

  sphere {
    <0.4, 0, 0>, 0.7
    pigment { color Cyan }
  }

  sphere {
    <0, 0.4, 0>, 0.7
    pigment { color Magenta }
  }

  finish {
    ambient 0.2
    diffuse 0.7
    phong 0.8
  }

  translate <3, 1.5, 4>
}

text {
  ttf "timrom.ttf" "INTERSECTION" 0.05, 0
  scale 0.27
  translate <2, 3.2, 4>
  pigment { color White }
  finish { ambient 0.6 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// 5. APLICACIÓN: TORNILLO
// ----------------------------------------------------------------------------

union {
  // Cabeza del tornillo (hexagonal usando intersection)
  intersection {
    cylinder {
      <0, 0.5, 0>, <0, 0.7, 0>, 0.5
    }

    box { <-0.6, 0.5, -0.35>, <0.6, 0.7, 0.35> }
    box { <-0.35, 0.5, -0.6>, <0.35, 0.7, 0.6> }
    box { <-0.6, 0.5, -0.35>, <0.6, 0.7, 0.35> rotate <0, 60, 0> }
  }

  // Ranura en la cabeza (usando difference)
  difference {
    cylinder {
      <0, 0.65, 0>, <0, 0.75, 0>, 0.4
    }

    box {
      <-0.5, 0.64, -0.05>, <0.5, 0.76, 0.05>
    }
  }

  // Cuerpo del tornillo
  cylinder {
    <0, 0, 0>, <0, 0.5, 0>, 0.2
  }

  // Punta
  cone {
    <0, 0, 0>, 0.2
    <0, -0.3, 0>, 0
  }

  pigment { color rgb <0.7, 0.7, 0.75> }

  finish {
    ambient 0.2
    diffuse 0.6
    phong 0.9
    metallic
    reflection 0.3
  }

  translate <6, 1.5, 4>
}

text {
  ttf "timrom.ttf" "TORNILLO" 0.05, 0
  scale 0.3
  translate <5.4, 3.2, 4>
  pigment { color White }
  finish { ambient 0.6 diffuse 0.5 }
}

// ----------------------------------------------------------------------------
// FILA INFERIOR: APLICACIONES PRÁCTICAS
// ----------------------------------------------------------------------------

// 6. TUBO (Cilindro hueco)
difference {
  cylinder {
    <0, 0, 0>, <0, 1.5, 0>, 0.5  // Cilindro exterior
    pigment { color rgb <0.8, 0.4, 0.2> }
  }

  cylinder {
    <0, -0.1, 0>, <0, 1.6, 0>, 0.35  // Cilindro interior (hueco)
  }

  finish {
    ambient 0.2
    diffuse 0.7
    phong 0.5
  }

  translate <-6, 0, 0>
}

text {
  ttf "timrom.ttf" "TUBO" 0.05, 0
  scale 0.3
  translate <-6.3, 2, 0>
  pigment { color White }
  finish { ambient 0.6 diffuse 0.5 }
}

// 7. DADO (Cubo con agujeros)
difference {
  // Cubo base con bordes redondeados
  superellipsoid {
    <0.1, 0.1>
    scale 0.6
  }

  // Agujero 1 (cara frontal, centro)
  sphere { <0, 0, 0.65>, 0.12 }

  // Agujeros 2 (cara trasera, esquinas)
  sphere { <-0.25, 0.25, -0.65>, 0.12 }
  sphere { <0.25, -0.25, -0.65>, 0.12 }

  // Agujeros 3 (cara izquierda)
  sphere { <-0.65, 0.3, 0>, 0.12 }
  sphere { <-0.65, 0, 0>, 0.12 }
  sphere { <-0.65, -0.3, 0>, 0.12 }

  // Agujeros 4 (cara derecha, cuadrado)
  sphere { <0.65, 0.25, 0.25>, 0.12 }
  sphere { <0.65, 0.25, -0.25>, 0.12 }
  sphere { <0.65, -0.25, 0.25>, 0.12 }
  sphere { <0.65, -0.25, -0.25>, 0.12 }

  // Agujeros 5 (cara superior, X)
  sphere { <0.3, 0.65, 0.3>, 0.12 }
  sphere { <0.3, 0.65, -0.3>, 0.12 }
  sphere { <0, 0.65, 0>, 0.12 }
  sphere { <-0.3, 0.65, 0.3>, 0.12 }
  sphere { <-0.3, 0.65, -0.3>, 0.12 }

  // Agujeros 6 (cara inferior, 3x2)
  sphere { <-0.25, -0.65, 0.3>, 0.12 }
  sphere { <-0.25, -0.65, 0>, 0.12 }
  sphere { <-0.25, -0.65, -0.3>, 0.12 }
  sphere { <0.25, -0.65, 0.3>, 0.12 }
  sphere { <0.25, -0.65, 0>, 0.12 }
  sphere { <0.25, -0.65, -0.3>, 0.12 }

  pigment { color rgb <0.95, 0.95, 0.95> }

  finish {
    ambient 0.2
    diffuse 0.7
    phong 0.8
  }

  rotate <25, 35, 15>
  translate <-4, 1.2, 0>
}

text {
  ttf "timrom.ttf" "DADO" 0.05, 0
  scale 0.3
  translate <-4.3, 2, 0>
  pigment { color White }
  finish { ambient 0.6 diffuse 0.5 }
}

// 8. COPA/VASO
difference {
  // Cuerpo exterior
  merge {
    cone {
      <0, 0, 0>, 0.5
      <0, 1.2, 0>, 0.6
    }

    torus {
      0.6, 0.05
      translate <0, 1.2, 0>
    }
  }

  // Interior (hueco)
  cone {
    <0, 0.1, 0>, 0.42
    <0, 1.25, 0>, 0.52
  }

  pigment {
    color rgbf <0.9, 0.95, 1, 0.8>  // Vidrio transparente
  }

  finish {
    ambient 0.0
    diffuse 0.3
    phong 1
    reflection { 0.1, 0.3 fresnel on }
  }

  interior {
    ior 1.5
  }

  translate <-2, 0, 0>
}

text {
  ttf "timrom.ttf" "COPA" 0.05, 0
  scale 0.3
  translate <-2.4, 2, 0>
  pigment { color White }
  finish { ambient 0.6 diffuse 0.5 }
}

// 9. ENGRANAJE SIMPLE
union {
  // Centro
  cylinder {
    <0, -0.2, 0>, <0, 0.2, 0>, 0.3
  }

  // Dientes (usando intersection)
  #declare Diente = box {
    <-0.1, -0.2, 0.3>, <0.1, 0.2, 0.7>
  }

  #declare I = 0;
  #while (I < 12)
    object {
      Diente
      rotate <0, I*30, 0>
    }
    #declare I = I + 1;
  #end

  // Agujero central
  difference {
    cylinder { <0, -0.25, 0>, <0, 0.25, 0>, 0.15 }
  }

  pigment { color rgb <0.5, 0.5, 0.6> }

  finish {
    ambient 0.2
    diffuse 0.6
    phong 0.8
    metallic
    reflection 0.2
  }

  rotate <90, 0, 0>
  translate <0, 1, 0>
}

text {
  ttf "timrom.ttf" "ENGRANAJE" 0.05, 0
  scale 0.27
  translate <-0.9, 2, 0>
  pigment { color White }
  finish { ambient 0.6 diffuse 0.5 }
}

// 10. LLAVE
union {
  // Cabeza de la llave (círculo con agujero)
  difference {
    cylinder {
      <0, 0, -0.1>, <0, 0, 0.1>, 0.4
    }

    cylinder {
      <0, 0, -0.15>, <0, 0, 0.15>, 0.2
    }
  }

  // Cuerpo
  box {
    <-0.1, -0.15, -0.1>, <1.2, 0.15, 0.1>
  }

  // Dientes
  box { <0.6, -0.15, -0.15>, <0.75, -0.35, 0.1> }
  box { <0.9, -0.15, -0.15>, <1.05, -0.3, 0.1> }
  box { <1.1, -0.15, -0.15>, <1.2, -0.4, 0.1> }

  pigment { color rgb <0.8, 0.7, 0.3> }

  finish {
    ambient 0.2
    diffuse 0.6
    phong 0.9
    metallic
    reflection 0.4
  }

  rotate <0, 0, -90>
  translate <2, 1.2, 0>
}

text {
  ttf "timrom.ttf" "LLAVE" 0.05, 0
  scale 0.3
  translate <1.5, 2, 0>
  pigment { color White }
  finish { ambient 0.6 diffuse 0.5 }
}

// 11. ESTRELLA 3D
intersection {
  // Dos cajas cruzadas
  box {
    <-1, -0.3, -0.3>, <1, 0.3, 0.3>
  }

  box {
    <-0.3, -1, -0.3>, <0.3, 1, 0.3>
  }

  box {
    <-0.3, -0.3, -1>, <0.3, 0.3, 1>
  }

  // Esfera para redondear
  sphere {
    <0, 0, 0>, 1.2
  }

  pigment { color rgb <1, 0.8, 0.2> }

  finish {
    ambient 0.3
    diffuse 0.7
    phong 0.9
  }

  scale 0.5
  rotate <30, 45, 20>
  translate <4, 1.2, 0>
}

text {
  ttf "timrom.ttf" "ESTRELLA" 0.05, 0
  scale 0.28
  translate <3.3, 2, 0>
  pigment { color White }
  finish { ambient 0.6 diffuse 0.5 }
}

// 12. TAZA CON ASA
union {
  // Cuerpo de la taza
  difference {
    cylinder {
      <0, 0, 0>, <0, 1, 0>, 0.5
    }

    cylinder {
      <0, 0.1, 0>, <0, 1.1, 0>, 0.42
    }
  }

  // Asa (usando torus y difference)
  difference {
    torus {
      0.4, 0.1
      rotate <0, 0, 90>
      translate <0, 0.5, 0>
    }

    box {
      <-1, -1, -1>, <0.1, 2, 1>
    }

    translate <0.5, 0, 0>
  }

  pigment { color rgb <0.8, 0.3, 0.3> }

  finish {
    ambient 0.2
    diffuse 0.7
    phong 0.6
  }

  translate <6, 0, 0>
}

text {
  ttf "timrom.ttf" "TAZA" 0.05, 0
  scale 0.3
  translate <5.7, 2, 0>
  pigment { color White }
  finish { ambient 0.6 diffuse 0.5 }
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
    reflection 0.12
  }
}

// ----------------------------------------------------------------------------
// FONDO
// ----------------------------------------------------------------------------

background { color rgb <0.3, 0.4, 0.6> }

// ============================================================================
// EJERCICIOS PARA PRACTICAR:
// ============================================================================
// 1. UNION vs MERGE:
//    - Crea dos esferas transparentes con union
//    - Repítelas con merge
//    - Observa la diferencia en las superficies internas
//
// 2. DIFFERENCE:
//    - Crea un cubo con agujeros circulares en cada cara
//    - Crea una esfera con un cubo sustraído del centro
//    - Crea texto tallado en una superficie
//
// 3. INTERSECTION:
//    - Intersecta un cubo y una esfera para crear esquinas redondeadas
//    - Intersecta tres cilindros perpendiculares
//    - Crea formas geométricas complejas
//
// 4. OBJETOS PRÁCTICOS:
//    - Diseña una tuerca hexagonal
//    - Crea un botón con agujeros
//    - Modela una rueda dentada completa
//    - Diseña una llave Allen (hexagonal)
//
// 5. PROYECTO: AJEDREZ COMPLETO
//    - Torre: Cilindro con almenas (usando difference)
//    - Alfil: Cono con corte diagonal (difference)
//    - Caballo: Combinación compleja (union + difference)
//    - Rey/Reina: Corona usando intersection y union
//
// 6. PROYECTO: CASA
//    - Paredes: Box con ventanas (difference)
//    - Puerta: Box sustraído de la pared
//    - Techo: Prisma o cono
//    - Chimenea: Cilindro en el techo
// ============================================================================

// ============================================================================
// REFERENCIA DE CSG:
// ============================================================================
//
// OPERACIONES CSG:
//
// 1. UNION { objeto1 objeto2 ... }
//    - Combina objetos
//    - Mantiene superficies internas
//    - Más rápido que merge
//    - Usar para objetos opacos
//
// 2. MERGE { objeto1 objeto2 ... }
//    - Combina objetos
//    - ELIMINA superficies internas
//    - Mejor para objetos transparentes
//    - Más lento que union
//
// 3. DIFFERENCE { objeto_base objeto_a_restar ... }
//    - Resta objetos del primero
//    - El PRIMER objeto es la base
//    - Los DEMÁS se restan
//    - Útil para crear huecos
//
// 4. INTERSECTION { objeto1 objeto2 ... }
//    - Solo mantiene partes comunes
//    - Donde TODOS los objetos se superponen
//    - Útil para limitar formas
//
// CONSEJOS:
//
// - En DIFFERENCE, hacer el objeto a restar ligeramente MÁS GRANDE
//   que el hueco deseado (evita problemas de coincidencia)
//
// - Orden importa en DIFFERENCE (primer objeto = base)
//
// - MERGE es preferible para vidrio, agua, cristal
//
// - UNION es más rápido, usar cuando sea posible
//
// - Combinar CSG con transformaciones para geometría compleja
//
// EJEMPLO DE OBJETO COMPLEJO:
// union {
//   difference {
//     sphere { <0,0,0>, 1 }
//     cylinder { <0,-1,0>, <0,1,0>, 0.5 }
//   }
//
//   intersection {
//     box { <-0.5,-0.5,-0.5>, <0.5,0.5,0.5> }
//     sphere { <0,0,0>, 0.7 }
//   }
//
//   translate <x, y, z>
// }
// ============================================================================
