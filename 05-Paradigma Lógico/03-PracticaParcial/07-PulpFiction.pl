/*
Module      : Paradigma Logico
Description : https://docs.google.com/document/d/15mo_2391atBqMjcYzLtKvGG6JiPzjbeyEGVlwZjv4B8/edit#
Date        : 
Grupo       : 
Name        : Guido Reboredo,
Subject     : Paradigmas de Programación
*/

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% BASE DE CONOCIMIENTOS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%personajes 
personaje(pumkin,     ladron([licorerias, estacionesDeServicio])).
personaje(honeyBunny, ladron([licorerias, estacionesDeServicio])).
personaje(vincent,    mafioso(maton)).
personaje(jules,      mafioso(maton)).
personaje(marsellus,  mafioso(capo)).
personaje(winston,    mafioso(resuelveProblemas)).
personaje(mia,        actriz([foxForceFive])).
personaje(butch,      boxeador).
%pareja
pareja(marsellus, mia).
pareja(pumkin,    honeyBunny).
%amigo
amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedor).
%trabajaPara(Empleador, Empleado)
trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).
%encargo(Solicitante, Encargado, Tarea). 
%las tareas pueden ser cuidar(Protegido), ayudar(Ayudado), buscar(Buscado, Lugar)
encargo(marsellus, vincent,   cuidar(mia)).
encargo(vincent,  elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).
encargo(marsellus, jules, ayudar(winston)).


% -------------- Predicados -------------- %

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PUNTO 1 - ES PELIGROSO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

actividadPeligrosa(ladron(Lugares)):-
    member(licorerias, Lugares).
actividadPeligrosa(mafioso(maton)).

esPeligroso(Personaje):-
    personaje(Personaje, Actividad),
    actividadPeligrosa(Actividad).

esPeligroso(Personaje):-
    trabajaPara(Personaje, Empleado),
    esPeligroso(Empleado).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PUNTO 2 - DUO TEMIBLE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

esDuo(Persona, OtraPersona):- amigo(Persona, OtraPersona).
esDuo(Persona, OtraPersona):- pareja(Persona, OtraPersona).

duoTemible(Persona,OtraPersona):-
    esPeligroso(Persona),
    esPeligroso(OtraPersona),
    esDuo(Persona, OtraPersona).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PUNTO 3 - ESTA EN PROBLEMAS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

estaEnProblemas(butch).

estaEnProblemas(Personaje):-
    trabajaPara(Empleador, Personaje),
    esPeligroso(Empleador),
    encargoProblematico(Empleador, Personaje).

encargoProblematico(Empleador, Personaje):-
    encargo(Empleador, Personaje, cuidar(Persona)),
    pareja(Empleador, Persona).

encargoProblematico(Empleador, Personaje):-
    encargo(Empleador, Personaje, buscar(Persona,_)),
    personaje(Persona, boxeador).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PUNTO 4 - SAN CAYETANO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

estaCerca(Personaje, Persona):-
    amigo(Personaje, Persona).

estaCerca(Personaje, Persona):-
    trabajaPara(Personaje, Persona).

sanCayetano(Personaje):-
    encargo(Personaje,_,_),
    forall(estaCerca(Personaje,Persona), encargo(Personaje, Persona, _)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PUNTO 5 - MAS ATAREADO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cantidadDeEncargos(Personaje,Cantidad):-
    encargo(_,Personaje,_),
    findall(Encargo,encargo(_,Personaje,Encargo), Encargos),
    length(Encargos, Cantidad).
    

masAtareado(Personaje):-
    cantidadDeEncargos(Personaje, CantidadPersonaje),
    forall(cantidadDeEncargos(_,Cantidad), CantidadPersonaje >= Cantidad).



%------------------------------------------%