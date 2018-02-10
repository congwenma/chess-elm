module Models.Piece exposing (Piece, getPieceIcon, PieceStatus(..))

import Models.Avatar exposing (Avatar, AvatarType, FactionType(..))
import Models.Coordinate exposing (..)
import Utils exposing (getFromMaybe)
import Dict


type PieceStatus
    = Alive
    | Dead


type alias Piece =
    { avatar : Avatar
    , coordinate : Coordinate
    , id : Int
    , status : PieceStatus
    }


getPieceIcon : AvatarType -> FactionType -> String
getPieceIcon avatar faction =
    case faction of
        BlackPlayer ->
            Utils.getFromMaybe <|
                Dict.get (toString avatar) <|
                    blackIconDict

        WhitePlayer ->
            Utils.getFromMaybe <|
                Dict.get (toString avatar) <|
                    whiteIconDict


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
