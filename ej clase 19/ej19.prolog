parent(tarciscio, manuel).
parent(elisa, manuel).

parent(tarciscio, mauricio).
parent(elisa, mauricio).

parent(tarciscio, mario).
parent(elisa, mario).

parent(tarciscio, elena).
parent(elisa, elena).



parent(francisco, gabriela).
parent(zulema, gabriela).

parent(francisco, adriana).
parent(zulema, adriana).

parent(francisco, marcela).
parent(zulema, marcela).



parent(manuel, manolo).
parent(gabriela, manolo).

parent(manuel, gaby).
parent(gabriela, gaby).



parent(mario, inigo).
parent(blanca, inigo).



parent(angel, herminio).
parent(elena, herminio).

parent(angel, claudia).
parent(elena, claudia).



parent(jesus, alejandra).
parent(adriana, alejandra).

parent(jesus, gonzalo).
parent(adriana, gonzalo).


parent(andres, daniel).
parent(marcela, daniel).




child(X, Y) :- parent(Y, X).

sibling(X, Y) :- parent(A, X), parent(A, Y).

grandparent(X, Y) :- parent(X, A), parent(A, Y).

grandchild(X, Y) :- grandparent(Y, X).

uncle(X, Y) :- parent(A, Y), sibling(A, X).

niece(X, Y) :- uncle(Y, X).

cousin(X, Y) :- parent(A, X), parent(B, Y), sibling(A, B).




/*
 * Results:
 * sibling(manolo, X).
 * X = manolo ;
 * X = gaby ;
 * X = manolo ;
 * X = gaby.

 * sibling(daniel, X).
 * X = daniel ;
 * X = daniel.

 * grandparent(X, manolo).
 * X = tarciscio ;
 * X = elisa ;
 * X = francisco ;
 * X = zulema ;
 * false.

 * cousin(X, manolo).
 * X = manolo ;
 * X = manolo ;
 * X = manolo ;
 * X = manolo ;
 * X = gaby ;
 * X = gaby ;
 * X = gaby ;
 * X = gaby ;
 * X = inigo ;
 * X = inigo ;
 * X = herminio ;
 * X = herminio ;
 * X = claudia ;
 * X = claudia ;
 * X = alejandra ;
 * X = alejandra ;
 * X = gonzalo ;
 * X = gonzalo ;
 * X = daniel ;
 * X = daniel.
 */