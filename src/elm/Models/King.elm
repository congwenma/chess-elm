module Models.King exposing (..)

import Models.Coordinate exposing (Coordinate)
import Models.Piece exposing (Piece)
import ChessUtils exposing (areAnyPieceOnCoordinate, areAnyEnemiesOnCoordinate)


potentials : Coordinate -> List Coordinate
potentials { x, y } =
    List.map
        (\xyTuple ->
            let
                ( tupX, tupY ) =
                    xyTuple
            in
                Coordinate tupX tupY
        )
        [ ( x + 1, y + 1 )
        , ( x + 1, y )
        , ( x + 1, y - 1 )
        , ( x - 1, y + 1 )
        , ( x - 1, y )
        , ( x - 1, y - 1 )
        , ( x, y + 1 )
        , ( x, y - 1 )
        ]


getMovePotential : Piece -> List Piece -> List Coordinate
getMovePotential { coordinate, avatar } allPieces =
    List.filter
        (\coord ->
            not <| areAnyPieceOnCoordinate allPieces coord
        )
        (potentials coordinate)


getKillPotential : Piece -> List Piece -> List Coordinate
getKillPotential { coordinate, avatar } allPieces =
    List.filter
        (\coord ->
            areAnyEnemiesOnCoordinate avatar allPieces coord
        )
        (potentials coordinate)
