herramientasRequeridas(ordenarCuarto, [aspiradora(100), trapeador, plumero]).
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordedadora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustradpesora, cera, aspiradora(300)]).

% 1.
tiene(egon, aspiradora(200)).
tiene(egon, trapeador).
tiene(peter, trapeador).
tiene(winston, varitaNeutrones).

% 2.
satisfaceNecesidad(Persona, Herramienta) :-
    tiene(Persona, Herramienta).

satisfaceNecesidad(Persona, aspiradora(PotenciaMin)) :-
    tiene(Persona, aspiradora(Potencia)),
    Potencia >= PotenciaMin.

% 3.
puedeRealizar(Persona, Tarea) :-
    herramientasRequeridas(Tarea, _),
    tiene(Persona, varitaNeutrones).

puedeRealizar(Persona, Tarea) :-
    tiene(Persona, _),
    herramientasRequeridas(Tarea, Herramientas), 
    forall(member(Herramienta, Herramientas), satisfaceNecesidad(Persona, Herramienta)).
    
% 4.
tareaPedida(cliente, tarea, 1000).
precio(tarea, 20).

cobro(Cliente, PrecioTotal) :-
    tareaPedida(Cliente, _, _),
    findall(Valor, valorTarea(Cliente, Valor), Valores),
    sumlist(Valores, PrecioTotal).

valorTarea(Cliente, Valor) :-
    tareaPedida(Cliente, Tarea, MetrosCuadrados),
    precio(Tarea, Precio),
    Valor is Precio * MetrosCuadrados.

% 5.
aceptaPedido(Persona, Cliente) :-
    tiene(Persona, _),
    tareaPedida(Cliente, _, _),
    puedeHacerPedido(Persona, Cliente),
    dispuesto(Persona, Cliente).

puedeHacerPedido(Persona, Cliente) :-
    forall(tareaPedida(Cliente, Tarea, _), puedeRealizar(Persona, Tarea)).

dispuesto(ray, Cliente) :-
    not(tareaPedida(Cliente, limpiarTecho, _)).

dispuesto(winston, Cliente) :-
    cobro(Cliente, Valor),
    Valor > 500.

dispuesto(egon, Cliente) :-
    not(tareaPedida(Cliente, Tarea, _), tareaCompleja(Tarea)).

dispuesto(peter, _).

tareaCompleja(limpiarTecho).

tareaCompleja(Tarea) :-
    herramientasRequeridas(Tarea, Herramientas),
    length(Herramientas, Cantidad),
    Cantidad > 2.

% 6.

    


    
    

    