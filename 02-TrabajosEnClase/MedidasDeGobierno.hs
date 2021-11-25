
type Bien = (String,Float)       
type Ciudad = [Ciudadano]
data Ciudadano = UnCiudadano {
    profesion :: String, sueldo :: Float,
    cantidadDeHijos :: Float, bienes :: [Bien] 
    } deriving Show


---------------------CASOS DE PRUEBA-------------------------------
--Personas
homero = UnCiudadano "SeguridadNuclear" 9000 3 [("casa",50000), ("deuda",-70000)]
frink = UnCiudadano "Profesor" 12000 1 []
krabappel = UnCiudadano "Profesor" 12000 0 [("casa",35000)]
burns = UnCiudadano "Empresario" 300000 1 [("empresa",1000000),("empresa",500000),("auto",200000)]
--Ciudades
springfield :: Ciudad
springfield = [homero, burns, frink, krabappel]
-------------------------------------------------------------------


--------------------- PUNTO 1 -------------------------------

patrimonio :: Ciudadano -> Float
patrimonio unCiudadano = foldl (\sem bien -> sem + snd bien) (sueldo unCiudadano) (bienes  unCiudadano)

ciudadanoSegun :: (Ciudadano -> Ciudadano -> Ciudadano) -> Ciudad -> Ciudadano
ciudadanoSegun f ciudad = foldl1 f ciudad

maximo :: Ciudadano -> Ciudadano -> Ciudadano
maximo unCiudadano otroCiudadano 
    | patrimonio unCiudadano >= patrimonio otroCiudadano = unCiudadano
    | otherwise = otroCiudadano


minimo :: Ciudadano -> Ciudadano -> Ciudadano
minimo unCiudadano otroCiudadano 
    | patrimonio unCiudadano <= patrimonio otroCiudadano = unCiudadano
    | otherwise = otroCiudadano


diferenciaDePatrimonio :: Ciudad -> Float
diferenciaDePatrimonio ciudad = (patrimonio.ciudadanoSegun maximo) ciudad - (patrimonio.ciudadanoSegun minimo) ciudad

{- 
PRUEBA
    *Main> diferenciaDePatrimonio springfield 
    2011000.0 
-}

--------------------- PUNTO 2 -------------------------------

altaGama :: (String,Float) -> Bool
altaGama ("auto",precio) = precio > 100000   
altaGama _ = False

tieneAutoDeAltaGama :: Ciudadano -> Bool
tieneAutoDeAltaGama ciudadano = any altaGama.bienes $ ciudadano

{- 
PRUEBA
    *Main> tieneAutoDeAltaGama burns
    True   
    *Main> tieneAutoDeAltaGama homero
    False  
-}

--------------------- PUNTO 3 -------------------------------

type Medida = Ciudadano -> Ciudadano

aplicarMedida :: Bool -> Ciudadano -> Ciudadano -> Ciudadano
aplicarMedida condicion unCiudadano otroCiudadano
    | condicion = otroCiudadano
    | otherwise = unCiudadano  


modificarSueldo :: Ciudadano -> Float -> Ciudadano
modificarSueldo unCiudadano cantidad = unCiudadano { sueldo = (+) (sueldo unCiudadano) cantidad }  

diferencia minimo sueldo = (minimo - sueldo)*0.3 

auh :: Medida
auh unCiudadano = aplicarMedida (patrimonio unCiudadano < 0) unCiudadano (modificarSueldo unCiudadano ((1000*).cantidadDeHijos $ unCiudadano))

impuestoGanancia :: Float -> Medida
impuestoGanancia minimo unCiudadano = aplicarMedida (sueldo unCiudadano > minimo) unCiudadano (modificarSueldo unCiudadano (diferencia minimo (sueldo unCiudadano)))

impuestoAltaGama :: Medida
impuestoAltaGama unCiudadano = aplicarMedida (tieneAutoDeAltaGama unCiudadano) unCiudadano (modificarSueldo unCiudadano (montoaDisminuir (bienes unCiudadano)))

montoaDisminuir :: [Bien] -> Float
montoaDisminuir bienes = ((-0.1)*).snd.head.filter altaGama $ bienes

negociarSueldoProfesion :: String -> Float -> Medida
negociarSueldoProfesion profesion porcentaje unCiudadano = aplicarMedida (esDeProfesion profesion unCiudadano) unCiudadano (modificarSueldo unCiudadano (cantidadAumento porcentaje (sueldo unCiudadano)))

cantidadAumento :: Float -> Float -> Float 
cantidadAumento porcentaje sueldo = (sueldo * porcentaje)/100

esDeProfesion unaProfesion unCiudadano = (unaProfesion ==).profesion $ unCiudadano


{- 
PRUEBA
    *Main> homero
    UnCiudadano {profesion = "SeguridadNuclear", sueldo = 9000.0, cantidadDeHijos = 3.0, bienes = [("casa",50000.0),("deuda",-70000.0)]}
    *Main> auh homero
    UnCiudadano {profesion = "SeguridadNuclear", sueldo = 12000.0, cantidadDeHijos = 3.0, bienes = [("casa",50000.0),("deuda",-70000.0)]}

    *Main> impuestoGanancia 20000 (UnCiudadano "Doctor" 20100 0 [])
    UnCiudadano {profesion = "Doctor", sueldo = 20070.0, cantidadDeHijos = 0.0, bienes = []}

    *Main> burns
    UnCiudadano {profesion = "Empresario", sueldo = 300000.0, cantidadDeHijos = 1.0, bienes = [("empresa",1000000.0),("empresa",500000.0),("auto",200000.0)]}
    *Main> impuestoAltaGama burns 
    UnCiudadano {profesion = "Empresario", sueldo = 280000.0, cantidadDeHijos = 1.0, bienes = [("empresa",1000000.0),("empresa",500000.0),("auto",200000.0)]}   

    *Main> frink                  
    UnCiudadano {profesion = "Profesor", sueldo = 12000.0, cantidadDeHijos = 1.0, bienes = []}
    *Main> negociarSueldoProfesion "Profesor" 10 frink        
    UnCiudadano {profesion = "Profesor", sueldo = 13200.0, cantidadDeHijos = 1.0, bienes = []}
-}

--------------------- PUNTO 4 -------------------------------

data Gobierno = UnGobierno {
    anios :: [Int],
    medidas :: [ Medida ]
    } 

gobiernoA = UnGobierno [1999..2003] [impuestoGanancia 30000, negociarSueldoProfesion "Profesor" 10, negociarSueldoProfesion "Empresarios" 40, impuestoAltaGama, auh] 
gobiernoB = UnGobierno [2004..2008] [impuestoGanancia 40000, negociarSueldoProfesion "Profesor" 30, negociarSueldoProfesion "Camionero" 40]

gobernarUnAnio :: Gobierno -> Ciudad -> Ciudad
gobernarUnAnio unGobierno unaCiudad = map (aplicarMedidas (medidas unGobierno)) unaCiudad

aplicarMedidas :: [Medida] -> Ciudadano -> Ciudadano
aplicarMedidas medidas unCiudadano = foldl (flip ($)) unCiudadano medidas

{- 
PRUEBA
    *Main> springfield
    [UnCiudadano {profesion = "SeguridadNuclear", sueldo = 9000.0, cantidadDeHijos = 3.0, bienes = [("casa",50000.0),("deuda",-70000.0)]},UnCiudadano {profesion = "Empresario", sueldo = 300000.0, cantidadDeHijos = 1.0, bienes = [("empresa",1000000.0),("empresa",500000.0),("auto",200000.0)]},UnCiudadano {profesion = "Profesor", sueldo = 12000.0, cantidadDeHijos = 1.0, bienes = []},UnCiudadano {profesion = "Profesor", sueldo = 12000.0, cantidadDeHijos = 0.0, bienes = [("casa",35000.0)]}]
    *Main> gobernarUnAnio gobiernoA sp
    span         splitAt      springfield
    *Main> gobernarUnAnio gobiernoA springfield 
    [UnCiudadano {profesion = "SeguridadNuclear", sueldo = 12000.0, cantidadDeHijos = 3.0, bienes = [("casa",50000.0),("deuda",-70000.0)]},UnCiudadano {profesion 
    = "Empresario", sueldo = 199000.0, cantidadDeHijos = 1.0, bienes = [("empresa",1000000.0),("empresa",500000.0),("auto",200000.0)]},UnCiudadano {profesion = "Profesor", sueldo = 13200.0, cantidadDeHijos = 1.0, bienes = []},UnCiudadano {profesion = "Profesor", sueldo = 13200.0, cantidadDeHijos = 0.0, bienes = [("casa",35000.0)]}]
-}

gobernarPeriodoCompleto :: Gobierno -> Ciudad -> Ciudad
gobernarPeriodoCompleto unGobierno unaCiudad = foldl (flip ($)) unaCiudad (replicate (length.anios $ unGobierno) (gobernarUnAnio unGobierno))

{- 
PRUEBA
    *Main> gobernarPeriodoCompleto gobiernoA springfield 
    [UnCiudadano {profesion = "SeguridadNuclear", sueldo = 21000.0, cantidadDeHijos = 3.0, bienes = [("casa",50000.0),("deuda",-70000.0)]},UnCiudadano {profesion 
    = "Empresario", sueldo = 19916.898, cantidadDeHijos = 1.0, bienes = [("empresa",1000000.0),("empresa",500000.0),("auto",200000.0)]},UnCiudadano {profesion = "Profesor", sueldo = 19326.12, cantidadDeHijos = 1.0, bienes = []},UnCiudadano {profesion = "Profesor", sueldo = 19326.12, cantidadDeHijos = 0.0, bienes = [("casa",35000.0)]}]
-}

distribuyoRiqueza :: Gobierno -> Ciudad -> Bool
distribuyoRiqueza unGobierno unaCiudad = (diferenciaDePatrimonio.gobernarPeriodoCompleto unGobierno $unaCiudad) < (diferenciaDePatrimonio unaCiudad)

kane :: Ciudadano
kane = UnCiudadano "Empresario" 100000 0 [("Rosebud",cantidad) | cantidad<-[5,10..]]
