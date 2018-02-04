module Components.Piece exposing (..)

import Models.Piece exposing (Piece, getPieceIcon)
import Html exposing (..)
import Html.Attributes exposing (..)
import Json.Encode exposing (string)


getPixels n =
    (toString n) ++ "px"


escapeAsciiCode : String -> Json.Encode.Value
escapeAsciiCode str =
    (string
        (String.join ""
            [ "&#", str, ";" ]
        )
    )


renderPiece : Piece -> Html msg
renderPiece piece =
    div
        [ class "chesspiece absolute"
        , style
            [ ( "left", getPixels <| piece.coordinate.x * 100 )
            , ( "top", getPixels <| piece.coordinate.y * 100 )
            ]
        ]
        [ span
            [ property "innerHTML" <|
                escapeAsciiCode <|
                    getPieceIcon piece.avatar.name piece.avatar.faction
            ]
            []
        ]
