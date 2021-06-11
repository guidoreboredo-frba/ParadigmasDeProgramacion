import Text.Show.Functions

psicosis = Pelicula "Psicosis" "Terror" 109 "Estados Unidos"
perfumeDeMujer= Pelicula "Perfume de Mujer" "Drama" 150  "Estados Unidos"
elSaborDeLasCervezas = Pelicula "El sabor de las cervezas"  "Drama" 95 "Iran"
lasTortugasTambienVuelan = Pelicula "Las tortugas también vuelan" "Drama" 103 "Iran"
--juan = Usuario "juan" "estandar" 23  "Argentina" [perfumeDeMujer] 60
juan = Usuario "juan" "estandar" 23  "Argentina" [perfumeDeMujer, elSaborDeLasCervezas, lasTortugasTambienVuelan, lasTortugasTambienVuelan] 60


data Pelicula = Pelicula {
    nombreP :: String, 
    genero :: String,
    duracion :: Int, 
    origen :: String
    } deriving (Show,Eq)

data UnUsuario = Usuario {
    nombre :: String, 
    categoria :: String, 
    edad :: Int, 
    paisResidencia :: String,
    peliculas :: [Pelicula],
    nivelSalud :: Int  
    } deriving Show 
 

-- PUNTO 2

ver :: Pelicula -> UnUsuario -> UnUsuario
ver unaPelicula usuario = usuario { peliculas = (peliculas usuario) ++ [unaPelicula] }

-- PUNTO 3

premiarUsuariosFieles :: [UnUsuario] -> [UnUsuario]
premiarUsuariosFieles usuarios = map premiarSiEsFiel usuarios

premiarSiEsFiel :: UnUsuario -> UnUsuario
premiarSiEsFiel usuario 
     | esFiel usuario = subirCategoria usuario
     | otherwise = usuario

esFiel :: UnUsuario -> Bool
esFiel usuario = ((>2).length.peliculasQueNoSeanDe "Estados Unidos".peliculas) usuario

peliculasQueNoSeanDe :: String -> [Pelicula] -> [Pelicula]
peliculasQueNoSeanDe pais peliculas = filter ((pais /=).origen) peliculas

subirCategoria :: UnUsuario -> UnUsuario
subirCategoria usuario = usuario {categoria = (nuevaCategoria.categoria) usuario}

nuevaCategoria :: String -> String
nuevaCategoria "basica" = "estandar"
nuevaCategoria _ = "premium"

-- PUNTO 4

type CriterioBusqueda = Pelicula -> Bool

teQuedasteCorto :: CriterioBusqueda
teQuedasteCorto pelicula = (<35).duracion $ pelicula

cuestionDeGenero :: [String] -> CriterioBusqueda
cuestionDeGenero generos pelicula = any (== genero pelicula) generos

deDondeSaliste :: String -> CriterioBusqueda
deDondeSaliste unOrigen unaPelicula = (== unOrigen).origen $ unaPelicula

vaPorEseLado :: Eq t => Pelicula -> (Pelicula -> t) -> CriterioBusqueda
vaPorEseLado pelicula caracteristica otraPelicula =  (caracteristica pelicula) == (caracteristica otraPelicula)

-- PUNTO 5

busquedaDePelicula :: UnUsuario -> [CriterioBusqueda] -> [Pelicula] -> [Pelicula]
busquedaDePelicula usuario criterio peliculas  = (take 3).filter (esRecomendablePara usuario criterio) $ peliculas

esRecomendablePara :: UnUsuario -> [CriterioBusqueda] -> Pelicula -> Bool
esRecomendablePara usuario criterios pelicula = (not.vio pelicula) usuario && cumpleCriterios pelicula criterios

vio :: Pelicula -> UnUsuario -> Bool
vio pelicula usuario = elem pelicula (peliculas usuario)

cumpleCriterios :: Pelicula -> [CriterioBusqueda] -> Bool
cumpleCriterios pelicula criterios = all  ($ pelicula) criterios






