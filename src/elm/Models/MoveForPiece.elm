module Models.MoveForPiece exposing (..)

import Models.Avatar exposing (..)
import Models.Piece exposing (Piece)
import Models.Coordinate exposing (Coordinate)
import Models.Pawn exposing (getMovePotential, getKillPotential)


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


getKillForAnyPiece : Piece -> List Coordinate
getKillForAnyPiece piece =
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
            getKillPotential piece
