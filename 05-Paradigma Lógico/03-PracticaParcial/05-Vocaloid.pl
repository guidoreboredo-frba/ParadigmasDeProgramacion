/*
Module      : Paradigma Logico
Description : https://docs.google.com/document/d/1xbXPZnhwyK5FSHR_oaXU4esfkTd2S-jf3rH1XLw864M/edit?usp=sharing
Date        : 
Grupo       : 
Name        : Guido Reboredo,
Subject     : Paradigmas de Programación
*/

% -------------- Base de Conocimiento -------------- %
%  Cantantes/vocaloids
vocaloid(megurineLuka, cancion(nightFever,4)).
vocaloid(megurineLuka, cancion(foreverYoung,5)).
vocaloid(hatsuneMiku, cancion(tellYourWorld,4)).
vocaloid(gumi, cancion(foreverYoung,4)).
vocaloid(gumi, cancion(tellYourWorld,5)).
vocaloid(seeU, cancion(novemberRain,6)).
vocaloid(seeU, cancion(nightFever,5)).

% Conciertos
concierto(mikuExpo, gigante(2,6), estadosUnidos, 2000).
concierto(magicalMirai, gigante(3,10), jampon, 3000).
concierto(vocalektVisions, mediano(9), estadosUnidos, 1000).
concierto(mikuFest, pequenio(4), argentina, 100).

%--------------------------------------------------- %


% -------------- Predicados -------------- %
% Parte 2 - Punto 1 - Vocaloid Novedosos
sabeAlMenosDos(Vocaloid):-
    vocaloid(Vocaloid, Cancion),
    vocaloid(Vocaloid, OtraCancion),
    Cancion \= OtraCancion.

tiempoTotalVocaloid(Vocaloid, Tiempo):-
    findall(Tiempo, vocaloid(Vocaloid, cancion(_,Tiempo)), Tiempos),
    sumlist(Tiempos, Tiempo).
  
esNovedoso(Vocaloid):-
    vocaloid(Vocaloid,_),
    sabeAlMenosDos(Vocaloid),
    tiempoTotalVocaloid(Vocaloid, Tiempo),
    Tiempo < 15.

% Parte 1 - Punto 2 - Vocaloid Acelerado
tieneCancionLenta(Vocaloid):-
    vocaloid(Vocaloid, cancion(_,Tiempo)),
    Tiempo > 4. 


esAcelerado(Vocaloid):-
    vocaloid(Vocaloid,_),
    not(tieneCancionLenta(Vocaloid)).

% Parte 2 - Punto 2 - Puede Participar

puedeParticipar(hatsuneMiku, Concierto):-
    concierto(Concierto,_,_,_).

puedeParticipar(Vocaloid, Concierto):-
    vocaloid(Vocaloid,_),
    Vocaloid \= hatsuneMiku,
    concierto(Concierto,Categoria,_,_),
    cumpleCondiciones(Vocaloid, Categoria).

cantidadCanciones(Vocaloid, Cantidad):-
    findall(Cancion, vocaloid(Vocaloid, Cancion),ListaCanciones),
    length(ListaCanciones, Cantidad).

cumpleCondiciones(Vocaloid, gigante(Canciones, Duracion)):-
    cantidadCanciones(Vocaloid, CantidadCanciones),
    CantidadCanciones >= Canciones, 
    tiempoTotalVocaloid(Vocaloid, Tiempo),
    Tiempo >= Duracion.


cumpleCondiciones(Vocaloid, mediano(Duracion)):-
    tiempoTotalVocaloid(Vocaloid, Tiempo),
    Tiempo < Duracion.

cumpleCondiciones(Vocaloid, pequenio(Duracion)):-
    vocaloid(Vocaloid,cancion(_,Tiempo)),
    Tiempo > Duracion.

% Vocaloid mas famoso

masFamoso(Vocaloid):-
    puntajeTotal(Vocaloid, Puntos),
    forall(puntajeTotal(_,OtroPuntaje), Puntos>=OtroPuntaje).

puntajeTotal(Vocaloid, Puntos):-
    vocaloid(Vocaloid,_),
    findall(Fama, famaConcierto(Vocaloid, Fama), Famas),
    sumlist(Famas, Puntaje),
    cantidadCanciones(Vocaloid, Cantidad),
    Puntos is Puntaje * Cantidad. 

famaConcierto(Vocaloid, Fama):-
    puedeParticipar(Vocaloid, Concierto),
    concierto(Concierto, _, _, Fama).



%------------------------------------------%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Parte 1 - Sombrero Seleccionador
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:-begin_tests(vocaloids).
    test(es_novedoso,nondet):-
        esNovedoso(gumi).
    test(no_es_novedoso, fail):-
        esNovedoso(hatsuneMiku).
    test(no_es_novedoso, set(Vocaloid = [megurineLuka,gumi,seeU])):-
        esNovedoso(Vocaloid).
    test(es_vocaloid_acelerado):-
        esAcelerado(hatsuneMiku).
    test(son_vocaloids_acelerados, set(Vocaloid=[hatsuneMiku])):-
        esAcelerado(Vocaloid).
:-end_tests(vocaloids).