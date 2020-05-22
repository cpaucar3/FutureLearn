-module(second).
-export([hypSize/2, perimeter/2, area/2]).

hypSize(A, B) ->
	A2 = first:square(A),
	B2 = first:square(B),
	math:sqrt(A2 + B2).

perimeter(A, B) ->
	C = hypSize(A, B),
	A + B + C.

area(A, B) ->
	A * B / 2.
