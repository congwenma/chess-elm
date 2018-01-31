module Models.GameSetTest exposing (..)

import Test exposing (Test, describe, test, fuzz, fuzz2, fuzzWith)
import Expect
import Models.GameSet exposing (..)


allTests : Test
allTests =
    describe "GameSet"
        [ gameSetTests ]


gameSetTests =
    describe "gameSet"
        [ test "contains 32 pieces" <|
            \() -> Expect.equal (List.length gameSet) 32
        ]
