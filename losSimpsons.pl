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
tieneHijo(unPersonaje) :-
    padreDe(unPersonaje,_).

tieneHijo(unPersonaje) :-
    madreDe(unPersonaje,_).

hermanos(unPersonaje, otroPersonaje) :-
    padreDe(Padre, unPersonaje),
    padreDe(Padre, otroPersonaje),
    madreDe(Madre, unPersonaje),
    madreDe(Madre, otroPersonaje),
    unPersonaje \= otroPersonaje.

medioHermanos(unPersonaje, otroPersonaje) :-
    padreDe(Padre, unPersonaje),
    padreDe(Padre, otroPersonaje),
    unPersonaje \= otroPersonaje.

medioHermanos(unPersonaje, otroPersonaje) :-
    madreDe(Madre, unPersonaje),
    madreDe(Madre, otroPersonaje),
    unPersonaje \= otroPersonaje.

tioDe(unPersonaje, otroPersonaje) :-
    hermanos(unPersonaje, Madre),
    madreDe(Madre, otroPersonaje).

abueloMultiple(unPersonaje) :-
    




