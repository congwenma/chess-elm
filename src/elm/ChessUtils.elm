module ChessUtils exposing (..)

-- Chess Import

import Models.Avatar exposing (Avatar, FactionType(..), enemyOf)
import Models.Piece exposing (Piece)
import Models.Coordinate exposing (Coordinate)


-- General

import Utils exposing (..)
import Dict


countPiecesByAvatar : List Piece -> List ( String, Int )
countPiecesByAvatar pieceList =
    List.sortBy Tuple.first <|
        Dict.toList <|
            List.foldl
                (\piece accu ->
                    let
                        avatarType =
                            piece.avatar.name

                        avatarTypeString =
                            toString avatarType
                    in
                        Dict.update avatarTypeString incrementFromMaybe accu
                )
                Dict.empty
                pieceList



-- Use for determining moves


areAnyPieceOnCoordinate : List Piece -> Coordinate -> Bool
areAnyPieceOnCoordinate allPieces coordinate =
    let
        allTakenCoords =
            List.map (\piece -> piece.coordinate) allPieces
    in
        List.member coordinate allTakenCoords


areAnyEnemiesOnCoordinate : Avatar -> List Piece -> Coordinate -> Bool
areAnyEnemiesOnCoordinate thisAvatar allPieces coordinate =
    let
        enemyFaction =
            enemyOf thisAvatar.faction

        enemyPieces =
            List.filter
                (\p ->
                    p.avatar.faction
                        == enemyFaction
                )
                allPieces
    in
        areAnyPieceOnCoordinate enemyPieces coordinate
