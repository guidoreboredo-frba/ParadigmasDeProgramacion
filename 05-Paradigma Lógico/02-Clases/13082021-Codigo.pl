% https://docs.google.com/document/d/1lV6vlO96KjJy-HakGEcpprrLaT_FU-U-/edit

transporte(juan, camina).
transporte(marcela, subte(a)).
transporte(pepe, colectivo(160,d)).
transporte(elena, colectivo(76)).
transporte(maria, auto(500, fiat,2015)).
transporte(ana, auto(fiesta, ford, 2014)).
transporte(roberto, auto(qubo, fiat, 2015)).
manejaLento(manuel).
manejaLento(ana).


% consultas que permita conocer quiénes son los que vienen en auto de marca fiat.
% transporte(Persona, auto(_,fiat,_)).


tardaMucho(Persona):- transporte(Persona, camina).
tardaMucho(Persona):- transporte(Persona,auto(_,_,_)), manejaLento(Persona).

viajaEnColectivo(Persona):- transporte(Persona, colectivo(_,_)).
viajaEnColectivo(Persona):- transporte(Persona, colectivo(_)).



%lugar(nombre,hotel(nombre,cantEstrellas,montoDiario)%
lugar(marDelPlata, hotel(elViajante,4,1500)).
lugar(marDelPlata, hotel(casaNostra,3,1000)).
lugar(lasToninas, hotel(holidays,2,500)).
lugar(tandil,quinta(amanecer,pileta,650)).
lugar(bariloche,carpa(80)).
lugar(laFalda, casa(pileta,600)).
lugar(rosario, casa(garaje,400)).

%puedeGastar(nombre,cantDias,montoTotal)%
puedeGastar(ana,4,10000).
puedeGastar(hernan,5,8000).
puedeGastar(mario,5,4000).


puedeIr(Persona,Lugar,Alojamiento):- 
    lugar(Lugar,Alojamiento), 
    compleCondiciones(Alojamiento, MontoDiario), 
    puedeGastar(Persona, CantDias, Disponible),
    Disponible >= MontoDiario * CantDias.

cumpleCondiciones(hotel(_, Estrellas, MontoDiario), MontoDiario):-
    Estrellas > 3.
cumpleCondiciones(casa(garaje, MontoDiario), MontoDiario).
cumpleCondiciones(quinta(_,pileta,MontoDiario), MontoDiario).
cumpleCondiciones(carpa(MontoDiario), MontoDiario).


% 2 

puedeIrACualquierLugar(Persona):- persona(Persona), 
    forall(lugar(Lugar, _), puedeIr(Persona, Lugar, _)).

persona(Persona):- puedeGastar(Persona, _, _).


puedeAlojarseEnCualquierAlojamiento(Persona):- persona(Persona),
forall(lugar(Persona,Alojamiento), puedeIr(Persona, _, Alojamiento)).


