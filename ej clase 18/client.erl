-module(client).
-compile(export_all).


serverName() ->
	'servidor@manolos-MacBook-Pro'.

start(Name) ->
	{server, serverName()} ! {self(), {register, Name, node(), self()}},
	register(client, spawn(client, clientFun,  [Name])).

clientFun(Name) ->
	monitor_node(serverName(), true),
	receive
		{nodedown, Node} ->
			io:format("~p died.~n", [Node]),
			no;
		{who, Who} ->
			{server, serverName()} ! {self(), {who, Who}},
			waitForResponse(),
			clientFun(Name);
		showAll ->
			{server, serverName()} ! {self(), showAll},
			waitForResponse(),
			clientFun(Name);
		kill ->
			{server, serverName()} ! {delete, Name},
			io:format("~p stopping~n", [Name]),
			killed;
		Else ->
			io:format("undefined: ~p~n", [Else]),
			clientFun(Name)
		after 5000 ->
			io:format("~p still alive.~n", [Name]),
			clientFun(Name)
	end.

waitForResponse() ->
	receive
		Response ->
		io:format("response: ~p~n", [Response])
	end.

% $ erl -sname cliente
% > c(client).
% > client:start(nombre).

% To kill client:
% > client ! kill.

% Get the Node of a 'Name':
% > client ! {who, 'Name'}.

% Show all nodes:
% > client ! showAll.