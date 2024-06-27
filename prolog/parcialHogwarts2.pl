lugarProhibido(bosque,50).
lugarProhibido(seccionRestringida,10).
lugarProhibido(tercerPiso,75).


hizo(ron, buenaAccion(jugarAlAjedrez, 50)).
hizo(harry, fueraDeCama).
hizo(hermione, irA(tercerPiso)).
hizo(hermione, responder(dondeSeEncuentraUnBezoar, 15, snape)).
hizo(hermione, responder(wingardiumLeviosa, 25, flitwick)).
hizo(harry, irA(bosque)).
hizo(draco, irA(mazmorras)).
hizo(cedric,buenaAccion(ganarAlQuidditch,100)).

hizo(luna, responder(dondeSeEncuentraUnBezoar, 15, snape)).
hizo(luna, responder(wingardiumLeviosa, 25, flitwick)).

esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).
esDe(cedric,hufflepuff).

% Punto 1

hizoAlgunaAccion(Mago):-
    hizo(Mago,_).

puntajeQueGenera(fueraDeCama,-50).
puntajeQueGenera(irA(Lugar),PuntajeQResta):-
    lugarProhibido(Lugar,Puntos),
    PuntajeQResta is Puntos * -1.
puntajeQueGenera(buenaAccion(_,Puntaje),Puntaje).

puntajeQueGenera(responder(_,Puntaje,Profe),Puntaje):-
    Profe\=snape.
puntajeQueGenera(responder(_,Puntaje,snape),MitadPuntaje):-
    MitadPuntaje is Puntaje /2.

hizoAlgunaMalaAccion(Mago):-
    hizo(Mago,Accion),
    puntajeQueGenera(Accion,Puntaje),
    Puntaje <0.

esBuenAlumno(Mago):-
    hizoAlgunaAccion(Mago),
    not(hizoAlgunaMalaAccion(Mago)).

recurrente(Accion):-
    hizo(Mago1,Accion),
    hizo(Mago2,Accion),
    Mago1\=Mago2.

% Punto 2

puntajeTotal(Casa,PuntajeTotal):-
    esDe(_,Casa),
    findall(Puntaje,(esDe(Mago,Casa),hizo(Mago,Accion),puntajeQueGenera(Accion,Puntaje)),Puntajes),
    sumlist(Puntajes,PuntajeTotal).

% Punto 3 

laCasaGanadora(Casa):-
    puntajeTotal(Casa,Puntaje1),
    forall((puntajeTotal(Casa2,Puntaje2),Casa \=Casa2),Puntaje1>Puntaje2).

/* 
laCasaGanadora(Casa):-
    puntajeTotal(Casa,Puntaje1),
    not((puntajeTotal(_,Puntaje2),Puntaje2>Puntaje1)).
*/

% Punto 4 resuelto arriba en puntaje que genera.

