personaje(pumkin,     ladron([licorerias, estacionesDeServicio])).
personaje(honeyBunny, ladron([licorerias, estacionesDeServicio])).
personaje(vincent,    mafioso(maton)).
personaje(jules,      mafioso(maton)).
personaje(marsellus,  mafioso(capo)).
personaje(winston,    mafioso(resuelveProblemas)).
personaje(mia,        actriz([foxForceFive])).
personaje(butch,      boxeador).

pareja(marsellus, mia).
pareja(pumkin,    honeyBunny).

%trabajaPara(Empleador, Empleado)
trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).

% 1.
esPeligroso(Personaje) :-
    realizaActividadPeligrosa(Personaje),
    tieneEmpleadosPeligrosos(Personaje).

realizaActividadPeligrosa(Personaje) :-
    personaje(Personaje, Actividad),
    actividadPeligrosa(Actividad).

tieneEmpleadosPeligrosos(Personaje) :-
    trabajaPara(Personaje, Empleado),
    personaje(Empleado, Actividad),
    actividadPeligrosa(Actividad).

actividadPeligrosa(mafioso(maton)).

actividadPeligrosa(ladron(DondeRoba)) :-
    member(licorerias, DondeRoba).

% 2.
amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedor).

duoTemible(Personaje, OtroPersonaje) :-
    esPeligroso(Personaje),
    esPeligroso(OtroPersonaje),
    parejaOAmigos(Personaje, OtroPersonaje).

parejaOAmigos(Personaje, OtroPersonaje) :-
    amigo(Personaje, OtroPersonaje).

parejaOAmigos(Personaje, OtroPersonaje) :-
    pareja(Personaje, OtroPersonaje).

% 3.
%encargo(Solicitante, Encargado, Tarea). 
%las tareas pueden ser cuidar(Protegido), ayudar(Ayudado), buscar(Buscado, Lugar)
encargo(marsellus, vincent,   cuidar(mia)).
encargo(vincent,  elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).

estaEnProblemas(butch).

estaEnProblemas(Personaje) :-
    trabajaPara(Jefe, Personaje),
    esPeligroso(Jefe),
    encargo(Jefe, Personaje, cuidar(Protegido)),
    pareja(Jefe, Protegido).

estaEnProblemas(Personaje) :-
    encargo(_, Personaje, buscar(Buscado, _)),
    personaje(Buscado, boxeador).

% 4.
sanCayetano(Personaje) :-
    personaje(Personaje, _),
    forall(tieneCerca(Personaje, Cercano), leDaTrabajo(Personaje, Cercano)).

tieneCerca(Personaje, Cercano) :-
    amigo(Personaje, Cercano).

tieneCerca(Personaje, Cercano) :-
    trabajaPara(Personaje, Cercano).

leDaTrabajo(Personaje, Cercano) :-
    encargo(Personaje, Cercano, _).

% 5.
masAtareado(MasAtareado) :-
    personaje(MasAtareado, _),
    cantidadEncargos(MasAtareado, MasEncargos),
    forall((personaje(MenosAtareado, _), cantidadEncargos(MenosAtareado, MenosEncargos)), MasEncargos >= MenosEncargos).

cantidadEncargos(Personaje, CantEncargos) :-
    findall(Encargo, encargo(_, Personaje, Encargo), Encargos),
    length(Encargos, CantEncargos).

% 6.
personajesRespetables(Personajes) :-
    findall(Personaje, esRespetable(Personaje), Personajes).

esRespetable(Personaje) :-
    personaje(Personaje, _),
    nivelRespeto(Personaje, Nivel),
    Nivel > 9.

nivelRespeto(Personaje, Nivel) :-
    personaje(Personaje, actriz(Peliculas)),
    length(Peliculas, CantPeliculas),
    Nivel is CantPeliculas * 0,1.

nivelRespeto(Personaje, 10) :-
    personaje(Personaje, mafioso(resuelveProblemas)).

nivelRespeto(Personaje, 1) :-
    personaje(Personaje, mafioso(maton)).

nivelRespeto(Personaje, 20) :-
    personaje(Personaje, mafioso(capo)).

% 7.
hartoDe(Personaje, OtroPersonaje) :-
    personaje(Personaje, _),
    personaje(OtroPersonaje, _),
    forall(encargo(_, Personaje, Encargo), interactua(Personaje, Encargo)).

interactua(Personaje, Encargo) :-
    eseOAmigo(Socorrido, EseOAmigo),
    participaDelEncargo(EseOAmigo, Encargo).

eseOAmigo(Socorrido, Socorrido).
eseOAmigo(Socorrido, Segundo) :-
    amigo(Socorrido, Segundo).

participaDelEncargo(Socorrido, cuidar(Socorrido)).
participaDelEncargo(Socorrido, buscar(Socorrido, _)).
participaDelEncargo(Socorrido, ayudar(Socorrido)).

