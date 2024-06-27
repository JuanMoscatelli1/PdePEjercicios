import Text.Show.Functions ()
import Data.List()

data Elemento = Elemento { 
    tipo :: String,
    ataque :: (Personaje -> Personaje),
    defensa :: (Personaje -> Personaje)
}deriving (Show)

data Personaje = Personaje { 
    nombre :: String, 
    salud :: Float, 
    elementos :: [Elemento],
    anioPresente :: Int
}deriving (Show)


--casos de prueba

maldad :: Elemento
maldad = Elemento {
    tipo = "maldad",
    ataque = causarDanio 10,
    defensa = meditar
}

jack :: Personaje
jack = Personaje {
    nombre = "jack",
    salud = 50,
    elementos = [maldad],
    anioPresente = 2021
}

--punto 1

mandarAlAnio anio personaje = personaje { anioPresente = anio}

meditar personaje = personaje { salud = salud personaje + (salud personaje)/2}

causarDanio danio personaje = personaje { salud = max (salud personaje - danio ) 0}

--punto 2

esMalvado personaje = any (=="maldad") (map tipo (elementos personaje))

danioQueProduce personaje elemento = (salud.(ataque elemento)) personaje 

puedeMatar personaje elemento = danioQueProduce personaje elemento == (salud personaje)

esEnemigoMortal personaje enemigos =  (any (puedeMatar personaje).elementos) enemigos

enemigosMortales personaje listaEnemigos = filter (esEnemigoMortal personaje) listaEnemigos

--punto 3

concentracion nivel = 
     Elemento {
         tipo = "magia",
         ataque = id,
         defensa = foldl1 (.) (replicate nivel meditar)
     }


esbirro = Elemento {
    tipo = "maldad",
    ataque = causarDanio 1,
    defensa = id
} 


esbirrosMalvados cantidad = replicate cantidad esbirro

katanaMagica :: Elemento 
katanaMagica = Elemento {
    tipo = "magia",
    ataque = causarDanio 1000,
    defensa = id
}

jack2 :: Personaje 
jack2 = Personaje {
    nombre = "jack2",
    salud = 300,
    elementos = [concentracion 3,katanaMagica],
    anioPresente = 200
}

portalAlFuturo anioFuturo = Elemento {
    tipo="magia",
    ataque = mandarAlAnio (anioFuturo + 2800),
    defensa = aku anioFuturo.salud
}

aku anio cantSalud = 
    Personaje {
        nombre = "aku",
        salud = cantSalud,
        elementos = concentracion 4 : portalAlFuturo anio : esbirrosMalvados (100*anio),
        anioPresente = anio
    }

--punto 4 

estaMuerto  = ((==0).salud)

luchar :: Personaje -> Personaje -> (Personaje, Personaje)
luchar atacante defensor
 |estaMuerto atacante = (defensor, atacante)
 |otherwise = luchar proximoAtacante proximoDefensor
 where proximoAtacante = usarElementos ataque defensor (elementos atacante)
       proximoDefensor = usarElementos defensa atacante (elementos atacante)

-- Abstraemos cómo hacer para usar uno de los efectos de un conjunto de elementos sobre un personaje
usarElementos :: (Elemento -> Personaje -> Personaje) -> Personaje -> [Elemento] -> Personaje
usarElementos funcion personaje elementos = foldl afectar personaje (map funcion elementos)

afectar personaje funcion = funcion personaje
afectar' = flip ($)