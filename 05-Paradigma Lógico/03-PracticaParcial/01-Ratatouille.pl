/*-
Module      : Paradigma Logico
Description : https://docs.google.com/document/d/193neL2CxpY0jqq5d8C8EgdTXzc1TQKSt/edit
Date        : 
Grupo       : 
Name        : Guido Reboredo,
Subject     : Paradigmas de Programación
*/

% -------------- Base de Conocimiento -------------------- %
% Ratas
rata(remmy,gusteaus).
rata(emile,chezMilleBar).
rata(django,pizzeriaJeSuis).
% Humanos(Nombre, Plato,Experiencia)
persona(linguini,ratatouille,10).
persona(linguini,sopa,10).
persona(colette,salmon,9).
persona(horst,ratatouille,1).
persona(horst,sopa,1).
persona(horst,salmon,1).
persona(horst,ensaladaRusa,8).
persona(amelie,cafe,10).
persona(amelie,ratatouille,8).
% TrabaEn(Persona,Restaurante)
trabajaEn(linguini,gusteaus).
trabajaEn(colette,gusteaus).
trabajaEn(horst,gusteaus).
trabajaEn(skinner,gusteaus).
trabajaEn(amelie,cafeDes2Moulines).
%esTutor(Tutor,Persona)
esTutor(amelie,skinner).
esTutor(linguini,Rata):- rata(Rata,gusteaus).

%-----------------------------------------------------------%

% -------------- Predicados -------------- %
% ESTA EN EL MENU

estaEnElMenu(Plato,Restaurante):-
    persona(Persona,Plato,_),
    trabajaEn(Persona,Restaurante).

    %****************PRUEBAS******************
    /*
     2 ?- estaEnElMenu(sopa,gusteaus).
    true.

    3 ?- estaEnElMenu(Que,gusteaus).  
    Que = ratatouille ;
    Que = sopa ;
    Que = salmon ;
    Que = ensaladaRusa.

    4 ?- estaEnElMenu(Que,Donde).    
    Que = ratatouille,
    Donde = gusteaus ;
    Que = sopa,
    Donde = gusteaus ;
    Que = salmon,
    Donde = gusteaus ;
    Que = ensaladaRusa,
    Donde = gusteaus.
    */
    %*******************************************

% COCINA BIEN
cocinaBien(Persona,Plato):-
    persona(Persona,Plato,Experiencia),
    Experiencia > 7.
cocinaBien(Persona,Plato):-
    esTutor(Tutor,Persona),
    cocinaBien(Tutor,Plato).

    %****************PRUEBAS******************
    /*
    8 ?- cocinaBien(skinner,cafe).
    true .

    9 ?- cocinaBien(linguini,Plato).  
    false.

    10 ?- cocinaBien(Persona,Plato).  
    Persona = colette,
    Plato = salmon ;
    Persona = horst,
    Plato = ensaladaRusa ;
    Persona = amelie,
    Plato = cafe ;
    Persona = skinner,
    Plato = cafe ;
    false.
    */
    %*******************************************

% ES CHEF

esChef(Persona,Resto):-
    trabajaEn(Persona,Resto),
    cumpleCondicionesChef(Persona,Resto).

cumpleCondicionesChef(Persona,Resto):-
    forall(estaEnElMenu(Plato,Resto), persona(Persona,Plato,_)).
    
cumpleCondicionesChef(Persona,_):-
    experienciaTotal(Persona,Experiencia),
    Experiencia >= 20.

experienciaTotal(Persona,Experiencia):-
    findall(Exp,persona(Persona,_,Exp), ListaExp),
    sumlist(ListaExp,Experiencia).

    %****************PRUEBAS******************
    /*
    30 ?- esChef(Persona,Lugar).
    Persona = linguini,
    Lugar = gusteaus ;
    Persona = horst,
    Lugar = gusteaus ;
    Persona = amelie,
    Lugar = cafeDes2Moulines ;
    */
    %*******************************************

% ES ENCARGADO
esEncargado(Persona,Lugar,Plato):-
    experienciaCocineroResto(Persona,Lugar,Plato,Experiencia),
    forall(experienciaCocineroResto(_,Lugar,Plato,ExpEmpleado),Experiencia >= ExpEmpleado).
   
experienciaCocineroResto(Persona,Lugar,Plato,Experiencia):-
    persona(Persona,Plato,Experiencia),
    trabajaEn(Persona,Lugar).
    
    %****************PRUEBAS******************
    /*
    46 ?- esEncargado(linguini,Resto,Plato). 
    Resto = gusteaus,
    Plato = ratatouille ;
    Resto = gusteaus,
    Plato = sopa.
    */
    %*******************************************

% PLATOS 
plato(ensaladaRusa, entrada([papa, zanahoria, arvejas, huevo])).
plato(bifeDeChorizo, principal(pure, 2)).
plato(frutillasConCrema, postre(265)).

% PLATO SALUDABLE
platoSaludable(Plato):-
    plato(Plato,TipoPlato),
    calorias(TipoPlato,Calorias),
    Calorias < 75.

calorias(entrada(Ingredientes),Calorias):-
    length(Ingredientes,Len),
    Calorias is Len * 15.

calorias(principal(Guarnicion,Tiempo),Calorias):-
    caloriasGuarnicion(Guarnicion, CalGuar),
    Calorias is (Tiempo * 5) + CalGuar.

calorias(postr(Calorias),Calorias).

caloriasGuarnicion(pure,20).
caloriasGuarnicion(papas,50).
caloriasGuarnicion(ensalada,0).

    %****************PRUEBAS******************
    /*
    55 ?- platoSaludable(Platos).
    Platos = ensaladaRusa ;
    Platos = bifeDeChorizo ;
    */
    %*******************************************

% CriticaPositiva

criticaPositiva(Critico,Resto):-
    restaurante(Resto),
    not(rata(_,Resto)),
    cumpleElCriterio(Critico,Resto).

cumpleElCriterio(antonEgo,Resto):-
    esEspecialistaEn(ratatouille,Resto).

cumpleElCriterio(cormillot,Resto):-
    forall(estaEnElMenu(Plato,Resto), platoSaludable(Plato)).

cumpleElCriterio(martiniano,Resto):-
    esChef(Persona,Resto),
    not((esChef(OtraPersona,Resto), OtraPersona \= Persona)).

esEspecialistaEn(Plato,Resto):-
    forall(esChef(Persona,Resto), cocinaBien(Persona,Plato)).


restaurante(Restaurante):- trabajaEn(_, Restaurante).

    %****************PRUEBAS******************
    /*
    70 ?- criticaPositiva(Critico,Resto).
    Critico = antonEgo,
    Resto = cafeDes2Moulines ;
    Critico = martiniano,
    Resto = cafeDes2Moulines ;
    */
    %*******************************************

%------------------------------------------%

