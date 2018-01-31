module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Landscape exposing (grid)
import Components.Piece exposing (renderPiece)
import Models.Avatar exposing (..)
import Models.GameSet exposing (gameSet)
import Debug exposing (..)


-- component import example
-- APP


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update
        }



-- MODEL: use this to hold the state


type alias Model =
    {}


model : Model
model =
    {}



-- UPDATE: make moves


type Msg
    = SelectPiece
    | MovePiece
    | OtherSelectPiece
    | OtherMovePiece


update : Msg -> Model -> Model
update msg model =
    case msg of
        SelectPiece ->
            model

        MovePiece ->
            model

        OtherSelectPiece ->
            model

        OtherMovePiece ->
            model


view : Model -> Html Msg
view model =
    div [ class "m4 relative" ]
        [ div [ class "chess-board absolute" ]
            grid
        , div [ class "chess-pieces" ]
            (List.map renderPiece gameSet)
        ]
