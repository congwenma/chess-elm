module Models.MoveForPiece exposing (..)

import Models.Avatar exposing (..)
import Models.Piece exposing (Piece)
import Models.Coordinate exposing (Coordinate)
import Models.Pawn exposing (getMovePotential, getKillPotential)


getMoveForAnyPiece : Piece -> List Piece -> List Coordinate
getMoveForAnyPiece piece allPieces =
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
            Models.Pawn.getMovePotential piece allPieces


getKillForAnyPiece : Piece -> List Piece -> List Coordinate
getKillForAnyPiece piece allPieces =
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
            -- dont need all pieces
            Models.Pawn.getKillPotential piece allPieces
