# Módulo 3: Subrutinas y Funciones

## 🎯 Objetivos del Módulo

Al completar este módulo, serás capaz de:
- Crear y usar funciones personalizadas
- Implementar subrutinas
- Entender el paso de argumentos
- Usar argumentos por referencia y valor
- Crear funciones recursivas
- Organizar código de manera modular

## 📝 Contenido

1. **01_funciones_basicas.f90** - Funciones definidas por el usuario
2. **02_subrutinas.f90** - Subrutinas y procedimientos
3. **03_argumentos.f90** - Paso de argumentos (intent)
4. **04_funciones_recursivas.f90** - Recursividad
5. **05_ejemplos_practicos.f90** - Aplicaciones reales

## 💡 Conceptos Clave

### Función
```fortran
real function nombre(x, y)
    real, intent(in) :: x, y
    nombre = x + y
end function nombre
```

### Subrutina
```fortran
subroutine nombre(input, output)
    real, intent(in) :: input
    real, intent(out) :: output
    output = input * 2
end subroutine nombre
```

## Diferencias clave
- **Funciones**: Retornan un solo valor
- **Subrutinas**: Pueden modificar múltiples argumentos
