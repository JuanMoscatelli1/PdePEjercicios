import Text.Show.Functions ()
import Data.List()

data Cliente = Cliente {
    nombreCliente :: String,
    hogar :: String
} deriving (Show)

data Viaje = Viaje {
    fecha :: Int,
    cliente :: Cliente,
    costo :: Int
} deriving (Show)

type Condicion = Viaje -> Bool

data Chofer = Chofer {
    nombre :: String,
    kilometraje :: Int,
    viajes :: [Viaje],
    condicion :: Condicion
} deriving (Show)

lucas :: Cliente
lucas = Cliente {
    nombreCliente = "lucas",
    hogar = "victoria"
}

viajeDanielLucas :: Viaje
viajeDanielLucas = Viaje {
    fecha = 20042017,
    cliente = lucas,
    costo = 150
}

daniel :: Chofer 
daniel = Chofer {
    nombre = "daniel",
    kilometraje = 23500,
    viajes = [viajeDanielLucas],
    condicion = noViveEn "olivos"
}

alejandra :: Chofer 
alejandra = Chofer {
    nombre = "alejandra",
    kilometraje = 180000,
    viajes = [],
    condicion = cualquierViaje
}
--punto 2
cualquierViaje viaje = True

viajeMayorA200 viaje = costo viaje > 200

nombreClienteMayorA n viaje = length ((nombreCliente.cliente) viaje) > n

noViveEn lugar viaje = hogar (cliente viaje) /= lugar

--punto 4

puedeTomar viaje chofer = (condicion chofer) viaje

--punto 5

liquidacion chofer = sum (map costo (viajes chofer))

--punto 6 

cualesPuedenTomarlo viaje listaChoferes = filter (puedeTomar viaje) listaChoferes

choferConMenosViaje :: [Chofer] -> Chofer
choferConMenosViaje [chofer] = chofer
choferConMenosViaje (chofer1:choferes) 
    | length (viajes chofer1) > length (viajes(head choferes)) = choferConMenosViaje choferes
    | otherwise = choferConMenosViaje (chofer1:(drop 1 choferes))

efectuarViaje viaje chofer = viajes chofer ++ viaje

--punto 7 

viajeNitoLucas :: Viaje 
viajeNitoLucas = Viaje {
    fecha = 11032017,
    cliente = lucas,
    costo = 50
}

repetirViaje viaje = viaje : repetirViaje viaje

nitoInfy :: Chofer 
nitoInfy = Chofer {
    nombre = "nito infy",
    kilometraje = 70000,
    viajes = repetirViaje viajeNitoLucas,
    condicion = nombreClienteMayorA 3
}

{-la liquidacion no se puede calcular porque la lista de viajes es infinita, en cambio 
saber si puede tomar un viaje es posible porque solamente se trabaja con la condicion-}
