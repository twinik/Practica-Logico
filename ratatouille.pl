rata(remy, gusteaus).
rata(emile, malabar).
rata(django, jeSuis).

persona(linguini, [plato(ratatouille, 3), plato(sopa, 5)]).
persona(colette, [plato(salmonAsado, 9)]).
persona(horst, [plato(ensaladaRusa, 8)]).

trabajaEn(linguini, gusteaus).
trabajaEn(colette, gusteaus).
trabajaEn(horst, gusteaus).
trabajaEn(amelie, cafeDes2Moulins).

% Punto 1
inspeccionSatisfactoria(Restaurante) :-
    trabajaEn(_,Restaurante),
    forall(rata(_, DondeVive), not(mismoRestaurante(DondeVive, Restaurante))).
    
mismoRestaurante(R,R).

% Punto 2
chef(Empleado, Restaurante) :-
    trabajaEn(Empleado, Restaurante),
    persona(Empleado, Platos),
    length(Platos, Cantidad),
    Cantidad > 0.

% Punto 3
chefcito(Rata) :-
    rata(Rata, RestoRata),
    trabajaEn(linguini, RestoLinguini),
    mismoRestaurante(RestoRata, RestoLinguini).

% Punto 4
cocinaBien(Persona, Plato) :-
    persona(Persona, Platos),
    member(plato(Plato, Experiencia), Platos),
    Experiencia > 7.

cocinaBien(Persona, _) :-
    mismoNombre(Persona, remy).

mismoNombre(N,N).

% Punto 5
encargadoDe(Restaurante, Plato, Encargado) :-
    trabajaEn(Encargado, Restaurante),
    persona(Encargado, EncargadoPlatos),
    member(plato(Plato, ExpEncargado), EncargadoPlatos),
    forall(persona(_, [plato(Plato, Experiencia)]), ExpEncargado >= Experiencia).

% Punto 6
plato(ensaladaRusa, entrada([papa, zanahoria, arvejas, huevo, mayonesa])).
plato(bifeDeChorizo, principal(pure, 25)).
plato(frutillasConCrema, postre(265)).

saludable(Plato) :-
    calorias(Plato, CantCalorias),
    CantCalorias < 75.

calorias(Plato, CantCalorias) :-
    plato(Plato, entrada(Ingredientes)),
    length(Ingredientes, CantIngredientes),
    CantCalorias is CantIngredientes * 15.

calorias(Plato, CantCalorias) :-
    plato(Plato, principal(Guarnicion, Minutos)),
    caloriasGuarnicion(Guarnicion, CaloriasGuarnicion),
    CantCalorias is CaloriasGuarnicion + 5 * Minutos.

calorias(Plato, CantCalorias) :-
    plato(Plato, postre(CantCalorias)).

caloriasGuarnicion(papasFritas, 50).
caloriasGuarnicion(pure, 20).
caloriasGuarnicion(ensalada, 0).

% Punto 7
criticaPositiva(Restaurante, antonEgo) :-
    inspeccionSatisfactoria(Restaurante),
    esEspecialista(Restaurante, ratatouille).

criticaPositiva(Restaurante, christophe) :-
    inspeccionSatisfactoria(Restaurante),
    masDe3Empleados(Restaurante).

criticaPositiva(Restaurante, cormillot) :-
    inspeccionSatisfactoria(Restaurante),
    platosSaludablesConZanahoria(Restaurante).

not(criticaPositiva(_, gordonRamsay)).
    

esEspecialista(Restaurante, Plato) :-
    trabajaEn(_, Restaurante),
    forall(trabajaEn(Empleado, Restaurante), cocinaBien(Empleado, Plato)).

masDe3Empleados(Restaurante) :-
    findall(Empleado, trabajaEn(Empleado, Restaurante), Empleados),
    length(Empleados, CantEmpleados),
    CantEmpleados > 3.
    
/* platosSaludablesConZanahoria(Restaurante) :-
    trabajaEn(_, Restaurante),
    findall(Empleado, trabajaEn(Empleado, Restaurante), Empleados),
    findall(Platos, member(persona(Empleado, Platos), Empleados), PlatosRestaurante),
    forall(PlatosRestaurante, saludable(Plato)). */
    
    