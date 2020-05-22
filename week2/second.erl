-module(second).
-export([perimeter/1, area/1, enclose/1, bits/1, test_all/0, take/2, test_take/0]).

-define(PI, 3.14159).

perimeter({circle, Radius}) ->
	2 * ?PI * Radius;

perimeter({triangle, A, B, C}) ->
	A + B + C;

perimeter({square, A}) ->
	4 * A;

perimeter({rectangle, L, W}) ->
	2 * (L + W).

area({circle, Radius}) ->
	?PI * Radius * Radius;

% Heron's formula
area({triangle, A, B, C} = Args) ->
	S = perimeter(Args) / 2,
	math:sqrt(S * (S - A) * (S - B) * (S - C));

area({square, A}) ->
	A * A;

area({rectangle, L, W}) ->
	L * W.

enclose({circle, Radius}) ->
	{Radius, Radius};

% TODO Minimum area of rectangle is twice that of the triangle
enclose({triangle, A, B, _C}) ->
	{A, B};

enclose({square, A}) ->
	{A, A};

enclose({rectangle, L, W}) ->
	{L, W}.

bits(N) ->
	bits(io_lib:format("~.2B", [N]), 0).

bits([], Sum) ->
	Sum;

% ASCII 48 is "0"
bits([48 | Rest], Sum) ->
	bits(Rest, Sum);

% ASCII 49 is "1"
bits([49 | Rest], Sum) ->
	bits(Rest, Sum + 1).

test_all() ->
	Circle = {circle, 2},
	Triangle = {triangle, 3, 4, 5},
	Square = {square, 3},
	Rectangle = {rectangle, 3, 4},

	12.56636 = perimeter(Circle),
	12 = perimeter(Triangle),
	12 = perimeter(Square),
	14 = perimeter(Rectangle),

	12.56636 = area(Circle),
	6.0 = area(Triangle),
	9 = area(Square),
	12 = area(Rectangle),

	% skip testing enclose/1

	3 = bits(7),
	1 = bits(8),

	io:format("passed\n").

take(0, _List) ->
	[];

take(N, List) ->
	case length(List) < N of
		true ->
			List;
		_ ->
			lists:sublist(List, N)
	end.

test_take() ->
	Hello = "hello",
	[] = take(0, Hello),
	"hell" = take(4, Hello),
	"hello" = take(5, Hello),
	"hello" = take(9, Hello),
	io:format("passed\n").

