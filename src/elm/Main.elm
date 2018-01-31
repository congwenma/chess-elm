module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


-- import Component

import Components.Landscape exposing (grid)
import Components.Piece exposing (renderPiece)


-- import Model

import Models.Piece exposing (Piece)
import Models.GameSet exposing (gameSet)
import Models.Coordinate exposing (Coordinate)


-- import Support

import Debug exposing (..)


-- APP


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update
        }



-- MODEL


type MaybePiece
    = Piece
    | NoPiece


type alias Model =
    { selectedPiece : MaybePiece
    , potentialMoves : List Coordinate
    , potentialKills : List Coordinate
    , pieces : List Piece
    }


model : Model
model =
    { selectedPiece = NoPiece
    , potentialMoves = []
    , potentialKills = []
    , pieces = gameSet
    }



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



-- VIEW:


view : Model -> Html Msg
view model =
    let
        { pieces } =
            model
    in
        div [ class "m4 relative" ]
            [ div [ class "chess-board absolute" ]
                grid
            , div [ class "chess-pieces" ]
                (List.map renderPiece pieces)
            ]
