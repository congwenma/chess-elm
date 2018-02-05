module Models.MoveForPiece exposing (..)

import Models.Avatar exposing (..)
import Models.Piece exposing (Piece)
import Models.Coordinate exposing (Coordinate)
import Models.Pawn exposing (getMovePotential)


getMoveForAnyPiece : Piece -> List Coordinate
getMoveForAnyPiece piece =
    case piece.avatar.name of
        Knight ->
            []

        Castle ->
            []

        Bishop ->
            []

        King ->
            []

        Queen ->
            []

        Pawn ->
            getMovePotential piece
