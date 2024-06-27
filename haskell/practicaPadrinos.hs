import Text.Show.Functions ()
import Data.List()

type Deseo = Chico -> Chico

data Chico = Chico {
    nombre :: String,
    edad :: Int,
    habilidades :: [String],
    deseos :: [Deseo]
} deriving (Show)

timmy = Chico {
    nombre = "timmy",
    edad = 10,
    habilidades = ["mirar television","jugar en la pc"],
    deseos = [serMayor,aprenderHabilidades ["programar"]]    
}

--punto 1

aprenderHabilidades habilidad chico = chico { habilidades = habilidades chico ++ habilidad}

serGrosoEnNeedForSpeed chico = 
    chico {habilidades = habilidades chico ++ (map (("jugar need for speed" ++).(" " ++).show) [1..])}

serMayor chico = chico { edad = 18}

--punto 2

cumplirDeseo chico = (head(deseos chico)) chico

madurar chico = chico { edad = edad chico + 1}

wanda = madurar.cumplirDeseo

cosmo chico = chico { edad = div (edad chico) 2}

cumplirTodo chico deseo = deseo chico

muffinMagico chico = foldl cumplirTodo chico (deseos chico)

--B 
--punto 1

tieneHabilidad habilidad chico = any (== habilidad) (habilidades chico)

esSuperMaduro chico = (edad chico > 18) && (tieneHabilidad "manejar" chico)

--punto 2 

type Condicion = Chico -> Bool

data Chica = Chica {
    nombreChica :: String,
    condicion :: Condicion
}

maniches = Chico {
    nombre = "maniches",
    edad = 50,
    habilidades = ["explotar","ser un supermodelo noruego","enamorar"],
    deseos = [serMayor,aprenderHabilidades ["programar"]]    
}


vicky :: Chica 
vicky = Chica {
    nombreChica = "vicky",
    condicion = tieneHabilidad "ser un supermodelo noruego"
}

quienConquistaA chica listaDeChicos = head (filter (condicion chica) listaDeChicos)

--C 

esProhibida habilidad = ((habilidad == "enamorar") || (habilidad == "matar") || (habilidad == "dominar el mundo"))

hayProhibidas lista = any esProhibida lista

infractoresDeDaRules listaDeChicos = filter (hayProhibidas.take 5.habilidades.muffinMagico) listaDeChicos
