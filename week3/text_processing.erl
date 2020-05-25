-module(text_processing).
-export([format/2]).

format(FileName, Len) ->
	{ok, FileBin} = file:read_file(FileName),
	FileStr = binary_to_list(FileBin),
	WordList = string:lexemes(FileStr, " \n"),
	format(WordList, "", [], Len, Len).

%%--------------------------------------------------------------------
%%% Internal functions
%%--------------------------------------------------------------------

format([], CurLine, FmtLines, _, _) ->
	lists:reverse([CurLine|FmtLines]);

format([Word|WordList], CurLine, FmtLines, RemLen, MaxLen) ->
	WordLen = length(Word) + 1,
	case WordLen < RemLen of
		true ->
			CurLine2 = case CurLine of
						   "" ->
							   Word;
						   _ ->
							   CurLine ++ " " ++ Word
					   end,
			format(WordList, CurLine2, FmtLines, RemLen - WordLen, MaxLen);
		_ ->
			format(WordList, Word, [CurLine|FmtLines], MaxLen - WordLen, MaxLen)
	end.

