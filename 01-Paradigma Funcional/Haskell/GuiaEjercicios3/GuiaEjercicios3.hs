{- 
Module      :  GuiaEjercicios3.hs
Description :  Trabajo Práctico Numero 3
Date        :  05.07.2021
Name        :  Guido Reboredo
Subject     :  PdeP K2054 - UTN FRBA

Ejercicios Prácticos Paradigma Funcional 
-}

{- Definiciones -}

type Nombre = String
type Notas = [Int]
data Persona = Alumno {nombre :: Nombre, notas :: Notas}

{- EJERCICIO #1 -}

promedio :: Notas -> Int
promedio notas = sum notas `div` length notas

promediosAlumnos :: [Persona] -> [(Nombre , Int)]
promediosAlumnos alumnos = map (\unAlumno -> (nombre unAlumno, promedio . notas $ unAlumno)) alumnos

alumnos = [(Alumno "juan" [8,6]), (Alumno "maria" [7,9,4]), (Alumno "ana" [6,2,4])]

{- EJERCICIO #2 -}

promediosSinAplazos :: [Notas] -> Notas
promediosSinAplazos listaNotas = map (promedio.filter (>=6)) listaNotas


{- EJERCICIO #3 -}

aprobo :: Persona -> Bool
aprobo alumno = all (>=6) . notas $ alumno

{- EJERCICIO #4 -}
{-Le aplico nombre a la lista de alumnos que me devuelva el filtro-}
aprobaron :: [Persona] -> [Nombre]
aprobaron alumnos = map nombre . filter aprobo $ alumnos  

{- EJERCICIO #5 -}
productos :: [String] -> [Integer] -> [(String, Integer)]
productos nombres precios = zip nombres precios

productos' :: [String] -> [Integer] -> [(String, Integer)]
productos' nombres precios = zipWith (\nom prec -> (nom, prec)) nombres precios

{- EJERCICIO #6 -}

data Flor= Flor{nombreFlor :: String, aplicacion:: String, cantidadDeDemanda:: Int } deriving Show

rosa = Flor "rosa" "decorativo" 120
jazmin =  Flor "jazmin" "aromatizante" 100
violeta=  Flor "violeta" "infusión" 110
orquidea =  Flor "orquidea" "decorativo" 90

flores = [orquidea, rosa,violeta, jazmin]

maximaFlorSegun :: (Flor -> Int) -> [Flor] -> Flor
maximaFlorSegun _ [flor] = flor
maximaFlorSegun criterio (flor:flores) | criterio flor >= criterio (maximaFlorSegun criterio flores) = flor
                                       | otherwise = maximaFlorSegun criterio flores



maximoSegun :: [Flor] -> ( Flor -> Int) -> String
maximoSegun flores criterio = nombreFlor . maximaFlorSegun criterio $ flores

{-a i) maximoSegun flores cantidadDeDemanda -}
{-a ii) maximoSegun flores (length . nombreFlor) -}
{-a iii) maximoSegun flores ( (`mod` 4).cantidadDeDemanda) -}

ordenadas :: [Flor] -> Bool
ordenadas [_] = True 
ordenadas (flor:otraFlor:flores) = cantidadDeDemanda flor > cantidadDeDemanda otraFlor && ordenadas (otraFlor : flores)
    
{- EJERCICIO #7 -}

vocales = "aeiou"++"AEIOU"  
consonantes = [letra | letra <- ["A".."Z"] ++ ["a".."z"], (not.esVocal) letra] 

esVocal :: Char -> Bool
esVocal letra = elem letra vocales

cantVocales :: String -> Int
cantVocales comida = length.filter esVocal $ comida

esCons :: Char -> Bool
esCons letra = elem letra consonantes

cantConsonantes :: String -> Int
cantConsonantes comida = length.filter esCons $ comida

f1 :: [String] -> [(String, (Int, Int))]
f1 comidas = map (\comida -> (comida, (cantConsonantes comida, cantVocales comida))) . filter (\comida -> cantConsonantes comida > cantVocales comida ) $ comidas
