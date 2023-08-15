% 1.
cree(gabriel, campanita).
cree(gabriel, magoDeOz).
cree(gabriel, cavenaghi).
cree(juan, conejoPascua).
cree(macarena, reyesMagos).
cree(macarena, magoCapria).
cree(macarena, campanita).

suenio(gabriel, loteria([5, 9])).
suenio(gabriel, futbolista(arsenal)).
suenio(juan, cantante(100000)).
suenio(macarena, cantante(10000)).

% 2.
ambiciosa(Persona) :-
    sumaDeDificultades(Persona, Suma),
    Suma > 20.

sumaDeDificultades(Persona, SumaTotal) :-
    suenio(Persona, _),
    findall(Dificultad, (suenio(Persona, Suenio), dificultad(Suenio, Dificultad)), Dificultades),
    sumlist(Dificultades, SumaTotal).

dificultad(loteria(Numeros), Dificultad) :-
    length(Numeros, Cantidad),
    Dificultad is 10 * Cantidad.

dificultad(futbolista(Equipo), 3) :-
    equipoChico(Equipo).

dificultad(futbolista(_), 16).

dificultad(cantante(Discos), 6) :-
    Discos > 500000.

dificultad(cantante(_), 4).

equipoChico(arsenal).
equipoChico(aldosivi).

% 3.
tieneQuimica(Persona, Personaje) :-
    cree(Persona, Personaje),
    requisitos(Persona, Personaje).

requisitos(Persona, campanita) :-
    suenio(Persona, Suenio),
    dificultad(Suenio, Dificultad),
    Dificultad < 5.

requisitos(Persona, _) :-
    not(ambiciosa(Persona)),
    forall(suenio(Persona, Suenio), esPuro(Suenio)).

esPuro(futbolista(_)).
esPuro(cantante(Discos)) :-
    Discos < 200000.

% 4.
amigo(campanita, reyesMagos).
amigo(campanita, conejoPascua).
amigo(conejoPascua, cavenaghi).

puedeAlegrar(Personaje, Persona) :-
    suenio(Persona, _),
    tieneQuimica(Persona, Personaje),
    noEnfermoDirectoIndirecto(Personaje).

noEnfermoDirectoIndirecto(Personaje) :-
    not(enfermo(Personaje)).

noEnfermoDirectoIndirecto(Personaje) :-
    amigo(Personaje, OtroPersonaje),
    noEnfermoDirectoIndirecto(OtroPersonaje).

enfermo(campanita).
enfermo(reyesMagos).
enfermo(conejoPascua).