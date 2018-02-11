module Components.Landscape exposing (renderGrid)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Update exposing (Msg(..))
import Models.Coordinate exposing (Coordinate, intoStringXY, intoString)


devMode : Bool
devMode =
    True


expand n =
    List.range 0 (n - 1)


gridDimension : { x : Int, y : Int }
gridDimension =
    { x = 8, y = 8 }


determineCellColor : Int -> String
determineCellColor n =
    case n % 2 == 0 of
        True ->
            "black"

        False ->
            "white"


renderGrid : List Coordinate -> List Coordinate -> List (Html Msg)
renderGrid potentialMoves potentialKills =
    List.map
        (\rowNum ->
            div [ class "chess-row flex flex-border" ]
                (List.map
                    (\colNum ->
                        let
                            coordinate =
                                Coordinate colNum rowNum
                        in
                            div
                                [ classList
                                    [ ( "chess-cell", True )
                                    , ( determineCellColor (colNum + rowNum), True )
                                    , ( "potentialMove", List.member (coordinate) potentialMoves )
                                    , ( "potentialKill", List.member (coordinate) potentialKills )
                                    ]
                                , onClick (MovePiece coordinate)
                                ]
                                [ span [ class "h2" ]
                                    [ text <|
                                        if devMode == True then
                                            intoStringXY colNum rowNum
                                        else
                                            ""
                                    ]
                                ]
                    )
                    (expand gridDimension.x)
                )
        )
        (expand gridDimension.y)
