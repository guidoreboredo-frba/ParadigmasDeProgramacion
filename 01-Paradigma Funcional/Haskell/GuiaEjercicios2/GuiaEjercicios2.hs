{- 
Module      :  GuiaEjercicios2.hs
Description :  Trabajo Práctico Numero 2
Date        :  30.04.2021
Name        :  Guido Reboredo
Subject     :  PdeP K2054 - UTN FRBA

Ejercicios Prácticos Paradigma Funcional 
-}

{- EJERCICIO #1 -}

data Empleados = Comun {nombre::String, sueldo::Integer} | Jefe {nombre::String, sueldo::Integer, reportes::Integer}

plus :: Integer -> Integer
plus cantidad = cantidad * 500

sueldoTotal :: Empleados -> Integer
sueldoTotal(Comun _ sueldo) = sueldo
sueldoTotal(Jefe _ sueldo cant) = plus cant + sueldo 

{- EJERCICIO #2 -}

data Bebida = Cafe {nombreBebida :: String} | Gaseosa {sabor ::String , azucar :: Integer}

esEnergizante :: Bebida -> Bool
esEnergizante (Cafe "capuchino") = True
esEnergizante (Gaseosa "pomelo" cant) = cant > 10
esEnergizante _ = False

{- EJERCICIO #3 -}

find' :: (a -> Bool) -> [a] -> a

find' criteria lista =  head . filter criteria $ lista

{- EJERCICIO #3.1 -}

data Politico = Politico {proyectosPresentados :: [String], salario :: Float, edad :: Int } deriving Show

politicos = [ Politico ["ser libres", "libre estacionamiento coches politicos", "ley no fumar", "ley 19182"] 20000 81, Politico ["tratar de reconquistar luchas sociales"] 10000 63, Politico ["tolerancia 100 para delitos"] 15500 49 ]

-- *Main> find' ((<50).edad) politicos
-- *Main> find' ((>3).length.proyectosPresentados) politicos
-- *Main> find' (any ((<3).length.words).proyectosPresentados) politicos