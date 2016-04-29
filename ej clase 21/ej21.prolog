%%Matricula 1 A00812215
%%Matricula 2 A01192241
%%Matricula 3 A01280156

%% 1. De forma similar a lo visto en clase, ilustra el árbol de búsqueda que se formará con el siguiente programa en Prolog al ejecutarlo para obtener todas las respuestas para los querys: (a) ?- a(Z).   (b) ?- a(2). (c) ?- a(4).

a(X) :- b(X).     % 
a(X) :- f(X).
b(X) :- g(X), !, v(X).
b(X) :- X = 4, v(X).
g(1).
g(2).
g(3).     
v(X).     
f(5). 
%%WORD_DOC




%% Programar el predicado xor en Prolog que implemente el or exclusivo, utilizando el cut.
Probar con:
?- xor(true,true).  => false
?- xor(true,false). => true

xor1(A,B) :- (A;B),(not(((A,B)))),!,write("true").
xor1(_,_) :- write("false").



%% 2. Programar el predicado hojas en Prolog que cuente las hojas de un árbol binario descrito con la función: árbol(Raíz, SubárbolIzquierdo, SubárbolDerecho).
Probar con:
?- hojas(arbol(8,arbol(5,arbol(2,nil,nil),arbol(7,nil,nil)),
   arbol(9, nil, arbol(15, arbol(11, nil, nil), nil))),H).  => H = 3

hojas(nil,0).
hojas(arbol(_,I,D), X) :-
     hojas(I,Rizq),
     hojas(D,Rder),
     X is 1 + Rizq + Rder.



%% 3. Programar el predicado busca en Prolog que busque un elemento, que debe pedirle al usuario, en un árbol binario y despliegue el nivel en el que se encuentra su nodo
Probar con:
?- busqueda(arbol(8,arbol(5,arbol(2,nil,nil),arbol(7,nil,nil)),
   arbol(9, nil, arbol(15, arbol(11, nil, nil), nil)))).  
Elemento? 2
Se encuentra en el nivel 3
?- busqueda(arbol(8,arbol(5,arbol(2,nil,nil),arbol(7,nil,nil)),
   arbol(9, nil, arbol(15, arbol(11, nil, nil), nil)))).  
Elemento? 1
No se encuentra en el árbol

busqueda(nil,0).
busqueda(arbol(_,I,D), X) :-
      busqueda(I,Rizq),
      busqueda(D,Rder),
      X is max(Rizq,Rder) + 1.