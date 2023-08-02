% A
canta(megurineLuka, cancion(nightFever, 4)).
canta(megurineLuka, cancion(foreverYoung, 5)).
canta(hatsuneMiku, cancion(tellYourWorld, 4)).
canta(gumi, cancion(foreverYoung, 4)).
canta(gumi, cancion(tellYourWorld, 5)).
canta(seeU, cancion(novemberRain, 6)).
canta(seeU, cancion(nightFever, 5)).

% 1.
esNovedoso(Cantante) :-
    sabeAlMenosDosCanciones(Cantante),
    sumaDuracionDeSusCanciones(Cantante, SumaMinutos),
    SumaMinutos < 15.

sabeAlMenosDosCanciones(Cantante) :-
    canta(Cantante, cancion(UnaCancion,_)),
    canta(Cantante, cancion(OtraCancion,_)),
    UnaCancion \= OtraCancion.

sumaDuracionDeSusCanciones(Cantante, SumaMinutos) :-
    findall(Minutos, canta(Cantante, cancion(_, Minutos)), ListaTotalMinutos),
    sumlist(ListaTotalMinutos, SumaMinutos).

% 2.
/* esAcelerado(Cantante) :-
    canta(Cantante, _),
    forall(canta(Cantante, cancion(_, Minutos)), Minutos =< 4). */
    
esAcelerado(Cantante) :-
    canta(Cantante, _),
    not((canta(Cantante, cancion(_, Minutos)), Minutos > 4)).

% B
% 1.
concierto(mikuExpo, usa, 2000, gigante(2, 6)).
concierto(magicalMirai, japon, 3000, gigante(3, 10)).
concierto(vocalektVisions, usa, 1000, mediano(9)).
concierto(mikuFest, argentina, 100, pequenio(4)).

% 2.
puedeParticipar(hatsuneMiku, Concierto) :-
    concierto(Concierto, _, _, _).

puedeParticipar(Cantante, Concierto) :-
    canta(Cantante, _),
    concierto(Concierto, _, _, Requisitos),
    cumpleRequisitos(Cantante, Requisitos).

cumpleRequisitos(Cantante, gigante(CantMinimaCanciones, DuracionMinima)) :-
    cantidadCanciones(Cantante, CantCanciones),
    CantCanciones >= CantMinimaCanciones,
    sumaDuracionDeSusCanciones(Cantante, SumaMinutos),
    SumaMinutos > DuracionMinima.

cumpleRequisitos(Cantante, mediano(DuracionMaxima)) :-
    sumaDuracionDeSusCanciones(Cantante, SumaMinutos),
    SumaMinutos < DuracionMaxima.

cumpleRequisitos(Cantante, pequenio(DuracionMinimaDeAlgunaCancion)) :-
    canta(Cantante, cancion(_, Minutos)),
    Minutos > DuracionMinimaDeAlgunaCancion.

cantidadCanciones(Cantante, CantCanciones) :-
    canta(Cantante, _),
    findall(Cancion, canta(Cantante, cancion(Cancion, _)), ListaDeSusCanciones),
    length(ListaDeSusCanciones, CantCanciones).

% 3.
cantanteMasFamoso(CantanteMasFamoso) :-
    cantidadFama(CantanteMasFamoso, CantidadFama),
    forall(cantidadFama(_, OtraCantidadFama), CantidadFama >= OtraCantidadFama).

cantidadFama(Cantante, CantidadFama) :-
    canta(Cantante, _),
    famaDeConciertos(Cantante, FamaTotalConciertos),
    cantidadCanciones(Cantante, CantCanciones),
    CantidadFama is FamaTotalConciertos * CantCanciones.

famaDeConciertos(Cantante, FamaTotalConciertos) :-
    findall(Fama, famaConcierto(Cantante, Fama), ListaFamas),
    sumlist(ListaFamas, FamaTotalConciertos).
    
famaConcierto(Cantante, Fama) :-
    puedeParticipar(Cantante, Concierto), 
    concierto(Concierto, _, Fama, _).

% 4.
conoce(megurineLuka, hatsuneMiku).
conoce(megurineLuka, gumi).
conoce(gumi, seeU).
conoce(seeU, kaito).

unicoParticipante(Cantante, Concierto) :-
    puedeParticipar(Cantante, Concierto),
    not(conoceOtroParticipante(Cantante, Concierto)).
    
conoceOtroParticipante(Cantante, Concierto) :-
    conoceOConocido(Cantante, OtroCantante),
    puedeParticipar(OtroCantante, Concierto).

conoceOConocido(Cantante, OtroCantante) :-
    conoce(Cantante, OtroCantante).

conoceOConocido(Cantante, OtroCantante) :-
    conoce(Cantante, UnCantante),
    conoceOConocido(UnCantante, OtroCantante).

% 5.
% Si aparece un nuevo tipo de concierto, habria que agregar otra clausula al predicado
% de cumpleRequisitos en donde se le pase que tipo de concierto es y sus requisitos.
% Dicha implementacion fue facilitada gracias al conceptos polimorfismo.