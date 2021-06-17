{-
Module      : Haskell
Description : La Argentina nos regala sabores
Date        : 16.06.2021
Grupo       : -
Name        : Guido Reboredo,
Subject     : Paradigmas de Programacion

La Argentina nos regala sabores

-}

{-------------- Imports --------------------}

import           Text.Show.Functions

{-------------------------------------------}

{----------- Declaracion de Datos ----------}

data Arbol = Arbol{
    especie   :: Especie,
    altura    :: Int,
    ancho     :: Int,
    vitalidad :: Float
}deriving Show

type Especie = (String, Crecimiento)

type Crecimiento = ( Int -> Int )

{-------------------------------------------}

{-------------- Datos de Prueba-------------}

--ARBOLES
unJacaranda = Arbol jacaranda 6 1 1.4
unPino = Arbol pino 5 3 1.9
unEucalipto = Arbol eucalipto 5 4 0.7
otroJacaranda =  Arbol jacaranda 10 2 1.0
unCerezo = Arbol cerezo 7 11 0.9
unBanano = Arbol banano 8 10 2.1
unBaoab  = Arbol baoab 3 10 2.2

--ESPECIES
cerezo= ("cerezo", escalonado)
banano= ("banano", progresivo)
jacaranda = ("jacaranda", progresivo)
pino = ("pino", duplica)
eucalipto = ("eucalipto", escalonado)
baoab = ("baoab", cuatriplica)

--CRECIMIENTOS
progresivo  = (`div` 2)
escalonado = (`mod` 2)
duplica = (2*)
torcido = progresivo.escalonado
cuatriplica = (4*)

{-------------------------------------------}

{------------------------------------------------------PUNTO 2------------------------------------------------------------------}

alturaEntre :: Int -> Int -> Arbol -> Bool
alturaEntre min max arbol = ((> min).altura $ arbol) && ((< max ).altura $ arbol)

esFondoso :: Arbol -> Bool
esFondoso unArbol = alturaEntre 6 15 unArbol && ((> altura unArbol) . ancho $ unArbol)

hayFondososConVitalidad :: [Arbol] -> Bool
hayFondososConVitalidad = any (\arbol -> esFondoso arbol && ((> 1).vitalidad $ arbol))

{-****************PRUEBAS******************

*Main> hayFondosos [unJacaranda,otroJacaranda,unCerezo]
False
*Main> unCerezo
Arbol {especie = ("cerezo",<function>), altura = 7, ancho = 11, vitalidad = 0.9}
*Main> hayFondosos [unJacaranda,otroJacaranda,unCerezo,unBanano]
True

*******************************************-}

{------------------------------------------------------------------------------------------------------------------------------}

{------------------------------------------------------PUNTO 3-----------------------------------------------------------------}

type FactorClimatico = Arbol -> Arbol

modificarAltura :: (Int->Int) -> Arbol -> Arbol
modificarAltura f unArbol = unArbol{altura = f.altura $ unArbol}
modificarAncho :: (Int->Int) -> Arbol -> Arbol
modificarAncho f unArbol = unArbol{ancho = f.ancho $ unArbol}

granizo :: FactorClimatico
granizo = modificarAltura progresivo . modificarAncho progresivo

{-****************PRUEBAS******************
*Main> unCerezo
Arbol {especie = ("cerezo",<function>), altura = 7, ancho = 11, vitalidad = 0.9}
*Main> granizo unCerezo
Arbol {especie = ("cerezo",<function>), altura = 3, ancho = 5, vitalidad = 0.9}
*******************************************-}

modificarVitalidad :: (Float -> Float) -> Arbol -> Arbol
modificarVitalidad f unArbol = unArbol{vitalidad = f.vitalidad $ unArbol}

transformarPorcentaje :: Float -> Arbol -> Float
transformarPorcentaje porcentaje unArbol= vitalidad unArbol * (porcentaje / 100)

lluvia :: Float -> FactorClimatico
lluvia mm unArbol = modificarAltura (+ 1).modificarVitalidad (+ transformarPorcentaje mm unArbol) $ unArbol

{-****************PRUEBAS******************

*Main> unCerezo
Arbol {especie = ("cerezo",<function>), altura = 7, ancho = 11, vitalidad = 0.9}
*Main> lluvia 20 unCerezo
Arbol {especie = ("cerezo",<function>), altura = 8, ancho = 11, vitalidad = 1.0799999}

*******************************************-}

temperatura :: Float -> FactorClimatico
temperatura grados unArbol 
    | grados < 0 = modificarVitalidad (/ 2) unArbol
    | grados > 40 =  modificarVitalidad ((*(-1)).(-) (transformarPorcentaje 40 unArbol)) unArbol
    | otherwise = unArbol

{-****************PRUEBAS******************

 *Main> temperatura 80 unCerezo
Arbol {especie = ("cerezo",<function>), altura = 7, ancho = 11, vitalidad = 0.53999996}
*Main> unCerezo
Arbol {especie = ("cerezo",<function>), altura = 7, ancho = 11, vitalidad = 0.9}
*Main> temperatura (-20) unCerezo
Arbol {especie = ("cerezo",<function>), altura = 7, ancho = 11, vitalidad = 0.45}
*Main> temperatura (30) unCerezo 
Arbol {especie = ("cerezo",<function>), altura = 7, ancho = 11, vitalidad = 0.9}

*******************************************-}

{------------------------------------------------------------------------------------------------------------------------------}


{------------------------------------------------------PUNTO 4-----------------------------------------------------------------}

crecerUnAnio :: Arbol -> Arbol
crecerUnAnio unArbol = modificarAltura (+ ((snd . especie $ unArbol).altura $ unArbol)) unArbol

{-****************PRUEBAS******************
 Arbol {especie = ("banano",<function>), altura = 8, ancho = 10, vitalidad = 2.1}
*Main> crecerUnAnio unBanano
Arbol {especie = ("banano",<function>), altura = 12, ancho = 10, vitalidad = 2.1}
*******************************************-}

{------------------------------------------------------------------------------------------------------------------------------}


{------------------------------------------------------PUNTO 5-----------------------------------------------------------------}

crecerUnAnioL :: [Arbol] -> [Arbol]
crecerUnAnioL  = map crecerUnAnio 

{-****************PRUEBAS******************
*Main> [unCerezo,unBanano]
[Arbol {especie = ("cerezo",<function>), altura = 7, ancho = 11, vitalidad = 0.9},Arbol {especie = ("banano",<function>), altura = 8, ancho = 10, vitalidad = 2.1}]
*Main> crecerUnAnioL [unCerezo,unBanano]
[Arbol {especie = ("cerezo",<function>), altura = 8, ancho = 11, vitalidad = 0.9},Arbol {especie = ("banano",<function>), altura = 12, ancho 
= 10, vitalidad = 2.1}]
*******************************************-}


{------------------------------------------------------------------------------------------------------------------------------}

{------------------------------------------------------PUNTO 7-----------------------------------------------------------------}

podarUnArbol :: Int -> Arbol -> Arbol
podarUnArbol mts unArbol = modificarAncho ((*(-1)).(-) mts) . modificarAltura ((*(-1)).(-) mts)  . modificarVitalidad (transformarPorcentaje 10 unArbol +) $ unArbol

{-****************PRUEBAS******************

*Main> unCerezo
Arbol {especie = ("cerezo",<function>), altura = 7, ancho = 11, vitalidad = 0.9}
*Main> podarUnArbol 2 unCerezo
Arbol {especie = ("cerezo",<function>), altura = 5, ancho = 9, vitalidad = 0.98999995}

*******************************************-}
{------------------------------------------------------------------------------------------------------------------------------}

{------------------------------------------------------PUNTO 8-----------------------------------------------------------------}

temporada :: Arbol -> [FactorClimatico] -> Arbol
temporada = foldl (flip ($))

{-****************PRUEBAS******************
*Main> unCerezo 
Arbol {especie = ("cerezo",<function>), altura = 7, ancho = 11, vitalidad = 0.9}
*Main> temporada unCerezo [lluvia 2,granizo,temperatura 20]
Arbol {especie = ("cerezo",<function>), altura = 4, ancho = 5, vitalidad = 0.918}
*******************************************-}

{------------------------------------------------------------------------------------------------------------------------------}

{------------------------------------------------------PUNTO 9-----------------------------------------------------------------}

{-****************PRUEBAS******************
 *Main> temporada unCerezo [lluvia 2,granizo,temperatura 20,podarUnArbol 2] 
Arbol {especie = ("cerezo",<function>), altura = 2, ancho = 3, vitalidad = 1.0098}
*Main> temporada unCerezo [lluvia 2,granizo,temperatura 20,podarUnArbol 2, crecerUnAnio]
Arbol {especie = ("cerezo",<function>), altura = 2, ancho = 3, vitalidad = 1.0098}
*******************************************-}

{------------------------------------------------------------------------------------------------------------------------------}

{------------------------------------------------------PUNTO 10----------------------------------------------------------------}

modificarArboles :: [FactorClimatico] -> [Arbol] -> [Arbol]
modificarArboles modificaciones = map (`temporada` modificaciones) 

estanOrdenados :: (Ord a) => (Arbol -> a) -> [FactorClimatico] -> [Arbol] -> Bool
estanOrdenados criterio modificaciones = verificarOrden.map criterio .  modificarArboles modificaciones

verificarOrden :: (Ord a) => [a] -> Bool
verificarOrden [_] = True
verificarOrden (x:y:xs) = (x <= y) && verificarOrden (y:xs) 
 
{-****************PRUEBAS******************
 *Main> estanOrdenados altura [lluvia 20,crecerUnAnio] [unCerezo,unBanano,unBaoab]
True   
*Main> estanOrdenados vitalidad [temperatura 45,crecerUnAnio] [unCerezo,unBanano,unBaoab]
True   
*Main> estanOrdenados vitalidad [temperatura 45,crecerUnAnio] [unBanano,unCerezo,unBaoab]              
False  
*******************************************-}

{------------------------------------------------------------------------------------------------------------------------------}