tarea(basico,buscar(libro,jartum)).
tarea(basico,buscar(arbol,patras)).
tarea(basico,buscar(roca,telaviv)).
tarea(intermedio,buscar(arbol,sofia)).
tarea(intermedio,buscar(arbol,bucarest)).
tarea(avanzado,buscar(perro,bari)).
tarea(avanzado,buscar(flor,belgrado)).
nivelActual(pepe,basico).
nivelActual(lucy,intermedio).
nivelActual(juancho,avanzado).
idioma(alejandria,arabe).
idioma(jartum,arabe).
idioma(patras,griego).
idioma(telaviv,hebreo).
idioma(sofia,bulgaro).
idioma(bari,italiano).
idioma(bucarest,rumano).
idioma(belgrado,serbio).
habla(pepe,bulgaro).
habla(pepe,griego).
habla(pepe,italiano).
habla(juancho,arabe).
habla(juancho,griego).
habla(juancho,hebreo).
habla(lucy,griego).
capital(pepe,1200).
capital(lucy,3000).
capital(juancho,500).

% Punto 1
destinoPosible(Persona, Ciudad) :-
    nivelActual(Persona, Nivel),
    tarea(Nivel, buscar(_,Ciudad)).

idiomaUtil(Nivel, Idioma) :-
    tarea(Nivel, buscar(_,Ciudad)),
    idioma(Ciudad, Idioma).

% Punto 2
excelenteCompaniero(P1, P2) :-
    nivelActual(P1, _),
    nivelActual(P2, _),
    forall(destinoPosible(P1, Ciudad), hablaDestinosPosibles(Ciudad, P2)).

hablaDestinosPosibles(Ciudad, P2) :-
    idioma(Ciudad, Idioma),
    habla(P2, Idioma).

% Punto 3
interesante(Nivel) :-
    tarea(Nivel,_),
    forall(tarea(Nivel, buscar(Cosa,_)), cosaViva(Cosa)).

interesante(Nivel) :-
    tarea(Nivel,_),
    idiomaUtil(Nivel, italiano).

cosaViva(arbol).
cosaViva(perro).
cosaViva(flor).

% Punto 4
complicado(Participante) :-
    nivelActual(Participante, _),
    forall(destinoPosible(Participante, Ciudad), not(hablaDestinosPosibles(Ciudad, Participante))).

complicado(Participante) :-
    not(nivelActual(Participante, basico)),
    capital(Participante, Capital),
    Capital < 1500.

complicado(Participante) :-
    nivelActual(Participante, basico),
    capital(Participante, Capital),
    Capital < 500.

% Punto 5
homogeneo(Nivel) :-
    tarea(Nivel, buscar(UnaCosa,_)),
    forall(tarea(Nivel, buscar(OtraCosa,_)), mismaCosa(UnaCosa, OtraCosa)).

mismaCosa(Cosa, Cosa).