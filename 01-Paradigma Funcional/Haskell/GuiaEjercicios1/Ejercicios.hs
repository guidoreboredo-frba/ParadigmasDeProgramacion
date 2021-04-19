-- Funcion para obtener el doble de un numero
doble nro = nro * 2 
-- Si quiero restingir los tipos de datos de siguiente para que no los infiera Haskell
siguiente :: Integer -> Integer
-- Funcion para obtener el siguiente numero.
siguiente nro = nro + 1

----------------------------------------------------------------------------------------------------------------------------------
{-
1) Definir la función calcular, que recibe una tupla de 2 elementos, y devuelve una nueva tupla según las siguientes reglas:
●  si el primer elemento es par lo duplica; si no lo deja como está
●  si el segundo elemento es impar le suma 1; si no deja como está
>calcular (4,5)
(8,6)
-}

-- Definicion de Calcular
calcular :: (Integer,Integer) -> (Integer,Integer)
-- Funcion que devuelve lo solicitado
calcular (primero,segundo) | even primero && even segundo      = (doble primero, segundo)
                           | odd  primero && not(even segundo) = (primero, siguiente segundo)
                           | even primero && odd segundo       = (doble primero, siguiente segundo)
                           | otherwise = (primero, segundo)

----------------------------------------------------------------------------------------------------------------------------------
{-
2) Definir las funciones boolenas estándar. Sin usar las funciones predefinidas.
2.1) Definir la función and’
2.2) Definir la función or’.
-}
-- Definicion de and recibiendo dos parametros
and' :: Bool -> Bool -> Bool
-- Funcion copia de &&
and' unBool otroBool | not unBool   = False
                     | otherwise    = otroBool
-- PATTERN MATCHING Otra opcion para la misma funcion 
and'' :: Bool -> Bool -> Bool
-- Funcion copia de &&
and'' True otroBool = otroBool
and'' _ _ = False 

-- Definicion de or recibiendo dos parametros
or'' :: Bool -> Bool -> Bool
-- Funcion copia de ||
or'' False False = False
or'' _ _ = True


----------------------------------------------------------------------------------------------------------------------------------
{-
3) Definir la función notaMaxima que dado un alumno devuelva la máxima nota del alumno. (Nota resolverlo sin guardas).
type Nota = Integer
type Alumno = (String, Nota, Nota, Nota)
-}

-- Definicion
-- Sinonimo de tipo
type Nota = Integer
type Alumno = (String, Nota, Nota, Nota)
-- Funcion
notaMaxima :: Alumno -> Nota
-- Funcion notaMaxima
notaMaxima (_, nota1,nota2,nota3) = nota1 `max` (nota2 `max` nota3)

----------------------------------------------------------------------------------------------------------------------------------
{-
4) Definir la función cuadruple reutilizando la función doble. 
-}
-- Usando el Doble del Doble.
cuadruple :: Integer -> Integer
cuadruple nro = doble (doble nro)

-- Con composicionde funciones. 
cuadruple' :: Integer -> Integer
cuadruple' nro = (doble . doble) nro

----------------------------------------------------------------------------------------------------------------------------------
{-
5) Definir la función esMayorA, que verifique si el doble del siguiente de la suma entre 2 y un número es mayor a 10. 
-}

esMayorA :: Integer -> Bool
esMayorA nro =  ((doble.siguiente) (nro+2)) > 10

----------------------------------------------------------------------------------------------------------------------------------
{-
6) Dar expresiones lambda que sean equivalentes a las siguientes expresiones:
triple
siguiente
suma
sumarDos
-}





