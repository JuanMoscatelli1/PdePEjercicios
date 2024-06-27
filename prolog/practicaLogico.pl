odiaA(charles,Persona2):-
  viveEnMansion(Persona2),
  not(odiaA(agatha,Persona2)).
odiaA(agatha,Persona):-
  viveEnMansion(Persona),
  Persona \= carnicero.
odiaA(carnicero,Persona):-
  odiaA(agatha,Persona).
  
viveEnMansion(charles).  
viveEnMansion(carnicero).  
viveEnMansion(agatha).

masRicoQueAgatha(Persona):-
  viveEnMansion(persona),
  not(odiaA(carnicero,Persona)).
  
asesino(Victima,Asesino):-
  odiaA(Asesino,Victima),
  not(masRicoQueAgatha(Asesino)),
  viveEnMansion(Asesino).

tarea(login, 80, programador). % La tarea login tarda 80 horas y debe ser realizada por el programador
tarea(cacheDistribuida, 120, arquitecto).
tarea(pruebasPerformance, 100, tester).
tarea(tuning, 30, arquitecto).

precede(cacheDistribuida, pruebasPerformance). % La tarea pruebasDePerformance solo puede comenzar una vez que cacheDistribuida finalice
precede(pruebasPerformance, tuning).

realizada(login). % La tarea login ya se realizo

anterior(TareaA,TareaB):-
  precede(TareaA,TareaB).
  
anterior(TareaA,TareaB):-
  precede(TareaC,TareaB),
  anterior(TareaA,TareaC).

meFaltaPara(TareaA,TareaB):-
  anterior(TareaB,TareaA),
  not(realizada(TareaB)).

puedoHacer(Tarea):-
  tarea(Tarea,_,_),
  not(realizada(Tarea)),
  forall(meFaltaPara(Tarea,TareaB),realizada(TareaB)).