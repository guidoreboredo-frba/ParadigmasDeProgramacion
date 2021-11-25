/*
Module      : Paradigma Logico
Description : https://docs.google.com/document/d/1GBORNTd2fujNy0Zs6v7AKXxRmC9wVICX2Y-pr7d1PwE/edit
Date        : 
Grupo       : 
Name        : Guido Reboredo,
Subject     : Paradigmas de Programación
*/

% -------------- Base de Conocimiento -------------- %

% HERRAMIENTAS REQUERIDAS (TAREA, HERRAMIENTAS) ASPIRADORA(POT MINIMA)
herramientasRequeridas(ordenarCuarto, [[aspiradora(100),escoba], trapeador, plumero]).
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordedadora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustradpesora, cera, aspiradora(300)]).

% HERRAMIENTASDISPONIBLES
herramientaDisponible(egon, aspiradora(200)).
herramientaDisponible(egon, sopapa).
herramientaDisponible(egon, trapeador).
herramientaDisponible(peter, trapeador).
herramientaDisponible(winston, varitaDeNeutrones).

% TAREA PEDIDA (CLIENTE, TAREA, METROS)
tareaPedida(ordenarCuarto, dana, 20).
tareaPedida(cortarPasto, walter, 50).
tareaPedida(limpiarTecho, walter, 70).
tareaPedida(limpiarBanio, louis, 15).

% PRECIO (TAREA, PRECIO)
precio(ordenarCuarto, 13).
precio(limpiarTecho, 20).
precio(limpiarBanio, 55).
precio(cortarPasto, 10).
precio(encerarPisos, 7).

%--------------------------------------------------- %

% -------------- Predicados -------------- %

cazafantasma(Persona):- herramientaDisponible(Persona, _).
herramienta(Herramienta):- herramientaDisponible(_,Herramienta).
tarea(Tarea):- herramientasRequeridas(Tarea,_).
cliente(Cliente):- tareaPedida(_,Cliente,_).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PUNTO 2 - SATISFACE NECESIDAD (PERSONA, HERRAMIENTA)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

satisfaceNecesidad(Persona, aspiradora(PotenciaMinima)):-
    herramientaDisponible(Persona, aspiradora(PotenciaDisponible)),
    between(0, PotenciaDisponible, PotenciaMinima).

satisfaceNecesidad(Persona, Herramienta):-
    herramientaDisponible(Persona, Herramienta).

satisfaceNecesidad(Persona, Herramientas):-
    member(Herramienta, Herramientas),
    satisfaceNecesidad(Persona, Herramienta).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PUNTO 3 - PUEDE REALIZAR (PERSONA, TAREA)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

puedeRealizar(Persona, Tarea):- 
    cazafantasma(Persona),
    tarea(Tarea),
    herramientaDisponible(Persona, varitaDeNeutrones).

puedeRealizar(Persona, Tarea):-
    cazafantasma(Persona),
    tarea(Tarea),
    forall(requiereHerramienta(Tarea,Herramienta), satisfaceNecesidad(Persona,Herramienta)).

requiereHerramienta(Tarea, Herramienta):-
    herramientasRequeridas(Tarea, Herramientas),
    member(Herramienta, Herramientas).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PUNTO 4 - PUEDE REALIZAR (PERSONA, TAREA)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

precioACobrar(Cliente, Monto):-
    cliente(Cliente),
    findall(Precio, precioDeTareaPedida(Cliente, Precio), Precios),
    sumlist(Precios, Monto).

precioDeTareaPedida(Cliente, Precio):-
    tareaPedida(Tarea,Cliente, Metros),
    precio(Tarea, Monto),
    Precio is Monto * Metros.
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PUNTO 5 - aceptaElPedido(Persona, Cliente)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

aceptaElPedido(Persona, Cliente):-
    puedeRealizarPedido(Persona, Cliente),
    estaDispuesto(Persona, Cliente).

puedeRealizarPedido(Persona, Cliente):-
    cazafantasma(Persona),
    cliente(Cliente),
    forall(tareaPedida(Tarea, Cliente,_), puedeRealizar(Persona, Tarea)).

estaDispuesto(ray, Cliente):-
    cliente(Cliente),
    not(tareaPedida(Cliente, limpiarTecho, _)).
estaDispuesto(winston,Cliente):-
    precioACobrar(Cliente, Monto),
    between(0,Monto, 500). 
estaDispuesto(egon, Cliente):-
    not((tareaPedida(Cliente, Tarea,_),
    tareaCompleja(Tarea))).
estaDispuesto(peter, _).

tareaCompleja(Tarea):-
    Tarea \= limpiarTecho,
    herramientasRequeridas(Tarea, ListaHerramientas),
    length(ListaHerramientas, CantidadHerramientas),
    CantidadHerramientas > 2. 


tareaCompleja(limpiarTecho).
    

%------------------------------------------%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PRUEBAS UNITARIAS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:-begin_tests(cazafantasma).
    test(satisface_la_necesidad):-
        satisfaceNecesidad(winston, varitaDeNeutrones).
    test(satisfacen_la_necesidad, set(Persona = [egon,peter])):-
        satisfaceNecesidad(Persona, trapeador).
    test(satisface_necesidad_aspiradora,nondet):-
        satisfaceNecesidad(egon, aspiradora(100)).
    test(puede_realizar_tarea, nondet):-
        puedeRealizar(winston, limpiarBanio).
    test(pueden_realizar_tareas, set(Persona = [egon, winston])):-
        puedeRealizar(Persona, limpiarBanio).

:-end_tests(cazafantasma).