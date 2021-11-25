{-
Module      : Haskell
Description : https://docs.google.com/document/d/1C_oehBaJYavsacmThRZcrpIpX6axxVOdX19vYusRhlE/edit#
Date        : 18.06.2021
Grupo       : -
Name        : Guido Reboredo,
Subject     : Paradigmas de Programación

Vacaciones

-}

{-------------- Imports --------------------}

import           Text.Show.Functions

{-------------------------------------------}


{---------------------------------------------DECLARACION DE DATOS-------------------------------------------------------------}

data Turista = Turista{
    nivelCansancio :: Int,
    nivelStress    :: Int,
    viajaSolo      :: Bool,
    idiomas        :: [String]
}deriving Show

type Excursion = Turista -> Turista

{------------------------------------------------------------------------------------------------------------------------------}


{---------------------------------------------------DATOS DE PRUEBA------------------------------------------------------------}

carlos :: Turista
carlos = Turista 5 4 False ["Ingles","Espaniol"]
pedro :: Turista
pedro = Turista 3 3 True ["Portuges"]
ana :: Turista
ana = Turista 0 21 False ["Espaniol"]
beto :: Turista
beto = Turista 15 15 True ["Aleman"]
cathi :: Turista
cathi = Turista 15 15 True ["Aleman", "Catalan"]

{------------------------------------------------------------------------------------------------------------------------------}


{------------------------------------------------------EXCURSIONES-------------------------------------------------------------}

modificarCansancio :: (Int -> Int) -> Turista -> Turista
modificarCansancio modif unTurista = unTurista{ nivelCansancio = modif.nivelCansancio $ unTurista}
modificarStress :: (Int -> Int) -> Turista -> Turista
modificarStress modif unTurista = unTurista{ nivelStress = modif.nivelStress $ unTurista}
aniadirIdioma :: String -> Turista -> Turista
aniadirIdioma idioma unTurista = unTurista {idiomas = idioma : idiomas unTurista}
modificarCompania :: Bool -> Turista -> Turista
modificarCompania bool unTurista = unTurista { viajaSolo = bool}

plusExcursion :: Int -> Turista -> Turista
plusExcursion porc unTurista= modificarStress (flip (-).(`div` 100).( porc * ).nivelStress $ unTurista) unTurista


irALaPlaya :: Excursion
irALaPlaya unTurista
  | (==True).viajaSolo $ unTurista = plusExcursion 10 . modificarCansancio (flip (-) 5) $ unTurista
  | otherwise = plusExcursion 10 . modificarStress (flip (-) 1) $ unTurista

{-****************PRUEBAS******************

*Main> irALaPlaya carlos
Turista {nivelCansancio = 5, nivelStress = 3, viajaSolo = False, idiomas = ["Ingles","Espa\241ol"]}
*Main> irALaPlaya pedro
Turista {nivelCansancio = -2, nivelStress = 3, viajaSolo = True, idiomas = ["Portuges"]}

*******************************************-}

apreciarUn :: String -> Excursion
apreciarUn elemento = plusExcursion 10 . modificarStress (flip (-) (length elemento))  

{-****************PRUEBAS******************

*Main> apreciarUn "lago" carlos
Turista {nivelCansancio = 5, nivelStress = 0, viajaSolo = False, idiomas = ["Ingles","Espa\241ol"]}
*Main> apreciarUn "sol" carlos
Turista {nivelCansancio = 5, nivelStress = 1, viajaSolo = False, idiomas = ["Ingles","Espa\241ol"]}
*Main>

*******************************************-}

salirHablarIdioma :: String -> Excursion
salirHablarIdioma idioma  = plusExcursion 10 . modificarCompania False . aniadirIdioma idioma


{-****************PRUEBAS******************

*Main> salirHablarIdioma "chino" carlos
Turista {nivelCansancio = 5, nivelStress = 4, viajaSolo = False, idiomas = ["chino","Ingles","Espaniol"]}

*******************************************-}

intensidad :: Int -> Int
intensidad = (`div` 4)

caminar :: Int -> Excursion
caminar tiempo  = plusExcursion 10 . modificarCansancio (+ intensidad tiempo) . modificarStress  (flip (-) (intensidad tiempo)) 


{-****************PRUEBAS******************
 
*Main> caminar 10 carlos
Turista {nivelCansancio = 7, nivelStress = 2, viajaSolo = False, idiomas = ["Ingles","Espaniol"]}
*Main> caminar 4 carlos 
Turista {nivelCansancio = 6, nivelStress = 3, viajaSolo = False, idiomas = ["Ingles","Espaniol"]}

*******************************************-}

paseoEnBarco :: String -> Excursion
paseoEnBarco "fuerte" = plusExcursion 10 . modificarCansancio (+10) . modificarStress (+6)
paseoEnBarco "moderada" = plusExcursion 10 
paseoEnBarco _ = plusExcursion 10 . caminar 10. salirHablarIdioma "Aleman". apreciarUn "mar"

{-****************PRUEBAS******************
 
*Main> paseoEnBarco "tranquila" carlos
Turista {nivelCansancio = 7, nivelStress = -1, viajaSolo = False, idiomas = ["Aleman","Ingles","Espaniol"]}
*Main> paseoEnBarco "moderada" carlos 
Turista {nivelCansancio = 5, nivelStress = 4, viajaSolo = False, idiomas = ["Ingles","Espaniol"]}
*Main> paseoEnBarco "fuerte" carlos  
Turista {nivelCansancio = 15, nivelStress = 10, viajaSolo = False, idiomas = ["Ingles","Espaniol"]}

*******************************************-}
{------------------------------------------------------------------------------------------------------------------------------}


{------------------------------------------------------PUNTO 2------------------------------------------------------------------}

deltaSegun :: (a -> Int) -> a -> a -> Int
deltaSegun f algo1 algo2 = f algo1 - f algo2

deltaExcursionSegun :: (Turista -> Int) -> Turista -> Excursion -> Int
deltaExcursionSegun f unTurista unaExcursion = deltaSegun f (unaExcursion unTurista) unTurista

{-****************PRUEBAS******************
 
*Main> deltaExcursionSegun nivelStress ana irALaPlaya
-3  

*******************************************-}

esEducativa :: Turista -> Excursion -> Bool
esEducativa turista = (>0).deltaExcursionSegun (length.idiomas) turista 

{-****************PRUEBAS******************
 
*Main> esEducativa (salirHablarIdioma "japones") ana
True   
*Main> esEducativa (caminar 10) ana                 
False

*******************************************-}

esDesestresante :: Turista -> Excursion -> Bool
esDesestresante turista = (< (-3)) . deltaExcursionSegun nivelStress turista

{-****************PRUEBAS******************

*Main> esDesestresante ana (caminar 20)
True   
*Main> esDesestresante ana (caminar 2) 
False  

*******************************************-}


{------------------------------------------------------------------------------------------------------------------------------}

{------------------------------------------------------PUNTO 3-----------------------------------------------------------------}

type Paquete = [Excursion]

completo :: Paquete
completo = [caminar 20, apreciarUn "cascada",caminar 40, salirHablarIdioma "malmecquiano"]
ladoB :: Excursion -> Paquete
ladoB excursion = [paseoEnBarco "tranquila"] ++ [excursion] ++ [caminar 120] 
islaVecina :: String -> Paquete
islaVecina "fuerte" = [paseoEnBarco "fuerte", apreciarUn "lago", paseoEnBarco "fuerte" ]
islaVecina marea = [paseoEnBarco marea, irALaPlaya , paseoEnBarco marea ]

realizarTour :: Turista -> Paquete -> Turista
realizarTour = foldl (flip ($))

{-****************PRUEBAS******************
 
*Main> realizarTour ana completo
Turista {nivelCansancio = 15, nivelStress = 0, viajaSolo = False, idiomas = ["malmecquiano","Espaniol"]}
*Main> realizarTour ana (ladoB irALaPlaya)
Turista {nivelCansancio = 32, nivelStress = -18, viajaSolo = False, idiomas = ["Aleman","Espaniol"]}
*Main> realizarTour ana (islaVecina "fuerte")
Turista {nivelCansancio = 20, nivelStress = 23, viajaSolo = False, idiomas = ["Espaniol"]}

*******************************************-}

hayDesestresante :: Turista -> Paquete -> Bool
hayDesestresante unTurista = any (esDesestresante unTurista)

terminaAcompaniado :: Turista -> Paquete -> Bool
terminaAcompaniado unTurista = not.viajaSolo.realizarTour unTurista 

esConvincente :: Turista -> Paquete -> Bool
esConvincente unTurista unPaquete = hayDesestresante unTurista unPaquete && terminaAcompaniado unTurista unPaquete

hayAlgunConvincente :: Turista -> [Paquete] -> Bool
hayAlgunConvincente unTurista = any ( esConvincente unTurista )

{-****************PRUEBAS******************
 
*Main> hayAlgunConvincente ana [ladoB (caminar 10), completo]
True   

*******************************************-}

espiritualidad ::  Paquete -> Turista -> Int
espiritualidad unPaquete unTurista = deltaSegun nivelStress (realizarTour unTurista unPaquete) unTurista + deltaSegun nivelCansancio (realizarTour unTurista unPaquete) unTurista

sumatoriaEspiritualidad :: Paquete -> [Turista] -> Int
sumatoriaEspiritualidad paquete  = foldr ((+) . espiritualidad paquete) 0 

efectividad :: Paquete -> [Turista] -> Int
efectividad paquete = sumatoriaEspiritualidad paquete. filter (`esConvincente` paquete)

{-****************PRUEBAS******************
 
*Main> efectividad completo [ana,carlos,pedro]
-8     

*******************************************-}


{------------------------------------------------------------------------------------------------------------------------------}

{------------------------------------------------------PUNTO 4------------------------------------------------------------------}


playasInfinitas :: Paquete
playasInfinitas = repeat irALaPlaya

{-****************PRUEBAS******************
 
*Main> take 10 playasInfinitas
[<function>,<function>,<function>,<function>,<function>,<function>,<function>,<function>,<function>,<function>]

*******************************************-}




{------------------------------------------------------------------------------------------------------------------------------}