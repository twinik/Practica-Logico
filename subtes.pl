linea(a,[plazaMayo,peru,lima,congreso,miserere,rioJaneiro,primeraJunta,nazca]).
linea(b,[alem,pellegrini,callao,pueyrredonB,gardel,medrano,malabia,lacroze,losIncas,urquiza]).
linea(c,[retiro,diagNorte,avMayo,independenciaC,plazaC]).
linea(d,[catedral,nueveJulio,medicina,pueyrredonD,plazaItalia,carranza,congresoTucuman]).
linea(e,[bolivar,independenciaE,pichincha,jujuy,boedo,varela,virreyes]).
linea(h,[lasHeras,santaFe,corrientes,once,venezuela,humberto1ro,inclan,caseros]).
combinacion([lima, avMayo]).
combinacion([once, miserere]).
combinacion([pellegrini, diagNorte, nueveJulio]).
combinacion([independenciaC, independenciaE]).
combinacion([jujuy, humberto1ro]).
combinacion([santaFe, pueyrredonD]).
combinacion([corrientes, pueyrredonB]).

% Punto 1
estaEn(Linea, Estacion) :-
    linea(Linea,Estaciones),
    member(Estacion, Estaciones).

% Punto 2
distancia(Estacion1, Estacion2, Distancia) :-
    estanEnMismaLinea(Estacion1, Estacion2),
    estaEn(Linea, Estacion1),
    linea(Linea, Estaciones),
    nth1(Pos1, Estaciones, Estacion1),
    nth1(Pos2, Estaciones, Estacion2),
    Distancia is abs(Pos2 - Pos1).

estanEnMismaLinea(Estacion1, Estacion2) :-
    estaEn(Linea1, Estacion1),
    estaEn(Linea2, Estacion2),
    mismaLinea(Linea1, Linea2).

mismaLinea(Linea, Linea).

% Punto 3
mismaAltura(Estacion1, Estacion2) :-
    not(estanEnMismaLinea(Estacion1, Estacion2)),
    estaEn(Linea1, Estacion1),
    estaEn(Linea2, Estacion2),
    linea(Linea1, Estaciones1),
    linea(Linea2, Estaciones2),
    nth1(Pos1, Estaciones1, Estacion1),
    nth1(Pos2, Estaciones2, Estacion2),
    mismaPos(Pos1, Pos2).

mismaPos(Pos, Pos).

% Punto 4
viajeFacil(Estacion1, Estacion2) :-
    estanEnMismaLinea(Estacion1, Estacion2).

viajeFacil(Estacion1, Estacion2) :-
    combinacion([Estacion1, Estacion2]).
