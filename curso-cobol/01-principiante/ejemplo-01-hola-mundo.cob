      ******************************************************************
      * EJEMPLO 1: HOLA MUNDO EN COBOL
      * Descripción: El programa más simple - muestra un mensaje
      * Autor: Curso de COBOL
      * Fecha: 2024
      ******************************************************************

      *----------------------------------------------------------------*
      * IDENTIFICATION DIVISION: Identifica el programa
      *----------------------------------------------------------------*
       IDENTIFICATION DIVISION.
       PROGRAM-ID. HOLA-MUNDO.
       AUTHOR. ESTUDIANTE-COBOL.
       DATE-WRITTEN. 2024-11-23.

      *----------------------------------------------------------------*
      * ENVIRONMENT DIVISION: Configuración del entorno
      * (No necesaria para este programa simple)
      *----------------------------------------------------------------*
       ENVIRONMENT DIVISION.

      *----------------------------------------------------------------*
      * DATA DIVISION: Definición de datos
      * (No necesaria para este programa simple)
      *----------------------------------------------------------------*
       DATA DIVISION.

      *----------------------------------------------------------------*
      * PROCEDURE DIVISION: Lógica del programa
      *----------------------------------------------------------------*
       PROCEDURE DIVISION.

      *--- Párrafo principal ---*
       MAIN-LOGIC.
           DISPLAY "========================================".
           DISPLAY "    BIENVENIDO AL MUNDO DE COBOL       ".
           DISPLAY "========================================".
           DISPLAY " ".
           DISPLAY "Hola Mundo desde COBOL!".
           DISPLAY " ".
           DISPLAY "Este es tu primer programa COBOL.".
           DISPLAY "COBOL sigue siendo relevante en 2024!".
           DISPLAY " ".
           DISPLAY "========================================".

           STOP RUN.

      *----------------------------------------------------------------*
      * EXPLICACIÓN:
      *
      * 1. IDENTIFICATION DIVISION - Metadatos del programa
      *    - PROGRAM-ID: Nombre único del programa
      *    - AUTHOR: Quien lo escribió
      *    - DATE-WRITTEN: Fecha de creación
      *
      * 2. DISPLAY - Muestra texto en pantalla
      *    - Similar a print() en Python o console.log() en JavaScript
      *    - Cada DISPLAY muestra una línea
      *
      * 3. STOP RUN - Termina el programa
      *    - Siempre debe estar al final
      *    - Devuelve control al sistema operativo
      *
      * PARA COMPILAR Y EJECUTAR:
      * cobc -x -free ejemplo-01-hola-mundo.cob
      * ./ejemplo-01-hola-mundo
      *----------------------------------------------------------------*
