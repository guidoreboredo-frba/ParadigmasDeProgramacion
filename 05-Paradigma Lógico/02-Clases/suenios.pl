%%https://docs.google.com/document/d/1DJy2ofrWdPu_Alaw1XuHklnG3LhPeROW/edit?usp=sharing&ouid=101809949137660188163&rtpof=true&sd=true

%PREDICADO creeEn(Persona, Personaje)
creeEn(gabriel, campanita).
creeEn(gabriel, magoDeOz).
creeEn(gabriel, cavenaghi).
creeEn(juan, conejoDePascua).
creeEn(macarena, reyesMagos).
creeEn(macarena, magoCaria).
creeEn(macarena, campanita).

%PREDICADO suenio(Persona, Suenio).
%%FUNCTOR ganaLoteria,futbolista,cantante
suenio(gabriel, ganarLoteria([5,9])).
suenio(gabriel, futbolista(arsenal)).
suenio(juan, cantante(100000)).
suenio(macarena, cantante(10000)).



%2
esAmbiciosa(Persona):-persona(Persona), sumaTotalDificultades(Persona, Total), 
        Total > 20.

persona(Persona):- creeEn(Persona, _).
sumaTotalDificultades(Persona, Total):- 
    findall(Dificultad, dificultad(Persona, Dificultad), ListaDificultades),
    sumlist(ListaDificultades, Total).

dificultad(Persona, NivelDificultad):- suenio(Persona, Suenio), 
                nivelDificultad(Suenio, NivelDificultad).

nivelDificultad(cantante(CantDiscos), 6):- CantDiscos > 500000.
nivelDificultad(cantante(CantDiscos), 4):- CantDiscos =< 500000.
nivelDificultad(ganarLoteria(Numeros), Dificultad):- length(Numeros, CantNumeros), 
                Dificultad is CantNumeros * 10.
nivelDificultad(futbolista(EquipoChico), 3):- equipoChico(EquipoChico).
nivelDificultad(futbolista(Equipo), 16):- not(equipoChico(Equipo)).

equipoChico(arsenal).
equipoChico(aldosivi).
