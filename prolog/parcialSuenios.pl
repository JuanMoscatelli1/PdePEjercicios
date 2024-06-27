creeEn(gabriel,campanita).
creeEn(gabriel,magoDeOz).
creeEn(gabriel,cavenaghi).
creeEn(juan,conejoDePascua).
creeEn(macarena,reyesMagos).
creeEn(macarena,magoCapria).
creeEn(macarena,campanita).

suenia(gabriel,ganarLoteria([5,9])).
suenia(gabriel,futbolista(arsenal)).
suenia(juan,cantante(100000)).
suenia(macarena,cantante(10000)).

% Punto 2

equipoChico(arsenal).
equipoChico(aldosivi).

dificultad(cantante(Numero),6):-
    Numero>500000.
dificultad(cantante(Numero),4):-
    Numero<500000.
dificultad(ganarLoteria(Lista),Dificultad):-
    length(Lista,Cantidad),
    Dificultad is 10*Cantidad.
dificultad(futbolista(Equipo),3):-
    equipoChico(Equipo).
dificultad(futbolista(Equipo),16):-
    not(equipoChico(Equipo)).

esAmbiciosa(Alguien):-
    creeEn(Alguien,_),
    findall(Dificultad,(suenia(Alguien,Suenio),dificultad(Suenio,Dificultad)),Dificultades),
    sumlist(Dificultades,DificultadesSumadas),
    DificultadesSumadas > 20.

% Punto 3

esPuro(futbolista(_)).
esPuro(cantante(Numero)):-
    Numero<200000.


tieneQuimica(Alguien,Personaje):-
    %Personaje \= campanita,
    creeEn(Alguien,Personaje),
    forall(suenia(Alguien,Suenio),esPuro(Suenio)),
    not(esAmbiciosa(Alguien)).
tieneQuimica(Alguien,campanita):-
    creeEn(Alguien,campanita),
    suenia(Alguien,Suenio),
    dificultad(Suenio,Dificultad),
    Dificultad<5.

% Punto 4

esAmigo(campanita,reyesMagos).
esAmigo(campanita,conejoDePascua).
esAmigo(conejoDePascua,cavenaghi).

personajeDeBackup(PersonajeDeBackup,Personaje):-
    esAmigo(PersonajeDeBackup,Personaje).
personajeDeBackup(PersonajeDeBackup,Personaje):-
    esAmigo(PersonajeDeBackup,Personaje2),
    personajeDeBackup(Personaje2,Personaje).

estaTriste(campanita).
estaTriste(conejoDePascua).

sueniaYTieneQuimica(Persona,Personaje):-
    suenia(Persona,_),
    tieneQuimica(Persona,Personaje).

cumpleCondiciones(Personaje):-
    not(estaTriste(Personaje)).
cumpleCondiciones(Personaje):-
    personajeDeBackup(PersonajeDeBackup,Personaje),
    not(estaTriste(PersonajeDeBackup)).


puedeAlegrar(Persona,Personaje):-
    sueniaYTieneQuimica(Persona,Personaje),
    cumpleCondiciones(Personaje).




