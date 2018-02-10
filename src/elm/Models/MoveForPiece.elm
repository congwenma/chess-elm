module Models.MoveForPiece exposing (..)

import Models.Avatar exposing (..)
import Models.Piece exposing (Piece)
import Models.Coordinate exposing (Coordinate)
import Debug


-- Importing Avatars

import Models.Pawn exposing (getMovePotential, getKillPotential)
import Models.Knight exposing (getMovePotential, getKillPotential)
import Models.King exposing (getMovePotential, getKillPotential)
import Models.Castle exposing (getMovePotential, getKillPotential)


getMoveForAnyPiece : Piece -> List Piece -> List Coordinate
getMoveForAnyPiece piece allPieces =
    case piece.avatar.name of
        Knight ->
            Models.Knight.getMovePotential piece allPieces

        Castle ->
            Models.Castle.getMovePotential piece allPieces

        Bishop ->
            []

        King ->
            Models.King.getMovePotential piece allPieces

        Queen ->
            []

        Pawn ->
            Models.Pawn.getMovePotential piece allPieces


getKillForAnyPiece : Piece -> List Piece -> List Coordinate
getKillForAnyPiece piece allPieces =
    case piece.avatar.name of
        Knight ->
            Models.Knight.getKillPotential piece allPieces

        Castle ->
            Models.Castle.getKillPotential piece allPieces

        Bishop ->
            []

        King ->
            Models.King.getKillPotential piece allPieces

        Queen ->
            []

        Pawn ->
            -- dont need all pieces
            Models.Pawn.getKillPotential piece allPieces
