-module(supermarket_billing).
-export([format/2, test/0]).

format(BarcodeList, Database) ->
	format(BarcodeList, Database, "", 0.0).

test() ->
	BarcodeList = [1234,4719,3814,1112,1113,1234],
	Database = [{4719, "Fish Fingers" , 121},
				{5643, "Nappies" , 1010},
				{3814, "Orange Jelly", 56},
				{1111, "Hula Hoops", 21},
				{1112, "Hula Hoops (Giant)", 133},
				{1234, "Dry Sherry, 1lt", 540}],
	ExpectedResult = 
	"         Erlang Stores

Dry Sherry, 1lt...........5.40
Fish Fingers..............1.21
Orange Jelly..............0.56
Hula Hoops (Giant)........1.33
Unknown Item..............0.00
Dry Sherry, 1lt...........5.40

Total....................13.90
",
	ExpectedResult = format(BarcodeList, Database),
	io:format("passed\n").

%%--------------------------------------------------------------------
%%% Internal functions
%%--------------------------------------------------------------------

format([], _Database, Bill, Total) ->
	Header = "         Erlang Stores\n\n",
	Footer = "\n" ++ makeLine("Total", Total),
	lists:flatten(Header ++ Bill ++ Footer);

format([Barcode|BarcodeList], Database, Bill, Total) ->
	{Name, Cost} = case lists:keyfind(Barcode, 1, Database) of
					   {Barcode, Name2, Cost2} ->
						   {Name2, Cost2 / 100};
					   false ->
						   {"Unknown Item", 0.0}
				   end,
	Line = makeLine(Name, Cost),
	format(BarcodeList, Database, Bill ++ Line, Total + Cost).

makeLine(Name, Cost) ->
	Line = io_lib:format("~s~~s~.2f~n", [Name, Cost]),
	DotLen = 33 - lists:flatlength(Line),
	DotLeader = lists:duplicate(DotLen, "."),
	io_lib:format(Line, [DotLeader]).

