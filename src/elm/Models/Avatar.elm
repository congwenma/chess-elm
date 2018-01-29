module Models.Avatar exposing (..)

import Dict exposing (..)


type alias Avatar =
    { name : AvatarType
    , faction : FactionType
    }


type AvatarType
    = Knight
    | Castle
    | Bishop
    | King
    | Queen
    | Pawn


blackIconDict =
    Dict.fromList
        [ ( "Castle", "9820" )
        , ( "Knight", "9822" )
        , ( "Bishop", "9821" )
        , ( "King", "9819" )
        , ( "Queen", "9818" )
        , ( "Pawn", "9821" )
        ]


whiteIconDict =
    Dict.fromList
        [ ( "Castle", "9814" )
        , ( "Knight", "9816" )
        , ( "Bishop", "9815" )
        , ( "King", "9813" )
        , ( "Queen", "9812" )
        , ( "Pawn", "9817" )
        ]


getFromMaybe : Maybe String -> String
getFromMaybe promise =
    case promise of
        Just promise ->
            promise

        Nothing ->
            ""


getPieceIcon : AvatarType -> FactionType -> String
getPieceIcon avatar faction =
    case faction of
        BlackPlayer ->
            getFromMaybe <| Dict.get (toString avatar) <| blackIconDict

        WhitePlayer ->
            getFromMaybe <| Dict.get (toString avatar) <| whiteIconDict


type FactionType
    = BlackPlayer
    | WhitePlayer


getFactionName : Avatar -> String
getFactionName avatar =
    case avatar.faction of
        BlackPlayer ->
            "Black"

        WhitePlayer ->
            "White"


getName : Avatar -> String
getName avatar =
    String.join " " [ getFactionName avatar, toString avatar.name ]


type alias Piece =
    { avatar : Avatar
    , x : Int
    , y : Int
    }


createAvatar { name, faction, x, y } =
    Piece (Avatar name faction) x y


gameSet : List Piece
gameSet =
    List.map createAvatar gameSetConfig


gameSetConfig : List { faction : FactionType, name : AvatarType, x : Int, y : Int }
gameSetConfig =
    [ -- PLAYER 1, row 1
      { name = Castle, faction = BlackPlayer, x = 0, y = 0 }
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
    , { name = King, faction = WhitePlayer, x = 3, y = 7 }
    , { name = Queen, faction = WhitePlayer, x = 4, y = 7 }
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
