ingrediente(cupcake, harina(165, reposteria)).
ingrediente(cupcake, mantequilla(sinSal, 165)).
ingrediente(cupcake, azucar(165)).
ingrediente(cupcake, leche).
ingrediente(cupcake, huevos(3)).

ingrediente(torta, mantequilla(conSal,200)).
ingrediente(torta, harina(150,reposteria)).
ingrediente(torta, azucar(200)).
ingrediente(torta, oregano).

ingrediente(asado, harina(100,reposteria)).

participante(juan).
participante(susana).

suministro(juan, harina(200, reposteria)).
suministro(juan, mantequilla(conSal, 200)).
suministro(juan, azucar(1000)).
suministro(juan, leche).
suministro(juan, huevos(12)).

% Punto 1

suministro(Participante,manteca):-
    participante(Participante).

hizo(juan,cupcake).
hizo(juan,torta).

hizo(susana,muffins).
hizo(susana,cupcake).

% Punto 2

tieneSuficiente(Pastelero,harina(Cantidad,_)):-
    suministro(Pastelero,harina(Cantidad2,_)),
    Cantidad2>=Cantidad.

tieneSuficiente(Pastelero,mantequilla(_,Cantidad)):-
    suministro(Pastelero,mantequilla(_,Cantidad2)),
    Cantidad2>=Cantidad.

tieneSuficiente(Pastelero,azucar(Cantidad)):-
    suministro(Pastelero,azucar(Cantidad2)),
    Cantidad2>=Cantidad.

tieneSuficiente(Pastelero,huevos(Cantidad)):-
    suministro(Pastelero,huevos(Cantidad2)),
    Cantidad2>=Cantidad.

tieneSuficiente(Pastelero,leche):-
    suministro(Pastelero,leche).

tieneSuficiente(Pastelero,manteca):-
    suministro(Pastelero,manteca).

% Punto 3

puedeHacer(Participante,Receta):-
    participante(Participante),
    ingrediente(Receta,_),
    forall(ingrediente(Receta,Ingrediente),tieneSuficiente(Participante,Ingrediente)),
    tieneSuficiente(Participante,manteca).

% Punto 4

ingredienteSimilar(mantequilla, manteca).
ingredienteSimilar(mantequilla, margarina).
ingredienteSimilar(azucar, miel).

ingredienteSimilar(Ingrediente1,Ingrediente2):-
    functor(Ingrediente1,Nombre,_),
    functor(Ingrediente2,Nombre,_).

recetaSimilar(Receta1,Receta2):-
    findall(Ingrediente,
               (ingrediente(Receta1,Ingrediente),ingrediente(Receta2,Ingrediente2),
               ingredienteSimilar(Ingrediente,Ingrediente2)),Ingredientes),
               length(Ingredientes,Numero), Numero>=3.

desafio(Receta,Participante):-
    participante(Participante),
    ingrediente(Receta,_),
    not((hizo(Participante,RecetasQueHizo),recetaSimilar(Receta,RecetasQueHizo))).

% Punto 5

/* deberia agregar el cacao en el tiene suficiente, el polimorfismo ayuda
en puedeHacer se uso, en tieneSuficiente que le pasamos el ingrediente, y el predicado
tieneSuficiente se encarga de decir si es verdadero o falso.
*/

% Punto 6

obtenerGramos(harina(Cantidad,_),Cantidad).
obtenerGramos(mantequilla(_,Cantidad),Cantidad).
obtenerGramos(azucar(Cantidad),Cantidad).

cantidadDeFelicidad(Participante,Receta,CantFelicidoniosTotal):-
    ingrediente(Receta,_),
    participante(Participante),
    findall(Felicidonios,(ingrediente(Receta,Ingrediente),obtenerGramos(Ingrediente,Felicidonios)),Lista),
    not(hizo(Participante,Receta)),
    sumlist(Lista,CantFelicidoniosTotal).

cantidadDeFelicidad(Participante,Receta,CantFelicidoniosTotal):-
    ingrediente(Receta,_),
    participante(Participante),
    findall(Felicidonios,(ingrediente(Receta,Ingrediente),obtenerGramos(Ingrediente,Felicidonios)),Lista),
    hizo(Participante,Receta),
    sumlist(Lista,PreCantFelic),
    CantFelicidoniosTotal is PreCantFelic +100.

% Punto 7

esParecida(Receta1):-
    ingrediente(Receta1,_),
    recetaSimilar(Receta1,_).

esParecida(Receta1):-
    ingrediente(Receta1,_),
    recetaSimilar(Receta1,Receta2),
    Receta1\=Receta2,
    esParecida(Receta2),
    Vueltas is Vueltas +1,
    Vueltas<7.
    
    