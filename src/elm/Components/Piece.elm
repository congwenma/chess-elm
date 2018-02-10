module Components.Piece exposing (..)

import Msg exposing (..)
import Models.Piece exposing (Piece, getPieceIcon)
import Html exposing (..)
import Html.Attributes exposing (..)
import Json.Encode exposing (string)
import Html.Events exposing (..)


getPixels : Int -> String
getPixels n =
    (toString n) ++ "px"


escapeAsciiCode : String -> Json.Encode.Value
escapeAsciiCode str =
    (string
        (String.join ""
            [ "&#", str, ";" ]
        )
    )


renderPiece : Maybe Piece -> Maybe Piece -> Piece -> Html Msg
renderPiece selectedPiece previousMovedPiece piece =
    let
        additionalClass =
            String.join " "
                [ case selectedPiece of
                    Nothing ->
                        ""

                    Just selected ->
                        if piece == selected then
                            "selected"
                        else
                            ""
                , case previousMovedPiece of
                    Nothing ->
                        ""

                    Just previousMoved ->
                        if piece == previousMoved then
                            "previousMoved"
                        else
                            ""
                , String.toLower <| toString piece.status
                ]

        clickHandler =
            case selectedPiece of
                Just sPiece ->
                    KillPiece piece

                Nothing ->
                    SelectPiece piece
    in
        div
            [ class ("chesspiece absolute user-select-none " ++ additionalClass)
            , style
                [ ( "left", getPixels <| piece.coordinate.x * 100 )
                , ( "top", getPixels <| piece.coordinate.y * 100 )
                ]
            , onClick clickHandler
            ]
            [ span
                [ property "innerHTML" <|
                    escapeAsciiCode <|
                        getPieceIcon piece.avatar.name piece.avatar.faction
                ]
                []
            ]
