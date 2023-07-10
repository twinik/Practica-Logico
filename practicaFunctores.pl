/*
En un juego de "construya su cañería", hay piezas de distintos tipos: codos, caños y canillas.
De los codos me interesa el color, p.ej. un codo rojo.
De los caños me interesan color y longitud, p.ej. un caño rojo de 3 metros.
De las canillas me interesan: tipo (de la pieza que se gira para abrir/cerrar), color y ancho (de la boca).
P.ej. una canilla triangular roja de 4 cm de ancho.
1) Definir un predicado que relacione una cañería con su precio. Una cañería es una lista de piezas. Los precios son:
codos: $5.
caños: $3 el metro.
canillas: las triangulares $20, del resto $12 hasta 5 cm de ancho, $15 si son de más de 5 cm.
*/

% cañería(?Cañería, ?Precio)
cañería(Cañería, Precio) :-
    findall(PrecioPieza, (member(Pieza, Cañería), precioPieza(Pieza, PrecioPieza)), Precios),
    sum_list(Precios, Precio).

precioPieza(codo(_), 5).
precioPieza(caño(_, Longitud), Precio) :-
    Precio is Longitud * 3.
precioPieza(canilla(triangular, _, _), 20).
precioPieza(canilla(_, Ancho, _), Precio) :-
    Ancho =< 5,
    Precio is 12.
precioPieza(canilla(_, Ancho, _), Precio) :-
    Ancho > 5,
    Precio is 15.