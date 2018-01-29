module Landscape exposing (grid)

import Html exposing (..)
import Html.Attributes exposing (..)


expand n =
    List.range 1 n


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


grid : List (Html msg)
grid =
    List.map
        (\rowNum ->
            div [ class "chess-row flex flex-border" ]
                (List.map
                    (\colNum ->
                        div [ class ("chess-cell " ++ determineCellColor (colNum + rowNum)) ] []
                    )
                    (expand gridDimension.x)
                )
        )
        (expand gridDimension.y)
