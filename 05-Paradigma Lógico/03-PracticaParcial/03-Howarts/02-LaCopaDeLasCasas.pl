/*
Module      : Paradigma Logico
Description : 
Date        : 
Grupo       : 
Name        : Guido Reboredo,
Subject     : Paradigmas de Programación
*/

% -------------- Base de Conocimiento -------------- %
% casas de magos
esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).
% acciones
accion(harry, fueraCama).
accion(hermione, irA(tercerPiso)).
accion(hermione, irA(biblioteca)).
accion(harry, irA(bosqueProhibido)).
accion(harry, irA(tercerPiso)).
accion(draco, irA(mazmorras)).
accion(ron,buenaAccion(ajedrez, 50)).
accion(ron, buenaAccion(salvarAmigos, 50)).
accion(harry, buenaAccion(ganarleVoldemort, 60)).

accion(hermione, respondioPregunta(dondeSeEncuentraUnBezoar, 20, snape)).
accion(hermione, respondioPregunta(comoLevitarPluma, 25, flitwick)).


lugarProhibido(bosqueProhibido,-50).
lugarProhibido(biblioteca,-10).
lugarProhibido(tercerPiso, -75).


%--------------------------------------------------- %

% -------------- Predicados -------------- %
% Punto 1 - buen alumno

mago(Mago):- esDe(Mago,_).
casa(Casa):- esDe(_,Casa).
esAccion(Accion):- accion(_,Accion).

puntajeAccion(irA(Lugar), Puntos):-
    lugarProhibido(Lugar,Puntos).
puntajeAccion(irA(Lugar), 0):-
    not(lugarProhibido(Lugar,_)).
puntajeAccion(fueraCama, -50).
puntajeAccion(buenaAccion(_,Puntos), Puntos).
puntajeAccion(respondioPregunta(_,Dificultad, Profesor), Dificultad):-
    Profesor \= snape.
puntajeAccion(respondioPregunta(_,Dificultad, snape), Puntos):-
    Puntos is Dificultad / 2.


malaAccion(Accion):-
    esAccion(Accion),
    puntajeAccion(Accion,Puntaje),
    Puntaje < 0. 

esBuenAlumno(Mago):-
    mago(Mago),
    findall(Accion, accion(Mago,Accion), Acciones),
    forall(member(AccionMago,Acciones),not(malaAccion(AccionMago))).


% PUNTO 1 - Accion Recurrente

accionRecurrente(Accion):-
    accion(Mago,Accion),
    accion(OtroMago, Accion),
    Mago \= OtroMago.

% PUNTO 2 - Puntaje Total

puntajeDeLaCasa(Casa, PuntajeTotal):-
    casa(Casa),
    findall(Puntaje, accionCasa(Casa, Puntaje), Puntajes),
    sumlist(Puntajes, PuntajeTotal).

accionCasa(Casa,Puntaje):-
    mago(Mago),
    esDe(Mago,Casa),
    accion(Mago, Accion),
    puntajeAccion(Accion, Puntaje).

% PUNTO 3 - Casa Ganadora

casaGanadora(Casa):-
    puntajeDeLaCasa(Casa,Puntaje),
    forall(puntajeDeLaCasa(_,OtroPuntaje), Puntaje >= OtroPuntaje). 


%------------------------------------------%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Parte 2 - LA COPA DE LAS CASAS ( TESTING )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:-begin_tests(laCopaDeLasCasas).
    test(es_buen_alumno):-
        esBuenAlumno(ron). 
    test(no_es_buen_alumno, fail):-
        esBuenAlumno(harry).
    test(son_buenos_alumnos, set(Alumno = [ron, draco, luna])):-
        esBuenAlumno(Alumno).
    test(accion_recurrente, set( Accion = [irA(tercerPiso), irA(tercerPiso)])):-
        accionRecurrente(Accion).
    test(puntaje_total_cuenta, set( Puntaje = [-65])):-
        puntajeDeLaCasa(gryffindor, Puntaje).
    test(casa_ganadora):-
        casaGanadora(slytherin).
:-end_tests(laCopaDeLasCasas).