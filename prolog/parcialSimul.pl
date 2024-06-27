% contenido( Titulo, Contenido)
%    peli(Protagonistas, Reparto)
%    serie(Temporada, Protagonistas, Reparto) 
contenido(secretoDeTusOjos, peli(
[ darin, villamil, rago, francella ], [ alarcon, gioia ]
)).
contenido(elPadrino, peli( [ alpaccino, brando ],[jorge] )).
contenido(avengers, peli(
[ downeyjr, evans, ruffalo, hemsworth, johansson, pratt ], [ samuelJackson, dinklage ]
)).
contenido(friends, serie(1, [ cox, anniston ], [ typer ])).
contenido(friends, serie(8, [ cox, anniston ], [ pitt ])).

% personaje(Nombre, Fans, Skills)
personaje(brando, 4000, [violento, pokerFace]).
personaje(pratt, 2000, [carilindo, comico]).
personaje(francella, 200, [comico, serio]).
personaje(alpaccino,5000,[gordo,grasoso]).

% punto 1

popular(Personaje):-
   personaje(Personaje,Fans,_),Fans>3000.

% punto 2 

participo(Alguien):-
    participoEnPeliGeneral(Alguien).

participo(Alguien):-
    participoEnSerieGeneral(Alguien).

participoEnPeliGeneral(Alguien):-
    contenido(_,Tipo),
    participoEnPeli(Alguien,Tipo).    

participoEnSerieGeneral(Alguien):-
        contenido(_,Tipo),
        participoEnSerie(Alguien,Tipo).  

participoEnPeli(Alguien,peli(Lista1,_)):-
        member(Alguien,Lista1).
participoEnPeli(Alguien,peli(_,Lista2)):-
        member(Alguien,Lista2).    
participoEnSerie(Alguien,serie(_,_,Lista2)):-
        member(Alguien,Lista2).         
participoEnSerie(Alguien,serie(_,Lista1,_)):-
        member(Alguien,Lista1).        

% punto 3 

estrellitaDeCine(Alguien):-
    participoEnPeliGeneral(Alguien),
    not(participoEnSerieGeneral(Alguien)). 

% punto 4 

pantallaGrande(Alguien):-
    participoEnPeliGeneral(Alguien).

% punto 5

participoConTitulo(Alguien,Titulo):-
    participoEnPeliGeneralConTitulo(Alguien,Titulo).

participoConTitulo(Alguien,Titulo):-
    participoEnSerieGeneralConTitulo(Alguien,Titulo).

participoEnPeliGeneralConTitulo(Alguien,Titulo):-
    contenido(Titulo,Tipo),
    participoEnPeli(Alguien,Tipo).    

participoEnSerieGeneralConTitulo(Alguien,Titulo):-
    contenido(Titulo,Tipo),
    participoEnSerie(Alguien,Tipo). 

reencuentro(Titulo):- 
    contenido(Titulo,_),
    findall(Personaje,(participoConTitulo(Personaje,Titulo),popular(Personaje)),Personajes),
    length(Personajes,Numero),Numero>=2.

% punto 6

participoEnAlgoProta(Alguien,peli(Lista1,_)):-
    member(Alguien,Lista1).
participoEnAlgoProta(Alguien,serie(_,Lista1,_)):-
    member(Alguien,Lista1).
participoEnContenidoProta(Alguien,Titulo):-
    contenido(Titulo,Tipo),
    participoEnAlgoProta(Alguien,Tipo).

admiteMultiverso(Alguien):- 
    participoEnAlgoProta(Alguien,_),
    findall(Titulo,participoEnContenidoProta(Alguien,Titulo),Titulos).

%,length(Titulos,Numero),
%Numero>=2.
    
