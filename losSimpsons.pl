padreDe(abe, abbie).
padreDe(abe, homero).
padreDe(abe, herbert).
padreDe(clancy, marge).
padreDe(clancy, patty).
padreDe(clancy, selma).
padreDe(homero, bart).
padreDe(homero, hugo).
padreDe(homero, lisa).
padreDe(homero, maggie).

madreDe(edwina, abbie).
madreDe(mona, homero).
madreDe(gaby, herbert).
madreDe(jacqueline, marge).
madreDe(jacqueline, patty).
madreDe(jacqueline, selma).
madreDe(marge, bart).
madreDe(marge, hugo).
madreDe(marge, lisa).
madreDe(marge, maggie).
madreDe(selma, ling).

% Punto 1
tieneHijo(Personaje) :-
    padreDe(Personaje,_).

tieneHijo(Personaje) :-
    madreDe(Personaje,_).

hermanos(Hermano1, Hermano2) :-
    padreDe(Padre, Hermano1),
    padreDe(Padre, Hermano2),
    madreDe(Madre, Hermano1),
    madreDe(Madre, Hermano2),
    Hermano1 \= Hermano2.

medioHermanos(MedioHermano1, MedioHermano2) :-
    padreDe(Padre, MedioHermano1),
    padreDe(Padre, MedioHermano2),
    MedioHermano1 \= MedioHermano2.

medioHermanos(MedioHermano1, MedioHermano2) :-
    madreDe(Madre, MedioHermano1),
    madreDe(Madre, MedioHermano2),
    MedioHermano1 \= MedioHermano2.

tioDe(Tio, Sobrino) :-
    hermanos(Tio, Madre),
    madreDe(Madre, Sobrino).

tioDe(Tio, Sobrino) :-
    hermanos(Tio, Padre),
    padreDe(Padre, Sobrino).

abueloMultiple(Personaje) :-
    padreDe(Personaje, Padre),
    padreDe(Padre, _),
    padreDe(Padre, _).

abueloMultiple(Personaje) :-
    madreDe(Personaje, Madre),
    madreDe(Madre, _),
    madreDe(Madre, _).

% Punto 2
descendiente(Descendiente, Ascendiente) :-
    padreDe(Ascendiente, Descendiente).

descendiente(Descendiente, Ascendiente) :-
    padreDe(Padre, Descendiente),
    descendiente(Padre,Ascendiente).
