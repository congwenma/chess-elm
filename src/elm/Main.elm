module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Landscape exposing (grid)
import Debug exposing (..)
import Models.Avatar exposing (..)
import Models.GameSet exposing (..)
import Json.Encode exposing (string)


-- component import example
-- APP


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update
        }



-- MODEL


type alias Model =
    Int


model : Model
model =
    0



-- UPDATE


type Msg
    = NoOp
    | Increment


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model

        Increment ->
            model + 1


view : Model -> Html Msg
view model =
    div [ class "m4 relative" ]
        [ div
            [ class "chess-board absolute" ]
            grid
        , div
            [ class "chess-pieces" ]
            (List.map renderPiece gameSet)
        ]


getPixels n =
    (toString n) ++ "px"


renderPiece : Piece -> Html Msg
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
