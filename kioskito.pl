atiende(dodain, lunes, 9, 15).
atiende(dodain, miercoles, 9,15).
atiende(dodain, viernes, 9,15).
atiende(lucas, martes, 10,20).
atiende(juanC, sabados, 18,22).
atiende(juanC, domingos, 18,22).
atiende(juanFdS, jueves, 10,20).
atiende(juanFdS, viernes, 12,20).
atiende(leoC, lunes, 14,18).
atiende(leoC, miercoles, 14,18).
atiende(martu, miercoles, 23,24).

% Punto 1
atiende(vale, Dia, HoraInicio, HoraFinal) :-
    atiende(dodain, Dia, HoraInicio, HoraFinal).

atiende(vale, Dia, HoraInicio, HoraFinal) :-
    atiende(juanC, Dia, HoraInicio, HoraFinal).

% En los otros dos puntos no es nesecario hacer nada, ya que 
% esta relacionado el concepto teorico de principio de universo cerrado, 
% ya que si algo es desconocido, se presume falso.

% Punto 2
quienAtiende(Dia, Hora, Quien) :-
    atiende(Quien, Dia, HoraInicio, HoraFinal), 
    estaEnRango(Hora, HoraInicio, HoraFinal).
    
estaEnRango(Hora, HoraInicio, HoraFinal) :-
    Hora - HoraInicio >= 0,
    Hora - HoraFinal =< 0.

% Punto 3
estaForeverAlone(Persona, Dia, Hora) :-
    quienAtiende(Dia, Hora, Persona),
    not((quienAtiende(Dia, Hora, OtraPersona), Persona \= OtraPersona)).

% Punto 4
posibilidadesDeAtencion(Dia, Quien) :-
    atiende(Quien, Dia, _, _).

% Punto 5
venta(dodain, 10, [golosinas(1200), cigarrilos([jockey]), golosinas(50)]).
venta(dodain, 12, [bebida(alcoholica, 8), bebida(noAlcoholica, 1), golosinas(10)]).
venta(martu, 12, [golosinas(1000), cigarrilos([chesterfield, colorado, parisiennes])]).
venta(lucas, 11, [golosinas(600)]).
venta(lucas, 18, [bebida(noAlcoholica, 2), cigarrilos([derby])]).

suertuda(Persona) :-
    venta(Persona, _, _),
    forall(venta(Persona, _, [PrimeraVenta|_]), ventaImportante(PrimeraVenta)).

ventaImportante(golosinas(Plata)) :-
    Plata > 100.

ventaImportante(cigarrilos(Marcas)) :-
    length(Marcas, CantidadMarcas),
    CantidadMarcas > 2.

ventaImportante(bebida(Tipo, _)) :-
    Tipo = alcoholica.

ventaImportante(bebida(_, Cantidad)) :-
    Cantidad > 5.