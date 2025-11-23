// ============================================================================
// EJEMPLO 11: MACROS Y PROGRAMACIÓN - Automatización Avanzada
// ============================================================================
// POV-Ray incluye un lenguaje de programación completo que permite crear
// escenas complejas de forma procedural.
//
// CONCEPTOS QUE APRENDERÁS:
// - Declaraciones y variables
// - Macros y funciones
// - Bucles (while, for)
// - Condicionales (if-else)
// - Arrays
// - Generación procedural de geometría
//
// CÓMO RENDERIZAR:
// povray 11-macros-programacion.pov +W800 +H600 +A
// ============================================================================

#version 3.7;

#include "colors.inc"
#include "math.inc"

global_settings {
  assumed_gamma 1.0
}

// ----------------------------------------------------------------------------
// CÁMARA Y LUCES
// ----------------------------------------------------------------------------

camera {
  location <0, 10, -25>
  look_at <0, 2, 0>
  angle 50
}

light_source {
  <15, 30, -25>
  color White * 1.3
}

light_source {
  <-10, 15, -15>
  color White * 0.5
  shadowless
}

// ----------------------------------------------------------------------------
// 1. DECLARACIONES Y VARIABLES
// ----------------------------------------------------------------------------

// Declarar constantes
#declare RadioBase = 0.5;
#declare AlturaColumna = 3;
#declare ColorBase = rgb <0.8, 0.8, 0.85>;

// Usar las variables
cylinder {
  <0, 0, 0>, <0, AlturaColumna, 0>, RadioBase

  pigment { color ColorBase }

  finish {
    ambient 0.2
    diffuse 0.7
    phong 0.6
  }

  translate <-10, 0, 5>
}

// ----------------------------------------------------------------------------
// 2. EXPRESIONES MATEMÁTICAS
// ----------------------------------------------------------------------------

#declare PI = 3.14159265359;
#declare NumEsferas = 8;
#declare RadioCirculo = 3;

// Crear círculo de esferas usando matemáticas
#declare I = 0;
#while (I < NumEsferas)
  #declare Angulo = (I / NumEsferas) * 2 * PI;
  #declare PosX = RadioCirculo * cos(Angulo);
  #declare PosZ = RadioCirculo * sin(Angulo);

  sphere {
    <PosX, 1, PosZ>, 0.4

    pigment {
      color rgb <
        0.5 + 0.5 * cos(Angulo),
        0.5 + 0.5 * sin(Angulo),
        0.8
      >
    }

    finish { ambient 0.2 diffuse 0.7 phong 0.8 }

    translate <-10, 0, -5>
  }

  #declare I = I + 1;
#end

// ----------------------------------------------------------------------------
// 3. MACROS SIMPLES
// ----------------------------------------------------------------------------

// Definir una macro que crea una columna decorativa
#macro Columna(Posicion, Altura, Radio, ColorCol)
  union {
    // Base
    cylinder {
      <0, 0, 0>, <0, 0.3, 0>, Radio * 1.3
    }

    // Cuerpo
    cylinder {
      <0, 0.3, 0>, <0, Altura - 0.3, 0>, Radio
    }

    // Capitel
    cone {
      <0, Altura - 0.3, 0>, Radio * 1.2
      <0, Altura, 0>, Radio * 1.4
    }

    pigment { color ColorCol }
    finish { ambient 0.2 diffuse 0.7 phong 0.5 }

    translate Posicion
  }
#end

// Usar la macro
Columna(<0, 0, 5>, 4, 0.3, Red)
Columna(<2, 0, 5>, 3.5, 0.25, Green)
Columna(<4, 0, 5>, 4.5, 0.35, Blue)

// ----------------------------------------------------------------------------
// 4. MACRO CON LÓGICA CONDICIONAL
// ----------------------------------------------------------------------------

#macro Pieza Ajedrez(Tipo, Posicion, EsBlanca)
  #local ColorPieza = (EsBlanca ? White : rgb <0.2, 0.2, 0.2>);

  union {
    // Base común
    cylinder {
      <0, 0, 0>, <0, 0.2, 0>, 0.4
    }

    // Forma según el tipo
    #if (strcmp(Tipo, "peon") = 0)
      sphere { <0, 0.6, 0>, 0.3 }
      cone { <0, 0.2, 0>, 0.35, <0, 0.5, 0>, 0.25 }

    #else
      #if (strcmp(Tipo, "torre") = 0)
        cylinder { <0, 0.2, 0>, <0, 0.8, 0>, 0.3 }
        difference {
          cylinder { <0, 0.8, 0>, <0, 1, 0>, 0.35 }
          box { <-0.4, 0.85, -0.15>, <0.4, 1.1, 0.15> }
          box { <-0.15, 0.85, -0.4>, <0.15, 1.1, 0.4> }
        }

      #else
        // Default: reina
        cone { <0, 0.2, 0>, 0.35, <0, 0.7, 0>, 0.2 }
        sphere { <0, 0.9, 0>, 0.25 }
      #end
    #end

    pigment { color ColorPieza }
    finish { ambient 0.2 diffuse 0.7 phong 0.8 }

    translate Posicion
  }
#end

// Usar la macro con diferentes parámetros
PiezaAjedrez("peon", <-5, 0, 0>, yes)
PiezaAjedrez("peon", <-4, 0, 0>, no)
PiezaAjedrez("torre", <-3, 0, 0>, yes)
PiezaAjedrez("reina", <-2, 0, 0>, no)

// ----------------------------------------------------------------------------
// 5. ARRAYS
// ----------------------------------------------------------------------------

// Declarar un array de colores
#declare Colores = array[6] {
  Red, Orange, Yellow, Green, Blue, Violet
}

// Usar el array
#declare I = 0;
#while (I < 6)
  sphere {
    <I * 1.2 - 3, 1.5, -5>, 0.4

    pigment { color Colores[I] }
    finish { ambient 0.2 diffuse 0.7 phong 0.9 }
  }

  #declare I = I + 1;
#end

// ----------------------------------------------------------------------------
// 6. MACRO RECURSIVA - ÁRBOL FRACTAL
// ----------------------------------------------------------------------------

#macro Rama(Profundidad, Largo, Grosor)
  #if (Profundidad > 0)
    // Tronco de la rama
    cylinder {
      <0, 0, 0>, <0, Largo, 0>, Grosor

      pigment {
        color rgb <0.4 + Profundidad*0.1, 0.25, 0.15>
      }

      finish { ambient 0.2 diffuse 0.7 }
    }

    // Ramas recursivas
    union {
      object {
        Rama(Profundidad - 1, Largo * 0.7, Grosor * 0.7)
        rotate <0, 0, -25>
      }

      object {
        Rama(Profundidad - 1, Largo * 0.7, Grosor * 0.7)
        rotate <0, 0, 25>
      }

      object {
        Rama(Profundidad - 1, Largo * 0.65, Grosor * 0.7)
        rotate <-25, 0, 0>
      }

      translate <0, Largo, 0>
    }
  #end
#end

// Crear árbol fractal
object {
  Rama(4, 1.5, 0.15)
  translate <7, 0, 0>
}

// ----------------------------------------------------------------------------
// 7. GENERACIÓN PROCEDURAL - ESCALERA ESPIRAL
// ----------------------------------------------------------------------------

#macro EscaleraEspiral(NumEscalones, Radio, AlturaPorEscalon, RotacionPorEscalon)
  #declare I = 0;
  #while (I < NumEscalones)
    box {
      <-0.6, 0, -0.3>, <0.6, 0.1, 0.3>

      pigment {
        color rgb <0.6, 0.5, 0.4>
      }

      finish { ambient 0.2 diffuse 0.7 }

      translate <Radio, I * AlturaPorEscalon, 0>
      rotate <0, I * RotacionPorEscalon, 0>
    }

    #declare I = I + 1;
  #end
#end

EscaleraEspiral(20, 3, 0.25, 15)
object {
  EscaleraEspiral(20, 3, 0.25, 15)
  translate <10, 0, -5>
}

// ----------------------------------------------------------------------------
// 8. MACRO PARA GENERAR TEXTO 3D AUTOMÁTICO
// ----------------------------------------------------------------------------

#macro LetreroGrande(Texto, Posicion, ColorTexto, Escala)
  text {
    ttf "timrom.ttf" Texto 0.2, 0

    pigment { color ColorTexto }

    finish {
      ambient 0.2
      diffuse 0.7
      phong 0.6
    }

    scale Escala
    translate Posicion
  }
#end

LetreroGrande("POV-Ray", <-3, 6, 0>, rgb <1, 0.8, 0.2>, 0.8)
LetreroGrande("Macros", <-2, 5, 0>, rgb <0.2, 0.8, 1>, 0.5)

// ----------------------------------------------------------------------------
// 9. FUNCIÓN MATEMÁTICA - SUPERFICIE PARAMÉTRICA
// ----------------------------------------------------------------------------

#macro SuperficieOnda(TamX, TamZ, Resolucion, Amplitud, Frecuencia)
  mesh {
    #declare X = -TamX;
    #while (X < TamX)
      #declare Z = -TamZ;
      #while (Z < TamZ)
        #declare X1 = X;
        #declare Z1 = Z;
        #declare Y1 = Amplitud * sin(sqrt(X1*X1 + Z1*Z1) * Frecuencia);

        #declare X2 = X + Resolucion;
        #declare Z2 = Z;
        #declare Y2 = Amplitud * sin(sqrt(X2*X2 + Z2*Z2) * Frecuencia);

        #declare X3 = X + Resolucion;
        #declare Z3 = Z + Resolucion;
        #declare Y3 = Amplitud * sin(sqrt(X3*X3 + Z3*Z3) * Frecuencia);

        #declare X4 = X;
        #declare Z4 = Z + Resolucion;
        #declare Y4 = Amplitud * sin(sqrt(X4*X4 + Z4*Z4) * Frecuencia);

        // Dos triángulos por cuadrado
        triangle {
          <X1, Y1, Z1>, <X2, Y2, Z2>, <X3, Y3, Z3>
        }
        triangle {
          <X1, Y1, Z1>, <X3, Y3, Z3>, <X4, Y4, Z4>
        }

        #declare Z = Z + Resolucion;
      #end
      #declare X = X + Resolucion;
    #end

    pigment {
      color rgb <0.3, 0.6, 0.9>
    }

    finish {
      ambient 0.2
      diffuse 0.7
      phong 0.8
    }
  }
#end

object {
  SuperficieOnda(3, 3, 0.2, 0.5, 2)
  translate <0, 0, -10>
}

// ----------------------------------------------------------------------------
// 10. MACRO CON BUCLE FOR (emulado)
// ----------------------------------------------------------------------------

#macro Grid(Ancho, Profundo, Espaciado)
  union {
    #declare X = 0;
    #while (X <= Ancho)
      cylinder {
        <X, 0, 0>, <X, 0, Profundo>, 0.02
        pigment { color rgb <0.7, 0.7, 0.7> }
      }
      #declare X = X + Espaciado;
    #end

    #declare Z = 0;
    #while (Z <= Profundo)
      cylinder {
        <0, 0, Z>, <Ancho, 0, Z>, 0.02
        pigment { color rgb <0.7, 0.7, 0.7> }
      }
      #declare Z = Z + Espaciado;
    #end

    finish { ambient 0.3 diffuse 0.6 }
  }
#end

// No mostrar el grid en esta escena para no saturar

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

background { color rgb <0.4, 0.5, 0.7> }

// ============================================================================
// EJERCICIOS PARA PRACTICAR:
// ============================================================================
// 1. VARIABLES:
//    - Crea variables para colores personalizados
//    - Usa expresiones matemáticas (sin, cos, sqrt)
//    - Combina variables en cálculos complejos
//
// 2. BUCLES:
//    - Crea un patrón de cubos apilados
//    - Genera una espiral de esferas
//    - Crea una cuadrícula 3D de objetos
//
// 3. MACROS SIMPLES:
//    - Macro para crear una casa
//    - Macro para crear un árbol
//    - Macro para crear una silla
//
// 4. CONDICIONALES:
//    - Macro que cambia forma según parámetro
//    - Validación de parámetros (if valor > max...)
//    - Alternancia de patrones (if mod(i, 2) = 0...)
//
// 5. ARRAYS:
//    - Array de posiciones aleatorias
//    - Array de tamaños progresivos
//    - Array multidimensional
//
// 6. RECURSIÓN:
//    - Crear un copo de nieve fractal
//    - Torre de Hanoi
//    - Triángulo de Sierpinski
//
// 7. PROYECTO: CIUDAD PROCEDURAL
//    - Macro para edificios de diferentes alturas
//    - Grid de calles
//    - Posicionamiento aleatorio
//    - Variación en colores y tamaños
//
// 8. PROYECTO: GALAXIA
//    - Espiral logarítmica de estrellas
//    - Diferentes tamaños y colores
//    - Uso de rand() para variación
// ============================================================================

// ============================================================================
// REFERENCIA DE PROGRAMACIÓN:
// ============================================================================
//
// DECLARACIONES:
// #declare Nombre = Valor;
// #local Nombre = Valor;      // Local a macro/bucle
//
// TIPOS DE DATOS:
// - Números: 1, 3.14, -5
// - Vectores: <1, 2, 3>
// - Colores: rgb <r, g, b>
// - Strings: "texto"
// - Objetos: sphere { ... }
//
// OPERADORES MATEMÁTICOS:
// +, -, *, /                   // Básicos
// sin(), cos(), tan()          // Trigonométricas
// sqrt(), pow(base, exp)       // Potencias
// abs(), floor(), ceil()       // Redondeo
// min(), max()                 // Comparación
// mod(a, b)                    // Módulo
//
// OPERADORES LÓGICOS:
// =, !=                        // Igualdad
// <, >, <=, >=                 // Comparación
// &, |, !                      // AND, OR, NOT
//
// BUCLES:
// #while (condición)
//   // código
// #end
//
// CONDICIONALES:
// #if (condición)
//   // código
// #else
//   // código alternativo
// #end
//
// #ifdef (Variable)            // Si está definida
// #ifndef (Variable)           // Si NO está definida
//
// MACROS:
// #macro NombreMacro(Param1, Param2, ...)
//   // código
// #end
//
// Llamar: NombreMacro(valor1, valor2, ...)
//
// ARRAYS:
// #declare MiArray = array[tamaño]
// #declare MiArray = array[n] { val1, val2, ... }
// Acceso: MiArray[índice]
//
// STRINGS:
// strcmp(str1, str2)           // Comparar (0 si iguales)
// strlen(str)                  // Longitud
// substr(str, pos, len)        // Subcadena
// concat(str1, str2, ...)      // Concatenar
// str(val, len, dec)           // Número a string
//
// ALEATORIOS:
// #declare R = seed(N);        // Inicializar generador
// rand(R)                      // Número aleatorio [0, 1)
//
// FUNCIONES:
// #declare Func = function { expresión }
// Evaluar: Func(x, y, z)
//
// INCLUSIÓN DE ARCHIVOS:
// #include "archivo.inc"       // Incluir archivo
//
// DIRECTIVAS ÚTILES:
// #debug "mensaje\n"           // Imprimir a consola
// #warning "aviso\n"           // Advertencia
// #error "error\n"             // Error y detener
//
// VARIABLES ESPECIALES:
// clock                        // Para animaciones (0 a 1)
// frame_number                 // Número de frame
// image_width, image_height    // Resolución
//
// EJEMPLO COMPLETO:
// #macro EsferaAleatoria(Semilla)
//   #local R = seed(Semilla);
//   sphere {
//     <rand(R)*10-5, rand(R)*3, rand(R)*10-5>, rand(R)*0.5+0.3
//     pigment { color rgb <rand(R), rand(R), rand(R)> }
//   }
// #end
//
// #declare I = 0;
// #while (I < 50)
//   EsferaAleatoria(I)
//   #declare I = I + 1;
// #end
// ============================================================================
