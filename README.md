# ChessInterface

## Projects aim

Interface for frontend webapplications to communicate realtime to the backend chessengine over Phoenix channels.

## Running

Start server with `phx phx.server`

Add ChessEngine to the same parent folder as ChessInterface.

Communicate with channels over wscat.

Examples:

`wscat -c 'ws://localhost:4000/socket/websocket?vsn=2.0.0'`
connected (press CTRL+C to quit)

`["1","1","game:default","phx_join",{}]`

`["1","2","game:default","start_board",{}]`