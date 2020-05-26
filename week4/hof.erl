-module(hof).
-export([doubleAll/1, evens/1, product/1, zipA/2, zip_withB/3, zip_withC/3, zipD/2]).

doubleAll(List) ->
	lists:map(fun(Elem) ->
					  Elem * 2
			  end, List).

evens(List) ->
	lists:filter(fun(Elem) ->
						 case Elem rem 2 of
							 0 ->
								 true;
							 1 ->
								 false
						 end
				 end, List).

product(List) ->
	lists:foldr(fun(Elem, Prd) -> 
						Prd * Elem
				end, 1, List).

zipA(L1, L2) ->
	case length(L1) of
		L1Len when L1Len < length(L2) ->
			lists:zip(L1, lists:sublist(L2, L1Len));
		_ ->
			lists:zip(lists:sublist(L1, length(L2)), L2)
	end.

zip_withB(F, L1, L2) ->
	case length(L1) of
		L1Len when L1Len < length(L2) ->
			lists:zipwith(F, L1, lists:sublist(L2, L1Len));
		_ ->
			lists:zipwith(F, lists:sublist(L1, length(L2)), L2)
	end.

zip_withC(F, L1, L2) ->
	lists:map(fun({X, Y}) -> F(X, Y) end, zipA(L1, L2)).

zipD(L1, L2) ->
	zip_withC(fun(X, Y) -> {X, Y} end, L1, L2).

