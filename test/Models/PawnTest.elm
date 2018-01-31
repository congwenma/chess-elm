module Models.PawnTest exposing (..)

import Test exposing (Test, describe, test, fuzz, fuzz2, fuzzWith)
import Expect
import Models.Pawn exposing (..)
import Models.Coordinate exposing (..)


tests : Test
tests =
    describe "Pawn"
        [ describe "getMovePotential"
            [ test "return only forward blocks" <|
                \() ->
                    Expect.equal
                        (getMovePotential (Coordinate 1 1)
                            |> List.map Models.Coordinate.intoString
                            |> String.join " | "
                        )
                        "(1, 1)"
            ]
        ]
