module Models.MoveForPiece exposing (..)

import Models.Avatar exposing (..)
import Models.Piece exposing (Piece)
import Models.Coordinate exposing (Coordinate)
import Debug


-- Importing Avatars

import Models.Castle exposing (getMovePotential, getKillPotential)
import Models.Bishop exposing (getMovePotential, getKillPotential)
import Models.Knight exposing (getMovePotential, getKillPotential)
import Models.King exposing (getMovePotential, getKillPotential)
import Models.Queen exposing (getMovePotential, getKillPotential)
import Models.Pawn exposing (getMovePotential, getKillPotential)


getMoveForAnyPiece : Piece -> List Piece -> List Coordinate
getMoveForAnyPiece piece allPieces =
    case piece.avatar.name of
        Knight ->
            Models.Knight.getMovePotential piece allPieces

        Castle ->
            Models.Castle.getMovePotential piece allPieces

        Bishop ->
            Models.Bishop.getMovePotential piece allPieces

        King ->
            Models.King.getMovePotential piece allPieces

        Queen ->
            Models.Queen.getMovePotential piece allPieces

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
            Models.Bishop.getKillPotential piece allPieces

        King ->
            Models.King.getKillPotential piece allPieces

        Queen ->
            Models.Queen.getKillPotential piece allPieces

        Pawn ->
            -- dont need all pieces
            Models.Pawn.getKillPotential piece allPieces
