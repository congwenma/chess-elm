module Components.Landscape exposing (renderGrid)

import Html exposing (..)
import Html.Attributes exposing (..)
import Models.Coordinate exposing (Coordinate, intoStringXY, intoString)


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


renderGrid : List Coordinate -> List Coordinate -> List (Html msg)
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
                                ]
                                [ span [ class "h2" ] [ text <| intoStringXY colNum rowNum ]
                                ]
                    )
                    (expand gridDimension.x)
                )
        )
        (expand gridDimension.y)
