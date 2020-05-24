-module(index).
-export([get_file_contents/1,show_file_contents/1, list_entries/1]).

% Used to read a file into a list of lines.
% Example files available in:
%   gettysburg-address.txt (short)
%   dickens-christmas.txt  (long)


% Get the contents of a text file into a list of lines.
% Each line has its trailing newline removed.

get_file_contents(Name) ->
	{ok,File} = file:open(Name,[read]),
	Rev = get_all_lines(File,[]),
	lists:reverse(Rev).

% Auxiliary function for get_file_contents.
% Not exported.

get_all_lines(File,Partial) ->
	case io:get_line(File,"") of
		eof -> file:close(File),
			   Partial;
		Line -> {Strip,_} = lists:split(length(Line)-1,Line),
				get_all_lines(File,[Strip|Partial])
	end.

% Show the contents of a list of strings.
% Can be used to check the results of calling get_file_contents.

show_file_contents([L|Ls]) ->
	io:format("~s~n",[L]),
	show_file_contents(Ls);
show_file_contents([]) ->
	ok.

list_entries(Name) ->
	Contents = get_file_contents(Name),
	EntryMap2 = lists:foldl(fun(Line, EntryMap) ->
									lineCount(Line, EntryMap)
							end, #{lineNum => 1}, Contents),
	EntryMap3 = maps:remove(lineNum, EntryMap2),
	% For each word, convert the list of lines to ranges/groups of lines
	EntryList = maps:to_list(EntryMap3),
	lists:keymap(fun([ Start | LineList]) ->
						 rangeConverter(Start, Start, LineList)
				 end, 2, EntryList).

lineCount(Line, #{lineNum := LineNum} = EntryMap) ->
	WordList = string:lexemes(string:lowercase(Line), " ,-.\\"),
	EntryMap3 = lists:foldl(fun(Word, EntryMap2) ->
									LineList = maps:get(Word, EntryMap2, []),
									EntryMap2#{Word => LineList ++ [LineNum]}
							end, EntryMap, WordList),
	EntryMap3#{lineNum => LineNum + 1}.

rangeConverter(Start, End, []) ->
	{Start, End};

rangeConverter(Start, End, [Next | LineList]) when Next - End =:= 1 ->
	rangeConverter(Start, Next, LineList);

rangeConverter(Start, End, [Next | LineList]) ->
	[{Start, End} | rangeConverter(Next, Next, LineList)].

