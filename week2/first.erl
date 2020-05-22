-module(first).
-export([fib/1, pieces/1, perfect/1]).

fib(N) ->
	fib(N, 0, 1).

fib(0, A, _B) ->
	A;

fib(N, A, B) ->
	fib(N -1 , B, A + B).

% N straight line cuts
% 1 -> 2
% 2 -> 4
% 3 -> 7
pieces(1) ->
	2;

pieces(N) ->
	pieces(N - 1) + N.

perfect(N) ->
	perfect(N, N div 2, 0).

perfect(N, 1, Sum) ->
	N == (Sum + 1);

perfect(N, Div, Sum) when N rem Div == 0 ->
	perfect(N, Div - 1, Sum + Div);

perfect(N, Div, Sum) ->
	perfect(N, Div - 1, Sum).
	
