puntajes(hernan,[3,5,8,6,9]).
puntajes(julio,[9,7,3,9,10,2]).
puntajes(ruben,[3,5,3,8,3]).
puntajes(roque,[7,10,10]).

% Punto 1
puntajeEnSalto(Competidor, Salto, Puntaje) :-
    puntajes(Competidor, Saltos),
    nth1(Salto, Saltos, Puntaje).

% Punto 2
estaDescalificado(Competidor) :-
    puntajes(Competidor, Saltos),
    length(Saltos, Cantidad),
    Cantidad > 5.

% Punto 3
clasificaFinal(Competidor) :-
    puntajes(Competidor, Saltos),
    sumlist(Saltos, Sum),
    Sum >= 28.
/* 
clasificaFinal(Competidor) :-
    %tiene dos saltos de 8 o mas
 */

