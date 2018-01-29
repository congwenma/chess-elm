module Models.AvatarTest exposing (..)

import Test exposing (Test, describe, test, fuzz, fuzz2, fuzzWith)
import Expect
import Models.Avatar exposing (..)


allTests : Test
allTests =
    describe "Avatar"
        [ sanityTest
        , avatarTests
        , gameSetTests
        ]


blackKnight =
    Avatar Knight BlackPlayer


avatarTests =
    describe "basic"
        [ test "constructor" <|
            \() ->
                Expect.equal blackKnight { name = Knight, faction = BlackPlayer }
        , test "getName" <|
            \() ->
                Expect.equal (getName blackKnight) "Black Knight"
        ]


gameSetTests =
    describe "gameSet"
        [ test "contains 32 pieces" <|
            \() -> Expect.equal (List.length gameSet) 32
        ]


sanityTest =
    describe "Sanity"
        [ test "1 + 1 = 2" <|
            \() -> Expect.equal (1 + 1) 2
        ]
