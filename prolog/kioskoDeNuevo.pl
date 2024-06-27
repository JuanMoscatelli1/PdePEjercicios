%atienden

atiende(dodain,lunes,9,15).
atiende(dodain,miercoles,9,15).
atiende(dodain,jueves,9,15).

atiende(lucas,martes,10,20).

atiende(juanC,sabado,18,22).
atiende(juanC,domingo,18,22).

atiende(juanFds,jueves,10,20).
atiende(juanFds,viernes,12,20).

atiende(leoC,lunes,14,18).
atiende(leoC,miercoles,14,18).

atiende(martu,miercoles,23,24).

%punto 1

atiende(vale,Dia,Hora1,Hora2):-
    atiende(dodain,Dia,Hora1,Hora2).
atiende(vale,Dia,Hora1,Hora2):-
    atiende(juanC,Dia,Hora1,Hora2).

% punto 2

quienAtiende(Persona,Dia,HoraEspecifica):-
    atiende(Persona,Dia,Hora1,Hora2),
    between(Hora1,Hora2,HoraEspecifica).

% punto 3 

foreverAlone(Persona,Dia,HoraEscpecifica):-
    quienAtiende(Persona,Dia,HoraEspecifica),
    not((quienAtiende(Persona2,Dia,HoraEspecifica),Persona\=Persona2)).

%que los que atienden ese mismo dia no sean diferentes a la persona(solo el)

% punto 4 

posibilidadesDeAtender(Dia,Personas):-
    findall(Persona,distinct(Persona,quienAtiende(Persona,Dia,_)),PersonasPosibles),
    combinar(PersonasPosibles,Personas).

