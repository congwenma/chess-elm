module Models.GameSetTest exposing (..)

import Test exposing (Test, describe, test, fuzz, fuzz2, fuzzWith)
import Expect
import Models.GameSet exposing (..)
import Models.Avatar exposing (AvatarType(..))
import Models.Piece exposing (Piece)


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
                Expect.equal
                    (countPiecesByAvatar gameSet)
                    [ ( Castle, 4 )
                    , ( Knight, 4 )
                    , ( Bishop, 4 )
                    , ( King, 2 )
                    , ( Queen, 2 )
                    , ( Pawn, 16 )
                    ]
        ]


countPiecesByAvatar : List Piece -> List ( AvatarType, Int )
countPiecesByAvatar pieces =
    List.foldl
        (\accu piece ->
            let
                avatarType =
                    piece.avatar.name
            in
                case accu.member (avatarType) of
                    True ->
                        accu

                    False ->
                        accu
        )
        Dict.empty
        pieces
