-- Si quiero restingir los tipos de datos de siguiente para que no los infiera Haskell
siguiente :: Integer -> Integer
-- Funcion para obtener el siguiente numero.
siguiente nro = nro + 1
-- Funcion para obtener el doble de un numero
doble nro = nro * 2 
-- Si quiero restingir los tipos de datos de calcular para que no los infiera Haskell
calcular :: Integer -> Integer
-- Exprecion con guardas. Si es par obtengo el siguiente, sino el doble
calcular nro | even nro = siguiente nro
             | otherwise = doble nro


-- Definicion de modelo para saber si aprobó un alumno (entrego nota y devuelve T o F)
aproboAlumno :: Integer -> Bool
aproboAlumno nota = nota >= 6

-- Definicion de funciones con Tuplas
mes :: (Integer, Integer, Integer) -> Integer
-- Recivo una fecha como una Tupla de tres elemento y devuelvo el mes
mes (_,unMes,_) = unMes