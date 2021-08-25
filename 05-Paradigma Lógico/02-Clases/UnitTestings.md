# TRABAJO PRACTICO NUMERO 2 - Mi Cursada Universitaria

Pruebas Unitarias
TP 2021 - Lógico

## Parte 1: Las materias

### esPesada

```prolog
17 ?- esPesada(Materia).
Materia = analisisdeSistemas ;
Materia = diseniodeSistemas ;
Materia = administraciondeRecursos ;
Materia = algebrayGeometriaAnalitica ;
Materia = algoritmoyEstructurasdeDatos ;
Materia = arquitecturadeComputadoras ;
Materia = sintaxisySemanticadelosLenguajes ;
```

### materiaInicial

```prolog
27 ?- materiaInicial(Materia).
Materia = analisisMatematicoI ;
Materia = algebrayGeometriaAnalitica ;
Materia = matematicaDiscreta ;
Materia = sistemasyOrganizaciones ;
Materia = algoritmoyEstructurasdeDatos ;
Materia = arquitecturadeComputadoras ;
Materia = fisicaI ;
Materia = inglesI ;
Materia = quimica ;
Materia = sistemasdeRepresentacion ;
Materia = ingenieriaySociedad ;

91 ?- materiaInicial(analisisMatematicoI). 
true.

92 ?- materiaInicial(proyectoFinal).       

```

### listadoDeCorrelativas

```prolog
5 ?- listadoDeCorrelativas(fisicaII,Correlativas). 
Correlativas = [fisicaI, analisisMatematicoI].

7 ?- listadoDeCorrelativas(diseniodeSistemas,Listado).                
Listado = [analisisdeSistemas, paradigmasdeProgramacion, sistemasyOrganizaciones, algoritmoyEstructurasdeDatos, matematicaDiscreta].

68 ?- listadoDeCorrelativas(proyectoFinal,Listado).
Listado = [analisisMatematicoI, algebrayGeometriaAnalitica, matematicaDiscreta, sistemasyOrganizaciones, algoritmoyEstructurasdeDatos, arquitecturadeComputadoras, ingenieriaySociedad, quimica, fisicaI|...].
```

### habilitaA

```prolog
23 ?- habilitaA(analisisdeSistemas,Habilitadas).
Habilitadas = [diseniodeSistemas, comunicaciones, economia, legislacion, proyectoFinal, redesdeInformacion, administraciondeRecursos, ingenieriadeSoftware, inteligenciaArtificial|...].

24 ?- habilitaA(comunicaciones,Habilitadas).     
Habilitadas = [redesdeInformacion, proyectoFinal].

69 ?- habilitaA(proyectoFinal,Habilitadas).
Habilitadas = [].
```

## Parte 2: Cursada

### anioQueCurso

```prolog
14 ?- anioQueCurso(juan,Materia,Anio).
Materia = discreta,
Anio = 2020 ;
Materia = paradigmas,
Anio = 2021 ;

28 ?- anioQueCurso(Persona,paradigmasdeProgramacion,Anio). 
Persona = juana,
Anio = 2014 ;
Persona = juana,
Anio = 2015 ;
Persona = tarciso,
Anio = 2020 ;
Persona = personaUltimoAnio,
Anio = 2017 ;
Persona = juan,
Anio = 2021 ;

```

### aproboCursada

```prolog
29 ?- aproboCursada(juana,paradigmasdeProgramacion).
true ;

30 ?- aproboCursada(juan,paradigmasdeProgramacion).  

31 ?- aproboCursada(Persona,paradigmasdeProgramacion). 
Persona = juana ;
Persona = tarciso ;
Persona = personaUltimoAnio.

33 ?- aproboCursada(juan,Materia).                   
Materia = matematicaDiscreta ;
Materia = arquitecturadeComputadoras.
```

### recursoMateria

```prolog
47 ?- recursoMateria(juan,arquitecturadeComputadoras).
true .

48 ?- recursoMateria(juan,Materias).                   
Materias = arquitecturadeComputadoras .

49 ?- recursoMateria(Persona,Materias). 
Persona = juana,
Materias = paradigmasdeProgramacion ;
Persona = juana,
Materias = paradigmasdeProgramacion ;
Persona = juan,
Materias = arquitecturadeComputadoras .
```
