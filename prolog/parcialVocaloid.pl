canta(megurineLuka, cancion(nightFever, 4)).
canta(megurineLuka, cancion(foreverYoung, 5)).
canta(hatsuneMiku, cancion(tellYourWorld, 4)).
canta(gumi, cancion(foreverYoung, 4)).
canta(gumi, cancion(tellYourWorld, 5)).
canta(seeU, cancion(novemberRain, 6)).
canta(seeU, cancion(nightFever, 5)).

% Punto 0

masNovedosos(Cantante):-
    canta(Cantante,_),
    findall(Cancion,canta(Cantante,cancion(Cancion,_)),Canciones),length(Canciones,Cant), Cant>=2,
    findall(Tiempo,canta(Cantante,cancion(_,Tiempo)),Tiempos),sumlist(Tiempos,Suma), Suma<15.

acelerado(Cantante):-
    canta(Cantante,_),
    not((canta(Cantante,cancion(_,Duracion)),Duracion>4)).
    
% Punto 1 y 2

cancionesTotales(Cantante,CantTotal):-
findall(Cancion,canta(Cantante,cancion(Cancion,_)),Canciones),length(Canciones,CantTotal).

tiempoTotal(Cantante,Tiempos):-
findall(Tiempo,canta(Cantante,cancion(_,Tiempo)),Tiempos).

masNovedososGigante(Cantante,Cantidad1,Cantidad2):-
    canta(Cantante,_),
    cancionesTotales(Cantante,CantTotal), CantTotal>=Cantidad1,
    tiempoTotal(Cantante,Tiempos),sumlist(Tiempos,Suma), Suma>Cantidad2.

concierto(mikuExpo,eeuu,2000,gigante(2,6)).
concierto(magicalMirai,japon,3000,gigante(3,10)).
concierto(vocalektVisions,eeuu,1000,mediano(9)).
concierto(mikuFest,argentina,100,pequenio(1,4)).

puedeParticipar(Vocaloid,Concierto):-
    concierto(Concierto,_,_,gigante(CantCanciones,TiempoMinimo)),
    masNovedososGigante(Vocaloid,CantCanciones,TiempoMinimo).

puedeParticipar(Vocaloid,Concierto):-
   concierto(Concierto,_,_,mediano(Duracion)),
   canta(Vocaloid,_),
   tiempoTotal(Vocaloid,Tiempos),sumlist(Tiempos,Suma),Suma<Duracion.

puedeParticipar(Vocaloid,Concierto):-
    concierto(Concierto,_,_,pequenio(_,Duracion)),
    canta(Vocaloid,cancion(_,Tiempo)),
    Tiempo>Duracion.

puedeParticipar(hatsuneMiku,Concierto):-
    concierto(Concierto,_,_,_).

% Punto 3

famaDeConciertos(Vocaloid,FamaTotal):-
    canta(Vocaloid,_),
    findall(Fama,(puedeParticipar(Vocaloid,Concierto),concierto(Concierto,_,Fama,_)),Famas),
    sumlist(Famas,FamaTotal).

calcularFamaTotal(Vocaloid,FamaTotalCalculada):-
    famaDeConciertos(Vocaloid,Fama),
    cancionesTotales(Vocaloid,CancionesTotales),
    FamaTotalCalculada is Fama * CancionesTotales.

elMasFamoso(Vocaloid):-
    calcularFamaTotal(Vocaloid,Fama),
    forall((calcularFamaTotal(Vocaloid2,Fama2),Vocaloid2 \= Vocaloid),Fama>=Fama2).

% Punto 4

conoceA(megurineLuka,hastuneMiku).
conoceA(megurineLuka,gumi).
conoceA(gumi,seeU).
conoceA(seeU,kaito).

conocido(Alguien,Otro):-
    conoceA(Alguien,Otro).

conocido(Alguien,Otro):-
    conoceA(Alguien,Alguien2),
    conocido(Alguien2,Otro).

unico(Vocaloid,Concierto):-
    puedeParticipar(Vocaloid,Concierto),
    not((conocido(Vocaloid, OtroCantante), 
    puedeParticipar(OtroCantante, Concierto))).

    %forall(conocido(Vocaloid,Alguien),not(puedeParticipar(Alguien,Concierto))).



