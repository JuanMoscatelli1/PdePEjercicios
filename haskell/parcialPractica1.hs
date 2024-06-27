import Text.Show.Functions ()
import Data.List()

--punto 1

data Persona = Persona {
    edad :: Int,
    items :: [String],
    experiencia :: Int
}  deriving ( Show )

type Debilidad = Persona -> Bool

data Criatura = Criatura {
    nivel :: Int,
    debilidad :: [Debilidad]
}  deriving ( Show )

dipper :: Persona
dipper = Persona {
    edad = 13,
    items = ["soplador de hojas","cuchillo"],
    experiencia = 10
}

gnomo1 :: Criatura
gnomo1 = Criatura {
    nivel = 10 ^2,
    debilidad = [tieneItem "soplador de hojas"]
}

tieneItem item persona  = any (== item ) (items persona) 

edadMenorA edadParametro persona = (edad persona) < edadParametro

experienciaMayorA nivelExp persona = (experiencia persona) > nivelExp

siempredetras :: Criatura 
siempredetras = Criatura {
    nivel = 0,
    debilidad = []
}

fantasma1 :: Criatura 
fantasma1 = Criatura {
    nivel = 3 * 20,
    debilidad = [tieneItem "disfraz de oveja",edadMenorA 13]
}

fantasma2 :: Criatura 
fantasma2 = Criatura {
    nivel = 1 * 20,
    debilidad = [experienciaMayorA 10]   
}

calcularExp persona criatura 
 | all (==True) (map ($ persona) (debilidad criatura)) = persona { experiencia = (experiencia persona) + (nivel criatura)}
 | otherwise = persona { experiencia = (experiencia persona) + 1}

--punto 2

