/*
Module      : Paradigma Logico
Description : https://docs.google.com/document/d/1RNgFMlSqOKiwe9SEi1U2cQjCmdFfWNflqycSfp7Qa-w/edit#heading=h.8z5fk89ui0rg
Date        : 
Grupo       : 
Name        : Guido Reboredo,
Subject     : Paradigmas de Programación
*/

% -------------- Base de Conocimiento -------------- %
% atiende
atiende(dodain,lunes,9,15).
atiende(dodain,miercoles,9,15).
atiende(dodain,viernes,9,15).
atiende(lucas,martes,10,20).
atiende(juanC,sabados, 18,22).
atiende(juanC,domingos,18,22).
atiende(juanFdS,jueves,10,20).
atiende(juanFdS,viernes,12,20).
atiende(leoC,lunes,14,18).
atiende(leoC,miercoles,14,18).
atiende(martu,miercoles,23,24).
%--------------------------------------------------- %

% -------------- Predicados -------------- %

% Punto 1 
% vale atiende los mismos días y horarios que dodain y juanC.
atiende(vale,Dia,HoraI,HoraF):- atiende(dodain,Dia,HoraI,HoraF).
atiende(vale,Dia,HoraI,HoraF):- atiende(juanC,Dia,HoraI,HoraF).

% - nadie hace el mismo horario que leoC
% por principio de universo cerrado, no agregamos a la base de conocimiento aquello que no tiene sentido agregar
% - maiu está pensando si hace el horario de 0 a 8 los martes y miércoles
% por principio de universo cerrado, lo desconocido se presume falso

% Punto 2
% Definir un predicado que permita relacionar un día y hora con una persona, en la que dicha persona atiende el kiosko. 

quienAtiende(Persona,Dia,Hora):-
    atiende(Persona,Dia,HoraInicio,HoraFin),
    between(HoraInicio,HoraFin,Hora).

    %****************PRUEBAS******************
    /*
    14 ?- quienAtiende(Quien,lunes,14).  
    Quien = dodain ;
    Quien = leoC ;
    Quien = vale ;
    Quien = vale ;
    21 ?- quienAtiende(juanFdS,jueves,11).           
    true .
    23 ?- quienAtiende(vale,Dias,10).   
    Dias = lunes ;
    Dias = miercoles ;
    Dias = viernes ;
    */
    %*******************************************

% Punto 3 
% Definir un predicado que permita saber si una persona en un día y horario determinado está atendiendo ella sola.

foreverAlone(Persona, Dia, Hora):-
    quienAtiende(Persona,Dia,Hora),
    not((quienAtiende(OtraPersona,Dia,Hora), Persona \= OtraPersona)).

    %****************PRUEBAS******************
    /*
    30 ?- foreverAlone(Quien,martes,19).
    Quien = lucas ;
    31 ?- foreverAlone(martu,miercoles,22). 
    false.
    32 ?- foreverAlone(martu,miercoles,23). 
    true 
    */
    %*******************************************

% Punto 4
% Dado un día, queremos relacionar qué personas podrían estar atendiendo el kiosko en algún momento de ese día.

puedeAtender(Dia,Atienden):-
    findall(Persona, distinct(Persona, quienAtiende(Persona, Dia, _)), Personas),
    combinarTurno(Personas,Atienden).

combinarTurno([],[]).
combinarTurno([Persona|Personas],[Persona|Otros]):-
    combinarTurno(Personas,Otros).
combinarTurno([_|Personas],Otros):-
    combinarTurno(Personas,Otros).

% VENTAS POSIBLES
venta(dodain,fecha(10,8),[golosinas(1200),cigarrillos(jockey),golosinas(50)]).
venta(dodain,fecha(12,8),[bebidas(true,8),bebidas(false,1),golosinas(10)]).
venta(martu,fecha(12,8),[golosinas(1000),cigarrillos([chesterfield,colorado,parisiennes])]).
venta(lucas,fehca(11,8),[golosinas(600)]).
venta(lucas,fecha(18,8),[bebidas(false,2),cigarrillos(derby)]).

vendedor(Persona):-
    venta(Persona,_,_).

esSuertuda(Persona):-
    vendedor(Persona),
    forall(venta(Persona,_,[Venta|_]), ventaImportante(Venta)).


ventaImportante(golosinas(Monto)):- Monto > 100.
ventaImportante(cigarrillos(Lista)):- 
    length(Lista,Len),
    Len > 2.
ventaImportante(bebidas(true,_)).
ventaImportante(bebidas(false,Cantidad)):- Cantidad > 5.


:-begin_tests(kioskito).

test(atienden_los_viernes, set(Persona = [vale, dodain, juanFdS])):-
  atiende(Persona, viernes, _, _).

test(personas_que_atienden_un_dia_puntual_y_hora_puntual, set(Persona = [vale, dodain, leoC])):-
  quienAtiende(Persona, lunes, 14).

test(dias_que_atiende_una_persona_en_un_horario_puntual, set(Dia = [lunes, miercoles, viernes])):-
  quienAtiende(vale, Dia, 10).

test(una_persona_esta_forever_alone_porque_atiende_sola, set(Persona=[lucas])):-
  foreverAlone(Persona, martes, 19).

test(persona_que_no_cumple_un_horario_no_puede_estar_forever_alone, fail):-
  foreverAlone(martu, miercoles, 22).

test(posibilidades_de_atencion_en_un_dia_muestra_todas_las_variantes_posibles, set(Personas=[[],[dodain],[dodain,leoC],[dodain,leoC,martu],[dodain,leoC,martu,vale],[dodain,leoC,vale],[dodain,martu],[dodain,martu,vale],[dodain,vale],[leoC],[leoC,martu],[leoC,martu,vale],[leoC,vale],[martu],[martu,vale],[vale]])):-
  puedeAtender(miercoles, Personas).

test(personas_suertudas, set(Persona = [dodain,martu])):-
  esSuertuda(Persona).

:-end_tests(kioskito).

%------------------------------------------%