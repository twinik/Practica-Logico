mago(harry, mestiza, corajudo, slytherin).
mago(harry, mestiza, amistoso, slytherin).
mago(harry, mestiza, orgulloso, slytherin).
mago(harry, mestiza, inteligente, slytherin).
mago(draco, pura, orgulloso, hufflepuff).
mago(draco, pura, inteligente, hufflepuff).
mago(hermione, impura, inteligente, _).
mago(hermione, impura, orgulloso, _).
mago(hermione, impura, responsable, _).

caracteristica(gryffindor, corajudo).
caracteristica(slytherin, orgulloso).
caracteristica(slytherin, inteligente).
caracteristica(ravenclaw, inteligente).
caracteristica(ravenclaw, responsable).
caracteristica(hufflepuff, amistoso).

% Parte 1
% 1.
permiteEntrar(Casa, Mago) :-
    mago(Mago, Sangre, _, _),
    caracteristica(Casa, _),
    not(slytherinPermiteSangreImpura(Casa, Sangre)).

slytherinPermiteSangreImpura(slytherin, impura).

% 2.
tieneCaracterApropiado(Mago, Casa) :-
    mago(Mago, _, _, _),
    caracteristica(Casa, _),
    forall(caracteristica(Casa, Caracteristica), mago(Mago, _, Caracteristica, _)).

% 3.
casaPosible(hermione, gryffindor).

casaPosible(Mago, Casa) :-
    tieneCaracterApropiado(Mago, Casa),
    permiteEntrar(Casa, Mago),
    mago(Mago, _, _, CasaOdiariaEntrar),
    Casa \= CasaOdiariaEntrar.

% 4.
cadenaDeAmistades(Magos) :-
    todosAmistosos(Magos),
    cadenaDeCasas(Magos).

todosAmistosos(Magos) :-
    forall(member(Mago, Magos), mago(Mago, _, amistoso, _)).

cadenaDeCasas(Magos).

% SIN TERMINAR %

% Parte 2
accion(harry, fueraCama).
accion(hermione, tercerPiso).
accion(hermione, biblioteca).
accion(harry, bosque).
accion(harry, tercerPiso).
accion(draco, mazmorras).
accion(ron, ganarAjedrez).
accion(hermione, salvarAmigos).
accion(harry, ganarVoldemort).

puntos(fueraCama, -50).
puntos(bosque, -50).
puntos(biblioteca, -10).
puntos(tercerPiso, -75).
puntos(ganarAjedrez, 50).
puntos(salvarAmigos, 50).
puntos(ganarVoldemort, 60).

esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).

% 1.a
buenAlumno(Mago) :-
    accion(Mago, _),
    forall(accion(Mago, Accion), not(resta(Accion))).

resta(Accion) :-
    puntos(Accion, Puntos), 
    Puntos < 0.

resta(respuesta(_, Puntos, Profesor)) :-
    Puntos < 0.

% b
recurrente(Accion) :-
    accion(Mago, Accion),
    accion(OtroMago, Accion),
    Mago \= OtroMago.

% 2.
puntajeTotal(Casa, PuntajeTotal) :-
    esDe(_, Casa),
    findall(Puntos, puntosDeCadaMagoDeLaCasa(Casa, Puntos), ListaPuntos),
    sumlist(ListaPuntos, PuntajeTotal).

puntosDeCadaMagoDeLaCasa(Casa, Puntos) :-
    esDe(Mago, Casa), 
    accion(Mago, Accion), 
    puntos(Accion, Puntos).

puntosDeCadaMagoDeLaCasa(Casa, Puntos) :-
    esDe(Mago, Casa), 
    accion(Mago, respuesta(_, Puntos, Profesor)).

puntosDeCadaMagoDeLaCasa(Casa, Puntos) :-
    esDe(Mago, Casa), 
    accion(Mago, respuesta(_, PuntosRta, snape)),
    Puntos is PuntosRta / 2.

% 3.
casaGanadora(CasaGanadora) :-
    puntajeTotal(CasaGanadora, PuntajeTotal),
    forall(puntajeTotal(_, OtroPuntajeTotal), PuntajeTotal >= OtroPuntajeTotal).

% 4.
accion(hermione, respuesta(bezoar, 20, snape)).
accion(hermione, respuesta(levitarPluma, 25, flitwick)).