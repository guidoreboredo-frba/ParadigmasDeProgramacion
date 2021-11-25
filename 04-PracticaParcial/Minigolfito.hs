{-
Module      : Haskell
Description : https://docs.google.com/document/d/1LeWBI6pg_7uNFN_yzS2DVuVHvD0M6PTlG1yK0lCvQVE/edit
Date        : 17.06.2021
Grupo       : -
Name        : Guido Reboredo,
Subject     : Paradigmas de Programación

Mini Golfito

-}

{-------------- Imports --------------------}

import Text.Show.Functions

{-------------------------------------------}



{----------------------------------------------- DEFINICION DE DATOS ----------------------------------------------------------}

data Jugador = UnJugador {
  nombre    :: String,
  padre     :: String,
  habilidad :: Habilidad
} deriving (Eq, Show)

data Habilidad = Habilidad {
  fuerzaJugador    :: Int,
  precisionJugador :: Int
} deriving (Eq, Show)

data Tiro = UnTiro {
  velocidad :: Int,
  precision :: Int,
  altura    :: Int
} deriving (Eq, Show)

type Puntos = Int

{------------------------------------------------------------------------------------------------------------------------------}

{------------------------------------------------ DATOS DE PRUEBA -------------------------------------------------------------}

bart = UnJugador "Bart" "Homero" (Habilidad 25 60)
todd = UnJugador "Todd" "Ned" (Habilidad 15 80)
rafa = UnJugador "Rafa" "Gorgory" (Habilidad 10 1)

{------------------------------------------------------------------------------------------------------------------------------}

{---------------------------------------------------- FUNCIONES ---------------------------------------------------------------}
between n m x = x `elem` [n .. m]

maximoSegun f = foldl1 (mayorSegun f)

mayorSegun f a b
  | f a > f b = a
  | otherwise = b

estanOrdenados :: [Pokemon] -> Bool

EstanOrdenados :: Ord a => [a] -> Bool
EstanOrdenados [] = True
EstanOrdenados [_] = True
EstanOrdenados (x:y:xs) = (x <= y) && EstanOrdenados (y:xs)






{------------------------------------------------------------------------------------------------------------------------------}


{------------------------------------------------------PUNTO 1-----------------------------------------------------------------}

type Palo = Habilidad -> Tiro 

putter :: Palo
putter habilidad = UnTiro {
    velocidad = 10,
    precision = (* 2) . precisionJugador $ habilidad,
    altura = 0
}

madera :: Palo
madera habilidad = UnTiro {
    velocidad = 100,
    precision = (`div` 2) .  precisionJugador $ habilidad,
    altura = 5
}

hierro :: Int -> Palo
hierro n habilidad = UnTiro {
    velocidad = (* n) . fuerzaJugador $ habilidad,
    precision = (`div` n) . precisionJugador $ habilidad,
    altura = minimo0 (n - 3) 

}

minimo0 :: Int -> Int
minimo0 n 
 | n >= 0 = n
 | otherwise = 0


palosDisponibles :: [Palo]
palosDisponibles = [hierro n | n <- [1..10]] ++ [madera, putter]


{-****************PRUEBAS******************

*Main> hierro 3  (Habilidad 25 60)
UnTiro {velocidad = 75, precision = 20, altura = 0}
*Main> madera  (Habilidad 25 60)
UnTiro {velocidad = 100, precision = 30, altura = 5}
*Main> putter  (Habilidad 25 60)
UnTiro {velocidad = 10, precision = 120, altura = 0}

*******************************************-}

{------------------------------------------------------------------------------------------------------------------------------}

{------------------------------------------------------PUNTO 2-----------------------------------------------------------------}

golpe :: Jugador -> Palo -> Tiro
golpe unaPersona unPalo = unPalo.habilidad $ unaPersona

{-****************PRUEBAS******************

*Main> golpe bart putter
UnTiro {velocidad = 10, precision = 120, altura = 0}

*******************************************-}

{------------------------------------------------------------------------------------------------------------------------------}

{------------------------------------------------------PUNTO 3-----------------------------------------------------------------}

type Obstaculo = Tiro -> Tiro

tiroEnBlanco :: Tiro
tiroEnBlanco = UnTiro 0 0 0

tunelConRampa :: Obstaculo
tunelConRampa unTiro
  | (precision unTiro > 90) && (altura unTiro == 0) = unTiro{ velocidad = (* 2).velocidad $ unTiro , precision = 100}
  | otherwise = tiroEnBlanco

{-****************PRUEBAS******************
*Main> tunelConRampa (UnTiro 5 5 5) 
UnTiro {velocidad = 0, precision = 0, altura = 0}
*Main> tunelConRampa (UnTiro 100 5 0)
UnTiro {velocidad = 0, precision = 0, altura = 0}
*Main> tunelConRampa (UnTiro 20 100 0)
UnTiro {velocidad = 40, precision = 100, altura = 0}
*******************************************-}

laguna :: Int -> Obstaculo
laguna largo unTiro 
    | ((> 80).velocidad $ unTiro) && ( between 1 5 . altura $ unTiro ) = unTiro {altura = (`div` largo).altura $ unTiro}
    | otherwise = tiroEnBlanco

{-****************PRUEBAS******************

*Main> laguna 2 (UnTiro 90 100 0)
UnTiro {velocidad = 0, precision = 0, altura = 0}
*Main> laguna 2 (UnTiro 20 100 2)
UnTiro {velocidad = 0, precision = 0, altura = 0}
*Main> laguna 2 (UnTiro 90 100 2)
UnTiro {velocidad = 90, precision = 100, altura = 1}

*******************************************-}

hoyo :: Obstaculo
hoyo tiro = tiroEnBlanco

{-****************PRUEBAS******************

*Main> hoyo (UnTiro 90 100 0)    
UnTiro {velocidad = 0, precision = 0, altura = 0}

*******************************************-}


{------------------------------------------------------------------------------------------------------------------------------}

{------------------------------------------------------PUNTO 4-----------------------------------------------------------------}

obstaculoSuperado :: Tiro -> Bool
obstaculoSuperado (UnTiro 0 0 0) = False
obstaculoSuperado _ = True


palosUtiles :: Jugador -> Obstaculo -> [Palo]
palosUtiles unJugador unObstaculo = filter ( obstaculoSuperado.unObstaculo.golpe unJugador ) palosDisponibles

{-****************PRUEBAS******************

*Main> palosUtiles bart (laguna 20)
[<function>,<function>,<function>,<function>,<function>,<function>]
*Main> palosUtiles bart tunelConRampa
[<function>]
*Main> palosUtiles rafa tunelConRampa
[]
*Main> palosUtiles rafa (laguna 2)   
[<function>]

*******************************************-}


cuantosSupera :: [Obstaculo] -> Tiro -> Int
cuantosSupera obstaculos tiro = length.takeWhile (\obs -> obstaculoSuperado.obs $ tiro) $ obstaculos

{-****************PRUEBAS******************

*Main> cuantosSupera [tunelConRampa, tunelConRampa, hoyo] (UnTiro 10 95 0)
2    

*******************************************-}

paloMasUtil :: Jugador -> [Obstaculo] -> Palo
paloMasUtil  unJugador obstaculos = maximoSegun (cuantosSupera obstaculos. golpe unJugador) palosDisponibles

{-****************PRUEBAS******************

*Main> golpe bart (paloMasUtil bart [tunelConRampa, tunelConRampa])
UnTiro {velocidad = 10, precision = 120, altura = 0}

*******************************************-}


{------------------------------------------------------------------------------------------------------------------------------}


{------------------------------------------------------PUNTO 5-----------------------------------------------------------------}

type Puntajes = (Jugador, Int)

listaTorneo :: [Puntajes]
listaTorneo = [(bart,10), (rafa,5), (todd,20)]

ganador :: [Puntajes] -> Puntajes
ganador = maximoSegun snd 

obtenerPerdedores :: [Puntajes] -> [Puntajes]
obtenerPerdedores puntajes =  filter (\ puntaje -> (snd . ganador $ puntajes) > snd puntaje) puntajes

padresPerdedores :: [Puntajes] -> [String]
padresPerdedores puntajes = map (padre.fst) (obtenerPerdedores puntajes)


{------------------------------------------------------------------------------------------------------------------------------}
