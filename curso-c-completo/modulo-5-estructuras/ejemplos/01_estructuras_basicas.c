/*
 * ============================================================================
 * PROGRAMA: Estructuras (struct)
 * DESCRIPCIÓN: Agrupar datos relacionados
 * NIVEL: Intermedio-Avanzado
 * ============================================================================
 */

#include <stdio.h>
#include <string.h>

// ========== DEFINICIÓN DE ESTRUCTURAS ==========

/*
 * Una estructura agrupa variables de diferentes tipos
 * bajo un solo nombre
 */

struct Persona {
    char nombre[50];
    int edad;
    float altura;
};

// typedef para simplificar uso
typedef struct {
    char marca[30];
    char modelo[30];
    int anio;
    float precio;
} Coche;

// Estructura anidada
typedef struct {
    int dia;
    int mes;
    int anio;
} Fecha;

typedef struct {
    char nombre[50];
    Fecha fecha_nacimiento;
    float salario;
} Empleado;

// ========== ENUMERACIONES ==========

enum DiaSemana {
    LUNES = 1,
    MARTES,
    MIERCOLES,
    JUEVES,
    VIERNES,
    SABADO,
    DOMINGO
};

enum Estado {
    INACTIVO = 0,
    ACTIVO = 1
};

// ========== FUNCIONES ==========

void imprimir_persona(struct Persona p) {
    printf("Nombre: %s\n", p.nombre);
    printf("Edad: %d años\n", p.edad);
    printf("Altura: %.2f m\n", p.altura);
}

void imprimir_coche(Coche c) {
    printf("%s %s (%d) - $%.2f\n", c.marca, c.modelo, c.anio, c.precio);
}

// ========== FUNCIÓN PRINCIPAL ==========

int main() {

    printf("========== ESTRUCTURAS EN C ==========\n\n");

    // ========== CREAR Y USAR ESTRUCTURAS ==========

    printf("--- Estructura básica ---\n");

    // Declaración e inicialización
    struct Persona persona1;

    strcpy(persona1.nombre, "Juan Pérez");
    persona1.edad = 30;
    persona1.altura = 1.75;

    imprimir_persona(persona1);
    printf("\n");

    // Inicialización directa
    struct Persona persona2 = {"María García", 25, 1.68};

    imprimir_persona(persona2);
    printf("\n");

    // ========== TYPEDEF SIMPLIFICA EL CÓDIGO ==========

    printf("--- Con typedef ---\n");

    // Sin typedef: struct Coche miCoche;
    // Con typedef: Coche miCoche;

    Coche coche1 = {"Toyota", "Corolla", 2022, 25000.00};
    Coche coche2 = {"Honda", "Civic", 2023, 28000.00};

    imprimir_coche(coche1);
    imprimir_coche(coche2);
    printf("\n");

    // ========== ARRAY DE ESTRUCTURAS ==========

    printf("--- Array de estructuras ---\n");

    Coche inventario[3] = {
        {"Ford", "Mustang", 2021, 45000.00},
        {"Chevrolet", "Camaro", 2022, 42000.00},
        {"Dodge", "Challenger", 2023, 48000.00}
    };

    printf("Inventario de coches:\n");
    for (int i = 0; i < 3; i++) {
        printf("%d. ", i + 1);
        imprimir_coche(inventario[i]);
    }
    printf("\n");

    // ========== ESTRUCTURAS ANIDADAS ==========

    printf("--- Estructuras anidadas ---\n");

    Empleado emp1;
    strcpy(emp1.nombre, "Carlos López");
    emp1.fecha_nacimiento.dia = 15;
    emp1.fecha_nacimiento.mes = 3;
    emp1.fecha_nacimiento.anio = 1990;
    emp1.salario = 50000.00;

    printf("Empleado: %s\n", emp1.nombre);
    printf("Fecha de nacimiento: %02d/%02d/%d\n",
           emp1.fecha_nacimiento.dia,
           emp1.fecha_nacimiento.mes,
           emp1.fecha_nacimiento.anio);
    printf("Salario: $%.2f\n\n", emp1.salario);

    // ========== PUNTEROS A ESTRUCTURAS ==========

    printf("--- Punteros a estructuras ---\n");

    Coche *ptr_coche = &coche1;

    // Acceso con ->
    printf("Marca: %s\n", ptr_coche->marca);
    printf("Modelo: %s\n", ptr_coche->modelo);
    printf("Año: %d\n", ptr_coche->anio);
    printf("\n");

    // ========== ENUMERACIONES ==========

    printf("--- Enumeraciones ---\n");

    enum DiaSemana hoy = MIERCOLES;

    printf("Hoy es día número: %d\n", hoy);

    switch (hoy) {
        case LUNES:
        case MARTES:
        case MIERCOLES:
        case JUEVES:
        case VIERNES:
            printf("Es día laboral\n");
            break;
        case SABADO:
        case DOMINGO:
            printf("Es fin de semana\n");
            break;
    }

    printf("\n");

    // ========== EJEMPLO PRÁCTICO: SISTEMA DE ESTUDIANTES ==========

    printf("--- Sistema de estudiantes ---\n");

    typedef struct {
        char nombre[50];
        int matricula;
        float calificaciones[5];
        float promedio;
    } Estudiante;

    Estudiante estudiante1 = {
        "Ana Rodríguez",
        12345,
        {8.5, 9.0, 7.5, 9.5, 8.0},
        0.0
    };

    // Calcular promedio
    float suma = 0;
    for (int i = 0; i < 5; i++) {
        suma += estudiante1.calificaciones[i];
    }
    estudiante1.promedio = suma / 5;

    printf("Estudiante: %s\n", estudiante1.nombre);
    printf("Matrícula: %d\n", estudiante1.matricula);
    printf("Calificaciones: ");
    for (int i = 0; i < 5; i++) {
        printf("%.1f ", estudiante1.calificaciones[i]);
    }
    printf("\nPromedio: %.2f\n", estudiante1.promedio);

    return 0;
}

/*
 * CONCEPTOS CLAVE:
 *
 * DECLARACIÓN DE STRUCT:
 *   struct Nombre {
 *       tipo miembro1;
 *       tipo miembro2;
 *   };
 *
 * ACCESO A MIEMBROS:
 *   variable.miembro           // Con variable
 *   puntero->miembro          // Con puntero
 *
 * TYPEDEF:
 *   typedef struct {
 *       ...
 *   } Nombre;
 *
 * ENUMERACIONES:
 *   enum Nombre {
 *       VALOR1,
 *       VALOR2
 *   };
 *
 * VENTAJAS:
 * - Organiza datos relacionados
 * - Código más legible
 * - Facilita mantenimiento
 * - Permite crear tipos personalizados
 *
 * EJERCICIOS:
 * 1. Sistema de biblioteca (libros con título, autor, año)
 * 2. Registro de productos (nombre, precio, stock)
 * 3. Agenda de contactos (nombre, teléfono, email)
 * 4. Sistema de empleados con departamentos
 * 5. Juego con personajes (nombre, vida, ataque, defensa)
 */
