-module(first).

-export([double/1,mult/2,area/3, square/1, triple/1, maxThree/3, howManyEqual/3]).



mult(X,Y) ->

    X*Y.



double(X) ->

    mult(2,X).



area(A,B,C) ->

    S = (A+B+C)/2,

    math:sqrt(S*(S-A)*(S-B)*(S-C)).

square(X) ->
	X * X.

triple(X) ->
	mult(3, X).

maxThree(A, B, C) ->
	max(max(A, B), C).

howManyEqual(A, B, C) ->
	Sum = count(A, B) + count(A, C) + count(B, C),
	case Sum of
		1 ->
			2;
		_ ->
			Sum
	end.

count(A, A) ->
	1;

count(_, _) ->
	0.

