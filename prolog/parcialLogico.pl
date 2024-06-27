% Punto 1

idiomaGratuito(ingles).
idiomaGratuito(espaniol).
idiomaGratuito(portugues).

idiomaPremium(italiano).
idiomaPremium(hebreo).
idiomaPremium(frances).
idiomaPremium(chino).

alumno(cristian,22,espaniol,gratuita,[idioma(ingles,7),idioma(portugues,15)]).
alumno(maria,34,ingles,premium(bronce),[idioma(hebreo,1)]).
alumno(felipe,60,italiano,premium(oro),[]).
alumno(juan,12,espaniol,aCuentaGotas(6),[idioma(ingles,20)]).

% Punto 2

esAvanzado(Alumno,Idioma):-
    alumno(Alumno,_,_,_,ListaDeIdiomas),
    member(idioma(Idioma,Nivel),ListaDeIdiomas),Nivel >= 15.

% Punto 3

esMiembroConNivel(Idioma,ListaDeIdiomas,Nivel):-
    member(idioma(Idioma,Nivel),ListaDeIdiomas).

certificado(Alumno,Idioma):-
    alumno(Alumno,_,_,_,ListaDeIdiomas),
    esMiembroConNivel(Idioma,ListaDeIdiomas,20).

% Punto 4

idioma(Idioma):-
    idiomaGratuito(Idioma).
idioma(Idioma):-
    idiomaPremium(Idioma).

lenguaCodiciada(Idioma1,Idioma2):-
    idioma(Idioma2),
    alumno(_,_,Idioma1,_,_),
    forall(alumno(_,_,Idioma1,_,ListaDeIdiomas),member(idioma(Idioma2,_),ListaDeIdiomas)).

% Punto 5

leFaltaAprender(Alguien,IdiomaFaltante):-
    idioma(IdiomaFaltante),
    alumno(Alguien,_,IdiomaNativo,_,ListaDeIdiomas),
    IdiomaNativo \= IdiomaFaltante,
    not(esMiembroConNivel(IdiomaFaltante,ListaDeIdiomas,20)).

% Punto 6

poliglota(Alguien):-
    alumno(Alguien,_,_,_,ListaDeIdiomas),
    esMiembroConNivel(Idioma1,ListaDeIdiomas,20),
    esMiembroConNivel(Idioma2,ListaDeIdiomas,20),
    Idioma1\=Idioma2.

% le agrego idioma(portugues,20) a la lista de idiomas de juan y muestra a juan.

% Punto 7


% no funciona correctamente pero es lo mejor que pude hacer(ya no daba mas).

puedeHacerCurso(Alumno,Idioma):-
    alumno(Alumno,_,_,gratuita,_),
    idiomaGratuito(Idioma).

todosLosIdiomasPosibles([],[],_,_).

todosLosIdiomasPosibles([Idioma | Idiomas],[Idioma | IdiomasPosibles],CantidadMaxima,Contador):-
    Contador<CantidadMaxima,
    Contador is Contador+1,
    todosLosIdiomasPosibles(Idiomas,IdiomasPosibles,CantidadMaxima,Contador).
    
todosLosIdiomasPosibles([_,Idiomas],IdiomasPosibles,CantidadMaxima,Contador):-
    todosLosIdiomasPosibles(Idiomas,IdiomasPosibles,CantidadMaxima,Contador).


puedeHacerCurso(Alumno,Idiomas):-
    alumno(Alumno,_,_,premium(bronce),ListaDeIdiomas),
    findall(Idioma,(member(idioma(Idioma,_),ListaDeIdiomas),idiomaPremium(Idioma)),ListaDeIdiomasPremium),
    length(ListaDeIdiomasPremium,CantidadDePremium),
    todosLosIdiomasPosibles(ListaDeIdiomas,Idiomas,3,CantidadDePremium).


% Punto 8

alumno(jorge,50,klingon,premium(oro),[]).
alumno(julian,26,espaniol,aCuentaGotas(6),[idioma(esperanto,20),idioma(ingles,8)]).
alumno(ricardo,44,espaniol,aCuentaGotas(6),
     [idioma(frances,20),idioma(hebreo,20),idioma(portugues,20),idioma(chino,20)]).


hablaIdiomaNativamente(Persona,Idioma):-
    alumno(Persona,_,Idioma,_,_).

hablaIdiomaNivel20(Persona,Idioma):-
    alumno(Persona,_,_,_,ListaDeIdiomas),
    esMiembroConNivel(Idioma,ListaDeIdiomas,20).

hablaIdioma(Persona,Idioma):-
    hablaIdiomaNativamente(Persona,Idioma).
hablaIdioma(Persona,Idioma):-
    hablaIdiomaNivel20(Persona,Idioma).
hablaIdioma(ernesto,ingles).

idiomaExcentrico(klingon).
idiomaExcentrico(esperanto).
idiomaExcentrico(latin).

sigueA(ricardo,adrian).
sigueA(jorge,adrian).
sigueA(julian,adrian).
%sigueA(juan,adrian).
sigueA(adrian,ernesto).


esExcentrica(Persona):-
    hablaIdioma(Persona,IdiomaExcentrico),
    idiomaExcentrico(IdiomaExcentrico).
esExcentrica(Persona):-
    alumno(Persona,_,_,_,_),
    not(hablaIdioma(Persona,ingles)),
    findall(Idioma,hablaIdioma(Persona,Idioma),ListaDeIdiomas2),
    length(ListaDeIdiomas2,Cantidad),Cantidad>=5.

tieneExcentricismo(Alguien):-
    sigueA(_,Alguien),
    forall(sigueA(Seguidor,Alguien),esExcentrica(Seguidor)).

% Punto 9

conoceA(Alguien,Otro):-
    sigueA(Alguien,Otro).
conoceA(Alguien,Otro):-
    sigueA(Alguien,Otro2),
    conoceA(Otro2,Otro).

puedeTraducir(Alguien,Idioma):-
    hablaIdioma(Alguien,Idioma).
puedeTraducir(Alguien,Idioma):-
    conoceA(Alguien,Persona),
    hablaIdioma(Persona,Idioma).

/* puse un hecho de q ernesto habla ingles para probar quienes pueden traducir ingles, y que
adrian sigue a ernesto, y al probar puedeTraducir muestra a los seguidores de adrian y a adrian.
*/