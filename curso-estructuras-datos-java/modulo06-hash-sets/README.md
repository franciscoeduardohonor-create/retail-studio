# Módulo 6: Tablas Hash y Sets

## 📚 Objetivos
- Entender función hash
- Implementar HashMap desde cero
- Manejar colisiones
- Aplicar hash en problemas

## 📖 Conceptos

### Tabla Hash (HashMap)

Estructura que mapea claves a valores usando una función hash.

```
hash("Juan") = 3
hash("María") = 7

Tabla:
[0] → null
[1] → null
[2] → null
[3] → ["Juan", 25]
[4] → null
[5] → null
[6] → null
[7] → ["María", 30]
```

### Función Hash

Convierte clave → índice

```java
int hash(String key) {
    int hash = 0;
    for (char c : key.toCharArray()) {
        hash = hash * 31 + c;
    }
    return hash % tamaño;
}
```

### Colisiones

**Métodos de resolución:**

1. **Chaining (encadenamiento):**
   - Cada slot es una lista enlazada
   - Simple de implementar

2. **Open Addressing:**
   - Buscar siguiente slot disponible
   - Linear probing, quadratic probing

### Complejidad

| Operación | Promedio | Peor Caso |
|-----------|----------|-----------|
| Get       | O(1)     | O(n)*     |
| Put       | O(1)     | O(n)*     |
| Remove    | O(1)     | O(n)*     |

\* Con muchas colisiones

### HashSet

HashMap donde solo importa la clave (no el valor).

**Usos:**
- Eliminar duplicados: O(n)
- Verificar pertenencia: O(1)
- Operaciones de conjuntos

## 🎯 Aplicaciones
- Caché (LRU Cache)
- Índices de bases de datos
- Contadores de frecuencia
- Detección de duplicados
- Diccionarios

## 📂 Ejemplos
1. `HashMap.java` - Implementación básica
2. `HashSet.java` - Conjunto con hash
3. `Aplicaciones.java` - Problemas comunes

## 🔥 Problemas
- Two Sum (suma de dos)
- Anagramas
- LRU Cache
- Primeros elementos únicos
- Subcadena sin caracteres repetidos
