module Models.GameSetTest exposing (..)

import Test exposing (Test, describe, test, fuzz, fuzz2, fuzzWith)
import Expect
import Models.GameSet exposing (..)
import Models.Avatar exposing (AvatarType(..))
import Models.Piece exposing (Piece)
import ChessUtils exposing (..)
import Debug exposing (log)


allTests : Test
allTests =
    describe "GameSet"
        [ gameSetTests ]


gameSetTests =
    describe "gameSet"
        [ test "contains 32 pieces" <|
            \() -> Expect.equal (List.length gameSet) 32
        , test "contains expected count of pieces by AvatarType" <|
            \() ->
                Expect.equalLists
                    (countPiecesByAvatar gameSet)
                    [ ( "Bishop", 4 )
                    , ( "Castle", 4 )
                    , ( "King", 2 )
                    , ( "Knight", 4 )
                    , ( "Pawn", 16 )
                    , ( "Queen", 2 )
                    ]
        ]
