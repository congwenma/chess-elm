module Models.GameSet exposing (..)

import Models.Coordinate exposing (Coordinate)
import Models.Avatar
    exposing
        ( Avatar
        , FactionType(..)
        , AvatarType(..)
        )
import Models.Piece exposing (Piece, PieceStatus(..))


createPiece { name, faction, x, y } index =
    Piece (Avatar name faction) (Coordinate x y) index Alive


gameSet : List Piece
gameSet =
    List.indexedMap (\index obj -> createPiece obj index) gameSetConfig


gameSetConfig : List { faction : FactionType, name : AvatarType, x : Int, y : Int }
gameSetConfig =
    -- PLAYER 1, row 1
    [ { name = Castle, faction = BlackPlayer, x = 0, y = 0 }
    , { name = Knight, faction = BlackPlayer, x = 1, y = 0 }
    , { name = Bishop, faction = BlackPlayer, x = 2, y = 0 }
    , { name = King, faction = BlackPlayer, x = 3, y = 0 }
    , { name = Queen, faction = BlackPlayer, x = 4, y = 0 }
    , { name = Bishop, faction = BlackPlayer, x = 5, y = 0 }
    , { name = Knight, faction = BlackPlayer, x = 6, y = 0 }
    , { name = Castle, faction = BlackPlayer, x = 7, y = 0 }

    -- PLAYER 1, row 2
    , { name = Pawn, faction = BlackPlayer, x = 0, y = 1 }
    , { name = Pawn, faction = BlackPlayer, x = 1, y = 1 }
    , { name = Pawn, faction = BlackPlayer, x = 2, y = 1 }
    , { name = Pawn, faction = BlackPlayer, x = 3, y = 1 }
    , { name = Pawn, faction = BlackPlayer, x = 4, y = 1 }
    , { name = Pawn, faction = BlackPlayer, x = 5, y = 1 }
    , { name = Pawn, faction = BlackPlayer, x = 6, y = 1 }
    , { name = Pawn, faction = BlackPlayer, x = 7, y = 1 }

    -- PLAYER 2, row 1
    , { name = Castle, faction = WhitePlayer, x = 0, y = 7 }
    , { name = Knight, faction = WhitePlayer, x = 1, y = 7 }
    , { name = Bishop, faction = WhitePlayer, x = 2, y = 7 }

    -- , { name = Bishop, faction = WhitePlayer, x = 4, y = 4 } -- TEST BISHOP
    , { name = King, faction = WhitePlayer, x = 3, y = 7 }
    , { name = Queen, faction = WhitePlayer, x = 4, y = 7 }

    -- , { name = Queen, faction = WhitePlayer, x = 4, y = 4 } -- TEST QUEEN
    , { name = Bishop, faction = WhitePlayer, x = 5, y = 7 }
    , { name = Knight, faction = WhitePlayer, x = 6, y = 7 }
    , { name = Castle, faction = WhitePlayer, x = 7, y = 7 }

    -- PLAYER 2, row 2
    , { name = Pawn, faction = WhitePlayer, x = 0, y = 6 }
    , { name = Pawn, faction = WhitePlayer, x = 1, y = 6 }
    , { name = Pawn, faction = WhitePlayer, x = 2, y = 6 }
    , { name = Pawn, faction = WhitePlayer, x = 3, y = 6 }
    , { name = Pawn, faction = WhitePlayer, x = 4, y = 6 }
    , { name = Pawn, faction = WhitePlayer, x = 5, y = 6 }
    , { name = Pawn, faction = WhitePlayer, x = 6, y = 6 }
    , { name = Pawn, faction = WhitePlayer, x = 7, y = 6 }
    ]
