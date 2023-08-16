animal(ginger, gallina(10, 5)).
animal(babs, gallina(15, 2)).
animal(bunty, gallina(23, 6)).
animal(mac, gallina(8, 7)).
animal(turuleca, gallina(15, 1)).
animal(rocky, gallo(animalDeCirco)).
animal(fowler, gallo(piloto)).
animal(oro, gallo(arrocero)).
animal(nick, rata).
animal(fetcher, rata).

granja(tweedys, [ginger, babs, bunty, mac, fowler]).
granja(delSol, [turuleca, oro, nick, fetcher]).

% 1.
puedeCederle(UnaGallina, OtraGallina) :-
    animal(UnaGallina, gallina(_, 7)),
    animal(OtraGallina, gallina(_, OtrosHuevos)),
    OtrosHuevos < 3.

% 2.
animalLibre(Animal) :-
    animal(Animal, _),
    granja(_, Animales),
    not(member(Animal, Animales)).

% 3.
valoracionDeGranja(Granja, Valoracion) :-
    granja(Granja, Animales),
    findall(ValAnimal, (member(Animal, Animales), valoracionAnimal(Animal, ValAnimal)), Valoraciones),
    sumlist(Valoraciones, Valoracion).

valoracionAnimal(Animal, Valoracion):-
    animal(Animal, Especie),
    valoracionDeEspecie(Especie, Valoracion).

valoracionDeEspecie(gallina(Peso, CantidadDeHuevos), Valoracion):-
    Valoracion is Peso * CantidadDeHuevos.

valoracionDeEspecie(gallo(piloto), 50).
valoracionDeEspecie(gallo(animalDeCirco), 50).
valoracionDeEspecie(gallo(_), 25).
valoracionDeEspecie(rata, 0).

% 4.
granjaDeluxe(Granja) :-
    granja(Granja, Animales),
    not(member(rata, Animales)),
    muchosAnimalesOMilDeValoracion(Granja, Animales).

muchosAnimalesOMilDeValoracion(_, Animales) :-
    length(Animales, Cantidad),
    Cantidad > 50.

muchosAnimalesOMilDeValoracion(Granja, _) :-
    valoracionDeGranja(Granja, 1000).

% 5.
buenaPareja(UnAnimal, OtroAnimal) :-
    vivenEnMismaGranja(UnAnimal, OtroAnimal),
    requisitosBuenaPareja(UnAnimal, OtroAnimal),
    UnAnimal \= OtroAnimal.

vivenEnMismaGranja(UnAnimal, OtroAnimal) :-
    granja(_, Animales),
    member(UnAnimal, Animales),
    member(OtroAnimal, Animales).

requisitosBuenaPareja(Rata1, Rata2) :-
    animal(Rata1, rata),
    animal(Rata2, rata).

requisitosBuenaPareja(Gallina1, Gallina2) :-
    animal(Gallina1, gallina(Peso, _)),
    animal(Gallina2, gallina(Peso, _)),
    puedeCederle(Gallina1, Gallina2).

requisitosBuenaPareja(Gallo1, Gallo2) :-
    animal(Gallo1, gallo(_)),
    animal(Gallo2, gallo(_)),
    unoSoloVuela(Gallo1, Gallo2).

unoSoloVuela(Gallo1, Gallo2) :-
    sabeVolar(Gallo1),
    not(sabeVolar(Gallo2)).

unoSoloVuela(Gallo1, Gallo2) :-
    sabeVolar(Gallo2),
    not(sabeVolar(Gallo1)).

sabeVolar(Gallo) :-
    animal(Gallo, gallo(piloto)).

sabeVolar(Gallo) :-
    animal(Gallo, gallo(animalDeCirco)).

% 6.
escapePerfecto(Granja) :-
    granja(Granja, Animales),
    todosEscapan(Animales),
    todosBuenaPareja(Animales).

todosEscapan(Animales) :-
    forall(member(Animal, Animales), poneMasDe5Huevos(Animal)).

poneMasDe5Huevos(Animal) :-
    animal(Animal, gallina(_, Huevos)),
    Huevos > 5.

todosBuenaPareja(Animales) :-
    forall(member(UnAnimal, Animales), (member(OtroAnimal, Animales), buenaPareja(UnAnimal, OtroAnimal))).