module Models.Avatar exposing (..)


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
