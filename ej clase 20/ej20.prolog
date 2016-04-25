%% 1. De forma similar a lo visto en clase, ilustra el árbol de búsqueda que se formará con el siguiente programa en Prolog al ejecutarlo para obtener todas las respuestas para el query: ?- p(Y).





%% 2. Programar el predicado secuencia en Prolog que despliegue la secuencia 1,2,…,N saltando de línea después de cada número.
secuencia(N) :- secuenciaAux(N, 1).

secuenciaAux(N, X) :-
	X =< N,
	write(X), nl,
	Xn is X + 1,
	secuenciaAux(N, Xn),
	fail.
secuenciaAux(_, _).


%% not working
%% 3. Programar el predicado multiplos en Prolog que cuente la cantidad de múltiplos de N menores o iguales a M (incluyendo a N).
/*?- multiplos(2,10,5).​=> true
  ?- multiplos(3,30,X).​=> X = 10*/
multiplos(N, M, X) :- multiplosAux(N, M, X, 1).

multiplosAux(N, M, X, R) :-
	M >= N,
	Mm is M-N,
	Rr is R+1,
	multiplosAux(N, Mm, X, Rr),
	X is Rr.



%% not working
%% 4. Programar el predicado digitos en Prolog que obtenga la cantidad de dígitos que tenga un número entero no negativo.
/*?- digitos(7,1).​​=> true
?- digitos(1234,D).​=> D = 4*/
digitos(X, D) :-
	X / 10 > 0,
	Xx is X/10,
	Dd is D+1,
	digitos(Xx, Dd),
	D is Dd.
digitos(_, D) :- D.

m(X, Y) :- X is Y mod 10.
/*var x = 1
var y = 1000.0
while (floor(y/10) > 0) {
	y = (y / 10)
	x += 1
}
print(x)*/