module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


-- import Component

import Components.Landscape exposing (renderGrid)
import Components.Piece exposing (renderPiece)


-- import Model

import Models.Avatar exposing (AvatarType(King))
import Models.Piece exposing (Piece, PieceStatus(..))
import Models.GameSet exposing (gameSet)
import Models.Coordinate exposing (Coordinate)
import Models.MoveForPiece exposing (..)


-- import Events

import Msg exposing (..)


-- import Support

import Ui.Modal
import Ui.Header
import Debug exposing (..)
import Utils exposing (getFromMaybe)


-- APP


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = init
        , view = view
        , update = update
        }



-- MODEL


type alias Model =
    { selectedPiece : Maybe Piece

    -- status
    , potentialMoves : List Coordinate
    , potentialKills : List Coordinate
    , previousMovedPiece : Maybe Piece
    , winner : String

    -- all Pieces
    , pieces : List Piece
    , alivePieces : List Piece
    }


init : Model
init =
    { selectedPiece = Nothing
    , potentialMoves = []
    , potentialKills = []
    , previousMovedPiece = Nothing
    , winner = ""

    -- all pieces
    , pieces = gameSet
    , alivePieces = gameSet
    }



-- UPDATE: make moves


update : Msg -> Model -> Model
update msg model =
    case msg of
        ResetGame2 ->
            init

        ResetGame uimsg ->
            Debug.log "****Reset Game" <| init

        SelectPiece piece ->
            { model
                | selectedPiece = Just piece
                , potentialMoves =
                    Debug.log
                        "potentialMoves"
                    <|
                        getMoveForAnyPiece piece model.alivePieces
                , potentialKills =
                    Debug.log
                        "potentialKills"
                    <|
                        getKillForAnyPiece piece model.alivePieces
            }

        MovePiece coordinate ->
            let
                -- info = Debug.log "MOVING PIECE" (toString coordinate)
                coordinateIsPotentialMove =
                    List.member coordinate model.potentialMoves

                coordinateHasNoPiece =
                    List.all (\piece -> not (piece.coordinate == coordinate)) model.alivePieces

                selectedPieceAfterMove =
                    -- Debug.log "SELECT PIECE AFTER MOVE" <|
                    case model.selectedPiece of
                        Just selectedPiece ->
                            -- Debug.log "SELECT PIECE" <|
                            if coordinateIsPotentialMove && coordinateHasNoPiece then
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
                { model
                    | pieces = afterMovePieces
                    , selectedPiece = Nothing
                    , potentialMoves = []
                    , potentialKills = []
                    , previousMovedPiece = selectedPieceAfterMove
                }

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
                                    replacePieceInPieces sPiece model.pieces
                                        |> List.map
                                            (\pce ->
                                                if pce == piece then
                                                    { pce | status = Dead }
                                                else
                                                    pce
                                            )

                                Nothing ->
                                    model.pieces

                        False ->
                            model.pieces

                winningCondition =
                    if piece.avatar.name == King && not (List.member piece afterMovePieces) then
                        toString <| Models.Avatar.enemyOf piece.avatar.faction
                    else
                        noWinner
            in
                { model
                    | pieces = afterMovePieces
                    , selectedPiece = Nothing
                    , potentialMoves = []
                    , potentialKills = []
                    , previousMovedPiece = selectedPieceAfterKill
                    , alivePieces = List.filter (\pce -> pce.status == Alive) afterMovePieces
                    , winner = winningCondition
                }

        OtherSelectPiece ->
            model

        OtherMovePiece ->
            model


replacePieceInPieces : Piece -> List Piece -> List Piece
replacePieceInPieces selected allPieces =
    allPieces
        |> List.indexedMap
            (\index pce ->
                if pce.id == selected.id then
                    selected
                else
                    pce
            )



-- VIEW:


noWinner : String
noWinner =
    ""


view : Model -> Html Msg
view model =
    let
        { pieces, potentialMoves, potentialKills, selectedPiece, previousMovedPiece, winner } =
            model
    in
        div []
            [ Ui.Header.view
                [ Ui.Header.title
                    { action = Nothing
                    , target = "_self"
                    , link = Nothing
                    , text = "Chess in Elm"
                    }
                ]
            , div []
                [ div [ class "m4 relative" ]
                    [ div [ class "chess-board absolute" ]
                        (renderGrid potentialMoves potentialKills)
                    , div [ class "chess-pieces" ]
                        (List.map (renderPiece selectedPiece previousMovedPiece) pieces)
                    ]
                , Ui.Modal.view
                    -- (Ui.Modal.ViewModel
                    { contents =
                        [ div []
                            [ text <| winner ++ " has Won!"
                            ]
                        ]
                    , footer =
                        [ div []
                            [ button [ onClick ResetGame2 ]
                                [ text "Play Again"
                                ]
                            , button [ onClick ResetGame2 ]
                                [ text "Close"
                                ]
                            ]
                        ]
                    , address = ResetGame
                    , title = "Title"
                    }
                    { closable = True
                    , backdrop = True
                    , open = winner /= noWinner
                    }
                ]
            ]
