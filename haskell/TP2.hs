import Text.Show.Functions ()
import Data.List()


-- Modelado de persona generica

type Ciudad = String
type Ciudades = [Ciudad]
type Habilidad = String
type Habilidades = [Habilidad]
type Suenio = Persona -> Persona

data  Persona  =  Persona  {
    nombre  ::  String,
    edad :: Int,
    felicidonios :: Int,
    habilidades :: [String],
    suenios :: [Suenio]
}   deriving ( Show)

-- FUNCIONES NECESARIAS 
-- Recibirse de una carrera


recibirseDe carrera = felicidoniosCarrera carrera . agregarHabilidadCarrera carrera

agregarHabilidadCarrera carrera persona = persona {habilidades = habilidades persona ++ [carrera]}

felicidoniosCarrera carrera persona = modificarFelicidonios (multLengthX 1000 carrera) persona

modificarFelicidonios numero persona = persona {felicidonios = felicidonios persona + numero}

multLengthX numero = (*numero) . length  


-- Viajar a cuidades


viajarA ciudades = (felicidoniosCuidades ciudades) . (aumentarEdad)

aumentarEdad persona = persona {edad = edad persona + 1}

felicidoniosCuidades ciudades persona = persona {felicidonios = felicidonios persona + (multLengthX 100 ciudades)}


-- Enamorarse de otra persona

enamorarseDe persona1  = modificarFelicidonios (felicidonios persona1)

-- Que todo siga igual

queTodoSigaIgual  = id

-- ComboPerfecto

comboPerfecto persona =  (sumarFelicidonios . viajarA["Berazategui","Paris"]. recibirseDe "Medicina") persona

sumarFelicidonios persona = persona {felicidonios = felicidonios persona + 100}

-- Personas para casos bases

eugenia :: Persona
eugenia = Persona {
    nombre = "Eugenia",
    edad = 22,
    felicidonios = 5000,
    habilidades = ["Pintura"],
    suenios = [recibirseDe "disenoDeInteriores", viajarA ["Paris"], enamorarseDe manuel]
}

manuel = Persona {
    nombre = "Manuel",
    edad = 19,
    felicidonios = 15,
    habilidades = ["Programar"],
    suenios = [viajarA ["Paris"], enamorarseDe eugenia]
}

raul = Persona {
    nombre = "Raul",
    edad = 30,
    felicidonios = 2000,
    habilidades = ["Futbol"],
    suenios = [viajarA ["bariloche", "villaLaAngostura", "sanMartinDeLosAndes"], enamorarseDe patagoniaArgentina]
}

patagoniaArgentina = Persona {
    nombre = "Patagonia Argentina",
    edad = 10000,
    felicidonios = 12000,
    habilidades = ["Enamorar"],
    suenios = []
}

martina = Persona {
    nombre = "Martina",
    edad = 22,
    felicidonios = 500,
    habilidades = ["Leer"],
    suenios = [comboPerfecto, recibirseDe "medicina", enamorarseDe mateo, viajarA ["Barcelona"]]
}

mateo = Persona {
    nombre = "Mateo",
    edad = 24,
    felicidonios = 0,
    habilidades = ["Comer"],
    suenios = [viajarA ["Egipto"]]
}

agustin = Persona {
    nombre = "Agustin",
    edad = 25,
    felicidonios = 100,
    habilidades = ["Estudiar"],
    suenios = [queTodoSigaIgual]
}



-- Punto 4
-- Punto a: Fuente minimalista
-- Cumple el primer sueño a la persona,y lo quita de la lista de sueños de esa persona.



type FuenteDeLosDeseos = Persona -> Persona



fuenteMinimalista :: FuenteDeLosDeseos
fuenteMinimalista  = (quitarPrimerSuenio . obtenerPrimerSuenio) 



obtenerPrimerSuenio persona = (head (suenios persona)) persona

quitarPrimerSuenio persona = persona {suenios = tail (suenios persona)}

-- No muestra la ñ porque se modifica los caracteres en consola
-- Caso de prueba: fuenteMinimalista eugenia



-- Punto b: Fuente copada
-- Cumple todos los sueños a la persona. La persona debe quedarse sin sueños.

fuenteCopada :: FuenteDeLosDeseos
fuenteCopada  = quitarSuenios . cumplirTodosLosSuenios



cumplirTodosLosSuenios persona = (foldl (cumplirSuenio) persona (suenios persona))

cumplirSuenio persona suenio = suenio persona

quitarSuenios persona = persona {suenios = []}

-- Caso de prueba: fuenteCopada eugenia 



-- Punto c: Fuente a pedido
-- Cumple el enésimo sueño a una persona, pero no lo quita de la lista de sueños.

fuenteAPedido ::   Int -> FuenteDeLosDeseos
fuenteAPedido  numeroSuenio persona  =  (obtenerNesimoSuenio numeroSuenio) persona


obtenerNesimoSuenio numeroSuenio persona = ((suenios persona) !! (numeroSuenio -1)) persona


-- Caso de prueba: fuenteAPedido eugenia
-- Caso de prueba2 para que retorne una funcion en el punto 5: fuenteAPedido 0 eugenia

-- Pundo d: Fuente sorda
-- Como no entiende bien qué sueño tiene que cumplir no le cumple ninguno

fuenteSorda :: FuenteDeLosDeseos
fuenteSorda  = seguiSoniado 

seguiSoniado = id 

-- Caso de prueba: fuenteSorda raul





-- Punto 5
 
{-       Dada una lista de fuentes y una persona, saber cuál es la fuente "ganadora" en base a un criterio.
Por ejemplo:
1) el que más felicidonios le de a esa persona cuando lo cumpla
2) el que menos felicidonios le de a esa persona cuando lo cumpla
3) el que más habilidades le deje a esa persona cuando lo cumpla
-}
 
 
type Criterio =  Persona -> FuenteDeLosDeseos -> FuenteDeLosDeseos ->Bool
type Cantidad = (FuenteDeLosDeseos -> Persona ->Int)
 
fuenteGanadora :: Persona ->  Criterio  -> [FuenteDeLosDeseos] -> FuenteDeLosDeseos
fuenteGanadora unaPersona unCriterio   = 
    foldr1 (comparar unCriterio unaPersona)  
 
 
comparar :: Criterio  -> Persona -> FuenteDeLosDeseos -> FuenteDeLosDeseos -> FuenteDeLosDeseos
comparar unCriterio  unaPersona unaFuente otraFuente  
        | unCriterio  unaPersona unaFuente otraFuente = unaFuente 
        | otherwise = otraFuente
 
cantidadDeFelicidonios :: FuenteDeLosDeseos -> Persona -> Int
cantidadDeFelicidonios unaFuente = felicidonios . unaFuente
 
cantidadDeHabilidades :: FuenteDeLosDeseos -> Persona -> Int
cantidadDeHabilidades unaFuente = length . habilidades . unaFuente
 
masCantidadDe :: Cantidad -> Criterio
masCantidadDe  unaCantidad unaPersona unaFuente otraFuente  = (unaCantidad unaFuente unaPersona) > (unaCantidad otraFuente unaPersona)
 
menosCantidadDe :: Cantidad -> Criterio
menosCantidadDe  unaCantidad unaPersona unaFuente = not.masCantidadDe unaCantidad unaPersona unaFuente
--caso de prueba
--fuenteGanadora raul (masCantidadDe cantidadDeFelicidonios) [fuenteSorda, fuenteAPedido  0,fuenteCopada, fuenteMinimalista]



-- Punto 6 
-- Implementar los siguientes requerimientos

-- Saber qué sueños son valiosos para una persona,
-- son aquellos que al cumplirlos la persona queda con más de 100 felicidonios. 

sueniosValiosos persona = verificarMayores100 (aplicarSuenios persona)

aplicarSuenios persona = ((map ($ persona) (suenios persona)))

verificarMayores100 = map ((>100) .felicidonios) 


-- Saber si algún sueño de una persona es raro, 
-- que es el que lo deja con la misma cantidad de felicidonios tras cumplirlo.

sueniosRaros :: Persona -> Bool
sueniosRaros persona = hayAlgunoRaro (map ((== felicidonios persona).felicidonios ) (aplicarSuenios persona))

hayAlgunoRaro = any (== True)


-- Dada una lista de personas, 
-- poder conocer la felicidad total de ese grupo si cumplen todos sus sueños. 
-- Tip: aprovecharse de alguna de las fuentes definidas anteriormente.

felicidadTotal :: [Persona] -> Int
felicidadTotal  persona = sum  (map ((felicidonios.fuenteCopada) persona) ) 




-- Punto 7
-- Modelar a una persona con sueños infinitos
-- Para cada fuente modelada en el punto 4, 
-- ¿es posible que esta pueda satisfacer a esa persona que tiene infinitos sueños? 
-- Justifique su respuesta con un ejemplo concreto: 
-- “a esta persona P0 con infinitos sueños S0 y la Fuente F1 la invoco en la consola y... (etc. etc. etc.)” 
-- y relacionelo con algún concepto visto en la cursada.


barry = Persona {
    nombre = "Barry",
    edad = 30,
    felicidonios = 2304,
    habilidades = ["Correr","Liderar"],
    suenios = cycle [recibirseDe "Medico", viajarA ["Paris","Oslo"],enamorarseDe eugenia]

}

-- Explicaciones de las distintas fuentes aplicadas a una persona con infinitos sueños
{- 
    Lo primero a tener en cuenta, es que haskell va haciendo los calculos a medida que lo va necesitando, por lo que
    por ej: si tenemos una lista infinita y hacemos un head o un take n, nos va a devolver esos valores finitos ya que
    primero obtiene la cabeza o los n valores y los valores restantes de la lista infinita no le importan
    Fuente minimalista: La fuente minimalista como solo toma el primer valor de la lista, 
    puede llegar a convenger la cuenta de felicidonios, pero los sueños al seguir siendo infinitos, 
    nunca va a terminar de mostrar una lista concreta por lo que suenio diverge
    Fuente copada: La fuente copada al tener que evaluar todos los sueños de la lista, nunca va a terminar de 
    evaluarlos, por lo que diverge totalmente. NO EVALUAR EN CONSOLA!!! 
    Fuente a pedido: La fuente a pedido va a poder tomar el valor que se le indique, y va a poder realizar
    la cuenta para la edad / felicidonios / habilidades, convergiendo esos a un valor en específico, pero como 
    la lista es infinita, nunca va a terminar de mostararla
    Fuente sorda: La fuente sorda al cumplir la funcion de identidad, le da igual que la persona tenga o no
    sueños infinitos, va a devolver todo igual siempre sin tener que realizar ningun cálculo y la lista de sueños,
    al ser infinita, va a diverger y nunca va a terminar de mostrar una lista finita
 -}