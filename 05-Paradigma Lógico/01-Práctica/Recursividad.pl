%------------ Transitividad -------------
padre(tatara, bisa).
padre(bisa, abu).
padre(abu, padre).
padre(padre, hijo).

ancestro(Padre,Persona):- 
    padre(Padre,Persona).

ancestro(Ancestro,Persona):- 
    padre(Padre,Persona), 
    ancestro(Ancestro,Padre).

%--------------------------------------

%------------ Distancias --------------
distancia(buenosAires, puertoMadryn, 1300).
distancia(puertoMadryn, puertoDeseado, 732).
distancia(puertoDeseado, rioGallegos, 736).
distancia(puertoDeseado, calafate, 979).
distancia(rioGallegos, calafate, 304).
distancia(calafate, chalten, 213).


kilometrosViaje(Origen,Destino,Km):-
    distancia(Origen,Destino,Km).
kilometrosViaje(Origen,Destino,Km):-
    distancia(Origen,PuntoIntermedio,KmIntermedio),
    kilometrosViaje(PuntoIntermedio,Destino,KmFinales),
    Km is KmIntermedio + KmFinales.

totalViaje(Origen, Destino, Kms):-
   kilometrosViaje(Origen, Destino, Kms).
totalViaje(Origen, Destino, Kms):-
   kilometrosViaje(Destino, Origen, Kms).


%------------------------------------------

%----------------MEMBER-----------------------

miMember(X,[X|_]).
miMember(X,[_|Z]):-miMember(X,Z).

%----------------------------------------------

%--------------nth1-----------------------------


miNth1(1,[Elemento|_],Elemento).

miNth1(Posicion,[_|Cola],Elemento):-
    miNth1(PosicionCola,Cola,Elemento),
    Posicion is PosicionCola + 1.

%------------------------------------------------