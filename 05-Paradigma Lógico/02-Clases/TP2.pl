% Base De Conocimientos --------------------------------------------------------
%Materias (Cantidad de Semanas en un Año Segun Calendario Universitario: 31 Semanas)
materia(analisisMatematicoI,155).
materia(algebrayGeometriaAnalitica,155).
materia(matematicaDiscreta,93).
materia(sistemasyOrganizaciones,93).
materia(algoritmoyEstructurasdeDatos,155).
materia(arquitecturadeComputadoras,124).
materia(ingenieriaySociedad,62).
materia(quimica,93).
materia(fisicaI,155).
materia(analisisMatematicoII,155).
materia(probabilidadyEstadistica,93).
materia(analisisdeSistemas,186).
materia(sintaxisySemanticadelosLenguajes,124).
materia(paradigmasdeProgramacion,124).
materia(inglesI,62).
materia(sistemasdeRepresentacion,93).
materia(sistemasOperativos,124).
materia(diseniodeSistemas,186).
materia(fisicaII,155).
materia(matematicaSuperior,124).
materia(gestiondeDatos,124).
materia(legislacion,62).
materia(economia,93).
materia(inglesII,62).
materia(redesdeInformacion,124).
materia(administraciondeRecursos,186).
materia(investigacionOperativa,155).
materia(simulacion,124).
materia(ingenieriadeSoftware,93).
materia(teoriadeControl,93).
materia(comunicaciones,124).
materia(proyectoFinal,186).
materia(inteligenciaArtificial,93).
materia(administracionGerencial,93).
materia(sistemasdeGestion,124).
%Integradoras
esIntegradora(sistemasyOrganizaciones).
esIntegradora(analisisdeSistemas).
esIntegradora(diseniodeSistemas).
esIntegradora(administraciondeRecursos).
esIntegradora(proyecto).
%Rendir Libre
rendirLibre(inglesI).
rendirLibre(inglesII).
%esCorrelativa (MateriaSuperior,Correlativa Necesaria)
esCorrelativa(analisisMatematicoII,algebrayGeometriaAnalitica).
esCorrelativa(analisisMatematicoII,analisisMatematicoI).
esCorrelativa(fisicaII,fisicaI).
esCorrelativa(fisicaII,analisisMatematicoI).
esCorrelativa(analisisdeSistemas,sistemasyOrganizaciones).
esCorrelativa(analisisdeSistemas,algoritmoyEstructurasdeDatos).
esCorrelativa(sintaxisySemanticadelosLenguajes,matematicaDiscreta).
esCorrelativa(sintaxisySemanticadelosLenguajes,algoritmoyEstructurasdeDatos).
esCorrelativa(paradigmasdeProgramacion,matematicaDiscreta).
esCorrelativa(paradigmasdeProgramacion,algoritmoyEstructurasdeDatos).
esCorrelativa(sistemasOperativos,matematicaDiscreta).
esCorrelativa(sistemasOperativos,algoritmoyEstructurasdeDatos).
esCorrelativa(sistemasOperativos,arquitecturadeComputadoras).
esCorrelativa(probabilidadyEstadistica,analisisMatematicoI).
esCorrelativa(probabilidadyEstadistica,algebrayGeometriaAnalitica).
esCorrelativa(diseniodeSistemas,analisisdeSistemas).
esCorrelativa(diseniodeSistemas,paradigmasdeProgramacion).
esCorrelativa(comunicaciones,paradigmasdeProgramacion).
esCorrelativa(comunicaciones,analisisdeSistemas).
esCorrelativa(matematicaSuperior,analisisMatematicoII).
esCorrelativa(matematicaSuperior,fisicaII).
esCorrelativa(matematicaSuperior,arquitecturadeComputadoras).
esCorrelativa(gestiondeDatos,analisisMatematicoII).
esCorrelativa(economia,analisisdeSistemas).
esCorrelativa(inglesII,inglesI).
esCorrelativa(redesdeInformacion,comunicaciones).
esCorrelativa(redesdeInformacion,analisisMatematicoII).
esCorrelativa(redesdeInformacion,fisicaII).
esCorrelativa(redesdeInformacion,sistemasOperativos).
esCorrelativa(administraciondeRecursos,diseniodeSistemas).
esCorrelativa(administraciondeRecursos,economia).
esCorrelativa(administraciondeRecursos,inglesI).
esCorrelativa(administraciondeRecursos,sistemasOperativos).
esCorrelativa(investigacionOperativa,matematicaSuperior).
esCorrelativa(investigacionOperativa,probabilidadyEstadistica).
esCorrelativa(simulacion,matematicaSuperior).
esCorrelativa(simulacion,probabilidadyEstadistica).
esCorrelativa(ingenieriadeSoftware,sintaxisySemanticadelosLenguajes).
esCorrelativa(ingenieriadeSoftware,probabilidadyEstadistica).
esCorrelativa(ingenieriadeSoftware,diseniodeSistemas).
esCorrelativa(ingenieriadeSoftware,gestiondeDatos).
esCorrelativa(teoriadeControl,quimica).
esCorrelativa(teoriadeControl,matematicaSuperior).
esCorrelativa(legislacion,analisisdeSistemas).
esCorrelativa(legislacion,ingenieriaySociedad).
esCorrelativa(inteligenciaArtificial,diseniodeSistemas).
esCorrelativa(inteligenciaArtificial,investigacionOperativa).
esCorrelativa(inteligenciaArtificial,simulacion).
esCorrelativa(administracionGerencial,diseniodeSistemas).
esCorrelativa(administracionGerencial,economia).
esCorrelativa(administracionGerencial,administraciondeRecursos).
esCorrelativa(administracionGerencial,investigacionOperativa).
esCorrelativa(sistemasdeGestion,administraciondeRecursos).
esCorrelativa(sistemasdeGestion,investigacionOperativa).
esCorrelativa(sistemasdeGestion,simulacion).
esCorrelativa(proyectoFinal,OtraMateria):- materia(OtraMateria,_), OtraMateria\=proyectoFinal.


%-----------------------------------------------------------------------------

% Parte 1: Las materias ------------------------------------------------------

%Integrante1 - PUNTO 1
esPesada(Materia):-
    materia(Materia,Horas),
    esIntegradora(Materia),
    Horas>100.

esPesada(Materia):-
    materia(Materia,_),
    string_length(Materia,Longitud),
    Longitud > 25.


%PUNTO 2 - INCISO A - TODOS

materiaInicial(Materia):-
    materia(Materia,_),
    not(esCorrelativa(Materia,_)).


%PUNTO 2 - INCISO 2 - INTEGRANTE 2
% Es Correlativa Materia Final de Materia Previa?
/*
esCorrelativa(Materia,OtraMateria):-
    planDeEstudio(_,Materia,ListaCorrelativas),
    nombreMateria(ID,OtraMateria),
    member(ID, ListaCorrelativas).

%%TODO: Convinar la transitiva con la no transitiva
esCorrelativaTransitiva(Materia,OtraMateria):-
    esCorrelativa(Materia,OtraMateriaTransitiva),
    esCorrelativa(OtraMateriaTransitiva,OtraMateria).
*/

materiasNecesarias(Materia,OtraMateria):-
    esCorrelativa(Materia, OtraMateria).
materiasNecesarias(Materia,OtraMateria):-
    esCorrelativa(Materia, OtraMateriaTransitiva),
    materiasNecesarias(OtraMateriaTransitiva,OtraMateria).

listadoDeCorrelativas(Materia,Lista):-
    materia(Materia,_),
    findall(Corr, materiasNecesarias(Materia,Corr), ListaCompleta),
    list_to_set(ListaCompleta,Lista).

habilitaA(Materia,Lista):-
    materia(Materia,_),
    findall(Corr, materiasNecesarias(Corr,Materia), ListaCompleta),
    list_to_set(ListaCompleta,Lista).


%Parte 2: Cursada
curso(juana,paradigmasdeProgramacion,cuatrimestral(2014,2),2).
curso(juana,arquitecturadeComputadoras,verano(2014,2),10).
curso(juana,paradigmasdeProgramacion,cuatrimestral(2015,2),8).
curso(tarciso,paradigmasdeProgramacion,anual(2020),9).
curso(juan,paradigmasdeProgramacion,verano(2022,1),2).
curso(juan,matematicaDiscreta,anual(2020),6).
curso(juan,arquitecturadeComputadoras,anual(2019),5).
curso(juan,arquitecturadeComputadoras,anual(2020),6).

%%PERSONA QUE CURSO TODO PRIMER ANIO
curso(personaSegundoAnio,analisisMatematicoI,anual(2020),9).
curso(personaSegundoAnio,algebrayGeometriaAnalitica,anual(2020),6).
curso(personaSegundoAnio,matematicaDiscreta,anual(2020),9).
curso(personaSegundoAnio,sistemasyOrganizaciones,anual(2020),7).
curso(personaSegundoAnio,algoritmoyEstructurasdeDatos,anual(2020),7).
curso(personaSegundoAnio,arquitecturadeComputadoras,anual(2020),6).
curso(personaSegundoAnio,fisicaI,anual(2020),10).
curso(personaSegundoAnio,inglesI,anual(2020),10).
%%..................................................
curso(personaUltimoAnio,analisisMatematicoI,anual(2016),7).
curso(personaUltimoAnio,algebrayGeometriaAnalitica,anual(2016),8).
curso(personaUltimoAnio,matematicaDiscreta,anual(2016),10).
curso(personaUltimoAnio,sistemasyOrganizaciones,anual(2016),7).
curso(personaUltimoAnio,algoritmoyEstructurasdeDatos,anual(2016),7).
curso(personaUltimoAnio,arquitecturadeComputadoras,anual(2016),7).
curso(personaUltimoAnio,fisicaI,anual(2016),9).
curso(personaUltimoAnio,inglesI,anual(2016),7).
curso(personaUltimoAnio,quimica,anual(2017),6).
curso(personaUltimoAnio,analisisMatematicoII,anual(2017),7).
curso(personaUltimoAnio,fisicaII,anual(2017),9).
curso(personaUltimoAnio,analisisdeSistemas,anual(2017),9).
curso(personaUltimoAnio,sintaxisySemanticadelosLenguajes,anual(2017),6).
curso(personaUltimoAnio,paradigmasdeProgramacion,anual(2017),6).
curso(personaUltimoAnio,sistemasOperativos,anual(2018),10).
curso(personaUltimoAnio,probabilidadyEstadistica,anual(2018),9).
curso(personaUltimoAnio,sistemasdeRepresentacion,anual(2018),7).
curso(personaUltimoAnio,diseniodeSistemas,anual(2018),8).
curso(personaUltimoAnio,comunicaciones,anual(2018),6).
curso(personaUltimoAnio,matematicaSuperior,anual(2018),9).
curso(personaUltimoAnio,gestiondeDatos,anual(2018),9).
curso(personaUltimoAnio,ingenieriaySociedad,anual(2019),8).
curso(personaUltimoAnio,economia,anual(2019),9).
curso(personaUltimoAnio,inglesII,anual(2019),7).
curso(personaUltimoAnio,redesdeInformacion,anual(2019),6).
curso(personaUltimoAnio,administraciondeRecursos,anual(2019),6).
curso(personaUltimoAnio,investigacionOperativa,anual(2020),7).
curso(personaUltimoAnio,simulacion,anual(2020),7).
curso(personaUltimoAnio,ingenieriadeSoftware,anual(2020),6).
curso(personaUltimoAnio,teoriadeControl,anual(2020),7).
curso(personaUltimoAnio,legislacion,anual(2020),10).
%%.............................................................................


anioQueCurso(Persona,Materia,Anio):-
	curso(Persona,Materia,cuatrimestral(Anio,_),_).

anioQueCurso(Persona,Materia,Anio):-
	curso(Persona,Materia,anual(Anio),_).

anioQueCurso(Persona,Materia,Anio):-
	curso(Persona,Materia,verano(AnioSiguiente,_),_),
    Anio is AnioSiguiente-1.


notaAprobada(Nota):- Nota >= 6.
notaPromocion(Nota):- Nota >= 8.

aproboCursada(Persona,Materia):-
    curso(Persona,Materia,_,Nota),
    notaAprobada(Nota).

recursoMateria(Persona,Materia):-
    anioQueCurso(Persona,Materia,Anio),
    anioQueCurso(Persona,Materia,OtroAnio), 
    OtroAnio\=Anio.

desempenio(Persona,Materia,Desemp):-
    curso(Persona,Materia,anual(_),Nota),
    Desemp is Nota.

desempenio(Persona,Materia,Desemp):-
    curso(Persona,Materia,cuatrimestral(_,Cuatri),Nota),
    Desemp is (Nota - (Cuatri - 1)).

desempenio(Persona,Materia,Desemp):-
    curso(Persona,Materia,verano(_,_),Desemp),
    Desemp =< 8.

desempenio(Persona,Materia,Desemp):-
    curso(Persona,Materia,verano(_,_),Nota),
    Nota >= 9,
    Desemp is 8.


desempenioDeCursada(Persona,Materia,Desemp):-
    curso(Persona,Materia,_,_), 
    findall(Puntaje,desempenio(Persona,Materia,Puntaje),ListaPuntajes),
    sumlist(ListaPuntajes,Desemp).
/* repite materias, fijarse despues - Si borramos la lineas Curso no es mas inversible pero no trae mas dobles*/


% Parte 3: Integrante 1

aproboFinal(juan,matematicaDiscreta).

puedeRendirFinal(Persona,Materia):-
    materia(Materia,_),
	curso(Persona,Materia,_,Nota),
    notaAprobada(Nota),
	not(notaPromocion(Nota)),
    not(aproboFinal(Persona,Materia)).

procrastinador(Persona):-
    curso(Persona,_,_,_),
    not(forall(puedeRendirFinal(Persona,Materia),aproboFinal(Persona,Materia))).

materiaFiltro(Materia):-
    materia(Materia,_),
    curso(_,Materia,_,_), /* repite, fijarse */
    forall(curso(_,Materia,_,Nota),not(notaPromocion(Nota)))
.


materiaTrivial(Materia):-
    materia(Materia,_),
    curso(_,Materia,_,_), /* repite, fijarse */
    forall(curso(_,Materia,_,Nota),notaAprobada(Nota))
.


% Parte 4: Integrante 1

leGusta(vanina,sistemasOperativos).
leGusta(vanina,gestiondeDatos).
leGusta(vanina,paradigmasdeProgramacion).

sugerirMaterias(Persona,Materias):-
    leGusta(Persona,UnaMateria),
    esPesada(SegundaMateria),
    esIntegradora(TercerMateria),
    append([UnaMateria],[SegundaMateria],ListaUno),
    append(ListaUno,[TercerMateria],Lista),
    list_to_set(Lista,Materias).



%PUNTO 4 - (2)

puedeCursar(Persona,Materia):-
    materia(Materia,_),
    not(aproboCursada(Persona,Materia)),
    forall(materiasNecesarias(Materia,Corr),aproboCursada(Persona,Corr)).

combinatoriaMaterias(Persona, MateriasPosibles):-
    findall(Materia, materia(Materia,_), Lista),
    combinatoria(Lista, Persona, MateriasPosibles).

combinatoria([],_, []).
combinatoria([Materia|Materias],Persona, [Materia|Posibles]):-
    puedeCursar(Persona,Materia),
    combinatoria(Materias,Persona,Posibles).
combinatoria([_|Materias], Persona,Posibles):-
    combinatoria(Materias, Persona,Posibles).


