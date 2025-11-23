# Módulo 2: Estructuras de Control y Arreglos

## 🎯 Objetivos del Módulo

Al completar este módulo, serás capaz de:
- Usar estructuras condicionales (IF, SELECT CASE)
- Implementar bucles (DO, DO WHILE)
- Trabajar con arreglos unidimensionales y multidimensionales
- Manipular matrices
- Resolver problemas con ciclos anidados

## 📝 Contenido

### Estructuras de Control
1. **01_if_simple.f90** - Condicionales básicos
2. **02_if_anidado.f90** - Condicionales anidados
3. **03_select_case.f90** - Selección múltiple
4. **04_bucle_do.f90** - Bucles DO básicos
5. **05_do_while.f90** - Bucles condicionales
6. **06_bucles_anidados.f90** - Ciclos anidados

### Arreglos
7. **07_arreglos_1d.f90** - Arreglos unidimensionales
8. **08_arreglos_2d.f90** - Matrices (arreglos 2D)
9. **09_operaciones_arreglos.f90** - Operaciones con arreglos
10. **10_arreglos_dinamicos.f90** - Arreglos dinámicos

## 💡 Conceptos Clave

### Estructura IF
```fortran
if (condicion) then
    ! código si es verdadero
else if (otra_condicion) then
    ! código alternativo
else
    ! código por defecto
end if
```

### Bucle DO
```fortran
do i = inicio, fin, incremento
    ! código que se repite
end do
```

### Arreglos
```fortran
! Declaración
integer, dimension(10) :: numeros
real :: matriz(3,3)

! Asignación
numeros(1) = 5
matriz(1,2) = 3.14
```

## 🚀 Compilar y ejecutar

```bash
gfortran -o programa archivo.f90
./programa
```

## ✏️ Ejercicios

Al final del módulo encontrarás ejercicios prácticos para dominar estos conceptos.
