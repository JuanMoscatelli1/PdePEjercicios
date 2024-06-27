herramientasRequeridas(ordenarCuarto, [aspiradora(100), trapeador, plumero]).
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordedadora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustradpesora, cera, aspiradora(300)]).

% Punto 1

tiene(egon,aspiradora(200)).
tiene(egon,trapeador).
tiene(peter,trapeador).
tiene(peter,sopapa).
tiene(winston,varita).
tiene(egon,plumero).

% Punto 2

satisface(Alguien,Herramienta):-
    tiene(Alguien,Herramienta).

satisface(Alguien,aspiradora(PotenciaNecesaria)):-
    tiene(Alguien,aspiradora(Potencia)), Potencia >= PotenciaNecesaria.

% Punto 3

puedeRealizar(Alguien,_):-
    tiene(Alguien,varita).

puedeRealizar(Alguien,Tarea):-
    herramientasRequeridas(Tarea,Lista),
    tiene(Alguien,_),
    forall(member(Herramienta,Lista),satisface(Alguien,Herramienta)).

% Punto 4

tareaPedida(cliente1,ordenarCuarto,10).
tareaPedida(cliente1,limpiarTecho,7).
tareaPedida(cliente2,limpiarBanio,3).

precioPorMetro(limpiarBanio,4).
precioPorMetro(ordenarCuarto,5).
precioPorMetro(limpiarTecho,3).

calcularPrecio(Tarea,Metros,PrecioCalc):-
    precioPorMetro(Tarea,PrecioxMetro),
    PrecioCalc is PrecioxMetro * Metros.

% el tareaPedida(Cliente,_,_), lo hace inversible pero repite los resultados 1 vez??

precioTotal(Cliente,Total):-
    tareaPedida(Cliente,_,_),
    findall(PrecioCalc,(tareaPedida(Cliente,Tarea,Metros),calcularPrecio(Tarea,Metros,PrecioCalc)),Precios),
    sumlist(Precios,Total).

% Punto 5

tareaCompleja(limpiarTecho).
tareaCompleja(Tarea):-
    herramientasRequeridas(Tarea,Lista),length(Lista,Num),Num>2.

loAcepta(ray,Cliente):-
    not(tareaPedida(Cliente,limpiarTecho,_)).
loAcepta(winston,Cliente):-
    precioTotal(Cliente,Total),
    Total>500.
loAcepta(egon,Cliente):-
    not((tareaPedida(Cliente,Tarea,_),tareaCompleja(Tarea))).
loAcepta(peter,_).

acepta(Cazafantasma,Cliente):-
    tareaPedida(Cliente,_,_),
    tiene(Cazafantasma,_),
    forall(tareaPedida(Cliente,Tarea,_),puedeRealizar(Cazafantasma,Tarea)),
    loAcepta(Cazafantasma,Cliente).
    
% Punto 6



    
