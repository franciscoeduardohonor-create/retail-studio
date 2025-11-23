# Módulo 7: Módulos y Paquetes 📦

## Objetivos

- ✅ Crear módulos personalizados
- ✅ Usar el gestor de paquetes (Pkg)
- ✅ Importar y exportar funciones
- ✅ Documentar código
- ✅ Escribir tests

## Conceptos Clave

```julia
# Crear un módulo
module MiModulo
    export funcion_publica

    function funcion_publica()
        println("Esta es pública")
    end

    function funcion_privada()
        println("Esta es privada")
    end
end

# Usar el módulo
using .MiModulo
funcion_publica()

# Gestión de paquetes
using Pkg
Pkg.add("DataFrames")
Pkg.update()
Pkg.status()

# Tests
using Test
@test 2 + 2 == 4
@test_throws DivideError 1 ÷ 0
```

---

➡️ **Siguiente:** [Módulo 8: Programación Paralela](../modulo-08-paralelo/README.md)
