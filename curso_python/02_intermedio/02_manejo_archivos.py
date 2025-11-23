"""
===============================================================================
CURSO PYTHON - NIVEL INTERMEDIO
Módulo 2: Manejo de Archivos
===============================================================================
En este módulo aprenderás:
- Abrir y cerrar archivos
- Leer archivos (read, readline, readlines)
- Escribir archivos (write, writelines)
- Modos de apertura
- Context manager (with)
- Trabajar con CSV
- Trabajar con JSON
- Manejo de rutas con pathlib
===============================================================================
"""

import os
import csv
import json
from pathlib import Path

# ============================================================================
# 1. LEER ARCHIVOS - Método básico
# ============================================================================
print("=== LEER ARCHIVOS ===\n")

# Crear un archivo de ejemplo primero
contenido_ejemplo = """Python es un lenguaje increíble.
Es fácil de aprender y muy poderoso.
Se usa en desarrollo web, ciencia de datos, IA y más.
¡Aprender Python es una excelente inversión!"""

# Escribir archivo de ejemplo
with open("ejemplo.txt", "w", encoding="utf-8") as archivo:
    archivo.write(contenido_ejemplo)

print("--- Leer archivo completo con read() ---")
# Abrir archivo para lectura
archivo = open("ejemplo.txt", "r", encoding="utf-8")
contenido = archivo.read()
print(contenido)
archivo.close()  # IMPORTANTE: siempre cerrar el archivo

print("\n" + "="*70 + "\n")

# ============================================================================
# 2. CONTEXT MANAGER (WITH)
# ============================================================================
print("=== CONTEXT MANAGER - Forma recomendada ===\n")

# Usando 'with' - cierra el archivo automáticamente
print("--- Leer con 'with' ---")
with open("ejemplo.txt", "r", encoding="utf-8") as archivo:
    contenido = archivo.read()
    print(contenido)
# El archivo se cierra automáticamente al salir del bloque

print("\n" + "="*70 + "\n")

# ============================================================================
# 3. DIFERENTES FORMAS DE LEER
# ============================================================================
print("=== DIFERENTES FORMAS DE LEER ===\n")

print("--- readline() - Lee línea por línea ---")
with open("ejemplo.txt", "r", encoding="utf-8") as archivo:
    linea1 = archivo.readline()
    linea2 = archivo.readline()
    print(f"Línea 1: {linea1.strip()}")
    print(f"Línea 2: {linea2.strip()}")

print()

print("--- readlines() - Lee todas las líneas en una lista ---")
with open("ejemplo.txt", "r", encoding="utf-8") as archivo:
    lineas = archivo.readlines()
    print(f"Total de líneas: {len(lineas)}")
    for i, linea in enumerate(lineas, start=1):
        print(f"{i}. {linea.strip()}")

print()

print("--- Iterar directamente sobre el archivo ---")
with open("ejemplo.txt", "r", encoding="utf-8") as archivo:
    for numero, linea in enumerate(archivo, start=1):
        print(f"[{numero}] {linea.strip()}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 4. ESCRIBIR ARCHIVOS
# ============================================================================
print("=== ESCRIBIR ARCHIVOS ===\n")

print("--- Modo 'w' - Sobrescribe el archivo ---")
with open("nuevo_archivo.txt", "w", encoding="utf-8") as archivo:
    archivo.write("Esta es la primera línea\n")
    archivo.write("Esta es la segunda línea\n")
    archivo.write("Esta es la tercera línea\n")

print("✓ Archivo 'nuevo_archivo.txt' creado")

# Leer y mostrar
with open("nuevo_archivo.txt", "r", encoding="utf-8") as archivo:
    print(archivo.read())

print()

print("--- Modo 'a' - Agrega al final del archivo ---")
with open("nuevo_archivo.txt", "a", encoding="utf-8") as archivo:
    archivo.write("Esta línea fue agregada después\n")

print("✓ Contenido agregado")

with open("nuevo_archivo.txt", "r", encoding="utf-8") as archivo:
    print(archivo.read())

print()

print("--- writelines() - Escribir lista de líneas ---")
lineas = [
    "Línea A\n",
    "Línea B\n",
    "Línea C\n"
]

with open("lineas.txt", "w", encoding="utf-8") as archivo:
    archivo.writelines(lineas)

print("✓ Archivo 'lineas.txt' creado")

print("\n" + "="*70 + "\n")

# ============================================================================
# 5. MODOS DE APERTURA
# ============================================================================
print("=== MODOS DE APERTURA ===\n")

print("""
┌──────┬────────────────────────────────────────────────────────┐
│ Modo │ Descripción                                            │
├──────┼────────────────────────────────────────────────────────┤
│ 'r'  │ Lectura (read) - Error si no existe                   │
│ 'w'  │ Escritura (write) - Crea o sobrescribe                │
│ 'a'  │ Agregar (append) - Crea o agrega al final             │
│ 'r+' │ Lectura y escritura                                    │
│ 'x'  │ Creación exclusiva - Error si ya existe               │
│ 'b'  │ Modo binario (combinar con otros: 'rb', 'wb')        │
│ 't'  │ Modo texto (default)                                   │
└──────┴────────────────────────────────────────────────────────┘

Siempre usar encoding='utf-8' para soportar caracteres especiales
""")

print("="*70 + "\n")

# ============================================================================
# 6. VERIFICAR SI EXISTE UN ARCHIVO
# ============================================================================
print("=== VERIFICAR EXISTENCIA DE ARCHIVOS ===\n")

import os

archivos = ["ejemplo.txt", "no_existe.txt"]

for archivo in archivos:
    if os.path.exists(archivo):
        print(f"✓ {archivo} existe")
        print(f"  Tamaño: {os.path.getsize(archivo)} bytes")
    else:
        print(f"✗ {archivo} NO existe")

print("\n" + "="*70 + "\n")

# ============================================================================
# 7. TRABAJAR CON CSV
# ============================================================================
print("=== TRABAJAR CON ARCHIVOS CSV ===\n")

print("--- Escribir CSV ---")

# Datos de ejemplo
empleados = [
    ["Nombre", "Edad", "Departamento", "Salario"],
    ["Juan Pérez", 30, "IT", 45000],
    ["María García", 28, "Ventas", 38000],
    ["Carlos López", 35, "IT", 50000],
    ["Ana Martínez", 32, "Marketing", 42000],
]

# Escribir CSV
with open("empleados.csv", "w", newline="", encoding="utf-8") as archivo:
    escritor = csv.writer(archivo)
    escritor.writerows(empleados)

print("✓ Archivo 'empleados.csv' creado")
print()

print("--- Leer CSV ---")
with open("empleados.csv", "r", encoding="utf-8") as archivo:
    lector = csv.reader(archivo)
    for fila in lector:
        print(fila)

print()

print("--- Leer CSV con DictReader (diccionarios) ---")
with open("empleados.csv", "r", encoding="utf-8") as archivo:
    lector = csv.DictReader(archivo)
    for fila in lector:
        print(f"{fila['Nombre']:20} - {fila['Departamento']:12} - ${float(fila['Salario']):>8,.2f}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 8. TRABAJAR CON JSON
# ============================================================================
print("=== TRABAJAR CON ARCHIVOS JSON ===\n")

print("--- Escribir JSON ---")

# Datos en estructura Python
datos_producto = {
    "nombre": "Laptop Dell",
    "precio": 15000,
    "especificaciones": {
        "procesador": "Intel i7",
        "ram": "16GB",
        "almacenamiento": "512GB SSD"
    },
    "disponible": True,
    "colores": ["Negro", "Plata", "Azul"],
    "calificacion": 4.5
}

# Guardar en JSON
with open("producto.json", "w", encoding="utf-8") as archivo:
    json.dump(datos_producto, archivo, indent=2, ensure_ascii=False)

print("✓ Archivo 'producto.json' creado")
print()

print("--- Leer JSON ---")
with open("producto.json", "r", encoding="utf-8") as archivo:
    producto_leido = json.load(archivo)

print("Datos leídos del JSON:")
print(json.dumps(producto_leido, indent=2, ensure_ascii=False))

print()
print(f"Nombre: {producto_leido['nombre']}")
print(f"Precio: ${producto_leido['precio']:,}")
print(f"Procesador: {producto_leido['especificaciones']['procesador']}")
print(f"Colores disponibles: {', '.join(producto_leido['colores'])}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 9. PATHLIB - Manejo moderno de rutas
# ============================================================================
print("=== PATHLIB - Manejo de rutas ===\n")

from pathlib import Path

print("--- Crear rutas ---")
ruta = Path("carpeta/subcarpeta/archivo.txt")
print(f"Ruta: {ruta}")
print(f"Nombre: {ruta.name}")
print(f"Extensión: {ruta.suffix}")
print(f"Directorio padre: {ruta.parent}")

print()

print("--- Directorio actual ---")
directorio_actual = Path.cwd()
print(f"Directorio actual: {directorio_actual}")

print()

print("--- Crear directorios ---")
nueva_carpeta = Path("datos/procesados")
nueva_carpeta.mkdir(parents=True, exist_ok=True)
print(f"✓ Carpeta creada: {nueva_carpeta}")

print()

print("--- Listar archivos ---")
directorio = Path(".")
archivos_txt = list(directorio.glob("*.txt"))
print(f"Archivos .txt en el directorio actual:")
for archivo in archivos_txt:
    print(f"  • {archivo.name}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 10. EJEMPLO PRÁCTICO: GESTOR DE TAREAS
# ============================================================================
print("=== EJEMPLO PRÁCTICO: GESTOR DE TAREAS ===\n")

class GestorTareas:
    """Gestor de tareas que guarda en archivo JSON"""

    def __init__(self, archivo="tareas.json"):
        self.archivo = archivo
        self.tareas = self.cargar_tareas()

    def cargar_tareas(self):
        """Carga tareas del archivo JSON"""
        if os.path.exists(self.archivo):
            with open(self.archivo, "r", encoding="utf-8") as f:
                return json.load(f)
        return []

    def guardar_tareas(self):
        """Guarda tareas en archivo JSON"""
        with open(self.archivo, "w", encoding="utf-8") as f:
            json.dump(self.tareas, f, indent=2, ensure_ascii=False)

    def agregar_tarea(self, descripcion, prioridad="media"):
        """Agrega una nueva tarea"""
        tarea = {
            "id": len(self.tareas) + 1,
            "descripcion": descripcion,
            "prioridad": prioridad,
            "completada": False
        }
        self.tareas.append(tarea)
        self.guardar_tareas()
        print(f"✓ Tarea agregada: {descripcion}")

    def marcar_completada(self, id_tarea):
        """Marca una tarea como completada"""
        for tarea in self.tareas:
            if tarea["id"] == id_tarea:
                tarea["completada"] = True
                self.guardar_tareas()
                print(f"✓ Tarea #{id_tarea} completada")
                return
        print(f"✗ Tarea #{id_tarea} no encontrada")

    def listar_tareas(self):
        """Lista todas las tareas"""
        if not self.tareas:
            print("No hay tareas")
            return

        print("\nLISTA DE TAREAS")
        print("=" * 70)

        pendientes = [t for t in self.tareas if not t["completada"]]
        completadas = [t for t in self.tareas if t["completada"]]

        if pendientes:
            print("\n📋 PENDIENTES:")
            for tarea in pendientes:
                prioridad_emoji = {"alta": "🔴", "media": "🟡", "baja": "🟢"}
                emoji = prioridad_emoji.get(tarea["prioridad"], "⚪")
                print(f"  {emoji} [{tarea['id']}] {tarea['descripcion']}")

        if completadas:
            print("\n✅ COMPLETADAS:")
            for tarea in completadas:
                print(f"  [{tarea['id']}] {tarea['descripcion']}")

        print("=" * 70)

# Usar el gestor
gestor = GestorTareas()

# Agregar tareas
gestor.agregar_tarea("Aprender Python", "alta")
gestor.agregar_tarea("Hacer ejercicios de POO", "alta")
gestor.agregar_tarea("Leer documentación", "media")

# Listar tareas
gestor.listar_tareas()

# Completar una tarea
print()
gestor.marcar_completada(1)

# Listar nuevamente
gestor.listar_tareas()

print("\n" + "="*70 + "\n")

# ============================================================================
# 11. EJEMPLO PRÁCTICO: ANALIZADOR DE LOG
# ============================================================================
print("=== EJEMPLO PRÁCTICO: ANALIZADOR DE LOG ===\n")

# Crear archivo de log de ejemplo
log_ejemplo = """2024-01-15 10:23:45 INFO Usuario login exitoso: juan@email.com
2024-01-15 10:24:12 ERROR Fallo en base de datos: timeout
2024-01-15 10:25:33 INFO Nueva compra: $150.00
2024-01-15 10:26:41 WARNING Conexión lenta detectada
2024-01-15 10:27:58 ERROR Archivo no encontrado: config.xml
2024-01-15 10:28:15 INFO Usuario logout: juan@email.com
2024-01-15 10:29:22 ERROR Fallo en API: 500 Internal Server Error
2024-01-15 10:30:01 INFO Nueva compra: $85.50"""

with open("application.log", "w", encoding="utf-8") as f:
    f.write(log_ejemplo)

# Analizador de log
class AnalizadorLog:
    """Analiza archivos de log"""

    def __init__(self, archivo_log):
        self.archivo_log = archivo_log

    def analizar(self):
        """Analiza el archivo de log"""
        estadisticas = {
            "INFO": 0,
            "WARNING": 0,
            "ERROR": 0
        }

        errores = []

        with open(self.archivo_log, "r", encoding="utf-8") as archivo:
            for linea in archivo:
                # Contar por nivel
                if "INFO" in linea:
                    estadisticas["INFO"] += 1
                elif "WARNING" in linea:
                    estadisticas["WARNING"] += 1
                elif "ERROR" in linea:
                    estadisticas["ERROR"] += 1
                    errores.append(linea.strip())

        return estadisticas, errores

    def generar_reporte(self):
        """Genera un reporte del análisis"""
        estadisticas, errores = self.analizar()

        print("REPORTE DE ANÁLISIS DE LOG")
        print("=" * 70)
        print(f"\nArchivo: {self.archivo_log}")
        print(f"\nEstadísticas:")
        print(f"  ℹ️  INFO: {estadisticas['INFO']}")
        print(f"  ⚠️  WARNING: {estadisticas['WARNING']}")
        print(f"  ❌ ERROR: {estadisticas['ERROR']}")

        if errores:
            print(f"\nErrores encontrados ({len(errores)}):")
            for error in errores:
                print(f"  • {error}")

        print("=" * 70)

# Usar el analizador
analizador = AnalizadorLog("application.log")
analizador.generar_reporte()

print("\n" + "="*70 + "\n")

# ============================================================================
# 12. EJEMPLO PRÁCTICO: EXPORTADOR DE DATOS
# ============================================================================
print("=== EJEMPLO PRÁCTICO: EXPORTADOR DE DATOS ===\n")

class ExportadorDatos:
    """Exporta datos a diferentes formatos"""

    @staticmethod
    def exportar_csv(datos, nombre_archivo):
        """Exporta datos a CSV"""
        if not datos:
            print("No hay datos para exportar")
            return

        # Obtener encabezados de las claves del primer diccionario
        encabezados = list(datos[0].keys())

        with open(nombre_archivo, "w", newline="", encoding="utf-8") as f:
            escritor = csv.DictWriter(f, fieldnames=encabezados)
            escritor.writeheader()
            escritor.writerows(datos)

        print(f"✓ Datos exportados a {nombre_archivo}")

    @staticmethod
    def exportar_json(datos, nombre_archivo):
        """Exporta datos a JSON"""
        with open(nombre_archivo, "w", encoding="utf-8") as f:
            json.dump(datos, f, indent=2, ensure_ascii=False)

        print(f"✓ Datos exportados a {nombre_archivo}")

    @staticmethod
    def exportar_txt(datos, nombre_archivo):
        """Exporta datos a TXT formateado"""
        with open(nombre_archivo, "w", encoding="utf-8") as f:
            for item in datos:
                f.write("-" * 50 + "\n")
                for clave, valor in item.items():
                    f.write(f"{clave}: {valor}\n")
                f.write("\n")

        print(f"✓ Datos exportados a {nombre_archivo}")

# Datos de ejemplo
ventas = [
    {"fecha": "2024-01-15", "producto": "Laptop", "cantidad": 2, "total": 30000},
    {"fecha": "2024-01-16", "producto": "Mouse", "cantidad": 5, "total": 1500},
    {"fecha": "2024-01-17", "producto": "Teclado", "cantidad": 3, "total": 2400},
]

# Exportar en diferentes formatos
exportador = ExportadorDatos()
exportador.exportar_csv(ventas, "ventas.csv")
exportador.exportar_json(ventas, "ventas.json")
exportador.exportar_txt(ventas, "ventas.txt")

print("\n" + "="*70 + "\n")

# ============================================================================
# LIMPIAR ARCHIVOS DE EJEMPLO
# ============================================================================
print("=== Limpiando archivos de ejemplo ===\n")

archivos_a_eliminar = [
    "ejemplo.txt", "nuevo_archivo.txt", "lineas.txt",
    "empleados.csv", "producto.json", "tareas.json",
    "application.log", "ventas.csv", "ventas.json", "ventas.txt"
]

for archivo in archivos_a_eliminar:
    if os.path.exists(archivo):
        os.remove(archivo)
        print(f"✓ {archivo} eliminado")

# Eliminar carpeta de ejemplo
import shutil
if os.path.exists("datos"):
    shutil.rmtree("datos")
    print("✓ Carpeta 'datos' eliminada")

print("\n" + "="*70 + "\n")

# ============================================================================
# EJERCICIOS PARA PRACTICAR
# ============================================================================
print("EJERCICIOS PARA PRACTICAR:")
print("="*70)
print("""
1. Contador de palabras:
   - Lee un archivo de texto
   - Cuenta cuántas veces aparece cada palabra
   - Guarda el resultado en un archivo JSON

2. Fusionador de archivos:
   - Lee múltiples archivos .txt
   - Combina su contenido en un solo archivo
   - Agrega separadores entre archivos

3. Conversor CSV a JSON:
   - Lee un archivo CSV
   - Convierte los datos a formato JSON
   - Guarda en un archivo .json

4. Sistema de configuración:
   - Crea una clase Config que lea/escriba configuraciones en JSON
   - Métodos: get(clave), set(clave, valor), guardar(), cargar()

5. Analizador de ventas:
   - Lee CSV con ventas (fecha, producto, cantidad, precio)
   - Calcula: total vendido, producto más vendido, ventas por día
   - Genera reporte en TXT

6. Gestor de inventario:
   - Lee/escribe inventario en JSON
   - Funciones: agregar_producto(), actualizar_stock()
   - Genera reporte en CSV

7. Procesador de logs:
   - Lee archivo de log
   - Filtra solo errores
   - Guarda errores en archivo separado con timestamp

¡Practica con estos ejercicios para dominar el manejo de archivos!
""")
