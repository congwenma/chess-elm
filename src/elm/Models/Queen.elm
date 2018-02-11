module Models.Queen exposing (..)

import Models.Castle
import Models.Bishop
import Models.Coordinate exposing (Coordinate)
import Models.Piece exposing (Piece)
import ChessUtils exposing (areAnyPieceOnCoordinate, areAnyEnemiesOnCoordinate)
import Debug


getMovePotential : Piece -> List Piece -> List Coordinate
getMovePotential piece allPieces =
    List.concat
        [ Models.Castle.getMovePotential piece allPieces
        , Models.Bishop.getMovePotential piece allPieces
        ]


getKillPotential : Piece -> List Piece -> List Coordinate
getKillPotential piece allPieces =
    List.concat
        [ Models.Castle.getKillPotential piece allPieces
        , Models.Bishop.getKillPotential piece allPieces
        ]
