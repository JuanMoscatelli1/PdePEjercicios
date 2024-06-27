-- Punto 1: a) Coeficiente de satifaccion

coeficienteSatisfaccion (edad,cantidadSuenios,nombre,felicidonios,habilidades)
    | felicidonios > 100 = felicidonios * edad
    | felicidonios <=100 && felicidonios > 50 = cantidadSuenios * felicidonios
    | otherwise = div felicidonios 2

-- b) Grado de ambicion de una persona

gradoAmbicion (edad,cantidadSuenios,nombre,felicidonios,habilidades)
    | felicidonios > 100 = felicidonios * cantidadSuenios
    | felicidonios <= 100 && felicidonios > 50 = edad * cantidadSuenios
    | otherwise = cantidadSuenios * 2 

-- Punto 2: a) Nombre largo

nombreLargo (edad,cantidadSuenios,nombre,felicidonios,habilidades) = ((>10) . length) nombre

-- b) Persona Suertuda

personaSuertuda  = even . (*3). coeficienteSatisfaccion 

-- c) Nombre Lindo

-- nombreLindo nombre1 = 'a' == (nombre1 !! (length (nombre1)))

-- Punto 3: Los sueños