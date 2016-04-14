-module(server).
-compile(export_all).


start() ->
	register(server, spawn(server, serverFun,  [[]])).

serverFun(Data) ->
	receive
		{nodedown, Node} ->
			io:format("deleting ~p~n", [Node]),
			serverFun(deleteNode(Node, Data));
		{From, {register, Name, Node, Pid}} ->
			io:format("registering: ~p - ~p - ~p~n", [Name, Node, Pid]),
			From ! {server, ok},
			serverFun(register(Name, Node, Pid, Data));
		{From, {who, Who}} ->
			From ! {server, search(Who, Data)},
			serverFun(Data);
		{From, showAll} ->
			io:format("~p~n", [Data]),
			From ! Data,
			serverFun(Data);
		{delete, Who} ->
			io:format("deleting ~p~n", [Who]),
			serverFun(delete(Who, Data));
		kill ->
			io:format("server stopping~n"),
			killed;
		Else ->
			io:format("something else~n"),
			io:format("~p~n", [Else]),
			serverFun(Data)
	end.

% Registers a process with name 'Name' in node 'Node' with process id 'Pid'
register(Name, Node, Pid, [{Name, _, _} | T]) ->
	[{Name, Node, Pid} | T];
register(Name, Node, Pid, [H | T]) ->
	[H | register(Name, Node, Pid, T)];
register(Name, Node, Pid, []) ->
	[{Name, Node, Pid}].

% Deletes a process named 'Name' from the array
delete(Name, [{Name, _, _} | T]) ->
	[T];
delete(Name, [H | T]) ->
	[H | delete(Name, T)];
delete(_, []) ->
	[].

% Deletes a 'Node' from the array
deleteNode(Node, [{_, Node, _} | T]) ->
	[T];
deleteNode(Node, [H | T]) ->
	[H | deleteNode(Node, T)];
deleteNode(_, []) ->
	[].

% Finds a process named 'Name' and returns its Node
search(Name, [{Name, Node, _} | _]) ->
	Node;
search(Name, [_ | T]) ->
	search(Name, T);
search(_, _) ->
	notFound.

% Finds a process named 'Name' and returns its process id
searchPid(Name, [{Name, _, Pid} | _]) ->
	Pid;
searchPid(Name, [_ | T]) ->
	searchPid(Name, T);
searchPid(_, _) ->
	notFound.


% $ erl -sname servidor
% > c(server).
% > server:start().

% To kill server:
% > server ! kill.