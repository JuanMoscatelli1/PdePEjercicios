kioskero(dodain,lunes,9,15).
kioskero(dodain,miercoles,9,15).
kioskero(dodain,viernes,9,15).

kioskero(lucas,martes,10,20).

kioskero(juanC,sabados,18,22).
kioskero(juanC,domingos,18,22).

kioskero(juanF,jueves,10,20).
kioskero(juanF,viernes,12,20).

kioskero(leoC,lunes,14,18).
kioskero(leoC,miercoles,14,18).

kioskero(martu,miercoles,23,24).

% Punto 1

kioskero(vale,Dias,Hora1,Hora2):- kioskero(dodain,Dias,Hora1,Hora2).
kioskero(vale,Dias,Hora1,Hora2):- kioskero(juanC,Dias,Hora1,Hora2).

%por universo cerrado, no se agrega lo de leo ni lo de maiu

% Punto 2 

quienAtiende(Quien,Dia,Hora):- kioskero(Quien,Dia,Hora1,Hora2), between(Hora1,Hora2,Hora).

% Punto 3

foreverAlone(Quien,Dia,Hora):- quienAtiende(Quien,Dia,Hora),
  not((quienAtiende(Quien2,Dia,Hora),Quien \= Quien2)).

% Punto 4

head(X, [X|_]).
tail(Xs, [_|Xs]).

posibilidadesTotales(Dia,Todos):-
    findall(Persona,kioskero(Persona,Dia,_,_),Personas),
    posibilidades(Personas,Todos). 

posibilidades([],[]).

posibilidades([Persona | Personas],[Persona | PersonasPosibles]):- 
    posibilidades(Personas,PersonasPosibles).

posibilidades([_ | Personas], PersonasPosibles):-
    posibilidades(Personas,PersonasPosibles).

% - findall como herramienta para poder generar un conjunto de soluciones que satisfacen un predicado
% - mecanismo de backtracking de Prolog permite encontrar todas las soluciones posibles

% Punto 5

venta(dodain,fecha(lunes,10,8),[golosinas(1200),cigarrilos([jockey]),golosinas(50)]).

venta(dodain,fecha(miercoles,12,8),[bebida(alcoholica,8),bebida(noAlcoholica,1),golosinas(10)]).

venta(martu,fecha(miercoles,12,8),
  [golosinas(1000),cigarrilos([chesterfield,colorado,parisiennes])]).

ventas(lucas,fecha(martes,11,8),[golosinas(600)]).

ventas(lucas,fecha(martes,18,8),[bebida(noAlcoholica,2),cigarrillos([derby])]).

esSuertuda(bebida(alcoholica,_)).
esSuertuda(bebida(noAlcoholica,Cantidad)):- Cantidad > 5.
esSuertuda(golosinas(Precio)):- Precio > 100.
esSuertuda(cigarrillos(Lista)):- length(Lista,Numero),Numero>2.



personaSuertuda(Persona):-
    venta(Persona,_,_),
    forall(venta(Persona,_,[Venta | _]),esSuertuda(Venta)).