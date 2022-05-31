# ChessInterface

## Projects aim

Interface for frontend webapplications to communicate realtime to the backend chessengine over Phoenix channels.

## Running

Start server with `mix phx.server`

Add ChessEngine to the same parent folder as ChessInterface.

## Communicate with channels over wscat.

Start repl with `iex -S mix phx.server`

Open a second terminal window

`wscat -c 'ws://localhost:4000/socket/websocket?vsn=2.0.0'`

Start a new game channel

`["1","1","game:Joe","phx_join",{}]`

Start new game

`["1","2","game:Joe","new_game",{}]`

Add new player

`["1","3","game:Joe","add_player",{"player2_name":"Hisaishi"}]`

Select colors

`["1","4","game:Joe","select_colors",{"player1_color":"black","player2_color":"white"}]`

Start a second game channel

`["2","1","game:Frank","phx_join",{}]`

Start a second game concurrently

`["2","2","game:Frank","new_game",{}]`

Add a new player

`["2","3","game:Frank","add_player",{"player2_name":"Zappa"}]`

Select colors

`["2","4","game:Frank","select_colors",{"player1_color":"white","player2_color":"black"}]`

Go back to the first terminal window to check inside the engine

`via_joe = Game.via_tuple("Joe")`

`via_frank = Game.via_tuple("Frank")`

`:sys.get_state(via_joe)`

`:sys.get_state(via_frank)`


