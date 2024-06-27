import Text.Show.Functions ()
import Data.List()


type Transformacion = Animal -> Animal
type Transformaciones = [Transformacion]
type Capacidad = String

--punto 1

data Animal = Animal {
    iq :: Int,
    especie :: String,
    capacidades :: [Capacidad]    
} deriving ( Show,Eq )

gato :: Animal
gato = Animal {
    iq = 82,
    especie = "gato",
    capacidades = ["dormir","maullar","correr"]
}

delfin :: Animal 
delfin = Animal {
    iq = 120,
    especie = "delfin",
    capacidades = ["nadar","pensar"]
}

elefante :: Animal

elefante = Animal {
    iq = 20,
    especie = "elefante",
    capacidades = ["Dormir","Molestar","Decir jjfj","Decir kwwj","Decir ttyyt"]
}

raton :: Animal 
raton = Animal {
    iq = 17,
    especie = "raton",
    capacidades = ["destruir el mundo","hacer planes desalmados"]
}

{-raton :: Animal 
raton = Animal {
    iq = 101,
    especie = "roedor",
    capacidades = ["comer queso"]
}-}

--punto 2


inteligenciaSuperior n animal  = animal { iq = (iq animal)*n}


inutilizar animal = animal {capacidades = []}

agregarCapacidad animal capacidad = animal { capacidades = (capacidades animal) ++ capacidad}

superpoderes animal  
    | especie animal == "elefante" = agregarCapacidad animal ["no tenerle miedo a los ratones"]
    | especie animal == "raton" && iq animal > 100 = agregarCapacidad animal ["hablar"]
    | especie animal == "raton" && iq animal < 100 = animal
    | otherwise = animal

sustanciaX animal = agregarCapacidad animal ["pensamiento profundo","insomnio"]

sustanciaY animal = agregarCapacidad animal ["soniar"]

sustancia coeficiente lista animal
    | iq animal > coeficiente = agregarCapacidad animal lista
    | otherwise = animal 

--punto 3 

agil animal = elem "correr" (capacidades animal) && iq animal > 80

llegoAlIntelecto n animal = iq animal >= n

obtenerDecir string = (take 5 string) == "Decir"

esVocal letra  = ((letra == 'a') || (letra== 'e') || (letra== 'i') || (letra== 'o') || (letra== 'u')) 

sonConsonantes string = (not.any (esVocal)) string

esRaro animal = length ((filter(sonConsonantes).map (drop 6).filter (obtenerDecir)) (capacidades animal)) >2

--punto 4

vaca:: Animal 
vaca= Animal {
    iq = 32,
    especie = "vaca",
    capacidades = ["Decir mmmm"]
}

elefante4:: Animal 
elefante4 = Animal {
    iq = 26,
    especie = "elefante",
    capacidades = []
}

type Criterio = Animal -> Bool

data Experimento = Experimento {
    transformaciones :: Transformaciones, 
    criterios :: Criterio  
}

experimentoEnRaton = Experimento {
   transformaciones = [inutilizar,(inteligenciaSuperior 10),superpoderes],
   criterios = llegoAlIntelecto 32

}

experimentoEnVaca = Experimento {
    transformaciones = [superpoderes, (sustancia 20 ["Decir grrr"])],
    criterios = esRaro
}

condicionElefante animal = especie animal == "elefante"

experimentoEnElefante = Experimento {
    transformaciones = [superpoderes],
    criterios = condicionElefante
}

realizarExperimento animal transfor = transfor animal

experimentoExitoso experimento animal= criterios experimento (foldl (realizarExperimento) animal (transformaciones experimento))

--punto 5

{- realizarExperimentoATodos experimento animal = foldl (realizarExperimento) animal (transformaciones experimento)


realizarInforme listaAnim listaCap experimento = map (realizarExperimentoATodos experimento) listaAnim

comparar listaAnim listaCap = foldl (comparar2) [] (map capacidades listaAnim) 

comparar2 listaAnim listaCap =  -}

--punto 6 


experimento6 = Experimento {
    transformaciones = [sustancia 10 ["hola"]],
    criterios = esRaro
}

dinosaurio:: Animal 
dinosaurio = Animal {
    iq = 30,
    especie = "desconocido",
    capacidades = ["Decir " ++ repeat 'g' ]
}

{-los experimentos que no van a funcionar son los que en la condicion evaluan la lista de capacidades porque nunca 
va a terminar de generar la capacidad de decir "gggg..."
esRaro se fija si la capacidad de decir algo tiene vocales o no y como es infinita no va a poder converger a un bool
por lo tanto diverge. 
el inutilizar borra la lista entonces no le importa si había una lista infinita o no, entonces converge a la lista vacía
devolver el bool. 
Los conceptos que ayudan son la convergencia ( si puede devolver un valor ) y la divergencia (si no puede devolver uno 
porque sigue infinitamente); la evaluacion diferida, que quiere decir que haskell va a calcular a medida que lo necesite
por ejemplo en inutlizar que va a directamente borrar la lista sin usarla.