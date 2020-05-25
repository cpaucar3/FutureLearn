-module(text_processing).
-export([format/2]).

format(FileName, Len) ->
	{ok, FileBin} = file:read_file(FileName),
	FileStr = binary_to_list(FileBin),
	[Word|WordList] = string:lexemes(FileStr, " \n"),
	format(WordList, Word, [], Len - length(Word), Len).

%%--------------------------------------------------------------------
%%% Internal functions
%%--------------------------------------------------------------------

format([], CurLine, FmtLines, _, _) ->
	lists:reverse([CurLine|FmtLines]);

format([Word|WordList], CurLine, FmtLines, RemLen, MaxLen) ->
	case length(Word) of
		WordLen when WordLen < RemLen ->
			CurLine2 = CurLine ++ " " ++ Word,
			format(WordList, CurLine2, FmtLines, RemLen - WordLen - 1, MaxLen);
		WordLen ->
			format(WordList, Word, [CurLine|FmtLines], MaxLen - WordLen, MaxLen)
	end.

