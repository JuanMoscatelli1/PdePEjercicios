mago(harry, mestiza, [coraje, amistad, orgullo, inteligencia]).
mago(ron, pura, [amistad, diversion, coraje]).
mago(hermione, impura, [inteligencia, coraje, responsabilidad, amistad, orgullo]).
mago(hannahAbbott, mestiza, [amistad, diversion]).
mago(draco, pura, [inteligencia, orgullo]).
mago(lunaLovegood, mestiza, [inteligencia, responsabilidad, amistad, coraje]).

odia(harry,slytherin).
odia(draco,hufflepuff).

casa(gryffindor).
casa(hufflepuff).
casa(ravenclaw).
casa(slytherin).

caracteriza(gryffindor,amistad).
caracteriza(gryffindor,coraje).
caracteriza(slytherin,orgullo).
caracteriza(slytherin,inteligencia).
caracteriza(ravenclaw,inteligencia).
caracteriza(ravenclaw,responsabilidad).
caracteriza(hufflepuff,amistad).
caracteriza(hufflepuff,diversion).

% Punto 1

permiteEntrar(Casa,Mago):-
    casa(Casa),
    Casa \= slytherin,
    mago(Mago,_,_).

permiteEntrar(slytherin,Mago):-
    not(mago(Mago,impura,_)).

% Punto 2

tieneCaracter(Mago,Casa):-
    mago(Mago,_,Lista),
    casa(Casa),
    forall(caracteriza(Casa,Trait),member(Trait,Lista)).
    
% Punto 3

casaPosible(Mago,Casa):-
    tieneCaracter(Mago,Casa),
    permiteEntrar(Casa,Mago),
    not(odia(Mago,Casa)).

% Punto 4

tieneAmistad(Mago):-
    mago(Mago,_,Lista),
    member(amistad,Lista).

todosAmistosos(ListaDeMagos):-
    forall(member(Mago,ListaDeMagos),tieneAmistad(Mago)).

cadenaDeCasas([Mago1, Mago2 | MagosRestantes]):-
    casaPosible(Mago1,Casa),
    casaPosible(Mago2,Casa),
    cadenaDeCasas([Mago2 | MagosRestantes]).
cadenaDeCasas([_]).
cadenaDeCasas([]).

cadenaDeAmistades(ListaDeMagos):-
    todosAmistosos(ListaDeMagos),
    cadenaDeCasas(ListaDeMagos).
