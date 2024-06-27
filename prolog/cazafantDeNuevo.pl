herramientasRequeridas(ordenarCuarto, [aspiradora(100), trapeador, plumero]).
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordedadora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustradpesora, cera, aspiradora(300)]).

% punto 1

tiene(egon,aspiradora(200)).
tiene(egon,trapeador).
tiene(peter,trapeador).
tiene(peter,sopapa).
tiene(winston,varitaDeNeutrones).

% punto 2

satisface(Alguien,Herramienta):-
    tiene(Alguien,Herramienta).

satisface(Alguien,aspiradora(PotenciaNecesaria)):-
    tiene(Alguien,aspiradora(Potencia)),Potencia>=PotenciaNecesaria.

% punto 3

puedeHacer(Alguien,_):-
    tiene(Alguien,varitaDeNeutrones).

puedeHacer(Alguien,Tarea):-
    herramientasRequeridas(Tarea,Herramientas),
    tiene(Alguien,_),  %inversibilidad creo
    forall(member(Herramienta,Herramientas),satisface(Alguien,Herramienta)).

% punto 4

tareaPedida(cliente1,ordenarCuarto,10).
tareaPedida(cliente1,limpiarTecho,7).
tareaPedida(cliente2,limpiarBanio,3).

precioPorMetro(limpiarBanio,4).
precioPorMetro(ordenarCuarto,5).
precioPorMetro(limpiarTecho,3).

precioDeTarea(Cliente,Tarea,PrecioTarea):-
    tareaPedida(Cliente,Tarea,Metros),
    precioPorMetro(Tarea,PrecioMetro),
    PrecioTarea is PrecioMetro*Metros.

precioTotal(Cliente,Precio):-
    tareaPedida(Cliente,_,_),
    findall(PrecioCalculado,precioDeTarea(Cliente,_,PrecioCalculado),Precios),
    sumlist(Precios,Precio).
    
% punto 5

aceptaPedido(Trabajador,Cliente):-
    puedeRealizarTodo(Trabajador,Cliente),
    quiereHacerPedido(Trabajador,Cliente).

puedeRealizarTodo(Trabajador,Cliente):-
    tareaPedida(Cliente,_,_),
    tiene(Trabajador,_),
    forall(tareaPedida(Cliente,Tarea,_),puedeHacer(Trabajador,Tarea)).

quiereHacerPedido(ray,Cliente):-
    not(tareaPedida(Cliente,limpiarTecho,_)).

quiereHacerPedido(winston,Cliente):-
    precioTotal(Cliente,Precio),
    Precio>=500.

quiereHacerPedido(egon,Cliente):-
    not((tareaPedida(Cliente,Tarea,_),tareaCompleja(Tarea))).

quiereHacerPedido(peter,_).

tareaCompleja(limpiarTechos).

tareaCompleja(Tarea):-
    herramientasRequeridas(Tarea,Herramientas),
    length(Herramientas,Cantidad), 
    Cantidad>2.