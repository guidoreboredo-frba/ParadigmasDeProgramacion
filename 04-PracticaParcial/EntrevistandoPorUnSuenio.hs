{------------- DEFINICIONES ------------------}

data Postulante = UnPostulante {
    nombre        :: String,
    edad          :: Int,
    remuneracion  :: Float,
    conocimientos :: [String]
    } |
    Estudiante {
    legajo        :: String,
    conocimientos :: [String]
    } deriving Show

type Nombre = String

data Puesto = UnPuesto {
    puesto                 :: String,
    conocimientoRequeridos :: [String]
    } deriving Show



{-------------- CASOS DE PRUEBA --------------}

--POSTULANTES
pepe = UnPostulante "Jose Perez" 35 15000.0 ["Haskell", "Prolog", "Wollok", "C", "repetir logica"]
tito = UnPostulante "Roberto Gonzalez" 20 12000.0 ["Haskell", "Php"]
--PUESTOS
jefe = UnPuesto "gerente de sistemas" ["Haskell", "Prolog", "Wollok"]
chePibe = UnPuesto "cadete" ["ir al banco"]
--ESTUDIANTES
guido = Estudiante "1" ["C","java","ABAP"]

--OTROS
apellidoDueno :: Nombre
apellidoDueno = "Gonzalez"

{------------- PUNTO 1 --------------}

type Requisito = Postulante -> Bool

tieneConocimientos :: Puesto -> Requisito
tieneConocimientos puesto postulante = all (\unConocimiento -> unConocimiento `elem` conocimientos postulante)  (conocimientoRequeridos puesto)

{-
--PRUEBA
*Main> jefe
UnPuesto {puesto = "gerente de sistemas", conocimientoRequeridos = ["Haskell","Prolog","Wollok"]}
*Main> pepe
UnPostulante {nombre = "Jose Perez", edad = 35, remuneracion = 15000.0, conocimientos = ["Haskell","Prolog","Wollok","C"]}
*Main> tieneConocimientos jefe pepe
True
-}

edadAceptable :: Int -> Int -> Requisito
edadAceptable min max postulante = ((> min).edad) postulante && ((< max).edad) postulante

{-
--PRUEBA
*Main> pepe
UnPostulante {nombre = "Jose Perez", edad = 35, remuneracion = 15000.0, conocimientos = ["Haskell","Prolog","Wollok","C"]}
*Main> edadAceptable 33 50 pepe
True
*Main> edadAceptable 38 50 pepe
False
*Main
-}

sinArreglo :: Requisito
sinArreglo = (/= apellidoDueno) . last . words . nombre

{-
--PRUEBA
*Main> tito
UnPostulante {nombre = "Roberto Gonzalez", edad = 20, remuneracion = 12000.0, conocimientos = ["Haskell","Php"]}
*Main> sinArreglo tito
False
*Main> sinArreglo pepe
True
*Main>
-}

{------------- PUNTO 2 --------------}

cumpleTodos :: [Requisito] -> Postulante -> Bool
cumpleTodos requisitos postulante = all ($ postulante) requisitos

{-
--PRUEBA
*Main> cumpleTodos [sinArreglo, edadAceptable 33 50, tieneConocimientos jefe] pepe
True
-}

preseleccion :: [Postulante] -> [Requisito] -> [Postulante]
preseleccion postulantes requisitos = filter (cumpleTodos requisitos) postulantes
{-
--PRUEBA
*Main> preseleccion [pepe,tito] [sinArreglo, edadAceptable 30 40, tieneConocimientos jefe]
[UnPostulante {nombre = "Jose Perez", edad = 35, remuneracion = 15000.0, conocimientos = ["Haskell","Prolog","Wollok","C"]}]

*Main> preseleccion [pepe,tito] [sinArreglo, edadAceptable 30 40, tieneConocimientos jefe,(all (/= "repetir logica").conocimientos)]
*Main> preseleccion [pepe,tito] [sinArreglo, edadAceptable 30 40, tieneConocimientos jefe,(not.(elem "repetir logica").conocimientos)]
-}

{------------- PUNTO 3 --------------}

incrementarEdad  :: Int -> Postulante -> Postulante
incrementarEdad anios unPostulante = unPostulante{edad = ((+anios).edad) unPostulante}

aumentarSueldo :: Float -> Postulante -> Postulante
aumentarSueldo porcentaje unPostulante = unPostulante{ remuneracion = (1 + porcentaje / 100) * remuneracion unPostulante}

actualizarPostulantes :: [Postulante]->[Postulante]
actualizarPostulantes postulantes = [aumentarSueldo 27 . incrementarEdad 1 $ postulante | postulante <- postulantes]

{-
--PRUEBA
*Main> tito
UnPostulante {nombre = "Roberto Gonzalez", edad = 20, remuneracion = 12000.0, conocimientos = ["Haskell","Php"]}
*Main> pepe
UnPostulante {nombre = "Jose Perez", edad = 35, remuneracion = 15000.0, conocimientos = ["Haskell","Prolog","Wollok","C","repetir logica"]}
*Main> actualizarPostulantes [tito,pepe]
[UnPostulante {nombre = "Roberto Gonzalez", edad = 21, remuneracion = 15240.0, conocimientos = ["Haskell","Php"]},
UnPostulante {nombre = "Jose Perez", edad = 36, remuneracion = 19050.0, conocimientos = ["Haskell","Prolog","Wollok","C","repetir logica"]}]
-}

actualizarPostulantes' :: [Postulante]->[Postulante]
actualizarPostulantes' = map (incrementarEdad 1.aumentarSueldo 27)

{-
--PRUEBA
*Main> actualizarPostulantes [tito, pepe]
[UnPostulante {nombre = "Roberto Gonzalez", edad = 21, remuneracion = 15240.0, conocimientos = ["Haskell","Php"]},
UnPostulante {nombre = "Jose Perez", edad = 36, remuneracion = 19050.0, conocimientos = ["Haskell","Prolog","Wollok","C","repetir logica"]}]
-}

listaInfinita = repeat tito

{------------- PUNTO 4 --------------}

capacitar :: String -> Postulante -> Postulante
capacitar unConocimiento unPostulante = unPostulante {conocimientos = aprender unConocimiento unPostulante}

aprender :: String -> Postulante -> [String]
aprender unConocimiento (UnPostulante _ _ _ conocimientos) = (++ [unConocimiento]) conocimientos
aprender unConocimiento (Estudiante _ conocimientos) = (++ [unConocimiento]).init $ conocimientos

{-
--PRUEBA
*Main> capacitar "C#" tito
UnPostulante {nombre = "Roberto Gonzalez", edad = 20, remuneracion = 12000.0, conocimientos = ["Haskell","Php","C#"]}
*Main> capacitar "ABAP" tito
UnPostulante {nombre = "Roberto Gonzalez", edad = 20, remuneracion = 12000.0, conocimientos = ["Haskell","Php","ABAP"]}
*Main> capacitar "C#" guido
Estudiante {legajo = "1", conocimientos = ["C","java","C#"]}
-}

capacitacion unPuesto unPostulante = foldl ( flip capacitar ) unPostulante (conocimientoRequeridos  unPuesto)
