/*
Module      : Paradigma Logico
Description : 
Date        : 
Grupo       : 
Name        : Guido Reboredo,
Subject     : Paradigmas de Programación
*/

% -------------- Base de Conocimiento -------------- %
% Caracrteristicas de los Magos
casa(slytherin).
casa(hufflepuff).
casa(gryffindor).
casa(ravenclaw).

sangre(harry,mestiza).
sangre(draco,pura).
sangre(ron,pura).
sangre(fred,pura).
sangre(hermione,impura).

caracteristica(harry, [corajudo, amistoso, orgulloso, inteligente]).
caracteristica(ron, [amistoso, orgulloso, corajudo]).
caracteristica(fred, [amistoso, inteligente, corajudo]).
caracteristica(draco, [inteligente,orgulloso]).
caracteristica(hermione,[inteligente,orgulloso,responsable,amistoso]).

odiaCasa(harry,slytherin).
odiaCasa(draco,hufflepuff).

% Es importante para el sombrero seleccionador
esImportante(gryffindor, corajudo).
esImportante(slytherin, orgulloso).
esImportante(slytherin, inteligente).
esImportante(ravenclaw, inteligente).
esImportante(ravenclaw, responsable).
esImportante(hufflepuff, amistoso).
%---------------------------------------------------%

% -------------- Predicados -------------- %
% Punto 1 
% una casa permite entrar a un mago

mago(Mago):- sangre(Mago,_).

puedeEntrar(Casa,Mago):-
    casa(Casa),
    mago(Mago),
    Casa \= slytherin.
puedeEntrar(slytherin, Mago):-
    sangre(Mago, Sangre),
    Sangre \= impura.
    
% cumple las condiciones de una casa

tieneCaracteristica(Caracteristica,Mago):-
    caracteristica(Mago,Caracteristicas),
    member(Caracteristica,Caracteristicas).

cumpleCondiciones(Casa,Mago):-
    casa(Casa), mago(Mago),
    forall(esImportante(Casa,Caracteristica), tieneCaracteristica(Caracteristica,Mago)).


puedeQuedarSeleccionado(Casa,Mago):-
    puedeEntrar(Casa,Mago),
    cumpleCondiciones(Casa,Mago),
    not(odiaCasa(Mago,Casa)).

puedeQuedarSeleccionado(gryffindor,hermione).

esAmistoso(Mago):-
    caracteristica(Mago, Lista),
    member(amistoso,Lista).


cadenaDeAmistades([Mago, OtroMago | Otros]):-
    puedeQuedarSeleccionado(Casa,Mago),
    puedeQuedarSeleccionado(Casa, OtroMago),
    esAmistoso(Mago),
    cadenaDeAmistades([OtroMago|Otros]).
cadenaDeAmistades([]).
cadenaDeAmistades([Mago]):- esAmistoso(Mago).


%------------------------------------------%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PRUEBAS UNITARIAS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:-begin_tests(sombreroSeleccionador).
    test(no_puede_entrar_mago_en_casa, fail):-
        puedeEntrar(slytherin,hermione).
    test(puede_entrar_mago_en_casa, set(Mago = [harry, draco, ron, fred,hermione])):-
        puedeEntrar(gryffindor, Mago).
    test(cumple_condiciones_mago_slytherin, set(Mago = [draco,hermione, harry])):-
        cumpleCondiciones(slytherin,Mago).
    test(cumple_condiciones_harry_casa, set(Casa = [gryffindor, slytherin, hufflepuff])):-
        cumpleCondiciones(Casa,harry).
    test(puede_quedar_seleccionado_hermione_casa, set(Casa = [ravenclaw,gryffindor, hufflepuff])):-
        puedeQuedarSeleccionado(Casa,hermione).
    test(cadena_de_amistades_false, fail):-
        cadenaDeAmistades([harry,ron,hermione,draco]). 
    test(cadena_de_amistades_true,nondet):-
        cadenaDeAmistades([harry,ron,hermione,fred]). 

:-end_tests(sombreroSeleccionador).