import Text.Show.Functions ()
import Data.List()

{-
Nombre: Moscatelli, Juan Ariel
Legajo: 1724629
-}

--modelado de candidato

type Capacidad = Candidato -> Double

data Candidato = Candidato {
    nombre :: String,
    edad :: Double,
    carisma :: Double,
    capacidades :: [Capacidad]
} deriving (Show)

--capacidades (son todas de tipo Capacidad)

facha candidato = 60 - edad candidato + (carisma candidato * 3) 

liderazgo candidato = edad candidato * 10

riqueza candidato = carisma candidato +  (edad candidato) / 50 

corrupto candidato = -100 

tiktoker candidato = 100

flogger candidato = 0

--ejemplos de candidatos

cintia :: Candidato
cintia = Candidato {
    nombre = "cintia",
    edad = 40,
    carisma = 10,
    capacidades = [liderazgo,riqueza,tiktoker]
}

marcos :: Candidato
marcos = Candidato {
    nombre = "marcos",
    edad = 45,
    carisma = 10,
    capacidades = [facha,liderazgo,corrupto]
}

jorge :: Candidato 
jorge = Candidato {
    nombre = "jorge",
    edad = 50,
    carisma = 50,
    capacidades = [corrupto]
}

listaDeLosCandidatos = [jorge,marcos,cintia]

--capacidades inutiles

listaDeInts candidato = map ($ candidato) (capacidades candidato)

capacidadesInutiles :: Candidato -> Bool
capacidadesInutiles candidato = any (<=0) (listaDeInts candidato)

capacidadesNoInutiles :: Candidato -> Bool
capacidadesNoInutiles candidato = all (>=0) (listaDeInts candidato)

--suma convencimiento

calcularConvencimiento candidato = max (sum (listaDeInts candidato)) 0

sumaConvencimiento :: Candidato -> (String, Double)
sumaConvencimiento candidato = (nombre candidato, calcularConvencimiento candidato)

--el mejor

elMejor :: Ord a => (t -> a) -> t -> t -> t
elMejor criterio elem1 elem2 
 | criterio elem2 > criterio elem1 = elem2
 | otherwise = elem1

--votacion

totalConvencimiento = sum.map calcularConvencimiento

cantidadDeVotos cantidad listaCandidatos candidato = cantidad * (calcularConvencimiento candidato) / (totalConvencimiento listaCandidatos)

entuplar cantidad listaCandidatos candidato = (nombre candidato, cantidadDeVotos cantidad listaCandidatos candidato) 

votacion :: Double -> [Candidato] -> [(String, Double)]
votacion cantidad listaCandidatos = map (entuplar cantidad listaCandidatos) listaCandidatos

--ganador (a)

ganador :: Double -> [Candidato] -> Candidato
ganador cantidad listaCandidatos = foldl1 (elMejor (cantidadDeVotos cantidad listaCandidatos)) listaCandidatos

--el mas facha (b)

elMasFachero :: Foldable t => t Candidato -> Candidato
elMasFachero listaCandidatos = foldl1 (elMejor facha) listaCandidatos

--el mas molesto (c)

letrasNombre = length.nombre

elMasMolestoDeNombrar :: Foldable t => t Candidato -> Candidato
elMasMolestoDeNombrar listaCandidatos = foldl1 (elMejor letrasNombre) listaCandidatos