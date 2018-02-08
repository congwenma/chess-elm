module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


-- import Component

import Components.Landscape exposing (renderGrid)
import Components.Piece exposing (renderPiece)


-- import Model

import Models.Piece exposing (Piece)
import Models.GameSet exposing (gameSet)
import Models.Coordinate exposing (Coordinate)
import Models.MoveForPiece exposing (..)


-- import Events

import Msg exposing (..)


-- import Support

import Debug exposing (..)
import Utils exposing (getFromMaybe)


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
    { selectedPiece : Maybe Piece
    , potentialMoves : List Coordinate
    , potentialKills : List Coordinate
    , pieces : List Piece
    }


model : Model
model =
    { selectedPiece = Nothing
    , potentialMoves = []
    , potentialKills = []
    , pieces = gameSet
    }



-- UPDATE: make moves


update : Msg -> Model -> Model
update msg model =
    case msg of
        SelectPiece piece ->
            { model
                | selectedPiece = Just piece
                , potentialMoves = getMoveForAnyPiece piece
                , potentialKills = getKillForAnyPiece piece
            }

        MovePiece coordinate ->
            let
                -- info = Debug.log "MOVING PIECE" (toString coordinate)
                coordinateIsPotentialMove =
                    List.member coordinate model.potentialMoves

                selectedPieceAfterMove =
                    -- Debug.log "SELECT PIECE AFTER MOVE" <|
                    case model.selectedPiece of
                        Just selectedPiece ->
                            -- Debug.log "SELECT PIECE" <|
                            if coordinateIsPotentialMove then
                                Just { selectedPiece | coordinate = coordinate }
                            else
                                model.selectedPiece

                        Nothing ->
                            Nothing

                afterMovePieces =
                    case selectedPieceAfterMove of
                        Just selectedPiece ->
                            replacePieceInPieces selectedPiece model.pieces

                        Nothing ->
                            model.pieces
            in
                { model | pieces = afterMovePieces, selectedPiece = Nothing, potentialMoves = [], potentialKills = [] }

        KillPiece piece ->
            let
                coordinateIsPotentialKill =
                    List.member piece.coordinate model.potentialKills

                selectedPieceAfterKill =
                    -- Debug.log "SELECT PIECE AFTER MOVE" <|
                    case model.selectedPiece of
                        Just selectedPiece ->
                            -- Debug.log "SELECT PIECE" <|
                            if coordinateIsPotentialKill then
                                Just { selectedPiece | coordinate = piece.coordinate }
                            else
                                model.selectedPiece

                        Nothing ->
                            Nothing

                afterMovePieces =
                    case coordinateIsPotentialKill of
                        True ->
                            case selectedPieceAfterKill of
                                Just sPiece ->
                                    replacePieceInPieces sPiece model.pieces |> List.filter (\pce -> not (pce == piece))

                                Nothing ->
                                    model.pieces

                        False ->
                            model.pieces
            in
                { model | pieces = afterMovePieces, selectedPiece = Nothing, potentialMoves = [], potentialKills = [] }

        OtherSelectPiece ->
            model

        OtherMovePiece ->
            model


replacePieceInPieces : Piece -> List Piece -> List Piece
replacePieceInPieces selected allPieces =
    allPieces
        |> List.indexedMap
            (\index pce ->
                -- let info = Debug.log "INDEXED MAP" <| ( piece, selectedPiece )
                -- in
                if pce.id == selected.id then
                    selected
                else
                    pce
            )



-- VIEW:


view : Model -> Html Msg
view model =
    let
        { pieces, potentialMoves, potentialKills, selectedPiece } =
            model
    in
        div [ class "m4 relative" ]
            [ div [ class "chess-board absolute" ]
                (renderGrid potentialMoves potentialKills)
            , div [ class "chess-pieces" ]
                (List.map (renderPiece selectedPiece) pieces)
            ]
