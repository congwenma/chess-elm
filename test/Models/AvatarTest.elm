module Models.AvatarTest exposing (..)

import Test exposing (Test, describe, test, fuzz, fuzz2, fuzzWith)
import Expect
import Models.Avatar exposing (..)


allTests : Test
allTests =
    describe "Avatar"
        [ sanityTest
        , avatarTests
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


sanityTest =
    describe "Sanity"
        [ test "1 + 1 = 2" <|
            \() -> Expect.equal (1 + 1) 2
        ]
