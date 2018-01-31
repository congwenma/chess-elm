module Components.Piece exposing (..)

import Models.Avatar exposing (Piece, getPieceIcon)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Json.Encode exposing (string)


getPixels n =
    (toString n) ++ "px"


renderPiece : Piece -> Html msg
renderPiece piece =
    div
        [ class "chesspiece absolute"
        , style
            [ ( "left", getPixels <| piece.x * 100 )
            , ( "top", getPixels <| piece.y * 100 )
            ]
        ]
        [ span
            [ property "innerHTML"
                (string
                    (String.join ""
                        [ "&#"
                        , getPieceIcon piece.avatar.name piece.avatar.faction
                        , ";"
                        ]
                    )
                )
            ]
            []
        ]
