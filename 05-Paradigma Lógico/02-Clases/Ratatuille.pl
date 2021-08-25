% https://docs.google.com/document/d/193neL2CxpY0jqq5d8C8EgdTXzc1TQKSt/edit

% Ratas: 
viveEn(remy, gusteaus).
viveEn(emile, chezMilleBar).
viveEn(django, pizzeriaJeSuis).

% Humanos:
sabeCocinar(linguini, ratatuille, 3).
sabeCocinar(linguini, sopa, 5).
sabeCocinar(colette, salmonAhumado, 9).
sabeCocinar(horst, ensaladaRusa, 8).

% TrabajaEn
trabajaEn(linguini, gusteaus).
trabajaEn(colette, gusteaus).
trabajaEn(skinner, gusteaus).
trabajaEn(amelie,cafeDes2Moulines).

%Esta en el menu
estaEnElMenu(Comida, Restaurante):-
    trabajaEn(Persona,Restaurante),
    sabeCocinar(Persona, Comida, _).

%Tutor
tieneTutor(linguini, Tutor):-
    trabajaEn(linguini, Lugar),
    viveEn(Tutor, Lugar).
tieneTutor(skinner, amelie).

%CocinaBien
cocinaBien(Persona, Plato):-
    sabeCocinar(Persona, Plato, Experiencia).
    7 < Experiencia. 

cocinaBien(Persona, Plato):-    
    sabeCocinar(Persona, Plato, Experiencia),
    tieneTutor(Persona, Tutor),
    cocinaBien(Tutor, Plato).

cocinaBien(remy, Plato):- sabeCocinar(_,Plato,_).


%3
esChef(Cocinero,Restaurante):-
    trabajaEn(Cocinero,Restaurante),
    