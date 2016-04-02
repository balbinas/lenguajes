-module(ej16).% file name
-export([formula_general/3, secuencia/1, mapea/2, menores/2]).

% 1. Función formula_general que resuelve ecuaciones cuadráticas de tipo ax^2 + bx + c = 0, a partir de sus coeficientes.
% quadratic equation = (-b ± sqrt(b^2-4ac)) / 2a
% ej16:formula_general(1, -5, 6).​=> {3.0,2.0}
% ej16:formula_general(3, 2, 2).​​=> imaginarias
formula_general(A, B, C) ->
	if
		B*B - 4*A*C < 0 -> imaginarias;
		true -> {(((-B) + math:sqrt(B*B - 4*A*C)) / 2*A), (((-B) - math:sqrt(B*B - 4*A*C)) / 2*A)}
	end.


% 2. Función secuencia que crea una lista con los números naturales del 1 a N.
% ej16:secuencia(0).​​=> []
% ej16:secuencia(5).​​=> [1,2,3,4,5]
secuencia(N) -> secuenciaAux(N, []).

secuenciaAux(N, L) ->
	if
		N == 0 -> L;
		true -> secuenciaAux(N-1, [N | L])
	end.


% 3. Función de orden superior mapea que trabaja igual que la FOS lists:map (sin utilizarla).
% ej16:mapea(fun math:sqrt/1, [1,4,9]).​​=> [1.0,2.0,3.0]
% ej16:mapea(fun(X) -> X*X end, [1,2,3]).​​=> [1,4,9]
mapea(Func, [X | Rest]) -> [Func(X) | mapea(Func, Rest)];
mapea(_, []) -> [].


% 4. Función menores que sin utilizar recursividad explícita regresa todos los elementos de una lista de sublistas que sean menores que su segundo argumento.
% ej16:menores([[1, 2, 3], [4, 5, 6]], 4). => [[1,2,3],[]]
% ej16:menores([[2,-3],[-1,2],[5,2]], 1). ​​=> [[-3],[-1],[]]
menores([List | Rest], N) -> menoresAux(Rest, N, smaller(List, N, [])).

menoresAux([List | Rest], N, R) -> menoresAux(Rest, N, lists:append(R, smaller(List, N, [])));
menoresAux([], _, R) -> R.

smaller([X | Rest], N, R) ->
	if
		X == [] -> [R];
		X < N -> smaller(Rest, N, lists:append(R, [X]));
		true -> smaller(Rest, N, R)
	end;
smaller([], _, R) -> [R].