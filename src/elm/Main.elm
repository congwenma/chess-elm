module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


-- import Component

import Components.Landscape exposing (renderGrid)
import Components.Piece exposing (renderPiece)


-- import Model

import Model exposing (..)


-- imports Events + Update

import Update exposing (..)


-- import Support

import Ui.Modal
import Ui.Header
import Debug exposing (..)


-- APP


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = init
        , view = view
        , update = update
        }



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
                [ h1 [ class "h1" ] [ text "Elm's Chess" ]

                -- Ui.Header.title
                -- { action = Nothing
                -- , target = "_self"
                -- , link = Nothing
                -- , text = "Elm's chess"
                -- }
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
