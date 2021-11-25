% https://docs.google.com/document/d/1Rhwg06D-6vJymzsldwLzZYgEwDfo4Jnr/edit

entretenimiento(cine).
entretenimiento(teatro).
entretenimiento(pool).
entretenimiento(parqueTematico).
costo(cine, 300).
costo(teatro, 500).
costo(pool, 250).
costo(parqueTematico, 800).


entretenimientos(Disponible, Sublista):-
    conjuntoEntretenimientos(ConjuntoEntretenimientos),
    sublista(ConjuntoEntretenimientos, Disponible, Sublista ).

conjuntoEntretenimientos(Lista):- findall(Entre, entretenimiento(Entre), Lista).

sublista([], _, []).
sublista([Entre|Cola], TotalDinero, [Entre| Resto]):-
    costo(Entre,Monto), Monto =< TotalDinero, 
    DineroRestante is TotalDinero - Monto, 
    sublista(Cola, DineroRestante, Resto).
sublista([_|Cola], Disponible, Lista):- 
    sublista(Cola, Disponible, Lista).


%EJERCICIO INTEGRADOR:



%tarea(agente, tarea, ubicacion)
%tareas:
%  ingerir(descripcion, tamaño, cantidad)
%  apresar(malviviente, recompensa)
%  asuntosInternos(agenteInvestigado)
%  vigilar(listaDeNegocios)

tarea(vigilanteDelBarrio, ingerir(pizza, 1.5, 2),laBoca).
tarea(vigilanteDelBarrio, vigilar([pizzeria, heladeria]), barracas).
tarea(canaBoton, asuntosInternos(vigilanteDelBarrio), barracas).
tarea(sargentoGarcia, vigilar([pulperia, haciendaDeLaVega, plaza]),puebloDeLosAngeles).
tarea(sargentoGarcia, ingerir(vino, 0.5, 5),puebloDeLosAngeles).
tarea(sargentoGarcia, apresar(elzorro, 100), puebloDeLosAngeles). 
tarea(vega, apresar(neneCarrizo,50),avellaneda).
tarea(jefeSupremo, vigilar([congreso,casaRosada,tribunales]),laBoca).


%Las ubicaciones que existen son las siguientes:
ubicacion(puebloDeLosAngeles).
ubicacion(avellaneda).
ubicacion(barracas).
ubicacion(marDelPlata).
ubicacion(laBoca).
ubicacion(uqbar).

%jefe(jefe, subordinado)
jefe(jefeSupremo,vega ).
jefe(vega, vigilanteDelBarrio).
jefe(vega, canaBoton).
jefe(jefeSupremo,sargentoGarcia).


%frecuenta(agente, lugar)

agente(Agente):- tarea(Agente, _, _).

frecuenta(Agente,Lugar):-
    tarea(Agente,_,Lugar).
frecuenta(Agente, buenosAires):- 
    agente(Agente).
frecuenta(vega,quilmes).
frecuenta(Agente, marDelPlata):-
    tarea(Agente, vigilar(Negocios), _), 
    member(alfajores, Negocios).

%Lugar Inaccesible, Nadie lo frecuenta. 
inaccesible(Lugar):-
    ubicacion(Lugar), 
    not(frecuenta(_,Lugar)).
    
%afincado
afincado(Agente):-
    tarea(Agente,_,Ubicacion),
    forall(tarea(Agente,_,OtraUbicacion), igual(Ubicacion, OtraUbicacion)).

igual(Lugar, Lugar).

%Cadena de Mando

cadenaDeMando([_]).
cadenaDeMando([ Jefe,Subor | Resto ]):- 
    jefe(Jefe, Subor),
    cadenaDeMando([Subor | Resto ]).

%agente Premiado

agentePremiado(Agente):-
    puntaje(Agente, Puntos),
    forall(puntaje(_,OtroPuntaje), Puntos>=OtroPuntaje).

puntaje(Agente, PuntajeTotal):- 
    agente(Agente),
    findall(Puntaje, puntajeTarea(Agente, Puntaje), ListaPuntajes),
    sumlist(ListaPuntajes, PuntajeTotal).


puntajeTarea(Agente,PuntajeTarea):-
    tarea(Agente, Tarea,_),
    cantidadPuntosPorTarea(Tarea, PuntajeTarea).

cantidadPuntosPorTarea(vigilar(Negocios), PuntosTotal):-
    length(Negocios, Cantidad),
    PuntosTotal is Cantidad * 5.
    
cantidadPuntosPorTarea(ingerir(_,Tamanio,Cantidad), PuntosTotal):-
    Unidades is Tamanio * Cantidad,
    PuntosTotal is (-10)*Unidades.

cantidadPuntosPorTarea(apresar(_,Recompenza), PuntosTotal):-
    PuntosTotal is Recompenza / 2.

cantidadPuntosPorTarea(asuntosInternos(Agente), PuntosTotal):-
    puntaje(Agente, PuntosAgente),
    PuntosTotal is PuntosAgente * 2. 