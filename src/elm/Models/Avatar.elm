module Models.Avatar exposing (..)

import Dict exposing (..)
import Utils exposing (..)


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
