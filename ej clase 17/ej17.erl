-module(ej17).
-compile(export_all).


% 1. Process that accepts a message {hello, P}, where P is assumed to be a Pid. For each message, the process should send {reply, C} to P (where C is a count.)
% Test program:
test_hello() ->
	H = spawn(ej17, hello, []),
	test_hello(10, H).
test_hello(N, H) when N > 0 ->
	H ! {hello, self()},
	receive
		{reply, C} ->
			io:format("Received ~w~n", [C]),
			test_hello(N-1, H)
	end;
test_hello(_, _) -> io:format("My work is done~n").

hello() ->
	receive
		{hello, P} -> P ! {reply, 0}, hello(1)
	end.

hello(Count) ->
	receive
		{hello, P} -> P ! {reply, Count}, hello(Count+1)
	end.


% 2. Process that handles the following messages:
% • {plus, X, Y}​ compute the sum of X and Y
% • {mul, X, Y}​ compute the product of X and Y
% • {last, P}​​ send a message of the form {result, L} to process P. L should be the last value computed.
% • {sum, P}​​ send a message of the form {result, S} to process P. S should be the sum of all computed values.
% Write a test program like the one in the previous exercise to test your code.

% To use:
% > Pid = ej17:test_math().
% > Pid ! {message}.

test_math() -> spawn(ej17, math, [0, 0]).

math(Last, Sum) ->
	receive
		{plus, X, Y} ->
			io:format("~p + ", [X]),
			io:format("~p = ", [Y]),
			io:format("~p~n", [X+Y]),
			math(X+Y, Sum + X+Y);
		{mul, X, Y} ->
			io:format("~p * ", [X]),
			io:format("~p = ", [Y]),
			io:format("~p~n", [X*Y]),
			math(X*Y, Sum + X*Y);
		{last, P} ->
			P ! {result, Last},
			io:format("Last: ~p~n", [Last]),
			math(Last, Sum);
		{sum, P} ->
			P ! {result, Sum},
			io:format("Sum: ~p~n", [Sum]),
			math(Last, Sum);
		exit -> bye;
		Else -> io:format("Error: ~p~n", [Else]), math(Last, Sum)
	end.