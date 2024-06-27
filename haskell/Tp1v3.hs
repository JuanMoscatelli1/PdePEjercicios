{-# OPTIONS_GHC -Wno-deferred-type-errors #-}
import Text.Show.Functions()
import Data.List()

type Persona = (Edad,CantidadSuenios,Nombre,Felicidonios,Habilidad)

type Edad = Int 
type CantidadSuenios = Int 
type Nombre = String 
type Felicidonios = Int 
type Habilidades = String 
type Habilidad = [Habilidades]
type Ciudad = String
type Ciudades = [Ciudad]
type Actividad = String

edad :: Persona -> Edad
edad (edad,_, _, _, _) = edad

cantidadSuenios :: Persona -> CantidadSuenios
cantidadSuenios (_,cantidadSuenios,_,_,_) = cantidadSuenios

nombre :: Persona -> Nombre
nombre (_,_,nombre,_,_) = nombre

felicidonios :: Persona -> Felicidonios
felicidonios (_,_,_,felicidonios,_) = felicidonios



-- Punto 1: a) Coeficiente de satifaccion

coeficienteSatisfaccion (edad,cantidadSuenios,nombre,felicidonios,[habilidad])
    | felicidonios > 100 = felicidonios * edad
    | felicidonios <=100 && felicidonios > 50 = cantidadSuenios * felicidonios
    | otherwise = div felicidonios 2


-- Casos de prueba

-- *Main> coeficienteSatisfaccion(25,3,"aaa",101,["nnn"])
--2525

-- *Main> coeficienteSatisfaccion(25,2,"aaa",100,["nnn"])
-- 200

-- *Main> coeficienteSatisfaccion(25,3,"aaa",50,["nnn"])
-- 25



-- b) Grado de ambicion de una persona

gradoAmbicion (edad,cantidadSuenios,nombre,felicidonios,[habilidad])
    | felicidonios > 100 = felicidonios * cantidadSuenios
    | felicidonios <= 100 && felicidonios > 50 = edad * cantidadSuenios
    | otherwise = cantidadSuenios * 2

-- Casos de prueba

-- *Main> gradoAmbicion (25,2,"aaa",101,["nnn"])
-- 202

-- *Main> gradoAmbicion (26,2,"aaa",100,["nnn"])
-- 52

-- *Main> gradoAmbicion (26,1,"aaa",50,["nnn"])
-- 2



-- Punto 2: a) Nombre largo

nombreLargo (edad,cantidadSuenios,nombre,felicidonios,[habilidad]) = ((>10) . length) nombre

-- Casos de prueba

--  *Main> nombreLargo (25,5,"Evangelina",80,["nnn"])
-- False

--  *Main> nombreLargo (25,5,"Maximiliano",80,["nnn"])
-- True



-- b) Persona Suertuda

personaSuertuda  = even . (*3). coeficienteSatisfaccion

-- Casos de prueba

-- *Main> personaSuertuda (25,6,"aaabbbcccddd",14,["nnn"])
-- False

-- *Main> personaSuertuda (25,6,"aaabbbcccddd",12,["nnn"])
-- True




-- c) Nombre Lindo

nombreLindo (edad,cantidadSuenios,nombre,felicidonios,[habilidad]) = ((=='a') . last) nombre

-- Casos de prueba

-- *Main>  nombreLindo (25,6,"Ariel",80,["nnn"])
-- False

-- *Main>  nombreLindo (25,6,"Melina",80,["nnn"])
-- True




-- Punto 3: 

-- Los sueños
-- ●	Recibirse de una carrera

recibirseCarrera (edad,cantidadSuenios,nombre,felicidonios, [habilidad]) carrera =
    (edad,cantidadSuenios,nombre,length carrera * 1000  + felicidonios,carrera : [habilidad])

-- Caso de prueba
-- recibirseCarrera (25,5,"aaa",101,["Pintura"]) "arquitectura"



-- Viajar a una lista de ciudades, suma 100 felicidonios por cada ciudad que visita, en el interín pasa un año 
-- (la persona tendrá un año más luego de viajar).

viajarACiudades (edad,cantidadSuenios,nombre,felicidonios, [habilidad]) ciudades = 
    (edad+1,cantidadSuenios,nombre, length ciudades * 100 + felicidonios,[habilidad])

-- Caso de prueba
-- *Main> viajarACiudades (25,5,"Jorge",101,["Cantar"]) ["Paris","Lugano"] 


-- ●	Enamorarse de otra persona
enamorarseDeOtraPersona (edadX,cantidadSueniosX,nombreX,felicidoniosX, [habilidadX]) (edadY,cantidadSueniosY,nombreY,felicidoniosY, [habilidadY]) =
    (edadX,cantidadSueniosX,nombreX,(felicidoniosX + felicidoniosY) , [habilidadX])

-- *Main> enamorarseDeOtraPersona (25,5,"xxx",104,["nnn"]) (27,4,"yyy",80,["ggg"])
-- (25,5,"xxx",184,["nnn"])


-- ●	para los conformistas, el sueño “que todo siga igual”, que mantiene a la persona sin cambios.
queTodoSigaIgual (edad,cantidadSuenios,nombre,felicidonios,[habilidad]) actividad = 
    (edad, cantidadSuenios, nombre, felicidonios, [habilidad])

-- Caso de prueba
-- *Main> queTodoSigaIgual (25,5,"aaa",101,["nnn"]) "que todo siga igual"
-- (25,5,"aaa",101,["nnn"])


-- ●	combo perfecto: se recibe de la carrera de "Medicina", viaja a "Berazategui" y "París"
-- y como bonus extra suma 100 felicidonios por el combo. Definirlo únicamente con funciones existentes.

comboPerfecto (edad,cantidadSuenios,nombre,felicidonios,[habilidad]) carrera ciudades  
        |   carrera == "Medicina" && ciudades == ["Berazategui","Paris"] = (edad,cantidadSuenios,nombre,felicidonios +100, [habilidad])
        |   otherwise = (edad,cantidadSuenios,nombre,felicidonios,[habilidad])
    
    
-- *Main> comboPerfecto (25,5,"aaa",101,["nnn"]) ["Medicina"] ["Berazategui" ] ["Paris"]
-- (25,5,"aaa",201,["nnn"])
-- *Main>
