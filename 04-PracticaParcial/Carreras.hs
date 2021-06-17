{-
Module      : Haskell
Description : Carreras Parcial
Date        : 17.06.2021
Grupo       : -
Name        : Guido Reboredo,
Subject     : Paradigmas de Programación
-}

{-------------- Imports --------------------}

import           Text.Show.Functions

{-------------------------------------------}

{-------------------------------------------------DECLARACION DE TIPOS--------------------------------------------------}

data Auto = Auto{
    color     :: String,
    velocidad :: Int,
    distancia :: Int
} deriving (Show,Eq)

type Carrera = [Auto]

-------------------------------------------------------------------------------------------------------------------}

{--------------------------------------------- DATOS DE PRUEBA ----------------------------------------------------------------}

autoRojo = Auto "Rojo" 20 5
autoAzul = Auto "Azul" 15 3
autoVerde = Auto "Verde" 25 100

carrera :: Carrera
carrera = [autoRojo,autoVerde,autoAzul]


{------------------------------------------------------------------------------------------------------------------------------}

{------------------------------------------------------PUNTO 1-----------------------------------------------------------------}

distanciaMenorA :: Int -> Int -> Int -> Bool
distanciaMenorA d d1 = (< 10) . abs . (d1 -)

esOtroAuto :: Auto -> Auto -> Bool
esOtroAuto unAuto = (/= color unAuto).color

estanCerca :: Auto -> Auto -> Bool
estanCerca unAuto otroAuto = esOtroAuto unAuto otroAuto && (distanciaMenorA 10 (distancia unAuto) . distancia)  otroAuto

{-****************PRUEBAS******************
*Main> estanCerca autoAzul autoVerde
False
*Main> estanCerca autoAzul autoRojo
True
*******************************************-}

vaGanando :: Auto -> [Auto] -> Bool
vaGanando unAuto  = all ( \auto -> ((< distancia unAuto) . distancia $ auto) || ((== False) . esOtroAuto unAuto  $ auto) )

{-****************PRUEBAS******************

*Main> vaGanando autoAzul carrera
False
*Main> vaGanando autoVerde carrera
True

*******************************************-}

estaTranquilo :: Auto -> Carrera -> Bool
estaTranquilo unAuto carrera = vaGanando unAuto carrera && ( not . any (estanCerca unAuto) $ carrera)

{-****************PRUEBAS******************

*Main> estaTranquilo autoVerde carrera
True
*Main> estaTranquilo autoAzul carrera
False

*******************************************-}

cuantosLeGanan :: Auto -> Carrera -> Int
cuantosLeGanan unAuto  = length . filter ( (> distancia unAuto) . distancia )

puesto :: Auto -> Carrera -> Int
puesto unAuto = (+ 1) . cuantosLeGanan unAuto

{-****************PRUEBAS******************
*Main> puesto autoVerde carrera
1
*Main> puesto autoAzul carrera
3
*Main> puesto autoRojo carrera
2
*******************************************-}
{------------------------------------------------------------------------------------------------------------------------------}

{------------------------------------------------------PUNTO 2------------------------------------------------------------------}

type Manipulador = Auto -> Auto
type Modificador = Int -> Int


correr :: Int -> Manipulador
correr t unAuto = unAuto{ distancia = ( + (t * velocidad unAuto) ).distancia $ unAuto }

{-****************PRUEBAS******************
*Main> autoRojo
Auto {color = "Rojo", velocidad = 20, distancia = 5}
*Main> correr 10 autoRojo
Auto {color = "Rojo", velocidad = 20, distancia = 205}
*Main>
*******************************************-}

sumar5 :: Modificador
sumar5 = ( + 5 )

modificarVelocidad :: Modificador -> Manipulador
modificarVelocidad funcion unAuto = unAuto {velocidad = funcion . velocidad $ unAuto}

{-****************PRUEBAS******************
*Main> autoRojo
Auto {color = "Rojo", velocidad = 20, distancia = 5}
*Main> modificarVelocidad sumar5 autoRojo
Auto {color = "Rojo", velocidad = 25, distancia = 5}
*Main>

*******************************************-}

{------------------------------------------------------------------------------------------------------------------------------}

{------------------------------------------------------PUNTO 3-----------------------------------------------------------------}

type PowerUp = Auto -> Carrera -> Carrera

afectarALosQueCumplen :: (a -> Bool) -> ( a -> a) -> [a] -> [a]
afectarALosQueCumplen criterio efecto lista = (map efecto . filter criterio) lista ++ filter (not.criterio) lista

terremoto :: PowerUp
terremoto unAuto  =  afectarALosQueCumplen (estanCerca unAuto) ( modificarVelocidad (flip (-) 50) )

{-****************PRUEBAS******************

*Main> terremoto autoRojo carrera
[Auto {color = "Azul", velocidad = -35, distancia = 3},Auto {color = "Rojo", velocidad = 20, distancia = 5},Auto {color = "Verde", velocidad 
= 25, distancia = 100}]
*Main>

*******************************************-}

leGanaA :: Auto -> Auto -> Bool
leGanaA unAuto otroAuto = distancia unAuto > distancia otroAuto  


miguelitos :: Int -> PowerUp
miguelitos cantidad unAuto = afectarALosQueCumplen (leGanaA unAuto) ( modificarVelocidad (flip (-) cantidad) )

{-****************PRUEBAS******************
 
*Main> miguelitos 1 autoVerde carrera
[Auto {color = "Rojo", velocidad = 19, distancia = 5},Auto {color = "Azul", velocidad = 14, distancia = 3},Auto {color = "Verde", velocidad = 25, distancia = 100}]
*Main> autoRojo
Auto {color = "Rojo", velocidad = 20, distancia = 5}
*Main> autoAzul
Auto {color = "Azul", velocidad = 15, distancia = 3}
*Main> autoVerde
Auto {color = "Verde", velocidad = 25, distancia = 100}

*******************************************-}

jetPack :: Int -> PowerUp
jetPack tiempo unAuto = afectarALosQueCumplen (not.esOtroAuto unAuto) (  modificarVelocidad (`div` 2). correr tiempo . modificarVelocidad (*2))

{-****************PRUEBAS******************
 
*Main> jetPack 2 autoRojo carrera
[Auto {color = "Rojo", velocidad = 20, distancia = 85},Auto {color = "Verde", velocidad = 25, distancia = 100},Auto {color = "Azul", velocidad = 15, distancia = 3}]
*Main> autoRojo
Auto {color = "Rojo", velocidad = 20, distancia = 5}

*******************************************-}


{------------------------------------------------------------------------------------------------------------------------------}

{------------------------------------------------------PUNTO 4-----------------------------------------------------------------}

correnTodos :: Int -> Carrera -> Carrera
correnTodos tiempo  = map (correr tiempo) 

buscarColor :: String -> Carrera -> Auto
buscarColor unColor  = head . filter ((== unColor) . color)

usaPowerUp :: PowerUp -> String -> Carrera -> Carrera
usaPowerUp pu color = pu.buscarColor color $ carrera

listaPosiciones :: Carrera -> [(Int,String)] 
listaPosiciones carrera = map (\auto -> (puesto auto carrera,color auto)) carrera

simularCarrera :: Carrera -> [Carrera ->Carrera] -> [(Int,String)]
simularCarrera carrera = ordenarPosiciones.listaPosiciones . foldl (flip ($)) carrera
 
{-****************PRUEBAS******************
*Main> simularCarrera carrera [usaPowerUp (miguelitos 20) "Rojo", correnTodos 10]           
[(3,"Azul"),(2,"Rojo"),(1,"Verde")]
*******************************************-}

ordenarPosiciones :: [(Int,String)]->[(Int,String)]
ordenarPosiciones [] = []
ordenarPosiciones [(x,y)] = [(x,y)]
ordenarPosiciones (x:y:xs)
 | fst x < fst y = x : ordenarPosiciones (y:xs)
 | otherwise = y: ordenarPosiciones (x:xs)




{------------------------------------------------------------------------------------------------------------------------------}







