%%Matricula 1 A00812215
%%Matricula 2 A01192241
%%Matricula 3 A01280156

%%1. Determinar si dos enteros mayores que 1 son primos relativos. Dos enteros son primos relativos si su unico divisor comun es el 1. Un divisor de un entero es un entero positivo que lo divide exactamente.
primos_relativos(X, Y) :-
    gcd(X, Y) =:= 1.


%%2. Encontrar un inverso de un entero n modulo m. Un inverso es un entero en el rango 1 <= x < m, tal que el residuo de dividir x veces n por m sea igual a 1. Puede que el inverso no exista o que haya varios.
inverso(N, M, X) :-
	X >= 1, X < M, ((X*N) mod M) =:= 1.

%%3. Modifica una lista de enteros repitiendo cada entero su numero de veces. 
repite(L, N, X) :-
    length(X, N),
    maplist(=(L), X).


%%4. Cuenta valores repetidos contiguos en una lista plana.
adyacentes([], []).
adyacentes([X|Y], [X|Z]) :- subtract(Y, [X], W), adyacentes(W, Z).


%%5. Decodificar la longitud de las corridas de una lista. Para esto, los terminos codificados [N,E] se decodifican como una secuencia de N copias del elemento E. 
decodifica([], []).
decodifica([[1,N]|E], [N|X]) :- decodifica(E,X).
decodifica([[N,N]|E], [N|X]) :-
        M is N-1,
        decodifica([[M,N]|E], X), !.
decodifica([N|E], [N|X]) :- decodifica(E, X).


%%6. Intercambiar 2 columnas de una matriz representada como lista de renglones. Asumir que las columnas especificadas existen y son distintas. 
intercambia([[]|_], []).
intercambia(M, [X|T]) :- row(M, X, M1), 
                       intercambia(M1, T).
renglon([], [], []).
renglon([[X|Xs]|Ys], [X|R], [Xs|Z]) :- renglon(Ys, R, Z).


%%7. Obtener una lista con los elementos de la diagonal de una matriz cuadrada. 
diagonal(M,N,L1,L1,N):-write(L1).
diagonal(M,N,L2,L,Ind):-find_n(Ind,M,E1),find_n(Ind,E1,E2),merge2(E2,L,L1),Ind2
is Ind+1,diagonal(M,N,L2,L1,Ind2).


%%8. Determinar si un termino dado representa un arbol binario de busqueda.
%% Representaremos un arbol binario de busqueda vacio con el atomo nil y un arbol no vacio con el termino a(R,I,D), donde R denota al nodo raiz e I y D denotan los subarboles izquierdo y derecho, respectivamente.
%% De esa forma T1 = nil representa a un arbol binario vacio, T2 = a(r,nil,nil) representa un arbol que consiste solo del nodo raiz que es un nodo hoja, y T3 = a(n1,a(n2,nil,nil),a(n3,nil,nil)) es un arbol que consiste de 3 nodos: n1 que es su raiz, n2 que es la raiz de su subarbol izquierdo y n3 que es la raiz de su subarbol derecho (n2 y n3 son nodos hoja).
%% Un arbol binario de busqueda es un arbol donde el valor de su raiz es mayor o igual que todos los valores de los nodos de su subarbol izquierdo y menor que todos los valores de su subarbol derecho. Los subarboles tambien son arboles binarios de busqueda. 



%%9. Obtener una lista con el valor de los nodos de un arbol binario de busqueda que caigan en un rango correctamente especificado (el primer numero define el limite inferior y el segundo el superior). 



%%10. Determinar si un arbol binario esta completamente balanceado. Definimos un arbol binario completamente balanceado como un arbol donde todas sus hojas estan en su ultimo nivel y donde su subarbol izquierdo tiene uno nodo mas o un nodo menos que su subarbol derecho. 
