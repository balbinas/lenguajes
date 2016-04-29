%% Matricula 1 A00812215
%%Matricula 2 A01192241
%%Matricula 3 A01280156

%% 1. De forma similar a lo visto en clase, ilustra el árbol de búsqueda que se formará con el siguiente programa en Prolog al ejecutarlo para obtener todas las respuestas para el query: ?- p(Y).
%%WORD_DOC




%% 2. Programar el predicado secuencia en Prolog que despliegue la secuencia 1,2,…,N saltando de línea después de cada número.
secuencia(N) :- secuenciaAux(N, 1).

secuenciaAux(N, X) :-
	X =< N,
	write(X), nl,
	Xn is X + 1,
	secuenciaAux(N, Xn),
	fail.
secuenciaAux(_, _).


%% 3. Programar el predicado multiplos en Prolog que cuente la cantidad de múltiplos de N menores o iguales a M (incluyendo a N).
multiplos(_,0,0).
multiplos(N,D,M):-
   X is D mod N,
   Y is D - 1,
   multiplos(N,Y,W),
   (X=:=0 -> M is W+1; M is W).


%% 4. Programar el predicado digitos en Prolog que obtenga la cantidad de dígitos que tenga un número entero no negativo.
digitos(0,0).
digitos(N,D):-
   X is N // 10,
   digitos(X,W),
  D is W+1.