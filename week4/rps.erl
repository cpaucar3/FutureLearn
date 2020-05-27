-module(rps).
-export([tournament/2]).

beat(rock) ->
  paper;

beat(paper) ->
  scissors;

beat(scissors) ->
  rock;

beat(_) ->
  not_ok.

lose(rock) ->
  scissors;

lose(paper) ->
  rock;

lose(scissors) ->
  paper;

lose(_) ->
  not_ok.

result(Left, Right) ->
  BeatRight = beat(Right),
  if
    Left =:= Right ->
      0;
    Left =:= BeatRight ->
      1;
    true ->
      -1
  end.

tournament(LeftList, RightList) ->
  Results = lists:zipwith(fun result/2, LeftList, RightList),
  lists:sum(Results).

