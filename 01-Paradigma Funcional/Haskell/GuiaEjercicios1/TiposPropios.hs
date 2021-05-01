
data Punto = Plano {coorX :: Double, coorY ::Double} |
             Espacio { coorX:: Double, coorY :: Double, coorZ:: Double}

distancia :: Punto -> Double
distancia (Plano x y) = sqrt (x^2 + y^2)
distancia (Espacio x y z) = sqrt (x^2 + y^2 + z^2)

data Persona = Persona { nombre :: String, edad :: Integer} deriving Show

cumplirAños :: Persona -> Persona
cumplirAños (Persona nombre edad) = Persona nombre (edad + 1)




seleccionar :: (Integer -> Bool) -> [Integer] -> [Integer]
seleccionar criterio numeros = [num | num<-numeros, criterio num]