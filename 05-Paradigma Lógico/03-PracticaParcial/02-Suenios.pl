/*
Module      : Paradigma Logico
Description : https://docs.google.com/document/d/1QcIfJEvOb-oxIFH4jeXEfiVTgMFQa00V0nvF11wIEAg/edit?usp=sharing
Date        : 
Grupo       : 
Name        : Guido Reboredo,
Subject     : Paradigmas de Programación
*/

% -------------- Base de Conocimiento -------------- %
% creeEn(Persona,CreeEn)
creeEn(gabriel,campanita).
creeEn(gabriel,elMagoDeOz).
creeEn(gabriel,cavenaghi).
creeEn(juan,conejoPascua).
creeEn(macarena,reyesMagos).
creeEn(macarena,magoCapria).
creeEn(macarena,campanita).
%Suenios
sueniaCon(gabriel,loteria([5,9])).
sueniaCon(gabriel,futbolista(arsenal)).
sueniaCon(juana,cantante(100000)).
sueniaCon(macarena,cantante(10000)).
%EquipoChico
esEquipoChico(arsenal).
esEquipoChico(aldosivi).
%--------------------------------------------------- %


% -------------- Predicados -------------- %
% ES AMBICIOSA
persona(Persona):-
    creeEn(Persona,_).

esAmbiciosa(Persona):-
    persona(Persona),
    dificultadTotal(Persona,Dif),
    Dif > 20.

dificultadTotal(Persona,Dif):-
    findall(Dificultad, dificultades(Persona,Dificultad), Dificultades),
    sumlist(Dificultades,Dif).
    
dificultades(Persona,Dif):-
    sueniaCon(Persona,Suenio),
    dificultadSuenio(Suenio,Dif).

dificultadSuenio(cantante(Discos),Dif):-
    Discos > 500000,
    Dif is 6.
dificultadSuenio(cantante(Discos),Dif):-
    Discos =< 500000,
    Dif is 4.
dificultadSuenio(loteria(ListaNumeros),Dif):-
    length(ListaNumeros,Len),
    Dif is 10*Len.
dificultadSuenio(futbolista(Equipo),Dif):-
    esEquipoChico(Equipo),
    Dif is 3.
dificultadSuenio(futbolista(Equipo),Dif):-
    not(esEquipoChico(Equipo)),
    Dif is 16.

    %****************PRUEBAS******************
    /*
    35 ?- dificultadTotal(gabriel,Dif).
    Dif = 23.

    36 ?- dificultadTotal(macarena,Dif). 
    Dif = 4.

    37 ?- esAmbiciosa(Persona).
    Persona = gabriel ;
    Persona = gabriel ;
    Persona = gabriel ;
    */
    %*******************************************

% TIENE QUIMICA
tieneQuimica(Personaje,Persona):-
    creeEn(Persona,Personaje),
    cumpleCondicionQuimica(Persona,Personaje).

cumpleCondicionQuimica(Persona,campanita):-
    sueniaCon(Persona,Suenio),
    dificultadSuenio(Suenio,Dif),
    Dif < 5.

cumpleCondicionQuimica(Persona,Personaje):-
    Personaje \= campanita,
    sueniosPuros(Persona),
    not(esAmbiciosa(Persona)).

sueniosPuros(Persona):-
    forall(sueniaCon(Persona,Suenio), suenioPuro(Suenio)).

suenioPuro(futbolista(_)).
suenioPuro(cantante(Discos)):-
    Discos < 200000.

    %****************PRUEBAS******************
    /*
    52 ?- tieneQuimica(Personaje,Persona).
    Personaje = campanita,
    Persona = gabriel ;
    Personaje = conejoPascua,
    Persona = juan ;
    Personaje = reyesMagos,
    Persona = macarena ;
    Personaje = magoCapria,
    Persona = macarena ;
    Personaje = campanita,
    Persona = macarena ;
    */
    %*******************************************

% ES AMUGUE

esAmiga(campanita,reyesMagos).
esAmiga(campanita,conejoDePascua).
esAmiga(conejoDePascua,cavenaghi).

estaEnfermo(campanita).
estaEnfermo(reyesMagos).
estaEnfermo(conejoDePascua).

puedeAlegrarA(Persona,Personaje):-
    sueniaCon(Persona,_),
    tieneQuimica(Personaje,Persona),
    condicionAlegrar(Personaje).

condicionAlegrar(Personaje):-
    not(estaEnfermo(Personaje)).

condicionAlegrar(Personaje):-
    estaEnfermo(Personaje),
    personajeBackUp(Personaje).

personajeBackUp(Personaje):-
    esAmiga(Personaje,OtraPersonaje),
    not(estaEnfermo(OtraPersonaje)).

personajeBackUp(Personaje):-
    esAmiga(Personaje,OtroPersonaje),
    personajeBackUp(OtroPersonaje).

    %****************PRUEBAS******************
    /*
    63 ?- puedeAlegrarA(Persona,Personaje).
    Persona = gabriel,
    Personaje = campanita ;
    Persona = gabriel,
    Personaje = campanita ;
    Persona = macarena,
    Personaje = magoCapria ;
    Persona = macarena,
    Personaje = campanita ;
    */
    %*******************************************
%------------------------------------------%