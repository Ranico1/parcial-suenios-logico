%creeEn(Persona, En quien cree).

creeEn(gabriel, campanita).
creeEn(gabriel, magoDeOz).
creeEn(gabriel, cavenaghi).
creeEn(juan, conejoDePascua).
creeEn(macarena,reyesMagos).
creeEn(macarena, magoCapria).
creeEn(macarena, campanita).

% suenio(objetivo, caracteristicas()).
suenio(gabriel, loteria, caracteristicasLoteria([5,9])).
suenio(gabriel, futbolista, caracteristicasFutbolista(arsenal)). 
suenio(juan, cantante, caracteristicasCantante(100.000)).
suenio(macarena, cantante, caracteristicasCantante(10000)). 



% Punto 2

ambiciosa(Persona) :-
    creeEn(Persona,_),
    sueniosDificles(Persona).

sueniosDificles(Persona) :-
    findall(DificultadSuenio, dificultadSuenio(Persona, DificultadSuenio), Dificultades),
    sum_list(Dificultades, NivelDificultad),
    NivelDificultad > 20. 

dificultadSuenio(Persona, DificultadSuenio) :- 
    suenio(Persona, _, Suenio),
    tipoDeDificultad(Suenio, DificultadSuenio).

tipoDeDificultad(caracteristicasCantante(CantDiscos), 6) :-
    CantDiscos > 500000.

tipoDeDificultad(caracteristicasCantante(CantDiscos), 4) :-
    CantDiscos =< 500000.

tipoDeDificultad(caracteristicasLoteria(NumerosApostados), DificultadSuenio) :-
    length(NumerosApostados, CantNumeros),
    DificultadSuenio is CantNumeros * 10. 

tipoDeDificultad(caracteristicasFutbolista(Equipo), 3) :- 
    equipoChico(Equipo).

tipoDeDificultad(caracteristicasFutbolista(Equipo), 16) :- 
   not(equipoChico(Equipo)). 
    

equipoChico(aldosivi).
equipoChico(arsenal). 

% Punto 3 

tienenQuimica(Personaje, Persona) :-
    creeEn(Persona, Personaje), 
    tieneSueniosPuros(Persona), 
    not(ambiciosa(Persona)),
    Personaje \= campanita.

tienenQuimica(campanita, Persona) :-
    creeEn(Persona, campanita), 
    dificultadSuenio(Persona, DificultadSuenio),
    DificultadSuenio < 5. 

tieneSueniosPuros(Persona) :-
    forall(suenio(Persona,_,Suenio), suenioPuro(Suenio)).

suenioPuro(caracteristicasFutbolista(_)).
suenioPuro(caracteristicasCantante(CantDiscos)) :-
    CantDiscos < 200000. 

% Punto 4 

amigos(campanita, reyesMagos).
amigos(campanita, conejoDePascua).
amigos(conejoDePascua, cavenaghi).

loAlegra(Personaje, Persona) :- 
    suenio(Persona,_,_), 
    tienenQuimica(Personaje, Persona), 
    algunPersonajeSano(Personaje). 

algunPersonajeSano(Personaje) :-
    not(enfermo(Personaje)). 

algunPersonajeSano(Personaje) :- 
    amigos(Personaje, Amigo),
    algunPersonajeSano(Amigo). 

enfermo(campanita).
enfermo(reyesMagos).
enfermo(conejoDePascua). 




