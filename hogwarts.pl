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
    