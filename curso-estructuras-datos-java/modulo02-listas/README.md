# Módulo 2: Listas Enlazadas

## 📚 Objetivos de Aprendizaje
- Entender la estructura y funcionamiento de las listas enlazadas
- Dominar las operaciones fundamentales: inserción, eliminación, búsqueda
- Implementar listas simplemente y doblemente enlazadas desde cero
- Resolver problemas comunes con listas enlazadas
- Aplicar técnicas avanzadas (dos punteros, recursión)

## 📖 Contenido Teórico

### ¿Qué es una Lista Enlazada?

Una lista enlazada es una estructura de datos lineal donde cada elemento (nodo) contiene:
1. **Dato**: El valor almacenado
2. **Referencia**: Puntero al siguiente nodo

```
[Dato|→] -> [Dato|→] -> [Dato|→] -> null
```

### Tipos de Listas Enlazadas

#### 1. **Lista Simplemente Enlazada**
Cada nodo apunta al siguiente:
```
HEAD -> [A|→] -> [B|→] -> [C|→] -> null
```

#### 2. **Lista Doblemente Enlazada**
Cada nodo apunta al siguiente y al anterior:
```
null ← [←|A|→] ↔ [←|B|→] ↔ [←|C|→] -> null
```

#### 3. **Lista Circular**
El último nodo apunta al primero:
```
    ┌────────────────┐
    ↓                │
[A|→] -> [B|→] -> [C|→]
```

### Arrays vs Listas Enlazadas

| Característica | Array | Lista Enlazada |
|---------------|-------|----------------|
| Tamaño | Fijo | Dinámico |
| Acceso por índice | O(1) ⚡ | O(n) 🐢 |
| Insertar al inicio | O(n) | O(1) ⚡ |
| Insertar al final | O(1)* | O(1)* o O(n) |
| Eliminar elemento | O(n) | O(1)** |
| Memoria | Contigua | Dispersa |
| Espacio extra | Ninguno | Punteros |

\* Con puntero al final
\** Si tienes la referencia al nodo

### Complejidad de Operaciones

| Operación | Complejidad | Notas |
|-----------|-------------|-------|
| Insertar al inicio | O(1) | Muy eficiente |
| Insertar al final (sin tail) | O(n) | Requiere recorrer |
| Insertar al final (con tail) | O(1) | Con puntero tail |
| Eliminar al inicio | O(1) | Muy eficiente |
| Eliminar del final | O(n) | Incluso con tail* |
| Buscar elemento | O(n) | Recorrido lineal |
| Acceder por índice | O(n) | No hay acceso directo |

\* En lista simple; O(1) en lista doble

### Ventajas de Listas Enlazadas

✅ **Tamaño dinámico** - Crece según necesidad
✅ **Inserción/eliminación eficiente** - Especialmente al inicio
✅ **No desperdicia memoria** - Solo usa lo necesario
✅ **Fácil reorganización** - Solo cambiar punteros

### Desventajas

❌ **No hay acceso aleatorio** - Debe recorrer desde inicio
❌ **Memoria extra** - Punteros ocupan espacio
❌ **Cache unfriendly** - Nodos dispersos en memoria
❌ **Más compleja** - Más propensa a errores (punteros nulos)

## 📂 Ejemplos Prácticos

1. `ListaSimple.java` - Implementación básica completa
2. `ListaDoble.java` - Lista doblemente enlazada
3. `ListaCircular.java` - Lista circular
4. `OperacionesAvanzadas.java` - Reversión, ciclos, etc.
5. `ProblemasComunes.java` - Problemas de entrevistas

## ✏️ Ejercicios para Practicar

1. `Ejercicio01_OperacionesBasicas.java` - Insertar, eliminar, buscar
2. `Ejercicio02_ReversarLista.java` - Invertir lista
3. `Ejercicio03_DetectarCiclo.java` - Floyd's Algorithm
4. `Ejercicio04_EncontrarMedio.java` - Técnica dos punteros
5. `Ejercicio05_FusionarListas.java` - Merge de listas ordenadas

## 🎯 Conceptos Clave

### Nodo Básico
```java
class Nodo {
    int dato;
    Nodo siguiente;

    Nodo(int dato) {
        this.dato = dato;
        this.siguiente = null;
    }
}
```

### Técnicas Importantes

#### 1. **Dos Punteros (Fast & Slow)**
```
Slow: ------>
Fast: -------------->
```
Usado para:
- Encontrar el medio
- Detectar ciclos
- Encontrar k-ésimo desde el final

#### 2. **Puntero Dummy**
Nodo ficticio al inicio que simplifica código
```java
Nodo dummy = new Nodo(0);
dummy.siguiente = head;
```

#### 3. **Recursión**
Muchos problemas de listas se resuelven elegantemente con recursión.

## 🔥 Problemas Clásicos

1. **Reversión de lista** - Iterativa y recursiva
2. **Detectar ciclo** - Floyd's Cycle Detection
3. **Encontrar el medio** - Dos punteros
4. **Eliminar n-ésimo desde el final** - Dos punteros
5. **Fusionar listas ordenadas** - Merge
6. **Verificar si es palíndromo** - Reversión + comparación
7. **Intersección de listas** - Dos punteros
8. **Copiar lista con punteros aleatorios** - HashMap

## 🚀 Aplicaciones Reales

- **Navegador web**: Historial de páginas (adelante/atrás)
- **Editor de texto**: Deshacer/Rehacer
- **Sistema operativo**: Gestión de procesos
- **Reproductor de música**: Lista de reproducción
- **Implementación de Stack/Queue**: Usando listas
- **Tablas hash**: Manejo de colisiones (chaining)

## 💡 Tips y Buenas Prácticas

1. **Siempre verifica null** antes de acceder a `nodo.siguiente`
2. **Usa nodo dummy** para simplificar inserciones/eliminaciones
3. **Dibuja diagramas** para visualizar las operaciones
4. **Prueba casos extremos**:
   - Lista vacía
   - Un solo nodo
   - Dos nodos
5. **Ten cuidado con pérdida de nodos** - guarda referencias antes de modificar

## 🎓 Desafíos Avanzados

1. Implementa una lista que se auto-ordene
2. Crea una lista con skip pointers (búsqueda más rápida)
3. Implementa una lista con nivel de prioridad
4. Diseña un LRU Cache usando lista doble + hash
5. Implementa una XOR Linked List (lista enlazada usando XOR)
